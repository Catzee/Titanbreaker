CycloneDruid = class({
    GetIntrinsicModifierName = function()
        return "modifer_peaceful_guardian_cyclone_aura"
    end
})

function CycloneDruid:Precache(context)
	PrecacheResource("particle", "particles/cyclone_self1.vpcf", context)
    -- hurricane particles
	PrecacheResource("particle", "particles/econ/items/razor/razor_arcana/razor_arcana_cyclone_core_cloudy.vpcf", context)
    PrecacheResource("particle", "particles/econ/items/razor/razor_arcana/razor_arcana_strike_top_lightning_strike.vpcf", context)
end

function CycloneDruid:CastFilterResultTarget(target)
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

function CycloneDruid:OnAbilityPhaseStart()
    local eventTable = {
		caster = self:GetCaster(),
		target = self:GetCursorTarget(),
		ability = self,
        mana = self:GetSpecialValueFor("AbilityManaCost"),
        instantcast = self:GetSpecialValueFor("instant")
	}
    
    ChannelManaFixStart(eventTable)

    EmitSoundOn("Hero_Silencer.Curse", eventTable.caster)

    eventTable.mana = nil
    eventTable.instantcast = nil
    ShapeshiftOut(eventTable)

    return true
end

function CycloneDruid:OnAbilityPhaseInterrupted()
    ChannelInterrupt({
		caster = self:GetCaster(),
		target = self:GetCursorTarget(),
		ability = self,
        cooldownfix = 1
	})
end

function CycloneDruid:OnSpellStart()
    local caster = self:GetCaster()
    local target = self:GetCursorTarget()
	local targetOrigin = caster:GetAbsOrigin()
    local abilityManaCost = self:GetSpecialValueFor("AbilityManaCost")
    local diminish = self:GetSpecialValueFor("diminish")

	local eventTable = {
		caster = caster,
		target = target,
		ability = self,
        mana = abilityManaCost
	}

    ChannelManaFixEnd(eventTable)
    
    eventTable.mana = nil
    PurgeIfFriend(eventTable)

    self:CycloneHurricane(eventTable)

    eventTable.diminish = diminish
    eventTable.dur = self:GetSpecialValueFor("buffduration")
    eventTable.buff = "modifer_peaceful_guardian_cyclone_debuff"
    eventTable.curseblade = 1
    self:CycloneDiminishing(eventTable)

    EmitSoundOn("DOTA_Item.Cyclone.Activate", caster)

    eventTable.diminish = nil
    eventTable.dur = nil
    eventTable.buff = nil
    eventTable.curseblade = nil
    eventTable.mana = abilityManaCost
    ChannelManaFixEnd(eventTable)

    eventTable.max = diminish
    eventTable.buff = "modifer_peaceful_guardian_cyclone_diminishing_return"
    eventTable.self = 1
    eventTable.dur = diminish
    eventTable.addstacks = diminish
    eventTable.alwaysapply = 1
    eventTable.mana = nil
    ApplyBuffStack(eventTable)
end

function CycloneDruid:CycloneDiminishing(event)
	local caster = event.caster
	local target = event.target

	local diminishing = caster:GetModifierStackCount("modifer_peaceful_guardian_cyclone_diminishing_return", caster)
	event.dur = event.dur * (event.diminish - diminishing) / event.diminish
	CCTarget(event)
end

function CycloneDruid:CycloneHurricane(event)
    if self:GetLevel() >= 4 and event.caster:HasModifier("modifier_druid_evasion_h") then
        ApplyBuff({caster = event.caster, target = event.caster, dur = self:GetSpecialValueFor("hurricane_duration"), buff = "modifer_peaceful_guardian_cyclone_hurricane", ability = self, pierceCyclone = 1})
    end
end