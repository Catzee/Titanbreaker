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

    self.parent = self:GetParent()
    local parentOrigin = self.parent:GetAbsOrigin()

    local particle = ParticleManager:CreateParticle("particles/units/unit_greevil/greevil_blackhole_n.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
	ParticleManager:SetParticleControlEnt(particle, 0, self.parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", parentOrigin, true)
    ParticleManager:SetParticleControlEnt(particle, 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", parentOrigin, true)

    self:AddParticle(particle, false, false, 1, false, false)
end

function modifier_shadow_cleric_dream_feast_tentacle:OnRefresh()
    self.auraRadius = self:GetAbility():GetSpecialValueFor("tentacle_aura_radius")
end