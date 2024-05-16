modifier_shadow_cleric_nightmare_aura_buff = class({
	IsHidden = function() 
        return true 
    end,
	IsPurgable = function() 
        return false 
    end,
    IsDebuff = function()
		return false
	end,
    DeclareFunctions = function()
        return
        {
            MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
        }
    end
})

function modifier_shadow_cleric_nightmare_aura_buff:OnCreated()
    self.ability = self:GetAbility()

    -- Fix for auras sometimes apply broken buff/debuff
    if(self.ability == nil) then
        self:Destroy()
        return
    end

    self:OnRefresh()

    if(not IsServer()) then
        return
    end

    self.auraOwner = self.ability:GetCaster()
    self:OnIntervalThink()
    self:StartIntervalThink(1)
end

function modifier_shadow_cleric_nightmare_aura_buff:OnIntervalThink()
    self:SetStackCount(self.auraOwner:GetModifierStackCount("modifier_shadow_cleric_nightmare_aura", nil))
end

function modifier_shadow_cleric_nightmare_aura_buff:OnRefresh() 
    self.bonusAttackSpeed = self.ability:GetSpecialValueFor("attack_speed_aura")
end

function modifier_shadow_cleric_nightmare_aura_buff:GetModifierAttackSpeedBonus_Constant() 
    return self.bonusAttackSpeed * self:GetStackCount()
end
