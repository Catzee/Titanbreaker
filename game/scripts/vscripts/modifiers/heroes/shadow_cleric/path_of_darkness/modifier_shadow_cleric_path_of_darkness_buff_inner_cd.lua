modifier_shadow_cleric_path_of_darkness_buff_inner_cd = class({
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