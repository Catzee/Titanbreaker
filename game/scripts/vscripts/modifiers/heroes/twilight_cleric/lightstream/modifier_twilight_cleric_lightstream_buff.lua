modifier_twilight_cleric_lightstream_buff = class({
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
            MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
        }
    end,
    GetModifierMagicalResistanceBonus = function(self)
        return self.bonusSpellResistancePerStack * self:GetStackCount()
    end
})

function modifier_twilight_cleric_lightstream_buff:OnCreated()
    self:OnRefresh()
end

function modifier_twilight_cleric_lightstream_buff:OnRefresh()
    self.bonusSpellResistancePerStack = self:GetAbility():GetSpecialValueFor("spellresistance_per_stack")
end