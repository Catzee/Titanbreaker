modifer_peaceful_guardian_cyclone_debuff = class({
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
		    MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
            MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
            MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
            MODIFIER_PROPERTY_OVERRIDE_ANIMATION
	    } 
    end,
    CheckState = function()
        return {
            [MODIFIER_STATE_STUNNED] = true
        }
    end,
    GetAbsoluteNoDamagePhysical = function()
        return 1
    end,
    GetAbsoluteNoDamageMagical = function()
        return 1
    end,
    GetAbsoluteNoDamagePure = function()
        return 1
    end,
    GetOverrideAnimation = function()
        return ACT_DOTA_FLAIL
    end
})

function modifer_peaceful_guardian_cyclone_debuff:OnCreated()
    self.parent = self:GetParent()
    self:OnRefresh()

    if(not IsServer()) then
        return
    end

    local parentOrigin = self.parent:GetAbsOrigin()

    local particleProc = ParticleManager:CreateParticle("particles/cyclone_self1.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
	ParticleManager:SetParticleControlEnt(particleProc, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", parentOrigin, true)

    self:AddParticle(particleProc, false, false, 1, false, false)

    self:StartIntervalThink(self.ability:GetSpecialValueFor("healtickrate"))
end

function modifer_peaceful_guardian_cyclone_debuff:OnRefresh()
    if(not IsServer()) then
        return
    end
    self.ability = self:GetAbility()
    self.caster = self.ability:GetCaster()
    self.healingMaxHpMpPct = self.ability:GetSpecialValueFor("bonus_stat3")
end

function modifer_peaceful_guardian_cyclone_debuff:OnIntervalThink()
    RestoreManaIfFriend({
		caster = self.caster,
		target = self.parent,
		ability = self.ability,
        amount = self.healingMaxHpMpPct,
        percent = self.healingMaxHpMpPct
    })
    HealUnitIfFriend({
		caster = self.caster,
		target = self.parent,
		ability = self.ability,
        heal = 0.0,
        percenthp = self.healingMaxHpMpPct,
        isdot = 1,
        healthroughcyclone = 1
    })
end