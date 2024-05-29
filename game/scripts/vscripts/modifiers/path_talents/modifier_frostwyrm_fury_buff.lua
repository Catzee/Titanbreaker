modifier_frostwyrm_fury_buff = class({
    IsHidden = function()
        return false
    end,
    IsPurgable = function()
        return false
    end,
    IsDebuff = function()
        return false
    end,
    GetTexture = function()
        return "fix/104"
    end
})