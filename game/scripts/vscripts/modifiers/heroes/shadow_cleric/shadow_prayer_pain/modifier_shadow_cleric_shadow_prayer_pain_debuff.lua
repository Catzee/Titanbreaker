modifier_shadow_cleric_shadow_prayer_pain_debuff = class({
	IsHidden = function() 
        return false 
    end,
	IsPurgable = function() 
        return true 
    end,
    IsDebuff = function()
		return true
	end,
    GetAttributes = function()
        return MODIFIER_ATTRIBUTE_MULTIPLE
    end
})

function modifier_shadow_cleric_shadow_prayer_pain_debuff:OnCreated()
    if(not IsServer()) then
        return
    end

    self.ability = self:GetAbility()
    self.caster = self.ability:GetCaster()
    self.target = self:GetParent()
    
    self:DealDamageToOwner(false)
end

function modifier_shadow_cleric_shadow_prayer_pain_debuff:OnIntervalThink()
    self:DealDamageToOwner(true)
end

function modifier_shadow_cleric_shadow_prayer_pain_debuff:DealDamageToOwner(isDot)
    isDot = isDot and 1 or nil

    DamageUnit({
        caster = self.caster,
        target = self.target,
        ability = self.ability,
        damage = 0,
        spelldamagefactor = self.ability:GetSpecialValueFor("spelldmg"),
        attributefactor = self.ability:GetSpecialValueFor("dmgfromstat"),
        shadowdmg = 1,
        oncritswp = self.ability:GetSpecialValueFor("oncritswp"),
        isdot = isDot,
        ignore_when_target_has_reflect = 1,
        luacallback = 1
    })
end