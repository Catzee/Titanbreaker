shadow11 = class({
    GetAOERadius = function(self)
        return self:GetSpecialValueFor("aoe")
    end
})

function shadow11:Precache(context)
	PrecacheResource("particle", "particles/fireball_17.vpcf", context)
	PrecacheResource("particle", "particles/econ/items/antimage/antimage_weapon_basher_ti5/am_manaburn_basher_ti_5.vpcf", context)
    PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_warlock.vsndevts", context)
    PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_silencer.vsndevts", context)
end

function shadow11:OnAbilityPhaseStart()
    local caster = self:GetCaster()
    local target = self:GetCursorTarget()
    
    ChannelManaFixStart({
		caster = caster,
		target = target,
		ability = self,
        mana = self:GetManaCost(-1)
	})

    EmitSoundOn("Hero_Silencer.Curse", caster)

    return true
end

function shadow11:OnAbilityPhaseInterrupted()
    ChannelInterrupt({
		caster = self:GetCaster(),
		target = self:GetCursorTarget(),
		ability = self,
        cooldownfix = 1
	})
end

function shadow11:OnSpellStart()
    local caster = self:GetCaster()
    local casterTeam = caster:GetTeamNumber()
    local target = self:GetCursorTarget()
    local position = target:GetAbsOrigin()

    local enemies = FindUnitsInRadius(
        casterTeam, 
        position, 
        nil, 
        self:GetSpecialValueFor("aoe"), 
        DOTA_UNIT_TARGET_TEAM_ENEMY, 
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
        DOTA_UNIT_TARGET_FLAG_NONE, 
        FIND_ANY_ORDER, 
        false)
    
    local projectile = {
        Target = nil,
        Source = caster,
        Ability = self,
        EffectName = "particles/fireball_17.vpcf",
        bDodgeable = true,
        bProvidesVision = true,
        iMoveSpeed = 550,
        iVisionRadius = 300,
        iVisionTeamNumber = casterTeam,
        iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1
    }

    for _, enemy in pairs(enemies) do
        projectile.Target = enemy
        ProjectileManager:CreateTrackingProjectile(projectile)
    end

    EmitSoundOn("Hero_Warlock.Attack", caster)

    ChannelManaFixEnd({
		caster = caster,
		target = target,
		ability = self,
        mana = self:GetManaCost(-1),
	})

    local cdrFlat = self:GetSpecialValueFor("cdr_flat")

    ReduceAbilityCooldown({
		caster = caster,
		target = target,
		ability = self,
        index = 4,
        amount = cdrFlat
	})

    ReduceAbilityCooldown({
		caster = caster,
		target = target,
		ability = self,
        index = 5,
        amount = cdrFlat
	})
end

function shadow11:OnProjectileHit(target, location)
    if(target == nil) then
        return true
    end

    local caster = self:GetCaster()

    local shadowSphereChance = 100
    TryAddShadowClericShadowSphere(caster, self, shadowSphereChance)

    EmitSoundOn("Hero_Warlock.FatalBondsDamage", target)

    local particle = ParticleManager:CreateParticle("particles/econ/items/antimage/antimage_weapon_basher_ti5/am_manaburn_basher_ti_5.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
    ParticleManager:SetParticleControlEnt(particle, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
    ParticleManager:ReleaseParticleIndex(particle)

    if(target._shadowClericShadow11InnerCd == nil) then
        CCTarget({
            caster = caster,
            target = target,
            ability = self,
            buff = "modifier_stunned",
            dur = self:GetSpecialValueFor("stun_duration"),
            curseblade = 1
        })

        target._shadowClericShadow11InnerCd = true
        local stunInnerCd = self:GetSpecialValueFor("stun_inner_cd") * GetInnerCooldownFactor(caster)
        Timers:CreateTimer(stunInnerCd, function()
            target._shadowClericShadow11InnerCd  = nil
        end)
    end

    DamageUnit({
        caster = caster,
        target = target,
        ability = self,
        damage = 0,
        spelldamagefactor = self:GetSpecialValueFor("spelldmg"),
        attributefactor = self:GetSpecialValueFor("dmgfromstat"),
        shadowdmg = 1
    })

    if(caster._shadowClericShadow11SecondInnerCd == nil and self:GetLevel() >= 3) then
        local shadowPrayerAbility = caster:FindAbilityByName("shadow33")
        if(shadowPrayerAbility ~= nil and shadowPrayerAbility:GetLevel() > 0) then
            shadowPrayerAbility:OnSpellStart(target)
        end

        caster._shadowClericShadow11SecondInnerCd = true
        local shadowPrayerInnerCd = 5 + self:GetSpecialValueFor("shadow_prayer_pain_inner_cd") * GetInnerCooldownFactor(caster)
        Timers:CreateTimer(shadowPrayerInnerCd, function()
            caster._shadowClericShadow11SecondInnerCd  = nil
        end)
    end

    return true
end