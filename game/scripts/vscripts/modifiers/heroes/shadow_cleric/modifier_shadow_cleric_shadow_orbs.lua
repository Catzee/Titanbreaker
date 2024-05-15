modifier_shadow_cleric_shadow_orbs = class({
	IsHidden = function() 
        return false 
    end,
	IsPurgable = function() 
        return false 
    end,
    IsDebuff = function()
		return false
	end,
    GetAttributes = function()
        return MODIFIER_ATTRIBUTE_PERMANENT
    end,
    RemoveOnDeath = function()
        return false
    end,
    GetTexture = function()
        return "enigma_midnight_pulse"
    end
})

function modifier_shadow_cleric_shadow_orbs:OnCreated()
    if(not IsServer()) then
        return
    end

    self.parent = self:GetParent()
    self:StartIntervalThink(0.5)
end

function modifier_shadow_cleric_shadow_orbs:OnIntervalThink()
    if(self:GetStackCount() < 3) then
        return
    end
    local particle = ParticleManager:CreateParticle("particles/items3_fx/glimmer_cape_initial_flash_ember.vpcf", PATTACH_POINT_FOLLOW, self.parent)
    ParticleManager:ReleaseParticleIndex(particle)
end