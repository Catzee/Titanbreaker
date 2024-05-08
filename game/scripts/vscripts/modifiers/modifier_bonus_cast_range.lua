modifier_bonus_cast_range = class({
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
            MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING
        }
    end,
    GetModifierCastRangeBonusStacking = function(self)
        return self:GetStackCount()
    end,
    GetAttributes = function()
        return MODIFIER_ATTRIBUTE_PERMANENT
    end,
    RemoveOnDeath = function()
        return false
    end
})