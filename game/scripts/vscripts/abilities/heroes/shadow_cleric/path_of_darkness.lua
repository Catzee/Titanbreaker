shadow6 = class({
    GetIntrinsicModifierName = function()
        return "modifier_shadow_cleric_path_of_darkness_internal_buff"
    end
})

function shadow6:Precache(context)
	PrecacheResource("particle", "particles/econ/items/silencer/silencer_ti6/silencer_last_word_status_ti6.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_bane/bane_projectile.vpcf", context)
	PrecacheResource("particle", "particles/shadow_cleric_mana_shield.vpcf", context)
end

function shadow6:OnSpellStart()
    local caster = self:GetCaster()
    local buffDuration = self:GetSpecialValueFor("duration")

    if(caster:HasModifier("modifier_shadow_cleric_path_of_darkness_buff_inner_cd") == false) then
        ApplyBuff({
            caster = caster,
            target = caster,
            ability = self,
            dur = buffDuration,
            buff = "modifier_shadow_cleric_path_of_darkness_buff"
        })

        local innerCd = self:GetSpecialValueFor("inner_cd") * GetInnerCooldownFactor(caster)
        caster:AddNewModifier(caster, self, "modifier_shadow_cleric_path_of_darkness_buff_inner_cd", { duration = innerCd})
    end

    if(self:GetLevel() >= 2) then
        ApplyBuff({
            caster = caster,
            target = caster,
            ability = self,
            dur = buffDuration,
            buff = "modifier_shadow_cleric_path_of_darkness_summons_buff"
        })
    end

    if(self:GetLevel() >= 3) then
        ApplyBuff({
            caster = caster,
            target = caster,
            ability = self,
            dur = self:GetSpecialValueFor("shadow_worms_mana_shield_duration"),
            buff = "modifier_shadow_cleric_path_of_darkness_mana_shield_buff"
        })
    end

    EmitSoundOn("Hero_Dark_Seer.Wall_of_Replica_Start", caster)
    EmitSoundOn("dark_seer_dkseer_respawn_04", caster)
end

function shadow6:OnShadowClericDamageTaken(caster)
    if(caster._shadowClearicShadow6ArmorInnerCd ~= nil) then
        return
    end

    if(self:GetLevel() < 4) then
        return
    end

    ApplyBuff({
        caster = caster,
        target = caster,
        ability = self,
        dur = self:GetSpecialValueFor("damage_proc_duration"),
        buff = "modifier_shadow_cleric_path_of_darkness_armor_buff"
    })
    
    caster._shadowClearicShadow6ArmorInnerCd = true

    local innerCd = self:GetSpecialValueFor("damage_proc_inner_cd") * GetInnerCooldownFactor(caster)
    Timers:CreateTimer(innerCd, function()
        caster._shadowClearicShadow6ArmorInnerCd = nil
    end)
end

function shadow6:OnProjectileHit(target, location)
    if(target == nil) then
        return true
    end

    DamageUnit({
        caster = self:GetCaster(),
        target = target,
        damage = 0,
        spelldamagefactor = self:GetSpecialValueFor("shadow_worms_spelldmg"),
        attributefactor = self:GetSpecialValueFor("shadow_worms_dmgfromstat"),
        shadowdmg = 1,
        fromsummon = 1
    })

    return true
end