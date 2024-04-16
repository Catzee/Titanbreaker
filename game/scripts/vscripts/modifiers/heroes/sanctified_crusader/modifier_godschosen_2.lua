modifier_godschosen_2 = class({
    IsHidden = function()
        return false
    end,
    IsPurgable = function()
        return false
    end,
	IsDebuff = function()
		return false
	end,
    DeclareFunctions = function()
        return 
        {
            MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
        }
    end
})

function modifier_godschosen_2:OnCreated()
    self.ability = self:GetAbility()
    self:OnRefresh()

    if(not IsServer()) then
        return
    end

    self.parent = self:GetParent()

    local parentOrigin = self.parent:GetAbsOrigin()

    local particle = ParticleManager:CreateParticle(
        "particles/econ/items/phantom_lancer/phantom_lancer_immortal_ti6/phantom_lancer_immortal_ti6_spiritlance_target.vpcf", 
        PATTACH_ABSORIGIN_FOLLOW, 
        self.parent)
    ParticleManager:SetParticleControlEnt(particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", parentOrigin, true)
    ParticleManager:SetParticleControlEnt(particle, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", parentOrigin, true)
    self:AddParticle(particle, false, false, 1, false, false)

    local particle = ParticleManager:CreateParticle("particles/units/unit_greevil/loot_greevil_tgt_end_sparks.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
    ParticleManager:SetParticleControlEnt(particle, 3, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", parentOrigin, true)
    self:AddParticle(particle, false, false, 1, false, false)

    local particle = ParticleManager:CreateParticle("particles/sacred_shield.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
    ParticleManager:SetParticleControlEnt(particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", parentOrigin, true)
    self:AddParticle(particle, false, false, 1, false, false)
end

function modifier_godschosen_2:OnRefresh()
    self.healingPct = self.ability:GetSpecialValueFor("heal") / 100
    self.finalDmgPct = self.ability:GetSpecialValueFor("retaliation") / 100
    self.damageRadius = self.ability:GetSpecialValueFor("radius")
end

function modifier_godschosen_2:GetModifierIncomingDamage_Percentage(kv)
    HealUnit({
        caster = self.parent, 
        target = self.parent, 
        heal = kv.damage * self.healingPct
    })

    self:SetStackCount(self:GetStackCount() + kv.damage)
    -- Preserve old mechanic (heal after dmg) because you can die with 75% of damage taken as healing
    if(self.healingPct < 1) then
        return
    end
    -- Prevent death
    return -99999999
end

function modifier_godschosen_2:OnDestroy()
    if(not IsServer()) then
        return
    end

    local parentOrigin = self.parent:GetAbsOrigin()

    local particle = ParticleManager:CreateParticle(
        "particles/econ/items/centaur/centaur_ti6_gold/centaur_ti6_warstomp_gold.vpcf", 
        PATTACH_ABSORIGIN, 
        self.parent)
    ParticleManager:SetParticleControl(particle, 1, Vector(self.damageRadius, 0, 0))
    ParticleManager:DestroyParticle(particle, false)
    ParticleManager:ReleaseParticleIndex(particle)

    EmitSoundOn("Hero_LegionCommander.Overwhelming.Hero", self.parent)

    local enemies = FindUnitsInRadius(
		self.parent:GetTeam(), 
		parentOrigin, 
		nil, 
		self.damageRadius, 
		DOTA_UNIT_TARGET_TEAM_ENEMY, 
		DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, 
		DOTA_UNIT_TARGET_FLAG_NONE, 
		FIND_ANY_ORDER, 
		false
	)

    local finalDamage = math.min(self:GetStackCount() * self.finalDmgPct, self.parent:GetMaxHealth())

    for _, enemy in pairs(enemies) do
        local particle = ParticleManager:CreateParticle(
            "particles/econ/items/centaur/centaur_ti6_gold/centaur_ti6_warstomp_gold.vpcf", 
            PATTACH_ABSORIGIN, 
            enemy)
        ParticleManager:SetParticleControlEnt(particle, 0, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", enemy:GetAbsOrigin(), true)
        ParticleManager:DestroyParticle(particle, false)
        ParticleManager:ReleaseParticleIndex(particle)
        -- We could cache event data and only change victim, but something in DamageUnit might modify event data...
        DamageUnit({
            caster = self.parent,
            target = enemy,
            ability = self.ability,
            damage = finalDamage,
            spelldamagefactor = 0.0,
            attributefactor = 0.0,
            holydmg = 1
        })
	end
end