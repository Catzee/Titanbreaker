Holy_Judgement = class({})

function Holy_Judgement:Precache(context)
    PrecacheResource("particle", "particles/units/heroes/hero_omniknight/omniknight_purification_cast.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_omniknight/omniknight_purification.vpcf", context)
	PrecacheResource("particle", "particles/econ/items/antimage/antimage_weapon_basher_ti5_gold/am_manaburn_basher_ti_5_b_gold.vpcf", context)
	-- aa proc particles
	PrecacheResource("particle", "particles/units/heroes/hero_keeper_of_the_light/keeper_of_the_light_mana_leak.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_nyx_assassin/nyx_assassin_mana_burn_bloom.vpcf", context)	
end

function Holy_Judgement:CastFilterResultTarget(target)
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

function Holy_Judgement:OnSpellStart()
    local caster = self:GetCaster()
    local target = self:GetCursorTarget()
	local targetOrigin = caster:GetAbsOrigin()

	local particleCast = ParticleManager:CreateParticle("particles/units/heroes/hero_omniknight/omniknight_purification_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControlEnt(particleCast, 0, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), true)
	ParticleManager:SetParticleControl(particleCast, 1, targetOrigin)
	ParticleManager:DestroyParticle(particleCast, false)
	ParticleManager:ReleaseParticleIndex(particleCast)

	local particleAoe = ParticleManager:CreateParticle("particles/units/heroes/hero_omniknight/omniknight_purification.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControl(particleAoe, 0, targetOrigin)
	ParticleManager:SetParticleControl(particleAoe, 1, Vector(10, 10, 10))
	ParticleManager:DestroyParticle(particleAoe, false)
	ParticleManager:ReleaseParticleIndex(particleAoe)  

	local particleManaburn = ParticleManager:CreateParticle("particles/econ/items/antimage/antimage_weapon_basher_ti5_gold/am_manaburn_basher_ti_5_b_gold.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
    ParticleManager:SetParticleControlEnt(particleManaburn, 0, caster, PATTACH_OVERHEAD_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), true)
	ParticleManager:DestroyParticle(particleManaburn, false)
	ParticleManager:ReleaseParticleIndex(particleManaburn)

	ApplyBuffConditional({
		caster = caster,
		target = target,
		buff = "modifier_silence",
		ability = self,
		dur = self:GetSpecialValueFor("silenceduration"),
		onlyenemy = 1
	})

	local eventTable = {
		caster = caster,
		target = target,
		heal = self:GetSpecialValueFor("AbilityHealing"),
		ability = self,
		spelldamagefactor = self:GetSpecialValueFor("spelldmg"),
		attributefactor = self:GetSpecialValueFor("dmgfromstat"),
		critdmgbonusfactor = self:GetSpecialValueFor("critbonus"),
		critmanareg = self:GetSpecialValueFor("critmana"),
		critmanaregnonpercent = 1,
		dmgfactor = self:GetSpecialValueFor("dmgfactor"),
		holydmg = 1,
		spellresduration = self:GetSpecialValueFor("spellresduration")
	}

	if (caster:GetTeamNumber() == target:GetTeamNumber()) then
		target:AddNewModifier(caster, self, "modifier_judgement_spellres",
		{
			duration = eventTable.spellresduration
		})

		HealUnit(eventTable)
	else
		eventTable.spelldamagefactor = eventTable.spelldamagefactor * eventTable.dmgfactor/100
		eventTable.attributefactor = eventTable.attributefactor * eventTable.dmgfactor/100
        eventTable.critdmgbonusfactor = nil
		DamageUnit(eventTable)

		caster:AddNewModifier(caster, self, "modifier_judgement_wisdom",
		{
			duration = self:GetSpecialValueFor("aaprocduration")
		})
	end

	EmitSoundOn("Hero_Omniknight.Purification", caster)
end
