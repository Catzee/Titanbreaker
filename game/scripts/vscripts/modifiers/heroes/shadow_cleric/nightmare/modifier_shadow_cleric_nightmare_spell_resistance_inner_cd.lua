modifier_shadow_cleric_nightmare_spell_resistance_inner_cd = class({
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
        return "fix/shadow2"
    end
})