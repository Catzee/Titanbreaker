modifer_peaceful_guardian_cyclone_hurricane_debuff = class({
	IsHidden = function() 
        return false 
    end,
	IsPurgable = function() 
        return false 
    end,
    IsDebuff = function()
		return true
	end,
	DeclareFunctions = function() 
        return 
        {
		    MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
            MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
	    } 
    end,
	GetModifierPhysicalArmorBonus = function(self) 
        return self.bonusArmorPerStack * self:GetStackCount()
    end,
	GetModifierMagicalResistanceBonus = function(self) 
        return self.bonusSpellResistancePerStack * self:GetStackCount()
    end
})

function modifer_peaceful_guardian_cyclone_hurricane_debuff:OnCreated()
    self:OnRefresh()
end

function modifer_peaceful_guardian_cyclone_hurricane_debuff:OnRefresh() 
    self.ability = self:GetAbility()
    self.bonusArmorPerStack = self.ability:GetSpecialValueFor("hurricane_armor")
    self.bonusSpellResistancePerStack = self.ability:GetSpecialValueFor("hurricane_spellresistance")
end