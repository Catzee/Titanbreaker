modifer_peaceful_guardian_cyclone_aura_buff = class({
	IsHidden = function() 
        return true 
    end,
	IsPurgable = function() 
        return false 
    end,
    IsDebuff = function()
		return false
	end,
	DeclareFunctions = function() 
        return 
        {
		    MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
	    } 
    end,
	GetModifierAttackSpeedBonus_Constant = function(self) 
        return self.bonusAttackSpeed
    end
})

function modifer_peaceful_guardian_cyclone_aura_buff:OnCreated()
    self.ability = self:GetAbility()

    -- Fix for auras sometimes apply broken buff/debuff
    if(self.ability == nil) then
        self:Destroy()
        return
    end

    self:OnRefresh()
end

function modifer_peaceful_guardian_cyclone_aura_buff:OnRefresh() 
    self.bonusAttackSpeed = self.ability:GetSpecialValueFor("as")
end