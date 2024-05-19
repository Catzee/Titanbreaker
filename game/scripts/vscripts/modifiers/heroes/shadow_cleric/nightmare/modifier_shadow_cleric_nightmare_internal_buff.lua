modifier_shadow_cleric_nightmare_internal_buff = class({
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
            MODIFIER_EVENT_ON_TAKEDAMAGE
        }
    end
})

function modifier_shadow_cleric_nightmare_internal_buff:OnCreated()
    if(not IsServer()) then
        return
    end

    self.parent = self:GetParent()
    self.ability = self:GetAbility()
end

function modifier_shadow_cleric_nightmare_internal_buff:OnTakeDamage(kv)
    if(kv.attacker ~= self.parent) then
        return
    end
    
    if(self.ability.OnShadowClericDamageDone) then
        self.ability:OnShadowClericDamageDone(kv.unit)
    end
end