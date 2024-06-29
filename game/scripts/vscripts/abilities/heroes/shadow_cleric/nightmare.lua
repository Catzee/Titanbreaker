shadow5 = class({
    GetIntrinsicModifierName = function()
        return "modifier_shadow_cleric_nightmare_internal_buff"
    end,
    GetCastRange = function(self)
        return self:GetSpecialValueFor("radius")
    end
})

function shadow5:Precache(context)
	PrecacheResource("particle", "particles/items2_fx/unused_field_3.vpcf", context)
	PrecacheResource("particle", "particles/status_fx/status_effect_maledict.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_slark/slark_dark_pact_pulses.vpcf", context)
    PrecacheResource("particle", "particles/econ/items/nightstalker/nightstalker_black_nihility/nightstalker_black_nihility_void_hit.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_vengeful/vengeful_wave_of_terror_recipient.vpcf", context)
    PrecacheResource("particle", "particles/econ/items/nightstalker/nightstalker_black_nihility/nightstalker_black_nihility_void_hit_ring.vpcf", context)
    PrecacheResource("particle", "particles/econ/items/nightstalker/nightstalker_black_nihility/nightstalker_black_nihility_void_hit_ray.vpcf", context)
    PrecacheResource("particle", "particles/silencer_curse_purple.vpcf", context)
    PrecacheResource("particle", "particles/shadow_skull.vpcf", context)
	PrecacheResource("soundfile", "soundevents/voscripts/game_sounds_vo_abaddon.vsndevts", context)
    PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_templar_assassin.vsndevts", context)
end

function shadow5:OnSpellStart()
    local caster = self:GetCaster()
    local casterPosition = caster:GetAbsOrigin()
    local enemies = FindUnitsInRadius(
        caster:GetTeamNumber(), 
        casterPosition, 
        nil, 
        self:GetSpecialValueFor("radius"), 
        DOTA_UNIT_TARGET_TEAM_ENEMY, 
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
        DOTA_UNIT_TARGET_FLAG_NONE, 
        FIND_ANY_ORDER, 
        false)

    local shadowSpheres = GetShadowClericShadowSpheres(caster)
    local shadowSpheresFactor = 1
    if(TryConsumeShadowClericShadowSpheres(caster, shadowSpheres)) then
        shadowSpheresFactor = shadowSpheresFactor + shadowSpheres
    end

    local innerCd = self:GetSpecialValueFor("fear_inner_cd") * GetInnerCooldownFactor(caster)

    for _, enemy in pairs(enemies) do
        if(enemy._shadowClearicShadow5FearInnerCd == nil) then
            ApplyBuff({
                caster = caster,
                target = enemy,
                ability = self,
                dur = self:GetSpecialValueFor("duration") * shadowSpheresFactor,
                buff = "modifier_shadow_cleric_nightmare_debuff"
            })
            
            enemy._shadowClearicShadow5FearInnerCd = true

            Timers:CreateTimer(innerCd, function()
                enemy._shadowClearicShadow5FearInnerCd = nil
            end)
        end
    end

    if(self:IsAltCasted() and caster:HasModifier("modifier_shadow_cleric_nightmare_spell_resistance_inner_cd") == false) then
        ApplyBuff({
            caster = caster,
            target = caster,
            ability = self,
            dur = self:GetSpecialValueFor("spell_resistance_duration"),
            buff = "modifier_shadow_cleric_nightmare_spell_resistance_buff"
        })

        local innerCd = self:GetSpecialValueFor("spell_resistance_inner_cd") * GetInnerCooldownFactor(caster)
        caster:AddNewModifier(caster, self, "modifier_shadow_cleric_nightmare_spell_resistance_inner_cd", {duration = innerCd})
    end
    
    ApplyBuff({
        caster = caster,
        target = caster,
        ability = self,
        dur = self:GetSpecialValueFor("duration2") * shadowSpheresFactor,
        buff = "modifier_shadow_cleric_nightmare_buff"
    })

    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_slark/slark_dark_pact_pulses.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
    ParticleManager:SetParticleControlEnt(particle, 0, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", casterPosition, true)
    ParticleManager:SetParticleControlEnt(particle, 1, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", casterPosition, true)
    ParticleManager:ReleaseParticleIndex(particle)

    local particle = ParticleManager:CreateParticle("particles/econ/items/nightstalker/nightstalker_black_nihility/nightstalker_black_nihility_void_hit.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
    ParticleManager:SetParticleControlEnt(particle, 0, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", casterPosition, true)
    ParticleManager:ReleaseParticleIndex(particle)

    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_vengeful/vengeful_wave_of_terror_recipient.vpcf", PATTACH_OVERHEAD_FOLLOW , caster)
    ParticleManager:DestroyParticle(particle, false)
    ParticleManager:ReleaseParticleIndex(particle)   

    EmitSoundOn("Hero_TemplarAssassin.Trap.Trigger", caster)
    EmitSoundOn("abaddon_abad_laugh_01", caster)

    self:TryApplyAttackSpeedAura(caster, shadowSpheresFactor)
end

function shadow5:TryApplyAttackSpeedAura(caster, shadowSpheresFactor)
    if(caster:HasModifier("modifier_shadow_cleric_nightmare_aura_inner_cd")) then
        return
    end
    
    local attackSpeedAuraStacks = caster:GetModifierStackCount("modifier_shadow_cleric_nightmare_aura", nil)
    local attackSpeedAuraDuration = self:GetSpecialValueFor("attack_speed_aura_duration_per_shadow_sphere") * (shadowSpheresFactor - 1)
    local attackSpeedAuraDurationMin = self:GetSpecialValueFor("attack_speed_aura_min_duration")

    if(attackSpeedAuraDuration < attackSpeedAuraDurationMin) then
        attackSpeedAuraDuration = attackSpeedAuraDurationMin
    end

    ApplyBuffStack({
        caster = caster,
        target = caster,
        ability = self,
        addstacks = 1,
        max = 99999,
        buff = "modifier_shadow_cleric_nightmare_aura",
        ["self"] = 1,
        dur = attackSpeedAuraDuration
    })

    local innerCd = self:GetSpecialValueFor("attack_speed_aura_inner_cd") * GetInnerCooldownFactor(caster)
    caster:AddNewModifier(caster, self, "modifier_shadow_cleric_nightmare_aura_inner_cd", {duration = innerCd})

    attackSpeedAuraStacks = caster:GetModifierStackCount("modifier_shadow_cleric_nightmare_aura", nil) - attackSpeedAuraStacks

    if(attackSpeedAuraStacks > 0) then
        local modifier = caster:FindModifierByName("modifier_shadow_cleric_nightmare_aura")
        Timers:CreateTimer(modifier:GetDuration(), function()
            if(modifier and not modifier:IsNull()) then
                while(attackSpeedAuraStacks > 0) do
                    modifier:DecrementStackCount()
                    attackSpeedAuraStacks = attackSpeedAuraStacks - 1
                end
            end
        end)
    end
end

function shadow5:OnShadowClericDamageDone(target)
    if(math.random(1, 100) > self:GetSpecialValueFor("chance")) then
        return
    end

    local caster = self:GetCaster()

    ProjectileManager:CreateTrackingProjectile({
        Target = target,
        Source = caster,
        Ability = self,
        EffectName = "particles/shadow_skull.vpcf",
        bDodgeable = true,
        bProvidesVision = true,
        iMoveSpeed = 350,
        iVisionRadius = 300,
        iVisionTeamNumber = caster:GetTeamNumber(),
        iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1
    })
end

function shadow5:OnProjectileHit(target, location)
    if(target == nil) then
        return true
    end

    DamageUnit({
        caster = self:GetCaster(),
        target = target,
        damage = 0,
        ability = self,
        spelldamagefactor = self:GetSpecialValueFor("spelldmg"),
        attributefactor = self:GetSpecialValueFor("dmgfromstat"),
        shadowdmg = 1,
        fromsummon = 1,
        ignore_when_target_has_reflect = 1
    })

    return true
end