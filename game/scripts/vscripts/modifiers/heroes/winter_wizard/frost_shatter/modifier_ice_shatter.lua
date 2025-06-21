modifier_ice_shatter = class({
    IsHidden = function()
        return false
    end,
    IsPurgable = function()
        return true
    end,
    IsDebuff = function()
		return false
    end,
    GetTexture = function()
        return "crystal_maiden_crystal_nova"
    end
})