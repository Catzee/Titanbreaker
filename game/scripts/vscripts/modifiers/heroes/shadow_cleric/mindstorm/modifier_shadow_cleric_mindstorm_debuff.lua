modifier_shadow_cleric_mindstorm_debuff = class({
	IsHidden = function() 
        return false 
    end,
	IsPurgable = function() 
        return false 
    end,
    IsDebuff = function()
		return false
	end,
    DeclareFunctions = function()
        return {
            MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
        }
    end,
    GetModifierMoveSpeedBonus_Percentage = function(self)
        return self.bonusMovementSpeed
    end
})

function modifier_shadow_cleric_mindstorm_debuff:OnCreated()
    self:OnRefresh()

    if(not IsServer()) then
        return
    end
    self.parent = self:GetParent()

    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_night_stalker/nightstalker_change_ash.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
    ParticleManager:SetParticleControlEnt(particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
    self:AddParticle(particle, false, false, 1, false, false)
end

function modifier_shadow_cleric_mindstorm_debuff:OnRefresh()
    self.bonusMovementSpeed = self:GetAbility():GetSpecialValueFor("slow")
end