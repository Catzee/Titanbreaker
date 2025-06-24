modifier_shadowblend = class({
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
        return 
        {
    	    MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
    		MODIFIER_PROPERTY_EVASION_CONSTANT
        } 
    end,
    GetStatusEffectName = function()
    	return "particles/status_fx/status_effect_enigma_blackhole_tgt.vpcf"
    end,
    StatusEffectPriority = function()
    	return 20
    end
})

function modifier_shadowblend:OnCreated(kv)
    if(not IsServer()) then
        return
    end
    	
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    
    local parentOrigin = self.parent:GetAbsOrigin()
    
    local particle = ParticleManager:CreateParticle("particles/econ/courier/courier_faceless_rex/cour_rex_flying_a.vpcf", PATTACH_CUSTOMORIGIN, nil)
    ParticleManager:SetParticleControlEnt(particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", parentOrigin, true)
    self:AddParticle(particle, false, false, 1, false, false)
    
    particle = ParticleManager:CreateParticle("particles/units/heroes/hero_shadow_demon/shadow_demon_disruption_center.vpcf", PATTACH_CUSTOMORIGIN, nil)
    ParticleManager:SetParticleControlEnt(particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", parentOrigin, true)
    self:AddParticle(particle, false, false, 1, false, false)
    
    if(self.ability:GetSpecialValueFor("chance") < 100) then
    	return
    end
    
    particle = ParticleManager:CreateParticle("particles/econ/events/ti9/mjollnir_shield_ti9.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
    ParticleManager:SetParticleControlEnt(particle, 0, self.parent, PATTACH_CENTER_FOLLOW, "attach_hitloc", parentOrigin, true)
    self:AddParticle(particle, false, false, 1, false, false)
    
    self:StartIntervalThink(0.5)
end

function modifier_shadowblend:OnIntervalThink()
    local enemies = FindNearbyEnemies(self.parent, self.parent:GetAbsOrigin(), 200)
    
    for _, enemy in pairs(enemies) do
        PerformAutoAttack({
            caster = self.parent,
            target = enemy,
            ability = self.ability,
            showFX = 1
        })	
    end					
end

function modifier_shadowblend:GetModifierMagicalResistanceBonus()
    if(self:GetStackCount() == 1) then
    	return 90
    end
    return 0
end

function modifier_shadowblend:GetModifierEvasion_Constant()
    if(self:GetStackCount() == 1) then
    	return 90
    end
    return 0			
end