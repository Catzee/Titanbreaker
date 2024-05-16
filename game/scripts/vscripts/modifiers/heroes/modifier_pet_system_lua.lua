modifier_pet_system_lua = class({
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
            MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
            MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
            MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
            MODIFIER_EVENT_ON_ATTACK_LANDED
        }
    end,
    CheckState = function()
        return 
        {
            [MODIFIER_STATE_UNSELECTABLE] = true,
            [MODIFIER_STATE_NO_HEALTH_BAR] = true,
            [MODIFIER_STATE_INVULNERABLE] = true,
            [MODIFIER_STATE_ATTACK_IMMUNE] = true
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
    end
})

function modifier_pet_system_lua:OnCreated(kv)
    if(not IsServer()) then
        return
    end

    self.ability = self:GetAbility()
    self.parent = self:GetParent()
    self.owner = self.ability:GetCaster()

    PetSystem({
        caster = self.owner,
        target = self.parent,
        ability = self.ability,
        intsp = kv.damage
        setpetowner = 1
    })

    Timers:CreateTimer(kv.lifetime, function()
        KillSummon({
            target = self.parent
        })
    end)

    self:StartIntervalThink(5)
end

function modifier_pet_system_lua:OnIntervalThink()
    PetSystem({
        caster = self.owner,
        target = self.parent,
        ability = self.ability,
        intsp = kv.damage
    })
end

function modifier_pet_system_lua:OnAttackLanded(kv)
    if(kv.attacker ~= self.parent) then
        return
    end

    DamageUnit({
        caster = self.owner,
        target = self.parent,
        ability = self.ability,
        damage = self.parent:GetAttackDamage(),
        spelldamagefactor = 0.0,
        attributefactor = 0.0,
        fromsummon = 1
    })
end