if not IsInToolsMode() then
    return
end

Timers:CreateTimer(1, function()
    -- Await until all game stuff initialized
    if(GameRules and GameRules:State_Get() >= DOTA_GAMERULES_STATE_PRE_GAME) then
        Init()
        return
    end
    return 1
end)

function Init()
    if(_G._debugToolsInit) then
        return
    end
    --[[
    Completely breaks datadriven...
    
    Convars:RegisterCommand("reload_kv", function(...)
        GameRules:Playtesting_UpdateAddOnKeyValues()
    end, "reload_kv", FCVAR_CHEAT)
    --]]

    Convars:RegisterCommand("droptempleitem", function(_, lootQuality, lootModifier)
        local lootQuality = tonumber(lootQuality)
        local isSoul = lootModifier == "soul" -- probably impossible without modifying DropTempleItem so unimplemented for now
        local isArti = lootModifier == "arti"

        DebugDropTempleItem(lootQuality, isSoul, isArti)
    end, "droptempleitem", FCVAR_CHEAT)

    Convars:RegisterCommand("templelvl", function(_, desiredLevel)
        local desiredLevel = tonumber(lootQuality)
        if(desiredLevel == nil) then
            desiredLevel = 100
        end

        DebugTempleLevel(desiredLevel)
    end, "templelvl", FCVAR_CHEAT)

    local villageDummyPoint = Vector(-14972.935547, 14804.335938, 128.000000)
    
    CreateUnitByName("npc_dota_creature_tutorial_dummy", villageDummyPoint, false, nil, nil, DOTA_TEAM_NEUTRALS)

    _G._debugToolsInit = true

end

function DebugDropTempleItem(lootQuality, isSoul, isArti)
    if not IsInToolsMode() then -- just to be 100% safe
        return
    end
    if(lootQuality == nil) then
        return
    end

    COverthrowGameMode:DropTempleItem(PlayerResource:GetSelectedHeroEntity(0), 100, 2, lootQuality, isArti)
end

function DebugDropTempleItem(lootQuality, isSoul, isArti)
    if not IsInToolsMode() then -- just to be 100% safe
        return
    end
    if(lootQuality == nil) then
        return
    end

    COverthrowGameMode:DropTempleItem(PlayerResource:GetSelectedHeroEntity(0), 100, 2, lootQuality, isArti)
end

function DebugTempleLevel(desiredLevel)
    if not IsInToolsMode() then -- just to be 100% safe
        return
    end
    local hero = PlayerResource:GetSelectedHeroEntity(0)
    local xp = COverthrowGameMode.levelTable[desiredLevel]
    hero:AddExperience(xp,false, true)
    AddHeroExperience(hero, xp)
end