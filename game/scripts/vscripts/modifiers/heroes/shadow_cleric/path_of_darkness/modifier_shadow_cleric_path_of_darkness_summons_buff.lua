modifier_shadow_cleric_path_of_darkness_buff = class({
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

function modifier_shadow_cleric_path_of_darkness_buff:OnCreated()
    if(not IsServer()) then
        return
    end
    
    self:OnRefresh()

    self.ability = self:GetAbility()
    self.caster = self.ability:GetCaster()
    self:OnIntervalThink()
    self:StartIntervalThink(self.ability:GetSpecialValueFor("shadow_worms_tickrate"))
end

function modifier_shadow_cleric_path_of_darkness_buff:OnRefresh()
    if(not IsServer()) then
        return
    end

    self.attackRange = self.ability:GetSpecialValueFor("shadow_worms_radius")
end

function modifier_shadow_cleric_path_of_darkness_buff:OnIntervalThink()
    local target = FindClosestEnemy({caster = self.caster, radius = self.attackRange})

    if(not target) then
        return
    end

    ProjectileManager:CreateTrackingProjectile({
        Target = target,
        Source = self.caster,
        Ability = self.ability,
        EffectName = "particles/units/heroes/hero_bane/bane_projectile.vpcf",
        bDodgeable = true,
        bProvidesVision = true,
        iMoveSpeed = 700,
        iVisionRadius = 300,
        iVisionTeamNumber = self.caster:GetTeamNumber(),
        iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_HITLOCATION
    })
end