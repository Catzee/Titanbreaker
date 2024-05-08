modifier_spirit_voodoo_spirit_shock_debuff = class({
    IsHidden = function()
        return false
    end,
    IsPurgable = function()
        return true
    end,
	IsDebuff = function()
		return true
	end,
    DeclareFunctions = function()
        return 
        {
            MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
            MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
        }
    end,
    GetModifierMoveSpeedBonus_Percentage = function(self)
        return self.bonusMovementSpeed
    end,
    GetModifierAttackSpeedBonus_Constant = function(self)
        return self.bonusAttackSpeed
    end
})

function modifier_spirit_voodoo_spirit_shock_debuff:OnCreated()
    self:OnRefresh()

    if(not IsServer()) then
        return
    end
    self.parent = self:GetParent()
    
    local particle = ParticleManager:CreateParticle("particles/items_fx/diffusal_slow.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
    ParticleManager:SetParticleControlEnt(particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
    self:AddParticle(particle, false, false, 1, false, false)
end

function modifier_spirit_voodoo_spirit_shock_debuff:OnRefresh()
    self.ability = self:GetAbility()
    self.bonusMovementSpeed = self.ability:GetSpecialValueFor("bonus_movespeed")
    self.bonusAttackSpeed = self.ability:GetSpecialValueFor("bonus_attackspeed")
end