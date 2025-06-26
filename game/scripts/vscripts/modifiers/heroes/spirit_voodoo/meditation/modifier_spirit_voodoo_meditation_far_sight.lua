modifier_spirit_voodoo_meditation_far_sight = class({
    IsHidden = function()
        return true
    end,
    IsPurgable = function()
        return false
    end,
    IsPurgeException = function()
    	return false
    end,
    IsDebuff = function()
    	return false
    end,
    DeclareFunctions = function()
        return 
        {
            MODIFIER_PROPERTY_BONUS_DAY_VISION,
            MODIFIER_PROPERTY_BONUS_NIGHT_VISION,
            MODIFIER_EVENT_ON_ORDER 
        }
    end,
    GetBonusDayVision = function(self)
    	return self.bonusVisionRange
    end,
    GetBonusNightVision = function(self)
    	return self.bonusVisionRange
    end,
    GetAttributes = function()
        return MODIFIER_ATTRIBUTE_PERMANENT
    end,
    RemoveOnDeath = function()
        return false
    end
})

function modifier_spirit_voodoo_meditation_far_sight:OnCreated()
    self:OnRefresh()
    
    if(not IsServer()) then
    	return
    end
    
    self.parent = self:GetParent()
end

function modifier_spirit_voodoo_meditation_far_sight:OnRefresh()
    self.ability = self:GetAbility()
    self.bonusVisionRange = self.ability:GetSpecialValueFor("vision")
end

function modifier_spirit_voodoo_meditation_far_sight:CheckState()
    if(self:GetStackCount() == 0) then
    	return
    end
    
    return 
    {
        [MODIFIER_STATE_FORCED_FLYING_VISION] = true
    }
end

function modifier_spirit_voodoo_meditation_far_sight:OnOrder(kv)
    if(kv.unit ~= self.parent) then
        return
    end
    
    if(kv.order_type ~= DOTA_UNIT_ORDER_TRAIN_ABILITY) then
    	return
    end
    
    if(kv.ability ~= self.ability) then
    	return
    end
    
    -- Called before SetLevel() in valve code... so desiredLevel - 1
    if(self.ability:GetLevel() >= 4) then
    	self:SetStackCount(1)
    end
end