RegrowthFeral = class({})

function RegrowthFeral:OnSpellStart()
    local caster = self:GetCaster()
    local target = self:GetCursorTarget()
    
    EmitSoundOn("DOTA_Item.HealingSalve.Activate", target)

    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_treant/treant_overgrowth_vine_glow_trail.vpcf", PATTACH_POINT_FOLLOW, target)
    ParticleManager:SetParticleControlEnt(particle, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
    ParticleManager:DestroyParticle(particle, false)
    ParticleManager:ReleaseParticleIndex(particle)

    ApplyBuff({
        caster = caster,
        target = target,
        ability = self,
        buff = "modifier_regrowth2",
        dur = self:GetSpecialValueFor("buffduration")
    })
end
