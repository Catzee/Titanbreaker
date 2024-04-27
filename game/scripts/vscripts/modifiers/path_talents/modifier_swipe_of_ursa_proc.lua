modifier_swipe_of_ursa_proc = class({
    IsHidden = function()
        return false
    end,
    IsPurgable = function()
        return false
    end,
	IsDebuff = function()
		return false
	end,
    GetTexture = function()
        return "ursa_enrage"
    end
})

function modifier_swipe_of_ursa_proc:OnCreated()
    if(not IsServer()) then
        return
    end

    self.parent = self:GetParent()

    local parentOrigin = self.parent:GetAbsOrigin()

    local particle = ParticleManager:CreateParticle(
        "particles/econ/items/pangolier/pangolier_ti8_immortal/pangolier_ti8_immortal_shield_buff_parent.vpcf", 
        PATTACH_ABSORIGIN_FOLLOW, 
        self.parent)
    ParticleManager:SetParticleControlEnt(particle, 0, self.parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", parentOrigin, true)
    ParticleManager:SetParticleControlEnt(particle, 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", parentOrigin, true)
    ParticleManager:SetParticleControl(particle, 3, Vector(50, 0, 0))
    ParticleManager:SetParticleControl(particle, 5, Vector(0, 0, 0))
    ParticleManager:SetParticleControl(particle, 8, Vector(50, 0, 0))
    
    self:AddParticle(particle, false, false, 1, false, false)
end