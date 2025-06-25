--[[
    HOW TO ADD SUPPORT FOR NEW HERO:
    1. Define and implement function that will return next ability for autocasts based on caster, ability, target (if exists)
    2. Setup tables entries in OnCreated for that hero and function from 1)
--]]

modifier_auto_casts = class({
    IsHidden = function()
        return true
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
        ["npc_dota_hero_pugna"] = "GetNextAbilityForPugnaAutoCasts",
        ["npc_dota_hero_grimstroke"] = "GetNextAbilityForGrimstrokeAutoCasts",
        ["npc_dota_hero_warlock"] = "GetNextAbilityForWarlockAutoCasts",
        ["npc_dota_hero_shadow_shaman"] = "GetNextAbilityForShadowShamanAutoCasts",
        ["npc_dota_hero_lina"] = "GetNextAbilityForLinaAutoCasts",
        ["npc_dota_hero_invoker"] = "GetNextAbilityForInvokerAutoCasts",
        ["npc_dota_hero_dark_seer"] = "GetNextAbilityForDarkSeerAutoCasts",
        ["npc_dota_hero_omniknight"] = "GetNextAbilityForOmniknightAutoCasts",
        ["npc_dota_hero_crystal_maiden"] = "GetNextAbilityForCrystalMaidenAutoCasts",
        ["npc_dota_hero_furion"] = "GetNextAbilityForNatureProphetAutoCasts",
        ["npc_dota_hero_witch_doctor"] = "GetNextAbilityForWitchDoctorAutoCasts",
        ["npc_dota_hero_silencer"] = "GetNextAbilityForSilencerAutoCasts",
        ["npc_dota_hero_enchantress"] = "GetNextAbilityForEnchantressAutoCasts",
        ["npc_dota_hero_phantom_assassin"] = "GetNextAbilityForPhantomAssassinAutoCasts",
        ["npc_dota_hero_juggernaut"] = "GetNextAbilityForJuggernautAutoCasts",
        ["npc_dota_hero_riki"] = "GetNextAbilityForRikiAutoCasts",
        ["npc_dota_hero_bounty_hunter"] = "GetNextAbilityForBountyHunterAutoCasts",
        ["npc_dota_hero_windrunner"] = "GetNextAbilityForWindRunnerAutoCasts",
        ["npc_dota_hero_bloodseeker"] = "GetNextAbilityForBloodseekerAutoCasts",
        ["npc_dota_hero_drow_ranger"] = "GetNextAbilityForDrowRangerAutoCasts",
        ["npc_dota_hero_dazzle"] = "GetNextAbilityForDazzleAutoCasts",
        ["npc_dota_hero_vengefulspirit"] = "GetNextAbilityForVengefulSpiritAutoCasts",
        ["npc_dota_hero_sven"] = "GetNextAbilityForSvenAutoCasts",
        ["npc_dota_hero_axe"] = "GetNextAbilityForAxeAutoCasts",
        ["npc_dota_hero_legion_commander"] = "GetNextAbilityForLegionCommanderAutoCasts",
        ["npc_dota_hero_beastmaster"] = "GetNextAbilityForBeastmasterAutoCasts",
        ["npc_dota_hero_ursa"] = "GetNextAbilityForUrsaAutoCasts",
        ["npc_dota_hero_pudge"] = "GetNextAbilityForPudgeAutoCasts",
        ["npc_dota_hero_skeleton_king"] = "GetNextAbilityForWraithKingAutoCasts",
        ["npc_dota_hero_mars"] = "GetNextAbilityForMarsAutoCasts",
        ["npc_dota_hero_dragon_knight"] = "GetNextAbilityForDragonKnightAutoCasts",
        ["npc_dota_hero_phantom_lancer"] = "GetNextAbilityForPhantomLancerAutoCasts",
        ["npc_dota_hero_terrorblade"] = "GetNextAbilityForTerrorbladeAutoCasts"
    }

    -- List of abilities that can be casted while running, but actually will do more harm than good
    self.cantBeCastedWhileRunning = {
        -- Prevent pointless Phantom Assassin E spam
        ["Fatal_Throw"] = true,
        -- Eventually will kill player because tries constantly spam q w e combos even when player running away (Juggernaut)
        ["deadly1"] = true,
        ["deadly2"] = true,
        ["deadly3"] = true,
        -- Eventually will kill player? (RIki)
        ["hawk1"] = true,
        ["hawk2"] = true,
        -- Eventually will kill player? (Bounty Hunter)
        ["combat1"] = true,
        ["combat2"] = true,
        ["combat3"] = true,
        -- Eventually will kill player? (Windrunner)
        ["wind1"] = true,
        ["wind2"] = true,
        ["wind7"] = true,
        -- Eventually will kill player? (Bloodseeker)
        ["Ghost1"] = true,
        ["Ghost2"] = true,
        ["Ghost3"] = true,
        ["Ghost5"] = true,
        -- Eventually will kill player? (Drow ranger)
        ["Focussed_Shot"] = true,
        ["Inspiring_Shot"] = true,
        ["Mindfreezing_Shot"] = true,
        -- Eventually will kill player? (Dazzle)
        ["Feral2"] = true,
        ["Feral3"] = true,
        ["Feral4"] = true,
        -- Eventually will kill player? (Sven)
        ["frostdk1"] = true,
        ["frostdk2"] = true,
        -- Eventually will kill player? (Axe)
        ["Wounding_Strike"] = true,
        --["Mortal_Swing"] = true,
        ["Concussive_Blow"] = true,
        ["Knee_Breaker"] = true,
        -- Eventually will kill player? (Legion Commander)
        ["Retri2"] = true,
        -- Eventually will kill player? (Beastmaster)
        ["fury1"] = true,
        ["fury4"] = true,
        -- Eventually will kill player? (Ursa)
        ["bear1"] = true,
        -- Eventually will kill player? (Pudge)
        ["unholy_1"] = true,
        ["unholy_2"] = true,
        -- Eventually will kill player? (Wraith King)
        ["Corrupting_Strike"] = true,
        -- Eventually will kill player? (Mars)
        ["mars1"] = true,
        -- Eventually will kill player? (Dragon Knight)
        ["Protect1"] = true,
        -- Eventually will kill player? (Phantom Lancer)
        ["pala1"] = true,
        -- Eventually will kill player? (Terrorblade)
        ["terror1"] = true,
    }

    -- List of heroes that must keep auto attacking last enemy after every auto cast
    self.mustAutoAttackAfterAutoCast = 
    {
        ["npc_dota_hero_juggernaut"] = true,
        ["npc_dota_hero_phantom_assassin"] = true,
        ["npc_dota_hero_windrunner"] = true,
        ["npc_dota_hero_riki"] = true,
        ["npc_dota_hero_bloodseeker"] = true,
        ["npc_dota_hero_dazzle"] = true,
        ["npc_dota_hero_axe"] = true,
        ["npc_dota_hero_legion_commander"] = true,
        ["npc_dota_hero_beastmaster"] = true,
        ["npc_dota_hero_ursa"] = true,
        ["npc_dota_hero_skeleton_king"] = true,
        ["npc_dota_hero_mars"] = true,
        ["npc_dota_hero_dragon_knight"] = true,
        ["npc_dota_hero_phantom_lancer"] = true,
        ["npc_dota_hero_terrorblade"] = true,
        ["npc_dota_hero_bounty_hunter"] = true,
        ["npc_dota_hero_bounty_sven"] = true
    }

    self:DetermineIfMustAutoAttackAfterAutoCast()
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

    if(kv.order_type == DOTA_UNIT_ORDER_ATTACK_TARGET) then
        -- Special case. Some heroes must spam auto attacks too for their abilities to work. If player decide change target it breaks auto casting for that heroes
        self:SetLastAutoCastTarget(kv.target)
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

    if(kv.target == nil) then
        return
    end

    self:SetLastAutoCastTarget(kv.target)

    if(self:IsMustAutoAttackAfterAutoCast()) then
        self.parent:MoveToTargetToAttack(kv.target)
    end
end

function modifier_auto_casts:OnIntervalThink()
    for ability, _ in pairs(self.abilitiesWithAutoCasts) do
        self:CheckAbilityAutoCast(self.parent, ability, self:GetLastAutoCastTarget())
    end
end

function modifier_auto_casts:DetermineIfMustAutoAttackAfterAutoCast()
    if(self.mustAutoAttackAfterAutoCast[self.parent:GetUnitName()] == true) then
        self._isAutoAttackAfterAutoCasts = true
        return
    end

    self._isAutoAttackAfterAutoCasts = false
end

function modifier_auto_casts:IsMustAutoAttackAfterAutoCast()
    return self._isAutoAttackAfterAutoCasts
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
            self.parent._autoCastLastAutoCastTarget = nil
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
    -- Waiting for invisibility
    if(caster:IsInvisible()) then
        if(caster:GetCurrentActiveAbility() ~= nil) then
            caster:Stop()
        end
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

function modifier_auto_casts:SetLastAutoCastTarget(target)
    self.parent._autoCastLastAutoCastTarget = target
end

function modifier_auto_casts:GetLastAutoCastTarget()
    return self.parent._autoCastLastAutoCastTarget
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
        if(self.cantBeCastedWhileRunning[ability:GetAbilityName()] == true) then
            ability._autoCastWhileRunning = false
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
    -- IsActivated() = not hidden by stance/shapeshift/etc
    return ability:GetAutoCastState() and ability:GetLevel() > 0 and ability:IsFullyCastable() and ability:IsActivated()
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

-- Oracle: Q E spam
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

-- Grimstroke: Q W or Q E spam
function modifier_auto_casts:GetNextAbilityForGrimstrokeAutoCasts(caster, ability, target)
    if(caster._autoCastDemo1 == nil) then
        caster._autoCastDemo1 = caster:FindAbilityByName("demo1")
        self:DetermineAutoCastOrderForAbility(caster._autoCastDemo1)
    end
    if(caster._autoCastDemo2 == nil) then
        caster._autoCastDemo2 = caster:FindAbilityByName("demo2")
        self:DetermineAutoCastOrderForAbility(caster._autoCastDemo2)
    end
    if(caster._autoCastDemo3 == nil) then
        caster._autoCastDemo3 = caster:FindAbilityByName("demo3")
        self:DetermineAutoCastOrderForAbility(caster._autoCastDemo3)
    end

    if(ability == caster._autoCastDemo1 or ability == caster._autoCastDemo2 or ability == caster._autoCastDemo3) then
        local isGrimstrokeQReadyForAutocast = self:IsAbilityReadyForAutoCast(caster._autoCastDemo1)
        local isGrimstrokeWReadyForAutocast = self:IsAbilityReadyForAutoCast(caster._autoCastDemo2)
        local isGrimstrokeEReadyForAutocast = self:IsAbilityReadyForAutoCast(caster._autoCastDemo3)
        local soulsCount = caster:GetModifierStackCount("modifier_souls", nil)

        if(isGrimstrokeWReadyForAutocast and soulsCount >= 2) then
            return caster._autoCastDemo2
        end

        if(isGrimstrokeEReadyForAutocast and soulsCount >= 2) then
            return caster._autoCastDemo3
        end

        if(isGrimstrokeQReadyForAutocast) then
            return caster._autoCastDemo1
        end
    end

    return nil
end

-- Warlock: Q W dots upkeep, D spam during downtime
function modifier_auto_casts:GetNextAbilityForWarlockAutoCasts(caster, ability, target)
    if(caster._autoCastWarlockQ == nil) then
        caster._autoCastWarlockQ = caster:FindAbilityByName("Agony")
        self:DetermineAutoCastOrderForAbility(caster._autoCastWarlockQ)
    end
    if(caster._autoCastWarlockW == nil) then
        caster._autoCastWarlockW = caster:FindAbilityByName("Pain_Warlock")
        self:DetermineAutoCastOrderForAbility(caster._autoCastWarlockW)
    end
    if(caster._autoCastWarlockD == nil) then
        caster._autoCastWarlockD = caster:FindAbilityByName("dark_ranger_life_drain")
        self:DetermineAutoCastOrderForAbility(caster._autoCastWarlockD)
    end

    if(ability == caster._autoCastWarlockQ or ability == caster._autoCastWarlockW or ability == caster._autoCastWarlockD) then
        local isWarlockQReadyForAutocast = self:IsAbilityReadyForAutoCast(caster._autoCastWarlockQ)
        local isWarlockWReadyForAutocast = self:IsAbilityReadyForAutoCast(caster._autoCastWarlockW)
        local isWarlockDReadyForAutocast = self:IsAbilityReadyForAutoCast(caster._autoCastWarlockD)

        if(target == nil) then
            return nil
        end

        if(isWarlockQReadyForAutocast) then
            local dotModifier = target:FindModifierByName("modifier_dot1")
            -- Due to instant cast time trying prevent issues with low spell haste upkeep
            local isDotAlmostEnded = dotModifier and dotModifier:GetRemainingTime() / dotModifier:GetDuration() < 0.8

            if(isDotAlmostEnded or dotModifier == nil) then
                return caster._autoCastWarlockQ
            end
        end

        if(isWarlockWReadyForAutocast) then
            local dotModifier = target:FindModifierByName("modifier_dot2")
            local stacksCount = dotModifier and dotModifier:GetStackCount() or 0
            local isDotAlmostEnded = dotModifier and dotModifier:GetRemainingTime() / dotModifier:GetDuration() < 0.3

            if(isDotAlmostEnded) then
                return caster._autoCastWarlockW
            end

            if(caster._autoCastWarlockW:GetLevel() >= 3 and stacksCount < 2) then
                return caster._autoCastWarlockW
            else
                if(dotModifier == nil) then
                    return caster._autoCastWarlockW
                end
            end
        end

        if(isWarlockDReadyForAutocast) then
            return caster._autoCastWarlockD
        end
    end

    return nil
end

-- Shadow Shaman: Q E D spam
function modifier_auto_casts:GetNextAbilityForShadowShamanAutoCasts(caster, ability, target)
    if(caster._autoCastShadowShamanQ == nil) then
        caster._autoCastShadowShamanQ = caster:FindAbilityByName("Lightning_Bolt")
        self:DetermineAutoCastOrderForAbility(caster._autoCastShadowShamanQ)
    end
    if(caster._autoCastShadowShamanE == nil) then
        caster._autoCastShadowShamanE = caster:FindAbilityByName("Spirit_Shock")
        self:DetermineAutoCastOrderForAbility(caster._autoCastShadowShamanE)
    end
    if(caster._autoCastShadowShamanD == nil) then
        caster._autoCastShadowShamanD = caster:FindAbilityByName("Lavaburst")
        self:DetermineAutoCastOrderForAbility(caster._autoCastShadowShamanD)
    end

    if(ability == caster._autoCastShadowShamanQ or ability == caster._autoCastShadowShamanE or ability == caster._autoCastShadowShamanD) then
        local isShadowShamanQReadyForAutocast = self:IsAbilityReadyForAutoCast(caster._autoCastShadowShamanQ)
        local isShadowShamanEReadyForAutocast = self:IsAbilityReadyForAutoCast(caster._autoCastShadowShamanE)
        local isShadowShamanDReadyForAutocast = self:IsAbilityReadyForAutoCast(caster._autoCastShadowShamanD)

        if(target == nil) then
            return nil
        end

        if(isShadowShamanEReadyForAutocast) then
            return caster._autoCastShadowShamanE
        end

        if(isShadowShamanDReadyForAutocast and target:HasModifier("modifier_lavashock")) then
            return caster._autoCastShadowShamanD
        end

        if(isShadowShamanQReadyForAutocast) then
            return caster._autoCastShadowShamanQ
        end
    end

    return nil
end

-- Lina: Q W E D spam
function modifier_auto_casts:GetNextAbilityForLinaAutoCasts(caster, ability, target)
    if(caster._autoCastLinaQ == nil) then
        caster._autoCastLinaQ = caster:FindAbilityByName("Magma_Bolt")
        self:DetermineAutoCastOrderForAbility(caster._autoCastLinaQ)
    end
    if(caster._autoCastLinaW == nil) then
        caster._autoCastLinaW = caster:FindAbilityByName("Fire_Lance")
        self:DetermineAutoCastOrderForAbility(caster._autoCastLinaW)
    end
    if(caster._autoCastLinaE == nil) then
        caster._autoCastLinaE = caster:FindAbilityByName("Molten_Lava")
        self:DetermineAutoCastOrderForAbility(caster._autoCastLinaE)
    end
    if(caster._autoCastLinaD == nil) then
        caster._autoCastLinaD = caster:FindAbilityByName("Dragon_Claw")
        self:DetermineAutoCastOrderForAbility(caster._autoCastLinaD)
    end

    if(ability == caster._autoCastLinaQ or ability == caster._autoCastLinaW or ability == caster._autoCastLinaE or ability == caster._autoCastLinaD) then
        local isLinaQReadyForAutocast = self:IsAbilityReadyForAutoCast(caster._autoCastLinaQ)
        local isLinaWReadyForAutocast = self:IsAbilityReadyForAutoCast(caster._autoCastLinaW)
        local isLinaEReadyForAutocast = self:IsAbilityReadyForAutoCast(caster._autoCastLinaE)
        local isLinaDReadyForAutocast = self:IsAbilityReadyForAutoCast(caster._autoCastLinaD)

        if(isLinaWReadyForAutocast) then
            return caster._autoCastLinaW
        end

        if(isLinaEReadyForAutocast) then
            return caster._autoCastLinaE
        end

        if(isLinaDReadyForAutocast) then
            return caster._autoCastLinaD
        end

        if(isLinaQReadyForAutocast) then
            return caster._autoCastLinaQ
        end
    end

    return nil
end

-- Invoker: Q W spam
function modifier_auto_casts:GetNextAbilityForInvokerAutoCasts(caster, ability, target)
    if(caster._autoCastInvokerQ == nil) then
        caster._autoCastInvokerQ = caster:FindAbilityByName("Arcane1")
        self:DetermineAutoCastOrderForAbility(caster._autoCastInvokerQ)
    end
    if(caster._autoCastInvokerW == nil) then
        caster._autoCastInvokerW = caster:FindAbilityByName("Arcane2")
        self:DetermineAutoCastOrderForAbility(caster._autoCastInvokerW)
    end

    if(ability == caster._autoCastInvokerQ or ability == caster._autoCastInvokerW) then
        local isInvokerQReadyForAutocast = self:IsAbilityReadyForAutoCast(caster._autoCastInvokerQ)
        local isInvokerWReadyForAutocast = self:IsAbilityReadyForAutoCast(caster._autoCastInvokerW)

        if(isInvokerWReadyForAutocast) then
            return caster._autoCastInvokerW
        end

        if(isInvokerQReadyForAutocast) then
            return caster._autoCastInvokerQ
        end
    end

    return nil
end

-- Dark Seer: Q W E spam
function modifier_auto_casts:GetNextAbilityForDarkSeerAutoCasts(caster, ability, target)
    if(caster._autoCastMindstorm == nil) then
        caster._autoCastMindstorm = caster:FindAbilityByName("shadow1")
        self:DetermineAutoCastOrderForAbility(caster._autoCastMindstorm)
    end
    if(caster._autoCastMindshatter == nil) then
        caster._autoCastMindshatter = caster:FindAbilityByName("shadow11")
        self:DetermineAutoCastOrderForAbility(caster._autoCastMindshatter)
    end
    if(caster._autoCastDreamFeast == nil) then
        caster._autoCastDreamFeast = caster:FindAbilityByName("shadow3")
        self:DetermineAutoCastOrderForAbility(caster._autoCastDreamFeast)
    end

    if(ability == caster._autoCastDreamFeast and self:IsAbilityReadyForAutoCast(caster._autoCastDreamFeast)) then
        return caster._autoCastDreamFeast
    end

    if(ability == caster._autoCastMindshatter and self:IsAbilityReadyForAutoCast(caster._autoCastMindshatter)) then
        return caster._autoCastMindshatter
    end

    if(ability == caster._autoCastMindstorm and self:IsAbilityReadyForAutoCast(caster._autoCastMindstorm)) then
        return caster._autoCastMindstorm
    end

    return nil
end

-- Omni: Q spam
function modifier_auto_casts:GetNextAbilityForOmniknightAutoCasts(caster, ability, target)
    if(caster._autoCastDivineLight == nil) then
        caster._autoCastDivineLight = caster:FindAbilityByName("Divine_Light")
        self:DetermineAutoCastOrderForAbility(caster._autoCastDivineLight)
    end

    if(ability == caster._autoCastDivineLight and self:IsAbilityReadyForAutoCast(caster._autoCastDivineLight)) then
        return caster._autoCastDivineLight
    end

    return nil
end

-- Crystal Maiden: Q Q W combo
function modifier_auto_casts:GetNextAbilityForCrystalMaidenAutoCasts(caster, ability, target)
    if(caster._autoCastCMIceBolt == nil) then
        caster._autoCastCMIceBolt = caster:FindAbilityByName("Ice_Bolt")
        self:DetermineAutoCastOrderForAbility(caster._autoCastCMIceBolt)
    end
    if(caster._autoCastCMFrostShatter == nil) then
        caster._autoCastCMFrostShatter = caster:FindAbilityByName("Frost_Shatter")
        self:DetermineAutoCastOrderForAbility(caster._autoCastCMFrostShatter)
    end
    
    if(ability == caster._autoCastCMFrostShatter and self:IsAbilityReadyForAutoCast(caster._autoCastCMFrostShatter)) then
        local winterChillStacks = caster:GetModifierStackCount("modifier_winterschill", nil)
        if(winterChillStacks >= 2) then
            return caster._autoCastCMFrostShatter
        end
    end

    if(ability == caster._autoCastCMIceBolt and self:IsAbilityReadyForAutoCast(caster._autoCastCMIceBolt)) then
        return caster._autoCastCMIceBolt
    end

    return nil
end

-- Nature Phophet: Q spam if required
function modifier_auto_casts:GetNextAbilityForNatureProphetAutoCasts(caster, ability, target)
    if(caster._autoCastNatureProphetQ == nil) then
        caster._autoCastNatureProphetQ = caster:FindAbilityByName("Lifebloom")
        self:DetermineAutoCastOrderForAbility(caster._autoCastNatureProphetQ)
    end
            
    if(ability == caster._autoCastNatureProphetQ and self:IsAbilityReadyForAutoCast(caster._autoCastNatureProphetQ)) then
        local position = caster:GetAbsOrigin()
        local allies = FindNearbyAllies(caster, caster:GetAbsOrigin(), ability:GetEffectiveCastRange(position, caster))
        local isCastRequired = false
        local maxStacks = GetMaxBuffStackBonus(caster) + 3

        for _, ally in pairs(allies) do
            local firstModifier = ally:FindModifierByName("modifier_lifebloom")
            local secondModifier = ally:FindModifierByName("modifier_lifebloomfull")
            local allyStacks = (firstModifier and firstModifier:GetStackCount() or 0) + (secondModifier and secondModifier:GetStackCount() or 0)
            local isHotAlmostEnded = (firstModifier and firstModifier:GetRemainingTime() / firstModifier:GetDuration() < 0.5 or false) 
                or (secondModifier and secondModifier:GetRemainingTime() / secondModifier:GetDuration() < 0.5 or false)
                
            if(allyStacks < maxStacks or isHotAlmostEnded) then
                isCastRequired = true
                break
            end
        end
        
        if(isCastRequired == true) then
            return caster._autoCastNatureProphetQ
        end
    end

    return nil
end

-- Witch Doctor: Q spam
function modifier_auto_casts:GetNextAbilityForWitchDoctorAutoCasts(caster, ability, target)
    if(caster._autoCastWitchDoctorQ == nil) then
        caster._autoCastWitchDoctorQ = caster:FindAbilityByName("resto1")
        self:DetermineAutoCastOrderForAbility(caster._autoCastWitchDoctorQ)
    end
            
    if(ability == caster._autoCastWitchDoctorQ and self:IsAbilityReadyForAutoCast(caster._autoCastWitchDoctorQ)) then
        return caster._autoCastWitchDoctorQ
    end

    return nil
end

-- Silener: Q spam
function modifier_auto_casts:GetNextAbilityForSilencerAutoCasts(caster, ability, target)
    if(caster._autoCastSilencerQ == nil) then
        caster._autoCastSilencerQ = caster:FindAbilityByName("Light_of_Heaven")
        self:DetermineAutoCastOrderForAbility(caster._autoCastSilencerQ)
    end
            
    if(ability == caster._autoCastSilencerQ and self:IsAbilityReadyForAutoCast(caster._autoCastSilencerQ)) then
        return caster._autoCastSilencerQ
    end

    return nil
end

-- Enchantress: Q spam
function modifier_auto_casts:GetNextAbilityForEnchantressAutoCasts(caster, ability, target)
    if(caster._autoCastEnchantressQ == nil) then
        caster._autoCastEnchantressQ = caster:FindAbilityByName("ench1")
        self:DetermineAutoCastOrderForAbility(caster._autoCastEnchantressQ)
    end
            
    if(ability == caster._autoCastEnchantressQ and self:IsAbilityReadyForAutoCast(caster._autoCastEnchantressQ)) then
        return caster._autoCastEnchantressQ
    end

    return nil
end

-- Phantom Assassin: D E spam
function modifier_auto_casts:GetNextAbilityForPhantomAssassinAutoCasts(caster, ability, target)
    if(caster._autoCastPhantomAssassinE == nil) then
        caster._autoCastPhantomAssassinE = caster:FindAbilityByName("Fatal_Throw")
        self:DetermineAutoCastOrderForAbility(caster._autoCastPhantomAssassinE)
    end
    if(caster._autoCastPhantomAssassinD == nil) then
        caster._autoCastPhantomAssassinD = caster:FindAbilityByName("Ambush")
        self:DetermineAutoCastOrderForAbility(caster._autoCastPhantomAssassinD)
    end

    if(ability == caster._autoCastPhantomAssassinD and self:IsAbilityReadyForAutoCast(caster._autoCastPhantomAssassinD)) then
        return caster._autoCastPhantomAssassinD
    end

    if(ability == caster._autoCastPhantomAssassinE and self:IsAbilityReadyForAutoCast(caster._autoCastPhantomAssassinE) and caster:GetModifierStackCount("modifier_combopoint", nil) >= 3) then
        return caster._autoCastPhantomAssassinE
    end

    return nil
end

-- Juggernaut: Q W E spam
function modifier_auto_casts:GetNextAbilityForJuggernautAutoCasts(caster, ability, target)
    if(caster._autoCastJuggernautQ == nil) then
        caster._autoCastJuggernautQ = caster:FindAbilityByName("deadly1")
        self:DetermineAutoCastOrderForAbility(caster._autoCastJuggernautQ)
    end
    if(caster._autoCastJuggernautW == nil) then
        caster._autoCastJuggernautW = caster:FindAbilityByName("deadly2")
        self:DetermineAutoCastOrderForAbility(caster._autoCastJuggernautW)
    end
    if(caster._autoCastJuggernautE == nil) then
        caster._autoCastJuggernautE = caster:FindAbilityByName("deadly3")
        self:DetermineAutoCastOrderForAbility(caster._autoCastJuggernautE)
    end
    
    if(not caster.yinyangsystem) then
        return nil
    end

    local isJuggernautQReadyForAutocast = self:IsAbilityReadyForAutoCast(caster._autoCastJuggernautQ)
    local isJuggernautWReadyForAutocast = self:IsAbilityReadyForAutoCast(caster._autoCastJuggernautW)
    local isJuggernautEReadyForAutocast = self:IsAbilityReadyForAutoCast(caster._autoCastJuggernautE)

    local yin = caster.yinyangsystem[1]
    local yang = caster.yinyangsystem[2]
    local yin2yang1modifier = caster:FindModifierByName("modifier_molten_blade")
    local yin2yang1modifierAlmostEnded = (yin2yang1modifier and yin2yang1modifier:GetRemainingTime() / yin2yang1modifier:GetDuration() < 0.5 or false) 

    -- Fallback
    if(yin + yang >= 3 and isJuggernautEReadyForAutocast) then
        return caster._autoCastJuggernautE
    end

    -- Q Q E combo
    if(yin2yang1modifier == nil or yin2yang1modifierAlmostEnded) then
        if(yin >= 2 and yang >= 1 and isJuggernautEReadyForAutocast) then
            return caster._autoCastJuggernautE
        else
            if(yin < 2 and isJuggernautQReadyForAutocast) then
                return caster._autoCastJuggernautQ
            end

            if(yang < 1 and isJuggernautWReadyForAutocast) then
                return caster._autoCastJuggernautW
            end
        end
    end

    -- Q W W combo
    local yin1yang2modifier = caster:FindModifierByName("modifier_frozen_blade")
    local yin1yang2modifierAlmostEnded = (yin1yang2modifier and yin1yang2modifier:GetRemainingTime() / yin1yang2modifier:GetDuration() < 0.5 or false) 

    if(yin1yang2modifier == nil or yin1yang2modifierAlmostEnded) then
        if(yin >= 1 and yang >= 2 and isJuggernautEReadyForAutocast) then
            return caster._autoCastJuggernautE
        else
            if(yin < 1 and isJuggernautQReadyForAutocast) then
                return caster._autoCastJuggernautQ
            end

            if(yang < 2 and isJuggernautWReadyForAutocast) then
                return caster._autoCastJuggernautW
            end
        end
    end

    -- Q Q Q combo
    if(yin >= 3 and isJuggernautEReadyForAutocast) then
        return caster._autoCastJuggernautE
    else
        if(yin < 3 and isJuggernautQReadyForAutocast) then
            return caster._autoCastJuggernautQ
        end
    end

    return nil
end

-- Riki: Q W spam
function modifier_auto_casts:GetNextAbilityForRikiAutoCasts(caster, ability, target)
    if(caster._autoCastRikiQ == nil) then
        caster._autoCastRikiQ = caster:FindAbilityByName("hawk1")
        self:DetermineAutoCastOrderForAbility(caster._autoCastRikiQ)
    end
    if(caster._autoCastRikiW == nil) then
        caster._autoCastRikiW = caster:FindAbilityByName("hawk2")
        self:DetermineAutoCastOrderForAbility(caster._autoCastRikiW)
    end
    
    local focusPoints = caster:GetModifierStackCount("modifier_combopoint", nil)

    if(ability == caster._autoCastRikiW and self:IsAbilityReadyForAutoCast(caster._autoCastRikiW) and focusPoints >= 3) then
        return caster._autoCastRikiW
    end

    if(ability == caster._autoCastRikiQ and self:IsAbilityReadyForAutoCast(caster._autoCastRikiQ)) then
        return caster._autoCastRikiQ
    end

    return nil
end

-- Bounty Hunter: Q W E spam
function modifier_auto_casts:GetNextAbilityForBountyHunterAutoCasts(caster, ability, target)
    if(caster._autoCastBountyHunterQ == nil) then
        caster._autoCastBountyHunterQ = caster:FindAbilityByName("combat1")
        self:DetermineAutoCastOrderForAbility(caster._autoCastBountyHunterQ)
    end
    if(caster._autoCastBountyHunterW == nil) then
        caster._autoCastBountyHunterW = caster:FindAbilityByName("combat3")
        self:DetermineAutoCastOrderForAbility(caster._autoCastBountyHunterW)
    end
    if(caster._autoCastBountyHunterE == nil) then
        caster._autoCastBountyHunterE = caster:FindAbilityByName("combat2")
        self:DetermineAutoCastOrderForAbility(caster._autoCastBountyHunterE)
    end

    if(ability == caster._autoCastBountyHunterE and self:IsAbilityReadyForAutoCast(caster._autoCastBountyHunterE)) then
        return caster._autoCastBountyHunterE
    end

    if(ability == caster._autoCastBountyHunterW and self:IsAbilityReadyForAutoCast(caster._autoCastBountyHunterW) and caster:GetModifierStackCount("modifier_combopoint", nil) >= 3) then
        return caster._autoCastBountyHunterW
    end
    
    if(ability == caster._autoCastBountyHunterQ and self:IsAbilityReadyForAutoCast(caster._autoCastBountyHunterQ)) then
        return caster._autoCastBountyHunterQ
    end

    return nil
end

-- Windrunner: Q W R spam
function modifier_auto_casts:GetNextAbilityForWindRunnerAutoCasts(caster, ability, target)
    if(caster._autoCastWindrunnerQ == nil) then
        caster._autoCastWindrunnerQ = caster:FindAbilityByName("wind1")
        self:DetermineAutoCastOrderForAbility(caster._autoCastWindrunnerQ)
    end
    if(caster._autoCastWindrunnerW == nil) then
        caster._autoCastWindrunnerW = caster:FindAbilityByName("wind2")
        self:DetermineAutoCastOrderForAbility(caster._autoCastWindrunnerW)
    end
    if(caster._autoCastWindrunnerR == nil) then
        caster._autoCastWindrunnerR = caster:FindAbilityByName("wind7")
        self:DetermineAutoCastOrderForAbility(caster._autoCastWindrunnerR)
    end

    -- If fire arrow learned try smart use lock and reload stacks
    local fireArrowLevel = caster._autoCastWindrunnerW:GetLevel()
    if(fireArrowLevel > 0) then
        if(ability == caster._autoCastWindrunnerR and self:IsAbilityReadyForAutoCast(caster._autoCastWindrunnerR) and caster:GetModifierStackCount("modifier_lockreload", nil) >= 10) then
            return caster._autoCastWindrunnerR
        end

        -- Try consider fire arrow buff
        if(fireArrowLevel >= 3) then
            local fireArrowBuffModifier = caster:FindModifierByName("modifier_fire_shots_jungle")
            local isFireArrowBuffModifierAlmostEnded = fireArrowBuffModifier and fireArrowBuffModifier:GetRemainingTime() / fireArrowBuffModifier:GetDuration() < 0.5 or false

            if(fireArrowBuffModifier == nil) then
                if(ability == caster._autoCastWindrunnerW and self:IsAbilityReadyForAutoCast(caster._autoCastWindrunnerW)) then
                    return caster._autoCastWindrunnerW
                end
            else
                if(ability == caster._autoCastWindrunnerW and self:IsAbilityReadyForAutoCast(caster._autoCastWindrunnerW) and isFireArrowBuffModifierAlmostEnded) then
                    return caster._autoCastWindrunnerW
                end
            end
        else
            if(ability == caster._autoCastWindrunnerW and self:IsAbilityReadyForAutoCast(caster._autoCastWindrunnerW)) then
                return caster._autoCastWindrunnerW
            end
        end
    else
        if(ability == caster._autoCastWindrunnerR and self:IsAbilityReadyForAutoCast(caster._autoCastWindrunnerR)) then
            return caster._autoCastWindrunnerR
        end

        if(ability == caster._autoCastWindrunnerW and self:IsAbilityReadyForAutoCast(caster._autoCastWindrunnerW)) then
            return caster._autoCastWindrunnerW
        end
    end

    if(ability == caster._autoCastWindrunnerQ and self:IsAbilityReadyForAutoCast(caster._autoCastWindrunnerQ)) then
        return caster._autoCastWindrunnerQ
    end
    
    return nil
end

-- Bloodseeker: Q W E D spam
function modifier_auto_casts:GetNextAbilityForBloodseekerAutoCasts(caster, ability, target)
    if(caster._autoCastBloodseekerQ == nil) then
        caster._autoCastBloodseekerQ = caster:FindAbilityByName("Ghost1")
        self:DetermineAutoCastOrderForAbility(caster._autoCastBloodseekerQ)
    end
    if(caster._autoCastBloodseekerW == nil) then
        caster._autoCastBloodseekerW = caster:FindAbilityByName("Ghost2")
        self:DetermineAutoCastOrderForAbility(caster._autoCastBloodseekerW)
    end
    if(caster._autoCastBloodseekerE == nil) then
        caster._autoCastBloodseekerE = caster:FindAbilityByName("Ghost3")
        self:DetermineAutoCastOrderForAbility(caster._autoCastBloodseekerE)
    end
    if(caster._autoCastBloodseekerD == nil) then
        caster._autoCastBloodseekerD = caster:FindAbilityByName("Ghost5")
        self:DetermineAutoCastOrderForAbility(caster._autoCastBloodseekerD)
    end

    if(ability == caster._autoCastBloodseekerD and self:IsAbilityReadyForAutoCast(caster._autoCastBloodseekerD) and caster:GetModifierStackCount("modifier_elementalfury", nil) >= 10) then
        return caster._autoCastBloodseekerD
    end

    if(ability == caster._autoCastBloodseekerQ and self:IsAbilityReadyForAutoCast(caster._autoCastBloodseekerQ)) then
        return caster._autoCastBloodseekerQ
    end

    if(ability == caster._autoCastBloodseekerW and self:IsAbilityReadyForAutoCast(caster._autoCastBloodseekerW)) then
        return caster._autoCastBloodseekerW
    end

    if(ability == caster._autoCastBloodseekerE and self:IsAbilityReadyForAutoCast(caster._autoCastBloodseekerE)) then
        return caster._autoCastBloodseekerE
    end

    return nil
end

-- Drow Ranger: Q E D spam
function modifier_auto_casts:GetNextAbilityForDrowRangerAutoCasts(caster, ability, target)
    if(caster._autoCastDrowRangerQ == nil) then
        caster._autoCastDrowRangerQ = caster:FindAbilityByName("Focussed_Shot")
        self:DetermineAutoCastOrderForAbility(caster._autoCastDrowRangerQ)
    end
    if(caster._autoCastDrowRangerE == nil) then
        caster._autoCastDrowRangerE = caster:FindAbilityByName("Inspiring_Shot")
        self:DetermineAutoCastOrderForAbility(caster._autoCastDrowRangerE)
    end
    if(caster._autoCastDrowRangerD == nil) then
        caster._autoCastDrowRangerD = caster:FindAbilityByName("Mindfreezing_Shot")
        self:DetermineAutoCastOrderForAbility(caster._autoCastDrowRangerD)
    end

    if(ability == caster._autoCastDrowRangerD and self:IsAbilityReadyForAutoCast(caster._autoCastDrowRangerD)) then
        return caster._autoCastDrowRangerD
    end

    if(ability == caster._autoCastDrowRangerE and self:IsAbilityReadyForAutoCast(caster._autoCastDrowRangerE)) then
        return caster._autoCastDrowRangerE
    end

    if(ability == caster._autoCastDrowRangerQ and self:IsAbilityReadyForAutoCast(caster._autoCastDrowRangerQ)) then
        return caster._autoCastDrowRangerQ
    end

    return nil
end

-- Dazzle: Q W E spam
function modifier_auto_casts:GetNextAbilityForDazzleAutoCasts(caster, ability, target)
    if(caster._autoCastDazzleQ == nil) then
        caster._autoCastDazzleQ = caster:FindAbilityByName("Feral2")
        self:DetermineAutoCastOrderForAbility(caster._autoCastDazzleQ)
    end
    if(caster._autoCastDazzleW == nil) then
        caster._autoCastDazzleW = caster:FindAbilityByName("Feral3")
        self:DetermineAutoCastOrderForAbility(caster._autoCastDazzleW)
    end
    if(caster._autoCastDazzleE == nil) then
        caster._autoCastDazzleE = caster:FindAbilityByName("Feral4")
        self:DetermineAutoCastOrderForAbility(caster._autoCastDazzleE)
    end

    local focusPoints = caster:GetModifierStackCount("modifier_combopoint", nil)
    local tigerFuryBuffModifier = caster:FindModifierByName("modifier_tigerfury")
    local isTigerFuryBuffModifierAlmostEnded = tigerFuryBuffModifier and tigerFuryBuffModifier:GetRemainingTime() / tigerFuryBuffModifier:GetDuration() < 0.5 or false  

    if(tigerFuryBuffModifier == nil) then
        if(ability == caster._autoCastDazzleW and self:IsAbilityReadyForAutoCast(caster._autoCastDazzleW) and focusPoints >= 4) then
            return caster._autoCastDazzleW
        end
    else
        if(ability == caster._autoCastDazzleW and self:IsAbilityReadyForAutoCast(caster._autoCastDazzleW) and isTigerFuryBuffModifierAlmostEnded and focusPoints >= 4) then
            return caster._autoCastDazzleW
        end
    end

    if(ability == caster._autoCastDazzleE and self:IsAbilityReadyForAutoCast(caster._autoCastDazzleE) and focusPoints >= 4) then
        return caster._autoCastDazzleE
    end

    if(ability == caster._autoCastDazzleQ and self:IsAbilityReadyForAutoCast(caster._autoCastDazzleQ) and focusPoints < 4) then
        return caster._autoCastDazzleQ
    end

    return nil
end

-- Venge: Q spam, TODO: Make it smarter...
function modifier_auto_casts:GetNextAbilityForVengefulSpiritAutoCasts(caster, ability, target)
    if(caster._autoCastVengefulSpiritMoonQ == nil) then
        caster._autoCastVengefulSpiritMoonQ = caster:FindAbilityByName("moon11")
        self:DetermineAutoCastOrderForAbility(caster._autoCastVengefulSpiritMoonQ)
    end
    if(caster._autoCastVengefulSpiritSunQ == nil) then
        caster._autoCastVengefulSpiritSunQ = caster:FindAbilityByName("moon1")
        self:DetermineAutoCastOrderForAbility(caster._autoCastVengefulSpiritSunQ)
    end

    if(ability == caster._autoCastVengefulSpiritMoonQ and self:IsAbilityReadyForAutoCast(caster._autoCastVengefulSpiritMoonQ)) then
        return caster._autoCastVengefulSpiritMoonQ
    end

    if(ability == caster._autoCastVengefulSpiritSunQ and self:IsAbilityReadyForAutoCast(caster._autoCastVengefulSpiritSunQ)) then
        return caster._autoCastVengefulSpiritSunQ
    end

    return nil
end

-- Sven: Q W spam
function modifier_auto_casts:GetNextAbilityForSvenAutoCasts(caster, ability, target)
    if(caster._autoCastSvenQ == nil) then
        caster._autoCastSvenQ = caster:FindAbilityByName("frostdk1")
        self:DetermineAutoCastOrderForAbility(caster._autoCastSvenQ)
    end
    if(caster._autoCastSvenW == nil) then
        caster._autoCastSvenW = caster:FindAbilityByName("frostdk2")
        self:DetermineAutoCastOrderForAbility(caster._autoCastSvenW)
    end

    if(ability == caster._autoCastSvenW and self:IsAbilityReadyForAutoCast(caster._autoCastSvenW)) then
        return caster._autoCastSvenW
    end

    if(ability == caster._autoCastSvenQ and self:IsAbilityReadyForAutoCast(caster._autoCastSvenQ)) then
        return caster._autoCastSvenQ
    end

    return nil
end

-- Axe: Q W E D spam
function modifier_auto_casts:GetNextAbilityForAxeAutoCasts(caster, ability, target)
    if(caster._autoCastAxeQ == nil) then
        caster._autoCastAxeQ = caster:FindAbilityByName("Wounding_Strike")
        self:DetermineAutoCastOrderForAbility(caster._autoCastAxeQ)
    end
    if(caster._autoCastAxeW == nil) then
        caster._autoCastAxeW = caster:FindAbilityByName("Mortal_Swing")
        self:DetermineAutoCastOrderForAbility(caster._autoCastAxeW)
    end
    if(caster._autoCastAxeE == nil) then
        caster._autoCastAxeE = caster:FindAbilityByName("Concussive_Blow")
        self:DetermineAutoCastOrderForAbility(caster._autoCastAxeE)
    end
    if(caster._autoCastAxeD == nil) then
        caster._autoCastAxeD = caster:FindAbilityByName("Knee_Breaker")
        self:DetermineAutoCastOrderForAbility(caster._autoCastAxeD)
    end

    if(target ~= nil) then
        if(ability == caster._autoCastAxeQ and self:IsAbilityReadyForAutoCast(caster._autoCastAxeQ) and target:HasModifier("modifier_wounding_strike_bleed_debuff") == false) then
            return caster._autoCastAxeQ
        end
    end
    
    if(ability == caster._autoCastAxeE and self:IsAbilityReadyForAutoCast(caster._autoCastAxeE)) then
        return caster._autoCastAxeE
    end

    if(ability == caster._autoCastAxeD and self:IsAbilityReadyForAutoCast(caster._autoCastAxeD)) then
        return caster._autoCastAxeD
    end

    if(ability == caster._autoCastAxeW and self:IsAbilityReadyForAutoCast(caster._autoCastAxeW)) then
        local casterPosition = caster:GetAbsOrigin()
        local enemiesAround = FindNearbyEnemies(caster, casterPosition, caster._autoCastAxeW:GetSpecialValueFor("radius"))

        if(#enemiesAround > 0) then
            return caster._autoCastAxeW
        end

        return nil
    end

    return nil
end

-- Legion Commander: Q W spam
function modifier_auto_casts:GetNextAbilityForLegionCommanderAutoCasts(caster, ability, target)
    if(caster._autoCastLegionCommanderQ == nil) then
        caster._autoCastLegionCommanderQ = caster:FindAbilityByName("Retri1")
        self:DetermineAutoCastOrderForAbility(caster._autoCastLegionCommanderQ)
    end
    if(caster._autoCastLegionCommanderW == nil) then
        caster._autoCastLegionCommanderW = caster:FindAbilityByName("Retri2")
        self:DetermineAutoCastOrderForAbility(caster._autoCastLegionCommanderW)
    end
    if(caster._autoCastLegionCommanderD == nil) then
        caster._autoCastLegionCommanderD = caster:FindAbilityByName("Retri4")
        --self:DetermineAutoCastOrderForAbility(caster._autoCastLegionCommanderD)
    end

    if(ability == caster._autoCastLegionCommanderW and self:IsAbilityReadyForAutoCast(caster._autoCastLegionCommanderW)) then
        return caster._autoCastLegionCommanderW
    end

    if(caster._autoCastLegionCommanderD:GetLevel() >= 4) then
        -- Always spam when possible and required for cdr
        if(ability == caster._autoCastLegionCommanderQ and self:IsAbilityReadyForAutoCast(caster._autoCastLegionCommanderQ) and caster._autoCastLegionCommanderD:GetCooldownTimeRemaining() > 1) then
            return caster._autoCastLegionCommanderQ
        end
    else
        -- Spam only when enemies around
        if(ability == caster._autoCastLegionCommanderQ and self:IsAbilityReadyForAutoCast(caster._autoCastLegionCommanderQ)) then
            local casterPosition = caster:GetAbsOrigin()
            local enemiesAround = FindNearbyEnemies(caster, casterPosition, caster._autoCastLegionCommanderQ:GetSpecialValueFor("range"))
            if(#enemiesAround > 0) then
                return caster._autoCastLegionCommanderQ
            end

            return nil
        end
    end

    return nil
end

-- Beastmaster: Q D spam
function modifier_auto_casts:GetNextAbilityForBeastmasterAutoCasts(caster, ability, target)
    if(caster._autoCastBeastmasterQ == nil) then
        caster._autoCastBeastmasterQ = caster:FindAbilityByName("fury1")
        self:DetermineAutoCastOrderForAbility(caster._autoCastBeastmasterQ)
    end
    if(caster._autoCastBeastmasterD == nil) then
        caster._autoCastBeastmasterD = caster:FindAbilityByName("fury4")
        self:DetermineAutoCastOrderForAbility(caster._autoCastBeastmasterD)
    end

    if(target == nil) then
    	return nil
    end

    -- Bonus Q W E damage based on current rage/mana with Q5. Maintain 40 rage for rest abilities usage
    local slaughterRageCost = caster._autoCastBeastmasterD:GetManaCost(-1)
    local minRageToMaintain = caster._autoCastBeastmasterQ:GetLevel() >= 5 and (caster:GetMaxMana() - slaughterRageCost) or 40
    local currentRage = caster:GetMana()

    if(ability == caster._autoCastBeastmasterD and self:IsAbilityReadyForAutoCast(caster._autoCastBeastmasterD) and currentRage >= minRageToMaintain) then
        if(caster._autoCastBeastmasterD:GetLevel() >= 4) then
            if(target:GetHealth() / target:GetMaxHealth() > 0.5) then
                if(caster:GetMana() >= 40 + slaughterRageCost) then
                    -- Bonus D damage when D used on enemies above 50% max health with at least 40 rage
                    return caster._autoCastBeastmasterD
                else
                    return nil
                end
            else
                -- Bonus damage can't be used anymore, spam D when possible
                return caster._autoCastBeastmasterD
            end
        else
            -- Spam D when possible
            return caster._autoCastBeastmasterD
        end
    end

    if(ability == caster._autoCastBeastmasterQ and self:IsAbilityReadyForAutoCast(caster._autoCastBeastmasterQ)) then
        return caster._autoCastBeastmasterQ
    end

    return nil
end

-- Ursa: Q spam
function modifier_auto_casts:GetNextAbilityForUrsaAutoCasts(caster, ability, target)
    if(caster._autoCastBearQ == nil) then
        caster._autoCastBearQ = caster:FindAbilityByName("bear1")
        self:DetermineAutoCastOrderForAbility(caster._autoCastBearQ)
    end

    if(ability == caster._autoCastBearQ and self:IsAbilityReadyForAutoCast(caster._autoCastBearQ)) then
        return caster._autoCastBearQ
    end

    return nil
end

-- Pudge: Q W spam
function modifier_auto_casts:GetNextAbilityForPudgeAutoCasts(caster, ability, target)
    if(caster._autoCastPudgeQ == nil) then
        caster._autoCastPudgeQ = caster:FindAbilityByName("unholy_1")
        self:DetermineAutoCastOrderForAbility(caster._autoCastPudgeQ)
    end
    if(caster._autoCastPudgeW == nil) then
        caster._autoCastPudgeW = caster:FindAbilityByName("unholy_2")
        self:DetermineAutoCastOrderForAbility(caster._autoCastPudgeW)
    end

    if(ability == caster._autoCastPudgeW and self:IsAbilityReadyForAutoCast(caster._autoCastPudgeW)) then
        return caster._autoCastPudgeW
    end

    if(ability == caster._autoCastPudgeQ and self:IsAbilityReadyForAutoCast(caster._autoCastPudgeQ)) then
        return caster._autoCastPudgeQ
    end

    return nil
end

-- Wraith King: Q spam, TODO: Something smarter?
function modifier_auto_casts:GetNextAbilityForWraithKingAutoCasts(caster, ability, target)
    if(caster._autoCastWraithKingQ == nil) then
        caster._autoCastWraithKingQ = caster:FindAbilityByName("Corrupting_Strike")
        self:DetermineAutoCastOrderForAbility(caster._autoCastWraithKingQ)
    end

    if(ability == caster._autoCastWraithKingQ and self:IsAbilityReadyForAutoCast(caster._autoCastWraithKingQ)) then
        return caster._autoCastWraithKingQ
    end

    return nil
end

-- Mars: Q spam, TODO: Something smarter?
function modifier_auto_casts:GetNextAbilityForMarsAutoCasts(caster, ability, target)
    if(caster._autoCastMarsQ == nil) then
        caster._autoCastMarsQ = caster:FindAbilityByName("mars1")
        self:DetermineAutoCastOrderForAbility(caster._autoCastMarsQ)
    end

    if(ability == caster._autoCastMarsQ and self:IsAbilityReadyForAutoCast(caster._autoCastMarsQ)) then
        return caster._autoCastMarsQ
    end

    return nil
end

-- Dragon Knight: Q spam, TODO: Something smarter?
function modifier_auto_casts:GetNextAbilityForDragonKnightAutoCasts(caster, ability, target)
    if(caster._autoCastDragonKnightQ == nil) then
        caster._autoCastDragonKnightQ = caster:FindAbilityByName("Protect1")
        self:DetermineAutoCastOrderForAbility(caster._autoCastDragonKnightQ)
    end

    if(ability == caster._autoCastDragonKnightQ and self:IsAbilityReadyForAutoCast(caster._autoCastDragonKnightQ)) then
        return caster._autoCastDragonKnightQ
    end

    return nil
end

-- Phantom Lancer: Q spam, TODO: Something smarter?
function modifier_auto_casts:GetNextAbilityForPhantomLancerAutoCasts(caster, ability, target)
    if(caster._autoCastPhantomLancerQ == nil) then
        caster._autoCastPhantomLancerQ = caster:FindAbilityByName("pala1")
        self:DetermineAutoCastOrderForAbility(caster._autoCastPhantomLancerQ)
    end

    if(ability == caster._autoCastPhantomLancerQ and self:IsAbilityReadyForAutoCast(caster._autoCastPhantomLancerQ)) then
        return caster._autoCastPhantomLancerQ
    end

    return nil
end

-- Terrorblade: Q spam, TODO: Something smarter?
function modifier_auto_casts:GetNextAbilityForTerrorbladeAutoCasts(caster, ability, target)
    if(caster._autoCastTerrorbladeQ == nil) then
        caster._autoCastTerrorbladeQ = caster:FindAbilityByName("terror1")
        self:DetermineAutoCastOrderForAbility(caster._autoCastTerrorbladeQ)
    end

    if(ability == caster._autoCastTerrorbladeQ and self:IsAbilityReadyForAutoCast(caster._autoCastTerrorbladeQ)) then
        return caster._autoCastTerrorbladeQ
    end

    return nil
end