shadow3 = class({})

function shadow3:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_enigma/enigma_base_attack.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_bane/bane_sap_glowsmokebase.vpcf", context)
    PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_warlock.vsndevts", context)
    -- tentacle particles
    PrecacheResource("particle", "particles/status_fx/status_effect_fiendsgrip.vpcf", context)
    PrecacheResource("particle", "particles/units/unit_greevil/greevil_blackhole_n.vpcf", context)
end

function shadow3:OnSpellStart()
    local caster = self:GetCaster()
    local target = self:GetCursorTarget()

    local spheresForCrit = self:GetSpecialValueFor("crit_shadow_spheres")
    local critDuration = self:GetSpecialValueFor("crit_duration")

    if(critDuration > 0 and GetShadowClericShadowSpheres(caster) >= spheresForCrit) then
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
        settickrate = self:GetSpecialValueFor("tick_interval")
    })

    local tentacle = self:GetSpecialValueFor("tentacle")

    if(tentacle > 0) then
        local tentacleDuration = self:GetSpecialValueFor("tentacle_duration")
        tentacle = CreateUnitByName("npc_dota_creature_shadow_tentacle", target:GetAbsOrigin(), true, caster, caster, caster:GetTeamNumber())
        tentacle:SetControllableByPlayer(caster:GetPlayerOwnerID(), true)
        tentacle:AddNewModifier(caster, self, "modifier_phased", {duration = tentacleDuration})
        tentacle:AddNewModifier(caster, self, "modifier_shadow_cleric_dream_feast_tentacle", {duration = tentacleDuration})
        tentacle:AddNewModifier(caster, self, "modifier_pet_system_lua", {duration = tentacleDuration, intsp = self:GetSpecialValueFor("tentacle_intsp"), shadowdmg = 1})
    end
    return true
end