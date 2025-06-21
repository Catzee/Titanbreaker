Retri4 = class({})

function Retri4:Precache(context)
    PrecacheResource("particle", "particles/units/heroes/hero_sven/sven_spell_storm_bolt.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_nyx_assassin/nyx_assassin_mana_burn_bloom.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_sven/sven_spell_storm_bolt.vpcf", context)
    PrecacheResource("particle", "particles/econ/items/magnataur/shock_of_the_anvil/magnataur_shockanvil_hit.vpcf", context)
end

function Retri4:OnAltCastToggled()
    self:FixCooldown()
end

function Retri4:OnProjectileHitHandle(target, location, projectileId)
    if(not target) then
		self._projectiles[projectileId] = nil
        return true
    end
	
    local particle = ParticleManager:CreateParticle("particles/econ/items/magnataur/shock_of_the_anvil/magnataur_shockanvil_hit.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControlEnt(particle, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
    ParticleManager:DestroyParticle(particle, false)
    ParticleManager:ReleaseParticleIndex(particle)
	
    EmitSoundOn("Hero_LegionCommander.Overwhelming.Hero", target)
	
	-- It was alt casted
	if(self._projectiles[projectileId] == true) then
		SpellInterrupt({
			caster = self:GetCaster(),
			target = target,
			ability = self,
			dur = self:GetSpecialValueFor("silence_duration")
		})
		self._projectiles[projectileId] = nil
		return
	end

    Punishment({
        caster = self:GetCaster(),
        target = target,
        ability = self,
        dur = self:GetSpecialValueFor("buffduration"),
		amount = self:GetSpecialValueFor("manareturn")
    })
	
    self._projectiles[projectileId] = nil
		
	if(RandomInt(1, 100) <= self:GetSpecialValueFor("shadowchance")) then
        DamageUnit({
            caster = caster,
            target = target,
            ability = self,
            damage = 0,
            spelldamagefactor = 0,
            attributefactor = 0,
            includeauto = self:GetSpecialValueFor("dmgfromstat"),
            shadowdmg = 1
        })
	end
	
    return true
end

function Retri4:OnSpellStart()
    local caster = self:GetCaster()
    local target = self:GetCursorTarget()

    EmitSoundOn("Hero_LegionCommander.PreAttack", caster)

    local projectileId = ProjectileManager:CreateTrackingProjectile({
        Target = target,
        Source = caster,
        Ability = self,
        EffectName = "particles/units/heroes/hero_sven/sven_spell_storm_bolt.vpcf",
        bDodgeable = true,
        bProvidesVision = true,
        iMoveSpeed = 750,
        iVisionRadius = 300,
        iVisionTeamNumber = caster:GetTeamNumber(),
        iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_HITLOCATION
    })
	
    self._projectiles = self._projectiles or {}
    self._projectiles[projectileId] = self:IsAltCasted()
	
    self._expectedCooldownEndTime = self._expectedCooldownEndTime or {}
	if(self._projectiles[projectileId] == false) then
		caster:AddNewModifier(caster, self, "modifier_pala_str_bonus_check", {duration = self:GetSpecialValueFor("strdur")})
        self._expectedCooldownEndTime[false] = GameRules:GetGameTime() + (self:GetCooldown(-1) * GetCooldownReductionFactor(caster, ability))
	else
        self._expectedCooldownEndTime[true] = GameRules:GetGameTime() + (self:GetSpecialValueFor("silence_inner_cd") * GetCooldownReductionFactor(caster, ability))
	end

    self:FixCooldown()
end

function Retri4:ReduceCooldown(cdrFlat)
    self._expectedCooldownEndTime = self._expectedCooldownEndTime or {}
    self._expectedCooldownEndTime[false] = self._expectedCooldownEndTime[false] or 0
    self._expectedCooldownEndTime[false] = self._expectedCooldownEndTime[false] - cdrFlat
    self:FixCooldown()
end

function Retri4:FixCooldown()
    local isAltCast = self:IsAltCasted()
    self:EndCooldown()
    self._expectedCooldownEndTime = self._expectedCooldownEndTime or {}
    self._expectedCooldownEndTime[isAltCast] = self._expectedCooldownEndTime[isAltCast] or 0
    local expectedCd = math.max(0, self._expectedCooldownEndTime[isAltCast] - GameRules:GetGameTime())
    self:StartCooldown(expectedCd)
end

modifier_pala_str_bonus_check = class({
	IsHidden = function() 
        return false 
    end,
	IsPurgable = function() 
        return false 
    end,
    IsPurgeException = function()
        return false
    end,
    IsDebuff = function()
		return false
	end,
	GetTextureName = function()
		return "sven_warcry"
	end
})

function modifier_pala_str_bonus_check:OnCreated()
	if(not IsServer()) then
		return
	end
	self.parent = self:GetParent()

	self:OnRefresh()
	self:StartIntervalThink(2.99)
end

function modifier_pala_str_bonus_check:OnRefresh()
	if(not IsServer()) then
		return
	end
	self.ability = self:GetAbility()
	self.amount = self.ability:GetSpecialValueFor("amount")
end

function modifier_pala_str_bonus_check:OnIntervalThink()
	RestoreMana({
        caster = self.parent,
        ability = self.ability,
		amount = self.amount,
		percent = 1
	})
end

LinkLuaModifier("modifier_pala_str_bonus_check", "abilities/heroes/fanatic_crusarder/hammer_of_sanction", LUA_MODIFIER_MOTION_NONE)