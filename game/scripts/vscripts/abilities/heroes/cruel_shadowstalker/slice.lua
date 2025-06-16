Dagger_Strike = class({
    GetIntrinsicModifierName = function()
        return "modifier_slice_alt_cast_state"
    end
})

function Dagger_Strike:Precache(context)
    PrecacheResource("particle", "particles/units/heroes/hero_bloodseeker/bloodseeker_bloodbath_d.vpcf", context)
    PrecacheResource("particle", "particles/econ/items/venomancer/toxicant/veno_toxicant_tail_b.vpcf", context)
    PrecacheResource("particle", "particles/items2_fx/orb_of_venom_b.vpcf", context)
end

function Dagger_Strike:OnAltCastToggled()
    self._modifier = self.modifier or self:GetCaster():FindModifierByName(self:GetIntrinsicModifierName())
    
    -- Hack for client lua... IsAltCasted() available only server side and we use modifier to determine alt cast state client side
    if(self:IsAltCasted()) then
        self._modifier:SetStackCount(1)
    else
        self._modifier:SetStackCount(0)
    end
end

function Dagger_Strike:GetManaCost(level)
    if(self:GetCaster():GetModifierStackCount(self:GetIntrinsicModifierName(), nil) > 0) then
        return 0
    else
        return self.BaseClass.GetManaCost(self, level)
    end
end

function Dagger_Strike:OnSpellStart()
    local caster = self:GetCaster()
    local target = self:GetCursorTarget()
	
    EmitSoundOn("Hero_PhantomAssassin.CoupDeGrace.Mech", target)
	
    CosmeticEffectsFromItems({
		caster = caster,
		target = target,
		ability = self
    })

    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_bloodseeker/bloodseeker_bloodbath_d.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
    ParticleManager:SetParticleControlEnt(particle, 0, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
    ParticleManager:ReleaseParticleIndex(particle)

    if(self:IsAltCasted()) then
        -- This was intentionally made to don't care if spell was interrupted or no
        if(caster:HasModifier("modifier_slice_inner_cd") == false) then
            SpellInterrupt({caster = caster, target = target, dur = self:GetSpecialValueFor("silence_duration"), ability = self})
            local innerCd = self:GetSpecialValueFor("silence_inner_cd") * GetInnerCooldownFactor(caster)
            caster:AddNewModifier(caster, self, "modifier_slice_inner_cd", { duration = innerCd})
        end
    else
        self._ambushAbility = self._ambushAbility or caster:FindAbilityByName("Ambush")
        self._ambushAbility:ApplyDataDrivenModifier(caster, caster, "modifier_combopoint", {duration = -1})

        DamageUnit({
            caster = caster,
            target = target,
            ability = self,
            damage = 0,
            spelldamagefactor = 0,
            attributefactor = 0,
            includeauto = self:GetSpecialValueFor("dmgfromstat"),
            critchancefactor = self:GetSpecialValueFor("critchance"),
            oncritbuff = "modifier_cobra_poison",
            oncritbuffchance = 25,
            oncritbuffdur = self:GetSpecialValueFor("poisondur"),
            cruelabils = 1
        })

        EnergyCost({
            caster = caster,
            target = target,
            ability = self,
            cost = self:GetManaCost(-1)
        })

        AddComboPoints({
            caster = caster,
            target = target,
            ability = self,
            amount = 1
        })
    end
end

modifier_slice_alt_cast_state = class({
	IsHidden = function() 
        return true 
    end,
	IsPurgable = function() 
        return false 
    end,
    IsPurgeException = function()
        return false
    end,
    IsDebuff = function()
		return false
	end,
    GetAttributes = function()
        return MODIFIER_ATTRIBUTE_PERMANENT
    end,
    RemoveOnDeath = function()
        return false
    end
})

modifier_slice_inner_cd = class({
	IsHidden = function() 
        return false 
    end,
	IsPurgable = function() 
        return false 
    end,
    IsPurgeException = function()
        return false
    end,
    IsDebuff = function()
		return true
	end
})

LinkLuaModifier("modifier_slice_alt_cast_state", "abilities/heroes/cruel_shadowstalker/slice", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_slice_inner_cd", "abilities/heroes/cruel_shadowstalker/slice", LUA_MODIFIER_MOTION_NONE)