--[[
     addon_init called at client and server before addon_game_mode and since some dota patch you are required to register modifiers at both sides.
     Without client side registration you will get visual bugs and console spam like "Attempt to create unknown modifier". 
     Probably datadriven modifiers was always registred at both sides and not affected by this...
--]]

--charge ability modifier
LinkLuaModifier("modifier_charges", "modifiers/modifier_charges", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phased_lua", "modifiers/modifier_phased_lua", LUA_MODIFIER_MOTION_NONE)
--LinkLuaModifier("modifier_armor_formula", "modifiers/modifier_armor_formula", LUA_MODIFIER_MOTION_NONE)
--LinkLuaModifier("modifier_dotsystem", "modifiers/modifier_dotsystem", LUA_MODIFIER_MOTION_NONE)
--LinkLuaModifier("modifier_castrange", "modifiers/modifier_castrange", LUA_MODIFIER_MOTION_NONE)
--LinkLuaModifier("modifier_path_health_buff", "modifiers/modifier_path_health_buff", LUA_MODIFIER_MOTION_NONE)
-- fix for death with pl 6th ability buff due to heal after damage
LinkLuaModifier("modifier_godschosen_2", "modifiers/heroes/sanctified_crusader/shield_of_vengeance/modifier_godschosen_2", LUA_MODIFIER_MOTION_NONE)
-- swipe of ursa proc duration fix
LinkLuaModifier("modifier_swipe_of_ursa_proc", "modifiers/path_talents/modifier_swipe_of_ursa_proc", LUA_MODIFIER_MOTION_NONE)
-- omniknight 2nd ability alt cast support
LinkLuaModifier("modifier_judgement_spellres", "modifiers/heroes/divine_crusarder/holy_judgement/modifier_judgement_spellres", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_judgement_wisdom", "modifiers/heroes/divine_crusarder/holy_judgement/modifier_judgement_wisdom", LUA_MODIFIER_MOTION_NONE)