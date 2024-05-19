modifier_shadow_cleric_nightmare_aura = class({
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
        return DOTA_UNIT_TARGET_TEAM_FRIENDLY
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
        return "modifier_shadow_cleric_nightmare_aura_buff" 
    end
})

function modifier_shadow_cleric_nightmare_aura:OnCreated()
    self:OnRefresh()
end

function modifier_shadow_cleric_nightmare_aura:OnRefresh()
    if(not IsServer()) then
        return
    end
    self.ability = self:GetAbility()
    self.auraRadius = self.ability:GetSpecialValueFor("attack_speed_aura_radius")
end

function modifier_shadow_cleric_nightmare_aura:GetAuraEntityReject(target)
    if(target.owner ~= nil) then
        return false
    end

    return true
end