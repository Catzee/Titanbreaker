shadow1 = class({
    GetIntrinsicModifierName = function()
        return "modifier_shadow_cleric_shadow_orbs"
    end
})

function shadow1:Precache(context)
	PrecacheResource("particle", "particles/econ/items/templar_assassin/templar_assassin_butterfly/templar_assassin_base_attack_explosion_butterfly.vpcf", context)
	PrecacheResource("particle", "particles/econ/events/ti4/dagon_ti4.vpcf", context)
    PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_templar_assassin.vsndevts", context)
    PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_invoker.vsndevts", context)
    -- shadow orb particle
	PrecacheResource("particle", "particles/items3_fx/glimmer_cape_initial_flash_ember.vpcf", context)
    -- debuff particle
    PrecacheResource("particle", "particles/units/heroes/hero_night_stalker/nightstalker_change_ash.vpcf", context)
end

function shadow1:OnSpellStart()
    local caster = self:GetCaster()
    local target = self:GetCursorTarget()
    local abilityManaCost = self:GetManaCost(-1)
    local duration = self:GetChannelTime()

    ChannelManaFixStart({
		caster = caster,
		target = target,
		ability = self,
        mana = abilityManaCost,
        casttime = duration
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
        tickinterval = self:GetSpecialValueFor("tickrate"),
        duration = duration,
        channelintervalcheck = 0.1
    })

    self:OnMindstormChannelTick(caster, target)
end

function shadow1:OnChannelFinish(isInterrupt)
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

function shadow1:OnShadowClericShadowSphereGained()
    local caster = self:GetCaster()
    ApplyBuffStack({
        caster = caster,
        target = caster,
        ability = self,
        max = self:GetSpecialValueFor("mindbender_max_stacks"),
        dur = self:GetSpecialValueFor("mindbender_duration"),
        buff = "modifier_shadow_cleric_mindstorm_mindbender",
        self = 1
    })
end

function shadow1:OnMindstormChannelTick(caster, target)
    local targetOrigin = target:GetAbsOrigin()
    local casterOrigin = caster:GetAbsOrigin()

    local particle = ParticleManager:CreateParticle("particles/econ/items/templar_assassin/templar_assassin_butterfly/templar_assassin_base_attack_explosion_butterfly.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
    ParticleManager:SetParticleControlEnt(particle, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", targetOrigin, true)
    ParticleManager:SetParticleControlEnt(particle, 3, target, PATTACH_POINT_FOLLOW, "attach_hitloc", targetOrigin, true)
    ParticleManager:ReleaseParticleIndex(particle)

    particle = ParticleManager:CreateParticle("particles/econ/events/ti4/dagon_ti4.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
    ParticleManager:SetParticleControlEnt(particle, 0, caster, PATTACH_POINT_FOLLOW, "attach_attack1", casterOrigin, true)
    ParticleManager:SetParticleControlEnt(particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", targetOrigin, true)
    ParticleManager:ReleaseParticleIndex(particle)

    particle = ParticleManager:CreateParticle("particles/econ/events/ti4/dagon_ti4.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
    ParticleManager:SetParticleControlEnt(particle, 0, caster, PATTACH_POINT_FOLLOW, "attach_attack2", casterOrigin, true)
    ParticleManager:SetParticleControlEnt(particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", targetOrigin, true)
    ParticleManager:ReleaseParticleIndex(particle)

    EmitSoundOn("Hero_TemplarAssassin.Trap.Cast", caster)

    DamageUnit({
        caster = caster,
        target = target,
        ability = self,
        damage = 0,
        spelldamagefactor = self:GetSpecialValueFor("spelldmg"),
        attributefactor = self:GetSpecialValueFor("dmgfromstat"),
        shadowdmg = 1,
        shadowstrikesp = 1,
        bloodwolf = 1,

    })
    
    if(math.random(1, 100) <= self:GetSpecialValueFor("knockback")) then
        KnockBackNear({
            caster = caster,
            target = target,
            ability = self,
            fixedforce = self:GetSpecialValueFor("knockback_force"),
            neartarget = self:GetSpecialValueFor("knockback_range")
        })
    end

    EmitSoundOn("Hero_Invoker.ProjectileImpact", caster)

    self:Mindflay({
        caster = caster,
        target = target,
        ability = self,
        dur = self:GetSpecialValueFor("slowdur")
    })

    local shadowSphereChance = self:GetSpecialValueFor("shadow_orbs_chance")
    TryAddShadowClericShadowSphere(caster, self, shadowSphereChance)

    caster:ForcePlayActivityOnce(ACT_DOTA_CAST_ABILITY_1)
end

function shadow1:OnChannelTickSystemTick(caster, target)
   self:OnMindstormChannelTick(caster, target) 
end

function shadow1:Mindflay( event )
	local caster = event.caster
	local target = event.target
	local ability = event.ability
	if event.ability ~= nil then
		local myevent = {}
		myevent.caster = caster
		myevent.target = target
		myevent.buff = "modifier_shadow_cleric_mindstorm_debuff"
		myevent.ability = ability
		myevent.dur = event.dur
		ApplyBuff(myevent)
		--end
		local distance = (caster:GetAbsOrigin()-target:GetAbsOrigin()):Length() - GetCastRangeBonus(caster)
		if distance > 1000 or target:HasModifier("modifier_invisible") then
			caster:Stop()
		end
	else
		caster:Stop()
	end
end