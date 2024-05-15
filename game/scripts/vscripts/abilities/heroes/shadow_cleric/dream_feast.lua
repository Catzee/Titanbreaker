shadow3 = class({})

function shadow3:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_enigma/enigma_base_attack.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_bane/bane_sap_glowsmokebase.vpcf", context)
    PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_warlock.vsndevts", context)
end

function shadow3:OnSpellStart()
    local caster = self:GetCaster()
    local target = self:GetCursorTarget()

    local spheresForCrit = self:GetSpecialValueFor("crit_shadow_spheres")
    local critDuration = self:GetSpecialValueFor("crit_duration")

    if(critDuration > 0 and TryConsumeShadowClericShadowSpheres(caster, spheresForCrit)) then
        caster:AddNewModifier(caster, self, "modifier_shadow_cleric_dream_feast_buff", { duration = critDuration })
    end

    ProjectileManager:CreateTrackingProjectile({
        Target = target,
        Source = caster,
        Ability = self,
        EffectName = "particles/units/heroes/hero_enigma/enigma_base_attack.vpcf",
        bDodgeable = true,
        bProvidesVision = true,
        iMoveSpeed = 800,
        iVisionRadius = 300,
        iVisionTeamNumber = casterTeam,
        iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1
    })

    EmitSoundOn("Hero_Warlock.Attack", caster)
end

function shadow3:OnProjectileHit(target, location)
    if(target == nil) then
        return true
    end

    local caster = self:GetCaster()

    EmitSoundOn("Hero_Warlock.FatalBonds", target)

    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_bane/bane_sap_glowsmokebase.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
    ParticleManager:SetParticleControlEnt(particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
    ParticleManager:ReleaseParticleIndex(particle)

    ApplyBuff({
        caster = caster,
        target = target,
        ability = self,
        buff = "modifier_shadow_cleric_dream_feast_debuff",
        dur = self:GetSpecialValueFor("duration"),
        settickrate = 1
    })

    return true
end