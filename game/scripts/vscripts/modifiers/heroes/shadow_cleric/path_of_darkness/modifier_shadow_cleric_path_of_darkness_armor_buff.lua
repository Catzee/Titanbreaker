modifier_shadow_cleric_path_of_darkness_armor_buff = class({
	IsHidden = function() 
        return false 
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
            MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
            MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
        }
    end,
    GetModifierPhysicalArmorBonus = function(self)
        return self.bonusArmor
    end,
    GetModifierMagicalResistanceBonus = function(self)
        return self.bonusSpellResistance
    end
})

function modifier_shadow_cleric_path_of_darkness_armor_buff:OnCreated()
    self:OnRefresh()
end

function modifier_shadow_cleric_path_of_darkness_armor_buff:OnRefresh()
    self.ability = self:GetAbility()
    self.bonusArmor = self.ability:GetSpecialValueFor("damage_proc_armor")
    self.bonusSpellResistance = self.ability:GetSpecialValueFor("damage_proc_spell_resistance")
end