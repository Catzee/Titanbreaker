modifier_shadow_cleric_path_of_darkness_internal_buff = class({
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

function modifier_shadow_cleric_path_of_darkness_internal_buff:OnCreated()
    if(not IsServer()) then
        return
    end

    self.parent = self:GetParent()
    self.ability = self:GetAbility()
end

function modifier_shadow_cleric_path_of_darkness_internal_buff:OnTakeDamage(kv)
    if(kv.unit ~= self.parent) then
        return
    end
    
    if(self.ability.OnShadowClericDamageTaken) then
        self.ability:OnShadowClericDamageTaken(self.parent)
    end
end