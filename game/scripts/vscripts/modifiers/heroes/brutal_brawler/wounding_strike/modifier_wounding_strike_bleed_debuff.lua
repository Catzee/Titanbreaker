modifier_wounding_strike_bleed_debuff = class({
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
        return "bloodseeker_blood_bath"
    end
})

function modifier_wounding_strike_bleed_debuff:OnCreated()
    if(not IsServer()) then
        return
    end
    self.ability = self:GetAbility()

    self.damageTable = {
        caster = self.ability:GetCaster(),
        target = self:GetParent(),
        ability = self.ability,
        damage = 0,
        spelldamagefactor = 0,
        attributefactor = self.ability:GetSpecialValueFor("bleeddmg"),
        isdot = 1
    }

    self:StartIntervalThink(self.ability:GetSpecialValueFor("tick"))
end

function modifier_wounding_strike_bleed_debuff:OnIntervalThink()
    DamageUnit(self.damageTable)
end
