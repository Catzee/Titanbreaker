Dark_Light2 = class({})

function Dark_Light2:Precache(context)
	PrecacheResource("particle", "particles/dazzle_holy_wave_b.vpcf", context)
	PrecacheResource("particle", "particles/econ/events/ti6/hero_levelup_ti6_flash_hit_magic.vpcf", context)
end

function Dark_Light2:CastFilterResultTarget(target)
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

function Dark_Light2:OnSpellStart()
    local caster = self:GetCaster()
    local target = self:GetCursorTarget()
    local abilityManaCost = self:GetManaCost(-1)

    ChannelManaFixStart({
		caster = caster,
		target = target,
		ability = self,
        mana = abilityManaCost,
        casttime = self:GetSpecialValueFor("duration")
	})

    SetChannelTarget({
        caster = caster,
        target = target,
        ability = self
    })

    ChannelTickSystem({
        caster = caster,
        target = target,
        ability = self,
        tickinterval = self:GetSpecialValueFor("dotticks"),
        duration = self:GetSpecialValueFor("duration"),
        channelintervalcheck = 0.1
    })

    self:OnLightstreamChannelTick(caster, target, true)
end

function Dark_Light2:OnChannelFinish(isInterrupt)
    local caster = self:GetCaster()
    local target = self:GetCursorTarget()

    if(isInterrupt == true) then
        StopChannelTarget({
            caster = caster,
            target = target,
            ability = self,
            buff = "modifier_penance"
        })
        ChannelInterrupt({
            caster = caster,
            target = target,
            ability = self,
            cooldownfix = 1
        })
    else
        ChannelManaFixEnd({
            caster = caster,
            target = target,
            ability = self,
            mana = self:GetManaCost(-1)
        })
    end
end

function Dark_Light2:OnLightstreamChannelTick(caster, target, forceDispel)
    local targetOrigin = target:GetAbsOrigin()

    local particle = ParticleManager:CreateParticle("particles/dazzle_holy_wave_b.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
    ParticleManager:SetParticleControlEnt(particle, 0, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", targetOrigin, true)
    ParticleManager:ReleaseParticleIndex(particle)

    local particle = ParticleManager:CreateParticle("particles/econ/events/ti6/hero_levelup_ti6_flash_hit_magic.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
    ParticleManager:SetParticleControlEnt(particle, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", targetOrigin, true)
    ParticleManager:ReleaseParticleIndex(particle)

    EmitSoundOn("DOTA_Item.LinkensSphere.Target", target)

    if(forceDispel == true or self:GetSpecialValueFor("dispelontick") > 0) then
        PurgeIfFriend({
            caster = caster,
            target = target,
            ability = self
        })
    end
    self:Penance({
        caster = caster,
        target = target,
        ability = self,
        damage = 0,
        spelldamagefactor = self:GetSpecialValueFor("spelldmg"),
        attributefactor = self:GetSpecialValueFor("dmgfromstat"),
        holydmg = 1,
        heal = 0.0,
        dmgfactor = self:GetSpecialValueFor("dmg"),
        darkstacks = self:GetSpecialValueFor("darkstacks"),
        bloodwolf = 1
    })

    ReduceCooldown({
        caster = caster,
        target = target,
        ability = self,
        amount = self:GetSpecialValueFor("cd"),
        chooseability = 5
    })

    caster:ForcePlayActivityOnce(ACT_DOTA_CAST_ABILITY_3)
end

function Dark_Light2:OnChannelTickSystemTick(caster, target)
   self:OnLightstreamChannelTick(caster, target) 
end

function Dark_Light2:Penance(event)
    local caster = event.caster
    local target = event.target

    if caster:GetTeamNumber() == target:GetTeamNumber() then
        if event.ability:GetLevel() >= 4 then
            ApplyBuffStack({
                caster = caster, 
                target = target, 
                ability = event.ability, 
                max = self:GetSpecialValueFor("spellresistance_max_stacks"), 
                buff = "modifier_twilight_cleric_lightstream_buff", 
                dur = self:GetSpecialValueFor("spellresistance_duration")
            })
        end
        HealUnit(event)
    else
        if event.darkstacks and event.darkstacks > 0 then
            local myevent = {}
            myevent.caster = caster
            myevent.target = target
            myevent.darkstacks = event.darkstacks
            ShadowCrippleStacks(myevent)
        end
        event.spelldamagefactor = event.spelldamagefactor * event.dmgfactor/100
        event.attributefactor = event.attributefactor * event.dmgfactor/100
        DamageUnit(event)
    end
end