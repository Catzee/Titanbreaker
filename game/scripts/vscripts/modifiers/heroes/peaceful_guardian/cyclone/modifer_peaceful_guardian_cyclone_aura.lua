modifer_peaceful_guardian_cyclone_aura = class({
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
        return DOTA_UNIT_TARGET_TEAM_FRIENDLY
    end,
	GetAuraSearchType = function() 
        return DOTA_UNIT_TARGET_HERO
    end,
	GetAuraSearchFlags = function() 
        return DOTA_UNIT_TARGET_FLAG_NONE
    end,
	GetAuraRadius = function(self) 
        return self.auraRadius 
    end,
	GetModifierAura = function() 
        return "modifer_peaceful_guardian_cyclone_aura_buff" 
    end
})

function modifer_peaceful_guardian_cyclone_aura:OnCreated()
    self:OnRefresh()
end

function modifer_peaceful_guardian_cyclone_aura:OnRefresh()
    self.auraRadius = self:GetAbility():GetSpecialValueFor("auraradius")
end