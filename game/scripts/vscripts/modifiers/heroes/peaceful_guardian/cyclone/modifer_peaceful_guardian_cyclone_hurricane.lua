modifer_peaceful_guardian_cyclone_hurricane = class({
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

function modifer_peaceful_guardian_cyclone_hurricane:OnCreated()
    self:OnRefresh()

    if(not IsServer()) then
        return
    end

    self.parent = self:GetParent()
    self:StartIntervalThink(self.ability:GetSpecialValueFor("hurricane_tickrate"))

    local particle = ParticleManager:CreateParticle("particles/econ/items/razor/razor_arcana/razor_arcana_cyclone_core_cloudy.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
    self:AddParticle(particle, false, false, 1, false, false)
end

function modifer_peaceful_guardian_cyclone_hurricane:OnRefresh() 
    self.ability = self:GetAbility()
    self.attackRadius = self.ability:GetSpecialValueFor("hurricane_radius")
    self.maxStacks = self.ability:GetSpecialValueFor("hurricane_debuff_max_stacks")
    self.debuffDuration = self.ability:GetSpecialValueFor("hurricane_debuff_duration")
    self.statsToDmg = self.ability:GetSpecialValueFor("hurricane_stat_to_dmg")
    self.spToDmg = self.ability:GetSpecialValueFor("hurricane_sp_to_dmg")
end

function modifer_peaceful_guardian_cyclone_hurricane:OnIntervalThink() 
    local enemy = FindClosestEnemy({caster = self.parent, radius = self.attackRadius})

    if(enemy == nil) then
        return
    end
    
    local enemyOrigin = enemy:GetAbsOrigin()

    ApplyBuffStack({caster = self.parent, target = enemy, dur = self.debuffDuration, buff = "modifer_peaceful_guardian_cyclone_hurricane_debuff", ability = self.ability, max = self.maxStacks})
    DamageUnit({caster = self.parent, target = enemy, ability = self.ability, damage = 0, attributefactor = self.statsToDmg, spelldamagefactor = self.spToDmg, naturedmg = 1})
    local particle = ParticleManager:CreateParticle("particles/econ/items/razor/razor_arcana/razor_arcana_strike_top_lightning_strike.vpcf", PATTACH_POINT_FOLLOW, enemy)
    ParticleManager:SetParticleControl(particle, 0, enemyOrigin)
    ParticleManager:SetParticleControl(particle, 1, enemyOrigin)
    ParticleManager:ReleaseParticleIndex(particle)
    EmitSoundOn("DOTA_Item.Mjollnir.Activate", enemy)
end