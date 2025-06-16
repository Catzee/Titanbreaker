modifier_cobra_poison = class({
	IsHidden = function() 
        return false 
    end,
	IsPurgable = function() 
        return true 
    end,
    IsDebuff = function()
		return false
	end,
	DeclareFunctions = function() 
        return 
        {
		    MODIFIER_EVENT_ON_ATTACK_LANDED
	    } 
    end,
    GetTextureName = function()
        return "venomancer_poison_nova"
    end
})

function modifier_cobra_poison:OnCreated()
    if(not IsServer()) then
        return
    end
    self.parent = self:GetParent()

    local parentOrigin = self.parent:GetAbsOrigin()

    local particle = ParticleManager:CreateParticle("particles/econ/items/venomancer/toxicant/veno_toxicant_tail_b.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
	ParticleManager:SetParticleControlEnt(particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_attack1", parentOrigin, true)
	ParticleManager:SetParticleControlEnt(particle, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_attack1", parentOrigin, true)
	ParticleManager:SetParticleControlEnt(particle, 2, self.parent, PATTACH_POINT_FOLLOW, "attach_attack1", parentOrigin, true)
	ParticleManager:SetParticleControlEnt(particle, 3, self.parent, PATTACH_POINT_FOLLOW, "attach_attack1", parentOrigin, true)
	ParticleManager:SetParticleControlEnt(particle, 4, self.parent, PATTACH_POINT_FOLLOW, "attach_attack1", parentOrigin, true)
    self:AddParticle(particle, false, false, 1, false, false)

    local particle = ParticleManager:CreateParticle("particles/econ/items/venomancer/toxicant/veno_toxicant_tail_b.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
	ParticleManager:SetParticleControlEnt(particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_attack2", parentOrigin, true)
	ParticleManager:SetParticleControlEnt(particle, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_attack2", parentOrigin, true)
	ParticleManager:SetParticleControlEnt(particle, 2, self.parent, PATTACH_POINT_FOLLOW, "attach_attack2", parentOrigin, true)
	ParticleManager:SetParticleControlEnt(particle, 3, self.parent, PATTACH_POINT_FOLLOW, "attach_attack2", parentOrigin, true)
	ParticleManager:SetParticleControlEnt(particle, 4, self.parent, PATTACH_POINT_FOLLOW, "attach_attack2", parentOrigin, true)
    self:AddParticle(particle, false, false, 1, false, false)
end

function modifier_cobra_poison:OnRefresh() 
    self.bonusAttackSpeed = self.ability:GetSpecialValueFor("as")
end

function modifier_cobra_poison:OnAttackLanded(kv)
    if(kv.attacker ~= self.parent) then
        return
    end

    DamageUnit({
        caster = caster,
        target = target,
        ability = self,
        damage = 0,
        spelldamagefactor = 0,
        attributefactor = 0,
        includeauto = 250,
        naturedmg = 1,
        poisondmg = 1
    })

    local particle = ParticleManager:CreateParticle("particles/items2_fx/orb_of_venom_b.vpcf", PATTACH_ABSORIGIN_FOLLOW, kv.target)
	ParticleManager:SetParticleControlEnt(particle, 0, kv.target, PATTACH_POINT_FOLLOW, "attach_hitloc", parentOrigin, true)
    ParticleManager:DestroyParticle(particle, false)
    ParticleManager:ReleaseParticleIndex(particle)
end