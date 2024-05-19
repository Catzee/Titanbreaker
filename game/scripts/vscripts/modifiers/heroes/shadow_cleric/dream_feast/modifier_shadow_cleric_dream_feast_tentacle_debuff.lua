modifier_shadow_cleric_dream_feast_tentacle_debuff = class({
	IsHidden = function() 
        return false 
    end,
	IsPurgable = function() 
        return false 
    end,
    IsDebuff = function()
		return true
	end,
    GetTexture = function()
        return "fix/shadow_tentacle"
    end,
    DeclareFunctions = function()
        return 
        {
            MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
            MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
        }
    end,
    GetModifierMoveSpeedBonus_Percentage = function(self)
        return self.bonusMovementSpeed
    end,
    GetModifierMagicalResistanceBonus = function(self)
        return self.bonusSpellResistance
    end
})

function modifier_shadow_cleric_dream_feast_tentacle_debuff:OnCreated()
    self.ability = self:GetAbility()

    -- Fix for auras sometimes apply broken buff/debuff
    if(self.ability == nil) then
        self:Destroy()
        return
    end

    self:OnRefresh()
end

function modifier_shadow_cleric_dream_feast_tentacle_debuff:OnRefresh() 
    self.bonusMovementSpeed = self.ability:GetSpecialValueFor("tentacle_movespeed_bonus_pct")
    self.bonusSpellResistance = self.ability:GetSpecialValueFor("tentacle_spellresistance_bonus")
end