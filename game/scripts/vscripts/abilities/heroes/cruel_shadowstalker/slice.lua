Dagger_Strike = class({
    GetIntrinsicModifierName = function()
        return "modifier_slice_alt_cast_state"
    end
})

function Dagger_Strike:Precache(context)
    PrecacheResource("particle", "particles/units/heroes/hero_bloodseeker/bloodseeker_bloodbath_d.vpcf", context)
    PrecacheResource("particle", "particles/econ/items/venomancer/toxicant/veno_toxicant_tail_b.vpcf", context)
end

function Dagger_Strike:OnAltCastToggled()
    local caster = self:GetCaster()
    self._modifier = self._modifier or caster:FindModifierByName(self:GetIntrinsicModifierName())
    
    -- Hack for client lua... IsAltCasted() available only server side and we use modifier to determine alt cast state client side
    if(self:IsAltCasted()) then
        self._modifier:SetStackCount(1)
    else
        self._modifier:SetStackCount(0)
    end

    self:FixCooldown()
end

function Dagger_Strike:GetManaCost(level)
    if(self:GetCaster():GetModifierStackCount(self:GetIntrinsicModifierName(), nil) > 0) then
        return 0
    else
        return self.BaseClass.GetManaCost(self, level)
    end
end

function Dagger_Strike:GetCooldown(level)
    if(self:GetCaster():GetModifierStackCount(self:GetIntrinsicModifierName(), nil) > 0) then
        return self:GetSpecialValueFor("silence_inner_cd")
    else
        return self.BaseClass.GetCooldown(self, level)
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

    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_bloodseeker/bloodseeker_bloodbath_d.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
    ParticleManager:SetParticleControlEnt(particle, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
    ParticleManager:ReleaseParticleIndex(particle)

    self._expectedCooldownEndTime = self._expectedCooldownEndTime or {}

    if(self:IsAltCasted()) then
		SpellInterrupt({caster = caster, target = target, dur = self:GetSpecialValueFor("silence_duration"), ability = self})
        self._expectedCooldownEndTime[true] = GameRules:GetGameTime() + (self:GetSpecialValueFor("silence_inner_cd") * GetCooldownReductionFactor(caster, self))
    else
        -- Hack around data driven modifiers...
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
        self._expectedCooldownEndTime[false] = GameRules:GetGameTime() + (self:GetCooldown(-1) * GetCooldownReductionFactor(caster, self))
    end

    self:FixCooldown()
end

function Dagger_Strike:ReduceCooldown(cdrFlat)
    self._expectedCooldownEndTime = self._expectedCooldownEndTime or {}
    self._expectedCooldownEndTime[false] = self._expectedCooldownEndTime[false] or 0
    self._expectedCooldownEndTime[false] = self._expectedCooldownEndTime[false] - cdrFlat
    self:FixCooldown()
end

function Dagger_Strike:FixCooldown()
    local isAltCast = self:IsAltCasted()
    self:EndCooldown()
    self._expectedCooldownEndTime = self._expectedCooldownEndTime or {}
    self._expectedCooldownEndTime[isAltCast] = self._expectedCooldownEndTime[isAltCast] or 0
    local expectedCd = math.max(0, self._expectedCooldownEndTime[isAltCast] - GameRules:GetGameTime())
    self:StartCooldown(expectedCd)
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

LinkLuaModifier("modifier_slice_alt_cast_state", "abilities/heroes/cruel_shadowstalker/slice", LUA_MODIFIER_MOTION_NONE)