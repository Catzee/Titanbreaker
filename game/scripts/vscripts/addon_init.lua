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
-- omniknight 2nd ability alt cast support (lua rewrite)
LinkLuaModifier("modifier_divine_crusarder_holy_judgement_buff", "modifiers/heroes/divine_crusarder/holy_judgement/modifier_divine_crusarder_holy_judgement_buff", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_divine_crusarder_holy_judgement_wisdom", "modifiers/heroes/divine_crusarder/holy_judgement/modifier_divine_crusarder_holy_judgement_wisdom", LUA_MODIFIER_MOTION_NONE)
-- np 5th ability alt cast support (lua rewrite)
LinkLuaModifier("modifer_peaceful_guardian_cyclone_aura", "modifiers/heroes/peaceful_guardian/cyclone/modifer_peaceful_guardian_cyclone_aura", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifer_peaceful_guardian_cyclone_aura_buff", "modifiers/heroes/peaceful_guardian/cyclone/modifer_peaceful_guardian_cyclone_aura_buff", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifer_peaceful_guardian_cyclone_debuff", "modifiers/heroes/peaceful_guardian/cyclone/modifer_peaceful_guardian_cyclone_debuff", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifer_peaceful_guardian_cyclone_diminishing_return", "modifiers/heroes/peaceful_guardian/cyclone/modifer_peaceful_guardian_cyclone_diminishing_return", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifer_peaceful_guardian_cyclone_hurricane", "modifiers/heroes/peaceful_guardian/cyclone/modifer_peaceful_guardian_cyclone_hurricane", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifer_peaceful_guardian_cyclone_hurricane_debuff", "modifiers/heroes/peaceful_guardian/cyclone/modifer_peaceful_guardian_cyclone_hurricane_debuff", LUA_MODIFIER_MOTION_NONE)
-- wd 4th ability alt support (lua rewrite)
LinkLuaModifier("modifier_spirit_voodoo_spirit_shock_buff", "modifiers/heroes/spirit_voodoo/spirit_shock/modifier_spirit_voodoo_spirit_shock_buff", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_spirit_voodoo_spirit_shock_debuff", "modifiers/heroes/spirit_voodoo/spirit_shock/modifier_spirit_voodoo_spirit_shock_debuff", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_spirit_voodoo_spirit_shock_instant_casts", "modifiers/heroes/spirit_voodoo/spirit_shock/modifier_spirit_voodoo_spirit_shock_instant_casts", LUA_MODIFIER_MOTION_NONE)