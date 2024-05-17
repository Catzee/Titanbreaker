modifier_shadow_cleric_path_of_darkness_mana_shield_buff = class({
	IsHidden = function() 
        return false 
    end,
	IsPurgable = function() 
        return false 
    end,
    IsDebuff = function()
		return false
	end
})

function modifier_shadow_cleric_path_of_darkness_mana_shield_buff:OnCreated()
    if(not IsServer()) then
        return
    end

    self.parent = self:GetParent()

    local particle = ParticleManager:CreateParticle("particles/shadow_cleric_mana_shield.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
    ParticleManager:SetParticleControlEnt(particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
    self:AddParticle(particle, false, false, 1, false, false)
end