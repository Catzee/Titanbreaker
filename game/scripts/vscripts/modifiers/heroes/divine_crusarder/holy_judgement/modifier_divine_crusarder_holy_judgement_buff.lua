modifier_divine_crusarder_holy_judgement_buff = class({
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
        return self.bonusSpellResistance
    end,
    GetAttributes = function()
        return MODIFIER_ATTRIBUTE_MULTIPLE
    end
})

function modifier_divine_crusarder_holy_judgement_buff:OnCreated()
    self:OnRefresh()
end

function modifier_divine_crusarder_holy_judgement_buff:OnRefresh()
    self.bonusSpellResistance = self:GetAbility():GetSpecialValueFor("spellres")
end