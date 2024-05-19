modifier_shadow_cleric_nightmare_aura_inner_cd = class({
	IsHidden = function() 
        return false 
    end,
	IsPurgable = function() 
        return false 
    end,
    IsDebuff = function()
		return true
	end
})