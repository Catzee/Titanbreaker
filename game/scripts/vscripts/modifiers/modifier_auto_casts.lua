--[[
    HOW TO ADD SUPPORT FOR NEW HERO:
    1. Define and implement function that will return next ability for autocasts based on caster, ability, target (if exists)
    2. Setup table entry in OnCreated for that hero and function from 1)
--]]

modifier_auto_casts = class({
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
            MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
            MODIFIER_EVENT_ON_ORDER
        }
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
    self.parentName = self.parent:GetUnitName()
    self.abilitiesWithAutoCasts = {}
    self.abilitiesWithAutoCastsCount = 0
    -- Add entry here [heroName, functionName] for heroName autocasts support + implementation of functionName somewhere here in modifier_auto_casts scope
    self.autoCastsImplementations = {
        ["npc_dota_hero_oracle"] = "GetNextAbilityForOracleAutoCasts",
        ["npc_dota_hero_pugna"] = "GetNextAbilityForPugnaAutoCasts"
    }
end

function modifier_auto_casts:OnOrder(kv)
    if(kv.unit ~= self.parent) then
        return
    end

    if(kv.order_type == DOTA_UNIT_ORDER_CAST_TOGGLE_AUTO and kv.ability ~= nil) then
        -- Inverted because called before state set
        if(kv.ability:GetAutoCastState() == false) then
            self.abilitiesWithAutoCasts[kv.ability] = true
            self.abilitiesWithAutoCastsCount = self.abilitiesWithAutoCastsCount + 1
        else
            self.abilitiesWithAutoCasts[kv.ability] = nil
            self.abilitiesWithAutoCastsCount = self.abilitiesWithAutoCastsCount - 1
        end

        if(self.abilitiesWithAutoCastsCount < 1) then
            self:StartIntervalThink(-1)
        else
            self:StartIntervalThink(0.05)
        end
    end

    if(self:IsOrderFromAutoCast()) then
        return
    end

    -- This orders breaks queue...
    if(kv.order_type == DOTA_UNIT_ORDER_CONTINUE) then
        return
    end

    if(kv.order_type == DOTA_UNIT_ORDER_CAST_TOGGLE) then
        return
    end

    if(kv.order_type == DOTA_UNIT_ORDER_CAST_TOGGLE_AUTO) then
        return
    end

    if(kv.order_type == DOTA_UNIT_ORDER_CAST_TOGGLE_ALT) then
        return
    end

    self:SetIsIgnoreCastTimeAbilities(self:IsOrderPreventAutoCastOfCastTimeAbilities(kv.order_type))
end

function modifier_auto_casts:IsOrderPreventAutoCastOfCastTimeAbilities(orderType)
    return orderType == DOTA_UNIT_ORDER_MOVE_TO_POSITION or orderType == DOTA_UNIT_ORDER_MOVE_TO_TARGET 
        or orderType == DOTA_UNIT_ORDER_ATTACK_MOVE or orderType == DOTA_UNIT_ORDER_ATTACK_TARGET
        or orderType == DOTA_UNIT_ORDER_EJECT_ITEM_FROM_STASH or orderType == DOTA_UNIT_ORDER_PING_ABILITY
        or orderType == DOTA_UNIT_ORDER_MOVE_TO_DIRECTION or orderType == DOTA_UNIT_ORDER_PATROL
        or orderType == DOTA_UNIT_ORDER_MOVE_RELATIVE or orderType == DOTA_UNIT_ORDER_DROP_ITEM_AT_FOUNTAIN
        or orderType == DOTA_UNIT_ORDER_TAUNT or orderType == DOTA_UNIT_ORDER_STOP
        or orderType == DOTA_UNIT_ORDER_HOLD_POSITION
end

function modifier_auto_casts:OnAbilityFullyCast(kv)
    if(kv.unit ~= self.parent) then
        return
    end

    if(kv.ability:GetAutoCastState() == false) then
        return
    end

    if(kv.target ~= nil) then
        kv.ability._lastAutoCastTarget = kv.target
    end
end

function modifier_auto_casts:OnIntervalThink()
    for ability, _ in pairs(self.abilitiesWithAutoCasts) do
        self:CheckAbilityAutoCast(self.parent, ability, ability._lastAutoCastTarget)
    end
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

    -- Abilities without cast time and instant cast should be castable while running (oracle E, np Q, etc)
    if(self:IsAbilityCanBeAutoCastedWhileRunning(ability) == false) then
        if(caster:IsMoving()) then
            return
        end

        if(self:IsIgnoreCastTimeAbilities()) then
            return
        end
    end

    local abilityToAutoCast = self:GetNextAbilityForAutoCast(caster, ability, target)

    -- Nothing worth casting, too bad...
    if(abilityToAutoCast == nil) then
        return
    end

    local autoCastOrder = self:GetAutoCastOrderForAbility(abilityToAutoCast)

    -- Unsupported behavior or something wrong, too bad
    if(autoCastOrder == nil) then
        return
    end

    if(autoCastOrder == DOTA_UNIT_ORDER_CAST_NO_TARGET) then

        self:SetIsOrderFromAutoCast(true)

        ExecuteOrderFromTable({
            UnitIndex = caster:entindex(),
            OrderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
            AbilityIndex = abilityToAutoCast:GetEntityIndex(), 
            Queue = false
        })

        self:SetIsOrderFromAutoCast(false)
        return
    end

    if(autoCastOrder == DOTA_UNIT_ORDER_CAST_TARGET and target) then

        self:SetIsOrderFromAutoCast(true)

        ExecuteOrderFromTable({
            UnitIndex = caster:entindex(),
            OrderType = DOTA_UNIT_ORDER_CAST_TARGET,
            AbilityIndex = abilityToAutoCast:GetEntityIndex(), 
            Queue = false,
            TargetIndex = target:entindex()
        })

        self:SetIsOrderFromAutoCast(false)
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

        self:SetIsOrderFromAutoCast(true)

        ExecuteOrderFromTable({
            UnitIndex = caster:entindex(),
            OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
            AbilityIndex = abilityToAutoCast:GetEntityIndex(), 
            Queue = false,
            Position = position
        })

        self:SetIsOrderFromAutoCast(false)
        return
    end
end

-- Pugna: Q E combo with W sometimes for debuff
function modifier_auto_casts:GetNextAbilityForPugnaAutoCasts(caster, ability, target)
    if(caster._autoCastPugnaSoulFlame == nil) then
        caster._autoCastPugnaSoulFlame = caster:FindAbilityByName("destro1")
        self:DetermineAutoCastOrderForAbility(caster._autoCastPugnaSoulFlame)
    end
    if(caster._autoCastPugnaIgnite == nil) then
        caster._autoCastPugnaIgnite = caster:FindAbilityByName("destro2")
        self:DetermineAutoCastOrderForAbility(caster._autoCastPugnaIgnite)
    end
    if(caster._autoCastPugnaChaosBlast == nil) then
        caster._autoCastPugnaChaosBlast = caster:FindAbilityByName("destro3")
        self:DetermineAutoCastOrderForAbility(caster._autoCastPugnaChaosBlast)
    end

    if(ability == caster._autoCastPugnaSoulFlame or ability == caster._autoCastPugnaIgnite or ability == caster._autoCastPugnaChaosBlast) then
        local isPugnaSoulFlameReadyForAutoCast = self:IsAbilityReadyForAutoCast(caster._autoCastPugnaSoulFlame)
        local isPugnaIgniteReadyForAutoCast = self:IsAbilityReadyForAutoCast(caster._autoCastPugnaIgnite)
        local isPugnaChaosBlastReadyForAutoCast = self:IsAbilityReadyForAutoCast(caster._autoCastPugnaChaosBlast)

        -- If ignire refreshed spam it because dot stacks?
        if(isPugnaIgniteReadyForAutoCast) then
            return caster._autoCastPugnaIgnite
        end

        if(isPugnaChaosBlastReadyForAutoCast and caster:GetModifierStackCount("modifier_souls", nil) >= 2) then
            return caster._autoCastPugnaChaosBlast
        end

        if(isPugnaSoulFlameReadyForAutoCast) then
            return caster._autoCastPugnaSoulFlame
        end
    end

    return nil
end

-- Oracle: Q, E spam
function modifier_auto_casts:GetNextAbilityForOracleAutoCasts(caster, ability, target)
    if(caster._autoCastOracleHolyLight == nil) then
        caster._autoCastOracleHolyLight = caster:FindAbilityByName("holy1")
        self:DetermineAutoCastOrderForAbility(caster._autoCastOracleHolyLight)
    end
    if(caster._autoCastOracleDivineNova == nil) then
        caster._autoCastOracleDivineNova = caster:FindAbilityByName("holy3")
        self:DetermineAutoCastOrderForAbility(caster._autoCastOracleDivineNova)
    end

    local isOracleDivineNovaReadyForAutocast = self:IsAbilityReadyForAutoCast(caster._autoCastOracleDivineNova)

    if(ability == caster._autoCastOracleHolyLight or ability == caster._autoCastOracleDivineNova) then
        local isOracleHolyLightReadyForAutocast = self:IsAbilityReadyForAutoCast(caster._autoCastOracleHolyLight)
        if(isOracleDivineNovaReadyForAutocast) then
            return caster._autoCastOracleDivineNova
        end 
        if(isOracleHolyLightReadyForAutocast) then
            return caster._autoCastOracleHolyLight
        end
    end

    return nil
end

-- target can be nil
function modifier_auto_casts:GetNextAbilityForAutoCast(caster, ability, target)
    -- Caster should be fine and ready to cast any ability now so no need to check for that (at least only manacosts and cooldowns for desired abilities needs checking)
    if(self.autoCastsImplementations[self.parentName] ~= nil) then
        local status, result = pcall(function ()
            return self[self.autoCastsImplementations[self.parentName]](self, caster, ability, target)
        end)

        if(status ~= true) then
            print("modifier_auto_casts:GetNextAbilityForAutoCast error: ", result)
            return nil
        end

        return result
    end

    return nil
end

function modifier_auto_casts:IsOrderFromAutoCast()
    if(self._isOrderFromAutoCast ~= nil) then
        return self._isOrderFromAutoCast
    end

    return false
end

function modifier_auto_casts:SetIsOrderFromAutoCast(state)
    self._isOrderFromAutoCast = state
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

function modifier_auto_casts:IsIgnoreCastTimeAbilities()
    if(self._isIgnoreCastTimeAbilities ~= nil) then
        return self._isIgnoreCastTimeAbilities
    end

    return false
end

function modifier_auto_casts:SetIsIgnoreCastTimeAbilities(state)
    self._isIgnoreCastTimeAbilities = state
end