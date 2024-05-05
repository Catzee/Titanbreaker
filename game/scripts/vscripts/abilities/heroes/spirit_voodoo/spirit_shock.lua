resto4 = class({})

function resto4:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_dark_seer/dark_seer_wall_of_replica_replicate.vpcf", context)
    -- debuff particle
	PrecacheResource("particle", "particles/items_fx/diffusal_slow.vpcf", context)
end

function resto4:CastFilterResultTarget(target)
	if(IsClient()) then
		return UF_SUCCESS
	end

	-- Alt cast state: can target enemies and allies
	if(self:IsAltCasted()) then
		return UnitFilter(target, self:GetAbilityTargetTeam(), self:GetAbilityTargetType(), self:GetAbilityTargetFlags(), self:GetCaster():GetTeamNumber())
	end

	-- Default state: can target only allies
	return UnitFilter(target, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, self:GetCaster():GetTeamNumber())
end

function resto4:OnSpellStart()
    local caster = self:GetCaster()
    local target = self:GetCursorTarget()
    local targetOrigin = target:GetAbsOrigin()

    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_dark_seer/dark_seer_wall_of_replica_replicate.vpcf", PATTACH_POINT_FOLLOW, target)
    ParticleManager:SetParticleControlEnt(particle, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", targetOrigin, true)
    ParticleManager:SetParticleControlEnt(particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", targetOrigin, true)
    ParticleManager:DestroyParticle(particle, false)
    ParticleManager:ReleaseParticleIndex(particle)

    ApplyBuffConditional({
        caster = caster,
        target = target,
        ability = self,
        buff = "modifier_spirit_voodoo_spirit_shock_debuff",
        dur = self:GetSpecialValueFor("enemyslow"),
        onlyenemy = 1
    })

    ApplyBuffConditional({
        caster = caster,
        target = target,
        ability = self,
        buff = "modifier_silence",
        dur = self:GetSpecialValueFor("buffdurationInterrupt"),
        onlyenemy = 1
    })

    ApplyBuffConditional({
        caster = caster,
        target = target,
        ability = self,
        buff = "modifier_spirit_voodoo_spirit_shock_buff",
        dur = self:GetSpecialValueFor("spellresistance_duration"),
        onlyfriend = 1
    })

    self:SpiritHealCrit({
        caster = caster,
        target = target,
        ability = self
    })

    DamageUnitConditional({
        caster = caster,
        target = target,
        ability = self,
        damage = 0,
        spelldamagefactor = self:GetSpecialValueFor("spelldmg"),
        attributefactor = self:GetSpecialValueFor("dmgfromstat"),
        arcanedmg = 1
    })

    PurgeIfFriend({
        caster = caster,
        target = target,
        ability = self
    })

    ApplyBuffStack({
        caster = caster,
        target = target,
        ability = self,
        addstacks = self:GetSpecialValueFor("instant_casts"),
        max = self:GetSpecialValueFor("instant_casts_max"),
        buff = "modifier_spirit_voodoo_spirit_shock_instant_casts",
        ["self"] = 1,
        dur = self:GetSpecialValueFor("instant_casts_duration")
    })

    EmitSoundOn("Hero_ElderTitan.AncestralSpirit.Buff", target)
    EmitSoundOn("witchdoctor_wdoc_anger_07", target)
end

function resto4:SpiritHealCrit(event)
    if event.ability:GetLevel() >= 3 then
        event.caster.spiritHealCrit = event.ability:GetSpecialValueFor("crits_count")
    end
end