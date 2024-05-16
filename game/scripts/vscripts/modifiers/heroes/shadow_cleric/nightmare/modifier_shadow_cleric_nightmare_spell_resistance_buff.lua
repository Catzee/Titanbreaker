modifier_shadow_cleric_nightmare_spell_resistance_buff = class({
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
    GetEffectName = function()
        return "particles/items2_fx/unused_field_3.vpcf"
    end,
    GetEffectAttachType = function()
        return PATTACH_ABSORIGIN_FOLLOW
    end
})

function modifier_shadow_cleric_nightmare_spell_resistance_buff:OnCreated()
    self:OnRefresh()
end

function modifier_shadow_cleric_nightmare_spell_resistance_buff:OnRefresh()
    self.bonusSpellResistance = self:GetAbility():GetSpecialValueFor("spell_resistance_amount")
end