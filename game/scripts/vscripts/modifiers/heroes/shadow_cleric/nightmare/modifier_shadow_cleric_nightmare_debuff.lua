modifier_shadow_cleric_nightmare_debuff = class({
	IsHidden = function() 
        return false 
    end,
	IsPurgable = function() 
        return false 
    end,
    IsDebuff = function()
		return true
	end,
	DeclareFunctions = function() 
        return 
        {
            MODIFIER_PROPERTY_OVERRIDE_ANIMATION
	    } 
    end,
    CheckState = function()
        return {
            [MODIFIER_STATE_STUNNED] = true
        }
    end,
    GetOverrideAnimation = function()
        return ACT_DOTA_FLAIL
    end,
    GetEffectName = function()
        return "particles/silencer_curse_purple.vpcf"
    end,
    GetEffectAttachType = function()
        return PATTACH_OVERHEAD_FOLLOW
    end
})

function modifier_shadow_cleric_nightmare_debuff:OnCreated()
    if(not IsServer()) then
        return
    end

    self.parent = self:GetParent()
    self.ability = self:GetAbility()

    self:OnIntervalThink()
    self:StartIntervalThink(self.ability:GetSpecialValueFor("fear_tickrate"))
end

function modifier_shadow_cleric_nightmare_debuff:OnIntervalThink()
    local particle = ParticleManager:CreateParticle("particles/econ/items/nightstalker/nightstalker_black_nihility/nightstalker_black_nihility_void_hit_ring.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
    ParticleManager:SetParticleControlEnt(particle, 0, self.parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
    ParticleManager:ReleaseParticleIndex(particle)

    KnockBack({
        caster = self.parent,
        target = self.parent,
        ability = self.ability,
        fixedforce = self.ability:GetSpecialValueFor("fear_force"),
        random = 1
    })
end

function modifier_shadow_cleric_nightmare_debuff:OnDestroy()
    if(not IsServer()) then
        return
    end
    local particle = ParticleManager:CreateParticle("particles/econ/items/nightstalker/nightstalker_black_nihility/nightstalker_black_nihility_void_hit_ray.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
    ParticleManager:SetParticleControlEnt(particle, 0, self.parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
    ParticleManager:ReleaseParticleIndex(particle)
end