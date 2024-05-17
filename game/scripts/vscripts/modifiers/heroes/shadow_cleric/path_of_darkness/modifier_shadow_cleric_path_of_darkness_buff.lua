modifier_shadow_cleric_path_of_darkness_buff = class({
	IsHidden = function() 
        return false 
    end,
	IsPurgable = function() 
        return false 
    end,
    IsDebuff = function()
		return false
	end,
    GetEffectName = function()
        return "particles/econ/items/silencer/silencer_ti6/silencer_last_word_status_ti6.vpcf"
    end,
    GetEffectAttachType = function()
        return PATTACH_ABSORIGIN_FOLLOW
    end
})