modifier_phased_lua = class({
    IsHidden = function()
        return false
    end,
    IsPurgable = function()
        return false
    end,
    CheckState = function() 
        return 
        {
            [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        } 
    end
})