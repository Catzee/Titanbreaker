modifier_auto_casts = class({
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
            MODIFIER_EVENT_ON_ABILITY_FULLY_CAST 
        }
    end,
    GetModifierCastRangeBonusStacking = function(self)
        return self:GetStackCount()
    end,
    GetAttributes = function()
        return MODIFIER_ATTRIBUTE_PERMANENT
    end,
    RemoveOnDeath = function()
        return false
    end
})

function modifier_auto_casts:OnCreated()
    if(not IsServer()) then
        return
    end

    self.parent = self:GetParent()
end

function modifier_auto_casts:OnAbilityFullyCast(kv)
    local hero = kv.unit
    local target = kv.target

    -- If ability doesn't have autocast turned on don't try start auto casts queue
    if(kv.ability:GetAutoCastState() == false) then
        return
    end

    -- Do nothing if there is auto cast queue already
    if(hero._autoCastInternalTimer ~= nil) then
        return
    end

    local tickRate = 0.05

    if(target ~= nil) then
        hero._lastAutoCastTarget = target
    end
    
    hero._autoCastInternalTimer = Timers:CreateTimer(0, function(kv)
        local status, errorMessage = pcall(function ()
            for i=0, COverthrowGameMode.heroAbilityCount do
                local ability = hero:GetAbilityByIndex(i)
                if(ability and ability:GetAutoCastState() == true) then
                    self:CheckAbilityAutoCast(hero, ability, hero._lastAutoCastTarget)
                    return
                end
            end
        end)
        if(status ~= true) then
            print("CheckAbilityAutoCast timer error: ", errorMessage)
        end

        return tickRate
    end)
end

-- Target can be nil
function modifier_auto_casts:CheckAbilityAutoCast(caster, ability, target)
    -- Caster dead...
    if(caster:IsAlive() == false) then
        return
    end
    if(target ~= nil) then
        -- Ignore dead guys
        if(target:IsNull() or target:IsAlive() == false) then
            return
        end
        -- Check for too far enemies (2500+)
        local casterPosition = caster:GetAbsOrigin()
        local targetPosition = target:GetAbsOrigin()
        local dx = casterPosition.x - targetPosition.x
        local dy = targetPosition.y - targetPosition.y
        local distanceToTargetSqr = dx * dx + dy * dy
        if(distanceToTargetSqr >= 6250000) then
            return
        end
    end
    -- Waiting for silence
    if(caster:IsSilenced()) then
        return
    end
    -- Waiting for stun
    if(caster:IsStunned()) then
        return
    end
    -- Waiting for channel
    if(caster:IsChanneling()) then
        return
    end
    -- Casting something else, waiting for that
    if(caster:GetCurrentActiveAbility() ~= nil) then
        return
    end

    local isAutoCastWhileRunningAllowed = false

    if(modifier_auto_casts:IsAbilityCanBeAutoCastedWhileRunning(modifier_auto_casts:GetLastAutoCastedAbility(caster))) then
        isAutoCastWhileRunningAllowed = true
    end
    
    -- If caster moving most likely he is running from death unless it special autocast while running...
    if(isAutoCastWhileRunningAllowed == false and caster:IsMoving()) then
        return
    end

    local abilityToAutoCast = modifier_auto_casts:GetNextAbilityForAutoCast(caster, ability, target)

    -- Nothing worth casting, too bad...
    if(abilityToAutoCast == nil) then
        return
    end

    local autoCastOrder = modifier_auto_casts:GetAutoCastOrderForAbility(abilityToAutoCast)

    -- Unsupported behavior or something wrong, too bad
    if(autoCastOrder == nil) then
        return
    end

    if(autoCastOrder == DOTA_UNIT_ORDER_CAST_NO_TARGET) then
        ExecuteOrderFromTable({
            UnitIndex = caster:entindex(),
            OrderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
            AbilityIndex = abilityToAutoCast:GetEntityIndex(), 
            Queue = false
        })

        modifier_auto_casts:SetLastAutoCastedAbility(caster, abilityToAutoCast)
        return
    end

    if(autoCastOrder == DOTA_UNIT_ORDER_CAST_TARGET and target) then
        ExecuteOrderFromTable({
            UnitIndex = caster:entindex(),
            OrderType = DOTA_UNIT_ORDER_CAST_TARGET,
            AbilityIndex = abilityToAutoCast:GetEntityIndex(), 
            Queue = false,
            TargetIndex = target:entindex()
        })

        modifier_auto_casts:SetLastAutoCastedAbility(caster, abilityToAutoCast)
        return
    end

    if(autoCastOrder == DOTA_UNIT_ORDER_CAST_POSITION) then
        local position = abilityToAutoCast:GetCursorPosition()
        -- Hopefully this will be enough to detect default(Vector) == ability never casted
        if(math.abs(position.x) + math.abs(position.y) < 0.01) then
            if(target ~= nil) then
                position = target:GetAbsOrigin()
            else
                -- Nothing can be done, too bad
                return
            end
        end

        ExecuteOrderFromTable({
            UnitIndex = caster:entindex(),
            OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
            AbilityIndex = abilityToAutoCast:GetEntityIndex(), 
            Queue = false,
            Position = position
        })

        modifier_auto_casts:SetLastAutoCastedAbility(caster, abilityToAutoCast)
        return
    end
end

-- target can be nil
function modifier_auto_casts:GetNextAbilityForAutoCast(caster, ability, target)
    -- Caster should be fine and ready to cast any ability now so no need to check for that (at least only manacosts and cooldowns for desired abilities needs checking)
    local casterName = caster:GetUnitName()

    -- Oracle: Q, E spam
    if(casterName == "npc_dota_hero_oracle") then
        if(caster._autoCastOracleHolyLight == nil) then
            caster._autoCastOracleHolyLight = caster:FindAbilityByName("holy1")
            self:DetermineAutoCastOrderForAbility(caster._autoCastOracleHolyLight)
        end
        -- Should be Q E spam, but now it have issues (atm this thing can't support auto casting while walking)
        if(caster._autoCastOracleDivineNova == nil) then
            caster._autoCastOracleDivineNova = caster:FindAbilityByName("holy3")
            self:DetermineAutoCastOrderForAbility(caster._autoCastOracleDivineNova)
        end

        local isOracleDivineNovaReadyForAutocast = modifier_auto_casts:IsAbilityReadyForAutoCast(caster._autoCastOracleDivineNova)

        if(ability == caster._autoCastOracleHolyLight or ability == caster._autoCastOracleDivineNova) then
            local isOracleHolyLightReadyForAutocast = modifier_auto_casts:IsAbilityReadyForAutoCast(caster._autoCastOracleHolyLight)
            if(isOracleDivineNovaReadyForAutocast) then
                return caster._autoCastOracleDivineNova
            end 
            if(isOracleHolyLightReadyForAutocast) then
                return caster._autoCastOracleHolyLight
            end
        end

        -- Returns nil to prevent rest calculations of rest conditions that will be always false
        return nil
    end

    return nil
end

function modifier_auto_casts:GetAutoCastOrderForAbility(ability)
    if(not ability or ability.GetAutoCastState == nil) then
        return nil
    end

    if(ability._autoCastOrder ~= nil) then
        return ability._autoCastOrder
    end

    return nil
end

function modifier_auto_casts:IsAbilityCanBeAutoCastedWhileRunning(ability)
    if(not ability) then
        return false
    end

    if(ability._autoCastWhileRunning ~= nil) then
        return ability._autoCastWhileRunning
    end

    return false
end

function modifier_auto_casts:SetLastAutoCastedAbility(hero, ability)
    if(hero == nil) then
        return
    end

    hero._lastAutoCastedAbility = ability
end

function modifier_auto_casts:GetLastAutoCastedAbility(hero)
    if(hero == nil) then
        return nil
    end

    return hero._lastAutoCastedAbility
end

function modifier_auto_casts:DetermineAutoCastOrderForAbility(ability)
    if(not ability or ability.GetAutoCastState == nil) then
        return
    end

    local abilityBehavior = COverthrowGameMode:GetAbilityBehaviorSafe(ability)

    -- Special behaviors that allow abilities to be casted while running: DOTA_ABILITY_BEHAVIOR_DONT_CANCEL_MOVEMENT, DOTA_ABILITY_BEHAVIOR_IMMEDIATE?
    if(ability._autoCastWhileRunning == nil) then
        if(bit.band(abilityBehavior, DOTA_ABILITY_BEHAVIOR_DONT_CANCEL_MOVEMENT) == DOTA_ABILITY_BEHAVIOR_DONT_CANCEL_MOVEMENT) then
            ability._autoCastWhileRunning = true
        end
        if(ability._autoCastWhileRunning == nil and bit.band(abilityBehavior, DOTA_ABILITY_BEHAVIOR_IMMEDIATE) == DOTA_ABILITY_BEHAVIOR_IMMEDIATE) then
            ability._autoCastWhileRunning = true
        end
    end

    -- Grimstroke Hellfire, maybe something else
    if(bit.band(abilityBehavior, DOTA_ABILITY_BEHAVIOR_NO_TARGET) == DOTA_ABILITY_BEHAVIOR_NO_TARGET) then
        ability._autoCastOrder = DOTA_UNIT_ORDER_CAST_NO_TARGET
        return
    end

    if(bit.band(abilityBehavior, DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) == DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) then
        ability._autoCastOrder = DOTA_UNIT_ORDER_CAST_TARGET
        return
    end

    -- Lina abilities, maybe something else
    if(bit.band(abilityBehavior, DOTA_ABILITY_BEHAVIOR_POINT) == DOTA_ABILITY_BEHAVIOR_POINT) then
        ability._autoCastOrder = DOTA_UNIT_ORDER_CAST_POSITION
        return
    end
end

function modifier_auto_casts:IsAbilityReadyForAutoCast(ability)
    if(not ability or ability.GetAutoCastState == nil) then
        return false
    end

    -- IsFullyCastable() = caster have enough mana and ability coooldown ready
    return ability:GetAutoCastState() and ability:GetLevel() > 0 and ability:IsFullyCastable()
end

-- Ability can be nil
function modifier_auto_casts:TryCancelAutoCasts(caster, orderType, ability)
    if(modifier_auto_casts:IsOrderCanBeIgnoredForAutoCastsWhileRunning(orderType)) then
        if(modifier_auto_casts:IsAbilityCanBeAutoCastedWhileRunning(modifier_auto_casts:GetLastAutoCastedAbility(caster))) then
            return
        end
    end

    -- Non ability order, cancel auto casting
    if(ability == nil) then
        modifier_auto_casts:CancelAutoCasts(caster)
        return
    end

    -- Cancels auto casts if this is order for non auto cast (most likely player issues order)
    -- No idea why GetAutoCastState can be nil, probably some weird things
    if(ability and ability.GetAutoCastState and ability:GetAutoCastState() == false) then
        COverthrowGameMode:TryCancelAutoCasts(hero, ability)
        return
    end

end

function modifier_auto_casts:IsOrderCanBeIgnoredForAutoCastsWhileRunning(orderType)
    return orderType == DOTA_UNIT_ORDER_MOVE_TO_POSITION or orderType == DOTA_UNIT_ORDER_MOVE_TO_TARGET 
        or orderType == DOTA_UNIT_ORDER_ATTACK_MOVE or orderType == DOTA_UNIT_ORDER_ATTACK_TARGET
        or orderType == DOTA_UNIT_ORDER_EJECT_ITEM_FROM_STASH or orderType == DOTA_UNIT_ORDER_PING_ABILITY
        or orderType == DOTA_UNIT_ORDER_MOVE_TO_DIRECTION or orderType == DOTA_UNIT_ORDER_PATROL
        or orderType == DOTA_UNIT_ORDER_MOVE_RELATIVE or orderType == DOTA_UNIT_ORDER_DROP_ITEM_AT_FOUNTAIN
        or orderType == DOTA_UNIT_ORDER_TAUNT
end

function modifier_auto_casts:CancelAutoCasts(caster)
    if(caster._autoCastInternalTimer ~= nil) then
        Timers:RemoveTimer(caster._autoCastInternalTimer)
        caster._autoCastInternalTimer = nil
    end
end