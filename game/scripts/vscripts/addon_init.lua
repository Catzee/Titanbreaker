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
LinkLuaModifier("modifier_bonus_cast_range", "modifiers/modifier_bonus_cast_range", LUA_MODIFIER_MOTION_NONE)
--LinkLuaModifier("modifier_path_health_buff", "modifiers/modifier_path_health_buff", LUA_MODIFIER_MOTION_NONE)
-- fix for death with pl 6th ability buff due to heal after damage
LinkLuaModifier("modifier_godschosen_2", "modifiers/heroes/sanctified_crusader/shield_of_vengeance/modifier_godschosen_2", LUA_MODIFIER_MOTION_NONE)
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
-- wd 4th ability alt cast support (lua rewrite)
LinkLuaModifier("modifier_spirit_voodoo_spirit_shock_buff", "modifiers/heroes/spirit_voodoo/spirit_shock/modifier_spirit_voodoo_spirit_shock_buff", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_spirit_voodoo_spirit_shock_debuff", "modifiers/heroes/spirit_voodoo/spirit_shock/modifier_spirit_voodoo_spirit_shock_debuff", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_spirit_voodoo_spirit_shock_instant_casts", "modifiers/heroes/spirit_voodoo/spirit_shock/modifier_spirit_voodoo_spirit_shock_instant_casts", LUA_MODIFIER_MOTION_NONE)
-- silencer 3rd ability alt cast support (lua rewrite)
LinkLuaModifier("modifier_twilight_cleric_lightstream_buff", "modifiers/heroes/twilight_cleric/lightstream/modifier_twilight_cleric_lightstream_buff", LUA_MODIFIER_MOTION_NONE)
-- wild guardian
-- wild guardian: human form renew (HoT)
LinkLuaModifier("modifier_regrowth2", "modifiers/heroes/wild_guardian/renew/modifier_regrowth2", LUA_MODIFIER_MOTION_NONE)
-- dark seer
-- dark seer: shadow orbs
LinkLuaModifier("modifier_shadow_cleric_shadow_orbs", "modifiers/heroes/shadow_cleric/modifier_shadow_cleric_shadow_orbs", LUA_MODIFIER_MOTION_NONE)
-- dark seer: mindstorm
LinkLuaModifier("modifier_shadow_cleric_mindstorm_mindbender", "modifiers/heroes/shadow_cleric/mindstorm/modifier_shadow_cleric_mindstorm_mindbender", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_shadow_cleric_mindstorm_debuff", "modifiers/heroes/shadow_cleric/mindstorm/modifier_shadow_cleric_mindstorm_debuff", LUA_MODIFIER_MOTION_NONE)
-- dark seer: shadow prayer pain
LinkLuaModifier("modifier_shadow_cleric_shadow_prayer_pain_debuff", "modifiers/heroes/shadow_cleric/shadow_prayer_pain/modifier_shadow_cleric_shadow_prayer_pain_debuff", LUA_MODIFIER_MOTION_NONE)
-- dark seer: dream feast
LinkLuaModifier("modifier_shadow_cleric_dream_feast_buff", "modifiers/heroes/shadow_cleric/dream_feast/modifier_shadow_cleric_dream_feast_buff", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_shadow_cleric_dream_feast_debuff", "modifiers/heroes/shadow_cleric/dream_feast/modifier_shadow_cleric_dream_feast_debuff", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_shadow_cleric_dream_feast_tentacle", "modifiers/heroes/shadow_cleric/dream_feast/modifier_shadow_cleric_dream_feast_tentacle", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_shadow_cleric_dream_feast_tentacle_debuff", "modifiers/heroes/shadow_cleric/dream_feast/modifier_shadow_cleric_dream_feast_tentacle_debuff", LUA_MODIFIER_MOTION_NONE)
-- dark seer: nightmare
LinkLuaModifier("modifier_shadow_cleric_nightmare_buff", "modifiers/heroes/shadow_cleric/nightmare/modifier_shadow_cleric_nightmare_buff", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_shadow_cleric_nightmare_debuff", "modifiers/heroes/shadow_cleric/nightmare/modifier_shadow_cleric_nightmare_debuff", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_shadow_cleric_nightmare_internal_buff", "modifiers/heroes/shadow_cleric/nightmare/modifier_shadow_cleric_nightmare_internal_buff", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_shadow_cleric_nightmare_spell_resistance_buff", "modifiers/heroes/shadow_cleric/nightmare/modifier_shadow_cleric_nightmare_spell_resistance_buff", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_shadow_cleric_nightmare_spell_resistance_inner_cd", "modifiers/heroes/shadow_cleric/nightmare/modifier_shadow_cleric_nightmare_spell_resistance_inner_cd", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_shadow_cleric_nightmare_aura", "modifiers/heroes/shadow_cleric/nightmare/modifier_shadow_cleric_nightmare_aura", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_shadow_cleric_nightmare_aura_buff", "modifiers/heroes/shadow_cleric/nightmare/modifier_shadow_cleric_nightmare_aura_buff", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_shadow_cleric_nightmare_aura_inner_cd", "modifiers/heroes/shadow_cleric/nightmare/modifier_shadow_cleric_nightmare_aura_inner_cd", LUA_MODIFIER_MOTION_NONE)
-- dark seer: path of darkness
LinkLuaModifier("modifier_shadow_cleric_path_of_darkness_armor_buff", "modifiers/heroes/shadow_cleric/path_of_darkness/modifier_shadow_cleric_path_of_darkness_armor_buff", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_shadow_cleric_path_of_darkness_buff", "modifiers/heroes/shadow_cleric/path_of_darkness/modifier_shadow_cleric_path_of_darkness_buff", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_shadow_cleric_path_of_darkness_mana_shield_buff", "modifiers/heroes/shadow_cleric/path_of_darkness/modifier_shadow_cleric_path_of_darkness_mana_shield_buff", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_shadow_cleric_path_of_darkness_summons_buff", "modifiers/heroes/shadow_cleric/path_of_darkness/modifier_shadow_cleric_path_of_darkness_summons_buff", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_shadow_cleric_path_of_darkness_buff_inner_cd", "modifiers/heroes/shadow_cleric/path_of_darkness/modifier_shadow_cleric_path_of_darkness_buff_inner_cd", LUA_MODIFIER_MOTION_NONE)
-- dark seer: path of darkness (class item)
LinkLuaModifier("modifier_shadow_cleric_path_of_darkness_shadow_priest_form", "modifiers/heroes/shadow_cleric/path_of_darkness/modifier_shadow_cleric_path_of_darkness_shadow_priest_form", LUA_MODIFIER_MOTION_NONE)
-- axe: wounding strike
LinkLuaModifier("modifier_wounding_strike_heal_debuff", "modifiers/heroes/brutal_brawler/wounding_strike/modifier_wounding_strike_heal_debuff", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_wounding_strike_bleed_debuff", "modifiers/heroes/brutal_brawler/wounding_strike/modifier_wounding_strike_bleed_debuff", LUA_MODIFIER_MOTION_NONE)
-- for lua pets
LinkLuaModifier("modifier_pet_system_lua", "modifiers/heroes/modifier_pet_system_lua", LUA_MODIFIER_MOTION_NONE)
-- frostwyrm fury (path talent)
LinkLuaModifier("modifier_frostwyrm_fury_buff", "modifiers/path_talents/modifier_frostwyrm_fury_buff", LUA_MODIFIER_MOTION_NONE)
-- swipe of ursa proc duration fix (divine item)
LinkLuaModifier("modifier_swipe_of_ursa_proc", "modifiers/path_talents/modifier_swipe_of_ursa_proc", LUA_MODIFIER_MOTION_NONE)

-- animation.lua modifiers
LinkLuaModifier( "modifier_animation", "libraries/modifiers/modifier_animation.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_animation_translate", "libraries/modifiers/modifier_animation_translate.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_animation_translate_permanent", "libraries/modifiers/modifier_animation_translate_permanent.lua", LUA_MODIFIER_MOTION_NONE )

-- autocasts
LinkLuaModifier( "modifier_auto_casts", "modifiers/modifier_auto_casts", LUA_MODIFIER_MOTION_NONE )