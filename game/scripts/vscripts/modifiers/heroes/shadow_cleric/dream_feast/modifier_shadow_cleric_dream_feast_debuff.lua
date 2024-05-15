modifier_shadow_cleric_dream_feast_debuff = class({
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

function modifier_shadow_cleric_dream_feast_debuff:OnCreated()
    if(not IsServer()) then
        return
    end
    self.ability = self:GetAbility()
    self.caster = self.ability:GetCaster()
    self.target = self:GetParent()
    
    self:StartIntervalThink(self.ability:GetSpecialValueFor("tick_interval"))
end

function modifier_shadow_cleric_dream_feast_debuff:OnIntervalThink()
    self:DealDamageToOwner()
end

function modifier_shadow_cleric_dream_feast_debuff:DealDamageToOwner()
    isDot = isDot and 1 or nil

    DamageUnit({
        caster = self.caster,
        target = self.target,
        ability = self.ability,
        damage = 0,
        spelldamagefactor = self.ability:GetSpecialValueFor("spelldmg"),
        attributefactor = self.ability:GetSpecialValueFor("dmgfromstat"),
        shadowdmg = 1,
        shadoworb = 1,
        isdot = 1,
        spellcastfrenzy = self.ability:GetSpecialValueFor("frenzy"),
        spellcastfrenzy_max = self.ability:GetSpecialValueFor("frenzy_max")
    })
end