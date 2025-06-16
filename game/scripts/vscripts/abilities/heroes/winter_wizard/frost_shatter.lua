Frost_Shatter = class({})

function Frost_Shatter:Precache(context)
    PrecacheResource("particle", "particles/items2_fx/skadi_projectile.vpcf", context)
    PrecacheResource("particle", "particles/econ/items/crystal_maiden/crystal_maiden_cowl_of_ice/maiden_crystal_nova_e_cowlofice.vpcf", context)
end

function Frost_Shatter:OnProjectileHitHandle(target, location, projectileId)
    if(not target) then
        return true
    end

    local icelancestacks = 0
    if(self._projectiles[projectileId] == true) then
        icelancestacks = 2
    end

    DamageUnit({
        caster = self:GetCaster(),
        target = target,
        ability = self,
        damage = 0,
        spelldamagefactor = self:GetSpecialValueFor("spelldmg"),
        attributefactor = self:GetSpecialValueFor("dmgfromstat"),
        frostdmg = 1,
        critchancefactor = self:GetSpecialValueFor("critchancefactor"),
        spellcastfrenzy = self:GetSpecialValueFor("frenzy"),
        spellcastfrenzy_max = 1,
        icelance = 1,
        icelancestacks = icelancestacks
    })

    self._projectiles[projectileId] = nil
    
    EmitSoundOn("hero_Crystal.projectileImpact", target)

    return true
end

function Frost_Shatter:OnMulticastProc(caster, target, duration)
    local particle = ParticleManager:CreateParticle("particles/econ/items/crystal_maiden/crystal_maiden_cowl_of_ice/maiden_crystal_nova_e_cowlofice.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
    ParticleManager:DestroyParticle(particle, false)
    ParticleManager:ReleaseParticleIndex(particle)

    local currentDuration = 0

    Timers:CreateTimer(0, function()
        if(caster and caster:IsNull() == false and caster:IsAlive() and target and target:IsNull() == false and target:IsAlive()) then
            self:OnSpellStart(target, true)
            currentDuration = currentDuration + 0.3
            if(currentDuration < duration) then
                return 0.3
            end
        end
    end)
end

function Frost_Shatter:OnSpellStart(customTarget, isMulticast)
    local caster = self:GetCaster()
    local target = customTarget or self:GetCursorTarget()

    EmitSoundOn("hero_Crystal.preAttack", caster)

    if(isMulticast == nil) then
        MulticastItem({
            caster = caster,
            target = target,
            ability = self
        })
    end

    local projectileId = ProjectileManager:CreateTrackingProjectile({
        Target = target,
        Source = caster,
        Ability = self,
        EffectName = "particles/items2_fx/skadi_projectile.vpcf",
        bDodgeable = true,
        bProvidesVision = true,
        iMoveSpeed = 1000,
        iVisionRadius = 300,
        iVisionTeamNumber = caster:GetTeamNumber(),
        iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1
    })

    local winterChill = caster:FindModifierByName("modifier_winterschill")
    local winterChillStacks = winterChill and winterChill:GetStackCount() or 0
    local tripleDmg = false

    if(winterChill and winterChillStacks >= 2) then
        local newStacks = winterChillStacks - 2
        if(newStacks <= 0) then
            caster:RemoveModifierByName("modifier_winterschill")
        else
            winterChill:SetModifierStackCount(newStacks)
        end
        tripleDmg = true
    end

    self._projectiles = self._projectiles or {}
    self._projectiles[projectileId] = tripleDmg

    local stackChance = self:GetSpecialValueFor("stackchance")

    if(RandomInt(0, stackChance) <= stackChance) then
        ApplyBuffStack({
            caster = caster,
            target = caster,
            ability = self,
            buff = "modifier_ice_shatter",
            max = 10,
            addstacks = 1,
            ["self"] = 1,
            dur = 10
        })
    end
end