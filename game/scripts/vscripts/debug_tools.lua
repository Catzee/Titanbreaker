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
    local villageDummyPoint = Vector(-14972.935547, 14804.335938, 128.000000)
    
    CreateUnitByName("npc_dota_creature_tutorial_dummy", villageDummyPoint, false, nil, nil, DOTA_TEAM_NEUTRALS)

    _G._debugToolsInit = true
end