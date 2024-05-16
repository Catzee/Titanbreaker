modifier_shadow_cleric_dream_feast_tentacle = class({
	IsHidden = function() 
        return true 
    end,
	IsPurgable = function() 
        return false 
    end,
    IsDebuff = function()
		return false
	end,
	IsAura = function() 
        return true 
    end,
	GetAuraSearchTeam = function() 
        return DOTA_UNIT_TARGET_TEAM_ENEMY
    end,
	GetAuraSearchType = function() 
        return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
    end,
	GetAuraSearchFlags = function() 
        return DOTA_UNIT_TARGET_FLAG_NONE
    end,
	GetAuraRadius = function(self)
        return self.auraRadius 
    end,
	GetModifierAura = function() 
        return "modifier_shadow_cleric_dream_feast_tentacle_debuff" 
    end,
    DeclareFunctions = function()
        return 
        {
            MODIFIER_EVENT_ON_ATTACK_LANDED
        }
    end,
    CheckState = function()
        return 
        {
            [MODIFIER_STATE_UNSELECTABLE] = true,
            [MODIFIER_STATE_ROOTED] = true
        }
    end,
    GetStatusEffectName = function()
        return "particles/status_fx/status_effect_fiendsgrip.vpcf"
    end,
    StatusEffectPriority = function()
        return MODIFIER_PRIORITY_NORMAL
    end
})

function modifier_shadow_cleric_dream_feast_tentacle:OnCreated()
    self:OnRefresh()

    if(not IsServer()) then
        return
    end

    self.owner = self.ability:GetCaster()
    self.parent = self:GetParent()
    local parentOrigin = self.parent:GetAbsOrigin()

    local particle = ParticleManager:CreateParticle("particles/units/unit_greevil/greevil_blackhole_n.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
	ParticleManager:SetParticleControlEnt(particle, 0, self.parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", parentOrigin, true)
    ParticleManager:SetParticleControlEnt(particle, 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", parentOrigin, true)

    self:AddParticle(particle, false, false, 1, false, false)
end

function modifier_shadow_cleric_dream_feast_tentacle:OnRefresh()
    if(not IsServer()) then
        return
    end
    self.ability = self:GetAbility()
    self.auraRadius = self.ability:GetSpecialValueFor("tentacle_aura_radius")
    self.shadowTentacleInnerCd = self.ability:GetSpecialValueFor("tentacle_bonus_shadow_spheres_per_aa_inner_cd")
    self.shadowTentacleShadowSpheres = self.ability:GetSpecialValueFor("tentacle_bonus_shadow_spheres_per_aa")
end

function modifier_shadow_cleric_dream_feast_tentacle:OnAttackLanded(kv)
    if(kv.attacker ~= self.parent) then
        return
    end

    if(self.owner._shadowClericDreamFeastTentacleAAInnerCd) then
        return
    end

    if(self.shadowTentacleShadowSpheres < 1) then
        return
    end
    local sphereChance = 100
    for i=1,self.shadowTentacleShadowSpheres do
        TryAddShadowClericShadowSphere(self.owner, self.ability, sphereChance)
    end

    self.owner._shadowClericDreamFeastTentacleAAInnerCd = true
    
    local innerCd = self.shadowTentacleInnerCd * GetInnerCooldownFactor(self.owner)
    Timers:CreateTimer(innerCd, function()
        self.owner._shadowClericDreamFeastTentacleAAInnerCd  = nil
    end)
end