Wounding_Strike = class({
    IsHiddenAbilityCastable = function()
        return true
    end
})

function Wounding_Strike:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_nyx_assassin/nyx_assassin_vendetta.vpcf", context)
	-- Modifiers particles
	PrecacheResource("particle", "particles/units/heroes/hero_bloodseeker/bloodseeker_rupture.vpcf", context)
	PrecacheResource("particle", "particles/status_fx/status_effect_rupture.vpcf", context)
end

function Wounding_Strike:OnSpellStart()
    -- Console casting orders probably still not fixed so checks for them...
    if(self:IsHidden() and COverthrowGameMode:IsAllowedToUseWhileHidden(self) == false) then
        print("This")
        return
    end
    local caster = self:GetCaster()
    local target = self:GetCursorTarget()

    EmitSoundOn("Hero_Axe.Attack", target)

    DamageUnit({
        caster = caster,
        target = target,
        ability = self,
        damage = 0,
        spelldamagefactor = 0.0,
        attributefactor = self:GetSpecialValueFor("dmgfromstat"),
        execute = self:GetSpecialValueFor("execute")
    })

    ApplyBuff({
        caster = caster,
        target = target,
        ability = self,
        buff = "modifier_wounding_strike_heal_debuff",
        dur = self:GetSpecialValueFor("buffduration")
    })

    ApplyBuff({
        caster = caster,
        target = target,
        ability = self,
        buff = "modifier_wounding_strike_bleed_debuff",
        dur = self:GetSpecialValueFor("bleeddur"),
        settickrate = self:GetSpecialValueFor("tick")
    })

    EnergyCost({
        caster = caster,
        ability = self,
        cost = self:GetManaCost(-1)
    })

    local targetAbsOrigin = target:GetAbsOrigin()
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_nyx_assassin/nyx_assassin_vendetta.vpcf", PATTACH_CUSTOMORIGIN, target)
    ParticleManager:SetParticleControl(particle, 0, targetAbsOrigin)
    ParticleManager:SetParticleControl(particle, 1, targetAbsOrigin)
    ParticleManager:ReleaseParticleIndex(particle)
end