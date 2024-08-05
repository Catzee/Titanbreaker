modifier_wounding_strike_heal_debuff = class({
    IsHidden = function()
        return false
    end,
    IsPurgable = function()
        return true
    end,
	IsDebuff = function()
		return true
	end,
    GetTexture = function()
        return "fix/axe_strike2"
    end,
    GetEffectName = function()
        return "particles/units/heroes/hero_bloodseeker/bloodseeker_rupture.vpcf"
    end,
    GetStatusEffectName = function()
        return "particles/status_fx/status_effect_rupture.vpcf"
    end,
    StatusEffectPriority = function()
        return MODIFIER_PRIORITY_HIGH
    end
})