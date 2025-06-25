modifier_sacred_shield = class({
    IsHidden = function()
        return false
    end,
    IsPurgable = function()
        return false
    end,
    IsPurgeException = function()
    	return false
    end,
    IsDebuff = function()
    	return false
    end,
    DeclareFunctions = function()
        return {
            MODIFIER_EVENT_ON_TAKEDAMAGE,
            MODIFIER_PROPERTY_TOOLTIP
        }
    end
})

function modifier_sacred_shield:OnCreated()
    self:OnRefresh()
    
    if(not IsServer()) then
    	return
    end
	
    local particle = ParticleManager:CreateParticle("particles/sacred_shield2.vpcf", PATTACH_ABSORIGIN_FOLLOW , self.parent)
    self:AddParticle(particle, false, false, 1, false, false)
end

function modifier_sacred_shield:OnRefresh()
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self.caster = self.ability:GetCaster()
end

function modifier_sacred_shield:OnTooltip()
    return self:GetStackCount()
end

function modifier_sacred_shield:OnTakeDamage(kv)
    if(kv.unit ~= self.parent) then
        return
    end
	
    SacredShieldAbsorb({
    	DamageTaken = kv.damage,
    	unit = kv.unit,
    	ability = self.ability,
    	caster = self.caster,
    	darkboltchance = self.ability:GetSpecialValueFor("darkboltchance")
    })
end