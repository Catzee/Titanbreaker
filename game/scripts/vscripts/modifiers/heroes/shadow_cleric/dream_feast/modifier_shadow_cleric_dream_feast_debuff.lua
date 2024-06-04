modifier_shadow_cleric_dream_feast_debuff = class({
	IsHidden = function() 
        return false 
    end,
	IsPurgable = function() 
        return false 
    end,
    IsDebuff = function()
		return true
	end,
    GetAttributes = function()
        return MODIFIER_ATTRIBUTE_MULTIPLE
    end
})

function modifier_shadow_cleric_dream_feast_debuff:OnCreated()
    if(not IsServer()) then
        return
    end
    self.ability = self:GetAbility()
    self.caster = self.ability:GetCaster()
    self.target = self:GetParent()
    
    local shadowSpheres = GetShadowClericShadowSpheres(self.caster)
    if(TryConsumeShadowClericShadowSpheres(self.caster, shadowSpheres)) then
        self:SetStackCount(shadowSpheres)
    end
end

function modifier_shadow_cleric_dream_feast_debuff:OnIntervalThink()
    DamageUnit({
        caster = self.caster,
        target = self.target,
        ability = self.ability,
        damage = 0,
        spelldamagefactor = self.ability:GetSpecialValueFor("spelldmg"),
        attributefactor = self.ability:GetSpecialValueFor("dmgfromstat"),
        shadowdmg = 1,
        shadoworb = self:GetStackCount(),
        isdot = 1,
        spellcastfrenzy = self.ability:GetSpecialValueFor("frenzy"),
        spellcastfrenzy_max = self.ability:GetSpecialValueFor("frenzy_max")
    })
end