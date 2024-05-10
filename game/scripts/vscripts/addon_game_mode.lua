--dotacustomgames@valvesoftware.com
--[[
Overthrow Game Mode
]]

_G.nNEUTRAL_TEAM = 4
_G.nCOUNTDOWNTIMER = 3901


---------------------------------------------------------------------------
-- COverthrowGameMode class
---------------------------------------------------------------------------
if COverthrowGameMode == nil then
	_G.COverthrowGameMode = class({}) -- put COverthrowGameMode in the global scope
	--refer to: http://stackoverflow.com/questions/6586145/lua-require-with-global-local
end

COverthrowGameMode.nextBossID = 1
---------------------------------------------------------------------------
-- Required .lua files
---------------------------------------------------------------------------
require( "events" )
require( "items" )
require( "utility_functions" )
require("timers")
require("game_mechanics")
require("ragesystem")
require("animations")
require("physics")
require('libraries/attachments')
require('libraries/popups')
require('libraries/notifications')
require("statcollection/init")
require("overrides/require")
require("debug_tools")

---------------------------------------------------------------------------
-- Precache
---------------------------------------------------------------------------
function Precache( context )
	--Cache the gold bags
  PrecacheItemByNameSync( "item_bag_of_gold", context )
  PrecacheResource( "particle", "particles/items2_fx/veil_of_discord.vpcf", context )	

  PrecacheItemByNameSync( "item_treasure_chest", context )
  PrecacheModel( "item_treasure_chest", context )

  --Cache the creature models
  PrecacheUnitByNameAsync( "npc_dota_creature_basic_zombie", function(unit) end )
  PrecacheModel( "npc_dota_creature_basic_zombie", context )

  PrecacheUnitByNameAsync( "npc_dota_creature_tutorial_dummy", function(unit) end )
  PrecacheModel( "npc_dota_creature_tutorial_dummy", context )

  PrecacheUnitByNameAsync( "npc_dota_creature_berserk_zombie", function(unit) end )
  PrecacheModel( "npc_dota_creature_berserk_zombie", context )

  PrecacheUnitByNameAsync( "dummy_unit_new", function(unit) end )
  PrecacheModel( "dummy_unit_new", context )


  PrecacheUnitByNameAsync( "bear_trap", function(unit) end )
  PrecacheModel( "bear_trap", context )
  PrecacheUnitByNameAsync( "npc_dota_creature_ghostwolf", function(unit) end )
  PrecacheModel( "npc_dota_creature_ghostwolf", context )
  PrecacheUnitByNameAsync( "npc_dota_creature_storm_twins", function(unit) end )
  PrecacheModel( "npc_dota_creature_storm_twins", context )
  PrecacheUnitByNameAsync( "glacier_crack", function(unit) end )
  PrecacheModel( "glacier_crack", context )
  PrecacheUnitByNameAsync( "npc_dota_creature_bear", function(unit) end )
  PrecacheModel( "npc_dota_creature_bear", context )
  PrecacheUnitByNameAsync( "npc_dota_creature_wolf", function(unit) end )
  PrecacheModel( "npc_dota_creature_wolf", context )


  PrecacheUnitByNameAsync( "npc_dota_treasure_courier", function(unit) end )
  PrecacheModel( "npc_dota_treasure_courier", context )

  PrecacheUnitByNameAsync( "npc_dota_creature_felhunter", function(unit) end )
  PrecacheModel( "npc_dota_creature_felhunter", context )

  PrecacheUnitByNameAsync( "ranger_crow", function(unit) end )
  PrecacheModel( "ranger_crow", context )

  PrecacheUnitByNameAsync( "npc_dota_creature_felhunterdummy", function(unit) end )
  PrecacheModel( "npc_dota_creature_felhunterdummy", context )

  PrecacheUnitByNameAsync( "npc_dota_creature_shadow_creeper", function(unit) end )
  PrecacheModel( "npc_dota_creature_shadow_creeper", context )

  PrecacheUnitByNameAsync( "npc_dota_creature_waterelemental", function(unit) end )
  PrecacheModel( "npc_dota_creature_waterelemental", context )

  PrecacheUnitByNameAsync( "npc_dota_creature_basecontrol", function(unit) end )
  PrecacheModel( "npc_dota_creature_basecontrol", context )

  PrecacheUnitByNameAsync( "pve_firebabydragon", function(unit) end )
  PrecacheModel( "pve_firebabydragon", context )

  PrecacheUnitByNameAsync( "pve_demon", function(unit) end )
  PrecacheModel( "pve_demon", context )

  PrecacheUnitByNameAsync( "dummy_dancing_rune", function(unit) end )
  PrecacheModel( "dummy_dancing_rune", context )

  PrecacheUnitByNameAsync( "wolf_pet", function(unit) end )
  PrecacheUnitByNameAsync( "snowwolf_pet", function(unit) end )
  PrecacheUnitByNameAsync( "npc_dota_creature_shadow_creeper_pve", function(unit) end )
  

  --petsPrecacheUnit
  PrecacheUnitByNameAsync( "npc_dota_creature_ghoul", function(unit) end )
  PrecacheUnitByNameAsync( "ranger_bloodwolf", function(unit) end )
  PrecacheUnitByNameAsync( "npc_dota_creature_uri", function(unit) end )
  

  --pendulum and glaive affix
  PrecacheUnitByNameAsync( "npc_dota_pendulum_trap_ward", function(unit) end )
  PrecacheResource( "particle", "particles/econ/items/magnataur/shock_of_the_anvil/magnataur_shockanvil.vpcf", context )
  PrecacheResource( "particle", "particles/traps/pendulum/wheel_scrape.vpcf", context )
  PrecacheResource( "particle", "particles/traps/pendulum/blade_trails.vpcf", context )
  PrecacheResource( "particle", "particles/units/heroes/hero_life_stealer/life_stealer_infest_emerge_blood01.vpcf", context )
  PrecacheResource( "particle", "particles/units/heroes/hero_magnataur/magnataur_shockwave.vpcf", context )
  PrecacheResource( "soundfile",  "soundevents/soundevents_conquest.vsndevts", context)
  PrecacheResource( "particle", "particles/drow_ti6_silence_gold_wave_no_arrow.vpcf", context )
  PrecacheResource( "particle", "particles/econ/items/juggernaut/bladekeeper_bladefury/_dc_juggernaut_blade_fury.vpcf", context )
  PrecacheResource( "particle", "particles/venomancer_venomous_gale_viper.vpcf", context )
  PrecacheResource( "particle", "particles/units/heroes/hero_dragon_knight/dragon_knight_breathe_fire.vpcf", context )
  PrecacheResource( "particle", "particles/fireball_linear_5.vpcf", context )

  --5.4
  PrecacheResource( "soundfile",  "soundevents/game_sounds_heroes/game_sounds_medusa.vsndevts", context)
  PrecacheResource( "particle", "particles/econ/items/wisp/wisp_death_ti7_model.vpcf", context )
  PrecacheResource( "particle", "particles/econ/items/wisp/wisp_death_ti7.vpcf", context )
  PrecacheResource( "particle", "particles/bloodseeker_ti7_overhead_vision_model_small.vpcf", context )
  PrecacheResource( "particle", "particles/econ/items/beastmaster/bm_shoulder_ti7/bm_shoulder_ti7_roar.vpcf", context )
  PrecacheResource( "particle", "particles/econ/items/antimage/antimage_ti7/antimage_blink_start_ti7_ashes.vpcf", context )
  PrecacheResource( "particle", "particles/econ/items/antimage/antimage_ti7/antimage_blink_start_ti7_pyro.vpcf", context )
  PrecacheResource( "particle", "particles/units/heroes/hero_enigma/enigma_ambient_body.vpcf", context )
  PrecacheResource( "particle", "particles/econ/items/monkey_king/arcana/death/mk_spring_arcana_death_souls.vpcf", context )
  PrecacheResource( "particle", "particles/econ/items/monkey_king/arcana/death/mk_spring_arcana_death_souls_line.vpcf", context )
  PrecacheResource( "particle", "particles/units/heroes/hero_sandking/sandking_sandstorm_sand.vpcf", context )
  PrecacheResource( "particle", "particles/units/heroes/hero_sandking/sandking_sandstorm_start.vpcf", context )
  PrecacheResource( "particle", "particles/econ/items/bristleback/ti7_head_nasal_goo/bristleback_ti7_crimson_nasal_goo_debuff.vpcf", context )
  PrecacheResource( "particle", "particles/econ/items/wisp/wisp_relocate_timer_buff_ti7_sparkle_blue.vpcf", context )
  PrecacheResource( "particle", "particles/econ/items/bristleback/ti7_head_nasal_goo/bristleback_ti7_nasal_goo_debuff.vpcf", context )
  PrecacheResource( "particle", "particles/econ/items/weaver/weaver_golden_immortal_ti7/weaver_golden_swarm_infected_debuff_ti7_ground_rings.vpcf", context )
  PrecacheResource( "particle", "particles/econ/items/invoker/invoker_apex/invoker_sun_strike_team_big_ray_immortal1.vpcf", context )
  PrecacheResource( "particle", "particles/units/heroes/hero_windrunner/wr_taunt_kiss_heart.vpcf", context )
  PrecacheResource( "particle", "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_loadout.vpcf", context )
  PrecacheResource( "particle", "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_gravemarker_lvl2.vpcf", context )
  PrecacheResource( "particle", "particles/generic_hero_status/death_tombstone.vpcf", context )
  PrecacheResource( "particle", "particles/units/heroes/hero_axe/axe_culling_blade_kill.vpcf", context )
  PrecacheResource( "particle", "particles/fire_ring_1.vpcf", context )
  PrecacheResource( "particle", "particles/units/heroes/hero_ursa/ursa_overpower_cast.vpcf", context )
  PrecacheResource( "particle", "particles/econ/items/axe/axe_weapon_bloodchaser/axe_attack_blur_counterhelix_bloodchaser.vpcf", context )
  PrecacheResource( "particle", "particles/econ/items/legion/legion_overwhelming_odds_ti7/legion_commander_odds_ti7_proj_chunk_glow.vpcf", context )
  PrecacheResource( "particle", "particles/units/heroes/hero_nevermore/nevermore_loadout_ember_swirl.vpcf", context )
  PrecacheResource( "particle", "particles/econ/items/troll_warlord/troll_warlord_ti7_axe/troll_ti7_axe_bash_explosion.vpcf", context )
  PrecacheResource( "particle", "particles/econ/items/shadow_demon/sd_ti7_shadow_poison/sd_ti7_shadow_poison_release_crush_splash.vpcf", context )
  PrecacheResource( "particle", "particles/creep_radiant_hulk_swipe_left.vpcf", context )
  PrecacheResource( "particle", "particles/creeps/lane_creeps/creep_radiant_hulk_swipe_left.vpcf", context )
  PrecacheResource( "particle", "particles/creeps/lane_creeps/creep_radiant_hulk_swipe_right.vpcf", context )
  PrecacheResource( "particle", "particles/econ/items/oracle/oracle_fortune_ti7/oracle_fortune_ti7_aoe.vpcf", context )
  PrecacheResource( "particle", "particles/creeps/lane_creeps/creep_radiant_hulk_swipe_right.vpcf", context )
  PrecacheResource( "particle", "particles/creeps/lane_creeps/creep_radiant_hulk_swipe_right.vpcf", context )
  PrecacheResource( "particle", "particles/creeps/lane_creeps/creep_radiant_hulk_swipe_right.vpcf", context )
  PrecacheResource( "particle", "particles/creeps/lane_creeps/creep_radiant_hulk_swipe_right.vpcf", context )
  PrecacheResource( "particle", "particles/econ/items/warlock/warlock_lost_ores/golem_lores_hulk_swipe.vpcf", context )
  PrecacheResource( "particle", "particles/econ/items/warlock/warlock_lost_ores/golem_lores_hulk_swipe_glow.vpcf", context )
  PrecacheResource( "particle", "particles/econ/items/warlock/warlock_lost_ores/golem_lores_hulk_swipe_left.vpcf", context )
  PrecacheResource( "particle", "particles/econ/items/warlock/warlock_lost_ores/golem_lores_hulk_swipe_right.vpcf", context )
  PrecacheResource( "particle", "particles/cm_ti7_immortal_base_attack_snowball_big.vpcf", context )
  PrecacheResource( "particle", "particles/status_fx/status_effect_iceblast.vpcf", context )
  PrecacheResource( "particle", "particles/drow_frost_arrow_big.vpcf", context )
  PrecacheResource( "particle", "particles/econ/items/zeus/zeus_ti8_immortal_arms/zeus_ti8_immortal_arc.vpcf", context )
  PrecacheResource( "particle", "particles/econ/items/witch_doctor/wd_ti8_immortal_head/wd_ti8_immortal_maledict_ring.vpcf", context )
  
  
  PrecacheResource( "model", "models/heroes/wraith_king/wraith_frost.vmdl", context )
  PrecacheResource( "model", "models/props/traps/pendulum/pendulum.vmdl", context )
  
  
  
  PrecacheResource( "soundfile",  "soundevents/game_sounds_heroes/game_sounds_sandking.vsndevts", context)
  
  
  --multi ele item
  PrecacheResource( "particle", "particles/orb_rotating_fire.vpcf", context )
  PrecacheResource( "particle", "particles/orb_rotating_holy.vpcf", context )
  PrecacheResource( "particle", "particles/orb_rotating_frost.vpcf", context )
  PrecacheResource( "particle", "particles/orb_rotating_shadow.vpcf", context )
  PrecacheResource( "particle", "particles/orb_rotating_nature.vpcf", context )
  PrecacheResource( "particle", "particles/orb_rotating_chaos.vpcf", context )
  PrecacheResource( "particle", "particles/orb_rotating_arcane.vpcf", context )

  --item quality rewards
  PrecacheResource( "particle", "particles/econ/items/bristleback/ti7_head_nasal_goo/bristleback_ti7_nasal_goo_debuff.vpcf", context )
  PrecacheResource( "particle", "particles/invoker_chaos_meteor_fly_blue.vpcf", context )
  PrecacheResource( "particle", "particles/invoker_chaos_meteor_fly_blue_fast.vpcf", context )
  PrecacheResource( "particle", "particles/econ/items/mirana/mirana_starstorm_bow/mirana_starstorm_starfall_attack.vpcf", context )
  PrecacheResource( "particle", "particles/invoker_chaos_meteor_fly_fast.vpcf", context )
  
  
  
  --totem
  PrecacheUnitByNameAsync( "npc_dota_creature_lifeward", function(unit) end )
  PrecacheUnitByNameAsync( "npc_dota_creature_lifeward2", function(unit) end )

  --dk rune blade
  PrecacheUnitByNameAsync( "dummy_dancing_rune", function(unit) end )
  PrecacheUnitByNameAsync( "temple_chest_3", function(unit) end )
  PrecacheUnitByNameAsync( "temple_chest_2", function(unit) end )
  PrecacheUnitByNameAsync( "temple_chest", function(unit) end )
  
  --for prot pala models
  PrecacheUnitByNameAsync( "npc_dota_hero_legion_commander", function(unit) end )
  PrecacheResource( "model", "models/items/legion_commander/valkyrie_head/valkyrie_head.vmdl", context )
  PrecacheResource( "model", "models/items/legion_commander/valkyrie_shoulder/valkyrie_shoulder.vmdl", context )
  PrecacheResource( "model", "models/items/dragon_knight/oblivion_blazer_offhand/oblivion_blazer_offhand.vmdl", context )
  PrecacheResource( "model", "models/items/omniknight/grey_night_weapon/grey_night_weapon.vmdl", context )
  --for blood seeker community model
  PrecacheResource( "model", "models/items/chaos_knight/rising_chaos_shield/rising_chaos_shield.vmdl", context )
  PrecacheResource( "model", "models/heroes/chaos_knight/chaos_knight_horse_head.vmdl", context )
  PrecacheResource( "model", "models/items/chaos_knight/rising_chaos_shield/rising_chaos_shield.vmdl", context )

  --PrecacheModel("models/items/queenofpain/unchained_tormented_wings/unchained_tormented_wings.vmdl", context)
  PrecacheResource( "model", "models/items/queenofpain/unchained_tormented_wings/unchained_tormented_wings.vmdl", context )
  PrecacheResource( "model", "models/heroes/undying/undying_flesh_golem.vmdl", context )

  --bear druid
  PrecacheResource( "model", "models/heroes/lone_druid/true_form.vmdl", context )
  PrecacheResource( "model", "models/items/lone_druid/true_form/rabid_black_bear/rabid_black_bear.vmdl", context )
  PrecacheResource( "model", "models/items/lone_druid/true_form/dark_wood_true_form/dark_wood_true_form.vmdl", context )

  --5.2 affixes
  PrecacheResource( "particle", "particles/units/heroes/hero_arc_warden/arc_warden_magnetic.vpcf", context )
  PrecacheResource( "particle", "particles/ringofsilence.vpcf", context )
  PrecacheResource( "particle", "particles/econ/items/lifestealer/lifestealer_immortal_backbone/status_effect_life_stealer_immortal_rage.vpcf", context )
  PrecacheResource( "particle", "particles/econ/items/morphling/morphling_crown_of_tears/morphling_crown_waveform.vpcf", context )
  PrecacheResource( "particle", "particles/econ/items/spirit_breaker/spirit_breaker_iron_surge/spirit_breaker_charge_target_iron.vpcf", context )
  PrecacheResource( "particle", "particles/econ/items/spirit_breaker/spirit_breaker_iron_surge/spirit_breaker_charge_iron.vpcf", context )
  PrecacheResource( "particle", "particles/units/heroes/hero_morphling/morphling_morph_agi.vpcf", context )
  PrecacheResource( "particle", "particles/ringofholy.vpcf", context )
  PrecacheResource( "particle", "pparticles/status_fx/status_effect_terrorblade_reflection.vpcf", context )
  PrecacheResource( "particle", "particles/rock_arrow.vpcf", context )
  --5.3 enchantress
  PrecacheResource( "particle", "particles/econ/items/treant_protector/ti7_shoulder/treant_ti7_livingarmor_beam_a.vpcf", context )
  PrecacheResource( "particle", "particles/units/heroes/hero_zeus/zeus_cloud_strike.vpcf", context )
  
  PrecacheResource( "particle", "particles/dazzle_ti6_shallow_grave_gold_ground_ring_red_dmg.vpcf", context )
  PrecacheResource( "particle", "particles/dazzle_ti6_shallow_grave_gold_ground_ring_shadow_bounce.vpcf", context )
  
  

  --Cache new particles
  
  PrecacheResource( "particle", "particles/units/heroes/hero_magnataur/magnataur_shockwave.vpcf", context )
  PrecacheResource( "particle", "particles/econ/events/nexon_hero_compendium_2014/teleport_end_nexon_hero_cp_2014.vpcf", context )
  PrecacheResource( "particle", "particles/leader/leader_overhead.vpcf", context )
  PrecacheResource( "particle", "particles/last_hit/last_hit.vpcf", context )
  PrecacheResource( "particle", "particles/units/heroes/hero_zuus/zeus_taunt_coin.vpcf", context )
  PrecacheResource( "particle", "particles/addons_gameplay/player_deferred_light.vpcf", context )
  PrecacheResource( "particle", "particles/items_fx/black_king_bar_avatar.vpcf", context )
  PrecacheResource( "particle", "particles/treasure_courier_death.vpcf", context )
  PrecacheResource( "particle", "particles/units/heroes/hero_templar_assassin/templar_assassin_trap_rings_inner.vpcf", context )
  PrecacheResource( "particle", "particles/castbar.vpcf", context )
  PrecacheResource( "particle", "particles/castbar3.vpcf", context )
  PrecacheResource( "particle", "particles/castbar25.vpcf", context )
  PrecacheResource( "particle", "particles/castbardynamic.vpcf", context )
  PrecacheResource( "particle", "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_crit_impact_dagger_arcana.vpcf", context )
  PrecacheResource( "particle", "particles/units/heroes/hero_dazzle/dazzle_armor_enemy_shield.vpcf", context )
  PrecacheResource( "particle", "particles/healingdigit1.vpcf", context )
  PrecacheResource( "particle", "particles/criticalstrike.vpcf", context )
  PrecacheResource( "particle", "particles/criticalheal.vpcf", context )
  PrecacheResource( "particle", "particles/units/heroes/hero_obsidian_destroyer/obsidian_destroyer_sanity_eclipse_mana_loss.vpcf", context )
  PrecacheResource( "particle", "particles/fireball_4.vpcf", context )
  PrecacheResource( "particle", "particles/fireball_17.vpcf", context )
  PrecacheResource( "particle", "particles/silencer_curse_skull_purple.vpcf", context )
  PrecacheResource( "particle", "particles/ring_fire_spike.vpcf", context )
  PrecacheResource( "particle", "particles/units/heroes/hero_necrolyte/necrolyte_spirit_ground_aura.vpcf", context )
  PrecacheResource( "particle", "particles/units/heroes/hero_morphling/morphling_base_attack.vpcf", context )
  

  --version 2
  
  PrecacheResource( "particle", "particles/econ/items/dazzle/dazzle_darkclaw/dazzle_darkclaw_poison_touch.vpcf", context )
  PrecacheResource( "particle", "particles/neutral_fx/mud_golem_hurl_boulder.vpcf", context )
  PrecacheResource( "particle", "particles/units/heroes/hero_tidehunter/tidehunter_gush.vpcf", context )
  PrecacheResource( "particle", "particles/base_attacks/ranged_tower_good.vpcf", context )
  PrecacheResource( "particle", "particles/fireball_15.vpcf", context )
  PrecacheResource( "particle", "particles/fireball_9.vpcf", context )
  PrecacheResource( "particle", "particles/fireball_thunder.vpcf", context )
  PrecacheResource( "particle", "particles/units/heroes/hero_treant/treant_leech_seed_projectile.vpcf", context )
  PrecacheResource( "particle", "particles/econ/items/viper/viper_immortal_tail_ti8/viper_immortal_ti8_nethertoxin_proj.vpcf", context )
  PrecacheResource( "particle", "particles/magnataur_shockwave_shadow.vpcf", context )
  PrecacheResource( "particle", "particles/units/heroes/hero_dazzle/dazzle_shallow_grave_playerglow.vpcf", context )
  PrecacheResource( "particle", "particles/units/heroes/hero_troll_warlord/troll_warlord_battletrance_buff.vpcf", context )
  PrecacheResource( "particle", "particles/econ/courier/courier_trail_divine/courier_divine_ambient.vpcf", context )
  PrecacheResource( "particle", "particles/units/heroes/hero_treant/treant_overgrowth_cast.vpcf", context )
  PrecacheResource( "particle", "particles/econ/items/viper/viper_ti7_immortal/viper_poison_debuff_ti7.vpcf", context )
  PrecacheResource( "particle", "particles/econ/items/omniknight/hammer_ti6_immortal/omniknight_purification_immortal_cast.vpcf", context )
  PrecacheResource( "particle", "particles/econ/items/sven/sven_ti7_sword/sven_ti7_sword_spell_great_cleave_gods_strength.vpcf", context )
  PrecacheResource( "particle", "particles/econ/items/sven/sven_ti7_sword/sven_ti7_loadout_burst.vpcf", context )
  PrecacheResource( "particle", "particles/necro_ti7_immortal_scythe_start_only_ghost.vpcf", context )
  PrecacheResource( "particle", "particles/econ/items/spectre/spectre_transversant_soul/spectre_transversant_spectral_dagger_path_owner_energy.vpcf", context )
  PrecacheResource( "particle", "particles/econ/items/lifestealer/lifestealer_immortal_backbone_gold/lifestealer_immortal_backbone_gold_rage.vpcf", context )

  --test precache for temple heroes
    --[[
    PrecacheUnitByNameAsync( "npc_dota_hero_drow_ranger", function(unit) end )
    PrecacheUnitByNameAsync( "npc_dota_hero_windrunner", function(unit) end )
    PrecacheUnitByNameAsync( "npc_dota_hero_sniper", function(unit) end )

    PrecacheUnitByNameAsync( "npc_dota_hero_beastmaster", function(unit) end )
    PrecacheUnitByNameAsync( "npc_dota_hero_dragon_knight", function(unit) end )
    PrecacheUnitByNameAsync( "npc_dota_hero_axe", function(unit) end )

    PrecacheUnitByNameAsync( "npc_dota_hero_lina", function(unit) end )
    PrecacheUnitByNameAsync( "npc_dota_hero_crystal_maiden", function(unit) end )
    PrecacheUnitByNameAsync( "npc_dota_hero_invoker", function(unit) end )

    PrecacheUnitByNameAsync( "npc_dota_hero_shadow_shaman", function(unit) end )
    PrecacheUnitByNameAsync( "npc_dota_hero_witch_doctor", function(unit) end )
    PrecacheUnitByNameAsync( "npc_dota_hero_bloodseeker", function(unit) end )

    PrecacheUnitByNameAsync( "npc_dota_hero_omniknight", function(unit) end )
    PrecacheUnitByNameAsync( "npc_dota_hero_legion_commander", function(unit) end )
    PrecacheUnitByNameAsync( "npc_dota_hero_phantom_lancer", function(unit) end )

    PrecacheUnitByNameAsync( "npc_dota_hero_vengefulspirit", function(unit) end )
    PrecacheUnitByNameAsync( "npc_dota_hero_furion", function(unit) end )

    PrecacheUnitByNameAsync( "npc_dota_hero_oracle", function(unit) end )
    PrecacheUnitByNameAsync( "npc_dota_hero_dark_seer", function(unit) end )
    PrecacheUnitByNameAsync( "npc_dota_hero_silencer", function(unit) end )

    PrecacheUnitByNameAsync( "npc_dota_hero_skeleton_king", function(unit) end )
    PrecacheUnitByNameAsync( "npc_dota_hero_pudge", function(unit) end )
    PrecacheUnitByNameAsync( "npc_dota_hero_sven", function(unit) end )

    PrecacheUnitByNameAsync( "npc_dota_hero_phantom_assassin", function(unit) end )
    PrecacheUnitByNameAsync( "npc_dota_hero_bounty_hunter", function(unit) end )
    PrecacheUnitByNameAsync( "npc_dota_hero_riki", function(unit) end )]]

    --holy edge
    PrecacheResource( "particle", "particles/econ/items/omniknight/hammer_ti6_immortal/omniknight_purification_immortal_cast.vpcf", context )  
    --shadowmourne
    PrecacheResource( "particle", "particles/econ/items/invoker/invoker_ti6/invoker_tornado_ti6_funnel.vpcf", context )  
    

    PrecacheResource( "soundfile",  "soundevents/game_sounds_heroes/game_sounds_crystalmaiden.vsndevts", context)
    PrecacheResource( "soundfile",  "soundevents/voscripts/game_sounds_vo_crystalmaiden.vsndevts", context)
    PrecacheResource( "soundfile",  "soundevents/game_sounds_heroes/game_sounds_lion.vsndevts", context)
    PrecacheResource( "soundfile",  "soundevents/game_sounds_heroes/game_sounds_silencer.vsndevts", context)
    PrecacheResource( "soundfile",  "soundevents/voscripts/game_sounds_vo_silencer.vsndevts", context)
    PrecacheResource( "soundfile",  "soundevents/voscripts/game_sounds_vo_terrorblade.vsndevts", context)
    PrecacheResource( "soundfile",  "soundevents/game_sounds_heroes/game_sounds_lina.vsndevts", context)
    PrecacheResource( "soundfile",  "soundevents/game_sounds_heroes/game_sounds_phantom_assassin.vsndevts", context)
    PrecacheResource( "soundfile",  "soundevents/game_sounds_heroes/game_sounds_invoker.vsndevts", context)
    PrecacheResource( "soundfile",  "soundevents/game_sounds_heroes/game_sounds_broodmother.vsndevts", context)
    PrecacheResource( "soundfile",  "soundevents/game_sounds_heroes/game_sounds_mirana.vsndevts", context)
    PrecacheResource( "soundfile",  "soundevents/voscripts/game_sounds_vo_beastmaster.vsndevts", context)
    PrecacheResource( "soundfile",  "soundevents/game_sounds_heroes/game_sounds_beastmaster.vsndevts", context)
    


    --act enter voice lines
    PrecacheResource( "soundfile",  "soundevents/voscripts/game_sounds_vo_lycan.vsndevts", context)
    PrecacheResource( "soundfile",  "soundevents/voscripts/game_sounds_vo_venomancer.vsndevts", context)
    PrecacheResource( "soundfile",  "soundevents/voscripts/game_sounds_vo_tidehunter.vsndevts", context)
    PrecacheResource( "soundfile",  "soundevents/voscripts/game_sounds_vo_warlock.vsndevts", context)
    PrecacheResource( "soundfile",  "soundevents/voscripts/game_sounds_vo_viper.vsndevts", context)
    PrecacheResource( "soundfile",  "soundevents/voscripts/game_sounds_vo_nevermore.vsndevts", context)
    PrecacheResource( "soundfile",  "soundevents/voscripts/game_sounds_vo_chaos_knight.vsndevts", context)
    PrecacheResource( "soundfile",  "soundevents/voscripts/game_sounds_vo_ogre_magi.vsndevts", context)
    PrecacheResource( "soundfile",  "soundevents/voscripts/game_sounds_vo_bane.vsndevts", context)
    PrecacheResource( "soundfile",  "soundevents/voscripts/game_sounds_vo_dazzle.vsndevts", context)
    PrecacheResource( "soundfile",  "soundevents/voscripts/game_sounds_vo_invoker.vsndevts", context)
    PrecacheResource( "soundfile",  "soundevents/game_sounds_heroes/game_sounds_razor.vsndevts", context)
    PrecacheResource( "soundfile",  "soundevents/voscripts/game_sounds_vo_omniknight.vsndevts", context)
    PrecacheResource( "soundfile",  "soundevents/voscripts/game_sounds_vo_treant.vsndevts", context)
    PrecacheResource( "soundfile",  "soundevents/voscripts/game_sounds_vo_furion.vsndevts", context)
    PrecacheResource( "soundfile",  "soundevents/voscripts/game_sounds_vo_medusa.vsndevts", context)
    PrecacheResource( "soundfile",  "soundevents/voscripts/game_sounds_vo_death_prophet.vsndevts", context)
    

    --zeus item and others
    PrecacheResource( "particle", "particles/units/heroes/hero_disruptor/disruptor_thunder_strike_aoe.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_disruptor/disruptor_thunder_strike_bolt.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/zeus/lightning_weapon_fx/zuus_lightning_bolt_castfx_ground2.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_zuus/zuus_thundergods_wrath_start.vpcf", context )

    PrecacheResource( "particle", "particles/units/heroes/hero_ogre_magi/ogre_magi_bloodlust_buff.vpcf", context )

    PrecacheResource( "particle", "particles/neutral_fx/ogre_magi_frost_armor.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/zeus/lightning_weapon_fx/zuus_base_attack_sparkles_immortal_lightning.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/zeus/lightning_weapon_fx/zuus_lightning_bolt_castfx_ground2.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_razor/storm_lightning_01_cloud.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_disruptor/disruptor_thunder_strike_aoe.vpcf", context )

    PrecacheResource( "particle", "particles/units/unit_greevil/greevil_transformation_runes.vpcf", context )
    PrecacheResource( "particle", "particles/units/unit_greevil/greevil_transformation_runes_b.vpcf", context )
    PrecacheResource( "particle", "particles/status_fx/status_effect_gods_strength.vpcf", context )
    PrecacheResource( "particle", "particles/status_fx/status_effect_legion_commander_duel.vpcf", context )

    PrecacheResource( "particle", "particles/units/heroes/hero_ancient_apparition/ancient_appartion_cold_feet_frozen_b.vpcf", context )
    PrecacheResource( "particle", "particles/status_fx/status_effect_frost.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/crystal_maiden/crystal_maiden_maiden_of_icewrack/maiden_freezing_field_snow_wolves.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/crystal_maiden/crystal_maiden_cowl_of_ice/maiden_crystal_nova_i_cowlofice.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/crystal_maiden/crystal_maiden_maiden_of_icewrack/maiden_arcana_ground_ambient.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_silencer/silencer_curse_cast_ring_rope.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/antimage/antimage_weapon_basher_ti5/am_manaburn_basher_ti_5_b.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_templar_assassin/templar_assassin_trap_explode_points.vpcf", context )

    PrecacheResource( "particle", "particles/units/heroes/hero_invoker/invoker_emp_lightning_thick_child.vpcf", context )

    PrecacheResource( "particle", "particles/econ/items/kunkka/divine_anchor/hero_kunkka_dafx_skills/kunkka_spell_torrent_splash_fxset.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_lycan/lycan_shapeshift_buff.vpcf", context )

    PrecacheResource( "particle", "particles/econ/items/batrider/hero_batrider_dpits3/batrider_dpits3_antennae.vpcf", context )


    PrecacheResource( "particle", "particles/econ/items/antimage/antimage_weapon_basher_ti5/antimage_manavoid_explode_b_basher_cast.vpcf", context )

    --gloves
    PrecacheResource( "particle", "particles/econ/items/queen_of_pain/qop_bloody_raven_wings/qop_bloody_raven_ambient.vpcf", context )
    PrecacheResource( "particle", "particles/chen_holy_persuasion_sparks_holy.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_tusk/tusk_ice_shards_projectile.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_crystalmaiden/maiden_frostbite_buff.vpcf", context )
    
    
    PrecacheResource( "particle", "particles/econ/items/tidehunter/tidehunter_divinghelmet/tidehunter_gush_diving_helmet_gold.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_nyx_assassin/nyx_assassin_spiked_carapace.vpcf", context )
    PrecacheResource( "particle", "particles/holywings.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_treant/treant_overgrowth_cast_tree.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_treant/treant_overgrowth_vines.vpcf", context )
    PrecacheResource( "particle", "particles/status_fx/status_effect_rupture.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_bloodseeker/bloodseeker_rupture.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_centaur/centaur_stampede_overhead.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_axe/axe_beserkers_call_owner_b.vpcf", context )
    PrecacheResource( "particle", "particles/castbar02.vpcf", context )
    PrecacheResource( "particle", "particles/castbar1.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_viper/viper_poison_attack_explosion.vpcf", context )
    PrecacheResource( "particle", "particles/silenceimunity.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/effigies/status_fx_effigies/status_effect_effigy_frosty_dire.vpcf", context )
    PrecacheResource( "particle", "particles/econ/courier/courier_shagbark/courier_shagbark_firefly_big.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_lone_druid/lone_druid_bear_entangle_body.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/lone_druid/lone_druid_cauldron/lone_druid_bear_entangle_spikes_f.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/lone_druid/lone_druid_cauldron/lone_druid_bear_entangle_ground_soil_cauldron.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_lone_druid/lone_druid_bear_entangle_ground_rocks.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/lone_druid/lone_druid_cauldron/druid_entangle_antler_dust.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/spirit_breaker/spirit_breaker_thundering_flail/spirit_breaker_thundering_flail_arc.vpcf", context )
    PrecacheResource( "particle", "particles/status_fx/status_effect_overpower.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_riki/riki_tricks_dagger_hit_sparks.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_vengeful/vengeful_wave_of_terror_recipient.vpcf", context )
    
    PrecacheResource( "particle", "particles/econ/items/abaddon/abaddon_alliance/abaddon_death_coil_explosion_alliance_e.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/abaddon/abaddon_alliance/abaddon_aphotic_shield_alliance_explosion.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/zeus/arcana_chariot/zeus_arcana_chariot.vpcf", context )
    
    
    
    PrecacheResource( "particle", "particles/castbar16.vpcf", context )
    PrecacheResource( "particle", "particles/castbar160.vpcf", context )
    PrecacheResource( "particle", "particles/castbar21.vpcf", context )
    PrecacheResource( "particle", "particles/castbar14.vpcf", context )

    --pve bosses
    PrecacheUnitByNameAsync( "mogushan_first_boss", function(unit) end )
    PrecacheUnitByNameAsync( "npc_dota_creature_pveboss1", function(unit) end )
    PrecacheModel( "npc_dota_creature_pveboss1", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_nyx_assassin/nyx_assassin_vendetta_blood.vpcf", context )
    PrecacheResource( "particle", "particles/hw_fx/hw_rosh_fireball.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/crystal_maiden/crystal_maiden_cowl_of_ice/maiden_crystal_nova_i_cowlofice.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/meepo/meepo_diggers_divining_rod/meepo_divining_rod_poof_start_ring_warpb.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/outworld_devourer/od_shards_exile/od_shards_exile_prison_start_base_ring.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_batrider/batrider_base_attack.vpcf", context )


    -- popups test
    PrecacheResource( "particle", "particles/units/heroes/hero_alchemist/alchemist_unstable_concoction_timer.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_legion_commander/legion_commander_duel_victory_text.vpcf", context )
    PrecacheResource( "particle", "particles/econ/events/killbanners/screen_killbanner_compendium14_firstblood.vpcf", context )
    PrecacheResource( "particle", "particles/econ/events/killbanners/screen_killbanner_compendium14_doublekill.vpcf", context )
    
    PrecacheResource( "particle", "particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_ambient_wing.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_oracle/oracle_fatesedict_ringc.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_mirana/mirana_starfall_trail.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_shadowraze_lava.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_ancient_apparition/ancient_appartion_cold_feet_frozen_b.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_shadowraze_end_smoke.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_bloodseeker/bloodseeker_bloodritual_impact_c.vpcf", context )
    PrecacheResource( "particle", "particles/generic_gameplay/generic_stunned_old.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/sniper/sniper_charlie/sniper_crosshair_b_charlie.vpcf", context )
    

    --basher
    PrecacheResource( "particle", "particles/units/heroes/hero_bloodseeker/bloodseeker_bloodritual_ring_b.vpcf", context )
    
    -- pve
    if GetMapName() == "beginner_pvp" then
     PrecacheUnitByNameAsync( "pve_fireegg", function(unit) end )
     PrecacheModel( "pve_fireegg", context )
   end

   PrecacheResource( "particle", "particles/units/heroes/hero_phoenix/phoenix_base_attack.vpcf", context )
   PrecacheResource( "particle", "particles/units/heroes/hero_weaver/weaver_base_attack.vpcf", context )
   PrecacheResource( "particle", "particles/units/heroes/hero_alchemist/alchemist_unstable_concoction_projectile_linear.vpcf", context )
   PrecacheResource( "particle", "particles/units/heroes/hero_shadow_demon/shadow_demon_shadow_poison_projectile.vpcf", context )
   PrecacheResource( "particle", "particles/econ/items/warlock/warlock_staff_glory/warlock_upheaval_hellborn_debuff.vpcf", context )
   PrecacheResource( "particle", "particles/units/heroes/hero_life_stealer/life_stealer_open_wounds_blood_trail01_corners.vpcf", context )
   PrecacheResource( "particle", "particles/units/heroes/hero_ursa/ursa_earthshock.vpcf", context )
   PrecacheResource( "particle", "particles/units/heroes/hero_abaddon/abaddon_borrowed_time.vpcf", context )
   PrecacheResource( "particle", "particles/units/heroes/hero_lich/lich_chain_frost.vpcf", context )
   PrecacheResource( "particle", "particles/units/heroes/hero_tusk/tusk_frozen_sigil_death.vpcf", context )
   PrecacheResource( "particle", "particles/units/heroes/hero_dazzle/dazzle_armor_friend_shield.vpcf", context )
   PrecacheResource( "particle", "particles/econ/items/sven/sven_warcry_ti5/sven_warcry_buff_ti_5.vpcf", context )
   PrecacheResource( "particle", "particles/units/heroes/hero_phoenix/phoenix_supernova_egg_ring_start.vpcf", context )
   PrecacheResource( "particle", "particles/econ/items/crystal_maiden/crystal_maiden_cowl_of_ice/maiden_crystal_nova_cowlofice.vpcf", context )
   PrecacheResource( "particle", "particles/units/heroes/hero_jakiro/jakiro_ice_path_shards.vpcf", context )
   PrecacheResource( "particle", "particles/units/heroes/hero_disruptor/disruptor_thunder_strike_aoe.vpcf", context )
   PrecacheResource( "particle", "particles/units/heroes/hero_disruptor/disruptor_kineticfield.vpcf", context )
   PrecacheResource( "particle", "particles/units/heroes/hero_stormspirit/stormspirit_ball_lightning_sphere.vpcf", context )
   PrecacheResource( "particle", "particles/econ/items/wraith_king/wraith_king_winterblight_weapon/wraith_king_winterblight_ambient.vpcf", context )
   PrecacheResource( "particle", "particles/econ/items/wraith_king/wraith_king_winterblight_weapon/wraith_king_winterblight_blade.vpcf", context )
   PrecacheResource( "particle", "particles/econ/items/wraith_king/wraith_king_winterblight_weapon/wraith_king_winterblight_blur.vpcf", context )
   PrecacheResource( "particle", "particles/units/heroes/hero_witchdoctor/witchdoctor_maledict_dot_skulls.vpcf", context )
   PrecacheResource( "particle", "particles/units/heroes/hero_centaur/centaur_warstomp_shockwave.vpcf", context )
   PrecacheResource( "particle", "particles/status_fx/status_effect_rupture.vpcf", context )
   PrecacheResource( "particle", "particles/items3_fx/glimmer_cape_initial_flash.vpcf", context )
   PrecacheResource( "particle", "particles/econ/items/antimage/antimage_weapon_basher_ti5_gold/am_manaburn_basher_ti_5_gold.vpcf", context )
   PrecacheResource( "particle", "particles/units/heroes/hero_silencer/silencer_last_word_status_ring_edge.vpcf", context )
   PrecacheResource( "particle", "particles/units/heroes/hero_arc_warden/arc_warden_tempest_cast_ring.vpcf", context )
   PrecacheResource( "particle", "particles/combopoint5.vpcf", context )
   PrecacheResource( "particle", "particles/combopoint3.vpcf", context )
   PrecacheResource( "particle", "particles/combopoint4.vpcf", context )
   PrecacheResource( "particle", "particles/units/heroes/hero_crystalmaiden/maiden_frostbite_buff.vpcf", context )

   --haste item
   
   PrecacheResource( "particle", "particles/base_destruction_fx/gbm_lvl3_glow.vpcf", context )
   PrecacheResource( "particle", "particles/units/heroes/hero_templar_assassin/templar_assassin_ambient_arc_glow.vpcf", context )
   PrecacheResource( "particle", "particles/units/heroes/hero_brewmaster/brewmaster_primal_split_storm_glow.vpcf", context )
   PrecacheResource( "particle", "particles/units/heroes/hero_mirana/mirana_moonlight_owner.vpcf", context )
   PrecacheResource( "particle", "particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_death_ember_suck.vpcf", context )
   PrecacheResource( "particle", "particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_base_attack_impact.vpcf", context )
   PrecacheResource( "particle", "particles/hw_fx/hw_rosh_fireball.vpcf", context )
   PrecacheResource( "particle", "particles/econ/items/dragon_knight/dk_immortal_dragon/dragon_knight_dragon_tail_dragon_iron_dragon.vpcf", context )
   PrecacheResource( "particle", "particles/econ/items/invoker/glorious_inspiration/invoker_forge_spirit_death_esl_explode.vpcf", context )
   
   PrecacheResource( "particle", "particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_ambient_head_ember.vpcf", context )
   PrecacheResource( "particle", "particles/econ/items/legion/legion_weapon_voth_domosh/legion_arcana_weapon.vpcf", context )
   PrecacheResource( "particle", "particles/econ/items/rubick/rubick_force_gold_ambient/rubick_telekinesis_force_rocks_b_gold.vpcf", context )
   PrecacheResource( "particle", "particles/status_fx/status_effect_phantom_lancer_illstrong.vpcf", context )

   PrecacheResource( "particle", "particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_ambient_head_ember.vpcf", context )
   PrecacheResource( "particle", "particles/econ/items/techies/techies_arcana/techies_sign_ambient.vpcf", context )
   PrecacheResource( "particle", "particles/pa_wings_self.vpcf", context )
   PrecacheResource( "particle", "particles/econ/items/axe/axe_cinder/axe_cinder_ambient_glow.vpcf", context )
   PrecacheResource( "particle", "particles/econ/items/dazzle/dazzle_darkclaw/dazzle_darkclaw_ambient_embers.vpcf", context )
   PrecacheResource( "particle", "particles/econ/items/natures_prophet/natures_prophet_weapon_sufferwood/natures_prophet_sufferwood_ambient.vpcf", context )
   PrecacheResource( "particle", "particles/disruptor_resistive_ambient_glow_self.vpcf", context )
   PrecacheResource( "particle", "particles/econ/items/crystal_maiden/crystal_maiden_ward_staff/crystal_maiden_ward_staff_ambient.vpcf", context )
   PrecacheResource( "particle", "particles/econ/items/rubick/rubick_puppet_master/rubick_back_puppet_ambient_edge.vpcf", context )
   PrecacheResource( "particle", "particles/econ/items/death_prophet/death_prophet_acherontia/death_prophet_inkling_ambient.vpcf", context )
   PrecacheResource( "particle", "particles/econ/items/enigma/enigma_world_chasm/status_effect_enigma_blackhole_tgt_ti5.vpcf", context )
   PrecacheResource( "particle", "particles/econ/items/crystal_maiden/crystal_maiden_maiden_of_icewrack/maiden_arcana_base_ambient_b.vpcf", context )
   PrecacheResource( "particle", "particles/econ/items/riki/riki_haze_atrocity/riki_versuta_eye_smoke.vpcf", context )
   PrecacheResource( "particle", "particles/econ/items/bloodseeker/bloodseeker_eztzhok_weapon/bloodseeker_bloodrage_eztzhok_ovr_energy.vpcf", context )
   PrecacheResource( "particle", "particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_ambient_head_ember.vpcf", context )
   


   PrecacheResource( "particle", "particles/items_fx/aegis_lvl_1000_ambient_gold_magic.vpcf", context )
   PrecacheResource( "particle", "particles/gladiatorwings1.vpcf", context )
   
   --city raid
   PrecacheResource( "particle", "particles/units/heroes/hero_centaur/centaur_base_attack_streak.vpcf", context )
   PrecacheResource( "particle", "particles/econ/items/death_prophet/death_prophet_acherontia/death_prophet_inkling_ambient.vpcf", context )
   PrecacheResource( "particle", "particles/econ/items/alchemist/alchemist_midas_knuckles/alch_knuckles_lasthit_coins.vpcf", context )
   
   --interrupt fx screen effects
   PrecacheResource( "particle", "particles/units/heroes/hero_zeus/zues_screen_empty.vpcf", context )
   PrecacheResource( "particle", "particles/screen_blood_3.vpcf", context )
   PrecacheResource( "particle", "particles/econ/events/killbanners/screen_killbanner_compendium14_rampage_burst.vpcf", context )
   PrecacheResource( "particle", "particles/econ/events/killbanners/screen_killbanner_compendium14_firstblood_drips.vpcf", context )
   
   
   --cosmetic rewards
   PrecacheResource( "particle", "particles/econ/items/razor/razor_punctured_crest/razor_static_link_beam_blade.vpcf", context )
   PrecacheResource( "particle", "particles/units/heroes/hero_centaur/centaur_base_attack_streak.vpcf", context )

   --2016 battle pass new effects
   PrecacheResource( "particle", "particles/shield_reflect_new.vpcf", context )
   
   PrecacheResource( "particle", "particles/units/heroes/hero_ember_spirit/ember_spirit_hit_fire.vpcf", context )

   --arcane blaster
   PrecacheResource( "particle", "particles/econ/items/leshrac/leshrac_tormented_staff/leshrac_base_attack_tormented.vpcf", context )
   --legionnaire
   PrecacheResource( "particle", "particles/units/heroes/hero_legion_commander/legion_commander_duel_victory_burst.vpcf", context )
   PrecacheResource( "particle", "particles/units/heroes/hero_oracle/oracle_false_promise_attacked_elec.vpcf", context )
   PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_legion_commander.vsndevts", context)

   PrecacheResource( "particle", "particles/units/heroes/hero_sven/sven_warcry_buff_b.vpcf", context )
   PrecacheResource( "particle", "particles/econ/items/bane/slumbering_terror/bane_slumber_nightmare.vpcf", context )
   
   --tree form
   PrecacheResource( "model", "models/heroes/treant_protector/legs.vmdl", context )
   PrecacheResource( "model", "models/heroes/treant_protector/foliage.vmdl", context )
   PrecacheResource( "model", "models/heroes/treant_protector/hands.vmdl", context )

   PrecacheResource( "model", "models/items/skeleton_king/the_blood_shard/the_blood_shard.vmdl", context )
   
   
   --temple of elements
   if true then --GetMapName() == "beginner_hero_level_1_to_9" or GetMapName() == "expert_hero_level_10_or_higher" then
     PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_lycan.vsndevts", context)
     PrecacheResource( "particle", "particles/units/heroes/hero_centaur/centaur_double_edge_bloodspray_src.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_ember_spirit/ember_spirit_flameguard_fire_inner.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/bristleback/bristle_spikey_spray/bristle_spikey_quill_spray_quills.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_huskar/huskar_burning_spear.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_venomancer/venomancer_poison_nova.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_sandking/sandking_sandstorm_start.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_lycan/lycan_claw_blur.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_lycan/lycan_weapon_blur.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_lycan/lycan_weapon_blur_both.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/windrunner/windrunner_weapon_sparrowhawk/windrunner_spell_powershot_sparrowhawk.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_medusa/medusa_mana_shield_oldbase.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_medusa/medusa_mana_shield_shell_add.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_windrunner/windrunner_spell_powershot.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_lycan/lycan_dust_hit.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_venomancer/venomancer_venomous_gale.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_venomancer/venomancer_base_attack.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_lycan/lycan_claw_blur_b.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_lycan/lycan_weapon_blur_b.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_lycan/lycan_loadout.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/tidehunter/tidehunter_divinghelmet/tidehunter_gush_splash_diving_helmet.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_sven/sven_spell_great_cleave.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_morphling/morphling_adaptive_strike.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_morphling/morphling_waveform.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_chen/chen_teleport.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_tidehunter/tidehunter_spell_ravage.vpcf", context )
     PrecacheResource( "particle", "particles/creeps/lane_creeps/creep_radiant_hulk_swipe_right.vpcf", context )
     PrecacheResource( "particle", "particles/creeps/lane_creeps/creep_radiant_hulk_swipe_left.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/kunkka/divine_anchor/hero_kunkka_dafx_skills/kunkka_spell_torrent_bubbles_fxset.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_winter_wyvern/wyvern_spawn.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_shadow_demon/shadow_demon_shadow_poison_projectile.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_bloodseeker/bloodseeker_bloodritual_ring_lv.vpcf", context )
     PrecacheResource( "particle", "particles/econ/events/ti6/cyclone_ti6.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_necrolyte/necrolyte_pulse_enemy.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_undying/undying_tombstone.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_doom_bringer/doom_bringer_doom.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_lina/lina_spell_light_strike_array.vpcf", context )
     PrecacheResource( "particle", "particles/fireball_11.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_doom_bringer/doom_weapon_blur.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_doom_bringer/doom_weapon_blur_hyhy.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_doom_bringer/doom_weapon_blurb.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_shadow_demon/sd_w.vpcf", context )
     PrecacheResource( "particle", "particles/econ/events/ti6/blink_dagger_start_ti6_lvl2.vpcf", context )
     PrecacheResource( "particle", "particles/econ/events/ti6/hero_levelup_ti6_flash_hit_magic.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_enigma/enigma_blackhole_n.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_omniknight/omniknight_purification_d_glow.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_warlock/warlock_rain_of_chaos_start_bubble_evil.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_warlock/warlock_base_attack.vpcf", context )
     PrecacheResource( "particle", "particles/econ/events/ti5/cyclone_ti5.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_shadowraze.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_shadowraze_collumn.vpcf", context )
     PrecacheResource( "particle", "particles/dazzle_shadow_wave_green.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/enigma/enigma_geodesic/enigma_base_attack_eidolon_geodesic.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_enigma/enigma_base_attack.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_jakiro/jakiro_base_attack.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_batrider/batrider_base_attack.vpcf", context )
     PrecacheResource( "particle", "particles/items3_fx/fish_bones_active_ring.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_spectre/spectre_attack_blur.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_spectre/spectre_attack_blur_b.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_phoenix/phoenix_supernova_reborn_star_sphere.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_phoenix/phoenix_base_attack.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_phoenix/phoenix_fire_spirit_launch.vpcf", context )
     PrecacheResource( "particle", "particles/dire_fx/dire_lava_falling_rocks.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_phoenix/phoenix_sunray_tgt.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_shadow_demon/shadow_demon_soul_catcher_v2_ground01.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_enigma/enigma_midnight_pulse.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_jakiro/jakiro_ice_path_shards.vpcf", context )
     PrecacheResource( "particle", "particles/econ/events/winter_major_2016/teleport_start_winter_major_2016_a_model_base.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/crystal_maiden/crystal_maiden_cowl_of_ice/maiden_crystal_nova_n_cowlofice.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_crystalmaiden/maiden_frostbite_buff.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/axe/axe_helm_shoutmask/axe_beserkers_call_owner_h_shoutmask.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_tusk/tusk_ice_shards_projectile.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_lina/lina_spell_light_strike_array_fire_b.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_drow/drow_frost_arrow.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/crystal_maiden/crystal_maiden_maiden_of_icewrack/maiden_freezing_field_snow_arcana1.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/crystal_maiden/crystal_maiden_cowl_of_ice/maiden_crystal_nova_e_cowlofice.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_winter_wyvern/wyvern_arctic_burn_start.vpcf", context )
     PrecacheResource( "particle", "particles/ringoffrost.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_tusk/tusk_frozen_sigil_base.vpcf", context )
     PrecacheResource( "particle", "particles/ringoffrost_2.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_phoenix/phoenix_supernova_reborn_sphere_model.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_tiny/tiny_toss_impact.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/axe/axe_weapon_practos/axe_attack_blur_counterhelix_practos.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_ember_spirit/ember_spirit_weapon_blur.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_ember_spirit/ember_spirit_weapon_blur_both.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_ember_spirit/ember_spirit_weapon_blur_overhead.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_ember_spirit/ember_spirit_weapon_blur_reverse.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/shadow_fiend/sf_fire_arcana/sf_rze.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_hands.vpcf", context )
     PrecacheResource( "particle", "particles/fireball_4_big.vpcf", context )
     PrecacheResource( "particle", "particles/fireball_linear_2.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_wisp/wisp_base_attack.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_clinkz/clinkz_searing_arrow.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_jakiro/jakiro_liquid_fire_explosion.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_lone_druid/lone_druid_bear_spawn.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_lone_druid/lone_druid_savage_roar.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_razor_reduced_flash/razor_plasmafield_reduced_flash.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_zuus/zeus_loadout.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_nevermore/nvm_atk_blur.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_nevermore/nvm_atk_blur_b.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_lone_druid/lone_druid_attack_start.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_wisp/wisp_attack_warmup.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_furion/furion_base_attack.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_treant/treant_foot_step.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_ember_spirit/ember_spirit_hit_fire.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/warlock/warlock_staff_hellborn/warlock_upheaval_hellborn_debuff.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/dragon_knight/dk_immortal_dragon/dragon_knight_dragon_tail_iron_dragon.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/lina/lina_head_headflame/lina_spell_dragon_slave_headflame_d.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_nevermore/nevermore_wings.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_siren/naga_siren_siren_song_cast.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_siren/naga_siren_riptide_debuff.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_siren/naga_siren_riptide_wave.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/earthshaker/earthshaker_totem_ti6/earthshaker_totem_ti6_blur_impact.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/lich/frozen_chains_ti6/lich_frozenchains_frostnova.vpcf", context )
     PrecacheResource( "particle", "particles/generic_gameplay/generic_sleep.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/crystal_maiden/crystal_maiden_cowl_of_ice/maiden_crystal_nova_cowlofice.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/wraith_king/wraith_king_ti6_bracer/wraith_king_ti6_hellfireblast.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_phantom_assassin/phantom_assassin_stifling_dagger.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/juggernaut/jugg_sword_fireborn_odachi/juggernaut_blade_fury_fireborn_odachi.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/dazzle/dazzle_ti6_gold/dazzle_ti6_shallow_grave_gold.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/ogre_magi/ogre_magi_jackpot/ogre_magi_jackpot_spindle_rig.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_bloodseeker/bloodseeker_rupture_nuke.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/wraith_king/wraith_king_ti6_bracer/wraith_king_ti6_hellfireblast_debuff.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/lich/frozen_chains_ti6/lich_frozenchains_frostnova.vpcf", context )
     PrecacheResource( "particle", "articles/units/heroes/hero_leshrac/leshrac_split_earth.vpcf", context )

     

     --tomb act
     PrecacheResource( "particle", "particles/econ/items/dazzle/dazzle_ti6/dazzle_ti6_shallow_grave_glyph.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_enigma/enigma_blackhole.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/silencer/silencer_ti6/silencer_last_word_dmg_ti6.vpcf", context )
     PrecacheResource( "particle", "particles/ringofsilence250.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_abaddon/abaddon_weapon_blur.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_abaddon/abaddon_weapon_blur2.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_abaddon/abaddon_weapon_blur3.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/vengeful/vengeful_weapon_talon/vengeful_wave_of_terror_weapon_talon.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/bane/slumbering_terror/bane_slumber_nightmare_spirit_inkblots.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/nyx_assassin/nyx_assassin_ti6/nyx_assassin_impale_ti6_gold.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_nyx_assassin/nyx_assassin_burrow_exit.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/nyx_assassin/nyx_assassin_ti6_witness/nyx_assassin_impale_ti6_witness.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_meepo/meepo_poof_start_timing.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/necrolyte/necronub_scythe/necrolyte_scythe_ka_flare.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/necrolyte/necronub_scythe/necrolyte_scythe_ka_start.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_venomancer/venomancer_loadout.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/undying/undying_pale_augur/undying_pale_augur_decay.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/necrolyte/necronub_base_attack/necrolyte_base_attack_ka.vpcf", context )
     
     PrecacheResource( "particle", "particles/water_torrent_2.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/kunkka/kunkka_torrent_base/kunkka_spell_torrent_splash_water2_econ.vpcf", context )
     PrecacheResource( "particle", "particles/blood_strike.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/centaur/centaur_ti6/centaur_ti6_warstomp.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/axe/axe_weapon_bloodchaser/axe_attack_blur_counterhelix_bloodchaser.vpcf", context )
     PrecacheResource( "particle", "particles/items2_fx/unused_field_6.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_brewmaster/brewmaster_thunder_clap.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/dazzle/dazzle_ti6/dazzle_ti6_shallow_grave_ground_ray.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_lycan/lycan_summon_wolves_spawn.vpcf", context )

     --affixes
     PrecacheResource( "particle", "particles/units/heroes/hero_centaur/centaur_warstomp.vpcf", context )
     PrecacheResource( "particle", "particles/meteor_arrow.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/earthshaker/egteam_set/hero_earthshaker_egset/earthshaker_echoslam_start_egset.vpcf", context )
     PrecacheResource( "particle", "particles/spikes_green.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/kunkka/kunkka_torrent_base/kunkka_spell_torrent_splash_econ.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/silencer/silencer_ti6/silencer_last_word_status_ti6.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_mirana/mirana_starfall_attack.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_phoenix/phoenix_supernova_reborn.vpcf", context )
     PrecacheResource( "particle", "particles/moon_light.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_luna/luna_eclipse_cast_moonlight_shaft03.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/bristleback/bristle_spikey_spray/bristle_spikey_quill_spray_hit.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/lina/lina_head_headflame/lina_flame_hand_dual_headflame.vpcf", context )
     PrecacheResource( "particle", "particles/status_fx/status_effect_medusa_stone_gaze.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/silencer/silencer_ti6/silencer_last_word_ti6_silence.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_skeletonking/wraith_king_spirits.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/bloodseeker/bloodseeker_eztzhok_weapon/bloodseeker_bloodrage_ground_eztzhok.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/effigies/status_fx_effigies/se_ambient_ti6_lvl3_ribbon.vpcf", context )
     PrecacheResource( "particle", "particles/neutral_fx/troll_heal.vpcf", context )
     PrecacheResource( "particle", "particles/econ/courier/courier_trail_hw_2013/courier_trail_hw_2013_ghosts.vpcf", context )
     PrecacheResource( "particle", "particles/econ/courier/courier_greevil_green/courier_greevil_green_ambient_3.vpcf", context )
     
     
     --hardmode
     PrecacheResource( "particle", "particles/units/heroes/hero_warlock/warlock_fatal_bonds_pulse.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/undying/undying_manyone/undying_pale_tombstone_cloud.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/shredder/timber_controlled_burn/timber_controlled_burn_timberchain_rope_flames.vpcf", context )
     PrecacheResource( "particle", "particles/fire_nova.vpcf", context )
     PrecacheResource( "particle", "particles/themed_fx/cny_fireworks_rockets_b.vpcf", context )
     PrecacheResource( "particle", "particles/themed_fx/cny_fireworks_rockets_a.vpcf", context )
     PrecacheResource( "particle", "particles/themed_fx/cny_fireworks_rockets_bsnd.vpcf", context )
     PrecacheResource( "particle", "particles/screen_smoke_2.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_ancient_apparition/ancient_apparition_ice_blast_sphere_final_explosion_smoke.vpcf", context )
     PrecacheResource( "particle", "particles/firering250.vpcf", context )

     --act 6
     PrecacheResource( "particle", "particles/fireball_2.vpcf", context )
     

     --act 8
     PrecacheResource( "particle", "particles/units/heroes/hero_chaos_knight/chaos_knight_weapon_blur.vpcf", context )
     PrecacheResource( "particle", "particles/fireball_4.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_loadout.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_bounty_hunter/bounty_hunter_track_trail_circle.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_huskar/huskar_burning_spear_debuff.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_shadowraze.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/medusa/medusa_daughters/medusa_daughters_mana_shield_shell.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/dazzle/dazzle_ti6_gold/dazzle_ti6_shallow_grave_gold_ground_ring.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_ursa/ursa_earthshock_rocks.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_ancient_apparition/ancient_apparition_chilling_touch_buff.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/dazzle/dazzle_ti6_gold/dazzle_ti6_shallow_grave_gold_halo.vpcf", context )
     PrecacheResource( "particle", "particles/econ/events/ti6/phase_boots_ti6.vpcf", context )
     PrecacheResource( "particle", "particles/wolf_pool_1.vpcf", context )
     PrecacheResource( "particle", "particles/wolf_pool_2.vpcf", context )
     PrecacheResource( "particle", "particles/items3_fx/warmage_mana.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_wisp/wisp_death.vpcf", context )
     --invoker
     PrecacheResource( "particle", "particles/units/heroes/hero_invoker/invoker_emp.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/antimage/antimage_weapon_basher_ti5/antimage_manavoid_ti_5.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_ancient_apparition/ancient_apparition_cold_feet_frozen.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_jakiro/jakiro_liquid_fire_debuff.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/ancient_apparition/aa_blast_ti_5/ancient_apparition_ice_blast_final_grid_c_ti5.vpcf", context )
     PrecacheResource( "particle", "particles/status_fx/status_effect_terrorblade_reflection.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_winter_wyvern/wyvern_cold_embrace_borealis.vpcf", context )
     PrecacheResource( "particle", "particles/ring_ice_spike.vpcf", context )
     PrecacheResource( "particle", "particles/econ/events/fall_major_2016/cyclone_fm06_c.vpcf", context )
     PrecacheResource( "particle", "particles/status_fx/status_effect_nightmare.vpcf", context )
     PrecacheResource( "particle", "particles/status_fx/status_effect_maledict.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_night_stalker/nightstalker_void.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/dazzle/dazzle_ti6/dazzle_ti6_shallow_grave_ground_ring.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_alchemist/alchemist_acid_spray.vpcf", context )
     PrecacheResource( "particle", "particles/fireball_linear_3.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_tidehunter/tidehunter_arm_of_the_deep_projectile.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_zuus/zuus_thunder_trail_projectile.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/mirana/mirana_persona/mirana_dark_moon_spell_arrow.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_drow/drow_ranger_glacier_projectile.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/grimstroke/ti9_immortal/gs_ti9_artistry_proj.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_hoodwink/hoodwink_sharpshooter_projectile.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_magnataur/magnataur_reverse_polarity_pull.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/gyrocopter/gyro_ti10_immortal_missile/gyro_ti10_immortal_missile_explosion.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/gyrocopter/gyro_ti10_immortal_missile/gyro_ti10_immortal_crimson_missile_explosion.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/lich/lich_ti8_immortal_arms/lich_ti8_chain_frost_explode.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/viper/viper_ti7_immortal/viper_poison_crimson_attack_ti7.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/warlock/warlock_ti9/warlock_ti9_shadow_word_debuff.vpcf", context )
     --PrecacheResource( "particle", "particles/units/heroes/hero_venomancer/venomancer_latent_poison_projectile_endcap.vpcf", context )
     --PrecacheResource( "particle", "particles/units/heroes/hero_venomancer/venomancer_latent_poison_projectile_endcap.vpcf", context )
     --PrecacheResource( "particle", "particles/units/heroes/hero_venomancer/venomancer_latent_poison_projectile_endcap.vpcf", context )
     --PrecacheResource( "particle", "particles/units/heroes/hero_venomancer/venomancer_latent_poison_projectile_endcap.vpcf", context )
     --PrecacheResource( "particle", "particles/units/heroes/hero_venomancer/venomancer_latent_poison_projectile_endcap.vpcf", context )
     --PrecacheResource( "particle", "particles/units/heroes/hero_venomancer/venomancer_latent_poison_projectile_endcap.vpcf", context )
     --PrecacheResource( "particle", "particles/units/heroes/hero_venomancer/venomancer_latent_poison_projectile_endcap.vpcf", context )
     --PrecacheResource( "particle", "particles/units/heroes/hero_venomancer/venomancer_latent_poison_projectile_endcap.vpcf", context )
     
     
     
     
     PrecacheResource( "particle", "particles/fireball_12.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/centaur/centaur_ti6_gold/centaur_ti6_warstomp_gold_ring_elec.vpcf", context )
     PrecacheResource( "particle", "particles/glyph_brown.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_lion/lion_spell_impale.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/heroes_underlord/abyssal_underlord_firestorm_wave.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/heroes_underlord/underlord_firestorm_pre_d.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_morphling/morphling_morph_str_ring.vpcf", context )
     PrecacheResource( "particle", "particles/econ/events/fall_major_2016/teleport_start_fm06_leaves_c.vpcf", context )
     PrecacheResource( "particle", "particles/techies_suicide_dud_arcana_skull.vpcf", context )
     PrecacheResource( "particle", "particles/hand_glow_red.vpcf", context )
     PrecacheResource( "particle", "particles/fireball_linear_4.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_invoker/invoker_emp_electricity.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_explosion.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_bane/bane_projectile.vpcf", context )
     PrecacheResource( "particle", "particles/holy_ring.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/kunkka/divine_anchor/hero_kunkka_dafx_skills/kunkka_spell_torrent_splash_fxset.vpcf", context )
     PrecacheResource( "particle", "particles/sven_spell_warcry_ti_5_fixed.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_legion_commander/legion_commander_press.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_antimage/antimage_spellshield_sphere.vpcf", context )
     PrecacheResource( "particle", "particles/units/heroes/hero_lina/lina_base_attack.vpcf", context )
     PrecacheResource( "particle", "particles/econ/items/windrunner/windrunner_cape_sparrowhawk/windrunner_windrun_sparrowhawk.vpcf", context )

     PrecacheUnitByNameAsync( "irongrizzly", function(unit) end )
     
     for i=1,10 do
      PrecacheUnitByNameAsync( "act13_"..i, function(unit) end )
    end
    for i=1,6 do
      PrecacheUnitByNameAsync( "merge_boss_arena_"..i, function(unit) end )
    end
    --4.4
    --units
    PrecacheUnitByNameAsync( "temple_jungle_boss_0", function(unit) end )
    PrecacheUnitByNameAsync( "temple_jungle_boss_1", function(unit) end )
    PrecacheUnitByNameAsync( "temple_jungle_boss_2", function(unit) end )
    PrecacheUnitByNameAsync( "temple_jungle_boss_3", function(unit) end )
    PrecacheUnitByNameAsync( "temple_jungle_boss_4", function(unit) end )
    PrecacheUnitByNameAsync( "temple_jungle_boss_5", function(unit) end )
    PrecacheUnitByNameAsync( "temple_jungle_boss_6", function(unit) end )
    PrecacheUnitByNameAsync( "temple_jungle_boss_7", function(unit) end )
    PrecacheUnitByNameAsync( "temple_jungle_spider", function(unit) end )
    PrecacheUnitByNameAsync( "temple_jungle_raptor", function(unit) end )
    PrecacheUnitByNameAsync( "temple_jungle_troll", function(unit) end )
    PrecacheUnitByNameAsync( "temple_jungle_viper", function(unit) end )
    PrecacheUnitByNameAsync( "temple_dragon_boss_7", function(unit) end )
    PrecacheUnitByNameAsync( "temple_jungle_lizard", function(unit) end )
    PrecacheUnitByNameAsync( "jungle_panther", function(unit) end )
    PrecacheUnitByNameAsync( "sandviper_pet", function(unit) end )
    PrecacheUnitByNameAsync( "temple_spike_trap", function(unit) end )
    PrecacheUnitByNameAsync( "temple_missile_trap", function(unit) end )
    PrecacheUnitByNameAsync( "temple_missile_trap_hydra", function(unit) end )
    PrecacheUnitByNameAsync( "temple_missile_trap_hydra_2", function(unit) end )
    PrecacheUnitByNameAsync( "temple_trap_hellgate", function(unit) end )
    PrecacheUnitByNameAsync( "temple_missile_trap_arrow", function(unit) end )
    PrecacheUnitByNameAsync( "temple_missile_trap_dragon", function(unit) end )
    --PrecacheUnitByNameAsync( "temple_jungle_spider", function(unit) end )


    --spells
    PrecacheResource( "particle", "particles/units/heroes/hero_broodmother/broodmother_hunger_buff.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_spirit_breaker/spirit_breaker_charge.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/heroes_underlord/abyssal_underlord_pitofmalice_stun.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/heroes_underlord/underlord_pitofmalice.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_winter_wyvern/wyvern_splinter.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_bane/bane_fiendsgrip_hands.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_blade_fury.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_dazzle/dazzle_base_attack.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_nevermore/nevermore_shadowraze.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/nightstalker/nightstalker_black_nihility/nightstalker_black_nihility_void_swarm.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_night_stalker/nightstalker_loadout_bats.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_enigma/enigma_blackhole_n.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/nightstalker/nightstalker_black_nihility/nightstalker_black_nihility_void_hit.vpcf", context )
    PrecacheResource( "particle", "particles/fireball_17.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_enchantress/enchantress_base_attack.vpcf", context )
    PrecacheResource( "particle", "particles/spear_arrow.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_luna/luna_base_attack.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_mirana/mirana_moonlight_ray.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/luna/luna_lucent_ti5/luna_shield_ambient_moonfall.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_obsidian_destroyer/obsidian_destroyer_arcane_orb.vpcf", context )
    PrecacheResource( "particle", "particles/ringoffrost_3.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/juggernaut/jugg_sword_dragon/juggernaut_blade_fury_dragon.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_ursa/ursa_earthshock_soil1.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_centaur/centaur_double_edge_tgt_rope.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_zuus/zuus_arc_lightning.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/kunkka/kunkka_immortal/kunkka_immortal_ghost_ship_marker.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/kunkka/kunkka_immortal/kunkka_immortal_ghost_ship.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_warlock/warlock_rain_of_chaos.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/kunkka/kunkka_immortal/kunkka_immortal_ghost_ship_impact.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_queenofpain/queen_shadow_strike_debuff.vpcf", context )
    PrecacheResource( "particle", "particles/fireball_13_big.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_death_prophet/death_prophet_death_bats.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_night_stalker/nightstalker_loadout_bats.vpcf", context )
    PrecacheResource( "particle", "particles/econ/courier/courier_trail_hw_2013/courier_trail_hw_2013_bats.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/gyrocopter/hero_gyrocopter_atomic_gold/gyro_rocket_barrage_atomic_light_gold.vpcf", context )
    PrecacheResource( "particle", "particles/invoker_chaos_meteor_fly_blue_slow2.5.vpcf", context )
    PrecacheResource( "particle", "particles/econ/events/killbanners/screen_killbanner_compendium14_doublekill.vpcf", context )
    PrecacheResource( "particle", "particles/item_quality_mythical.vpcf", context )
    PrecacheResource( "particle", "particles/shredder_chakram_follow.vpcf", context )
    PrecacheResource( "particle", "particles/econ/events/ti7/cyclone_ti7_embers.vpcf", context )
    PrecacheResource( "particle", "particles/lich_chain_frostfire.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_dark_seer/dark_seer_ion_shell_damage.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_dark_seer/dark_seer_ion_shell_fallback_mid.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/wisp/wisp_relocate_marker_ti7.vpcf", context )
    PrecacheResource( "particle", "particles/sd_ti7_shadow_poison_proj_5sec.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/riki/riki_immortal_ti6/riki_immortal_ti6_blinkstrike.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/shadow_demon/sd_ti7_shadow_poison/sd_ti7_shadow_poison_kill.vpcf", context )
    PrecacheResource( "particle", "particles/shadow_shaman_ti8_ether_shock_model_scatter2.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/doom/doom_ti8_immortal_arms/doom_ti8_immortal_devour_burst_b.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/underlord/underlord_ti8_immortal_weapon/underlord_ti8_immortal_pitofmalice_stun_light_b.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/vengeful/vs_ti8_immortal_shoulder/vs_ti8_immortal_magic_missle_end_embers.vpcf", context )
    PrecacheResource( "particle", "particles/econ/events/ti8/ti8_hero_effect_gems.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/vengeful/vs_ti8_immortal_shoulder/vs_ti8_immortal_magic_missle_end_streaks_b.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/queen_of_pain/qop_ti8_immortal/queen_ti8_shadow_strike_body.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/phantom_assassin/pa_ti8_immortal_head/pa_ti8_immortal_stifling_dagger_explosion.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/batrider/batrider_ti8_immortal_mount/batrider_ti8_immortal_firefly_path_front.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/ancient_apparition/ancient_apparation_ti8/ancient_ice_vortex_ti8_ring_spiral.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/phantom_assassin/pa_ti8_immortal_head/pa_ti8_immortal_stifling_dagger_explosion.vpcf", context )
    PrecacheResource( "particle", "particles/econ/events/ti8/mekanism_ti8_beam.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/witch_doctor/wd_ti8_immortal_head/wd_ti8_immortal_maledict_dark_b.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/underlord/underlord_ti8_immortal_weapon/underlord_ti8_immortal_pitofmalice_stun_base.vpcf", context )
    PrecacheResource( "particle", "particles/econ/events/ti8/blink_dagger_ti8_end_ray.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/omniknight/omni_ti8_head/omniknight_repel_buff_ti8_glyph.vpcf", context )
    PrecacheResource( "particle", "particles/ring_green.vpcf", context )
    PrecacheResource( "particle", "particles/hellfire.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/ogre_magi/ogre_ti8_immortal_weapon/ogre_ti8_immortal_bloodlust_buff.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_vengeful/vengeful_wave_of_terror.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/venomancer/veno_ti8_immortal_head/veno_ti8_immortal_gale.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/nyx_assassin/nyx_assassin_ti6/nyx_assassin_impale_ti6.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_nyx_assassin/nyx_assassin_impale.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/vengeful/vs_ti8_immortal_shoulder/vs_ti8_immortal_magic_missle.vpcf", context )
    PrecacheResource( "particle", "particles/chaosbolt.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_skywrath_mage/skywrath_mage_arcane_bolt.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/queen_of_pain/qop_ti8_immortal/queen_ti8_shadow_strike.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_skeletonking/skeletonking_hellfireblast_explosion.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/dark_willow/dark_willow_ti8_immortal_head/dw_crimson_ti8_immortal_cursed_crownmarker_steam.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/lich/lich_ti8_immortal_arms/lich_ti8_chain_frost.vpcf", context )
    PrecacheResource( "particle", "particles/econ/events/fall_major_2016/cyclone_fm06_rock_a.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/omniknight/omni_ti8_head/omniknight_repel_buff_ti8_glyph.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/pangolier/pangolier_ti8_immortal/pangolier_ti8_immortal_shield_buff_parent.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/queen_of_pain/qop_ti8_immortal/queen_ti8_golden_shadow_strike_debuff_creep.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/zeus/zeus_ti8_immortal_arms/zeus_ti8_immortal_arc_flash.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/pangolier/pangolier_ti8_immortal/pangolier_ti8_immortal_shield_buff.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/effigies/status_fx_effigies/jade_base_statue_destruction_generic_d.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/underlord/underlord_ti8_immortal_weapon/underlord_ti8_immortal_pitofmalice_vortex.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/juggernaut/jugg_ti8_sword/juggernaut_blade_fury_abyssal_cyclone_groundmarks.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/juggernaut/jugg_ti8_sword/juggernaut_crimson_blade_fury_abyssal.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/dark_willow/dark_willow_ti8_immortal_head/dw_crimson_ti8_immortal_cursed_crownmarker_embers.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/lich/frozen_chains_ti6/lich_frozenchains_frostnova_flash_h.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/lich/lich_ti8_immortal_arms/lich_ti8_chain_frost_explode_flare.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_bloodseeker/bloodseeker_rupture_glow_lv.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_lone_druid/lone_druid_rabid_buff_speed.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_zeus/zeus_cloud_ground_haze.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/batrider/batrider_ti8_immortal_mount/batrider_ti8_immortal_firefly_path_front.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/mirana/mirana_ti8_immortal_mount/mirana_ti8_immortal_leap_start_embers.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/storm_spirit/strom_spirit_ti8/storm_spirit_ti8_overload_active_e.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/viper/viper_immortal_tail_ti8/viper_immortal_ti8_nethertoxin.vpcf", context )
    PrecacheResource( "particle", "particles/fireball_linear_8.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/doom/doom_ti8_immortal_arms/doom_ti8_immortal_devour.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/dazzle/dazzle_ti6_gold/dazzle_ti6_shallow_grave_gold_playerglow.vpcf", context )
    PrecacheResource( "particle", "particles/meteor_hammer_spell_2secs.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_rubick/rubick_telekinesis_rocks.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_dark_willow/dark_willow_wisp_spell_ring.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/tiny/tiny_prestige/tiny_prestige_tree_linear_proj.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/necrolyte/necro_ti9_immortal/necro_ti9_immortal_shroud.vpcf", context )
    --PrecacheResource( "particle", "particles/econ/items/arc_warden/arc_warden_ti9_immortal/arc_warden_ti9_wraith_spawn_portal.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/axe/axe_ti9_immortal/axe_ti9_beserkers_call_owner_aoe_ground_glow.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/lifestealer/ls_ti9_immortal/ls_ti9_open_wounds_swoop_parent.vpcf", context )
    PrecacheResource( "particle", "particles/neutral_fx/harpy_chain_lightning.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_enigma/enigma_blackhole_fallback_low.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_wings.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/pugna/pugna_ward_ti5/pugna_ward_ambient_ti_5.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/pugna/pugna_ward_ti5/pugna_ward_attack_light_ti_5.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/pudge/pudge_immortal_arm/pudge_immortal_arm_rot_gold.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/ember_spirit/ember_ti9/ember_ti9_flameguard_sigil_sun.vpcf", context )

            --[[ fxprecatch fxxxx
            PrecacheResource( "particle", "particles/econ/items/ember_spirit/ember_ti9/ember_ti9_flameguard_sigil_sun.vpcf", context )
            PrecacheResource( "particle", "particles/units/heroes/hero_lina/lina_base_attack.vpcf", context )
            PrecacheResource( "particle", "particles/units/heroes/hero_centaur/centaur_double_edge_tgt_rope.vpcf", context )
            ]]
            --act 13
            PrecacheResource( "particle", "particles/econ/courier/courier_wyvern_hatchling/courier_wyvern_hatchling_ice.vpcf", context )
            PrecacheResource( "particle", "particles/icerock_arrow.vpcf", context )
            PrecacheResource( "particle", "particles/fireball_linear_6.vpcf", context )
            

            PrecacheResource( "particle", "particles/units/heroes/hero_beastmaster/beastmaster_wildaxe.vpcf", context )
            PrecacheResource( "particle", "particles/econ/items/lina/lina_head_headflame/lina_spell_dragon_slave_headflame.vpcf", context )
            PrecacheResource( "particle", "particles/units/heroes/hero_clinkz/clinkz_base_attack.vpcf", context )
            
            --divine items
            PrecacheResource( "particle", "particles/econ/items/enigma/enigma_world_chasm/enigma_blackhole_ti5.vpcf", context )
            PrecacheResource( "particle", "particles/units/heroes/hero_omniknight/omniknight_purification.vpcf", context )
            PrecacheResource( "particle", "particles/item_quality_divine.vpcf", context )
            PrecacheResource( "particle", "particles/econ/items/antimage/antimage_weapon_basher_ti5_gold/antimage_manavoid_ti_5_gold.vpcf", context )
            PrecacheResource( "particle", "particles/econ/items/lina/lina_ti6/lina_ti6_ambient_ground_aura.vpcf", context )
            PrecacheResource( "particle", "particles/units/heroes/hero_warlock/warlock_rain_of_chaos_start_meteor_flame.vpcf", context )
            


            PrecacheResource( "particle", "particles/invoker_sun_strike_team_big_ray_immortal1_long.vpcf", context )
            PrecacheResource( "particle", "particles/invoker_sun_strike_team_big_ray_legendary_long.vpcf", context )


            PrecacheUnitByNameAsync( "temple_sand_poisonward", function(unit) end )
            PrecacheModel( "temple_sand_poisonward", context )
            PrecacheUnitByNameAsync( "temple_fungal_spawn", function(unit) end )
            PrecacheModel( "temple_fungal_spawn", context )
            PrecacheUnitByNameAsync( "temple_fungal_slark", function(unit) end )
            PrecacheModel( "temple_fungal_spawn", context )
            PrecacheUnitByNameAsync( "temple_dragon_egg", function(unit) end )
            PrecacheModel( "temple_dragon_egg", context )
            PrecacheUnitByNameAsync( "temple_dragon_mini_fire", function(unit) end )
            PrecacheModel( "temple_dragon_mini_fire", context )
            PrecacheUnitByNameAsync( "temple_fungal_slark", function(unit) end )
            PrecacheModel( "temple_fungal_spawn", context )
            PrecacheUnitByNameAsync( "temple_dragon_boss_5", function(unit) end )
            PrecacheModel( "temple_dragon_boss_5", context )
            PrecacheUnitByNameAsync( "temple_dragon_egg", function(unit) end )
            PrecacheModel( "temple_dragon_egg", context )
            PrecacheUnitByNameAsync( "temple_dragon_egg_2", function(unit) end )
            PrecacheModel( "temple_dragon_egg_2", context )
            PrecacheUnitByNameAsync( "temple_dragon_mini_dragon", function(unit) end )
            PrecacheModel( "temple_dragon_mini_dragon", context )
            PrecacheUnitByNameAsync( "temple_dragon_boss_5", function(unit) end )
            PrecacheModel( "temple_dragon_boss_5", context )
            PrecacheUnitByNameAsync( "pve_skeleton", function(unit) end )
            PrecacheModel( "pve_skeleton", context )
            PrecacheUnitByNameAsync( "pve_beastslow", function(unit) end )
            PrecacheModel( "pve_beastslow", context )
            PrecacheUnitByNameAsync( "pve_skeletonstun", function(unit) end )
            PrecacheModel( "pve_skeletonstun", context )
            PrecacheUnitByNameAsync( "temple_sand_poisonward", function(unit) end )
            PrecacheModel( "temple_sand_poisonward", context )
            PrecacheUnitByNameAsync( "temple_shadow_inferno", function(unit) end )
            PrecacheModel( "temple_shadow_inferno", context )
            PrecacheUnitByNameAsync( "temple_dragon_mini_fire", function(unit) end )
            PrecacheModel( "temple_dragon_mini_fire", context )
            PrecacheUnitByNameAsync( "temple_dragon_totem", function(unit) end )
            PrecacheModel( "temple_dragon_totem", context )
            PrecacheUnitByNameAsync( "temple_dragon_totem_arcane", function(unit) end )
            PrecacheModel( "temple_dragon_totem_arcane", context )
            PrecacheUnitByNameAsync( "temple_shadow_gravemaker_skeleton", function(unit) end )
            PrecacheModel( "temple_shadow_gravemaker_skeleton", context )
            PrecacheUnitByNameAsync( "temple_dragon_plant", function(unit) end )
            PrecacheModel( "temple_dragon_plant", context )
            PrecacheUnitByNameAsync( "temple_shadow_spectre", function(unit) end )
            PrecacheModel( "temple_shadow_spectre", context )
            PrecacheUnitByNameAsync( "temple_shadow_spectre_2", function(unit) end )
            PrecacheModel( "temple_shadow_spectre_2", context )
            PrecacheUnitByNameAsync( "temple_mount_misha", function(unit) end )
            PrecacheModel( "temple_mount_misha", context )

            PrecacheUnitByNameAsync( "temple_wolf_bat", function(unit) end )
            PrecacheModel( "temple_wolf_bat", context )
            PrecacheUnitByNameAsync( "temple_shadow_hound", function(unit) end )
            PrecacheModel( "temple_shadow_hound", context )
            PrecacheUnitByNameAsync( "temple_shadow_hound", function(unit) end )
            PrecacheModel( "temple_shadow_hound", context )
            PrecacheUnitByNameAsync( "temple_water_fungal2", function(unit) end )
            PrecacheModel( "temple_water_fungal2", context )
            PrecacheUnitByNameAsync( "temple_fire_ele", function(unit) end )
            PrecacheModel( "temple_fire_ele", context )

            --since later spawn of creeps
            --a11
            PrecacheUnitByNameAsync( "temple_throne_boss_2", function(unit) end )
            PrecacheUnitByNameAsync( "temple_volcano_boss_3", function(unit) end )
            PrecacheUnitByNameAsync( "temple_tomb_boss_4", function(unit) end )
            PrecacheUnitByNameAsync( "temple_mount_boss_7", function(unit) end )
            PrecacheUnitByNameAsync( "temple_dragon_boss_6", function(unit) end )
            PrecacheUnitByNameAsync( "temple_shadow_boss_7", function(unit) end )
            PrecacheUnitByNameAsync( "temple_water_boss_6", function(unit) end )
            PrecacheUnitByNameAsync( "temple_sand_boss_6", function(unit) end )
            PrecacheUnitByNameAsync( "temple_wolf_boss_5", function(unit) end )
            PrecacheUnitByNameAsync( "temple_mogushan_boss_1", function(unit) end )
            PrecacheUnitByNameAsync( "temple_temple_boss_1", function(unit) end )
            PrecacheUnitByNameAsync( "merge_boss_12", function(unit) end )
            PrecacheUnitByNameAsync( "merge_boss_34", function(unit) end )
            PrecacheUnitByNameAsync( "merge_boss_56", function(unit) end )
            PrecacheUnitByNameAsync( "merge_boss_78", function(unit) end )
            PrecacheUnitByNameAsync( "merge_boss_910", function(unit) end )
            --a10
            PrecacheUnitByNameAsync( "temple_throne_boss_1", function(unit) end )
            --a9
            PrecacheUnitByNameAsync( "temple_mogushan_boss_1", function(unit) end )
            PrecacheUnitByNameAsync( "temple_mogushan_ranged", function(unit) end )
            PrecacheUnitByNameAsync( "temple_mogushan_melee", function(unit) end )
            PrecacheUnitByNameAsync( "temple_mogushan_runner", function(unit) end )
            --a8
            PrecacheUnitByNameAsync( "temple_volcano_fireele", function(unit) end )
            PrecacheUnitByNameAsync( "temple_volcano_fireborn", function(unit) end )
            PrecacheUnitByNameAsync( "temple_volcano_flameborn", function(unit) end )
            PrecacheUnitByNameAsync( "npc_dota_creature_imp_volcano", function(unit) end )
            PrecacheUnitByNameAsync( "npc_dota_creature_demon_volcano", function(unit) end )
            PrecacheUnitByNameAsync( "temple_volcano_boss_1", function(unit) end )
            PrecacheUnitByNameAsync( "temple_volcano_boss_2", function(unit) end )
            --a7
            PrecacheUnitByNameAsync( "temple_tomb_boss_1", function(unit) end )
            PrecacheUnitByNameAsync( "temple_tomb_boss_2", function(unit) end )
            PrecacheUnitByNameAsync( "temple_tomb_boss_3", function(unit) end )
            PrecacheUnitByNameAsync( "temple_tomb_boss_4", function(unit) end )
            PrecacheUnitByNameAsync( "temple_tomb_spider", function(unit) end )
            PrecacheUnitByNameAsync( "temple_tomb_fly", function(unit) end )
            PrecacheUnitByNameAsync( "temple_tomb_shadow", function(unit) end )
            PrecacheUnitByNameAsync( "temple_tomb_bug", function(unit) end )
            PrecacheUnitByNameAsync( "temple_tomb_skeleton", function(unit) end )
            --a6
            PrecacheUnitByNameAsync( "temple_mount_boss_1", function(unit) end )
            PrecacheUnitByNameAsync( "temple_mount_boss_2", function(unit) end )
            PrecacheUnitByNameAsync( "temple_mount_boss_3", function(unit) end )
            PrecacheUnitByNameAsync( "temple_mount_boss_4", function(unit) end )
            PrecacheUnitByNameAsync( "temple_mount_boss_5", function(unit) end )
            PrecacheUnitByNameAsync( "temple_mount_boss_6", function(unit) end )
            PrecacheUnitByNameAsync( "temple_mount_plant", function(unit) end )
            PrecacheUnitByNameAsync( "temple_mount_tree", function(unit) end )
            PrecacheUnitByNameAsync( "temple_mount_fireele", function(unit) end )
            PrecacheUnitByNameAsync( "temple_mount_inferno", function(unit) end )
            PrecacheUnitByNameAsync( "temple_mount_archer", function(unit) end )
            PrecacheUnitByNameAsync( "temple_mount_archer_boss", function(unit) end )
            PrecacheUnitByNameAsync( "temple_mount_wisp", function(unit) end )
            --a5
            PrecacheUnitByNameAsync( "temple_dragon_jakiro", function(unit) end )
            PrecacheUnitByNameAsync( "temple_dragon_melee", function(unit) end )
            PrecacheUnitByNameAsync( "temple_dragon_mini_fire", function(unit) end )
            PrecacheUnitByNameAsync( "temple_dragon_mini_dragon", function(unit) end )
            PrecacheUnitByNameAsync( "temple_dragon_egg", function(unit) end )
            PrecacheUnitByNameAsync( "temple_dragon_egg_2", function(unit) end )
            PrecacheUnitByNameAsync( "temple_dragon_totem", function(unit) end )
            PrecacheUnitByNameAsync( "temple_dragon_garg", function(unit) end )
            PrecacheUnitByNameAsync( "temple_dragon_garg2", function(unit) end )
            PrecacheUnitByNameAsync( "temple_dragon_plant", function(unit) end )
            PrecacheUnitByNameAsync( "temple_dragon_boss_1", function(unit) end )
            PrecacheUnitByNameAsync( "temple_dragon_boss_2", function(unit) end )
            PrecacheUnitByNameAsync( "temple_dragon_boss_3", function(unit) end )
            PrecacheUnitByNameAsync( "temple_dragon_boss_5", function(unit) end )
            PrecacheUnitByNameAsync( "temple_dragon_boss_4_depressive", function(unit) end )
            PrecacheUnitByNameAsync( "temple_dragon_boss_4_supportive", function(unit) end )
            PrecacheUnitByNameAsync( "temple_dragon_boss_4_angry", function(unit) end )
            --a4
            PrecacheUnitByNameAsync( "temple_shadow_inferno", function(unit) end )
            PrecacheUnitByNameAsync( "temple_shadow_spectre", function(unit) end )
            PrecacheUnitByNameAsync( "temple_shadow_melee", function(unit) end )
            PrecacheUnitByNameAsync( "temple_shadow_undying", function(unit) end )
            PrecacheUnitByNameAsync( "temple_shadow_colossus", function(unit) end )
            PrecacheUnitByNameAsync( "temple_shadow_demon", function(unit) end )
            PrecacheUnitByNameAsync( "temple_shadow_gravemaker", function(unit) end )
            PrecacheUnitByNameAsync( "temple_shadow_gravemaker_skeleton", function(unit) end )
            PrecacheUnitByNameAsync( "temple_shadow_nightspider", function(unit) end )
            PrecacheUnitByNameAsync( "temple_shadow_archer", function(unit) end )
            PrecacheUnitByNameAsync( "temple_shadow_boss_1", function(unit) end )
            PrecacheUnitByNameAsync( "temple_shadow_boss_2", function(unit) end )
            PrecacheUnitByNameAsync( "temple_shadow_boss_3", function(unit) end )
            PrecacheUnitByNameAsync( "temple_shadow_boss_4", function(unit) end )
            PrecacheUnitByNameAsync( "temple_shadow_boss_5", function(unit) end )
            PrecacheUnitByNameAsync( "temple_shadow_boss_6", function(unit) end )
            --a3
            PrecacheUnitByNameAsync( "temple_fungal_ancient", function(unit) end )
            PrecacheUnitByNameAsync( "temple_fungal_slark", function(unit) end )
            PrecacheUnitByNameAsync( "temple_fungal_slardar", function(unit) end )
            PrecacheUnitByNameAsync( "temple_fungal_morph", function(unit) end )
            PrecacheUnitByNameAsync( "temple_fungal_spawn", function(unit) end )
            PrecacheUnitByNameAsync( "temple_water_boss_1", function(unit) end )
            PrecacheUnitByNameAsync( "temple_water_boss_2", function(unit) end )
            PrecacheUnitByNameAsync( "temple_water_boss_3", function(unit) end )
            PrecacheUnitByNameAsync( "temple_water_boss_4", function(unit) end )
            PrecacheUnitByNameAsync( "temple_water_boss_5", function(unit) end )
            PrecacheUnitByNameAsync( "temple_water_boss_7", function(unit) end )
            --a2
            PrecacheUnitByNameAsync( "temple_sand_boss_1", function(unit) end )
            PrecacheUnitByNameAsync( "temple_sand_boss_2", function(unit) end )
            PrecacheUnitByNameAsync( "temple_sand_boss_2_2", function(unit) end )
            PrecacheUnitByNameAsync( "temple_sand_boss_3", function(unit) end )
            PrecacheUnitByNameAsync( "temple_sand_boss_4", function(unit) end )
            PrecacheUnitByNameAsync( "temple_sand_boss_5", function(unit) end )
            PrecacheUnitByNameAsync( "temple_sand_boss_7", function(unit) end )
            PrecacheUnitByNameAsync( "temple_sand_dustlord", function(unit) end )
            PrecacheUnitByNameAsync( "temple_sand_dustgolem", function(unit) end )
            PrecacheUnitByNameAsync( "temple_sand_stonegolem", function(unit) end )
            PrecacheUnitByNameAsync( "temple_sand_dustboar", function(unit) end )
            PrecacheUnitByNameAsync( "temple_sand_bloodboar", function(unit) end )
            PrecacheUnitByNameAsync( "temple_sand_tuskboar", function(unit) end )
            PrecacheUnitByNameAsync( "temple_bloodsucker", function(unit) end )
            PrecacheUnitByNameAsync( "temple_sand_poisonward", function(unit) end )
            PrecacheUnitByNameAsync( "act_2_farmer", function(unit) end )
            PrecacheUnitByNameAsync( "act_2_lama", function(unit) end )
            --a1
            PrecacheUnitByNameAsync( "temple_wolf", function(unit) end )
            PrecacheUnitByNameAsync( "temple_wolf_brown", function(unit) end )
            PrecacheUnitByNameAsync( "temple_wolf_rage", function(unit) end )
            PrecacheUnitByNameAsync( "temple_wolf_boss_1", function(unit) end )
            PrecacheUnitByNameAsync( "temple_wolf_boss_2", function(unit) end )
            PrecacheUnitByNameAsync( "temple_wolf_boss_3", function(unit) end )
            PrecacheUnitByNameAsync( "temple_wolf_boss_4", function(unit) end )
            PrecacheUnitByNameAsync( "temple_wolf_boss_4_2", function(unit) end )
            PrecacheUnitByNameAsync( "temple_wolf_boss_3_2", function(unit) end )
            PrecacheUnitByNameAsync( "temple_wolf_boss_6", function(unit) end )
            PrecacheUnitByNameAsync( "act_1_nabu", function(unit) end )
            PrecacheUnitByNameAsync( "act_1_son", function(unit) end )
            PrecacheUnitByNameAsync( "act_1_villager", function(unit) end )
            PrecacheUnitByNameAsync( "pve_storm_crow", function(unit) end )
            --affixes
            PrecacheUnitByNameAsync( "temple_walking_bot", function(unit) end )
            PrecacheUnitByNameAsync( "temple_walking_bot2", function(unit) end )
            PrecacheUnitByNameAsync( "temple_rollermaw", function(unit) end )
            PrecacheUnitByNameAsync( "temple_mine", function(unit) end )
            

            --quest giver
            PrecacheUnitByNameAsync( "npc_dota_creature_questboard", function(unit) end )
            PrecacheUnitByNameAsync( "npc_dota_creature_quest_ogre", function(unit) end )

            --dragon sets
            PrecacheUnitByNameAsync( "warglaive_dragon", function(unit) end )
            PrecacheModel( "warglaive_dragon", context )
            PrecacheUnitByNameAsync( "agiset_dragon", function(unit) end )
            PrecacheModel( "agiset_dragon", context )
            PrecacheUnitByNameAsync( "strset_dragon", function(unit) end )
            PrecacheModel( "strset_dragon", context )
            PrecacheUnitByNameAsync( "intset_dragon", function(unit) end )
            PrecacheModel( "intset_dragon", context )
            PrecacheModel( "models/props_debris/merchant_debris_chest001.vmdl", context )
            

            PrecacheResource( "soundfile",  "soundevents/game_sounds_heroes/game_sounds_tidehunter.vsndevts", context)
            PrecacheResource( "soundfile",  "soundevents/game_sounds_heroes/game_sounds_tiny.vsndevts", context)
            PrecacheResource( "soundfile",  "soundevents/game_sounds_heroes/game_sounds_dragon_knight.vsndevts", context)
            PrecacheResource( "soundfile",  "soundevents/voscripts/game_sounds_vo_abaddon.vsndevts", context)
            PrecacheResource( "soundfile",  "soundevents/game_sounds_heroes/game_sounds_treant.vsndevts", context)
            
            --new artifact visuals
            PrecacheResource( "model", "models/items/phantom_assassin/creeping_shadow_head/creeping_shadow_head.vmdl", context )
            PrecacheResource( "model", "models/items/visage/bound_of_the_soul_keeper_familiar/bound_of_the_soul_keeper_familiar.vmdl", context )
            
            
          end

        end

        function Activate()
         -- Create our game mode and initialize it
         COverthrowGameMode:InitGameMode()
         -- Custom Spawn
         COverthrowGameMode:CustomSpawnCamps()
       end

       function COverthrowGameMode:CustomSpawnCamps()
         for name,_ in pairs(spawncamps) do
           spawnunits(name)
         end
       end

       ---------------------------------------------------------------------------
       -- Initializer
       ---------------------------------------------------------------------------
       GameState_Shopping = 1
       GameState_Arena = 2
       GameState_Farming = 3
       GameState_CityRaid = 4

       GameWinConditionExtended = 1 -- enabled by default, extends match if losing team won atleast 2 rounds in kills
       GameWinCondition = {}


       -- Test Bots
       testbots = false
       --cheatsenabled = false --used to prevent elo tracking on server

       -- Game Mode Voting, unused atm
       function COverthrowGameMode:GameWinConditionCheckVote()
         local short = 0
         local long = 0
         for i = 0, 25 do
          if GameWinCondition[i] ~= nil then
           if GameWinCondition[i] == 0 then
            short = short + 1
          else
            long = long + 1
          end
        end
      end
      if long > short then
        GameWinConditionExtended = 1
      end
    end

    -- Round 1 Quick Start Voting
    function COverthrowGameMode:QuickStartVote()
     --print("checking for quickstart")
     if self.GameState == GameState_Shopping then
      local voteamount = 0
      local totalPlayers = PlayerResource:GetPlayerCount()
      for i = 0, 25 do
       if self.FirstRoundQuickStartVote[i] ~= nil then
        if self.FirstRoundQuickStartVote[i] == 2 then
         voteamount = voteamount + 1
       end
     end
   end
   --print("vote count " .. voteamount)
   --print("total players " .. totalPlayers)
   --print(self.QuickStartVoteBool)
   if voteamount >= totalPlayers and self.QuickStartVoteBool == true then
     --print("everyone voted to start")
     if PlayerResource:GetPlayerCount() <= 1 then
      self.RoundCountdown = 11
    else
      self.RoundCountdown = 2
    end
    EmitSoundOn("DOTA_Item.Pipe.Activate", Entities:FindByName( nil, "team_base_1" ))
    EmitSoundOn("DOTA_Item.Pipe.Activate", Entities:FindByName( nil, "team_base_2" ))			
    self.QuickStartVoteBool = false
    if self.Quest ~= nil then
      self.Quest:CompleteQuest()
    end
  end
end
end

function COverthrowGameMode:ResetStartVotes()
	print("resetting votes")
	for i = 0, 25 do
		if self.FirstRoundQuickStartVote[i] ~= nil then
			self.FirstRoundQuickStartVote[i] = 0
		end
	end
end



function COverthrowGameMode:InitGameMode()
	--print( "GAA is loaded." )
	
  --	CustomNetTables:SetTableValue( "test", "value 1", {} );
  --	CustomNetTables:SetTableValue( "test", "value 2", { a = 1, b = 2 } );

  self.m_TeamColors = {}
  self.m_TeamColors[DOTA_TEAM_GOODGUYS] = { 61, 210, 150 }	--		Teal
  self.m_TeamColors[DOTA_TEAM_BADGUYS]  = { 243, 201, 9 }		--		Yellow
  self.m_TeamColors[DOTA_TEAM_CUSTOM_1] = { 197, 77, 168 }	--      Pink
  self.m_TeamColors[DOTA_TEAM_CUSTOM_2] = { 255, 108, 0 }		--		Orange
  self.m_TeamColors[DOTA_TEAM_CUSTOM_3] = { 52, 85, 255 }		--		Blue
  self.m_TeamColors[DOTA_TEAM_CUSTOM_4] = { 101, 212, 19 }	--		Green
  self.m_TeamColors[DOTA_TEAM_CUSTOM_5] = { 129, 83, 54 }		--		Brown
  self.m_TeamColors[DOTA_TEAM_CUSTOM_6] = { 27, 192, 216 }	--		Cyan
  self.m_TeamColors[DOTA_TEAM_CUSTOM_7] = { 199, 228, 13 }	--		Olive
  self.m_TeamColors[DOTA_TEAM_CUSTOM_8] = { 140, 42, 244 }	--		Purple

  for team = 0, (DOTA_TEAM_COUNT-1) do
    color = self.m_TeamColors[ team ]
    if color then
     --SetTeamCustomHealthbarColor( team, color[1], color[2], color[3] )
   end
 end

 self.m_VictoryMessages = {}
 self.m_VictoryMessages[DOTA_TEAM_GOODGUYS] = "#VictoryMessage_GoodGuys"
 self.m_VictoryMessages[DOTA_TEAM_BADGUYS]  = "#VictoryMessage_BadGuys"
 self.m_VictoryMessages[DOTA_TEAM_CUSTOM_1] = "#VictoryMessage_Custom1"
 self.m_VictoryMessages[DOTA_TEAM_CUSTOM_2] = "#VictoryMessage_Custom2"
 self.m_VictoryMessages[DOTA_TEAM_CUSTOM_3] = "#VictoryMessage_Custom3"
 self.m_VictoryMessages[DOTA_TEAM_CUSTOM_4] = "#VictoryMessage_Custom4"
 self.m_VictoryMessages[DOTA_TEAM_CUSTOM_5] = "#VictoryMessage_Custom5"
 self.m_VictoryMessages[DOTA_TEAM_CUSTOM_6] = "#VictoryMessage_Custom6"
 self.m_VictoryMessages[DOTA_TEAM_CUSTOM_7] = "#VictoryMessage_Custom7"
 self.m_VictoryMessages[DOTA_TEAM_CUSTOM_8] = "#VictoryMessage_Custom8"

 self.max_players = 5
 self.total_lives_lost = 0
 self.heroAbilityCount = 5
 self.m_GatheredShuffledTeams = {}
 self.numSpawnCamps = 5
 self.specialItem = ""
 self.spawnTime = 120
 self.nNextSpawnItemNumber = 1
 self.hasWarnedSpawn = false
 self.allSpawned = false
 self.leadingTeam = -1
 self.runnerupTeam = -1
 self.leadingTeamScore = 0
 self.runnerupTeamScore = 0
 self.isGameTied = true
 self.countdownEnabled = false
 self.itemSpawnIndex = 1
 self.healersInGame = 0
 self.itemSpawnLocation = Entities:FindByName( nil, "greevil" )
 self.act_already_loaded = {}
 self.tier1ItemBucket = {}
 self.tier2ItemBucket = {}
 self.tier3ItemBucket = {}
 self.tier4ItemBucket = {}
 self.tier5ItemBucket = {}
 self.tier5SetBucketStr = {}
 self.tier5SetBucketAgi = {}
 self.tier5SetBucketInt = {}
 self.tier6ItemBucket = {}
 self.affixbucket = {}
 self.act_affixes = {
  "pve_act_affix_reincarnation",
  "pve_act_affix_sanguine",
  "pve_act_affix_chainbreaker",
  "pve_act_affix_shieldmaster",
  "pve_act_affix_defiler",
  "pve_act_affix_avenger",
  "pve_act_affix_arcaneshield",
  "pve_act_affix_giant",
  "pve_act_affix_shaman",
  "pve_act_affix_lastwill",
  "pve_act_affix_reflexes",
  "pve_act_affix_horde",
  "pve_act_affix_pack",
  "pve_temple_affix_iron"
}
self.affixes = {
  "pve_temple_deathrattle",
  "pve_temple_aggro_armor",
  "pve_hammer_wave",
  "pve_meteor_crash",
  "pve_summonmovingcyclone_dark",
  "pve_temple_houndmaster",
  "pve_temple_reflect",
  "pve_temple_stompingcharge_straight",
  "pve_temple_colossus",
  "pve_temple_meteor",
  "pve_crit_high_low",
  "pve_temple_raisedead",
  "pve_temple_frostbreath",
  "pve_temple_crazy",
  "pve_temple_spottheweak",
  "pve_temple_viperpoison",
  "pve_temple_bloodritual",
  "pve_temple_rootaffix",
  "pve_healnegate",
  "pve_lifesteal_low",
  "pve_ice_nova_affix",
  "pve_temple_affix_shadowcloud",
  "pve_temple_bloodlust",
  "pve_temple_ambush",
  "pve_temple_affix_maniac",
  "pve_temple_affix_shadow_magus",
  "pve_temple_affix_immolation",
  "pve_temple_affix_heal_totem",
  "pve_temple_affix_resistance",
  "pve_temple_shockwave_affix",
  "pve_temple_affix_axemaster",
  "pve_temple_aggro_highest_hp",
  "pve_temple_aggro_ranged",
  "pve_affix_runner",
  "pve_affix_heal_on_hit",
  "pve_temple_fire_bolt",
  "pve_temple_fireball_ritual_hard_1",
  "pve_affix_firebreath",
  "pve_affix_grow_as",
  "pve_affix_frenzy",
  "pve_affix_ambush_dot",
  "pve_affix_aa_multishot",
  "pve_affix_rapidfire",
  "pve_affix_shadow_claw",
  "pve_affix_jumpstomp",
  "pve_affix_coils",
  --"pve_temple_rockthrow",
  --"pve_temple_rockthrow_curve",
  "pve_bash_10",
  "pve_trap_twin_dragons",
  "pve_trap_hydra",
  "pve_trap_arrows",
  "pve_temple_affix_glaivemaster",
  --"pve_pendulum_caller",
  "pve_affix_shrinking",
  "pve_temple_affix_arrowmaster",
  "pve_temple_affix_reflect_zone",
  "pve_temple_stompingcharge_straight_3",
  "pve_affix_fanatic_rage",
  "pve_temple_affix_taunt",
  "pve_wave_caller",
  "pve_affix_walking_laser_trap",
  "pve_chainlightning",
  "pve_affix_mines",
  "pve_rollermaw",
  "pve_affix_spinning_laser_trap",
  "pve_affix_chicken_at_each",
  "pve_temple_affix_armor_melt",
  "icehowl_10",
  "pve_greedy_saw",
  "pve_affix_fireball_aoe",
  "pve_bloodsucker",
  "pve_temple_lifelink",
  "pve_temple_axes2",
  "pve_temple_iceberg_linear2",
  "pve_temple_vipershot",
  "pve_temple_tower",
  "pve_temple_ogrebrutes",
  "pve_temple_heal_pool_affix",
  "pve_affix_pure_dot",
  "pve_affix_slow_poison",
  "pve_trap_hydra_2",
  "pve_frostfire_chains",
  "pve_temple_aoe_waterbolts2",
  "pve_temple_bloodpool_heal",
  "pve_temple_affix_cast_totem",
  "pve_rotting"
}  

--path artifact affixes
--DeepPrintTable(COverthrowGameMode.GeneratedItemData)
self.GeneratedItemDataPathIndex = 1 + #COverthrowGameMode.GeneratedItemData
--print("table GeneratedItemDataPathIndex is " .. self.GeneratedItemDataPathIndex)
for i=1, #COverthrowGameMode.PathTalentNames do
  local pathname = COverthrowGameMode.PathTalentNames[i]
  if pathname and pathname ~= "" and pathname ~= " " then
    local entry = {}
    local suffix = "y0" .. tostring(i)
    if i >= 10 then
      suffix = "y" .. tostring(i)
    end
    if i >= 100 then --using z for encoding paths abive 99 z12 = 112
      suffix = "z" .. string.sub(tostring(i), 2, 3)
    end
    entry[1] = suffix
    entry[2] = " Path: " .. pathname
    entry[3] = pathname
    entry[4] = pathname
    entry[5] = pathname
    table.insert(COverthrowGameMode.GeneratedItemData, entry)
  end
end
--DeepPrintTable(COverthrowGameMode.GeneratedItemData)
--DeepPrintTable(COverthrowGameMode.GeneratedItemData)

--mogushan
self.bosses = {}
self.bosses[1] = {
  "temple_wolf_boss_1",
  "temple_wolf_boss_2",
  "temple_wolf_boss_4"
}
self.bosses[2] = {
  "temple_sand_boss_1",
  "temple_sand_boss_2",
  "temple_sand_boss_3",
  "temple_sand_boss_5",
  "temple_sand_boss_7"
}
self.bosses[3] = {
  "temple_water_boss_1",
  "temple_water_boss_2",
  "temple_water_boss_3",
  "temple_water_boss_5",
  "temple_water_boss_7"
}
self.bosses[4] = {
  "temple_shadow_boss_1",
  "temple_shadow_boss_2",
  "temple_shadow_boss_3",
  "temple_shadow_boss_4",
  "temple_shadow_boss_5",
  "temple_shadow_boss_6"
}
self.bosses[5] = {
  "temple_dragon_boss_1",
  "temple_dragon_boss_2",
  "temple_dragon_boss_3",
  "temple_dragon_boss_5"
}
self.bosses[6] = {
  "temple_mount_boss_1",
  "temple_mount_boss_2",
  "temple_mount_boss_3",
  "temple_mount_boss_4",
  "temple_mount_boss_5",
  "temple_mount_boss_6"
}
self.bosses[7] = {
  "temple_tomb_boss_1",
  "temple_tomb_boss_2",
  "temple_tomb_boss_3"
}
self.bosses[8] = {
  "temple_volcano_boss_1",
  "temple_volcano_boss_2"
}
self.bosses[9] = {
  "mogushan_super_boss"
}
self.bosses[10] = {
  "temple_throne_boss_1"
}
self.bosses[11] = {
  "temple_temple_boss_1"
}
self.bosses[12] = {
  "temple_jungle_boss_0",
  "temple_jungle_boss_1",
  "temple_jungle_boss_3",
  "temple_jungle_boss_4",
  "temple_jungle_boss_5",
  "temple_jungle_boss_6",
  "temple_jungle_boss_7"
}   

self.mogushan_extra_bosses = {
  "temple_shadow_nightspider",
  "temple_wolf",
  "temple_shadow_archer",
  "temple_mount_plant",
  "temple_sand_stonegolem",
  "temple_sand_dustboar"
}
self.boss_spells = {}
self.boss_spells[1] = {
  "pve_crit_high",
  "pve_temple_dot_bleed_random",
  "pve_stunaoe_high_cd",
  "pve_wolf_rage",
  "pve_wolf_summon_at_each",
  "pve_temple_stompingcharge_circle",
  "pve_aoesilence",
  "pve_temple_stompingcharge_notrandom",
  "pve_temple_ritual_reflect_claw",
  "pve_lowest_aggro_hunt",
  "pve_temple_wolf_armor_strikes",
  "pve_aoe_spell_1",
  "pve_temple_bolt_aoe_claw",
  "pve_affix_jumpstomp",
  "icehowl_3",
  "pve_temple_random_stun_not_lowest",
  "pve_generated_spell_wolfclawpurehp",
  "pve_temple_furthest_target_summon",
  "pve_temple_stompingcharge_notrandom2",
  "pve_temple_aggro_mres",
  "pve_temple_self_heal_with_stun"
}
self.boss_spells[2] = {
  "pve_temple_aoe_impale_random",
  "pve_temple_summon_mass_rocks",
  "boss1_aafrenzy",
  "pve_temple_random_aoe_spawns_one_fat",
  "pve_temple_sand_one_poison_ward",
  "pve_temple_veno_nova",
  "pve_temple_armor_poison",
  "pve_temple_bristle_add_cc",
  "pve_temple_medusa_shield_shot",
  "pve_temple_shadow_link_close",
  "pve_summonmovingcyclone",
  "pve_temple_earthquake_random",
  "pve_temple_impale_four_dir",
  "boss1_aahealthreduce",
  "pve_temple_bolt_aoe_rock",
  "pve_temple_bolt_aoe_claw_bouncing",
  "pve_tuskboar",
  "pve_temple_trample",
  "pve_temple_aggro_cycling",
  "pve_temple_hoofquake",
  "pve_temple_highest_aggro_summon"
  --"medusa_stone_gaze"
  --"pve_temple_stompingcharge"
}
self.boss_spells[3] = {
  --"pve_temple_cleave_siren",
  "pve_temple_water_ground_dmg",
  "pve_fungal_summon_at_each",
  "pve_temple_self_heal",
  "pve_slow_on_damage_stacking",
  "pve_bash_low",
  "pve_summonmoving_water_linear",
  "pve_temple_aoe_waterbolts",
  "pve_aa_wavestrike",
  "pve_waterstomp_enrage",
  --"pve_temple_aoe_sleep",
  "pve_temple_random_doom_aoe_poison",
  "pve_temple_water_aoedmg",
  "pve_lowest_aggro_hunt",
  "Shield_ReflectPVE",
  "pve_temple_water_slark_kite",
  "pve_temple_bolt_aoe_water",
  "icehowl_2",
  "icehowl_6",
  "pve_wave_caller_10",
  "pve_generated_spell_wateraoefollowing",
  "pve_affix_fanatic_rage2",
  "pve_temple_random_aggro_summon"
}
self.boss_spells[4] = {
  "pve_summonmoving_shadow_linear",
  "pve_temple_tank_bolt",
  "pve_temple_summon_ritual",
  "pve_temple_dot_bleed_random",
  "pve_temple_super_bolt",
  "pve_temple_random_aoe_spawns",
  "pve_temple_self_heal",
  "pve_random_aggro_hunt",
  --"pve_temple_damage_aura_anti_divided",
  "pve_temple_furthest_buff",
  "pve_temple_shadow_infernos",
  "pve_temple_random_doom",
  "pve_temple_random_doom_aoe",
  "pve_temple_fireball_random_charge",
  "pve_temple_aa_shadowcloud",
  "pve_shadow_enrage",
  "pve_temple_furthest_shadow_collector",
  --"pve_temple_random_aoe_firestorm",
  "pve_temple_aoe_waterbolts3",
  "pve_temple_bolt_aoe_shadow",
  "pve_temple_bolt_aoe_shadow_bouncing",
  "icehowl_4",
  "pve_hellgate",
  "pve_temple_lowest_aggro_summon"
  --"pve_temple_aa_skeleton"
}
self.boss_spells[5] = {
  "pve_temple_reflect_passive",
  "pve_temple_reflect_buffs",
  "pve_temple_shadow_aoe",
  "pve_temple_shadow_link",
  "pve_temple_dragon_eggs",
  "pve_temple_dot_furthest",
  "pve_temple_random_target_summon",
  "pve_temple_healing_collector",
  "pve_temple_passive_fire_aoe",
  "pve_temple_tank_stack",
  "pve_temple_dragon_totems",
  "pve_temple_look_damage",
  "pve_temple_random_aoe_dmg_rosh",
  "pve_temple_heal_aoe",
  "pve_enrage_casttime",
  "pve_aa_stun_ice_random",
  "pve_temple_damage_aura_anti_divided_frost",
  "pve_temple_ringoffrost",
  "pve_temple_bolt_aoe_fire",
  "icehowl_7",
  "pve_trap_turning_dragons2"
}
self.boss_spells[6] = {
  "pve_sprint_low",
  "pve_random_aggro_hunt_2",
  "pve_temple_immolation",
  "pve_temple_fireball_circle",
  "pve_temple_furthest_fire_collector",
  "pve_temple_fireball_ritual",
  "pve_big_slow_hits",
  "pve_temple_cleave_2",
  "pve_temple_reflect_passive_low",
  "pve_temple_aoe_roots",
  "pve_bearform_enrage",
  "pve_temple_stampede",
  "pve_temple_mount_roar",
  "pve_temple_thunder_strikes",
  "pve_wisp_army",
  "pve_temple_movingthunder",
  "pve_thunder_shield",
  "boss1_aafrenzy_time_2",
  "pve_circle_flames",
  "pve_temple_bolt_aoe_nature",
  "icehowl_8"
}
self.boss_spells[7] = {
  "pve_temple_ritual_aoe_dmg",
  "pve_temple_lowest_aggro_wave",
  "pve_temple_shadowpool",
  "pve_temple_shadow_slark_kite",
  "pve_temple_aa_stack_kill",
  "pve_temple_enrage_passive_low",
  "pve_temple_random_impale",
  "pve_temple_tomb_heal_collector",
  "pve_temple_aoe_impale_circular",
  "pve_temple_aggro_highest_hp_boss",
  "pve_temple_random_bug_spawn",
  "pve_temple_root_passive_low",
  "pve_temple_aoe_dot_execute",
  "pve_temple_aoe_bolts_lifesteal",
  "pve_lowest_aggro_hunt_enrage",
  "pve_temple_aoe_dmg_range_invert",
  "pve_temple_aa_poisoncloud",
  "pve_temple_aa_skeleton_necro",
  "pve_omni_1"
}
self.boss_spells[8] = {
  "pve_temple_aoe_dot_moving",
  "pve_temple_summon_fireball_each",
  "pve_temple_aoe_dmg_save_zone",
  "pve_aa_fireaoe",
  "pve_temple_fire_ward",
  "pve_temple_volcano",
  "pve_temple_flamepool_run",
  --"pve_temple_aoe_dmg_save_zonerings",
  "pve_temple_fire_bolt",
  "pve_stunaoe_fire",
  "pve_temple_summon_magma"
}
--passives
self.boss_spells[9] = {
  "pve_bash_10",
  "pve_healnegate75",
  "pve_crit_high",
  "pve_aa_fireaoe",
  "pve_temple_cleave_siren",
  "pve_temple_affix_axemaster",
  "pve_temple_affix_resistance",
  "pve_temple_shockwave_affix",
  "pve_temple_bolt_aoe_thunder",
  "pve_affix_frenzy",
  "pve_affix_jumpstomp",
  "pve_temple_rockthrow_curve",
  "icehowl_9",
  "icehowl_5",
  "pve_first_arena_earth",
  "pve_first_arena_flames"
}
self.boss_spells[10] = {
  "pve_temple_emp",
  "pve_temple_arcane_barrage_aoe",
  "pve_temple_iceberg_linear",
  "pve_temple_aoe_dmg_range_invert_knockback",
  --"pve_temple_dot_furthest_frost",
  "pve_shadow_summon_at_each",
  "pve_temple_dot_furthest_shadow_spread",
  "pve_temple_reflect_buffs_invoker",
  "pve_temple_fireball_random",
  "pve_temple_random_aoe_explosion",
  "pve_temple_fireball_ritual_hard_2",
  "pve_temple_invoker_arcane_totems",
  "pve_temple_one_fat_blizzard"
}
self.boss_spells[11] = {
  "pve_temple_invoker_shadow_totems",
  "pve_temple_tank_bolt",
  "pve_temple_dot_furthest_frost",
  "pve_shadow_summon_at_each",
  "pve_temple_dot_furthest_shadow_spread",
  "pve_temple_reflect_buffs_invoker",
  "temple_shadowstrike"
}
self.boss_spells[12] = {
  "pve_12_0_1",
  "pve_12_0_2",
  "pve_12_1_1",
  "pve_12_1_2",
  "pve_12_1_3",
  "pve_temple_bolt_aoe_thunder",
  "pve_12_2_1",
  "pve_12_2_2",
  "pve_temple_arrowrain",
  "pve_temple_arrowrain_2",
  "pve_temple_bolt_aoe_nature",
  "pve_affix_rapidfire",
  "pve_12_4_3",
  "pve_12_4_1",
  "pve_12_4_2",
  "pve_12_4_4",
  "pve_12_5_1",
  "pve_12_5_2",
  "pve_temple_bolt_aoe_shadow",
  "pve_temple_heal_pool",
  "pve_12_6_3",
  "pve_12_6_4",
  "pve_temple_heal_aoe_75",
  "pve_12_7_1",
  "pve_12_7_2",
  "pve_12_7_3",
  "pve_temple_affix_axemaster",
  "pve_temple_deathrattle"
}
self.boss_spells[13] = {
  "act13_ms",
  "act13_frenzy",
  "act13_aura_as",
  "act13_bash",
  "act13_ice_armor",
  "act13_as",
  "act13_arrows",
  "pve_temple_affix_taunt",
  "pve_affix_aa_multishot_frost",
  "act13_frost_orbs",
  "act13_chain_frost",
  "act13_frostwyrm",
  "act13_ms_2",
  "act13_catapult"
}


self.act_kills = {0,0,0,0,0,0,0,0,0,0,0,0,0}
self.act_kills_max = {5,7,9,9,14,9,4,8,50,2,11,14,3}
self.act11_bosses = {}

self.boss_kills_per_act = {}
for i=1,13 do
  self.boss_kills_per_act[i] = 0
end

self.mogushankills = 0
self.max_mogushan_rounds = 50
self.player_count_scale = 1
--self.quest_mogushan_completed = 0

self.hero_spells = {}
--1 = ranger
self.hero_spells[1] = {}
self.hero_spells[1]["Focussed_Shot"] = 10
self.hero_spells[1]["Icy_Shot"] = 10
self.hero_spells[1]["Inspiring_Shot"] = 20
self.hero_spells[1]["Mindfreezing_Shot"] = 30
self.hero_spells[1]["frost_lake"] = 20
self.hero_spells[1]["glacier_crack_spell"] = 30
self.hero_spells[1]["beast1"] = 10
self.hero_spells[1]["Hunter_Assassinate"] = 10
self.hero_spells[1]["Snipe"] = 20
self.hero_spells[1]["Beastrage"] = 30
self.hero_spells[1]["Beastheal"] = 30
self.hero_spells[1]["Bear"] = 30
self.hero_spells[1]["wind1"] = 10
self.hero_spells[1]["wind2"] = 10
self.hero_spells[1]["wind3"] = 20
self.hero_spells[1]["wind4"] = 30
self.hero_spells[1]["wind5"] = 30
self.hero_spells[1]["wind7"] = 30
--2 = shaman
local index = 2
self.hero_spells[index] = {}
self.hero_spells[index]["Spirit_Heal"] = 10
self.hero_spells[index]["Lightning_Bolt"] = 10
self.hero_spells[index]["Spirit_Shock"] = 20
self.hero_spells[index]["Lavaburst"] = 30
self.hero_spells[index]["serpent_twins"] = 20
self.hero_spells[index]["Lightning_Storm"] = 30
self.hero_spells[index]["Ghost1"] = 10
self.hero_spells[index]["Ghost2"] = 10
self.hero_spells[index]["Ghost3"] = 20
self.hero_spells[index]["Ghost4"] = 30
self.hero_spells[index]["Ghost5"] = 30
self.hero_spells[index]["Ghost6"] = 30
self.hero_spells[index]["resto1"] = 10
self.hero_spells[index]["resto2"] = 10
self.hero_spells[index]["resto3"] = 20
self.hero_spells[index]["resto4"] = 30
self.hero_spells[index]["resto5"] = 30
self.hero_spells[index]["resto6"] = 30
--3 = warrior
index = 3
self.hero_spells[index] = {}
self.hero_spells[index]["Protect1"] = 10
self.hero_spells[index]["Protect2"] = 10
self.hero_spells[index]["Protect3"] = 20
self.hero_spells[index]["Protect4"] = 30
self.hero_spells[index]["Protect5"] = 20
self.hero_spells[index]["WarriorCharge"] = 30
self.hero_spells[index]["Shield_Reflect"] = 10
self.hero_spells[index]["Terror_ShoutProt"] = 10
self.hero_spells[index]["Terror_ShoutFury"] = 20
self.hero_spells[index]["Terror_Shout"] = 30
self.hero_spells[index]["fury1"] = 30
self.hero_spells[index]["fury2"] = 30
self.hero_spells[index]["fury3"] = 10
self.hero_spells[index]["fury4"] = 10
self.hero_spells[index]["fury5"] = 20
self.hero_spells[index]["Wounding_Strike"] = 30
self.hero_spells[index]["Mortal_Swing"] = 30
self.hero_spells[index]["Concussive_Blow"] = 30
self.hero_spells[index]["Knee_Breaker"] = 30
self.hero_spells[index]["Sword_Storm"] = 30
self.hero_spells[index]["temple_brawler_defstance"] = 30
self.hero_spells[index]["temple_brawler_battlestance"] = 30
self.hero_spells[index]["temple_brawler_furystance"] = 30
--4 = paladin
index = 4
self.hero_spells[index] = {}
self.hero_spells[index]["Retri1"] = 10
self.hero_spells[index]["Retri2"] = 10
self.hero_spells[index]["Retri3"] = 20
self.hero_spells[index]["Retri4"] = 30
self.hero_spells[index]["Retri5"] = 20
self.hero_spells[index]["Retri6"] = 30
self.hero_spells[index]["Divine_Light"] = 10
self.hero_spells[index]["Holy_Judgement"] = 10
self.hero_spells[index]["Exorcism"] = 20
self.hero_spells[index]["Prayer_Of_Protection"] = 30
self.hero_spells[index]["Guardian"] = 30
self.hero_spells[index]["Holy_Shield"] = 30
self.hero_spells[index]["pala1"] = 10
self.hero_spells[index]["pala2"] = 10
self.hero_spells[index]["pala3"] = 20
self.hero_spells[index]["pala4"] = 30
self.hero_spells[index]["pala5"] = 30
self.hero_spells[index]["pala6"] = 30
--5 = mage
index = 5
self.hero_spells[index] = {}
self.hero_spells[index]["Arcane1"] = 10
self.hero_spells[index]["Arcane2"] = 10
self.hero_spells[index]["Arcane3"] = 20
self.hero_spells[index]["Arcane4"] = 30
self.hero_spells[index]["Arcane7"] = 20
self.hero_spells[index]["Arcane6"] = 30
self.hero_spells[index]["Magma_Bolt"] = 10
self.hero_spells[index]["Fire_Lance"] = 10
self.hero_spells[index]["Molten_Lava"] = 20
self.hero_spells[index]["Dragon_Claw"] = 30
self.hero_spells[index]["Polymorph"] = 30
self.hero_spells[index]["fire6"] = 30
self.hero_spells[index]["Ice_Bolt"] = 10
self.hero_spells[index]["Frost_Shatter"] = 10
self.hero_spells[index]["Ice_Nova"] = 20
self.hero_spells[index]["Ice_Armor"] = 30
self.hero_spells[index]["Polymorph"] = 30
self.hero_spells[index]["Waterelemental"] = 30
--6 = druid support
index = 6
self.hero_spells[index] = {}
self.hero_spells[index]["Lifebloom"] = 10
self.hero_spells[index]["Regrowth"] = 10
self.hero_spells[index]["Restoration"] = 20
self.hero_spells[index]["RootsDruid"] = 30
self.hero_spells[index]["CycloneDruid"] = 20
self.hero_spells[index]["ShapeshiftTemple"] = 30
self.hero_spells[index]["moon11"] = 10
self.hero_spells[index]["moon3"] = 10
self.hero_spells[index]["moon2"] = 20
self.hero_spells[index]["moon4"] = 30
self.hero_spells[index]["moon5"] = 30
self.hero_spells[index]["moon6Temple"] = 30
self.hero_spells[index]["moon1"] = 10
self.hero_spells[index]["RootsDruidMoon"] = 10
self.hero_spells[index]["moon12"] = 20
self.hero_spells[index]["moon9"] = 30
self.hero_spells[index]["moon10"] = 30
self.hero_spells[index]["Shapeshift"] = 30
--self.hero_spells[index]["CycloneDruidFeral"] = 30
--self.hero_spells[index]["RootsDruidFeral"] = 30
--7 = priest
index = 7
self.hero_spells[index] = {}
self.hero_spells[index]["holy1"] = 10
self.hero_spells[index]["holy2"] = 10
self.hero_spells[index]["holy3"] = 20
self.hero_spells[index]["holy4"] = 30
self.hero_spells[index]["holy55"] = 20
self.hero_spells[index]["holy6"] = 30
self.hero_spells[index]["Light_of_Heaven"] = 10
self.hero_spells[index]["sacred_shield"] = 10
self.hero_spells[index]["Dark_Light2"] = 20
self.hero_spells[index]["disc7"] = 30
self.hero_spells[index]["Shadow_Creeper"] = 30
self.hero_spells[index]["Fear_of_Dark"] = 30
self.hero_spells[index]["shadow1"] = 10
self.hero_spells[index]["shadow11"] = 10
self.hero_spells[index]["shadow33"] = 20
self.hero_spells[index]["shadow3"] = 30
self.hero_spells[index]["shadow5"] = 30
self.hero_spells[index]["shadow6"] = 30
--8 = dk
index = 8
self.hero_spells[index] = {}
self.hero_spells[index]["Corrupting_Strike"] = 10
self.hero_spells[index]["Rot"] = 10
self.hero_spells[index]["Infested_Wound"] = 20
self.hero_spells[index]["Death_For_Life"] = 30
self.hero_spells[index]["Deafening_Coil"] = 20
self.hero_spells[index]["Fatal_Grasp"] = 30
self.hero_spells[index]["frostdk1"] = 10
self.hero_spells[index]["frostdk2"] = 10
self.hero_spells[index]["frostdk3"] = 20
self.hero_spells[index]["frostdk4"] = 30
self.hero_spells[index]["frostdk5"] = 30
self.hero_spells[index]["frostdk6"] = 30
self.hero_spells[index]["unholy_1"] = 10
self.hero_spells[index]["unholy_2"] = 10
self.hero_spells[index]["unholy_3"] = 20
self.hero_spells[index]["unholy_4"] = 30
self.hero_spells[index]["unholy_5"] = 30
self.hero_spells[index]["unholy_6"] = 30
--9 = rogue
index = 9
self.hero_spells[index] = {}
self.hero_spells[index]["Dagger_Strike"] = 10
self.hero_spells[index]["Numbing_Cut"] = 10
self.hero_spells[index]["Fatal_Throw"] = 20
self.hero_spells[index]["Ambush"] = 30
self.hero_spells[index]["Shadow_Blend"] = 20
self.hero_spells[index]["combat1"] = 30
self.hero_spells[index]["combat2"] = 10
self.hero_spells[index]["combat3"] = 10
self.hero_spells[index]["combat4"] = 20
self.hero_spells[index]["combat5"] = 30
self.hero_spells[index]["hawk1"] = 30
self.hero_spells[index]["hawk2"] = 30
self.hero_spells[index]["hawk3"] = 10
self.hero_spells[index]["hawk4"] = 10
self.hero_spells[index]["hawk7"] = 20
--10 = dh
index = 10
self.hero_spells[index] = {}
self.hero_spells[index]["dh1"] = 10
self.hero_spells[index]["dh2"] = 10
self.hero_spells[index]["dh3"] = 20
self.hero_spells[index]["dh4"] = 30
self.hero_spells[index]["dh5"] = 20
self.hero_spells[index]["dh6"] = 30
self.hero_spells[index]["terror1"] = 10
self.hero_spells[index]["terror2"] = 10
self.hero_spells[index]["terror3"] = 20
self.hero_spells[index]["terror4"] = 30
self.hero_spells[index]["terror5"] = 30
self.hero_spells[index]["terror6"] = 30
--11 = witcher
index = 11
self.hero_spells[index] = {}
self.hero_spells[index]["demo1"] = 10
self.hero_spells[index]["demo2"] = 10
self.hero_spells[index]["demo3"] = 20
self.hero_spells[index]["demo4"] = 30
self.hero_spells[index]["demo5"] = 20
self.hero_spells[index]["demo6"] = 30
self.hero_spells[index]["destro1"] = 10
self.hero_spells[index]["destro2"] = 10
self.hero_spells[index]["destro3"] = 20
self.hero_spells[index]["destro4"] = 30
self.hero_spells[index]["Shadowfury"] = 30
self.hero_spells[index]["destro6"] = 30
self.hero_spells[index]["Agony"] = 10
self.hero_spells[index]["Pain_Warlock"] = 10
self.hero_spells[index]["Agony2"] = 20
self.hero_spells[index]["dark_ranger_life_drain"] = 30
self.hero_spells[index]["Fear_Warlock"] = 20
self.hero_spells[index]["Felhunter"] = 30

self.molten_forge_shop_position = Entities:FindByName( nil, "volcano2" ):GetAbsOrigin()+Vector(1300, 300,0)
self.home_base_position = Entities:FindByName( nil, "team_base_1" ):GetAbsOrigin()
--temple class precache
--for k, v in pairs(COverthrowGameMode.hero_spells[1]) do
  --    print(k)
  --    print(v)
  --    PrecacheItemByNameAsync( k, function(unit) end )
  --end
  --print(#self.hero_spells[1])
  --print(self.hero_spells[1][math.random(1,#self.hero_spells[1])])

  math.randomseed(Time())

  --intools
  --self.intools = false
  
  --mythic
  self.mythic_slots = 11
  --stash
  --self.max_stashes = 5
  --self.current_stash_id = 1

  --talents, path
  self.maxtalents = 162 --144 --120

  self.TEAM_KILLS_TO_WIN = 7
  self.CLOSE_TO_VICTORY_THRESHOLD = 2


  --PVE stuff
  self.PVELives = 5 --todo 3
  self.auto_load_on = true --instantly load hero data when hero got picked

  -- new PVE mixed Mode, FARM MODE
  self.FarmMode = 0

  self.EnableShapeshift = 1

  --ranked games
  self.rankedgame = 0
  self.leaverreported = false

  --self:CreateAct11LastBoss()

  --rune of detection
  self.arenachosen = -1
  self.runeofdetection = nil
  ---------------------------------------------------------------------------

  self:GatherAndRegisterValidTeams()

  GameRules:GetGameModeEntity().COverthrowGameMode = self

  -- Show the ending scoreboard immediately
  GameRules:SetCustomGameEndDelay( 20 )
  GameRules:SetCustomVictoryMessageDuration( 1000 )
  --GameRules:SetHideKillMessageHeaders( true )
  --GameRules:GetGameModeEntity():SetTopBarTeamValuesOverride( true ) --inversed
  GameRules:GetGameModeEntity():SetNeutralStashEnabled(false)
  GameRules:GetGameModeEntity():SetNeutralStashTeamViewOnlyEnabled(true)
  GameRules:GetGameModeEntity():SetTopBarTeamValuesVisible( true ) --inversed
  GameRules:SetHideKillMessageHeaders( true )
  GameRules:SetUseUniversalShopMode( true ) --false!
  GameRules:GetGameModeEntity():SetRuneEnabled( 0, false ) --Double Damage
  GameRules:GetGameModeEntity():SetRuneEnabled( 1, false ) --Haste
  GameRules:GetGameModeEntity():SetRuneEnabled( 2, false ) --Illusion
  GameRules:GetGameModeEntity():SetRuneEnabled( 3, false ) --Invis
  GameRules:GetGameModeEntity():SetRuneEnabled( 4, false ) --Regen
  GameRules:GetGameModeEntity():SetRuneEnabled( 5, false ) --Bounty
  GameRules:GetGameModeEntity():SetLoseGoldOnDeath( false )
  GameRules:GetGameModeEntity():SetFountainPercentageHealthRegen( 20 )
  GameRules:GetGameModeEntity():SetFountainPercentageManaRegen( 20 )
  GameRules:GetGameModeEntity():SetFountainConstantManaRegen( 30 )
  GameRules:GetGameModeEntity():SetBountyRunePickupFilter( Dynamic_Wrap( COverthrowGameMode, "BountyRunePickupFilter" ), self )
  GameRules:GetGameModeEntity():SetExecuteOrderFilter( Dynamic_Wrap( COverthrowGameMode, "ExecuteOrderFilter" ), self )

  -- PWS damage filter, my own
  GameRules:GetGameModeEntity():SetDamageFilter(Dynamic_Wrap(COverthrowGameMode, "FilterDamage"), self)			--SetExecuteOrderFilter(Dynamic_Wrap(GameMode, "OrderFilter"), self)
  GameRules:GetGameModeEntity():SetModifyExperienceFilter(Dynamic_Wrap(COverthrowGameMode, "FilterExperience"), self)


  --new pre game stuff
  GameRules:SetShowcaseTime( 0.0 )
  GameRules:SetStrategyTime( 0.5 )


  GameRules:GetGameModeEntity():SetRecommendedItemsDisabled(true)


  -- My own tests -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  --GameRules:SetCustomGameSetupRemainingTime( 10 ) --no effect!todo
  --GameRules:SetCustomGameSetupTimeout(10)
  GameRules:SetGoldPerTick(0)
  GameRules:SetFirstBloodActive(false)
  GameRules:SetHeroSelectionTime(180)
  GameRules:SetHeroRespawnEnabled(true)
  GameRules:SetPostGameTime(90)
  GameRules:SetPreGameTime(1)
  GameRules:SetSameHeroSelectionEnabled(true)
  GameRules:SetUseCustomHeroXPValues(true)
  GameRules:SetStartingGold(0)
  GameRules:SetCustomGameSetupAutoLaunchDelay(5)

  -- further tests for pickign and stuff
  --GameRules:LockCustomGameSetupTeamAssignment(false)



  self.GameState = GameState_Shopping


  self.RoundCountdown=100
  self.RoundCounter = 1
  -- time measurement
  self.SecondsCounter = 0
  self.GameMinutes = 0
  self.HeroesAlivePerTeam={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
  self.TeamIsPlaying={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
  self.RoundWonPerTeam={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}

  --Quests
  self.Quest = nil
  self.StartQuest = true
  self.FirstRoundQuickStartVote = {}
  self.QuickStart = true -- for the Quest Showing
  self.QuickStartVoteBool = true  -- for the functionchecking

  --camera
  GameRules:GetGameModeEntity():SetCameraDistanceOverride(1350.0)

  --fog
  GameRules:GetGameModeEntity():SetUnseenFogOfWarEnabled(true)
  GameRules:GetGameModeEntity():SetFogOfWarDisabled(false)
  -- sewers arena waterfall

  self.waterfall = -1


  -- max level
  
  if true then --GetMapName() == "beginner_hero_level_1_to_9" or GetMapName() == "expert_hero_level_10_or_higher" then
    GameRules:GetGameModeEntity():SetUseCustomHeroLevels(true)
    --local levelTable = {0, 200, 500,900,1400,2000,2700,3500,4400,5400,40000,100000,170000,250000,360000,460000,570000,690000,720000,850000}

        --[[old table for save
        local levelTable = {
            --1 to 10
            0, 25, 100, 300, 700,1400,2300,3300,4300,5400, -- ~500 per level
            --11 to 20
            6400,8500,10600,12700,13800,15900,18000,20500,23500,27000, --2k per level
            --21 to 30
            80000,160000,240000,320000,400000,480000,560000,640000,720000,800000, --80k per level
            --80000,160000,240000,320000,400000,480000,560000,640000,720000,800000,
            --31 to 40
            1000000,1300000,1600000,1900000,2200000,2500000,2800000,3100000,3500000,4000000, --300k per level
            --41 to 45
            7000000,10000000,13000000,16000000,19000000, -- 3 mil per level
            --46 to 50
            29000000,39000000,49000000,59000000,60000000, --10 mil per level
            --51 to 55
            72000000,85000000,99000000,114000000,130000000, -- ~15 mil per level
            --56 to 60
            147000000,165000000,185000000,205000000,225000000, -- 20 mil per level
            --61 to 65
            250000000,275000000,300000000,325000000,350000000, -- 25 mil per level
            --66 to 70
            375000000,400000000,425000000,450000000,475000000, -- 25
            --71 to 75
            500000000,550000000,600000000,650000000,700000000, -- 50
            --76 to 80
            750000000, 800000000, 850000000, 900000000, 950000000 --50
            --40000,100000,170000,250000,360000,460000,570000,690000,720000,850000
          }]]

          local levelTable = {
            --1 to 10
            0, 6, 125, 300, 500,1200,2000,3300,4300,5400, -- ~500 per level   0, 25 , 100, 300, 700, 1400, 2300, 3300
            --11 to 20
            7000,9000,11000,13000,15000,17000,19000,21000,23000,25000, --2k per level
            --21 to 30
            50000,80000,110000,140000,170000,200000,230000,280000,340000,400000, --80k per level, better 30k per level
            --80000,160000,240000,320000,400000,480000,560000,640000,720000,800000,
            --31 to 40
            700000,1000000,1300000,1600000,1900000,2300000,2700000,3100000,3500000,4000000, --300k per level
            --41 to 45
            --7000000,10000000,13000000,16000000,19000000,
            5000000,6000000,7000000,8000000,9000000, -- 3 mil per level
            --46 to 50
            --29000000,39000000,49000000,59000000,60000000,
            10000000,12000000,14000000,17000000,20000000, --10 mil per level
            --51 to 55
            --72000000,85000000,99000000,114000000,130000000,
            25000000,30000000,35000000,40000000,45000000, -- ~15 mil per level
            --56 to 60
            --147000000,165000000,185000000,205000000,225000000,
            55000000,65000000,75000000,85000000,100000000, -- 20 mil per level
            --61 to 65
            --250000000,275000000,300000000,325000000,350000000,
            120000000,140000000,160000000,180000000,200000000, -- 25 mil per level
            --66 to 70
            230000000,260000000,290000000,320000000,350000000, -- 25
            --71 to 75
            400000000,450000000,500000000,550000000,600000000, -- 50
            --76 to 80
            650000000, 700000000, 800000000, 850000000, 920000000, --50
            --81 to 85
            1000000000, 1050000000, 1100000000, 1150000000, 1200000000, --100
            --86 to 90
            1250000000, 1300000000, 1350000000, 1400000000, 1450000000, --100
            --91 to 95
            1500000000, 1550000000, 1600000000, 1650000000, 1700000000, --200
            --96 to 100
            1750000000, 1850000000, 1910000000, 1970000000, 2050000000 --200
            --old, max value reached
            --81 to 85
            --1050000000, 1150000000, 1250000000, 1350000000, 1450000000, --100
            --86 to 90
            --1550000000, 1650000000, 1750000000, 1850000000, 1950000000, --100
            --91 to 95
            --2150000000, 2350000000, 2550000000, 2750000000, 2950000000, --200
            --96 to 100
            --3150000000, 3350000000, 3550000000, 3750000000, 3950000000 --200
          }

          local levelTableDotaFake = { --max lvl 25
            --1 to 10
            0, 6, 125, 300, 500,1200,2000,3300,4300,5400, -- ~500 per level   0, 25 , 100, 300, 700, 1400, 2300, 3300
            --11 to 20
            7000,9000,11000,13000,15000,17000,19000,21000,23000,25000, --2k per level
            --21 to 25
            50000,80000,110000,140000,170000
          }

          --season 5: xp adjust /5
          for entry=1, #levelTable do
            local factor = 1 + (entry - 20) / 15
            if factor < 1 then
              factor = 1
            end
            if factor > 5 then
              factor = 5
            end
            levelTable[entry] = levelTable[entry] / factor
          end
          for entry=1, #levelTableDotaFake do
            local factor = 1 + (entry - 20) / 15
            if factor < 1 then
              factor = 1
            end
            if factor > 5 then
              factor = 5
            end
            levelTableDotaFake[entry] = levelTableDotaFake[entry] / factor
          end
          --tests with other exp functions
          --pure exponential xp, bad cuz most xp sits at level 60+, wolfram alpha 25*1.24724^x, x > 0, x < 80
        --[[
        levelTable[1] = 0
        for i=0,78 do
            --levelTable[i] = 25 * math.pow(1.24724, i-1)
            local exponential = 25 * math.pow(1.2508, i)
            local linear = i * 949999975 / 78 + 25
            levelTable[i+2] = 0.000125 * linear + 0.999875 * exponential --25 * i * i * i * i
        end
        levelTable[1] = 0
        DeepPrintTable(levelTable)]]

        --mixed, exp + linear: plot 0.5 * 25*1.24724^x + 0.5 * x*950000000/79, x > 0, x < 80
        --quadratic x2: plot 25 * x*x * 6100 , x > 0, x < 80
        --quadratic x3: plot f(x) = 25 * x*x*x * 78  , x > 0, x < 80, not bad, 40 mil exp at level 45
        --quadratic x4: plot f(x) = 25 * x*x*x *x  , x > 0, x < 80
        --mixed quadratic + linear: 

        --local xpAmount = 2000
        --levelTable[0] = 0 -- XP table requires a leading 0
        --for i=1,10 do
          --levelTable[i] = xpAmount
          --xpAmount = xpAmount + 3000
          --print( string.format( "%s %s", i, xpAmount ) )
          --end
          --levelTable[11] = 1600
          --levelTable[12] = 3000
          --DeepPrintTable(levelTable)
          self.levelTable = levelTable
          GameRules:GetGameModeEntity():SetCustomXPRequiredToReachNextLevel( levelTableDotaFake )
          --GameRules:GetGameModeEntity():SetUseCustomHeroLevels(true)

          --premium slot buy mode
          self.junglemodepremium = 1
          --self.jungledifficulty = 1.0
        end

        -- Data Tracking
        self.HealerTeamRatio={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
        --self.HealerTeamRatio[DOTA_TEAM_GOODGUYS] = 0
        --self.HealerTeamRatio[DOTA_TEAM_BADGUYS] = 0


        --arena control positions
        self.team_control_pos_1 = 0
        self.team_control_pos_2 = 0
        self.team_control_pos_3 = 0
        self.team_control_pos_4 = 0
        self.teamleader_1 = nil
        self.teamleader_2 = nil

        --find team leaders
        for i=0, PlayerResource:GetPlayerCount() do
          local player = PlayerResource:GetPlayer(i)
          if player ~= nil and player:GetTeamNumber() == DOTA_TEAM_GOODGUYS and self.teamleader_1 == nil then
           self.teamleader_1 = i
         end	
         if player ~= nil and player:GetTeamNumber() == DOTA_TEAM_BADGUYS and self.teamleader_2 == nil then
           self.teamleader_2 = i
         end		
       end

       if self.teamleader_1 == nil then
        self.teamleader_1 = 0
      end
      if self.teamleader_2 == nil then
        self.teamleader_2 = 0
      end

      


      ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

      ListenToGameEvent( "game_rules_state_change", Dynamic_Wrap( COverthrowGameMode, 'OnGameRulesStateChange' ), self )
      ListenToGameEvent( "npc_spawned", Dynamic_Wrap( COverthrowGameMode, "OnNPCSpawned" ), self )
      ListenToGameEvent( "dota_team_kill_credit", Dynamic_Wrap( COverthrowGameMode, 'OnTeamKillCredit' ), self )
      ListenToGameEvent( "entity_killed", Dynamic_Wrap( COverthrowGameMode, 'OnEntityKilled' ), self )
      ListenToGameEvent( "dota_item_picked_up", Dynamic_Wrap( COverthrowGameMode, "OnItemPickUp"), self )
      ListenToGameEvent( "dota_npc_goal_reached", Dynamic_Wrap( COverthrowGameMode, "OnNpcGoalReached" ), self )
      ListenToGameEvent('dota_player_gained_level', Dynamic_Wrap(COverthrowGameMode, "OnPlayerLevelUp"), self)
      --ListenToGameEvent( "entity_hurt", Dynamic_Wrap( COverthrowGameMode, "OnDamageTaken" ), self )
      --ListenToGameEvent( "dota_player_pick_hero", Dynamic_Wrap( COverthrowGameMode, "OnHeroInGame" ), self )

      CustomGameEventManager:RegisterListener( "gamemode_vote", GameModeVote )
      CustomGameEventManager:RegisterListener( "feedelotogame", FeedEloToGameEvent )
      CustomGameEventManager:RegisterListener( "feedrewardstoluaserver", FeedRewardGameEvent )
      CustomGameEventManager:RegisterListener( "loadchardata", LoadCharReply )
      CustomGameEventManager:RegisterListener( "temple_difficulty_change", TempleDifficultyChange )
      CustomGameEventManager:RegisterListener( "selltempleitem", SellTempleItem )
      CustomGameEventManager:RegisterListener( "sellmythicweapon", SellMythicWeapon )
      CustomGameEventManager:RegisterListener( "equipmythicweapon", EquipDroppedMythicWeapon )
      CustomGameEventManager:RegisterListener( "getmychest", GetMyChest )
      CustomGameEventManager:RegisterListener( "talentpressed", TalentPressedButton )
      CustomGameEventManager:RegisterListener( "resetpathpressed", ToggleResetPathPointsPressed )
      CustomGameEventManager:RegisterListener( "resettempleherolevel", ToggleResetTempleHeroLevel )
      CustomGameEventManager:RegisterListener( "gamblingpressed", GamblingPressedButton )
      CustomGameEventManager:RegisterListener( "refreshtalents", RefreshTalents )
      CustomGameEventManager:RegisterListener( "artifactforging", ArtifactForgingPressedButton )
      CustomGameEventManager:RegisterListener( "removetempleheroability", RemoveTempleHeroAbility )
      CustomGameEventManager:RegisterListener( "request_droptable", EventRequestDropTable )
      CustomGameEventManager:RegisterListener( "tp_pressed", TempleTeleportFromMenu )
      CustomGameEventManager:RegisterListener( "save_pressed", SavePressed )
      CustomGameEventManager:RegisterListener( "moveitemtostash", MoveToStash )
      CustomGameEventManager:RegisterListener( "buynormalitem", BuyNormalItem )
      CustomGameEventManager:RegisterListener( "recover_artifact", RecoverLastReplacedArtifact )
      CustomGameEventManager:RegisterListener( "savecharsuccess", SaveCharSuccessNotification )
      CustomGameEventManager:RegisterListener( "setautosell", SetAutoSell )
      CustomGameEventManager:RegisterListener( "toggle_stash", Dynamic_Wrap( COverthrowGameMode, 'TryToggleStash' ) )
      CustomGameEventManager:RegisterListener( "togglepathword", TogglePathWord )
      CustomGameEventManager:RegisterListener( "temple_difficulty_mode_change", TempleDifficultyModeChange )
      CustomGameEventManager:RegisterListener( "playerconnected", Dynamic_Wrap( COverthrowGameMode, 'OnPlayerConnected' ) )
      CustomGameEventManager:RegisterListener( "getleaderboard", Dynamic_Wrap(COverthrowGameMode, 'SendLeaderboard'))
      
      --weapon choice
      CustomGameEventManager:RegisterListener( "weaponchoice", WeaponChoice )

      Convars:RegisterCommand( "overthrow_force_item_drop", function(...) self:ForceSpawnItem() end, "Force an item drop.", FCVAR_CHEAT )
      Convars:RegisterCommand( "overthrow_force_gold_drop", function(...) self:ForceSpawnGold() end, "Force gold drop.", FCVAR_CHEAT )
      Convars:RegisterCommand( "overthrow_set_timer", function(...) return SetTimer( ... ) end, "Set the timer.", FCVAR_CHEAT )
      Convars:RegisterCommand( "overthrow_force_end_game", function(...) return self:EndGame( DOTA_TEAM_GOODGUYS ) end, "Force the game to end.", FCVAR_CHEAT )
      

      GameRules:GetGameModeEntity():SetThink( "OnThink", self, 1 ) 

      -- Load leaderboard from server
      COverthrowGameMode:LoadLeaderboardFromServer()
      -- Spawning monsters
      spawncamps = {}
      for i = 1, self.numSpawnCamps do
        local campname = "camp"..i.."_path_customspawn"
        spawncamps[campname] =
        {
         NumberToSpawn = RandomInt(3,5),
         WaypointName = "camp"..i.."_path_wp1"
       }
     end

     --villager
     local unit = CreateUnitByName("act_1_villager", Entities:FindByName( nil, "villager" ):GetAbsOrigin(), true, nil, nil, DOTA_TEAM_GOODGUYS )
     unit:SetForwardVector(Vector(0,-1,0))
     COverthrowGameMode.treeoflife = Entities:FindByName( nil, "treeoflife")
   end

   function COverthrowGameMode:ShowCosmetics(target)
     local tab = {}
     if not target:IsRealHero() then
      return
    end

    tab.id = target:GetPlayerID()
    tab.unit = target
    FeedEloToGameEvent(1, tab)  --the elo reward cosmetics
    ShowSeasonRewards(target)  --the end of season rewards
  end

  function FeedRewardGameEvent(event, args)  --loaded end of season rewards from server arrive here
  --print("feed reward received, from js to lua")
  --print("event arrived " .. args['name'])
  --print("event arrived " .. args['rating'])
  if not IsServer() then
    return
  end

  if true then --we do it offline
    return
  end

  local data = args['playerids']
  local i = 0
  COverthrowGameMode.season2rewards = {}
  for word in string.gmatch(data, '([^,]+)') do
   --print(word)
   COverthrowGameMode.season2rewards[i] = word
   i = i + 1
 end

 --add cosmetic rewards for existing heroes

 local all = HeroList:GetAllHeroes()
 local hero
 for i=1, #all do
  hero = all[i]
  --print(hero:GetUnitName())
  if hero and COverthrowGameMode.season2rewards then
   local playerid = hero:GetPlayerID()
   --print("playerid " .. playerid)
   local steamid = PlayerResource:GetSteamAccountID(playerid)
   --print("steamid " .. steamid)
   --print(#COverthrowGameMode.season2rewards-1)
   for j=0, #COverthrowGameMode.season2rewards-1 do
    if COverthrowGameMode.season2rewards[j] and steamid > 0 then
     local id = tonumber(COverthrowGameMode.season2rewards[j])
     --print("id " .. id)
     --print("steamid " .. steamid)
     if steamid == id then
      --print("id match " .. id)
      hero.season2 = 0
      hero.season2_2vs2 = 0
      if COverthrowGameMode.season2rewards[j+1] and COverthrowGameMode.season2rewards[j+1] == "1" then
       --print("gladiator in 3v3 " .. id)
       hero.season2 = 1
       --print(hero:GetUnitName())
       ShowSeasonRewards(hero)
     end
     if COverthrowGameMode.season2rewards[j+2] and COverthrowGameMode.season2rewards[j+2] == "1" then
       --print("gladiator in 2v2 " .. id)
       hero.season2_2vs2 = 1
       --print(hero:GetUnitName())
       ShowSeasonRewards(hero)
     end
   end
 end
end
end
end
end

function COverthrowGameMode:OnPlayerConnected(params)
  local playerId = params["player_id"]

  -- Ignore every request until data synced
  if(COverthrowGameMode._ignoreReconnectRequestsFromPlayer and COverthrowGameMode._ignoreReconnectRequestsFromPlayer[playerId]) then
    return
  end

  -- Since some dota patch all client side requests silently fail if you send them too early...
  COverthrowGameMode._ignoreReconnectRequestsFromPlayer = COverthrowGameMode._ignoreReconnectRequestsFromPlayer or {}
  COverthrowGameMode._ignoreReconnectRequestsFromPlayer[playerId] = true

  local player = PlayerResource:GetPlayer(playerId)
  CustomGameEventManager:Send_ServerToPlayer(player, "playerconnectedresponse", { })

  -- Should be enough to consider high ping guys
  Timers:CreateTimer(5, function()
    -- Restore shop data for that client
    SendItemsToShop(player)
    -- Restore auto sell filters data for that client
    SendAutoSell(player)
    -- Restore talents data for that client
    SendAllTalentsToPlayer(player, playerId)
    -- Restory toggle stash button
    COverthrowGameMode:SendStashInfo(player)

    -- Allows next reconnect requests spam
    COverthrowGameMode._ignoreReconnectRequestsFromPlayer[playerId] = nil
  end)
end

function COverthrowGameMode:SendStashInfo(player)
  local hero = player:GetAssignedHero()

  if(hero == nil) then
    return
  end

  if hero.premium and hero.premium >= 6 then
    CustomGameEventManager:Send_ServerToPlayer(player, "toggle_stash_set_number", {nr = "Toggle Stash: [" .. hero.current_stash_id .. "/" .. hero.bought_stash_count .. "]"})
  else
    CustomGameEventManager:Send_ServerToPlayer(player, "toggle_stash_set_number", {nr = "Stash not unlocked"})
  end
end

function RemoveAllCosmetics( hero )
  local slot = 1
  --DeepPrintTable(hero.cosmetic_rewards)
  for slot=1, COverthrowGameMode.mythic_slots do
    if hero and hero.cosmetic_rewards and hero.cosmetic_rewards[slot] then
      UTIL_Remove(hero.cosmetic_rewards[slot])
      hero.cosmetic_rewards[slot] = nil
    end
  end
end

function AddCosmeticToHero( hero, cosmetic, slot )
  local entity = SpawnEntityFromTableSynchronous("prop_dynamic", { model = cosmetic } )
  if not hero.cosmetic_rewards then
    hero.cosmetic_rewards = {}
  end
  hero.cosmetic_rewards[slot] = entity
  entity:FollowEntity(hero, true)
end

function ArtifactCosmeticUnlocked(slot, quality, hero)
  local id = hero:GetPlayerID()
  local slotname = "Mainhand"
  if slot == 2 then
    slotname = "Offhand"
  end
  if slot == 3 then
    slotname = "Ring"
  end
  if slot == 4 then
    slotname = "Head"
  end
  if slot == 5 then
    slotname = "Chest"
  end
  if slot == 6 then
    slotname = "Boots"
  end
  local qualityname = "Legendary"
  if quality == 6 then
    qualityname = "Immortal"
  end
  if quality == 7 then
    qualityname = "Ancient Immortal"
  end
  if quality == 8 then
    qualityname = "Divine"
  end
  if not hero.cosmetics_unlocked then
    hero.cosmetics_unlocked = {}
  end
  if not hero.cosmetics_unlocked[slot] or hero.cosmetics_unlocked[slot] < quality then
    hero.cosmetics_unlocked[slot] = quality
    Notifications:Bottom(id, {text="Your Artifact in the "..slotname.." slot unlocked a cosmetic of "..qualityname.." quality.", duration=8, style={color="violet"}})
  end
end

function GetCosmeticRewardByHero( hero, slot, quality )
  local heroname = hero:GetUnitName()
  if quality <= 4 then --below quality 5, equip basic level 0 item
    quality = 0
  end
  if heroname == "npc_dota_hero_phantom_assassin" then
    if slot == 1 and quality and quality >= 7 then -- mainhand
      --hero.tier2prop = Attachments:AttachProp(hero, "attach_attack2", "models/items/abaddon/weapon_ravelord/weapon_ravelord.vmdl", 0.55)
      --return "models/heroes/phantom_assassin/pa_arcana_weapons.vmdl"
      return "models/items/phantom_assassin/creeping_shadow_weapon/creeping_shadow_weapon.vmdl"
    end
    if slot == 1 and quality and quality == 6 then -- mainhand
      return "models/items/phantom_assassin/raiments_of_the_shadow_slayer_set_weapon/raiments_of_the_shadow_slayer_set_weapon.vmdl"
    end
    if slot == 1 and quality and quality >= 5 then -- mainhand
      ArtifactCosmeticUnlocked(slot, 5, hero, true)
      return "models/items/phantom_assassin/evildoer/evildoer.vmdl"
    end
    if slot == 1 and quality and quality >= 0 then -- mainhand
      return "models/heroes/phantom_assassin/phantom_assassin_weapon.vmdl"
    end
    if slot == 2 and quality and quality >= 7 then -- offhand
      return "models/items/phantom_assassin/creeping_shadow_back/creeping_shadow_back.vmdl"
    end
    if slot == 2 and quality and quality == 6 then -- offhand
      ArtifactCosmeticUnlocked(slot, 6, hero, true)
      return "models/items/phantom_assassin/raiments_of_the_shadow_slayer_set_back/raiments_of_the_shadow_slayer_set_back.vmdl"
    end
    if slot == 3 and quality and quality >= 6 then -- ring
      ArtifactCosmeticUnlocked(slot, 6, hero, true)
      --return "models/items/phantom_assassin/creeping_shadow_head/creeping_shadow_head.vmdl"
    end
    if slot == 4 and quality and quality >= 7 then -- head
      return "models/items/phantom_assassin/creeping_shadow_head/creeping_shadow_head.vmdl"
    end
    if slot == 4 and quality and quality >= 6 then -- head
      return "models/items/phantom_assassin/raiments_of_the_shadow_slayer_set_head/raiments_of_the_shadow_slayer_set_head.vmdl"
    end
    if slot == 4 and quality and quality >= 0 then -- head
      return "models/heroes/phantom_assassin/phantom_assassin_helmet.vmdl"
    end
    if slot == 5 and quality and quality >= 7 then -- chest
      return "models/items/phantom_assassin/creeping_shadow_shoulder/creeping_shadow_shoulder.vmdl"
    end
    if slot == 5 and quality and quality == 6 then -- chest
      return "models/items/phantom_assassin/raiments_of_the_shadow_slayer_set_shoulder/raiments_of_the_shadow_slayer_set_shoulder.vmdl"
    end
    if slot == 6 and quality and quality >= 7 then -- boots
      return "models/items/phantom_assassin/creeping_shadow_belt/creeping_shadow_belt.vmdl"
    end
    if slot == 6 and quality and quality == 6 then -- boots
      return "models/items/phantom_assassin/raiments_of_the_shadow_slayer_set_belt/raiments_of_the_shadow_slayer_set_belt.vmdl"
    end
    if slot == 6 and quality and quality >= 0 then -- boots
      return "models/heroes/phantom_assassin/phantom_assassin_cape.vmdl"
    end
  end
  if heroname == "npc_dota_hero_oracle" then
    if slot == 2 and quality and quality >= 6 then -- mainhand
      ArtifactCosmeticUnlocked(slot, 6, hero, true)
      --return "models/items/phantom_assassin/evildoer/evildoer.vmdl"
    end
  end
  if heroname == "npc_dota_hero_drow_ranger" then
    --gauntlets missing
    if slot == 1 and quality and quality >= 6 then -- mainhand
      hero.tier1prop = Attachments:AttachProp(hero, "bow_mid", "models/items/drow/dotapit_s3_frostfang_bow/dotapit_s3_frostfang_bow.vmdl", 1.75)
      ArtifactCosmeticUnlocked(slot, 6, hero)
      return "models/items/drow/longbow_of_the_boreal_watch/longbow_of_the_boreal_watch.vmdl"
    end
    if slot == 1 and quality and quality == 6 then -- mainhand
      return "models/items/drow/longbow_of_the_boreal_watch/longbow_of_the_boreal_watch.vmdl"
    end
    if slot == 1 and quality and quality == 5 then -- mainhand
      return "models/items/drow/iceburst_bow.vmdl"
    end
    if slot == 1 and quality and quality >= 0 then -- mainhand
      return "models/heroes/drow/drow_weapon.vmdl"
    end
    if slot == 2 and quality and quality >= 7 then -- offhand
      return "models/items/drow/anuxi_wurm_quiver/anuxi_wurm_quiver.vmdl"
    end
    if slot == 2 and quality and quality == 6 then -- offhand
      return "models/items/drow/quiver_of_the_boreal_watch/quiver_of_the_boreal_watch.vmdl"
    end
    if slot == 3 and quality and quality >= 7 then -- ring
      return "models/items/drow/anuxi_wurm_cape/anuxi_wurm_cape.vmdl"
    end
    if slot == 3 and quality and quality == 6 then -- ring
      return "models/items/drow/cloak_of_the_boreal_watch/cloak_of_the_boreal_watch.vmdl"
    end
    if slot == 3 and quality and quality >= 0 then -- ring
      return "models/heroes/drow/drow_cape.vmdl"
    end
    if slot == 4 and quality and quality >= 7 then -- head
      return "models/items/drow/anuxi_wurm_head/anuxi_wurm_head.vmdl"
    end
    if slot == 4 and quality and quality == 6 then -- head
      return "models/items/drow/cowl_of_the_boreal_watch/cowl_of_the_boreal_watch.vmdl"
    end
    if slot == 4 and quality and quality >= 0 then -- head
      return "models/heroes/drow/drow_haircowl.vmdl"
    end
    if slot == 5 and quality and quality >= 7 then -- chest
      return "models/items/drow/anuxi_wurm_mantle/anuxi_wurm_mantle.vmdl"
    end
    if slot == 5 and quality and quality == 6 then -- chest
      return "models/items/drow/pauldrons_of_the_boreal_watch/pauldrons_of_the_boreal_watch.vmdl"
    end
    if slot == 6 and quality and quality >= 7 then -- boots
      return "models/items/drow/anuxi_wurm_booties/anuxi_wurm_booties.vmdl"
    end
    if slot == 6 and quality and quality == 6 then -- boots
      return "models/items/drow/legplates_of_the_boreal_watch/legplates_of_the_boreal_watch.vmdl"
    end
  end
  if heroname == "npc_dota_hero_axe" then
    --gauntlets missing
    if slot == 1 and quality and quality >= 7 then -- mainhand
      --hero.tier3prop = Attachments:AttachProp(hero, "attach_weapon", "models/items/faceless_void/battlefury/battlefury.vmdl", nil)
    end
    if slot == 1 and quality and quality >= 6 then -- mainhand
      ArtifactCosmeticUnlocked(slot, 6, hero)
      return "models/items/axe/oglodi_big_boss_weapon/oglodi_big_boss_weapon.vmdl"
    end
    if slot == 1 and quality and quality == 5 then -- mainhand
      return "models/items/axe/redstone_axe/redstone_axe.vmdl"
    end
    if slot == 1 and quality and quality >= 0 then -- mainhand
      return "models/heroes/axe/axe_weapon.vmdl"
    end
    if slot == 2 and quality and quality >= 7 then -- offhand
      ArtifactCosmeticUnlocked(slot, 7, hero)
      return "models/items/axe/armor_of_the_wrought_legion_misc/armor_of_the_wrought_legion_misc.vmdl"
    end
    if slot == 2 and quality and quality == 6 then -- offhand
      return "models/items/axe/oglodi_big_boss_misc/oglodi_big_boss_misc.vmdl"
    end
    if slot == 4 and quality and quality >= 7 then -- head
      return "models/items/axe/armor_of_the_wrought_legion_head/armor_of_the_wrought_legion_head.vmdl"
    end
    if slot == 4 and quality and quality == 6 then -- head
      return "models/items/axe/oglodi_big_boss_head/oglodi_big_boss_head.vmdl"
    end
    if slot == 4 and quality and quality >= 0 then -- head
      --return "models/heroes/drow/drow_haircowl.vmdl"
    end
    if slot == 5 and quality and quality >= 7 then -- chest
      return "models/items/axe/armor_of_the_wrought_legion_armor/armor_of_the_wrought_legion_armor.vmdl"
    end
    if slot == 5 and quality and quality == 6 then -- chest
      return "models/items/axe/armor_of_the_wrought_legion_armor/armor_of_the_wrought_legion_armor.vmdl"
    end
    if slot == 6 and quality and quality >= 7 then -- boots
      return "models/items/axe/armor_of_the_wrought_legion_belt/armor_of_the_wrought_legion_belt.vmdl"
    end 
    if slot == 6 and quality and quality == 6 then -- boots
      return "models/items/axe/oglodi_big_boss_belt/oglodi_big_boss_belt.vmdl"
    end
  end
  if heroname == "npc_dota_hero_legion_commander" then
    --gauntlets missing
    if slot == 1 and quality and quality >= 7 then -- mainhand
      --hero.tier3prop = Attachments:AttachProp(hero, "attach_attack1", "models/items/omniknight/clergy_war_hammer/clergy_war_hammer.vmdl", 1.4)
    end
    if slot == 1 and quality and quality == 6 then -- mainhand
      return "models/items/legion_commander/the_armors_of_zhuzhou_weapon/the_armors_of_zhuzhou_weapon.vmdl"
    end
    if slot == 1 and quality and quality == 5 then -- mainhand
      return "models/items/legion_commander/vanguardfireblade_weapon/vanguardfireblade_weapon.vmdl"
    end
    if slot == 1 and quality and quality >= 0 then -- mainhand
      return "models/heroes/legion_commander/legion_commander_weapon.vmdl"
    end
    if slot == 2 and quality and quality >= 6 then -- offhand
      hero.tier1prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/skywrath_mage/guiding_lights_back/guiding_lights_back.vmdl", nil)
      ArtifactCosmeticUnlocked(slot, 6, hero)
    end
    if slot == 2 and quality and quality == 6 then -- offhand
      return "models/items/legion_commander/the_armors_of_zhuzhou_back/the_armors_of_zhuzhou_back.vmdl"
    end
    if slot == 3 and quality and quality >= 7 then -- ring
      return "models/items/legion_commander/equine_glove/equine_glove.vmdl"
    end
    if slot == 3 and quality and quality == 6 then -- ring
      return "models/items/legion_commander/the_armors_of_zhuzhou_arms/the_armors_of_zhuzhou_arms.vmdl"
    end
    if slot == 4 and quality and quality >= 5 then -- head
      hero.tier2prop = Attachments:AttachProp(hero, "attach_eyeL", "models/items/skywrath_mage/dotapit_s3_avillivas_countenance/dotapit_s3_avillivas_countenance.vmdl", nil)
      ArtifactCosmeticUnlocked(slot, 5, hero)
    end
    if slot == 4 and quality and quality == 6 then -- head
      return "models/items/legion_commander/the_armors_of_zhuzhou_head/the_armors_of_zhuzhou_head.vmdl"
    end
    if slot == 4 and quality and quality >= 0 then -- head
      return "models/heroes/legion_commander/legion_commander_head.vmdl"
    end
    if slot == 5 and quality and quality >= 6 then -- chest
      hero.tier4prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/sven/glittering_hawk_shoulder/glittering_hawk_shoulder.vmdl", nil)
      ArtifactCosmeticUnlocked(slot, 6, hero)
    end
    if slot == 5 and quality and quality == 6 then -- chest
      return "models/items/legion_commander/the_armors_of_zhuzhou_shoulder/the_armors_of_zhuzhou_shoulder.vmdl"
    end
  end
  if heroname == "npc_dota_hero_windrunner" then
    --gauntlets missing
    if slot == 1 and quality and quality >= 6 then -- mainhand
      hero.tier3prop = Attachments:AttachProp(hero, "attach_attack1", "models/items/medusa/emerald_ocean_weapon/emerald_ocean_weapon.vmdl", 1.2)
      ArtifactCosmeticUnlocked(slot, 6, hero)
      --return "models/items/windrunner/ti6_falcon_bow/ti6_falcon_bow_model.vmdl"
    end
    if slot == 1 and quality and quality == 6 then -- mainhand
      return "models/items/windrunner/ti6_windranger_weapon/ti6_windranger_weapon.vmdl"
    end
    if slot == 1 and quality and quality == 5 then -- mainhand
      return "models/items/windrunner/rainmaker_bow/rainmaker_bow.vmdl"
    end
    if slot == 1 and quality and quality >= 0 then -- mainhand
      return "models/heroes/windrunner/windrunner_bow.vmdl"
    end
    if slot == 2 and quality and quality >= 7 then -- offhand
      ArtifactCosmeticUnlocked(slot, 7, hero)
      return "models/items/windrunner/orchid_flowersong_offhand/orchid_flowersong_offhand.vmdl"
    end
    if slot == 2 and quality and quality == 6 then -- offhand
      return "models/items/windrunner/ti6_windranger_offhand/ti6_windranger_offhand.vmdl"
    end
    if slot == 4 and quality and quality >= 7 then -- head
      return "models/items/windrunner/falconhelm1/falconhelm1.vmdl"
    end
    if slot == 4 and quality and quality == 6 then -- head
      return "models/items/windrunner/ti6_windranger_head/ti6_windranger_head.vmdl"
    end
    if slot == 4 and quality and quality >= 0 then -- head
      return "models/heroes/windrunner/windrunner_head.vmdl"
    end
    if slot == 5 and quality and quality >= 7 then -- chest
      return "models/items/windrunner/shoulderpadfalcon/shoulderpadfalcon.vmdl"
    end
    if slot == 5 and quality and quality == 6 then -- chest
      return "models/items/windrunner/ti6_windranger_shoulder/ti6_windranger_shoulder.vmdl"
    end
    if slot == 6 and quality and quality >= 7 then -- boots
      return "models/items/windrunner/falconcloak/falconcloak.vmdl"
    end
    if slot == 6 and quality and quality == 6 then -- boots
      return "models/items/windrunner/ti6_windranger_back/ti6_windranger_back.vmdl"
    end
    if slot == 6 and quality and quality >= 0 then -- boots
      return "models/heroes/windrunner/windrunner_cape.vmdl"
    end
  end
  if heroname == "npc_dota_hero_sniper" then
    if slot == 1 and quality and quality >= 6 then -- mainhand
      hero.tier3prop = Attachments:AttachProp(hero, "attach_attack1", "models/items/sniper/dragons_breath/dragons_breath.vmdl", nil)
      ArtifactCosmeticUnlocked(slot, 6, hero)
    end
    if slot == 1 and quality and quality == 6 then -- mainhand
      return "models/items/sniper/wolf_gun_dark/wolf_gun_dark.vmdl"
    end
    if slot == 1 and quality and quality == 5 then -- mainhand
      return "models/items/sniper/killstealer/killstealer.vmdl"
    end
    if slot == 1 and quality and quality >= 0 then -- mainhand
      return "models/heroes/sniper/weapon.vmdl"
    end
    if slot == 2 and quality and quality >= 7 then -- offhand
      return "models/items/sniper/the_marksman_arms/the_marksman_arms.vmdl"
    end
    if slot == 2 and quality and quality == 6 then -- offhand
      return "models/items/sniper/wolf_arms_dark/wolf_arms_dark.vmdl"
    end
    if slot == 4 and quality and quality >= 5 then -- head
      hero.tier1prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/dragon_knight/oblivion_blazer_head/oblivion_blazer_head.vmdl", nil)
      ArtifactCosmeticUnlocked(slot, 5, hero)
    end
    if slot == 4 and quality and quality == 6 then -- head
      return "models/items/sniper/wolf_hat_dark/wolf_hat_dark.vmdl"
    end
    if slot == 4 and quality and quality >= 0 then -- head
      return "models/heroes/sniper/headitem.vmdl"
    end
    if slot == 5 and quality and quality >= 6 then -- chest
      hero.tier2prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/dragon_knight/armor_of_the_drake/armor_of_the_drake.vmdl", nil)
      ArtifactCosmeticUnlocked(slot, 6, hero)
    end
    if slot == 5 and quality and quality == 6 then -- chest
      return "models/items/sniper/wolf_shoulder_dark/wolf_shoulder_dark.vmdl"
    end
    if slot == 6 and quality and quality >= 7 then -- boots
      return "models/items/sniper/the_marksman_back/the_marksman_back.vmdl"
    end
    if slot == 6 and quality and quality == 6 then -- boots
      return "models/items/sniper/wolf_cape_dark/wolf_cape_dark.vmdl"
    end
    if slot == 6 and quality and quality >= 0 then -- boots
      return "models/heroes/sniper/cape.vmdl"
    end
  end
  if heroname == "npc_dota_hero_chen" then
    if slot == 1 and quality and quality >= 7 then -- mainhand
      return "models/items/chen/chen_eye_of_power_weapon/chen_eye_of_power_weapon.vmdl"
    end
    if slot == 1 and quality and quality == 6 then -- mainhand
      return "models/items/chen/weapon_desert/weapon_desert.vmdl"
    end
    if slot == 1 and quality and quality == 6 then -- mainhand
      return "models/items/chen/squareskystaff_weapon/squareskystaff_weapon.vmdl"
    end
    if slot == 1 and quality and quality >= 0 then -- mainhand
      return "models/heroes/chen/weapon.vmdl"
    end
    if slot == 2 and quality and quality >= 7 then -- offhand
      return "models/items/chen/chen_eye_of_power_arms/chen_eye_of_power_arms.vmdl"
    end
    if slot == 2 and quality and quality == 6 then -- offhand
      return "models/items/chen/arms_desert/arms_desert.vmdl"
    end
    if slot == 3 and quality and quality >= 7 then -- ring
      return "models/items/chen/chen_eye_of_power_misc/chen_eye_of_power_misc.vmdl"
    end
    if slot == 3 and quality and quality == 6 then -- ring
      return "models/items/chen/neck_desert/neck_desert.vmdl"
    end
    if slot == 4 and quality and quality >= 6 then -- head
      hero.tier1prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/dragon_knight/oblivion_blazer_head/oblivion_blazer_head.vmdl", nil)
      ArtifactCosmeticUnlocked(slot, 6, hero)
    end
    if slot == 4 and quality and quality == 6 then -- head
      return "models/items/chen/head_desert/head_desert.vmdl"
    end
    if slot == 4 and quality and quality >= 0 then -- head
      return "models/heroes/chen/helmet.vmdl"
    end
    if slot == 5 and quality and quality >= 7 then -- chest
      return "models/items/chen/chen_eye_of_power_shoulder/chen_eye_of_power_shoulder.vmdl"
    end
    if slot == 5 and quality and quality == 6 then -- chest
      return "models/items/chen/shoulder_desert/shoulder_desert.vmdl"
    end
    if slot == 6 and quality and quality >= 7 then -- boots
      return "models/items/chen/chen_eye_of_power_mount/chen_eye_of_power_mount.vmdl"
    end
    if slot == 6 and quality and quality == 6 then -- boots
      return "models/items/chen/mount_desert_new/mount_desert_new.vmdl"
    end
    if slot == 6 and quality and quality >= 0 then -- boots
      return "models/heroes/chen/mount.vmdl"
    end
  end
  if heroname == "npc_dota_hero_phantom_lancer" then
    if slot == 1 and quality and quality >= 7 then -- mainhand
      return "models/items/phantom_lancer/ancient_gods_lance/ancient_gods_lance.vmdl"
    end
    if slot == 1 and quality and quality == 6 then -- mainhand
      return "models/items/phantom_lancer/infinite_waves_serpent_weapon/infinite_waves_serpent_weapon.vmdl"
    end
    if slot == 1 and quality and quality == 5 then -- mainhand
      return "models/items/phantom_lancer/weapon_kinship/weapon_kinship.vmdl"
    end
    if slot == 1 and quality and quality >= 0 then -- mainhand
      return "models/heroes/phantom_lancer/phantom_lancer_weapon.vmdl"
    end
    if slot == 2 and quality and quality >= 7 then -- offhand
      return "models/items/phantom_lancer/ancient_gods_arms/ancient_gods_arms.vmdl"
    end
    if slot == 2 and quality and quality == 6 then -- offhand
      return "models/items/phantom_lancer/infinite_waves_arms/infinite_waves_arms.vmdl"
    end
    if slot == 3 and quality and quality >= 7 then -- ring
      --return "models/items/chen/chen_eye_of_power_misc/chen_eye_of_power_misc.vmdl"
    end
    if slot == 3 and quality and quality == 6 then -- ring
      --return "models/items/chen/neck_desert/neck_desert.vmdl"
    end
    if slot == 4 and quality and quality >= 7 then -- head
      --hero.tier1prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/dragon_knight/oblivion_blazer_head/oblivion_blazer_head.vmdl", nil)
    end
    if slot == 4 and quality and quality == 6 then -- head
     -- return "models/items/chen/head_desert/head_desert.vmdl"
   end
   if slot == 4 and quality and quality >= 0 then -- head
    return "models/heroes/phantom_lancer/phantom_lancer_head.vmdl"
  end
  if slot == 5 and quality and quality >= 7 then -- chest
    return "models/items/phantom_lancer/ancient_gods_shoulder/ancient_gods_shoulder.vmdl"
  end
  if slot == 5 and quality and quality == 6 then -- chest
    return "models/items/phantom_lancer/infinite_waves_shoulder/infinite_waves_shoulder.vmdl"
  end
  if slot == 6 and quality and quality >= 7 then -- boots
    return "models/items/phantom_lancer/ancient_gods_belt/ancient_gods_belt.vmdl"
  end
  if slot == 6 and quality and quality == 6 then -- boots
    return "models/items/phantom_lancer/infinite_waves_belt/infinite_waves_belt.vmdl"
  end
  if slot == 6 and quality and quality >= 0 then -- boots
    return "models/heroes/phantom_lancer/phantom_lancer_belt.vmdl"
  end
end
if heroname == "npc_dota_hero_dazzle" then
  if slot == 1 and quality and quality >= 7 then -- mainhand
    return "models/items/dazzle/darkclaw_acolyte_weapon/darkclaw_acolyte_weapon.vmdl"
  end
  if slot == 1 and quality and quality == 6 then -- mainhand
    return "models/items/dazzle/shadowflame_weapon/shadowflame_weapon.vmdl"
  end
  if slot == 1 and quality and quality == 5 then -- mainhand
    return "models/items/dazzle/dazzle_final_graveheart/dazzle_final_graveheart.vmdl"
  end
  if slot == 1 and quality and quality >= 0 then -- mainhand
    return "models/heroes/dazzle/dazzle_staff.vmdl"
  end
  if slot == 2 and quality and quality >= 7 then -- offhand
    hero.artifact_offhand = 7
    ArtifactCosmeticUnlocked(slot, 7, hero)
  end
  if slot == 2 and quality and quality == 5 then -- offhand
    hero.artifact_offhand = 6
    ArtifactCosmeticUnlocked(slot, 5, hero)
  end
  if slot == 3 and quality and quality >= 7 then -- ring
    return "models/items/dazzle/darkclaw_acolyte_arms/darkclaw_acolyte_arms.vmdl"
  end
  if slot == 3 and quality and quality >= 6 then -- ring
    ArtifactCosmeticUnlocked(slot, 6, hero, true)
    return "models/items/dazzle/shadowflame_arms/shadowflame_arms.vmdl"
  end
  if slot == 4 and quality and quality >= 7 then -- head
    return "models/items/dazzle/darkclaw_acolyte_back/darkclaw_acolyte_back.vmdl"
  end
  if slot == 4 and quality and quality == 6 then -- head
   return "models/items/dazzle/shadowflame_back_s1/shadowflame_back_s1.vmdl"
 end
 if slot == 4 and quality and quality >= 0 then -- head
  return "models/heroes/dazzle/dazzle_mohawk.vmdl"
end
if slot == 5 and quality and quality >= 7 then -- chest
  return "models/items/dazzle/darkclaw_acolyte_misc/darkclaw_acolyte_misc.vmdl"
end
if slot == 5 and quality and quality == 6 then -- chest
  return "models/items/dazzle/shadowflame_misc/shadowflame_misc.vmdl"
end
if slot == 5 and quality and quality >= 0 then -- chest
  return "models/heroes/dazzle/dazzle_shoulder.vmdl"
end
if slot == 6 and quality and quality >= 7 then -- boots
  return "models/items/dazzle/darkclaw_acolyte_legs/darkclaw_acolyte_legs.vmdl"
end
if slot == 6 and quality and quality == 6 then -- boots
  return "models/items/dazzle/shadowflame_legs/shadowflame_legs.vmdl"
end
if slot == 6 and quality and quality >= 0 then -- boots
  return "models/heroes/dazzle/dazzle_dress.vmdl"
end
end
if heroname == "npc_dota_hero_antimage" then
  if slot == 1 and quality and quality >= 7 then -- mainhand
    return "models/items/antimage/skullbasher/skullbasher_gold.vmdl"
  end
  if slot == 1 and quality and quality == 6 then -- mainhand
    return "models/items/antimage/god_eater_weapon/god_eater_weapon.vmdl"
  end
  if slot == 1 and quality and quality == 5 then -- mainhand
    return "models/items/antimage/antimage_slasher_weapon.vmdl"
  end
  if slot == 1 and quality and quality >= 0 then -- mainhand
    return "models/heroes/antimage/antimage_weapon.vmdl"
  end
  if slot == 2 and quality and quality >= 7 then -- offhand
    return "models/items/antimage/skullbasher/skullbasher_gold_offhand.vmdl"
  end
  if slot == 2 and quality and quality == 6 then -- offhand
    return "models/items/antimage/god_eater_off_hand/god_eater_off_hand.vmdl"
  end
  if slot == 2 and quality and quality == 5 then -- offhand
    return "models/items/antimage/antimage_slasher_offhand_weapon.vmdl"
  end
  if slot == 2 and quality and quality >= 0 then -- offhand
    return "models/heroes/antimage/antimage_offhand_weapon.vmdl"
  end
  if slot == 3 and quality and quality >= 7 then -- ring
    return "models/items/antimage/tarrasque_scale_arms/tarrasque_scale_arms.vmdl"
  end
  if slot == 3 and quality and quality == 6 then -- ring
    return "models/items/antimage/god_eater_shoulder/god_eater_shoulder.vmdl"
  end
  if slot == 4 and quality and quality >= 6 then -- head
    hero.cosmetic_reward_head = 7
    ArtifactCosmeticUnlocked(slot, 6, hero)
    return "models/items/antimage/tarrasque_scale_head/tarrasque_scale_head.vmdl"
  end
  if slot == 4 and quality and quality == 6 then -- head
   return "models/items/antimage/god_eater_head/god_eater_head.vmdl"
 end
 if slot == 4 and quality and quality >= 0 then -- head
  return "models/heroes/antimage/antimage_head.vmdl"
end
if slot == 5 and quality and quality >= 7 then -- chest
  return "models/items/antimage/tarrasque_scale_armor/tarrasque_scale_armor.vmdl"
end
if slot == 5 and quality and quality == 6 then -- chest
  return "models/items/antimage/god_eater_armor/god_eater_armor.vmdl"
end
if slot == 6 and quality and quality >= 7 then -- boots
  return "models/items/antimage/tarrasque_scale_belt/tarrasque_scale_belt.vmdl"
end
if slot == 6 and quality and quality == 6 then -- boots
  return "models/items/antimage/god_eater_belt/god_eater_belt.vmdl"
end
if slot == 6 and quality and quality >= 0 then -- boots
  --return "models/heroes/phantom_lancer/phantom_lancer_belt.vmdl"
end
end
if heroname == "npc_dota_hero_furion" then
  if slot == 1 and quality and quality >= 7 then -- mainhand
    return "models/items/furion/scythe_of_ice/scythe_of_ice.vmdl"
  end
  if slot == 1 and quality and quality == 6 then -- mainhand
    return "models/items/furion/flowerstaff.vmdl"
  end
  if slot == 1 and quality and quality >= 0 then -- mainhand
    return "models/heroes/furion/furion_staff.vmdl"
  end
  if slot == 2 and quality and quality >= 7 then -- offhand
    return "models/items/furion/the_ancient_guardian_neck/the_ancient_guardian_neck.vmdl"
  end
  if slot == 2 and quality and quality == 6 then -- offhand
    return "models/items/furion/primeval_neck/primeval_neck.vmdl"
  end
  if slot == 2 and quality and quality >= 0 then -- offhand
    return "models/heroes/furion/furion_beard.vmdl"
  end
  if slot == 3 and quality and quality >= 7 then -- ring
    return "models/items/furion/the_ancient_guardian_arms/the_ancient_guardian_arms.vmdl"
  end
  if slot == 3 and quality and quality == 6 then -- ring
    return "models/items/furion/primeval_arms/primeval_arms.vmdl"
  end
  if slot == 4 and quality and quality >= 7 then -- head
   return "models/items/furion/the_ancient_guardian_head/the_ancient_guardian_head.vmdl"
 end
 if slot == 4 and quality and quality == 6 then -- head
   return "models/items/furion/primeval_head/primeval_head.vmdl"
 end
 if slot == 4 and quality and quality >= 0 then -- head
  return "models/heroes/furion/furion_horns.vmdl"
end
if slot == 5 and quality and quality >= 7 then -- chest
  return "models/items/furion/the_ancient_guardian_shoulder/the_ancient_guardian_shoulder.vmdl"
end
if slot == 5 and quality and quality == 6 then -- chest
  return "models/items/furion/primeval_shoulder/primeval_shoulder.vmdl"
end
if slot == 6 and quality and quality >= 7 then -- boots
  return "models/items/furion/the_ancient_guardian_back/the_ancient_guardian_back.vmdl"
end
if slot == 6 and quality and quality == 6 then -- boots
  return "models/items/furion/primeval_back/primeval_back.vmdl"
end
if slot == 6 and quality and quality >= 0 then -- boots
  --return "models/heroes/phantom_lancer/phantom_lancer_belt.vmdl"
end
end
if heroname == "npc_dota_hero_invoker" then
  if slot == 1 and quality and quality >= 7 then -- mainhand
    return "models/items/invoker/dark_artistry/dark_artistry_bracer_model.vmdl"
  end
  if slot == 1 and quality and quality == 6 then -- mainhand
    return "models/items/invoker/sinisterlightning_arms/sinisterlightning_arms.vmdl"
  end
  if slot == 1 and quality and quality >= 0 then -- mainhand
    --return "models/heroes/furion/furion_staff.vmdl"
  end
  if slot == 2 and quality and quality >= 7 then -- offhand
    ArtifactCosmeticUnlocked(slot, 7, hero)
    return "models/items/invoker/dark_artistry/dark_artistry_cape_model.vmdl"
  end
  if slot == 2 and quality and quality == 6 then -- offhand
    return "models/items/invoker/sinisterlightning_back/sinisterlightning_back.vmdl"
  end
  if slot == 3 and quality and quality >= 7 then -- ring
    --return "models/items/invoker/dark_artistry/dark_artistry_belt_model.vmdl"
  end
  if slot == 3 and quality and quality == 6 then -- ring
    --return "models/items/furion/primeval_arms/primeval_arms.vmdl"
  end
  if slot == 3 and quality and quality >= 0 then -- ring
    return "models/heroes/invoker/invoker_head.vmdl"
  end
  if slot == 4 and quality and quality >= 7 then -- head
   return "models/items/invoker/dark_artistry/dark_artistry_hair_model.vmdl"
 end
 if slot == 4 and quality and quality == 6 then -- head
   return "models/items/invoker/sinisterlightning_head/sinisterlightning_head.vmdl"
 end
 if slot == 4 and quality and quality >= 0 then -- head
  return "models/heroes/invoker/invoker_hair.vmdl"
end
if slot == 5 and quality and quality >= 7 then -- chest
  return "models/items/invoker/dark_artistry/dark_artistry_shoulder_model.vmdl"
end
if slot == 5 and quality and quality == 6 then -- chest
  return "models/items/invoker/sinisterlightning_shoulder/sinisterlightning_shoulder.vmdl"
end
if slot == 6 and quality and quality >= 7 then -- boots
  return "models/items/invoker/dark_artistry/dark_artistry_belt_model.vmdl"
end
if slot == 6 and quality and quality == 6 then -- boots
  return "models/items/invoker/cadenza_belt/cadenza_belt.vmdl"
end
if slot == 6 and quality and quality >= 0 then -- boots
  --return "models/heroes/phantom_lancer/phantom_lancer_belt.vmdl"
end
end
if heroname == "npc_dota_hero_silencer" then
  if slot == 1 and quality and quality >= 7 then -- mainhand
    return "models/items/silencer/the_hazhadal_magebreaker_weapon/the_hazhadal_magebreaker_weapon.vmdl"
  end
  if slot == 1 and quality and quality == 6 then -- mainhand
    return "models/items/silencer/fanpiercingsilence/fanpiercingsilence.vmdl"
  end
  if slot == 1 and quality and quality >= 0 then -- mainhand
    return "models/heroes/silencer/silencer_weapon.vmdl"
  end
  if slot == 2 and quality and quality >= 7 then -- offhand
    return "models/items/silencer/the_hazhadal_magebreaker_off_hand/the_hazhadal_magebreaker_off_hand.vmdl"
  end
  if slot == 2 and quality and quality == 6 then -- offhand
    return "models/items/silencer/bts_final_utterance_offhand/bts_final_utterance_offhand.vmdl"
  end
  if slot == 3 and quality and quality >= 7 then -- ring
    return "models/items/silencer/the_hazhadal_magebreaker_arms/the_hazhadal_magebreaker_arms.vmdl"
  end
  if slot == 3 and quality and quality == 6 then -- ring
    return "models/items/silencer/bts_final_utterance_arms/bts_final_utterance_arms.vmdl"
  end
  if slot == 3 and quality and quality >= 0 then -- ring
    --return "models/heroes/invoker/invoker_head.vmdl"
  end
  if slot == 4 and quality and quality >= 7 then -- head
   return "models/items/silencer/ti6_helmet/mesh/ti6_helmet.vmdl"
 end
 if slot == 4 and quality and quality == 6 then -- head
   return "models/items/silencer/bts_final_utterance_head/bts_final_utterance_head.vmdl"
 end
 if slot == 4 and quality and quality >= 0 then -- head
  return "models/heroes/silencer/silencer_helmet.vmdl"
end
if slot == 5 and quality and quality >= 7 then -- chest
  return "models/items/silencer/the_hazhadal_magebreaker_shoulder/the_hazhadal_magebreaker_shoulder.vmdl"
end
if slot == 5 and quality and quality == 6 then -- chest
  return "models/items/silencer/bts_final_utterance_shoulder/bts_final_utterance_shoulder.vmdl"
end
if slot == 6 and quality and quality >= 7 then -- boots
  return "models/items/silencer/the_hazhadal_magebreaker_belt/the_hazhadal_magebreaker_belt.vmdl"
end
if slot == 6 and quality and quality == 6 then -- boots
  return "models/items/silencer/bts_final_utterance_belt/bts_final_utterance_belt.vmdl"
end
if slot == 6 and quality and quality >= 0 then -- boots
  return "models/heroes/silencer/silencer_robe.vmdl"
end
end
if heroname == "npc_dota_hero_pudge" then
  if slot == 1 and quality and quality == 6 then -- mainhand
    return "models/items/pudge/ftp_dendi_weapon/ftp_dendi_weapon.vmdl"
  end
  if slot == 1 and quality and quality >= 6 then -- mainhand
    hero.cosmeti_pudge_pet = 7
    ArtifactCosmeticUnlocked(slot, 6, hero)
    return "models/items/pudge/the_devarque_fugitive_weapon/the_devarque_fugitive_weapon.vmdl"
  end
  if slot == 1 and quality and quality >= 0 then -- mainhand
    return "models/heroes/pudge/weapon.vmdl"
  end
  if slot == 2 and quality and quality == 6 then -- offhand
    return "models/items/pudge/ftp_dendi_shoulder/ftp_dendi_shoulder.vmdl"
  end
  if slot == 2 and quality and quality >= 7 then -- offhand
    return "models/items/pudge/the_devarque_fugitive_shoulder/the_devarque_fugitive_shoulder.vmdl"
  end
  if slot == 2 and quality and quality == 0 then -- offhand
    return "models/heroes/pudge/leftarm.vmdl"
  end
  if slot == 3 and quality and quality == 6 then -- ring
    return "models/items/pudge/ftp_dendi_offhand/ftp_dendi_offhand.vmdl"
  end
  if slot == 3 and quality and quality >= 7 then -- ring
    return "models/items/pudge/the_devarque_fugitive_off_hand/the_devarque_fugitive_off_hand.vmdl"
  end
  if slot == 3 and quality and quality >= 0 then -- ring
    --return "models/heroes/invoker/invoker_head.vmdl"
  end
  if slot == 4 and quality and quality == 6 then -- head
   return "models/items/pudge/ftp_dendi_head/ftp_dendi_head.vmdl"
 end
 if slot == 4 and quality and quality >= 7 then -- head
   return "models/items/pudge/the_devarque_fugitive_head/the_devarque_fugitive_head.vmdl"
 end
 if slot == 4 and quality and quality >= 0 then -- head
  --return "models/heroes/silencer/silencer_helmet.vmdl"
end
if slot == 5 and quality and quality == 6 then -- chest
  return "models/items/pudge/ftp_dendi_arm/ftp_dendi_arm.vmdl"
end
if slot == 5 and quality and quality >= 7 then -- chest
  return "models/items/pudge/the_devarque_fugitive_arms/the_devarque_fugitive_arms.vmdl"
end
if slot == 6 and quality and quality == 6 then -- boots
  return "models/items/pudge/ftp_dendi_back/ftp_dendi_back.vmdl"
end
if slot == 6 and quality and quality >= 7 then -- boots
  return "models/items/pudge/the_devarque_fugitive_back/the_devarque_fugitive_back.vmdl"
end
if slot == 6 and quality and quality >= 0 then -- boots
  --return "models/heroes/silencer/silencer_robe.vmdl"
end
end
if heroname == "npc_dota_hero_bloodseeker" then
  if slot == 1 and quality and quality >= 7 then -- mainhand
    return "models/items/blood_seeker/thirst_of_eztzhok_weapon/thirst_of_eztzhok.vmdl"
  end
  if slot == 1 and quality and quality == 6 then -- mainhand
    return "models/items/blood_seeker/tribal_terror_weapon/tribal_terror_weapon.vmdl"
  end
  if slot == 1 and quality and quality >= 0 then -- mainhand
    return "models/heroes/blood_seeker/weapon.vmdl"
  end
  if slot == 2 and quality and quality >= 7 then -- offhand
    return "models/items/blood_seeker/thirst_of_eztzhok_weapon_offhand/thirst_of_eztzhok_offhand.vmdl"
  end
  if slot == 2 and quality and quality == 6 then -- offhand
    return "models/items/blood_seeker/tribal_terror_offhand/tribal_terror_offhand.vmdl"
  end
  if slot == 2 and quality and quality == 0 then -- offhand
    return "models/heroes/blood_seeker/weapon_offhand.vmdl"
  end
  if slot == 3 and quality and quality >= 7 then -- ring
    return "models/items/blood_seeker/bloodseeker_relentless_hunter_arms/bloodseeker_relentless_hunter_arms.vmdl"
  end
  if slot == 3 and quality and quality == 6 then -- ring
    return "models/items/blood_seeker/tribal_terror_arms/tribal_terror_arms.vmdl"
  end
  if slot == 3 and quality and quality >= 0 then -- ring
    --return "models/heroes/invoker/invoker_head.vmdl"
  end
  if slot == 4 and quality and quality >= 7 then -- head
   return "models/items/blood_seeker/bloodseeker_relentless_hunter_head/bloodseeker_relentless_hunter_head.vmdl"
 end
 if slot == 4 and quality and quality == 6 then -- head
   return "models/items/blood_seeker/tribal_terror_head/tribal_terror_head.vmdl"
 end
 if slot == 4 and quality and quality >= 0 then -- head
  return "models/heroes/blood_seeker/helmet.vmdl"
end
if slot == 5 and quality and quality >= 7 then -- chest
  return "models/items/blood_seeker/bloodseeker_relentless_hunter_belt/bloodseeker_relentless_hunter_belt.vmdl"
end
if slot == 5 and quality and quality == 6 then -- chest
  return "models/items/blood_seeker/tribal_terror_belt/tribal_terror_belt.vmdl"
end
if slot == 6 and quality and quality >= 7 then -- boots
  return "models/items/blood_seeker/bloodseeker_relentless_hunter_back/bloodseeker_relentless_hunter_back.vmdl"
end
if slot == 6 and quality and quality == 6 then -- boots
  return "models/items/blood_seeker/tribal_terror_back/tribal_terror_back.vmdl"
end
if slot == 6 and quality and quality >= 0 then -- boots
  --return "models/heroes/silencer/silencer_robe.vmdl"
end
end
if heroname == "npc_dota_hero_lina" then
  if slot == 1 and quality and quality >= 5 then -- mainhand
    hero.tier2prop = Attachments:AttachProp(hero, "attach_attack1", "models/items/doom/weapon_eyeoffetitzu/weapon_eyeoffetitzu.vmdl", 0.5)
    ArtifactCosmeticUnlocked(slot, 5, hero)
    --return "models/items/blood_seeker/thirst_of_eztzhok_weapon/thirst_of_eztzhok.vmdl"
  end
  if slot == 1 and quality and quality == 6 then -- mainhand
    --return "models/items/blood_seeker/tribal_terror_weapon/tribal_terror_weapon.vmdl"
  end
  if slot == 1 and quality and quality >= 0 then -- mainhand
    --return "models/heroes/blood_seeker/weapon.vmdl"
  end
  if slot == 2 and quality and quality >= 6 then -- offhand
    return "models/items/lina/scales_of_the_burning_dragon_arms/scales_of_the_burning_dragon_arms.vmdl"
  end
  if slot == 2 and quality and quality == 6 then -- offhand
    return "models/items/lina/bewitching_flame_arms/bewitching_flame_arms.vmdl"
  end
  if slot == 2 and quality and quality == 0 then -- offhand
    --return "models/heroes/blood_seeker/weapon_offhand.vmdl"
  end
  if slot == 3 and quality and quality >= 7 then -- ring
    return "models/items/lina/scales_of_the_burning_dragon_neck/scales_of_the_burning_dragon_neck.vmdl"
  end
  if slot == 3 and quality and quality == 6 then -- ring
    return "models/items/lina/warhawk_vestiments_necklace/warhawk_vestiments_necklace.vmdl"
  end
  if slot == 3 and quality and quality >= 0 then -- ring
    --return "models/heroes/invoker/invoker_head.vmdl"
  end
  if slot == 4 and quality and quality >= 7 then -- head
   return "models/items/lina/scales_of_the_burning_dragon_head/scales_of_the_burning_dragon_head.vmdl"
 end
 if slot == 4 and quality and quality == 6 then -- head
   return "models/items/lina/bewitching_flame_hair/bewitching_flame_hair.vmdl"
 end
 if slot == 4 and quality and quality >= 0 then -- head
  return "models/heroes/lina/lina_head.vmdl"
end
--if slot == 5 and quality and quality >= 7 then -- chest
  --    return "models/items/lina/lina_immortal_ii/mesh/lina_immortal_ii.vmdl"
  --end
  if slot == 5 and quality and quality >= 6 then -- chest
    hero.tier3prop = Attachments:AttachProp(hero, "attach_hitloc", "models/heroes/shadow_fiend/arcana_wings.vmdl", nil)
    ArtifactCosmeticUnlocked(slot, 6, hero)
    return "models/items/lina/bewitching_flame_neck/bewitching_flame_neck.vmdl"
  end
  if slot == 6 and quality and quality >= 7 then -- boots
    return "models/items/lina/scales_of_the_burning_dragon_belt/scales_of_the_burning_dragon_belt.vmdl"
  end
  if slot == 6 and quality and quality == 6 then -- boots
    return "models/items/lina/bewitching_flame_belt/bewitching_flame_belt.vmdl"
  end
  if slot == 6 and quality and quality >= 0 then -- boots
    return "models/heroes/lina/lina_belt.vmdl"
  end
end
if heroname == "npc_dota_hero_crystal_maiden" then
  if slot == 1 and quality and quality >= 7 then -- mainhand
    return "models/items/crystal_maiden/cm_mike_staff/cm_mike_staff.vmdl"
  end
  if slot == 1 and quality and quality == 6 then -- mainhand
    return "models/items/crystal_maiden/lumini_polare_weapon/lumini_polare_weapon.vmdl"
  end
  if slot == 1 and quality and quality >= 0 then -- mainhand
    return "models/heroes/crystal_maiden/crystal_maiden_staff.vmdl"
  end
  if slot == 2 and quality and quality >= 7 then -- offhand
    ArtifactCosmeticUnlocked(slot, 7, hero)
    return "models/items/crystal_maiden/frozen_feather_bracers/frozen_feather_bracers.vmdl"
  end
  if slot == 2 and quality and quality == 6 then -- offhand
    return "models/items/crystal_maiden/lumini_polare_arms/lumini_polare_arms.vmdl"
  end
  if slot == 2 and quality and quality == 0 then -- offhand
    --return "models/heroes/blood_seeker/weapon_offhand.vmdl"
  end
  if slot == 3 and quality and quality >= 6 then -- ring
    hero.artifact_ring = 7
    ArtifactCosmeticUnlocked(slot, 6, hero)
  end
  if slot == 3 and quality and quality == 6 then -- ring
    return "models/items/lina/warhawk_vestiments_necklace/warhawk_vestiments_necklace.vmdl"
  end
  if slot == 3 and quality and quality >= 0 then -- ring
    --return "models/heroes/invoker/invoker_head.vmdl"
  end
  if slot == 4 and quality and quality >= 7 then -- head
   return "models/items/crystal_maiden/cowl_of_ice/cowl_of_ice.vmdl"
 end
 if slot == 4 and quality and quality == 6 then -- head
   return "models/items/crystal_maiden/lumini_polare_head/lumini_polare_head.vmdl"
 end
 if slot == 4 and quality and quality >= 0 then -- head
  return "models/heroes/crystal_maiden/head_item.vmdl"
end
if slot == 5 and quality and quality >= 7 then -- chest
  return "models/items/crystal_maiden/frozen_feathers_shoulders/frozen_feathers_shoulders.vmdl"
end
if slot == 5 and quality and quality == 6 then -- chest
  return "models/items/crystal_maiden/lumini_polare_shoulder/lumini_polare_shoulder.vmdl"
end
if slot == 6 and quality and quality >= 7 then -- boots
  return "models/heroes/crystal_maiden/crystal_maiden_arcana_back.vmdl"
end
if slot == 6 and quality and quality == 6 then -- boots
  return "models/items/crystal_maiden/lumini_polare_back/lumini_polare_back.vmdl"
end
if slot == 6 and quality and quality >= 0 then -- boots
  return "models/heroes/crystal_maiden/crystal_maiden_cape.vmdl"
end
end
if heroname == "npc_dota_hero_beastmaster" then
  if slot == 1 and quality and quality >= 7 then -- mainhand
    return "models/items/beastmaster/chimeras_anger_weapon/chimeras_anger_weapon.vmdl"
  end
  if slot == 1 and quality and quality == 6 then -- mainhand
    return "models/items/beastmaster/beast_heart_marauder_weapon/beast_heart_marauder_weapon.vmdl"
  end
  if slot == 1 and quality and quality >= 0 then -- mainhand
    return "models/heroes/beastmaster/beastmaster_weapon.vmdl"
  end
  if slot == 2 and quality and quality >= 7 then -- offhand
    hero.tier2prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/furion/shoulders_beaver_1.vmdl", nil)
    ArtifactCosmeticUnlocked(slot, 7, hero)
    return "models/items/beastmaster/chimeras_anger_arms/chimeras_anger_arms.vmdl"
  end
  if slot == 2 and quality and quality == 6 then -- offhand
    return "models/items/beastmaster/beast_heart_marauder_arms/beast_heart_marauder_arms.vmdl"
  end
  if slot == 2 and quality and quality == 0 then -- offhand
    --return "models/heroes/blood_seeker/weapon_offhand.vmdl"
  end
  if slot == 3 and quality and quality >= 7 then -- ring
    --return "models/items/lina/warhawk_vestiments_necklace/warhawk_vestiments_necklace.vmdl"
  end
  if slot == 3 and quality and quality == 6 then -- ring
    --return "models/items/lina/warhawk_vestiments_necklace/warhawk_vestiments_necklace.vmdl"
  end
  if slot == 3 and quality and quality >= 0 then -- ring
    --return "models/heroes/invoker/invoker_head.vmdl"
  end
  if slot == 4 and quality and quality >= 6 then -- head
    hero.tier3prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/sniper/wolf_hat_dark/wolf_hat_dark.vmdl", nil)
    ArtifactCosmeticUnlocked(slot, 6, hero)
    --return "models/items/crystal_maiden/cowl_of_ice/cowl_of_ice.vmdl"
  end
  if slot == 4 and quality and quality == 6 then -- head
   return "models/items/beastmaster/beast_heart_marauder_head/beast_heart_marauder_head.vmdl"
 end
 if slot == 4 and quality and quality >= 0 then -- head
  return "models/heroes/beastmaster/beastmaster_head.vmdl"
end
if slot == 5 and quality and quality >= 6 then -- chest
  hero.tier1prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/lycan/hunter_kings_shoulder/hunter_kings_shoulder.vmdl", nil)
  ArtifactCosmeticUnlocked(slot, 6, hero)
  --return "models/items/crystal_maiden/frozen_feathers_shoulders/frozen_feathers_shoulders.vmdl"
end
if slot == 5 and quality and quality == 6 then -- chest
  return "models/items/beastmaster/beast_heart_marauder_shoulder/beast_heart_marauder_shoulder.vmdl"
end
if slot == 6 and quality and quality >= 7 then -- boots
  return "models/items/beastmaster/chimeras_anger_belt/chimeras_anger_belt.vmdl"
end
if slot == 6 and quality and quality == 6 then -- boots
  return "models/items/beastmaster/beast_heart_marauder_belt/beast_heart_marauder_belt.vmdl"
end
if slot == 6 and quality and quality >= 0 then -- boots
  --return "models/heroes/crystal_maiden/crystal_maiden_cape.vmdl"
end
end
if heroname == "npc_dota_hero_ursa" then
  if slot == 1 and quality and quality >= 7 then -- mainhand
    hero:SetOriginalModel("models/items/lone_druid/true_form/rabid_black_bear/rabid_black_bear.vmdl")
    ArtifactCosmeticUnlocked(slot, 7, hero)
    return nil
  end
  if slot == 1 and quality and quality >= 5 then -- mainhand
    hero:SetOriginalModel("models/items/lone_druid/true_form/dark_wood_true_form/dark_wood_true_form.vmdl")
    ArtifactCosmeticUnlocked(slot, 5, hero)
  end
  if slot == 1 and quality and quality >= 0 then -- mainhand
    --return "models/heroes/rikimaru/rikimaru_weapon.vmdl"
  end
end
if heroname == "npc_dota_hero_riki" then
  if slot == 1 and quality and quality >= 7 then -- mainhand
    return "models/items/rikimaru/riki_golden_saboteur_weapon/riki_golden_saboteur_weapon.vmdl"
  end
  if slot == 1 and quality and quality == 6 then -- mainhand
    return "models/items/rikimaru/umbrage/umbrage.vmdl"
  end
  if slot == 1 and quality and quality >= 0 then -- mainhand
    return "models/heroes/rikimaru/rikimaru_weapon.vmdl"
  end
  if slot == 2 and quality and quality >= 7 then -- offhand
    return "models/items/rikimaru/riki_golden_saboteur_weapon_offhand/riki_golden_saboteur_weapon_offhand.vmdl"
  end
  if slot == 2 and quality and quality == 6 then -- offhand
    return "models/items/rikimaru/umbrage__offhand/umbrage__offhand.vmdl"
  end
  if slot == 2 and quality and quality == 0 then -- offhand
    return "models/heroes/rikimaru/rikimaru__offhand_weapon.vmdl"
  end
  if slot == 3 and quality and quality >= 7 then -- ring
    return "models/items/rikimaru/riki_golden_saboteur__arms/riki_golden_saboteur__arms.vmdl"
  end
  if slot == 3 and quality and quality >= 6 then -- ring
    ArtifactCosmeticUnlocked(slot, 6, hero, true)
    return "models/items/rikimaru/frozenblood_arms/frozenblood_arms.vmdl"
  end
  if slot == 3 and quality and quality >= 0 then -- ring
    --return "models/heroes/invoker/invoker_head.vmdl"
  end
  if slot == 4 and quality and quality >= 7 then -- head
   return "models/items/rikimaru/riki_golden_saboteur__head_alt/riki_golden_saboteur__head_alt.vmdl"
 end
 if slot == 4 and quality and quality == 6 then -- head
   return "models/items/rikimaru/frozenblood_head/frozenblood_head.vmdl"
 end
 if slot == 4 and quality and quality >= 0 then -- head
  return "models/heroes/rikimaru/rikimaru_head.vmdl"
end
if slot == 5 and quality and quality >= 7 then -- chest
  return "models/items/rikimaru/riki_golden_saboteur__shoulder/riki_golden_saboteur__shoulder.vmdl"
end
if slot == 5 and quality and quality == 6 then -- chest
  return "models/items/rikimaru/frozenblood_shoulder/frozenblood_shoulder.vmdl"
end
if slot == 6 and quality and quality >= 7 then -- boots
  return "models/items/rikimaru/ti6_blink_strike/riki_ti6_blink_strike.vmdl"
end
if slot == 6 and quality and quality == 6 then -- boots
  return "models/items/rikimaru/frozenblood_tail/frozenblood_tail.vmdl"
end
if slot == 6 and quality and quality >= 0 then -- boots
  --return "models/heroes/crystal_maiden/crystal_maiden_cape.vmdl"
end
end
if heroname == "npc_dota_hero_dragon_knight" then
  if slot == 1 and quality and quality >= 7 then -- mainhand
    return "models/items/dragon_knight/fireborn_sword/fireborn_sword.vmdl"
  end
  if slot == 1 and quality and quality == 6 then -- mainhand
    return "models/items/dragon_knight/aurora_warrior_set_weapon/aurora_warrior_set_weapon.vmdl"
  end
  if slot == 1 and quality and quality == 5 then -- mainhand
    return "models/items/dragon_knight/dragon_lord_weapon/dragon_lord_weapon.vmdl"
  end
  if slot == 1 and quality and quality >= 0 then -- mainhand
    return "models/heroes/dragon_knight/weapon.vmdl"
  end
  if slot == 2 and quality and quality >= 6 then -- offhand
    hero.tier3prop = Attachments:AttachProp(hero, "attach_attack2", "models/items/dragon_knight/fireborn_shield/fireborn_shield.vmdl", nil)
    ArtifactCosmeticUnlocked(slot, 6, hero)
    return nil
    --return "models/items/rikimaru/riki_golden_saboteur_weapon_offhand/riki_golden_saboteur_weapon_offhand.vmdl"
  end
  if slot == 2 and quality and quality == 6 then -- offhand
    return "models/items/dragon_knight/aurora_warrior_set_off_hand/aurora_warrior_set_off_hand.vmdl"
  end
  if slot == 2 and quality and quality == 5 then -- offhand
    return "models/items/dragon_knight/dragon_lord_offhand/dragon_lord_offhand.vmdl"
  end
  if slot == 2 and quality and quality >= 0 then -- offhand
    return "models/heroes/dragon_knight/shield.vmdl"
  end
  if slot == 3 and quality and quality >= 7 then -- ring
    return "models/items/dragon_knight/fireborn_arms/fireborn_arms.vmdl"
  end
  if slot == 3 and quality and quality == 6 then -- ring
    return "models/items/dragon_knight/aurora_warrior_set_arms/aurora_warrior_set_arms.vmdl"
  end
  if slot == 3 and quality and quality >= 0 then -- ring
    --return "models/heroes/invoker/invoker_head.vmdl"
  end
  if slot == 4 and quality and quality >= 7 then -- head
   return "models/items/dragon_knight/fireborn_helmet/fireborn_helmet.vmdl"
 end
 if slot == 4 and quality and quality == 6 then -- head
   return "models/items/dragon_knight/aurora_warrior_set_head/aurora_warrior_set_head.vmdl"
 end
 if slot == 4 and quality and quality >= 0 then -- head
  return "models/heroes/dragon_knight/helmet.vmdl"
end
if slot == 5 and quality and quality >= 7 then -- chest
  return "models/items/dragon_knight/fireborn_shoulders/fireborn_shoulders.vmdl"
end
if slot == 5 and quality and quality == 6 then -- chest
  return "models/items/dragon_knight/aurora_warrior_set_shoulder/aurora_warrior_set_shoulder.vmdl"
end
if slot == 6 and quality and quality >= 7 then -- boots
  return "models/items/dragon_knight/fireborn_back/fireborn_back.vmdl"
end
if slot == 6 and quality and quality == 6 then -- boots
  return "models/items/dragon_knight/aurora_warrior_set_back/aurora_warrior_set_back.vmdl"
end
if slot == 6 and quality and quality >= 0 then -- boots
  --return "models/heroes/crystal_maiden/crystal_maiden_cape.vmdl"
end
end
if heroname == "npc_dota_hero_skeleton_king" then
  if slot == 1 and quality and quality >= 7 then -- mainhand
    return "models/items/wraith_king/the_blood_shard/the_blood_shard.vmdl"
  end
  if slot == 1 and quality and quality == 6 then -- mainhand
    return "models/items/wraith_king/lord_of_the_hunt_weapon/lord_of_the_hunt_weapon.vmdl"
  end
  if slot == 1 and quality and quality == 5 then -- mainhand
    return "models/items/wraith_king/bk/bk_sword2.vmdl"
  end
  if slot == 1 and quality and quality >= 0 then -- mainhand
    return "models/heroes/wraith_king/wraith_king_weapon.vmdl"
  end
  if slot == 2 and quality and quality >= 7 then -- offhand
    --hero.tier2prop = Attachments:AttachProp(hero, "attach_attack2", "models/items/wraith_king/lord_of_the_hunt_weapon/lord_of_the_hunt_weapon.vmdl", nil)
    return "models/items/wraith_king/wraith_king_the_immortal_glory_shoulder/wraith_king_the_immortal_glory_shoulder.vmdl"
  end
  if slot == 2 and quality and quality == 6 then -- offhand
    return "models/items/wraith_king/lord_of_the_hunt_shoulder/lord_of_the_hunt_shoulder.vmdl"
  end
  if slot == 2 and quality and quality == 5 then -- offhand
    return "models/items/wraith_king/bk/bk_shoulders.vmdl"
  end
  if slot == 2 and quality and quality >= 0 then -- offhand
    --return "models/heroes/dragon_knight/shield.vmdl"
  end
  if slot == 3 and quality and quality >= 7 then -- ring
    return "models/items/wraith_king/blistering_shade/mesh/blistering_shade.vmdl"
  end
  if slot == 3 and quality and quality == 6 then -- ring
    return "models/items/wraith_king/lord_of_the_hunt_arms/lord_of_the_hunt_arms.vmdl"
  end
  if slot == 3 and quality and quality >= 0 then -- ring
    --return "models/heroes/invoker/invoker_head.vmdl"
  end
  if slot == 4 and quality and quality >= 7 then -- head
   return "models/items/wraith_king/wraith_king_the_immortal_glory_head/wraith_king_the_immortal_glory_head.vmdl"
 end
 if slot == 4 and quality and quality == 6 then -- head
   return "models/items/wraith_king/lord_of_the_hunt_head/lord_of_the_hunt_head.vmdl"
 end
 if slot == 4 and quality and quality >= 0 then -- head
  return "models/heroes/wraith_king/wraith_king_head.vmdl"
end
if slot == 5 and quality and quality >= 6 then -- chest
  hero.tier3prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/obsidian_destroyer/obsidianguard_back/obsidianguard_back.vmdl", nil)
  ArtifactCosmeticUnlocked(slot, 6, hero)
  return "models/items/wraith_king/wraith_king_the_immortal_glory_armor/wraith_king_the_immortal_glory_armor.vmdl"
end
if slot == 5 and quality and quality == 6 then -- chest
  return "models/items/wraith_king/lord_of_the_hunt_armor/lord_of_the_hunt_armor.vmdl"
end
if slot == 6 and quality and quality >= 7 then -- boots
  return "models/items/wraith_king/wraith_king_the_immortal_glory_back/wraith_king_the_immortal_glory_back.vmdl"
end
if slot == 6 and quality and quality == 6 then -- boots
  return "models/items/wraith_king/lord_of_the_hunt_back/lord_of_the_hunt_back.vmdl"
end
if slot == 6 and quality and quality >= 0 then -- boots
  --return "models/heroes/crystal_maiden/crystal_maiden_cape.vmdl"
end
end
if heroname == "npc_dota_hero_bristleback" then
  if slot == 1 and quality and quality >= 7 then -- mainhand
    return "models/items/bristleback/ef_mace_glow/ef_mace_glow.vmdl"
  end
  if slot == 1 and quality and quality == 6 then -- mainhand
    return "models/items/bristleback/wrathrunner_weapon/wrathrunner_weapon.vmdl"
  end
  if slot == 1 and quality and quality == 5 then -- mainhand
    return "models/items/bristleback/heavy_barbed_morning_star/heavy_barbed_morning_star.vmdl"
  end
  if slot == 1 and quality and quality >= 0 then -- mainhand
    return "models/heroes/bristleback/bristleback_weapon.vmdl"
  end
  if slot == 2 and quality and quality >= 7 then -- offhand
    return "models/items/bristleback/ef_armlet_glow/ef_armlet_glow.vmdl"
  end
  if slot == 2 and quality and quality == 6 then -- offhand
    return "models/items/bristleback/wrathrunner_neck/wrathrunner_neck.vmdl"
  end
  if slot == 2 and quality and quality == 5 then -- offhand
    return "models/items/bristleback/heavy_barbed_arms/heavy_barbed_arms.vmdl"
  end
  if slot == 2 and quality and quality >= 0 then -- offhand
    --return "models/heroes/dragon_knight/shield.vmdl"
  end
  if slot == 3 and quality and quality >= 7 then -- ring
    return "models/items/bristleback/ef_amulet_glow/ef_amulet_glow.vmdl"
  end
  if slot == 3 and quality and quality == 6 then -- ring
    return "models/items/bristleback/wrathrunner_arms/wrathrunner_arms.vmdl"
  end
  if slot == 3 and quality and quality >= 0 then -- ring
    --return "models/heroes/invoker/invoker_head.vmdl"
  end
  if slot == 4 and quality and quality >= 7 then -- head
   return "models/items/bristleback/ef_helmet_glow/ef_helmet_glow.vmdl"
 end
 if slot == 4 and quality and quality == 6 then -- head
   return "models/items/bristleback/wrathrunner_head/wrathrunner_head.vmdl"
 end
 if slot == 4 and quality and quality >= 0 then -- head
  --return "models/heroes/wraith_king/wraith_king_head.vmdl"
end
if slot == 5 and quality and quality >= 7 then -- chest
  return "models/items/bristleback/ef_shoulder/ef_shoulder.vmdl"
end
if slot == 5 and quality and quality == 6 then -- chest
  return "models/items/bristleback/wrathrunner_back/wrathrunner_back.vmdl"
end
if slot == 6 and quality and quality >= 7 then -- boots
  --return "models/items/wraith_king/wraith_king_the_immortal_glory_back/wraith_king_the_immortal_glory_back.vmdl"
end
if slot == 6 and quality and quality == 6 then -- boots
  --return "models/items/wraith_king/lord_of_the_hunt_back/lord_of_the_hunt_back.vmdl"
end
if slot == 6 and quality and quality >= 0 then -- boots
  --return "models/heroes/crystal_maiden/crystal_maiden_cape.vmdl"
end
end
if heroname == "npc_dota_hero_sven" then
  if slot == 1 and quality and quality >= 7 then -- mainhand
    return "models/items/sven/arbiter_weapon/arbiter_weapon.vmdl"
  end
  if slot == 1 and quality and quality == 6 then -- mainhand
    return "models/items/sven/breath_of_tielong/breath_of_tielong.vmdl"
  end
  if slot == 1 and quality and quality == 5 then -- mainhand
    return "models/items/sven/the_rogue_omen_sword/the_rogue_omen_sword.vmdl"
  end
  if slot == 1 and quality and quality >= 0 then -- mainhand
    return "models/heroes/sven/sven_sword.vmdl"
  end
  if slot == 2 and quality and quality >= 7 then -- offhand
    return "models/items/sven/arbiter_arms/arbiter_arms.vmdl"
  end
  if slot == 2 and quality and quality == 6 then -- offhand
    return "models/items/sven/gauntlet_of_tielong/gauntlet_of_tielong.vmdl"
  end
  if slot == 2 and quality and quality == 5 then -- offhand
    return "models/items/sven/rhinoceros_arms/rhinoceros_arms.vmdl"
  end
  if slot == 2 and quality and quality >= 0 then -- offhand
    return "models/heroes/sven/sven_gauntlet.vmdl"
  end
  if slot == 3 and quality and quality >= 7 then -- ring
    return "models/items/sven/arbiter_shoulder/arbiter_shoulder.vmdl"
  end
  if slot == 3 and quality and quality == 6 then -- ring
    return "models/items/sven/pauldron_of_tielong/pauldron_of_tielong.vmdl"
  end
  if slot == 3 and quality and quality >= 0 then -- ring
    --return "models/heroes/invoker/invoker_head.vmdl"
  end
  if slot == 4 and quality and quality >= 7 then -- head
   return "models/items/sven/arbiter_head/arbiter_head.vmdl"
 end
 if slot == 4 and quality and quality == 6 then -- head
   return "models/items/sven/helmet_of_tielong/helmet_of_tielong.vmdl"
 end
 if slot == 4 and quality and quality >= 0 then -- head
  return "models/heroes/sven/sven_mask.vmdl"
end
if slot == 5 and quality and quality >= 7 then -- chest
  return "models/items/sven/arbiter_belt/arbiter_belt.vmdl"
end
if slot == 5 and quality and quality == 6 then -- chest
  return "models/items/sven/belt_of_tielong/belt_of_tielong.vmdl"
end
if slot == 6 and quality and quality >= 7 then -- boots
  return "models/items/sven/arbiter_back/arbiter_back.vmdl"
end
if slot == 6 and quality and quality == 6 then -- boots
  --return "models/items/sven/belt_of_tielong/belt_of_tielong.vmdl"
end
if slot == 6 and quality and quality >= 0 then -- boots
  --return "models/heroes/crystal_maiden/crystal_maiden_cape.vmdl"
end
end
if heroname == "npc_dota_hero_clinkz" then
  if slot == 1 and quality and quality >= 7 then -- mainhand
    return "models/items/clinkz/ti6_clinkz_weapon/ti6_clinkz_weapon.vmdl"
  end
  if slot == 1 and quality and quality == 6 then -- mainhand
    return "models/items/clinkz/redbull_clinkz_weapon/redbull_clinkz_weapon.vmdl"
  end
  if slot == 1 and quality and quality == 5 then -- mainhand
    return "models/items/clinkz/wep/wep.vmdl"
  end
  if slot == 1 and quality and quality >= 0 then -- mainhand
    return "models/heroes/clinkz/clinkz_bow.vmdl"
  end
  if slot == 2 and quality and quality >= 7 then -- offhand
    return "models/items/clinkz/ti6_clinkz_back/ti6_clinkz_back.vmdl"
  end
  if slot == 2 and quality and quality == 6 then -- offhand
    return "models/items/clinkz/redbull_clinkz_back/redbull_clinkz_back.vmdl"
  end
  if slot == 2 and quality and quality == 5 then -- offhand
    return "models/items/clinkz/justpicsnothingmnew/justpicsnothingmnew.vmdl"
  end
  if slot == 2 and quality and quality >= 0 then -- offhand
    return "models/heroes/sven/sven_gauntlet.vmdl"
  end
  if slot == 3 and quality and quality >= 7 then -- ring
    return "models/items/clinkz/ti6_clinkz_gloves/ti6_clinkz_gloves.vmdl"
  end
  if slot == 3 and quality and quality == 6 then -- ring
    return "models/items/clinkz/redbull_clinkz_gloves/redbull_clinkz_gloves.vmdl"
  end
  if slot == 3 and quality and quality >= 0 then -- ring
    return "models/heroes/clinkz/clinkz_gloves.vmdl"
  end
  if slot == 4 and quality and quality >= 7 then -- head
   return "models/items/clinkz/ti6_clinkz_head/ti6_clinkz_head.vmdl"
 end
 if slot == 4 and quality and quality == 6 then -- head
   return "models/items/clinkz/redbull_clinkz_head/redbull_clinkz_head.vmdl"
 end
 if slot == 4 and quality and quality >= 0 then -- head
  --return "models/heroes/clinkz/clinkz_head.vmdl"
end
if slot == 5 and quality and quality >= 7 then -- chest
  return "models/items/clinkz/ti6_clinkz_shoulder/ti6_clinkz_shoulder.vmdl"
end
if slot == 5 and quality and quality == 6 then -- chest
  return "models/items/clinkz/redbull_clinkz_shoulder/redbull_clinkz_shoulder.vmdl"
end
if slot == 6 and quality and quality >= 7 then -- boots
  --return "models/items/sven/arbiter_back/arbiter_back.vmdl"
end
if slot == 6 and quality and quality == 6 then -- boots
  --return "models/items/sven/belt_of_tielong/belt_of_tielong.vmdl"
end
if slot == 6 and quality and quality >= 0 then -- boots
  return "models/heroes/clinkz/clinkz_head.vmdl"
end
end
if heroname == "npc_dota_hero_bounty_hunter" then
  if slot == 1 and quality and quality >= 7 then -- mainhand
    return "models/items/bounty_hunter/gold_ripperbounty_hunter_weapon/gold_ripperbounty_hunter_weapon.vmdl"
  end
  if slot == 1 and quality and quality == 6 then -- mainhand
    return "models/items/bounty_hunter/twinblades_weapon/twinblades_weapon.vmdl"
  end
  if slot == 1 and quality and quality == 5 then -- mainhand
    return "models/items/bounty_hunter/weapon_assasin.vmdl"
  end
  if slot == 1 and quality and quality >= 0 then -- mainhand
    return "models/heroes/bounty_hunter/bounty_hunter_rweapon.vmdl"
  end
  if slot == 2 and quality and quality >= 7 then -- offhand
    return "models/items/bounty_hunter/gold_ripperbounty_hunter_off_hand/gold_ripperbounty_hunter_off_hand.vmdl"
  end
  if slot == 2 and quality and quality == 6 then -- offhand
    return "models/items/bounty_hunter/twinblades_offhand/twinblades_offhand.vmdl"
  end
  if slot == 2 and quality and quality == 5 then -- offhand
    return "models/items/bounty_hunter/offhand_assasin.vmdl"
  end
  if slot == 2 and quality and quality >= 0 then -- offhand
    return "models/heroes/bounty_hunter/bounty_hunter_lweapon.vmdl"
  end
  if slot == 3 and quality and quality >= 7 then -- ring
    return "models/items/bounty_hunter/gold_ripperbounty_hunter_shoulder/gold_ripperbounty_hunter_shoulder.vmdl"
  end
  if slot == 3 and quality and quality >= 6 then -- ring
    ArtifactCosmeticUnlocked(slot, 6, hero, true)
    return "models/items/bounty_hunter/twinblades_shoulder/twinblades_shoulder.vmdl"
  end
  if slot == 3 and quality and quality >= 0 then -- ring
    --return "models/heroes/clinkz/clinkz_gloves.vmdl"
  end
  if slot == 4 and quality and quality >= 7 then -- head
   return "models/items/bounty_hunter/gold_ripperbounty_hunter_head/gold_ripperbounty_hunter_head.vmdl"
 end
 if slot == 4 and quality and quality == 6 then -- head
   return "models/items/bounty_hunter/twinblades_head/twinblades_head.vmdl"
 end
 if slot == 4 and quality and quality >= 0 then -- head
  --return "models/heroes/clinkz/clinkz_head.vmdl"
end
if slot == 5 and quality and quality >= 7 then -- chest
  return "models/items/bounty_hunter/gold_ripperbounty_hunter_armor/gold_ripperbounty_hunter_armor.vmdl"
end
if slot == 5 and quality and quality == 6 then -- chest
  return "models/items/bounty_hunter/twinblades_armor/twinblades_armor.vmdl"
end
if slot == 6 and quality and quality >= 7 then -- boots
  return "models/items/bounty_hunter/gold_ripperbounty_hunter_back/gold_ripperbounty_hunter_back.vmdl"
end
if slot == 6 and quality and quality == 6 then -- boots
  return "models/items/bounty_hunter/twinblades_back/twinblades_back.vmdl"
end
if slot == 6 and quality and quality >= 0 then -- boots
  --return "models/heroes/clinkz/clinkz_head.vmdl"
end
end
if heroname == "npc_dota_hero_omniknight" then
  if slot == 1 and quality and quality >= 7 then -- mainhand
    return "models/items/omniknight/light_hammer/mesh/light_hammer_model.vmdl"
  end
  if slot == 1 and quality and quality == 6 then -- mainhand
    return "models/items/omniknight/grey_night_weapon/grey_night_weapon.vmdl"
  end
  if slot == 1 and quality and quality == 5 then -- mainhand
    return "models/items/omniknight/weapon_omnik_slam/weapon_omnik_slam.vmdl"
  end
  if slot == 1 and quality and quality >= 0 then -- mainhand
    return "models/heroes/omniknight/hammer.vmdl"
  end
  if slot == 2 and quality and quality >= 7 then -- offhand
    return "models/items/omniknight/winged_gauntlet3/winged_gauntlet3.vmdl"
  end
  if slot == 2 and quality and quality == 6 then -- offhand
    return "models/items/omniknight/grey_night_arms/grey_night_arms.vmdl"
  end
  if slot == 2 and quality and quality == 5 then -- offhand
    --return "models/items/bounty_hunter/offhand_assasin.vmdl"
  end
  if slot == 2 and quality and quality >= 0 then -- offhand
    --return "models/heroes/bounty_hunter/bounty_hunter_lweapon.vmdl"
  end
  if slot == 3 and quality and quality >= 6 then -- ring
    return nil
    --return "models/items/omniknight/misc_book_hierophant.vmdl"
  end
  if slot == 3 and quality and quality == 6 then -- ring
    return "models/items/omniknight/grey_night_shoulders/grey_night_shoulders.vmdl"
  end
  if slot == 3 and quality and quality >= 0 then -- ring
    --return "models/heroes/omniknight/hair.vmdl"
  end
  if slot == 4 and quality and quality >= 6 then -- head
    hero.tier2prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/phantom_lancer/ancient_gods_shoulder/ancient_gods_shoulder.vmdl", nil)
    ArtifactCosmeticUnlocked(slot, 6, hero)
    return "models/items/omniknight/omniknight_sacred_light_head/omniknight_sacred_light_head.vmdl"
  end
  if slot == 4 and quality and quality == 6 then -- head
   return "models/items/omniknight/grey_night_head/grey_night_head.vmdl"
 end
 if slot == 4 and quality and quality >= 0 then -- head
  return "models/heroes/omniknight/hair.vmdl"
end
if slot == 5 and quality and quality >= 6 then -- chest
  hero.tier1prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/phantom_lancer/ancient_gods_shoulderpad/ancient_gods_shoulderpad.vmdl", nil)
  ArtifactCosmeticUnlocked(slot, 6, hero)
  return "models/items/omniknight/winged_cape2/winged_cape2.vmdl"
end
if slot == 5 and quality and quality == 6 then -- chest
  return "models/items/omniknight/grey_night_back/grey_night_back.vmdl"
end
if slot == 6 and quality and quality >= 7 then -- boots
  hero.tier3prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/puck/reminiscence_wings/reminiscence_wings.vmdl", nil)
  ArtifactCosmeticUnlocked(slot, 7, hero)
  --return "models/items/bounty_hunter/gold_ripperbounty_hunter_back/gold_ripperbounty_hunter_back.vmdl"
end
if slot == 6 and quality and quality == 6 then -- boots
  --return "models/items/bounty_hunter/twinblades_back/twinblades_back.vmdl"
end
if slot == 6 and quality and quality >= 0 then -- boots
  return "models/heroes/omniknight/head.vmdl"
end
end
if heroname == "npc_dota_hero_witch_doctor" then
  if slot == 1 and quality and quality >= 7 then -- mainhand
    return "models/items/witchdoctor/stormcrow_staff/stormcrow_staff.vmdl"
  end
  if slot == 1 and quality and quality == 6 then -- mainhand
    return "models/items/witchdoctor/wanderer_ticket_staff/wanderer_ticket_staff.vmdl"
  end
  if slot == 1 and quality and quality == 5 then -- mainhand
    return "models/items/witchdoctor/witchstaff_weapon/witchstaff_weapon.vmdl"
  end
  if slot == 1 and quality and quality >= 0 then -- mainhand
    return "models/heroes/witchdoctor/witchdoctor_staff.vmdl"
  end
  if slot == 2 and quality and quality >= 7 then -- offhand
    return "models/items/witchdoctor/stormcrowbag/stormcrowbag.vmdl"
  end
  if slot == 2 and quality and quality == 6 then -- offhand
    return "models/items/omniknight/grey_night_arms/grey_night_arms.vmdl"
  end
  if slot == 2 and quality and quality == 5 then -- offhand
    --return "models/items/bounty_hunter/offhand_assasin.vmdl"
  end
  if slot == 2 and quality and quality >= 0 then -- offhand
    --return "models/heroes/bounty_hunter/bounty_hunter_lweapon.vmdl"
  end
  if slot == 3 and quality and quality >= 6 then -- ring
    hero.tier3prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/pudge/ftp_dendi_crow/ftp_dendi_crow.vmdl", 1.5)
    ArtifactCosmeticUnlocked(slot, 6, hero)
    --return "models/items/omniknight/misc_book_hierophant.vmdl"
  end
  if slot == 3 and quality and quality == 6 then -- ring
    return "models/items/witchdoctor/wanderer_ticket_shoulderpart/wanderer_ticket_shoulderpart.vmdl"
  end
  if slot == 3 and quality and quality >= 0 then -- ring
    --return "models/heroes/omniknight/hair.vmdl"
  end
  if slot == 4 and quality and quality >= 7 then -- head
    hero.tier2prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/shadowshaman/true_crow_vision/true_crow_vision.vmdl", 1.75)
    ArtifactCosmeticUnlocked(slot, 7, hero)
    return
  end
  if slot == 4 and quality and quality == 6 then -- head
   return "models/items/witchdoctor/wanderer_ticket_mask/wanderer_ticket_mask.vmdl"
 end
 if slot == 4 and quality and quality >= 0 then -- head
  --return "models/heroes/omniknight/hair.vmdl"
end
if slot == 5 and quality and quality >= 7 then -- chest
  return "models/items/witchdoctor/stormcrowcloak/stormcrowcloak.vmdl"
end
if slot == 5 and quality and quality == 6 then -- chest
  return "models/items/witchdoctor/wanderer_ticket_backpart/wanderer_ticket_backpart.vmdl"
end
if slot == 6 and quality and quality >= 7 then -- boots
  return "models/items/witchdoctor/stormcrow_belt/stormcrow_belt.vmdl"
end
if slot == 6 and quality and quality == 6 then -- boots
  return "models/items/witchdoctor/wanderer_ticket_cloth/wanderer_ticket_cloth.vmdl"
end
if slot == 6 and quality and quality >= 0 then -- boots
  --return "models/heroes/omniknight/head.vmdl"
end
end
if heroname == "npc_dota_hero_elder_titan" then
  if slot == 1 and quality and quality >= 7 then -- mainhand
    return "models/items/elder_titan/warden_of_the_gong_weapon/warden_of_the_gong_weapon.vmdl"
  end
  if slot == 1 and quality and quality == 6 then -- mainhand
    return "models/items/elder_titan/harness_of_the_soulforged_weapon/harness_of_the_soulforged_weapon.vmdl"
  end
  if slot == 1 and quality and quality == 5 then -- mainhand
    return "models/items/elder_titan/mightworld_weapon/mightworld_weapon.vmdl"
  end
  if slot == 1 and quality and quality >= 0 then -- mainhand
    return "models/heroes/elder_titan/elder_titan_hammer.vmdl"
  end
  if slot == 2 and quality and quality >= 7 then -- offhand
    return "models/items/elder_titan/warden_of_the_gong_arms/warden_of_the_gong_arms.vmdl"
  end
  if slot == 2 and quality and quality == 6 then -- offhand
    return "models/items/elder_titan/harness_of_the_soulforged_arms/harness_of_the_soulforged_arms.vmdl"
  end
  if slot == 2 and quality and quality == 5 then -- offhand
    --return "models/items/bounty_hunter/offhand_assasin.vmdl"
  end
  if slot == 2 and quality and quality >= 0 then -- offhand
    --return "models/heroes/elder_titan/elder_titan_totem.vmdl"
  end
  if slot == 3 and quality and quality >= 7 then -- ring
    --hero.tier3prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/pudge/ftp_dendi_crow/ftp_dendi_crow.vmdl", nil)
    --return "models/items/omniknight/misc_book_hierophant.vmdl"
  end
  if slot == 3 and quality and quality == 6 then -- ring
    --return "models/items/witchdoctor/wanderer_ticket_shoulderpart/wanderer_ticket_shoulderpart.vmdl"
  end
  if slot == 3 and quality and quality >= 0 then -- ring
    --return "models/heroes/omniknight/hair.vmdl"
  end
  if slot == 4 and quality and quality >= 7 then -- head
    return "models/items/elder_titan/warden_of_the_gong_head/warden_of_the_gong_head.vmdl"
  end
  if slot == 4 and quality and quality == 6 then -- head
   return "models/items/elder_titan/harness_of_the_soulforged_head/harness_of_the_soulforged_head.vmdl"
 end
 if slot == 4 and quality and quality >= 0 then -- head
  --return "models/heroes/omniknight/hair.vmdl"
end
if slot == 5 and quality and quality >= 7 then -- chest
  return "models/items/elder_titan/warden_of_the_gong_shoulder/warden_of_the_gong_shoulder.vmdl"
end
if slot == 5 and quality and quality == 6 then -- chest
  return "models/items/elder_titan/harness_of_the_soulforged_shoulder/harness_of_the_soulforged_shoulder.vmdl"
end
if slot == 6 and quality and quality >= 7 then -- boots
  return "models/items/elder_titan/warden_of_the_gong_back/warden_of_the_gong_back.vmdl"
end
if slot == 6 and quality and quality == 6 then -- boots
  return "models/items/elder_titan/harness_of_the_soulforged_back/harness_of_the_soulforged_back.vmdl"
end
if slot == 6 and quality and quality >= 0 then -- boots
  --return "models/heroes/omniknight/head.vmdl"
end
end
if heroname == "npc_dota_hero_ogre_magi" then
  if slot == 1 and quality and quality >= 7 then -- mainhand
    return "models/items/ogre_magi/fortunes_veil_weapon/fortunes_veil_weapon.vmdl"
  end
  if slot == 1 and quality and quality == 6 then -- mainhand
    return "models/items/ogre_magi/ogre_ancestral_weapon/ogre_ancestral_weapon.vmdl"
  end
  if slot == 1 and quality and quality == 5 then -- mainhand
    return "models/items/ogre_magi/batter_snag/batter_snag.vmdl"
  end
  if slot == 1 and quality and quality >= 0 then -- mainhand
    return "models/heroes/ogre_magi/ogre_magi_weapon.vmdl"
  end
  if slot == 2 and quality and quality >= 7 then -- offhand
    return "models/items/ogre_magi/fortunes_veil_arms/fortunes_veil_arms.vmdl"
  end
  if slot == 2 and quality and quality == 6 then -- offhand
    return "models/items/ogre_magi/ogre_ancestral_arms/ogre_ancestral_arms.vmdl"
  end
  if slot == 2 and quality and quality == 5 then -- offhand
    --return "models/items/bounty_hunter/offhand_assasin.vmdl"
  end
  if slot == 2 and quality and quality >= 0 then -- offhand
    --return "models/heroes/elder_titan/elder_titan_totem.vmdl"
  end
  if slot == 3 and quality and quality >= 7 then -- ring
    --hero.tier3prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/pudge/ftp_dendi_crow/ftp_dendi_crow.vmdl", nil)
    --return "models/items/omniknight/misc_book_hierophant.vmdl"
  end
  if slot == 3 and quality and quality == 6 then -- ring
    --return "models/items/witchdoctor/wanderer_ticket_shoulderpart/wanderer_ticket_shoulderpart.vmdl"
  end
  if slot == 3 and quality and quality >= 0 then -- ring
    --return "models/heroes/omniknight/hair.vmdl"
  end
  if slot == 4 and quality and quality >= 7 then -- head
    return "models/items/ogre_magi/fortunes_veil_head/fortunes_veil_head.vmdl"
  end
  if slot == 4 and quality and quality == 6 then -- head
   return "models/items/ogre_magi/ogre_ancestral_head/ogre_ancestral_head.vmdl"
 end
 if slot == 4 and quality and quality >= 0 then -- head
  --return "models/heroes/omniknight/hair.vmdl"
end
if slot == 5 and quality and quality >= 7 then -- chest
  return "models/items/ogre_magi/fortunes_veil_back/fortunes_veil_back.vmdl"
end
if slot == 5 and quality and quality == 6 then -- chest
  return "models/items/ogre_magi/ogre_ancestral_back/ogre_ancestral_back.vmdl"
end
if slot == 6 and quality and quality >= 7 then -- boots
  return "models/items/ogre_magi/fortunes_veil_belt/fortunes_veil_belt.vmdl"
end
if slot == 6 and quality and quality == 6 then -- boots
  return "models/items/ogre_magi/ogre_ancestral_belt/ogre_ancestral_belt.vmdl"
end
if slot == 6 and quality and quality >= 0 then -- boots
  --return "models/heroes/omniknight/head.vmdl"
end
end
if heroname == "npc_dota_hero_vengefulspirit" then
  if slot == 1 and quality and quality >= 7 then -- mainhand
    return "models/items/vengefulspirit/forsaken_wings_weapon/forsaken_wings_weapon.vmdl"
  end
  if slot == 1 and quality and quality == 6 then -- mainhand
    return "models/items/vengefulspirit/echoes_eyrie_weapon/echoes_eyrie_weapon.vmdl"
  end
  if slot == 1 and quality and quality == 5 then -- mainhand
    return "models/items/vengefulspirit/huangs_umbra_weapon/huangs_umbra_weapon.vmdl"
  end
  if slot == 1 and quality and quality >= 0 then -- mainhand
    return "models/heroes/vengeful/vengeful_weapon.vmdl"
  end
  if slot == 2 and quality and quality >= 7 then -- offhand
    --return "models/items/ogre_magi/fortunes_veil_arms/fortunes_veil_arms.vmdl"
  end
  if slot == 2 and quality and quality == 6 then -- offhand
    --return "models/items/ogre_magi/ogre_ancestral_arms/ogre_ancestral_arms.vmdl"
  end
  if slot == 2 and quality and quality == 5 then -- offhand
    --return "models/items/bounty_hunter/offhand_assasin.vmdl"
  end
  if slot == 2 and quality and quality >= 0 then -- offhand
    --return "models/heroes/elder_titan/elder_titan_totem.vmdl"
  end
  if slot == 3 and quality and quality >= 7 then -- ring
    --hero.tier3prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/pudge/ftp_dendi_crow/ftp_dendi_crow.vmdl", nil)
    --return "models/items/omniknight/misc_book_hierophant.vmdl"
  end
  if slot == 3 and quality and quality == 6 then -- ring
    --return "models/items/witchdoctor/wanderer_ticket_shoulderpart/wanderer_ticket_shoulderpart.vmdl"
  end
  if slot == 3 and quality and quality >= 0 then -- ring
    --return "models/heroes/omniknight/hair.vmdl"
  end
  if slot == 4 and quality and quality >= 7 then -- head
    return "models/items/vengefulspirit/forsaken_wings_head/forsaken_wings_head.vmdl"
  end
  if slot == 4 and quality and quality == 6 then -- head
   return "models/items/vengefulspirit/echoes_eyrie_head/echoes_eyrie_head.vmdl"
 end
 if slot == 4 and quality and quality >= 0 then -- head
  return "models/heroes/vengeful/vengeful_hair.vmdl"
end
if slot == 5 and quality and quality >= 7 then -- chest
  return "models/items/vengefulspirit/forsaken_wings_shoulder/forsaken_wings_shoulder.vmdl"
end
if slot == 5 and quality and quality == 6 then -- chest
  return "models/items/vengefulspirit/echoes_eyrie_shoulder/echoes_eyrie_shoulder.vmdl"
end
if slot == 6 and quality and quality >= 7 then -- boots
  return "models/items/vengefulspirit/forsaken_wings_legs/forsaken_wings_legs.vmdl"
end
if slot == 6 and quality and quality == 6 then -- boots
  return "models/items/vengefulspirit/echoes_eyrie_legs/echoes_eyrie_legs.vmdl"
end
if slot == 6 and quality and quality >= 0 then -- boots
  --return "models/heroes/omniknight/head.vmdl"
end
end
if heroname == "npc_dota_hero_pugna" then
  if slot == 1 and quality and quality >= 7 then -- mainhand
    return "models/items/pugna/narcissistic_leech_weapon/narcissistic_leech_weapon.vmdl"
  end
  if slot == 1 and quality and quality == 6 then -- mainhand
    return "models/items/pugna/nether_grandmasters_bite/nether_grandmasters_bite.vmdl"
  end
  if slot == 1 and quality and quality == 5 then -- mainhand
    return "models/items/pugna/nether_lords_scepter/nether_lords_scepter.vmdl"
  end
  if slot == 1 and quality and quality >= 0 then -- mainhand
    return "models/heroes/pugna/pugna_weapon.vmdl"
  end
  if slot == 2 and quality and quality >= 7 then -- offhand
    return "models/items/pugna/narcissistic_leech_arms/narcissistic_leech_arms.vmdl"
  end
  if slot == 2 and quality and quality == 6 then -- offhand
    return "models/items/pugna/nether_grandmasters_bracers/nether_grandmasters_bracers.vmdl"
  end
  if slot == 2 and quality and quality == 5 then -- offhand
    return "models/items/pugna/nether_lords_bracer/nether_lords_bracer.vmdl"
  end
  if slot == 2 and quality and quality >= 0 then -- offhand
    --return "models/heroes/elder_titan/elder_titan_totem.vmdl"
  end
  if slot == 3 and quality and quality >= 7 then -- ring
    --hero.tier3prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/pudge/ftp_dendi_crow/ftp_dendi_crow.vmdl", nil)
    return "models/items/pugna/narcissistic_leech_back/narcissistic_leech_back.vmdl"
  end
  if slot == 3 and quality and quality == 6 then -- ring
    return "models/items/pugna/nether_grandmasters_cape/nether_grandmasters_cape.vmdl"
  end
  if slot == 3 and quality and quality >= 0 then -- ring
    --return "models/heroes/omniknight/hair.vmdl"
  end
  if slot == 4 and quality and quality >= 7 then -- head
    return "models/items/pugna/narcissistic_leech_head/narcissistic_leech_head.vmdl"
  end
  if slot == 4 and quality and quality == 6 then -- head
   return "models/items/pugna/nether_grandmasters_covering/nether_grandmasters_covering.vmdl"
 end
 if slot == 4 and quality and quality >= 0 then -- head
  return "models/heroes/pugna/pugna_head.vmdl"
end
if slot == 5 and quality and quality >= 7 then -- chest
  return "models/items/pugna/narcissistic_leech_shoulder/narcissistic_leech_shoulder.vmdl"
end
if slot == 5 and quality and quality == 6 then -- chest
  return "models/items/pugna/nether_grandmasters_points/nether_grandmasters_points.vmdl"
end
if slot == 6 and quality and quality >= 7 then -- boots
  return "models/items/pugna/narcissistic_leech_belt/narcissistic_leech_belt.vmdl"
end
if slot == 6 and quality and quality == 6 then -- boots
  return "models/items/pugna/nether_grandmasters_waistcloth/nether_grandmasters_waistcloth.vmdl"
end
if slot == 6 and quality and quality >= 0 then -- boots
  --return "models/heroes/omniknight/head.vmdl"
end
end
if heroname == "npc_dota_hero_warlock" then
  if slot == 1 and quality and quality >= 7 then -- mainhand
    return "models/items/warlock/mystery_of_the_lost_ores_weapon/mystery_of_the_lost_ores_weapon.vmdl"
  end
  if slot == 1 and quality and quality == 6 then -- mainhand
    return "models/items/warlock/breathofdeath_weapon/breathofdeath_weapon.vmdl"
  end
  if slot == 1 and quality and quality == 5 then -- mainhand
    return "models/items/warlock/grimoires_weapon/grimoires_weapon.vmdl"
  end
  if slot == 1 and quality and quality >= 0 then -- mainhand
    return "models/heroes/warlock/warlock_staff.vmdl"
  end
  if slot == 2 and quality and quality >= 6 then -- offhand
    hero.cosmetic_warlock_pet = true
    ArtifactCosmeticUnlocked(slot, 6, hero)
    return "models/items/warlock/mystery_of_the_lost_ores_off_hand/mystery_of_the_lost_ores_off_hand.vmdl"
  end
  if slot == 2 and quality and quality == 6 then -- offhand
    return "models/items/warlock/lantern_of_the_conjuring_sigil/lantern_of_the_conjuring_sigil.vmdl"
  end
  if slot == 2 and quality and quality == 5 then -- offhand
    return "models/items/warlock/grimoires_offhand/grimoires_offhand.vmdl"
  end
  if slot == 2 and quality and quality >= 0 then -- offhand
    --return "models/heroes/elder_titan/elder_titan_totem.vmdl"
  end
  if slot == 3 and quality and quality >= 7 then -- ring
    --hero.tier3prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/pudge/ftp_dendi_crow/ftp_dendi_crow.vmdl", nil)
    return "models/items/warlock/mystery_of_the_lost_ores_arms/mystery_of_the_lost_ores_arms.vmdl"
  end
  if slot == 3 and quality and quality == 6 then -- ring
    return "models/items/warlock/bracers_of_the_conjurer/bracers_of_the_conjurer.vmdl"
  end
  if slot == 3 and quality and quality >= 0 then -- ring
    --return "models/heroes/omniknight/hair.vmdl"
  end
  if slot == 4 and quality and quality >= 7 then -- head
    --hero.tier2prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/doom/crown_of_omoz/crown_of_omoz.vmdl", nil)
    return "models/items/warlock/mystery_of_the_lost_ores_belt/mystery_of_the_lost_ores_belt.vmdl"
  end
  if slot == 4 and quality and quality == 6 then -- head
   return "models/items/warlock/hood_of_the_conjurer/hood_of_the_conjurer.vmdl"
 end
 if slot == 4 and quality and quality >= 0 then -- head
  return "models/heroes/warlock/warlock_cape.vmdl"
end
if slot == 5 and quality and quality >= 7 then -- chest
  --hero.tier1prop = Attachments:AttachProp(hero, "attach_hitloc", "models/particle/warlock_hand_of_glory_grip.vmdl", nil)
  --hero.tier4prop = Attachments:AttachProp(hero, "attach_hitloc", "models/particle/warlock_helborn_grasp_grip.vmdl", nil)
  hero.tier3prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/doom/baphomet_wings/baphomet_wings.vmdl", nil)
  ArtifactCosmeticUnlocked(slot, 7, hero)
  return "models/items/warlock/mystery_of_the_lost_ores_shoulder/mystery_of_the_lost_ores_shoulder.vmdl"
end
if slot == 5 and quality and quality == 6 then -- chest
  return "models/items/warlock/dark_pauldrons_of_the_conjurer/dark_pauldrons_of_the_conjurer.vmdl"
end
if slot == 6 and quality and quality >= 7 then -- boots
  return "models/items/warlock/mystery_of_the_lost_ores_back/mystery_of_the_lost_ores_back.vmdl"
end
if slot == 6 and quality and quality == 6 then -- boots
  --return "models/items/pugna/nether_grandmasters_waistcloth/nether_grandmasters_waistcloth.vmdl"
end
if slot == 6 and quality and quality >= 0 then -- boots
  --return "models/heroes/omniknight/head.vmdl"
end
end
if heroname == "npc_dota_hero_shadow_shaman" then
  if slot == 1 and quality and quality >= 7 then -- mainhand
    return "models/items/shadowshaman/dotapit_s3_wild_tempest_weapon/dotapit_s3_wild_tempest_weapon.vmdl"
  end
  if slot == 1 and quality and quality == 6 then -- mainhand
    return "models/items/shadowshaman/tangki_weapon/tangki_weapon.vmdl"
  end
  if slot == 1 and quality and quality == 5 then -- mainhand
    return "models/items/shadowshaman/eki_bukaw_wand/eki_bukaw_wand.vmdl"
  end
  if slot == 1 and quality and quality >= 0 then -- mainhand
    return "models/heroes/shadowshaman/weapon.vmdl"
  end
  if slot == 2 and quality and quality >= 7 then -- offhand
    return "models/items/shadowshaman/dotapit_s3_wild_tempest_offhand/dotapit_s3_wild_tempest_offhand.vmdl"
  end
  if slot == 2 and quality and quality == 6 then -- offhand
    return "models/items/shadowshaman/tangki_offhand/tangki_offhand.vmdl"
  end
  if slot == 2 and quality and quality == 5 then -- offhand
    return "models/items/shadowshaman/eki_bukaw_wand__offhand/eki_bukaw_wand__offhand.vmdl"
  end
  if slot == 2 and quality and quality >= 0 then -- offhand
    return "models/heroes/shadowshaman/weapon_offhand.vmdl"
  end
  if slot == 3 and quality and quality >= 7 then -- ring
    return "models/items/shadowshaman/dotapit_s3_wild_tempest_arms/dotapit_s3_wild_tempest_arms.vmdl"
  end
  if slot == 3 and quality and quality == 6 then -- ring
    return "models/items/shadowshaman/tangki_arms/tangki_arms.vmdl"
  end
  if slot == 3 and quality and quality >= 0 then -- ring
    --return "models/heroes/omniknight/hair.vmdl"
  end
  if slot == 4 and quality and quality >= 7 then -- head
    --hero.tier2prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/razor/razor_head_bindings/razor_head_bindings.vmdl", nil)
    --return "models/items/warlock/mystery_of_the_lost_ores_belt/mystery_of_the_lost_ores_belt.vmdl"
  end
  if slot == 4 and quality and quality == 6 then -- head
   --return "models/items/shadowshaman/tangki_head/tangki_head.vmdl"
 end
 if slot == 4 and quality and quality >= 0 then -- head
  return "models/heroes/shadowshaman/head.vmdl"
end
if slot == 5 and quality and quality >= 6 then -- chest
  hero.tier3prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/disruptor/stormlands_back/stormlands_back.vmdl", 1.35)
  ArtifactCosmeticUnlocked(slot, 6, hero)
  return "models/items/shadowshaman/dotapit_s3_wild_tempest_belt/dotapit_s3_wild_tempest_belt.vmdl"
end
if slot == 5 and quality and quality == 6 then -- chest
  return "models/items/shadowshaman/tangki_belt/tangki_belt.vmdl"
end
if slot == 6 and quality and quality >= 7 then -- boots
  --return "models/items/warlock/mystery_of_the_lost_ores_back/mystery_of_the_lost_ores_back.vmdl"
end
if slot == 6 and quality and quality == 6 then -- boots
  return "models/items/shadowshaman/tangki_head/tangki_head.vmdl"
end
if slot == 6 and quality and quality >= 0 then -- boots
  --return "models/heroes/omniknight/head.vmdl"
end
end
if heroname == "npc_dota_hero_dark_seer" then
  if slot == 1 and quality and quality >= 7 then -- mainhand
    return "models/items/dark_seer/imperious_tactician_arms/imperious_tactician_arms.vmdl"
  end
  if slot == 1 and quality and quality == 6 then -- mainhand
    return "models/items/dark_seer/master_strategist_arms/master_strategist_arms.vmdl"
  end
  if slot == 1 and quality and quality == 5 then -- mainhand
    return "models/heroes/dark_seer/dark_seer_arm.vmdl"
  end
  if slot == 1 and quality and quality >= 0 then -- mainhand
    --return "models/heroes/shadowshaman/weapon.vmdl"
  end
  if slot == 2 and quality and quality >= 7 then -- offhand
    return "models/items/dark_seer/imperious_tactician_back/imperious_tactician_back.vmdl"
  end
  if slot == 2 and quality and quality == 6 then -- offhand
    return "models/items/dark_seer/master_strategist_back/master_strategist_back.vmdl"
  end
  if slot == 2 and quality and quality == 5 then -- offhand
    return "models/heroes/dark_seer/dark_seer_back.vmdl"
  end
  if slot == 2 and quality and quality >= 0 then -- offhand
    --return "models/heroes/shadowshaman/weapon_offhand.vmdl"
  end
  if slot == 3 and quality and quality >= 7 then -- ring
    --return "models/items/shadowshaman/dotapit_s3_wild_tempest_arms/dotapit_s3_wild_tempest_arms.vmdl"
  end
  if slot == 3 and quality and quality == 6 then -- ring
    --return "models/items/shadowshaman/tangki_arms/tangki_arms.vmdl"
  end
  if slot == 3 and quality and quality >= 0 then -- ring
    --return "models/heroes/omniknight/hair.vmdl"
  end
  if slot == 4 and quality and quality >= 7 then -- head
    return "models/items/dark_seer/imperious_tactician_head/imperious_tactician_head.vmdl"
  end
  if slot == 4 and quality and quality == 6 then -- head
   return "models/items/dark_seer/master_strategist_head/master_strategist_head.vmdl"
 end
 if slot == 4 and quality and quality >= 0 then -- head
  --return "models/heroes/shadowshaman/head.vmdl"
end
if slot == 5 and quality and quality >= 7 then -- chest
  return "models/items/dark_seer/imperious_tactician_shoulder/imperious_tactician_shoulder.vmdl"
end
if slot == 5 and quality and quality == 6 then -- chest
  return "models/items/dark_seer/master_strategist_shoulder/master_strategist_shoulder.vmdl"
end
if slot == 6 and quality and quality >= 7 then -- boots
  return "models/items/dark_seer/imperious_tactician_belt/imperious_tactician_belt.vmdl"
end
if slot == 6 and quality and quality == 6 then -- boots
  return "models/items/dark_seer/master_strategist_belt/master_strategist_belt.vmdl"
end
if slot == 6 and quality and quality >= 0 then -- boots
  --return "models/heroes/omniknight/head.vmdl"
end
end
return nil
end

function COverthrowGameMode:GetAllArtifactItemQuality(hero)
  return GetAllArtifactItemQuality(hero)
end

function GetAllArtifactItemQuality(hero)
  local result = {}
  if hero and hero.inventory then
    local slot = 1
    for slot=1, COverthrowGameMode.mythic_slots do
      if hero.inventory[slot] and hero.inventory[slot][1] and string.len(hero.inventory[slot][1]) > 3 then
        local quality = COverthrowGameMode:GetMythicWeaponQualityNumber(hero.inventory[slot][1])
        result[slot] = quality
        if not result[slot] then
          result[slot] = 0
        end
      else
        result[slot] = 0
      end
    end
  end
  return result
end

function EquipArtifactCosmeticRewards(hero, equip_sets) --sets were disabled cuz ppl wanted to use their own sets
  local debug = false
  if not hero then
    return
  end
  if hero:HasModifier("modifier_catform") or hero:HasModifier("modifier_metamorph_dh") or hero:HasModifier("modifier_shapeshifttravel")  then --shapeshift exceptions, they grab items on shift
    return
  end
  local qualities = GetAllArtifactItemQuality(hero)
  --DeepPrintTable(qualities)
  local slot = 1
  for slot=1, COverthrowGameMode.mythic_slots do
    if (qualities and qualities[slot]) or debug then
      if debug then
        qualities[slot] = 7 --test ancient immortal
      end
      local model = GetCosmeticRewardByHero( hero, slot, qualities[slot] )
      --print("model " .. model)
      if model and equip_sets then
        AddCosmeticToHero( hero, model, slot )
      end
    end
  end
end

function COverthrowGameMode:EquipArtifactCosmeticRewardsGlobal( hero )
  EquipArtifactCosmeticRewards(hero, false)
end

function COverthrowGameMode:RemoveAllCosmeticsGlobal( hero )
  RemoveAllCosmetics(hero)
end

function EquipCosmeticReward(hero)
  --hero.gladiator = x  is the rating
  if hero then
    hero.gladiator = 0
    hero.gladiatorwins = 0
    if hero:HasModifier("modifier_item_item_set_t4_new_4") or hero:HasModifier("modifier_item_item_set_t4_sp_4") or hero:HasModifier("modifier_item_item_set_t4_aa_4") or hero:HasModifier("modifier_item_item_set_t4_str_4") or hero:HasModifier("modifier_item_item_set_t4_agi_4") or hero:HasModifier("modifier_item_item_set_t4_int_4") then
      hero.gladiator = 1800
    end
    local args = {}
    args.id = hero:GetPlayerID()
    args.unit = hero
    FeedEloToGameEvent(nil, args)
  end
end

function FeedEloToGameEvent(event, args)     --also rewards for end of season
--print("event arrived " .. args['name'])
--print("event arrived " .. args['rating'])
if not IsServer() then
  return
end

local player
local rating
local wins

if args and args.id and args.unit then
  player = args.id
  rating = args.unit.gladiator
  wins = args.unit.gladiatorwins
else
  player = args['name']
  rating = tonumber(args['rating'])
  wins = tonumber(args['wins'])
end


local all = HeroList:GetAllHeroes()
--print("found heroes for gold add")
--print(#all)
local hero
for i=1, #all do
  hero = all[i]
  if hero ~= nil and rating ~= nil and wins ~= nil then
   local name = hero:GetPlayerID()
   --print(name)
   --print(player)
   if name == player then
    hero.gladiator = rating
    hero.gladiatorwins = wins
    local heroName = hero:GetUnitName()
    --add fx
    print("fct add cosm2")
    if heroName == "npc_dota_hero_sniper" then
     if rating > 2000 and not hero.tier3 then
      hero.tier3 = true
      hero.tier3prop = Attachments:AttachProp(hero, "attach_attack1", "models/items/sniper/dragons_breath/dragons_breath.vmdl", nil)
    end
    if rating > 1600 and not hero.tier1 then
      hero.tier1 = true
      hero.tier1prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/dragon_knight/oblivion_blazer_head/oblivion_blazer_head.vmdl", nil)
    end
    if rating > 1750 and not hero.tier2 then
      hero.tier2 = true
      hero.tier2prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/dragon_knight/armor_of_the_drake/armor_of_the_drake.vmdl", nil)
    end
  end

  if heroName == "npc_dota_hero_drow_ranger" then
   if rating > 2000 and not hero.tier3 then
    hero.tier3 = true
    hero.tier3prop = Attachments:AttachProp(hero, "bow_mid", "models/items/drow/dotapit_s3_frostfang_bow/dotapit_s3_frostfang_bow.vmdl", 1.9)
  end
  if rating > 1600 and not hero.tier1 then
    hero.tier1 = true
    all[i].ArenaControl:GetAbilityByIndex(0):ApplyDataDrivenModifier(all[i].ArenaControl, all[i].ArenaControl.controlowner, "modifier_gladiator_reward_drow_4", nil)
  end
  if rating > 1750 and not hero.tier2 then
    hero.tier2 = true
    hero.tier2prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/abaddon/haze_whisperer_head/haze_whisperer_head.vmdl", nil)
  end
end

if heroName == "npc_dota_hero_axe" then
 if rating > 2000 and not hero.tier3 then
  hero.tier3 = true
  --local weapon = Attachments:Attachment_HideCosmetic(hero, "attach_weapon")
  --weapon:RemoveSelf()
  hero.tier3prop = Attachments:AttachProp(hero, "attach_weapon", "models/items/faceless_void/battlefury/battlefury.vmdl", nil)
end
if rating > 1600 and not hero.tier1 then
  hero.tier1 = true
  hero.tier1prop = Attachments:AttachProp(hero, "attach_mouth", "models/items/clinkz/bone_fletcher_head_helmet/bone_fletcher_head_helmet.vmdl", nil)
end
if rating > 1750 and not hero.tier2 then
  hero.tier2 = true
  hero.tier2prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/lone_druid/dark_wood_shoulder/dark_wood_shoulder.vmdl", nil)
end
end

if heroName == "npc_dota_hero_lina" then
 if rating > 2000 and not hero.tier3 then
  hero.tier3 = true
  hero.tier3prop = Attachments:AttachProp(hero, "attach_hitloc", "models/heroes/shadow_fiend/arcana_wings.vmdl", nil)
end
if rating > 1600 and not hero.tier1 then
  hero.tier1 = true
  hero.tier1prop = Attachments:AttachProp(hero, "attach_head", "models/items/doom/ancient_beast_shoulders/ancient_beast_shoulders.vmdl", nil)
end
if rating > 1750 and not hero.tier2 then
  hero.tier2 = true
  hero.tier2prop = Attachments:AttachProp(hero, "attach_attack1", "models/items/doom/weapon_eyeoffetitzu/weapon_eyeoffetitzu.vmdl", 0.4)
end
end

if heroName == "npc_dota_hero_crystal_maiden" then
 if rating > 2000 and not hero.tier3 then
  hero.tier3 = true
  hero.tier3prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/storm_spirit/raikage_ares_arms/raikage_ares_arms.vmdl", nil)
end
if rating > 1600 and not hero.tier1 then
  hero.tier1 = true
  hero.tier1prop = Attachments:AttachProp(hero, "attach_attack2", "models/items/crystal_maiden/ward_staff/ward_staff_crystal.vmdl", nil)
end
if rating > 1750 and not hero.tier2 then
  hero.tier2 = true
  hero.tier2prop = Attachments:AttachProp(hero, "attach_head", "models/items/siren/iceborn_head/iceborn_head.vmdl", nil)
end
end

if heroName == "npc_dota_hero_omniknight" then
 if rating > 2000 and not hero.tier3 then
  hero.tier3 = true
  hero.tier3prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/puck/reminiscence_wings/reminiscence_wings.vmdl", nil)
end
if rating > 1600 and not hero.tier1 then
  hero.tier1 = true
  hero.tier1prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/phantom_lancer/ancient_gods_shoulderpad/ancient_gods_shoulderpad.vmdl", nil)
end
if rating > 1750 and not hero.tier2 then
  hero.tier2 = true
  hero.tier2prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/phantom_lancer/ancient_gods_shoulder/ancient_gods_shoulder.vmdl", nil)
  all[i].ArenaControl:GetAbilityByIndex(0):ApplyDataDrivenModifier(all[i].ArenaControl, all[i].ArenaControl.controlowner, "modifier_gladiator_reward_omni_2", nil)
end
end

if heroName == "npc_dota_hero_phantom_assassin" then
 if rating > 2000 and not hero.tier3 then
  hero.tier3 = true
  hero.tier3prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/spectre/phantasmal_disruptions_shoulder/phantasmal_disruptions_shoulder.vmdl", nil)
end
if rating > 1600 and not hero.tier1 then
  --hero.tier1 = true
  --Attachments:AttachProp(hero, "attach_hitloc", "models/items/phantom_lancer/ancient_gods_shoulderpad/ancient_gods_shoulderpad.vmdl", nil)
end
if rating > 1750 and not hero.tier2 then
  hero.tier2 = true
  hero.tier2prop = Attachments:AttachProp(hero, "attach_attack2", "models/items/abaddon/weapon_ravelord/weapon_ravelord.vmdl", 0.6)
end
end

if heroName == "npc_dota_hero_legion_commander" then
 if rating > 2000 and not hero.tier3 then
  hero.tier3 = true
  hero.tier3prop = Attachments:AttachProp(hero, "attach_attack1", "models/items/omniknight/clergy_war_hammer/clergy_war_hammer.vmdl", nil)
end
if rating > 1700 and not hero.tier1 then
  --hero.tier1 = true
  --Attachments:AttachProp(hero, "attach_hitloc", "models/items/phantom_lancer/ancient_gods_shoulderpad/ancient_gods_shoulderpad.vmdl", nil)
end
if rating > 1900 and not hero.tier2 then
  --hero.tier2 = true
  --Attachments:AttachProp(hero, "attach_hitloc", "models/items/phantom_lancer/ancient_gods_shoulder/ancient_gods_shoulder.vmdl", nil)
  --all[i].ArenaControl:GetAbilityByIndex(0):ApplyDataDrivenModifier(all[i].ArenaControl, all[i].ArenaControl.controlowner, "modifier_gladiator_reward_omni_2", nil)
end
end

if heroName == "npc_dota_hero_silencer" then
 if rating > 2000 and not hero.tier3 then
  hero.tier3 = true
  hero.tier3prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/legion_commander/athenas_flame_back/athenas_flame_back.vmdl", nil)
end
if rating > 1600 and not hero.tier1 then
  hero.tier1 = true
  hero.tier1prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/legion_commander/athenas_flame_head/athenas_flame_head.vmdl", nil)
end
if rating > 1750 and not hero.tier2 then
  hero.tier2 = true
  hero.tier2prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/queenofpain/darkangel_shoulder/darkangel_shoulder.vmdl", nil)
  all[i].ArenaControl:GetAbilityByIndex(0):ApplyDataDrivenModifier(all[i].ArenaControl, all[i].ArenaControl.controlowner, "modifier_gladiator_reward_omni_2", nil)
end
end

if heroName == "npc_dota_hero_furion" then
 if rating > 2000 and not hero.tier3 then
  hero.tier3 = true
  hero.tier3prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/skywrath_mage/manticore_of_the_eyrie_wings/manticore_of_the_eyrie_wings.vmdl", nil)
end
if rating > 1600 and not hero.tier1 then
  hero.tier1 = true
  hero.tier1prop = Attachments:AttachProp(hero, "attach_hitloc", "models/heroes/treant_protector/treant_crow.vmdl", nil)
end
if rating > 1750 and not hero.tier2 then
  hero.tier2 = true
  hero.tier2prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/beastmaster/red_talon_head/red_talon_head.vmdl", nil)
end
end

if heroName == "npc_dota_hero_shadow_shaman" then
 if rating > 2000 and not hero.tier3 then
  hero.tier3 = true
  hero.tier3prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/disruptor/stormlands_back/stormlands_back.vmdl", nil)
end
if rating > 1600 and not hero.tier1 then
  --hero.tier1 = true
  --Attachments:AttachProp(hero, "attach_hitloc", "models/items/legion_commander/athenas_flame_head/athenas_flame_head.vmdl", nil)
end
if rating > 1750 and not hero.tier2 then
  hero.tier2 = true
  hero.tier2prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/razor/razor_head_bindings/razor_head_bindings.vmdl", nil)
end
end

if heroName == "npc_dota_hero_windrunner" then
 if rating > 2000 and not hero.tier3 then
  hero.tier3 = true
  hero.tier3prop = Attachments:AttachProp(hero, "attach_attack1", "models/items/medusa/emerald_ocean_weapon/emerald_ocean_weapon.vmdl", nil)
end
if rating > 1700 and not hero.tier1 then
  --hero.tier1 = true
  --Attachments:AttachProp(hero, "attach_hitloc", "models/items/legion_commander/athenas_flame_head/athenas_flame_head.vmdl", nil)
end
if rating > 1900 and not hero.tier2 then
  --hero.tier2 = true
  --Attachments:AttachProp(hero, "attach_hitloc", "models/items/razor/razor_head_bindings/razor_head_bindings.vmdl", nil)
end
end

if heroName == "npc_dota_hero_riki" then
 if rating > 2100 and not hero.tier3 then
  --hero.tier3 = true
  --Attachments:AttachProp(hero, "attach_attack1", "models/heroes/disruptor/weapon.vmdl", nil)
  --Attachments:AttachProp(hero, "attach_attack2", "models/heroes/disruptor/weapon.vmdl", nil)
end
if rating > 1700 and not hero.tier1 then
  --hero.tier1 = true
  --Attachments:AttachProp(hero, "attach_hitloc", "models/items/legion_commander/athenas_flame_head/athenas_flame_head.vmdl", nil)
end
if rating > 1900 and not hero.tier2 then
  --hero.tier2 = true
  --Attachments:AttachProp(hero, "attach_hitloc", "models/items/razor/razor_head_bindings/razor_head_bindings.vmdl", nil)
end
end

if heroName == "npc_dota_hero_beastmaster" then
 if rating > 2000 and not hero.tier3 then
  hero.tier3 = true
  hero.tier3prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/sniper/wolf_hat_dark/wolf_hat_dark.vmdl", nil)
end
if rating > 1600 and not hero.tier1 then
  hero.tier1 = true
  hero.tier1prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/lycan/hunter_kings_shoulder/hunter_kings_shoulder.vmdl", nil)
end
if rating > 1750 and not hero.tier2 then
  hero.tier2 = true
  hero.tier2prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/furion/shoulders_beaver_1.vmdl", nil)
end
end

if heroName == "npc_dota_hero_dragon_knight" then
 if rating > 2000 and not hero.tier3 then
  hero.tier3 = true
  hero.tier3prop = Attachments:AttachProp(hero, "attach_attack2", "models/items/dragon_knight/fireborn_shield/fireborn_shield.vmdl", nil)
end
if rating > 1700 and not hero.tier1 then
  --hero.tier1 = true
  --Attachments:AttachProp(hero, "attach_hitloc", "models/items/legion_commander/athenas_flame_head/athenas_flame_head.vmdl", nil)
end
if rating > 1900 and not hero.tier2 then
  --hero.tier2 = true
  --Attachments:AttachProp(hero, "attach_hitloc", "models/items/razor/razor_head_bindings/razor_head_bindings.vmdl", nil)
end
end

if heroName == "npc_dota_hero_witch_doctor" then
 if rating > 2000 and not hero.tier3 then
  hero.tier3 = true
  hero.tier3prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/pudge/ftp_dendi_crow/ftp_dendi_crow.vmdl", nil)
end
if rating > 1700 and not hero.tier1 then
  --hero.tier1 = true
  --Attachments:AttachProp(hero, "attach_hitloc", "models/items/legion_commander/athenas_flame_head/athenas_flame_head.vmdl", nil)
end
if rating > 1750 and not hero.tier2 then
  hero.tier2 = true
  hero.tier2prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/shadowshaman/true_crow_vision/true_crow_vision.vmdl", nil)
end
end

if heroName == "npc_dota_hero_invoker" then
 if rating > 2200 and not hero.tier3 then
  hero.tier3 = true
  hero.tier3prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/skywrath_mage/blessing_of_the_crested_dawn_back/blessing_of_the_crested_dawn_back.vmdl", nil)
end
if rating > 1700 and not hero.tier1 then
  --hero.tier1 = true
  --Attachments:AttachProp(hero, "attach_hitloc", "models/items/legion_commander/athenas_flame_head/athenas_flame_head.vmdl", nil)
end
if rating > 2000 and not hero.tier2 then
  hero.tier2 = true
  hero.tier2prop = Attachments:AttachProp(hero, "attach_hitloc", "models/heroes/vengeful/vengeful_weapon.vmdl", nil)
end
end

if heroName == "npc_dota_hero_sven" then
 if rating > 2200 and not hero.tier3 then
  hero.tier3 = true
  hero.tier3prop = Attachments:AttachProp(hero, "attach_weapon", "models/items/sven/dotapit3_sven_weapon/dotapit3_sven_weapon.vmdl", nil)
end
if rating > 1750 and not hero.tier1 then
  hero.tier1 = true
  hero.tier1prop = Attachments:AttachProp(hero, "attach_head", "models/items/sven/dotapit3_sven_head/dotapit3_sven_head.vmdl", nil)
end
if rating > 2000 and not hero.tier2 then
  hero.tier2 = true
  hero.tier2prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/sven/dotapit3_sven_shoulder/dotapit3_sven_shoulder.vmdl", nil)
end
end

if heroName == "npc_dota_hero_skeleton_king" then
 if rating > 2200 and not hero.tier3 then
  hero.tier3 = true
  hero.tier3prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/obsidian_destroyer/obsidianguard_back/obsidianguard_back.vmdl", nil)
end
if rating > 1750 and not hero.tier1 then
  hero.tier1 = true
  hero.tier1prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/obsidian_destroyer/herald_of_measureless_ruin_head/herald_of_measureless_ruin_head.vmdl", nil)
end
if rating > 1500 and not hero.tier2 then
  hero.tier2 = true
  hero.tier2prop = Attachments:AttachProp(hero, "attach_attack2", "models/items/wraith_king/lord_of_the_hunt_weapon/lord_of_the_hunt_weapon.vmdl", nil)
end
end

if heroName == "npc_dota_hero_warlock" then
 if rating > 2200 and not hero.tier3 then
  hero.tier3 = true
  hero.tier3prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/doom/baphomet_wings/baphomet_wings.vmdl", nil)
end
if rating > 1750 and not hero.tier1 then
  hero.tier1 = true
  hero.tier1prop = Attachments:AttachProp(hero, "attach_hitloc", "models/particle/warlock_hand_of_glory_grip.vmdl", nil)
  hero.tier4prop = Attachments:AttachProp(hero, "attach_hitloc", "models/particle/warlock_helborn_grasp_grip.vmdl", nil)
end
if rating > 1500 and not hero.tier2 then
  hero.tier2 = true
  hero.tier2prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/doom/crown_of_omoz/crown_of_omoz.vmdl", nil)
end
end

if heroName == "npc_dota_hero_bounty_hunter" then
  if rating > 2200 and not hero.tier3 then
    hero.tier3 = true
    hero.tier3prop = Attachments:AttachProp(hero, "attach_attack2", "models/items/blood_seeker/thirst_of_eztzhok_weapon/thirst_of_eztzhok.vmdl", nil)
    hero.tier4prop = Attachments:AttachProp(hero, "attach_attack1", "models/items/blood_seeker/thirst_of_eztzhok_weapon/thirst_of_eztzhok.vmdl", nil)
  end
  if rating > 1750 and not hero.tier1 then
    hero.tier1 = true
    hero.tier1prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/blood_seeker/necklace_of_scarlet_claws/necklace_of_scarlet_claws.vmdl", nil)
  end
  if rating > 1500 and not hero.tier2 then
    hero.tier2 = true
    hero.tier2prop = Attachments:AttachProp(hero, "attach_head", "models/items/blood_seeker/hunt_of_the_weeping_beast_head/hunt_of_the_weeping_beast_head.vmdl", nil)
  end
end

--cosmetics gladiator, old stuff
if false and all[i].ArenaControl ~= nil and all[i].gladiator then 
 local name = all[i]:GetUnitName()

 if name == "npc_dota_hero_phantom_assassin2" then
  --if all[i].gladiator >= 2 then
   all[i].ArenaControl:GetAbilityByIndex(0):ApplyDataDrivenModifier(all[i].ArenaControl, all[i].ArenaControl.controlowner, "modifier_gladiator_reward_pa_2", nil)
   --end
   --if all[i].gladiator >= 4 then
     all[i].ArenaControl:GetAbilityByIndex(0):ApplyDataDrivenModifier(all[i].ArenaControl, all[i].ArenaControl.controlowner, "modifier_gladiator_reward_pa_4", nil)
     --end
   end

   if name == "npc_dota_hero_lina2" then
    --all[i].ArenaControl:GetAbilityByIndex(0):ApplyDataDrivenModifier(all[i].ArenaControl, all[i].ArenaControl.controlowner, "modifier_gladiator_reward_lina_1", nil)
    all[i].ArenaControl:GetAbilityByIndex(0):ApplyDataDrivenModifier(all[i].ArenaControl, all[i].ArenaControl.controlowner, "modifier_gladiator_reward_lina_2", nil)
    --all[i].ArenaControl:GetAbilityByIndex(0):ApplyDataDrivenModifier(all[i].ArenaControl, all[i].ArenaControl.controlowner, "modifier_gladiator_reward_lina_3", nil)
    all[i].ArenaControl:GetAbilityByIndex(0):ApplyDataDrivenModifier(all[i].ArenaControl, all[i].ArenaControl.controlowner, "modifier_gladiator_reward_lina_4", nil)
  end

  if name == "npc_dota_hero_omniknight" then
    --all[i].ArenaControl:GetAbilityByIndex(0):ApplyDataDrivenModifier(all[i].ArenaControl, all[i].ArenaControl.controlowner, "modifier_gladiator_reward_lina_1", nil)
    --all[i].ArenaControl:GetAbilityByIndex(0):ApplyDataDrivenModifier(all[i].ArenaControl, all[i].ArenaControl.controlowner, "modifier_gladiator_reward_omni_2", nil)
    --all[i].ArenaControl:GetAbilityByIndex(0):ApplyDataDrivenModifier(all[i].ArenaControl, all[i].ArenaControl.controlowner, "modifier_gladiator_reward_lina_3", nil)
    --all[i].ArenaControl:GetAbilityByIndex(0):ApplyDataDrivenModifier(all[i].ArenaControl, all[i].ArenaControl.controlowner, "modifier_gladiator_reward_omni_4", nil)
  end

  if name == "npc_dota_hero_drow_ranger" then
    --all[i].ArenaControl:GetAbilityByIndex(0):ApplyDataDrivenModifier(all[i].ArenaControl, all[i].ArenaControl.controlowner, "modifier_gladiator_reward_lina_1", nil)
    ----all[i].ArenaControl:GetAbilityByIndex(0):ApplyDataDrivenModifier(all[i].ArenaControl, all[i].ArenaControl.controlowner, "modifier_gladiator_reward_drow_2", nil)
    --all[i].ArenaControl:GetAbilityByIndex(0):ApplyDataDrivenModifier(all[i].ArenaControl, all[i].ArenaControl.controlowner, "modifier_gladiator_reward_lina_3", nil)
    ----all[i].ArenaControl:GetAbilityByIndex(0):ApplyDataDrivenModifier(all[i].ArenaControl, all[i].ArenaControl.controlowner, "modifier_gladiator_reward_drow_4", nil)
  end
end


end
end			
end
end

function ShowSeasonRewards(hero)     --also rewards for end of season
--print("event arrived " .. args['name'])
--print("event arrived " .. args['rating'])
if not IsServer() or not hero then
  return
end

local season2 = hero.season2
local season2_2vs2 = hero.season2_2vs2

local heroName = hero:GetUnitName()
--add fx

if heroName == "npc_dota_hero_bounty_hunter" then
  if season2 and season2 == 1 and not hero.tier3 then
   hero.tier3 = true
   hero.tier3prop = Attachments:AttachProp(hero, "attach_attack2", "models/items/blood_seeker/thirst_of_eztzhok_weapon/thirst_of_eztzhok.vmdl", nil)
   hero.tier4prop = Attachments:AttachProp(hero, "attach_attack1", "models/items/blood_seeker/thirst_of_eztzhok_weapon/thirst_of_eztzhok.vmdl", nil)
 end
 if season2 and season2 == 1 and not hero.tier1 then
   hero.tier1 = true
   hero.tier1prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/blood_seeker/necklace_of_scarlet_claws/necklace_of_scarlet_claws.vmdl", nil)
 end
 if season2 and season2 == 1 and not hero.tier2 then
   hero.tier2 = true
   hero.tier2prop = Attachments:AttachProp(hero, "attach_head", "models/items/blood_seeker/hunt_of_the_weeping_beast_head/hunt_of_the_weeping_beast_head.vmdl", nil)
 end
end
if season2_2vs2 and season2_2vs2 == 1 then
  if heroName == "npc_dota_hero_shadow_shaman" then
   --hero.ArenaControl:GetAbilityByIndex(0):ApplyDataDrivenModifier(hero.ArenaControl, hero.ArenaControl.controlowner, "modifier_gladiator_reward_ele_1", nil)
 end
end
if heroName == "npc_dota_hero_phantom_lancer" then
  if not hero.tier1 then
   hero.tier1 = true
   hero.tier1prop = Attachments:AttachProp(hero, "attach_head", "models/items/legion_commander/valkyrie_head/valkyrie_head.vmdl", nil)
 end
 if not hero.tier2 then
   hero.tier2 = true
   hero.tier2prop = Attachments:AttachProp(hero, "attach_body", "models/items/legion_commander/valkyrie_shoulder/valkyrie_shoulder.vmdl", nil)
 end
 if not hero.tier3 then
   hero.tier3 = true
   hero.tier3prop = Attachments:AttachProp(hero, "attach_attack1", "models/items/omniknight/grey_night_weapon/grey_night_weapon.vmdl", nil)
 end
 if not hero.tier4 then
   hero.tier4 = true
   hero.tier4prop = Attachments:AttachProp(hero, "attach_attack2", "models/items/dragon_knight/oblivion_blazer_offhand/oblivion_blazer_offhand.vmdl", nil)
 end
end
end

function ShowSeasonRewardsOfflineAll()
	local all = HeroList:GetAllHeroes()
	local hero
	for i=1, #all do
		ShowSeasonRewardsOffline(all[i])
	end
end

function ShowSeasonRewardsOffline(hero) -- all season rewards and prot paladin
	if not IsServer() or not hero then
		return
	end

	local playerid = hero:GetPlayerID()
	local steamid = PlayerResource:GetSteamAccountID(playerid)

	local top20_2v2 = false
	if steamid == 82551448 or steamid == 127007645 or steamid == 67344024 or steamid == 335461272 or steamid == 76384373 or steamid == 105231444 or steamid == 318146678 or steamid == 10138672 or steamid == 183702509 or steamid == 80747011 then
		top20_2v2 = true
	end
	if steamid == 95413522 or steamid == 106077797 or steamid == 105129571 or steamid == 109439812 or steamid == 93297684 or steamid == 85223442 or steamid == 60773145 or steamid == 314570475 or steamid == 77798428 or steamid == 48039172 then
		top20_2v2 = true
	end

	local top20_3v3 = false
	if steamid == 318146678 or steamid == 95413522 or steamid == 118156267 or steamid == 88921041 or steamid == 127007645 or steamid == 82551448 or steamid == 76384373 or steamid == 195941981 or steamid == 48515564 or steamid == 26946058 then
		top20_3v3 = true
	end
	if steamid == 34911825 or steamid == 314570475 or steamid == 105129571 or steamid == 67344024 or steamid == 108263788 or steamid == 90764615 or steamid == 87003062 or steamid == 10138672 or steamid == 113784584 or steamid == 75702485 then
		top20_3v3 = true
	end

	local top5 = false
	if steamid == 318146678 or steamid == 95413522 or steamid == 118156267 or steamid == 88921041 or steamid == 127007645 or steamid == 82551448 or steamid == 127007645 or steamid == 67344024 or steamid == 335461272 or steamid == 76384373 then
		top5 = true
	end

	local communityguy = false
	if steamid == 95413522 or steamid == 80747011 or steamid == 118156267 or steamid == 250547043 or steamid == 31621388 or steamid == 104882008 or steamid == 95413522 or steamid == 95413522 or steamid == 95413522 or steamid == 95413522 then
		communityguy = true
	end

	--season 3
	local top20_3v3_s3 = false
	if steamid == 31621388 or steamid == 95413522 or steamid == 105129571 or steamid == 104882008 or steamid == 46041755 or steamid == 109749971 or steamid == 72800586 or steamid == 43911351 or steamid == 94378919 or steamid == 27931017 or steamid == 121086100 then
		top20_3v3_s3 = true
	end
	if steamid == 120920002 or steamid == 75702485 or steamid == 240722162 or steamid == 51811635 or steamid == 120446874 or steamid == 38158732 or steamid == 128642941 or steamid == 53285677 or steamid == 127078573 or steamid == 195941981 then
		top20_3v3_s3 = true
	end

	local top20_2v2_s3 = false
	if steamid == 105129571 or steamid == 104882008 or steamid == 301059838 or steamid == 46041755 or steamid == 128642941 or steamid == 27931017 or steamid == 316660681 or steamid == 31621388 or steamid == 55451092 or steamid == 33154838 then
		top20_2v2_s3 = true
	end
	if steamid == 162503758 or steamid == 67821679 or steamid == 204752697 or steamid == 131887766 or steamid == 95413522 or steamid == 118984892 or steamid == 101347856 or steamid == 117000156 or steamid == 335014170 or steamid == 88454032 then
		top20_2v2_s3 = true
	end

	--season 4
	local top20_3v3_s4 = false
	if steamid == 95413522 or steamid == 0 or steamid == 0 or steamid == 0 or steamid == 0 or steamid == 0 or steamid == 0 or steamid == 0 or steamid == 0 or steamid == 0 or steamid == 0 then
		top20_3v3_s4 = true
	end
	if steamid == 0 or steamid == 0 or steamid == 0 or steamid == 0 or steamid == 0 or steamid == 0 or steamid == 0 or steamid == 0 or steamid == 0 or steamid == 0 then
		top20_3v3_s4 = true
	end

	local top20_2v2_s4 = false
	if steamid == 95413522 or steamid == 0 or steamid == 0 or steamid == 0 or steamid == 0 or steamid == 0 or steamid == 0 or steamid == 0 or steamid == 0 or steamid == 0 then
		top20_2v2_s4 = true
	end
	if steamid == 0 or steamid == 0 or steamid == 0 or steamid == 0 or steamid == 0 or steamid == 0 or steamid == 0 or steamid == 0 or steamid == 0 or steamid == 0 then
		top20_2v2_s4 = true
	end


	local heroName = hero:GetUnitName()
	
	if heroName == "npc_dota_hero_bounty_hunter" and top20_3v3 then
		if not hero.tier3 then
			hero.tier3 = true
			hero.tier3prop = Attachments:AttachProp(hero, "attach_attack2", "models/items/blood_seeker/thirst_of_eztzhok_weapon/thirst_of_eztzhok.vmdl", nil)
			hero.tier4prop = Attachments:AttachProp(hero, "attach_attack1", "models/items/blood_seeker/thirst_of_eztzhok_weapon/thirst_of_eztzhok.vmdl", nil)
		end
		if not hero.tier1 then
			hero.tier1 = true
			hero.tier1prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/blood_seeker/necklace_of_scarlet_claws/necklace_of_scarlet_claws.vmdl", nil)
		end
		if not hero.tier2 then
			hero.tier2 = true
			hero.tier2prop = Attachments:AttachProp(hero, "attach_head", "models/items/blood_seeker/hunt_of_the_weeping_beast_head/hunt_of_the_weeping_beast_head.vmdl", nil)
		end
	end
	if heroName == "npc_dota_hero_bloodseeker" and communityguy then
		if not hero.tier3 then
			hero.tier3 = true
			hero.tier3prop = Attachments:AttachProp(hero, "attach_attack2", "models/items/chaos_knight/rising_chaos_shield/rising_chaos_shield.vmdl", nil)
		end
		if not hero.tier1 then
			hero.tier1 = true
			hero.tier1prop = Attachments:AttachProp(hero, "attach_hitloc", "models/heroes/chaos_knight/chaos_knight_horse_head.vmdl", nil)
		end
		if not hero.tier2 then
			hero.tier2 = true
			hero.tier2prop = Attachments:AttachProp(hero, "attach_attack1", "models/items/chaos_knight/rising_chaos_shield/rising_chaos_shield.vmdl", nil)
		end
	end
	--season 3
	if heroName == "npc_dota_hero_pudge" and top20_2v2_s3 then
		if not hero.tier3 then
			hero.tier3 = true
			hero.tier3prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/chaos_knight/rising_chaos_spaulders/rising_chaos_spaulders.vmdl", nil)
		end
		if not hero.tier1 then
			hero.tier1 = true
			hero.tier1prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/chaos_knight/baleful_reign_head/baleful_reign_head.vmdl", nil)
		end
		if not hero.tier2 then
			hero.tier2 = true
			hero.tier2prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/chaos_knight/chaos_legion_shield/chaos_legion_shield.vmdl", nil)
		end
	end
	print("load offline rewards")
	if heroName == "npc_dota_hero_legion_commander" and top20_3v3_s3 then
		print("load commander rewards")
		if not hero.tier4 then
			print("load shoulder rewards")
			hero.tier4 = true
			hero.tier4prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/sven/glittering_hawk_shoulder/glittering_hawk_shoulder.vmdl", nil)
		end
		if not hero.tier1 then
			hero.tier1 = true
			hero.tier1prop = Attachments:AttachProp(hero, "attach_hitloc", "models/items/skywrath_mage/guiding_lights_back/guiding_lights_back.vmdl", nil)
		end
		if not hero.tier2 then
			hero.tier2 = true
			hero.tier2prop = Attachments:AttachProp(hero, "attach_eyeL", "models/items/skywrath_mage/dotapit_s3_avillivas_countenance/dotapit_s3_avillivas_countenance.vmdl", nil)
		end
	end
	if top5 then
		if heroName == "npc_dota_hero_shadow_shaman" then
			hero:GetAbilityByIndex(1):ApplyDataDrivenModifier(hero, hero, "modifier_gladiator_reward_ele_1", nil)
		end
	end
	if top20_2v2 then
		hero.season2_2vs2 = 1
	end
	if top20_2v2_s3 then
		hero.season3_2vs2 = 1
	end
	if top20_3v3_s3 then
		hero.season3_3vs3 = 1
	end
	if top20_3v3_s4 then
		hero.season4_3vs3 = 1
	end
	if top20_2v2_s4 then
		hero.season4_2vs2 = 1
	end
end


-- Game Mode Vote Test, Events arrive here

function GameModeVote(event, args)
	print("event arrived " .. args['player_id'])
	print("event arrived " .. args['mode_id'])

	local player = args['player_id']
	local value = args['mode_id']
	if value < 2 then
		GameWinCondition[player] = value
	end
	if value == 2 then
		self.FirstRoundQuickStartVote[player] = value
	end
end

function WeaponChoice(event, args)
	print("event arrived " .. args['player_id'])
	print("event arrived " .. args['weapon'])

	local playerid = args['player_id']
	local weapon = args['weapon']
	
	local all = HeroList:GetAllHeroes()
	local hero
	for i=1, #all do
		hero = all[i]
		playerid_2 = hero:GetPlayerOwnerID()
		if playerid == playerid_2 then
			if weapon == 1 then
				hero.ArenaControl:GetAbilityByIndex(0):ApplyDataDrivenModifier(hero, hero, "modifier_weapon_hammer", nil)
			end
		end
	end
end

-- Arena Control Start Function

function ArenaStart(event)
	if COverthrowGameMode.junglemode then
		return
	end
	local caster = event.caster.controlowner
	local playerid = caster:GetPlayerOwnerID()
	print("playerid = " .. playerid)
	GameRules:GetGameModeEntity().COverthrowGameMode.FirstRoundQuickStartVote[playerid] = 2
	event.caster:SetRenderColor(0, 255, 0)
	event.caster:SetForwardVector(Vector(0,-100,0))
	event.caster.child:SetRenderColor(0, 255, 0)
	event.caster.child:SetForwardVector(Vector(0,-100,0))
end

function WaterfallImpact(pos)
	--print("water impact called")
	local caster = CreateUnitByName("dummy_aoe_unit", pos, true, nil, nil, 1)
	local particle = ParticleManager:CreateParticle("particles/econ/items/kunkka/divine_anchor/hero_kunkka_dafx_skills/kunkka_spell_torrent_splash_fxset.vpcf", PATTACH_POINT_FOLLOW, caster)
	local ability = caster:GetAbilityByIndex(0)
	EmitSoundOn("DOTA_Item.ForceStaff.Activate", caster)
	local enemies = FindUnitsInRadius( 1, pos, caster, 325, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	--print(#enemies)
	if #enemies > 0 then
		for _,enemy in pairs(enemies) do
			if enemy ~= nil then
				if ((enemy:GetUnitLabel()=="hero") or (enemy:GetUnitLabel()=="pet")) then
					local dmgtable = {}
					dmgtable.Duration = 3
					ability:ApplyDataDrivenModifier(caster, enemy, "modifier_stunned", dmgtable)
					ability:ApplyDataDrivenModifier(caster, enemy, "modifier_phased", dmgtable)
					--knockback
					local vec = enemy:GetAbsOrigin()-pos
					vec = vec:Normalized()
					--enemy:ApplyAbsVelocityImpulse(vec)
					local npc = enemy
					Physics:Unit(npc)
					npc:PreventDI(false)
					npc:SetAutoUnstuck(true)
					npc:SetNavCollisionType(PHYSICS_NAV_BOUNCE)
					npc:FollowNavMesh(true)
					npc:SetPhysicsVelocityMax(1500)
					npc:SetPhysicsFriction(0.05)
					npc:Hibernate(false)
					npc:SetGroundBehavior(PHYSICS_GROUND_LOCK)
					npc:SetPhysicsVelocity(800 * vec)
				end
			end
		end
	end
	Timers:CreateTimer(3.0,function() 
    UTIL_Remove(caster)
  end)
end

---------------------------------------------------------------------------
-- Get the color associated with a given teamID
---------------------------------------------------------------------------
function COverthrowGameMode:ColorForTeam( teamID )
	local color = self.m_TeamColors[ teamID ]
	if color == nil then
		color = { 255, 255, 255 } -- default to white
	end
	return color
end

---------------------------------------------------------------------------
---------------------------------------------------------------------------
function COverthrowGameMode:EndGame( victoryTeam )
	self.Winner = victoryTeam
	GameRules:SetGameWinner( victoryTeam )
end


---------------------------------------------------------------------------
-- Put a label over a player's hero so people know who is on what team
---------------------------------------------------------------------------
function COverthrowGameMode:UpdatePlayerColor( nPlayerID )
	if not PlayerResource:HasSelectedHero( nPlayerID ) then
		return
	end

	local hero = PlayerResource:GetSelectedHeroEntity( nPlayerID )
	if hero == nil then
		return
	end

	local teamID = PlayerResource:GetTeam( nPlayerID )
	local color = self:ColorForTeam( teamID )
	PlayerResource:SetCustomPlayerColor( nPlayerID, color[1], color[2], color[3] )
end


---------------------------------------------------------------------------
-- Simple scoreboard using debug text
---------------------------------------------------------------------------
function COverthrowGameMode:UpdateScoreboard()
	if true then --GetMapName() == "beginner_hero_level_1_to_9" or GetMapName() == "expert_hero_level_10_or_higher" then
		local all = HeroList:GetAllHeroes()
		local hero
		local lives = 0
		for i=1, #all do
			hero = all[i]
			if hero ~= nil then
				lives = lives + hero:GetModifierStackCount("modifier_pvelives", nil)
			end			
		end
		CustomNetTables:SetTableValue( "game_state", "victory_condition", { kills_to_win = lives } );
		return
	end
	local sortedTeams = {}
	for _, team in pairs( self.m_GatheredShuffledTeams ) do
		table.insert( sortedTeams, { teamID = team, teamScore = GetTeamHeroKills( team ) } )
	end

	-- reverse-sort by score
	table.sort( sortedTeams, function(a,b) return ( a.teamScore > b.teamScore ) end )

	for _, t in pairs( sortedTeams ) do
		local clr = self:ColorForTeam( t.teamID )

		-- Scaleform UI Scoreboard
		local score = 
		{
     team_id = t.teamID,
     team_score = t.teamScore
   }
   FireGameEvent( "score_board", score )
 end
 -- Leader effects (moved from OnTeamKillCredit)
 local leader = sortedTeams[1].teamID
 --print("Leader = " .. leader)
 self.leadingTeam = leader
 self.runnerupTeam = sortedTeams[2].teamID
 self.leadingTeamScore = sortedTeams[1].teamScore
 self.runnerupTeamScore = sortedTeams[2].teamScore
 if sortedTeams[1].teamScore == sortedTeams[2].teamScore then
  self.isGameTied = true
else
  self.isGameTied = false
end
--local allHeroes = HeroList:GetAllHeroes()
	--[[for _,entity in pairs( allHeroes) do
		if entity:GetTeamNumber() == leader and sortedTeams[1].teamScore ~= sortedTeams[2].teamScore then
			if entity:IsAlive() == true then
				-- Attaching a particle to the leading team heroes
				local existingParticle = entity:Attribute_GetIntValue( "particleID", -1 )
       			if existingParticle == -1 then
       				local particleLeader = ParticleManager:CreateParticle( "particles/leader/leader_overhead.vpcf", PATTACH_OVERHEAD_FOLLOW, entity )
					ParticleManager:SetParticleControlEnt( particleLeader, PATTACH_OVERHEAD_FOLLOW, entity, PATTACH_OVERHEAD_FOLLOW, "follow_overhead", entity:GetAbsOrigin(), true )
					entity:Attribute_SetIntValue( "particleID", particleLeader )
				end
			else
				local particleLeader = entity:Attribute_GetIntValue( "particleID", -1 )
				if particleLeader ~= -1 then
					ParticleManager:DestroyParticle( particleLeader, true )
					entity:DeleteAttribute( "particleID" )
				end
			end
		else
			local particleLeader = entity:Attribute_GetIntValue( "particleID", -1 )
			if particleLeader ~= -1 then
				ParticleManager:DestroyParticle( particleLeader, true )
				entity:DeleteAttribute( "particleID" )
			end
		end
 end--]]
end

function CountAllItems()
  local item_count = 0
  local items = GetAllArtifacts(nil, true, true)
  for i=1, #items do
    if items[i] then
      for j=1,20 do
        if items[i][j] then
          item_count = item_count + 1
        end
      end
    end
  end
  items = GetAllItems(nil, true, false)
  for i=1, #items do
    if items[i] then
      for j=1,20 do
        if items[i][j] then
          item_count = item_count + 1
        end
      end
    end
  end
  print(item_count)
end

---------------------------------------------------------------------------
-- Update player labels and the scoreboard
---------------------------------------------------------------------------
function COverthrowGameMode:OnThink()
  

  --COverthrowGameMode:GenerateCoolItemEffectWithStatTransfer()
  --GameRules:SetGoldPerTick(1000)
  --DeepPrintTable(self.act_kills)
  --if math.random(1,100) <= 10 then
    --    COverthrowGameMode:SpawnTreasureChests()
    --end
    --CountAllItems()
    --[[
    if not COverthrowGameMode.testquestbosses then
        COverthrowGameMode.testquestbosses = true
        for i=1,10 do
            COverthrowGameMode:CreateActBoss(11,i)
        end
      end]]
      --CreateAct11MergeBoss(1,2,12)
      --CreateAct11MergeBoss(3,4,12)
      --CreateAct11MergeBoss(5,6,12)
      --CreateAct11MergeBoss(7,8,12)
      --CreateAct11MergeBoss(9,10,12)

      --test quest
    --[[
    local test = {caster = HeroList:GetAllHeroes()[1], target = HeroList:GetAllHeroes()[1]}
    
    if not COverthrowGameMode.testquest and HeroList:GetAllHeroes()[1] then
        COverthrowGameMode.main_quests_completed = 1
        test.caster.id = 21
        COverthrowGameMode.testquest = true
        CinematicApproachMessage(test)
        HeroList:GetAllHeroes()[1]:SetAbsOrigin(COverthrowGameMode.treeoflife:GetAbsOrigin())
      end]]
      --if math.random(1,100) <= 25 and HeroList:GetAllHeroes()[1] then
        --COverthrowGameMode:DropClassQuestReward( HeroList:GetAllHeroes()[1], "aimo", 3 )
        --self:CreateMythicWeapon(HeroList:GetAllHeroes()[1], "epic2aaas", false, 0, 0 ,0, true)
        --end
        --test merge boss
    --[[
    if self.first_boss then
        self.jungledifficulty = 1000
        self.first_boss.act = math.random(1,13)
        for i=1,1 do
            COverthrowGameMode:DropTempleItem(self.first_boss, 100, 1, 0, false)
        end
      end]]
    --[[
    if not COverthrowGameMode.test1 then
        COverthrowGameMode.test1 = true
        COverthrowGameMode.jungledifficulty = 100
        CreateAct11MergeBoss( 1, 2, 45 )
      end]]
    --[[if HeroList:GetAllHeroes()[1] and not COverthrowGameMode.asdfasdf then
        COverthrowGameMode.asdfasdf = true
        COverthrowGameMode:TestDropAllItems( HeroList:GetAllHeroes()[1] )
        COverthrowGameMode.jungledifficulty = 500
        HeroList:GetAllHeroes()[1].autosell = 6
        COverthrowGameMode:TestDropAllArtifacts( HeroList:GetAllHeroes()[1], 8 )
        COverthrowGameMode.asdfasdf = true
        COverthrowGameMode:TestDropAllItems( HeroList:GetAllHeroes()[1] )
        COverthrowGameMode.jungledifficulty = 500
        HeroList:GetAllHeroes()[1].autosell = 6
        COverthrowGameMode:TestDropAllArtifacts( HeroList:GetAllHeroes()[1], 8 )
      end]]
      --DeepPrintTable(COverthrowGameMode.act_kills)

      --if HeroList:GetAllHeroes()[1] then
        --COverthrowGameMode:DropTempleItem( HeroList:GetAllHeroes()[1], 100, 2, 4, false )
        --end
        --if HeroList:GetAllHeroes()[1] then
          --COverthrowGameMode:DropRandomNeutralItemForHero(HeroList:GetAllHeroes()[1], true)
          --end
          --if not COverthrowGameMode.bosstest then
            --	COverthrowGameMode:CreateActBoss(11,1)
            --	COverthrowGameMode.bosstest = true
            --end
            if COverthrowGameMode.act_11_cleared and COverthrowGameMode.act_12_cleared and COverthrowGameMode.act_13_cleared and COverthrowGameMode.jungledifficulty >= 20 and COverthrowGameMode.jungledifficulty < 500 and not COverthrowGameMode.singularityRewardGiven then
              COverthrowGameMode.singularityRewardGiven = true
              COverthrowGameMode:DropRandomNeutralItemForAllHeroes(true, 1)
              Notifications:BottomToAll({text="A grand reward... for the bravest of warriors... a tier 1 Singularity!", duration=10, style={color="orange"}})
              EmitGlobalSound("abaddon_abad_respawn_06")
            end
            if COverthrowGameMode.act_11_cleared and COverthrowGameMode.act_12_cleared and COverthrowGameMode.act_13_cleared and COverthrowGameMode.jungledifficulty >= 500 and not COverthrowGameMode.singularityRewardGiven then
              COverthrowGameMode.singularityRewardGiven = true
              COverthrowGameMode:DropRandomNeutralItemForAllHeroes(true, 2)
              Notifications:BottomToAll({text="A grand reward... for the bravest of warriors... a tier 2 Singularity!", duration=10, style={color="orange"}})
              EmitGlobalSound("abaddon_abad_respawn_06")
            end
            
            
            nCOUNTDOWNTIMER = self.RoundCountdown
            SetTimer("no", self.RoundCountdown)


            --vision node on each hero for neutrals to be allowed to order to them
            if not self.fowviewcounter then
              self.fowviewcounter = 0
            end
            self.fowviewcounter = self.fowviewcounter + 1
            if self.fowviewcounter >= 5 then
              self.fowviewcounter = 0
              local allHero = HeroList:GetAllHeroes()
              local heroPicked
              for i=1, #allHero do
                heroPicked = allHero[i]
                AddFOWViewer(3, Vector(heroPicked:GetAbsOrigin()[1], heroPicked:GetAbsOrigin()[2]), 100000, 5, false)
              end
            end

            --print("think")
            --check if game is fully joined by all heroes
            if not self.allplayershavehero and GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
              local allin = true
              for i=0, 15 do
               if PlayerResource:IsValidPlayerID(i) then
                if PlayerResource:HasSelectedHero(i) == false then
                 --print("player has not yet picked " .. i)
                 allin = false
               end
             end
           end
           if allin then
             self.allplayershavehero = 1
             --COverthrowGameMode:GetSeasonRewards() -- when all joined, load online (elo rewards) and offline (end of season) rewards
             --ShowSeasonRewardsOfflineAll()
             --CustomGameEventManager:Send_ServerToAllClients("updateinventory", { value = 1})
             local time_to_choose = 25 --23
             if #(HeroList:GetAllHeroes()) <= 1 then
              time_to_choose = 15
            end
            COverthrowGameMode.time_to_choose_ml = time_to_choose
            --print("show % selection")
            CustomGameEventManager:Send_ServerToAllClients( "temple_show_difficulty_panel", {value = time_to_choose} )
            CustomGameEventManager:Send_ServerToAllClients( "report_drop_chance", {value = self.jungledifficulty, boss = 0, mode = COverthrowGameMode.difficultyMode} )
            CustomGameEventManager:Send_ServerToAllClients( "temple_difficulty_update", { value = self.jungledifficulty} )
            Timers:CreateTimer(time_to_choose,function()
              --print("show % selection")
              CustomGameEventManager:Send_ServerToAllClients( "temple_show_difficulty_panel", {value = time_to_choose} )
              CustomGameEventManager:Send_ServerToAllClients( "report_drop_chance", {value = self.jungledifficulty, boss = 0, mode = COverthrowGameMode.difficultyMode} )
              CustomGameEventManager:Send_ServerToAllClients( "temple_difficulty_update", { value = self.jungledifficulty} )
              self.difficulty_is_set = true
              local all = HeroList:GetAllHeroes()
              if GetDifficultyModeExtraLives() >= 1 then
                for i=1, #all do
                  AddLivesToHero(all[i], GetDifficultyModeExtraLives())
                end
              end
              all = #all

              --no longer use formula that reduces single player bonus on higher ML
              local scaleUpToLevel = 100 --50
              local interpolation_factor = 0 --(self.jungledifficulty-1) / (scaleUpToLevel - 1)
              if interpolation_factor > 1 then
                interpolation_factor = 1
              end
              self.player_count_scale = (0.25 + 0.15 * all) * (1-interpolation_factor) + interpolation_factor
              local reduction = 1 - self.player_count_scale
              local hpReduction = 1 - ((0.25 + 0.15 * all) * 0.5 + 0.5)
              if reduction > 0.0 then
                local msg = ""..tostring(all).." Player(s) detected. Monster Damage reduced by "..tostring(reduction*100).."% and Health reduced by " .. tostring(hpReduction*100) .. "%."
                Notifications:BottomToAll({text=msg, duration=13, style={color="orange"}})
              end
              --unlock tps
              if self.jungledifficulty >= 20 then
                for k=1, 20 do
                  if COverthrowGameMode.teleporters and COverthrowGameMode.teleporters[k] then
                    COverthrowGameMode.teleporters[k].tp_active = true
                    CustomGameEventManager:Send_ServerToAllClients( "tp_unlocked", {value = k} )
                  end
                end
              end
              --only 1 life on 500%!
                --[[
                if self.jungledifficulty >= 500 then
                    local all = HeroList:GetAllHeroes()
                    local hero
                    for i=1, #all do
                        hero = all[i]
                        if hero and hero.ArenaControl and hero.ArenaControl:GetAbilityByIndex(0) then
                            hero.pvelives = 1
                            hero:SetModifierStackCount("modifier_pvelives", hero.ArenaControl:GetAbilityByIndex(0), hero.pvelives)
                        end
                    end
                  end]]
                  Timers:CreateTimer(1,function()
                    ActEntered(1)
                  end)
                end)
            --print("all players are in game")
            --[[
            local equip_custom_artifact_based_cosmetics = true
                if equip_custom_artifact_based_cosmetics then
                Timers:CreateTimer(15,function()
                    local all = HeroList:GetAllHeroes()
                    local hero
                    for i=1, #all do
                        hero = all[i]
                        EquipArtifactCosmeticRewards(hero, false)
                    end
                end)
              end]]

            --[[lock view on tree during selection
            --GameRules:GetGameModeEntity():SetFogOfWarDisabled(true)
            local all = HeroList:GetAllHeroes()
            local tree = Entities:FindByName( nil, "treeoflife" ):GetAbsOrigin() + Vector(0,-250,0)
            print("asd1")
            Timers:CreateTimer(3,function()
                for i=1, #all do
                    print("asd2")
                    all[i].spawn_pos = all[i]:GetAbsOrigin()
                    all[i]:SetAbsOrigin(tree)
                    PlayerResource:SetCameraTarget(all[i]:GetPlayerOwnerID(), all[i])
                end
            end)
            Timers:CreateTimer(time_to_choose,function()
                print("asd3")
                for i=1, #all do
                    all[i]:SetAbsOrigin(all[i].spawn_pos)
                    Timers:CreateTimer(0.1,function()
                        PlayerResource:SetCameraTarget(all[i]:GetPlayerOwnerID(), nil)
                    end)
                end
              end) ]]
            end
          end

          if not IsInToolsMode() and GameRules:IsCheatMode() and not self.gameischeated then
            self.gameischeated = true
            GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
          end

          if GameRules:IsGamePaused() then
            return 1
          end

          if self.countdownEnabled ~= true then
            --print("countdown not enabled yet")
            return 1
          end

          if self.RoundCountdown > 0 then
            self.RoundCountdown = self.RoundCountdown-1
          end

          --quests, event acts
          if COverthrowGameMode.quest_escort_1 then
            QuestEscort1(COverthrowGameMode.quest_escort_1)
          end
          --test act 13
          --if not COverthrowGameMode.asdf and HeroList:GetAllHeroes()[1] then
            --    COverthrowGameMode.asdf = true
            --    HeroList:GetAllHeroes()[1]:SetAbsOrigin(Entities:FindByName( nil, "act13_1" ):GetAbsOrigin())
            --end

            --tp lock to certain Act?
            local mogushan_boss = COverthrowGameMode.current_mogushan_arena_boss
            if COverthrowGameMode.act13_event_in_progress or (mogushan_boss and not mogushan_boss:IsNull() and mogushan_boss:GetHealth() / mogushan_boss:GetMaxHealth() < 1) then
              local center = Entities:FindByName( nil, "mogushan" ):GetAbsOrigin()
              local max_distance = 2500
              if COverthrowGameMode.act13_event_in_progress then
                center = Entities:FindByName( nil, "act13_1" ):GetAbsOrigin()
                max_distance = 3200
              end
              local all = HeroList:GetAllHeroes()
              local hero
              for i=1, #all do
                hero = all[i]
                if hero and ((hero:GetAbsOrigin() - center):Length() > max_distance or (COverthrowGameMode.act13_event_in_progress and hero:GetAbsOrigin()[1] < 12900)) and hero.combat_system_ability and hero:IsAlive() and not hero.templepermadead then
                  hero:SetAbsOrigin(center)
                  hero.combat_system_ability:ApplyDataDrivenModifier(hero, hero, "modifier_phased", {Duration = 0.05})
                  local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_chen/chen_teleport.vpcf", PATTACH_POINT_FOLLOW, hero)
                  ParticleManager:ReleaseParticleIndex(particle)
                  EmitGlobalSound("DOTA_Item.ArcaneBoots.Activate")
                  --PlayerResource:SetCameraTarget(hero:GetPlayerOwnerID(), hero)
                  --Timers:CreateTimer(0.5,function()
                  --PlayerResource:SetCameraTarget(hero:GetPlayerOwnerID(), nil)
                  --end)
                end         
              end
            end

            --act enter message
            local display_enter_msg = false
            --if COverthrowGameMode.jungledifficulty <= 500000.0 then
             --	display_enter_msg = true
             --end
             local all = HeroList:GetAllHeroes()
             local hero
             for i=1, #all do
              hero = all[i]
              --AddAttackSpeed( hero, 100, 10 )
              --COverthrowGameMode:CraftSpecificArtifact( hero, 12, math.random(1,2) )
              if GameRules:IsCheatMode() then
                hero.game_over = true
              end
              if math.random(1,100) <= 0 then
                if math.random(1,100) <= 33 then
                  self:CreateMythicWeapon(hero, "myth9generate", false, 0, 0 ,0, true)
                else
                  if math.random(1,100) <= 50 then
                    self:CreateMythicWeapon(hero, "mythTgenerate", false, 0, 0 ,0, true)
                  else
                    self:CreateMythicWeapon(hero, "mythEgenerate", false, 0, 0 ,0, true)
                  end
                end
              end
              --QUESTS
              --final quest
              if self.main_quests_completed and self.main_quests_completed >= 12 then
                local caster = self.treeoflife
                caster.id = 21
                local event = {
                  caster = caster,
                  target = hero
                }
                CinematicApproachMessage(event)
              end
              --gold quest
              if not self.gold_quest_completed and self.main_quests_completed and self.main_quests_completed >= 5 then
                self.gold_quest_completed = true
                Timers:CreateTimer(20.0,function()
                  local gold_drop = 25 * self.jungledifficulty
                  --EmitGlobalSound("abaddon_abad_lasthit_07")
                  EmitGlobalSound("DOTA_Item.Hand_Of_Midas")
                  Notifications:BottomToAll({text="Quest completed: Half way there", duration=12, style={color="lightgreen"}})
                  Notifications:BottomToAll({text="Cain: You have collected 5 of the 10 Essences we need. Here's a small appreciation for your efforts: A coin worth "..gold_drop.." Gold.", duration=12, style={color="lightgreen"}})
                  for j=1,5 do
                    if all[j] then
                      --all[j]:SetGold(all[j]:GetGold()+gold_drop, true)
                      --all[j]:SetGold(0, false)
                      AddGold(all[j], gold_drop)
                      local particle = ParticleManager:CreateParticle( "particles/econ/items/alchemist/alchemist_midas_knuckles/alch_knuckles_lasthit_coins.vpcf", PATTACH_CUSTOMORIGIN, all[j])
                      ParticleManager:SetParticleControl(particle, 1, all[j]:GetAbsOrigin())
                      ParticleManager:ReleaseParticleIndex(particle)
                    end
                  end
                end)
              end
              --gold quest
              if not self.gold_quest_completed_2 and self.main_quests_completed and self.main_quests_completed >= 9 then
                self.gold_quest_completed_2 = true
                Timers:CreateTimer(20.0,function()
                  local gold_drop = 50 * self.jungledifficulty
                  --EmitGlobalSound("abaddon_abad_lasthit_07")
                  EmitGlobalSound("DOTA_Item.Hand_Of_Midas")
                  Notifications:BottomToAll({text="Quest completed: Almost there!", duration=12, style={color="lightgreen"}})
                  Notifications:BottomToAll({text="Cain: You have collected 9 of the 10 Essences we need. Here's a small appreciation for your efforts: A coin worth "..gold_drop.." Gold.", duration=12, style={color="lightgreen"}})
                  for j=1,5 do
                    if all[j] then
                      --all[j]:SetGold(all[j]:GetGold()+gold_drop, true)
                      --all[j]:SetGold(0, false)
                      AddGold(all[j], gold_drop)
                      local particle = ParticleManager:CreateParticle( "particles/econ/items/alchemist/alchemist_midas_knuckles/alch_knuckles_lasthit_coins.vpcf", PATTACH_CUSTOMORIGIN, all[j])
                      ParticleManager:SetParticleControl(particle, 1, all[j]:GetAbsOrigin())
                      ParticleManager:ReleaseParticleIndex(particle)
                    end
                  end
                end)
              end
              --debug new talents
              if false then
               for k=0,20 do
                local a = hero:GetAbilityByIndex(k)
                if a then
                 --print(a:GetName())
                 --print(a:GetLevel())
               else
                 --print(a)
               end
             end
             local mods = hero:GetModifierCount()-1
             for i=0, mods do
              local name = hero:GetModifierNameByIndex(i)
              --print(name)
            end
          end

          --molten forge crafting menu
          --hero.molten_forge_menu_opened = false
          if self.molten_forge_shop_position and (hero:GetAbsOrigin() - self.molten_forge_shop_position):Length() <= 300 then
            if not hero.molten_forge_menu_opened then
              hero.molten_forge_menu_opened = true
              local player = PlayerResource:GetPlayer(hero:GetPlayerID())
              CustomGameEventManager:Send_ServerToPlayer(player, "molten_forge_menu", {open = 1})
              EmitSoundOn("sounds/vo/secretshop/secretshop_whatyoubuying_02.vsnd", hero)
            end
          else
            if hero.molten_forge_menu_opened then
              hero.molten_forge_menu_opened = false
              local player = PlayerResource:GetPlayer(hero:GetPlayerID())
              CustomGameEventManager:Send_ServerToPlayer(player, "molten_forge_menu", {open = 0})
            end
          end

          for j=1, 13 do
           if not (hero.actentered and hero.actentered[j]) then
            local trigger_dist = 1750
            local pos
            if j == 1 then
             pos = Entities:FindByName( nil, "camp1" ):GetAbsOrigin()
             trigger_dist = 1550
           end
           if j == 2 then
             pos = Entities:FindByName( nil, "camp6" ):GetAbsOrigin()
           end
           if j == 3 then
             pos = Entities:FindByName( nil, "camp15" ):GetAbsOrigin()
             trigger_dist = 2500
           end
           if j == 4 then
             pos = Entities:FindByName( nil, "camp19" ):GetAbsOrigin()
           end
           if j == 5 then
             pos = Entities:FindByName( nil, "camp28" ):GetAbsOrigin()
             trigger_dist = 2250
           end
           if j == 6 then
             pos = Entities:FindByName( nil, "camp38" ):GetAbsOrigin()
           end
           if j == 7 then
             pos = Entities:FindByName( nil, "tomb1" ):GetAbsOrigin()
           end
           if j == 8 then
             pos = Entities:FindByName( nil, "volcano1" ):GetAbsOrigin()
             trigger_dist = 3000
           end
           if j == 9 then
             pos = Entities:FindByName( nil, "mogushan" ):GetAbsOrigin()
             trigger_dist = 3000
           end
           if j == 10 then
             pos = Entities:FindByName( nil, "boss25" ):GetAbsOrigin()
             trigger_dist = 1900
           end
           if j == 11 then
             pos = Entities:FindByName( nil, "act11_creep_1" ):GetAbsOrigin()
             trigger_dist = 1000
           end
           if j == 12 then
            pos = Entities:FindByName( nil, "act12_1" ):GetAbsOrigin()
            trigger_dist = 1400
          end
          if j == 13 then
            pos = Entities:FindByName( nil, "act13_1" ):GetAbsOrigin()
            trigger_dist = 1200
          end
          local dist = (hero:GetAbsOrigin() - pos):Length()
          if dist < trigger_dist and self.difficulty_is_set then --new
           hero.actentered[j] = true
           if self.act_already_loaded and not self.act_already_loaded[j] then
            self.act_already_loaded[j] = true
            display_enter_msg = true
            self:PopulateTemple(j)
            --sound files on act enter
            local sound
            local text
            --if j == 1 then
              --    sound = "lycan_lycan_ability_summon_05"
              --   text = "Moogla the Wild: Now my wolves will feast!"
              --end
              if j == 2 then
                sound = "venomancer_venm_kill_05"
                text = "Nazgoo: Welcome... to your death!"
              end
              if j == 3 then
                sound = "tidehunter_tide_attack_09"
                text = "Sca from the Deep Sea: You can't hide from the tide!"
              end
              if j == 4 then
                sound = "warlock_warl_kill_04"
                text = "No'ra, Master of Doom: To the Darkest Vale with you!"
              end
              if j == 5 then
                sound = "viper_vipe_kill_08"
                text = "Angry Dragon Council: Did you wonder what death was like? Here it is!"
              end
              if j == 6 then
                sound = "nevermore_nev_attack_03"
                text = "Neyamor: You're mine, heart and soul!"
              end
              if j == 7 then
                sound = "abaddon_abad_cast_01"
                text = "The Black Night: By what right do you tread here?!"
                end
                if j == 8 then
                  sound = "chaos_knight_chaknight_kill_01"
                  text = "Xaxex: I'll trample your bones to dust!"
                end
                if j == 9 then
                  sound = "ogre_magi_ogmag_attack_04"
                  text = "Mogu, Undefeated Arena Champion: Hittin stuff is fun. Hah aha ha ha ha!"
                end
                if j == 10 then
                  sound = "invoker_invo_attack_06"
                  text = "Kiirion: You dare fight me?"
                end
                if j == 11 then
                  sound = "bane_bane_kill_05"
                  text = "Mysterious Voice: Welcome to my nightmare!"
                end
                if j == 12 then
                  sound = "dazzle_dazz_kill_09"
                  text = "Zalajin: Your death ennobles us all."
                end
                if j == 13 then
                  --sound = "dazzle_dazz_kill_09"
                  --text = "Zalajin: Your death ennobles us all."
                  Act13Event(true)
                end
                if sound and text then
                  Timers:CreateTimer(4.0,function()
                    EmitGlobalSound(sound)
                    Notifications:BottomToAll({text=text, duration=8, style={color="orange"}})
                  end)
                end
              end
              if display_enter_msg and j ~= 1 then
                local particle = ParticleManager:CreateParticleForPlayer("particles/units/heroes/hero_ancient_apparition/ancient_apparition_ice_blast_sphere_final_explosion_smoke.vpcf", PATTACH_POINT_FOLLOW, hero, hero:GetOwner())
                ParticleManager:SetParticleControl(particle, 3, hero:GetAbsOrigin())
                ParticleManager:ReleaseParticleIndex(particle)
                --Timers:CreateTimer(0.75,function()
                particle = ParticleManager:CreateParticleForPlayer("particles/screen_smoke_2.vpcf", PATTACH_POINT_FOLLOW, hero, hero:GetOwner())
                ParticleManager:ReleaseParticleIndex(particle)
                EmitSoundOn("DOTA_Item.DustOfAppearance.Activate", hero)
                --end)
                local player = PlayerResource:GetPlayer(hero:GetPlayerID())
                Timers:CreateTimer(2.0,function()
                 ActEntered(j)
                 EmitSoundOn("Item.PickUpRecipeWorld", hero)
               end)
              end
            end
          end
          if not self.enter_temple_msg then
            local pos = Entities:FindByName( nil, "act11_center" ):GetAbsOrigin()
            local dist = (hero:GetAbsOrigin() - pos):Length()
            if dist < 1800 then
             self.enter_temple_msg = true
             Notifications:BottomToAll({text="Nabu: A seal protects each Titan. It can only be destroyed by defeating their corresponding Act first.", duration=12, style={color="white"}})
             EmitGlobalSound("terrorblade_arcana.stinger.respawn")
           end
         end
       end
     end
     if self.junglemode then
      if self.auto_load_on then
       local all = HeroList:GetAllHeroes()
       local hero
       for i=1, #all do
        hero = all[i]
        if hero and not hero.auto_loaded then
         --hero.auto_loaded = true
         --print("try loading every sec for " .. hero:GetUnitName())
         LoadMyChar(hero)
       end			
     end
   end
   --player disable
   local all = HeroList:GetAllHeroes()
   local hero
   for i=1, #all do
     hero = all[i]
     local playerid = hero:GetPlayerID()
     local steamid = PlayerResource:GetSteamAccountID(playerid)
     if steamid == 331083980 or steamid == 295988718 or steamid == 365408273 or steamid == 324725164 or steamid == 312858974 or steamid == 374517205 or steamid == 324725164 or steamid == 119503233 or 
       steamid == 376982804 or steamid == 380880662 or steamid == 383610783 or steamid == 383689050 or steamid == 383856994 or steamid == 301230370 or steamid == 445970633 or steamid == 169589001 or steamid == 212685045 or steamid == 433543739
       or steamid == 100437970 or steamid == 247058932 or steamid == 433543739 or steamid == 207219111 or steamid == 138250514 or steamid == 100678658 or steamid == 422948593 or steamid == 365686150 or steamid == 366222608
       or steamid == 125456719 or steamid == 189981798 or steamid == 197202228 or steamid == 173962066 or steamid == 136581278 or steamid == 418116710 or steamid == 171034086 or steamid == 121416239 or steamid == 343733493 
       or steamid == 188237126 or steamid == 197202228 or steamid == 836575036 or steamid == 29497558 then -- or steamid == 39460724 then
        --GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
        hero.cheater = true
      end
    end
  end

  --update time and resend inventory incase of disc
  self.SecondsCounter = self.SecondsCounter + 1
  --print(self.SecondsCounter)
  if self.SecondsCounter >= 30 then
    self.SecondsCounter = 0
    self.GameMinutes = self.GameMinutes + 0.5

    --reconnect tp active
    for k=1,12 do
      if COverthrowGameMode.teleporters and COverthrowGameMode.teleporters[k] and COverthrowGameMode.teleporters[k].tp_active then
        CustomGameEventManager:Send_ServerToAllClients( "tp_unlocked", {value = k} )
      end
    end
    if COverthrowGameMode.act11_bosses_spawned then
      CustomGameEventManager:Send_ServerToAllClients( "tp_unlocked", {value = 8} )
    end

    --update artifact item inventory every 60 secs, good after disconnect
    --print("minute passed")
    local all = HeroList:GetAllHeroes()
    local hero
    for i=1, #all do
     hero = all[i]
     if hero and hero.inventory then
      for slot=1, self.mythic_slots do
       if hero.inventory[slot] and hero.inventory[slot][1] and string.len(hero.inventory[slot][1]) > 3 then
        CustomGameEventManager:Send_ServerToAllClients("templeweaponequip", { item = hero.inventory[slot][1], itemname = hero.inventory[slot][0], attributes = hero.inventory[slot][4], stat1 = hero.inventory[slot][5],
          stat1name = hero.inventory[slot][8], stat2 = hero.inventory[slot][6], stat2name = hero.inventory[slot][9], stat3 = hero.inventory[slot][7], stat3name = hero.inventory[slot][10], ilevel = hero.inventory[slot][11], slot = hero.inventory[slot][2],
        rarity = hero.inventory[slot][3], playerid = hero:GetPlayerID(), weapontype = hero.inventory[slot][14] } )
      end
    end
    --statistics
    local damagepersec = math.floor(hero.damage_done / 30)
    if hero.best_dps then
     if damagepersec > hero.best_dps then
      hero.best_dps = damagepersec
    end
  else
   hero.best_dps = damagepersec
 end
 local healpersec = math.floor(hero.healing_done / 30)
 if hero.best_hps then
   if healpersec > hero.best_hps then
    hero.best_hps = healpersec
  end
else
 hero.best_hps = healpersec
end
--print("aggro caused " .. hero.aggro_caused)
CustomGameEventManager:Send_ServerToAllClients("templeherostatistics", { playerid = hero:GetPlayerID(), abil = hero.ability_bonus, ele = hero.elemental_bonus, crit_chance = hero.crit_chance_factor, crit_dmg = hero.crit_dmg_factor, heal = hero.heal_bonus, cd = hero.cooldown_reduction, aggro = hero.aggro_caused, dps = damagepersec, hps = healpersec, bestdps = hero.best_dps, besthps = hero.best_hps, sp = hero.spellpower, multiplicative = hero.multiplicative_bonus } )
CalcAbilityStatsPercent(hero)
local player = PlayerResource:GetPlayer(hero:GetPlayerID())
for index=0,6 do
  local dmg = 0
  local heal = 0
  local ab_for_name = hero:GetAbilityByIndex(index)
  local name = nil
  if ab_for_name then
    name = ab_for_name:GetAbilityName()
  end
  if hero.ability_stats_percent and hero.ability_stats_percent[index] and hero.ability_stats and hero.ability_stats[index] then
    dmg = hero.ability_stats_percent[index]
    hero.ability_stats[index] = 0
  end
  if hero.ability_stats_percent_heal and hero.ability_stats_percent_heal[index] and hero.ability_stats_heal and hero.ability_stats_heal[index] then
    heal = hero.ability_stats_percent_heal[index]
    hero.ability_stats_heal[index] = 0
  end
  if name then
    CustomGameEventManager:Send_ServerToPlayer(player, "temple_ability_stats", {abilityname = name, abilityindex = index, damage = dmg, healing = heal})
  end
end
hero.damage_done = 0
hero.healing_done = 0
end
--try resend dropped item, good after disconnect
--todo, resend whole list
--if hero and hero.weapondrop and hero.weapondrop[1] then
 --	local player = PlayerResource:GetPlayer(hero:GetPlayerID())
 --	if player then
   --		CustomGameEventManager:Send_ServerToPlayer(player, "lasttempleweapondrop", { item = hero.weapondrop[1], itemname = hero.weapondrop[0], attributes = hero.weapondrop[4], stat1 = hero.weapondrop[5], stat1name = hero.weapondrop[8], stat2 = hero.weapondrop[6], stat2name = hero.weapondrop[9], stat3 = hero.weapondrop[7], stat3name = hero.weapondrop[10], ilevel = hero.weapondrop[11], slot = hero.weapondrop[2], rarity = hero.weapondrop[3], playerid = hero:GetPlayerID() } )
   --	end
   --end
   --update talent trees
   --Timers:CreateTimer(i*3,function()
   --   SendTalentTreesToAll(hero)
   --end)
 end
end

--send dps meter update
self:SendDPSMeterData()

-- inventory and unit selection
--CustomGameEventManager:Send_ServerToAllClients("updateinventory", { value = 1})

--City Raid Game Mode
if self.GameState == GameState_CityRaid and GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
  --if self.RoundCountdown > 0 then
   self.RoundCountdown = self.RoundCountdown+2
   --end
   local creepinterval = 40
   local farminterval = 120
   local farminterval_big = 300
   local catapultinterval = 5

   --scalings
   local scale = math.floor((PlayerResource:GetPlayerCountForTeam(2) + PlayerResource:GetPlayerCountForTeam(3) - 6)/1.0 + self.GameMinutes/5)
   if scale < 0 then
     scale = 0
   end

   if self.startcreepspawn and self.creeptimer then
     self.creeptimer = self.creeptimer + 1
     if self.creeptimer >= creepinterval then
      self.creeptimer = 0
      self.catapulttimer = self.catapulttimer + 1
      local tab = {Duration = 0.1}

      for i=1, 5 do
       local spawn = CreateUnitByName("npc_dota_creature_city_troll_melee", self.creepspawn_1, true, nil, nil, DOTA_TEAM_GOODGUYS)
       spawn.waypoint_top = 2
       spawn:SetHullRadius(30)
       spawn:AddAbility("cityraid_pathing"):SetLevel(1)
       spawn:GetAbilityByIndex(0):ApplyDataDrivenModifier(spawn, spawn, "modifier_phased", tab)
       spawn:CreatureLevelUp(scale)

       spawn = CreateUnitByName("npc_dota_creature_city_troll_melee", self.creepspawn_1, true, nil, nil, DOTA_TEAM_GOODGUYS)
       spawn.waypoint_bot = 2
       spawn:SetHullRadius(30)
       spawn:AddAbility("cityraid_pathing"):SetLevel(1)
       spawn:GetAbilityByIndex(0):ApplyDataDrivenModifier(spawn, spawn, "modifier_phased", tab)
       spawn:CreatureLevelUp(scale)

       spawn = CreateUnitByName("npc_dota_creature_city_centaur_melee", self.creepspawn_2, true, nil, nil, DOTA_TEAM_BADGUYS)
       spawn.waypoint_top = 7
       spawn.badguys = 1
       spawn:SetHullRadius(30)
       spawn:AddAbility("cityraid_pathing"):SetLevel(1)
       spawn:GetAbilityByIndex(0):ApplyDataDrivenModifier(spawn, spawn, "modifier_phased", tab)
       spawn:CreatureLevelUp(scale)

       spawn = CreateUnitByName("npc_dota_creature_city_centaur_melee", self.creepspawn_2, true, nil, nil, DOTA_TEAM_BADGUYS)
       spawn.waypoint_bot = 7
       spawn.badguys = 1
       spawn:SetHullRadius(30)
       spawn:AddAbility("cityraid_pathing"):SetLevel(1)
       spawn:GetAbilityByIndex(0):ApplyDataDrivenModifier(spawn, spawn, "modifier_phased", tab)
       spawn:CreatureLevelUp(scale)
     end
     Timers:CreateTimer(0.5,function() 
       for i=1, 1 do
        local spawn = CreateUnitByName("npc_dota_creature_city_troll_ranged", self.creepspawn_1, true, nil, nil, DOTA_TEAM_GOODGUYS)
        spawn.waypoint_top = 2
        spawn:SetHullRadius(30)
        spawn:AddAbility("cityraid_pathing"):SetLevel(1)
        spawn:GetAbilityByIndex(0):ApplyDataDrivenModifier(spawn, spawn, "modifier_phased", tab)
        spawn:CreatureLevelUp(scale)

        if self.cityraidboss_1 and self.cityraidboss_1:HasModifier("modifier_catapult") and self.catapulttimer >= catapultinterval then
         local mods = self.cityraidboss_1:GetModifierCount()-1
         local maxsiege = 0
         for siege=0, mods do
          local name = self.cityraidboss_1:GetModifierNameByIndex(siege)
          if name == "modifier_catapult" and maxsiege < 2 then
           maxsiege = maxsiege + 1
           spawn = CreateUnitByName("npc_dota_creature_city_catapult_1", self.creepspawn_1, true, nil, nil, DOTA_TEAM_GOODGUYS)
           spawn.waypoint_top = 2
           spawn:SetHullRadius(90)
           spawn:AddAbility("cityraid_pathing"):SetLevel(1)
           spawn:GetAbilityByIndex(0):ApplyDataDrivenModifier(spawn, spawn, "modifier_phased", tab)
           spawn:CreatureLevelUp(scale)
         end
       end
     end

     spawn = CreateUnitByName("npc_dota_creature_city_troll_ranged", self.creepspawn_1, true, nil, nil, DOTA_TEAM_GOODGUYS)
     spawn.waypoint_bot = 2
     spawn:SetHullRadius(30)
     spawn:AddAbility("cityraid_pathing"):SetLevel(1)
     spawn:GetAbilityByIndex(0):ApplyDataDrivenModifier(spawn, spawn, "modifier_phased", tab)
     spawn:CreatureLevelUp(scale)

     spawn = CreateUnitByName("npc_dota_creature_city_centaur_ranged", self.creepspawn_2, true, nil, nil, DOTA_TEAM_BADGUYS)
     spawn.waypoint_top = 7
     spawn.badguys = 1
     spawn:SetHullRadius(30)
     spawn:AddAbility("cityraid_pathing"):SetLevel(1)
     spawn:GetAbilityByIndex(0):ApplyDataDrivenModifier(spawn, spawn, "modifier_phased", tab)
     spawn:CreatureLevelUp(scale)

     if self.cityraidboss_2 and self.cityraidboss_2:HasModifier("modifier_catapult") and self.catapulttimer >= catapultinterval then
       local mods = self.cityraidboss_2:GetModifierCount()-1
       local maxsiege = 0
       for siege=0, mods do
        local name = self.cityraidboss_2:GetModifierNameByIndex(siege)
        if name == "modifier_catapult" and maxsiege < 2 then
         maxsiege = maxsiege + 1
         spawn = CreateUnitByName("npc_dota_creature_city_catapult_2", self.creepspawn_2, true, nil, nil, DOTA_TEAM_BADGUYS)
         spawn.waypoint_bot = 7
         spawn.badguys = 1
         spawn:SetHullRadius(90)
         spawn:AddAbility("cityraid_pathing"):SetLevel(1)
         spawn:GetAbilityByIndex(0):ApplyDataDrivenModifier(spawn, spawn, "modifier_phased", tab)
         spawn:CreatureLevelUp(scale)
       end
     end
   end

   spawn = CreateUnitByName("npc_dota_creature_city_centaur_ranged", self.creepspawn_2, true, nil, nil, DOTA_TEAM_BADGUYS)
   spawn.waypoint_bot = 7
   spawn.badguys = 1
   spawn:SetHullRadius(30)
   spawn:AddAbility("cityraid_pathing"):SetLevel(1)
   spawn:GetAbilityByIndex(0):ApplyDataDrivenModifier(spawn, spawn, "modifier_phased", tab)
   spawn:CreatureLevelUp(scale)
 end
end)
     --testunit:AddAbility("dps_meter")
     --testunit:FindAbilityByName("dps_meter"):SetLevel(1)
     --testunit:SetControllableByPlayer(all[1]:GetPlayerOwnerID(), true)
     if self.catapulttimer >= catapultinterval then
       Timers:CreateTimer(0.6,function() 
        self.catapulttimer = 0
      end)
     end
   end


   --farm spots small
   self.farmtimer = self.farmtimer + 1
   self.farmtimer_big = self.farmtimer_big + 1
   if self.farmtimer >= farminterval then
    self.farmtimer = 0
    local tab = {Duration = 0.1}
    for i=1, 4 do
     if self.farm_units[i] and not self.farm_units[i]:IsNull() and self.farm_units[i]:IsAlive() then

     else
      local spawn
      if i <= 2 then
       spawn = CreateUnitByName("npc_dota_creature_city_wolf_1", self.farmspot[i], true, nil, nil, DOTA_TEAM_BADGUYS)
     end
     if i >= 3 then
       spawn = CreateUnitByName("npc_dota_creature_city_wolf_2", self.farmspot[i], true, nil, nil, DOTA_TEAM_BADGUYS)
     end
     spawn:SetHullRadius(30)
     spawn:GetAbilityByIndex(0):ApplyDataDrivenModifier(spawn, spawn, "modifier_phased", tab)
     spawn:CreatureLevelUp(scale)
     self.farm_units[i] = spawn
     spawn.spawncamp = self.farmspot[i]
   end
 end
end
--farm spots big
if self.farmtimer_big >= farminterval_big then
  self.farmtimer_big = 0
  local tab = {Duration = 0.1}
  for i=5, 10 do
   if self.farm_units[i] and not self.farm_units[i]:IsNull() and self.farm_units[i]:IsAlive() then

   else
    local spawn
    if i == 8 then
     spawn = CreateUnitByName("npc_dota_creature_city_kobold_boss", self.farmspot[i], true, nil, nil, DOTA_TEAM_BADGUYS)
     spawn.drop_goldcore = 1
     spawn.camp_position = self.farmspot[i]
   end
   if i == 10 then
     spawn = CreateUnitByName("npc_dota_creature_city_frost_boss", self.farmspot[i], true, nil, nil, DOTA_TEAM_BADGUYS)
     spawn.drop_frostcore = 1
   end
   if i == 9 then
     spawn = CreateUnitByName("npc_dota_creature_city_shadow_boss", self.farmspot[i], true, nil, nil, DOTA_TEAM_BADGUYS)
     spawn.drop_shadowcore = 1
   end
   if i == 5 then
     spawn = CreateUnitByName("npc_dota_creature_city_iron_boss", self.farmspot[i], true, nil, nil, DOTA_TEAM_BADGUYS)
     spawn.drop_ironcore = 1
   end
   if i == 7 then
     spawn = CreateUnitByName("npc_dota_creature_city_fire_boss", self.farmspot[i], true, nil, nil, DOTA_TEAM_BADGUYS)
     spawn.drop_firecore = 1
   end
   if i == 6 then
     spawn = CreateUnitByName("npc_dota_creature_city_nature_boss", self.farmspot[i], true, nil, nil, DOTA_TEAM_BADGUYS)
     spawn.drop_naturecore = 1
   end
   spawn:SetHullRadius(30)
   spawn:GetAbilityByIndex(0):ApplyDataDrivenModifier(spawn, spawn, "modifier_phased", tab)
   --pve bosses 30% stronger?
   spawn:CreatureLevelUp(scale+3)
   self.farm_units[i] = spawn
   spawn.spawncamp = self.farmspot[i]
 end
end
end
end

end



if self.GameState ~= GameState_CityRaid then
  COverthrowGameMode:CheckForLeavers()
end
--print("mid loop")
--Shopping Time, wait for counter to start Arena
if self.GameState == GameState_Shopping then
  --print("shopping")
  COverthrowGameMode:QuickStartVote()
  -- show starting explanation of longer shopping time before round 1
  --print("testing to make a quest")
  --print(self.StartQuest)
  if self.RoundCounter == 1 and self.StartQuest == true then
   self.StartQuest = false
   --print("making a quest")
   if self.junglemode then
    self.Quest = SpawnEntityFromTableSynchronous( "quest", { name = "QuestName", title = "#QuestTimerStartTemple" } )
  else
    self.Quest = SpawnEntityFromTableSynchronous( "quest", { name = "QuestName", title = "#QuestTimerStart" } )
  end

  self.Quest.EndTime = self.RoundCountdown
  subQuest = SpawnEntityFromTableSynchronous( "subquest_base", { 
    show_progress_bar = true, 
    progress_bar_hue_shift = -119 
  } )
  self.Quest:AddSubquest( subQuest )
  -- text on the quest timer at start
  self.Quest:SetTextReplaceValue( QUEST_TEXT_REPLACE_VALUE_CURRENT_VALUE, 100 )
  self.Quest:SetTextReplaceValue( QUEST_TEXT_REPLACE_VALUE_TARGET_VALUE, 100 )

  -- value on the bar
  subQuest:SetTextReplaceValue( SUBQUEST_TEXT_REPLACE_VALUE_CURRENT_VALUE, 100 )
  subQuest:SetTextReplaceValue( SUBQUEST_TEXT_REPLACE_VALUE_TARGET_VALUE, 100 )

  Timers:CreateTimer(1, function()
    if self.Quest ~= nil then
      self.Quest.EndTime = self.Quest.EndTime - 1
      self.Quest:SetTextReplaceValue( QUEST_TEXT_REPLACE_VALUE_CURRENT_VALUE, self.Quest.EndTime )
      subQuest:SetTextReplaceValue( QUEST_TEXT_REPLACE_VALUE_CURRENT_VALUE, self.Quest.EndTime )

      -- Finish the quest when the time is up  
      if self.Quest.EndTime == 0 then 
        --EmitGlobalSound("Tutorial.Quest.complete_01") -- Part of game_sounds_music_tutorial
        self.Quest:CompleteQuest()
        return
      else
        return 1 -- Call again every second
      end
    end
  end)			
end
if self.RoundCountdown == 1 and self.RoundCounter == 1 and self.rankedgame > 0 then
 --print("pre fight cache of elo table")
 COverthrowGameMode:ReceiveEloResults(11) --only if not yet updated
end

if self.RoundCountdown == 30 and (self.RoundCounter == 1 or self.RoundCounter == 4) then
 self:TipQuest()
end

if self.RoundCountdown == 53 then
 local all = HeroList:GetAllHeroes()
 --print("found heroes for gold add")
 --print(#all)
 local hero
 for i=1, #all do
  hero = all[i]
  if hero ~= nil and self.RoundCounter ~=1 and hero.SavedGold then
   --hero:SetGold(hero:GetGold()+3000, true)
   hero:HeroLevelUp(true)
   --todo +1 only
   if not (self.FarmMode == 1) then
    if self.RoundCounter <= 3 then
     hero:SetAbilityPoints(hero:GetAbilityPoints()+1)
   else
     hero:SetAbilityPoints(hero:GetAbilityPoints())
   end
 else
  if self.RoundCounter <= 4 then
   hero:SetAbilityPoints(0)
   LevelNextAbility(hero)
 else
   hero:SetAbilityPoints(hero:GetAbilityPoints())
 end
end
local gold = hero.SavedGold + 4500
--all[i].SavedGold = gold
hero:SetGold(gold, true)
hero:SetGold(0, false)
end			
end
--print("player resource" .. hero:GetPlayerOwner():GetName())
--print("find centaur")
--print("fake")
--print(PlayerResource:IsFakeClient( 3 ))
--local testhero = Entities:FindByName( nil, "npc_centaur" )
--print(testhero:GetPlayerOwnerID())
--print(testhero:GetPlayerOwner())
--local vec = overBoss:GetAbsOrigin()
--vec[1]=vec[1]+300
--vec[2]=vec[2]+300
--vec[3]=vec[3]+0
--testhero = CreateHeroForPlayer("npc_dota_hero_axe", PlayerResource:GetPlayer(4))
--testhero:SetAbsOrigin(vec)
end

if self.RoundCountdown == 2 and self.RoundCounter == 1 and not self.junglemode then
 --shapeshift model fix
end

-- if we play alone, summon test units
if self.RoundCountdown == 10 and testbots then
 print("test bots enalbing")
 testbots = false
 if self.testmode or PlayerResource:GetPlayerCount() <= 1 then
  -- test bot populate
  if true then
   SendToServerConsole("dota_bot_populate")
 else
   SendToServerConsole("dota_create_fake_clients")
   Timers:CreateTimer(1.1,function() 
    local pl = PlayerResource:GetPlayer(1)
    CreateHeroForPlayer("npc_dota_hero_sven", pl)
    pl = PlayerResource:GetPlayer(2)
    CreateHeroForPlayer("npc_dota_hero_sven", pl)
    pl = PlayerResource:GetPlayer(3)
    CreateHeroForPlayer("npc_dota_hero_sven", pl)
    pl = PlayerResource:GetPlayer(4)
    CreateHeroForPlayer("npc_dota_hero_sven", pl)
    pl = PlayerResource:GetPlayer(5)
    CreateHeroForPlayer("npc_dota_hero_sven", pl)
    pl = PlayerResource:GetPlayer(6)
    CreateHeroForPlayer("npc_dota_hero_sven", pl)
    pl = PlayerResource:GetPlayer(7)
    CreateHeroForPlayer("npc_dota_hero_sven", pl)
    pl = PlayerResource:GetPlayer(8)
    CreateHeroForPlayer("npc_dota_hero_sven", pl)
  end)
 end
 self.rankedgame = 0

 -- disable old test units
 self.PlayersPlaying = 10
 self.TEAM_KILLS_TO_WIN = 35	-- here change todo 25, 35
 CustomNetTables:SetTableValue( "game_state", "victory_condition", { kills_to_win = self.TEAM_KILLS_TO_WIN } );
 if self.PVEMode == 0 and not self.junglemode then
   
   local finder = {}
   finder[1]="testunit1"
   finder[2]="testunit2"
   finder[3]="testunit3"
   finder[4]="testunit4"
   finder[5]="testunit5"
   finder[6]="testunit6"
   local all = HeroList:GetAllHeroes()
   for k=1, 3 do
    for p=1, 6 do
     if not all[1] then
      return
    end
    local playercontrol = all[1]:GetPlayerOwner()
    local pos = Entities:FindByName( nil, finder[p] ):GetAbsOrigin()
    local testunit = CreateUnitByName("npc_dota_creature_felhunterdummy", pos+k*Vector(0,-100,0)+Vector(0,200,0), true, nil, nil, DOTA_TEAM_BADGUYS)
    testunit:AddAbility("dps_meter")
    testunit:FindAbilityByName("dps_meter"):SetLevel(1)
    testunit:SetControllableByPlayer(all[1]:GetPlayerOwnerID(), true)
  end
end
for k=1, 2 do
  local playercontrol = all[1]:GetPlayerOwner()
  local pos = Entities:FindByName( nil, "team_arena_1" ):GetAbsOrigin()
  local testunit = CreateUnitByName("npc_dota_creature_felhunterdummy", pos+k*Vector(0,-100,0)+Vector(0,400,0), true, nil, nil, playercontrol:GetTeamNumber())
  testunit:AddAbility("dps_meter")
  testunit:FindAbilityByName("dps_meter"):SetLevel(1)
  testunit:SetControllableByPlayer(all[1]:GetPlayerOwnerID(), true)
end
end
end
end

if self.RoundCountdown == 0 and not self.junglemode and (self.FarmMode == 0 or (self.RoundCounter ~= 4 and self.RoundCounter ~= 8 and self.RoundCounter ~= 12))  then
 --starting round
 --print("starting round")
 self.RoundCountdown = 600
 self.GameState = GameState_Arena
 --EmitGlobalSound("announcer_dlc_axe_announcer_battle_begin_01")
 -- rune of detection reset
 if self.runeofdetection and not self.runeofdetection:IsNull() then
  UTIL_Remove(self.runeofdetection)
  self.runeofdetection = nil
end

--show scoreboard
--CustomUI:DynamicHud_SetVisible(-1, "HudTopBar", false)
--CustomUI:DynamicHud_SetVisible(-1, "TipsRow", false)

--Teleport to Arena
all = HeroList:GetAllHeroes()
--print("found")
--print(#all)
local pos1 = Entities:FindByName( nil, "team_arena_1" ):GetAbsOrigin()-Vector(0,0,0)
local pos2 = Entities:FindByName( nil, "team_arena_2" ):GetAbsOrigin()-Vector(0,0,0)
self.arenachosen = 1
local rnd = math.random(1,100)
local water = -1
--print(rnd)
if self.PVEMode ~= 1 then
  if rnd <= 80 and PlayerResource:GetPlayerCount() > 1 and not self.testmode then --66 1
   pos1 = Entities:FindByName( nil, "team_arena_5" ):GetAbsOrigin()-Vector(0,0,0)
   pos2 = Entities:FindByName( nil, "team_arena_6" ):GetAbsOrigin()-Vector(0,0,0)
   water = 12
   self.arenachosen = 3
 end
 if rnd <= 60 and PlayerResource:GetPlayerCount() > 1 and not self.testmode then
   pos1 = Entities:FindByName( nil, "team_arena_3" ):GetAbsOrigin()-Vector(0,0,0)
   pos2 = Entities:FindByName( nil, "team_arena_4" ):GetAbsOrigin()-Vector(0,0,0)
   water = -1
   self.arenachosen = 2
 end
 if rnd <= 40 and PlayerResource:GetPlayerCount() > 1 and not self.testmode then --todo set 1
   pos1 = Entities:FindByName( nil, "team_arena_7" ):GetAbsOrigin()-Vector(0,0,0)
   pos2 = Entities:FindByName( nil, "team_arena_8" ):GetAbsOrigin()-Vector(0,0,0)
   water = -1
   self.arenachosen = 4
 end
 if rnd <= 20 and PlayerResource:GetPlayerCount() > 1 and not self.testmode then --todo set 1
   pos1 = Entities:FindByName( nil, "team_arena_9" ):GetAbsOrigin()-Vector(0,0,0)
   pos2 = Entities:FindByName( nil, "team_arena_10" ):GetAbsOrigin()-Vector(0,0,0)
   water = -1
   self.arenachosen = 5
 end
end
--PVE Mode Teleporting
if self.PVEMode == 1 then
  print("pve mode on")
  pos1 = Entities:FindByName( nil, "team_arena_2" ):GetAbsOrigin()-Vector(0,0,0)
  pos2 = Entities:FindByName( nil, "team_arena_1" ):GetAbsOrigin()-Vector(0,0,0)
  rnd = math.random(1,100)
  water = -1

  self:PVEAggroClear()

  --summon Boss
  --local playercontrol = all[1]:GetPlayerOwner()
  local pos = Entities:FindByName( nil, "testunit6" ):GetAbsOrigin()
  local boss
  if self.currentBoss == 1 then
   boss = CreateUnitByName("npc_dota_creature_pveboss1", pos, true, nil, nil, DOTA_TEAM_BADGUYS )
   Attachments:AttachProp(boss, "attach_attack1", "models/props_items/basher.vmdl", 1.5)
 end
 self.currentBossUnit = boss
 boss.IsCasting = 0
 --testunit:AddAbility("dps_meter")
 --testunit:FindAbilityByName("dps_meter"):SetLevel(1)
 --print(playercontrol)
 --print(pos)
 --print(testunit)
 --testunit:SetControllableByPlayer(all[1]:GetPlayerOwnerID(), true)
end




self.HeroesAlivePerTeam={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}

self.waterfall = water

for i=1, #all do
  if all[i] ~= nil and all[i]:IsHero() and not (all[i]:IsIllusion()) then
   --print(all[i]:GetUnitName())
   all[i].damagedone = 0
   all[i].healingdone = 0

   if all[i]:IsHero() == true then
    local gold = all[i]:GetGold()
    all[i].SavedGold = gold
    all[i]:SetGold(0, true)
    all[i]:SetGold(0, false)
  end

  -- Combat Reset, Cooldowns Full HP MANA etc
  for j=0,5 do
    if all[i]:GetAbilityByIndex(j) ~= nil then
     all[i]:GetAbilityByIndex(j):EndCooldown()      --TODO revert when all heroes have 6 abilities
   end
   local item = all[i]:GetItemInSlot(j)
   if item ~= nil then
    item:EndCooldown()
  end
end
all[i]:SetHealth(20000.0)
all[i]:SetMana(20000.0)
if all[i].Rage ~= nil then
  all[i].Rage = 0
end
all[i].souls = 0
all[i]:RemoveModifierByName("modifier_silencer_int_steal")
all[i]:RemoveModifierByName("modifier_fanatism")
all[i]:RemoveModifierByName("modifier_elementalfury")
all[i]:RemoveModifierByName("modifier_combopoint")
all[i]:RemoveModifierByName("modifier_shadoworb")
all[i]:RemoveModifierByName("modifier_stealthrogue")
all[i]:RemoveModifierByName("modifier_stealthcat")
all[i]:RemoveModifierByName("modifier_invisible")
all[i]:RemoveModifierByName("modifier_beastrage")
all[i]:RemoveModifierByName("modifier_arcanepower")
all[i]:RemoveModifierByName("modifier_sacred_shield")
all[i]:RemoveModifierByName("modifier_earth_shield")
all[i]:RemoveModifierByName("modifier_souls")
all[i]:RemoveModifierByName("modifier_lockreload")
all[i]:RemoveModifierByName("modifier_suncharge")
all[i]:RemoveModifierByName("modifier_mooncharge")
all[i]:RemoveModifierByName("modifier_inner_cd_bonus")
all[i]:RemoveModifierByName("modifier_warlockrage")
all[i]:RemoveModifierByName("modifier_frostrune")
all[i]:RemoveModifierByName("modifier_light_charge")
all[i]:RemoveModifierByName("modifier_metamorph_dh")
all[i]:Stop()
if all[i].ComboPoints then
  all[i].ComboPoints = 0
end

-- shapeshift desync
if self.EnableShapeshift == 0 then
  local ability =  all[i]:GetAbilityByIndex(5)
  if ability and (ability:GetName() == "Shapeshift" or ability:GetName() == "ShapeshiftFeral") then
   if ability:GetToggleState() then
     ability:ToggleAbility()
   end
 end
end


-- Strong Dispel
local RemovePositiveBuffs = true
local RemoveDebuffs = true
local BuffsCreatedThisFrameOnly = false
local RemoveStuns = false
local RemoveExceptions = false
all[i]:Purge( RemovePositiveBuffs, RemoveDebuffs, BuffsCreatedThisFrameOnly, RemoveStuns, RemoveExceptions)


if all[i].OldMana ~= nil then
  all[i].OldMana = all[i]:GetMaxMana()
end

if all[i]:GetTeamNumber()==2 then	
  all[i]:SetAbsOrigin(pos1)
  if all[i].Pet ~= nil and not all[i].Pet:IsNull() then
   UTIL_Remove(all[i].Pet)
   --all[i].Pet:SetAbsOrigin(pos1+Vector(125,0,0))
 end	
 if all[i].Pet1 ~= nil and not all[i].Pet1:IsNull() then
   UTIL_Remove(all[i].Pet1)
 end	
 if all[i].Pet2 ~= nil and not all[i].Pet2:IsNull() then
   UTIL_Remove(all[i].Pet2)
 end	
 pos1[2]=pos1[2]-125
else
  all[i]:SetAbsOrigin(pos2)
  if all[i].Pet ~= nil and not all[i].Pet:IsNull() then
   UTIL_Remove(all[i].Pet)
 end
 if all[i].Pet1 ~= nil and not all[i].Pet1:IsNull() then
   UTIL_Remove(all[i].Pet1)
 end	
 if all[i].Pet2 ~= nil and not all[i].Pet2:IsNull() then
   UTIL_Remove(all[i].Pet2)
 end	
 pos2[2]=pos2[2]-125
end

-- auto summon pets
local heroName = all[i]:GetUnitName()
if heroName == "npc_dota_hero_warlock" then 
  --all[i]:GetAbilityByIndex(5):Order
end


PlayerResource:SetCameraTarget(all[i]:GetPlayerOwnerID(), all[i])
Timers:CreateTimer(0.6,function() 
  PlayerResource:SetCameraTarget(all[i]:GetPlayerOwnerID(), nil)
end)

--Stats for arena end determination
--print("teamnumber " .. all[i]:GetTeamNumber())
if (all[i]:GetTeamNumber() > 11) then
  --print("teamnumber very high")
else
  --nothing anymore
end
self.HeroesAlivePerTeam[all[i]:GetTeamNumber()-1]=self.HeroesAlivePerTeam[all[i]:GetTeamNumber()-1]+1
self.TeamIsPlaying[all[i]:GetTeamNumber()-1]=1
end
end
if self.EnableShapeshift == 0 then
  self.EnableShapeshift = 1
end
end

if self.RoundCountdown == 0 and (self.FarmMode == 1 and (self.RoundCounter == 4 or self.RoundCounter == 8 or self.RoundCounter == 12))  then
 --starting FARM ROUND
 self.RoundCountdown = 435
 self.GameState = GameState_Farming

 local r = self.RoundCounter
 self:PopulateDungeon(r)

 --Teleport to Dungeon
 all = HeroList:GetAllHeroes()
 --print("found")
 --print(#all)
 local pos1 = Entities:FindByName( nil, "pve_team1_1" ):GetAbsOrigin()-Vector(0,0,0)
 local pos2 = Entities:FindByName( nil, "pve_team2_1" ):GetAbsOrigin()-Vector(0,0,0)

 for i=1, #all do
  if all[i] ~= nil and all[i]:IsHero() and not (all[i]:IsIllusion()) then
   --print(all[i]:GetUnitName())
   all[i].damagedone = 0
   all[i].healingdone = 0

   -- Combat Reset, Cooldowns Full HP MANA etc
   for j=0,5 do
    if all[i]:GetAbilityByIndex(j) ~= nil then
     all[i]:GetAbilityByIndex(j):EndCooldown()      --TODO revert when all heroes have 6 abilities
   end
   local item = all[i]:GetItemInSlot(j)
   if item ~= nil then
    item:EndCooldown()
  end
end
all[i]:SetHealth(20000.0)
all[i]:SetMana(20000.0)
if all[i].Rage ~= nil then
  all[i].Rage = 0
end
all[i].souls = 0
all[i]:RemoveModifierByName("modifier_silencer_int_steal")
all[i]:RemoveModifierByName("modifier_fanatism")
all[i]:RemoveModifierByName("modifier_elementalfury")
all[i]:RemoveModifierByName("modifier_combopoint")
all[i]:RemoveModifierByName("modifier_shadoworb")
all[i]:RemoveModifierByName("modifier_stealthrogue")
all[i]:RemoveModifierByName("modifier_stealthcat")
all[i]:RemoveModifierByName("modifier_invisible")
all[i]:RemoveModifierByName("modifier_beastrage")
all[i]:RemoveModifierByName("modifier_arcanepower")
all[i]:RemoveModifierByName("modifier_sacred_shield")
all[i]:RemoveModifierByName("modifier_earth_shield")
all[i]:RemoveModifierByName("modifier_souls")
all[i]:RemoveModifierByName("modifier_warlockrage")
all[i]:RemoveModifierByName("modifier_frostrune")
all[i]:RemoveModifierByName("modifier_light_charge")
all[i]:RemoveModifierByName("modifier_metamorph_dh")
all[i]:Stop()
if all[i].ComboPoints then
  all[i].ComboPoints = 0
end


-- Strong Dispel
local RemovePositiveBuffs = true
local RemoveDebuffs = true
local BuffsCreatedThisFrameOnly = false
local RemoveStuns = false
local RemoveExceptions = false
all[i]:Purge( RemovePositiveBuffs, RemoveDebuffs, BuffsCreatedThisFrameOnly, RemoveStuns, RemoveExceptions)


if all[i].OldMana ~= nil then
  all[i].OldMana = all[i]:GetMaxMana()
end


if all[i]:GetTeamNumber()==2 then	
  all[i]:SetAbsOrigin(pos1)
  if all[i].Pet ~= nil and not all[i].Pet:IsNull() then
   UTIL_Remove(all[i].Pet)
   --all[i].Pet:SetAbsOrigin(pos1+Vector(125,0,0))
 end	
 if all[i].Pet1 ~= nil and not all[i].Pet1:IsNull() then
   UTIL_Remove(all[i].Pet1)
 end	
 if all[i].Pet2 ~= nil and not all[i].Pet2:IsNull() then
   UTIL_Remove(all[i].Pet2)
 end	
 pos1[2]=pos1[2]-125
else
  all[i]:SetAbsOrigin(pos2)
  if all[i].Pet ~= nil and not all[i].Pet:IsNull() then
   UTIL_Remove(all[i].Pet)
   --all[i].Pet:SetAbsOrigin(pos2+Vector(-125,0,0))
 end
 if all[i].Pet1 ~= nil and not all[i].Pet1:IsNull() then
   UTIL_Remove(all[i].Pet1)
 end	
 if all[i].Pet2 ~= nil and not all[i].Pet2:IsNull() then
   UTIL_Remove(all[i].Pet2)
 end	
 pos2[2]=pos2[2]-125
end


PlayerResource:SetCameraTarget(all[i]:GetPlayerOwnerID(), all[i])
Timers:CreateTimer(1.1,function() 
  PlayerResource:SetCameraTarget(all[i]:GetPlayerOwnerID(), nil)
end)

end
end

end
end

--FARM MODE TIME, wait for time to end
if self.GameState == GameState_Farming then
  if self.RoundCountdown == 0 then
   self:EndFarmMode()
 end
 --Arena Time, wait for only one team to survive, healing dampening	
elseif self.GameState == GameState_Arena then
  local teamsAlive = 0
  local lastTeamAlive = 0

  -- reset money all the time during a fight
  local allhero = HeroList:GetAllHeroes()
  --print("found heroes for gold add")
  --print(#all)
  local hero
  for i=1, #allhero do
   hero = allhero[i]
   if hero ~= nil then
    hero:SetGold(0, true)	
    hero:SetGold(0, false)		
  end
end

-- sewers waterfall check
if self.waterfall ~= nil and self.waterfall > 0 then
 self.waterfall = self.waterfall - 1
 if self.waterfall == 3 or self.waterfall == 1 then
  --print("2 or 4")
  local waterunit = Entities:FindByName( nil, "waterfall1" )
  local pos = waterunit:GetAbsOrigin()
  local dummycaster = CreateUnitByName("dummy_aoe_unit", pos, true, nil, nil, 1)
  Timers:CreateTimer(4.0,function() 
   UTIL_Remove(dummycaster)
 end)
  --local pos = waterunit:GetAbsOrigin()
  local particle = ParticleManager:CreateParticle("particles/econ/items/kunkka/divine_anchor/hero_kunkka_dafx_skills/kunkka_spell_torrent_bubbles_fxset.vpcf", PATTACH_POINT_FOLLOW, dummycaster)
  --ParticleManager:SetParticleControl(particle, 0, waterunit:GetAbsOrigin())
  --ParticleManager:SetParticleControl(particle, 1, Vector(1,0,0))
end
if self.waterfall == 0 then
  --print("booooom")
  self.waterfall = 22		
  local waterunit = Entities:FindByName( nil, "waterfall1" )
  local pos = waterunit:GetAbsOrigin()
  --local particle = ParticleManager:CreateParticle("particles/econ/items/kunkka/divine_anchor/hero_kunkka_dafx_skills/kunkka_spell_torrent_splash_fxset.vpcf", PATTACH_WORLDORIGIN, waterunit)
  --ParticleManager:SetParticleControl(particle, 0, waterunit:GetAbsOrigin())
  WaterfallImpact(pos)
end
end

-- if we play alone, testmode
local soloPlaying = false 
if self.testmode or PlayerResource:GetPlayerCount() <= 1 then
 soloPlaying = true
end

for i=1, 10 do
 if self.TeamIsPlaying[i]==1 then
  --print("team " .. i .. "is playing")
  --print("it has " .. self.HeroesAlivePerTeam[i] .. " heroes still alive")
  if self.HeroesAlivePerTeam[i] <= 0 then
   --one team is eliminated
   --EndArena(i)
   --break
 else
   teamsAlive=teamsAlive+1
   lastTeamAlive=i
 end
end
end
--print("teams alive " .. teamsAlive)
if teamsAlive == 1 and soloPlaying == false and self.PVEMode == 0 then
 Timers:CreateTimer(0.5,function() 
  self:EndArena(lastTeamAlive)
end)
 
end
--draw
if teamsAlive == 0 and soloPlaying == false and self.PVEMode == 0 then
 Timers:CreateTimer(0.5,function() 
  self:EndArena(-1)
end)
 
end

if self.PVEMode == 1 then
 self:CastBossSpells()
end

--PVE Mode end is different
--team did wipe
if teamsAlive == 0 and self.PVEMode == 1 then
 Timers:CreateTimer(0.5,function() 
  self:EndPVE(0)
end)
end
--boss got killed
--currentBossUnit:IsNull()
if self.PVEMode == 1 and currentBossUnit ~= nil and ((self.currentBossUnit:IsNull()) or (not self.currentBossUnit:IsAlive())) then
 Timers:CreateTimer(0.5,function() 
  self:EndPVE(1)
end)
end

--rune of detection spawn
if (self.RoundCountdown == 480 or self.RoundCountdown == 420 or self.RoundCountdown == 360 or self.RoundCountdown == 300 or self.RoundCountdown == 240 or self.RoundCountdown == 180 or self.RoundCountdown == 120 or self.RoundCountdown == 60) and self.PVEMode == 0 and false then
 if self.runeofdetection and not self.runeofdetection:IsNull() then
  UTIL_Remove(self.runeofdetection)
  self.runeofdetection = nil
end
EmitGlobalSound("Item.DropGemWorld")
local runepos = Entities:FindByName( nil, "rune_1" ):GetAbsOrigin()
if self.arenachosen == 2 then
  runepos = Entities:FindByName( nil, "rune_2" ):GetAbsOrigin()
end
if self.arenachosen == 3 then
  runepos = Entities:FindByName( nil, "rune_3" ):GetAbsOrigin()
end
if self.arenachosen == 4 then
  runepos = Entities:FindByName( nil, "rune_4" ):GetAbsOrigin()
end
if self.arenachosen == 5 then
  runepos = Entities:FindByName( nil, "rune_5" ):GetAbsOrigin()
end
local rune = CreateItem("item_runeofdetection", nil, nil)
local rune2 = CreateItemOnPositionSync(runepos, rune)
self.runeofdetection = rune2
end

--healing dampening quest title
if self.RoundCountdown == 360 and self.PVEMode == 0 then
  self.Quest = SpawnEntityFromTableSynchronous( "quest", { name = "QuestName", title = "#QuestTimer" } )
  self.Quest.EndTime = 100
  subQuest = SpawnEntityFromTableSynchronous( "subquest_base", { 
    show_progress_bar = true, 
    progress_bar_hue_shift = -119 
  } )
  self.Quest:AddSubquest( subQuest )
  -- text on the quest timer at start
  self.Quest:SetTextReplaceValue( QUEST_TEXT_REPLACE_VALUE_CURRENT_VALUE, 100 )
  self.Quest:SetTextReplaceValue( QUEST_TEXT_REPLACE_VALUE_TARGET_VALUE, 100 )

  -- value on the bar
  subQuest:SetTextReplaceValue( SUBQUEST_TEXT_REPLACE_VALUE_CURRENT_VALUE, 100 )
  subQuest:SetTextReplaceValue( SUBQUEST_TEXT_REPLACE_VALUE_TARGET_VALUE, 100 )

  Timers:CreateTimer(1, function()
   self.Quest.EndTime = self.Quest.EndTime - 1
   if self.Quest.EndTime < 25 then
    self.Quest.EndTime = 25
  end
  self.Quest:SetTextReplaceValue( QUEST_TEXT_REPLACE_VALUE_CURRENT_VALUE, self.Quest.EndTime )
  subQuest:SetTextReplaceValue( QUEST_TEXT_REPLACE_VALUE_CURRENT_VALUE, self.Quest.EndTime )

  -- Finish the quest when the time is up  
  if self.Quest.EndTime == 0 then 
   --EmitGlobalSound("Tutorial.Quest.complete_01") -- Part of game_sounds_music_tutorial
   self.Quest:CompleteQuest()
   return
 else
   return 1 -- Call again every second
 end
end)
end
end



--print("end loop")
for nPlayerID = 0, (DOTA_MAX_TEAM_PLAYERS-1) do
  self:UpdatePlayerColor( nPlayerID )
end
--print("call scoreboard update")
self:UpdateScoreboard()
-- Stop thinking if game is paused
if GameRules:IsGamePaused() == true then
  return 1
end

if self.countdownEnabled == true then
  --print("countdown")
  CountdownTimer()
  if nCOUNTDOWNTIMER == 30 then
   --print("countdown send")
   CustomGameEventManager:Send_ServerToAllClients( "timer_alert", {} )
 end
 if nCOUNTDOWNTIMER <= 0 then
			--[[Check to see if there's a tie
			if self.isGameTied == false then
				GameRules:SetCustomVictoryMessage( self.m_VictoryMessages[self.leadingTeam] )
				COverthrowGameMode:EndGame( self.leadingTeam )
				self.countdownEnabled = false
			else
				self.TEAM_KILLS_TO_WIN = self.leadingTeamScore + 1
				local broadcast_killcount = 
				{
					killcount = self.TEAM_KILLS_TO_WIN
				}
				CustomGameEventManager:Send_ServerToAllClients( "overtime_alert", broadcast_killcount )
			end]]--
    end
  end
  --print("finish loop")
  --if GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
    --Spawn Gold Bags
    --COverthrowGameMode:ThinkGoldDrop()
    --COverthrowGameMode:ThinkSpecialItemDrop()
    --end

    return 1
  end


  function COverthrowGameMode:EndArena(winningteam)
   self.RoundWonPerTeam[winningteam]=self.RoundWonPerTeam[winningteam]+1
   self.RoundCounter=self.RoundCounter+1
   print("increased ROUNDCOUTER +++++++++++++++++++++++++")
   print(self.RoundCounter)
   --EmitGlobalSound("Hero_LegionCommander.Duel.Victory")
   --EmitGlobalSound("DOTA_Item.DoE.Activate")
   --send stats to server
   print("winning team " .. winningteam)
   if self.rankedgame > 0 and winningteam ~= -1 then
    COverthrowGameMode:SendEloResults(winningteam+1)

    if self.endrankedgameafternextreport then
     Timers:CreateTimer(5.0,function() 
      print("ended ranked game")
      self.rankedgame = 0
    end)
   end

   --wait a bit and update tables
   Timers:CreateTimer(3.0,function() 
     print("loading table from server, end of round")
     COverthrowGameMode:ReceiveEloResults(10) --always update
   end)
 end

 --shopping stats
 local timesaver = self.RoundCountdown
 self.RoundCountdown = 55
 self.GameState = GameState_Shopping

 -- sewers arena
 self.waterfall = -1

 if self.RoundWonPerTeam[winningteam]>=self.TEAM_KILLS_TO_WIN then
  --GameRules:SetCustomVictoryMessage( self.m_VictoryMessages[winningteam] )
  --GameRules:SetGameWinner( winningteam )
end


	--Teleport back to shop
	if self.Quest ~= nil and self.Quest.gamelengthquest == nil then
		self.Quest:CompleteQuest()
	end

	COverthrowGameMode:ResetStartVotes()
	self.QuickStartVoteBool = true
	--Teleport back to shop
	local all = HeroList:GetAllHeroes()
	--print("found")
	--print(#all)
	local pos1 = Entities:FindByName( nil, "team_base_1" ):GetAbsOrigin()
	local pos2 = Entities:FindByName( nil, "team_base_2" ):GetAbsOrigin()
	for i=1, #all do
		if all[i]:IsHero() and not (all[i]:IsIllusion()) then
			--print(all[i]:GetName())
			all[i]:RemoveModifierByName("modifier_cyclone")
			all[i]:SetHealth(20000.0)

			-- Combat Reset, Cooldowns Full HP MANA etc
			for j=0,5 do
				if all[i]:GetAbilityByIndex(j) ~= nil then
					all[i]:GetAbilityByIndex(j):EndCooldown()      --TODO revert when all heroes have 6 abilities
				end
			end		
			if all[i].Pet ~= nil and not all[i].Pet:IsNull() then 
				UTIL_Remove(all[i].Pet)
			end
			if all[i].Pet1 ~= nil and not all[i].Pet1:IsNull() then 
				UTIL_Remove(all[i].Pet1)
			end
			if all[i].Pet2 ~= nil and not all[i].Pet2:IsNull() then 
				UTIL_Remove(all[i].Pet2)
			end
			COverthrowGameMode:RemovePetsAfterBattle(all[i])

			if all[i].ArenaControl ~= nil then 
				all[i].ArenaControl:SetRenderColor(255, 0, 0)
				all[i].ArenaControl:SetForwardVector(Vector(0,100,0))
				all[i].ArenaControl.child:SetRenderColor(255, 0, 0)
				all[i].ArenaControl.child:SetForwardVector(Vector(0,100,0))
			end
			local table2 = {}
			table2.Duration = 0.1
      all[i]:GetAbilityByIndex(1):ApplyDataDrivenModifier(all[i], all[i], "modifier_phased", table2)
      if all[i]:GetTeamNumber()==2 then

        all[i]:SetAbsOrigin(pos1)
        pos1[2]=pos1[2]-125	
        if all[i]:GetTeamNumber()==winningteam then
         StartAnimation(all[i], {activity=ACT_DOTA_VICTORY, duration=1.0, rate=1.0})
       end
     else	
      all[i]:SetAbsOrigin(pos2)
      pos2[2]=pos2[2]-125
      if all[i]:GetTeamNumber()==winningteam then
       StartAnimation(all[i], {activity=ACT_DOTA_VICTORY, duration=1.0, rate=1.0})
     end
   end
   --todo move camera
   --PlayerResource:SetCameraTarget(all[i]:GetPlayerOwnerID(), all[i])
   PlayerResource:SetCameraTarget(all[i]:GetPlayerOwnerID(), all[i])
   local saver = i
   Timers:CreateTimer(1.25,function() 
    PlayerResource:SetCameraTarget(all[saver]:GetPlayerOwnerID(), nil)
  end)

   --DPS calculations
   all[i].totaldamagedone = all[i].totaldamagedone + all[i].damagedone
   all[i].totalhealingdone = all[i].totalhealingdone + all[i].healingdone
   local time = 600 - timesaver
   if time <= 0 then
     time = 1
   end
   all[i].totaltimeplayed = all[i].totaltimeplayed + time
   all[i].dpsthisturn = all[i].damagedone / time
   all[i].hpsthisturn = all[i].healingdone / time
   --print("end turn stats")
   --print(all[i].damagedone)
   --print(time)

 end
end

-- determine overtime if enabled
-- determine overtime if enabled
if GameWinConditionExtended == 1 then
  local highkillamount = 0
  for _, team in pairs( self.m_GatheredShuffledTeams ) do
   if GetTeamHeroKills( team ) >= self.PlayersPlaying then
    highkillamount = highkillamount + 1
  end
end
if highkillamount >= 2 then
 GameWinConditionExtended = 2
 print("overtime!")
 self.TEAM_KILLS_TO_WIN = self.TEAM_KILLS_TO_WIN + self.PlayersPlaying*1/2
 print("increase game length by some kills" .. self.PlayersPlaying*2/2)
 CustomNetTables:SetTableValue( "game_state", "victory_condition", { kills_to_win = self.TEAM_KILLS_TO_WIN } );

 -- Quest to show game extension
 self.Quest = SpawnEntityFromTableSynchronous( "quest", { name = "QuestName", title = "#QuestTimerOvertime" } )
 self.Quest.EndTime = 10
 self.Quest.gamelengthquest = 1
 subQuest = SpawnEntityFromTableSynchronous( "subquest_base", { 
  show_progress_bar = true, 
  progress_bar_hue_shift = -119 
} )
 self.Quest:AddSubquest( subQuest )
 -- text on the quest timer at start
 self.Quest:SetTextReplaceValue( QUEST_TEXT_REPLACE_VALUE_CURRENT_VALUE, 10 )
 self.Quest:SetTextReplaceValue( QUEST_TEXT_REPLACE_VALUE_TARGET_VALUE, 10 )

 -- value on the bar
 subQuest:SetTextReplaceValue( SUBQUEST_TEXT_REPLACE_VALUE_CURRENT_VALUE, 10 )
 subQuest:SetTextReplaceValue( SUBQUEST_TEXT_REPLACE_VALUE_TARGET_VALUE, 10 )

 Timers:CreateTimer(1, function()
   self.Quest.EndTime = self.Quest.EndTime - 1
   self.Quest:SetTextReplaceValue( QUEST_TEXT_REPLACE_VALUE_CURRENT_VALUE, self.Quest.EndTime )
   subQuest:SetTextReplaceValue( QUEST_TEXT_REPLACE_VALUE_CURRENT_VALUE, self.Quest.EndTime )

   -- Finish the quest when the time is up  
   if self.Quest.EndTime == 0 then 
     --EmitGlobalSound("Tutorial.Quest.complete_01") -- Part of game_sounds_music_tutorial
     self.Quest.gamelengthquest = nil
     self.Quest:CompleteQuest()
     return
   else
     return 1 -- Call again every second
   end
 end)
end
end

-- determine the winner of the game
local winners = 0
local winner = -1
local winnerkills = 0
for _, team in pairs( self.m_GatheredShuffledTeams ) do
  print("winner variable " .. winners)
  if GetTeamHeroKills( team ) >= self.TEAM_KILLS_TO_WIN and GetTeamHeroKills( team ) > winnerkills then
   winners =  1
   winner = team
   winnerkills = GetTeamHeroKills( team )
   print("team reached victory condition " .. team .. " with kills " .. GetTeamHeroKills( team ) .. " and kills needed " .. self.TEAM_KILLS_TO_WIN)
 elseif GetTeamHeroKills( team ) >= self.TEAM_KILLS_TO_WIN and GetTeamHeroKills( team ) == winnerkills then
   winners = winners + 1
   winner = team
   winnerkills = GetTeamHeroKills( team )
   print("this is called by " .. team)
 end
end
if winners == 1 and self.Winner == nil then
  print("we have only 1 winner")

  local broadcast_kill_event =
  {
    killer_id = -1,
    team_id = winner,
    team_kills = winnerkills,
    kills_remaining = 0,
    victory = 1,
    close_to_victory = 0,
    very_close_to_victory = 0,
  }
  GameRules:SetCustomVictoryMessage( self.m_VictoryMessages[winner] )
  self.Winner = winner
  --COverthrowGameMode:SendEloResults(winner)
  -- extra bonus for winning
  print("send double win bonus for team " .. winner)
  
  if self.rankedgame == 4 or self.rankedgame == 6 then
   Timers:CreateTimer(0.4,function() 
    print("send double win bonus for team first" .. winner)
    COverthrowGameMode:SendEloResults(winner)
  end)
   Timers:CreateTimer(0.8,function() 
     print("send double win bonus for team first 2nd" .. winner)
     COverthrowGameMode:SendEloResults(winner)
   end)
   Timers:CreateTimer(1.5,function() 
     print("send double win bonus for team first 2nd" .. winner)
     COverthrowGameMode:ReportHeroStatistics(winner)
   end)
 end

 Timers:CreateTimer(3.0,function() 
   GameRules:SetGameWinner( winner )
 end)

 CustomGameEventManager:Send_ServerToAllClients( "kill_event", broadcast_kill_event )
elseif winners > 1 then
  print("its a draw, extending one more round")
  self.TEAM_KILLS_TO_WIN = self.TEAM_KILLS_TO_WIN + self.PlayersPlaying*1/2
  CustomNetTables:SetTableValue( "game_state", "victory_condition", { kills_to_win = self.TEAM_KILLS_TO_WIN } );
end

end

function COverthrowGameMode:RemovePetsAfterBattle(caster)
  local enemies = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetAbsOrigin(), caster, 99999, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC, 0, 0, false )
  if #enemies > 0 then
    for _,enemy in pairs(enemies) do
      if enemy ~= nil and (enemy:GetPlayerOwnerID() == caster:GetPlayerOwnerID() or enemy == caster.Pet or enemy == caster.Pet1 or enemy == caster.Pet2) and (enemy:GetUnitLabel() == "pet" or enemy:GetUnitLabel() == "ward") and not enemy:IsNull() then
        UTIL_Remove(enemy)
      end
    end
  end
  if caster.companion then
    for i=1,10 do
      if caster.companion[i] and not caster.companion[i]:IsNull() then
        UTIL_Remove(caster.companion[i])
        caster.companion[i] = nil
      end
    end
  end
  if caster.frostwyrm and not caster.frostwyrm:IsNull() then
    UTIL_Remove(caster.frostwyrm)
    caster.frostwyrm = nil
  end
  if caster.Pet and not caster.Pet:IsNull() then
    UTIL_Remove(caster.Pet)
    caster.Pet = nil
  end
  if caster.hellguard and not caster.hellguard:IsNull() then
    UTIL_Remove(caster.hellguard)
    caster.hellguard = nil
  end
  if caster.shadowimp and not caster.shadowimp:IsNull() then
    UTIL_Remove(caster.shadowimp)
    caster.shadowimp = nil
  end
end

function COverthrowGameMode:SendEloResults(winner)
	--print("send elo lua call")
	local all = HeroList:GetAllHeroes()
	for i=1, #all do
		local player = PlayerResource:GetPlayer(all[i]:GetPlayerID())
		
		if GameRules:PlayerHasCustomGameHostPrivileges(player) then

			if winner >= 95 and self.leaverreported then --if we have reported already, dont report again
				print("skipped duplicate report, fix works")
				return
			end
			if winner >= 95 then --only report leaver once
				self.leaverreported = true
			end
			print("send elo lua call2")
			CustomGameEventManager:Send_ServerToPlayer(player, "send_elo_result", { winningteam = winner } )
		end
	end
end

function COverthrowGameMode:ReportHeroStatistics(winner)
	--print("send elo lua call")
	if not self.rankedgame then
		return  --disable for testing
	end
	local playersabove1550 = 0
	local req = CreateHTTPRequestScriptVM( "POST", "http://catze.eu/reportherostatistics.php" )
	local all = HeroList:GetAllHeroes()
	for i=1, #all do
		if IsServer() then
			local team = all[i]:GetTeamNumber()-1
			local otherteam = 2
			if team == otherteam then
				otherteam = 1
			end
			local winstring = "wins"..i
			local lossesstring = "losses"..i
			local herostring = "hero"..i
			req:SetHTTPRequestGetOrPostParameter(herostring, string.sub(all[i]:GetName(), 15))
			req:SetHTTPRequestGetOrPostParameter(winstring, tostring(self.RoundWonPerTeam[team]))
			req:SetHTTPRequestGetOrPostParameter(lossesstring, tostring(self.RoundWonPerTeam[otherteam]))
			if all[i].gladiator and all[i].gladiator >= 1550 then
				playersabove1550 = playersabove1550 + 1
			end
		end
	end
	print("hero report highlvl players = "..playersabove1550)
	if playersabove1550 >= #all then
		print("sending hero report")
		req:SetHTTPRequestGetOrPostParameter("players", tostring(#all))
		req:Send(function(result)
			print("report hero stats answer")
			print(result)
			print(result.Body)
    end)
	end
end

function COverthrowGameMode:SaveCharSendToServer(data, hero, steamid)
  --print(" try send")
  if IsServer() then
    --print(" try send 2")
    local request = CreateHTTPRequestScriptVM( "POST", "http://catze.eu/savechar_v21_season_10.php" )
    for k,v in pairs(data) do
      request:SetHTTPRequestGetOrPostParameter(k, tostring(v))
    end
    request:Send(function(result)
      --print("save results")
      --print(result)
      --print(result.Body)
      --Notifications:Bottom(hero:GetPlayerID(), {text=result.Body, duration=8, style={color="red"}})
      if result and result.Body and result.Body == "invalid" then
        Notifications:Bottom(hero:GetPlayerID(), {text="Authorization failed!", duration=8, style={color="red"}})
      else
        Notifications:Bottom(hero:GetPlayerID(), {text="Save successful!", duration=8, style={color="lightgreen"}})
      end
      if tostring(steamid) == "95413522" then
        Notifications:Bottom(hero:GetPlayerID(), {text=result, duration=18, style={color="lightgreen"}})
        Notifications:Bottom(hero:GetPlayerID(), {text=result.Body, duration=18, style={color="lightgreen"}})
        print(result.Body)
      end
    end)
  end
end

function COverthrowGameMode:GetSeasonRewards()
	local all = PlayerResource:GetPlayerCount()-1
	for i=0, all do
		local player = PlayerResource:GetPlayer(i)
		if player and GameRules:PlayerHasCustomGameHostPrivileges(player) then
			print("event: getseasonrewards on " .. i)
			--print(PlayerResource:GetPlayerName(i+1))
			local j = 2
			CustomGameEventManager:Send_ServerToPlayer(player, "getseasonrewards", { season = j } )
		end
	end
end

function COverthrowGameMode:CheckForLeavers()
	--print("send elo lua call")
	if self.rankedgame == 0 then
		return
	end
	if not IsServer() then
		return
	end

	local all = HeroList:GetAllHeroes()
	for i=1, #all do
		local id = all[i]:GetPlayerID()
		local player = PlayerResource:GetPlayer(all[i]:GetPlayerID())
		if not all[i].disconnecttime then
			all[i].disconnecttime = 0
		end
		if PlayerResource:GetConnectionState(id) == DOTA_CONNECTION_STATE_DISCONNECTED then
			all[i].disconnecttime = all[i].disconnecttime + 1
    elseif PlayerResource:GetConnectionState(id) == DOTA_CONNECTION_STATE_ABANDONED then
     print("player abandoned")
     all[i].disconnecttime = all[i].disconnecttime + 20
   else
     all[i].disconnecttime = 0
   end
   --print("disc counter " .. all[i].disconnecttime)
   if all[i].disconnecttime >= 120 and self.rankedgame ~= 0 and not self.endrankedgameafternextreport then	
     print("player abandon detect 2")
     if self.GameState == GameState_Arena then
      --during round wait with score denying
      self.endrankedgameafternextreport = true
    else
      self.rankedgame = 0
    end
    
    local disc = id+100
    COverthrowGameMode:SendEloResults(disc) -- this is better, only goes to host
    --COverthrowGameMode:ReceiveEloResults(disc) -- send leaver data to server
    -- update all player tables! after short delay
    if IsServer() then
      CustomGameEventManager:Send_ServerToAllClients("send_leaver_detected", { code = id } )
    end

    Timers:CreateTimer(0.75,function() 
      print("loading table from server, cuz of leaver")
      COverthrowGameMode:ReceiveEloResults(10) --always update
    end)
  end
  --print("player disc time " .. player.disconnecttime)
end
end

function COverthrowGameMode:ReceiveEloResults(code)
	--print("send elo lua call")
	if code >= 95 and self.leaverreported then --if we have reported already, dont report again
		print("skipped duplicate report, fix works")
		return
	end
	if code >= 95 then --only report leaver once
		self.leaverreported = true
	end
	if IsServer() then
		print("call receive elo result, should only once")
		CustomGameEventManager:Send_ServerToAllClients("send_elo_result", { winningteam = code } )
	end
end

--PVE Mode functions -------------------------------------------------------------------------------------

function COverthrowGameMode:CastBossSpells()
	local boss = self.currentBossUnit
	local alreadycast = 0

	if boss.PVEcastcooldown ~= nil then
		boss.PVEcastcooldown = boss.PVEcastcooldown - 1
	else
		boss.PVEcastcooldown = 0
	end

	local target = self:PVEAggroHighest()
	if target then

		if self.currentBossUnit ~= nil and not self.currentBossUnit:IsNull() then
			--print("find 1")
			for i=0, 5 do
				--print("find 2")
				if alreadycast == 0 and boss.PVEcastcooldown <= 0 then
					--print("find 3")

					local ability = boss:GetAbilityByIndex(i)
					--print("casting nr " .. boss.IsCasting)
					--print("abil name " .. ability:GetName())
					if ability ~= nil and ( not ability:IsPassive()) and  ability:GetCooldownTimeRemaining() <= 0.0 and not boss:HasModifier("modifier_stunned") and not boss:HasModifier("modifier_silence") then
						--print("find 4")
						local order = 
						{
             UnitIndex = boss:entindex(),
             OrderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
             AbilityIndex = ability:GetEntityIndex(), 
             Queue = false
             --TargetIndex = caster.creepertarget:entindex()
           }

           ExecuteOrderFromTable(order)
           --print(ability:GetCastPoint(0))
           --if ability:GetCastPoint(0) > 1.0 then
            --	Timers:CreateTimer(0.1,function() 
            --        ability:Start
            --    end)
            --end
            --print("did cast")
            --print(ability:GetName())
            alreadycast = 1
            boss.PVEcastcooldown = 3
          end
        end
      end
    end
    if alreadycast == 0 then
     --print("aggro search")

     --print(target:GetName())
     local order = 
     {
      UnitIndex = boss:entindex(),
      OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
      TargetIndex = target:entindex()
    }
    ExecuteOrderFromTable(order)

  end
end
--add attack order
local add = boss.PVEAdd1
if boss.PVEAdd1 and not boss.PVEAdd1:IsNull() and boss.PVEAdd1:IsAlive() then
  local t = self:PVEAggroLowest()
  if t  then
   local order = 
   {
    UnitIndex = add:entindex(),
    OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
    TargetIndex = t:entindex()
  }
  ExecuteOrderFromTable(order)
end
end
end

function UnitAI(event)
	COverthrowGameMode:UnitAI(event)
end

function GetNextAbilityInRotation(boss)
	if not boss.next_ability then
		boss.next_ability = 0
	end
	local index = boss.next_ability
	local ability
	--search in remaining abilities
	for j=index, 6 do
		ability = boss:GetAbilityByIndex(j)
		if ability and not ability:IsPassive() then
			boss.next_ability = j
			return ability
		end
	end
	--found none, try search in all abilities, restarting rotation
  --boss.next_ability = -1
  --return nil
  for j=0, 6 do
    ability = boss:GetAbilityByIndex(j)
    if ability and not ability:IsPassive() then
     boss.next_ability = j
     return ability
   end
 end
 return nil
end

function SetNextAbilityInRotation(boss)
	if not boss.next_ability then
		boss.next_ability = 0
	end
	boss.next_ability = boss.next_ability + 1
	--print("next abil set "..boss.next_ability)
end

function GetLastAbilityInRotation( boss )
  local ab = nil
  for j=0, 6 do
    local ability = boss:GetAbilityByIndex(j)
    if ability and not ability:IsPassive() then
      ab = ability
    end
  end
  return ab
end


function COverthrowGameMode:UnitAI(event)
	local tickFrequency = 1
	local boss = event.caster
	if boss then
		if boss:IsNull() then
			return
		end
		if not boss:IsAlive() then
			return
		end
    if boss:HasModifier("modifier_spike_trap") then
      return
    end
  end
  if boss:HasModifier("modifier_temple_stone_seal") or boss.is_leaping then
    return
  end

  --fix portal warp
  if not boss.portalAbilityRemoved then
    local portalAbility = boss:FindAbilityByName("twin_gate_portal_warp")
    if portalAbility then
      boss:RemoveAbility("twin_gate_portal_warp")
      boss.portalAbilityRemoved = true
    end
  end

  --print(event.caster:GetEntityIndex())
  --print(event.caster:GetUnitName())
  --print(event.caster:GetHealth())
  local alreadycast = 0
  local cooldown = 12 --9 in 5.4 patch
  local maniac_affix = false
  if boss:HasModifier("modifier_affix_maniac") then
    maniac_affix = true
    cooldown = cooldown / 2
  end
  if boss.global_cooldown_factor then
    cooldown = cooldown * boss.global_cooldown_factor
  end
  --goblin wants to flee!
  if boss:HasModifier("modifier_loot_goblin") and boss:GetHealth() / boss:GetMaxHealth() < 1 then
    if not boss.loot_goblin_order_position and boss.loot_goblin_flee_mode_straight then
      local order_position = Entities:FindByName( nil, "boss5" ):GetAbsOrigin()
      local distance_to_order_position = (boss:GetAbsOrigin() - order_position):Length()
      if (boss:GetAbsOrigin() - Entities:FindByName( nil, "boss23" ):GetAbsOrigin()):Length() > distance_to_order_position then
        distance_to_order_position = (boss:GetAbsOrigin() - Entities:FindByName( nil, "boss23" ):GetAbsOrigin()):Length()
        order_position = Entities:FindByName( nil, "boss23" ):GetAbsOrigin()
      end
      if (boss:GetAbsOrigin() - Entities:FindByName( nil, "mogushan" ):GetAbsOrigin()):Length() > distance_to_order_position then
        order_position = Entities:FindByName( nil, "mogushan" ):GetAbsOrigin()
      end
      boss.loot_goblin_order_position = order_position
    end
    if boss.loot_goblin_flee_mode_changing then
      --local order_position = {}
      --order_position[1] = Entities:FindByName( nil, "boss5" ):GetAbsOrigin()
      --order_position[2] = Entities:FindByName( nil, "boss23" ):GetAbsOrigin()
      --order_position[3] = Entities:FindByName( nil, "mogushan" ):GetAbsOrigin()
      local order_position
      if not boss.loot_goblin_order_position then
        order_position = boss:GetAbsOrigin() + RandomVector(1000)
        boss.loot_goblin_order_position = order_position
      else
        order_position = boss.loot_goblin_order_position + RandomVector(900)
        boss.loot_goblin_order_position = order_position
      end
    end
    local order = 
    {
      UnitIndex = boss:entindex(),
      OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
      Position = boss.loot_goblin_order_position,
      Queue = false
    }
    ExecuteOrderFromTable(order)
    if not boss.loot_goblin_timer then
      boss.loot_goblin_timer = 30
    end
    boss.loot_goblin_timer = boss.loot_goblin_timer - tickFrequency
    DecreaseBuffStack({caster = boss, amount = 3, buff = "modifier_loot_hoarder_damage_reduction"})
    if boss and boss.loot_goblin_timer <= 0 and not boss:IsNull() and boss:IsAlive() then
      UTIL_Remove(boss)
    end
    return
  end
  if boss.hascombatphases then
    local hpregion = boss:GetHealth() / boss:GetMaxHealth()
    for i=1, boss.hascombatphases do
     if hpregion <= i / boss.hascombatphases then
      if i ~= boss.combatphase then
       --entering new phase
       boss.combatphase = i
       --remove all other abilities
       boss:RemoveAbility("pve_temple_emp")
       boss:RemoveAbility("pve_temple_arcane_barrage_aoe")
       boss:RemoveAbility("pve_temple_iceberg_linear")
       boss:RemoveAbility("pve_temple_aoe_dmg_range_invert_knockback")
       --boss:RemoveAbility("pve_temple_dot_furthest_frost")
       boss:RemoveAbility("pve_shadow_summon_at_each")
       boss:RemoveAbility("pve_temple_dot_furthest_shadow_spread")
       boss:RemoveAbility("pve_temple_reflect_buffs_invoker")
       boss:RemoveAbility("pve_temple_fireball_random")
       boss:RemoveAbility("pve_temple_random_aoe_explosion")
       boss:RemoveAbility("pve_temple_fireball_ritual_hard_1")
       boss:RemoveAbility("pve_temple_fireball_ritual_hard_2")
       boss:RemoveAbility("pve_temple_invoker_arcane_totems")
       boss:RemoveAbility("pve_temple_one_fat_blizzard")
       
       if i == 4 then
        --add new
        boss:AddAbility("pve_temple_invoker_arcane_totems"):SetLevel(1)
        boss:AddAbility("pve_temple_emp"):SetLevel(1)
        boss:AddAbility("pve_temple_arcane_barrage_aoe"):SetLevel(1)
      end
      if i == 1 then
        boss:AddAbility("pve_shadow_summon_at_each"):SetLevel(1)
        boss:AddAbility("pve_temple_dot_furthest_shadow_spread"):SetLevel(1)
        boss:AddAbility("pve_temple_reflect_buffs_invoker"):SetLevel(1)
      end
      if i == 3 then
        boss:AddAbility("pve_temple_iceberg_linear"):SetLevel(1)
        boss:AddAbility("pve_temple_aoe_dmg_range_invert_knockback"):SetLevel(1)
        --boss:AddAbility("pve_temple_dot_furthest_frost"):SetLevel(1)
        boss:AddAbility("pve_temple_one_fat_blizzard"):SetLevel(1)
      end
      if i == 2 then
        boss:AddAbility("pve_temple_fireball_random"):SetLevel(1)
        boss:AddAbility("pve_temple_random_aoe_explosion"):SetLevel(1)
        boss:AddAbility("pve_temple_fireball_ritual_hard_1"):SetLevel(1)
        boss:AddAbility("pve_temple_fireball_ritual_hard_2"):SetLevel(1)
      end
    end
    break
  end
end
end

--dont leave spawn area
if boss.temple_spawn_spot then
  if (boss.temple_spawn_spot-boss:GetAbsOrigin()):Length() > 4000 then
   local RemovePositiveBuffs = false
   local RemoveDebuffs = true
   local BuffsCreatedThisFrameOnly = false
   local RemoveStuns = true
   local RemoveExceptions = false
   local particle = ParticleManager:CreateParticle("particles/econ/events/ti5/blink_dagger_start_smoke_ti5.vpcf", PATTACH_POINT_FOLLOW, boss)
   ParticleManager:ReleaseParticleIndex(particle)
   boss:Stop()
   boss:Purge( RemovePositiveBuffs, RemoveDebuffs, BuffsCreatedThisFrameOnly, RemoveStuns, RemoveExceptions)
   boss:SetAbsOrigin(boss.temple_spawn_spot)
   boss:SetHealth(boss:GetMaxHealth())
   if boss.aggrolist then
    for i=0, 30 do
      boss.aggrolist[i] = 0
    end
  end
end
end

--report affixes
if not boss.affixes_discovered and IsHeroNear( boss, 1300 ) and not boss:HasModifier("modifier_loot_goblin") and not boss:HasModifier("modifier_invisible") then
  boss.affixes_discovered = true
  PVEUnitDiscoverAffixes(boss)
end

--dont break channels
if boss:HasModifier("modifier_tranq") then -- or (boss:HasModifier("modifier_shieldreflect") and not boss:HasModifier("modifier_phased")) then
  return
end

--has custom global cooldown
if boss.temple_cooldown then
  cooldown = boss.temple_cooldown
end


	local target = self:AggroHighest(boss)
	if boss:HasModifier("modifier_lowest_aggro_hunt") then
    target = self:AggroLowest(boss)
  end
  if boss:HasModifier("modifier_aggro_highest_hp") then
    target = self:AggroLowestHP(boss)
  end
  if boss:HasModifier("modifier_aggro_ranged") then
    local new_target = self:AggroRangedPreferred(boss)
    if new_target then
      target = new_target
    end
  end
  if boss:HasModifier("modifier_aggro_armor") then
    local new_target = self:AggroLowestArmor(boss)
    if new_target then
      target = new_target
    end
  end
  if boss:HasModifier("modifier_aggro_mres") then
    local new_target = self:AggroLowestMres(boss)
    if new_target then
      target = new_target
    end
  end
  if boss.cycling_aggro_target and not boss.cycling_aggro_target:IsNull() and boss.cycling_aggro_target:IsAlive() and (boss:GetAbsOrigin() - boss.cycling_aggro_target:GetAbsOrigin()):Length() < 2500 then
    target = boss.cycling_aggro_target
  end
  if target and not target:IsNull() then

    --stuck protection, tested, doesnt report FALSE when stuck in trees, so its useless
    if boss.unitSpawnPosition and not boss.noStuckProtection then
      local destinationReachable = GridNav:CanFindPath(boss:GetAbsOrigin(), target:GetAbsOrigin())
      --print(destinationReachable)
      --print(boss:GetName())
      if not destinationReachable then
        if not boss.stuckTime then
          boss.stuckTime = 0
        end
        boss.stuckTime = boss.stuckTime + tickFrequency
        if boss.stuckTime >= 10 then
          boss:SetAbsOrigin(GetValidSpawnPosition(boss))
          boss.stuckTime = 0
          --print("reset")
        end
        return
      else
        boss.stuckTime = 0
      end
    end

    if not CheckForCC(boss) and not CheckForSilence(boss) then
      if not maniac_affix then
        if not boss:HasModifier("modifier_invisible") then
         --get next ability in rotation
         local ability = GetNextAbilityInRotation(boss)
        if ability and ability:GetCooldownTimeRemaining() <= 0.0 then
          --cast it if it has no cd
          --print("cast correct ".. ability:GetName())
          --yes, cast it
          local order = 
          {
            UnitIndex = boss:entindex(),
            OrderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
            AbilityIndex = ability:GetEntityIndex(), 
            Queue = false
          }

          ExecuteOrderFromTable(order)

          --increased cd after full rotation
          if ability == GetLastAbilityInRotation(boss) then
            cooldown = 1.25 * cooldown
          end

          --global cd
          for j=0, 6 do
           local a = boss:GetAbilityByIndex(j)
          if a and a ~= ability and not a:IsPassive() and a:GetCooldownTimeRemaining() < cooldown then
            if a ~= ability then
              a:EndCooldown()
              a:StartCooldown(cooldown)
            end
          end
        end
        alreadycast = 1
        --set next ability in rotation
        SetNextAbilityInRotation(boss)
      end
      --if we cant cast our rotation, cast any spell
      if alreadycast == 0 then
        for i=0, 6 do
         if alreadycast == 0 then
          ability = boss:GetAbilityByIndex(i)
          if ability and ( not ability:IsPassive()) and ability:GetCooldownTimeRemaining() <= 0.0 then
           --print("cast first available")
           local order = 
           {
            UnitIndex = boss:entindex(),
            OrderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
            AbilityIndex = ability:GetEntityIndex(), 
            Queue = false
          }

          ExecuteOrderFromTable(order)

          for j=0, 6 do
            local a = boss:GetAbilityByIndex(j)
            if a and a ~= ability and not a:IsPassive() and a:GetCooldownTimeRemaining() < cooldown then
              if a ~= ability then
                a:EndCooldown()
                a:StartCooldown(cooldown)
              end
            end
          end
          alreadycast = 1
          --boss.PVEcastcooldown = 3
        end
      end
    end
  end
end
else
  --maniac! random spell chosen
  if alreadycast == 0 and not boss:HasModifier("modifier_invisible") then
   local ability_list = {}
   local index = 1
   --find candidates
   for i=0, 6 do
    local ability = boss:GetAbilityByIndex(i)
    if ability and not ability:IsPassive() and ability:GetCooldownTimeRemaining() <= 0.0 then
     ability_list[index] = ability
     index = index + 1
   end
 end
 --choose candidate
 if #ability_list > 0 then
  local ability = ability_list[math.random(1,#ability_list)]
  local order = 
  {
    UnitIndex = boss:entindex(),
    OrderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
    AbilityIndex = ability:GetEntityIndex(), 
    Queue = false
  }

  ExecuteOrderFromTable(order)

  for j=0, 6 do
    local a = boss:GetAbilityByIndex(j)
    if a and a ~= ability and not a:IsPassive() and a:GetCooldownTimeRemaining() < cooldown then
      if a ~= ability then
        a:EndCooldown()
        a:StartCooldown(cooldown)
      end
    end
  end
  alreadycast = 1
end
end
end
end
if alreadycast == 0 then
  if target:HasModifier("modifier_pet_system") then
    --patrol towards pet position, since we cant target it
    local order = 
    {
      UnitIndex = boss:entindex(),
      OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
      Position = target:GetAbsOrigin(),
      Queue = false
    }
    ExecuteOrderFromTable(order)
    return
  end
  local order = 
  {
    UnitIndex = boss:entindex(),
    OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
    TargetIndex = target:entindex()
  }
  ExecuteOrderFromTable(order)
end
else
  -- we found no close (aggro) target, are we patrolling?
  if boss.patrolling and boss.patrolling_path then
    if not boss.patrollingCounter then
      boss.patrollingCounter = 0
    end
    boss.patrollingCounter = boss.patrollingCounter + 1
    if boss.patrollingCounter < 15 then
      return
    end
    boss.patrollingCounter = 0
    local destination = boss.patrolling_path[boss.patrolling]
    local pos = boss:GetAbsOrigin()
    if destination and pos then
      local distance = (pos-destination):Length()
      if distance < 250 then
       boss.patrolling = boss.patrolling + 1
       if boss.patrolling > 3 then
        boss.patrolling = 1
      end
      destination = boss.patrolling_path[boss.patrolling]
    end
    local order = 
    {
      UnitIndex = boss:entindex(),
      OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
      Position = destination
    }
    ExecuteOrderFromTable(order)
  end
end
end
end

function GetValidSpawnPosition(unit)
  local unitPos = unit:GetAbsOrigin()
  local spawnPos = unit.unitSpawnPosition
  local targetPos = COverthrowGameMode.treeoflife:GetAbsOrigin() --just something on the main map area (not titan island)
  if spawnPos then
    local destinationReachable = GridNav:CanFindPath(spawnPos, targetPos)
    if destinationReachable then
      return spawnPos
    end
  end
  for i=1, 5 do --test a few other random spots, maybe lucky
    local newPos = unitPos + RandomVector(1000)
    local destinationReachable = GridNav:CanFindPath(newPos, targetPos)
    if destinationReachable then
      return newPos
    end
    --print("iteration " .. i)
  end
  return unitPos
end

function COverthrowGameMode:PVEClearMobs()
	local all = HeroList:GetAllHeroes()
	local enemies = FindUnitsInRadius( DOTA_TEAM_BADGUYS, Vector(0,0,0), all[1], 500000.0, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	--print(#enemies)
	if #enemies > 0 then
		for _,enemy in pairs(enemies) do
			if enemy ~= nil then
				if enemy:GetUnitLabel()=="pveboss" or enemy:GetUnitLabel()=="pve" or enemy:GetUnitLabel()=="hero" then
					UTIL_Remove(enemy)
				end
			end
		end
	end
end

function COverthrowGameMode:PopulateDungeon(round)
	self:PVEClearMobs()
	local p21 = Entities:FindByName( nil, "pve_team1_2_1" ):GetAbsOrigin()
	local p22 = Entities:FindByName( nil, "pve_team1_2_2" ):GetAbsOrigin()
	local p23 = Entities:FindByName( nil, "pve_team1_2_3" ):GetAbsOrigin()
	local p3 = Entities:FindByName( nil, "pve_team1_3" ):GetAbsOrigin()
	local p41 = Entities:FindByName( nil, "pve_team1_4_1" ):GetAbsOrigin()
	local p42 = Entities:FindByName( nil, "pve_team1_4_2" ):GetAbsOrigin()
	local p43 = Entities:FindByName( nil, "pve_team1_4_3" ):GetAbsOrigin()
	local p5 = Entities:FindByName( nil, "pve_team1_5" ):GetAbsOrigin()
	local p61 = Entities:FindByName( nil, "pve_team1_6_1" ):GetAbsOrigin()
	local p62 = Entities:FindByName( nil, "pve_team1_6_2" ):GetAbsOrigin()
	local p7 = Entities:FindByName( nil, "pve_team1_7" ):GetAbsOrigin()

	
	--print("r value " .. round)
	--old scale: local scale = 1.35 + ((round - 2)/6.0)
	local scale = (1.15 + ((round - 2)/6.0))
	if scale < 0.5 then
		scale = 0.5
	end
	--scale = scale *(1.0 + 0.55*((PlayerResource:GetPlayerCount()) / 2))
	--un even players, observer!
	if (PlayerResource:GetPlayerCount() % 2) == 1 then
		scale = scale *(1.0 + 0.55*((PlayerResource:GetPlayerCount()-1) / 2))
	else
		scale = scale *(1.0 + 0.55*((PlayerResource:GetPlayerCount()) / 2))
	end
	for i=1, 2 do
		if i == 2 then
			p21 = Entities:FindByName( nil, "pve_team2_2_1" ):GetAbsOrigin()
			p22 = Entities:FindByName( nil, "pve_team2_2_2" ):GetAbsOrigin()
			p23 = Entities:FindByName( nil, "pve_team2_2_3" ):GetAbsOrigin()
			p3 = Entities:FindByName( nil, "pve_team2_3" ):GetAbsOrigin()
			p41 = Entities:FindByName( nil, "pve_team2_4_1" ):GetAbsOrigin()
			p42 = Entities:FindByName( nil, "pve_team2_4_2" ):GetAbsOrigin()
			p43 = Entities:FindByName( nil, "pve_team2_4_3" ):GetAbsOrigin()
			p5 = Entities:FindByName( nil, "pve_team2_5" ):GetAbsOrigin()
			p61 = Entities:FindByName( nil, "pve_team2_6_1" ):GetAbsOrigin()
			p62 = Entities:FindByName( nil, "pve_team2_6_2" ):GetAbsOrigin()
			p7 = Entities:FindByName( nil, "pve_team2_7" ):GetAbsOrigin()
		end
		if round == 4 then
			local unit
			unit = CreateUnitByName("pve_spider", p21, true, nil, nil, DOTA_TEAM_BADGUYS )
			self:SetPVEStats(unit,scale,5,250,1)
			unit = CreateUnitByName("pve_spiderranged", p22, true, nil, nil, DOTA_TEAM_BADGUYS )
			self:SetPVEStats(unit,scale,8,150,1)
			unit = CreateUnitByName("pve_spiderranged", p23, true, nil, nil, DOTA_TEAM_BADGUYS )
			self:SetPVEStats(unit,scale,8,150,1)
			unit = CreateUnitByName("pve_spiderboss", p3, true, nil, nil, DOTA_TEAM_BADGUYS )
			self:SetPVEStats(unit,scale,10,650,2)

			unit = CreateUnitByName("pve_spidertank", p41, true, nil, nil, DOTA_TEAM_BADGUYS )
			self:SetPVEStats(unit,scale,5,200,1)
			unit = CreateUnitByName("pve_spiderranged", p42, true, nil, nil, DOTA_TEAM_BADGUYS )
			self:SetPVEStats(unit,scale,8,150,1)
			unit = CreateUnitByName("pve_spiderranged", p43, true, nil, nil, DOTA_TEAM_BADGUYS )
			self:SetPVEStats(unit,scale,8,150,1)
			unit = CreateUnitByName("pve_undyingboss", p5, true, nil, nil, DOTA_TEAM_BADGUYS )
			self:SetPVEStats(unit,scale,11,750,2)

			unit = CreateUnitByName("pve_undyingtank", p61, true, nil, nil, DOTA_TEAM_BADGUYS )
			self:SetPVEStats(unit,scale,15,250,1)
			unit = CreateUnitByName("pve_undyingtank", p62, true, nil, nil, DOTA_TEAM_BADGUYS )
			self:SetPVEStats(unit,scale,15,250,1)
			unit = CreateUnitByName("pve_skeleboss", p7, true, nil, nil, DOTA_TEAM_BADGUYS )
			self:SetPVEStats(unit,scale,18,750,2)
			unit.islastboss = 1
			--boss = CreateUnitByName("npc_dota_creature_pveboss1", q3, true, nil, nil, DOTA_TEAM_BADGUYS )
			
		end

		if round == 8 then
			local unit
			unit = CreateUnitByName("pve_beartank", p21, true, nil, nil, DOTA_TEAM_BADGUYS )
			self:SetPVEStats(unit,scale,8,180,1)
			unit = CreateUnitByName("pve_beartank", p22, true, nil, nil, DOTA_TEAM_BADGUYS )
			self:SetPVEStats(unit,scale,8,180,1)
			unit = CreateUnitByName("pve_beartank", p23, true, nil, nil, DOTA_TEAM_BADGUYS )
			self:SetPVEStats(unit,scale,8,180,1)
			unit = CreateUnitByName("pve_bearboss", p3, true, nil, nil, DOTA_TEAM_BADGUYS )
			self:SetPVEStats(unit,scale,10,700,2)

			unit = CreateUnitByName("pve_beartank", p41, true, nil, nil, DOTA_TEAM_BADGUYS )
			self:SetPVEStats(unit,scale,8,150,1)
			unit = CreateUnitByName("pve_bearstunner", p42, true, nil, nil, DOTA_TEAM_BADGUYS )
			self:SetPVEStats(unit,scale,5,150,1)
			unit = CreateUnitByName("pve_bearstunner", p43, true, nil, nil, DOTA_TEAM_BADGUYS )
			self:SetPVEStats(unit,scale,5,150,1)
			unit = CreateUnitByName("pve_bearboss2", p5, true, nil, nil, DOTA_TEAM_BADGUYS )
			self:SetPVEStats(unit,scale,15,750,2)

			unit = CreateUnitByName("pve_mountaingiant", p61, true, nil, nil, DOTA_TEAM_BADGUYS )
			self:SetPVEStats(unit,scale,60,225,1)
			unit = CreateUnitByName("pve_mountaingiant", p62, true, nil, nil, DOTA_TEAM_BADGUYS )
			self:SetPVEStats(unit,scale,60,225,1)
			unit = CreateUnitByName("pve_bearboss3", p7, true, nil, nil, DOTA_TEAM_BADGUYS )
			self:SetPVEStats(unit,scale,14,800,2)
			unit.islastboss = 1
			--boss = CreateUnitByName("npc_dota_creature_pveboss1", q3, true, nil, nil, DOTA_TEAM_BADGUYS )
			
		end
		if round == 12 then
			local unit
			unit = CreateUnitByName("pve_lizard", p21, true, nil, nil, DOTA_TEAM_BADGUYS )
			self:SetPVEStats(unit,scale,9,100,1)
			unit = CreateUnitByName("pve_lizard", p22, true, nil, nil, DOTA_TEAM_BADGUYS )
			self:SetPVEStats(unit,scale,9,100,1)
			unit = CreateUnitByName("pve_lizard", p23, true, nil, nil, DOTA_TEAM_BADGUYS )
			self:SetPVEStats(unit,scale,9,100,1)
			unit = CreateUnitByName("pve_dragonboss", p3, true, nil, nil, DOTA_TEAM_BADGUYS )
			self:SetPVEStats(unit,scale,10,700,3)

			unit = CreateUnitByName("pve_lizard2", p41, true, nil, nil, DOTA_TEAM_BADGUYS )
			self:SetPVEStats(unit,scale,5,150,1)
			unit = CreateUnitByName("pve_lizard3", p42, true, nil, nil, DOTA_TEAM_BADGUYS )
			self:SetPVEStats(unit,scale,18,75,1)
			unit = CreateUnitByName("pve_lizard3", p43, true, nil, nil, DOTA_TEAM_BADGUYS )
			self:SetPVEStats(unit,scale,18,75,1)
			unit = CreateUnitByName("pve_dragonboss2", p5, true, nil, nil, DOTA_TEAM_BADGUYS )
			self:SetPVEStats(unit,scale,13,700,3)

			unit = CreateUnitByName("pve_lizard", p61, true, nil, nil, DOTA_TEAM_BADGUYS )
			self:SetPVEStats(unit,scale,20,130,1)
			unit = CreateUnitByName("pve_lizard", p62, true, nil, nil, DOTA_TEAM_BADGUYS )
			self:SetPVEStats(unit,scale,20,130,1)
			unit = CreateUnitByName("pve_dragonboss3", p7, true, nil, nil, DOTA_TEAM_BADGUYS )
			self:SetPVEStats(unit,scale,19,900,3)
			unit.islastboss = 1
			--boss = CreateUnitByName("npc_dota_creature_pveboss1", q3, true, nil, nil, DOTA_TEAM_BADGUYS )
		end
	end
end

function PVEAreaTeleport(event)
	if COverthrowGameMode.GameState ~= GameState_Farming then
		return
	end
	local unit = event.caster.controlowner
	local pos = Entities:FindByName( nil, "pve_team1_1" ):GetAbsOrigin()
	if unit:GetTeamNumber() == 3 then
		pos = Entities:FindByName( nil, "pve_team2_1" ):GetAbsOrigin()
	end
	if unit:HasModifier("modifier_isinbase") then
		unit:SetAbsOrigin(pos)
		local abil = unit:GetAbilityByIndex(0)
		if abil then
			local tab = {}
			tab.Duration = 0.25
			abil:ApplyDataDrivenModifier(unit, unit, "modifier_phased", tab)
		end
		PlayerResource:SetCameraTarget(unit:GetPlayerOwnerID(), unit)
		Timers:CreateTimer(1.25,function() 
     PlayerResource:SetCameraTarget(unit:GetPlayerOwnerID(), nil)
   end)
	end
end

function COverthrowGameMode:SetSummonPVEStats(event)
  SetPVEStats(event)
end

function SetPVEStats(event)
  local caster = event.caster
  local target = event.target
  if event.caster and not event.caster:IsNull() then
    if event.setowner then
     event.target.owner = event.caster
   end
   local reward = 0
   if event.reward then
     reward = event.reward
   end
   if event.modelsize then
     event.target:SetModelScale(event.modelsize)
   end
   if event.actboss then
     event.target.act = event.actboss
   end
   if event.damageimune then
    event.target.damageimune = true
  end
  if event.noexp then
    target.noexp = 1
  end
  if event.destroyonmasterdeath then
    caster.destroysummonsondeath = true
    if not caster.summons then
      caster.summons = {}
    end
    table.insert(caster.summons, target)
  end
  local scale = event.caster.pvescale
  --print("pve scale " .. scale .. " " .. event.caster:GetUnitName() .. event.target:GetUnitName() .. " reward" .. reward)
  COverthrowGameMode:SetTempleStats(event.target, scale, event.dmg, event.hp, reward, 0)
end
end

function SetSummonTempleStats(event)
	local scale = event.caster.pvescale
	if event.modelsize then
		event.target:SetModelScale(event.modelsize)
	end
	if event.noexp then
		event.target.noexp = 1
	end
  if event.damageimune then
    event.target.damageimune = true
  end
  COverthrowGameMode:SetTempleStats(event.target, scale, event.dmg, event.hp, 0, 0)
end

function PVEItemDrop(event)
	--local scale = event.caster.pvescale
	if event.unit.islastboss and COverthrowGameMode.RoundCountdown > 30 then
		COverthrowGameMode.RoundCountdown = 30
	end
	if event.caster.rewardchance then
		--print("chance " .. event.caster.rewardchance)

		--special summons
		if event.caster.sandevent then
			if COverthrowGameMode.sandevent then
				COverthrowGameMode.sandevent = COverthrowGameMode.sandevent + 1
			else
				COverthrowGameMode.sandevent = 1
			end
			if COverthrowGameMode.sandevent == 6 then
				local b4 = Entities:FindByName( nil, "camp7" ):GetAbsOrigin()+Vector(250,-2200,-128)
        --lama
        local unit = CreateUnitByName("act_2_lama", b4+Vector(0,-225,0), true, nil, nil, DOTA_TEAM_GOODGUYS )
        local lama = unit
        unit:SetForwardVector(Vector(0,-1,0))
        unit:GetAbilityByIndex(0):ApplyDataDrivenModifier(unit, unit, "modifier_invulnerable", {Duration = -1})
        unit = CreateUnitByName("act_2_lama", b4+Vector(-90,-190,0), true, nil, nil, DOTA_TEAM_GOODGUYS )
        lama.lama = unit
        unit:SetForwardVector(Vector(0,-1,0))
        unit:GetAbilityByIndex(0):ApplyDataDrivenModifier(unit, unit, "modifier_invulnerable", {Duration = -1})
        unit = CreateUnitByName("act_2_lama", b4+Vector(90,-190,0), true, nil, nil, DOTA_TEAM_GOODGUYS )
        lama.lama.lama = unit
        unit:SetForwardVector(Vector(0,-1,0))
        unit:GetAbilityByIndex(0):ApplyDataDrivenModifier(unit, unit, "modifier_invulnerable", {Duration = -1})
        --furycat
        unit = CreateUnitByName("temple_sand_boss_4", b4, true, nil, nil, DOTA_TEAM_BADGUYS )
        unit.act = 2
        unit.act_specific_loot_factor = 3
        COverthrowGameMode:SetTempleStats(unit,COverthrowGameMode.jungledifficulty*1.1,200,25000,100, 0)
        unit.templeboss_sandviper = 1
        unit.quest_furycat = 1
        unit:SetForwardVector(Vector(0,-1,0))
        unit.cinematic_lama = lama
        SetCinematicApproachMessage( unit, 2 )

        --quest
        COverthrowGameMode.Quest = SpawnEntityFromTableSynchronous( "quest", { name = "QuestName", title = "#QuestTimerTempleEventSand" } )

        COverthrowGameMode.Quest.EndTime = 25
        subQuest = SpawnEntityFromTableSynchronous( "subquest_base", { 
          show_progress_bar = true, 
          progress_bar_hue_shift = -119 
        } )
        COverthrowGameMode.Quest:AddSubquest( subQuest )
        -- text on the quest timer at start
        COverthrowGameMode.Quest:SetTextReplaceValue( QUEST_TEXT_REPLACE_VALUE_CURRENT_VALUE, 100 )
        COverthrowGameMode.Quest:SetTextReplaceValue( QUEST_TEXT_REPLACE_VALUE_TARGET_VALUE, 100 )

        -- value on the bar
        subQuest:SetTextReplaceValue( SUBQUEST_TEXT_REPLACE_VALUE_CURRENT_VALUE, 100 )
        subQuest:SetTextReplaceValue( SUBQUEST_TEXT_REPLACE_VALUE_TARGET_VALUE, 100 )

        Timers:CreateTimer(1, function()
         if COverthrowGameMode.Quest ~= nil then
          COverthrowGameMode.Quest.EndTime = COverthrowGameMode.Quest.EndTime - 1
          COverthrowGameMode.Quest:SetTextReplaceValue( QUEST_TEXT_REPLACE_VALUE_CURRENT_VALUE, COverthrowGameMode.Quest.EndTime )
          subQuest:SetTextReplaceValue( QUEST_TEXT_REPLACE_VALUE_CURRENT_VALUE, COverthrowGameMode.Quest.EndTime )

          -- Finish the quest when the time is up  
          if COverthrowGameMode.Quest.EndTime <= 0 then 
           --EmitGlobalSound("Tutorial.Quest.complete_01") -- Part of game_sounds_music_tutorial
           COverthrowGameMode.Quest:CompleteQuest()
           return
         else
           return 1 -- Call again every second
         end
       end
     end)
      end
    end
    if event.caster.waterevent then
     if COverthrowGameMode.waterevent then
      COverthrowGameMode.waterevent = COverthrowGameMode.waterevent + 1
    else
      COverthrowGameMode.waterevent = 1
    end
    if COverthrowGameMode.sandevent and COverthrowGameMode.sandevent >= 4 and COverthrowGameMode.waterevent and COverthrowGameMode.waterevent >= 4 then
      --nothing
    end
  end

  --mogushan spawning
  if event.caster.templeboss_mogushan then
    COverthrowGameMode.mogushankills = COverthrowGameMode.mogushankills + 1
    local round = math.floor(COverthrowGameMode.mogushankills)
    if round < COverthrowGameMode.max_mogushan_rounds then
      Notifications:BottomToAll({text="Round "..round.." defeated! The next round will start in 15 secs with 10% increased Monster Level.", duration=10, style={color="orange"}})
      Timers:CreateTimer(15, function()
        MogushanSpawnRound(event.caster.pvescale, 9)
      end)
      if round == 10 then
        CheckForClassQuestRewards("Arena Champion")
      end
    else
      local totalChests = 10
      local center = Entities:FindByName( nil, "mogushan" ):GetAbsOrigin()
      Notifications:BottomToAll({text="Round "..round.." defeated! This was the last round, granting Items with 1000x increased drop chances from this Monster as well as many treasure chests! Well done!", duration=15, style={color="orange"}})
      for i = 1, totalChests do
        Timers:CreateTimer(i*1,function()
          local unit = CreateUnitByName("temple_chest", center+Vector(-550 + 100 * i,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
          unit:SetModelScale(2)
          unit.nobosskill = true
          unit.act = math.random(1,13)
          COverthrowGameMode:SetTempleStats(unit,COverthrowGameMode.jungledifficulty*2.5,0,250,100,0)
          EmitSoundOn("DOTA_Item.Hand_Of_Midas", unit)
        end)
      end
    end
    --new mogushan badge of honor tokens
    if COverthrowGameMode.jungledifficulty >= 100 then
      local all = HeroList:GetAllHeroes()
      for i=1, #all do
       if all[i] and math.random(1,100) <= COverthrowGameMode.mogushankills then
        Timers:CreateTimer(i*1,function()
         local hero = all[i]
         Notifications:Top(hero:GetPlayerID(), {text="You received 1 Badge of Honor! Use it at the Molten Force to get a 50% Crafting Discount!", duration=5, style={color="orange"}})
         ApplyBuffStack({caster = hero, target = hero, ability = hero.combat_system_ability, dur = -1, addstacks = 1, buff = "modifier_jungle_token", alwaysapply = 1})
         EmitSoundOn("DOTA_Item.HavocHammer.Cast", hero)
       end)
      end
    end
  end
end
        --[[
		if event.caster.templeboss_mogushan then
			COverthrowGameMode.mogushankills = COverthrowGameMode.mogushankills + 1
			if (COverthrowGameMode.mogushankills % 2) == 0 and COverthrowGameMode.mogushankills >= 2 and COverthrowGameMode.mogushankills <= 18 then
				local scale = event.caster.pvescale + COverthrowGameMode.jungledifficulty * 0.25
				--print("arena diffi: "..scale)
                local round = math.floor(COverthrowGameMode.mogushankills / 2)
                --chance for super boss
                local super_boss = false
                local super_boss_chance = 5 + (round - 3) * 5
                if super_boss_chance > 100 then
                    super_boss_chance = 100
                end
                if super_boss_chance < 0 then
                    super_boss_chance = 0
                end
				Notifications:BottomToAll({text="Round "..round.." defeated! The next round will be 25% harder. "..super_boss_chance.."% chance to spawn Mogu.", duration=10, style={color="orange"}})
				Timers:CreateTimer(30, function()
					local c1 = Entities:FindByName( nil, "mogushan" ):GetAbsOrigin()
					local unit
					--bosses
					local bossname = RandomBoss("none")
					unit = CreateUnitByName(bossname, c1, true, nil, nil, DOTA_TEAM_BADGUYS )
                    unit:SetForwardVector(Vector(0,-1,0))
					unit.act = 9
					COverthrowGameMode:SetTempleStats(unit,scale,100,10000,100,0)
					unit.templeboss_mogushan = 1
					if COverthrowGameMode.mogushankills >= 6 then
						unit.ischallengeboss = 1
					end

					local bossname2 = RandomBossMogushan(bossname)
                    --chance for super boss
                    if round >= 3 and math.random(1,100) <= super_boss_chance then
                        bossname2 = "mogushan_super_boss"
                        super_boss = true
                        Notifications:BottomToAll({text="Mogu, the undefeated Arena Champion has spawned! Exclusive [Ancient] Souls on 10000% or higher guaranteed!", duration=8, style={color="lightgreen"}})
                    end
					unit = CreateUnitByName(bossname2, c1+Vector(350,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
                    unit:SetForwardVector(Vector(0,-1,0))
					unit.chance_for_mogushan_affixes = 100
					unit.act = 9
					unit.templeboss_mogushan = 1
                    if super_boss then
                        --to make sure it gets only 1 extra affix
                        unit.mogushan_super_boss = true
                    end
					if COverthrowGameMode.mogushankills >= 6 then
						unit.ischallengeboss = 1
					end
					SetMogushanStats(unit, bossname2, scale)
                 end)
			end
			if COverthrowGameMode.mogushankills == 20 or COverthrowGameMode.mogushankills == 22 then
				local scale = event.caster.pvescale + COverthrowGameMode.jungledifficulty * 0.5
				--print("arena diffi: "..scale)
				local round = math.floor(COverthrowGameMode.mogushankills / 2)
                Notifications:BottomToAll({text="Round "..round.." defeated! Now the brutal rounds begin, being 50% harder and starting in 30 seconds.", duration=8, style={color="orange"}})
				Timers:CreateTimer(30, function()
					local c1 = Entities:FindByName( nil, "mogushan" ):GetAbsOrigin()
					local unit
					--bosses
					local bossname = RandomBoss("none")
					unit = CreateUnitByName(bossname, c1, true, nil, nil, DOTA_TEAM_BADGUYS )
                    unit:SetForwardVector(Vector(0,-1,0))
					unit.act = 9
					unit.exp_factor = 5
					COverthrowGameMode:SetTempleStats(unit,scale,100,10000,100,0)
					unit.templeboss_mogushan = 1
					if COverthrowGameMode.mogushankills >= 6 then
						unit.ischallengeboss = 1
					end

					local bossname2 = RandomBossMogushan(bossname)
					unit = CreateUnitByName(bossname2, c1+Vector(350,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
                    unit:SetForwardVector(Vector(0,-1,0))
					unit.chance_for_mogushan_affixes = 100
					unit.act = 9
					unit.exp_factor = 5
					unit.templeboss_mogushan = 1
					if COverthrowGameMode.mogushankills >= 6 then
						unit.ischallengeboss = 1
					end
					SetMogushanStats(unit, bossname2, scale)
                 end)
			end
			if COverthrowGameMode.mogushankills == 24 then
				local scale = event.caster.pvescale
				--print("arena diffi: "..scale)
				local round = math.floor(COverthrowGameMode.mogushankills / 2)
                Notifications:BottomToAll({text="Round "..round.." defeated! Now the final challenge awaits: 1 additional Boss will spawn, starting in 30 seconds.", duration=8, style={color="orange"}})
				Timers:CreateTimer(30, function()
					local c1 = Entities:FindByName( nil, "mogushan" ):GetAbsOrigin()
					local unit
					--bosses
					local bossname = RandomBoss("none")
					unit = CreateUnitByName(bossname, c1, true, nil, nil, DOTA_TEAM_BADGUYS )
                    unit:SetForwardVector(Vector(0,-1,0))
					unit.act = 9
					unit.exp_factor = 5
					COverthrowGameMode:SetTempleStats(unit,scale,100,10000,100,0)
					unit.templeboss_mogushan = 1
					if COverthrowGameMode.mogushankills >= 14 then
						unit.ischallengeboss = 1
					end

					local bossname2 = RandomBossMogushan(bossname)
					unit = CreateUnitByName(bossname2, c1+Vector(350,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
                    unit:SetForwardVector(Vector(0,-1,0))
					unit.chance_for_mogushan_affixes = 100
					unit.act = 9
					unit.exp_factor = 5
					unit.templeboss_mogushan = 1
					if COverthrowGameMode.mogushankills >= 6 then
						unit.ischallengeboss = 1
					end
					SetMogushanStats(unit, bossname2, scale)

					local bossname3 = RandomBossMogushan(bossname2)
					unit = CreateUnitByName(bossname3, c1+Vector(-350,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
                    unit:SetForwardVector(Vector(0,-1,0))
					unit.chance_for_mogushan_affixes = 100
					unit.act = 9
					unit.exp_factor = 5
					unit.templeboss_mogushan = 1
					if COverthrowGameMode.mogushankills >= 6 then
						unit.ischallengeboss = 1
					end
					SetMogushanStats(unit, bossname3, scale)
                 end)
			end
		end]]
		--unlock teleporter
		if event.caster.unlocktpact1 then
      COverthrowGameMode.act1_tp_clawza_active = true
      --COverthrowGameMode.teleporters[0].tp_active = true
    end
    if event.caster.unlock_improved_tp_act_11 then
      COverthrowGameMode.unlock_improved_tp_act_11 = true
      --COverthrowGameMode.teleporters[0].tp_active = true
    end
    

    --new act 11
    local unit = event.caster
    if unit.act_11_last_boss then
      CinematicKillMessage(11)
    end
    if unit.act_12_final_boss then
      CinematicKillMessage(12)
      COverthrowGameMode.act_12_cleared = true
    end
    if unit.act11_last_boss then
      COverthrowGameMode.act_11_cleared = true
    end
    if unit.act11_boss then
     if COverthrowGameMode.act11_boss_kills then
      COverthrowGameMode.act11_boss_kills = COverthrowGameMode.act11_boss_kills + 1
    else
      COverthrowGameMode.act11_boss_kills = 1
    end
    if COverthrowGameMode.act11_boss_kills == 15 then --after x kills summon final boss
      COverthrowGameMode:CreateAct11LastBoss()
    end
    if not COverthrowGameMode.act_11_merge_bosses then
      COverthrowGameMode.act_11_merge_bosses = {}
    end
    COverthrowGameMode.act_11_merge_bosses[unit.act11_boss] = true
    if not COverthrowGameMode.act_11_merge_bosses_spawned then
      COverthrowGameMode.act_11_merge_bosses_spawned = {}
    end
    for i=1,10,2 do
      if COverthrowGameMode.act_11_merge_bosses[i] and COverthrowGameMode.act_11_merge_bosses[i+1] and not COverthrowGameMode.act_11_merge_bosses_spawned[i] then
        COverthrowGameMode.act_11_merge_bosses_spawned[i] = true
        CreateAct11MergeBoss(i,i+1,28)
      end
    end
  end
  if unit.templeboss_wolf then
   local i = 1
   COverthrowGameMode.boss_kills_per_act[i] = COverthrowGameMode.boss_kills_per_act[i] + 1
   if COverthrowGameMode.boss_kills_per_act[i] == 4 then
    COverthrowGameMode:CreateActBoss(11,i)
  end
end
if unit.templeboss_sandviper then
 local i = 2
 COverthrowGameMode.boss_kills_per_act[i] = COverthrowGameMode.boss_kills_per_act[i] + 1
 if COverthrowGameMode.boss_kills_per_act[i] == 7 then
  COverthrowGameMode:CreateActBoss(11,i)
end
end
if unit.templeboss_wetlands then
 local i = 3
 COverthrowGameMode.boss_kills_per_act[i] = COverthrowGameMode.boss_kills_per_act[i] + 1
 if COverthrowGameMode.boss_kills_per_act[i] == 10 then
  COverthrowGameMode:CreateActBoss(11,i)
end
end
if unit.templeboss_shadowlands then
 local i = 4
 COverthrowGameMode.boss_kills_per_act[i] = COverthrowGameMode.boss_kills_per_act[i] + 1
 if COverthrowGameMode.boss_kills_per_act[i] == 8 then
  COverthrowGameMode:CreateActBoss(11,i)
end
end
if unit.templeboss_dragon then
 local i = 5
 COverthrowGameMode.boss_kills_per_act[i] = COverthrowGameMode.boss_kills_per_act[i] + 1
 if COverthrowGameMode.boss_kills_per_act[i] == 7 then
  COverthrowGameMode:CreateActBoss(11,i)
end
if COverthrowGameMode.boss_kills_per_act[i] == 4 then
  COverthrowGameMode:SpawnDragonEggs()
end
end
if unit.templeboss_mount then
 local i = 6
 COverthrowGameMode.boss_kills_per_act[i] = COverthrowGameMode.boss_kills_per_act[i] + 1
 if COverthrowGameMode.boss_kills_per_act[i] == 11 then
  COverthrowGameMode:CreateActBoss(11,i)
end
end
if unit.templeboss_tomb then
 local i = 7
 COverthrowGameMode.boss_kills_per_act[i] = COverthrowGameMode.boss_kills_per_act[i] + 1
 if COverthrowGameMode.boss_kills_per_act[i] == 3 then
  COverthrowGameMode:CreateAct7Omni()
end
if COverthrowGameMode.boss_kills_per_act[i] == 4 then
  COverthrowGameMode:CreateActBoss(11,i)
end
end
if unit.templeboss_volcano then
 local i = 8
 COverthrowGameMode.boss_kills_per_act[i] = COverthrowGameMode.boss_kills_per_act[i] + 1
 if COverthrowGameMode.boss_kills_per_act[i] == 2 then
  COverthrowGameMode:CreateActBoss(11,i)
end
end
if unit.templeboss_mogushan then
 local i = 9
 COverthrowGameMode.boss_kills_per_act[i] = COverthrowGameMode.boss_kills_per_act[i] + 1
 if COverthrowGameMode.boss_kills_per_act[i] == 5 then
  COverthrowGameMode:CreateActBoss(11,i)
end
end
if unit.templeboss_throne then
 local i = 10
 COverthrowGameMode.boss_kills_per_act[i] = COverthrowGameMode.boss_kills_per_act[i] + 1
 if COverthrowGameMode.boss_kills_per_act[i] == 1 then
  COverthrowGameMode:CreateActBoss(11,i)
end
end

--update act boss kill stats
local act = event.caster.act
if act and COverthrowGameMode.act_kills and COverthrowGameMode.act_kills[act] and unit.isboss then
 COverthrowGameMode.act_kills[act] = COverthrowGameMode.act_kills[act] + 1
 --for i=1,11 do
  --print("act "..i.." bosses killed: "..COverthrowGameMode.act_kills[i])
  --end
  if act == 12 and COverthrowGameMode.act_kills[act] == 9 and not COverthrowGameMode.jungle_rumble_event_triggered then --9 with egg
    COverthrowGameMode.jungle_rumble_event_triggered = true
    JungleRumbleEvent(false)
  end
end




--remove lock shield on act 8 boss
--if event.caster.flameshieldunlock then
  --	COverthrowGameMode.flameshieldedboss:RemoveModifierByName("modifier_fire_shield_lock")
  --	Timers:CreateTimer(10, function()
  --		Notifications:BottomToAll({text="The Mysterious Flame Shield from Xaxex the Flamerider seems to have disappeared!", duration=6, style={color="orange"}})
  --	end)
  --end
  --normal loot
  --print("loot chance")
  --print(event.caster)
  --print(event.caster.rewardchance)
  if unit.act13_last_boss then
    COverthrowGameMode.act_13_cleared = true
    COverthrowGameMode.act13_event_in_progress = nil
    local all = HeroList:GetAllHeroes()
    local hero
    --for i=1, #all do
      --hero = all[i]
      --PlayerResource:SetCameraTarget(hero:GetPlayerOwnerID(), nil)
      --end
      for i=1,2 do
        local unit = CreateUnitByName("temple_chest", Entities:FindByName( nil, "act13_3" ):GetAbsOrigin() + Vector(-450+300*i,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
        unit:SetModelScale(2)
        unit.main_quest_boss = 17
        unit.act = 13
        COverthrowGameMode:SetTempleStats(unit,COverthrowGameMode.jungledifficulty*2.6,0,1000,100,0)
      end
    end
    if unit.loot_goblin_gold_drop then
      AddGoldToAllPlayers(math.random(5,25)*COverthrowGameMode.jungledifficulty)
    end
    if unit.loot_hoarder_on_death_chance and math.random(1,100) <= unit.loot_hoarder_on_death_chance then
      COverthrowGameMode:SpawnTreasureChest(unit:GetAbsOrigin(), 99)
    end
    --if event and event.caster and event.caster.rewardchance and event.caster.rewardchance >= 100 then --spawn chests after boss kill
      --    COverthrowGameMode:SpawnTreasureChests()
      --end
      COverthrowGameMode:SpawnStormCrowPatrols()
      COverthrowGameMode:DropTempleItem(event.caster, event.caster.rewardchance, 1, 0, false)
      local wasBossKill = event.caster.rewardchance >= 100 and not event.caster.nobosskill
      if wasBossKill then
        OnBossKilled()
      end
      local caster = event.caster
      --new class quests
      if caster.quest_trigger_class then
        CheckForClassQuestRewards(caster.quest_trigger_class)
      end
      if not COverthrowGameMode.quest_act1andact2 and COverthrowGameMode.boss_kills_per_act[1] and COverthrowGameMode.boss_kills_per_act[1] >= 4 and COverthrowGameMode.boss_kills_per_act[2] and COverthrowGameMode.boss_kills_per_act[2] >= 6 then
        COverthrowGameMode.quest_act1andact2 = true
        CheckForClassQuestRewards("Beast Clearing")
      end
      if not COverthrowGameMode.quest_act5andact6 and COverthrowGameMode.boss_kills_per_act[5] and COverthrowGameMode.boss_kills_per_act[5] >= 7 and COverthrowGameMode.boss_kills_per_act[6] and COverthrowGameMode.boss_kills_per_act[6] >= 9 then
        COverthrowGameMode.quest_act5andact6 = true
        CheckForClassQuestRewards("Giant Slaying")
      end
      if not COverthrowGameMode.quest_act3andact4 and COverthrowGameMode.boss_kills_per_act[3] and COverthrowGameMode.boss_kills_per_act[3] >= 9 and COverthrowGameMode.boss_kills_per_act[4] and COverthrowGameMode.boss_kills_per_act[4] >= 6 then
        COverthrowGameMode.quest_act3andact4 = true
        CheckForClassQuestRewards("A Light in the Dark")
      end
      local pve_act_affix_reincarnation = unit:FindAbilityByName("pve_act_affix_reincarnation")
      if pve_act_affix_reincarnation and math.random(1,100) <= 25 and not caster.real_boss then
        ReviveUnit(unit, event.attacker)
      end
      if event.caster.main_quest_boss then
        COverthrowGameMode:SpawnTreasureChests()
      end
      --summon handling on boss death
      if caster.destroysummonsondeath and caster.summons then
        for k,v in pairs(caster.summons) do
          if v and not v:IsNull() then
            local particle = ParticleManager:CreateParticle("particles/items_fx/necronomicon_spawn_warrior.vpcf", PATTACH_POINT_FOLLOW, v)
            ParticleManager:ReleaseParticleIndex(particle)
            UTIL_Remove(v)
          end
        end
      end
    end
  end

  function COverthrowGameMode:SetPVEStats(target, scale, dmg, hp, reward)
   local scale2 = 1.4 + ((self.RoundCounter - 2)/8.0)
   if scale2 < 1.0 then
    scale2 = 1.0
  end
  
  if (PlayerResource:GetPlayerCount() % 2) == 1 then
    scale2 = scale2 *(0.0 + 1.0*((PlayerResource:GetPlayerCount()-1) / 2))
  else
    scale2 = scale2 *(0.0 + 1.0*((PlayerResource:GetPlayerCount()) / 2))
  end

  if COverthrowGameMode.junglemode then
    scale2 = scale
  end

  target:SetBaseDamageMin(dmg*scale)
  target:SetBaseDamageMax(dmg*scale)
  target:SetBaseMaxHealth(hp*scale2)
  target:SetMaxHealth(hp*scale2)                           
  target:SetHealth(hp*scale2)
  target.aggrolist = {}
  for i=0, 30 do
   target.aggrolist[i] = 0
 end
 local abil = target:FindAbilityByName("pveboss_system")
 if abil then
  abil:SetLevel(1)
end
target.pvescale = scale
target.rewardlevel = reward
target.rewardchance = reward

--fix pve dummy abil
local abil2 = target:FindAbilityByName("dummy_unit")
if abil2 then
  abil2:SetLevel(1)
end
end


function COverthrowGameMode:PVEAggroHighest() --outdated
	local all = HeroList:GetAllHeroes()
	local aggro = -1
	local unit
	for i=1, #all do
		if all[i]:IsHero() and all[i]:IsAlive() and not (all[i]:IsIllusion()) then
      local summonAggro = CheckSummonAggro(all[i])
      if summonAggro then
        return summonAggro
      end
      if all[i].PVEaggro ~= nil and all[i].PVEaggro > aggro then
        unit = all[i]
        aggro = all[i].PVEaggro
      end
    end
  end
  if aggro > 0 and unit and not unit:IsNull() then
    return unit
  end
end

function COverthrowGameMode:AggroHighest(caster) --aaaaaaaaaaaa
	local all = HeroList:GetAllHeroes()
	local aggro = 0
	local unit
	for i=1, #all do
		local ownerid = all[i]:GetPlayerOwnerID()
		if all[i]:IsHero() and all[i]:IsAlive() and not (all[i]:IsIllusion()) and (all[i]:GetAbsOrigin()-caster:GetAbsOrigin()):Length() <= 2500 and caster then
      local summonAggro = CheckSummonAggro(all[i])
      if summonAggro then
        return summonAggro
      end
      if (all[i]:GetAbsOrigin()-caster:GetAbsOrigin()):Length() <= 1500 then
        local mods = all[i]:GetModifierCount()-1
        for j=0, mods do
          local name = all[i]:GetModifierNameByIndex(j)
          if name == "modifier_taunt123" then
            return all[i]
          end
        end
      end
      if caster.aggrolist and caster.aggrolist[ownerid] ~= nil and caster.aggrolist[ownerid] > aggro then
        unit = all[i]
        aggro = caster.aggrolist[ownerid]
      end
    end
  end
  --print("aggro this iteration was " .. aggro)
  if aggro > 0 and unit and not unit:IsNull() then
    return unit
  end
end

function COverthrowGameMode:AggroRangedPreferred(caster)
  local all = HeroList:GetAllHeroes()
  local aggro = -1
  local unit
  for i=1, #all do
    local ownerid = all[i]:GetPlayerOwnerID()
    if all[i]:IsHero() and all[i]:IsAlive() and not (all[i]:IsIllusion()) and (all[i]:GetAbsOrigin()-caster:GetAbsOrigin()):Length() <= 2500 and caster then
      local summonAggro = CheckSummonAggro(all[i])
      if summonAggro then
        return summonAggro
      end
      if (all[i]:GetAbsOrigin()-caster:GetAbsOrigin()):Length() <= 1500 then
        local mods = all[i]:GetModifierCount()-1
        for j=0, mods do
          local name = all[i]:GetModifierNameByIndex(j)
          if name == "modifier_taunt123" then
            return all[i]
          end
        end
      end
      if caster.aggrolist and caster.aggrolist[ownerid] ~= nil and caster.aggrolist[ownerid] > aggro and all[i]:IsRangedAttacker() then
        unit = all[i]
        aggro = caster.aggrolist[ownerid]
      end
    end
  end
  --print("aggro this iteration was " .. aggro)
  if aggro > 0 and unit and not unit:IsNull() then
    return unit
  end
end

function COverthrowGameMode:AggroLowestHP(caster)
	--if caster and caster:GetHealth() / caster:GetMaxHealth() >= 1.0 then
   --	return nil
   --end
   local all = HeroList:GetAllHeroes()
   local hp = nil
   local unit
   for i=1, #all do
    local ownerid = all[i]:GetPlayerOwnerID()
    if all[i]:IsHero() and all[i]:IsAlive() and not (all[i]:IsIllusion()) and (all[i]:GetAbsOrigin()-caster:GetAbsOrigin()):Length() <= 2500 and caster then
      local summonAggro = CheckSummonAggro(all[i])
      if summonAggro then
        return summonAggro
      end
      if (all[i]:GetAbsOrigin()-caster:GetAbsOrigin()):Length() <= 1500 then
        local mods = all[i]:GetModifierCount()-1
        for j=0, mods do
          local name = all[i]:GetModifierNameByIndex(j)
          if name == "modifier_taunt123" then
            return all[i]
          end
        end
      end
      --local h = all[i]:GetHealth() / all[i]:GetMaxHealth()
      local h = all[i]:GetHealth()
      if ((not hp) or h < hp) and caster.aggrolist and caster.aggrolist[ownerid] and caster.aggrolist[ownerid] > 0 then
        unit = all[i]
        hp = h
      end
    end
  end
  --print("aggro this iteration was " .. aggro)
  if hp and hp > 0 and unit and not unit:IsNull() then
    return unit
  end
end

function COverthrowGameMode:AggroLowestArmor(caster)
  local all = HeroList:GetAllHeroes()
  local bestArmor = nil
  local unit
  for i=1, #all do
    local ownerid = all[i]:GetPlayerOwnerID()
    if all[i]:IsHero() and all[i]:IsAlive() and not (all[i]:IsIllusion()) and (all[i]:GetAbsOrigin()-caster:GetAbsOrigin()):Length() <= 2500 and caster then
      local summonAggro = CheckSummonAggro(all[i])
      if summonAggro then
        return summonAggro
      end
      if (all[i]:GetAbsOrigin()-caster:GetAbsOrigin()):Length() <= 1500 then
        local mods = all[i]:GetModifierCount()-1
        for j=0, mods do
          local name = all[i]:GetModifierNameByIndex(j)
          if name == "modifier_taunt123" then
            return all[i]
          end
        end
      end
      --local h = all[i]:GetHealth() / all[i]:GetMaxHealth()
      local armor = all[i]:GetPhysicalArmorValue(false)
      if ((not bestArmor) or armor < bestArmor) and caster.aggrolist and caster.aggrolist[ownerid] and caster.aggrolist[ownerid] > 0 then
        unit = all[i]
        bestArmor = armor
      end
    end
  end
  --print("aggro this iteration was " .. aggro)
  if bestArmor and unit and not unit:IsNull() then
    return unit
  end
end

function COverthrowGameMode:AggroLowestMres(caster)
  local all = HeroList:GetAllHeroes()
  local bestArmor = nil
  local unit
  for i=1, #all do
    local ownerid = all[i]:GetPlayerOwnerID()
    if all[i]:IsHero() and all[i]:IsAlive() and not (all[i]:IsIllusion()) and (all[i]:GetAbsOrigin()-caster:GetAbsOrigin()):Length() <= 2500 and caster then
      local summonAggro = CheckSummonAggro(all[i])
      if summonAggro then
        return summonAggro
      end
      if (all[i]:GetAbsOrigin()-caster:GetAbsOrigin()):Length() <= 1500 then
        local mods = all[i]:GetModifierCount()-1
        for j=0, mods do
          local name = all[i]:GetModifierNameByIndex(j)
          if name == "modifier_taunt123" then
            return all[i]
          end
        end
      end
      --local h = all[i]:GetHealth() / all[i]:GetMaxHealth()
      local armor = all[i]:Script_GetMagicalArmorValue(false, nil)
      if ((not bestArmor) or armor < bestArmor) and caster.aggrolist and caster.aggrolist[ownerid] and caster.aggrolist[ownerid] > 0 then
        unit = all[i]
        bestArmor = armor
      end
    end
  end
  --print("aggro this iteration was " .. aggro)
  if bestArmor and unit and not unit:IsNull() then
    return unit
  end
end

function COverthrowGameMode:AggroLowest(caster)
	local all = HeroList:GetAllHeroes()
	local aggro = -1
	local unit = nil
	for i=1, #all do
		local ownerid = all[i]:GetPlayerOwnerID()
		if all[i]:IsHero() and all[i]:IsAlive() and not (all[i]:IsIllusion()) and (all[i]:GetAbsOrigin()-caster:GetAbsOrigin()):Length() <= 2500 and caster then
      local summonAggro = CheckSummonAggro(all[i])
      if summonAggro then
        return summonAggro
      end
      if (all[i]:GetAbsOrigin()-caster:GetAbsOrigin()):Length() <= 1500 then
        local mods = all[i]:GetModifierCount()-1
        for j=0, mods do
          local name = all[i]:GetModifierNameByIndex(j)
          if name == "modifier_taunt123" then
            return all[i]
          end
        end
      end
      if caster.aggrolist and caster.aggrolist[ownerid] ~= nil and ( caster.aggrolist[ownerid] < aggro or aggro == -1 ) then
        unit = all[i]
        aggro = caster.aggrolist[ownerid]
      end
    end
  end
  if unit and not unit:IsNull() then
    return unit
  end
  return nil
end

function PVERandomTargetNotLowestAggro(caster)
	local all = HeroList:GetAllHeroes()
	local aggro = -1
	--find lowest
	local unit
	for i=1, #all do
		local ownerid = all[i]:GetPlayerOwnerID()
		if all[i]:IsHero() and all[i]:IsAlive() and not (all[i]:IsIllusion()) and (all[i]:GetAbsOrigin()-caster:GetAbsOrigin()):Length() <= 2500 and caster then
      local summonAggro = CheckSummonAggro(all[i])
      if summonAggro then
        return summonAggro
      end
      if caster.aggrolist and caster.aggrolist[ownerid] ~= nil and  ( caster.aggrolist[ownerid] < aggro or aggro == -1 ) then
        unit = all[i]
        aggro = caster.aggrolist[ownerid]
      end
    end
  end
  --exlude lowest from list
  if aggro > 0 then
    local all_near = {}
    for i=1, #all do
     if all[i]:IsHero() and not (all[i]:IsIllusion()) and (all[i]:GetAbsOrigin()-caster:GetAbsOrigin()):Length() <= 2500 and all[i]:IsAlive() and (all[i] ~= unit) then
      table.insert(all_near, all[i])
    end
  end
  local source = all_near[math.random(1,#all_near)]
  if source and not source:IsNull() then
   return source
 end
 return nil
end
end

function COverthrowGameMode:PVEAggroLowest() --outdated
	local all = HeroList:GetAllHeroes()
	local aggro = -1
	local unit
	for i=1, #all do
		if all[i]:IsHero() and all[i]:IsAlive() and not (all[i]:IsIllusion()) and all[i]:HasModifier("in_aggro_range") then
      local summonAggro = CheckSummonAggro(all[i])
      if summonAggro then
        return summonAggro
      end
      if all[i].PVEaggro ~= nil and ( all[i].PVEaggro < aggro or aggro == -1 ) then
        unit = all[i]
        aggro = all[i].PVEaggro
      end
    end
  end
  if aggro > -1 and unit and not unit:IsNull() then
    return unit
  end
end

function CheckSummonAggro( caster )
  if caster and not caster:IsNull() and caster.hellguard and not caster.hellguard:IsNull() and caster.hellguard:IsAlive() and caster.hellguard:HasModifier("modifier_taunt123") then
    return caster.hellguard
  else
    return nil
  end
end

function COverthrowGameMode:PVEAggroClear() --old
	local all = HeroList:GetAllHeroes()
	for i=1, #all do
		if all[i]:IsHero() and not (all[i]:IsIllusion()) then
			all[i].PVEaggro = 0
		end
	end
end

function UnitAggroClear(event)
	local caster = event.caster
	caster.aggrolist = nil
	caster.aggrolist = {}
	for i=0, 30 do
    caster.aggrolist[i] = 0
  end
  caster.aggro_not_pulled_yet = true
end

function FindLinkedAggro(event)
	--print("find linked call")
	local caster = event.caster
	local enemies = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetAbsOrigin(), caster, 600, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	if #enemies > 0 then
		for _,enemy in pairs(enemies) do
			if enemy ~= nil then
				if enemy:GetUnitLabel()=="hero" and enemy ~= caster then
					--print("unit "..enemy:GetUnitName())
					local myevent = {}
					myevent.unit = enemy
					myevent.attacker = event.target
					myevent.damagetaken = 1
					--myevent.aggroaura = 1
					PVEAggroAdd(myevent)
				end
			end
		end
	end
end

function IsHeroNear( caster, range )
  local near = false
  local enemies = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetAbsOrigin(), caster, range, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, 0, 0, false )
  if #enemies > 0 then
    for _,enemy in pairs(enemies) do
      if enemy ~= nil then
        near = true
      end
    end
  end
  return near
end

function AggroOnEnemy(event)
	local caster = event.caster
	local target = event.target
	if caster:GetTeamNumber() ~= target:GetTeamNumber() and target:HasAbility("pveboss_system") then
    if event.health then
      event.damagetaken = event.health * caster:GetMaxHealth() / 100
    end
    event.attacker = caster
    event.unit = target
    if not event.damagetaken then
      event.damagetaken = 0
    end
    --print("aggro " .. event.damagetaken)
    PVEAggroAdd(event)
  end
end

function FindMasterHero(unit)
	if unit then
		if unit:IsRealHero() then
			return unit
		end
		if unit.owner and unit.owner:IsRealHero() then
			return unit.owner
		end
		local player = unit:GetPlayerOwner()
		if player then
			local hero = player:GetAssignedHero()
			if hero then
				return hero
			end
		end
	end
	return nil
end

function COverthrowGameMode:PVEAggroAddAOE(source, target, aggro, area)
  if not source or not target then
    return
  end
  local pos = target:GetAbsOrigin()
  local enemies = FindUnitsInRadius( source:GetTeamNumber(), pos, source, area, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC, 0, 0, false )
  for _,enemy in pairs(enemies) do
    local event = {attacker = source, unit = enemy, damagetaken = aggro}
    PVEAggroAdd(event)
  end
end

function COverthrowGameMode:PVEAggroAdd(event)
  PVEAggroAdd(event)
end

function PVEAggroAdd(event)
	local source = event.attacker
	local caster = event.unit
	if event.aggroaura then
		caster = event.caster
		source = event.target
		local real_hero_aggro_source = FindMasterHero(source)
		if not real_hero_aggro_source then
			return
		else
			source = real_hero_aggro_source
		end
	end
	if event.findlinkedaggro then
		local myevent = {}
		myevent.caster = caster
		myevent.target = source
		--if caster and caster.aggrolist and source and source:GetPlayerOwnerID() and caster.aggrolist[source:GetPlayerOwnerID()] and caster.aggrolist[source:GetPlayerOwnerID()] > 0.0 then
      --	return
      --end
      --only find linked on first pull when aggro list empty
      if caster.totalaggro and caster.totalaggro > 0.0 then
       --return
     else
       FindLinkedAggro(myevent)
     end
   end
   local aggro = event.damagetaken
   local aggro_original = aggro
   if caster and caster.aggrolist and (source:IsHero() or source.owner) then
    if caster:HasModifier("modifier_temple_stone_seal") then
     return
   end
   if not source:IsHero() then
     source = source.owner
   end
   local bonus_aggro = 1
   local aggro_reduce = 0
   local setHeroStatsAggroPercent = not event.ignore_super_aggro_tank
   if source:IsHero() then
    if source.super_aggro_tank and not event.ignore_super_aggro_tank then
      local levelThreshold = 2
      local level_tank_ability = 0
      local tank_ability = source:GetAbilityByIndex(0)
      if tank_ability and tank_ability:GetName() == "bear1" then
        levelThreshold = 4
      end
      if source.super_aggro_tank_temple then
        tank_ability = source:FindAbilityByName("Protect1")
      end
      if source.super_aggro_tank_prot then
        tank_ability = source:FindAbilityByName("Protect1")
        if not tank_ability and source.abil1 then
          level_tank_ability = source.abil1
        end
      end
      if source.super_aggro_tank_dk then
        tank_ability = source:FindAbilityByName("Corrupting_Strike")
      end
      if source.super_aggro_tank_pala then
        tank_ability = source:FindAbilityByName("pala1")
        levelThreshold = 2
      end
      if source.super_aggro_tank_dh then
        tank_ability = source:FindAbilityByName("terror1")
        levelThreshold = 2
      end
      
      --print(source.super_aggro_tank_monk)
      if tank_ability then
        level_tank_ability = tank_ability:GetLevel()
      end
      if level_tank_ability and level_tank_ability >= levelThreshold then
        local aggro_bonus_armor = 1 + source:GetPhysicalArmorValue(false) * 0.05
        if aggro_bonus_armor < 1 then
          aggro_bonus_armor = 1
        end
        local aggro_bonus_resist = 1 + source:Script_GetMagicalArmorValue(false, nil) * 100 * 0.1
        if aggro_bonus_resist < 1 then
          aggro_bonus_resist = 1
        end
        local aggro_bonus_hp = 1 + source:GetMaxHealth() / 5000
        bonus_aggro = aggro_bonus_armor * aggro_bonus_resist * aggro_bonus_hp
        if source.super_aggro_tank_monk and level_tank_ability >= 4 then
         bonus_aggro = bonus_aggro * (1 + 0.01 * GetStrengthCustom(source))
       end
       --print("aggro factors")
       --print(aggro_bonus_armor)
       --print(aggro_bonus_resist)
       --print(aggro_bonus_hp)
     end
   end
 end
 --print("aggro add")
 if source:HasModifier("modifier_dh_aa_heal") then
   bonus_aggro = bonus_aggro * 2
 end
 if source:HasModifier("modifier_fanatism_aggro") then
   bonus_aggro = bonus_aggro * 3
 end
 if source:HasModifier("modifier_item_shield_aggro") then
   bonus_aggro = bonus_aggro * 2
 end
 if source:HasModifier("modifier_item_bootshp3") then
   bonus_aggro = bonus_aggro * 2
 end
 if source:HasModifier("modifier_item_bootshp4") then
  bonus_aggro = bonus_aggro * 2
end
if source:HasModifier("modifier_mythic_aggro") then
 bonus_aggro = bonus_aggro + source:GetModifierStackCount("modifier_mythic_aggro", nil) / 100
end
if source:HasModifier("modifier_mythic_aggro_reduce") then
 aggro_reduce = aggro_reduce + source:GetModifierStackCount("modifier_mythic_aggro_reduce", nil) / 100
end
--if source:HasModifier("modifier_item_needle_threat") then
  --	aggro_reduce = aggro_reduce + 30
  --end
  --if source:HasModifier("modifier_item_needle_threat2") then
    --	aggro_reduce = aggro_reduce + 50
    --end
    --if source.talents and source.talents[16] then
      --    aggro_reduce = aggro_reduce + 10 * source.talents[16]
      --end
      --final aggro calced
      --print("aggro test")
      --print(bonus_aggro)
      local final_factor = bonus_aggro * (1 - (aggro_reduce / 100))
      --print(final_factor)
      --if final_factor > 15 then
        --	final_factor = 15
        --end
        if final_factor < 0.25 then
         final_factor = 0.25
       end
       aggro = aggro * final_factor

       if aggro_original >= 1 then
         --print("final_factor " .. final_factor)
         --print(source:GetName())
         if setHeroStatsAggroPercent then
          source.aggro_caused = final_factor
        end
        if source:IsRealHero() then
          source.damage_done = source.damage_done + aggro_original
        end
      end
      caster.aggrolist[source:GetPlayerOwnerID()] = caster.aggrolist[source:GetPlayerOwnerID()] + aggro
      if caster.totalaggro then
       caster.totalaggro = caster.totalaggro + aggro
     else
       caster.totalaggro = aggro
     end
     --first aggro causes instant pull
     if caster.aggro_not_pulled_yet then
      caster.aggro_not_pulled_yet = nil
      local order = 
      {
        UnitIndex = caster:entindex(),
        OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
        TargetIndex = source:entindex()
      }
      ExecuteOrderFromTable(order)
    end
  end
end

function PVEAggroAddRandomHero(event)
	local source
	local caster = event.target
	if caster == nil then
		caster = event.caster
	end
	local aggro = event.amount

	local all = HeroList:GetAllHeroes()
	local all_near = {}
	for i=1, #all do
    local mods = all[i]:GetModifierCount()-1
    for j=0, mods do
      local name = all[i]:GetModifierNameByIndex(j)
    end
    if caster and not caster:IsNull() and all[i]:IsHero() and not (all[i]:IsIllusion()) and all[i]:IsAlive() and (all[i]:GetAbsOrigin()-caster:GetAbsOrigin()):Length() <= 2500 then
      if (event.aggro_prefer_ranged and all[i]:IsRangedAttacker()) or not event.aggro_prefer_ranged then
        table.insert(all_near, all[i])
      end
    end
  end
  if #all_near < 1 then
    for i=1, #all do
      if caster and not caster:IsNull() and all[i]:IsHero() and not (all[i]:IsIllusion()) and all[i]:IsAlive() and (all[i]:GetAbsOrigin()-caster:GetAbsOrigin()):Length() <= 2500 then
        table.insert(all_near, all[i])
      end
    end
  end
  source = all_near[math.random(1,#all_near)]
  
  if source and caster and caster.aggrolist and (source:IsHero() or source.owner) and aggro then
    if not source:IsHero() then
     source = source.owner
   end
   --if source:HasModifier("item_shield_aggro") then
    --	aggro = event.damagetaken * 4
    --end
    if aggro > 50000 then
     local particle = ParticleManager:CreateParticle("particles/units/unit_greevil/greevil_transformation_runes.vpcf", PATTACH_POINT_FOLLOW, source)
     ParticleManager:ReleaseParticleIndex(particle)
   end
   if caster.aggrolist[source:GetPlayerOwnerID()] then
     caster.aggrolist[source:GetPlayerOwnerID()] = caster.aggrolist[source:GetPlayerOwnerID()] + aggro
   else
     caster.aggrolist[source:GetPlayerOwnerID()] = aggro
   end
 end
end

function COverthrowGameMode:PVERandomTarget( event )
  return PVERandomTarget(event)
end

function PVERandomTarget(event)
	local caster = event.caster
	if not caster or caster:IsNull() then
		return
	end
	local all = HeroList:GetAllHeroes()
	local all_near = {}
	for i=1, #all do
		if all[i]:IsHero() and not (all[i]:IsIllusion()) and (all[i]:GetAbsOrigin()-caster:GetAbsOrigin()):Length() <= 2500 and all[i]:IsAlive() then
			table.insert(all_near, all[i])
		end
	end
	local source = all_near[math.random(1,#all_near)]
	return source
end

function PVERandomTargetRanged(event)
  local caster = event.caster
  if not caster or caster:IsNull() then
    return
  end
  local all = HeroList:GetAllHeroes()
  local all_near = {}
  for i=1, #all do
    if all[i]:IsHero() and not (all[i]:IsIllusion()) and (all[i]:GetAbsOrigin()-caster:GetAbsOrigin()):Length() <= 2500 and all[i]:IsAlive() and all[i]:IsRangedAttacker() then
      table.insert(all_near, all[i])
    end
  end
  local source = all_near[math.random(1,#all_near)]
  return source
end

function COverthrowGameMode:PVERandomTargetNearTarget(unit, distance, exclude_target)
  local caster = unit
  if not caster or caster:IsNull() then
    return
  end
  local all = HeroList:GetAllHeroes()
  local all_near = {}
  for i=1, #all do
    if all[i]:IsHero() and not (all[i]:IsIllusion()) and (all[i]:GetAbsOrigin()-caster:GetAbsOrigin()):Length() <= distance and all[i]:IsAlive() and all[i] ~= unit and all[i] ~= exclude_target then
      table.insert(all_near, all[i])
    end
  end
  local source = all_near[math.random(1,#all_near)]
  return source
end

function COverthrowGameMode:RandomXHeroes(event)
  return PVERandomXTargets(event)
end

function PVERandomXTargets(event)
	local caster = event.caster
	local amount = event.numbertargets
	local all = HeroList:GetAllHeroes()
	local all_near = {}
	local result = {}
	for i=1, #all do
		if all[i]:IsHero() and not (all[i]:IsIllusion()) and (all[i]:GetAbsOrigin()-caster:GetAbsOrigin()):Length() <= 2500 and all[i]:IsAlive() then
			table.insert(all_near, all[i])
		end
	end
	if #all_near < amount and not event.stillbuffifless then
		return nil
	end
	if #all_near < 1 then
		return
	end

	--find first
	local choice = all_near[math.random(1,#all_near)]
	result[1] = choice
	--second
	all_near = {}
	for i=1, #all do
		if (not (all[i] == result[1])) and all[i]:IsHero() and (not (all[i]:IsIllusion())) and ((all[i]:GetAbsOrigin()-caster:GetAbsOrigin()):Length() <= 2500) and all[i]:IsAlive() then
			table.insert(all_near, all[i])
		end
	end
	choice = all_near[math.random(1,#all_near)]
	result[2] = choice

	--third
	all_near = {}
	for i=1, #all do
		if not (all[i] == result[1]) and not (all[i] == result[2]) and all[i]:IsHero() and not (all[i]:IsIllusion()) and (all[i]:GetAbsOrigin()-caster:GetAbsOrigin()):Length() <= 2500 and all[i]:IsAlive() then
			table.insert(all_near, all[i])
		end
	end
	choice = all_near[math.random(1,#all_near)]
	result[3] = choice

	return result
end

function PVEFurthestTarget(event)
	local caster = event.caster

	local all = HeroList:GetAllHeroes()
	local target
	local distance = 0
  local max_distance = 2500
  if event.max_distance then
    max_distance = event.max_distance
  end
  for i=1, #all do
    local d = (all[i]:GetAbsOrigin()-caster:GetAbsOrigin()):Length()
    if d > distance and d <= max_distance and all[i]:IsAlive() then
     distance = d
     target = all[i]
   end
 end
 return target
end

function PVEAggroReset(event)
	local source = event.unit
	local caster = event.caster
	if caster and caster.aggrolist and source and source:IsHero() then
		--print(caster:GetName())
		--print(source:GetName())
		caster.aggrolist[source:GetPlayerOwnerID()] = 0.0
	end
end

function PVEAggroOnAttack(event)
	local source = event.target
	local caster = event.attacker
	if caster and caster.aggrolist and (source:IsHero() or source.owner) then
		if not source:IsHero() then
			source = source.owner
		end
		caster.aggrolist[source:GetPlayerOwnerID()] = caster.aggrolist[source:GetPlayerOwnerID()] + event.damagetaken

		if source:IsHero() and source:GetPrimaryAttribute() == 0 then
			caster.aggrolist[source:GetPlayerOwnerID()] = caster.aggrolist[source:GetPlayerOwnerID()] + event.damagetaken
		end
		--print("aggro add")
		--print(event.damagetaken)
	end
end


function COverthrowGameMode:EndPVE(result)
	--shopping stats
	local timesaver = self.RoundCountdown
	self.RoundCountdown = 55
	self.GameState = GameState_Shopping

	self:PVEClearMobs()

	if result == 0 then --lose!
		self.RoundCountdown = 20
		if not self.currentBossUnit:IsNull() then
			UTIL_Remove(self.currentBossUnit)
		end
		self.currentBossUnit = nil
		self.PVELives = self.PVELives - 1
		--print("pve lives")
		--print(self.PVELives)
		if self.PVELives <= 0 then
			GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
		end
	end

	if result == 1 then --win!
		self.currentBoss = self.currentBoss + 1
		self.RoundCountdown = 55
		self.currentBossUnit = nil
	end

	--self.RoundWonPerTeam[winningteam]=self.RoundWonPerTeam[winningteam]+1
	self.RoundCounter=self.RoundCounter+1

	--shopping stats
	
	self.GameState = GameState_Shopping

	--Teleport back to shop
	if self.Quest ~= nil and self.Quest.gamelengthquest == nil then
		self.Quest:CompleteQuest()
	end

	COverthrowGameMode:ResetStartVotes()
	self.QuickStartVoteBool = true

	all = HeroList:GetAllHeroes()
	--print("found")
	--print(#all)
	local pos1 = Entities:FindByName( nil, "team_base_1" ):GetAbsOrigin()
	local pos2 = Entities:FindByName( nil, "team_base_2" ):GetAbsOrigin()
	for i=1, #all do
		if all[i]:IsHero() and not (all[i]:IsIllusion()) then
			--print(all[i]:GetName())
			all[i]:RemoveModifierByName("modifier_cyclone")
			all[i]:SetHealth(20000.0)


			-- Combat Reset, Cooldowns Full HP MANA etc
			for j=0,5 do
				if all[i]:GetAbilityByIndex(j) ~= nil then
					all[i]:GetAbilityByIndex(j):EndCooldown()      --TODO revert when all heroes have 6 abilities
				end
			end		
			if all[i].Pet ~= nil and not all[i].Pet:IsNull() then 
				UTIL_Remove(all[i].Pet)
			end
			if all[i].Pet1 ~= nil and not all[i].Pet1:IsNull() then 
				UTIL_Remove(all[i].Pet1)
			end
			if all[i].Pet2 ~= nil and not all[i].Pet2:IsNull() then 
				UTIL_Remove(all[i].Pet2)
			end
			if all[i].ArenaControl ~= nil then 
				all[i].ArenaControl:SetRenderColor(255, 0, 0)
				all[i].ArenaControl:SetForwardVector(Vector(0,100,0))
				all[i].ArenaControl.child:SetRenderColor(255, 0, 0)
				all[i].ArenaControl.child:SetForwardVector(Vector(0,100,0))
			end
			local table2 = {}
			table2.Duration = 0.1
      all[i]:GetAbilityByIndex(1):ApplyDataDrivenModifier(all[i], all[i], "modifier_phased", table2)
      if all[i]:GetTeamNumber()==2 then

        all[i]:SetAbsOrigin(pos1)
        pos1[2]=pos1[2]-125	
        if all[i]:GetTeamNumber()==winningteam then
         StartAnimation(all[i], {activity=ACT_DOTA_VICTORY, duration=1.0, rate=1.0})
       end
     else	
      all[i]:SetAbsOrigin(pos2)
      pos2[2]=pos2[2]-125
      if all[i]:GetTeamNumber()==winningteam then
       StartAnimation(all[i], {activity=ACT_DOTA_VICTORY, duration=1.0, rate=1.0})
     end
   end
   --todo move camera
   --PlayerResource:SetCameraTarget(all[i]:GetPlayerOwnerID(), all[i])
   PlayerResource:SetCameraTarget(all[i]:GetPlayerOwnerID(), all[i])
   local saver = i
   Timers:CreateTimer(1.25,function() 
    PlayerResource:SetCameraTarget(all[saver]:GetPlayerOwnerID(), nil)
  end)

   --DPS calculations
   all[i].totaldamagedone = all[i].totaldamagedone + all[i].damagedone
   all[i].totalhealingdone = all[i].totalhealingdone + all[i].healingdone
   local time = 600 - timesaver
   if time <= 0 then
     time = 1
   end
   all[i].totaltimeplayed = all[i].totaltimeplayed + time
   all[i].dpsthisturn = all[i].damagedone / time
   all[i].hpsthisturn = all[i].healingdone / time

 end
end
end

function COverthrowGameMode:EndFarmMode()
	--shopping stats
	local timesaver = self.RoundCountdown
	self.RoundCountdown = 55 --no gold (below 53)
	self.GameState = GameState_Shopping

	self:PVEClearMobs()


	--self.RoundWonPerTeam[winningteam]=self.RoundWonPerTeam[winningteam]+1
	self.RoundCounter=self.RoundCounter+1

	--Teleport back to shop
	if self.Quest ~= nil and self.Quest.gamelengthquest == nil then
		self.Quest:CompleteQuest()
	end

	COverthrowGameMode:ResetStartVotes()
	self.QuickStartVoteBool = true

	all = HeroList:GetAllHeroes()
	local pos1 = Entities:FindByName( nil, "team_base_1" ):GetAbsOrigin()
	local pos2 = Entities:FindByName( nil, "team_base_2" ):GetAbsOrigin()
	for i=1, #all do
		if all[i]:IsHero() and not (all[i]:IsIllusion()) then
			print(all[i]:GetName())
			all[i]:RemoveModifierByName("modifier_cyclone")
			all[i]:SetHealth(20000.0)

			-- Combat Reset, Cooldowns Full HP MANA etc
			for j=0,5 do
				if all[i]:GetAbilityByIndex(j) ~= nil then
					all[i]:GetAbilityByIndex(j):EndCooldown()      --TODO revert when all heroes have 6 abilities
				end
			end		
			if all[i].Pet ~= nil and not all[i].Pet:IsNull() then 
				UTIL_Remove(all[i].Pet)
			end
			if all[i].Pet1 ~= nil and not all[i].Pet1:IsNull() then 
				UTIL_Remove(all[i].Pet1)
			end
			if all[i].Pet2 ~= nil and not all[i].Pet2:IsNull() then 
				UTIL_Remove(all[i].Pet2)
			end
			COverthrowGameMode:RemovePetsAfterBattle(all[i])
			if all[i].ArenaControl ~= nil then 
				all[i].ArenaControl:SetRenderColor(255, 0, 0)
				all[i].ArenaControl:SetForwardVector(Vector(0,100,0))
				all[i].ArenaControl.child:SetRenderColor(255, 0, 0)
				all[i].ArenaControl.child:SetForwardVector(Vector(0,100,0))
			end
			local table2 = {}
			table2.Duration = 0.1
      all[i]:GetAbilityByIndex(1):ApplyDataDrivenModifier(all[i], all[i], "modifier_phased", table2)
      if all[i]:GetTeamNumber()==2 then

        all[i]:SetAbsOrigin(pos1)
        pos1[2]=pos1[2]-125	
        if all[i]:GetTeamNumber()==winningteam then
         StartAnimation(all[i], {activity=ACT_DOTA_VICTORY, duration=1.0, rate=1.0})
       end
     else	
      all[i]:SetAbsOrigin(pos2)
      pos2[2]=pos2[2]-125
      if all[i]:GetTeamNumber()==winningteam then
       StartAnimation(all[i], {activity=ACT_DOTA_VICTORY, duration=1.0, rate=1.0})
     end
   end
   --todo move camera
   --PlayerResource:SetCameraTarget(all[i]:GetPlayerOwnerID(), all[i])
   PlayerResource:SetCameraTarget(all[i]:GetPlayerOwnerID(), all[i])
   local saver = i
   Timers:CreateTimer(1.25,function() 
    PlayerResource:SetCameraTarget(all[saver]:GetPlayerOwnerID(), nil)
  end)

   --DPS calculations
   all[i].totaldamagedone = all[i].totaldamagedone + all[i].damagedone
   all[i].totalhealingdone = all[i].totalhealingdone + all[i].healingdone
   local time = 600 - timesaver
   if time <= 0 then
     time = 1
   end
   all[i].totaltimeplayed = all[i].totaltimeplayed + time
   all[i].dpsthisturn = all[i].damagedone / time
   all[i].hpsthisturn = all[i].healingdone / time

   local all = HeroList:GetAllHeroes()
   --print("found heroes for gold add")
   --print(#all)
   
   --gold set
   --local gold = all[i].SavedGold
   --all[i].SavedGold = gold
   --all[i]:SetGold(gold, true)
   --all[i]:SetGold(0, false)


 end
end

end

---------------------------------------------------------------------------
-- Scan the map to see which teams have spawn points
---------------------------------------------------------------------------
function COverthrowGameMode:GatherAndRegisterValidTeams()
	print( "GatherValidTeams:" )
	local numTeams = 0
	local foundTeams = {}
	local foundTeamsList = {}
	-- My own Mode with 2 teams!
	
	
	for _, playerStart in pairs( Entities:FindAllByClassname( "info_player_start_dota" ) ) do
		foundTeams[  playerStart:GetTeam() ] = true
	end

	numTeams = TableCount(foundTeams)
	print( "GatherValidTeams - Found spawns for a total of " .. numTeams .. " teams" )
	
	
	for t, _ in pairs( foundTeams ) do
		print("t " .. t)
		table.insert( foundTeamsList, t )
	end
	

	if 	numTeams == 0 then
		print( "GatherValidTeams - NO team spawns detected, defaulting to GOOD/BAD" )
		table.insert( foundTeamsList, DOTA_TEAM_GOODGUYS )
		table.insert( foundTeamsList, DOTA_TEAM_BADGUYS )
		numTeams = 2
	end

	local maxPlayersPerValidTeam = math.floor( 10 / numTeams )

	self.m_GatheredShuffledTeams = ShuffledList( foundTeamsList )

	print( "Final shuffled team list:" )
	for _, team in pairs( self.m_GatheredShuffledTeams ) do
		print( " - " .. team .. " ( " .. GetTeamName( team ) .. " )" )
	end

	print( "Setting up teams:" )
	for team = 0, (DOTA_TEAM_COUNT-1) do
		local maxPlayers = 0
		if ( nil ~= TableFindKey( foundTeamsList, team ) ) then
			maxPlayers = maxPlayersPerValidTeam
		end
		print( " - " .. team .. " ( " .. GetTeamName( team ) .. " ) -> max players = " .. tostring(maxPlayers) )
		GameRules:SetCustomGameTeamMaxPlayers( team, maxPlayers )
		
	end

	-- fix 3v3, we dont want more than 2 teams
	if GetMapName() == "expert_pvp_3vs3" then
		GameRules:SetCustomGameTeamMaxPlayers( 2, 3 )
		GameRules:SetCustomGameTeamMaxPlayers( 3, 3 )
		self.rankedgame = PlayerResource:GetPlayerCount()
		if self.rankedgame ~= 4 and self.rankedgame ~= 6 then
			self.rankedgame = 0
		end
	end
	if GetMapName() == "expert_pvp_2vs2" then
		GameRules:SetCustomGameTeamMaxPlayers( 2, 2 )
		GameRules:SetCustomGameTeamMaxPlayers( 3, 2 )
		self.rankedgame = PlayerResource:GetPlayerCount()
		if self.rankedgame ~= 4 and self.rankedgame ~= 6 then
			self.rankedgame = 0
		end
	end
	if GetMapName() == "special_test_map" then
		--GameRules:SetCustomGameTeamMaxPlayers( 2, 2 )
		--GameRules:SetCustomGameTeamMaxPlayers( 3, 2 )
		self.rankedgame = 0
		self.testmode = 1
	end
	if GetMapName() == "special_moba_city_raid" then
		print("city raid mode")
		GameRules:SetCustomGameTeamMaxPlayers( 2, 10 )
		GameRules:SetCustomGameTeamMaxPlayers( 3, 10 )
		self.rankedgame = 0
		self.cityraidmode = 1
		self.GameState = GameState_CityRaid

		self.waypoint_top = {}
		self.waypoint_bot = {}

		self.waypoint_top[1] = Entities:FindByName(nil, "waypoint_bot_-1"):GetAbsOrigin()
		self.waypoint_top[2] = Entities:FindByName(nil, "waypoint_bot_0"):GetAbsOrigin()
		self.waypoint_top[3] = Entities:FindByName(nil, "waypoint_top_1"):GetAbsOrigin()
		self.waypoint_top[4] = Entities:FindByName(nil, "waypoint_top_2"):GetAbsOrigin()
		self.waypoint_top[5] = Entities:FindByName(nil, "waypoint_top_3"):GetAbsOrigin()
		self.waypoint_top[6] = Entities:FindByName(nil, "waypoint_top_4"):GetAbsOrigin()		
		self.waypoint_top[7] = Entities:FindByName(nil, "waypoint_bot_5"):GetAbsOrigin()
		self.waypoint_top[8] = Entities:FindByName(nil, "waypoint_bot_6"):GetAbsOrigin()

		self.waypoint_bot[1] = Entities:FindByName(nil, "waypoint_bot_-1"):GetAbsOrigin()
		self.waypoint_bot[2] = Entities:FindByName(nil, "waypoint_bot_0"):GetAbsOrigin()
		self.waypoint_bot[3] = Entities:FindByName(nil, "waypoint_bot_1"):GetAbsOrigin()
		self.waypoint_bot[4] = Entities:FindByName(nil, "waypoint_bot_2"):GetAbsOrigin()
		self.waypoint_bot[5] = Entities:FindByName(nil, "waypoint_bot_3"):GetAbsOrigin()
		self.waypoint_bot[6] = Entities:FindByName(nil, "waypoint_bot_4"):GetAbsOrigin()		
		self.waypoint_bot[7] = Entities:FindByName(nil, "waypoint_bot_5"):GetAbsOrigin()
		self.waypoint_bot[8] = Entities:FindByName(nil, "waypoint_bot_6"):GetAbsOrigin()		

		self.creepspawn_1 = Entities:FindByName(nil, "team_creepspawn_1"):GetAbsOrigin()	
		self.creepspawn_2 = Entities:FindByName(nil, "team_creepspawn_2"):GetAbsOrigin()

		self.farmspot = {}
		self.farmspot[1] = Entities:FindByName(nil, "farmspot_1"):GetAbsOrigin()
		self.farmspot[2] = Entities:FindByName(nil, "farmspot_2"):GetAbsOrigin()
		self.farmspot[3] = Entities:FindByName(nil, "farmspot_3"):GetAbsOrigin()
		self.farmspot[4] = Entities:FindByName(nil, "farmspot_4"):GetAbsOrigin()
		self.farmspot[5] = Entities:FindByName(nil, "farmspot_5"):GetAbsOrigin()
		self.farmspot[6] = Entities:FindByName(nil, "farmspot_6"):GetAbsOrigin()
		self.farmspot[7] = Entities:FindByName(nil, "farmspot_7"):GetAbsOrigin()
		self.farmspot[8] = Entities:FindByName(nil, "farmspot_8"):GetAbsOrigin()
		self.farmspot[9] = Entities:FindByName(nil, "farmspot_9"):GetAbsOrigin()
		self.farmspot[10] = Entities:FindByName(nil, "farmspot_10"):GetAbsOrigin()

		--tower leveling
		--tower scaling
		--local scale = PlayerResource:GetPlayerCountForTeam(2) + PlayerResource:GetPlayerCountForTeam(3) - 10
		local scale = math.floor((PlayerResource:GetPlayerCountForTeam(2) + PlayerResource:GetPlayerCountForTeam(3) - 6) + 0)
		if scale < 0 then
			scale = 0
		end
		Entities:FindByName(nil, "tower_good_top_2"):CreatureLevelUp(10+scale)
		Entities:FindByName(nil, "tower_good_top_3"):CreatureLevelUp(20+scale)
		Entities:FindByName(nil, "tower_good_bot_2"):CreatureLevelUp(10+scale)
		Entities:FindByName(nil, "tower_good_bot_3"):CreatureLevelUp(20+scale)
		Entities:FindByName(nil, "tower_bad_top_2"):CreatureLevelUp(10+scale)
		Entities:FindByName(nil, "tower_bad_top_3"):CreatureLevelUp(20+scale)
		Entities:FindByName(nil, "tower_bad_bot_2"):CreatureLevelUp(10+scale)
		Entities:FindByName(nil, "tower_bad_bot_3"):CreatureLevelUp(20+scale)	

		--boss spawn and scales
		local spawn = CreateUnitByName("npc_dota_creature_city_boss_1", Entities:FindByName(nil, "boss_good"):GetAbsOrigin(), true, nil, nil, DOTA_TEAM_GOODGUYS)
		spawn:CreatureLevelUp(scale)
		self.cityraidboss_1 = spawn
		spawn = CreateUnitByName("npc_dota_creature_city_boss_2", Entities:FindByName(nil, "boss_bad"):GetAbsOrigin(), true, nil, nil, DOTA_TEAM_BADGUYS)
		spawn:CreatureLevelUp(scale)
		self.cityraidboss_2 = spawn

	end
	self.PVEMode = 0
	--print(GetMapName())
	if true then --GetMapName() == "beginner_hero_level_1_to_9" or GetMapName() == "expert_hero_level_10_or_higher" then
		--AddShopWhitelistItem
		GameRules:SetCustomGameTeamMaxPlayers( 2, 5 )
		GameRules:SetCustomGameTeamMaxPlayers( 3, 0 )
		self.junglemode = 1
		self.jungledifficulty = 1.0
    self.difficultyMode = 1
    self.maxjungledifficulty = 1000
    self.minjungledifficulty = 1
    
    
    --find teleporters
    self.teleporters = {}
    self.teleporters[0] = Entities:FindByName( nil, "team_base_1" )
    self.teleporters[0].tp_active = true
    for i=1, 10 do
     self.teleporters[i] = Entities:FindByName( nil, "teleporter_"..tostring(i) )
   end
 end
 if GetMapName() == "beginner_pvp" then
  self.FarmMode = 1
  --print("farm mode on")
  self.rankedgame = 0
end
--self.version = 1
--if GetMapName() == "titanbreaker_season_2" or true then
  self.version = 2
  --end
  --print("gamestate = " .. self.GameState)
  --GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_CUSTOM_1, 2 ) -- changed to add 2 spectators
end

-- Spawning individual camps
function COverthrowGameMode:spawncamp(campname)
	--spawnunits(campname) todo wanted to stop spawns, works?
end

function TestmodeEndRound(event)
	COverthrowGameMode:EndArena(2)
end

-- Simple Custom Spawn
function spawnunits(campname)
	local spawndata = spawncamps[campname]
	local NumberToSpawn = spawndata.NumberToSpawn --How many to spawn
  local SpawnLocation = Entities:FindByName( nil, campname )
  local waypointlocation = Entities:FindByName ( nil, spawndata.WaypointName )
  if SpawnLocation == nil then
    return
  end

  local randomCreature = 
  {
    "basic_zombie",
    "berserk_zombie"
  }
  local r = randomCreature[RandomInt(1,#randomCreature)]
  --print(r)
  for i = 1, NumberToSpawn do
    local creature = CreateUnitByName( "npc_dota_creature_" ..r , SpawnLocation:GetAbsOrigin() + RandomVector( RandomFloat( 0, 200 ) ), true, nil, nil, DOTA_TEAM_BADGUYS )
    --print ("Spawning Camps")
    creature:SetInitialGoalEntity( waypointlocation )
  end
end

--------------------------------------------------------------------------------
-- Event: Filter for inventory full
--------------------------------------------------------------------------------
function COverthrowGameMode:ExecuteOrderFilter( filterTable )
	--[[
	for k, v in pairs( filterTable ) do
		print("EO: " .. k .. " " .. tostring(v) )
	end
	]]

	local orderType = filterTable["order_type"]

  if(orderType == DOTA_UNIT_ORDER_CAST_TOGGLE_ALT) then
    if(filterTable["entindex_ability"]) then
      local ability = EntIndexToHScript(filterTable["entindex_ability"])
      if(ability) then
        if(ability._ToggleAltCast ~= nil) then
          local status, errorMessage = pcall(function ()
            ability:_ToggleAltCast()
          end)
          if(status ~= true) then
            print("ToggleAltCast error: ", errorMessage)
          end
        end
        if(ability.OnAltCastToggled ~= nil) then
          local status, errorMessage = pcall(function ()
            ability:OnAltCastToggled()
          end)
          if(status ~= true) then
            print("OnAltCastToggled error: ", errorMessage)
          end
        end
      end
    end
  end

	if ( orderType ~= DOTA_UNIT_ORDER_PICKUP_ITEM or filterTable["issuer_player_id_const"] == -1 ) then
		return true
	else
		local item = EntIndexToHScript( filterTable["entindex_target"] )
		if item == nil then
			return true
		end
		local pickedItem = item:GetContainedItem()
		--print(pickedItem:GetAbilityName())
		if pickedItem == nil then
			return true
		end
		if pickedItem:GetAbilityName() == "item_treasure_chest" then
			local player = PlayerResource:GetPlayer(filterTable["issuer_player_id_const"])
			local hero = player:GetAssignedHero()
			if hero:GetNumItemsInInventory() < 6 then
				--print("inventory has space")
				return true
			else
				--print("Moving to target instead")
				local position = item:GetAbsOrigin()
				filterTable["position_x"] = position.x
				filterTable["position_y"] = position.y
				filterTable["position_z"] = position.z
				filterTable["order_type"] = DOTA_UNIT_ORDER_MOVE_TO_POSITION
				return true
			end
		end
	end
	return true
end

function COverthrowGameMode:OnNPCSpawned( keys )

	local npc = EntIndexToHScript(keys.entindex)
	local player = npc:GetOwner()

	if not self.GameState == GameState_CityRaid then
		npc:SetMinimumGoldBounty(0)
		npc:SetMaximumGoldBounty(0)
	end


	if npc:IsRealHero() and npc and not npc.bHeroSpawned then
		print("new npc spawned")
		npc.bHeroSpawned = true
		COverthrowGameMode:OnHeroInGame(npc)
	end

	if npc:GetUnitLabel() == "pet" then
   -- DPS System
   npc:AddAbility("combat_system_pet")
   local ability1 = npc:FindAbilityByName("combat_system_pet")
   if ability1 ~= nil then
     ability1:SetLevel(1)
   end
 end
end



function COverthrowGameMode:OnHeroInGame(hero)
  hero.savagery = {false, false, false}
  SetGold(hero, 0)
  hero.level = 1
  hero.levelPercentage = 0
  hero.xp = 0
  local heroName = hero:GetUnitName()
  local firstmsg = 120
  local secondmsg = 240
  local msgdur = 20
  local msglevelthreshold = 9
  -- This line for example will set the starting gold of every hero to 500 unreliable gold
  hero:RemoveModifierByName("modifier_silencer_int_steal")
  hero.spelldamage = 0
  hero.totaldamagedone = 0
  hero.totaltimeplayed = 0
  hero.damagedone = 0
  hero.healingdone = 0
  hero.totalhealingdone = 0
  --hero:SetGold(2375+1500, true) --gold here
  hero.mythic_dust = 0

  --camera fix
  PlayerResource:SetCameraTarget(hero:GetPlayerOwnerID(), hero)
  Timers:CreateTimer(0.25,function() 
    PlayerResource:SetCameraTarget(hero:GetPlayerOwnerID(), nil)
  end)

  --statistics
  hero.ability_bonus = 0
  hero.elemental_bonus = 0
  hero.crit_chance_factor = 0
  hero.crit_dmg_factor = 0
  hero.heal_bonus = 0
  hero.cooldown_reduction = 0
  hero.aggro_caused = 1
  hero.damage_done = 0
  hero.healing_done = 0
  hero.best_dps = 0
  hero.best_hps = 0
  hero.spellpower = 0

  hero:Stop()

  --artifacts
  hero.inventory = {}
  for i=1, self.mythic_slots do
    hero.inventory[i] = {}
  end
  --mastery path
  hero.talentpoints = 0 --0 + 150 --test
  hero.talents_without_pathwords = {}
  hero.talents = {}
  for i=1,self.maxtalents do
    hero.talents[i] = 0
  end
  hero.talents_clicked = {}
  for i=1,self.maxtalents do
    hero.talents_clicked[i] = 0
  end
  --act tracking
  hero.actentered = {}
  --dmg tracking per spell
  hero.spellcast_tracking = {}
  --new stash
  hero.stash = {}

  --inventory update
  local playerforinv = PlayerResource:GetPlayer(hero:GetPlayerID())
  Timers:CreateTimer(3.0,function() 
    CustomGameEventManager:Send_ServerToPlayer(playerforinv, "updateinventory", { value = 1})
  end)
  Timers:CreateTimer(90,function()
    if hero.level and hero.level < 10 then
      Notifications:Bottom(hero:GetPlayerID(), {text="You can find a Titanbreaker guide in the panel on the left, if you want to learn more about the game!", duration=12, style={color="violet"}})
    end
  end)

  --jungle mode
  if self.junglemode then
    hero:SetCanSellItems(false)
  end
  if false and self.junglemode and not self.spawnedtutorialdummy1 then
    local dummy_pos = Entities:FindByName( nil, "team_base_1" ):GetAbsOrigin()+Vector(-550,-350,0)
    self.spawnedtutorialdummy1 = CreateUnitByName("npc_dota_creature_tutorial_dummy", dummy_pos, true, nil, nil, 4)
    self.spawnedtutorialdummy1.position = dummy_pos
  end
  if false and self.junglemode and not self.spawnedtutorialdummy2 then
    local dummy_pos = Entities:FindByName( nil, "team_base_1" ):GetAbsOrigin()+Vector(-425,-100,0)
    self.spawnedtutorialdummy2 = CreateUnitByName("npc_dota_creature_tutorial_dummy", dummy_pos, true, nil, nil, 4)
    self.spawnedtutorialdummy2.position = dummy_pos
    self.spawnedtutorialdummy2:AddAbility("pve_dummy_resistance_1"):SetLevel(1)
    self.spawnedtutorialdummy2:SetBaseMaxHealth(5000000)
    self.spawnedtutorialdummy2:SetMaxHealth(5000000)
    self.spawnedtutorialdummy2:SetHealth(5000000)
  end
  if false and self.junglemode and not self.spawnedtutorialdummy3 then
    local dummy_pos = Entities:FindByName( nil, "team_base_1" ):GetAbsOrigin()+Vector(-300,150,0)
    self.spawnedtutorialdummy3 = CreateUnitByName("npc_dota_creature_tutorial_dummy", dummy_pos, true, nil, nil, 4)
    self.spawnedtutorialdummy3.position = dummy_pos
    self.spawnedtutorialdummy3:AddAbility("pve_dummy_resistance_1"):SetLevel(2)
    local hp = 1000000000
    self.spawnedtutorialdummy3:SetBaseMaxHealth(hp)
    self.spawnedtutorialdummy3:SetMaxHealth(hp)                           
    self.spawnedtutorialdummy3:SetHealth(hp)
  end

  --test for faster eval
  if false then
    Timers:CreateTimer(1.0,function() 
     local port = Entities:FindByName( nil, "teleporter_2" ):GetAbsOrigin()
     hero:SetAbsOrigin(port)
   end)
  end

  if self.junglemode then
    GameRules:GetGameModeEntity():SetBuybackEnabled(false)
    hero:SetBuybackCooldownTime(9999999)
    hero:SetGold(0, false)
    hero:SetGold(0, true)
    GameRules:GetGameModeEntity():SetStashPurchasingDisabled(true)
    --if not self.junglemodepremium then
     --print("stash disabled")
     --GameRules:GetGameModeEntity():SetStashPurchasingDisabled(true)
     --end
     --no longer stash buy
     --GameRules:GetGameModeEntity():SetStashPurchasingDisabled(true)
   end

   --if self.junglemode then
     hero.pvelives = 5
     --end
     if GetMapName() == "tod_hardcore" then
      hero.pvelives = 0
    end
    if GetMapName() == "tod_challenge_mode" then
      hero.pvelives = 1
    end
    
    if ((self.testmode or PlayerResource:GetPlayerCount() <= 1) and not self.junglemode) or IsInToolsMode() then
      --hero:SetGold(102375, true)
      --GameRules:SetGoldPerTick(100000)
      GameRules:SetGoldPerTick(0)
    end

    hero:SetAbilityPoints(0) --todo 0
    if GetMapName() ~= "special_moba_city_raid" then
      hero:SetCustomDeathXP(0)
    end 

    --ShowSeasonRewardsOffline(hero)

    -- Custom Resource Systems
    if heroName == "npc_dota_hero_axe" or heroName == "npc_dota_hero_dragon_knight" or heroName == "npc_dota_hero_beastmaster" or heroName == "npc_dota_hero_bristleback" or heroName == "npc_dota_hero_ursa" then
     -- Add the spell
     hero:AddAbility("rage_system"):SetLevel(1)
     hero.resourcesystem = 1
     if heroName ~= "npc_dota_hero_ursa" then
      hero.is_warrior = true
    end

    if heroName == "npc_dota_hero_ursa" then
      hero.super_aggro_tank = 1
    end
    if heroName == "npc_dota_hero_bristleback" then
      hero.super_aggro_tank = 1
      hero.super_aggro_tank_temple = 1
    end
    if heroName == "npc_dota_hero_dragon_knight" then
      hero.super_aggro_tank_prot = 1
    end
    -- Level it up
    --hero:FindAbilityByName("rage_system")
    --AdjustWarriorClassMana(hero)
    Timers:CreateTimer(firstmsg,function()
      if hero.level < msglevelthreshold then
        Notifications:Bottom(hero:GetPlayerID(), {text="Your hero does not use regular Mana as resource, instead he uses Rage to fuel his most powerful Abilities. You gain Rage when you attack or when you take Damage. Rage can not exceed 100 and does not benefit from the Intellect Attribute.", duration=msgdur, style={color="yellow"}})
      end
    end)
  end

  if heroName == "npc_dota_hero_dragon_knight" or heroName == "npc_dota_hero_phantom_lancer" then
   hero.super_aggro_tank = 1
   Timers:CreateTimer(secondmsg,function()
    if hero.level < msglevelthreshold then
     Notifications:Bottom(hero:GetPlayerID(), {text="You picked a Tank class. Try protection your teammates by holding aggro of dangerous monsters. You generate aggro mostly by dealing Damage, but also with certain Abilities.", duration=msgdur, style={color="yellow"}})
   end
 end)
 end
 if heroName == "npc_dota_hero_skeleton_king" then
  hero.super_aggro_tank = 1
  Timers:CreateTimer(secondmsg,function()
    if hero.level < msglevelthreshold then
      Notifications:Bottom(hero:GetPlayerID(), {text="You picked a Tank class. Try protection your teammates by holding aggro of dangerous monsters. You generate aggro mostly by dealing Damage, but also with certain Abilities.", duration=msgdur, style={color="yellow"}})
    end
  end)
end

if heroName == "npc_dota_hero_phantom_lancer" then
  Timers:CreateTimer(0.15,function()
   print("set pl model")
   if false then
    print("1")
    hero:SetModel("models/heroes/dragon_knight/dragon_knight.vmdl")
    print("2")
    hero:SetOriginalModel("models/heroes/dragon_knight/dragon_knight.vmdl")
    print("3")
    local myevent = {}
    print("4")
    myevent.caster = hero
    print("5")
    myevent.destroywearables = true
    print("6")
    --HideWearables(myevent) -- caused crash short moment after
    print("7")
    ShowSeasonRewards(hero)
    print("8")
    hero:SetHullRadius(30)
    print("9")
  end
end)
end

--if heroName == "npc_dota_hero_pugna" and false then
	--	hero:AddNewModifier(hero, hero:FindAbilityByName("destro4"), "modifier_charges",
	--	    {
   --	        max_count = 1,
   --	        start_count = 1,
   --	        replenish_time = 25
 --	    }
 --	)
 --end
 CheckForHeroChargeAbilities(hero)

 if heroName == "npc_dota_hero_lion" then
  hero.temple_class = 11
end
if heroName == "npc_dota_hero_skeleton_king" or heroName == "npc_dota_hero_sven" or heroName == "npc_dota_hero_pudge" or heroName == "npc_dota_hero_abaddon" or heroName == "npc_dota_hero_antimage" or heroName == "npc_dota_hero_terrorblade" or heroName == "npc_dota_hero_templar_assassin" then
 -- Add the spell
 hero:AddAbility("runic_system"):SetLevel(1)
 hero.resourcesystem = 3
 -- Level it up
 --hero:FindAbilityByName("runic_system")
 --AdjustWarriorClassMana(hero)
 if heroName == "npc_dota_hero_abaddon" then
  hero.super_aggro_tank = 1
  hero.super_aggro_tank_dk = 1
  hero.temple_class = 8
end
if heroName == "npc_dota_hero_terrorblade" then
  hero.super_aggro_tank = 1
  hero.super_aggro_tank_dh = 1
end
if heroName == "npc_dota_hero_templar_assassin" then
  hero.temple_class = 10
  hero.super_aggro_tank = 1
  hero.super_aggro_tank_dh = 1
end
if heroName == "npc_dota_hero_antimage" or heroName == "npc_dota_hero_terrorblade"  or heroName == "npc_dota_hero_templar_assassin" then
  hero.demonhunter = 1
  Timers:CreateTimer(firstmsg,function()
   if hero.level < msglevelthreshold then
    Notifications:Bottom(hero:GetPlayerID(), {text="Your hero does not use regular Mana as resource, instead he uses Felpower to fuel his most powerful Abilities. You gain Felpower when you attack or when you use your Fel Bash. Felpower can not exceed 100 and does not benefit from the Intellect Attribute.", duration=msgdur, style={color="yellow"}})
  end
end)
else
  Timers:CreateTimer(firstmsg,function()
   if hero.level < msglevelthreshold then
    if heroName == "npc_dota_hero_pudge" then
     Notifications:Bottom(hero:GetPlayerID(), {text="Your hero does not use regular Mana as resource, instead he uses Corruption to fuel his most powerful Abilities. You gain Corruption when you attack or when you use your Necrotic Strike. Corruption can not exceed 100 and does not benefit from the Intellect Attribute.", duration=msgdur, style={color="yellow"}})
   end
   if heroName == "npc_dota_hero_sven" then
     Notifications:Bottom(hero:GetPlayerID(), {text="Your hero does not use regular Mana as resource, instead he uses Corruption to fuel his most powerful Abilities. You gain Corruption when you attack or when you use your Frost Strike. Corruption can not exceed 100 and does not benefit from the Intellect Attribute.", duration=msgdur, style={color="yellow"}})
   end
   if heroName == "npc_dota_hero_skeleton_king" then
     Notifications:Bottom(hero:GetPlayerID(), {text="Your hero does not use regular Mana as resource, instead he uses Corruption to fuel his most powerful Abilities. You gain Corruption when you attack or when you use your Blood Disease. Corruption can not exceed 100 and does not benefit from the Intellect Attribute.", duration=msgdur, style={color="yellow"}})
   end
 end
end)
end
end

if heroName == "npc_dota_hero_phantom_assassin" or heroName == "npc_dota_hero_riki" or heroName == "npc_dota_hero_bounty_hunter" or heroName == "npc_dota_hero_slark" then
 -- Add the spell
 hero:AddAbility("energy_system"):SetLevel(1)
 hero.resourcesystem = 2
 hero.is_rogue = true
 -- Level it up
 --hero:FindAbilityByName("energy_system")
 hero.ComboPoints = 0
 --AdjustWarriorClassMana(hero)
 Timers:CreateTimer(firstmsg,function()
  if hero.level < msglevelthreshold then
   Notifications:Bottom(hero:GetPlayerID(), {text="Your hero does not use regular Mana as resource, instead he uses Energy to fuel his Abilities. You gain Energy every second. Energy can not exceed 100 and does not benefit from the Intellect Attribute.", duration=msgdur, style={color="yellow"}})
 end
end)
 Timers:CreateTimer(secondmsg,function()
  if hero.level < msglevelthreshold then
   Notifications:Bottom(hero:GetPlayerID(), {text="Some of your Abilities generate Focus Points which can be used to fuel your most powerful Abilities.", duration=msgdur, style={color="yellow"}})
 end
end)
end
if heroName == "npc_dota_hero_juggernaut" or heroName == "npc_dota_hero_mars" then
  -- Add the spell
  hero:AddAbility("energy_system"):SetLevel(1)
  hero.resourcesystem = 2
  hero.is_monk = true
  if heroName == "npc_dota_hero_mars" then
    hero.super_aggro_tank = 1
    hero.super_aggro_tank_monk = true
  end
end
if heroName == "npc_dota_hero_vengefulspirit" then
 hero.abil1 = 1
 hero.abil2 = 1
 hero.abil3 = 0
 hero.abil4 = 0
 hero.abil5 = 0
 hero:GetAbilityByIndex(5):ApplyDataDrivenModifier(hero, hero, "modifier_moonstance", nil)
 Timers:CreateTimer(firstmsg,function()
  if hero.level < msglevelthreshold then
   Notifications:Bottom(hero:GetPlayerID(), {text="Your hero has 2 different stances with completely different Abilities. Try to switch stances whenever you reach 5 Moon charges or 5 Sun charges to efficiently use them, unleashing this hero's maximum potential.", duration=msgdur, style={color="yellow"}})
 end
end)
end

if heroName == "npc_dota_hero_dazzle" then
 -- Add the spell
 hero.resourcesystem = 4
 hero.ComboPoints = 0
 hero.Shapeshift = 0
 hero.Catform = 1
 hero.spell1 = 1
 hero.spell2 = 1
 hero.spell3 = 0
 hero.spell4 = 0
 hero.spell5 = 0
 hero:AddAbility("energy_system"):SetLevel(1)
 
 hero:FindAbilityByName("energy_system"):ApplyDataDrivenModifier(hero, hero, "modifier_stunned", {Duration = 1.1})
 --AdjustWarriorClassMana(hero)
 Timers:CreateTimer(1.0,function()
  if self.FarmMode == 1 then
   hero.spell4 = 0
   hero.spell5 = 0 
 end
 local ability_shift =  hero:GetAbilityByIndex(5)
 ability_shift:SetLevel(1)
 local myevent = {}
 myevent.ability = ability_shift
 myevent.caster = hero
 ShapeshiftFeral(myevent)
 --ability_shift:ApplyDataDrivenModifier(hero, hero, "modifier_catform", nil)
 if self.FarmMode == 1 or true then
   ability_shift:SetLevel(0)
 end
end)
 
 Timers:CreateTimer(firstmsg,function()
  if hero.level < msglevelthreshold then
   Notifications:Bottom(hero:GetPlayerID(), {text="While in Catform, your hero does not use regular Mana as resource, instead he uses Energy to fuel his Abilities. You gain Energy every second. Energy can not exceed 100 and does not benefit from the Intellect Attribute.", duration=msgdur, style={color="yellow"}})
 end
end)
end

--silencer fix
if heroName == "npc_dota_hero_silencer" then
  Timers:CreateTimer(1.0,function() 
   hero:RemoveModifierByName("modifier_silencer_int_steal")
 end)
end

if heroName == "npc_dota_hero_drow_ranger" or heroName == "npc_dota_hero_sniper" or heroName == "npc_dota_hero_windrunner" or heroName == "npc_dota_hero_mirana" or heroName == "npc_dota_hero_clinkz" then
 -- Add the spell
 hero.resourcesystem = 5
 hero:AddAbility("focus_system"):SetLevel(1)
 Timers:CreateTimer(firstmsg,function()
  if hero.level < msglevelthreshold then
   Notifications:Bottom(hero:GetPlayerID(), {text="Your hero does not use regular Mana as resource, instead he uses Focus to fuel some of his Abilities. You gain Focus every second. Focus can not exceed 100 and does not benefit from the Intellect Attribute.", duration=msgdur, style={color="yellow"}})
 end
end)
 if heroName == "npc_dota_hero_clinkz" then
  hero.temple_class = 1 --ranger
  --AddTempleClassAbility(hero, nil, true) --random
  --AddTempleClassAbility(hero, nil, true) --random
  --AddTempleClassAbility(hero, nil, true) --random
  --AddTempleClassAbility(hero, nil, true) --random
  --AddTempleClassAbility(hero, nil, true) --random
end
end

if heroName == "npc_dota_hero_elder_titan" then
  hero.temple_class = 2 --shaman
end

if heroName == "npc_dota_hero_bristleback" then
  hero.temple_class = 3 --warrior
end

if heroName == "npc_dota_hero_chen" then
  hero.temple_class = 4 --pala
  hero.super_aggro_tank_pala = 1
  hero.super_aggro_tank = 1
end

if heroName == "npc_dota_hero_ogre_magi" then
  hero.temple_class = 5 --mage
end

--if heroName == "npc_dota_hero_enchantress" then
  --    hero.temple_class = 6 --druid support
  --end

  if heroName == "npc_dota_hero_keeper_of_the_light" then
    hero.temple_class = 7 --priest
  end

  if heroName == "npc_dota_hero_slark" then
    hero.temple_class = 9 --rogue
  end

  --full healers stats tracking
  if heroName == "npc_dota_hero_silencer" or heroName == "npc_dota_hero_omniknight" or heroName == "npc_dota_hero_furion" or heroName == "npc_dota_hero_witch_doctor" or heroName == "npc_dota_hero_oracle" then
    self.HealerTeamRatio[hero:GetOwner():GetTeamNumber()] = self.HealerTeamRatio[hero:GetOwner():GetTeamNumber()] + 1.0
    self.healersInGame = self.healersInGame + 1
    Timers:CreateTimer(firstmsg,function()
      if hero.level < msglevelthreshold then
       Notifications:Bottom(hero:GetPlayerID(), {text="You picked a Healer class. Try to heal wounded allies and dispel their debuffs to keep them alive. Read the Boss Abilities to see which debuffs can be dispelled and which can not.", duration=msgdur, style={color="yellow"}})
     end
   end)
  end
  --hybrid healers stats tracking
  if heroName == "npc_dota_hero_shadow_shaman" or heroName == "npc_dota_hero_dazzle" then
    self.HealerTeamRatio[hero:GetOwner():GetTeamNumber()] = self.HealerTeamRatio[hero:GetOwner():GetTeamNumber()] + 0.5
  end

  -- OOC System
  local abil_combat = hero:FindAbilityByName("combat_system")
  if not abil_combat then
    hero.combat_system_ability = hero:AddAbility("combat_system")
  else
    hero.combat_system_ability = abil_combat
  end
  hero.oocmana = 0 --todo make 0 for non mana users
  --print("added system to")
  --print(hero:GetName())
  -- Level it up
  local ability1 = hero:FindAbilityByName("combat_system")
  if ability1 ~= nil then
   ability1:SetLevel(1)
   --new sleep
   --ability1:ApplyDataDrivenModifier(hero, hero, "modifier_bane_nightmare", {Duration = 23})
   local stunTime = 25 --COverthrowGameMode.time_to_choose_ml
   if PlayerResource:GetTeamPlayerCount() <= 1 then
    stunTime = 15
  end
  ability1:ApplyDataDrivenModifier(hero, hero, "modifier_sap", {Duration = stunTime})
end

if hero:GetMaxMana() >= 250 then
 hero.oocmana = 1
end
-- set ooc for stealth users
if heroName == "npc_dota_hero_phantom_assassin" or heroName == "npc_dota_hero_riki" or heroName == "npc_dota_hero_bounty_hunter"  then
  hero.oocmana = 2 -- stealth
end
if heroName == "npc_dota_hero_dazzle" then
  hero.oocmana = 3 -- stealth feral druid
end

-- Set Starting Spells to lvl 1 todo fix for non wow heroes
if not (self.FarmMode == 1) then
  for i=0,5-5 do
   if hero:GetAbilityByIndex(i) ~= nil then
    hero:GetAbilityByIndex(i):SetLevel(1)
  end
end
else
  for i=0,2 do
   LevelNextAbility(hero)
 end
end

--spawn arena control unit
owner = hero:GetOwner()
teamid = hero:GetTeamNumber()
if GetMapName() ~= "special_moba_city_raid" then
  local origin = hero:GetAbsOrigin() + Vector(0,-200,0)
  hero.ArenaControl = CreateUnitByName("npc_dota_creature_basecontrol", origin, true, owner, nil, teamid)
  
  ParticleManager:CreateParticleForPlayer("particles/units/heroes/hero_silencer/silencer_last_word_status_ring_edge.vpcf", PATTACH_POINT_FOLLOW, hero.ArenaControl, owner)

  --hero.ArenaControl:SetForwardVector(Vector(0,100,0))
  hero.ArenaControl:SetHullRadius(1)
  hero.ArenaControl.controlowner = hero
  --caster.Pet:SetPlayerID(owner:GetPlayerID())
  hero.ArenaControl:SetControllableByPlayer(hero:GetPlayerID(), false)
  --hero.ArenaControl:SetRenderColor(255, 0, 0)

  --hero.ArenaControl:CreatureLevelUp(event.ability:GetLevel()-1)
  Timers:CreateTimer(0.1,function() 
    --print("team number " .. hero:GetTeamNumber())
    local table = {}
    table.Duration = 0.1
    local pos = Entities:FindByName( nil, "team_base_1" ):GetAbsOrigin()
    if self.junglemode then
     --print("temple!")
     hero.ArenaControl:RemoveAbility("arenastats")
     --local ability = hero.ArenaControl:AddAbility("savechar")
     --ability:SetLevel(1)
     --ability = hero.ArenaControl:AddAbility("loadchar")
     --ability:SetLevel(1)

     hero.ArenaControl:SetAbsOrigin(pos + Vector(100*self.team_control_pos_1,-75,0))
     hero:SetAbsOrigin(pos + Vector(525 + 125*self.team_control_pos_1, -125 - 125*self.team_control_pos_1,0))
     self.team_control_pos_1 = self.team_control_pos_1 + 1
     if GetMapName() ~= "tod_hardcore" then
      hero.ArenaControl:GetAbilityByIndex(0):ApplyDataDrivenModifier(hero.ArenaControl, hero, "modifier_pvelives", nil)
      hero:SetModifierStackCount("modifier_pvelives", hero.ArenaControl:GetAbilityByIndex(0), hero.pvelives)
    end
    --hero.ArenaControl:SetModel("models/props_debris/merchant_debris_chest001.vmdl")
    --hero.ArenaControl:SetOriginalModel("models/props_debris/merchant_debris_chest001.vmdl")
    --hero.ArenaControl:SetModelScale(0.7)
    --hero.ArenaControl:SetRenderColor(255, 255, 255)
    hero.ArenaControl:SetForwardVector(Vector(-1,0,0))
  else
   if hero:GetTeamNumber() ~= 2 then
    pos = Entities:FindByName( nil, "team_base_2" ):GetAbsOrigin()-Vector(400,0,0)
    hero.ArenaControl:SetOrigin(pos + Vector(70*self.team_control_pos_2,-425,0))
    self.team_control_pos_2 = self.team_control_pos_2 + 1
    hero.ArenaControl.child = CreateUnitByName("npc_dota_creature_basecontrol", origin, true, teamleader_1, nil, DOTA_TEAM_GOODGUYS)
    hero.ArenaControl.child:RemoveAbility("startarena")
    hero.ArenaControl.child:SetForwardVector(Vector(0,100,0))
    hero.ArenaControl.child:SetHullRadius(1)
    hero.ArenaControl.child:SetRenderColor(255, 0, 0)
    pos = Entities:FindByName( nil, "team_base_1" ):GetAbsOrigin()
    hero.ArenaControl.child:SetOrigin(pos + Vector(-100+70*self.team_control_pos_4,-500,0))
    self.team_control_pos_4 = self.team_control_pos_4 + 1
  else
    hero.ArenaControl:SetOrigin(pos + Vector(-100+70*self.team_control_pos_1,-425,0))
    self.team_control_pos_1 = self.team_control_pos_1 + 1
    hero.ArenaControl.child = CreateUnitByName("npc_dota_creature_basecontrol", origin, true, teamleader_2, nil, DOTA_TEAM_BADGUYS)
    hero.ArenaControl.child:RemoveAbility("startarena")
    hero.ArenaControl.child:SetForwardVector(Vector(0,100,0))
    hero.ArenaControl.child:SetHullRadius(1)
    hero.ArenaControl.child:SetRenderColor(255, 0, 0)
    pos = Entities:FindByName( nil, "team_base_2" ):GetAbsOrigin()-Vector(400,0,0)
    hero.ArenaControl.child:SetOrigin(pos + Vector(70*self.team_control_pos_3,-500,0))
    self.team_control_pos_3 = self.team_control_pos_3 + 1
  end
  hero:GetAbilityByIndex(1):ApplyDataDrivenModifier(hero, hero.ArenaControl, "modifier_phased", table)
  hero:GetAbilityByIndex(1):ApplyDataDrivenModifier(hero, hero.ArenaControl.child, "modifier_phased", table)
end

if self.testmode then
 local ability = hero.ArenaControl:AddAbility("testmode_endround")
 ability:SetLevel(1)
end
end)
else
		--[[--
		local origin = hero:GetAbsOrigin() + Vector(0,-200,0)
		hero.ArenaControl = CreateUnitByName("npc_dota_creature_basecontrol_cityraid", origin, true, owner, nil, teamid)
		
		ParticleManager:CreateParticleForPlayer("particles/units/heroes/hero_silencer/silencer_last_word_status_ring_edge.vpcf", PATTACH_POINT_FOLLOW, hero.ArenaControl, owner)

		hero.ArenaControl:SetForwardVector(Vector(0,100,0))
		hero.ArenaControl:SetHullRadius(1)
		hero.ArenaControl.controlowner = hero
		--caster.Pet:SetPlayerID(owner:GetPlayerID())
	 	hero.ArenaControl:SetControllableByPlayer(hero:GetPlayerID(), true)
	 	--]]
  end


  --fix that energy systems are only instantiated once (counters etc)
  Timers:CreateTimer(1.0,function() 
    hero.SpawnedAlready = 1
    --try to get rewards if not already received
    --if GameRules:PlayerHasCustomGameHostPrivileges(hero:GetPlayerOwner()) then
      --print("host has joined the game, starting reward request from server")
      --COverthrowGameMode:GetSeasonRewards()
      --end
    end)

  if hero.resourcesystem and not (heroName == "npc_dota_hero_dazzle") then
    local player = PlayerResource:GetPlayer(hero:GetPlayerID())
    CustomGameEventManager:Send_ServerToPlayer(player, "set_mana_per_int", { mana = 0 } )
  end

  --armor adjust
  --if hero.combat_system_ability then
    --    hero:AddNewModifier(hero, ability, "modifier_armor_formula",
    --        { }
    --    )
    --end

    --  Test ----------------------------------------------------------------------------------------------------------------------
    --_G.GameMechanics:PeriodicDebug(hero)
    --print(_G.GameMechanics)
    local genesisDelay = 15
    Timers:CreateTimer(genesisDelay,function() 
      if hero.combat_system_ability and hero.talents and hero.talents[135] > 0 then
       hero.combat_system_ability:ApplyDataDrivenModifier(hero, hero, "modifier_talent_genesis", {duration = 120 + 60 * hero.talents[135]})
     end
   end)
  end

  function COverthrowGameMode:OnDamageTaken(keys)
   --local npc = EntIndexToHScript(keys.entindex)
   --GameMechanics:DamageTaken(keys)
   for key,val in pairs(keys) do
    print(key, val)
  end
end

function AdjustWarriorClassMana( hero ) 
  Timers:CreateTimer(0.1,function() 
   --local heroLevel = hero:GetLevel()
   -- Adjust the new mana regen
   hero:SetBaseManaRegen(0.0)
 end)
end
















--EVENTS ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--[[ events.lua ]]

---------------------------------------------------------------------------
-- Event: Game state change handler
---------------------------------------------------------------------------
function COverthrowGameMode:OnGameRulesStateChange()
	local nNewState = GameRules:State_Get()
	print( "OnGameRulesStateChange: " .. nNewState )

	if nNewState == DOTA_GAMERULES_STATE_HERO_SELECTION then
		print("hero selection")
		COverthrowGameMode:GameWinConditionCheckVote()
	end

	if nNewState == DOTA_GAMERULES_STATE_PRE_GAME then
		local numberOfPlayers = PlayerResource:GetPlayerCount()
		print("PRE GAME STATE, players playing" .. numberOfPlayers)
		if numberOfPlayers > 7 then
			--self.TEAM_KILLS_TO_WIN = 25
			nCOUNTDOWNTIMER = 901
    elseif numberOfPlayers > 4 and numberOfPlayers <= 7 then
     --self.TEAM_KILLS_TO_WIN = 20
     nCOUNTDOWNTIMER = 721
   else
     --self.TEAM_KILLS_TO_WIN = 15
     nCOUNTDOWNTIMER = 601
   end
   if GetMapName() == "forest_solo" then
     self.TEAM_KILLS_TO_WIN = PlayerResource:GetTeamPlayerCount()*7
   elseif GetMapName() == "desert_duo" then
     self.TEAM_KILLS_TO_WIN = PlayerResource:GetTeamPlayerCount()*7
   else
     self.TEAM_KILLS_TO_WIN = PlayerResource:GetTeamPlayerCount()*7
   end

   self.PlayersPlaying = PlayerResource:GetPlayerCount()
   self.TEAM_KILLS_TO_WIN = PlayerResource:GetPlayerCount()*5/2
   if GetMapName() == "beginner_pvp" then 
     --print("pve map on")
     self.TEAM_KILLS_TO_WIN = PlayerResource:GetPlayerCount()*6/2
   end
   --print( "Kills to win = " .. tostring(self.TEAM_KILLS_TO_WIN) )
   CustomNetTables:SetTableValue( "game_state", "victory_condition", { kills_to_win = self.TEAM_KILLS_TO_WIN } );

   self._fPreGameStartTime = GameRules:GetGameTime()

   -- random hero for everyone who has not yet picked
   all = HeroList:GetAllHeroes()
   --print("found heroes for gold add")
   --print(#all)
   local hero
   for i=0, 15 do
     if PlayerResource:IsValidPlayerID(i) then
      if PlayerResource:HasSelectedHero(i) == false then
       print("player has not yet picked " .. i)
       --PlayerResource:SetHasRepicked(i)
       --PlayerResource:GetPlayer(i):MakeRandomHeroSelection()
     end
   end
 end
end

--show select difficulty panel
if nNewState == DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP and true then --(GetMapName() == "beginner_hero_level_1_to_9" or GetMapName() == "expert_hero_level_10_or_higher") then
  --print("show % selection")
  --CustomGameEventManager:Send_ServerToAllClients( "temple_show_difficulty_panel", {value = 1} )
end

if nNewState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
  print( "OnGameRulesStateChange: Game In Progress" )
  self.countdownEnabled = true
  CustomGameEventManager:Send_ServerToAllClients( "show_timer", {} )
  self.startcreepspawn = 1
  self.creeptimer = 0
  self.farmtimer = 0
  self.farmtimer_big = 0
  self.catapulttimer = 0
  self.farm_units = {}
  --DoEntFire( "center_experience_ring_particles", "Start", "0", 0, self, self  )
  if true then --GetMapName() == "beginner_hero_level_1_to_9" or GetMapName() == "expert_hero_level_10_or_higher" then
			--[[
			self:PopulateTemple(1)
			Timers:CreateTimer(2,function()
				self:PopulateTemple(2)
			end)
			Timers:CreateTimer(4,function()
				self:PopulateTemple(3)
			end)
			Timers:CreateTimer(6,function()
				self:PopulateTemple(4)
			end)
			Timers:CreateTimer(8,function()
				self:PopulateTemple(5)
			end)
			Timers:CreateTimer(10,function()
				self:PopulateTemple(6)
			end)
			Timers:CreateTimer(12,function()
				self:PopulateTemple(7)
			end)
			Timers:CreateTimer(14,function()
				self:PopulateTemple(8)
			end)
			Timers:CreateTimer(16,function()
				self:PopulateTemple(9)
			end)
			Timers:CreateTimer(18,function()
				self:PopulateTemple(10)
			end)
			--print("POPULATED TEMPLE")
			--]]
			self.EnableShapeshift = 1
			--GameRules:GetGameModeEntity():SetFogOfWarDisabled(true)
			--Timers:CreateTimer(100000.5,function() 
      --    GameRules:GetGameModeEntity():SetFogOfWarDisabled(false) --todo fog
      --end)
    end
    --COverthrowGameMode:GetSeasonRewards()
  end
  --print("gamestate = " .. self.GameState)
end

--------------------------------------------------------------------------------
-- Event: OnNPCSpawned
--------------------------------------------------------------------------------
--[[function COverthrowGameMode:OnNPCSpawned( event )
	local spawnedUnit = EntIndexToHScript( event.entindex )
	if spawnedUnit:IsRealHero() then
		-- Destroys the last hit effects
		local deathEffects = spawnedUnit:Attribute_GetIntValue( "effectsID", -1 )
		if deathEffects ~= -1 then
			ParticleManager:DestroyParticle( deathEffects, true )
			spawnedUnit:DeleteAttribute( "effectsID" )
		end
		if self.allSpawned == false then
			if GetMapName() == "mines_trio" then
				--print("mines_trio is the map")
				--print("self.allSpawned is " .. tostring(self.allSpawned) )
				local unitTeam = spawnedUnit:GetTeam()
				local particleSpawn = ParticleManager:CreateParticleForTeam( "particles/addons_gameplay/player_deferred_light.vpcf", PATTACH_ABSORIGIN, spawnedUnit, unitTeam )
				ParticleManager:SetParticleControlEnt( particleSpawn, PATTACH_ABSORIGIN, spawnedUnit, PATTACH_ABSORIGIN, "attach_origin", spawnedUnit:GetAbsOrigin(), true )
			end
		end
	end
end]]

--------------------------------------------------------------------------------
-- Event: BountyRunePickupFilter
--------------------------------------------------------------------------------
function COverthrowGameMode:BountyRunePickupFilter( filterTable )
  filterTable["xp_bounty"] = 0*2*filterTable["xp_bounty"]
  filterTable["gold_bounty"] = 0*2*filterTable["gold_bounty"]
  return true
end

---------------------------------------------------------------------------
-- Event: OnTeamKillCredit, see if anyone won
---------------------------------------------------------------------------
function COverthrowGameMode:OnTeamKillCredit( event )
  --	print( "OnKillCredit" )
  --	DeepPrint( event )

  self.lastKillGlobal = event.killer_userid
  local nKillerID = event.killer_userid
  local nTeamID = event.teamnumber
  local nTeamKills = 	event.herokills
  local nKillsRemaining = self.TEAM_KILLS_TO_WIN - nTeamKills

  --print("teamkills " .. nTeamKills)
  local broadcast_kill_event =
  {
    killer_id = event.killer_userid,
    team_id = event.teamnumber,
    team_kills = nTeamKills,
    kills_remaining = nKillsRemaining,
    victory = 0,
    close_to_victory = 0,
    very_close_to_victory = 0,
  }

  if nKillsRemaining <= 0 then
    -- no longer end game mid round
    --print("not over yet")
    --GameRules:SetCustomVictoryMessage( self.m_VictoryMessages[nTeamID] )
    --GameRules:SetGameWinner( nTeamID )
    --broadcast_kill_event.victory = 1
  elseif nKillsRemaining == 1 then
    EmitGlobalSound( "ui.npe_objective_complete" )
    broadcast_kill_event.very_close_to_victory = 1
  elseif nKillsRemaining <= self.CLOSE_TO_VICTORY_THRESHOLD then
    EmitGlobalSound( "ui.npe_objective_given" )
    broadcast_kill_event.close_to_victory = 1
  end

  --print("sending event")
  CustomGameEventManager:Send_ServerToAllClients( "kill_event", broadcast_kill_event )
end

---------------------------------------------------------------------------
-- Event: OnEntityKilled
---------------------------------------------------------------------------
function COverthrowGameMode:OnEntityKilled( event )
	local killedUnit = EntIndexToHScript( event.entindex_killed )
	local killedTeam = killedUnit:GetTeamNumber()-1
	local hero = EntIndexToHScript( event.entindex_attacker )
	local heroTeam = hero:GetTeam()
  if hero and hero:IsHero() then
    OnKillEffects(hero, killedUnit)
        --[[local deathXP = killedUnit:GetDeathXP()
	    if deathXP > 0 then
	    	local allhero = HeroList:GetAllHeroes()
		    local hero
		    for i=1, #allhero do
		        hero = allhero[i]
		        if (hero:GetAbsOrigin() - heroGettingXP:GetAbsOrigin()):Length() <= 2600 then
		            --if there are nearby heroes, they sucked some XP,this  counters this mechanic
		            nearby_heroes = nearby_heroes + 1
		        end
		    end
	    	local allHeroes = HeroList:GetAllHeroes()
	    	AddHeroExperience(deathXP)
	    end]]
    end
    --new swarm
    if killedUnit.swarm_on_death then
      local target_to_attack = hero
      if hero == killedUnit then
        target_to_attack = nil
      end
      SpawnMonsterSwarm(killedUnit.swarm_on_death, killedUnit.swarm_on_death_mincount, killedUnit.swarm_on_death_maxcount, killedUnit, killedUnit.swarm_on_death_random_offset, hero, true, nil, nil, killedUnit.pvescale)
    end
    if killedUnit:IsRealHero() then
      --screen blood
      PopupKillbannerPlayer(killedUnit, "firstblood")
      PopupKillbannerPlayer(hero, "triplekill_flare_d")
      
      --PopupKillbannerPlayer(hero, "doublekill")

      YinYangSystemReset( {caster = killedUnit} )
      ResetAllCooldowns(killedUnit)

      -- my own additions
      if self.GameState==GameState_Arena then
       --print(killedUnit:GetTeamNumber())
       self.HeroesAlivePerTeam[killedTeam]=self.HeroesAlivePerTeam[killedTeam]-1
       -- kill pet on death
       if killedUnit.Pet ~= nil and not killedUnit.Pet:IsNull() then
        UTIL_Remove(killedUnit.Pet)
      end
      if killedUnit.Pet1 ~= nil and not killedUnit.Pet1:IsNull() then
        UTIL_Remove(killedUnit.Pet1)
      end
      if killedUnit.Pet2 ~= nil and not killedUnit.Pet2:IsNull() then
        UTIL_Remove(killedUnit.Pet2)
      end
    end

    --remove pets
    COverthrowGameMode:RemovePetsAfterBattle(killedUnit)


    --remove farmed materials
    local mods = killedUnit:GetModifierCount()-1
    local first = true
    for i=0, mods do
     local name = killedUnit:GetModifierNameByIndex(i)
     if first and (name == "modifier_firecore" or name == "modifier_shadowcore" or name == "modifier_ironcore" or name == "modifier_naturecore" or name == "modifier_frostcore") then
      local stacks = killedUnit:GetModifierStackCount(name, nil)
      if stacks > 1 then
       killedUnit:SetModifierStackCount(name, nil, stacks-1)
     else
       killedUnit:RemoveModifierByName(name)
     end
     --first = false  --remove 1 stack of every!
   end
 end


 self.allSpawned = true
 --print("Hero has been killed")
 if hero:IsRealHero() and heroTeam ~= killedTeam then
   --print("Granting killer xp")
   if killedUnit:GetTeam() == self.leadingTeam and self.isGameTied == false then
    local memberID = hero:GetPlayerID()
    --PlayerResource:ModifyGold( memberID, 500, true, 0 )
    --hero:AddExperience( 100, 0, false, false )
    local name = hero:GetClassname()
    local victim = killedUnit:GetClassname()
    local kill_alert =
    {
      hero_id = hero:GetClassname()
    }
    CustomGameEventManager:Send_ServerToAllClients( "kill_alert", kill_alert )
  else
    --hero:AddExperience( 50, 0, false, false )
  end
end
--Granting XP to all heroes who assisted
local allHeroes = HeroList:GetAllHeroes()
for _,attacker in pairs( allHeroes ) do
 --print(killedUnit:GetNumAttackers())
 for i = 0, killedUnit:GetNumAttackers() - 1 do
  if attacker == killedUnit:GetAttacker( i ) then
   --print("Granting assist xp")
   --attacker:AddExperience( 25, 0, false, false )
 end
end
end
if self.junglemode then
 if killedUnit.pvelives and killedUnit.pvelives > 0 then
  if killedUnit.talents and killedUnit.talents[123] and killedUnit.talents[123] > 0 then
    Timers:CreateTimer(5, function()
      local stacks = killedUnit:GetModifierStackCount("modifier_growingpains", nil) + 1 + 2 * killedUnit.talents[123]
      if stacks > 50 then
        stacks = 50
      end
      killedUnit.combat_system_ability:ApplyDataDrivenModifier(killedUnit, killedUnit, "modifier_growingpains", {Duration = -1})
      killedUnit:SetModifierStackCount("modifier_growingpains", killedUnit.combat_system_ability, stacks)
    end)
  end
  local chance_not_lose_life = 0
  if killedUnit.talents and killedUnit.talents[63] and killedUnit.talents[63] > 0 then
    chance_not_lose_life = 7 * killedUnit.talents[63]
    if chance_not_lose_life > 50 then
      chance_not_lose_life = 50
    end
  end
  if ((killedUnit:HasModifier("modifier_item_crit_pure_immortal3") or killedUnit:HasModifier("modifier_item_crit_myth")) and math.random(1,100) <= 20) or (killedUnit.talents and killedUnit.talents[63] and killedUnit.talents[63] > 0 and math.random(1,100) <= chance_not_lose_life) or (killedUnit:HasModifier("modifier_ring_of_blood") and math.random(1,100) <= 50) then
    --print("no life lost")
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_windrunner/wr_taunt_kiss_heart.vpcf", PATTACH_WORLDORIGIN, killedUnit)
    ParticleManager:SetParticleControl(particle, 0, killedUnit:GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(particle)
    EmitGlobalSound("treant_treant_spawn_04")
  else
   killedUnit.pvelives = killedUnit.pvelives - 1
   local particle = ParticleManager:CreateParticle("particles/econ/items/wisp/wisp_death_ti7.vpcf", PATTACH_WORLDORIGIN, killedUnit)
   ParticleManager:SetParticleControl(particle, 0, killedUnit:GetAbsOrigin())
   ParticleManager:ReleaseParticleIndex(particle)
   particle = ParticleManager:CreateParticle("particles/units/heroes/hero_axe/axe_culling_blade_kill.vpcf", PATTACH_WORLDORIGIN, killedUnit)
   ParticleManager:SetParticleControl(particle, 4, killedUnit:GetAbsOrigin())
   ParticleManager:ReleaseParticleIndex(particle)
   self.total_lives_lost = self.total_lives_lost + 1
 end
 killedUnit:SetTimeUntilRespawn(2)
 killedUnit:SetModifierStackCount("modifier_pvelives", killedUnit.ArenaControl:GetAbilityByIndex(0), killedUnit.pvelives)
 if killedUnit.pvelives <= 0 then
   killedUnit:RemoveModifierByName("modifier_pvelives")
 end
 --tree of life
 if killedUnit.pvelives == 1 and GetGlobalTreeOfLifeBonus() > 0 and not COverthrowGameMode.treeOfLifePathApplied then
  COverthrowGameMode.treeOfLifePathApplied = true
  Timers:CreateTimer(5,function() 
    AddLivesToHero(killedUnit, GetGlobalTreeOfLifeBonus())
  end)
end
--imunity after death
if killedUnit.combat_system_ability then
  Timers:CreateTimer(2.1,function() 
    killedUnit.combat_system_ability:ApplyDataDrivenModifier(killedUnit, killedUnit, "modifier_talent_spiritwolf", {duration = 15})
    if killedUnit.talents and killedUnit.talents[135] and killedUnit.talents[135] > 0 then
     killedUnit.combat_system_ability:ApplyDataDrivenModifier(killedUnit, killedUnit, "modifier_talent_genesis", {duration = 60 + 60 * killedUnit.talents[135]})
   end
 end)
end
local tp_already = false
local tp = COverthrowGameMode.teleporters[1]
if tp and tp.tp_active then
  tp_already = true
  Timers:CreateTimer(2.5,function() 
    killedUnit:SetAbsOrigin(tp:GetAbsOrigin())
  end)
end
if not tp_already and COverthrowGameMode.act1_tp_clawza_active then
  Timers:CreateTimer(2.5,function() 
    local act_1_graveyard = Entities:FindByName( nil, "camp3" )
    killedUnit:SetAbsOrigin(act_1_graveyard:GetAbsOrigin()+Vector(-550,-1550,0))
  end)
end
if killedUnit.combat_system_ability then
  Timers:CreateTimer(2.75,function()
    killedUnit.combat_system_ability:ApplyDataDrivenModifier(killedUnit, killedUnit, "modifier_phased", {Duration = 0.5})
  end)
end
EmitGlobalSound("DOTA_Item.ArcaneBoots.Activate")
--cam
local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_chen/chen_teleport.vpcf", PATTACH_POINT_FOLLOW, killedUnit)
ParticleManager:ReleaseParticleIndex(particle)
PlayerResource:SetCameraTarget(killedUnit:GetPlayerOwnerID(), killedUnit)
Timers:CreateTimer(2.75,function() 
  PlayerResource:SetCameraTarget(killedUnit:GetPlayerOwnerID(), nil)
end)
--death voice and silencer int steal bug
Timers:CreateTimer(1.5,function() 
  local sounds = {
    "abaddon_abad_frostmourne_05",
    "abaddon_abad_lose_02",
    "abaddon_abad_frostmourne_07",
    "terrorblade_terr_death_03",
    "abaddon_abad_death_07",
    "haos_knight_chaknight_death_05",
    "chaos_knight_chaknight_death_07"
  }
  EmitGlobalSound(sounds[math.random(1,#sounds)])
  hero:RemoveModifierByName("modifier_silencer_int_steal")
end)
else
  killedUnit:SetTimeUntilRespawn(9999999)
  killedUnit.templepermadead = true
  EmitSoundOn("abaddon_abad_kill_03", killedUnit)
  local particle = ParticleManager:CreateParticle("particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_loadout.vpcf", PATTACH_WORLDORIGIN, killedUnit)
  ParticleManager:SetParticleControl(particle, 0, killedUnit:GetAbsOrigin())
  ParticleManager:ReleaseParticleIndex(particle)
  Timers:CreateTimer(3.5,function() 
    local particle = ParticleManager:CreateParticle("particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_gravemarker_lvl2.vpcf", PATTACH_WORLDORIGIN, killedUnit)
    ParticleManager:SetParticleControl(particle, 0, killedUnit:GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(particle)
    particle = ParticleManager:CreateParticle("particles/generic_hero_status/death_tombstone.vpcf", PATTACH_WORLDORIGIN, killedUnit)
    ParticleManager:SetParticleControl(particle, 0, killedUnit:GetAbsOrigin()+Vector(0,75,0))
    ParticleManager:ReleaseParticleIndex(particle)
  end)
  if killedUnit.ArenaControl then
    Timers:CreateTimer(1.5,function() 
      killedUnit:SetAbsOrigin(killedUnit.ArenaControl:GetAbsOrigin())
    end)
  end
end
else
  COverthrowGameMode:SetRespawnTime( killedTeam, killedUnit )
  if killedUnit:GetRespawnTime() > 1 then
    --print("Hero has long respawn time")
    if killedUnit:IsReincarnating() == true then
     --print("Set time for Wraith King respawn disabled")
     return nil
   else
     COverthrowGameMode:SetRespawnTime( killedTeam, killedUnit )
   end
 else
  COverthrowGameMode:SetRespawnTime( killedTeam, killedUnit )
end
end
end
end

function COverthrowGameMode:SetRespawnTime( killedTeam, killedUnit )
	--print("Setting time for respawn")
	if killedTeam == self.leadingTeam and self.isGameTied == false then
		killedUnit:SetTimeUntilRespawn(2)
	else
		killedUnit:SetTimeUntilRespawn(2)
	end
	if self.GameState == GameState_CityRaid then
		local time = killedUnit:GetLevel()*4 + 5
		killedUnit:SetTimeUntilRespawn(time)
	end
end


--------------------------------------------------------------------------------
-- Event: OnItemPickUp
--------------------------------------------------------------------------------
function COverthrowGameMode:OnItemPickUp( event )
	if event.itemname == "item_runeofdetection" then
		--local unit = EntIndexToHScript( event.HeroEntityIndex )
		--if unit:GetUnitLabel() == "pet" then
      --	unit = unit.owner
      --end
      --if unit == nil then
        --	return
        --end
        --if unit:IsNull() then
          --	return
          --end
          --local ab = unit:FindAbilityByName("combat_system")
          --if ab then
            --	ab:ApplyDataDrivenModifier(unit, unit, "modifier_runeofdetection", nil)
            --end

            return
          end

          local item = EntIndexToHScript( event.ItemEntityIndex )
          local owner = EntIndexToHScript( event.HeroEntityIndex )

	--[[if self.junglemode then
		print("try pickup")
		Timers:CreateTimer(0.1,function() 
	        if item and not item:IsNull() and owner then
	        	owner:DropItemAtPosition(owner:GetAbsOrigin()+Vector(0,-85,0), item)
		    	if owner:GetNumItemsInInventory() >= 6 and owner:GetNumItemsInStash() < 6 then
		    		local name = item:GetName()
		    		owner:AddItemByName( name )
		    		UTIL_Remove( item )
		    		return
		    	end
		    	if owner:GetNumItemsInInventory() < 6 then
		    		local name = item:GetName()
		    		owner:AddItemByName( name )
		    		UTIL_Remove( item )
		    		return
		    	end
			end
	    end)
   end--]]

   local r = 1000
   --r = RandomInt(200, 400)
   if event.itemname == "item_bag_of_gold" then
    --print("Bag of gold picked up")
    PlayerResource:ModifyGold( owner:GetPlayerID(), r, true, 0 )
    SendOverheadEventMessage( owner, OVERHEAD_ALERT_GOLD, owner, r, nil )
    UTIL_Remove( item ) -- otherwise it pollutes the player inventory
  elseif event.itemname == "item_treasure_chest" then
    --print("Special Item Picked Up")
    DoEntFire( "item_spawn_particle_" .. self.itemSpawnIndex, "Stop", "0", 0, self, self )
    COverthrowGameMode:SpecialItemAdd( event )
    UTIL_Remove( item ) -- otherwise it pollutes the player inventory
  end
  --print(owner:GetName())
  if owner:IsRealHero() then
    --print("Bag of gold picked up")
    --PlayerResource:ModifyGold( owner:GetPlayerID(), r, true, 0 )
    --SendOverheadEventMessage( owner, OVERHEAD_ALERT_GOLD, owner, r, nil )
    --print("bero")
  end
  

  --fix shareable loot
  Timers:CreateTimer(0.2,function() 
    if item.shareable then
      owner:RemoveItem(item)
      local it = owner:AddItemByName(event.itemname)
      it.shareable = 1
      --print("item time")
      --print(it:GetPurchaseTime())
      it:SetPurchaseTime(GameRules:GetGameTime()-20.0)
      --print(it:GetPurchaseTime())
    end
  end)
  
end

function GamblingPressedButton(event, args)
	local id = args['player_id']
	local player = PlayerResource:GetPlayer(id)
	local hero = player:GetAssignedHero()
	local item = args['item']
	--print("talent pressed "..nr)
	local goldcost = 100
	local quality = 4 --minimum is epic
  local slot = 1
  local artifact = true
  local bosskills = hero.bosskills
  if not bosskills then
    bosskills = 0
  end
  local requirekills = nil
  local requirekills_ancient = nil
  local require_monster_level = 0
  local require_kiirion = nil
  local molten_forge = nil
  local is_special_craft_item = false
  local token_required = nil

  local wasRandomGamble = false
  local requireTitanKills = 5
  if item >= 400 then --immortal
    goldcost = 500
    quality = 8
    if math.random(1,100) <= 10 then --aimo chance
      quality = 10
    end
    require_monster_level = 10
  end
  if item >= 600 then --divine
    goldcost = 5000 --1000
    quality = 12
    require_monster_level = 100
  end
  if item >= 700 then --myhical
    goldcost = 10000 --5000
    quality = 13
    require_monster_level = 200
  end
  slot = item % 100
  if slot >= 12 then --random slot
    slot = math.random(1,11)
    goldcost = goldcost / 2
    wasRandomGamble = true
  end
  local tokenUsed = false
  if hero:HasModifier("modifier_jungle_token") then
    tokenUsed = true
    goldcost = goldcost / 2
  end
  if slot == 3 and not COverthrowGameMode.act_12_cleared then
    if wasRandomGamble then
      slot = math.random(4,7)
    else
      Notifications:Top(hero:GetPlayerID(), {text="Requires defeating the King of the Jungle in Chapter 12!", duration=5, style={color="red"}})
      return
    end
  end
  if slot == 8 and not COverthrowGameMode.act_13_cleared then
    if wasRandomGamble then
      slot = math.random(9,11)
    else
      Notifications:Top(hero:GetPlayerID(), {text="Requires defeating the Ice King Izaiah in Chapter 13!", duration=5, style={color="red"}})
      return
    end
  end
  if slot == 10 then
    slot = "T"
  end
  if slot == 11 then
    slot = "E"
  end
  artifact = true
  is_special_craft_item = true
  molten_forge = true


  if COverthrowGameMode.jungledifficulty < require_monster_level then
    Notifications:Top(hero:GetPlayerID(), {text="Requires playing on Monster Level " .. require_monster_level .. " or higher!", duration=5, style={color="red"}})
    return
  end
  if require_kiirion then
    if not COverthrowGameMode.boss_kills_per_act or COverthrowGameMode.boss_kills_per_act[10] <= 0 then
      Notifications:Top(hero:GetPlayerID(), {text="Kiirion has not been defeated yet!", duration=5, style={color="red"}})
      return
    end
  end
  if molten_forge then
    if not COverthrowGameMode.boss_kills_per_act or COverthrowGameMode.boss_kills_per_act[8] <= 6 then
      Notifications:Top(hero:GetPlayerID(), {text="The Molten Forge has not been cleared yet!", duration=5, style={color="red"}})
      return
    end
  end
  if hero then
    --enough gold?
    if hero.buycooldown then
     Notifications:Top(hero:GetPlayerID(), {text="3 Seconds Cooldown!", duration=5, style={color="red"}})
     return
   end
   hero.buycooldown = true
   Timers:CreateTimer(3.0,function()
     hero.buycooldown = false
   end)
   if requirekills then
    if not hero.hasboughtimmortal then
      hero.hasboughtimmortal = 0
    end
    if bosskills and COverthrowGameMode.jungledifficulty and bosskills*COverthrowGameMode.jungledifficulty >= requirekills * (hero.hasboughtimmortal+1) then
     --hero.hasboughtimmortal = true
   else
     local missing_score = requirekills * (hero.hasboughtimmortal+1) - bosskills*COverthrowGameMode.jungledifficulty
     Notifications:Top(hero:GetPlayerID(), {text="You are missing "..missing_score.." Boss Kill Score to gamble for an [Ancient] Immortal Item.", duration=5, style={color="red"}})
     return
   end
 end
 if requirekills_ancient then
  if not hero.hasboughtancientimmortal then
    hero.hasboughtancientimmortal = 0
  end
  if bosskills and COverthrowGameMode.jungledifficulty and bosskills*COverthrowGameMode.jungledifficulty >= requirekills_ancient * (hero.hasboughtancientimmortal+1) then
    --hero.hasboughtimmortal = true
  else
    local missing_score = requirekills_ancient * (hero.hasboughtancientimmortal+1) - bosskills*COverthrowGameMode.jungledifficulty
    Notifications:Top(hero:GetPlayerID(), {text="You are missing "..missing_score.." Boss Kill Score to gamble for an [Ancient] Immortal Item.", duration=5, style={color="red"}})
    return
  end
end
if (not COverthrowGameMode.main_quests_completed) or (COverthrowGameMode.main_quests_completed < requireTitanKills) then
  Notifications:Top(hero:GetPlayerID(), {text="You need to kill "..requireTitanKills.." Titans to craft this Item.", duration=5, style={color="red"}})
  return
end
local gold = GetGold(hero) --hero:GetGold()
if goldcost <= gold then
 -- valid save possible?
 if ValidSavePossible(hero) then
  if is_special_craft_item then
    COverthrowGameMode:CraftSpecificArtifact( hero, quality, slot )
    if tokenUsed then
      COverthrowGameMode:ConsumeToken(hero, "modifier_jungle_token")
      Notifications:Top(hero:GetPlayerID(), {text="Badge of Honor used! Discount received!", duration=8, style={color="orange"}})
    end
    --if token_required then
      --    if hero:HasModifier(token_required) then
        --        COverthrowGameMode:ConsumeToken(hero, token_required)
        --        COverthrowGameMode:CraftSpecificArtifact( hero, quality, slot )
        --    else
        --        Notifications:Top(hero:GetPlayerID(), {text="You do not have the required materials!", duration=5, style={color="red"}})
          --        return
          --    end
          --end
        else
          COverthrowGameMode:DropTempleItem( hero, 100, 2, quality, artifact )
        end
        --hero:SetGold(gold-goldcost, true)
        --hero:SetGold(0, false)
        TryPayGold( hero, goldcost )
        if requirekills then
          hero.hasboughtimmortal = hero.hasboughtimmortal + 1
        end
        if requirekills_ancient then
          hero.hasboughtancientimmortal = hero.hasboughtancientimmortal + 1
        end
        --save game
        COverthrowGameMode:SaveChar(hero)
        --EmitSoundOn("ui.blacksmith_background", hero)
        --EmitSoundOn("sounds/vo/secretshop/secretshop_whatyoubuying_02.vsnd", hero)
        Timers:CreateTimer(10.5,function()
          EmitSoundOn("secretshop_secretshop_looksgood", hero)
        end)
        --end
      else
        Notifications:Top(hero:GetPlayerID(), {text="Crafting is only possible when you can make a valid save (without trying to save soulbound items in your shared stash)!", duration=5, style={color="red"}})
      end
    else
     Notifications:Top(hero:GetPlayerID(), {text="Not enough Gold!", duration=5, style={color="red"}})
   end
 end
end

function COverthrowGameMode:CraftSpecificArtifact( hero, quality, slot )
  if quality >= 8 then
    local weapon = "immo" .. slot .. "generate"
    if quality == 10 then
      weapon = "aimo" .. slot .. "generate"
    end
    if quality == 12 then
      weapon = "divi" .. slot .. "generate"
    end
    if quality == 13 then
      weapon = "myth" .. slot .. "generate"
    end
    --print(weapon)
    --EmitSoundOn("DOTA_Item.EtherealBlade.Target", hero)
    COverthrowGameMode:ThunderEffectAndSound(hero)
    COverthrowGameMode:CreateMythicWeapon( hero, weapon, false, nil, nil, nil, false )
  end
end


function GetDiscountTokenCount(hero)
  return hero:GetModifierStackCount("modifier_jungle_token", nil)
end

function GetDiscountTokenBestGoldValue()
  if COverthrowGameMode.jungledifficulty >= 200 then
    return 4000
  end
  return 2000
end

function COverthrowGameMode:ConsumeToken(hero, token_required)
  local stacks = hero:GetModifierStackCount(token_required, nil)
  if stacks > 1 and hero.combat_system_ability then
    hero:SetModifierStackCount(token_required, hero.combat_system_ability, stacks - 1)
  else
    hero:RemoveModifierByName(token_required)
  end
end

function ArtifactForgingPressedButton(event, args)
	local id = args['player_id']
	local player = PlayerResource:GetPlayer(id)
	local hero = player:GetAssignedHero()
	local slot = args['item']
	--print("forging pressed "..slot)
	local dust_cost = 0
	if slot == 1 then
		dust_cost = 25000
	end
	if slot == 2 then
		dust_cost = 25000
	end
	if slot == 3 then
		dust_cost = 25000
	end
	if slot == 4 then
		dust_cost = 10000
	end
	if slot == 5 then
		dust_cost = 10000
	end
	if slot == 6 then
		dust_cost = 10000
	end
	dust_cost = 1 --new mythic dust
	--higher cost for ancient immortals
	if hero and hero.inventory and hero.inventory[slot] and hero.inventory[slot][1] and COverthrowGameMode:IsWeapon(hero.inventory[slot][1]) and COverthrowGameMode:GetMythicWeaponQualityNumber(hero.inventory[slot][1]) >= 7 then
		dust_cost = 3
		Notifications:Top(hero:GetPlayerID(), {text="[Ancient] Artifacts can not be forged.", duration=5, style={color="red"}})
		return
	end
	--goldcost = goldcost / 10000
	if hero then
		--enough gold?
		local dust = hero.mythic_dust
		if dust and dust_cost <= dust then
			print(slot)
			if hero and hero.inventory and hero.inventory[slot] and COverthrowGameMode:IsWeapon(hero.inventory[slot][1]) and hero.inventory[slot][12] and hero.inventory[slot][13] then
				print("weapon "..hero.inventory[slot][1])
				local ilevel = hero.inventory[slot][12]
				local maxlevel = hero.inventory[slot][13]
				print("ilevel "..ilevel)
				print("maxlevel "..maxlevel)
				if ilevel < maxlevel * 2.0 then
					if COverthrowGameMode:IncreaseMythicWeaponStats(hero, slot) then
						COverthrowGameMode:MythicDustChange(hero, -dust_cost)
						COverthrowGameMode:SendHeroInventoryToAll(hero)
						EmitSoundOn("DOTA_Item.SoulRing.Activate", hero)
					else
						Notifications:Top(hero:GetPlayerID(), {text="Error 01!", duration=5, style={color="red"}})
					end
				else
					Notifications:Top(hero:GetPlayerID(), {text="Item above 200% of Max Level, can not be improved!", duration=5, style={color="red"}})
				end
			else
				Notifications:Top(hero:GetPlayerID(), {text="No Item equipped in that slot!", duration=5, style={color="red"}})
			end
		else
			Notifications:Top(hero:GetPlayerID(), {text="Not enough Mythic Dust!", duration=5, style={color="red"}})
		end
	end
end

function ItemLottery( event )
	local owner = event.caster
	local quality = event.quality
	if true then
		return
	end
	if owner:IsRealHero() then
		--print("Bag of gold picked up")
		--PlayerResource:ModifyGold( owner:GetPlayerID(), r, true, 0 )
		--SendOverheadEventMessage( owner, OVERHEAD_ALERT_GOLD, owner, r, nil )
		--UTIL_Remove( item ) -- otherwise it pollutes the player inventory
		if ValidSavePossible(owner) then
			print("bought rare")
			COverthrowGameMode:DropTempleItem( owner, 100, 2, quality, false )
			return
		else
			--refund gold
			print("no valid save")
			local gold = owner:GetGold()
			owner:SetGold(gold+1, true)
			owner:SetGold(0, false)
		end
	else
		--refund gold
		print("no hero")
		local gold = owner:GetGold()
		owner:SetGold(gold+1, true)
		owner:SetGold(0, false)
	end
end
--------------------------------------------------------------------------------
-- Event: OnNpcGoalReached
--------------------------------------------------------------------------------
function COverthrowGameMode:OnNpcGoalReached( event )
	local npc = EntIndexToHScript( event.npc_entindex )
	if npc:GetUnitName() == "npc_dota_treasure_courier" then
		COverthrowGameMode:TreasureDrop( npc )
	end
end

function PVERespawnPosition( event )
	if COverthrowGameMode.GameState ~= GameState_Farming then
		return
	end

	local caster = event.caster
	local pos1 = Entities:FindByName( nil, "pve_team1_1" ):GetAbsOrigin()-Vector(0,0,0)
	local pos2 = Entities:FindByName( nil, "pve_team2_1" ):GetAbsOrigin()-Vector(0,0,0)

	if caster:GetTeamNumber()==2 then	
		caster:SetAbsOrigin(pos1)
	else
		caster:SetAbsOrigin(pos2)
	end
	
	local tab = {}
	tab.Duration = 0.5
	caster:GetAbilityByIndex(1):ApplyDataDrivenModifier(caster, caster, "modifier_phased", tab)
	PlayerResource:SetCameraTarget(caster:GetPlayerOwnerID(), caster)
	Timers:CreateTimer(1.2,function() 
    PlayerResource:SetCameraTarget(caster:GetPlayerOwnerID(), nil)
  end)
end

function COverthrowGameMode:TipQuest( event )
	local q = SpawnEntityFromTableSynchronous( "quest", { name = "QuestName", title = "#QuestTip" } )
	q.EndTime = 15
	local subQuest = SpawnEntityFromTableSynchronous( "subquest_base", { 
   show_progress_bar = true, 
   progress_bar_hue_shift = -60 
 } )
	q:AddSubquest( subQuest )
	-- text on the quest timer at start
	q:SetTextReplaceValue( QUEST_TEXT_REPLACE_VALUE_CURRENT_VALUE, q.EndTime )
	q:SetTextReplaceValue( QUEST_TEXT_REPLACE_VALUE_TARGET_VALUE, q.EndTime )

	-- value on the bar
	subQuest:SetTextReplaceValue( SUBQUEST_TEXT_REPLACE_VALUE_CURRENT_VALUE, q.EndTime )
	subQuest:SetTextReplaceValue( SUBQUEST_TEXT_REPLACE_VALUE_TARGET_VALUE, q.EndTime )

	Timers:CreateTimer(1, function()
		if q ~= nil then
      q.EndTime = q.EndTime - 1
      q:SetTextReplaceValue( QUEST_TEXT_REPLACE_VALUE_CURRENT_VALUE, q.EndTime )
      subQuest:SetTextReplaceValue( QUEST_TEXT_REPLACE_VALUE_CURRENT_VALUE, q.EndTime )

      -- Finish the quest when the time is up  
      if q.EndTime == 0 then 
        --EmitGlobalSound("Tutorial.Quest.complete_01") -- Part of game_sounds_music_tutorial
        q:CompleteQuest()
        return
      else
        return 1 -- Call again every second
      end
    end
  end)
end

function COverthrowGameMode:FilterDamage( filterTable )
	--for k, v in pairs( filterTable ) do
   --	print("Damage: " .. k .. " " .. tostring(v) )
   --end
   local victim_index = filterTable["entindex_victim_const"]
   local attacker_index = filterTable["entindex_attacker_const"]
   if not victim_index or not attacker_index then
    filterTable["damage"] = 0
    return true
  end

  local victim = EntIndexToHScript( victim_index )
  local attacker = EntIndexToHScript( attacker_index )
  local victimMaxHealth = victim:GetMaxHealth()
  local blockFactor = 1
  --stop pet aa dmg
  if attacker:HasModifier("modifier_pet_system") or attacker:HasModifier("modifier_pet_system_grizzly") or attacker:HasModifier("modifier_uri_sleep") then
    filterTable["damage"] = 0
    return true
  end

  if victim.damageimune then
    filterTable["damage"] = 0
    return true
  end

  if attacker:HasModifier("modifier_omni_allow_heal") then
    filterTable["damage"] = 0
    return true
  end
  if victim:HasModifier("modifier_shieldreflect") then
    --filterTable["damage"] = 0
    return true
  end
  if victim.swordSwipeLevel and victim.swordSwipeLevel >= 4 then
    blockFactor = blockFactor + 0.03 * CountBuffs( victim, "modifier_prot_str_bonus" )
  end
  if victim:HasModifier("modifier_ursa_prot") then
    blockFactor = blockFactor + 0.5
  end
  local stoneSkin = victim:GetModifierStackCount("modifier_stoneskin", nil)
  if stoneSkin >= 1 and victim:HasModifier("modifier_pathbuff_109") then
    blockFactor = blockFactor + 0.01 * stoneSkin
  end
  local mars2 = victim:FindAbilityByName("mars2")
  if mars2 and mars2:GetLevel() >= 2 then
    blockFactor = blockFactor + 0.25
  end
  if GetLevelOfAbility(victim, "mars4") >= 3 then
    blockFactor = blockFactor + 0.01 * victim:GetPhysicalArmorValue(false)
  end
  
  if victim.blindfold_lickwounds_heal_counter and victim.blindfold_lickwounds_heal_counter >= 5 then
    victim.blindfold_lickwounds_heal_counter = 0
    local particle = ParticleManager:CreateParticle( "particles/items4_fx/combo_breaker_buff.vpcf", PATTACH_POINT_FOLLOW, victim )
    ParticleManager:SetParticleControl(particle, 1, victim:GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(particle)
    filterTable["damage"] = 0
    return true
  end
  if attacker.has_used_ravencraft_abilitypoint_item and not attacker:HasModifier("modifier_pathbuff_088") then
    filterTable["damage"] = 0
    return true
  end
  if HeroHasNeutralItem(victim, "item_neutral_14") and filterTable["damage"] > victimMaxHealth * 0.5 and not victim.titanShieldCD then
    filterTable["damage"] = 0
    victim.titanShieldCD = true
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_antimage/antimage_spellshield_sphere.vpcf", PATTACH_POINT_FOLLOW, victim)
    ParticleManager:ReleaseParticleIndex(particle)
    EmitSoundOn("DOTA_Item.ClarityPotion.Activate", victim)
    Timers:CreateTimer(30 * GetInnerCooldownFactor(victim),function()
      victim.titanShieldCD = false
    end)
    return true
  end
  --local damagetype = filterTable["damagetype_const"]

  --local inflictor = filterTable["entindex_inflictor_const"]
  local original_damage = filterTable["damage"] --Pre reduction
  local newdamage = original_damage * GetTotalDamageTakenFactor(victim, attacker)
  --soullink
  if victim.hellguard and victim:HasModifier("modifier_soullink") and not victim.hellguard:IsNull() and victim.hellguard:IsAlive() then
    newdamage = newdamage * 0.25
    local lifeCost = 0.1
    local hellguardHP = victim.hellguard:GetHealth()
    local hellguardMaxHP = victim.hellguard:GetMaxHealth()
    if hellguardMaxHP > 0 and not victim.hellguard_lifecost_cd then
      victim.hellguard_lifecost_cd = true
      Timers:CreateTimer(0.5,function()
        victim.hellguard_lifecost_cd = false
      end)
      if hellguardHP / hellguardMaxHP > lifeCost then
        victim.hellguard:SetHealth(victim.hellguard:GetHealth() - victim.hellguard:GetMaxHealth() * lifeCost)
        FireBloodRopeFX( victim, victim.hellguard )
      else
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_bloodseeker/bloodseeker_rupture_nuke.vpcf", PATTACH_WORLDORIGIN, victim)
        ParticleManager:SetParticleControl(particle, 0, victim.hellguard:GetAbsOrigin())
        ParticleManager:ReleaseParticleIndex(particle)
        victim.hellguard:Kill(victim.combat_system_ability, victim)
        victim.hellguard = nil
      end
    end
  end

  --behind target?
  local behindtarget = false
  local vec1 = victim:GetForwardVector()
  local vec2 = victim:GetAbsOrigin() - attacker:GetAbsOrigin()
  local direction = vec1[1]*vec2[1] + vec1[2]*vec2[2]
  if direction > 0 then
    behindtarget = true
  end

  --debuff
  if victim.tower_of_chaos_reduction then
    if victim.tower_of_chaos_reduction < 1 then
      newdamage = newdamage * (1 - victim.tower_of_chaos_reduction)
      victim.tower_of_chaos_reduction = 0
    end
  end
  if attacker:HasModifier("modifier_dh_slow") then
    newdamage = newdamage * 0.8
  end
  if attacker:HasModifier("modifier_cspear") then
    newdamage = newdamage * 0.95
  end
  if attacker:HasModifier("modifier_sou_minus") then
    newdamage = newdamage * 0.8
  end
  if attacker:HasModifier("modifier_dmg_reduce_roots") then
    newdamage = newdamage * 0.85
  end
  
  --if victim:HasModifier("modifier_killdance") then
    --    newdamage = 0 --newdamage * 0.1
    --end
    if victim:HasModifier("modifier_invul") then
      newdamage = newdamage * 0.1
    end
    if victim:HasModifier("modifier_rotdk") then
      newdamage = newdamage * 0.95
    end
    if victim:HasModifier("modifier_soulwarden_shield") then
      newdamage = newdamage * 0.25
    end
    if victim:HasModifier("modifier_prayer_shield") then
      newdamage = newdamage * 0.5
    end

    local restoStacks = victim:GetModifierStackCount("modifier_hot3", nil)
    if restoStacks > 0 then
      local restoReduction = 0.1 * restoStacks
      if restoReduction > 0.9 then
        restoReduction = 0.9
      end
      newdamage = newdamage * (1 - restoReduction)
    end
    
    
    
    --turtle affix
    if victim:HasModifier("modifier_turtle_shell") then
      if not behindtarget then
       newdamage = newdamage * 0.25
     else
       newdamage = newdamage * 1.25
     end
   end
   if attacker:HasModifier("modifier_smokebomb_miss_2") then
    newdamage = newdamage * 0.5
  end
  if attacker:HasModifier("modifier_warrior3dot") then
    newdamage = newdamage * 0.8
  end
  if victim:HasModifier("modifier_class_terror") and victim:HasModifier("modifier_dh_aa_heal") then
    newdamage = newdamage * 0.5
  end

  --boss max hp bug, solution reduce incoming dmg
  if victim.incoming_damage_factor then
    newdamage = newdamage * victim.incoming_damage_factor
  end

  --divine shield absorb
  local divineShield = victim.divine_shield
  if divineShield and divineShield >= 1 then
    if newdamage >= divineShield then
      newdamage = newdamage - divineShield
      victim:RemoveModifierByName("modifier_divine_shield")
      victim.divine_shield = 0
    else
      divineShield = divineShield - newdamage
      victim.divine_shield = divineShield
      victim:SetModifierStackCount("modifier_divine_shield", victim.combat_system_ability, divineShield)
      newdamage = 0
    end
  end

  --mana shield absorbtion mechanic
  local mana = victim:GetMana()
  local hppermana = 0
  if victim:HasModifier("modifier_molten_armor") then
    hppermana = hppermana + 45
  end
  if victim:HasModifier("modifier_nether_shield") then
    hppermana = hppermana + 50
  end
  if victim:HasModifier("modifier_moon_shield") then
    hppermana = hppermana + 35
  end
  if victim:HasModifier("modifier_mana_shield") then
    hppermana = hppermana + 40
  end
  local absorbFactor = 0.75
  if victim.talents and victim.talents[33] and victim.talents[33] > 0 and not victim.resourcesystem then
    local level = victim.talents[33]
    if hppermana > 0 then
      hppermana = hppermana * (1 + 0.5 * level)
    else
      hppermana = 45 + 5 * level
      absorbFactor = 0.45 + 0.05 * level
      local cap = 0.7
      --if victim:HasModifier("modifier_pathbuff_033") then
        --    cap = 0.8
        --end
        if absorbFactor > cap then
          absorbFactor = cap
        end
      end
    end
    hppermana = hppermana * GetAbsorbtionFactor( victim )
    if hppermana > 0 then
      local absorbabledamage = newdamage * absorbFactor
      local maxshield = mana*hppermana
      if maxshield >= absorbabledamage then --absorb all X%
        newdamage = newdamage - absorbabledamage
        victim:SetMana(mana - absorbabledamage / hppermana)
      else --absorb only a portion, we are oom
        victim:SetMana(0)
        newdamage = newdamage - maxshield
      end
    end

    --block agi sharpened senses
    --[[
    if victim.talents and victim.talents[19] and victim.talents[19] > 0 then
        local agi_block_range_melee = 0.05
        if not victim:IsRangedAttacker() then
            agi_block_range_melee = agi_block_range_melee * 1.5
        end
        local block_amount = agi_block_range_melee * victim.talents[19] * GetAgilityCustom(victim) * blockFactor
        if newdamage <= block_amount then
            newdamage = 0
        else
            newdamage = newdamage - block_amount
        end
      end]]

      --block terror
      local terror_block = victim:FindAbilityByName("terror6")
      if terror_block and terror_block:GetLevel() >= 4 then
        local block_amount = 0.2 * (GetAgilityCustom(victim) + GetStrengthCustom(victim)) * blockFactor
        if newdamage <= block_amount then
          newdamage = 0
        else
          newdamage = newdamage - block_amount
        end
      end

      --block agi moonglaive shield 45%
      local glaive_shield = victim:GetModifierStackCount("modifier_talent_moonglaive_shield", nil)
      if glaive_shield > 0 and victim.combat_system_ability and newdamage >= 5 then
        local block_factor = (0.3 + 0.1 * victim.talents[24]) * blockFactor
        if block_factor > 1 then
          block_factor = 1
        end
        newdamage = newdamage * (1 - block_factor)
        glaive_shield = glaive_shield - 1
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_antimage/antimage_spellshield_sphere.vpcf", PATTACH_POINT_FOLLOW, victim)
        ParticleManager:ReleaseParticleIndex(particle)
        EmitSoundOn("DOTA_Item.ClarityPotion.Activate", victim)
        if glaive_shield > 0 then
          victim:SetModifierStackCount("modifier_talent_moonglaive_shield", victim.combat_system_ability, glaive_shield)
        else
          victim:RemoveModifierByName("modifier_talent_moonglaive_shield")
        end
      end
	  
      -- np swift winds block damage shield
      local swiftWindsBlocks = victim:GetModifierStackCount("modifier_druid_evasion_h", nil)
      if swiftWindsBlocks > 0 and victim.combat_system_ability and newdamage >= 5 then
        local block_factor = 1
        newdamage = newdamage * (1 - block_factor)
        swiftWindsBlocks = swiftWindsBlocks - 1
        if swiftWindsBlocks >= 0 then
          victim:SetModifierStackCount("modifier_druid_evasion_h", victim.combat_system_ability, swiftWindsBlocks)
        end
      end
	  
      --block
      local block = 0
      if mars2 and mars2:GetLevel() >= 4 then
        block = block + victim:GetPhysicalArmorValue(false) + GetStrengthCustom(victim) * 0.1
      end
      if HeroHasNeutralItem(victim, "item_neutral_18") then
        block = block + 250
      end
      if victim.mars2reduction and victim.mars2reduction > 0 then
        block = block + original_damage * victim.mars2reduction
        victim.mars2reduction = 0
      end
      if GetLevelOfAbility(victim, "Ghost6") >= 3 then
        block = block + GetStrengthCustom(victim) * 0.5
      end
      if victim.talents and victim.talents[40] and victim.talents[40] > 0 then
        block = block + victim:GetMaxHealth() * victim.talents[40] * 0.001
      end
      local blockartifact = victim:GetModifierStackCount("modifier_mythic_block", nil)
      block = block + blockartifact
      block = block * blockFactor
      if victim.talents and victim.talents[11] and victim.talents[11] > 0 then
        local BoW = 0.03 * victim.talents[11] * blockFactor
        if BoW > 0.6 then
          BoW = 0.6
        end
        block = block + original_damage * BoW
      end
      newdamage = newdamage - block
      if newdamage < 0 then
        newdamage = 0
      end
      --shadow reflexes
      --if victim.talents and victim.talents[75] and victim.talents[75] > 0 then
        --    block = GetPrimaryStatValueCustom(victim) * 0.05 * victim.talents[75]
        --    newdamage = newdamage - block
        --    if newdamage < 0 then
          --        newdamage = 0
          --    end
          --end
          --shadow runes
          if victim.talents and victim.talents[95] and victim.talents[95] > 0 then
            local baseStats = GetStrengthCustom(victim) + GetAgilityCustom(victim) + GetIntellectCustom(victim)
            if victim:HasModifier("modifier_pathbuff_095") then
              baseStats = baseStats + GetStrengthCustom(victim)
            end
            block = baseStats * 0.05 * victim.talents[95]
            newdamage = newdamage - block
            if newdamage < 0 then
              newdamage = 0
            end
          end
          --wolf rider
          if victim.talents and victim.talents[60] and victim.talents[60] > 0 then
            local bonusfromms = victim:GetMoveSpeedModifier(victim:GetBaseMoveSpeed(), true) - 300
            bonusfromms = bonusfromms * 0.0005 * victim.talents[60]
            local wolf_dmg_factor = (1 - bonusfromms)
            if wolf_dmg_factor < 0.5 then
              wolf_dmg_factor = 0.5
            end
            newdamage = newdamage * wolf_dmg_factor
            if newdamage < 0 then
              newdamage = 0
            end
          end

          --ML 500 max hit block
          if (COverthrowGameMode.jungledifficulty >= 500 and victim:HasModifier("pve_boss_extra_resistances")) or victim:HasModifier("modifier_pve_act_affix_giant") then
            local factor = 0.2 --0.18
            if victim:HasModifier("modifier_pve_act_affix_giant") then
              factor = 0.15 --0.1
            end
            if attacker:HasModifier("modifier_giant") and math.random(1,100) <= 50 then
              factor = factor * 1.5
              local particle = ParticleManager:CreateParticle("particles/econ/items/phantom_assassin/pa_ti8_immortal_head/pa_ti8_immortal_stifling_dagger_explosion.vpcf", PATTACH_ABSORIGIN_FOLLOW, victim)
              ParticleManager:SetParticleControl(particle, 3, victim:GetAbsOrigin())
              ParticleManager:ReleaseParticleIndex(particle)
            elseif attacker:HasModifier("modifier_giant2") and math.random(1,100) <= 50 then
              factor = factor * 2
              local particle = ParticleManager:CreateParticle("particles/econ/items/phantom_assassin/pa_ti8_immortal_head/pa_ti8_immortal_stifling_dagger_explosion.vpcf", PATTACH_ABSORIGIN_FOLLOW, victim)
              ParticleManager:SetParticleControl(particle, 3, victim:GetAbsOrigin())
              ParticleManager:ReleaseParticleIndex(particle)
            end
            local max_dmg = victim:GetMaxHealth() * factor
            if newdamage > max_dmg then
              newdamage = max_dmg
              local particle = ParticleManager:CreateParticle( "particles/items4_fx/combo_breaker_buff.vpcf", PATTACH_POINT_FOLLOW, victim )
              ParticleManager:SetParticleControl(particle, 1, victim:GetAbsOrigin())
              ParticleManager:ReleaseParticleIndex(particle)
            end
          end

          --horde affix
          if victim:HasModifier("modifier_pve_act_affix_horde") then
            newdamage = newdamage * 0.75
          end
          --pack affix
          if victim:HasModifier("modifier_pve_act_affix_pack") then
            local monsters_nearby = CountNearbyMonsters(victim, 600)
            if monsters_nearby >= 2 then
              newdamage = newdamage / (monsters_nearby - 0.5)
            end
          end
          if victim:HasModifier("modifier_temple_tower") then
            if not victim:IsMoving() then
              newdamage = newdamage * 0.1
            else
              newdamage = newdamage * 1.25
            end
          end
          

          -- Extra rules for certain ability modifiers
          -- modifier-anti_magic_shell (Absorbs 300 magic damage)
          if victim:HasModifier("modifier_sacred_shield") and victim.AphoticShieldRemaining and not victim:HasModifier("modifier_unholyheal") then
            local shield_remaining = victim.AphoticShieldRemaining
            --print("remaining shield "..shield_remaining)
            if shield_remaining >= newdamage then
             victim.AphoticShieldRemaining = victim.AphoticShieldRemaining - newdamage
             if victim.pwssource.healingdone then
              victim.pwssource.healingdone = victim.pwssource.healingdone + newdamage
            end
            newdamage = 0
          else
           -- Absorb up to the limit and end
           newdamage = newdamage - shield_remaining
           victim.AphoticShieldRemaining = nil
           victim:RemoveModifierByName("modifier_sacred_shield")
           if victim.pwssource.healingdone then
            victim.pwssource.healingdone = victim.pwssource.healingdone + shield_remaining
          end
        end
      end

      --final blow?
      if victim.talents and victim.combat_system_ability then
        local lifeafterdamage = victim:GetHealth() - newdamage
        if victim.talents[57] and victim.talents[57] > 0 and not victim:HasModifier("modifier_talent57cd") and lifeafterdamage < (victim:GetMaxHealth() / 4) then
          newdamage = 0
          HealUnit({caster = victim, target = victim, ability = victim.combat_system_ability, heal = 0, percenthp = 10 * victim.talents[57] })
          local phoenix_cd = 180
          if victim.talents[90] and victim.talents[90] > 0 and victim:HasModifier("modifier_pathbuff_057") then
            phoenix_cd = phoenix_cd - 5 * victim.talents[90]
          end
          if victim:HasModifier("modifier_resaura") or victim:HasModifier("modifier_resaura2") then
            phoenix_cd = phoenix_cd * 0.85
          end
          phoenix_cd = phoenix_cd * GetInnerCooldownFactor(victim)
          if phoenix_cd < 45 then
            phoenix_cd = 45
          end
          local cdLower = victim.talents[57] * 10
          victim.combat_system_ability:ApplyDataDrivenModifier(victim, victim, "modifier_talent57cd", { Duration = phoenix_cd})
          --victim.combat_system_ability:ApplyDataDrivenModifier(victim, victim, "modifier_talent57_dmg", { Duration = 15})
          local dmgevent = {caster = victim, ability = victim.combat_system_ability, damage = 0, firedmg = 1, stun = victim.talents[57], attributefactor = 300*victim.talents[57], aoe = 900, targeteffect = "fire", isaoe = 1 }
          EmitSoundOn("Ability.LightStrikeArray", victim)
          local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_lina/lina_spell_light_strike_array.vpcf", PATTACH_POINT_FOLLOW, victim)
          ParticleManager:SetParticleControl(particle, 1, Vector(900,1,1))
          ParticleManager:ReleaseParticleIndex(particle)
          DamageAOE(dmgevent)
          local myevent = {caster = victim, amount = cdLower, ability = victim:GetAbilityByIndex(5)}
          ReduceCooldown(myevent)
          RestoreMana({caster = victim, percent = 1, amount = 10 * victim.talents[57]})
          victim.phoenixReduction = true
          Timers:CreateTimer(0.5 * victim.talents[57],function() 
            victim.phoenixReduction = false
          end)
        end
        lifeafterdamage = victim:GetHealth() - newdamage
        if victim.talents[42] and victim.talents[42] > 0 and not victim:HasModifier("modifier_talent42cd") then
          if lifeafterdamage < 1 and not IsImmortal(victim) then
            newdamage = 0
            local spiritwolfcd = 240 * GetInnerCooldownFactor(victim)
            if victim:HasModifier("modifier_resaura") or victim:HasModifier("modifier_resaura2") then
              spiritwolfcd = spiritwolfcd * 0.85
            end
            local spritiwolfduration = 1 * victim.talents[42]
            victim:SetHealth(victim:GetHealth()+victim:GetMaxHealth()*0.15*victim.talents[42])
            victim.combat_system_ability:ApplyDataDrivenModifier(victim, victim, "modifier_talent42cd", { Duration = spiritwolfcd})
            victim.combat_system_ability:ApplyDataDrivenModifier(victim, victim, "modifier_talent_spiritwolf", { Duration = spritiwolfduration })
            -- Moved to lua to be 100% sure it will be destroyed and released
            local victimAbsOrigin = victim:GetAbsOrigin()
            local firstParticle = ParticleManager:CreateParticle( "particles/sven_spell_warcry_ti_5_fixed.vpcf", PATTACH_POINT_FOLLOW, victim)
            local secondParticle = ParticleManager:CreateParticle("particles/units/heroes/hero_legion_commander/legion_commander_press.vpcf", PATTACH_ABSORIGIN_FOLLOW, victim)
            ParticleManager:SetParticleControlEnt(secondParticle, 0, victim, PATTACH_POINT_FOLLOW, "attach_hitloc", victimAbsOrigin, false)
            ParticleManager:SetParticleControlEnt(secondParticle, 1, victim, PATTACH_POINT_FOLLOW, "attach_hitloc", victimAbsOrigin, false)
            ParticleManager:SetParticleControlEnt(secondParticle, 2, victim, PATTACH_POINT_FOLLOW, "attach_hitloc", victimAbsOrigin, false)
            Timers:CreateTimer(spritiwolfduration, function()
              ParticleManager:DestroyParticle(firstParticle, false)
              ParticleManager:ReleaseParticleIndex(firstParticle)
              ParticleManager:DestroyParticle(secondParticle, false)
              ParticleManager:ReleaseParticleIndex(secondParticle)
            end)
          end
        end
      end
      --find last dmg
      if newdamage > 0 then
        attacker.last_damaged_target = victim
      end
      -- Reassign the new damage
      filterTable["damage"] = newdamage
      return true
    end

    function COverthrowGameMode:FilterExperience( filterTable )
      local experience = filterTable["experience"]
      local playerID = filterTable["player_id_const"]
      --local reason = filterTable["reason_const"]

      -- Disable all hero kill experience
      --if reason == DOTA_ModifyXP_HeroKill then
        --    return false
        --end
        --DeepPrintTable(filterTable)
        --print(experience)
        local player = PlayerResource:GetPlayer(playerID)
        local heroGettingXP = player:GetAssignedHero()
        local allhero = HeroList:GetAllHeroes()
        local hero
        local nearby_heroes = 0
        for i=1, #allhero do
          hero = allhero[i]
          if (hero:GetAbsOrigin() - heroGettingXP:GetAbsOrigin()):Length() <= 2600 then
            --if there are nearby heroes, they sucked some XP,this  counters this mechanic
            nearby_heroes = nearby_heroes + 1
          end
        end
        filterTable["experience"] = filterTable["experience"] * (0.625 + 0.375 *nearby_heroes)
        if heroGettingXP then
         AddHeroExperience(heroGettingXP, filterTable["experience"])
       end
       --print(filterTable["experience"])
       return true
     end

     function cityraid_pathing(event)
       local caster = event.caster
       local pos = caster:GetAbsOrigin()
       local self = COverthrowGameMode
       local waypointtrigger = 400
       --print("called")
       if not caster.timer then
        caster.timer = 58
      else
        caster.timer = caster.timer + 2
      end

      if caster.waypoint_top then
        --print("called 2")
        local current_wp = caster.waypoint_top
        local distancetonext = (pos - self.waypoint_top[current_wp]):Length()
        if caster.badguys then
         --badguys
         --print("called")
         if distancetonext < waypointtrigger and caster.waypoint_top > 1 then
          --order to next
          caster.waypoint_top = caster.waypoint_top - 1
        end
        if (distancetonext < waypointtrigger or caster.timer >= 60) then
          --order to next
          local order = 
          {
           UnitIndex = caster:entindex(),
           OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
           Position = self.waypoint_top[caster.waypoint_top], 
           Queue = false
         }
         ExecuteOrderFromTable(order)
       end
     else
       --goodguys
       if distancetonext < waypointtrigger and caster.waypoint_top < 8 then
        --order to next
        caster.waypoint_top = caster.waypoint_top + 1
      end
      if (distancetonext < waypointtrigger or caster.timer >= 60) then
        --order to next
        local order = 
        {
         UnitIndex = caster:entindex(),
         OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
         Position = self.waypoint_top[caster.waypoint_top], 
         Queue = false
       }
       ExecuteOrderFromTable(order)
     end
   end
 end

 if caster.waypoint_bot then
  local current_wp = caster.waypoint_bot
  local distancetonext = (pos - self.waypoint_bot[current_wp]):Length()
  if caster.badguys then
   --badguys
   if distancetonext < waypointtrigger and caster.waypoint_bot > 1 then
    --order to next
    caster.waypoint_bot = caster.waypoint_bot - 1
  end
  if (distancetonext < waypointtrigger or caster.timer >= 60) then
    --order to next
    local order = 
    {
     UnitIndex = caster:entindex(),
     OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
     Position = self.waypoint_bot[caster.waypoint_bot], 
     Queue = false
   }
   ExecuteOrderFromTable(order)
 end
else
 --goodguys
 if distancetonext < waypointtrigger and caster.waypoint_bot < 8 then
  --order to next
  caster.waypoint_bot = caster.waypoint_bot + 1
end
if distancetonext < waypointtrigger or caster.timer >= 60 then
  --order to next
  local order = 
  {
   UnitIndex = caster:entindex(),
   OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
   Position = self.waypoint_bot[caster.waypoint_bot], 
   Queue = false
 }
 ExecuteOrderFromTable(order)
end
end
end

if caster.timer >= 60 then
  caster.timer = 0
end
end

function city_item_drop(event)
	local caster = event.caster
	local attacker = event.attacker
	if attacker:GetUnitLabel() ~= "hero" then
   attacker = attacker.owner
   if attacker ~= nil and attacker:IsRealHero() then
    --okay, found owner of pet
    --print("corrected attacker for loot")
  else
    return
  end
end
local ability = event.ability
local buff = "none"
if caster.drop_frostcore then
  buff = "modifier_frostcore"
  --local item = CreateItem("item_frostcore", nil, nil)
  --local item2 = CreateItemOnPositionSync(caster:GetAbsOrigin(), item)
end
if caster.drop_firecore then
  buff = "modifier_firecore"
end
if caster.drop_shadowcore then
  buff = "modifier_shadowcore"
end
if caster.drop_naturecore then
  buff = "modifier_naturecore"
end
if caster.drop_ironcore then
  buff = "modifier_ironcore"
end
if caster.drop_goldcore then
  local item = CreateItem("item_bag_of_gold", nil, nil)
  local item2 = CreateItemOnPositionSync(caster:GetAbsOrigin(), item)
end

--team gold
local gold = caster:GetGoldBounty()*0.25
--print("gold function " .. gold)
local killer = attacker:GetTeamNumber()
local allhero = HeroList:GetAllHeroes()
local hero
for i=1, #allhero do
  hero = allhero[i]
  if hero ~= nil and gold > 0 then
   local dist = (caster:GetAbsOrigin()-hero:GetAbsOrigin()):Length()
   if hero:GetTeamNumber() == killer and hero ~= attacker and dist < 1200 then
    --print("hero " ..hero:GetName() .. " gold: " .. hero:GetGold())
    --print("gold " .. gold)
    local amount = gold + PlayerResource:GetUnreliableGold(hero:GetPlayerID())
    hero:SetGold(amount, false)

    --print("hero " ..hero:GetName() .. " gold: " .. hero:GetGold())
    local particle = ParticleManager:CreateParticle( "particles/econ/items/alchemist/alchemist_midas_knuckles/alch_knuckles_lasthit_coins.vpcf", PATTACH_POINT_FOLLOW, hero )
    ParticleManager:SetParticleControl(particle, 1, hero:GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(particle)
  end	
end
end

--reward material to random
if buff ~= "none" then
  local candidates = {}
  local index = 0
  for i=1, #allhero do
   hero = allhero[i]
   if hero ~= nil then
    local dist = (caster:GetAbsOrigin()-hero:GetAbsOrigin()):Length()
    if hero:GetTeamNumber() == killer and dist < 1200 then
     --candidates[index] = hero	
     --index = index + 1
     local stacks = hero:GetModifierStackCount(buff, nil)
     if stacks == 0 then
      ability:ApplyDataDrivenModifier(caster, hero, buff, nil)
      hero:SetModifierStackCount(buff, ability, 1)
    else
      hero:SetModifierStackCount(buff, ability, stacks+1)
    end
    local particle = ParticleManager:CreateParticle( "particles/econ/events/nexon_hero_compendium_2014/blink_dagger_start_nexon_hero_cp_2014.vpcf", PATTACH_WORLDORIGIN, hero )
    ParticleManager:SetParticleControl(particle, 0, hero:GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(particle)
  end	
end
end
		--[[
		index = index - 1
		if index >= 0 then
			local rnd = math.random(0,index)
			local stacks = candidates[rnd]:GetModifierStackCount(buff, nil)
			if stacks == 0 then
				ability:ApplyDataDrivenModifier(caster, candidates[rnd], buff, nil)
				candidates[rnd]:SetModifierStackCount(buff, ability, 1)
			else
				candidates[rnd]:SetModifierStackCount(buff, ability, stacks+1)
			end
			local particle = ParticleManager:CreateParticle( "particles/econ/events/nexon_hero_compendium_2014/blink_dagger_start_nexon_hero_cp_2014.vpcf", PATTACH_WORLDORIGIN, candidates[rnd] )
			ParticleManager:SetParticleControl(particle, 0, candidates[rnd]:GetAbsOrigin())
    end]]

  end

end

function city_boss_reset_distance(event)
	--print("reset called")
	local caster = event.caster
	local pos = caster:GetAbsOrigin()
	local maxdistance = 2000
	if caster:GetUnitName() == "npc_dota_creature_city_wolf_1" or caster:GetUnitName() == "npc_dota_creature_city_wolf_2" then
		maxdistance = 600
	end
	--print((caster.spawncamp-pos):Length())
	if caster.spawncamp and (caster.spawncamp-pos):Length() > maxdistance then
		local particle = ParticleManager:CreateParticle( "particles/econ/events/nexon_hero_compendium_2014/blink_dagger_start_nexon_hero_cp_2014.vpcf", PATTACH_WORLDORIGIN, caster )
		ParticleManager:SetParticleControl(particle, 0, caster:GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(particle)
    --ParticleManager:SetParticleControlEnt( particleLeader, PATTACH_OVERHEAD_FOLLOW, entity, PATTACH_OVERHEAD_FOLLOW, "follow_overhead", entity:GetAbsOrigin(), true )
    caster:SetHealth(99999)
    caster:SetAbsOrigin(caster.spawncamp)
    caster:Stop()
  end
end

function setcitygamewinner( event )
	local team = event.caster:GetTeamNumber()
	if team == 2 or team == 3 then
		COverthrowGameMode:EndGame(team)
	end
end

function AddCatapult( event )
	local caster = event.caster
	local team = caster:GetTeamNumber()
	if team == 2 then
		event.ability:ApplyDataDrivenModifier(caster, COverthrowGameMode.cityraidboss_1, "modifier_catapult", nil)
	end
	if team == 3 then
		event.ability:ApplyDataDrivenModifier(caster, COverthrowGameMode.cityraidboss_2, "modifier_catapult", nil)
	end
end

function CombineLegendary( event )
  local caster = event.caster

  --count materials
  local fire = caster:GetModifierStackCount("modifier_firecore", nil)
  local frost = caster:GetModifierStackCount("modifier_frostcore", nil)
  local shadow = caster:GetModifierStackCount("modifier_shadowcore", nil)
  local iron = caster:GetModifierStackCount("modifier_ironcore", nil)
  local nature = caster:GetModifierStackCount("modifier_naturecore", nil)

  --find steel item
  local item_steel
  local str 
  local agi
  local as
  local hp
  local intdmg
  local intheal
  for i=0,5 do
    local item = caster:GetItemInSlot(i)
    if item and item:GetName() == "item_smith_steel" then
     item_steel = item
   end
   if item and item:GetName() == "item_active13" then
     str = item
   end
   if item and item:GetName() == "item_caster4" then
     intdmg = item
   end
   if item and item:GetName() == "item_caster1" then
     intheal = item
   end
   if item and item:GetName() == "item_weapon8" then
     agi = item
   end
   if item and item:GetName() == "item_weapon4" then
     as = item
   end
   if item and item:GetName() == "item_hp2" then
     hp = item
   end
 end

 local buff
 local stacks
 if frost >= 2 and iron >= 1 and item_steel and str then
  buff = "modifier_frostcore"
  stacks = caster:GetModifierStackCount(buff, nil)
  if stacks > 2 then
   caster:SetModifierStackCount(buff, nil, stacks-2)
 else
   caster:RemoveModifierByName(buff)
 end
 buff = "modifier_ironcore"
 stacks = caster:GetModifierStackCount(buff, nil)
 if stacks > 1 then
   caster:SetModifierStackCount(buff, nil, stacks-1)
 else
   caster:RemoveModifierByName(buff)
 end

 caster:RemoveItem(item_steel)
 caster:RemoveItem(str)
 caster:AddItemByName("item_frostmourne")
 return
end 
if nature >= 2 and iron >= 1 and item_steel and agi then
  buff = "modifier_naturecore"
  stacks = caster:GetModifierStackCount(buff, nil)
  if stacks > 2 then
   caster:SetModifierStackCount(buff, nil, stacks-2)
 else
   caster:RemoveModifierByName(buff)
 end
 buff = "modifier_ironcore"
 stacks = caster:GetModifierStackCount(buff, nil)
 if stacks > 1 then
   caster:SetModifierStackCount(buff, nil, stacks-1)
 else
   caster:RemoveModifierByName(buff)
 end
 caster:RemoveItem(item_steel)
 caster:RemoveItem(agi)
 caster:AddItemByName("item_warglaive")
 return
end 
if fire >= 2 and iron >= 1 and item_steel and as then
  buff = "modifier_firecore"
  stacks = caster:GetModifierStackCount(buff, nil)
  if stacks > 2 then
   caster:SetModifierStackCount(buff, nil, stacks-2)
 else
   caster:RemoveModifierByName(buff)
 end
 buff = "modifier_ironcore"
 stacks = caster:GetModifierStackCount(buff, nil)
 if stacks > 1 then
   caster:SetModifierStackCount(buff, nil, stacks-1)
 else
   caster:RemoveModifierByName(buff)
 end
 caster:RemoveItem(item_steel)
 caster:RemoveItem(as)
 caster:AddItemByName("item_handoffirelord")
 return
end 
if shadow >= 2 and iron >= 1 and item_steel and intdmg then
  buff = "modifier_shadowcore"
  stacks = caster:GetModifierStackCount(buff, nil)
  if stacks > 2 then
   caster:SetModifierStackCount(buff, nil, stacks-2)
 else
   caster:RemoveModifierByName(buff)
 end
 buff = "modifier_ironcore"
 stacks = caster:GetModifierStackCount(buff, nil)
 if stacks > 1 then
   caster:SetModifierStackCount(buff, nil, stacks-1)
 else
   caster:RemoveModifierByName(buff)
 end
 caster:RemoveItem(item_steel)
 caster:RemoveItem(intdmg)
 caster:AddItemByName("item_shadowmourne")
 return
end 
if fire >= 1 and nature >= 1 and frost >= 1 and item_steel and intheal then
  buff = "modifier_frostcore"
  stacks = caster:GetModifierStackCount(buff, nil)
  if stacks > 1 then
   caster:SetModifierStackCount(buff, nil, stacks-1)
 else
   caster:RemoveModifierByName(buff)
 end
 buff = "modifier_naturecore"
 stacks = caster:GetModifierStackCount(buff, nil)
 if stacks > 1 then
   caster:SetModifierStackCount(buff, nil, stacks-1)
 else
   caster:RemoveModifierByName(buff)
 end
 buff = "modifier_firecore"
 stacks = caster:GetModifierStackCount(buff, nil)
 if stacks > 1 then
   caster:SetModifierStackCount(buff, nil, stacks-1)
 else
   caster:RemoveModifierByName(buff)
 end
 caster:RemoveItem(item_steel)
 caster:RemoveItem(intheal)
 caster:AddItemByName("item_eternallife")
 return
end 
if iron >= 1 and nature >= 1 and shadow >= 1 and item_steel and hp then
  buff = "modifier_shadowcore"
  stacks = caster:GetModifierStackCount(buff, nil)
  if stacks > 1 then
   caster:SetModifierStackCount(buff, nil, stacks-1)
 else
   caster:RemoveModifierByName(buff)
 end
 buff = "modifier_naturecore"
 stacks = caster:GetModifierStackCount(buff, nil)
 if stacks > 1 then
   caster:SetModifierStackCount(buff, nil, stacks-1)
 else
   caster:RemoveModifierByName(buff)
 end
 buff = "modifier_ironcore"
 stacks = caster:GetModifierStackCount(buff, nil)
 if stacks > 1 then
   caster:SetModifierStackCount(buff, nil, stacks-1)
 else
   caster:RemoveModifierByName(buff)
 end
 caster:RemoveItem(item_steel)
 caster:RemoveItem(hp)
 caster:AddItemByName("item_arcaniteshield")
 return
end 

end

function BuyMount( event )
	if GetMapName() ~= "special_moba_city_raid" then
		return
	end
	local caster = event.caster

	local particle = ParticleManager:CreateParticle( "particles/econ/events/ti5/blink_dagger_end_lvl2_ti5.vpcf", PATTACH_WORLDORIGIN, caster )
	ParticleManager:SetParticleControl(particle, 0, caster:GetAbsOrigin())
  ParticleManager:ReleaseParticleIndex(particle)
  local heroName = caster:GetUnitName()
  if heroName ~= "npc_dota_hero_drow_ranger" and heroName ~= "npc_dota_hero_sven" and heroName ~= "npc_dota_hero_omniknight" and heroName ~= "npc_dota_hero_shadow_shaman" then
    event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_mount_standard", nil)
    return
  end
  if event.standard then
    return
  end
  Timers:CreateTimer(0.1,function() 
    local gold = caster:GetGold()
    local id = caster:GetPlayerID()
    local xp = caster:GetCurrentXP()

    local spelllevels = {}
    local items = {}
    local pos = caster:GetAbsOrigin()
    for i=0,5 do
     spelllevels[i] = caster:GetAbilityByIndex(i):GetLevel()
   end
   for i=0,11 do
     items[i] = caster:GetItemInSlot(i)
     if items[i] then
      items[i] = items[i]:GetName()
    end
    --caster:DropItemAtPositionImmediate(items[i], pos) 
  end
  
  local newhero
  if heroName == "npc_dota_hero_drow_ranger" then
   newhero = "npc_dota_hero_mirana"
 end
 if heroName == "npc_dota_hero_sven" then
   newhero = "npc_dota_hero_abaddon"
 end
 if heroName == "npc_dota_hero_omniknight" then
   newhero = "npc_dota_hero_chen"
 end
 if heroName == "npc_dota_hero_shadow_shaman" then
   newhero = "npc_dota_hero_disruptor"
 end

 PrecacheUnitByNameAsync( newhero, function(unit)
   local hero = PlayerResource:ReplaceHeroWith(id, newhero, gold, xp)
   hero:AddExperience(xp,false, false)
   for i=0,5 do
    local ability = hero:GetAbilityByIndex(i):SetLevel(1)   --spelllevels[i])
  end
  for i=0,11 do
    if items[i] then
     hero:AddItemByName(items[i])
   end
 end
 --incase new ability
 local ab = hero:GetAbilityByIndex(6)
 if ab then
   ab:SetLevel(1)
 end
end, id )
end)
end

--[[ example charges on ability
unit:AddNewModifier(unit, unit:FindAbilityByName("ability_name"), "modifier_charges",
        {
            max_count = 2,
            start_count = 1,
            replenish_time = 6
        }
    )

    ]]

    -- Save Load PVE mode dungeon

    function SavePressed(event, args)
      local player = PlayerResource:GetPlayer(args['player_id'])
      local hero = player:GetAssignedHero()
      if hero and GameRules:GetGameTime() >= 15 then
        if hero.hero_load_reply_received then
          COverthrowGameMode:SaveChar(hero)
        else
          Notifications:Top(hero:GetPlayerID(), {text="You can not save before your hero did load!", duration=5, style={color="red"}})
        end
      end
    end

    function SaveMyChar(event)
     COverthrowGameMode:SaveChar(event.caster.controlowner)
   end

   function COverthrowGameMode:SaveChars()
     local all = HeroList:GetAllHeroes()
     local hero
     for i=1, #all do
      local id = all[i]:GetPlayerID()
      if PlayerResource:GetConnectionState(id) == DOTA_CONNECTION_STATE_DISCONNECTED or PlayerResource:GetConnectionState(id) == DOTA_CONNECTION_STATE_ABANDONED then
       --skip saving
     else
       COverthrowGameMode:SaveChar(all[i])
     end
   end
 end

 function ValidSavePossible(hero)
   if GameRules:IsCheatMode() and not IsInToolsMode() then
    return false
  end
  if hero.game_over then
    return
  end
    --[[
	for i = 12, 14 do
		local item = hero:GetItemInSlot(i)
		local item_reference = item
		if item then
			if not item:IsMuted() then
				item = item:GetName()
				item = string.sub(item, 6)
				if i >= 12 then
					if not item_reference.droppedthisgame then
						EmitGlobalSound("DOTA_Item.Necronomicon.Bow")
						Notifications:Top(hero:GetPlayerID(), {text="Could not save. You are trying to save a soulbound Item in a shared stash slot (the 3 rightmost slots are shared slots)!", duration=5, style={color="red"}})
						return false
					end
				end
			end
		end
	end]]
  --check all stashes
  for i = 1, 6*5 do --all stashes, 6 slots times 5
    local stash_index = math.floor(1 + (i-1) / 6)
    local stash_slot = ((i-1) % 6) + 1
    local item = GetStashTableItem( hero, stash_index, stash_slot) --8 offset from inventory and backpack
    --print("item in stash " .. stash_index .. " and slot " .. stash_slot .. " is named " .. items[i+8])
    if item and item ~= "no" then
      if IsItemNeutralItem(item) then
        return false
      end
      if stash_slot >= 4 then --shared items
        if not GetStashTableItemShareStatus( hero, stash_index, stash_slot) then
          return false
        end
      end
    end
  end
  return true
end

function IsItemNeutralItem( itemname )
  if itemname then
    local neutralItems = COverthrowGameMode:GetAllNeutralItems()
    for t = 1, #neutralItems do
      if itemname == neutralItems[t] then
        return true
      end
    end
  end
  return false
end

function COverthrowGameMode:SaveChar(hero)
	--if hero:GetCurrentXP() == 0 then
   --	print("can not save hero with 0 xp")
   --	return
   --end
   if GameRules:IsCheatMode() and not IsInToolsMode() then
    return
  end
  if hero.ArenaControl then
    hero.ArenaControl:RemoveAbility("loadchar")
  end
  --we have to save our current stash, it might have changes that have not saved yet
  SaveCurrentStashItemsToStashTable( hero, hero.current_stash_id )
  --local all = HeroList:GetAllHeroes()
  --for i=1, #all do
    local player = PlayerResource:GetPlayer(hero:GetPlayerID())
    local playerid = hero:GetPlayerID()
    local steamid = tostring(PlayerResource:GetSteamAccountID(playerid))
    --print(player)
    --print(playerid)
    --print(steamid)
    if not (PlayerResource:GetConnectionState(playerid) == DOTA_CONNECTION_STATE_DISCONNECTED or PlayerResource:GetConnectionState(playerid) == DOTA_CONNECTION_STATE_ABANDONED) then
     --print("saving char lua " .. hero:GetName())
     local heroname = hero:GetName()
     heroname = string.sub(heroname, 15)
     --print(heroname)
     local items = {}
     for i = 0, 8 do --inventory + backpack
      local item = hero:GetItemInSlot(i)
      local item_reference = item
      if item then
        if IsItemNeutralItem(item:GetName()) then
          EmitGlobalSound("DOTA_Item.Necronomicon.Bow")
          Notifications:Top(hero:GetPlayerID(), {text="Could not save! You are trying to save a neutral Item in a backpack stash slot! You can only save neutral Items in the neutral Item slot!", duration=5, style={color="red"}})
          return
        end
        if not item:IsMuted() then
          item = item:GetName()
          item = string.sub(item, 6)
          if i >= 12 then
           if not item_reference.droppedthisgame then
            EmitGlobalSound("DOTA_Item.Necronomicon.Bow")
            Notifications:Top(hero:GetPlayerID(), {text="Could not save. You are trying to save a soulbound Item in a shared stash slot (the 3 rightmost slots are shared slots)!", duration=5, style={color="red"}})
            if hero.ArenaControl then
             hero.ArenaControl:FindAbilityByName("savechar"):EndCooldown()
             local particle = ParticleManager:CreateParticle( "particles/econ/events/ti6/blink_dagger_end_ti6_lvl2.vpcf", PATTACH_POINT_FOLLOW, hero.ArenaControl )
             ParticleManager:ReleaseParticleIndex(particle)
           end
           return
         end
       end
     else
      item = "no"
    end
  else
   item = "no"
 end
 items[i] = item
 --print("item " .. i .. " " .. item)
end

--new toggle stash items
for i = 1, 6*5 do --all stashes, 6 slots times 5
  local stash_index = math.floor(1 + (i-1) / 6)
  local stash_slot = ((i-1) % 6) + 1
  items[i+8] = GetStashTableItem( hero, stash_index, stash_slot) --8 offset from inventory and backpack
  --print("item in stash " .. stash_index .. " and slot " .. stash_slot .. " is named " .. items[i+8])
  if items[i+8] and items[i+8] ~= "no" then
    if IsItemNeutralItem(items[i+8]) then
      EmitGlobalSound("DOTA_Item.Necronomicon.Bow")
      Notifications:Top(hero:GetPlayerID(), {text="Could not save! You are trying to save a neutral Item in the stash! You can only save neutral Items in the neutral Item slot!", duration=5, style={color="red"}})
      return
    end
    items[i+8] = string.sub(items[i+8], 6)
    if stash_slot >= 4 then --shared items
      if not GetStashTableItemShareStatus( hero, stash_index, stash_slot) then
        EmitGlobalSound("DOTA_Item.Necronomicon.Bow")
        Notifications:Top(hero:GetPlayerID(), {text="Could not save. You are trying to save a soulbound Item in a shared stash slot (the 3 rightmost slots are shared slots)!", duration=5, style={color="red"}})
        if hero.ArenaControl then
          hero.ArenaControl:FindAbilityByName("savechar"):EndCooldown()
          local particle = ParticleManager:CreateParticle( "particles/econ/events/ti6/blink_dagger_end_ti6_lvl2.vpcf", PATTACH_POINT_FOLLOW, hero.ArenaControl )
          ParticleManager:ReleaseParticleIndex(particle)
        end
        return
      end
    end
  else
    items[i+8] = "no"
  end
end
--print(" table items")
--DeepPrintTable(items)

local playername = PlayerResource:GetPlayerName(playerid)
--print(playername)
--if playername and playername == "" then
 --	playername = "unknown_titanbreaker"
 --end
 --print(playername)
 local xp = tostring(hero.xp)
 if hero.reset_hero_level_on_save then
  xp = "1"
end
local gold_to_save = GetGold(hero) + GetDiscountTokenCount(hero) * GetDiscountTokenBestGoldValue() --hero:GetGold()
local cost_for_path_reset = 100
local has_paid_for_path_reset = false
if hero.reset_path_next_load and gold_to_save >= cost_for_path_reset then
  gold_to_save = gold_to_save - cost_for_path_reset
  has_paid_for_path_reset = true
end
local goldsave = tostring(gold_to_save)
--print("save gold ")
--print(goldsave)
--print("xp " .. xp)
EmitGlobalSound("DOTA_Item.Hand_Of_Midas")
if hero.ArenaControl then
  local particle = ParticleManager:CreateParticle( "particles/econ/items/alchemist/alchemist_midas_knuckles/alch_knuckles_lasthit_coins.vpcf", PATTACH_POINT_FOLLOW, hero.ArenaControl )
  ParticleManager:SetParticleControl(particle, 1, hero.ArenaControl:GetAbsOrigin())
  ParticleManager:ReleaseParticleIndex(particle)
end
local bosskills = hero.bosskills
if not bosskills then
  bosskills = 0
end
bosskills = math.floor(bosskills*COverthrowGameMode.jungledifficulty*GetDifficultyModeBossScoreFactor())
if hero.loadedbosskills and hero.loadedbosskills > bosskills then
  bosskills = hero.loadedbosskills
end

--mythic items
local mythic_slots = self.mythic_slots
local mythic = {}
local mythicstat = {}
for x = 1, mythic_slots do
  mythic[x] = "no"
  if hero.inventory and hero.inventory[x] and hero.inventory[x][1] and self:IsWeapon(hero.inventory[x][1]) then
   mythic[x] = hero.inventory[x][1]
 end
 mythicstat[x] = {}
 for y = 1, 3 do
   mythicstat[x][y] = 0
   if hero.inventory and hero.inventory[x] and hero.inventory[x][y+4] then
    mythicstat[x][y] = hero.inventory[x][y+4]
  end
end
end
local livesleft = hero:GetModifierStackCount("modifier_pvelives", nil)
local path_points = "no"
if not has_paid_for_path_reset then
  path_points = ""
  for k=1, COverthrowGameMode.maxtalents do
   --print(path_points)
   if hero.talents_clicked and hero.talents_clicked[k] then
    path_points = path_points..tostring(hero.talents_clicked[k])
  else
    path_points = path_points.."0"
  end
end
end
local hc = 0
if GetMapName() == "tod_hardcore" then
  hc = 1
end
if GetMapName() == "tod_challenge_mode" then
  hc = 2
end
local dps = 0
if hero.best_dps then
  dps = hero.best_dps
end
local hps = 0
if hero.best_hps then
  hps = hero.best_hps
end
local temple_abilities = {}
local aggro_amount = GetDedicatedServerKeyV2("GetAggroKeyVTWO") --GetDedicatedServerKey("GetAggroKey")
--find keyv2
--if tostring(steamid) == "95413522" then
  --    Notifications:Bottom(hero:GetPlayerID(), {text=GetDedicatedServerKeyV2("GetAggroKeyVTWO"), duration=8, style={color="lightgreen"}})
  --end
  --print(aggro_amount)
  --temple class abilities
  for n=1, 5 do
    if hero.temple_class then
      local a = hero:GetAbilityByIndex(n)
      if a then
        temple_abilities[n] = a:GetName()
      else
        temple_abilities[n] = "no"
      end
    else
      temple_abilities[n] = "no"
    end
  end
  --temple abilities are now used to store neutral items!
  temple_abilities[1] = "no"
  --print("stash test neutral")
  local neutralItem = hero:GetItemInSlot(16)
  if neutralItem then
    print(neutralItem.heroOwner)
    print(hero)
    if not neutralItem:IsMuted() and neutralItem.heroOwner and neutralItem.heroOwner == hero then
      neutralItem = neutralItem:GetName()
      neutralItem = string.sub(neutralItem, 6)
      temple_abilities[1] = neutralItem
      print("stored neutral item " .. temple_abilities[1])
    end
  end

  --temple ability 2 is now used to store the mastery ability!
  temple_abilities[2] = "no"
  if hero.masteryAbility then
    temple_abilities[2] = hero.masteryAbility:GetName()
  end


  local send_data = { order = "savechar", hero = heroname, gold = goldsave, slot1 = items[0], slot2 = items[1], slot3 = items[2], slot4 = items[3], slot5 = items[4], slot6 = items[5], 
    slot7 = items[6], slot8 = items[7], slot9 = items[8], slot10 = items[9], slot11 = items[10], slot12 = items[11], slot13 = items[12], slot14 = items[13], slot15 = items[14], name = playername, pid = steamid, 
    exp = xp, kills = bosskills, lives = livesleft, mythic1 = mythic[1], mythic1stat1 = mythicstat[1][1], mythic1stat2 = mythicstat[1][2], mythic1stat3 = mythicstat[1][3], 
    mythic2 = mythic[2], mythic2stat1 = mythicstat[2][1], mythic2stat2 = mythicstat[2][2], mythic2stat3 = mythicstat[2][3],
    mythic3 = mythic[3], mythic3stat1 = mythicstat[3][1], mythic3stat2 = mythicstat[3][2], mythic3stat3 = mythicstat[3][3],
    mythic4 = mythic[4], mythic4stat1 = mythicstat[4][1], mythic4stat2 = mythicstat[4][2], mythic4stat3 = mythicstat[4][3],
    mythic5 = mythic[5], mythic5stat1 = mythicstat[5][1], mythic5stat2 = mythicstat[5][2], mythic5stat3 = mythicstat[5][3],
    mythic6 = mythic[6], mythic6stat1 = mythicstat[6][1], mythic6stat2 = mythicstat[6][2], mythic6stat3 = mythicstat[6][3],
    mythic7 = mythic[7], mythic7stat1 = mythicstat[7][1], mythic7stat2 = mythicstat[7][2], mythic7stat3 = mythicstat[7][3],
    mythic8 = mythic[8], mythic8stat1 = mythicstat[8][1], mythic8stat2 = mythicstat[8][2], mythic8stat3 = mythicstat[8][3],
    pathpoints = path_points, hardcore = hc,
    bestdps = 0, besthps = 0, ability1 = temple_abilities[1], ability2 = temple_abilities[2], ability3 = temple_abilities[3], ability4 = temple_abilities[4], ability5 = temple_abilities[5],
    aggro = aggro_amount
  }
  --new mythics
  for slotindex = 9, 11 do
    send_data["mythic" .. slotindex] = mythic[slotindex]
    for statindex = 1, 3 do
      send_data["mythic" .. slotindex .. "stat" .. statindex] = mythicstat[slotindex][statindex]
    end
  end
  for slotindex = 16, 39 do
    send_data["slot" .. slotindex] = items[slotindex-1]
  end
  COverthrowGameMode:SaveCharSendToServer(send_data, hero, steamid)
  --print("save table")
  --DeepPrintTable(send_data)
  --CustomGameEventManager:Send_ServerToPlayer(player, "savechar", send_data ) --old save system
  if hero.premium and hero.premium >= 6 then
    Notifications:Bottom(hero:GetPlayerID(), {text="Inventory, Backpack, Artifacts and Stash saved!", duration=8, style={color="lightgreen"}})
  else
    Notifications:Bottom(hero:GetPlayerID(), {text="Inventory, Backpack and Artifacts saved! If you need additional Item Save Slots (6 Stash Slots), check out www.catze.eu/titanbreaker.html !", duration=12, style={color="lightgreen"}})
  end
            --[[,
                --new stash toggle
                slot16 = items[15], slot17 = items[16], slot18 = items[17], slot19 = items[18], slot20 = items[19], slot21 = items[20], slot22 = items[21], slot23 = items[22], slot24 = items[23],
                slot25 = items[24], slot26 = items[16], slot27 = items[17], slot28 = items[18], slot29 = items[19], slot30 = items[20], slot22 = items[21], slot23 = items[22], slot24 = items[23]]
              end
              --end
            end

            function SaveCharSuccessNotification(event, args)
              local player = PlayerResource:GetPlayer(args['player_id'])
              local hero = player:GetAssignedHero()
              if hero then
                Notifications:Bottom(hero:GetPlayerID(), {text="Save successful!", duration=8, style={color="lightgreen"}})
              end
            end

            function LoadMyChar(caster)
              if IsServer() then
                --local hero = event.caster.controlowner
                local hero = caster
                --hero.charloaded = false--todo enable
                --if hero.charloaded then
                 --print("only one load per game")
                 --return
                 --end
                 local all = HeroList:GetAllHeroes()
                 --for i=1, #all do
                  local player = PlayerResource:GetPlayer(hero:GetPlayerID())
                  local playerid = hero:GetPlayerID()
                  local steamid = tostring(PlayerResource:GetSteamAccountID(playerid))
                  --if GameRules:PlayerHasCustomGameHostPrivileges(player) then
                    --print("loading char lua " .. steamid)
                    local heroname = hero:GetName()
                    heroname = string.sub(heroname, 15)
                    local hc = 0
                    if GetMapName() == "tod_hardcore" then
                     hc = 1
                   end
                   --new sys
                   local request = CreateHTTPRequestScriptVM( "POST", "http://catze.eu/loadchar_v15_season_10.php" )
                   request:SetHTTPRequestGetOrPostParameter("order", "loadchar")
                   request:SetHTTPRequestGetOrPostParameter("pid", tostring(steamid))
                   request:SetHTTPRequestGetOrPostParameter("hero", tostring(heroname))
                   request:Send(function(result)
                     --print("load char 1")
                     --print("save results")
                     --print(result)
                     --print(result.Body)
                     --Notifications:Bottom(hero:GetPlayerID(), {text="Save successful!", duration=8, style={color="lightgreen"}})
                     --if tostring(steamid) == "95413522" then
                      --    Notifications:Bottom(hero:GetPlayerID(), {text=result, duration=8, style={color="lightgreen"}})
                      --    Notifications:Bottom(hero:GetPlayerID(), {text=result.Body, duration=8, style={color="lightgreen"}})
                      --end
                      COverthrowGameMode:LoadCharReply({}, result)
                    end)
                   --CustomGameEventManager:Send_ServerToPlayer(player, "loadchar", { hero = heroname, playerid = steamid, hardcore = hc} ) --old system
                   --event.caster:RemoveAbility("loadchar")
                   --end
                   --end
                 end
               end

               function TempleDifficultyModeChange(event, args)
                if COverthrowGameMode.difficulty_is_set then
                  --return
                end
                local value = args['value']
                COverthrowGameMode.difficultyMode = value
                CustomGameEventManager:Send_ServerToAllClients( "temple_difficulty_mode_update", { value = COverthrowGameMode.difficultyMode} )
              end


              function TempleDifficultyChange(event, args)
               if COverthrowGameMode.difficulty_is_set then
                -- used to hide the window after the pick phase, incase the hidding bugged out
                CustomGameEventManager:Send_ServerToAllClients( "temple_show_difficulty_panel", {value = 0} )
                return
              end
              local value = args['value'] --up or down?
              local step = 1
              local oldvalue = COverthrowGameMode.jungledifficulty
              --down
              if COverthrowGameMode.jungledifficulty <= 2 then
                step = 1
              end
              if COverthrowGameMode.jungledifficulty == 5 and value == -1 then
                step = 3
              end
              if COverthrowGameMode.jungledifficulty == 10 and value == -1 then
                step = 5
              end
              if COverthrowGameMode.jungledifficulty == 20 and value == -1 then
                step = 10
              end
              if COverthrowGameMode.jungledifficulty == 50 and value == -1 then
                step = 30
              end
              if COverthrowGameMode.jungledifficulty == 100 and value == -1 then
                step = 50
              end
              if COverthrowGameMode.jungledifficulty == 200 and value == -1 then
                step = 100
              end
              if COverthrowGameMode.jungledifficulty == 500 and value == -1 then
                step = 300
              end
              if COverthrowGameMode.jungledifficulty == 1000 and value == -1 then
                step = 500
              end
              
              --up
              if COverthrowGameMode.jungledifficulty == 1 and value ~= -1 then
                step = 1
              end
              if COverthrowGameMode.jungledifficulty == 2 and value ~= -1 then
                step = 3
              end
              if COverthrowGameMode.jungledifficulty == 5 and value ~= -1 then
                step = 5
              end
              if COverthrowGameMode.jungledifficulty == 10 and value ~= -1 then
                step = 10
              end
              if COverthrowGameMode.jungledifficulty == 20 and value ~= -1 then
                step = 30
              end
              if COverthrowGameMode.jungledifficulty == 50 and value ~= -1 then
                step = 50
              end
              if COverthrowGameMode.jungledifficulty == 100 and value ~= -1 then
                step = 100
              end
              if COverthrowGameMode.jungledifficulty == 200 and value ~= -1 then
                step = 300
              end
              if COverthrowGameMode.jungledifficulty == 500 and value ~= -1 then
                step = 500
              end

              --new check requirements
              local max_ml_by_kill_score = GetHighestAllowedMonsterLevel()
              if max_ml_by_kill_score < COverthrowGameMode.jungledifficulty + step*value then
                local required_boss_score = (COverthrowGameMode.jungledifficulty + step*value) * 30
                Notifications:TopToAll({text="At least one of your team members needs a Boss Kill Score of " .. required_boss_score .. " to unlock this Monster Level.", duration=5, style={color="red"}})
                return
              end
              
              COverthrowGameMode.jungledifficulty = COverthrowGameMode.jungledifficulty + step*value
              if COverthrowGameMode.jungledifficulty < COverthrowGameMode.minjungledifficulty then
                COverthrowGameMode.jungledifficulty = COverthrowGameMode.minjungledifficulty
              end
              if COverthrowGameMode.maxjungledifficulty and COverthrowGameMode.jungledifficulty > COverthrowGameMode.maxjungledifficulty then
                COverthrowGameMode.jungledifficulty = COverthrowGameMode.maxjungledifficulty
              end
              if COverthrowGameMode.jungledifficulty ~= oldvalue then
                CustomGameEventManager:Send_ServerToAllClients( "temple_difficulty_update", { value = COverthrowGameMode.jungledifficulty} )
              end
            end

            function GetHighestAllowedMonsterLevel()
              local highest_kill_score = 1
              local all = HeroList:GetAllHeroes()
              for i=1, #all do
                if all[i] and all[i].loadedbosskills and all[i].loadedbosskills > highest_kill_score then
                  highest_kill_score = all[i].loadedbosskills
                end
              end
              local allowed_ml = math.floor(0.0001 + highest_kill_score / 30)
              if allowed_ml < 1 then
                allowed_ml = 1
              end
              return allowed_ml
            end

            function SellTempleItem(event, args)
             --print("event arrived sell item, playerid " .. args['player_id'])

             local id = args['player_id']
             local player = PlayerResource:GetPlayer(id)
             if player then
              -- sell last dropped, move other to interface
              local hero = player:GetAssignedHero()
              --print(hero:GetName())
              if hero then
               local item = hero.lasttempledrop_1
               if args['itemslot'] == 2 then
                --print("2nd removed")
                item = hero.lasttempledrop_2
              end
              if item and not item:IsNull() then
                local gold = item:GetCost() / 100
                --print(gold)
                if gold < 1.0 then
                  gold = 1
                  --local chance = 75 --gold * 100
                  --if chance >= math.random(1,100) then
                   --	gold = 1
                   --else
                   --	gold = 0
                   --end
                 end
                 EmitSoundOn("DOTA_Item.Hand_Of_Midas", hero)
                 if item:GetContainer() then
                   local particle = ParticleManager:CreateParticle( "particles/econ/items/alchemist/alchemist_midas_knuckles/alch_knuckles_lasthit_coins.vpcf", PATTACH_CUSTOMORIGIN, hero)
                   ParticleManager:SetParticleControl(particle, 1, item:GetContainer():GetAbsOrigin())
                   ParticleManager:ReleaseParticleIndex(particle)
                 else
                   local particle = ParticleManager:CreateParticle( "particles/econ/items/alchemist/alchemist_midas_knuckles/alch_knuckles_lasthit_coins.vpcf", PATTACH_CUSTOMORIGIN, hero)
                   ParticleManager:SetParticleControl(particle, 1, hero:GetAbsOrigin())
                   ParticleManager:ReleaseParticleIndex(particle)
                 end
                 --hero:SetGold(hero:GetGold()+gold, true)
                 --hero:SetGold(0, false)
                 AddGold(hero, gold)
                 if item:GetContainer() then
                   UTIL_Remove( item:GetContainer() )
                 else
                   UTIL_Remove( item )
                 end

                 hero.lasttempledrop = nil
                 if args['itemslot'] == 2 then
                   hero.lasttempledrop_2 = nil
                 else
                   hero.lasttempledrop_1 = nil
                 end
               end
             end
           end
         end

         function GetMyChest(event, args)
           local id = args['player_id']
           local player = PlayerResource:GetPlayer(id)
           local hero = player:GetAssignedHero()
           if hero then
            local unit = hero.ArenaControl
            if unit then
             --print("chest request, found chest")
             --print(unit)
             --
             --PlayerResource:SetOverrideSelectionEntity(id, unit)
             --PlayerResource:SetOverrideSelectionEntity(id, unit)
             CustomGameEventManager:Send_ServerToPlayer(player, "setmychest", { chest = unit:GetEntityIndex() } )
           end
         end
       end

       function TalentPointsSpentInTree(hero, tree)
         local sum = 0
         if tree <= 4 then
          --old tree
          for i=12*(tree-1)+1, 12*tree do
            if hero.talents_clicked[i] then
              sum = sum + hero.talents_clicked[i]
            end
          end
          --new talents
          local new_talents_per_tree = 3
          local offset = 48
          for i=new_talents_per_tree*(tree-1)+1+offset, new_talents_per_tree*tree+offset do
            if hero.talents_clicked[i] then
              sum = sum + hero.talents_clicked[i]
            end
          end
        else
          --new tree
          if tree <= 8 then
            for i=15*(tree-1)+1, 15*tree do
              if hero.talents_clicked[i] then
                sum = sum + hero.talents_clicked[i]
              end
            end
          else
            -- tree 9 or later
            for i=18*(tree-1)+1, 18*tree do
              if hero.talents_clicked[i] then
                sum = sum + hero.talents_clicked[i]
              end
            end
          end
          --print("tp sum " .. sum)
        end
        return sum
      end

      function COverthrowGameMode:GetTalentTreeByTalentPoint( talent )
        return GetTalentTreeByTalentPoint( talent )
      end

      function GetTalentTreeByTalentPoint( talent )
        local tree = 1 + math.floor((talent - 1) / 12)
        local new_talents_begin = 49
        if talent >= new_talents_begin and talent <= 60 then
          tree = 1 + math.floor((talent - new_talents_begin) / 3)
        end
        if talent >= 61 then
          tree = 1 + math.floor((talent - 1) / 15)
        end
        if talent >= 121 then
          tree = 1 + math.floor((talent - 121) / 3)
        end
        if talent >= 145 then
          tree = 9
        end
        return tree
      end

      function TalentPointAllowed(hero, talent)
        local tree = 1 + math.floor((talent - 1) / 12)
        local row = math.floor(1 + ((talent - 1) % 12) / 3)
        local new_talents_begin = 49
        if talent >= new_talents_begin and talent <= 60 then
          --new talents
          tree = 1 + math.floor((talent - new_talents_begin) / 3)
          row = 5
        end
        if talent >= 61 then
          tree = 1 + math.floor((talent - 1) / 15)
          row = math.floor(1 + ((talent - 1) % 15) / 3)
        end
        if talent >= 121 then
          tree = GetTalentTreeByTalentPoint(talent)
          row = 6
        end
        if talent >= 145 then
          tree = GetTalentTreeByTalentPoint(talent)
          row = math.floor(1 + (talent - 145) / 3)
        end
        --print("point allowed check, tree " .. tree .. " row " .. row)
        if TalentPointsSpentInTree(hero, tree) >= (row-1)*3 then
          return true
        end
        return false
      end

--[[
function GetTalentTreeByTalentPoint( talent )
    local tree = 1 + math.floor((talent - 1) / 12)
    local new_talents_begin = 49
    if talent >= new_talents_begin and talent <= 60 then
        tree = 1 + math.floor((talent - new_talents_begin) / 3)
    end
    if talent >= 61 then
        tree = 1 + math.floor((talent - 1) / 15)
    end
    return tree
end

function TalentPointAllowed(hero, talent)
	local tree = 1 + math.floor((talent - 1) / 12)
	local row = math.floor(1 + ((talent - 1) % 12) / 3)
	local new_talents_begin = 49
    if talent >= new_talents_begin and talent <= 60 then
        --new talents
        tree = 1 + math.floor((talent - new_talents_begin) / 3)
        row = 5
    end
    if talent >= 61 then
        tree = 1 + math.floor((talent - 1) / 15)
        row = math.floor(1 + ((talent - 1) % 15) / 3)
    end
    if TalentPointsSpentInTree(hero, tree) >= (row-1)*3 then
        return true
    end
	return false
end]]

function ToggleResetPathPointsPressed(event, args)
  local id = args['player_id']
  local player = PlayerResource:GetPlayer(id)
  local hero = player:GetAssignedHero()
  if hero then
    if hero.reset_path_next_load then
      hero.reset_path_next_load = false
    else
      hero.reset_path_next_load = true
    end
  end
end

function ToggleResetTempleHeroLevel(event, args)
  local id = args['player_id']
  local player = PlayerResource:GetPlayer(id)
  local hero = player:GetAssignedHero()
  if hero then
    if hero.reset_hero_level_on_save then
      hero.reset_hero_level_on_save = false
    else
      hero.reset_hero_level_on_save = true
    end
  end
end

function TalentPressedButton(clicked, args)
	local id = args['player_id']
	local player = PlayerResource:GetPlayer(id)
	local hero = player:GetAssignedHero()
	local nr = args['talent']

	--print("talent pressed "..nr)
	if hero then
		if hero.talentpoints and hero.talentpoints > 0 and hero.talents_clicked and hero.talents_clicked[nr] and hero.talents_clicked[nr] < 3 and TalentPointAllowed(hero, nr) then
			--print("talent pressed success "..nr)
      local distance = (hero:GetAbsOrigin()-Entities:FindByName( nil, "irongrizzly" ):GetAbsOrigin()):Length()
      local threshold = 700
      if true then --distance <= threshold or not clicked then
       hero.talentpoints = hero.talentpoints - 1
       hero.talents_clicked[nr] = hero.talents_clicked[nr] + 1
       CustomGameEventManager:Send_ServerToAllClients("talentleveled", { playerid = id, talent = nr, level = GetPointsInTalent(hero, nr) } )
       CustomGameEventManager:Send_ServerToPlayer(player, "talentpoints", { points = hero.talentpoints } )
       --summon path champion
       --if clicked then
        --    SummonPathChampion(GetTalentTreeByTalentPoint(nr), hero)
        --end
      else
        Notifications:Top(hero:GetPlayerID(), {text="You must go to the Wild Tree in the central northern region in order train your Path.", duration=5, style={color="red"}})
      end
      --todo: recalculate talent stats, no need, done in modifier
      --TalentTreeStatsRecalculation(hero)
    end
  end
end

function SummonPathChampion(monster_type, hero)
  local position = hero:GetAbsOrigin() + Vector(250, 500,0)
  local monster = "irongrizzly"
  local dmg_bonus = 1
  local hp_bonus = 1.3
  if monster_type == 2 then
    monster = "temple_wolf_brown"
    dmg_bonus = 0.8
    hp_bonus = 1
  end
  if monster_type == 3 then
    monster = "temple_dragon_jakiro"
    dmg_bonus = 1.15
    hp_bonus = 1
  end
  if monster_type == 4 then
    monster = "ranger_bloodwolf" --"temple_sand_bloodboar"
    dmg_bonus = 1.5
    hp_bonus = 1
  end
  if monster_type == 5 then
    monster = "temple_shadow_spectre_2"
    dmg_bonus = 1
    hp_bonus = 1.15
  end
  if monster_type == 6 then
    monster = "pve_storm_crow"
    dmg_bonus = 1.75
    hp_bonus = 0.75
  end
  if monster_type == 7 then
    monster = "act13_9"
    dmg_bonus = 1.25
    hp_bonus = 1.25
  end
  local unit = CreateUnitByName(monster, position, true, nil, nil, DOTA_TEAM_BADGUYS )
  if monster_type == 1 or monster_type == 4 or monster_type == 8 then
    unit:AddAbility("pveboss_system")
  end
  unit.chance_for_champion = 100
  unit.noexp = true
  COverthrowGameMode:SetTempleStats(unit,COverthrowGameMode.jungledifficulty*1,200*dmg_bonus,2000*hp_bonus,0,0)
  unit:SetModelScale(1.0)
  if monster_type == 2 then
    unit:SetRenderColor(0, 0, 25)
  end
  if monster_type ~= 1 or monster_type ~= 5 then
    unit:SetModelScale(1.25)
  end
  AttackHero(unit, hero)
end

function AddTalentPoint(hero, talent, playerid)
	local id = playerid
	local player = PlayerResource:GetPlayer(id)
	local nr = talent
	--print("talent pressed "..nr)
	if hero then
		if hero.talentpoints and hero.talentpoints > 0 and hero.talents and hero.talents[nr] and hero.talents[nr] < 3 and TalentPointAllowed(hero, nr) then
			--print("talent pressed success "..nr)
			hero.talentpoints = hero.talentpoints - 1
			hero.talents[nr] = hero.talents[nr] + 1
			CustomGameEventManager:Send_ServerToAllClients("talentleveled", { playerid = id, talent = nr, level = hero.talents[nr] } )
			CustomGameEventManager:Send_ServerToPlayer(player, "talentpoints", { points = hero.talentpoints } )
			--todo: recalculate talent stats, no need, done in modifier
			--TalentTreeStatsRecalculation(hero)
		end
	end
end

function GetPointsInTalent( hero, talent )
  if hero and hero.talents_clicked and hero.talents_clicked[talent] then
    local soul_bonus = GetSoulItemTalent(hero)
    local result = hero.talents_clicked[talent]
    local bonus = 0
    for k=1, 3 do
      if soul_bonus[k][1] == talent then
        bonus = soul_bonus[k][2]
      end
    end
    return result + bonus
  end
  return 0
end

function ItemAddAbilityPoint(event)
	local caster = event.target
	Timers:CreateTimer(1,function()
		local points = caster:GetModifierStackCount("modifier_mythic_abilitypoint", nil)
		if not caster.abilitypointfromitem then
			caster.abilitypointfromitem = points
			caster:SetAbilityPoints(caster:GetAbilityPoints()+points)
    elseif caster.abilitypointfromitem and caster.abilitypointfromitem < points then
      caster:SetAbilityPoints(caster:GetAbilityPoints()+points-caster.abilitypointfromitem)
      caster.abilitypointfromitem = points
    end
  end)
end

function ItemAddTalentPoint(event)
	local caster = event.target
	Timers:CreateTimer(0.03,function() --takes a frame to set stackcount
		local points = caster:GetModifierStackCount("modifier_mythic_pathpoints", nil)
		if not caster.talentpointsfromitem then
			caster.talentpointsfromitem = points
			AddTalentPoint(caster, points)
    elseif caster.talentpointsfromitem and caster.talentpointsfromitem < points then
     AddTalentPoint(caster, points-caster.talentpointsfromitem)
     caster.talentpointsfromitem = points
   end
 end)
end

function AddTalentPoint(hero, amount)
	local id = hero:GetPlayerID()
	local player = PlayerResource:GetPlayer(id)
	print("talent addd point "..amount)
	if hero then
		print("talent addd point 2 "..amount)
		if hero.talentpoints and amount > 0 then
			print("talent addd point 3 "..amount)
			hero.talentpoints = hero.talentpoints + amount
			CustomGameEventManager:Send_ServerToPlayer(player, "talentpoints", { points = hero.talentpoints } )
			if not hero.pathnotificationcd then
				hero.pathnotificationcd = true
				Notifications:Bottom(id, {text="You gained 1 Path Point.", duration=10, style={color="white"}})
				Timers:CreateTimer(5,function() 
					hero.pathnotificationcd = false
        end)
			end
		end
	end
end

function SendAllTalentsToPlayer(player, id)
  local hero = player:GetAssignedHero()
  if hero and hero.talents then
    for i=1, COverthrowGameMode.maxtalents do
      if hero.talents[i] and hero.talents[i] > 0 then
        CustomGameEventManager:Send_ServerToPlayer(player, "talentleveled", { playerid = id, talent = i, level = hero.talents[i] } )
      end
    end
  end
end

function TogglePathWord(event, args)
  local id = args['player_id']
  local player = PlayerResource:GetPlayer(id)
  local hero = player:GetAssignedHero()
  if hero then
    if hero.disablePathWordBonuses then
      hero.disablePathWordBonuses = false
    else
      hero.disablePathWordBonuses = true
    end
  end
end

function RefreshTalents(event, args)
  --local id = args['player_id']
  --local player = PlayerResource:GetPlayer(id)
  local all = HeroList:GetAllHeroes()
  if all and all[1] then
    Timers:CreateTimer(0.05,function()
      SendTalentTreesToAll(all[1], 2)
    end)
  end
  if all and all[2] then
    Timers:CreateTimer(1.0,function()
      SendTalentTreesToAll(all[2], 2)
    end)
  end
  if all and all[3] then
    Timers:CreateTimer(2.0,function()
      SendTalentTreesToAll(all[3], 2)
    end)
  end
  if all and all[4] then
    Timers:CreateTimer(3.0,function()
      SendTalentTreesToAll(all[4], 2)
    end)
  end
  if all and all[5] then
    Timers:CreateTimer(4.0,function()
      SendTalentTreesToAll(all[5], 2)
    end)
  end
    --[[for i=1, #all do
        hero = all[i]
        if hero then
            local h = hero
            --Timers:CreateTimer(i*0.2,function()
            SendTalentTreesToAll(all[1], i*2)
            --end)
        end
      end]]
    end

    function SendTalentTreesToAll(hero, delay)
      local id = hero:GetPlayerID()
      --local player = PlayerResource:GetPlayer(id)
      --local hero = player:GetAssignedHero()
      if hero and hero.talents then
        SendTalentTreesToAllRecursive(hero, 0.05, 1)
        --[[
        --Timers:CreateTimer(delay,function()
        local index = 1
        for index=1, COverthrowGameMode.maxtalents do
            if hero.talents[index] then
                CustomGameEventManager:Send_ServerToAllClients("talentleveled", { playerid = id, talent = index, level = hero.talents[index] } )
            end
          end]]
          --end)
        end
      end

      function SendTalentTreesToAllRecursive(hero, delay, index)
        local id = hero:GetPlayerID()
        Timers:CreateTimer(delay,function()
          if hero and hero.talents then
            if hero.talents[index] and hero.talents[index] > 0 then
              CustomGameEventManager:Send_ServerToAllClients("talentleveled", { playerid = id, talent = index, level = hero.talents[index] } )
            end
            index = index + 1
            if index <= COverthrowGameMode.maxtalents then
              SendTalentTreesToAllRecursive(hero, delay, index)
            end
          end
        end)
      end

      function SendAutoSell(player)
        if player then
          local hero = player:GetAssignedHero()
          if(hero) then
            CustomGameEventManager:Send_ServerToPlayer(player, "getautosellresponse", { autosell = hero.autosell, autosellArti = hero.autosellArti, autosellSouls = hero.autosellSouls })
          end
        end
      end

      function SetAutoSell(event, args)
        local id = args['player_id']
        local index = args['index']
        local indexArti = args['indexArti']
        local indexSouls = args['indexSouls']
        local player = PlayerResource:GetPlayer(id)

        if player then
          local hero = player:GetAssignedHero()
          if hero then
            if(index ~= nil) then
              hero.autosell = index
            end
            if(indexArti ~= nil) then
              hero.autosellArti = indexArti
            end
            if(indexSouls ~= nil) then
              hero.autosellSouls = indexSouls
            end
          end
        end
      end

      function SellMythicWeapon(event, args)
        local id = args['player_id']
        local index = args['index']
        local player = PlayerResource:GetPlayer(id)
        local normalItemSellValue = args['sellValue']
        if player then
          -- sell last dropped, move other to interface
          local hero = player:GetAssignedHero()
          --print(hero:GetName())
          if hero and index and hero.item_sell_list and hero.item_sell_list[index] and hero.item_sell_list[index][1] then
            --artifact item
            local artifact_item = hero.item_sell_list[index]
            local quality = artifact_item[3]
            if quality then
              local gold = 1
              if quality == "epic" then
                gold = 2
              end
              if quality == "leg" then
                gold = 5
              end
              if quality == "im" then
                gold = 25
              end
              if quality == "aim" then
                gold = 50
              end
              if quality == "divi" then
                gold = 100
              end
              if quality == "myth" then
                gold = 500
              end
              EmitSoundOn("DOTA_Item.Hand_Of_Midas", hero)
              local particle = ParticleManager:CreateParticle( "particles/econ/items/alchemist/alchemist_midas_knuckles/alch_knuckles_lasthit_coins.vpcf", PATTACH_CUSTOMORIGIN, hero)
              ParticleManager:SetParticleControl(particle, 1, hero:GetAbsOrigin())
              ParticleManager:ReleaseParticleIndex(particle)
              --hero:SetGold(hero:GetGold()+gold, true)
              --hero:SetGold(0, false)
              AddGold(hero, gold)
            end
            -- delete drop
            artifact_item[1] = nil
            hero.item_sell_list[index] = nil
          end

          if hero and index and hero.item_sell_list and hero.item_sell_list[index] and not hero.item_sell_list[index][1] then
            --normal item
            local item = hero.item_sell_list[index]
            if not item then
              return
            end
            if item:IsNull() then
              return
            end
            local gold = normalItemSellValue --item:GetCost() / 200
            --print(gold)
            if gold < 1.0 then
              gold = 1
              --local chance = gold * 10000
              --if chance >= math.random(1,10000) then
                --    gold = 1
                --else
                --    gold = 0
                --end
                --gold = 1 -- minimum gold per sell? no
              end
              EmitSoundOn("DOTA_Item.Hand_Of_Midas", hero)
              if item:GetContainer() then
                local particle = ParticleManager:CreateParticle( "particles/econ/items/alchemist/alchemist_midas_knuckles/alch_knuckles_lasthit_coins.vpcf", PATTACH_CUSTOMORIGIN, hero)
                ParticleManager:SetParticleControl(particle, 1, item:GetContainer():GetAbsOrigin())
                ParticleManager:ReleaseParticleIndex(particle)
              else
                local particle = ParticleManager:CreateParticle( "particles/econ/items/alchemist/alchemist_midas_knuckles/alch_knuckles_lasthit_coins.vpcf", PATTACH_CUSTOMORIGIN, hero)
                ParticleManager:SetParticleControl(particle, 1, hero:GetAbsOrigin())
                ParticleManager:ReleaseParticleIndex(particle)
              end
              if item:GetContainer() then
                UTIL_Remove( item:GetContainer() )
              else
                UTIL_Remove( item )
              end
              EmitSoundOn("DOTA_Item.Hand_Of_Midas", hero)
              local particle = ParticleManager:CreateParticle( "particles/econ/items/alchemist/alchemist_midas_knuckles/alch_knuckles_lasthit_coins.vpcf", PATTACH_CUSTOMORIGIN, hero)
              ParticleManager:SetParticleControl(particle, 1, hero:GetAbsOrigin())
              ParticleManager:ReleaseParticleIndex(particle)
              --hero:SetGold(hero:GetGold()+gold, true)
              --hero:SetGold(0, false)
              AddGold(hero, gold)
              hero.item_sell_list[index] = nil
            end
          end
        end

        function RecoverLastReplacedArtifact(event, args)
          args.recover = true
          EquipDroppedMythicWeapon(event, args)
        end

        function EquipDroppedMythicWeapon(event, args)
         local id = args['player_id']
         local index = args['index']
         local player = PlayerResource:GetPlayer(id)
         if player then
          local hero = player:GetAssignedHero()
          if hero then
            --equip a new weapon or replace with last saved
            local slot
            local weapondrop = {}
            if not args.recover and index and hero.item_sell_list and hero.item_sell_list[index] then
              weapondrop = hero.item_sell_list[index]
              slot = weapondrop[2]
            else
              slot = args.slot
            end
            if not hero.last_replaced_artifact then
              hero.last_replaced_artifact = {}
            end
            --DeepPrintTable(hero.last_replaced_artifact[slot])
            if slot then
              if not args.recover then
                --copy saved item data over to hero inventory
                hero.last_replaced_artifact[slot] = {}
                for i=0,14 do
                  if hero.inventory and hero.inventory[slot] and hero.inventory[slot][i] then
                    hero.last_replaced_artifact[slot][i] = hero.inventory[slot][i]
                  end
                  hero.inventory[slot][i] = weapondrop[i]
                end
              else
                --swap with the one equipped before
                weapondrop = {}
                local current_artifact = {}
                for i=0,14 do
                  if hero and hero.last_replaced_artifact and hero.last_replaced_artifact[slot] and hero.last_replaced_artifact[slot][i] and hero.inventory and hero.inventory[slot] and hero.inventory[slot][i] then
                    current_artifact[i] = hero.inventory[slot][i]
                    hero.inventory[slot][i] = hero.last_replaced_artifact[slot][i]
                    weapondrop[i] = hero.last_replaced_artifact[slot][i]
                  end
                end
                hero.last_replaced_artifact[slot] = current_artifact
              end
            end
            local particle = ParticleManager:CreateParticle( "particles/econ/items/dazzle/dazzle_ti6/dazzle_ti6_shallow_grave_ground_ray.vpcf", PATTACH_POINT_FOLLOW, hero )
            ParticleManager:ReleaseParticleIndex(particle)
            EmitSoundOn("DOTA_Item.DustOfAppearance.Activate", hero)
            
            --update all players with newly equipped item
            CustomGameEventManager:Send_ServerToAllClients("templeweaponequip", { item = weapondrop[1], itemname = weapondrop[0], attributes = weapondrop[4], stat1 = weapondrop[5], stat1name = weapondrop[8], stat2 = weapondrop[6], stat2name = weapondrop[9], stat3 = weapondrop[7], stat3name = weapondrop[10], ilevel = weapondrop[11], slot = weapondrop[2], rarity = weapondrop[3], playerid = hero:GetPlayerID(), weapontype = weapondrop[14] } )
            --update attributes for hero (buffs!)
            COverthrowGameMode:UpdateMythicWeaponStats(hero)
            -- delete drop
            if weapondrop and weapondrop[1] then
              weapondrop[1] = nil
            end
            if hero.item_sell_list and hero.item_sell_list[index] then
              hero.item_sell_list[index] = nil
            end
          end
        end
      end

      function LoadCharReply(event, args)
       COverthrowGameMode:LoadCharReply(event, args)
     end

     function COverthrowGameMode:LoadCharReply(event, args)  --loaded end of season rewards from server arrive here
     --print("feed reward received, from js to lua")
     --print("event arrived " .. args['name'])
     --print("event arrived " .. args['rating'])
     --print(args.Body)
     --DeepPrintTable(args)
     --print("load char 2")
     local temple_version = 1
     if COverthrowGameMode.junglemodepremium then
      temple_version = 2
    end

    if not IsServer() then
      --return ?
    end
    --print("loaded reply")
    local rawdata = args.Body --args['data']
    --print(rawdata)
    local i = 0
    local data = {}
    for word in string.gmatch(rawdata, '([^,]+)') do
     --print(word)
     --print("data[i] " .. i .. " " .. word)
     data[i] = word
     i = i + 1
   end

--[[0 = id
1-6 = items
7 = xp
8-10 = backpack
11-13 = personal stash tab 1
14 = bosskills
15-58 = mythics
59-70 = personal stash tab 2-5
71-73 = shared stash tab 1
74 = premium
75 = gold
76-87 = shared stash tab 2-5
88-92 = temple abilities
93 = pathpoints]]
local all = HeroList:GetAllHeroes()
local hero
for i=1, #all do
  hero = all[i]
  local heroname = hero:GetName()
  heroname = string.sub(heroname, 15)
  if hero then
    hero.hero_load_reply_received = true
    local playerid = hero:GetPlayerID()
    local player = PlayerResource:GetPlayer(hero:GetPlayerID())
    local steamid = PlayerResource:GetSteamAccountID(playerid)
    for j=0, #data-2 do
      --print("j value " .. j)
      --print(data[j])
      if data[j] and steamid > 0 then
        local id = tonumber(data[j])
        --print("id vs steamid bots " .. id .. " " .. steamid)
        if id and steamid == id and not hero.auto_loaded then
          
          local goldindex = j+75
          local bankindex = j+74
          print("bank " .. bankindex)
          local temple_abil_index = j + 87
          --this is the hero we loaded data for
          hero.auto_loaded = true
          --enable save feature
          if hero and hero.ArenaControl then
            local ability = hero.ArenaControl:AddAbility("savechar"):SetLevel(1)
            ability = hero.ArenaControl:AddAbility("movetostash"):SetLevel(1)
            hero.ArenaControl:FindAbilityByName("startarena"):SetLevel(0)
            hero.ArenaControl:AddAbility("temple_teleport"):SetLevel(1)
          end
          --stop loading in challenge mode
          if GetMapName() == "tod_challenge_mode" then
           for x = 1, self.mythic_slots do
            hero.inventory[x][1] = "no"
            for y = 1, 3 do
             hero.inventory[x][y+4] = 0
           end
         end
         return
       end

       for k=0, 5 do
         local item = hero:GetItemInSlot(k)
         if item then
          --print(item:GetName())
          hero:RemoveItem(item)
        end
      end
      --inventory
      for k=1, 6 do
       if data[j+k] and data[j+k] ~= "no" then
        --print(data[j+k])
        hero:AddItemByName("item_"..data[j+k])
      end
    end
    local xp = data[j+7]
    --print("load char success, xp = " .. xp)
    if xp then
     xp = tonumber(xp)
     if xp and xp > 2150000000 then
      xp = 2150000000
    end
    if xp and xp < 0 then
      xp = 2150000000
    end
    hero.dont_add_temple_class_ability = true
    --xp = COverthrowGameMode.levelTable[100] --test xp
    hero:AddExperience(xp,false, true)
    AddHeroExperience(hero, xp)
    hero.dont_add_temple_class_ability = nil
    local particle = ParticleManager:CreateParticle( "particles/econ/items/alchemist/alchemist_midas_knuckles/alch_knuckles_lasthit_coins.vpcf", PATTACH_POINT_FOLLOW, hero.ArenaControl )
    ParticleManager:SetParticleControl(particle, 1, hero.ArenaControl:GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(particle)
    particle = ParticleManager:CreateParticle( "particles/econ/items/alchemist/alchemist_midas_knuckles/alch_knuckles_lasthit_coins.vpcf", PATTACH_POINT_FOLLOW, hero )
    ParticleManager:SetParticleControl(particle, 1, hero:GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(particle)
    EmitSoundOn("DOTA_Item.Hand_Of_Midas", hero)
  end
  --boss kill save
  local bosskills = data[j+14]
  if tonumber(bosskills) then
   hero.loadedbosskills = tonumber(bosskills)
 else
   hero.loadedbosskills = 0
 end

 -- new mythic, 8 slots after kills
 for x = 1, self.mythic_slots do
   hero.inventory[x][1] = data[j+15+4*(x-1)]
   --print(hero.inventory[x][1])
   --print(hero.inventory[x][1])
   for y = 1, 3 do
    if data[j+15+4*(x-1)+y] then
     hero.inventory[x][y+4] = tonumber(data[j+15+4*(x-1)+y])
   else
     hero.inventory[x][y+4] = 0
   end
   --print(hero.inventory[x][y+4])
 end
 if hero.inventory[x][1] and hero.inventory[x][1] ~= "no" then
  --Reconstruct item from minimal server data
  COverthrowGameMode:CreateMythicWeapon( hero, hero.inventory[x][1], true, hero.inventory[x][5], hero.inventory[x][6], hero.inventory[x][7], true )
end
end

--print("boss kill record loaded: "..hero.loadedbosskills)
--gold
if data[goldindex] then
 local gold = tonumber(data[goldindex])
 --hero:SetGold(gold, true)
 --hero:SetGold(0, false)
 SetGold(hero, gold)
end

--temple class abilities
local temple_abil = 1
for temple_abil = 1, 5 do
  print("neutral check")
  --now this is the new neutral item
  if hero and data[goldindex+temple_abil] then --hero.temple_class
    local ability_name = data[temple_abil_index+temple_abil]
    print("neutral check 2")
    if ability_name and ability_name ~= "no" and ability_name ~= "empty_spell1" and ability_name ~= "empty_spell2" and ability_name ~= "empty_spell3" and ability_name ~= "empty_spell4" and ability_name ~= "empty_spell5" then
      print("neutral check 3 " .. ability_name)
      --print("learn")
      --print(ability_name)
      --print(hero.templeclassabilities)
      --AddTempleClassAbility( hero, ability_name, false )
      if temple_abil == 1 then
        --print("neutral check 4 " .. ability_name)
        local neutralItem = hero:AddItemByName( "item_" .. ability_name )
        neutralItem.heroOwner = hero
      end
      if temple_abil == 2 then
        LearnMasteryAbility(hero, ability_name)
      end
    end
  end
end

--print("gold ")
--print(data[goldindex])
--print("premium ")
--print(data[bankindex])
--does he have premium bank slots?
local bank_slots = 6 --new, free backpack
hero.bought_stash_count = 0
print("stash check")
if data[bankindex] then
 bank_slots = tonumber(data[bankindex])
 print("stash check 2 " .. bank_slots)
 if bank_slots >= 6 then
  --bank_slots = 9
  hero.premium = bank_slots
  hero.bought_stash_count = math.floor(bank_slots / 6)
  hero.current_stash_id = 1
  COverthrowGameMode:SendStashInfo(player)
  print("stash check 3 " .. hero.bought_stash_count)
else
  bank_slots = 6
end
end
--print(bank_slots)
if temple_version == 2 and bank_slots > 0 then
 --local sharedindex = j+59
 --filler to fill normal inventory
 local count = 6-GetNumItemsHeroHas(hero)
 local filler = {}
 for m=1, count do
  filler[m] = hero:AddItemByName( "item_dmg1" )
end

--print("backpack")
for n=j+8, j+10 do
  --print(data[n])
  --print("bank items")
  if data[n] and data[n] ~= "no" then
   --print(data[n])
   local newitem = hero:AddItemByName("item_"..data[n])
 end
end
--print("personal stash")
if bank_slots >= 6 then
  for n=j+11, j+13 do
    --print(data[n])
    --print("bank items")
    if data[n] and data[n] ~= "no" then
      --print(data[n])
      local newitem = hero:AddItemByName("item_"..data[n])
    end
  end
  --new toggle stashes, personal
  local stashStartPersonal = 59
  for n=j+stashStartPersonal, j+stashStartPersonal+11 do
    if data[n] and data[n] ~= "no" then
      local stash_index = math.floor(1 + (n-stashStartPersonal) / 3) + 1
      local stash_slot = ((n-stashStartPersonal) % 3) + 1
      local newitem = "item_" .. data[n]
      print("save perso item " .. newitem .. " into stashid " .. stash_index .. " slot " .. stash_slot)
      SaveItemIntoStashTable( hero, stash_index, stash_slot, newitem, false )
    end
  end
  --new toggle stashes, shared
  local sharedStart = 76
  for n=j+sharedStart, j+sharedStart+11 do
    if data[n] and data[n] ~= "no" then
      local stash_index = math.floor(1 + (n-sharedStart) / 3) + 1
      local stash_slot = ((n-sharedStart) % 3) + 4
      local newitem = "item_" .. data[n]
      print("save shared item " .. newitem .. " into stashid " .. stash_index .. " slot " .. stash_slot)
      SaveItemIntoStashTable( hero, stash_index, stash_slot, newitem, true )
    end
  end
end
--fill before shared slots
--are we premium?
if hero.bought_stash_count > 0 then
  local count2 = 6 - GetNumItemsStashAndBackpack(hero)
  local filler2 = {}
  for m2=1, count2 do
    filler2[m2] = hero:AddItemByName( "item_dmg2" )
  end

  --print("shared stash")
  local sharedTab1 = 71
  for n=j+sharedTab1, j+sharedTab1+2 do
   if data[n] and data[n] ~= "no" then
    --print(data[n])
    local newitem = hero:AddItemByName("item_"..data[n])
    --print("shared item loaded " .. newitem:GetName())
    if newitem then
      newitem.droppedthisgame = true
    end
    newitem.droppedthisgame = true --to test for bugs
    --print(GetSlotItemIsIn(hero, newitem))
  end
end

--remove filler
for m2=1, count2 do
  UTIL_Remove( filler2[m2] )
end
end
--remove filler
for m=1, count do
  UTIL_Remove( filler[m] )
end

--new stash toggle feature, after loading all items, make sure we save ? nah
--SaveCurrentStashItemsToStashTable(hero, 1)
                        --[[
                        SaveCurrentStashItemsToStashTable(hero, 1)
                        local stash_2_index = sharedindex + 6 --?
                        local s2_index = 1
                        for s2=stash_2_index, stash_2_index + 6 do
                            if data[s2] and data[s2] ~= "no" then
                                if s2_index <= 3 then
                                    SaveItemIntoStashTable( hero, 2, s2_index, data[s2], false )
                                else
                                     SaveItemIntoStashTable( hero, 2, s2_index, data[s2], true )
                                end
                            end
                            s2_index = s2_index + 1
                          end]]

                          Timers:CreateTimer(0.25,function() --wait a moment for path talent rings to update
                            --if true then
                              local pathpoints = data[81+12]  --with 7 artifact slots 49+4
                              if pathpoints and pathpoints ~= "no" then
                                local myevent = {player_id = playerid }
                                --print("path point len")
                                --print(string.len(pathpoints))
                                for p=1, string.len(pathpoints) do
                                  local points = tonumber(string.sub(pathpoints, p, p))
                                  --print("points")
                                  --print(points)
                                  if points then
                                    myevent.talent = p
                                    for amount=1, points do
                                      --print("add talent "..amount)

                                      --AddTalentPoint(hero, p, playerid)
                                      TalentPressedButton(false, myevent)
                                      --local id = args['player_id']
                                      --local player = PlayerResource:GetPlayer(id)
                                      --local hero = player:GetAssignedHero()
                                      --local nr = args['talent']
                                    end
                                  end
                                end
                              end
                              --end
                            end)
                        end
                      end
                    end
                  end
                end
              end
            end

            function COverthrowGameMode:GetNumberItemsInInventory(hero)
              return GetNumberItemsInInventory(hero)
            end

            function COverthrowGameMode:GetNumberItemsInBackpack(hero)
              return GetNumberItemsInBackpack(hero)
            end

            function COverthrowGameMode:GetNumberItemsInStash(hero)
              return GetNumberItemsInStash(hero)
            end

            function GetSlotItemIsIn(hero, item_handle)
             local slot = -1
             for index=0,14 do
              local item2 = hero:GetItemInSlot(index)
              if item2 and item2 == item_handle then
               slot = index
             end
           end
           return slot
         end

         function GetNumberItemsInInventory(hero)
          local amount = 0
          for index=0,5 do
            local item = hero:GetItemInSlot(index)
            if item then
              amount = amount + 1
            end
          end
          return amount
        end

        function GetNumberItemsInStash(hero)
          local amount = 0
          for index=9,14 do
            local item = hero:GetItemInSlot(index)
            if item then
              amount = amount + 1
            end
          end
          return amount
        end

        function GetNumberItemsInBackpack(hero)
          local amount = 0
          for index=6,8 do
            local item = hero:GetItemInSlot(index)
            if item then
              amount = amount + 1
            end
          end
          return amount
        end

        function GetNumItemsStashAndBackpack(hero)
         local amount = 0
         for index=6,14 do
          local item = hero:GetItemInSlot(index)
          if item then
           amount = amount + 1
         end
       end
       return amount
     end

     function GetNumItemsHeroHas(hero)
       local amount = 0
       for index=0,5 do
        local item = hero:GetItemInSlot(index)
        if item then
         amount = amount + 1
       end
     end
     return amount
   end

   function COverthrowGameMode:SpawnStormCrowPatrols()
    if not self.stormcrowpatrolsspawned then
      self.stormcrowpatrolsspawned = true
    else
      return
    end
    --patrol
    for i=1, 3 do
      local unit = CreateUnitByName("pve_storm_crow", Vector(0,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
      unit.chance_for_champion = 100
      unit.loot_goblin_artifact_factor = 4
      unit.noStuckProtection = true
      if i == 1 then
        unit:AddAbility("pve_summonmovingcyclone_dark"):SetLevel(1)
        unit:AddAbility("pve_trap_arrows"):SetLevel(1)
        unit:AddAbility("icehowl_10"):SetLevel(1)
        unit.patrolling = 15
        self:SetTempleStats(unit,COverthrowGameMode.jungledifficulty * 1,100,4000,20,0)
      elseif i == 2 then
        unit:AddAbility("pve_temple_affix_shadowcloud"):SetLevel(1)
        unit:AddAbility("pve_affix_frenzy"):SetLevel(1)
        unit:AddAbility("pve_healnegate"):SetLevel(1)
        unit.patrolling = 16
        self:SetTempleStats(unit,COverthrowGameMode.jungledifficulty * 1.25,300,1000,20,0)
      else
        unit:AddAbility("pve_chainlightning"):SetLevel(1)
        unit:AddAbility("icehowl_8"):SetLevel(1)
        unit:AddAbility("pve_thunder_shield"):SetLevel(1)
        unit.patrolling = 17
        self:SetTempleStats(unit,COverthrowGameMode.jungledifficulty * 1.5,200,3000,20,0)
      end
    end
  end

  function COverthrowGameMode:SpawnTreasureChests()
    --debug
    local spotcount = 31
    if false then
      local counter = 1
      for counter = 1, spotcount do
        local name = "chest_"..counter
        if counter >= 11 then
          name = "chest"..counter
        end
        local unit = Entities:FindByName( nil, name )
        if unit then
          --print(counter)
          --print(unit:GetName())
        end
      end
    end
    --lucky chest
    if not self.treasurechestsspawned then
      Notifications:TopToAll({text="Nabu: We just got a report from Cain, saying that Treasure Goblins have been sighted!", duration=8, style={color="lightblue"}})
      self.treasurechestsspawned = true
      local chest_count = 1
      local already_spawned = {}
      local max = 6
      for chest_count = 1, max do
        local index = math.random(1,spotcount)
        if not already_spawned[index] then
          --print("spawned chest")
          already_spawned[index] = true
          local name = "chest_"..index
          if index >= 11 then
            name = "chest"..index
          end
          local luckychest = Entities:FindByName( nil, name ):GetAbsOrigin()
          self:SpawnTreasureChest(luckychest, 100)
        else
          max = max + 1
        end
      end
    end
  end

  function COverthrowGameMode:SpawnTreasureChest(pos, health_percent)
    local chest_types = 3
    local roll = math.random(1,chest_types)
    local unit
    if roll == 1 then
      --runs straight, harder, better artifact chance
      unit = CreateUnitByName("temple_chest", pos, true, nil, nil, DOTA_TEAM_BADGUYS )
      unit.loot_goblin_flee_mode_straight = true
    end
    if roll == 2 then
      --random movement, but faster 20%
      unit = CreateUnitByName("temple_chest_2", pos, true, nil, nil, DOTA_TEAM_BADGUYS )
      unit.loot_goblin_flee_mode_changing = true
      unit.loot_goblin_artifact_factor = 5
    end
    if roll == 3 then
      --runs straight, harder, 10% faster, gold drop
      unit = CreateUnitByName("temple_chest_3", pos, true, nil, nil, DOTA_TEAM_BADGUYS )
      unit.loot_goblin_flee_mode_straight = true
      unit.loot_goblin_gold_drop = true
    end
    unit:AddAbility("pve_loot_goblin"):SetLevel(1)
    unit.no_will_of_survival = 1
    self:SetTempleStats(unit,self.jungledifficulty*1.5,0,1500,100,0) --1000hp 5.8
    unit.nobosskill = true
    unit.drop_chance_factor = 10
    if health_percent < 100 then
      unit:SetHealth(unit:GetMaxHealth()*health_percent/100)
      EmitSoundOn("DOTA_Item.Hand_Of_Midas", unit)
      local particle = ParticleManager:CreateParticle( "particles/econ/items/alchemist/alchemist_midas_knuckles/alch_knuckles_lasthit_coins.vpcf", PATTACH_CUSTOMORIGIN, unit)
      ParticleManager:SetParticleControl(particle, 1, unit:GetAbsOrigin())
      ParticleManager:ReleaseParticleIndex(particle)
    end
  end

  function GetScalingByAct(act)
    if GetDifficultyModeActScalingDynamic() then
      if act >= 11 then
        act = 11
      end
      return COverthrowGameMode.jungledifficulty * (1 + 0.1 * (act-1))
    else
      return COverthrowGameMode.jungledifficulty * (1 + 0.1 * (13-1))
    end
  end

  function GetBossVariation()
    if COverthrowGameMode.jungledifficulty == 1 or COverthrowGameMode.jungledifficulty == 2 or COverthrowGameMode.jungledifficulty == 10 or COverthrowGameMode.jungledifficulty == 2 or COverthrowGameMode.jungledifficulty == 50
     or COverthrowGameMode.jungledifficulty == 200 or COverthrowGameMode.jungledifficulty == 1000 then
      --return 2
    end
    return 1
  end

  function COverthrowGameMode:PopulateTemple(zone)
    self.current_act_populated = zone
    self.act_affix_roll = math.random(1,#self.act_affixes)
    --self.act_affix_roll = 12
    local horde_factor = 1
    if self.act_affix_roll == 12 and self.jungledifficulty > 50 then
      --horde act affix
      horde_factor = math.random(2,3)
    end
    local scale = GetScalingByAct(zone)

    if zone == 1 then
      local randomActAbilities = {"pve_affix_jumpstomp_2", "pve_temple_bloodpool", "pve_wolf_rage"}
      --scale = 1.0
      local c1 = Entities:FindByName( nil, "camp1" ):GetAbsOrigin()
      local c2 = Entities:FindByName( nil, "camp2" ):GetAbsOrigin()+Vector(200,-200,0)
      local c3 = Entities:FindByName( nil, "camp3" ):GetAbsOrigin()
      local c4 = Entities:FindByName( nil, "camp4" ):GetAbsOrigin()
      local c5 = Entities:FindByName( nil, "camp5_1" ):GetAbsOrigin()
      local c6 = Entities:FindByName( nil, "camp5" ):GetAbsOrigin()
      local c2new = Entities:FindByName( nil, "camp2new" ):GetAbsOrigin()
      local c3new = Entities:FindByName( nil, "camp3new" ):GetAbsOrigin()
      local b1 = Entities:FindByName( nil, "boss1" ):GetAbsOrigin()
      local b2 = Entities:FindByName( nil, "boss2" ):GetAbsOrigin()
      local b3 = Entities:FindByName( nil, "boss3" ):GetAbsOrigin()
      local quest_pos = Entities:FindByName( nil, "camp12" ):GetAbsOrigin()

      local unit
      local affixinact1 = 1
      local act_1_dmg_factor = 1
      if COverthrowGameMode.jungledifficulty <= 1.0 then
       affixinact1 = 0
       act_1_dmg_factor = 0.6
     end

     --camp 1
     unit = CreateUnitByName("temple_wolf_rage", c1+Vector(-500,150,0), true, nil, nil, DOTA_TEAM_BADGUYS )
     unit.chance_for_champion = 10
     --SetSwarmOnDeath(unit, 1, 1, Vector(-900,-1600,0), zone, "temple_wolf_rage", nil, true)
     unit:SetRenderColor(255, 255, 255)
     self:SetTempleStats(unit,scale,75*act_1_dmg_factor,750,20,2*affixinact1)
     unit:SetForwardVector(Vector(1, -0.75, 0))

     --unit:AddAbility("pve_temple_random_aoe_dmg_rosh"):SetLevel(1)
     --unit:AddAbility("pve_rotting"):SetLevel(1)
     --unit:AddAbility("pve_affix_walking_laser_trap"):SetLevel(1)
     --unit:AddAbility("pve_affix_fireball_aoe"):SetLevel(1)

     --unit:AddAbility(act_affix):SetLevel(1)
     --unit:AddAbility("pve_temple_affix_taunt"):SetLevel(1)
     --unit:AddAbility("pve_temple_aggro_ranged"):SetLevel(1)
     --unit:AddAbility("pve_temple_rockthrow"):SetLevel(1)
     
     
     --unit:AddAbility("pve_affix_spinning_laser_trap"):SetLevel(1)
     --unit:AddAbility("pve_affix_walking_laser_trap"):SetLevel(1)
     --unit:AddAbility("pve_wave_caller_10"):SetLevel(1)


     --unit:AddAbility("pve_temple_affix_glaivemaster"):SetLevel(1)
     --unit:AddAbility("pve_chainlightning"):SetLevel(1)
     --unit:AddAbility("pve_affix_chicken_at_each"):SetLevel(1)
     --unit:AddAbility("pve_affix_artillery"):SetLevel(1)
     --unit:AddAbility("pve_rollermaw"):SetLevel(1)
     
     --unit:AddAbility("pve_wave_caller_3"):SetLevel(1)
     --unit:AddAbility("pve_temple_affix_armor_melt"):SetLevel(1)
     --unit:AddAbility("icehowl_6"):SetLevel(1)
     --unit:AddAbility("pve_temple_aoe_dmg_range_sandstorm_knockback"):SetLevel(1)
     --unit:AddAbility("pve_affix_fanatic_rage"):SetLevel(1)
     --unit:AddAbility("pve_temple_affix_taunt"):SetLevel(1)

     --test wolf
     unit.loot_goblin_artifact_factor = 1000

     
     local killing_wolf = unit


     --story son
     if scale <= 1 then
      unit = CreateUnitByName("act_1_son", c1+Vector(1250,-150,0), true, nil, nil, DOTA_TEAM_GOODGUYS )
      unit:SetForwardVector(Vector(-1, 0, 0))
      CinematicKill(unit, killing_wolf, killing_wolf:FindAbilityByName("pveboss_system"), 16, 12, true)
      Timers:CreateTimer(4,function()
        Notifications:BottomToAll({text="Villager Cain: There's my daughter! She's back!", duration=10, style={color="white"}})
      end)
      Timers:CreateTimer(18,function()
        EmitGlobalSound("beastmaster_beas_death_01")
        Notifications:BottomToAll({text="Villager Cain: Noooooooo! My daughter got killed by a wolf.", duration=10, style={color="white"}})
      end)
      Timers:CreateTimer(28,function()
        Notifications:BottomToAll({text="Villager Cain: Please search the Wild Forest for my other daughter. There's still hope to find her alive!", duration=10, style={color="white"}})
      end)
    end
    
    
    --unit:AddAbility("pve_temple_rockthrow_curve"):SetLevel(1)
    

    --unit:AddAbility("pve_temple_bloodritual"):SetLevel(1)

    for i=1, horde_factor do

      -- new camp 2
      unit = CreateUnitByName("temple_wolf_rage", c2new, true, nil, nil, DOTA_TEAM_BADGUYS )
      --unit:AddAbility("pve_temple_affix_iron"):SetLevel(1)
      --unit:AddAbility("pve_temple_axes2"):SetLevel(1)
      --unit:AddAbility("pve_temple_iceberg_linear2"):SetLevel(1)
      --unit:AddAbility("pve_temple_vipershot"):SetLevel(1)
      --unit:AddAbility("pve_temple_tower"):SetLevel(1)
      --unit:AddAbility("pve_temple_ogrebrutes"):SetLevel(1)
      --unit:AddAbility("pve_temple_iceberg_linear2"):SetLevel(1)
      --unit:AddAbility("pve_temple_iceberg_linear2"):SetLevel(1)
      
      --unit.chance_for_champion = 10
      if COverthrowGameMode.jungledifficulty > 1 then --no hard scenario on ML 1
        SetSwarmOnDeath(unit, 3, 3, Vector(1000,750,0), zone, "temple_wolf_rage", nil, true)
      end
      unit:AddAbility(randomActAbilities[math.random(1, #randomActAbilities)]):SetLevel(1) --pve_affix_shadow_claw
      unit:SetRenderColor(255, 255, 255)
      self:SetTempleStats(unit,scale,50*act_1_dmg_factor,750,20,2*affixinact1)
      unit:SetForwardVector(Vector(0,1,0))
      unit = CreateUnitByName("temple_wolf_rage", c2new+Vector(-250,100,0), true, nil, nil, DOTA_TEAM_BADGUYS )
      --unit:AddAbility("pve_act_affix_lastwill"):SetLevel(1)
      unit.chance_for_champion = 10
      --SetSwarmOnDeath(unit, 4, 5, Vector(2250,-500,0), zone, nil, nil, true)
      unit:AddAbility(randomActAbilities[math.random(1, #randomActAbilities)]):SetLevel(1)
      unit:SetRenderColor(255, 255, 255)
      self:SetTempleStats(unit,scale,50*act_1_dmg_factor,750,20,2*affixinact1)
      unit:SetForwardVector(Vector(0,1,0))

      --camp 2.5
      unit = CreateUnitByName("temple_wolf_rage", c2new+Vector(1500,1000,0), true, nil, nil, DOTA_TEAM_BADGUYS )
      unit.chance_for_champion = 10
      unit.exp_factor = 2
      --SetSwarmOnDeath(unit, 7, 7, Vector(900,900,0), zone, "temple_wolf_rage", nil, true)
      unit:AddAbility("pve_temple_ambush"):SetLevel(1)
      unit:SetRenderColor(50, 50, 50)
      self:SetTempleStats(unit,scale,125*act_1_dmg_factor,500,20,2*affixinact1)

      --camp 3
      unit = CreateUnitByName("temple_wolf_rage", c3new, true, nil, nil, DOTA_TEAM_BADGUYS )
      --unit.chance_for_champion = 10
      SetSwarmOnDeath(unit, 3, 5, Vector(900,900,0), zone, "temple_wolf_rage", nil, true)
      unit:SetRenderColor(255, 255, 255)
      self:SetTempleStats(unit,scale,75*act_1_dmg_factor,750,20,2*affixinact1)


      --camp 2 aka camp 4 now
      unit = CreateUnitByName("temple_wolf_rage", c2+Vector(125,125,0), true, nil, nil, DOTA_TEAM_BADGUYS )
      unit:SetRenderColor(255, 255, 255)
      --unit:AddAbility("pve_affix_rapidfire"):SetLevel(1)
      unit:SetModelScale(0.75)
      self:SetTempleStats(unit,scale,50*act_1_dmg_factor,250,4,0*affixinact1)
      unit = CreateUnitByName("temple_wolf_rage", c2, true, nil, nil, DOTA_TEAM_BADGUYS )
      unit.exp_factor = 7
      unit:SetRenderColor(200, 200, 200)
      unit.chance_for_champion = 10
      unit:SetModelScale(0.9)
      unit:AddAbility(randomActAbilities[math.random(1, #randomActAbilities)]):SetLevel(1)
      self:SetTempleStats(unit,scale,60*act_1_dmg_factor,1250,4,2*affixinact1)
      unit = CreateUnitByName("temple_wolf_rage", c2+Vector(125,-125,0), true, nil, nil, DOTA_TEAM_BADGUYS )
      --unit:SetRenderColor(255, 255, 255)
      unit:SetModelScale(0.75)
      self:SetTempleStats(unit,scale,50*act_1_dmg_factor,250,4,0*affixinact1)
      unit = CreateUnitByName("temple_wolf_rage", c2+Vector(-125,125,0), true, nil, nil, DOTA_TEAM_BADGUYS )
      --unit:SetRenderColor(255, 255, 255)
      unit:SetModelScale(0.75)
      self:SetTempleStats(unit,scale,50*act_1_dmg_factor,250,4,0*affixinact1)
      unit = CreateUnitByName("temple_wolf_rage", c2+Vector(-125,-125,0), true, nil, nil, DOTA_TEAM_BADGUYS )
      --unit:SetRenderColor(255, 255, 255)
      unit:SetModelScale(0.75)
      self:SetTempleStats(unit,scale,50*act_1_dmg_factor,250,4,0*affixinact1)
      --camp 3
      unit = CreateUnitByName("temple_wolf_brown", c3+Vector(150,-200,0), true, nil, nil, DOTA_TEAM_BADGUYS )
      unit:AddAbility(randomActAbilities[math.random(1, #randomActAbilities)]):SetLevel(1)
      --unit:AddAbility("pve_affix_firebreath"):SetLevel(1)
      unit.chance_for_champion = 15
      self:SetTempleStats(unit,scale,125*act_1_dmg_factor,1500,20,2*affixinact1)
      --camp 4
      unit = CreateUnitByName("temple_wolf_brown", c4, true, nil, nil, DOTA_TEAM_BADGUYS )
      --unit:AddAbility("pve_affix_grow_as"):SetLevel(1)
      --unit.chance_for_champion = 10
      SetSwarmOnDeath(unit, 4, 6, Vector(1200,0,0), zone, "temple_wolf_brown", nil, true)
      self:SetTempleStats(unit,scale,125*act_1_dmg_factor,400,10,1*affixinact1)
      unit = CreateUnitByName("temple_wolf_brown", c4+Vector(-125,-125,0), true, nil, nil, DOTA_TEAM_BADGUYS )
      self:SetTempleStats(unit,scale,125*act_1_dmg_factor,400,10,1*affixinact1)
      --patrol
      unit = CreateUnitByName("temple_wolf_brown", c3, true, nil, nil, DOTA_TEAM_BADGUYS )
      unit:AddAbility(randomActAbilities[math.random(1, #randomActAbilities)]):SetLevel(1)
      unit.chance_for_champion = 15
      unit.patrolling = zone
      self:SetTempleStats(unit,scale,175*act_1_dmg_factor,1000,20,2*affixinact1)

      --camp 5
      unit = CreateUnitByName("temple_wolf_brown", c5, true, nil, nil, DOTA_TEAM_BADGUYS )
      unit.chance_for_champion = 10
      self:SetTempleStats(unit,scale,100*act_1_dmg_factor,650,10,1*affixinact1)
      unit:SetModelScale(0.9)
      unit = CreateUnitByName("temple_wolf_brown", c5+Vector(-125,-100,0), true, nil, nil, DOTA_TEAM_BADGUYS )
      unit.chance_for_champion = 10
      self:SetTempleStats(unit,scale,100*act_1_dmg_factor,650,10,1*affixinact1)
      unit:SetModelScale(0.9)
    end

    --traps
    if scale > 1 then
      unit = CreateUnitByName("temple_spike_trap", c5+Vector(-500,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
      unit.exp_factor = 5
      self:SetTempleStats(unit,scale,750,100,0,0)
      unit = CreateUnitByName("temple_spike_trap", c6+Vector(550,750,0), true, nil, nil, DOTA_TEAM_BADGUYS )
      unit.exp_factor = 5
      self:SetTempleStats(unit,scale,750,100,0,0)
    end

    --camp 6
    unit = CreateUnitByName("temple_wolf_brown", c6, true, nil, nil, DOTA_TEAM_BADGUYS )
    unit:AddAbility(randomActAbilities[math.random(1, #randomActAbilities)]):SetLevel(1)
    self:SetTempleStats(unit,scale,65*act_1_dmg_factor,900,4,0)
    unit = CreateUnitByName("temple_wolf_brown", c6+Vector(-100,-100,0), true, nil, nil, DOTA_TEAM_BADGUYS )
    self:SetTempleStats(unit,scale,65*act_1_dmg_factor,300,4,0)
    unit = CreateUnitByName("temple_wolf_brown", c6+Vector(100,-100,0), true, nil, nil, DOTA_TEAM_BADGUYS )
    self:SetTempleStats(unit,scale,65*act_1_dmg_factor,300,4,0)
    unit = CreateUnitByName("temple_wolf_brown", c6+Vector(-100,100,0), true, nil, nil, DOTA_TEAM_BADGUYS )
    self:SetTempleStats(unit,scale,65*act_1_dmg_factor,300,4,0)
    unit = CreateUnitByName("temple_wolf_brown", c6+Vector(100,100,0), true, nil, nil, DOTA_TEAM_BADGUYS )
    self:SetTempleStats(unit,scale,65*act_1_dmg_factor,300,4,0)


    --boss 1
    unit = CreateUnitByName("temple_wolf_boss_1", b1, true, nil, nil, DOTA_TEAM_BADGUYS )
    COverthrowGameMode.first_boss = unit
    --unit:SetRenderColor(25, 25, 25)
    unit.act = zone
    local bossHpFactor = 1
    if self.jungledifficulty > 1.0 then
     unit:AddAbility("pve_temple_wolf_armor_strikes")
     bossHpFactor = 2
   end
   
   self:SetTempleStats(unit,scale,200*act_1_dmg_factor,10000 * bossHpFactor,100,0)
   unit:SetForwardVector(Vector(1,-1,0))
   unit.templeboss_wolf = 1
   unit.unlocktpact1 = true
   --unit:AddAbility("burningtreeevent"):SetLevel(1)
   --boss 2
   unit = CreateUnitByName("temple_wolf_boss_2", b2, true, nil, nil, DOTA_TEAM_BADGUYS )
   unit.act = zone
   if self.jungledifficulty > 1.0 then
     unit:AddAbility("pve_temple_wolf_armor_strikes")
   end
   self:SetTempleStats(unit,scale,200*act_1_dmg_factor,20000,100,0)
   unit.templeboss_wolf = 1
   --boss 3
   unit = CreateUnitByName("temple_wolf_boss_3", b3+Vector(0,100,0), true, nil, nil, DOTA_TEAM_BADGUYS )
   --unit:AddAbility("pve_temple_spottheweak")
   unit.act = zone
   unit.cannotleavespawnpos = true
   unit.bosslikescaling = true
   unit.isboss = true
   self:SetTempleStats(unit,scale,30*act_1_dmg_factor,10000,0,0)
   --unit:AddAbility("pve_temple_bloodpool"):SetLevel(1)
   --unit:AddAbility("pve_wolf_armor_synergy_1"):SetLevel(1)
   local wolfboss1 = unit
   unit = CreateUnitByName("temple_wolf_boss_3_2", b3+Vector(0,-250,0), true, nil, nil, DOTA_TEAM_BADGUYS )
   unit:AddAbility("pve_affix_shadow_claw"):SetLevel(1)
   self:SetTempleStats(unit,scale,100*act_1_dmg_factor,10000,100,0)
   unit.sharedhealth = wolfboss1
   unit.act_specific_loot_factor = 3

   --if self.jungledifficulty <= 1.0 then
    --wolfboss1:RemoveAbility("pve_wolf_shared_life")
    --unit:RemoveAbility("pve_wolf_shared_life")
    --end
    --unit:RemoveAbility("pve_wolf_armor_synergy_2")
    --unit:AddAbility("pve_wolf_armor_synergy_2"):SetLevel(1)
    --unit:RemoveAbility("pve_aoesilence")
    --unit:AddAbility("pve_temple_bloodpool"):SetLevel(1)
    --unit:AddAbility("pve_temple_random_stun_not_lowest"):SetLevel(1)
    wolfboss1.sharedhealth = unit
    unit.templeboss_wolf = 1
    unit.teleporter = 1
    SetCinematicApproachMessage(unit, 1)
    --boss 4
    local bossName = "temple_wolf_boss_4"
    if GetBossVariation() == 2 then
      bossName = "temple_wolf_boss_4_2"
    end
    unit = CreateUnitByName(bossName, c3+Vector(1600,-1200,0), true, nil, nil, DOTA_TEAM_BADGUYS )
    unit.act = zone
    self:SetTempleStats(unit,scale,220*act_1_dmg_factor,20000,100,0)
    unit.templeboss_wolf = 1
    

    --quest giver
        --[[
		unit = CreateUnitByName("npc_dota_creature_questboard", quest_pos+Vector(1025,475,0), true, nil, nil, DOTA_TEAM_GOODGUYS )
		unit:SetForwardVector(Vector(0.25,-1,0))
		unit = CreateUnitByName("npc_dota_creature_questboard", quest_pos+Vector(1175,545,0), true, nil, nil, DOTA_TEAM_GOODGUYS )
		unit:SetForwardVector(Vector(0,-1,0))
		unit:RemoveAbility("pve_quest_abaddon_0")
		unit:RemoveAbility("pve_quest_abaddon_1")
		unit:RemoveAbility("pve_quest_abaddon_2")
		unit:RemoveAbility("pve_quest_abaddon_3")
		unit:RemoveAbility("pve_quest_abaddon_4")
		unit:RemoveAbility("pve_quest_abaddon_5")
		unit:AddAbility("pve_quest_abaddon_6"):SetLevel(1)
		unit:AddAbility("pve_quest_abaddon_7"):SetLevel(1)
		unit:AddAbility("pve_quest_abaddon_8"):SetLevel(1)
		unit:AddAbility("pve_quest_abaddon_9"):SetLevel(1)
		unit:AddAbility("pve_quest_abaddon_11"):SetLevel(1)
		unit:AddAbility("pve_quest_abaddon_10"):SetLevel(1)
        unit = CreateUnitByName("npc_dota_creature_questboard", quest_pos+Vector(1325,475,0), true, nil, nil, DOTA_TEAM_GOODGUYS )
        unit:SetForwardVector(Vector(-0.25,-1,0))
        unit:RemoveAbility("pve_quest_abaddon_0")
        unit:RemoveAbility("pve_quest_abaddon_1")
        unit:RemoveAbility("pve_quest_abaddon_2")
        unit:RemoveAbility("pve_quest_abaddon_3")
        unit:RemoveAbility("pve_quest_abaddon_4")
        unit:RemoveAbility("pve_quest_abaddon_5")
        unit:AddAbility("pve_quest_abaddon_12"):SetLevel(1)
        ]]
      end

      if zone == 2 then
        --scale = scale * (1 + 0.1 * (zone-1))
        local c1 = Entities:FindByName( nil, "camp6" ):GetAbsOrigin()
        local c2 = Entities:FindByName( nil, "camp7" ):GetAbsOrigin()
        local c3 = Entities:FindByName( nil, "camp8" ):GetAbsOrigin()
        local c4 = Entities:FindByName( nil, "camp9" ):GetAbsOrigin()
        local c5 = Entities:FindByName( nil, "camp10" ):GetAbsOrigin()
        local c6 = Entities:FindByName( nil, "camp11" ):GetAbsOrigin()
        local b1 = Entities:FindByName( nil, "boss4" ):GetAbsOrigin()
        local b2 = Entities:FindByName( nil, "boss5" ):GetAbsOrigin()
        local b3 = Entities:FindByName( nil, "boss6" ):GetAbsOrigin()
        local act_dmg_factor = 1
        if COverthrowGameMode.jungledifficulty <= 1.0 then
          act_1_dmg_factor = 0.6
        end

        local unit

        --farmer quest
        unit = CreateUnitByName("act_2_farmer", Entities:FindByName( nil, "farmer" ):GetAbsOrigin(), true, nil, nil, DOTA_TEAM_GOODGUYS )
        unit:SetForwardVector(Vector(1,-1,0))
        unit = CreateUnitByName("act_2_lama", Entities:FindByName( nil, "farmer" ):GetAbsOrigin()+Vector(-30,-120,0), true, nil, nil, DOTA_TEAM_GOODGUYS )
        unit:SetForwardVector(Vector(1,-0.15,0))

        local deadwingPos = c1+Vector(750,150,0)
        if math.random(1,100) <= 33 then
          deadwingPos = c6+Vector(300,0,0)
        elseif math.random(1,100) <= 50 then
          deadwingPos = c3+Vector(0,300,0)
        end
        unit = CreateUnitByName("extra_act2", deadwingPos, true, nil, nil, DOTA_TEAM_BADGUYS )
        unit.chance_for_champion = 100
        unit.exp_factor = 2
        unit:AddAbility("pve_temple_ambush"):SetLevel(1)
        self:SetTempleStats(unit,scale,200,2500,20,2)

        for i=1, horde_factor do
          --camp 1
          unit = CreateUnitByName("temple_sand_dustlord", c1, true, nil, nil, DOTA_TEAM_BADGUYS )
          unit:AddAbility("pve_affix_slow_poison"):SetLevel(1)
          unit.chance_for_champion = 10
          self:SetTempleStats(unit,scale,225*act_dmg_factor,2500,20,2)
          --camp 1.5
          unit = CreateUnitByName("temple_sand_dustlord", c1+Vector(1050,2000,0), true, nil, nil, DOTA_TEAM_BADGUYS )
          self:SetTempleStats(unit,scale,125*act_dmg_factor,500,7,1)
          unit:SetModelScale(0.85)
          unit = CreateUnitByName("temple_sand_dustlord", c1+Vector(1250,2000,0), true, nil, nil, DOTA_TEAM_BADGUYS )
          unit:AddAbility("pve_affix_slow_poison"):SetLevel(1)
          unit.chance_for_champion = 10
          self:SetTempleStats(unit,scale,300*act_dmg_factor,750,7,1)
          unit:SetModelScale(1.5)
          unit = CreateUnitByName("temple_sand_dustlord", c1+Vector(1450,2000,0), true, nil, nil, DOTA_TEAM_BADGUYS )
          self:SetTempleStats(unit,scale,125*act_dmg_factor,500,7,1)
          unit:SetModelScale(0.85)

          --traps
          unit = CreateUnitByName("temple_spike_trap", c1+Vector(1250+200,1400,0), true, nil, nil, DOTA_TEAM_BADGUYS )
          unit.exp_factor = 5
          self:SetTempleStats(unit,scale,750,100,0,0)

          --traps
          unit = CreateUnitByName("temple_missile_trap", c2+Vector(1200,750,0), true, nil, nil, DOTA_TEAM_BADGUYS )
          unit.exp_factor = 5
          --unit.chance_for_champion = 10
          self:SetTempleStats(unit,scale,750,100,0,0)
          unit:SetForwardVector(Vector(0,-1,0))
          unit.trap_element = "5darts"
          unit.random_new_direction = true

          --camp 2
          unit = CreateUnitByName("temple_sand_dustboar", c2+Vector(75,75,0), true, nil, nil, DOTA_TEAM_BADGUYS )
          unit:AddAbility("pve_affix_slow_poison"):SetLevel(1)
          unit:SetModelScale(0.75)
          self:SetTempleStats(unit,scale,90,400,5,1)
          unit = CreateUnitByName("temple_sand_dustboar", c2+Vector(75,-75,0), true, nil, nil, DOTA_TEAM_BADGUYS )
          unit:AddAbility("pve_affix_slow_poison"):SetLevel(1)
          unit:SetModelScale(0.75)
          self:SetTempleStats(unit,scale,90,400,5,1)
          unit = CreateUnitByName("temple_sand_dustboar", c2+Vector(-75,75,0), true, nil, nil, DOTA_TEAM_BADGUYS )
          unit:AddAbility("pve_affix_slow_poison"):SetLevel(1)
          unit:SetModelScale(0.75)
          self:SetTempleStats(unit,scale,90,400,5,1)
          unit = CreateUnitByName("temple_sand_dustboar", c2+Vector(-75,-75,0), true, nil, nil, DOTA_TEAM_BADGUYS )
          unit:AddAbility("pve_affix_slow_poison"):SetLevel(1)
          unit:SetModelScale(0.75)
          self:SetTempleStats(unit,scale,90,400,5,1)
          --camp 3
          unit = CreateUnitByName("temple_sand_dustlord", c3, true, nil, nil, DOTA_TEAM_BADGUYS )
          unit.chance_for_champion = 10
          self:SetTempleStats(unit,scale,100,1500,10,1)
          unit:SetModelScale(1.25)
          unit = CreateUnitByName("temple_sand_dustlord", c3+Vector(0,-250,0), true, nil, nil, DOTA_TEAM_BADGUYS )
          unit.chance_for_champion = 20
          self:SetTempleStats(unit,scale,180,1500,10,1)
          unit:SetModelScale(1.6)
          --camp 4
          unit = CreateUnitByName("temple_sand_dustboar", c4, true, nil, nil, DOTA_TEAM_BADGUYS )
          --unit.chance_for_champion = 10
          SetSwarmOnDeath(unit, 8, 12, Vector(-250,1500,0), zone, "temple_sand_dustboar", nil, false)
          self:SetTempleStats(unit,scale,425*act_dmg_factor,750,20,2)
          unit:SetModelScale(1.1)

          --patrol
          unit = CreateUnitByName("temple_sand_dustboar", b1+Vector(0,-100,0), true, nil, nil, DOTA_TEAM_BADGUYS )
          unit.chance_for_champion = 10
          unit.patrolling = zone
          self:SetTempleStats(unit,scale,150,850,10,1)
          unit:SetModelScale(0.9)
          unit = CreateUnitByName("temple_sand_dustboar", b2+Vector(0,-50,0), true, nil, nil, DOTA_TEAM_BADGUYS )
          unit.chance_for_champion = 10
          unit.patrolling = zone
          self:SetTempleStats(unit,scale,150,850,10,1)
          unit:SetModelScale(0.9)
          

          --camp 5
          unit = CreateUnitByName("temple_sand_stonegolem", c5, true, nil, nil, DOTA_TEAM_BADGUYS )
          unit:AddAbility("pve_affix_knockback"):SetLevel(1)
          unit.chance_for_champion = 10
          self:SetTempleStats(unit,scale,240,2000,20,3)
          unit:SetModelScale(1.8)

          --camp 6
          unit = CreateUnitByName("temple_sand_dustgolem", c6, true, nil, nil, DOTA_TEAM_BADGUYS )
          unit:AddAbility("pve_affix_knockback"):SetLevel(1)
          self:SetTempleStats(unit,scale,185,1000,10,2)
          unit:SetModelScale(1.4)
          unit = CreateUnitByName("temple_sand_dustgolem", c6+Vector(0,-150,0), true, nil, nil, DOTA_TEAM_BADGUYS )
          unit:AddAbility("pve_affix_knockback"):SetLevel(1)
          self:SetTempleStats(unit,scale,185,1000,10,2)
          unit:SetModelScale(1.4)
        end
        --camp 6
        unit = CreateUnitByName("temple_sand_dustgolem", c6+Vector(1200+math.random(1,1000),-500+math.random(1,1000),0), true, nil, nil, DOTA_TEAM_BADGUYS )
        unit:AddAbility("pve_affix_knockback"):SetLevel(1)
        unit.exp_factor = 3
        SetSwarmOnDeath(unit, 12, 15, Vector(1500,0,0), zone, "temple_sand_dustgolem", nil, false)
        self:SetTempleStats(unit,scale,55,600,8,1)
        unit:SetModelScale(0.85)
        unit = CreateUnitByName("temple_sand_dustgolem", c6+Vector(1200+math.random(1,1000),-500+math.random(1,1000),0), true, nil, nil, DOTA_TEAM_BADGUYS )
        unit:AddAbility("pve_affix_knockback"):SetLevel(1)
        self:SetTempleStats(unit,scale,55,600,8,1)
        unit:SetModelScale(0.85)
        unit = CreateUnitByName("temple_sand_dustgolem", c6+Vector(1200+math.random(1,1000),-500+math.random(1,1000),0), true, nil, nil, DOTA_TEAM_BADGUYS )
        unit:AddAbility("pve_affix_knockback"):SetLevel(1)
        self:SetTempleStats(unit,scale,55,600,8,1)
        unit:SetModelScale(0.85)
        unit = CreateUnitByName("temple_sand_dustgolem", c6+Vector(1200+math.random(1,1000),-500+math.random(1,1000),0), true, nil, nil, DOTA_TEAM_BADGUYS )
        unit:AddAbility("pve_affix_knockback"):SetLevel(1)
        self:SetTempleStats(unit,scale,55,500,8,0)
        unit:SetModelScale(0.85)
        unit = CreateUnitByName("temple_sand_dustgolem", c6+Vector(1200+math.random(1,1000),-500+math.random(1,1000),0), true, nil, nil, DOTA_TEAM_BADGUYS )
        unit:AddAbility("pve_affix_knockback"):SetLevel(1)
        self:SetTempleStats(unit,scale,55,500,8,0)
        unit:SetModelScale(0.85)
        unit = CreateUnitByName("temple_sand_dustgolem", c6+Vector(1200+math.random(1,1000),-500+math.random(1,1000),0), true, nil, nil, DOTA_TEAM_BADGUYS )
        unit:AddAbility("pve_affix_knockback"):SetLevel(1)
        self:SetTempleStats(unit,scale,55,500,8,0)
        unit:SetModelScale(0.85)
        unit = CreateUnitByName("temple_sand_dustgolem", c6+Vector(1200+math.random(1,1000),-500+math.random(1,1000),0), true, nil, nil, DOTA_TEAM_BADGUYS )
        unit:AddAbility("pve_affix_knockback"):SetLevel(1)
        self:SetTempleStats(unit,scale,55,500,8,0)
        unit:SetModelScale(0.85)
        unit = CreateUnitByName("temple_sand_dustgolem", c6+Vector(1200+math.random(1,1000),-500+math.random(1,1000),0), true, nil, nil, DOTA_TEAM_BADGUYS )
        unit:AddAbility("pve_affix_knockback"):SetLevel(1)
        self:SetTempleStats(unit,scale,55,500,8,0)
        unit:SetModelScale(0.85)
        unit = CreateUnitByName("temple_sand_dustgolem", c6+Vector(1200+math.random(1,1000),-500+math.random(1,1000),0), true, nil, nil, DOTA_TEAM_BADGUYS )
        unit:AddAbility("pve_affix_knockback"):SetLevel(1)
        self:SetTempleStats(unit,scale,55,500,8,0)
        unit:SetModelScale(0.85)
        unit = CreateUnitByName("temple_sand_dustgolem", c6+Vector(1200+math.random(1,1000),-500+math.random(1,1000),0), true, nil, nil, DOTA_TEAM_BADGUYS )
        unit:AddAbility("pve_affix_knockback"):SetLevel(1)
        self:SetTempleStats(unit,scale,55,500,8,0)
        unit:SetModelScale(0.85)

        --traps
        unit = CreateUnitByName("temple_missile_trap", c6+Vector(1500,1200,0), true, nil, nil, DOTA_TEAM_BADGUYS )
        unit.exp_factor = 5
        --unit.chance_for_champion = 10
        self:SetTempleStats(unit,scale,750,100,0,0)
        unit:SetForwardVector(Vector(-1,-1,0))
        unit.trap_element = "poison"
        unit = CreateUnitByName("temple_missile_trap", c6+Vector(1500,-1200,0), true, nil, nil, DOTA_TEAM_BADGUYS )
        unit.exp_factor = 5
        --unit.chance_for_champion = 10
        self:SetTempleStats(unit,scale,750,100,0,0)
        unit:SetForwardVector(Vector(-1,1,0))
        unit.trap_element = "poison"
        unit.trap_timer = 4
        unit = CreateUnitByName("temple_missile_trap", c6+Vector(2900,250,0), true, nil, nil, DOTA_TEAM_BADGUYS )
        unit.exp_factor = 5
        --unit.chance_for_champion = 10
        self:SetTempleStats(unit,scale,750,100,0,0)
        unit:SetForwardVector(Vector(-1,-1,0))
        unit.trap_element = "poison"
        unit.trap_timer = 2
        unit = CreateUnitByName("temple_missile_trap", c6+Vector(2900,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
        unit.exp_factor = 5
        --unit.chance_for_champion = 10
        self:SetTempleStats(unit,scale,750,100,20,0)
        unit:SetForwardVector(Vector(-1,0,0))
        unit.trap_element = "poison"
        unit.trap_timer = 6
        unit = CreateUnitByName("temple_missile_trap", c6+Vector(2900,-250,0), true, nil, nil, DOTA_TEAM_BADGUYS )
        unit.exp_factor = 5
        --unit.chance_for_champion = 10
        self:SetTempleStats(unit,scale,750,100,0,0)
        unit:SetForwardVector(Vector(-1,1,0))
        unit.trap_element = "poison"
        unit.trap_timer = 8

        --traps
        unit = CreateUnitByName("temple_spike_trap", b1+Vector(0,-1500,0), true, nil, nil, DOTA_TEAM_BADGUYS )
        unit.exp_factor = 5
        self:SetTempleStats(unit,scale,750,100,0,0)

        --boss 1
        unit = CreateUnitByName("temple_sand_boss_3", b1, true, nil, nil, DOTA_TEAM_BADGUYS )
        unit.act = zone
        self:SetTempleStats(unit,scale,200,20000,100,0)
        unit.templeboss_sandviper = 1
        unit.sandevent = 1
        unit:SetForwardVector(Vector(0,-1,0))
        --boss 2
        local bossName = "temple_sand_boss_2"
        if GetBossVariation() == 2 then
          bossName = "temple_sand_boss_2_2"
        end
        unit = CreateUnitByName(bossName, b2, true, nil, nil, DOTA_TEAM_BADGUYS )
        unit.act = zone
        self:SetTempleStats(unit,scale,225,20000,100,0)
        unit.templeboss_sandviper = 1
        unit.sandevent = 1
        unit:SetForwardVector(Vector(-1,-0.5,0))
        --boss 6 stallion
        unit = CreateUnitByName("temple_sand_boss_7", c6+Vector(1200+math.random(1,1000),-500+math.random(1,1000),0), true, nil, nil, DOTA_TEAM_BADGUYS )
        unit.act = zone
        self:SetTempleStats(unit,scale,250,20000,100,0)
        unit.templeboss_sandviper = 1
        unit.sandevent = 1
        unit:SetForwardVector(Vector(0,-1,0))
        
        --boss 3
        unit = CreateUnitByName("temple_sand_boss_1", b3+Vector(50,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
        unit.act = zone
        self:SetTempleStats(unit,scale,300,20000,100,0)
        unit.templeboss_sandviper = 1
        unit.sandevent = 1
        unit:SetForwardVector(Vector(-1,0,0))
        --boss 4
        unit = CreateUnitByName("temple_sand_boss_5", b3+Vector(500,2400,0), true, nil, nil, DOTA_TEAM_BADGUYS )
        unit.act = zone
        self:SetTempleStats(unit,scale,275,15000,100,0)
        unit.templeboss_sandviper = 1
        unit.sandevent = 1
        unit:SetForwardVector(Vector(0,-1,0))
        --boss 5 deathgore
        unit = CreateUnitByName("temple_sand_bloodboar", b3+Vector(100,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
        unit:SetModelScale(1.3)
        unit.act = zone
        unit.patrolling = -2
        unit.canleavespawnpos = true
        unit:AddAbility("pve_temple_bloodlust")
        unit:AddAbility("pve_temple_reflect")
        unit:AddAbility("pve_temple_crazy")
        unit:AddAbility("pve_affix_slow_poison")
        unit:AddAbility("pve_healnegate")
        unit:AddAbility("pve_crit_high_low")
        self:SetTempleStats(unit,scale,200,20000,100,0)
        unit.templeboss_sandviper = 1
        unit.sandevent = 1
        unit.loot_hoarder_on_death_chance = 25
      end

      if zone == 3 then
        --scale = scale * (1 + 0.1 * (zone-1))
        local c1 = Entities:FindByName( nil, "camp15" ):GetAbsOrigin()
        local c2 = Entities:FindByName( nil, "camp16" ):GetAbsOrigin()
        local c3 = Entities:FindByName( nil, "camp17" ):GetAbsOrigin()
        local c4 = Entities:FindByName( nil, "camp18" ):GetAbsOrigin()
        local c5 = Entities:FindByName( nil, "camp12" ):GetAbsOrigin()
        local c6 = Entities:FindByName( nil, "camp13" ):GetAbsOrigin()
        local c7 = Entities:FindByName( nil, "camp14" ):GetAbsOrigin()
        local b1 = Entities:FindByName( nil, "boss7" ):GetAbsOrigin()
        local b2 = Entities:FindByName( nil, "boss8" ):GetAbsOrigin()
        local b3 = Entities:FindByName( nil, "boss9" ):GetAbsOrigin()
        local event = Entities:FindByName( nil, "fishevent" ):GetAbsOrigin()

        local unit

        local deadwingPos = c1+Vector(-400,-400,0)
        if math.random(1,100) <= 33 then
          deadwingPos = c6+Vector(-400,-400,0)
        elseif math.random(1,100) <= 50 then
          deadwingPos = c4+Vector(-400,-400,0)
        end
        unit = CreateUnitByName("extra_act3", deadwingPos, true, nil, nil, DOTA_TEAM_BADGUYS )
        unit.chance_for_champion = 100
        unit.exp_factor = 2
        unit:AddAbility("pve_temple_ambush"):SetLevel(1)
        self:SetTempleStats(unit,scale,200,1500,20,2)

        for i=1, horde_factor do
          --camp 1
          unit = CreateUnitByName("temple_fungal_spawn", c1, true, nil, nil, DOTA_TEAM_BADGUYS )
          unit.chance_for_champion = 10
          self:SetTempleStats(unit,scale,250,2000,20,2)
          unit:SetModelScale(1.75)
          --camp 2
          unit = CreateUnitByName("temple_fungal_spawn", c2+Vector(75,75,0), true, nil, nil, DOTA_TEAM_BADGUYS )
          unit:SetModelScale(1)
          self:SetTempleStats(unit,scale,125,400,5,1)
          unit = CreateUnitByName("temple_fungal_spawn", c2+Vector(75,-75,0), true, nil, nil, DOTA_TEAM_BADGUYS )
          unit:SetModelScale(1)
          self:SetTempleStats(unit,scale,125,400,5,1)
          unit = CreateUnitByName("temple_fungal_spawn", c2+Vector(-75,75,0), true, nil, nil, DOTA_TEAM_BADGUYS )
          unit:SetModelScale(1)
          self:SetTempleStats(unit,scale,125,400,5,1)
          unit = CreateUnitByName("temple_fungal_spawn", c2+Vector(-75,-75,0), true, nil, nil, DOTA_TEAM_BADGUYS )
          unit:SetModelScale(1)
          self:SetTempleStats(unit,scale,125,400,5,1)
          --camp 3
          unit = CreateUnitByName("temple_fungal_slark", c3, true, nil, nil, DOTA_TEAM_BADGUYS )
          unit:AddAbility("pve_temple_cleave"):SetLevel(1)
          unit.chance_for_champion = 10
          self:SetTempleStats(unit,scale,150,1500,10,2)
          unit:SetModelScale(1.25)
          unit = CreateUnitByName("temple_fungal_slark", c3+Vector(0,-250,0), true, nil, nil, DOTA_TEAM_BADGUYS )
          unit:AddAbility("pve_temple_cleave"):SetLevel(1)
          unit.chance_for_champion = 10
          self:SetTempleStats(unit,scale,150,1500,10,2)
          unit:SetModelScale(1.25)
        end

        --traps
        --unit = CreateUnitByName("temple_missile_trap", c3+Vector(-250,-1000,0), true, nil, nil, DOTA_TEAM_BADGUYS )
        --unit.exp_factor = 5
        --self:SetTempleStats(unit,scale,750,100,0,0)
        --unit:SetForwardVector(Vector(0,1,0))
        --unit.trap_element = "water"

        --camp 4
        unit = CreateUnitByName("temple_fungal_morph", c4, true, nil, nil, DOTA_TEAM_BADGUYS )
        unit:AddAbility("pve_affix_frenzy"):SetLevel(1)
        unit.chance_for_champion = 10
        self:SetTempleStats(unit,scale,400,900,20,1,2)
        unit:SetModelScale(1.5)
        unit:SetForwardVector(Vector(0,-1,0))
        unit.loot_hoarder_on_death_chance = 25

        --traps
        --unit = CreateUnitByName("temple_spike_trap", c4+Vector(-1050,-950,0), true, nil, nil, DOTA_TEAM_BADGUYS )
        --unit.exp_factor = 5
        --self:SetTempleStats(unit,scale,750,100,0,0)

        for i=1, horde_factor do
          --patrol
          unit = CreateUnitByName("temple_fungal_slardar", b1+Vector(0,75,0), true, nil, nil, DOTA_TEAM_BADGUYS )
          unit.chance_for_champion = 10
          unit.patrolling = zone
          self:SetTempleStats(unit,scale,350,750,20,0)
          unit:SetModelScale(1.15)
          unit = CreateUnitByName("temple_fungal_slardar", b3+Vector(0,75,0), true, nil, nil, DOTA_TEAM_BADGUYS )
          unit.chance_for_champion = 10
          unit.patrolling = zone
          self:SetTempleStats(unit,scale,200,1500,20,1)
          unit:SetModelScale(1.25)
          

          --camp 5
          unit = CreateUnitByName("temple_fungal_ancient", c5, true, nil, nil, DOTA_TEAM_BADGUYS )
          unit.chance_for_champion = 10
          unit:AddAbility("pve_temple_cleave"):SetLevel(1)
          SetSwarmOnDeath(unit, 5, 9, nil, zone, nil, nil, false, {Entities:FindByName( nil, "camp14" ):GetAbsOrigin(),Entities:FindByName( nil, "boss7" ):GetAbsOrigin(),Entities:FindByName( nil, "boss8" ):GetAbsOrigin()})
          --unit.chance_for_champion = 10
          self:SetTempleStats(unit,scale,225,2250,20,3)
          unit:SetModelScale(1.3)

          --camp 6
          unit = CreateUnitByName("temple_fungal_morph", c6, true, nil, nil, DOTA_TEAM_BADGUYS )
          unit:AddAbility("pve_affix_frenzy"):SetLevel(1)
          unit.chance_for_champion = 20
          unit:SetModelScale(1.2)
          self:SetTempleStats(unit,scale,150,450,5,1)
          unit = CreateUnitByName("temple_fungal_morph", c6+Vector(75,75,0), true, nil, nil, DOTA_TEAM_BADGUYS )
          unit:SetModelScale(0.8)
          self:SetTempleStats(unit,scale,90,450,5,1)
          unit = CreateUnitByName("temple_fungal_morph", c6+Vector(75,-75,0), true, nil, nil, DOTA_TEAM_BADGUYS )
          unit:SetModelScale(0.8)
          self:SetTempleStats(unit,scale,90,450,5,1)
          unit = CreateUnitByName("temple_fungal_morph", c6+Vector(-75,75,0), true, nil, nil, DOTA_TEAM_BADGUYS )
          unit:SetModelScale(0.8)
          self:SetTempleStats(unit,scale,90,450,5,1)
          unit = CreateUnitByName("temple_fungal_morph", c6+Vector(-75,-75,0), true, nil, nil, DOTA_TEAM_BADGUYS )
          unit:SetModelScale(0.8)
          self:SetTempleStats(unit,scale,90,450,5,1)

          --camp 7
          unit = CreateUnitByName("temple_fungal_ancient", c7, true, nil, nil, DOTA_TEAM_BADGUYS )
          unit.chance_for_champion = 10
          unit:AddAbility("pve_temple_cleave"):SetLevel(1)
          self:SetTempleStats(unit,scale,160,1500,10,1)
          unit:SetModelScale(1.0)
          unit = CreateUnitByName("temple_fungal_ancient", c7+Vector(0,-200,0), true, nil, nil, DOTA_TEAM_BADGUYS )
          unit:AddAbility("pve_temple_cleave"):SetLevel(1)
          self:SetTempleStats(unit,scale,160,1500,10,1)
          unit:SetModelScale(1.0)
        end

        --boss 1
        unit = CreateUnitByName("temple_water_boss_1", b1, true, nil, nil, DOTA_TEAM_BADGUYS )
        unit.act = zone
        self:SetTempleStats(unit,scale,200,20000,100,0)
        unit.templeboss_wetlands = 1
        unit.waterevent = 1
        --boss 2
        unit = CreateUnitByName("temple_water_boss_2", b2, true, nil, nil, DOTA_TEAM_BADGUYS )
        unit.act = zone
        SetSwarmOnDeath(unit, 20, 30, nil, zone, nil, nil, false,{Entities:FindByName( nil, "boss9" ):GetAbsOrigin(),Entities:FindByName( nil, "boss7" ):GetAbsOrigin(),Entities:FindByName( nil, "camp12" ):GetAbsOrigin()})
        self:SetTempleStats(unit,scale,200,20000,100,0)
        unit.templeboss_wetlands = 1
        unit.waterevent = 1
        -- boss 2.5
        unit = CreateUnitByName("temple_water_boss_5", Entities:FindByName( nil, "teleporter_3" ):GetAbsOrigin()+Vector(600,1100,0), true, nil, nil, DOTA_TEAM_BADGUYS )
        unit.act = zone
        self:SetTempleStats(unit,scale,175,22500,100,0)
        unit.templeboss_wetlands = 1
        unit.waterevent = 1
        --boss 3
        unit = CreateUnitByName("temple_water_boss_3", b3, true, nil, nil, DOTA_TEAM_BADGUYS )
        unit.act = zone
        self:SetTempleStats(unit,scale,200,20000,100,0)
        unit.templeboss_wetlands = 1
        --unit.templeboss_dragon = 1
        unit.teleporter = 2
        unit.waterevent = 1
        unit.loot_hoarder_on_death_chance = 25
        unit:SetForwardVector(Vector(1,0,0))
        --boss 7
        unit = CreateUnitByName("temple_water_boss_7", c3+Vector(-1900,-1150,0), true, nil, nil, DOTA_TEAM_BADGUYS )
        unit.act = zone
        self:SetTempleStats(unit,scale,250,20000,100,0)
        unit.templeboss_wetlands = 1
        unit:SetForwardVector(Vector(1,1,0))

        --boss 4 wavestriker
        unit = CreateUnitByName("temple_fungal_morph_2", b3+Vector(100,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
        SetSwarmOnDeath(unit, 15, 25, nil, zone, "temple_fungal_morph", nil, false,{Entities:FindByName( nil, "camp17" ):GetAbsOrigin(),Entities:FindByName( nil, "boss9" ):GetAbsOrigin(),Entities:FindByName( nil, "boss8" ):GetAbsOrigin()})
        unit:SetModelScale(1.85)
        unit:SetRenderColor(255, 0, 0)
        unit.act = zone
        unit.patrolling = -3
        unit.canleavespawnpos = true
        unit:AddAbility("pve_temple_frostbreath")
        unit:AddAbility("pve_ice_nova_affix")
        --unit:AddAbility("pve_affix_runner")
        unit:AddAbility("pve_affix_heal_on_hit")
        unit:AddAbility("pve_affix_frenzy")
        unit:AddAbility("pve_temple_aggro_highest_hp_boss")
        --unit:AddAbility("pve_temple_ambush")
        self:SetTempleStats(unit,scale,225,15000,100,0)
        unit.templeboss_wetlands = 1

        --worms
        local b4 = Entities:FindByName( nil, "camp12" ):GetAbsOrigin()+Vector(-2600,-550,0)
        unit = CreateUnitByName("temple_water_boss_4", b4, true, nil, nil, DOTA_TEAM_BADGUYS )
        unit.canleavespawnpos = true
        unit.act = zone
        unit.templeboss_wetlands = true
        COverthrowGameMode:SetTempleStats(unit,scale,75,9000,100,0)
        unit:AddAbility("pve_temple_worm_poison1"):SetLevel(1)
        unit:AddAbility("pve_temple_worm_skin_poison1"):SetLevel(1)
        unit.act_specific_loot_factor = 3
        unit = CreateUnitByName("temple_water_boss_4", b4+Vector(0,275,0), true, nil, nil, DOTA_TEAM_BADGUYS )
        unit.canleavespawnpos = true
        unit.act = zone
        unit.templeboss_wetlands = true
        COverthrowGameMode:SetTempleStats(unit,scale,75,9000,100,0)
        unit:SetRenderColor(255, 125, 125)
        unit:AddAbility("pve_temple_worm_poison2"):SetLevel(1)
        unit:AddAbility("pve_temple_worm_skin_poison2"):SetLevel(1)
        unit = CreateUnitByName("temple_water_boss_4", b4+Vector(0,-275,0), true, nil, nil, DOTA_TEAM_BADGUYS )
        unit.canleavespawnpos = true
        unit.act = zone
        unit.templeboss_wetlands = true
        COverthrowGameMode:SetTempleStats(unit,scale,75,9000,100,0)
        unit:SetRenderColor(125, 255, 125)
        unit:AddAbility("pve_temple_worm_poison3"):SetLevel(1)
        unit:AddAbility("pve_temple_worm_skin_poison3"):SetLevel(1)
        unit:AddAbility("pve_temple_random_doom_aoe_poison"):SetLevel(1)

        --mass fish event
        unit = CreateUnitByName("temple_fungal_slardar", event, true, nil, nil, DOTA_TEAM_BADGUYS )
        self:SetTempleStats(unit,scale,5,125,0,0)
        unit:SetModelScale(0.9)
        unit:AddAbility("fishevent"):SetLevel(1)

        --traps
        --unit = CreateUnitByName("temple_missile_trap", b4+Vector(200,-1300,0), true, nil, nil, DOTA_TEAM_BADGUYS )
        --unit.exp_factor = 5
        --self:SetTempleStats(unit,scale,750,100,0,0)
        --unit:SetForwardVector(Vector(1,0,0))
        --unit.trap_element = "5darts_water"
      end

      if zone == 12 then
        --scale = scale * 2.2
        local c1 = Entities:FindByName( nil, "act12_1" ):GetAbsOrigin()
        local c2 = Entities:FindByName( nil, "act12_2" ):GetAbsOrigin()
        local c3 = Entities:FindByName( nil, "act12_3" ):GetAbsOrigin()
        local c4 = Entities:FindByName( nil, "act12_4" ):GetAbsOrigin()
        local c5 = Entities:FindByName( nil, "act12_5" ):GetAbsOrigin()
        local c6 = Entities:FindByName( nil, "act12_6" ):GetAbsOrigin()
        local c7 = Entities:FindByName( nil, "act12_7" ):GetAbsOrigin()
        local c8 = Entities:FindByName( nil, "act12_8" ):GetAbsOrigin()
        local c9 = Entities:FindByName( nil, "act12_9" ):GetAbsOrigin()
        local c10 = Entities:FindByName( nil, "act12_10" ):GetAbsOrigin()
        local c11 = Entities:FindByName( nil, "act12_11" ):GetAbsOrigin()
        local c12 = Entities:FindByName( nil, "act12_12" ):GetAbsOrigin()
        local c13 = Entities:FindByName( nil, "act12_13" ):GetAbsOrigin()
        local c14 = Entities:FindByName( nil, "act12_14" ):GetAbsOrigin()
        local c15 = Entities:FindByName( nil, "act12_15" ):GetAbsOrigin()
        local c16 = Entities:FindByName( nil, "act12_16" ):GetAbsOrigin()
        local egg1 = Entities:FindByName( nil, "act12_eggs1" ):GetAbsOrigin()
        local egg2 = Entities:FindByName( nil, "act12_eggs2" ):GetAbsOrigin()
        local egg3 = Entities:FindByName( nil, "act12_eggs3" ):GetAbsOrigin()
        local egg = egg2
        --if math.random(1,300) <= 100 then
          --  egg = egg2
          --end
          --if math.random(1,300) > 150 then
            --  egg = egg3
            --end


            local unit
            --camp 1
            unit = CreateUnitByName("temple_jungle_raptor", c1, true, nil, nil, DOTA_TEAM_BADGUYS )
            --unit.chance_for_champion = 10
            self:SetTempleStats(unit,scale,250,2000,20,0)
            unit:SetModelScale(0.75)
            unit:AddAbility("raptorevent"):SetLevel(1)
            for i=1, horde_factor do
              --camp 2
              unit = CreateUnitByName("temple_jungle_raptor", c2+Vector(75,75,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              self:SetTempleStats(unit,scale,125,400,5,1)
              unit = CreateUnitByName("temple_jungle_raptor", c2+Vector(75,-75,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              self:SetTempleStats(unit,scale,125,400,5,1)
              unit = CreateUnitByName("temple_jungle_raptor", c2+Vector(-75,75,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              self:SetTempleStats(unit,scale,125,400,5,1)
              unit = CreateUnitByName("temple_jungle_raptor", c2+Vector(-75,-75,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              self:SetTempleStats(unit,scale,125,400,5,1)

              --camp 4
              unit = CreateUnitByName("temple_jungle_viper", c4, true, nil, nil, DOTA_TEAM_BADGUYS )
              --unit.chance_for_champion = 100
              SetSwarmOnDeath(unit, 15, 25, Vector(0,2500,0), zone, "temple_jungle_viper", nil, false)
              self:SetTempleStats(unit,scale,150,3000,20,2)
              unit:SetModelScale(1.05)

              --camp 6
              unit = CreateUnitByName("temple_jungle_viper", c6, true, nil, nil, DOTA_TEAM_BADGUYS )
              unit.chance_for_champion = 20
              unit:AddAbility("pve_affix_slow_poison"):SetLevel(1)
              self:SetTempleStats(unit,scale,500,500,10,2)
              unit:SetModelScale(0.9)
              unit = CreateUnitByName("temple_jungle_viper", c6+Vector(-100,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              unit.chance_for_champion = 10
              unit:AddAbility("pve_affix_slow_poison"):SetLevel(1)
              self:SetTempleStats(unit,scale,500,500,10,2)
              unit:SetModelScale(0.9)

              --camp 8
              
              unit = CreateUnitByName("temple_jungle_spider", c8+Vector(0,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              unit.chance_for_champion = 10
              self:SetTempleStats(unit,scale,350,650,7,1)
              unit:SetModelScale(0.85)
              unit = CreateUnitByName("temple_jungle_spider", c8+Vector(-50,75,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              unit.chance_for_champion = 10
              self:SetTempleStats(unit,scale,350,650,7,1)
              unit:SetModelScale(0.85)
              unit = CreateUnitByName("temple_jungle_spider", c8+Vector(50,75,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              unit.chance_for_champion = 10
              self:SetTempleStats(unit,scale,350,650,7,1)
              unit:SetModelScale(0.85)

              --camp 10
              unit = CreateUnitByName("temple_jungle_spider", c10, true, nil, nil, DOTA_TEAM_BADGUYS )
              unit.chance_for_champion = 10
              self:SetTempleStats(unit,scale,450,900,20,2)
              unit:SetModelScale(1.25)

              --camp 12
              unit = CreateUnitByName("temple_jungle_troll", c12, true, nil, nil, DOTA_TEAM_BADGUYS )
              unit.chance_for_champion = 100
              self:SetTempleStats(unit,scale,200,2000,20,2)
              unit:SetModelScale(1.15)
              --camp 14
              unit = CreateUnitByName("temple_jungle_troll", c14, true, nil, nil, DOTA_TEAM_BADGUYS )
              unit.chance_for_champion = 10
              self:SetTempleStats(unit,scale,100,1500,10,2)
              unit:SetModelScale(0.9)
              unit = CreateUnitByName("temple_jungle_troll", c14+Vector(-100,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              unit.chance_for_champion = 10
              self:SetTempleStats(unit,scale,100,1500,10,2)
              unit:SetModelScale(0.9)

              --camp 16
              unit = CreateUnitByName("temple_jungle_troll", c16+Vector(75,75,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              unit:SetModelScale(0.75)
              self:SetTempleStats(unit,scale,75,800,5,1)
              unit = CreateUnitByName("temple_jungle_troll", c16+Vector(75,-75,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              unit:SetModelScale(0.75)
              self:SetTempleStats(unit,scale,75,800,5,1)
              unit = CreateUnitByName("temple_jungle_troll", c16+Vector(-75,75,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              unit:SetModelScale(0.75)
              self:SetTempleStats(unit,scale,75,800,5,1)
              unit = CreateUnitByName("temple_jungle_troll", c16+Vector(-75,-75,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              unit:SetModelScale(0.75)
              self:SetTempleStats(unit,scale,75,800,5,1)
              

              --patrol
              unit = CreateUnitByName("temple_jungle_raptor", c14+Vector(0,75,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              unit.chance_for_champion = 50
              unit.patrolling = zone
              self:SetTempleStats(unit,scale,350,950,20,1)
              unit:SetModelScale(1.25)
              unit = CreateUnitByName("temple_jungle_raptor", c7+Vector(0,75,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              unit.chance_for_champion = 50
              unit.patrolling = zone
              self:SetTempleStats(unit,scale,175,2250,20,2)
              unit:SetModelScale(1.0)
              unit = CreateUnitByName("extra_act12", c10+Vector(0,75,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              unit.chance_for_champion = 100
              unit.patrolling = zone
              self:SetTempleStats(unit,scale,125,2500,20,2)
              unit:SetModelScale(1.0)

            end

            --boss 1
            unit = CreateUnitByName("temple_jungle_boss_1", c3, true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.act = zone
            self:SetTempleStats(unit,scale,200,20000,100,0)
            unit.boss_in_act = 2

            --boss 2
            unit = CreateUnitByName("temple_jungle_boss_2", c5, true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.act = zone
            self:SetTempleStats(unit,scale,200,20000,100,0)
            unit.boss_in_act = 3

            --boss 3
            unit = CreateUnitByName("temple_jungle_boss_3", c7, true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.act = zone
            self:SetTempleStats(unit,scale,200,20000,100,0)
            unit.boss_in_act = 4
            unit:SetForwardVector(Vector(1,0,0))

            --boss 4
            unit = CreateUnitByName("temple_jungle_boss_4", c9, true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.act = zone
            self:SetTempleStats(unit,scale,200,20000,100,0)
            unit.boss_in_act = 5

            --boss 5
            unit = CreateUnitByName("temple_jungle_boss_5", c11, true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.act = zone
            self:SetTempleStats(unit,scale,200,20000,100,0)
            unit.boss_in_act = 6

            --boss 6
            unit = CreateUnitByName("temple_jungle_boss_6", c15, true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.act = zone
            unit.global_cooldown_factor = 0.6
            self:SetTempleStats(unit,scale,200,20000,100,0)
            unit.boss_in_act = 7
            unit:SetForwardVector(Vector(1,0,0))

            --boss 7
            unit = CreateUnitByName("temple_jungle_boss_7", c13+Vector(450,600,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.act = zone
            self:SetTempleStats(unit,scale,200,20000,100,0)
            unit.boss_in_act = 8

            --egg event
            unit = CreateUnitByName("temple_dragon_egg_2", egg, true, nil, nil, DOTA_TEAM_BADGUYS )
            self:SetTempleStats(unit,scale,0,7500,0,0)
            unit:SetModelScale(1.4)
            unit:AddAbility("pve_temple_dragon_hatch_3"):SetLevel(1)
            unit:SetRenderColor(75, 75, 75)

            
          end

          if zone == 4 then
            --                                                                   AVERAGE GOOD STATS ARE 200 dmg and 2000 life
            --scale = scale * (1 + 0.1 * (zone-1))
            local c1 = Entities:FindByName( nil, "camp19" ):GetAbsOrigin()
            local c1l = Entities:FindByName( nil, "camp19left" ):GetAbsOrigin()+Vector(120,-600,0)
            local c1r = Entities:FindByName( nil, "camp19right" ):GetAbsOrigin()+Vector(-125,-600,0)
            local c2 = Entities:FindByName( nil, "camp20" ):GetAbsOrigin()
            local c3 = Entities:FindByName( nil, "camp21" ):GetAbsOrigin()
            local c4 = Entities:FindByName( nil, "camp22" ):GetAbsOrigin()
            local c5 = Entities:FindByName( nil, "camp23" ):GetAbsOrigin()
            local c6 = Entities:FindByName( nil, "camp24" ):GetAbsOrigin()
            local c7 = Entities:FindByName( nil, "camp25" ):GetAbsOrigin()
            local c8 = Entities:FindByName( nil, "camp26" ):GetAbsOrigin()
            local c9 = Entities:FindByName( nil, "camp27" ):GetAbsOrigin()
            local b1 = Entities:FindByName( nil, "boss10" ):GetAbsOrigin()
            local b2 = Entities:FindByName( nil, "boss11" ):GetAbsOrigin()
            local b3 = Entities:FindByName( nil, "boss12" ):GetAbsOrigin()
            local b4 = Entities:FindByName( nil, "boss13" ):GetAbsOrigin()
            local b5 = Entities:FindByName( nil, "boss14" ):GetAbsOrigin()
            local b6 = Entities:FindByName( nil, "boss15" ):GetAbsOrigin()
            local event = Entities:FindByName( nil, "shadowevent" ):GetAbsOrigin()+Vector(50,-100,0)

            local unit

            local deadwingPos = c1+Vector(0,-1000,0)
            if math.random(1,100) <= 33 then
              deadwingPos = c3+Vector(-400,-400,0)
            elseif math.random(1,100) <= 50 then
              deadwingPos = c5+Vector(-400,-400,0)
            end
            unit = CreateUnitByName("extra_act4", deadwingPos, true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.chance_for_champion = 100
            unit.exp_factor = 2
            unit:AddAbility("pve_temple_ambush"):SetLevel(1)
            self:SetTempleStats(unit,scale,200,1500,20,2)

            --camp 1                 
            unit = CreateUnitByName("temple_shadow_melee", c1, true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.chance_for_champion = 10
            self:SetTempleStats(unit,scale,25,300,20,3)
            unit = CreateUnitByName("temple_shadow_archer", c1l, true, nil, nil, DOTA_TEAM_BADGUYS )
            self:SetTempleStats(unit,scale,35,200,5,0)
            unit = CreateUnitByName("temple_shadow_archer", c1l+Vector(0,-100,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            self:SetTempleStats(unit,scale,35,200,5,0)
            unit = CreateUnitByName("temple_shadow_archer", c1l+Vector(0,-200,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            self:SetTempleStats(unit,scale,35,200,5,0)
            unit = CreateUnitByName("temple_shadow_archer", c1l+Vector(0,-300,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            self:SetTempleStats(unit,scale,35,200,5,0)
            unit = CreateUnitByName("temple_shadow_archer", c1r, true, nil, nil, DOTA_TEAM_BADGUYS )
            self:SetTempleStats(unit,scale,35,200,5,0)
            unit = CreateUnitByName("temple_shadow_archer", c1r+Vector(0,-100,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            self:SetTempleStats(unit,scale,35,200,5,0)
            unit = CreateUnitByName("temple_shadow_archer", c1r+Vector(0,-200,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            self:SetTempleStats(unit,scale,35,200,5,0)
            unit = CreateUnitByName("temple_shadow_archer", c1r+Vector(0,-300,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.chance_for_champion = 10
            self:SetTempleStats(unit,scale,35,200,5,0)

            --traps
            unit = CreateUnitByName("temple_missile_trap", c1+Vector(-125,-1000,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.exp_factor = 5
            --unit.chance_for_champion = 10
            self:SetTempleStats(unit,scale,750,100,0,0)
            unit:SetForwardVector(Vector(0,1,0))
            unit.trap_element = "shadow"
            unit = CreateUnitByName("temple_missile_trap", c1+Vector(125,-1000,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.exp_factor = 5
            --unit.chance_for_champion = 10
            self:SetTempleStats(unit,scale,750,100,0,0)
            unit:SetForwardVector(Vector(0,1,0))
            unit.trap_element = "shadow"
            unit.trap_timer = 3

            --camp 2
            for i=1, horde_factor do
              unit = CreateUnitByName("temple_shadow_melee", c2+Vector(75,75,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              unit.chance_for_champion = 10
              unit:SetModelScale(0.85)
              self:SetTempleStats(unit,scale,150,1000,10,1)
              unit = CreateUnitByName("temple_shadow_melee", c2+Vector(75,-75,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              unit.chance_for_champion = 10
              unit:SetModelScale(0.85)
              self:SetTempleStats(unit,scale,150,1000,10,1)

              --camp 3
              unit = CreateUnitByName("temple_shadow_undying", c3, true, nil, nil, DOTA_TEAM_BADGUYS )
              --unit.chance_for_champion = 10
              SetSwarmOnDeath(unit, 4, 8, Vector(3000,-1250,0), zone, nil, nil, false)
              self:SetTempleStats(unit,scale,300,1500,20,3)
              unit.loot_hoarder_on_death_chance = 25

              --camp 4
              unit = CreateUnitByName("temple_shadow_undying", c4, true, nil, nil, DOTA_TEAM_BADGUYS )
              self:SetTempleStats(unit,scale,110,600,4,3)
              unit:SetModelScale(0.95)
              unit = CreateUnitByName("temple_shadow_undying", c4+Vector(-150,150,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              self:SetTempleStats(unit,scale,110,350,4,0)
              unit:SetModelScale(0.95)
              unit = CreateUnitByName("temple_shadow_undying", c4+Vector(-150,-150,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              self:SetTempleStats(unit,scale,110,350,4,0)
              unit:SetModelScale(0.95)
              unit = CreateUnitByName("temple_shadow_undying", c4+Vector(150,150,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              self:SetTempleStats(unit,scale,110,350,4,0)
              unit:SetModelScale(0.95)
              unit = CreateUnitByName("temple_shadow_undying", c4+Vector(150,-150,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              self:SetTempleStats(unit,scale,110,350,4,0)
              unit:SetModelScale(0.95)
            end
            --traps
            unit = CreateUnitByName("temple_spike_trap", c4+Vector(950,1000,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.exp_factor = 5
            self:SetTempleStats(unit,scale,750,100,0,0)

            for i=1, horde_factor do
              --camp 5
              unit = CreateUnitByName("temple_shadow_nightspider", c5, true, nil, nil, DOTA_TEAM_BADGUYS )
              unit.chance_for_champion = 10
              self:SetTempleStats(unit,scale,300,350,10,0)
              unit = CreateUnitByName("temple_shadow_nightspider", c5+Vector(150,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              unit.chance_for_champion = 10
              self:SetTempleStats(unit,scale,300,350,10,0)

              --camp 5 2
              unit = CreateUnitByName("temple_shadow_nightspider", c5+Vector(-900,-1250,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              unit.chance_for_champion = 10
              self:SetTempleStats(unit,scale,300,350,10,0)
              unit = CreateUnitByName("temple_shadow_nightspider", c5+Vector(-900,-1150,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              unit.chance_for_champion = 10
              self:SetTempleStats(unit,scale,300,350,10,0)

              --patrol
              unit = CreateUnitByName("temple_shadow_nightspider", b1+Vector(0,100,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              unit.chance_for_champion = 10
              unit.patrolling = zone
              self:SetTempleStats(unit,scale,300,1250,20,0)
              unit = CreateUnitByName("temple_shadow_nightspider", b3+Vector(0,100,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              unit.chance_for_champion = 10
              unit.patrolling = zone
              self:SetTempleStats(unit,scale,300,1250,20,1)

              --scale = 4.0
              --camp 6
              unit = CreateUnitByName("temple_shadow_colossus", c6+Vector(0,150,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              unit:AddAbility("pve_temple_colossus"):SetLevel(1)
              unit.chance_for_champion = 25
              unit:SetModelScale(1.2)
              self:SetTempleStats(unit,scale,275,1850,20,3)
              unit:SetForwardVector(Vector(0,1,0))

              --camp 7
              unit = CreateUnitByName("temple_shadow_colossus", c7, true, nil, nil, DOTA_TEAM_BADGUYS )
              unit:AddAbility("pve_temple_colossus"):SetLevel(1)
              unit:SetModelScale(1.3)
              self:SetTempleStats(unit,scale,400,500,10,1)
              unit = CreateUnitByName("temple_shadow_colossus", c7+Vector(150,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              unit:AddAbility("pve_temple_colossus"):SetLevel(1)
              unit:SetModelScale(1.3)
              self:SetTempleStats(unit,scale,400,500,10,1)

              --camp 8
              unit = CreateUnitByName("temple_shadow_demon", c8, true, nil, nil, DOTA_TEAM_BADGUYS )
              unit.chance_for_champion = 10
              self:SetTempleStats(unit,scale,150,1000,10,1)
              unit = CreateUnitByName("temple_shadow_demon", c8+Vector(150,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              unit.chance_for_champion = 10
              self:SetTempleStats(unit,scale,150,1000,10,1)

              --camp 9
              unit = CreateUnitByName("temple_shadow_demon", c9, true, nil, nil, DOTA_TEAM_BADGUYS )
              unit.chance_for_champion = 10
              unit:SetModelScale(1.25)
              self:SetTempleStats(unit,scale,450,1000,20,1)
            end

            --traps
            unit = CreateUnitByName("temple_missile_trap", b2+Vector(-500,2300,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.exp_factor = 5
            unit.loot_hoarder_on_death_chance = 10
            --unit.chance_for_champion = 10
            self:SetTempleStats(unit,scale,750,100,0,0)
            unit:SetForwardVector(Vector(0,1,0))
            unit.trap_element = "shadowshort"
            unit.random_new_direction = true
            unit = CreateUnitByName("temple_missile_trap", b2+Vector(-1000,2300,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.exp_factor = 5
            unit.loot_hoarder_on_death_chance = 10
            --unit.chance_for_champion = 10
            self:SetTempleStats(unit,scale,750,100,0,0)
            unit:SetForwardVector(Vector(0,1,0))
            unit.trap_element = "shadowshort"
            unit.random_new_direction = true
            unit = CreateUnitByName("temple_missile_trap", b2+Vector(-750,1800,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.exp_factor = 5
            unit.loot_hoarder_on_death_chance = 10
            --unit.chance_for_champion = 10
            self:SetTempleStats(unit,scale,750,100,0,0)
            unit:SetForwardVector(Vector(0,1,0))
            unit.trap_element = "shadowshort"
            unit.random_new_direction = true

            --scale = 3.0
            --boss 1
            unit = CreateUnitByName("temple_shadow_boss_1", b1, true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.act = zone
            self:SetTempleStats(unit,scale,200,20000,100,0)
            unit.templeboss_shadowlands = 1
            unit:SetForwardVector(Vector(-1,1,0))
            --boss 2
            unit = CreateUnitByName("temple_shadow_boss_2", b2, true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.act = zone
            self:SetTempleStats(unit,scale,175,25000,100,0)
            unit.templeboss_shadowlands = 1
            --boss 3
            unit = CreateUnitByName("temple_shadow_boss_3", b3, true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.act = zone
            self:SetTempleStats(unit,scale,150,25000,100,0)
            unit.templeboss_shadowlands = 1
            unit:SetForwardVector(Vector(1,0,0))

            --scale = 4.0
            --boss 4
            unit = CreateUnitByName("temple_shadow_boss_4", b4, true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.act = zone
            self:SetTempleStats(unit,scale,100,30000,100,0)
            unit.templeboss_shadowlands = 1
            unit.loot_hoarder_on_death_chance = 25
            unit:SetForwardVector(Vector(0,-1,0))
            --boss 5
            unit = CreateUnitByName("temple_shadow_boss_5", b5, true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.act = zone
            SetSwarmOnDeath(unit, 3, 3, Vector(0,2000,0), zone, "temple_shadow_colossus", nil, false)
            self:SetTempleStats(unit,scale,150,25000,100,0)
            unit.templeboss_shadowlands = 1
            --boss 6
            unit = CreateUnitByName("temple_shadow_boss_6", b6, true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.act = zone
            self:SetTempleStats(unit,scale,180,22500,100,0)
            unit.templeboss_shadowlands = 1
            unit.teleporter = 3
            unit:SetForwardVector(Vector(-1,-1,0))
            unit.act_specific_loot_factor = 3

            --invis shadow event
            local tab = {}
            tab.Duration = -1
            for i=1, horde_factor do
              unit = CreateUnitByName("temple_shadow_gravemaker", event+Vector(250,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              self:SetTempleStats(unit,scale,115,3500,0,0)
              unit:FindAbilityByName("pveboss_system"):ApplyDataDrivenModifier(unit, unit, "modifier_invisible", tab)
              unit = CreateUnitByName("temple_shadow_gravemaker", event+Vector(-250,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              self:SetTempleStats(unit,scale,115,3500,0,0)
              unit:FindAbilityByName("pveboss_system"):ApplyDataDrivenModifier(unit, unit, "modifier_invisible", tab)
              unit = CreateUnitByName("temple_shadow_gravemaker", event+Vector(-250,-250,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              self:SetTempleStats(unit,scale,115,3500,0,0)
              unit:FindAbilityByName("pveboss_system"):ApplyDataDrivenModifier(unit, unit, "modifier_invisible", tab)
              unit = CreateUnitByName("temple_shadow_gravemaker", event+Vector(250,250,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              self:SetTempleStats(unit,scale,115,3500,0,0)
              unit:FindAbilityByName("pveboss_system"):ApplyDataDrivenModifier(unit, unit, "modifier_invisible", tab)
              unit = CreateUnitByName("temple_shadow_gravemaker", event+Vector(0,250,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              self:SetTempleStats(unit,scale,115,3500,0,0)
              unit:FindAbilityByName("pveboss_system"):ApplyDataDrivenModifier(unit, unit, "modifier_invisible", tab)
              unit = CreateUnitByName("temple_shadow_gravemaker", event+Vector(0,250,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              self:SetTempleStats(unit,scale,115,3500,0,0)
              unit:FindAbilityByName("pveboss_system"):ApplyDataDrivenModifier(unit, unit, "modifier_invisible", tab)
              unit = CreateUnitByName("temple_shadow_gravemaker", event+Vector(250,-250,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              self:SetTempleStats(unit,scale,115,3500,0,0)
              unit:FindAbilityByName("pveboss_system"):ApplyDataDrivenModifier(unit, unit, "modifier_invisible", tab)
              unit = CreateUnitByName("temple_shadow_gravemaker", event+Vector(-250,250,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              self:SetTempleStats(unit,scale,115,3500,0,0)
              unit:FindAbilityByName("pveboss_system"):ApplyDataDrivenModifier(unit, unit, "modifier_invisible", tab)
            end
            unit = CreateUnitByName("temple_shadow_gravemaker", event+Vector(-150,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.act = zone
            unit.templeboss_shadowlands = 1
            self:SetTempleStats(unit,scale,125,7000,100,0)
            unit:FindAbilityByName("pveboss_system"):ApplyDataDrivenModifier(unit, unit, "modifier_invisible", tab)
            unit = CreateUnitByName("temple_shadow_gravemaker", event+Vector(150,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.act = zone
            unit.templeboss_shadowlands = 1
            self:SetTempleStats(unit,scale,125,7000,100,0)
            unit:FindAbilityByName("pveboss_system"):ApplyDataDrivenModifier(unit, unit, "modifier_invisible", tab)
          end

          if zone == 8 then
            self.act_affix_roll = nil
            --                                                              AVERAGE GOOD STATS ARE 200 dmg and 2000 life
            local tab = {}
            tab.Duration = -1
            --scale = scale * (1 + 0.1 * (zone-1))
            local c1 = Entities:FindByName( nil, "volcano1" ):GetAbsOrigin()
            --local c2 = Entities:FindByName( nil, "tomb2" ):GetAbsOrigin()
            --local c3 = Entities:FindByName( nil, "tomb3" ):GetAbsOrigin()
            --local c4 = Entities:FindByName( nil, "tomb4" ):GetAbsOrigin()
            --local c5 = Entities:FindByName( nil, "tomb5" ):GetAbsOrigin()
            --local c6 = Entities:FindByName( nil, "tomb6" ):GetAbsOrigin()

            local unit

            --bosses
            unit = CreateUnitByName("temple_volcano_boss_1", c1, true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.bosslikescaling = true
            unit:AddAbility("volcano_event_1")
            self:SetTempleStats(unit,scale,175,22500,0,0)
            unit.templeboss_volcano = 1
            unit.isboss = true
            unit:SetForwardVector(Vector(0,-1,0))
            --unit:FindAbilityByName("pve_aa_fireaoe"):ApplyDataDrivenModifier(unit, unit, "modifier_fire_shield_lock", nil)
            --self.flameshieldedboss = unit
            --unit.temple_cooldown = 5
          end

          if zone == 9 then
            self.act_affix_roll = nil
            --scale = scale * 1.5 --(1 + 0.1 * (zone-1))
            MogushanSpawnRound(scale, zone)
            local c2 = Entities:FindByName( nil, "ogre1" ):GetAbsOrigin()
            local c3 = Entities:FindByName( nil, "ogre2" ):GetAbsOrigin()
            local unit = CreateUnitByName("npc_dota_creature_quest_ogre", c2, true, nil, nil, DOTA_TEAM_GOODGUYS )
            unit:SetForwardVector(Vector(0,-1,0))
            unit = CreateUnitByName("npc_dota_creature_quest_ogre", c3, true, nil, nil, DOTA_TEAM_GOODGUYS )
            unit:SetForwardVector(Vector(0,-1,0))
          end

          if zone == 10 then
            --                                                              AVERAGE GOOD STATS ARE 200 dmg and 2000 life
            local tab = {}
            tab.Duration = -1
            --scale = scale * (1 + 0.1 * (zone-1))
            local b1 = Entities:FindByName( nil, "boss25" ):GetAbsOrigin()

            local unit
            for i=1, horde_factor do
              --warden
              unit = CreateUnitByName("temple_volcano_fireele", b1+Vector(-250,900,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              unit.chance_for_champion = 25
              self:SetTempleStats(unit,scale,150,2500,20,1)
              unit:SetForwardVector(Vector(0,1,0))
              unit = CreateUnitByName("temple_volcano_fireele", b1+Vector(250,900,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              unit.chance_for_champion = 25
              self:SetTempleStats(unit,scale,150,2500,20,1)
              unit:SetForwardVector(Vector(0,1,0))
            end
            local unit_pointer = unit
            Timers:CreateTimer(1,function()
              if unit_pointer and not unit_pointer:IsNull() then
                if unit_pointer:GetHealth() / unit_pointer:GetMaxHealth() <= 0.05 then
                  SpawnMonsterSwarm( zone, 2, 4, unit_pointer, false, false, true, false, {b1+Vector(0,600,0)+RandomVector(1200), b1+Vector(0,600,0)+RandomVector(1200), b1+Vector(0,600,0)+RandomVector(1200), b1+Vector(0,600,0)+RandomVector(1200)}, scale )
                  SpawnMonsterSwarm( zone, 2, 4, unit_pointer, false, false, true, true, {b1+Vector(0,600,0)+RandomVector(1200), b1+Vector(0,600,0)+RandomVector(1200), b1+Vector(0,600,0)+RandomVector(1200), b1+Vector(0,600,0)+RandomVector(1200)}, scale )
                else
                  return 1
                end
              end
            end)

            --bosses
            unit = CreateUnitByName("temple_throne_boss_1", b1, true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.act = zone
            self:SetTempleStats(unit,scale,100,40000,100,0)
            unit.templeboss_throne = 1
            unit.hascombatphases = 4
            unit.combatphase = 0
            unit.ischallengeboss = 1
            unit.display_casting_spells = true
            unit:SetForwardVector(Vector(0,1,0))
            unit.loot_hoarder_on_death_chance = 25
            unit.act_specific_loot_factor = 3
            unit.quest_trigger_class = "Saving the Sanctum"
          end

          if zone == 7 then
            --                                                              AVERAGE GOOD STATS ARE 200 dmg and 2000 life
            --scale = scale * (1 + 0.1 * (zone-1))
            local tab = {}
            tab.Duration = -1
            --scale = scale * (1 + 0.1 * (zone-1))
            local c1 = Entities:FindByName( nil, "tomb1" ):GetAbsOrigin()
            local c2 = Entities:FindByName( nil, "tomb2" ):GetAbsOrigin()
            local c3 = Entities:FindByName( nil, "tomb3" ):GetAbsOrigin()
            local c4 = Entities:FindByName( nil, "tomb4" ):GetAbsOrigin()
            local c5 = Entities:FindByName( nil, "tomb5" ):GetAbsOrigin()
            local c6 = Entities:FindByName( nil, "tomb6" ):GetAbsOrigin()

            local unit
            for i=1, horde_factor do
              --camp 1                 
              unit = CreateUnitByName("temple_tomb_skeleton", c1, true, nil, nil, DOTA_TEAM_BADGUYS )
              SetSwarmOnDeath(unit, 5, 15, Vector(-2000,-2000,0), 4, nil, nil, false)
              --unit.chance_for_champion = 10
              self:SetTempleStats(unit,scale,350,1250,20,3)

              --camp 2
              unit = CreateUnitByName("temple_tomb_bug", c3, true, nil, nil, DOTA_TEAM_BADGUYS )
              unit.chance_for_champion = 10
              self:SetTempleStats(unit,scale,150,750,7,1)
              unit:FindAbilityByName("pveboss_system"):ApplyDataDrivenModifier(unit, unit, "modifier_invisible", tab)
              unit = CreateUnitByName("temple_tomb_bug", c3+Vector(200,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              self:SetTempleStats(unit,scale,150,750,7,1)
              unit:FindAbilityByName("pveboss_system"):ApplyDataDrivenModifier(unit, unit, "modifier_invisible", tab)
              unit = CreateUnitByName("temple_tomb_bug", c3+Vector(-200,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              self:SetTempleStats(unit,scale,150,750,7,1)
              unit:FindAbilityByName("pveboss_system"):ApplyDataDrivenModifier(unit, unit, "modifier_invisible", tab)
            end

            --camp 3
            unit = CreateUnitByName("temple_tomb_spider", c5, true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.chance_for_champion = 20
            self:SetTempleStats(unit,scale,225,500,10,2)
            unit:FindAbilityByName("pveboss_system"):ApplyDataDrivenModifier(unit, unit, "modifier_invisible", tab)
            unit = CreateUnitByName("temple_tomb_spider", c5+Vector(225,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.chance_for_champion = 10
            self:SetTempleStats(unit,scale,225,500,10,2)
            unit:FindAbilityByName("pveboss_system"):ApplyDataDrivenModifier(unit, unit, "modifier_invisible", tab)
            local unit_pointer = unit
            Timers:CreateTimer(1,function()
              if unit_pointer and not unit_pointer:IsNull() then
                if unit_pointer:GetHealth() / unit_pointer:GetMaxHealth() <= 0.75 then
                  SpawnMonsterSwarm( zone, 3, 5, unit_pointer, false, false, true, false, {Entities:FindByName( nil, "cathedral" ):GetAbsOrigin()}, scale )
                  SpawnMonsterSwarm( zone, 3, 5, unit_pointer, false, false, true, true, {Entities:FindByName( nil, "cathedral" ):GetAbsOrigin()}, scale )
                else
                  return 1
                end
              end
            end)

            --traps
            unit = CreateUnitByName("temple_spike_trap", c3+Vector(-650,350,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.exp_factor = 5
            self:SetTempleStats(unit,scale,750,100,0,0)

            --traps
            unit = CreateUnitByName("temple_missile_trap", c4+Vector(675,700,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.exp_factor = 5
            --unit.chance_for_champion = 10
            self:SetTempleStats(unit,scale,750,100,0,0)
            unit:SetForwardVector(Vector(-1,-1,0))
            unit.trap_element = "5darts_shadow"

            --bosses
            unit = CreateUnitByName("temple_tomb_boss_1", c2, true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.act = zone
            self:SetTempleStats(unit,scale,225,22500,100,0)
            unit.templeboss_tomb = 1
            --unit.temple_cooldown = 5
            unit.ischallengeboss = 1
            unit:SetForwardVector(Vector(1,-1,0))

            unit = CreateUnitByName("temple_tomb_boss_2", c4+Vector(0,-100,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.act = zone
            self:SetTempleStats(unit,scale,175,27500,100,0)
            unit.templeboss_tomb = 1
            --unit.temple_cooldown = 5
            unit.ischallengeboss = 1
            unit:SetForwardVector(Vector(1,-1,0))
            unit = CreateUnitByName("temple_tomb_boss_3", c6, true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.act = zone
            SetSwarmOnDeath(unit, 20, 30, nil, zone, "temple_shadow_gravemaker", nil, false, {Entities:FindByName( nil, "cathedral" ):GetAbsOrigin(),Entities:FindByName( nil, "boss7" ):GetAbsOrigin(),Entities:FindByName( nil, "camp14" ):GetAbsOrigin()})
            self:SetTempleStats(unit,scale,150,30000,100,0)
            unit.templeboss_tomb = 1
            --unit.temple_cooldown = 5
            unit.ischallengeboss = 1
            unit:SetForwardVector(Vector(1,0,0))
          end

          if zone == 5 then
            --                                                                   AVERAGE GOOD STATS ARE 200 dmg and 2000 life
            --scale = 6.0
            --scale = scale * (1 + 0.1 * (zone-1))
            local c1 = Entities:FindByName( nil, "camp28" ):GetAbsOrigin()
            local c2l = Entities:FindByName( nil, "camp29l" ):GetAbsOrigin()
            local c2r = Entities:FindByName( nil, "camp29r" ):GetAbsOrigin()
            local c3 = Entities:FindByName( nil, "camp30" ):GetAbsOrigin()
            local c4 = Entities:FindByName( nil, "camp31" ):GetAbsOrigin()
            local c5 = Entities:FindByName( nil, "camp32" ):GetAbsOrigin()
            local c6 = Entities:FindByName( nil, "camp33" ):GetAbsOrigin()
            local c7 = Entities:FindByName( nil, "camp34" ):GetAbsOrigin()
            local c8 = Entities:FindByName( nil, "camp35" ):GetAbsOrigin()
            local c9 = Entities:FindByName( nil, "camp36" ):GetAbsOrigin()
            local c10 = Entities:FindByName( nil, "camp37" ):GetAbsOrigin()
            local b1 = Entities:FindByName( nil, "boss16" ):GetAbsOrigin()
            local b2 = Entities:FindByName( nil, "boss17" ):GetAbsOrigin()
            local b3 = Entities:FindByName( nil, "boss18" ):GetAbsOrigin()
            local b4 = Entities:FindByName( nil, "boss19" ):GetAbsOrigin()
            local b7 = Entities:FindByName( nil, "new_dragon_boss" ):GetAbsOrigin()
            local event = Entities:FindByName( nil, "eggevent" ):GetAbsOrigin()+Vector(0,-200,0)

            local unit

            local deadwingPos = c1+Vector(0,250,0)
            if math.random(1,100) <= 33 then
              deadwingPos = c9+Vector(0,150,0)
            elseif math.random(1,100) <= 50 then
              deadwingPos = c5+Vector(0,150,0)
            end
            unit = CreateUnitByName("extra_act5", deadwingPos, true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.chance_for_champion = 100
            unit.exp_factor = 2
            unit:AddAbility("pve_temple_ambush"):SetLevel(1)
            self:SetTempleStats(unit,scale,200,1500,20,2)

            --camp 1   
            unit = CreateUnitByName("temple_dragon_jakiro", c1+Vector(150,-500,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.chance_for_champion = 10
            self:SetTempleStats(unit,scale,300,1500,20,2)
            unit:SetModelScale(1.2)
            unit:AddAbility("pve_aa_root"):SetLevel(1)

            --patrol
            unit = CreateUnitByName("temple_dragon_jakiro", c1+Vector(150,-400,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.chance_for_champion = 10
            unit.patrolling = zone
            self:SetTempleStats(unit,scale,275,1500,20,1)
            unit:SetModelScale(1.1)
            unit:AddAbility("pve_aa_root"):SetLevel(1)

            --camp 2
            unit = CreateUnitByName("temple_dragon_jakiro", c2l, true, nil, nil, DOTA_TEAM_BADGUYS )
            self:SetTempleStats(unit,scale,35,250,5,1)
            unit:AddAbility("pve_aa_root"):SetLevel(1)
            unit = CreateUnitByName("temple_dragon_jakiro", c2l+Vector(0,-100,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            self:SetTempleStats(unit,scale,35,250,5,0)
            unit:AddAbility("pve_aa_root"):SetLevel(1)
            unit = CreateUnitByName("temple_dragon_jakiro", c2l+Vector(0,-200,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            self:SetTempleStats(unit,scale,35,250,5,0)
            unit:AddAbility("pve_aa_root"):SetLevel(1)
            unit = CreateUnitByName("temple_dragon_jakiro", c2l+Vector(0,-300,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            self:SetTempleStats(unit,scale,35,250,5,0)
            unit:AddAbility("pve_aa_root"):SetLevel(1)
            unit = CreateUnitByName("temple_dragon_jakiro", c2r, true, nil, nil, DOTA_TEAM_BADGUYS )
            self:SetTempleStats(unit,scale,35,250,5,1)
            unit:AddAbility("pve_aa_root"):SetLevel(1)
            unit = CreateUnitByName("temple_dragon_jakiro", c2r+Vector(0,-100,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            self:SetTempleStats(unit,scale,35,250,5,0)
            unit:AddAbility("pve_aa_root"):SetLevel(1)
            unit = CreateUnitByName("temple_dragon_jakiro", c2r+Vector(0,-200,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            self:SetTempleStats(unit,scale,35,250,5,0)
            unit:AddAbility("pve_aa_root"):SetLevel(1)
            unit = CreateUnitByName("temple_dragon_jakiro", c2r+Vector(0,-300,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            self:SetTempleStats(unit,scale,35,250,5,0)
            unit:AddAbility("pve_aa_root"):SetLevel(1)

            --camp 3
            for i=1, horde_factor do
              unit = CreateUnitByName("temple_dragon_jakiro", c3+Vector(475,100,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              unit.chance_for_champion = 10
              unit:SetModelScale(1.1)
              unit:AddAbility("pve_aa_root"):SetLevel(1)
              self:SetTempleStats(unit,scale,125,1000,10,1)
              unit.loot_hoarder_on_death_chance = 25
              unit = CreateUnitByName("temple_dragon_melee", c3+Vector(475,-100,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              unit.chance_for_champion = 10
              --unit:SetModelScale(1.1)
              self:SetTempleStats(unit,scale,125,1000,10,1)
              unit:AddAbility("pve_aa_root"):SetLevel(1)
            end
            --traps
            unit = CreateUnitByName("temple_missile_trap", c3+Vector(150,1500,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.exp_factor = 5
            --unit.chance_for_champion = 10
            self:SetTempleStats(unit,scale,750,100,0,0)
            unit:SetForwardVector(Vector(0,-1,0))
            unit.trap_element = "ice"
            unit = CreateUnitByName("temple_missile_trap", c3+Vector(-50,1225,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.exp_factor = 5
            --unit.chance_for_champion = 10
            self:SetTempleStats(unit,scale,750,100,0,0)
            unit:SetForwardVector(Vector(-1,0,0))
            unit.trap_element = "ice"
            unit = CreateUnitByName("temple_missile_trap", c10+Vector(2800,-1000,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.exp_factor = 5
            --unit.chance_for_champion = 10
            self:SetTempleStats(unit,scale,750,100,0,0)
            unit:SetForwardVector(Vector(0,1,0))
            unit.trap_element = "ice"
            unit.trap_timer_set = 1.5
            
            for i=1, horde_factor do
              --camp 4
              unit = CreateUnitByName("temple_dragon_melee", c4, true, nil, nil, DOTA_TEAM_BADGUYS )
              --unit.chance_for_champion = 10
              SetSwarmOnDeath(unit, 10, 20, Vector(-2000,-2000,0), zone, nil, 3000, false)
              self:SetTempleStats(unit,scale,275,1850,20,3)
              --unit:SetModelScale(1.6)


              --camp 5
              unit = CreateUnitByName("temple_dragon_garg", c5+Vector(100,250,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              unit.chance_for_champion = 10
              self:SetTempleStats(unit,scale,400,450,10,1)
              unit:SetModelScale(1.4)
              unit = CreateUnitByName("temple_dragon_garg", c5+Vector(-100,250,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              unit.chance_for_champion = 10
              self:SetTempleStats(unit,scale,400,450,10,1)
              unit:SetModelScale(1.4)

              --camp 6
              unit = CreateUnitByName("temple_dragon_garg", c6+Vector(-3700,1875,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              self:SetTempleStats(unit,scale,200,250,7,1)
              unit = CreateUnitByName("temple_dragon_garg", c6+Vector(-3850,1800,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              self:SetTempleStats(unit,scale,200,250,7,1)
              unit = CreateUnitByName("temple_dragon_garg", c6+Vector(-3550,1800,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              self:SetTempleStats(unit,scale,200,250,7,1)

              --scale = 7.0

              --camp 8
              unit = CreateUnitByName("temple_dragon_garg2", c8, true, nil, nil, DOTA_TEAM_BADGUYS )
              unit.chance_for_champion = 20
              unit:SetModelScale(1.35)
              self:SetTempleStats(unit,scale,375,1250,20,3)
              unit.loot_hoarder_on_death_chance = 25

              --camp 7
              unit = CreateUnitByName("temple_dragon_garg2", c7, true, nil, nil, DOTA_TEAM_BADGUYS )
              unit.chance_for_champion = 10
              unit:SetModelScale(1.05)
              self:SetTempleStats(unit,scale,160,1250,10,1)
              unit = CreateUnitByName("temple_dragon_garg2", c7+Vector(150,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              unit.chance_for_champion = 10
              self:SetTempleStats(unit,scale,160,1250,10,1)
              unit:SetModelScale(1.05)

              --scale = 8.0

              --camp 9
              unit = CreateUnitByName("temple_dragon_garg2", c9+Vector(100,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              self:SetTempleStats(unit,scale,125,150,4,0)
              unit = CreateUnitByName("temple_dragon_garg2", c9+Vector(-100,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              self:SetTempleStats(unit,scale,125,150,4,0)
              unit = CreateUnitByName("temple_dragon_garg2", c9+Vector(50,50,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              self:SetTempleStats(unit,scale,125,150,4,2)
              unit = CreateUnitByName("temple_dragon_garg2", c9+Vector(-50,50,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              self:SetTempleStats(unit,scale,125,150,4,0)
              unit = CreateUnitByName("temple_dragon_melee", c9+Vector(0,-50,0), true, nil, nil, DOTA_TEAM_BADGUYS )
              self:SetTempleStats(unit,scale,125,750,4,0)

              --camp 10
              unit = CreateUnitByName("temple_dragon_garg2", c10, true, nil, nil, DOTA_TEAM_BADGUYS )
              unit.chance_for_champion = 10
              unit:SetModelScale(1.45)
              self:SetTempleStats(unit,scale,400,950,20,3)
            end
            --scale = 6.0

            --boss 1
            unit = CreateUnitByName("temple_dragon_boss_1", b1, true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.act = zone
            self:SetTempleStats(unit,scale,200,20000,100,0)
            unit.templeboss_dragon = 1
            unit:SetForwardVector(Vector(0,-1,0))

            --scale = 7.0

            --boss 2
            unit = CreateUnitByName("temple_dragon_boss_2", b2+Vector(300,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.act = zone
            self:SetTempleStats(unit,scale,150,27500,100,0)
            unit.templeboss_dragon = 1
            unit:SetForwardVector(Vector(1,1,0))

            --scale = 8.0

            --boss 3
            unit = CreateUnitByName("temple_dragon_boss_3", b3, true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.act = zone
            SetSwarmOnDeath(unit, 15, 25, Vector(-3000,0,0), zone, nil, nil, false)
            self:SetTempleStats(unit,scale,175,22500,100,0)
            unit.templeboss_dragon = 1
            unit.templeboss_fire = 1

            --boss 7
            unit = CreateUnitByName("temple_dragon_boss_7", b7, true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.act = zone
            self:SetTempleStats(unit,scale,200,20000,100,0)
            unit.templeboss_dragon = 1
            unit:SetForwardVector(Vector(0,1,0))
            

            --boss 4
            unit = CreateUnitByName("temple_dragon_boss_4_depressive", b4, true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.canleavespawnpos = true
            unit.act = zone
            self:SetTempleStats(unit,scale,150,17500,100,0)
            unit.templeboss_dragon = 1
            unit.templeboss_t1setquest = 1
            unit:SetForwardVector(Vector(0,-1,0))
            unit.act_specific_loot_factor = 3
            local dc1 = unit
            unit = CreateUnitByName("temple_dragon_boss_4_angry", b4+Vector(-250,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.canleavespawnpos = true
            unit.act = zone
            self:SetTempleStats(unit,scale,100,15000,100,0)
            unit.templeboss_dragon = 1
            unit.templeboss_t1setquest = 1
            unit:SetForwardVector(Vector(0,-1,0))
            local dc2 = unit
            unit = CreateUnitByName("temple_dragon_boss_4_supportive", b4+Vector(250,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.canleavespawnpos = true
            unit.act = zone
            self:SetTempleStats(unit,scale,100,15000,100,0)
            unit.templeboss_dragon = 1
            unit.templeboss_t1setquest = 1
            unit.dragoncouncil1 = dc1
            unit.dragoncouncil2 = dc2
            unit:SetForwardVector(Vector(0,-1,0))

            --boss 5
            local random_pos = c6+Vector(750,475,100)
            math.randomseed(Time())
            local v1 = math.random(1,1000)
            --print("roll " .. v1)
            if v1 <= 333 then
             random_pos = c6+Vector(-400,2670,100)
           elseif v1 <= 667 then
            random_pos = c6+Vector(-3200,2670,100)
          end
          unit = CreateUnitByName("temple_dragon_egg_2", random_pos, true, nil, nil, DOTA_TEAM_BADGUYS )
          self:SetTempleStats(unit,scale,0,1000,0,0)
          unit:SetModelScale(1.25)
          unit:AddAbility("pve_temple_dragon_hatch_2"):SetLevel(1)
          unit:SetRenderColor(25, 25, 25)
        end


        if zone == 6 then
          --                                                                   AVERAGE GOOD STATS ARE 200 dmg and 2000 life
          --scale = 12.5
          --scale = scale * (1 + 0.1 * (zone-1))
          local c1 = Entities:FindByName( nil, "camp38" ):GetAbsOrigin()
          local c2 = Entities:FindByName( nil, "camp39" ):GetAbsOrigin()+Vector(50,0,0)
          local c3 = Entities:FindByName( nil, "camp40" ):GetAbsOrigin()
          local c4 = Entities:FindByName( nil, "camp41" ):GetAbsOrigin()
          local c5 = Entities:FindByName( nil, "camp42" ):GetAbsOrigin()
          local c6 = Entities:FindByName( nil, "camp43" ):GetAbsOrigin()
          local c7 = Entities:FindByName( nil, "camp44" ):GetAbsOrigin()
          local c8 = Entities:FindByName( nil, "camp45" ):GetAbsOrigin()
          local c9 = Entities:FindByName( nil, "camp46" ):GetAbsOrigin()
          local b1 = Entities:FindByName( nil, "boss20" ):GetAbsOrigin()
          local b2 = Entities:FindByName( nil, "boss21" ):GetAbsOrigin()
          local b3 = Entities:FindByName( nil, "boss22" ):GetAbsOrigin()
          local b4 = Entities:FindByName( nil, "boss23" ):GetAbsOrigin()
          local b5 = Entities:FindByName( nil, "boss24" ):GetAbsOrigin()

          local unit

          local deadwingPos = c5+Vector(0,250,0)
          if math.random(1,100) <= 33 then
            deadwingPos = c7+Vector(0,150,0)
          elseif math.random(1,100) <= 50 then
            deadwingPos = c9+Vector(0,150,0)
          end
          unit = CreateUnitByName("extra_act6", deadwingPos, true, nil, nil, DOTA_TEAM_BADGUYS )
          unit.chance_for_champion = 100
          unit.exp_factor = 2
          unit:AddAbility("pve_temple_ambush"):SetLevel(1)
          self:SetTempleStats(unit,scale,135,2500,20,2)

          for i=1, horde_factor do
            --camp 1   
            unit = CreateUnitByName("temple_mount_fireele", c1, true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.chance_for_champion = 10
            self:SetTempleStats(unit,scale,300,1500,20,3)

            --camp 2
            unit = CreateUnitByName("temple_mount_archer", c2+Vector(100,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.chance_for_champion = 10
            self:SetTempleStats(unit,scale,40,250,5,1)
            unit = CreateUnitByName("temple_mount_archer", c2+Vector(75,-100,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            self:SetTempleStats(unit,scale,40,250,5,0)
            unit = CreateUnitByName("temple_mount_archer", c2+Vector(50,-200,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            self:SetTempleStats(unit,scale,40,250,5,0)
            unit = CreateUnitByName("temple_mount_archer", c2+Vector(25,-300,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            self:SetTempleStats(unit,scale,40,250,5,1)
            unit = CreateUnitByName("temple_mount_archer", c2+Vector(0,-400,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            self:SetTempleStats(unit,scale,40,250,5,1)
            unit = CreateUnitByName("temple_mount_archer", c2+Vector(125,100,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            self:SetTempleStats(unit,scale,40,250,5,0)
            unit = CreateUnitByName("temple_mount_archer", c2+Vector(150,200,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            self:SetTempleStats(unit,scale,40,250,5,0)
            unit = CreateUnitByName("temple_mount_archer", c2+Vector(175,300,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            self:SetTempleStats(unit,scale,40,250,5,1)

            --scale = 15

            --camp 3
            unit = CreateUnitByName("temple_mount_fireele", c3, true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.chance_for_champion = 10
            self:SetTempleStats(unit,scale,60,1000,10,1)
            unit = CreateUnitByName("temple_mount_archer", c3+Vector(100,150,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.chance_for_champion = 10
            self:SetTempleStats(unit,scale,90,750,5,1)
            unit = CreateUnitByName("temple_mount_archer", c3+Vector(100,-150,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.chance_for_champion = 10
            self:SetTempleStats(unit,scale,90,750,5,1)

            --traps
            unit = CreateUnitByName("temple_missile_trap", c3+Vector(-300,600,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.exp_factor = 5
            --unit.chance_for_champion = 10
            self:SetTempleStats(unit,scale,750,100,0,0)
            unit:SetForwardVector(Vector(0,1,0))
            unit.trap_element = "fire"
            unit.random_new_direction = true

            --patrol
            unit = CreateUnitByName("temple_mount_archer", b1+Vector(100,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.chance_for_champion = 10
            unit.patrolling = zone
            self:SetTempleStats(unit,scale,125,350,7,1)
            unit = CreateUnitByName("temple_mount_archer", b1+Vector(150,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.patrolling = zone
            self:SetTempleStats(unit,scale,125,350,7,1)
            unit = CreateUnitByName("temple_mount_archer", b1+Vector(200,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.patrolling = zone
            self:SetTempleStats(unit,scale,125,350,7,1)
            
            --scale = 17.5

            --camp 4
            unit = CreateUnitByName("temple_mount_tree", c4, true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.chance_for_champion = 10
            self:SetTempleStats(unit,scale,400,1500,20,2)
            unit:SetModelScale(1.6)

            --camp 4_2
            local tab = {}
            tab.Duration = -1
            unit = CreateUnitByName("temple_mount_tree", c4+Vector(-100,1500,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            self:SetTempleStats(unit,scale,100,500,5,0)
            unit:SetModelScale(1.0)
            unit:FindAbilityByName("pveboss_system"):ApplyDataDrivenModifier(unit, unit, "modifier_invisible", tab)
            unit = CreateUnitByName("temple_mount_tree", c4+Vector(-100,1500,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            self:SetTempleStats(unit,scale,100,500,5,0)
            unit:SetModelScale(1.0)
            unit:FindAbilityByName("pveboss_system"):ApplyDataDrivenModifier(unit, unit, "modifier_invisible", tab)
            unit = CreateUnitByName("temple_mount_tree", c4+Vector(-100,1500,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            self:SetTempleStats(unit,scale,100,500,5,0)
            unit:SetModelScale(1.0)
            unit:FindAbilityByName("pveboss_system"):ApplyDataDrivenModifier(unit, unit, "modifier_invisible", tab)
            unit = CreateUnitByName("temple_mount_tree", c4+Vector(-100,1500,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            self:SetTempleStats(unit,scale,100,500,5,0)
            unit:SetModelScale(1.0)
            unit:FindAbilityByName("pveboss_system"):ApplyDataDrivenModifier(unit, unit, "modifier_invisible", tab)
            unit = CreateUnitByName("temple_mount_tree", c4+Vector(-100,1500,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            self:SetTempleStats(unit,scale,100,500,5,0)
            unit:SetModelScale(1.0)
            unit:FindAbilityByName("pveboss_system"):ApplyDataDrivenModifier(unit, unit, "modifier_invisible", tab)


            --camp 5
            unit = CreateUnitByName("temple_mount_tree", c5+Vector(100,250,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.chance_for_champion = 10
            self:SetTempleStats(unit,scale,400,700,10,1)
            unit:SetModelScale(1.4)
            unit = CreateUnitByName("temple_mount_tree", c5+Vector(-100,250,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.chance_for_champion = 10
            self:SetTempleStats(unit,scale,400,700,10,1)
            unit:SetModelScale(1.4)

            --scale = 20

            --camp 6
            unit = CreateUnitByName("temple_mount_plant", c6+Vector(75,100,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            self:SetTempleStats(unit,scale,200,250,7,1)
            unit = CreateUnitByName("temple_mount_plant", c6+Vector(75,-100,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            self:SetTempleStats(unit,scale,200,250,7,1)
            unit = CreateUnitByName("temple_mount_plant", c6, true, nil, nil, DOTA_TEAM_BADGUYS )
            self:SetTempleStats(unit,scale,200,250,7,1)

            --camp 7
            unit = CreateUnitByName("temple_mount_plant", c7, true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.chance_for_champion = 10
            unit:SetModelScale(1.05)
            self:SetTempleStats(unit,scale,250,750,10,2)
            unit = CreateUnitByName("temple_mount_plant", c7+Vector(150,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            --unit.chance_for_champion = 10
            SetSwarmOnDeath(unit, 3, 10, nil, zone, nil, nil, false, {Entities:FindByName( nil, "boss22" ):GetAbsOrigin(),Entities:FindByName( nil, "boss24" ):GetAbsOrigin(),Entities:FindByName( nil, "boss21" ):GetAbsOrigin()})
            self:SetTempleStats(unit,scale,250,750,10,2)
            unit:SetModelScale(1.05)

            --scale = 22.5

            --camp 8
            unit = CreateUnitByName("temple_mount_wisp", c8, true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.chance_for_champion = 20
            unit:SetModelScale(1.35)
            self:SetTempleStats(unit,scale,325,1250,20,4)

            --camp 9
            unit = CreateUnitByName("temple_mount_wisp", c9+Vector(100,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            self:SetTempleStats(unit,scale,120,150,4,1)
            unit = CreateUnitByName("temple_mount_wisp", c9+Vector(-100,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            self:SetTempleStats(unit,scale,120,150,4,1)
            unit = CreateUnitByName("temple_mount_wisp", c9+Vector(50,50,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            self:SetTempleStats(unit,scale,120,150,4,1)
            unit = CreateUnitByName("temple_mount_wisp", c9+Vector(-50,50,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            self:SetTempleStats(unit,scale,120,150,4,1)
            unit = CreateUnitByName("temple_mount_wisp", c9+Vector(0,-50,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            self:SetTempleStats(unit,scale,120,150,4,1)
          end
          --scale = 12.5

          --boss 1
          unit = CreateUnitByName("temple_mount_boss_1", b1, true, nil, nil, DOTA_TEAM_BADGUYS )
          unit.act = zone
          SetSwarmOnDeath(unit, 3, 10, Vector(3000,0,0), zone, nil, nil, false)
          self:SetTempleStats(unit,scale,200,20000,100,0)
          unit.templeboss_mount = 1
          unit.loot_hoarder_on_death_chance = 25
          unit:SetForwardVector(Vector(0,1,0))

          --scale = 15

          --boss 2
          unit = CreateUnitByName("temple_mount_boss_2", b2, true, nil, nil, DOTA_TEAM_BADGUYS )
          unit.act = zone
          self:SetTempleStats(unit,scale,200,20000,100,0)
          unit.templeboss_mount = 1

          --scale = 17.5

          --boss 3
          unit = CreateUnitByName("temple_mount_boss_3", b3, true, nil, nil, DOTA_TEAM_BADGUYS )
          unit.act = zone
          self:SetTempleStats(unit,scale,160,25000,100,0)
          unit.templeboss_mount = 1
          unit.loot_hoarder_on_death_chance = 25
          unit:SetForwardVector(Vector(1,0,0))

          --scale = 20

          --boss 4
          unit = CreateUnitByName("temple_mount_boss_4", b4, true, nil, nil, DOTA_TEAM_BADGUYS )
          unit.act = zone
          self:SetTempleStats(unit,scale,175,22500,100,0)
          unit.templeboss_mount = 1

          --scale = 22.5

          --boss 5
          unit = CreateUnitByName("temple_mount_boss_5", b5, true, nil, nil, DOTA_TEAM_BADGUYS )
          unit.act = zone
          self:SetTempleStats(unit,scale,175,22500,100,0)
          unit.templeboss_mount = 1
          unit:SetForwardVector(Vector(0,-1,0))
          unit:AddAbility("burningtreeevent"):SetLevel(1)

          --boss 6 event, first event, then boss
          end
          self.current_act_populated = nil
          self.act_affix_roll = nil
        end

        function COverthrowGameMode:SpawnDragonEggs()
         --egg event
         if self.act5_dragon_eggs_spawned then
          return
        end
        self.act5_dragon_eggs_spawned = true
        Notifications:BottomToAll({text="Nabu: Dragon Eggs have been sighted in Dragonsky! Destroy them before they become too powerful!", duration=12, style={color="white"}})
        local scale = self.jungledifficulty * 1.5
        local event = Entities:FindByName( nil, "eggevent" ):GetAbsOrigin()+Vector(0,-200,0)
        local unit = CreateUnitByName("temple_dragon_egg", event+Vector(175,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
        self:SetTempleStats(unit,scale,0,250,0,0)
        unit:SetModelScale(1.1)
        unit:AddAbility("pve_temple_dragon_hatch"):SetLevel(1)
        unit = CreateUnitByName("temple_dragon_egg", event+Vector(-175,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
        self:SetTempleStats(unit,scale,0,250,0,0)
        unit:SetModelScale(1.1)
        unit:AddAbility("pve_temple_dragon_hatch"):SetLevel(1)
        unit = CreateUnitByName("temple_dragon_egg", event+Vector(0,175,0), true, nil, nil, DOTA_TEAM_BADGUYS )
        self:SetTempleStats(unit,scale,0,250,0,0)
        unit:SetModelScale(1.1)
        unit:AddAbility("pve_temple_dragon_hatch"):SetLevel(1)
        unit = CreateUnitByName("temple_dragon_egg", event+Vector(-90,-150,0), true, nil, nil, DOTA_TEAM_BADGUYS )
        self:SetTempleStats(unit,scale,0,250,0,0)
        unit:SetModelScale(1.1)
        unit:AddAbility("pve_temple_dragon_hatch"):SetLevel(1)
        unit = CreateUnitByName("temple_dragon_egg", event+Vector(90,-150,0), true, nil, nil, DOTA_TEAM_BADGUYS )
        self:SetTempleStats(unit,scale,0,250,0,0)
        unit:SetModelScale(1.1)
        unit:AddAbility("pve_temple_dragon_hatch"):SetLevel(1)
      end

      function FishEvent(event)
        local eventpos = event.caster:GetAbsOrigin()
        local scale = COverthrowGameMode.jungledifficulty*1.2
        for i=1, 35 do
         --print("here " .. tostring(i))
         Timers:CreateTimer(i*0.75,function() 
          --print("here inside " .. tostring(i))
          --print(eventpos)

          local offset = RandomVector(1):Normalized()*math.random(150,900)
          local unit = CreateUnitByName("temple_fungal_slardar", eventpos+offset, true, nil, nil, DOTA_TEAM_BADGUYS )
          if i == 35 then
            unit:AddAbility("icehowl_6")
            COverthrowGameMode:SetTempleStats(unit,scale,150,25000,100,3)
            unit:SetModelScale(1.8)
            unit.act = 3
            unit.templeboss_wetlands = true
          else
            unit.noexp = 1
            COverthrowGameMode:SetTempleStats(unit,scale,35,150,1,0)
            unit:SetModelScale(0.9)
          end
          local tab = {}
          tab.Duration = 0.1
          local ab = unit:FindAbilityByName("pveboss_system")
          ab:ApplyDataDrivenModifier(unit, unit, "modifier_phased", tab)
          local particle = ParticleManager:CreateParticle("particles/econ/items/tidehunter/tidehunter_divinghelmet/tidehunter_gush_splash_diving_helmet.vpcf", PATTACH_POINT_FOLLOW, unit)
          ParticleManager:SetParticleControl(particle, 3, unit:GetAbsOrigin())
          ParticleManager:ReleaseParticleIndex(particle)
          local myevent = {}
          myevent.amount = 25
          myevent.target = unit
          PVEAggroAddRandomHero(event)
        end)
       end
     end

     function RaptorHatchEvent(event)
      local eventpos = event.caster:GetAbsOrigin()
      local scale = COverthrowGameMode.jungledifficulty*2.2
      local unit = CreateUnitByName("temple_jungle_lizard", eventpos, true, nil, nil, DOTA_TEAM_BADGUYS )
      unit.canleavespawnpos = true
      COverthrowGameMode:SetTempleStats(unit,scale,150,15000,100,0)
      unit.act = 12
      unit.boss_in_act = 1
      local tab = {}
      tab.Duration = 0.1
      local ab = unit:FindAbilityByName("pveboss_system")
      ab:ApplyDataDrivenModifier(unit, unit, "modifier_phased", tab)
      local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_ursa/ursa_earthshock.vpcf", PATTACH_POINT_FOLLOW, unit)
      ParticleManager:ReleaseParticleIndex(particle)
      local myevent = {}
      myevent.amount = 25
      myevent.target = unit
      PVEAggroAddRandomHero(event)
      EmitSoundOn("Hero_Lina.DragonSlave", unit)
    end

    function RaptorEvent(event)
      local eventpos = Entities:FindByName( nil, "act12_1" ):GetAbsOrigin() --event.caster:GetAbsOrigin() + Vector(-300, 300,0)
      local scale = COverthrowGameMode.jungledifficulty*2.2
      for i=1, 1 do
        --print("here " .. tostring(i))
        Timers:CreateTimer(1.0,function() 
          --print("here inside " .. tostring(i))
          --print(eventpos)

          --local offset = RandomVector(1):Normalized()*math.random(150,900)
          local unit = CreateUnitByName("temple_jungle_boss_0", eventpos, true, nil, nil, DOTA_TEAM_BADGUYS )
          unit.canleavespawnpos = true
          COverthrowGameMode:SetTempleStats(unit,scale,250,15000,100,2)
          unit.act = 12
          unit.boss_in_act = 1
          local tab = {}
          tab.Duration = 0.1
          local ab = unit:FindAbilityByName("pveboss_system")
          ab:ApplyDataDrivenModifier(unit, unit, "modifier_phased", tab)
          ab:ApplyDataDrivenModifier(unit, unit, "modifier_silence", {Duration = 5})
          local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_ursa/ursa_earthshock.vpcf", PATTACH_POINT_FOLLOW, unit)
          ParticleManager:ReleaseParticleIndex(particle)
          local myevent = {}
          myevent.amount = 25
          myevent.target = unit
          PVEAggroAddRandomHero(event)
          EmitSoundOn("Hero_Lina.DragonSlave", unit)
        end)
      end
    end

    function VolcanoEvent1(event)
     if event.caster and not event.caster.templeboss_volcano then
      return
    end
    if COverthrowGameMode.volcano_event_1_triggered then
      return
    end
    COverthrowGameMode.volcano_event_1_triggered = true
    local scale = COverthrowGameMode.jungledifficulty*1.8
    local pos = {}
    pos[0] = Entities:FindByName( nil, "volcano3" ):GetAbsOrigin()
    pos[1] = Entities:FindByName( nil, "volcano2" ):GetAbsOrigin()+Vector(-1000, -800,0)
    pos[2] = Entities:FindByName( nil, "volcano4" ):GetAbsOrigin()
    pos[3] = Entities:FindByName( nil, "volcano5" ):GetAbsOrigin()
    pos[4] = Entities:FindByName( nil, "volcano1" ):GetAbsOrigin()
    pos[5] = Entities:FindByName( nil, "volcano2" ):GetAbsOrigin()

    --first fast spawn
    local unit
    local particle
    local tab
    local ab
    for i=1,2 do
      unit = CreateUnitByName("temple_volcano_fireborn", pos[4]+Vector(-1050+i*700, 0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
      unit:AddAbility("pve_trap_twin_dragons"):SetLevel(1)
      unit:AddAbility("pve_event_volcano2")
      unit.bosslikescaling = true
      unit.noinvisaffix = true
      unit.act = 8
      unit.can_have_affixes = true
      COverthrowGameMode:SetTempleStats(unit,scale,75,2500,0,0)
      unit:SetModelScale(1.0)
      particle = ParticleManager:CreateParticle("particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_shadowraze.vpcf", PATTACH_POINT_FOLLOW, unit)
      ParticleManager:SetParticleControl(particle, 3, unit:GetAbsOrigin())
      ParticleManager:ReleaseParticleIndex(particle)
      tab = {}
      tab.Duration = 0.1
      ab = unit:FindAbilityByName("pveboss_system")
      ab:ApplyDataDrivenModifier(unit, unit, "modifier_phased", tab)
      tab.Duration = 5
      if i == 2 then
        ab:ApplyDataDrivenModifier(unit, unit, "modifier_stunned", tab)
      else
        tab.Duration = 60
        ab:ApplyDataDrivenModifier(unit, unit, "modifier_bane_nightmare", tab)
      end
    end

    for i=1, 35 do
      --print("here " .. tostring(i))
      local extra = 0
      if i == 35 then
       extra = 15
     end
     Timers:CreateTimer(i*1.25+extra,function() 
      --print("here inside " .. tostring(i))
      --print(eventpos)
      local offset = RandomVector(1):Normalized()*50
      local spawn_pos = pos[i%6]+offset
      if math.random(1,100) <= 66 then
        spawn_pos = pos[1]+offset
      end
      --local unit
      if i == 35 then
        unit = CreateUnitByName("temple_volcano_fireborn", spawn_pos, true, nil, nil, DOTA_TEAM_BADGUYS )
        unit:AddAbility("pve_event_volcano2")
        unit:AddAbility("pve_temple_fire_bolt"):SetLevel(1)
        unit.bosslikescaling = true
        unit.noinvisaffix = true
        unit.act = 8
        unit.can_have_affixes = true
        COverthrowGameMode:SetTempleStats(unit,scale,100,20000,0,4)
        unit:SetModelScale(1.0)
      else
        unit = CreateUnitByName("npc_dota_creature_imp_volcano", spawn_pos, true, nil, nil, DOTA_TEAM_BADGUYS )
        unit.noexp = 1
        unit.act = 8
        unit.noinvisaffix = true
        if math.random(1,100) <= 20 then
          unit:AddAbility("pve_temple_meteor_low"):SetLevel(1)
        end
        COverthrowGameMode:SetTempleStats(unit,scale,25+i*2,350,0,0)
        unit:SetModelScale(0.9)
      end
      tab = {}
      tab.Duration = 0.1
      ab = unit:FindAbilityByName("pveboss_system")
      ab:ApplyDataDrivenModifier(unit, unit, "modifier_phased", tab)
      particle = ParticleManager:CreateParticle("particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_shadowraze.vpcf", PATTACH_POINT_FOLLOW, unit)
      ParticleManager:SetParticleControl(particle, 3, unit:GetAbsOrigin())
      ParticleManager:ReleaseParticleIndex(particle)
      --order
      AttackRandomHero(unit)
    end)
   end
 end

 function VolcanoEvent2(event)
  if COverthrowGameMode.a8_cursed_flames_killed then
    COverthrowGameMode.a8_cursed_flames_killed = COverthrowGameMode.a8_cursed_flames_killed + 1
    if not (COverthrowGameMode.a8_cursed_flames_killed == 3) then
      return
    end
  else
    COverthrowGameMode.a8_cursed_flames_killed = 1
    return
  end
  if COverthrowGameMode.volcano_event_2_triggered then
    return
  end
  COverthrowGameMode.volcano_event_2_triggered = true
  local pos = {}
  pos[0] = Entities:FindByName( nil, "volcano2" ):GetAbsOrigin()
  pos[1] = Entities:FindByName( nil, "volcano2" ):GetAbsOrigin()+Vector(-1000, -800,0)
  pos[2] = Entities:FindByName( nil, "volcano3" ):GetAbsOrigin()
  pos[3] = Entities:FindByName( nil, "volcano4" ):GetAbsOrigin()
  pos[4] = Entities:FindByName( nil, "volcano1" ):GetAbsOrigin()
  local scale = COverthrowGameMode.jungledifficulty*1.8
  for i=1, 4 do
    --print("here " .. tostring(i))
    local extra = 0
    local delay = 10
    if i >= 3 then
     extra = 20
   end
   Timers:CreateTimer(delay+0*i+extra,function() 
    --print("here inside " .. tostring(i))
    --print(eventpos)
    local offset = RandomVector(1):Normalized()*50
    local unit
    unit = CreateUnitByName("temple_volcano_flameborn", pos[i%4]+offset, true, nil, nil, DOTA_TEAM_BADGUYS )
    unit.noinvisaffix = true
    unit.act = 8
    unit.can_have_affixes = true
    unit:AddAbility("pve_stunaoe_fire"):SetLevel(1)
    unit:AddAbility("pve_as_aura"):SetLevel(1)
    if i >= 3 then
      unit:AddAbility("pve_event_volcano3")
      COverthrowGameMode:SetTempleStats(unit,scale,200,10000,0,1)
      unit:SetModelScale(0.9)
    else
      unit:AddAbility("pve_event_volcano3")
      COverthrowGameMode:SetTempleStats(unit,scale,150,7500,0,1)
      unit:SetModelScale(0.75)
    end
    local tab = {}
    tab.Duration = 0.1
    local ab = unit:FindAbilityByName("pveboss_system")
    ab:ApplyDataDrivenModifier(unit, unit, "modifier_phased", tab)
    local particle = ParticleManager:CreateParticle("particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_shadowraze.vpcf", PATTACH_POINT_FOLLOW, unit)
    ParticleManager:SetParticleControl(particle, 3, unit:GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(particle)
    --order
    AttackRandomHero(unit)
  end)
 end
end

function VolcanoEvent3(event)
	if COverthrowGameMode.volcano_golems_killed then
		COverthrowGameMode.volcano_golems_killed = COverthrowGameMode.volcano_golems_killed + 1
		if not (COverthrowGameMode.volcano_golems_killed == 4) then
			return
		end
	else
		COverthrowGameMode.volcano_golems_killed = 1
		return
	end
  if COverthrowGameMode.volcano_event_3_triggered then
    return
  end
  COverthrowGameMode.volcano_event_3_triggered = true
  local pos = {}
  pos[0] = Entities:FindByName( nil, "volcano2" ):GetAbsOrigin()
  pos[1] = Entities:FindByName( nil, "volcano3" ):GetAbsOrigin()
  pos[2] = Entities:FindByName( nil, "volcano4" ):GetAbsOrigin()
  pos[3] = Entities:FindByName( nil, "volcano5" ):GetAbsOrigin()
  pos[4] = Entities:FindByName( nil, "volcano1" ):GetAbsOrigin()
  local scale = COverthrowGameMode.jungledifficulty*1.8
  for i=1, 1 do
    --print("here " .. tostring(i))
    Timers:CreateTimer(i*0.9,function() 
      --print("here inside " .. tostring(i))
      --print(eventpos)
      local offset = RandomVector(1):Normalized()*50
      local unit
      unit = CreateUnitByName("temple_volcano_boss_2", pos[4]+offset, true, nil, nil, DOTA_TEAM_BADGUYS )
      unit.bosslikescaling = true
      unit.act = 8
      unit:AddAbility("pve_event_volcano4")
      unit.noinvisaffix = true
      unit.isboss = true
      COverthrowGameMode:SetTempleStats(unit,scale,150,25000,0,0)
      --unit:SetModelScale(0.9)
      local tab = {}
      tab.Duration = 0.1
      local ab = unit:FindAbilityByName("pveboss_system")
      ab:ApplyDataDrivenModifier(unit, unit, "modifier_phased", tab)
      local particle = ParticleManager:CreateParticle("particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_shadowraze.vpcf", PATTACH_POINT_FOLLOW, unit)
      ParticleManager:SetParticleControl(particle, 3, unit:GetAbsOrigin())
      ParticleManager:ReleaseParticleIndex(particle)
      --order
      Timers:CreateTimer(0.25,function() 
        local order = 
        {
         UnitIndex = unit:entindex(),
         OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
         Position = pos[4], 
         Queue = false
       }
       ExecuteOrderFromTable(order)
     end)
    end)
  end
end

function VolcanoEvent4(event)
  if COverthrowGameMode.volcano_event_4_triggered then
    return
  end
  COverthrowGameMode.volcano_event_4_triggered = true
  local pos = {}
  pos[0] = Entities:FindByName( nil, "volcano2" ):GetAbsOrigin()
  pos[1] = Entities:FindByName( nil, "volcano3" ):GetAbsOrigin()
  pos[2] = Entities:FindByName( nil, "volcano4" ):GetAbsOrigin()
  pos[3] = Entities:FindByName( nil, "volcano5" ):GetAbsOrigin()
  pos[4] = Entities:FindByName( nil, "volcano1" ):GetAbsOrigin()
  local scale = COverthrowGameMode.jungledifficulty*1.8
  for i=1, 6 do
    --print("here " .. tostring(i))
    Timers:CreateTimer(i*12-9,function() 
      --print("here inside " .. tostring(i))
      --print(eventpos)
      local offset = RandomVector(1):Normalized()*50
      local unit
      unit = CreateUnitByName("npc_dota_creature_demon_volcano", pos[i%4]+offset, true, nil, nil, DOTA_TEAM_BADGUYS )
      if i % 4 == 1 then
        unit:AddAbility("pve_temple_affix_armor_melt"):SetLevel(1)
      end
      if i % 4 == 2 then
        unit:AddAbility("pve_temple_iceberg_linear2"):SetLevel(1)
      end
      if i % 4 == 3 then
        unit:AddAbility("pve_temple_affix_immolation"):SetLevel(1)
      end
      if i % 4 == 0 then
        unit:AddAbility("pve_temple_fireball_ritual_hard_1"):SetLevel(1)
      end
      unit:AddAbility("pve_affix_fireball_aoe"):SetLevel(1)
      unit.act = 8
      unit.noinvisaffix = true
      unit.templeboss_volcano = true
      --if i == 5 or i == 6 then
        unit.ischallengeboss = 1
        unit.bosslikescaling = true
        --end
        COverthrowGameMode:SetTempleStats(unit,scale,100+i*35,2500,100,0)
        unit:SetModelScale(1.3)
        local tab = {}
        tab.Duration = 0.1
        local ab = unit:FindAbilityByName("pveboss_system")
        ab:ApplyDataDrivenModifier(unit, unit, "modifier_phased", tab)
        local particle = ParticleManager:CreateParticle("particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_shadowraze.vpcf", PATTACH_POINT_FOLLOW, unit)
        ParticleManager:SetParticleControl(particle, 3, unit:GetAbsOrigin())
        ParticleManager:ReleaseParticleIndex(particle)
        if i == 6 then
          unit.act_specific_loot_factor = 3
          unit.quest_trigger_class = "Volcanic Invasion"
        end
        --order
        AttackRandomHero(unit)
      end)
  end
end

function BurningTreeEvent(event)
	local eventpos = Entities:FindByName( nil, "boss22" ):GetAbsOrigin()
	local bosstargetpos = Entities:FindByName( nil, "boss23" ):GetAbsOrigin()
	local targetpos = Entities:FindByName( nil, "boss24" ):GetAbsOrigin()
	local scale = COverthrowGameMode.jungledifficulty*1.6
	for i=1, 62 do
		--print("here " .. tostring(i))
		local extra = 0.0
		if i >= 58 then
			extra = (i-57)*6
		end
   Timers:CreateTimer(i*0.75+extra,function() 
    --print("here inside " .. tostring(i))
    --print(eventpos)
    --local offset = RandomVector(1):Normalized()*750
    if i == 5 then
     Notifications:BottomToAll({text="An Invasion on Highmountain has started! Take care!", duration=6, style={color="orange"}})
   end
   local unitname = "temple_mount_fireele"
   local roll = math.random(1,3)
   if roll == 1 then
     unitname = "temple_mount_inferno"
   elseif roll == 2 then
     unitname = "temple_mount_archer"
   end
   if i == 1 then
    unitname = "temple_volcano_fireborn"
  end
  local unit = CreateUnitByName(unitname, bosstargetpos+Vector(math.random(1,200),math.random(1,200),0), true, nil, nil, DOTA_TEAM_BADGUYS )
  unit.noexp = 1
  if i < 58 then
    if i == 1 or i == 28 then
      unit.setChampionAffixCount = 1
      if roll == 3 then
       COverthrowGameMode:SetTempleStats(unit,scale,(15+i/5)*4,(150+i)*25,2,0)
     elseif roll == 2 then
       COverthrowGameMode:SetTempleStats(unit,scale,(40+i/5)*4,(50+i)*25,2,0)
     else
       COverthrowGameMode:SetTempleStats(unit,scale,(25+i/5)*4,(100+i)*25,2,0)
     end
   else
    if roll == 3 then
      COverthrowGameMode:SetTempleStats(unit,scale,15+i/5,150+i,2,0)
    elseif roll == 2 then
      COverthrowGameMode:SetTempleStats(unit,scale,40+i/5,50+i,2,0)
    else
      COverthrowGameMode:SetTempleStats(unit,scale,25+i/5,100+i,2,0)
    end
  end
end
--unit:SetModelScale(0.9)
local particle = ParticleManager:CreateParticle("particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_shadowraze.vpcf", PATTACH_POINT_FOLLOW, unit)
ParticleManager:ReleaseParticleIndex(particle)
--ParticleManager:SetParticleControl(particle, 3, unit:GetAbsOrigin())
local orderpos = targetpos
if i >= 58 then
  unit.canleavespawnpos = true
  if roll == 3 then
   COverthrowGameMode:SetTempleStats(unit,scale,100,9000,100,2)
   unit:SetModelScale(1.3)
 elseif roll == 2 then
   COverthrowGameMode:SetTempleStats(unit,scale,150,6000,100,2)
   unit:SetModelScale(1.3)
 else
   COverthrowGameMode:SetTempleStats(unit,scale,125,7500,100,2)
   unit:SetModelScale(1.1)
 end
 unit.act = 6
 unit.templeboss_mount = 1
 orderpos = bosstargetpos
end
local tab = {}
tab.Duration = 3
local ab = unit:FindAbilityByName("pveboss_system")
ab:ApplyDataDrivenModifier(unit, unit, "modifier_phased", tab)
Timers:CreateTimer(0.25,function() 
  local order = 
  {
    UnitIndex = unit:entindex(),
    OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
    Position = targetpos,
    Queue = false
  }
  ExecuteOrderFromTable(order)
end)
end)
 end
 Timers:CreateTimer(90,function()
   Notifications:BottomToAll({text="Lucil the Forbidden Flame has spawned at the pinacle of Highmountain!", duration=6, style={color="orange"}})
   local unitname = "temple_mount_boss_6"
   local unit = CreateUnitByName(unitname, targetpos, true, nil, nil, DOTA_TEAM_BADGUYS )
   unit.act_specific_loot_factor = 3
   unit.act = 6
   COverthrowGameMode:SetTempleStats(unit,scale,250,20000,100,0)
   unit.templeboss_mount = 1
   unit.flameshieldunlock = true
   --unit:SetModelScale(0.9)
   local tab = {}
   tab.Duration = 0.1
   local ab = unit:FindAbilityByName("pveboss_system")
   ab:ApplyDataDrivenModifier(unit, unit, "modifier_phased", tab)
   local particle = ParticleManager:CreateParticle("particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_shadowraze.vpcf", PATTACH_POINT_FOLLOW, unit)
   ParticleManager:ReleaseParticleIndex(particle)
   --ParticleManager:SetParticleControl(particle, 3, unit:GetAbsOrigin())
   local myevent = {}
   myevent.amount = 25
   myevent.target = unit
   PVEAggroAddRandomHero(event)
 end)
end

function JungleRumbleEvent(event)
  local scale = COverthrowGameMode.jungledifficulty*2.2
  for i=1, 60 do
    Timers:CreateTimer(i*2.0,function()
      if i == 2 then
        EmitGlobalSound("DOTA_Item.DoE.Activate")
      end 
      if i == 5 then
        Notifications:BottomToAll({text="Did you hear it rumbling in the distance?", duration=6, style={color="orange"}})
      end
      local spawnpos = Entities:FindByName( nil, "act12_"..math.random(1,16) ):GetAbsOrigin()
      local unitname = "temple_jungle_troll"
      local roll = math.random(1,4)
      if roll == 2 then
        unitname = "temple_jungle_viper"
      elseif roll == 3 then
        unitname = "temple_jungle_spider"
      elseif roll == 4 then
        unitname = "temple_jungle_raptor"
      end

      local unit = CreateUnitByName(unitname, spawnpos, true, nil, nil, DOTA_TEAM_BADGUYS )
      if roll == 2 then
        unit:AddAbility("pve_affix_slow_poison"):SetLevel(1)
      end
      unit.noexp = 1
      unit.patrolling = 12
      if i % 10 == 0 then
        unit.chance_for_champion = 100
        unit.noexp = nil
      end
      if roll == 1 then
        COverthrowGameMode:SetTempleStats(unit,scale,50,1300,5,0)
      elseif roll == 2 then
        COverthrowGameMode:SetTempleStats(unit,scale,150,700,5,0)
      elseif roll == 3 then
        COverthrowGameMode:SetTempleStats(unit,scale,100,1000,5,0)
      elseif roll == 4 then
        COverthrowGameMode:SetTempleStats(unit,scale,200,400,5,0)
      end

      local particle = ParticleManager:CreateParticle("particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_shadowraze.vpcf", PATTACH_POINT_FOLLOW, unit)
      ParticleManager:ReleaseParticleIndex(particle)

      local tab = {}
      tab.Duration = 3
      local ab = unit:FindAbilityByName("pveboss_system")
      ab:ApplyDataDrivenModifier(unit, unit, "modifier_phased", tab)

      --final boss
      if i == 60 then
        Timers:CreateTimer(60,function()
          Notifications:BottomToAll({text="The King of the Jungle has arrived!", duration=6, style={color="orange"}})
          EmitGlobalSound("DOTA_Item.DoE.Activate")
          local unitname = "temple_jungle_boss_"..math.random(0,7)
          local unit = CreateUnitByName(unitname, spawnpos, true, nil, nil, DOTA_TEAM_BADGUYS )
          unit.act = 12
          unit.main_quest_boss = 12
          unit.patrolling = 12
          unit.canleavespawnpos = true
          unit.improved_loot_quality = 10
          unit.act_12_final_boss = true
          unit.act_specific_loot_factor = 3
          unit.quest_trigger_class = "King of the Jungle"
          COverthrowGameMode:SetTempleStats(unit,scale,250,30000,100,0)
          unit:SetModelScale(1.25)
          local tab = {}
          tab.Duration = 0.1
          local ab = unit:FindAbilityByName("pveboss_system")
          ab:ApplyDataDrivenModifier(unit, unit, "modifier_phased", tab)
          local particle = ParticleManager:CreateParticle("particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_shadowraze.vpcf", PATTACH_POINT_FOLLOW, unit)
          ParticleManager:ReleaseParticleIndex(particle)
        end)
      end
    end)
  end
end

function AddAbilityNonDuplicate(target, ability)
	if target:HasAbility(ability) or (target.noinvisaffix and ability == "pve_temple_ambush") or (target:HasAbility("pve_temple_spottheweak") and ability =="pve_temple_ambush") or (target:HasAbility("pve_temple_ambush") and ability =="pve_temple_spottheweak") or (target:HasAbility("pve_temple_ambush") and ability =="pve_temple_viperpoison") or (target:HasAbility("pve_temple_viperpoison") and ability =="pve_temple_ambush")
   or (target:IsRangedAttacker() and ability == "pve_temple_colossus") or (target.patrolling and ability == "pve_temple_ambush") then
    --print("duplicate")
    local affix_ability = PickRandomShuffle( COverthrowGameMode.affixes, COverthrowGameMode.affixbucket )
    AddAbilityNonDuplicate(target, affix_ability)
    --return nil
  else
    local level = 1
    if COverthrowGameMode.jungledifficulty >= 10 then
      level = 2
    end
    if COverthrowGameMode.jungledifficulty >= 100 then
      level = 3
    end
    local added_ability_a = target:AddAbility(ability)
    if added_ability_a then
      added_ability_a:SetLevel(level)
    end
    --return ability
  end
end

function RandomBoss(otherboss)
	local b = COverthrowGameMode.bosses[math.random(1,#COverthrowGameMode.bosses)]
	if b == otherboss then
		return RandomBoss(otherboss)
	else
		return b
	end
end

function RandomBossMogushan(otherboss)
	local b = COverthrowGameMode.mogushan_extra_bosses[math.random(1,#COverthrowGameMode.mogushan_extra_bosses)]
	if b == otherboss then
		return RandomBossMogushan(otherboss)
	else
		return b
	end
end

function RandomBossIncludeMogushan(otherboss)
	local r = math.random(1,#COverthrowGameMode.bosses + #COverthrowGameMode.mogushan_extra_bosses)
	if r <= #COverthrowGameMode.bosses then
		--normal boss
		local b = COverthrowGameMode.bosses[math.random(1,#COverthrowGameMode.bosses)]
		if b == otherboss then
			return RandomBoss(otherboss)
		else
			return b
		end
	else
		--mogushan boss
		local b = COverthrowGameMode.mogushan_extra_bosses[math.random(1,#COverthrowGameMode.mogushan_extra_bosses)]
		if b == otherboss then
			return RandomBossMogushan(otherboss)
		else
			return b
		end
	end
end

function SetMogushanStats( unit, name, scale )
	if name == "temple_shadow_nightspider" then
		COverthrowGameMode:SetTempleStats(unit,scale,200,4000,100,0)
		unit:SetModelScale(1.1)
	end
	if name == "temple_wolf" then
		COverthrowGameMode:SetTempleStats(unit,scale,100,10000,100,0)
		unit:SetModelScale(1.25)
	end
	if name == "temple_shadow_archer" then
		COverthrowGameMode:SetTempleStats(unit,scale,150,6000,100,0)
		unit:SetModelScale(0.75)
	end
	if name == "temple_mount_plant" then
		COverthrowGameMode:SetTempleStats(unit,scale,85,12500,100,0)
		unit:SetModelScale(1.15)
	end
	if name == "temple_sand_stonegolem" then
		COverthrowGameMode:SetTempleStats(unit,scale,70,15000,100,0)
		unit:SetModelScale(1.4)
	end
  if name == "mogushan_super_boss" then
    COverthrowGameMode:SetTempleStats(unit,scale,100,10000,100,0)
  end
  if name == "temple_sand_dustboar" then
    if math.random(1,100) <= 50 then
     COverthrowGameMode:SetTempleStats(unit,scale,125,8000,100,0)
     unit:SetModelScale(1.3)
   else
     --horde
     local center = unit:GetAbsOrigin()
     COverthrowGameMode:SetTempleStats(unit,scale,50,5000,100,0)
     unit:SetModelScale(0.9)
     for i=1, 4 do
      local vec = Vector(-375+250*i,125,0)
      if i >= 3 then
       vec = Vector(-375+250*(i-2),-125,0)
     end
     unit = CreateUnitByName(name, center + vec, true, nil, nil, DOTA_TEAM_BADGUYS )
     COverthrowGameMode:SetTempleStats(unit,scale,50,5000,0,0)
     unit:SetModelScale(1.0)
   end
 end
end

end

function TempleShadowWave(event)
	local caster = event.caster
	local target = COverthrowGameMode:AggroHighest(caster)
  if event.random then
    target = PVERandomTarget(event)
  end
  if target and not target:IsNull() then
    event.ability:ApplyDataDrivenModifier(caster, target, "modifier_temple_bolts_wave", nil)
  end
end

function TempleBuffLowestAggro(event)
	local caster = event.caster
	local target = COverthrowGameMode:AggroLowest(caster)
	if target then
		event.ability:ApplyDataDrivenModifier(caster, target, event.buff, nil)
	end
end

function TempleBuffHighestAggro(event)
  local caster = event.caster
  local target = COverthrowGameMode:AggroHighest(caster)
  if target then
    event.ability:ApplyDataDrivenModifier(caster, target, event.buff, nil)
  end
end

function TempleRandomBuff(event)
	local caster = event.caster
  local ability = event.ability
  local buff = event.buff
  local target
  if event.prefer_ranged then
    target = PVERandomTargetRanged(event)
  else
    target = PVERandomTarget(event)
  end
  if event.requires_and_starts_cooldown then
    if ability:GetCooldownTimeRemaining() > 0 then
      return
    else
      ability:StartCooldown(event.requires_and_starts_cooldown)
    end
  end
  if target and event.ability then
    if event.dur then
     ability:ApplyDataDrivenModifier(caster, target, buff, { Duration = event.dur })
   else
     ability:ApplyDataDrivenModifier(caster, target, buff, nil)
   end
 end
end

function TempleRandomBuffNotLowestAggro(event)
	local caster = event.caster
	local buff = event.buff
	local target = PVERandomTargetNotLowestAggro(caster)
	if target then
		if event.dur then
			event.ability:ApplyDataDrivenModifier(caster, target, buff, { Duration = event.dur })
		else
			event.ability:ApplyDataDrivenModifier(caster, target, buff, nil)
		end
	end
end

function TempleFurthestBuff(event)
	local caster = event.caster
	local buff = event.buff
	local target = PVEFurthestTarget(event)
	if target then
		event.ability:ApplyDataDrivenModifier(caster, target, buff, nil)
	end
end

function TempleFurthestBuffStack(event)
	local caster = event.caster
	local buff = event.buff
	local target = PVEFurthestTarget(event)
	if target then
		local stack = target:GetModifierStackCount(buff, nil)
		event.ability:ApplyDataDrivenModifier(caster, target, buff, nil)
		target:SetModifierStackCount(buff, event.ability, stack+1)
	end
end

function TempleShadowLink(event)
	local caster = event.caster
	event.numbertargets = 3
	local targets = PVERandomXTargets(event)
	if targets and targets[1] and targets[2] and targets[3] then
		caster.shadowlinktarget = {}
		for i = 1, 3 do
			caster.shadowlinktarget[i] = targets[i]
			event.ability:ApplyDataDrivenModifier(caster, targets[i], "modifier_shadow_link", {Duration = 20})
		end
	end
end

function BuffRandomXTargets(event)
	local caster = event.caster
	event.numbertargets = event.count
	local targets = PVERandomXTargets(event)
	--print("t1 "..targets[1])
	--DeepPrintTable(targets)
	for i=1,event.count do
		if targets and targets[i] then
			--print("try aply")
			event.ability:ApplyDataDrivenModifier(caster, targets[i], event.buff, {Duration = event.dur})
		end
	end
end

function TempleShadowLinkTick(event)
	local caster = event.caster
	local target = event.target
	local breakdistance = 1500
	if caster and not event.close and not caster:IsNull() and target == caster.shadowlinktarget[1] then
		if (not caster.shadowlinktarget[1]:IsAlive() or not caster.shadowlinktarget[2]:IsAlive() or not caster.shadowlinktarget[3]:IsAlive()) or ((caster.shadowlinktarget[1]:GetAbsOrigin()-caster.shadowlinktarget[2]:GetAbsOrigin()):Length() > breakdistance and (caster.shadowlinktarget[1]:GetAbsOrigin()-caster.shadowlinktarget[3]:GetAbsOrigin()):Length() > breakdistance and (caster.shadowlinktarget[2]:GetAbsOrigin()-caster.shadowlinktarget[3]:GetAbsOrigin()):Length() > breakdistance) then

			caster.shadowlinktarget[1]:RemoveModifierByName("modifier_shadow_link")
			caster.shadowlinktarget[2]:RemoveModifierByName("modifier_shadow_link")
			caster.shadowlinktarget[3]:RemoveModifierByName("modifier_shadow_link")
		else
			local particle = ParticleManager:CreateParticle("particles/starsurge_beam.vpcf", PATTACH_POINT_FOLLOW, caster.shadowlinktarget[1])
			ParticleManager:SetParticleControlEnt(particle, 0, caster.shadowlinktarget[1], PATTACH_POINT_FOLLOW, "attach_hitloc", caster.shadowlinktarget[1]:GetAbsOrigin(), true)
			ParticleManager:SetParticleControlEnt(particle, 1, caster.shadowlinktarget[2], PATTACH_POINT_FOLLOW, "attach_hitloc", caster.shadowlinktarget[2]:GetAbsOrigin(), true)
      ParticleManager:ReleaseParticleIndex(particle)
      particle = ParticleManager:CreateParticle("particles/starsurge_beam.vpcf", PATTACH_POINT_FOLLOW, caster.shadowlinktarget[2])
      ParticleManager:SetParticleControlEnt(particle, 0, caster.shadowlinktarget[2], PATTACH_POINT_FOLLOW, "attach_hitloc", caster.shadowlinktarget[2]:GetAbsOrigin(), true)
      ParticleManager:SetParticleControlEnt(particle, 1, caster.shadowlinktarget[3], PATTACH_POINT_FOLLOW, "attach_hitloc", caster.shadowlinktarget[3]:GetAbsOrigin(), true)
      ParticleManager:ReleaseParticleIndex(particle)
      particle = ParticleManager:CreateParticle("particles/starsurge_beam.vpcf", PATTACH_POINT_FOLLOW, caster.shadowlinktarget[3])
      ParticleManager:SetParticleControlEnt(particle, 0, caster.shadowlinktarget[3], PATTACH_POINT_FOLLOW, "attach_hitloc", caster.shadowlinktarget[3]:GetAbsOrigin(), true)
      ParticleManager:SetParticleControlEnt(particle, 1, caster.shadowlinktarget[1], PATTACH_POINT_FOLLOW, "attach_hitloc", caster.shadowlinktarget[1]:GetAbsOrigin(), true)
      ParticleManager:ReleaseParticleIndex(particle)
    end
  end
  if caster and event.close and not caster:IsNull() and target == caster.shadowlinktarget[1] then
    breakdistance = 300
    if (not caster.shadowlinktarget[1]:IsAlive() or not caster.shadowlinktarget[2]:IsAlive() or not caster.shadowlinktarget[3]:IsAlive()) or ((caster.shadowlinktarget[1]:GetAbsOrigin()-caster.shadowlinktarget[2]:GetAbsOrigin()):Length() < breakdistance and (caster.shadowlinktarget[1]:GetAbsOrigin()-caster.shadowlinktarget[3]:GetAbsOrigin()):Length() < breakdistance and (caster.shadowlinktarget[2]:GetAbsOrigin()-caster.shadowlinktarget[3]:GetAbsOrigin()):Length() < breakdistance) then

     caster.shadowlinktarget[1]:RemoveModifierByName("modifier_shadow_link")
     caster.shadowlinktarget[2]:RemoveModifierByName("modifier_shadow_link")
     caster.shadowlinktarget[3]:RemoveModifierByName("modifier_shadow_link")
   else
     local particle = ParticleManager:CreateParticle("particles/dazzle_shadow_wave_green.vpcf", PATTACH_POINT_FOLLOW, caster.shadowlinktarget[1])
     ParticleManager:SetParticleControlEnt(particle, 0, caster.shadowlinktarget[1], PATTACH_POINT_FOLLOW, "attach_hitloc", caster.shadowlinktarget[1]:GetAbsOrigin(), true)
     ParticleManager:SetParticleControlEnt(particle, 1, caster.shadowlinktarget[2], PATTACH_POINT_FOLLOW, "attach_hitloc", caster.shadowlinktarget[2]:GetAbsOrigin(), true)
     ParticleManager:ReleaseParticleIndex(particle)
     particle = ParticleManager:CreateParticle("particles/dazzle_shadow_wave_green.vpcf", PATTACH_POINT_FOLLOW, caster.shadowlinktarget[2])
     ParticleManager:SetParticleControlEnt(particle, 0, caster.shadowlinktarget[2], PATTACH_POINT_FOLLOW, "attach_hitloc", caster.shadowlinktarget[2]:GetAbsOrigin(), true)
     ParticleManager:SetParticleControlEnt(particle, 1, caster.shadowlinktarget[3], PATTACH_POINT_FOLLOW, "attach_hitloc", caster.shadowlinktarget[3]:GetAbsOrigin(), true)
     ParticleManager:ReleaseParticleIndex(particle)
     particle = ParticleManager:CreateParticle("particles/dazzle_shadow_wave_green.vpcf", PATTACH_POINT_FOLLOW, caster.shadowlinktarget[3])
     ParticleManager:SetParticleControlEnt(particle, 0, caster.shadowlinktarget[3], PATTACH_POINT_FOLLOW, "attach_hitloc", caster.shadowlinktarget[3]:GetAbsOrigin(), true)
     ParticleManager:SetParticleControlEnt(particle, 1, caster.shadowlinktarget[1], PATTACH_POINT_FOLLOW, "attach_hitloc", caster.shadowlinktarget[1]:GetAbsOrigin(), true)
     ParticleManager:ReleaseParticleIndex(particle)
   end
 end
end

function MoveToStash(event, args)
  local player = PlayerResource:GetPlayer(args['player_id'])
  local hero = player:GetAssignedHero()
  if hero and hero:IsHero() and hero:IsAlive() and GetNumberItemsInStash(hero) < 6 then
    local item = hero:GetItemInSlot(0)
    if item and not item:IsNull() and not item:IsMuted() then
      --inventory gets filled first, then backpack, then stash
        local filler_item_count = 14 - GetNumberItemsInInventory(hero) - GetNumberItemsInBackpack(hero) - GetNumberItemsInStash(hero)
        local itemname = item:GetName()
        local shareable = item.droppedthisgame
        local filler = {}
        for i=1, filler_item_count do
         filler[i] = hero:AddItemByName( "item_dmg1" )
       end
       local newitem = hero:AddItemByName( itemname )
       if shareable then
         newitem.droppedthisgame = true
       end
       --Timers:CreateTimer(10,function()
       for i=1, filler_item_count do
         UTIL_Remove( filler[i] )
       end
       UTIL_Remove( item )
       EmitSoundOn("DOTA_Item.Hand_Of_Midas", hero)
       --end)
     else
      Notifications:Top(hero:GetPlayerID(), {text="Couldn't move Item! No Item in your top left Item slot or Item does not belong to you!", duration=6, style={color="red"}})
    end
  else
    Notifications:Top(hero:GetPlayerID(), {text="Couldn't move Item! Hero dead or Stash full!", duration=6, style={color="red"}})
  end
end

function COverthrowGameMode:ReportBossKills(kills)
	local score = math.floor(kills*COverthrowGameMode.jungledifficulty*GetDifficultyModeBossScoreFactor()+0.5)
	CustomGameEventManager:Send_ServerToAllClients( "report_boss_score", {value = score, kills = kills, progress = GetProgress()} )
end

function COverthrowGameMode:MythicDustChange(hero, value_change)
	local player = PlayerResource:GetPlayer(hero:GetPlayerID())
	EmitSoundOn("DOTA_Item.DustOfAppearance.Activate", hero)
	--particle
	local particle = ParticleManager:CreateParticle("particles/items_fx/dust_of_amaps/modular_library_radiant_00.vmapppearance.vpcf", PATTACH_POINT_FOLLOW, hero)
	ParticleManager:SetParticleControl(particle, 1, Vector(150,150,150))
  ParticleManager:ReleaseParticleIndex(particle)
  particle = ParticleManager:CreateParticle("particles/items_fx/blink_dagger_start.vpcf", PATTACH_POINT_FOLLOW, hero)
  ParticleManager:ReleaseParticleIndex(particle)
  hero.mythic_dust = hero.mythic_dust + value_change
  CustomGameEventManager:Send_ServerToPlayer(player, "mythic_dust_update", {value = hero.mythic_dust} )
  Timers:CreateTimer(0.75,function()
    particle = ParticleManager:CreateParticle("particles/items_fx/blink_dagger_start.vpcf", PATTACH_POINT_FOLLOW, hero)
    ParticleManager:ReleaseParticleIndex(particle)
    EmitSoundOn("DOTA_Item.DustOfAppearance.Activate", hero)
    particle = ParticleManager:CreateParticle( "particles/econ/items/dazzle/dazzle_ti6/dazzle_ti6_shallow_grave_ground_ray.vpcf", PATTACH_POINT_FOLLOW, hero )
  end)
  Timers:CreateTimer(1.5,function()
    particle = ParticleManager:CreateParticle("particles/items_fx/blink_dagger_start.vpcf", PATTACH_POINT_FOLLOW, hero)
    ParticleManager:ReleaseParticleIndex(particle)
    EmitSoundOn("DOTA_Item.DustOfAppearance.Activate", hero)
  end)
  Timers:CreateTimer(2.25,function()
    particle = ParticleManager:CreateParticle("particles/items_fx/blink_dagger_start.vpcf", PATTACH_POINT_FOLLOW, hero)
    ParticleManager:ReleaseParticleIndex(particle)
    EmitSoundOn("DOTA_Item.DustOfAppearance.Activate", hero)
  end)
end

function COverthrowGameMode:OnPlayerLevelUp(keys)
  local player = EntIndexToHScript(keys.player)
  local caster = player:GetAssignedHero()
  local heroName = caster:GetUnitName()
  --print("level up: new level " .. caster:GetLevel())
  --fix passive assignment after lvl 30
    --[[
    local abilityPointsLostFromPassiveAssignment = 0
    if caster:GetLevel() < 30 then
    	caster.passiveTalentsLevels = {}
    	for i=6,13 do
    		local ability = caster:GetAbilityByIndex(i)
	    	if ability then
	    		caster.passiveTalentsLevels[i-5] = ability:GetLevel()
	    	end
	    end
    end
    if caster:GetLevel() >= 30 then
    	for i=6,13 do
    		local ability = caster:GetAbilityByIndex(i)
	    	if ability and caster.passiveTalentsLevels and caster.passiveTalentsLevels[i-5] then
	    		ability:SetLevel(caster.passiveTalentsLevels[i-5])
	    		print("set lvl " .. ability:GetName() .. " lvl=" .. ability:GetLevel())
	    		if caster.passiveTalentsLevels[i-5] == 0 then
	    			abilityPointsLostFromPassiveAssignment = abilityPointsLostFromPassiveAssignment + 1
	    		end
	    	end
	    end
    end
    DeepPrintTable(caster.passiveTalentsLevels)]]
    --for i=6,13 do
    	--print(caster:GetAbilityByIndex(i):GetLevel())
      --end

      if heroName ~= "npc_dota_hero_invoker" then
        if caster:IsRealHero() and COverthrowGameMode.junglemode and ((caster:GetLevel() >= 13 and caster:GetLevel() <= 17) or (caster:GetLevel() >= 25 and caster:GetLevel() ~= 40 and caster:GetLevel() ~= 60 and caster:GetLevel() ~= 80 and caster:GetLevel() ~= 100)) then
          caster:SetAbilityPoints(caster:GetAbilityPoints()-1)
        end
      end
      if heroName == "npc_dota_hero_invoker" then
        if caster:IsRealHero() and COverthrowGameMode.junglemode and ((caster:GetLevel() >= 13 and caster:GetLevel() <= 25 and caster:GetLevel() ~= 20) or (caster:GetLevel() >= 25 and caster:GetLevel() ~= 40 and caster:GetLevel() ~= 60 and caster:GetLevel() ~= 80 and caster:GetLevel() ~= 100)) then
          caster:SetAbilityPoints(caster:GetAbilityPoints()-1)
        end
      end
      --if caster:IsRealHero() and COverthrowGameMode.junglemode and (caster:GetLevel() == 21 or caster:GetLevel() == 31 or caster:GetLevel() == 41) then
        --	caster:SetAbilityPoints(caster:GetAbilityPoints()+1)
        --end
        --if caster:IsRealHero() and COverthrowGameMode.junglemode and caster:GetLevel() >= 15 and (caster:GetLevel())%2 ~= 0 and caster.talentpoints then
          --    AddTalentPoint(caster, 1)
          --end
          --if COverthrowGameMode.junglemode and caster:IsRealHero() and COverthrowGameMode.junglemode and caster:GetLevel() == 25 then
            --   caster.hasmount = 1
            --end
            --if COverthrowGameMode.junglemode and caster:IsRealHero() and COverthrowGameMode.junglemode and caster:GetLevel() == 30 then
              --local ability = caster:FindAbilityByName("combat_system")
              --if ability then
                --    ability:ApplyDataDrivenModifier(caster, caster, "modifier_temple_armor_aura", nil)
                --end
                --end
                --if COverthrowGameMode.junglemode and caster:IsRealHero() and COverthrowGameMode.junglemode and caster:GetLevel() == 50 then
                  --   caster.hasmount = 2
                  --end
                  --every 5 levels get temple abil
                  if caster.temple_class and not caster.dont_add_temple_class_ability then -- and caster:GetLevel() % 5 == 0 then
                    AddTempleClassAbility(caster, nil, true) --random
                  end
                end

                function LevelNextAbility( hero )
                  local name = hero:GetName()
                  if hero.currentability then
                    hero.currentability = hero.currentability + 1
                    ability = hero.currentability
                  else
                    hero.currentability = 0
                  end
                  local index = hero.currentability
                  --sonderfall
                  if name == "npc_dota_hero_sniper" then
                    if hero.currentability == 3 then
                     index = 5
                   end
                   if hero.currentability == 4 then
                     index = 3
                   end
                   if hero.currentability == 5 then
                     index = 4
                   end
                 end
                 if name == "npc_dota_hero_vengefulspirit" then
                  if hero.currentability == 3 then
                   index = 5
                 end
                 if hero.currentability == 4 then
                   index = 3
                 end
                 if hero.currentability == 5 then
                   index = 4
                 end
               end
               
               --standard
               local ability = hero:GetAbilityByIndex(index)
               if ability then
                ability:SetLevel(1)
              end
            end

            function exp_scale(x, constant, exp_degree, fixterm)
             return x * x * constant * exp_degree + x * constant * (1-exp_degree) + constant * fixterm
           end

           function exp_scale_weighted(x, constant, weight)
             return (x * x * constant * 0.5 + x * constant * 0.5) * weight + ((3 * x) - 2) * constant * (1 - weight)
           end

           --setstats
           function COverthrowGameMode:SetTempleStats(target, scale, dmg, hp, reward, affixes)
             if not target then
              return
            end
            local is_champion = false
            local isboss = false
            local isthrash = false
            local issummon = false
            if target.noexp then
              issummon = true
            end
            local playerscale = 1
            if self.current_act_populated then
              --track unit act for act specific drops
              target.act = self.current_act_populated
            end
            if self.player_count_scale then
              playerscale = self.player_count_scale
            end
            if playerscale <= 0 then
              playerscale = 1
            end
            if (reward and reward >= 100) or (target and target.isboss) then
              isboss = true
              target.isboss = true
            end
            if target:HasModifier("modifier_loot_goblin") then
              target.isgoblin = true
            end
            if reward and reward > 0 and not isboss then
              isthrash = true
              if reward < 100 then
                --new discount on drop chance, 5.5 patch
                reward = reward / 10
              end
            end
            --low level lower hp needed
            local interpolation_factor = (COverthrowGameMode.jungledifficulty - 1 ) / 4
            if interpolation_factor > 1 then
              interpolation_factor = 1
            end
            if (target.chance_for_champion and scale > 1.0) then
              --increase base 10% to 20%
              target.chance_for_champion = target.chance_for_champion * 2
              if math.random(1,100) <= target.chance_for_champion * GetDifficultyModeChampionChanceFactor() then
               is_champion = true
               reward = 100
               if not target.isboss then
                target.nobosskill = 1
              end
              local champion_power = math.random(5,6)
              if target.champion_affixes_max then
                champion_power = 7 - target.champion_affixes_max
              end
              affixes = 7 - champion_power
              --max hp x 10 - 19
              
              hp = hp * 12 * interpolation_factor + hp * 5 * (1 - interpolation_factor)


              dmg = dmg * (1.0 + 0.1 * champion_power)
              target:SetModelScale(target:GetModelScale()*1.25)
              target.is_champion = true
            else
             affixes = 0
           end
         else
          --normal trash that is not able to be champion, must remove their affixes
          if not isboss and not target.can_have_affixes then
           affixes = 0
         end
       end
       if target.chance_for_mogushan_affixes then
        if math.random(1,100) <= target.chance_for_mogushan_affixes then
         local champion_power = math.random(5,6)
         affixes = 7 - champion_power
         if target.mogushan_super_boss then
          -- only 1 random affix for this super boss
          affixes = 1
        end
        --max hp x 10 - 19
        hp = hp * (1 + 0.2 * champion_power)
        --max dmg x 2-2.75
        dmg = dmg * (1 + 0.2 * champion_power)
      end
    end
    if target.setChampionAffixCount then
      affixes = target.setChampionAffixCount
    end
    if isboss then
      SetBossID(target)
    end
    if isthrash and (not is_champion) and (not issummon) then
      --just to make trash a bit more dangerous, since they have nothing else
      if COverthrowGameMode.jungledifficulty == 5 then
        dmg = dmg * 1.25
      end
      if COverthrowGameMode.jungledifficulty == 10 then
        dmg = dmg * 1.5
      end
      if COverthrowGameMode.jungledifficulty >= 20 and COverthrowGameMode.jungledifficulty < 100 then
        dmg = dmg * 2
      end
      if COverthrowGameMode.jungledifficulty >= 100 then
        dmg = dmg * 3
      end
    end

    dmg = dmg * GetDifficultyModeDamageFactor() -- * 0.9 --0.9 new season 8

    --season 5: 5x hp, gradually
    if COverthrowGameMode.jungledifficulty == 1 then
      hp = hp * 1.25
      dmg = dmg * 1
    end
    if COverthrowGameMode.jungledifficulty == 2 then
      hp = hp * 2
      dmg = dmg * 1
    end
    if COverthrowGameMode.jungledifficulty == 5 then
      hp = hp * 3
      dmg = dmg * 1
    end
    if COverthrowGameMode.jungledifficulty == 10 then
      hp = hp * 4
      dmg = dmg * 0.95
    end
    if COverthrowGameMode.jungledifficulty == 20 then
      hp = hp * 5
      dmg = dmg * 0.9
    end
    if COverthrowGameMode.jungledifficulty == 50 then
      hp = hp * 4.5
      dmg = dmg * 0.85
    end
    if COverthrowGameMode.jungledifficulty >= 100 then
      hp = hp * 4
      dmg = dmg * 0.8
    end

    hp = exp_scale(scale, hp, 0.33, 0)  --0.25 before
    
    if not target.isgoblin then
      hp = hp * (0.5 + 0.5 * playerscale) --here lets downscale hp not too much
    end

    hp = hp * 1.2 --cuz longer global cd, 5.4 patch

    --first play experience adjustments, now diminishes after first act
    local weaken = 1.0
    if self.jungledifficulty <= 1.0 then
      local effectStrength = 1 - (scale - 1) * 2
      if effectStrength < 0 then
        effectStrength = 0
      end
      if effectStrength > 1 then
        effectStrength = 1
      end
      if isboss or is_champion then
        weaken = 0.25 * effectStrength + (1 - effectStrength)
      else
        weaken = 0.75 * effectStrength + (1 - effectStrength)
      end
    end

    hp = hp * weaken * GetDifficultyModeHealthFactor()
    
    --quick testing
    --hp = 1
    --dmg = 1
    --hp = 500
    if hp < 1.0 then
      hp = 1
    end
    dmg = dmg * playerscale
    target:SetBaseDamageMin(dmg*scale*weaken)
    target:SetBaseDamageMax(dmg*scale*weaken)
    
    --overflow hp bug
    if not hp or hp <= 0 then
      hp = 20000000000
    end
    --hp overflow problem, solved via dmg reduction
    local max_allowed_hp = 1000000000
    if hp > max_allowed_hp then
      target.incoming_damage_factor = max_allowed_hp / hp
      hp = max_allowed_hp
    end

    target:SetBaseMaxHealth(hp)
    target:SetMaxHealth(hp)
    target:SetHealth(hp)
    target.aggrolist = {}
    target.aggro_not_pulled_yet = true
    target.rewardchance = reward
    target.pvescale = scale
    local xp_base = 0
    if isthrash then
      xp_base = 10
    end
    if isboss then
      xp_base = 200 --125 before
    end
    if is_champion then
      xp_base = 400 --375
    end
    --act11 bonus
    if target.act and target.act == 11 then
      if target.act11_last_boss then
        xp_base = xp_base * 25
      else
        xp_base = xp_base * 10
      end
    end
    xp_base = xp_base * playerscale
    if issummon then
      xp_base = 0
    end
    local xp_given = exp_scale(scale, xp_base, 0.15, 0)--((3 * scale) - 2) * xp_base  --
    --if self.jungledifficulty < 1.0 then
     --	xp_given = xp_base * 0.25
     --end
     if target.exp_factor then
      xp_given = xp_given * target.exp_factor
    end
    xp_given = xp_given * 1.1 * GetDifficultyModeExperienceFactor()
    if xp_given > 100000000 then
      xp_given = 100000000
    end
    target:SetDeathXP(xp_given)
    --if isboss and false then
      --print("boss")
      --print("health "..hp)
      --print("dmg "..newdmg)
      --print("xp "..xp_given)
      --end
      --if self.totalxpspawned then
       --	self.totalxpspawned = self.totalxpspawned + xp_given
       --else
       --	self.totalxpspawned = xp_given
       --end
       --print("xp "..self.totalxpspawned)
       --print("xp " .. target:GetDeathXP())
       for i=0, 30 do
        target.aggrolist[i] = 0
      end
      local abil = target:FindAbilityByName("pveboss_system")
      if abil then
        abil:SetLevel(1)
        --if isboss and (not target.isgoblin) and (not target.no_will_of_survival) then
          --    abil:ApplyDataDrivenModifier(target,  target, "modifier_pve_boss_toughness", {Duration = -1})
          --end
        end
        -- fix boss base leave
        if (isboss and not target.canleavespawnpos) or target.cannotleavespawnpos then
          target.temple_spawn_spot = target:GetAbsOrigin()
        end
        target.unitSpawnPosition = target:GetAbsOrigin()
        --fix pve dummy abil
        local abil2 = target:FindAbilityByName("dummy_unit")
        if abil2 then
          abil2:SetLevel(1)
        end
        local abillevel = 1
        if self.jungledifficulty >= 5 then
          abillevel = 2
        end
        if self.jungledifficulty >= 10 then
          abillevel = 3
        end
        if self.jungledifficulty >= 20 then
          abillevel = 4
        end
        if self.jungledifficulty >= 50 then
          abillevel = 5
        end
        if self.jungledifficulty >= 100 then
          abillevel = 6 --4
        end
        if self.jungledifficulty >= 200 then
          abillevel = 7 --4
        end
        if self.jungledifficulty >= 500 then
          abillevel = 8 --4
        end
        if self.jungledifficulty >= 1000 then
          abillevel = 9 --5
        end
        if target.isgoblin then
          abillevel = 1 --goblins should not get that increased ms that bosses get
        end
        for i=0,12 do
          local abil3 = target:GetAbilityByIndex(i)
          if abil3 then
           abil3:SetLevel(abillevel)
         end
       end
       --special scalings, currently AS for bosses
       local resistances_bonus_level = 1
       if not isboss then
        if self.jungledifficulty >= 10.0 then
         resistances_bonus_level = 2
       end
       if self.jungledifficulty >= 100.0 then
         resistances_bonus_level = 3
       end
     end
     if isboss or target.bosslikescaling then
      if self.jungledifficulty >= 10.0 then
       resistances_bonus_level = 4
     end
     if self.jungledifficulty >= 100.0 then
       resistances_bonus_level = 5
     end
   end
   --set passive bonus stats
   abil = target:FindAbilityByName("pveboss_system")
   if abil then
    abil:SetLevel(abillevel)
    --local BossAADamageFactor = 1
    --if isboss then
      --   BossAADamageFactor = COverthrowGameMode.jungledifficulty 
      --end
    end
    if abil and (isboss or target.bosslikescaling) and not is_champion then
      --double resistances
      abil:ApplyDataDrivenModifier(target,  target, "pve_boss_extra_resistances", nil)
      target.isboss = true
    end
    if is_champion and abil then
      abil:ApplyDataDrivenModifier(target,  target, "pve_champion_extra_resistances", nil)
    end

    target:SetForwardVector(Vector(-1,0,0))
    -- initialize path patrolling
    if target.patrolling then
      target.patrolling_path = {}
      if target.patrolling == 1 then
       target.patrolling = 1
       target.patrolling_path[1] = Entities:FindByName( nil, "camp3" ):GetAbsOrigin()
       target.patrolling_path[2] = Entities:FindByName( nil, "boss2" ):GetAbsOrigin()
       target.patrolling_path[3] = Entities:FindByName( nil, "boss3" ):GetAbsOrigin()
     end
     if target.patrolling == 2 then
      target.patrolling = 1
      target.patrolling_path[1] = Entities:FindByName( nil, "camp10" ):GetAbsOrigin()
      target.patrolling_path[2] = Entities:FindByName( nil, "boss4" ):GetAbsOrigin()
      target.patrolling_path[3] = Entities:FindByName( nil, "boss6" ):GetAbsOrigin()
    end
    if target.patrolling == -2 then
     target.patrolling = 1
     target.patrolling_path[1] = Entities:FindByName( nil, "camp7" ):GetAbsOrigin()
     target.patrolling_path[2] = Entities:FindByName( nil, "camp11" ):GetAbsOrigin()+Vector(1100,0,0)
     target.patrolling_path[3] = Entities:FindByName( nil, "boss4" ):GetAbsOrigin()
   end
   if target.patrolling == 3 then
     target.patrolling = 1
     target.patrolling_path[1] = Entities:FindByName( nil, "boss7" ):GetAbsOrigin()
     target.patrolling_path[2] = Entities:FindByName( nil, "fishevent" ):GetAbsOrigin()
     target.patrolling_path[3] = Entities:FindByName( nil, "camp13" ):GetAbsOrigin()
   end
   if target.patrolling == -3 then
    target.patrolling = 1
    target.patrolling_path[1] = Entities:FindByName( nil, "boss7" ):GetAbsOrigin()
    target.patrolling_path[2] = Entities:FindByName( nil, "camp13" ):GetAbsOrigin()
    target.patrolling_path[3] = Entities:FindByName( nil, "teleporter_3" ):GetAbsOrigin()
  end
  if target.patrolling == 4 then
   target.patrolling = 1
   target.patrolling_path[1] = Entities:FindByName( nil, "camp20" ):GetAbsOrigin()
   target.patrolling_path[2] = Entities:FindByName( nil, "boss12" ):GetAbsOrigin()
   target.patrolling_path[3] = Entities:FindByName( nil, "boss15" ):GetAbsOrigin()
 end
 if target.patrolling == 5 then
   target.patrolling = 1
   target.patrolling_path[1] = Entities:FindByName( nil, "camp28" ):GetAbsOrigin()
   target.patrolling_path[2] = Entities:FindByName( nil, "boss17" ):GetAbsOrigin()
   target.patrolling_path[3] = Entities:FindByName( nil, "boss19" ):GetAbsOrigin()
 end
 if target.patrolling == 6 then
   target.patrolling = 1
   target.patrolling_path[1] = Entities:FindByName( nil, "camp38" ):GetAbsOrigin()
   target.patrolling_path[2] = Entities:FindByName( nil, "boss21" ):GetAbsOrigin()
   target.patrolling_path[3] = Entities:FindByName( nil, "boss24" ):GetAbsOrigin()
 end
 if target.patrolling == 12 then
  target.patrolling = 1
  target.patrolling_path[1] = Entities:FindByName( nil, "act12_12" ):GetAbsOrigin()
  target.patrolling_path[2] = Entities:FindByName( nil, "act12_7" ):GetAbsOrigin()
  target.patrolling_path[3] = Entities:FindByName( nil, "act12_2" ):GetAbsOrigin()
end
--pppppppp
if target.patrolling == 15 then
  target.patrolling = 1
  target.patrolling_path[1] = Entities:FindByName( nil, "boss5" ):GetAbsOrigin()
  target.patrolling_path[2] = Entities:FindByName( nil, "boss6" ):GetAbsOrigin()
  target.patrolling_path[3] = Entities:FindByName( nil, "act12_5" ):GetAbsOrigin()
end
if target.patrolling == 16 then
  target.patrolling = 1
  target.patrolling_path[1] = Entities:FindByName( nil, "boss24" ):GetAbsOrigin()
  target.patrolling_path[2] = Entities:FindByName( nil, "boss14" ):GetAbsOrigin()
  target.patrolling_path[3] = Entities:FindByName( nil, "mogushan" ):GetAbsOrigin()
end
if target.patrolling == 17 then
  target.patrolling = 1
  target.patrolling_path[1] = Entities:FindByName( nil, "boss21" ):GetAbsOrigin()
  target.patrolling_path[2] = Entities:FindByName( nil, "boss11" ):GetAbsOrigin()
  target.patrolling_path[3] = Entities:FindByName( nil, "boss16" ):GetAbsOrigin()
end
end

--if affixes < 6 and reward > 0 and reward < 100 and math.random(1,100) <= 1 then
  --target:AddAbility("pve_loot_goblin"):SetLevel(1)
  --end
  
  if affixes and affixes > 0 then
    for i=1, affixes do
     local affix_ability = PickRandomShuffle( COverthrowGameMode.affixes, COverthrowGameMode.affixbucket )
     AddAbilityNonDuplicate(target, affix_ability)
      --[[
      if self.jungledifficulty >= 30.0 then
        local found_ability = target:FindAbilityByName(added_ability)
        if found_ability then
          found_ability:SetLevel(2)
        end
      end
      if self.jungledifficulty >= 40.0 then
        local found_ability = target:FindAbilityByName(added_ability)
        if found_ability then
          found_ability:SetLevel(3)
        end
      end
      ]]
    end
  end
  --relevel affixes?
  for i=0,5 do
    local abil3 = target:GetAbilityByIndex(i)
    if abil3 then
     abil3:SetLevel(abillevel)
     end
   end
   --new act affix
   if self.jungledifficulty > 50 and self.act_affix_roll then
    local act_affix = self.act_affixes[self.act_affix_roll]
    if act_affix then
      target:AddAbility(act_affix):SetLevel(1)
    end
  end
  if (is_champion or isthrash) and not isboss then
    target.real_boss = false
  else
    target.real_boss = true
  end
end

function AddActAffixes( unit, count )
  local affixBucket = {}
  local affixCount = #COverthrowGameMode.act_affixes
  for i=1, affixCount do
    table.insert(affixBucket, COverthrowGameMode.act_affixes[i])
  end
  for i=1, count do
    local roll = math.random(1, affixCount)
    local act_affix = affixBucket[roll]
    if act_affix then
      unit:AddAbility(act_affix):SetLevel(1)
      table.remove(affixBucket, roll)
    end
  end
end

function COverthrowGameMode:CreateAct11LastBoss()
  local center = Entities:FindByName( nil, "act11_center" ):GetAbsOrigin()
  Timers:CreateTimer(18.5,function()
    EmitGlobalSound("silencer_silen_kill_02")
  end)
  Timers:CreateTimer(20,function() 
    Notifications:BottomToAll({text="Something weird seems to be happening in the Temple... what is this... take care!", duration=5, style={color="orange"}})
    EmitGlobalSound("silencer_silen_cast_01")
  end)
  --Timers:CreateTimer(25,function()
  --EmitGlobalSound("Hero_Silencer.LastWord.Target")
  --end)
  local unit
  Timers:CreateTimer(26,function()
    EmitGlobalSound("Hero_Silencer.LastWord.Cast")
    local scale = self.jungledifficulty + self.jungledifficulty * 1.0
    Notifications:BottomToAll({text="It's Morpheus, Warden of the Temple! We must defeat him or he will steal all your Essences of Life!", duration=5, style={color="orange"}})
    unit = CreateUnitByName("temple_temple_boss_1", center, true, nil, nil, DOTA_TEAM_BADGUYS )
    unit.act = 11
    unit.act_11_last_boss = true
    unit.main_quest_boss = 11
    unit:AddAbility("pve_temple_invoker_shadow_totems")
    unit:AddAbility("pve_summonmoving_shadow_linear")
    self:AddSeveralSuperBossAbilities(unit, 4, 2)
    self:AddSeveralSuperBossAbilities(unit, 7, 2)
    --self:AddSeveralSuperBossAbilities(unit, 10, 1)
    self.act_affix_roll = math.random(1,#self.act_affixes)
    self:SetTempleStats(unit,scale,125,30000,100,0)
    self.act_affix_roll = nil
    --end
    unit.act11_boss = 11
    unit.act11_last_boss = true
    unit.ischallengeboss = true
    unit.act_specific_loot_factor = 3
    unit:FindAbilityByName("pveboss_system"):ApplyDataDrivenModifier(unit, unit, "modifier_stunned", {Duration = 8})
    unit:FindAbilityByName("pveboss_system"):ApplyDataDrivenModifier(unit, unit, "modifier_invulnerable", {Duration = 8})
    local particle = ParticleManager:CreateParticle("particles/items2_fx/veil_of_discord.vpcf", PATTACH_POINT_FOLLOW, unit)
    ParticleManager:SetParticleControl(particle, 1, Vector(1200,1200,1200))
    ParticleManager:ReleaseParticleIndex(particle)
    particle = ParticleManager:CreateParticle("particles/items2_fx/veil_of_discord.vpcf", PATTACH_POINT_FOLLOW, unit)
    ParticleManager:SetParticleControl(particle, 1, Vector(300,300,300))
    ParticleManager:ReleaseParticleIndex(particle)
    local unit_pointer = unit
    Timers:CreateTimer(1,function()
      if unit_pointer and not unit_pointer:IsNull() then
        if unit_pointer:GetHealth() / unit_pointer:GetMaxHealth() <= 0.3 then
          EmitGlobalSound("silencer_silen_kill_15")
          Notifications:BottomToAll({text="Warden of the Temple: Creatures of the night, come and fight for me!", duration=8, style={color="orange"}})
          SpawnMonsterSwarm( 11, 5, 10, unit_pointer, false, false, true, true, {center+RandomVector(1200), center+RandomVector(1200), center+RandomVector(1200), center+RandomVector(1200)}, scale )
        else
          return 1
        end
      end
    end)
  end)
  Timers:CreateTimer(31.1,function()
    EmitGlobalSound("Hero_Silencer.LastWord.Cast")
    --local scale = self.jungledifficulty + self.jungledifficulty * 1.0
    --Notifications:BottomToAll({text="He cursed all 10 Temple Gods and then spread madness across the whole kingdom of Kelthador!", duration=10, style={color="orange"}})
      --Notifications:BottomToAll({text="We have to defeat him to put an end to the chaos he inflicted.", duration=10, style={color="orange"}})
    end)
  Timers:CreateTimer(30,function()
    EmitGlobalSound("silencer_silen_ability_curse_03")
  end)
  Timers:CreateTimer(34,function()
    EmitGlobalSound("silencer_silen_kill_15")
    local particle = ParticleManager:CreateParticle("particles/items2_fx/veil_of_discord.vpcf", PATTACH_POINT_FOLLOW, unit)
    ParticleManager:SetParticleControl(particle, 1, Vector(1200,1200,1200))
    ParticleManager:ReleaseParticleIndex(particle)
  end)
end

function COverthrowGameMode:CreateActBoss(act, boss_unlock)
  CinematicKillMessage(boss_unlock)
  --Notifications:BottomToAll({text="Mysterious activities have been spotted in the Temple of Dreams. You can use the Teleporter now!", duration=8, style={color="orange"}})
  --unlock tp
  
  if not self.act11_bosses_spawned then
    self.act_affix_roll = math.random(1,#self.act_affixes)
    local horde_factor = 1
    if self.act_affix_roll == 12 and self.jungledifficulty > 50 then
      --horde act affix
      horde_factor = math.random(2,3)
    end
    self.act11_bosses_spawned = true
    local scale = self.jungledifficulty + self.jungledifficulty * 1.0
    local center = Entities:FindByName( nil, "act11_center" ):GetAbsOrigin()
    --creeps
    local creep1 = Entities:FindByName( nil, "act11_creep_1" ):GetAbsOrigin()
    local creep2 = Entities:FindByName( nil, "act11_creep_2" ):GetAbsOrigin()
    local creep3 = Entities:FindByName( nil, "act11_creep_3" ):GetAbsOrigin()
    --local rider = CreateUnitByName("npc_dota_creature_questboard", creep1+Vector(0,-1000,0), true, nil, nil, DOTA_TEAM_GOODGUYS )
    --rider:SetForwardVector(Vector(-0.25,1,0))

    local deadwingPos = creep1+Vector(0,750,0)
    if math.random(1,100) <= 33 then
      deadwingPos = creep2+Vector(0,750,0)
    elseif math.random(1,100) <= 50 then
      deadwingPos = creep3+Vector(0,750,300)
    end
    local unit = CreateUnitByName("extra_act11", deadwingPos, true, nil, nil, DOTA_TEAM_BADGUYS )
    unit.chance_for_champion = 100
    unit:AddAbility("pve_temple_ambush")
    self:SetTempleStats(unit,scale,250,1000,20,0)

    for i=1,1*horde_factor do
     local unit = CreateUnitByName("temple_shadow_spectre_2", creep1+Vector(0,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
     unit:SetModelScale(1.1)
     unit:AddAbility("pve_temple_ambush")
     unit:AddAbility("temple_shadowstrike")
     self:SetTempleStats(unit,scale,250,1250,20,0)
   end
   for i=1,3*horde_factor do
     local unit = CreateUnitByName("temple_shadow_spectre_2", creep2+Vector(-300+150*i,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
     unit:SetModelScale(0.85)
     unit:AddAbility("pve_temple_ambush")
     unit:AddAbility("temple_shadowstrike")
     self:SetTempleStats(unit,scale,65,500,7,0)
   end
   for i=1,1*horde_factor do
     local unit = CreateUnitByName("temple_shadow_spectre_2", creep3+Vector(0,400,0), true, nil, nil, DOTA_TEAM_BADGUYS )
     unit:SetModelScale(1.0)
     unit:AddAbility("pve_temple_ambush")
     unit:AddAbility("temple_shadowstrike")
     self:SetTempleStats(unit,scale,50,600,7,0)
   end
   for i=1,horde_factor do
     local unit = CreateUnitByName("temple_shadow_archer", creep3+Vector(-150+150*i,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
     unit.chance_for_champion = 100
     unit:SetModelScale(0.70)
     unit:AddAbility("pve_aa_shadow_wave")
     self:SetTempleStats(unit,scale,125,450,7,0)
     unit.loot_goblin_artifact_factor = 3 -- 90% arti
     unit.drop_chance_factor = 4 -- 10% aimo on ml 20
     unit.unlock_improved_tp_act_11 = true
   end
   --traps
   local unit = CreateUnitByName("temple_spike_trap", creep1+Vector(150,1000,0), true, nil, nil, DOTA_TEAM_BADGUYS )
   unit.exp_factor = 5
   self:SetTempleStats(unit,scale,750,100,0,0)
   unit = CreateUnitByName("temple_spike_trap", creep3+Vector(-950,-115,0), true, nil, nil, DOTA_TEAM_BADGUYS )
   unit.exp_factor = 5
   self:SetTempleStats(unit,scale,750,100,0,0)


   --bosses
   for bossnumber=1,10 do
     local pos = Entities:FindByName( nil, "act"..act.."_"..bossnumber ):GetAbsOrigin()
     local name = ""
     if bossnumber == 1 then
      name = "temple_wolf_boss_5"
    end
    if bossnumber == 2 then
      name = "temple_sand_boss_6"
    end
    if bossnumber == 3 then
      name = "temple_water_boss_6"
    end
    if bossnumber == 4 then
      name = "temple_shadow_boss_7"
    end
    if bossnumber == 5 then
      name = "temple_dragon_boss_6"
    end
    if bossnumber == 6 then
      name = "temple_mount_boss_7"
    end
    if bossnumber == 7 then
      name = "temple_tomb_boss_4"
    end
    if bossnumber == 8 then
      name = "temple_volcano_boss_3"
    end
    if bossnumber == 9 then
      name = "temple_mogushan_boss_1"
    end
    if bossnumber == 10 then
      name = "temple_throne_boss_2"
    end
    local unit = CreateUnitByName(name, pos, true, nil, nil, DOTA_TEAM_BADGUYS )
    unit.act = 11
    unit.main_quest_boss = bossnumber
    if bossnumber ~= 10 and bossnumber ~= 9 then
      self:AddSeveralSuperBossAbilities(unit, bossnumber, 5)
    end
    if bossnumber == 9 then
      unit:AddAbility("pve_temple_stompingcharge_straight")
      self:AddSeveralSuperBossAbilities(unit, 9, 1)
      self:AddSeveralSuperBossAbilities(unit, 9, 1)
      self:AddSeveralSuperBossAbilities(unit, 9, 1)
      self:AddSeveralSuperBossAbilities(unit, 9, 1)
    end
    if bossnumber == 10 then
      self:AddSeveralSuperBossAbilities(unit, 10, 1)
      self:AddSeveralSuperBossAbilities(unit, math.random(4,8), 1)
      self:AddSeveralSuperBossAbilities(unit, 10, 1)
      self:AddSeveralSuperBossAbilities(unit, math.random(4,8), 1)
      self:AddSeveralSuperBossAbilities(unit, 10, 1)
      self:AddSeveralSuperBossAbilities(unit, math.random(4,8), 1)
    end
    --if act == 9 then
     --	self:SetTempleStats(unit,scale,115,10000,100,0)
     --end
     --if act ~= 9 then

      --new act affix
      self.act_affix_roll = math.random(1,#self.act_affixes)
      self:SetTempleStats(unit,scale,115,20000,100,0)
      --end
      unit.act11_boss = bossnumber
      --unit.temple_cooldown = 5
      unit.ischallengeboss = true
      self.act11_bosses[bossnumber] = unit
      Timers:CreateTimer(1,function()
        unit:FindAbilityByName("pveboss_system"):ApplyDataDrivenModifier(unit, unit, "modifier_temple_stone_seal", {Duration = -1})
      end)
      --unit:FindAbilityByName("pveboss_system"):ApplyDataDrivenModifier(unit, unit, "modifier_stunned", {Duration = -1})
      LookToPoint(unit, center)
    end
    self.act_affix_roll = nil
  end
  --unlock seal
  Timers:CreateTimer(2,function()
    if self.act11_bosses[boss_unlock] and not self.act11_bosses[boss_unlock]:IsNull() then
     self.act11_bosses[boss_unlock]:RemoveModifierByName("modifier_temple_stone_seal")
     SetCinematicApproachMessage(self.act11_bosses[boss_unlock], boss_unlock+10)
     UnitAggroClear({caster = self.act11_bosses[boss_unlock]})
     --self.act11_bosses[boss_unlock]:RemoveModifierByName("modifier_stunned")
   end
 end)
end

function LookToPoint( unit, point )
	local vec = (point-unit:GetAbsOrigin()):Normalized()
	vec[3] = 0
  unit:SetForwardVector(vec)
end

function COverthrowGameMode:AddSeveralSuperBossAbilities(unit, act, amount)
	for i=1,amount do
		self:AddSuperBossAbilities(unit, act)
	end
end

function COverthrowGameMode:AddSuperBossAbilities(unit, act)
	--print("addsuperbossabil")
	--print(act)
	--print(self.boss_spells)
	--print(#self.boss_spells)
	--DeepPrintTable(self.boss_spells)
	local ability = self.boss_spells[act][math.random(1,#self.boss_spells[act])]
	if not unit:HasAbility(ability) then
		if ability then
			unit:AddAbility(ability):SetLevel(1)
		end
	else
		self:AddSuperBossAbilities(unit, act)
	end
end

function COverthrowGameMode:SendDPSMeterData()
  local all = HeroList:GetAllHeroes()
  local hero
  local first_send = false
  for i=1, #all do
    hero = all[i]
    local boss = hero.current_boss_target
    local result_list = {}
    local total_aggro = 0
    --print(boss)
    if hero and boss and not boss:IsNull() and boss:IsAlive() and boss.aggrolist then
     --print(boss:GetUnitName())
     for j=0, self.max_players-1 do
      if boss.aggrolist[j] and boss.aggrolist[j] > 0.0 then
       result_list[j+1] = {playerid = j, aggro = boss.aggrolist[j]}
       total_aggro = total_aggro + boss.aggrolist[j]
     else
       result_list[j+1] = {playerid = j, aggro = 0.0}
     end
   end
   --DeepPrintTable(result_list)
   table.sort( result_list, function(a,b) return ( a.aggro > b.aggro ) end)
   -- relative dmg
   for j=1, self.max_players do
    result_list[j].aggro = result_list[j].aggro / total_aggro
  end
  --DeepPrintTable(result_list)
  --print(total_aggro)
  if total_aggro > 0 then
    local p1 = PlayerResource:GetPlayer(result_list[1].playerid)
    if p1 and p1:GetAssignedHero() then
     p1 = p1:GetAssignedHero():GetUnitName()
   else
     p1 = "none"
   end
   local p2 = PlayerResource:GetPlayer(result_list[2].playerid)
   if p2 and p2:GetAssignedHero() then
     p2 = p2:GetAssignedHero():GetUnitName()
   else
     p2 = "none"
   end
   local p3 = PlayerResource:GetPlayer(result_list[3].playerid)
   if p3 and p3:GetAssignedHero() then
     p3 = p3:GetAssignedHero():GetUnitName()
   else
     p3 = "none"
   end
   local p4 = PlayerResource:GetPlayer(result_list[4].playerid)
   if p4 and p4:GetAssignedHero() then
     p4 = p4:GetAssignedHero():GetUnitName()
   else
     p4 = "none"
   end
   local p5 = PlayerResource:GetPlayer(result_list[5].playerid)
   if p5 and p5:GetAssignedHero() then
     p5 = p5:GetAssignedHero():GetUnitName()
   else
     p5 = "none"
   end
   --send first table to all for observer
   if not first_send then
     first_send = true
     CustomGameEventManager:Send_ServerToAllClients( "report_dps_meter", {
      playerid1 = p1, aggro1 = result_list[1].aggro,
      playerid2 = p2, aggro2 = result_list[2].aggro,
      playerid3 = p3, aggro3 = result_list[3].aggro,
      playerid4 = p4, aggro4 = result_list[4].aggro,
      playerid5 = p5, aggro5 = result_list[5].aggro
    } )
   else
     local player = PlayerResource:GetPlayer(hero:GetPlayerID())
     CustomGameEventManager:Send_ServerToPlayer(player, "report_dps_meter", {
      playerid1 = p1, aggro1 = result_list[1].aggro,
      playerid2 = p2, aggro2 = result_list[2].aggro,
      playerid3 = p3, aggro3 = result_list[3].aggro,
      playerid4 = p4, aggro4 = result_list[4].aggro,
      playerid5 = p5, aggro5 = result_list[5].aggro
    } )
   end
 end
else
 --hide panel?
end
end
end

function GetProgress()
	local kills = 0
	local total_kills = 0
	for i=1,13 do
		if COverthrowGameMode.act_kills and COverthrowGameMode.act_kills[i] then
			kills = kills + COverthrowGameMode.act_kills[i]
		end
		total_kills = total_kills + COverthrowGameMode.act_kills_max[i]
	end
	return math.floor(100 * kills / total_kills)
end

function IsActCleared(act)
	local kills = COverthrowGameMode.act_kills[act]
	local total_kills = COverthrowGameMode.act_kills_max[act]
	if kills >= total_kills then
		return true
	else
		return false
	end
end

function GetRandomTableKey( mytable )
  local numitems = 0 -- find the size of the table
  for k,v in pairs(mytable) do
    numitems = numitems + 1
  end

  local randval = math.random(1, numitems) -- get a random point

  local randentry
  local count = 0
  for k,v in pairs(mytable) do
    count = count + 1
    if (count == randval) then
      randentry = {key = k, val = v}
      return randentry
    end
  end
end

function AddTempleClassAbility( hero, ability, random ) --nil = random
  local templeclass = hero.temple_class
  if templeclass then
    if hero.templeclassabilities then
      hero.templeclassabilities = hero.templeclassabilities + 1
    else
      hero.templeclassabilities = 1
    end
    --print("temple class abilities "..hero.templeclassabilities)
    if hero.templeclassabilities > 5 then --max 5 extra abils
      return
    end
    hero:RemoveAbility("empty_spell"..tostring(hero.templeclassabilities))
    local ability_name = nil
    if random then
      ability_name = GetRandomTempleClassAbility(hero, templeclass)
    else
      ability_name = ability
    end
    if not ability_name then
      return
    end
    --PrecacheItemByNameAsync( ability_name, function(abil) 
    local added_ability = hero:AddAbility(ability_name) --:SetLevel(1)
    if ability_name == "WarriorCharge" or ability_name == "Shield_Reflect" or ability_name == "Terror_ShoutProt" or ability_name == "Terror_ShoutFury" or ability_name == "Terror_Shout" then
      added_ability:SetLevel(1)
    end
    CheckForHeroChargeAbilities(hero)
    --end )
    if false then
      for i=0, 15 do
        local abi = hero:GetAbilityByIndex(i)
        if abi then
          print(abi:GetName().." pos "..i)
        end
      end
    end
  end
end

function GetRandomTempleClassAbility( hero, templeclass )
  local ability_name = GetRandomTableKey(COverthrowGameMode.hero_spells[templeclass]).key
  if hero:HasAbility(ability_name) then
    return GetRandomTempleClassAbility( hero, templeclass )
  else
    return ability_name
  end
end

function RemoveRightmostTempleClassAbility( hero )
  local templeclass = hero.temple_class
  if templeclass then
    for i=1, 5 do
      local index = 6 - i
      local ability = hero:GetAbilityByIndex(index)
      local ability_name
      if ability then
        ability_name = ability:GetName()
      end
      if ability and ability_name and ability_name ~= "empty_spell"..tostring(index) then
        hero.templeclassabilities = index - 1
        hero:RemoveAbility(ability_name)
        hero:AddAbility("empty_spell"..tostring(index)):SetLevel(1)
        return
      end
    end
  end
end

function RemoveTempleHeroAbility(event, args)
  local id = args['player_id']
  local player = PlayerResource:GetPlayer(id)
  if player then
    local hero = player:GetAssignedHero()
    if hero and not hero.remove_temple_ability_cd then
      hero.remove_temple_ability_cd = true
      Timers:CreateTimer(1.5,function() 
        hero.remove_temple_ability_cd = nil
      end)
      RemoveRightmostTempleClassAbility( hero )
    end
  end
end

function ReportLootTables( hero, toAll )
  local player = hero:GetPlayerOwner()
  local normal_table = COverthrowGameMode.last_drop_table_imm
  local artifact_table = COverthrowGameMode.last_drop_table_art_imm
  if hero.report_drop_table_cd then
    return
  end
  hero.report_drop_table_cd = true
  Timers:CreateTimer(2,function() 
    hero.report_drop_table_cd = nil
  end)
  if normal_table then
    for i=#normal_table,1,-1 do
      if normal_table[i] then
        for j=1,#normal_table[i] do 
          if not toAll then
            CustomGameEventManager:Send_ServerToPlayer(player, "additemtodroptable", { item = normal_table[i][j], is_artifact = 0, itemname = "no", attributes = 0, stat1name = "no", stat2name = "no", stat3name = "no", slot = 0, rarity = "no", observer = 0 } )
          else
            CustomGameEventManager:Send_ServerToAllClients("additemtodroptable", { item = normal_table[i][j], is_artifact = 0, itemname = "no", attributes = 0, stat1name = "no", stat2name = "no", stat3name = "no", slot = 0, rarity = "no", observer = 1 } )
          end
        end
      end
    end
  end
  if artifact_table then
    for i=30,1,-1 do
      if artifact_table[i] then
        for j=1,#artifact_table[i] do 
          if not toAll then
            CustomGameEventManager:Send_ServerToPlayer(player, "additemtodroptable", { item = artifact_table[i][j], is_artifact = 1, itemname = COverthrowGameMode:GetMythicWeaponAttributeName(artifact_table[i][j], 0), attributes = COverthrowGameMode:GetMythicWeaponAttributeCount(artifact_table[i][j]), stat1name = COverthrowGameMode:GetMythicWeaponAttributeName(artifact_table[i][j], 1), stat2name = COverthrowGameMode:GetMythicWeaponAttributeName(artifact_table[i][j], 2), stat3name = COverthrowGameMode:GetMythicWeaponAttributeName(artifact_table[i][j], 3), slot = weaponslot, rarity = COverthrowGameMode:GetMythicWeaponQuality(artifact_table[i][j]), observer = 0 } )
          else
            CustomGameEventManager:Send_ServerToAllClients("additemtodroptable", { item = artifact_table[i][j], is_artifact = 1, itemname = COverthrowGameMode:GetMythicWeaponAttributeName(artifact_table[i][j], 0), attributes = COverthrowGameMode:GetMythicWeaponAttributeCount(artifact_table[i][j]), stat1name = COverthrowGameMode:GetMythicWeaponAttributeName(artifact_table[i][j], 1), stat2name = COverthrowGameMode:GetMythicWeaponAttributeName(artifact_table[i][j], 2), stat3name = COverthrowGameMode:GetMythicWeaponAttributeName(artifact_table[i][j], 3), slot = weaponslot, rarity = COverthrowGameMode:GetMythicWeaponQuality(artifact_table[i][j]), observer = 1 } )
          end
        end
      end
    end
  end
end

function EventRequestDropTable(event, args)
  local id = args['player_id']
  local player = PlayerResource:GetPlayer(id)
  local hero = player:GetAssignedHero()
  if player and hero then
    ReportLootTables(hero, false)
  else
    --request by observer? then take first hero
      local all = HeroList:GetAllHeroes()
      hero = all[1]
      if hero then
        ReportLootTables(hero, true)
      end
    end
  end

  function SetSwarmOnDeath( unit, min, max, position_offset, act, force_unit_type, random_offset, jump, spawn_points)
    unit.swarm_on_death = act
    unit.swarm_on_death_jumptolocation = jump
    if position_offset then
      unit.swarm_on_death_position = unit:GetAbsOrigin() + position_offset
    end
    if random_offset then
      unit.swarm_on_death_random_offset = random_offset
    end
    if spawn_points then
      unit.spawn_point_list = spawn_points
    end
    unit.swarm_on_death_mincount = min
    unit.swarm_on_death_maxcount = max
    if force_unit_type then
      unit.swarm_on_death_force_unit_type = force_unit_type
    end
  end

  function CinematicKill( unit, attacker, kill_ability, duration, attack_delay, jump )
    local jumptime = 2
    --StartAnimation(attacker, {activity=ACT_DOTA_ATTACK, duration=attack_delay*1.25, rate=0.8/attack_delay})
    unit:GetAbilityByIndex(0):ApplyDataDrivenModifier(unit, unit, "modifier_invulnerable", {Duration = -1})
    attacker:FindAbilityByName("pveboss_system"):ApplyDataDrivenModifier(attacker, attacker, "modifier_invulnerable", {Duration = duration})
    --smoke
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_slark/slark_shadow_dance_outer_smoke.vpcf", PATTACH_POINT_FOLLOW, attacker)
    ParticleManager:SetParticleControl(particle, 0, attacker:GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 1, attacker:GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 2, attacker:GetAbsOrigin())
    --StartAnimation(unit, {activity=ACT_DOTA_RUN, duration=delay*1.25, rate=1.0/delay})
    local order = 
    {
      UnitIndex = unit:entindex(),
      OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
      Position = unit:GetAbsOrigin()+unit:GetForwardVector()*125*duration,
      Queue = false
    }
    Timers:CreateTimer(0.1,function()
      ExecuteOrderFromTable(order)
      if unit.lama then
        order.UnitIndex = unit.lama:entindex()
        ExecuteOrderFromTable(order)
        if unit.lama.lama then
          order.UnitIndex = unit.lama.lama:entindex()
          ExecuteOrderFromTable(order)
        end
      end
    end)
    Timers:CreateTimer(attack_delay-jumptime,function()
      ParticleManager:DestroyParticle( particle, true )
      ParticleManager:ReleaseParticleIndex(particle)
      if jump then
        local attack_spot = unit:GetAbsOrigin()+unit:GetForwardVector()*125*jumptime
        attack_spot = attack_spot - (attack_spot-attacker:GetAbsOrigin()):Normalized()*125
        LeapToLocation(attacker, attack_spot, jumptime)
      end
    end)
    local all = HeroList:GetAllHeroes()
    for j=1, #all do
      kill_ability:ApplyDataDrivenModifier(attacker, all[j], "modifier_stunned", {Duration = duration})
      PlayerResource:SetCameraTarget(all[j]:GetPlayerOwnerID(), unit)
      Timers:CreateTimer(duration,function() 
        PlayerResource:SetCameraTarget(all[j]:GetPlayerOwnerID(), nil)
      end)
    end
    for i=0,duration*3-attack_delay*3+6 do
      Timers:CreateTimer(attack_delay+i*0.33,function()
        if unit and not unit:IsNull() then
          if i == 0 then
            BloodArcana({caster = attacker, target = unit, ignore_crit_effect_cooldown = true})
            EmitSoundOn("Hero_PhantomAssassin.CoupDeGrace", unit)
          end
          if i == math.floor(duration*3-attack_delay*3) then
            unit:RemoveModifierByName("modifier_invulnerable")
            BloodArcana({caster = attacker, target = unit, ignore_crit_effect_cooldown = true})
            EmitSoundOn("Hero_PhantomAssassin.CoupDeGrace", unit)
            unit:Kill(kill_ability, attacker)
            if unit.lama then
              unit.lama:Kill(kill_ability, attacker)
              if unit.lama.lama then
                unit.lama.lama:Kill(kill_ability, attacker)
              end
            end
          end
          if i % 4 == 1 then
            EmitSoundOn("crystalmaiden_cm_pain_0"..(i%5)+1, unit)
          end
          local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_bloodseeker/bloodseeker_rupture_nuke.vpcf", PATTACH_WORLDORIGIN, unit)
          ParticleManager:SetParticleControl(particle, 0, unit:GetAbsOrigin())
          ParticleManager:ReleaseParticleIndex(particle)
        end
      end)
    end
  end

  function CinematicApproachMessage(event)
    local target = event.caster
    local id = target.id
    local sound
    local text
    local delay = 0.1
    local dur = 8
    if id and id == 0 and not target.cinematic_message_triggered and (event.target:GetAbsOrigin()-target:GetAbsOrigin()):Length() <= 250 then
      dur = 12
      target.cinematic_message_triggered = true
      text = "Nabu: Only the Tree of Eternity can bring Cain's daughters back to life. But he can't do it alone: You need to find the 10 Essences of Life and bring them to him. You can find the Essences in the Titan Temple. Open the Teleporter by pressing K to teleport to the Titan Temple."
        Timers:CreateTimer(11,function()
          target.cinematic_message_triggered = false
        end)
        --ac1 cleared and nabu found = tp to temple active
        if COverthrowGameMode.act11_bosses_spawned then
          COverthrowGameMode.teleporters[8].tp_active = true
          CustomGameEventManager:Send_ServerToAllClients( "tp_unlocked", {value = 8} )
        end
      end
      if id and id == 1 and not target.cinematic_message_triggered then
        target.cinematic_message_triggered = true
        sound = "lycan_lycan_ability_summon_05"
        text = "Moogla the Wild: Now my wolves will feast... on your other daughter, Cain!"
      end
      if id and id == 2 and not target.cinematic_message_triggered then
        target.cinematic_message_triggered = true
        text = "Furycat: Wow! So Llama, very meat, much eat!"
        dur = 12
        CinematicKill( target.cinematic_lama, target, target:GetAbilityByIndex(0), 4, 3, true )
        target:GetAbilityByIndex(0):ApplyDataDrivenModifier(target, target, "modifier_silence", {Duration = 5})
        target:GetAbilityByIndex(0):ApplyDataDrivenModifier(target, target, "modifier_disarmed", {Duration = 5})
      end
      if id and id == 11 and not target.cinematic_message_triggered then
        target.cinematic_message_triggered = true
        sound = "lycan_lycan_battlebegins_01"
        text = "Venrir, Titan of the Forest: Ha! The savagery starts now..."
      end
      if id and id == 12 and not target.cinematic_message_triggered then
        target.cinematic_message_triggered = true
        sound = "venomancer_venm_rare_01"
        text = "Scorxix, Titan of the Desert: I'm a perfect 10... on the pain scale!"
      end
      if id and id == 13 and not target.cinematic_message_triggered then
        target.cinematic_message_triggered = true
        sound = "medusa_medus_rival_08"
        text = "Meduva, Titan of Water: Wriggle back to the water, little fish!"
      end
      if id and id == 14 and not target.cinematic_message_triggered then
        target.cinematic_message_triggered = true
        sound = "terrorblade_terr_attack_05"
        text = "Shalcaasac, Titan of Darkness: Fear he who fears nothing!"
      end
      if id and id == 15 and not target.cinematic_message_triggered then
        target.cinematic_message_triggered = true
        sound = "viper_vipe_rare_03"
        text = "Yiro, Titan of the Sky: Who needs legs... when you got wings?"
      end
      if id and id == 16 and not target.cinematic_message_triggered then
        target.cinematic_message_triggered = true
        sound = "beastmaster_beas_cast_06"
        text = "Nanook, Titan of the Mountain: You should pray... you are prey!"
      end
      if id and id == 17 and not target.cinematic_message_triggered then
        target.cinematic_message_triggered = true
        sound = "death_prophet_dpro_respawn_01"
        text = "Sylvana, Titan of the Dead: Please, bury me deeper next time!"
      end
      if id and id == 18 and not target.cinematic_message_triggered then
        target.cinematic_message_triggered = true
        sound = "chaos_knight_chaknight_rare_04"
        text = "Sulros, Titan of Fire: I am a Fundamental of the universe."
      end
      if id and id == 19 and not target.cinematic_message_triggered then
        target.cinematic_message_triggered = true
        sound = "beastmaster_beas_spawn_06"
        text = "Kong King, Titan of Power: I'm a natural disaster!"
      end
      if id and id == 20 and not target.cinematic_message_triggered then
        target.cinematic_message_triggered = true
        sound = "omniknight_omni_kill_08"
        text = "Rikdal, Titan of the Elements: Your time has come!"
      end
      if id and id == 21 and not target.cinematic_message_triggered and (event.target:GetAbsOrigin()-target:GetAbsOrigin()):Length() <= 600 then
        target.cinematic_message_triggered = true
        COverthrowGameMode.main_quests_completed = COverthrowGameMode.main_quests_completed + 1
        EmitGlobalSound("treant_treant_spawn_04")
        delay = 15
        dur = 22
        text = "Cain: You have brought my daughters back! I can't believe it! Thank you, Tree of Eternity, thank you, brave adventurers! Here, take this treasure, it's yours, you earned it!"
        sound = "beastmaster_beas_thanks_01"
        --spawn cain daughters
        Timers:CreateTimer(7.5,function()
          local tree_position = COverthrowGameMode.treeoflife:GetAbsOrigin() + Vector(0,-150,0)
          local unit = CreateUnitByName("act_1_son", tree_position+Vector(0,0,0), true, nil, nil, DOTA_TEAM_GOODGUYS )
          COverthrowGameMode.quest_escort_1_units = {}
          COverthrowGameMode.quest_escort_1_units[1] = unit
          unit:SetForwardVector(Vector(-1,-1,0))
          local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_omniknight/omniknight_guardian_angel_ally.vpcf", PATTACH_POINT_FOLLOW, unit)
          ParticleManager:ReleaseParticleIndex(particle)
          particle = ParticleManager:CreateParticle("particles/units/heroes/hero_treant/treant_overgrowth_cast.vpcf", PATTACH_POINT_FOLLOW, unit)
          ParticleManager:ReleaseParticleIndex(particle)
          unit:GetAbilityByIndex(0):ApplyDataDrivenModifier(unit, unit, "modifier_cant_die", {Duration = -1})
          unit = CreateUnitByName("act_1_son", tree_position+Vector(-125,125,0), true, nil, nil, DOTA_TEAM_GOODGUYS )
          COverthrowGameMode.quest_escort_1_units[2] = unit
          unit:SetForwardVector(Vector(-1,-1,0))
          particle = ParticleManager:CreateParticle("particles/units/heroes/hero_omniknight/omniknight_guardian_angel_ally.vpcf", PATTACH_POINT_FOLLOW, unit)
          ParticleManager:ReleaseParticleIndex(particle)
          particle = ParticleManager:CreateParticle("particles/units/heroes/hero_treant/treant_overgrowth_cast.vpcf", PATTACH_POINT_FOLLOW, unit)
          ParticleManager:ReleaseParticleIndex(particle)
          unit:GetAbilityByIndex(0):ApplyDataDrivenModifier(unit, unit, "modifier_cant_die", {Duration = -1})
          EmitSoundOn("DOTA_Item.EtherealBlade.Target", unit)
          Timers:CreateTimer(2,function()
            EmitGlobalSound("treant_treant_respawn_03")
          end)
          Timers:CreateTimer(20.0,function()
            unit = CreateUnitByName("temple_chest", tree_position+Vector(-450,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            unit:SetModelScale(2)
            unit.main_quest_boss = 13
            unit.act = 12 --belongs to jungle act
            unit.nobosskill = true
            --unit.cain_reward = true
            COverthrowGameMode:SetTempleStats(unit,COverthrowGameMode.jungledifficulty*2.2,0,1000,100,0)
            EmitSoundOn("DOTA_Item.Hand_Of_Midas", unit)

            unit = CreateUnitByName("temple_chest", tree_position+Vector(-575,125,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            unit:SetModelScale(2)
            unit.main_quest_boss = 14 -- no text for this chest, enough if one triggers msg
            unit.act = 12 --belongs to jungle act
            unit.nobosskill = true
            --unit.cain_reward = true
            COverthrowGameMode:SetTempleStats(unit,COverthrowGameMode.jungledifficulty*2.2,0,1000,100,0)
            Timers:CreateTimer(20.0,function()
              Notifications:BottomToAll({text="Villager Cain: Please escort my daughters back home to my village, so I can finally see them again!", duration=15, style={color="white"}})
              COverthrowGameMode.quest_escort_1 = 1
            end)
          end)
        end)
      end
      if sound then
        Timers:CreateTimer(delay,function()
          EmitGlobalSound(sound)
        end)
        Timers:CreateTimer(delay+5,function()
          EmitGlobalSound("Conquest.Stinger.HulkCreep")
        end)
      end
      if text then
        Timers:CreateTimer(delay,function()
          Notifications:BottomToAll({text=text, duration=dur, style={color="white"}})
        end)
      end
    end

    function CinematicKillMessage(act)
      local sound
      local text
      local delay = 0.1
      local dur = 15
      if act == 1 then
        delay = 6
        dur = 20
        text = "Villager Cain: We are too late! My other daughter is dead too. Please go on and look for Nabu, the Spirit of the Forest. Maybe she knows a way to bring them back to life..."
      end
      if act == 2 then
        delay = 6
        dur = 15
        text = "Farmer Pete: Thank you for defeating this evil cat. Now I am safe again! Nabu told me that you must go to the Titan Temple now to retrieve the Essence of the Desert!"
      end
      if act == 3 then
        delay = 6
        dur = 20
        text = "Nabu: Thank you for making the Riverlands safe again. Please teleport to the Titan Temple and kill Meduva to find the Essence of Water!"
      end
      if act == 4 then
        delay = 6
        dur = 20
        text = "Nabu: Thanks for saving the Shadowlands. Please teleport to the Titan Temple now and locate the Essence of Darkness."
        CheckForClassQuestRewards("Shadowland Assault")
      end
      if act == 5 then
        delay = 6
        dur = 20
        text = "Nabu: The corrupted Dragons are finally eliminated. Please teleport to the Titan Temple and get the Essence of the Sky."
      end
      if act == 6 then
        delay = 6
        dur = 20
        text = "Nabu: Thank you for stopping the invasion on Highmountain. Please teleport to the Titan Temple and retrieve the Essence of the Mountain."
      end
      if act == 7 then
        delay = 6
        dur = 20
        text = "Farmer Pete: Thank you for protecting me again, the tombs should now be sealed. Nabu said you can get the Essence of the Dead from Sylvana in the Titan Temple."
      end
      if act == 8 then
        delay = 6
        dur = 20
        text = "Nabu: Thank you for stopping the Lava Imp invasion. Please take the teleporter to the Titan Temple and locate the Essence of Fire."
      end
      if act == 9 then
        delay = 6
        dur = 20
        text = "Nabu: Thanks for defeating the armies of Mogushan. Please take the teleporter to the Titan Temple now and retrieve the Essence of Power."
      end
      if act == 10 then
        delay = 6
        dur = 20
        text = "Nabu: Thanks for defeating Kiirion and restoring order to the Arcane Sanctum. Please take the teleporter to the Titan Temple and find the Essence of Elements."
      end
      if act == 11 then
        delay = 6
        dur = 20
        text = "Nabu: Finally the Titan Temple is purged from all evil! Now there is only one last thing left to do: Go to the Jungle of Zul'Juru and slay the King of the Jungle, in order to get access to the Tree of Eternity!"
        end
        if act == 12 then
          delay = 6
          dur = 30
          text = "Nabu: The King of the Jungle is dead! If you have collected all 10 Essences of Life, you can go to the Tree of Eternity now and revive Cain's daughters."
        end
        if sound then
          Timers:CreateTimer(delay,function()
            EmitGlobalSound(sound)
          end)
        end
        if text then
          Timers:CreateTimer(delay,function()
            Notifications:BottomToAll({text=text, duration=dur, style={color="white"}})
          end)
        end
        --nabu spawn on any cinematic kill (endboss)
        if not COverthrowGameMode.nabu then
          local unit = CreateUnitByName("act_1_nabu", COverthrowGameMode.teleporters[1]:GetAbsOrigin()+Vector(400,-600,0), true, nil, nil, DOTA_TEAM_GOODGUYS )
          unit:SetForwardVector(Vector(-1,0,0))
          SetCinematicApproachMessage(unit, 0)
          COverthrowGameMode.nabu = unit
          COverthrowGameMode.nabu.spawn_pos = COverthrowGameMode.nabu:GetAbsOrigin()
        end
      end

      function COverthrowGameMode:SetCinematicApproachMessage( target, id )
        SetCinematicApproachMessage( target, id )
      end

      function SetCinematicApproachMessage( target, id )
        target.id = id
        target:AddAbility("cinematic_approach_message"):SetLevel(1)
      end

      function MogushanSpawnRound( scale, zone )
       if not COverthrowGameMode.mogushan_round then
        COverthrowGameMode.mogushan_round = 0
      end
      local isFirstRound = false
      local last_round = COverthrowGameMode.max_mogushan_rounds
      local is_last_round = COverthrowGameMode.mogushan_round == last_round
      local tab = {}
      tab.Duration = -1
      local c1 = Entities:FindByName( nil, "mogushan" ):GetAbsOrigin()
      local unit
      COverthrowGameMode.mogushan_round = COverthrowGameMode.mogushan_round + 1
      local merge_boss_final_round = 30
      scale = scale + COverthrowGameMode.jungledifficulty * 0.1 --* (COverthrowGameMode.mogushan_round - 1) -- +10% per round
      
      local initial_monster_formation = 1 + ((COverthrowGameMode.mogushan_round - 1) % 4)   -- math.random(1,4)
      local act = math.random(1,9)
      if COverthrowGameMode.mogushan_round == 5 then
        act = 9
        initial_monster_formation = 2
      end
      if COverthrowGameMode.mogushan_round == 1 then
        act = 9
        initial_monster_formation = 2
        isFirstRound = true
      end
      if is_last_round then
        initial_monster_formation = 1
      end

      --round 21 to 30 = new bosses
      local titan_father_round = false
      if (COverthrowGameMode.mogushan_round >= 25 and COverthrowGameMode.mogushan_round <= 30) then
        initial_monster_formation = 1 --math.random(1,2)
        titan_father_round = true
      end

      if initial_monster_formation == 1 then
        --1 boss + 1 affix      -- 2 champ
        local boss = COverthrowGameMode.bosses[act][math.random(1,#COverthrowGameMode.bosses[act])]
        local override_act = 1
        local bossnumber = COverthrowGameMode.mogushan_round - 24
        local titan_father_affixes = 1
        if titan_father_round then
          boss = "merge_boss_arena_" .. tostring(bossnumber)
        end
        local unit = CreateUnitByName(boss, c1, true, nil, nil, DOTA_TEAM_BADGUYS )
        --add super boss abilities
        if titan_father_round then
          if bossnumber == 1 then
            override_act = 2
            if math.random(1,100) <= 50 then
              override_act = 6
            end
            COverthrowGameMode:AddSeveralSuperBossAbilities(unit, 2, 3)
            COverthrowGameMode:AddSeveralSuperBossAbilities(unit, 6, 3)
          end
          if bossnumber == 2 then
            override_act = 8
            if math.random(1,100) <= 50 then
              override_act = 12
            end
            COverthrowGameMode:AddSeveralSuperBossAbilities(unit, 8, 3)
            COverthrowGameMode:AddSeveralSuperBossAbilities(unit, 12, 3)
          end
          if bossnumber == 3 then
            override_act = 9
            if math.random(1,100) <= 50 then
              override_act = 11
            end
            COverthrowGameMode:AddSeveralSuperBossAbilities(unit, 9, 2)
            COverthrowGameMode:AddSeveralSuperBossAbilities(unit, 11, 2)
            unit.can_have_affixes = true
            titan_father_affixes = 3
          end
          if bossnumber == 4 then
            override_act = 3
            if math.random(1,100) <= 50 then
              override_act = 5
            end
            COverthrowGameMode:AddSeveralSuperBossAbilities(unit, 3, 3)
            COverthrowGameMode:AddSeveralSuperBossAbilities(unit, 5, 3)
          end
          if bossnumber == 5 then
            override_act = 1
            if math.random(1,100) <= 50 then
              override_act = 13
            end
            COverthrowGameMode:AddSeveralSuperBossAbilities(unit, 1, 3)
            COverthrowGameMode:AddSeveralSuperBossAbilities(unit, 13, 3)
          end
          if bossnumber == 6 then
            override_act = 4
            if math.random(1,100) <= 66 then
              override_act = 7
            end
            if math.random(1,100) <= 33 then
              override_act = 10
            end
            COverthrowGameMode:AddSeveralSuperBossAbilities(unit, 4, 2)
            COverthrowGameMode:AddSeveralSuperBossAbilities(unit, 7, 2)
            COverthrowGameMode:AddSeveralSuperBossAbilities(unit, 10, 2)
          end
          zone = override_act
          act = override_act
        end
        local boss_pointer = unit
        COverthrowGameMode.current_mogushan_arena_boss = unit
        if act == 9 then
          unit.act_specific_loot_factor = 3
        end
        if COverthrowGameMode.mogushan_round == last_round then
          unit.drop_chance_factor = 1000
        end
        unit.act = zone
        COverthrowGameMode:SetTempleStats(unit,scale,125,15000,100,titan_father_affixes)
        unit:SetForwardVector(Vector(0,-1,0))
        unit.templeboss_mogushan = 1
        --set event at 50
        --[[
        Timers:CreateTimer(1,function()
            if boss_pointer and not boss_pointer:IsNull() then
                if boss_pointer:GetHealth() / boss_pointer:GetMaxHealth() <= 0.5 then
                    MogushanBattleEvent( boss_pointer, act )
                else
                    return 1
                end
            end
        end)
        --champs
        local champ = GetRandomMonsterNameByAct(act)
        unit = CreateUnitByName(champ, c1+Vector(250,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
        unit.chance_for_champion = 100
        unit.champion_affixes_max = 1
        COverthrowGameMode:SetTempleStats(unit,scale,50,750,0,0)
        unit:SetForwardVector(Vector(0,-1,0))
        unit = CreateUnitByName(champ, c1+Vector(-250,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
        unit.chance_for_champion = 100
        unit.champion_affixes_max = 1
        COverthrowGameMode:SetTempleStats(unit,scale,50,750,0,0)
        unit:SetForwardVector(Vector(0,-1,0))
        if COverthrowGameMode.mogushan_round == last_round then
            unit = CreateUnitByName(champ, c1+Vector(0,-250,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.chance_for_champion = 100
            unit.champion_affixes_max = 2
            COverthrowGameMode:SetTempleStats(unit,scale,50,750,0,0)
            unit:SetForwardVector(Vector(0,-1,0))
          end]]
        end
        if initial_monster_formation == 3 then
          --1 mega champ        -- 2 events
          local boss = COverthrowGameMode.bosses[act][math.random(1,#COverthrowGameMode.bosses[act])]
          local override_act = 1
          local titan_father_affixes = 0
          local unit = CreateUnitByName(boss, c1, true, nil, nil, DOTA_TEAM_BADGUYS )
          local boss_pointer = unit
          COverthrowGameMode.current_mogushan_arena_boss = unit
          if act == 9 then
            unit.act_specific_loot_factor = 3
          end
          if COverthrowGameMode.mogushan_round == last_round then
            unit.drop_chance_factor = 1000
          end
          unit.act = zone
          COverthrowGameMode:SetTempleStats(unit,scale,125,15000,100,titan_father_affixes)
          unit:SetForwardVector(Vector(0,-1,0))
          unit.templeboss_mogushan = 1

          local aggroAbility = GetRandomPassiveAggroAbilityOrMS()
          --unit 1
          champ = GetRandomMonsterNameByAct(act)
          unit = CreateUnitByName(champ, c1+Vector(225,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
          unit.act = zone
          COverthrowGameMode:SetTempleStats(unit,scale,150,1500,0,0)
          unit:SetForwardVector(Vector(0,-1,0))
          unit:AddAbility(aggroAbility):SetLevel(1)
          --unit 2
          unit = CreateUnitByName(champ, c1+Vector(-225,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
          unit.act = zone
          COverthrowGameMode:SetTempleStats(unit,scale,150,1500,0,0)
          unit:SetForwardVector(Vector(0,-1,0))
          unit:AddAbility(aggroAbility):SetLevel(1)
          --unit 1
          champ = GetRandomMonsterNameByAct(act)
          unit = CreateUnitByName(champ, c1+Vector(450,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
          unit.act = zone
          COverthrowGameMode:SetTempleStats(unit,scale,200,1000,0,0)
          unit:SetForwardVector(Vector(0,-1,0))
          unit:AddAbility(aggroAbility):SetLevel(1)
          --unit 2
          unit = CreateUnitByName(champ, c1+Vector(-450,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
          unit.act = zone
          COverthrowGameMode:SetTempleStats(unit,scale,200,1000,0,0)
          unit:SetForwardVector(Vector(0,-1,0))
          unit:AddAbility(aggroAbility):SetLevel(1)
        end
        if initial_monster_formation == 2 then
          --1 boss  horde     --3 champs
          local actAffixes = 2
          local chance_for_champion = 100
          local champ = GetRandomMonsterNameByAct(act)
          if isFirstRound then
           champ = "mogushan_first_boss"
           actAffixes = 0
           chance_for_champion = 0
         end
         local unit = CreateUnitByName(champ, c1, true, nil, nil, DOTA_TEAM_BADGUYS )
         local boss_pointer = unit
         COverthrowGameMode.current_mogushan_arena_boss = unit
         if act == 9 then
          unit.act_specific_loot_factor = 3
        end
        if COverthrowGameMode.mogushan_round == last_round then
          unit.drop_chance_factor = 1000
        end
        unit.act = zone
        unit.chance_for_champion = chance_for_champion
        unit.templeboss_mogushan = 1
        unit.isboss = 1
        AddActAffixes(unit, actAffixes)
        COverthrowGameMode:SetTempleStats(unit,scale,125,3000,100,2)
        unit:SetForwardVector(Vector(0,-1,0))
      end
      if initial_monster_formation == 4 then
        --1 champ 2 bouncers     --3 champs
        local champ = GetRandomMonsterNameByAct(act)
        local unit = CreateUnitByName(champ, c1, true, nil, nil, DOTA_TEAM_BADGUYS )
        local boss_pointer = unit
        COverthrowGameMode.current_mogushan_arena_boss = unit
        if act == 9 then
          unit.act_specific_loot_factor = 3
        end
        if COverthrowGameMode.mogushan_round == last_round then
          unit.drop_chance_factor = 1000
        end
        unit.act = zone
        unit.chance_for_champion = 100
        unit.templeboss_mogushan = 1
        unit.isboss = 1
        COverthrowGameMode:SetTempleStats(unit,scale,125,3000,100,0)
        unit:SetForwardVector(Vector(0,-1,0))

        local aggroAbility = GetRandomPassiveAggroAbilityOrMS()
        --unit 1
        champ = GetRandomMonsterNameByAct(act)
        unit = CreateUnitByName(champ, c1+Vector(250,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
        unit.act = zone
        COverthrowGameMode:SetTempleStats(unit,scale,250,2500,0,0)
        unit:SetForwardVector(Vector(0,-1,0))
        unit:AddAbility(aggroAbility):SetLevel(1)
        --unit 2
        unit = CreateUnitByName(champ, c1+Vector(-250,0,0), true, nil, nil, DOTA_TEAM_BADGUYS )
        unit.act = zone
        COverthrowGameMode:SetTempleStats(unit,scale,250,2500,0,0)
        unit:SetForwardVector(Vector(0,-1,0))
        unit:AddAbility(aggroAbility):SetLevel(1)
      end
      print("initial_monster_formation: " .. initial_monster_formation)
    end

    function MogushanBattleEvent( unit, act )
      local event = math.random(1,4)
      local spawn_points = {}
      local scale = unit.pvescale
      spawn_points[1] = Entities:FindByName( nil, "mogushan1" ):GetAbsOrigin()
      spawn_points[2] = Entities:FindByName( nil, "mogushan2" ):GetAbsOrigin()
      spawn_points[3] = Entities:FindByName( nil, "mogushan3" ):GetAbsOrigin()
      spawn_points[4] = Entities:FindByName( nil, "mogushan4" ):GetAbsOrigin()
      if event == 1 then
        --swarm over time
        for i=1,6 do
          Timers:CreateTimer(4*i-3.5,function()
            SpawnMonsterSwarm( act, 3, 5, unit, false, false, false, true, spawn_points, scale )
          end)
        end
      end
      if event == 2 then
        --swarm burst
        for i=1,4 do
          Timers:CreateTimer(2*i,function()
            SpawnMonsterSwarm( act, 3, 5, unit, false, false, false, true, spawn_points, scale )
          end)
        end
      end
      if event == 3 then
        --2 champs
        for i=1,2 do
          --Timers:CreateTimer(2*i,function()
          SpawnMonsterSwarm( act, 1, 1, unit, false, false, true, true, spawn_points, scale )
          --end)
        end
      end
      if event == 4 then
        --1 champ, half swarm
        SpawnMonsterSwarm( act, 1, 1, unit, false, false, true, true, spawn_points, scale )
        for i=1,3 do
          Timers:CreateTimer(6*i-5,function()
            SpawnMonsterSwarm( act, 3, 5, unit, false, false, false, true, spawn_points, scale )
          end)
        end
      end
    end

    function ActEntered( act )
      --print("entered act "..act)
      CustomGameEventManager:Send_ServerToAllClients("actentered", { act = act } )
      local items = GetActSpecificItems( act )
      for j=1,#items do 
        CustomGameEventManager:Send_ServerToAllClients("additemtoactenter", { item = items[j], is_artifact = 0, itemname = "no", attributes = 0, stat1name = "no", stat2name = "no", stat3name = "no", slot = 0, rarity = "no", observer = 1 } )
      end
    end

    function AddGoldToAllPlayers( gold )
      Notifications:BottomToAll({text="This Gold Bandit dropped "..gold.." Gold for all Heroes.", duration=8, style={color="yellow"}})
      local all = HeroList:GetAllHeroes()
      for j=1, #all do
        --all[j]:SetGold(all[j]:GetGold()+gold, true)
        --all[j]:SetGold(0, false)
        AddGold(all[j], gold)
        local particle = ParticleManager:CreateParticle( "particles/econ/items/alchemist/alchemist_midas_knuckles/alch_knuckles_lasthit_coins.vpcf", PATTACH_CUSTOMORIGIN, all[j])
        ParticleManager:SetParticleControl(particle, 1, all[j]:GetAbsOrigin())
        ParticleManager:ReleaseParticleIndex(particle)
      end
    end

    function CreateAct11MergeBoss( boss1, boss2, delay )
      local pos1 = Entities:FindByName( nil, "act11".."_"..boss1 ):GetAbsOrigin()
      local pos2 = Entities:FindByName( nil, "act11".."_"..boss2 ):GetAbsOrigin()
      local center = Entities:FindByName( nil, "act11_center" ):GetAbsOrigin()
      local scale = COverthrowGameMode.jungledifficulty * 2
      for i=1,delay do
        Timers:CreateTimer(i,function()
          local particle = ParticleManager:CreateParticle( "particles/econ/items/monkey_king/arcana/death/mk_spring_arcana_death_souls_line.vpcf", PATTACH_WORLDORIGIN, nil)
          ParticleManager:SetParticleControl(particle, 0, pos1)
          ParticleManager:SetParticleControl(particle, 4, center)
          ParticleManager:ReleaseParticleIndex(particle)
          particle = ParticleManager:CreateParticle( "particles/econ/items/monkey_king/arcana/death/mk_spring_arcana_death_souls_line.vpcf", PATTACH_WORLDORIGIN, nil)
          ParticleManager:SetParticleControl(particle, 0, pos2)
          ParticleManager:SetParticleControl(particle, 4, center)
          ParticleManager:ReleaseParticleIndex(particle)
          EmitGlobalSound("Item.GlimmerCape.Activate")
          if i == 19 then
            Notifications:BottomToAll({text="Nabu: The souls of the Titans... this can't be... they seem to be merging...", duration=8, style={color="lightgreen"}})
          end
        end)
      end
      
      Timers:CreateTimer(delay,function()
        Timers:CreateTimer(2,function()
          Notifications:BottomToAll({text="Nabu: A new Titan was created!", duration=3, style={color="lightgreen"}})
        end)
        EmitGlobalSound("DOTA_Item.EtherealBlade.Target")
        local name = "merge_boss_"..boss1..""..boss2
        local unit = CreateUnitByName(name, center, true, nil, nil, DOTA_TEAM_BADGUYS )
        unit.act = boss1
        unit.is_merge_boss = 1 --for better loot from these
        COverthrowGameMode.act_1_final_boss = unit
        unit:AddAbility(GetMergeBossAbilityByAct(boss1)):SetLevel(1)
        if math.random(1,100) <= 50 then
          unit.act = boss2
          COverthrowGameMode:AddSeveralSuperBossAbilities(unit, boss1, 2)
          COverthrowGameMode:AddSeveralSuperBossAbilities(unit, boss2, 3)
        else
          COverthrowGameMode:AddSeveralSuperBossAbilities(unit, boss2, 2)
          COverthrowGameMode:AddSeveralSuperBossAbilities(unit, boss1, 3)
        end
        unit.act11_boss = 10 + boss2 / 2
        unit.act11_merge_boss = boss1
        COverthrowGameMode.act_affix_roll = math.random(1,#COverthrowGameMode.act_affixes)
        COverthrowGameMode:SetTempleStats(unit,scale,115,20000,100,0)
        COverthrowGameMode.act_affix_roll = nil
        unit:SetForwardVector(Vector(0,-1,0))
        local ability = unit:GetAbilityByIndex(0)
        ability:ApplyDataDrivenModifier(unit, unit, "modifier_stunned", {Duration = 5})
        ability:ApplyDataDrivenModifier(unit, unit, "modifier_invulnerable", {Duration = 5})
        if boss1 == 3 and boss2 == 4 then
          local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_enigma/enigma_ambient_body.vpcf", PATTACH_POINT_FOLLOW, unit)
          ParticleManager:ReleaseParticleIndex(particle)
        end
        local particle = ParticleManager:CreateParticle( "particles/econ/items/monkey_king/arcana/death/mk_spring_arcana_death_souls.vpcf", PATTACH_POINT_FOLLOW, unit)
        ParticleManager:ReleaseParticleIndex(particle)
        Timers:CreateTimer(5,function()
          local text = "Warg: The predator returns!"
          local sound = "lycan_lycan_respawn_10"
          if boss1 == 3 then
            text = "Nightflow: You summon... the summoner!"
            sound = "warlock_warl_spawn_02"
          end
          if boss1 == 5 then
            text = "Icarus: Nature's Guardian returns!"
            sound = "furion_furi_respawn_11"
          end
          if boss1 == 7 then
            text = "Bahamut: From the hell of hells I come!"
            sound = "terrorblade_terr_spawn_05"
          end
          if boss1 == 9 then
            text = "Minotaar: I'm born anew to this plane!"
            sound = "chaos_knight_chaknight_respawn_09"
          end
          EmitGlobalSound(sound)
          Notifications:BottomToAll({text=text, duration=5, style={color="white"}})
        end)
      end)
    end

    function GetMergeBossAbilityByAct( act )
      local abils = {
        "pve_temple_aoe_dmg_range_sandstorm_knockback",
        "none",
        "pve_temple_add_keep_close",
        "none",
        "pve_trap_turning_dragons",
        "none",
        "pve_wave_caller_3",
        "none",
        "pve_wave_caller_2",
        "none"
      }
      return abils[act]
    end

    function COverthrowGameMode:CreateAct7Omni()
      local scale = self.jungledifficulty * 1.6
      local unit = CreateUnitByName("temple_tomb_boss_5", Entities:FindByName( nil, "cathedral" ):GetAbsOrigin(), true, nil, nil, DOTA_TEAM_BADGUYS )
      unit.act = 7
      self:SetTempleStats(unit,scale,250,25000,100,0)
      unit.templeboss_tomb = 1
      unit.ischallengeboss = 1
      unit:SetForwardVector(Vector(0,-1,0))
      unit.loot_hoarder_on_death_chance = 100
      unit.quest_trigger_class = "Haunting the Dead"
      Timers:CreateTimer(13,function()
        EmitGlobalSound("omniknight_omni_rare_01")
      end)
      Timers:CreateTimer(18,function()
        Notifications:BottomToAll({text="Nabu: Did you hear that? It seems like someone left the church... is our Bishop still alive?", duration=8, style={color="lightgreen"}})
      end)
    end

    function PVEUnitCastSpell( event )
      local caster = event.caster
      local ability = event.event_ability
      local delay = 0
      if ability and caster and caster.display_casting_spells then 
        --if not caster:HasModifier("pve_champion_extra_resistances") then -- only show alert quickly on champions
          --    delay = 4
          --end
          local name = ability:GetName()
          local id = caster:GetEntityIndex()
          Timers:CreateTimer(delay,function()
            CustomGameEventManager:Send_ServerToAllClients( "report_monster_spellcast", {ability = name, unit = id} )
          end)
        end
      end

      function PVEUnitDiscoverAffixes( caster )
        local delay = 0
        if caster then
          if caster:GetUnitName() == "temple_spike_trap" or caster:GetUnitName() == "temple_missile_trap" then
            return
          end
          local data = {}
          local monstertype = 1 --regular
          if not caster:GetAbilityByIndex(0) then --or caster:GetAbilityByIndex(0):GetName() == "pveboss_system" then
            return --discover all units with a spell
          end
          --fix pet combat ability on some units
          caster:RemoveAbility("combat_system_pet")
          caster:RemoveModifierByName("modifier_pet_dps")
          local ability_index = 1
          for i=0,6 do
            local ability = caster:GetAbilityByIndex(i)
            if ability and ability:GetName() ~= "pveboss_system" and ability_index <= 6 then
              --print(ability:GetName() .. "  "..(i+1))
              data["ability"..ability_index] = ability:GetName()
              ability_index = ability_index + 1
            else
              --data["ability"..(i+1)] = nil
            end
          end
          --print(data["ability1"])
          if not data["ability1"] then
            return
          end
          if caster:HasModifier("pve_champion_extra_resistances") then
            monstertype = 2
          end
          if caster:HasModifier("pve_boss_extra_resistances") then
            monstertype = 3
          end
          if caster:HasModifier("pve_boss_extra_resistances") and caster.act11_boss then
            monstertype = 4
          end
          if monstertype == 1 then
            return
          end
          data["unit"] = caster:GetUnitName()
          data["monstertype"] = monstertype
          Timers:CreateTimer(delay,function()
            CustomGameEventManager:Send_ServerToAllClients( "report_monster_affixes", data )
          end)
        end
      end

      function QuestEscort1( state )
        local scale = COverthrowGameMode.jungledifficulty*2.4
        local units = COverthrowGameMode.quest_escort_1_units
        local startpos = COverthrowGameMode.treeoflife:GetAbsOrigin()
        local endpos = COverthrowGameMode.home_base_position
        local total_distance = (startpos-endpos):Length()
        local hero_near = false
        local all = HeroList:GetAllHeroes()
        for i=1, #all do
          local hero = all[i]
          if hero and (hero:GetAbsOrigin() - units[1]:GetAbsOrigin()):Length() < 600 then
            hero_near = true
          end
        end
        local distance_to_goal = (units[1]:GetAbsOrigin() - endpos):Length()
        --escort finished?
        if distance_to_goal <= 250 then
          COverthrowGameMode.quest_escort_1 = nil
          EmitSoundOn("valve_dota_001.stinger.radiant_win", units[1])
          local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_omniknight/omniknight_guardian_angel_ally.vpcf", PATTACH_POINT_FOLLOW, units[1])
          ParticleManager:ReleaseParticleIndex(particle)
          particle = ParticleManager:CreateParticle("particles/units/heroes/hero_omniknight/omniknight_guardian_angel_ally.vpcf", PATTACH_POINT_FOLLOW, units[1])
          ParticleManager:ReleaseParticleIndex(particle)
          Notifications:BottomToAll({text="Villager Cain: Thanks for bringing my daughters back savely! Here, take this treasure. You have earned it!", duration=12, style={color="white"}})
          Timers:CreateTimer(5.0,function()
            local unit = CreateUnitByName("temple_chest", endpos+Vector(0,-500,0), true, nil, nil, DOTA_TEAM_BADGUYS )
            unit:SetModelScale(2)
            unit.main_quest_boss = 15 -- no text for this chest, enough if one triggers msg
            unit.act = 12 --belongs to jungle act
            unit.nobosskill = true
            local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_omniknight/omniknight_guardian_angel_ally.vpcf", PATTACH_POINT_FOLLOW, unit)
            ParticleManager:ReleaseParticleIndex(particle)
            EmitSoundOn("DOTA_Item.Hand_Of_Midas", unit)
            COverthrowGameMode:SetTempleStats(unit,COverthrowGameMode.jungledifficulty*2.2,0,1000,100,0)
            Timers:CreateTimer(15.0,function()
              Notifications:BottomToAll({text="Villager Cain: We have just received a raven message from Castle Winterwall. They are under siege and need our help! Please go there fast!", duration=15, style={color="white"}})
            end)
          end)
          return
        end
        if state and state > 0 then
          if hero_near then
            for i=1,2 do
              local order = 
              {
                UnitIndex = units[i]:entindex(),
                OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
                Position = endpos,
                Queue = false
              }
              ExecuteOrderFromTable(order)
            end
          else
            for i=1,2 do
              local order = 
              {
                UnitIndex = units[i]:entindex(),
                OrderType = DOTA_UNIT_ORDER_STOP,
                Queue = false
              }
              ExecuteOrderFromTable(order)
            end
          end
          --spawn new champ?
          --print(distance_to_goal / total_distance)
          if state == 1 and distance_to_goal < total_distance * 0.92 then
            state = state + 1
            local pos = Entities:FindByName( nil, "act12_2" ):GetAbsOrigin()
            SpawnMonsterSwarm( 12, 5, 5, nil, nil, units[1], true, true, {pos}, scale )
          end
          if state == 2 and distance_to_goal < total_distance * 0.86 then
            state = state + 1
            local pos = Entities:FindByName( nil, "act12_1" ):GetAbsOrigin()
            SpawnMonsterSwarm( 12, 10, 10, nil, nil, units[1], true, true, {pos}, scale )
            SpawnMonsterSwarm( 12, 1, 1, nil, nil, units[1], true, true, {pos}, scale )
          end
          if state == 3 and distance_to_goal < total_distance * 0.8 then
            state = state + 1
            local pos = Entities:FindByName( nil, "boss1" ):GetAbsOrigin()
            SpawnMonsterSwarm( 12, 1, 1, nil, nil, units[1], true, true, {pos}, scale )
            SpawnMonsterSwarm( 12, 1, 1, nil, nil, units[1], true, true, {pos}, scale )
          end
          if state == 4 and distance_to_goal < total_distance * 0.66 then
            state = state + 1
            local pos = Entities:FindByName( nil, "camp15" ):GetAbsOrigin()
            SpawnMonsterSwarm( 3, 15, 15, nil, nil, units[1], true, true, {pos}, scale )
            SpawnMonsterSwarm( 3, 1, 1, nil, nil, units[1], true, true, {pos}, scale )
          end
          if state == 5 and distance_to_goal < total_distance * 0.6 then
            state = state + 1
            local pos = Entities:FindByName( nil, "camp12" ):GetAbsOrigin()
            SpawnMonsterSwarm( 3, 1, 1, nil, nil, units[1], true, true, {pos}, scale * 0.9 )
            SpawnMonsterSwarm( 3, 1, 1, nil, nil, units[1], true, true, {pos}, scale * 0.9 )
            SpawnMonsterSwarm( 3, 1, 1, nil, nil, units[1], true, true, {pos}, scale * 0.9 )
          end
          if state == 6 and distance_to_goal < total_distance * 0.65 then
            state = state + 1
            local pos = Entities:FindByName( nil, "camp6" ):GetAbsOrigin()
            SpawnMonsterSwarm( 2, 7, 7, nil, nil, units[1], true, true, {pos}, scale )
            SpawnMonsterSwarm( 2, 7, 7, nil, nil, units[1], true, true, {pos}, scale )
            Timers:CreateTimer(15,function()
              SpawnMonsterSwarm( 2, 3, 3, nil, nil, units[1], true, true, {pos}, scale )
              SpawnMonsterSwarm( 2, 3, 3, nil, nil, units[1], true, true, {pos}, scale )
              SpawnMonsterSwarm( 2, 3, 3, nil, nil, units[1], true, true, {pos}, scale )
            end)
          end
          if state == 7 and distance_to_goal < total_distance * 0.52 then
            state = state + 1
            local pos = Entities:FindByName( nil, "camp3" ):GetAbsOrigin()
            SpawnMonsterSwarm( 1, 6, 6, nil, nil, units[1], true, true, {pos}, scale )
            SpawnMonsterSwarm( 1, 2, 2, nil, nil, units[1], true, true, {pos}, scale )
            SpawnMonsterSwarm( 1, 2, 2, nil, nil, units[1], true, true, {pos}, scale )
          end
          if state == 8 and distance_to_goal < total_distance * 0.48 then
            state = state + 1
            local pos = Entities:FindByName( nil, "boss1" ):GetAbsOrigin()
            SpawnMonsterSwarm( 1, 12, 12, nil, nil, units[1], true, true, {pos}, scale )
            SpawnMonsterSwarm( 1, 2, 2, nil, nil, units[1], true, true, {pos}, scale )
          end
          if state == 9 and distance_to_goal < total_distance * 0.45 then
            state = state + 1
            local pos = Entities:FindByName( nil, "boss1" ):GetAbsOrigin()
            SpawnMonsterSwarm( 1, 25, 25, nil, nil, units[1], true, true, {pos}, scale )
          end
          if state == 10 and distance_to_goal < total_distance * 0.42 then
            state = state + 1
            local pos = Entities:FindByName( nil, "boss1" ):GetAbsOrigin()
            SpawnMonsterSwarm( 1, 1, 1, nil, nil, units[1], true, true, {pos}, scale )
            SpawnMonsterSwarm( 1, 1, 1, nil, nil, units[1], true, true, {pos}, scale )
          end
          if state == 11 and distance_to_goal < total_distance * 0.39 then
            state = state + 1
            local pos = Entities:FindByName( nil, "camp2" ):GetAbsOrigin()
            unit = CreateUnitByName("temple_wolf_boss_6", pos, true, nil, nil, DOTA_TEAM_BADGUYS )
            unit.act = 12
            unit.canleavespawnpos = true
            unit.drop_chance_factor = 100
            unit.loot_hoarder_on_death_chance = 100
            COverthrowGameMode:SetTempleStats(unit,scale,200,25000,100,0)
            unit:SetForwardVector(Vector(0,1,0))
            unit:SetRenderColor(200, 200, 255)
          end
          --update state
          COverthrowGameMode.quest_escort_1 = state
        end
      end

      function Act13Event(event)
        COverthrowGameMode.act13_event_in_progress = true
        local scale = COverthrowGameMode.jungledifficulty * 2.6
        local spawnpos = Entities:FindByName( nil, "act13_3" ):GetAbsOrigin()
        local order_position = Entities:FindByName( nil, "act13_1" ):GetAbsOrigin()
        for i=1, 60 do
          local delay = 0
          local baseDelayPerWave = 4
          if i >= 17 then --events 15 25 35 45 55 60 -- before 20 40 60 70 80 100, now 60 80
            delay = delay + 20
          end
          if i >= 27 then
            delay = delay + 25
          end
          if i >= 36 then
            delay = delay + 20
          end
          if i >= 58 then
            delay = delay + 20
          end
          if i >= 60 then
            delay = delay + 5
          end
          Timers:CreateTimer(i * baseDelayPerWave + delay,function()
            local unitname = GetRandomMonsterNameByAct(13)
            local dmg = 75
            local hp = 1000
            local max = 1
            if i % 10 == 1 then -- every 10th 15er skeletons
              max = 15
              unitname = "act13_6"
            end
            if i == 15 then -- legionnairs
              unitname = "act13_9"
            end
            if i == 25 then -- drow
              max = 2
              unitname = "act13_7"
            end
            if i >= 26 and i <= 28 then -- catapults
              max = 3
              unitname = "act13_10"
            end
            if i == 55 then -- legionnairs
              unitname = "act13_9"
            end
            if i == 35 then -- wolf boss
              unitname = "act13_11"
            end
            if i == 56 then -- catapults
              max = 5
              unitname = "act13_10"
            end
            if i == 57 then -- catapults
              max = 5
              unitname = "act13_10"
            end
            if i == 60 then -- lich
              max = 1
              unitname = "act13_8"
            end
            if unitname == "act13_1" then
              dmg = dmg * 1.0
              hp = hp * 0.5
              max = 2
            end
            if unitname == "act13_2" then
              dmg = dmg * 1.0
              hp = hp * 1.0
            end
            if unitname == "act13_3" then
              dmg = dmg * 0.75
              hp = hp * 1.5
            end
            if unitname == "act13_4" then
              dmg = dmg * 0.5
              hp = hp * 2.0
            end
            if unitname == "act13_5" then
              dmg = dmg * 1.3
              hp = hp * 0.6
            end
            if unitname == "act13_6" then
              dmg = dmg * 1.0
              hp = hp * 0.5
              max = 5
            end
            if unitname == "act13_7" then
              dmg = dmg * 225 / 75
              hp = hp * 15
              max = 2
            end
            if unitname == "act13_8" then
              dmg = dmg * 200 / 75
              hp = hp * 30
              max = 1
            end
            if unitname == "act13_11" then
              dmg = dmg * 400 / 75
              hp = hp * 20
              max = 1
            end
            if unitname == "act13_9" then
              dmg = dmg * 175 / 75
              hp = hp * 10
              max = 2
            end
            if unitname == "act13_10" then
              dmg = dmg * 1.0
              hp = hp * 3
            end
            for j=1,max do
              local unit = CreateUnitByName(unitname, spawnpos, true, nil, nil, DOTA_TEAM_BADGUYS )
              if i % 10 == 0 and j == 1 and i ~= 20 and i ~= 40 and i ~= 41 and i ~= 60 and i ~= 80 and i ~= 71 and i ~= 72 and i ~= 100 then --every 10th a champ, but not when boss spawns
                unit.chance_for_champion = 100
                --unit.act = 13
              end
              unit.act = 13
              local loot = 0
              if i == 35 then
                unit.isboss = true
                unit:AddAbility("act13_ms"):SetLevel(1)
                unit:AddAbility("pve_temple_wolf_armor_strikes"):SetLevel(1)
                unit.setChampionAffixCount = 1
              end
              if i == 60 then
                loot = 100
                unit.act13_last_boss = true
                unit.quest_trigger_class = "Defend the Wall"
                unit.boss_kill_factor = 15
              end
              if unitname == "act13_1" then
                unit:AddAbility("act13_ms"):SetLevel(1)
              end
              if unitname == "act13_2" then
                unit:AddAbility("act13_frenzy"):SetLevel(1)
              end
              if unitname == "act13_3" then
                unit:AddAbility("act13_aura_as"):SetLevel(1)
                unit:SetRenderColor(175, 175, 255)
              end
              if unitname == "act13_4" then
                unit:AddAbility("act13_bash"):SetLevel(1)
              end
              if unitname == "act13_5" then
                unit:AddAbility("act13_ice_armor"):SetLevel(1)
              end
              if unitname == "act13_6" then
                unit:AddAbility("act13_as"):SetLevel(1)
                unit:SetRenderColor(175, 175, 255)
              end
              if unitname == "act13_7" then
                unit:AddAbility("act13_arrows"):SetLevel(1)
                unit:AddAbility("pve_temple_affix_taunt"):SetLevel(1)
                unit:AddAbility("pve_affix_aa_multishot_frost"):SetLevel(1)
              end
              if unitname == "act13_8" then
                unit:AddAbility("act13_frost_orbs"):SetLevel(1)
                unit:AddAbility("act13_chain_frost"):SetLevel(1)
                unit:AddAbility("act13_frostwyrm"):SetLevel(1)
                unit.canleavespawnpos = true
                unit.main_quest_boss = 16
              end
              if unitname == "act13_9" then
                unit:SetRenderColor(0, 0, 0)
                unit:SetModelScale(1.25)
                --unit:AddAbility("act13_frostwyrm_attack"):SetLevel(1)
                unit:AddAbility("act13_ms_2"):SetLevel(1)
              end
              if unitname == "act13_10" then
                unit:SetRenderColor(225, 225, 255)
                unit:AddAbility("act13_catapult"):SetLevel(1)
              end
              COverthrowGameMode:SetTempleStats(unit,scale,dmg,hp,loot,0)
              local ability = unit:FindAbilityByName("pveboss_system")
              if ability then
                ability:ApplyDataDrivenModifier(unit, unit, "modifier_phased", {Duration = 0.1})
              end
              Timers:CreateTimer(0.25,function()
                local order2 = 
                {
                  UnitIndex = unit:entindex(),
                  OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
                  Position = order_position,
                  Queue = false
                }
                local all = HeroList:GetAllHeroes()
                local hero_to_attack = all[math.random(1,#all)]
                local order = 
                {
                  UnitIndex = unit:entindex(),
                  OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
                  TargetIndex = hero_to_attack:entindex(),
                  Queue = false
                }
                --if hero_to_attack and hero_to_attack:IsAlive() then
                  ExecuteOrderFromTable(order2)
                  Timers:CreateTimer(0.25,function()
                    if hero_to_attack and hero_to_attack:IsAlive() then
                      ExecuteOrderFromTable(order)
                    end
                    Timers:CreateTimer(10.25,function()
                      if hero_to_attack and hero_to_attack:IsAlive() then
                        ExecuteOrderFromTable(order)
                      end
                    end)
                  end)
                  --else
                  
                  --end
                end)
            end
          end)
end
end

function CheckForClassQuestRewards(questname)
  return --disabled quests for now
    --[[
    if COverthrowGameMode.jungledifficulty >= 5 then
        local quality = "lege"
        if COverthrowGameMode.jungledifficulty >= 50 then
            quality = "aimo"
        end
        local all = HeroList:GetAllHeroes()
        for i=1, #all do
            local hero = all[i]
            Timers:CreateTimer(2*i,function()
                local herolist = GetHeroListByQuestName( questname )
                if ListContainsString( herolist, hero:GetUnitName() ) then
                    if questname == "Defend the Wall" and COverthrowGameMode.total_lives_lost <= 5 then
                        COverthrowGameMode:DropClassQuestReward( hero, quality, 3 )
                    end
                    if questname == "King of the Jungle" and COverthrowGameMode.total_lives_lost <= 3 then
                        COverthrowGameMode:DropClassQuestReward( hero, quality, 3 )
                    end
                    if questname == "Haunting the Dead" and COverthrowGameMode.total_lives_lost <= 0 and GameRules:GetGameTime() - COverthrowGameMode._fPreGameStartTime <= 480 then
                        COverthrowGameMode:DropClassQuestReward( hero, quality, 3 )
                    end
                    if questname == "Arena Champion" then
                        COverthrowGameMode:DropClassQuestReward( hero, quality, 3 )
                    end
                    if questname == "Volcanic Invasion" and COverthrowGameMode.total_lives_lost <= 0 then
                        COverthrowGameMode:DropClassQuestReward( hero, quality, 3 )
                    end
                    if questname == "Shadowland Assault" and COverthrowGameMode.total_lives_lost <= 0 and GameRules:GetGameTime() - COverthrowGameMode._fPreGameStartTime <= 600 then
                        COverthrowGameMode:DropClassQuestReward( hero, quality, 3 )
                    end
                    if questname == "Beast Clearing" and COverthrowGameMode.total_lives_lost <= 0 and GameRules:GetGameTime() - COverthrowGameMode._fPreGameStartTime <= 720 then
                        COverthrowGameMode:DropClassQuestReward( hero, quality, 3 )
                    end
                    if questname == "Saving the Sanctum" and COverthrowGameMode.total_lives_lost <= 0 then
                        COverthrowGameMode:DropClassQuestReward( hero, quality, 3 )
                    end
                    if questname == "Giant Slaying" and COverthrowGameMode.total_lives_lost <= 0 then
                        COverthrowGameMode:DropClassQuestReward( hero, quality, 3 )
                    end
                    if questname == "A Light in the Dark" and COverthrowGameMode.total_lives_lost <= 0 then
                        COverthrowGameMode:DropClassQuestReward( hero, quality, 3 )
                    end
                end
            end)
        end
      end]]
    end

    function ListContainsString( list, text )
      for i=1, #list do
        if list[i] == text then
          return true
        end
      end
      return false
    end

    function GetHeroListByQuestName( questname )
      for i=1, #COverthrowGameMode.ClassQuestData do
        if questname == COverthrowGameMode.ClassQuestData[i][1] then
          return COverthrowGameMode.ClassQuestData[i][3]
        end
      end
      return nil
    end

    function ReviveUnit(unit, killer)
      local name = unit:GetUnitName()
      local pos = unit:GetAbsOrigin()
      local scale = unit.pvescale
      local modelscale = unit:GetModelScale()
      local particle = ParticleManager:CreateParticle("particles/items4_fx/meteor_hammer_cast.vpcf", PATTACH_WORLDORIGIN, killer)
      ParticleManager:SetParticleControl(particle, 0, pos)
      ParticleManager:ReleaseParticleIndex(particle)
      EmitSoundOn("DOTA_Item.HeavensHalberd.Activate", killer)
      Timers:CreateTimer(2.5, function()
        local new_unit = CreateUnitByName(name, pos, true, nil, nil, DOTA_TEAM_BADGUYS )
        new_unit.chance_for_champion = 10
        COverthrowGameMode:SetTempleStats(new_unit,scale,200,2000,20,2)
        unit:SetModelScale(modelscale)
        local particle = ParticleManager:CreateParticle("particles/items4_fx/meteor_hammer_spell_impact_ember.vpcf", PATTACH_WORLDORIGIN, killer)
        ParticleManager:SetParticleControl(particle, 3, pos)
        ParticleManager:ReleaseParticleIndex(particle)
      end)
    end

    function CheckForHeroChargeAbilities( hero )
      local abilityName = "dh1"
      local ability = hero:FindAbilityByName(abilityName)
      if ability and not hero[abilityName .."_is_init"] then
        hero[abilityName.."_is_init"] = true
        hero:AddNewModifier(hero, ability, "modifier_charges",
        {
          max_count = 3,
          start_count = 1,
          replenish_time = 1.5
        }
        )
      end
      abilityName = "unholy_1"
      ability = hero:FindAbilityByName(abilityName)
      if ability and not hero[abilityName .."_is_init"] then
        hero[abilityName.."_is_init"] = true
        hero:AddNewModifier(hero, ability, "modifier_charges",
        {
          max_count = 5,
          start_count = 1,
          replenish_time = 2
        }
        )
      end
      abilityName = "shadow11"
      ability = hero:FindAbilityByName(abilityName)
      if ability and not hero[abilityName .."_is_init"] then
        hero[abilityName.."_is_init"] = true
        hero:AddNewModifier(hero, ability, "modifier_charges",
        {
          max_count = 3,
          start_count = 1,
          replenish_time = 10
        }
        )
      end
      abilityName = "Retri1"
      ability = hero:FindAbilityByName(abilityName)
      if ability and not hero[abilityName .."_is_init"] then
        hero[abilityName.."_is_init"] = true
        hero:AddNewModifier(hero, ability, "modifier_charges",
        {
          max_count = 3,
          start_count = 1,
          replenish_time = 1.5
        }
        )
      end
      abilityName = "pala1"
      ability = hero:FindAbilityByName(abilityName)
      if ability and not hero[abilityName .."_is_init"] then
        hero[abilityName.."_is_init"] = true
        hero:AddNewModifier(hero, ability, "modifier_charges",
        {
          max_count = 3,
          start_count = 1,
          replenish_time = 3
        }
        )
      end
      abilityName = "paladin1"
      ability = hero:FindAbilityByName(abilityName)
      if ability and not hero[abilityName .."_is_init"] then
        hero[abilityName.."_is_init"] = true
        hero:AddNewModifier(hero, ability, "modifier_charges",
        {
          max_count = 2,
          start_count = 1,
          replenish_time = 2
        }
        )
      end
      abilityName = "keeper1"
      ability = hero:FindAbilityByName(abilityName)
      if ability and not hero[abilityName .."_is_init"] then
        hero[abilityName.."_is_init"] = true
        hero:AddNewModifier(hero, ability, "modifier_charges",
        {
          max_count = 2,
          start_count = 1,
          replenish_time = 10
        }
        )
      end
      abilityName = "enchant1"
      ability = hero:FindAbilityByName(abilityName)
      if ability and not hero[abilityName .."_is_init"] then
        hero[abilityName.."_is_init"] = true
        hero:AddNewModifier(hero, ability, "modifier_charges",
        {
          max_count = 2,
          start_count = 1,
          replenish_time = 3
        }
        )
      end
      abilityName = "terror1"
      ability = hero:FindAbilityByName(abilityName)
      if ability and not hero[abilityName .."_is_init"] then
        hero[abilityName.."_is_init"] = true
        hero:AddNewModifier(hero, ability, "modifier_charges",
        {
          max_count = 3,
          start_count = 1,
          replenish_time = 2
        }
        )
      end
      abilityName = "Protect1"
      ability = hero:FindAbilityByName(abilityName)
      if ability and not hero[abilityName .."_is_init"] then
        hero[abilityName.."_is_init"] = true
        hero:AddNewModifier(hero, ability, "modifier_charges",
        {
          max_count = 5,
          start_count = 1,
          replenish_time = 3
        }
        )
      end
      abilityName = "fury1"
      ability = hero:FindAbilityByName(abilityName)
      if ability and not hero[abilityName .."_is_init"] then
        hero[abilityName.."_is_init"] = true
        hero:AddNewModifier(hero, ability, "modifier_charges",
        {
          max_count = 5,
          start_count = 1,
          replenish_time = 1.5
        }
        )
      end
      abilityName = "spectre1"
      ability = hero:FindAbilityByName(abilityName)
      if ability and not hero[abilityName .."_is_init"] then
        hero[abilityName.."_is_init"] = true
        hero:AddNewModifier(hero, ability, "modifier_charges",
        {
          max_count = 3,
          start_count = 1,
          replenish_time = 2
        }
        )
      end
      abilityName = "templedk1"
      ability = hero:FindAbilityByName(abilityName)
      if ability and not hero[abilityName .."_is_init"] then
        hero[abilityName.."_is_init"] = true
        hero:AddNewModifier(hero, ability, "modifier_charges",
        {
          max_count = 3,
          start_count = 1,
          replenish_time = 3
        }
        )
      end
      abilityName = "frostdk1"
      ability = hero:FindAbilityByName(abilityName)
      if ability and not hero[abilityName .."_is_init"] then
        hero[abilityName.."_is_init"] = true
        hero:AddNewModifier(hero, ability, "modifier_charges",
        {
          max_count = 2,
          start_count = 1,
          replenish_time = 3
        }
        )
      end
      abilityName = "Corrupting_Strike"
      ability = hero:FindAbilityByName(abilityName)
      if ability and not hero[abilityName .."_is_init"] then
        hero[abilityName.."_is_init"] = true
        hero:AddNewModifier(hero, ability, "modifier_charges",
        {
          max_count = 2,
          start_count = 1,
          replenish_time = 3
        }
        )
      end
      abilityName = "Fire_Lance"
      ability = hero:FindAbilityByName(abilityName)
      if ability and not hero[abilityName .."_is_init"] then
        hero[abilityName.."_is_init"] = true
        hero:AddNewModifier(hero, ability, "modifier_charges",
        {
          max_count = 3,
          start_count = 1,
          replenish_time = 2.5
        }
        )
      end
      abilityName = "Arcane2"
      ability = hero:FindAbilityByName(abilityName)
      if ability and not hero[abilityName .."_is_init"] then
        hero[abilityName.."_is_init"] = true
        hero:AddNewModifier(hero, ability, "modifier_charges",
        {
          max_count = 3,
          start_count = 1,
          replenish_time = 3
        }
        )
      end
      abilityName = "Frost_Shatter"
      ability = hero:FindAbilityByName(abilityName)
      if ability and not hero[abilityName .."_is_init"] then
        hero[abilityName.."_is_init"] = true
        hero:AddNewModifier(hero, ability, "modifier_charges",
        {
          max_count = 4,
          start_count = 1,
          replenish_time = 4,
          replenish_time_per_level = 1
        }
        )
      end
      abilityName = "ench3"
      ability = hero:FindAbilityByName(abilityName)
      if ability and not hero[abilityName .."_is_init"] then
        hero[abilityName.."_is_init"] = true
        hero:AddNewModifier(hero, ability, "modifier_charges",
        {
          max_count = 3,
          start_count = 1,
          replenish_time = 30
        }
        )
      end
    end

    function SetBossID(target)
      target.bossid = COverthrowGameMode.nextBossID
      COverthrowGameMode.nextBossID = COverthrowGameMode.nextBossID + 1
    end

    COverthrowGameMode.ClassQuestData = {
      --title, task, hero list
      {"Defend the Wall", "Clear Act 13 on Monster Level 50 or higher without your team losing a life.", {"npc_dota_hero_drow_ranger", "npc_dota_hero_crystal_maiden", "npc_dota_hero_sven","npc_dota_hero_terrorblade"}},
      {"King of the Jungle", "Defeat the King of the Jungle in Act 12 on Monster Level 50 or higher without your team losing a life.", {"npc_dota_hero_windrunner", "npc_dota_hero_sniper", "npc_dota_hero_furion", "npc_dota_hero_enchantress", "npc_dota_hero_ursa"}},
      {"Haunting the Dead", "Clear Act 7 on Monster Level 50 or higher in less than 8 Minutes without your team losing a life.", {"npc_dota_hero_abaddon", "npc_dota_hero_pugna", "npc_dota_hero_phantom_lancer", "npc_dota_hero_chen", "npc_dota_hero_pudge", "npc_dota_hero_grimstroke"}},
      {"Arena Champion", "Beat 10 Mogushan Rounds in Act 9 on Monster Level 50 or higher.", {"npc_dota_hero_axe", "npc_dota_hero_beastmaster", "npc_dota_hero_dragon_knight", "npc_dota_hero_bristleback", "npc_dota_hero_legion_commander"}},
      {"Volcanic Invasion", "Clear Act 8 on Monster Level 50 or higher without your team losing a life.", {"npc_dota_hero_clinkz", "npc_dota_hero_lina", "npc_dota_hero_omniknight"}},
      {"Shadowland Assault", "Clear Act 4 on Monster Level 50 or higher in less than 10 Minutes without your team losing a life.", {"npc_dota_hero_phantom_assassin", "npc_dota_hero_riki", "npc_dota_hero_warlock", "npc_dota_hero_slark","npc_dota_hero_templar_assassin","npc_dota_hero_lion"}},
      {"Beast Clearing", "Clear Act 1 and Act 2 on Monster Level 50 or higher in less than 15 Minutes without your team losing a life.", {"npc_dota_hero_bounty_hunter", "npc_dota_hero_juggernaut", "npc_dota_hero_dazzle"}},
      {"Saving the Sanctum", "Clear Act 10 on Monster Level 50 or higher without your team losing a life.", {"npc_dota_hero_bloodseeker", "npc_dota_hero_invoker", "npc_dota_hero_elder_titan", "npc_dota_hero_ogre_magi"}},
      {"Giant Slaying", "Clear Act 5 and Act 6 on Monster Level 50 or higher without your team losing a life.", {"npc_dota_hero_skeleton_king", "npc_dota_hero_oracle", "npc_dota_hero_witch_doctor", "npc_dota_hero_shadow_shaman"}},
      {"A Light in the Dark", "Clear Act 3 and 4 on Monster Level 50 or higher without your team losing a life.", {"npc_dota_hero_silencer", "npc_dota_hero_keeper_of_the_light", "npc_dota_hero_vengefulspirit", "npc_dota_hero_antimage", "npc_dota_hero_dark_seer"}},
    }

    function GetHeroLevel( hero )
      return hero.level
    end

    function AddHeroExperience( hero, xp )
     hero.xp = hero.xp + xp
     CalculateHeroLevel(hero, hero.xp)
   end

   function CalculateHeroLevel( hero, xp )
     local previousLevel = hero.level
     local level = #COverthrowGameMode.levelTable
     local levelPercentage = 0
     while xp < COverthrowGameMode.levelTable[level] do
      level = level - 1
    end
    hero.level = level
    if hero.level >= 100 then
      levelPercentage = 100
    else
      local xpRange = COverthrowGameMode.levelTable[level + 1] - COverthrowGameMode.levelTable[level]
      local xpPoint = xp - COverthrowGameMode.levelTable[level]
      levelPercentage = math.floor(100 * xpPoint / xpRange)
    end
    hero.levelPercentage = levelPercentage
    --print("new hero lvl: " .. level .. " xpTotal: " .. xp .. " perc: " .. hero.levelPercentage)
    if level > previousLevel then
      local levelUps = level - previousLevel
      for i = 1, levelUps do
        OnLevelUp(hero, previousLevel + i, i == levelUps)
      end
    end
  end

  function OnLevelUp(hero, newLevel, showFX)
   print("OnLevelUp")
   if newLevel >= 15 and (newLevel % 2) ~= 0 and hero.talentpoints then
    AddTalentPoint(hero, 1)
  end
  if newLevel == 20 or newLevel == 30 or newLevel == 40 or newLevel == 60 or newLevel == 80 or newLevel == 100 then
   hero:SetAbilityPoints(hero:GetAbilityPoints()+1)
 end
 if newLevel == 25 then
   hero.hasmount = 1
 end
 if newLevel == 50 then
   hero.hasmount = 2
 end
 if showFX then
  EmitSoundOn("DOTA_Item.HealingSalve.Activate", hero)
  local particle = ParticleManager:CreateParticle("particles/econ/events/ti6/hero_levelup_ti6_flash_hit_magic.vpcf", PATTACH_POINT_FOLLOW, hero)
  ParticleManager:ReleaseParticleIndex(particle)
end
end

function GetRandomPassiveAggroAbilityOrMS()
  local abils = {"pve_temple_aggro_highest_hp", "pve_temple_aggro_ranged", "pve_temple_aggro_cycling", "pve_healnegate" }
  return abils[math.random(1,#abils)]
end

function COverthrowGameMode:LoadLeaderboardFromServer()
  if(IsServer() == false) then
    return
  end

  local request = CreateHTTPRequestScriptVM("POST", "http://catze.eu/templetop10_season_5.php")
  request:SetHTTPRequestGetOrPostParameter("order", "getelo")
  request:SetHTTPRequestGetOrPostParameter("players", "5") -- seems unused, but panorama sends...
  request:Send(function(result)
    --print(result)
    --print(result.Body)
    if result and result.Body and string.match(result.Body, ",") then
      self._leaderboardData = result.Body
      self._isLeaderboardReady = true
    else
      self._isLeaderboardReady = false
    end
  end)
end

function COverthrowGameMode:SendLeaderboard(params)
  local player = PlayerResource:GetPlayer(params.PlayerID)

  -- Disconnected player or broken request
  if(player == null) then
    return
  end

  -- Server still processing request
  if(COverthrowGameMode._isLeaderboardReady == nil) then
    Timers:CreateTimer(1, function()
      COverthrowGameMode:SendLeaderboard(params)
    end)
    return
  end

  -- Server not responding, too bad...
  if(COverthrowGameMode._isLeaderboardReady == false) then
    return
  end

  CustomGameEventManager:Send_ServerToPlayer(player, "getleaderboardresponse", { data = COverthrowGameMode._leaderboardData } )
end