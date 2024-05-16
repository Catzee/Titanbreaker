modifier_shadow_cleric_dream_feast_tentacle = class({
	IsHidden = function() 
        return false 
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
end

function modifier_shadow_cleric_dream_feast_tentacle:OnRefresh()
    self.auraRadius = self:GetAbility():GetSpecialValueFor("tentacle_aura_radius")
end