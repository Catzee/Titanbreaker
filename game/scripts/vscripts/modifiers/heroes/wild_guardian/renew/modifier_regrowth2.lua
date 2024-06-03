modifier_regrowth2 = class({
    IsHidden = function()
        return false
    end,
    IsPurgable = function()
        return true
    end,
	IsDebuff = function()
		return false
	end,
    DeclareFunctions = function()
        return 
        {
            MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
        }
    end,
    GetModifierPhysicalArmorBonus = function(self)
        return self.bonusArmor
    end,
    GetTexture = function()
        return "furion_wrath_of_nature"
    end,
    GetEffectName = function()
        return "particles/units/heroes/hero_oracle/oracle_purifyingflames_heal.vpcf"
    end,
    GetEffectAttachType = function()
        return PATTACH_ABSORIGIN_FOLLOW
    end
})

function modifier_regrowth2:OnCreated()
    self:OnRefresh()

    if(not IsServer()) then
        return
    end

    self.parent = self:GetParent()

    self:StartIntervalThink(self.ability:GetSpecialValueFor("tick_interval"))
end

function modifier_regrowth2:OnRefresh()
    self.ability = self:GetAbility()
    self.bonusArmor = self.ability:GetSpecialValueFor("bonus_armor")
    self.spelldmgtick = self.ability:GetSpecialValueFor("spelldmgtick")
    self.dmgfromstathot = self.ability:GetSpecialValueFor("dmgfromstathot")
    self.critchancefactor = (self.ability:GetSpecialValueFor("bonus_crit_chance_pct") / 100) + 1
    if(not IsServer()) then
        return
    end

    self.caster = self:GetCaster()
end

function modifier_regrowth2:OnIntervalThink()
    HealUnit({
        caster = self.caster,
        target = self.parent,
        ability = self.ability,
        heal = 0,
        spelldamagefactor = self.spelldmgtick,
        attributefactor = self.dmgfromstathot,
        attributechangeall = 1,
        critchancefactor = self.critchancefactor,
        isdot = 1
    })
end