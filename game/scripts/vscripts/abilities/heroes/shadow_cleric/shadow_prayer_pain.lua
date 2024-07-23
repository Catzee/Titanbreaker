shadow33 = class({})

function shadow33:Precache(context)
	PrecacheResource("particle", "particles/fireball_16.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_bane/bane_sap_glowsmokebase.vpcf", context)
    PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_warlock.vsndevts", context)
end

-- target = target unit from W4 or class item multicasts
function shadow33:OnSpellStart(target)
    local caster = self:GetCaster()
    target = target or self:GetCursorTarget()

    ProjectileManager:CreateTrackingProjectile({
        Target = target,
        Source = caster,
        Ability = self,
        EffectName = "particles/fireball_16.vpcf",
        bDodgeable = true,
        bProvidesVision = true,
        iMoveSpeed = 800,
        iVisionRadius = 300,
        iVisionTeamNumber = casterTeam,
        iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1
    })

    EmitSoundOn("Hero_Warlock.Attack", caster)
end

function shadow33:OnProjectileHit(target, location)
    if(target == nil) then
        return true
    end

    local caster = self:GetCaster()

    EmitSoundOn("Hero_Warlock.FatalBondsDamage", target)

    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_bane/bane_sap_glowsmokebase.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
    ParticleManager:SetParticleControlEnt(particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
    ParticleManager:ReleaseParticleIndex(particle)

    DamageUnit({
        caster = caster,
        target = target,
        ability = self,
        damage = 0,
        spelldamagefactor = self:GetSpecialValueFor("spelldmg"),
        attributefactor = self:GetSpecialValueFor("dmgfromstat"),
        shadowdmg = 1
    })

    ApplyBuff({
        caster = caster,
        target = target,
        ability = self,
        buff = "modifier_shadow_cleric_shadow_prayer_pain_debuff",
        dur = self:GetSpecialValueFor("duration"),
        settickrate = self:GetSpecialValueFor("tick_interval")
    })

    return true
end

function shadow33:OnAbilityCriticalStrike(caster, target, multicastChance)
    if(self:GetLevel() < 4) then
        print("no lvl")
        return
    end

    if(math.random(1,100) > multicastChance) then
        return
    end

    if((caster:GetAbsOrigin() - target:GetAbsOrigin()):Length() > 2500) then
        return
    end

    if(caster._shadowClericShadow33InnerCd) then
        return
    end

    self:OnSpellStart(target)

    if caster:HasModifier("modifier_class_darkseer") then
        Timers:CreateTimer(0.3,function()
            self:OnSpellStart(target)
            Timers:CreateTimer(0.3,function()
                self:OnSpellStart(target)
            end)
        end)
    end

    caster._shadowClericShadow33InnerCd = true

    local innerCd = self:GetSpecialValueFor("multicast_inner_cd") * GetInnerCooldownFactor(caster)
    Timers:CreateTimer(innerCd, function()
        caster._shadowClericShadow33InnerCd  = nil
    end)
end

function shadow33:OnUnitDamaged(event)
    if(event.target:HasModifier("modifier_shadow_cleric_dream_feast_debuff") == false) then
        return
    end

    if(event.caster._shadowClericShadow33CdrInnerCd) then
        return
    end

    ReduceAbilityCooldown({
		caster = event.caster,
		target = event.caster,
		ability = self,
        index = GetAbilityIndexCustom(self),
        amount = self:GetSpecialValueFor("cdr_flat_dream_feast")
	})

    event.caster._shadowClericShadow33CdrInnerCd = true
    
    local innerCd = self:GetSpecialValueFor("cdr_flat_dream_feast_inner_cd") * GetInnerCooldownFactor(event.caster)
    Timers:CreateTimer(innerCd, function()
        event.caster._shadowClericShadow33CdrInnerCd  = nil
    end)
end