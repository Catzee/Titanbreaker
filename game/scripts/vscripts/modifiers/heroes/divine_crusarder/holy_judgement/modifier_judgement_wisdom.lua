modifier_judgement_wisdom = class({
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
    GetTexture = function()
        return "wisp_spirits"
    end
})

function modifier_judgement_wisdom:OnCreated()
    self.parent = self:GetParent()
    self:OnRefresh()

    if(not IsServer()) then
        return
    end
    local parentOrigin = self.parent:GetAbsOrigin()

    local particleProc = ParticleManager:CreateParticle("particles/units/heroes/hero_keeper_of_the_light/keeper_of_the_light_mana_leak.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
	ParticleManager:SetParticleControlEnt(particleProc, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", parentOrigin, true)
    ParticleManager:SetParticleControlEnt(particleProc, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", parentOrigin, true)
    ParticleManager:DestroyParticle(particleProc, false)
	ParticleManager:ReleaseParticleIndex(particleProc)
end

function modifier_judgement_wisdom:OnRefresh()
    self.ability = self:GetAbility()
    self.bonusManaOnAttackLanded = self.ability:GetSpecialValueFor("aamana")
end

function modifier_judgement_wisdom:OnAttackLanded(kv)
    if(kv.attacker ~= self.parent) then
        return
    end
    
    RestoreMana({
		caster = self.parent,
		target = self.parent,
		ability = self.ability,
        amount = self.bonusManaOnAttackLanded
	})

    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_nyx_assassin/nyx_assassin_mana_burn_bloom.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
	ParticleManager:SetParticleControlEnt(particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
    ParticleManager:DestroyParticle(particle, false)
	ParticleManager:ReleaseParticleIndex(particle)

    self:Destroy()
end