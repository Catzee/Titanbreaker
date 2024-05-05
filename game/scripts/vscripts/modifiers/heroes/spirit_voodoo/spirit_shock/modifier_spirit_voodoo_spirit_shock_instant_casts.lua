modifier_spirit_voodoo_spirit_shock_instant_casts = class({
    IsHidden = function()
        return false
    end,
    IsPurgable = function()
        return false
    end,
	IsDebuff = function()
		return false
	end
})