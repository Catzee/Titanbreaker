modifier_shadow_cleric_dream_feast_tentacle_debuff = class({
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

function modifier_shadow_cleric_dream_feast_tentacle_debuff:OnCreated()
    if(not IsServer()) then
        return
    end
    
end

function modifier_shadow_cleric_dream_feast_tentacle_debuff:OnCreated()
    self.ability = self:GetAbility()

    -- Fix for auras sometimes apply broken buff/debuff
    if(self.ability == nil) then
        self:Destroy()
        return
    end

    self:OnRefresh()
end

function modifier_shadow_cleric_dream_feast_tentacle_debuff:OnRefresh() 
    self.bonusAttackSpeed = self.ability:GetSpecialValueFor("as")
end