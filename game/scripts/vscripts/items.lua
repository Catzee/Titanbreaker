--[[ items.lua ]]

--Spawns Bags of Gold in the middle
function COverthrowGameMode:ThinkGoldDrop()
	local r = RandomInt( 1, 100 )
	if r > 96 then
		--self:SpawnGold()
	end
end

function COverthrowGameMode:SpawnGold()
	local overBoss = Entities:FindByName( nil, "@overboss" )
	local throwCoin = nil
	local throwCoin2 = nil
	if overBoss then
		throwCoin = overBoss:FindAbilityByName( 'dota_ability_throw_coin' )
		throwCoin2 = overBoss:FindAbilityByName( 'dota_ability_throw_coin_long' )
	end

	-- sometimes play the long anim
	if throwCoin2 and RandomInt( 1, 100 ) > 80 then
		overBoss:CastAbilityNoTarget( throwCoin2, -1 )
	elseif throwCoin then
		overBoss:CastAbilityNoTarget( throwCoin, -1 )
	else
		self:SpawnGoldEntity( Vector( 0, 0, 0 ) )
	end
end

function COverthrowGameMode:SpawnGoldEntity( spawnPoint )
	EmitGlobalSound("Item.PickUpGemWorld")
	local newItem = CreateItem( "item_bag_of_gold", nil, nil )
	local drop = CreateItemOnPositionForLaunch( spawnPoint, newItem )
	newItem:LaunchLootInitialHeight( false, 0, 500, 0.75, spawnPoint + RandomVector( RandomFloat( 250, 550 ) ) )
	newItem:SetContextThink( "KillLoot", function() return self:KillLoot( newItem, drop ) end, 20 )
end


--Removes Bags of Gold after they expire
function COverthrowGameMode:KillLoot( item, drop )

	if drop:IsNull() then
		return
	end

	local nFXIndex = ParticleManager:CreateParticle( "particles/items2_fx/veil_of_discord.vpcf", PATTACH_CUSTOMORIGIN, drop )
	ParticleManager:SetParticleControl( nFXIndex, 0, drop:GetOrigin() )
	ParticleManager:SetParticleControl( nFXIndex, 1, Vector( 35, 35, 25 ) )
	ParticleManager:ReleaseParticleIndex( nFXIndex )
	EmitGlobalSound("Item.PickUpWorld")

	UTIL_Remove( item )
	UTIL_Remove( drop )
end

function COverthrowGameMode:SpecialItemAdd( event )
	local item = EntIndexToHScript( event.ItemEntityIndex )
	local owner = EntIndexToHScript( event.HeroEntityIndex )
	local hero = owner:GetClassname()
	local ownerTeam = owner:GetTeamNumber()
	local sortedTeams = {}
	for _, team in pairs( self.m_GatheredShuffledTeams ) do
		table.insert( sortedTeams, { teamID = team, teamScore = GetTeamHeroKills( team ) } )
	end

	-- reverse-sort by score
	table.sort( sortedTeams, function(a,b) return ( a.teamScore > b.teamScore ) end )
	local n = TableCount( sortedTeams )
	local leader = sortedTeams[1].teamID
	local lastPlace = sortedTeams[n].teamID

	local tableindex = 0
	local tier1 = 
	{
		"item_urn_of_shadows",
		"item_ring_of_basilius",
		"item_ring_of_aquila",
		"item_arcane_boots",
		"item_tranquil_boots",
		"item_phase_boots",
		"item_power_treads",
		"item_medallion_of_courage",
		"item_soul_ring",
		"item_gem",
		"item_orb_of_venom"
	}
	local tier2 = 
	{
		"item_blink",
		"item_force_staff",
		"item_cyclone",
		"item_ghost",
		"item_vanguard",
		"item_mask_of_madness",
		"item_blade_mail",
		"item_helm_of_the_dominator",
		"item_vladmir",
		"item_yasha",
		"item_mekansm",
		"item_hood_of_defiance",
		"item_veil_of_discord",
		"item_glimmer_cape"
	}
	local tier3 = 
	{
		"item_shivas_guard",
		"item_sphere",
		"item_diffusal_blade",
		"item_maelstrom",
		"item_basher",
		"item_invis_sword",
		"item_desolator",
		"item_ultimate_scepter",
		"item_bfury",
		"item_pipe",
		"item_heavens_halberd",
		"item_crimson_guard",
		"item_black_king_bar",
		"item_bloodstone",
		"item_lotus_orb",
		"item_guardian_greaves",
		"item_moon_shard"
	}
	local tier4 = 
	{
		"item_skadi",
		"item_sange_and_yasha",
		"item_greater_crit",
		"item_sheepstick",
		"item_orchid",
		"item_heart",
		"item_mjollnir",
		"item_ethereal_blade",
		"item_radiance",
		"item_abyssal_blade",
		"item_butterfly",
		"item_monkey_king_bar",
		"item_satanic",
		"item_octarine_core",
		"item_silver_edge",
		"item_rapier"
	}

	local t1 = PickRandomShuffle( tier1, self.tier1ItemBucket )
	local t2 = PickRandomShuffle( tier2, self.tier2ItemBucket )
	local t3 = PickRandomShuffle( tier3, self.tier3ItemBucket )
	local t4 = PickRandomShuffle( tier4, self.tier4ItemBucket )

	local spawnedItem = ""

	-- pick the item we're giving them
	if GetTeamHeroKills( leader ) > 5 and GetTeamHeroKills( leader ) <= 10 then
		if ownerTeam == leader and ( self.leadingTeamScore - self.runnerupTeamScore > 3 ) then
			spawnedItem = t1
		elseif ownerTeam == lastPlace then
			spawnedItem = t3
		else
			spawnedItem = t2
		end
	elseif GetTeamHeroKills( leader ) > 10 and GetTeamHeroKills( leader ) <= 15 then
		if ownerTeam == leader and ( self.leadingTeamScore - self.runnerupTeamScore > 3 ) then
			spawnedItem = t2
		elseif ownerTeam == lastPlace then
			spawnedItem = t4
		else
			spawnedItem = t3
		end
	else
		spawnedItem = t2
	end

	-- add the item to the inventory and broadcast
	owner:AddItemByName( spawnedItem )
	EmitGlobalSound("powerup_04")
	local overthrow_item_drop =
	{
		hero_id = hero,
		dropped_item = spawnedItem
	}
	CustomGameEventManager:Send_ServerToAllClients( "overthrow_item_drop", overthrow_item_drop )
end

function COverthrowGameMode:UpdateMythicWeaponStats(hero)
	--print("update artifact stats")
	--clear all previous buffs from other weapons
	hero:RemoveModifierByName("modifier_mythic_str")
	hero:RemoveModifierByName("modifier_mythic_agi")
	hero:RemoveModifierByName("modifier_mythic_int")
	hero:RemoveModifierByName("modifier_mythic_aa")
	hero:RemoveModifierByName("modifier_mythic_sp")
	hero:RemoveModifierByName("modifier_mythic_critdmg")
	hero:RemoveModifierByName("modifier_mythic_as")
	hero:RemoveModifierByName("modifier_mythic_abilcrit")
	hero:RemoveModifierByName("modifier_mythic_armor")
	hero:RemoveModifierByName("modifier_mythic_spellres")
	hero:RemoveModifierByName("modifier_mythic_aacrit")
	hero:RemoveModifierByName("modifier_mythic_minusarmor")
	hero:RemoveModifierByName("modifier_mythic_health")
	hero:RemoveModifierByName("modifier_mythic_minusspellres")
	hero:RemoveModifierByName("modifier_mythic_mana")
	hero:RemoveModifierByName("modifier_mythic_firedmg")
	hero:RemoveModifierByName("modifier_mythic_shadowdmg")
	hero:RemoveModifierByName("modifier_mythic_arcanedmg")
	hero:RemoveModifierByName("modifier_mythic_frostdmg")
	hero:RemoveModifierByName("modifier_mythic_naturedmg")
	hero:RemoveModifierByName("modifier_mythic_holydmg")
	hero:RemoveModifierByName("modifier_mythic_chaosdmg")
	hero:RemoveModifierByName("modifier_mythic_physicaldmg")
	hero:RemoveModifierByName("modifier_mythic_aggro")
	hero:RemoveModifierByName("modifier_mythic_resource")
	hero:RemoveModifierByName("modifier_mythic_aggro_reduce")
	hero:RemoveModifierByName("modifier_mythic_abil")
	hero:RemoveModifierByName("modifier_mythic_heal")
	hero:RemoveModifierByName("modifier_mythic_cd")
	hero:RemoveModifierByName("modifier_mythic_pathpoints")
	hero:RemoveModifierByName("modifier_mythic_abilitypoint")
	hero:RemoveModifierByName("modifier_mythic_ms")
	hero:RemoveModifierByName("modifier_mythic_block")
	hero:RemoveModifierByName("modifier_mythic_autoattackdamage")
	hero:RemoveModifierByName("modifier_mythic_aoe")
	hero:RemoveModifierByName("modifier_mythic_single")
	hero:RemoveModifierByName("modifier_mythic_dot")

	--new stats
	hero:RemoveModifierByName("modifier_mythic_firedmgd")
	hero:RemoveModifierByName("modifier_mythic_shadowdmgd")
	hero:RemoveModifierByName("modifier_mythic_arcanedmgd")
	hero:RemoveModifierByName("modifier_mythic_frostdmgd")
	hero:RemoveModifierByName("modifier_mythic_naturedmgd")
	hero:RemoveModifierByName("modifier_mythic_holydmgd")
	hero:RemoveModifierByName("modifier_mythic_chaosdmgd")
	hero:RemoveModifierByName("modifier_mythic_physicaldmgd")
	hero:RemoveModifierByName("modifier_mythic_mhp")
	hero:RemoveModifierByName("modifier_mythic_sph")
	
	--runewords
	hero:RemoveModifierByName("modifier_runeword_fah")
	hero:RemoveModifierByName("modifier_runeword_wii")
	hero:RemoveModifierByName("modifier_runeword_loo")
	hero:RemoveModifierByName("modifier_runeword_tal")
	hero:RemoveModifierByName("modifier_runeword_nah")
	hero:RemoveModifierByName("modifier_runeword_ser")
	hero:RemoveModifierByName("modifier_runeword_mine")
	hero:RemoveModifierByName("modifier_runeword_tic")
	hero:RemoveModifierByName("modifier_runeword_kil")
	hero:RemoveModifierByName("modifier_runeword_roh")
	hero:RemoveModifierByName("modifier_runeword_sin")

	--artifact powers
	local startInsert = false
	for i=1, #COverthrowGameMode.GeneratedItemData do
		if COverthrowGameMode.GeneratedItemData[i] and COverthrowGameMode.GeneratedItemData[i][1] == "fis" then
			startInsert = true
		end
		if startInsert then
			hero[COverthrowGameMode.GeneratedItemData[i][1]] = 0 --initialize the new arti passives with 0
		end
		if COverthrowGameMode.GeneratedItemData[i] and COverthrowGameMode.GeneratedItemData[i][1] == "met" then
			break
		end
	end
	local herocontrol = hero.ArenaControl
	--local slot = COverthrowGameMode:GetMythicWeaponSlot(weapon)

	for slot=1, self.mythic_slots do
		local weapon = hero.inventory[slot][1]
		--print("slot power "..slot)
		--print(self:GetMythicWeaponLevel(hero, slot))
		if weapon and string.len(weapon) > 3 then
			for i=1,3 do
				local stat = COverthrowGameMode:GetMythicWeaponAttributeName(weapon, i)
				local amount = hero.inventory[slot][4+i]
				local buff = ""
				local statName = nil
				local is_hp_buff = false
				--print(stat)
				--print(amount)

				--stat translation
				if stat == " Strength" or (stat == " Primary Attribute" and hero:GetPrimaryAttribute() == 0) then
					buff = "modifier_mythic_str"
				end
				if stat == " Agility" or (stat == " Primary Attribute" and hero:GetPrimaryAttribute() == 1) then
					buff = "modifier_mythic_agi"
				end
				if stat == " Intellect" or (stat == " Primary Attribute" and hero:GetPrimaryAttribute() == 2) then
					buff = "modifier_mythic_int"
				end
				if stat == " Damage" then
					buff = "modifier_mythic_aa"
				end
				if stat == "% Ability Critical Damage" then
					buff = "modifier_mythic_critdmg"
				end
				if stat == " Spellpower" then
					buff = "modifier_mythic_sp"
				end
				if stat == "% Attack Speed" then
					buff = "modifier_mythic_as"
				end
				if stat == "% Ability Crit (300%)" then
					buff = "modifier_mythic_abilcrit"
				end
				if stat == " Armor" then
					buff = "modifier_mythic_armor"
				end
				if stat == " Spell Resistance" then
					buff = "modifier_mythic_spellres"
				end
				if stat == "% Auto Attack Crit (300%)" then
					buff = "modifier_mythic_aacrit"
				end
				if stat == " Armor Reduction" then
					buff = "modifier_mythic_minusarmor"
				end
				if stat == " Block" then
					buff = "modifier_mythic_block"
				end
				if stat == " Max Health" then
					buff = "modifier_mythic_health"
				end
				if stat == "% Resistance Reduction" then
					buff = "modifier_mythic_minusspellres"
				end
				if stat == " Max Mana" then
					buff = "modifier_mythic_mana"
				end
				if stat == "% Fire Damage" then
					buff = "modifier_mythic_firedmg"
				end
				if stat == "% Shadow Damage" then
					buff = "modifier_mythic_shadowdmg"
				end
				if stat == "% Arcane Damage" then
					buff = "modifier_mythic_arcanedmg"
				end
				if stat == "% Frost Damage" then
					buff = "modifier_mythic_frostdmg"
				end
				if stat == "% Physical Damage" then
					buff = "modifier_mythic_physicaldmg"
				end
				if stat == "% Nature Damage" then
					buff = "modifier_mythic_naturedmg"
				end
				if stat == "% Holy Damage" then
					buff = "modifier_mythic_holydmg"
				end
				if stat == "% Chaos Damage" then
					buff = "modifier_mythic_chaosdmg"
				end
				if stat == " Fire Damage" then
					buff = "modifier_mythic_firedmgd"
				end
				if stat == " Shadow Damage" then
					buff = "modifier_mythic_shadowdmgd"
				end
				if stat == " Arcane Damage" then
					buff = "modifier_mythic_arcanedmgd"
				end
				if stat == " Frost Damage" then
					buff = "modifier_mythic_frostdmgd"
				end
				if stat == " Physical Damage" then
					buff = "modifier_mythic_physicaldmgd"
				end
				if stat == " Nature Damage" then
					buff = "modifier_mythic_naturedmgd"
				end
				if stat == " Holy Damage" then
					buff = "modifier_mythic_holydmgd"
				end
				if stat == " Chaos Damage" then
					buff = "modifier_mythic_chaosdmgd"
				end
				if stat == "% Aggro Caused" then
					buff = "modifier_mythic_aggro"
				end
				if stat == "% Aggro Lowered" then
					buff = "modifier_mythic_aggro_reduce"
				end
				if stat == "% Energy Regeneration" then
					buff = "modifier_mythic_resource"
				end
				if stat == "% Damage" then
					buff = "modifier_mythic_abil"
				end
				if stat == "% AOE Ability Damage" then
					buff = "modifier_mythic_aoe"
				end
				if stat == "% Single Target Ability Damage" then
					buff = "modifier_mythic_single"
				end
				if stat == "% DoT Ability Damage" then
					buff = "modifier_mythic_dot"
				end
				if stat == " Auto Attack Damage" then
					buff = "modifier_mythic_autoattackdamage"
				end
				if stat == "% Healing" then
					buff = "modifier_mythic_heal"
				end
				if stat == "% Cooldown Reduction" then
					buff = "modifier_mythic_cd"
				end
				if stat == "% Movement Speed" then
					buff = "modifier_mythic_ms"
				end
				if stat == " Path Point(s)" then
					buff = "modifier_mythic_pathpoints"
				end
				if stat == " Ability Point(s)" then
					buff = "modifier_mythic_abilitypoint"
				end
				--runewords
				if stat == " Rune Power: FAH" then
					buff = "modifier_runeword_fah"
				end
				if stat == " Rune Power: LOO" then
					buff = "modifier_runeword_loo"
				end
				if stat == " Rune Power: WII" then
					buff = "modifier_runeword_wii"
				end
				if stat == " Rune Power: TAL" then
					buff = "modifier_runeword_tal"
				end
				if stat == " Rune Power: NAH" then
					buff = "modifier_runeword_nah"
				end
				if stat == " Rune Power: ZER" then
					buff = "modifier_runeword_ser"
				end
				if stat == " Rune Power: TEM" then
					buff = "modifier_runeword_mine"
				end
				if stat == " Rune Power: SIN" then
					buff = "modifier_runeword_sin"
				end
				if stat == " Rune Power: TIC" then
					buff = "modifier_runeword_tic"
				end
				if stat == " Rune Power: KIL" then
					buff = "modifier_runeword_kil"
				end
				if stat == " Rune Power: ROH" then
					buff = "modifier_runeword_roh"
				end
				if stat == " % Max Health" then
					buff = "modifier_mythic_mhp"
				end
				if stat == " Spellhaste" then
					buff = "modifier_mythic_sph"
				end
				--print("buff on item")
				--print(buff)
				if amount and amount > 0 and buff ~= "" then
					local sum = hero:GetModifierStackCount(buff, nil)
					--print(herocontrol)
					--print(hero)
					--print(herocontrol:FindAbilityByName("savechar"))
					herocontrol:FindAbilityByName("savechar"):ApplyDataDrivenModifier(herocontrol, hero, buff, {Duration = -1})
					local total_stats = amount+sum
					if total_stats > 35 and buff == "modifier_mythic_spellres" then
						total_stats = 35
					end
					if total_stats > 10 and buff == "modifier_mythic_minusspellres" then
						total_stats = 10
					end
					hero:SetModifierStackCount(buff, herocontrol:GetAbilityByIndex(1), total_stats)
				end
				if buff == "" then --new effects that dont use a buff use this system
					local attributeCode = GetAttributeCodeByAttributeName(stat)
					if attributeCode then
						if not hero[attributeCode] then
							hero[attributeCode] = 0
						end
						hero[attributeCode] = hero[attributeCode] + amount
					end
				end
			end
		end
	end
	hero:CalculateStatBonus(true)
end

function GetAttributeCodeByAttributeName( name )
	local code = nil
	if not name then
		return code
	end
	for i=1, #COverthrowGameMode.GeneratedItemData do
		if COverthrowGameMode.GeneratedItemData[i] and name == COverthrowGameMode.GeneratedItemData[i][2] then
			return COverthrowGameMode.GeneratedItemData[i][1]
		end
	end
	return code
end

function COverthrowGameMode:MythicWeaponAttributeMax( attribute )
	return COverthrowGameMode:MythicWeaponAttributeValue( attribute ) * 100 --100 assumed max, actually 100 atm but issue on older weapons
end

function COverthrowGameMode:MythicWeaponAttributeValue( attribute )
	if attribute == " Damage" then
		return 2
	end
	if attribute == " Auto Attack Damage" then
		return 5
	end
	if attribute == "% Ability Crit (300%)" and COverthrowGameMode.version == 1 then
		return 0.33333
	end
	if attribute == "% Ability Crit (300%)" and COverthrowGameMode.version == 2 then
		return 0.11
	end
	if attribute == "% Ability Critical Damage" then
		return 0.2
	end
	if attribute == "% Attack Speed" and COverthrowGameMode.version == 1 then
		return 10
	end
	if attribute == "% Attack Speed" and COverthrowGameMode.version == 2 then
		return 1.25
	end
	if attribute == " Spellpower" then
		return 2
	end
	if attribute == " Armor" then
		return 0.075
	end
	if attribute == " Spell Resistance" and COverthrowGameMode.version == 1 then
		return 1
	end
	if attribute == " Spell Resistance" and COverthrowGameMode.version == 2 then
		return 0.15
	end
	if attribute == "% Auto Attack Crit (300%)" and COverthrowGameMode.version == 1 then
		return 0.33333
	end
	if attribute == "% Auto Attack Crit (300%)" and COverthrowGameMode.version == 2 then
		return 0.25
	end
	if attribute == " Armor Reduction" and COverthrowGameMode.version == 1 then
		return 0.25
	end
	if attribute == " Armor Reduction" and COverthrowGameMode.version == 2 then
		return 0.05
	end
	if attribute == " Block" then
		return 10
	end
	if attribute == " Max Health" then
		return 20 --25 --45
	end
	if attribute == "% Resistance Reduction" and COverthrowGameMode.version == 1 then
		return 0.25
	end
	if attribute == "% Resistance Reduction" and COverthrowGameMode.version == 2 then
		return 0.1
	end
	if attribute == " Max Mana" then
		return 5 --25 --45
	end
	if attribute == "% Physical Damage" or attribute == "% Fire Damage" or attribute == "% Shadow Damage" or attribute == "% Frost Damage" or attribute == "% Arcane Damage" or attribute == "% Nature Damage" or attribute == "% Holy Damage" or attribute == "% Chaos Damage" then
		return 0.75
	end
	if attribute == " Physical Damage" or attribute == " Fire Damage" or attribute == " Shadow Damage" or attribute == " Frost Damage" or attribute == " Arcane Damage" or attribute == " Nature Damage" or attribute == " Holy Damage" or attribute == " Chaos Damage" then
		return 6
	end
	if attribute == "% Aggro Caused" then
		return 5
	end
	if attribute == "% Aggro Lowered" then
		return 5
	end
	if attribute == "% Energy Regeneration" and COverthrowGameMode.version == 1 then
		return 1
	end
	if attribute == "% Energy Regeneration" and COverthrowGameMode.version == 2 then
		return 0.2
	end
	if attribute == "% Damage" and COverthrowGameMode.version == 1 then
		return 1.5
	end
	if attribute == "% Damage" and COverthrowGameMode.version == 2 then
		return 0.25
	end
	if attribute == "% AOE Ability Damage" then
		return 0.5
	end
	if attribute == "% Single Target Ability Damage" then
		return 0.4
	end
	if attribute == "% DoT Ability Damage" then
		return 0.5
	end
	if attribute == "% Healing" and COverthrowGameMode.version == 1 then
		return 1.5
	end
	if attribute == "% Healing" and COverthrowGameMode.version == 2 then
		return 0.25
	end
	if attribute == "% Cooldown Reduction" and COverthrowGameMode.version == 1 then
		return 0.4
	end
	if attribute == "% Cooldown Reduction" and COverthrowGameMode.version == 2 then
		return 0.15
	end
	if attribute == "% Movement Speed" and COverthrowGameMode.version == 1 then
		return 0.5
	end
	if attribute == "% Movement Speed" and COverthrowGameMode.version == 2 then
		return 0.1
	end
	if attribute == " Ability Point(s)" and COverthrowGameMode.version == 1 then
		return 0.035
	end
	if attribute == " Ability Point(s)" and COverthrowGameMode.version == 2 then
		return 0.025
	end
	if attribute == " Path Point(s)" and COverthrowGameMode.version == 1 then
		return 0.055
	end
	if attribute == " Path Point(s)" and COverthrowGameMode.version == 2 then
		return 0.025
	end
	if attribute == " % Max Health" then
		return 0.25
	end
	if attribute == " Spellhaste" then
		return 1.12 --0.75
	end
	
	--runewords
	if attribute == " Rune Power: FAH" or attribute == " Rune Power: WII" or attribute == " Rune Power: LOO" or attribute == " Rune Power: TAL" or attribute == " Rune Power: NAH" or attribute == " Rune Power: ZER" or
			attribute == " Rune Power: TEM" or attribute == " Rune Power: TIC" or attribute == " Rune Power: KIL" or attribute == " Rune Power: ROH" or attribute == " Rune Power: SIN" then
		if COverthrowGameMode.version == 1 then
			return 0.425
		end
		if COverthrowGameMode.version == 2 then
			return 0.2
		end
	end
	if string.sub(attribute, 1, 6) == " Path:" then
		return 0.035 --0.04
	end

	--new artifact powers: damage 0.25, eledmg 0.75 passive
	if attribute == " % First Blood" then
		return 0.75
	end
	if attribute == " % Echo" then
		return 0.5
	end
	if attribute == " % Spell Cleave" then
		return 0.15
	end
	if attribute == " % Sonic Wall" then
		return 0.15
	end
	if attribute == " % Primal Fear" then
		return 0.5
	end
	if attribute == " Corrosive Skin" then
		return 0.05
	end
	if attribute == " War Leader" then
		return 0.5
	end
	if attribute == " Leader of the Pack" then
		return 0.5
	end
	if attribute == " Archmage" then
		return 0.5
	end
	if attribute == " % Crusader" then
		return 0.25
	end
	if attribute == " % Wrath of God" then
		return 0.375
	end
	if attribute == " Interstellar" then
		return 3
	end
	if attribute == " % Shapeshifter" then
		return 0.75
	end
	if attribute == " % Lion King" then
		return 0.75
	end
	if attribute == " % Overheat" then
		return 1
	end
	if attribute == " % Mountain King" then
		return 0.04
	end
	if attribute == " % Sacred Protection" then
		return 0.35
	end
	if attribute == " % Overpower" then
		return 2
	end
	if attribute == " % Cold Chain" then
		return 0.25
	end
	if attribute == " % Almighty" then
		return 0.2
	end
	if attribute == " % Conjurer" then
		return 0.02
	end
	if attribute == " % Hunter" then
		return 1
	end
	if attribute == " % Balance of Power" then
		return 0.04
	end
	if attribute == " Supercharge" then
		return 0.03
	end
	if attribute == " % Berserker" then
		return 1
	end
	if attribute == " % Eye of the Tiger" then
		return 0.75
	end
	if attribute == " % Titan Sorcerer" then
		return 0.5
	end
	if attribute == " % Fortress of Destruction" then
		return 0.75
	end
	if attribute == " % Inner Fire" then
		return 0.15
	end
	if attribute == " % Beast Within" then
		return 0.5
	end
	if attribute == " % Shivering Cold" then
		return 0.5
	end
	if attribute == " % Force of Nature" then
		return 0.4
	end

	if attribute == " % Fist of Fire" then
		return 0.4
	end
	if attribute == " % Frost Fever" then
		return 0.25
	end
	if attribute == " % Shadow Warrior" then
		return 3
	end
	if attribute == " % Underlord" then
		return 2
	end
	if attribute == " % Wrath of Zeus" then
		return 0.5
	end
	if attribute == " % Hand of God" then
		return 0.4
	end
	if attribute == " % Nether Core" then
		return 3
	end

	if attribute == " % Multistrike" then
		return 0.1
	end
	if attribute == " % Flamewalker" then
		return 4
	end
	if attribute == " % Tides of Time" then
		return 0.5
	end
	if attribute == " % Afterburn" then
		return 1.5
	end
	if attribute == " % Frostbite" then
		return 1
	end
	if attribute == " % Twin Blast" then
		return 0.75
	end
	if attribute == " % Black Mirror" then
		return 0.8
	end
	if attribute == " % Star Collapse" then
		return 1
	end
	if attribute == " % Hemorrhage" then
		return 0.375
	end
	if attribute == " % Radiance" then
		return 0.4
	end
	if attribute == " % Nature's Harmony" then
		return 0.25
	end
	if attribute == " % Tower of Chaos" then
		return 0.3
	end
	if attribute == " % Netherfusion" then
		return 0.4
	end
	if attribute == " % Swift Mending" then
		return 0.1
	end
	if attribute == " % Divine Shield" then
		return 0.25
	end
	if attribute == " % Chivalry" then
		return 0.25
	end
	if attribute == " % Boulder Giant" then
		return 0.25
	end
	if attribute == " % Thunder Giant" then
		return 0.25
	end
	if attribute == " % Alchemist" then
		return 0.75
	end
	if attribute == " Manaworm" then
		return 0.05
	end
	if attribute == " % Massive Massacre" then
		return 1
	end
	if attribute == " % Metamorphosis" then
		return 1
	end
	return 1
end

function GetGeneratedItemType(weapon) -- attributes per category
	local suffix = weapon:sub(15-6,17-6)
	local category = 1
	--str, default
	--if suffix == "fis" or suffix == "str" or suffix == "phy" or suffix == "phd" or suffix == "fah" or suffix == "loo" or suffix == "wii" or suffix == "tal" or suffix == "zer" or suffix == "nah" or suffix == "tem" or suffix == "tic" or suffix == "kil" or suffix == "roh" or suffix == "aoe" then
	--	category = 1
	--end
	--agi
	if suffix == "mma" or suffix == "met" or suffix == "swi" or suffix == "hem" or suffix == "mul" or suffix == "eot" or suffix == "pac" or suffix == "ech" or suffix == "agi" or suffix == "ats" or suffix == "aac" or suffix == "aad" or suffix == "mov" or suffix == "cha" or suffix == "chd" or suffix == "sha" or suffix == "shd" then
		category = 2
	end
	--int
	if suffix == "mwo" or suffix == "thu" or suffix == "stc" or suffix == "bla" or suffix == "fbi" or suffix == "aft" or suffix == "fla" or suffix == "tsc" or suffix == "ins" or suffix == "mag" or suffix == "swa" or suffix == "int" or suffix == "spp" or suffix == "man" or suffix == "arc" or suffix == "ard" or suffix == "fir" or suffix == "fid" or suffix == "hol" or suffix == "hod" or suffix == "fro" or suffix == "frd" or suffix == "sin" or suffix == "sph" then
		category = 3
	end
	--def
	if suffix == "div" or suffix == "tow" or suffix == "frt" or suffix == "wra" or suffix == "arm" or suffix == "res" or suffix == "hpp" or suffix == "blo" or suffix == "nat" or suffix == "nad" or suffix == "hea" or suffix == "cdr"or suffix == "mhp" then
		category = 4
	end
	--offensive neutral
	if suffix == "alc" or suffix == "mig" or suffix == "har" or suffix == "rad" or suffix == "twi" or suffix == "tid" or suffix == "ifi" or suffix == "shc" or suffix == "ber" or suffix == "bwi" or suffix == "fon" or suffix == "shs" or suffix == "csk" or suffix == "spc" or suffix == "aaa" or suffix == "crd" or suffix == "abc" or suffix == "ene" or suffix == "abp" or suffix == "abi" or suffix == "pat" or suffix == "arr" or suffix == "dot" then
		category = 5
	end
	return category
end



function COverthrowGameMode:GenerateCoolItemEffectWithStatTransfer()
	--stat transfer: from to
	local stat1 = COverthrowGameMode.HeroStatsData[math.random(1,14)]
	local stat2 = COverthrowGameMode.HeroStatsData[math.random(1,#COverthrowGameMode.HeroStatsData)]   --[math.random(1,41)]
	while stat1 == stat2 do
		stat2 = COverthrowGameMode.HeroStatsData[math.random(1,#COverthrowGameMode.HeroStatsData)] --[math.random(1,41)]
	end
	local transferAmount = 0.5
	local baseAmount = 1
	local itemStatType = 1
	local weightedTransferAmount = baseAmount * transferAmount * stat2[2] / stat1[2]
	local text = COverthrowGameMode.ItemStatTypes[itemStatType][2] .. ": Gain +" .. weightedTransferAmount .. stat2[3] .. " for every Point of" .. stat1[3]
	if math.random(1,100) <= (#COverthrowGameMode.ItemStatTypes - 1) * 10 then
		itemStatType = math.random(2,#COverthrowGameMode.ItemStatTypes)
		weightedTransferAmount = weightedTransferAmount * COverthrowGameMode.ItemStatTypes[itemStatType][5]
		local preText = COverthrowGameMode.ItemStatTypes[itemStatType][2]
		if COverthrowGameMode.ItemStatTypes[itemStatType][3] < 100 then
			preText = preText .. " (" .. COverthrowGameMode.ItemStatTypes[itemStatType][3] .. "% Chance)"
		end
		text = preText .. ": Gain +" .. weightedTransferAmount .. stat2[3] .. " for every Point of" .. stat1[3] .. " for " .. COverthrowGameMode.ItemStatTypes[itemStatType][4] .. " secs"
	end
	print(text)
	local itemCode = "trans_" .. stat1[1] .. "_" .. stat2[1] .. "_" .. COverthrowGameMode.ItemStatTypes[itemStatType][1]
	print("code: " .. itemCode)
	local itemName = "Armor of " .. stat1[5] .. " " .. stat2[6]
	print(itemName)
end

COverthrowGameMode.ItemStatTypes = {
	-- code, name, proc chance, effect duration, stat factor
	{"pas", "Passive", 100, -1, 1},
	{"ona", "On Attack", 3, 10, 2},
	{"ond", "On Deal Damage", 2, 10, 2},
	{"ont", "On Take Damage", 100, 10, 2},
	{"onc", "On Cast", 5, 10, 2},
	{"onh", "On Heal", 5, 15, 2},
	{"on3", "On Cast 3rd Ability", 100, 8, 1.75},
	{"on4", "On Cast 4th Ability", 100, 10, 2},
	{"on5", "On Cast 5th Ability", 100, 12, 2.25},
	{"on6", "On Cast 6th Ability", 100, 15, 2.5}
}

--new word based stat system, only stackable stats that are balanced (not armor reduction for example)
COverthrowGameMode.HeroStatsData = {
	-- code, valuePerPoint, stat name, desc1, desc2, desc3
	--base stats
    {"str", 1, " Strength", "Grizzly", "Giant", "Power"}, --first is attribute given, 2 3 4 are item name suffixes
    {"agi", 1, " Agility", "Fury", "Swift", "Swiftness"},
    {"int", 1, " Intellect", "Dragon", "Mindful", "Dragons"},
    {"aaa", 2, " Attack Damage", "Spike", "Spiky", "Spikes"}, --weapons, shoulder, ring, 
    {"aad", 6, " Auto Attack Damage", "Sharp", "Hurting", "Harm"}, --only weapon
    {"spp", 2, " Spellpower", "Wizard", "Mythical", "Magic"},  
    {"ats", 2, " Attack Speed", "Windfury", "Rapid", "Combat"}, --weapons, shoulder
    {"has", 2, " % Spellhaste", "Flowing", "Flowing", "Flow"}, --weapons, shoulder
    --cooldown
    {"cdr", 0.1, " % Cooldown Reduction", "Eternal", "Eternal", "Eternity"}, --weapons, shoulder
    --defenses
    {"hpp", 30, " Health", "Titan", "Immense", "Might"}, --not weapons and ring
    {"arm", 0.2, " Armor", "Valyrian", "Unbreakable", "Defense"}, --not weapons and ring
    {"res", 0.25, " Spell Resistance", "Barrier", "Enchanted", "Shelter"}, --not weapons and ring
    {"blo", 5, " Block", "Massive", "Massive", "Walls"}, --offhand, chest, shoulder
    {"drd", 0.05, " % Damage Reduction", "Barricade", "Barricading", "Barricades"}, --offhand, chest, shoulder
    {"eva", 0.1, " % Evasion", "Elusion", "Elusive", "Elusion"}, --offhand, chest, shoulder
    
    --ability %
    {"abp", 0.2, " % Damage", "Evil", "Evil", "Evil"}, --weapons, shoulder
    {"hea", 0.3, " % Healing", "Sacred", "Sacred", "Sanctity"}, --weapons, shoulder, ring
    {"aoe", 0.6, " % AOE Ability Damage", "Cleaver", "Cleaving", "Cleaving"}, --only mainhand offhand
    {"dot", 0.45, " % DoT Ability Damage", "Decaying", "Decaying", "Decay"}, --only mainhand offhand
    {"sin", 0.45, " % Single Target Ability Damage", "Focussed", "Focussed", "Focus"}, --only mainhand offhand
    --crit dmg
    {"crd", 0.2, " % Ability Critical Damage", "Colossal", "Cruel", "Destruction"}, --offhand, ring
    {"abh", 0.2, " % Auto Attack Crit Damage", "Slaughter", "Slaughtering", "Slaughter"}, --weapons, shoulder, ring
    --ele
    {"fir", 0.4, " % Fire Damage", "Burning", "Burning", "Lava"},
    {"sha", 0.4, " % Shadow Damage", "Dark", "Dark", "Darkness"},
    {"arc", 0.4, " % Arcane Damage", "Arcane", "Arcane", "Wizardry"},
    {"fro", 0.4, " % Frost Damage", "Frozen", "Frozen", "Frost"},
    {"nat", 0.4, " % Nature Damage", "Earthen", "Earthen", "Bark"},
    {"cha", 0.4, " % Chaos Damage", "Chaos", "Chaotic", "Chaos"},
    {"hol", 0.4, " % Holy Damage", "Divine", "Divine", "Divinity"},
    {"phy", 0.4, " % Physical Damage", "Iron", "Hard", "Iron"},
    {"fid", 5, " Fire Damage", "Fire", "Fiery", "Fire"},
    {"shd", 5, " Shadow Damage", "Shadow", "Sinister", "Shadows"},
    {"ard", 5, " Arcane Damage", "Storm", "Stormy", "Storms"},
    {"frd", 5, " Frost Damage", "Ice", "Iced", "Ice"},
    {"nad", 5, " Nature Damage", "Viperbite", "Biting", "Bites"},
    {"chd", 5, " Chaos Damage", "Underworld", "Abyssal", "Underworlds"},
    {"hod", 5, " Holy Damage", "Holy", "Holy", "Prayers"},
    {"phd", 5, " Physical Damage", "Metal", "Metallic", "Metal"},
    --resources
    {"man", 30, " Mana", "Nether", "Endless", "Wisdom"}, 
    {"enm", 0.25, " Max Energy", "Energy", "Energetic", "Energy"},
    {"ene", 0.25, " % Energy Regeneration", "Runic", "Runic", "Runes"}, --weapons, shoulder
    --base stat percent
    {"stp", 0.1, " % Total Strength", "Bear", "Growing", "Bears"}, --first is attribute given, 2 3 4 are item name suffixes
    {"agp", 0.1, " % Total Agility", "Furious", "Furious", "Fury"},
    {"inp", 0.1, " % Total Intellect", "Witcher", "Evoking", "Witchers"},
    {"aap", 0.1, " % Total Attack Damage", "Ripper", "Ripping", "Rupture"}, --weapons, shoulder, ring, 
    {"spe", 0.1, " % Total Spellpower", "Caster", "Casting", "Casters"}, 
    {"arp", 0.1, " % Total Armor", "Tower", "Towering", "Towers"}, 
    {"blp", 0.1, " % Total Block", "Wall", "Walling", "Walls"}, 
    {"hpe", 0.1, " % Total Health", "Vitality", "Vital", "Vitality"}, 
    {"map", 0.1, " % Total Mana", "Deep", "Deep", "Depth"}, 
    --crit procs
    {"abc", 0.05, " % Ability Crit (300%)", "Executioner", "Final", "Execution"}, --weapons, shoulder, ring
    {"abd", 0.025, " % Ability Crit (1000%)", "Cataclysm", "Cataclysmic", "Cataclysm"}, --weapons, shoulder, ring
    {"aac", 0.025, " % Auto Attack Crit (300%)", "Deadly", "Deadly", "Conflict"}, --weapons
    {"aae", 0.05, " % Auto Attack Crit (300%)", "Piercer", "Piercing", "Piercing"} --weapons
}

--new generated items
COverthrowGameMode.GeneratedItemData = {
    {"str", " Strength", "Grizzly", "Grizzly", "Power"}, --first is attribute given, 2 3 4 are item name suffixes
    {"agi", " Agility", "Fury", "Swift", "Swiftness"},
    {"int", " Intellect", "Dragon", "Mindful", "Dragons"},
    {"aaa", " Attack Damage", "Spike", "Spiky", "Spikes"}, --weapons, shoulder, ring, 
    {"spp", " Spellpower", "Wizard", "Mythical", "Magic"}, 
    {"crd", "% Ability Critical Damage", "Colossal", "Cruel", "Destruction"}, --offhand, ring
    {"ats", " Attack Speed", "Windfury", "Rapid", "Combat"}, --weapons, shoulder
    {"abc", "% Ability Crit (300%)", "Executioner", "Final", "Execution"}, --weapons, shoulder, ring
    {"arm", " Armor", "Valyrian", "Unbreakable", "Defense"}, --not weapons and ring
    {"res", " Spell Resistance", "Barrier", "Enchanted", "Shelter"}, --not weapons and ring
    {"aac", "% Auto Attack Crit (300%)", "Deadly", "Deadly", "Conflict"}, --weapons
    {"hpp", " Max Health", "Vitality", "Vital", "Vitality"}, --not weapons and ring
    {"man", " Max Mana", "Endless", "Endless", "Wisdom"}, 
    {"fir", "% Fire Damage", "Burning", "Burning", "Lava"},
    {"sha", "% Shadow Damage", "Dark", "Dark", "Darkness"},
    {"arc", "% Arcane Damage", "Arcane", "Arcane", "Wizardry"},
    {"fro", "% Frost Damage", "Frozen", "Frozen", "Frost"},
    {"nat", "% Nature Damage", "Earthen", "Earthen", "Bark"},
    {"cha", "% Chaos Damage", "Chaos", "Chaotic", "Chaos"},
    {"hol", "% Holy Damage", "Divine", "Divine", "Divinity"},
    {"phy", "% Physical Damage", "Iron", "Hard", "Iron"},
    {"ene", "% Energy Regeneration", "Runic", "Runic", "Runes"}, --weapons, shoulder
    {"abp", "% Damage", "Evil", "Evil", "Evil"}, --weapons, shoulder
    {"hea", "% Healing", "Sacred", "Sacred", "Sanctity"}, --weapons, shoulder, ring
    {"cdr", "% Cooldown Reduction", "Eternal", "Eternal", "Eternity"}, --weapons, shoulder
    {"blo", " Block", "Blocker", "Blocking", "Walls"}, --offhand, chest, shoulder
    {"aad", " Auto Attack Damage", "Sharp", "Hurting", "Harm"}, --only weapon
    {"abi", " Ability Point(s)", "Wise", "Deep", "Knowledge"}, --only ring
    {"pat", " Path Point(s)", "Brilliant", "Brilliant", "Brilliance"}, --only ring

    {"fah", " Rune Power: FAH", "Fanatic", "Fanatic", "Fanaticism"}, --only 4
    {"loo", " Rune Power: LOO", "Mystic", "Mystic", "Myths"}, --only 4
    {"wii", " Rune Power: WII", "Spirit", "Spiritual", "Spirits"}, --only 4
    {"tal", " Rune Power: TAL", "Talon", "Damaging", "Talons"}, --only 5
    {"zer", " Rune Power: ZER", "Bone", "Thick", "Bones"}, --only 5
    {"nah", " Rune Power: NAH", "Ghostly", "Ghostly", "Ghosts"}, --only 5
    {"tem", " Rune Power: TEM", "Elder", "Elderly", "Decay"}, --only 6
    {"tic", " Rune Power: TIC", "Aged", "Aged", "Aging"}, --only 6
    {"kil", " Rune Power: KIL", "Killer", "Killing", "Assassination"}, --only 6
    {"fah", " Rune Power: FAH", "Fanatic", "Fanatic", "Fanaticism"}, --only 4
    {"loo", " Rune Power: LOO", "Mystic", "Mystic", "Myths"}, --only 4
    {"wii", " Rune Power: WII", "Spirit", "Spiritual", "Spirits"}, --only 4
    {"tal", " Rune Power: TAL", "Talon", "Damaging", "Talons"}, --only 5
    {"zer", " Rune Power: ZER", "Bone", "Thick", "Bones"}, --only 5
    {"nah", " Rune Power: NAH", "Ghostly", "Ghostly", "Ghosts"}, --only 5
    {"tem", " Rune Power: TEM", "Elder", "Elderly", "Decay"}, --only 6
    {"tic", " Rune Power: TIC", "Aged", "Aged", "Aging"}, --only 6
    {"kil", " Rune Power: KIL", "Killer", "Killing", "Assassination"}, --only 6
    {"fah", " Rune Power: FAH", "Fanatic", "Fanatic", "Fanaticism"}, --only 4
    {"loo", " Rune Power: LOO", "Mystic", "Mystic", "Myths"}, --only 4
    {"wii", " Rune Power: WII", "Spirit", "Spiritual", "Spirits"}, --only 4
    {"tal", " Rune Power: TAL", "Talon", "Damaging", "Talons"}, --only 5
    {"zer", " Rune Power: ZER", "Bone", "Thick", "Bones"}, --only 5
    {"nah", " Rune Power: NAH", "Ghostly", "Ghostly", "Ghosts"}, --only 5
    {"tem", " Rune Power: TEM", "Elder", "Elderly", "Decay"}, --only 6
    {"tic", " Rune Power: TIC", "Aged", "Aged", "Aging"}, --only 6
    {"kil", " Rune Power: KIL", "Killer", "Killing", "Assassination"}, --only 6
    {"fah", " Rune Power: FAH", "Fanatic", "Fanatic", "Fanaticism"}, --only 4
    {"loo", " Rune Power: LOO", "Mystic", "Mystic", "Myths"}, --only 4
    {"wii", " Rune Power: WII", "Spirit", "Spiritual", "Spirits"}, --only 4
    {"tal", " Rune Power: TAL", "Talon", "Damaging", "Talons"}, --only 5
    {"zer", " Rune Power: ZER", "Bone", "Thick", "Bones"}, --only 5
    {"nah", " Rune Power: NAH", "Ghostly", "Ghostly", "Ghosts"}, --only 5
    {"tem", " Rune Power: TEM", "Elder", "Elderly", "Decay"}, --only 6
    {"tic", " Rune Power: TIC", "Aged", "Aged", "Aging"}, --only 6
    {"kil", " Rune Power: KIL", "Killer", "Killing", "Assassination"}, --only 6
    {"fah", " Rune Power: FAH", "Fanatic", "Fanatic", "Fanaticism"}, --only 4
    {"loo", " Rune Power: LOO", "Mystic", "Mystic", "Myths"}, --only 4
    {"wii", " Rune Power: WII", "Spirit", "Spiritual", "Spirits"}, --only 4
    {"tal", " Rune Power: TAL", "Talon", "Damaging", "Talons"}, --only 5
    {"zer", " Rune Power: ZER", "Bone", "Thick", "Bones"}, --only 5
    {"nah", " Rune Power: NAH", "Ghostly", "Ghostly", "Ghosts"}, --only 5
    {"tem", " Rune Power: TEM", "Elder", "Elderly", "Decay"}, --only 6
    {"tic", " Rune Power: TIC", "Aged", "Aged", "Aging"}, --only 6
    {"kil", " Rune Power: KIL", "Killer", "Killing", "Assassination"}, --only 6
    {"roh", " Rune Power: ROH", "Rhodes", "Raw", "Rhodes"}, --only 6
    {"roh", " Rune Power: ROH", "Rhodes", "Raw", "Rhodes"}, --only 6
    {"roh", " Rune Power: ROH", "Rhodes", "Raw", "Rhodes"}, --only 6
    {"roh", " Rune Power: ROH", "Rhodes", "Raw", "Rhodes"}, --only 6
    {"roh", " Rune Power: ROH", "Rhodes", "Raw", "Rhodes"}, --only 6
    {"sid", " Rune Power: SIN", "Sinner", "Sinful", "Sins"}, --only 6
    {"sid", " Rune Power: SIN", "Sinner", "Sinful", "Sins"}, --only 6
    {"sid", " Rune Power: SIN", "Sinner", "Sinful", "Sins"}, --only 6
    {"sid", " Rune Power: SIN", "Sinner", "Sinful", "Sins"}, --only 6
    {"sid", " Rune Power: SIN", "Sinner", "Sinful", "Sins"}, --only 6

    {"mov", "% Movement Speed", "Light", "Fast", "Floating"}, --only boots
    {"arr", " Armor Reduction", "Crushing", "Crushing", "Penetration"}, --only offhand
    {"srr", "% Resistance Reduction", "Breaker", "Breaking", "Ruin"}, --only offhand
    {"aoe", "% AOE Ability Damage", "Cleaver", "Cleaving", "Cleaving"}, --only mainhand offhand
    {"dot", "% DoT Ability Damage", "Decaying", "Decaying", "Decay"}, --only mainhand offhand
    {"sin", "% Single Target Ability Damage", "Focussed", "Focussed", "Focus"}, --only mainhand offhand

    {"fid", " Fire Damage", "Fire", "Fiery", "Fire"},
    {"shd", " Shadow Damage", "Shadow", "Sinister", "Shadows"},
    {"ard", " Arcane Damage", "Storm", "Stormy", "Storms"},
    {"frd", " Frost Damage", "Ice", "Iced", "Ice"},
    {"nad", " Nature Damage", "Viperbite", "Biting", "Bites"},
    {"chd", " Chaos Damage", "Underworld", "Abyssal", "Underworlds"},
    {"hod", " Holy Damage", "Holy", "Holy", "Prayers"},
    {"phd", " Physical Damage", "Metal", "Metallic", "Metal"},

    {"mhp", " % Max Health", "Mammoth", "Mammoth", "Mammoths"},
    {"sph", " Spellhaste", "Flow", "Flowing", "Flow"},

    --new unique power effects
    {"fis", " % First Blood", "Pioneer", "Pioneer", "Strikes"}, --must be first! to track beginning of list
    {"ech", " % Echo", "Echo", "Echoing", "Echoes"},
    {"scl", " % Spell Cleave", "Shatter", "Shattering", "Shattering"},
    {"swa", " % Sonic Wall", "Sonic", "Banging", "Waves"},
    {"fea", " % Primal Fear", "Fearful", "Fearful", "Fear"},
    {"csk", " Corrosive Skin", "Corrosive", "Corossive", "Acid"},
    {"war", " War Leader", "War", "Warlike", "War"},
    {"pac", " Leader of the Pack", "Wolf", "Wolfish", "Wolves"},
    {"mag", " Archmage", "Archmage", "Magical", "Archmages"},
    {"cru", " % Crusader", "Crusader", "Crusading", "Crusaders"},
    {"wra", " % Wrath of God", "Wrath", "Wrathful", "Wrath"},
    {"ins", " Interstellar", "Interstellar", "Interstellar", "Stars"},
    {"shs", " % Shapeshifter", "Shapeshifter", "Shapeshifting", "Shapeshifters"},
    {"ber", " % Berserker", "Berserker", "Berserker", "Berserkers"},
    {"eot", " % Eye of the Tiger", "Tiger", "Tiger", "Tigers"},
    {"tsc", " % Titan Sorcerer", "Sorcerer", "Titanic", "Sorcerers"},
    {"frt", " % Fortress of Destruction", "Fortress", "Destructive", "Fortresses"},
    {"ifi", " % Inner Fire", "Inner Fire", "Inner", "Flames"},
    {"bwi", " % Beast Within", "Beastial", "Beastial", "Beasts"},
    {"shc", " % Shivering Cold", "Shivering", "Shivering", "Shiver"},
    {"fon", " % Force of Nature", "Natural", "Natural", "Force"},

    {"fof", " % Fist of Fire", "Glowing", "Glowing", "Glow"},
    {"ffe", " % Frost Fever", "Fever", "Frosty", "Fever"},
    
    {"shw", " % Shadow Warrior", "Night", "Nightly", "Nights"},
    {"und", " % Underlord", "Underlord", "Lordly", "Underlords"},
    {"woz", " % Wrath of Zeus", "Zeus", "Zeus'", "Zeus"},
    {"hog", " % Hand of God", "Godlike", "Godlike", "Gods"},
    {"nec", " % Nether Core", "Nether", "Nether", "Nether"},

    {"mul", " % Multistrike", "Multistrike", "Striking", "Multistrikes"},
    {"fla", " % Flamewalker", "Flamewalker", "Flamewalking", "Flamewalkers"},
    {"tid", " % Tides of Time", "Tidal", "Tidal", "Tides"},
    {"aft", " % Afterburn", "Afterburn", "Afterburning", "Incineration"},
    {"fbi", " % Frostbite", "Frostbite", "Frostbiting", "Frostbites"},
    {"twi", " % Twin Blast", "Twin", "Blasting", "Twins"},
    {"bla", " % Black Mirror", "Black", "Black", "Blackness"},
    {"stc", " % Star Collapse", "Collapsing", "Collapsing", "Collapse"},
    {"hem", " % Hemorrhage", "Hemorrhage", "Bleeding", "Hemorrhage"},
    {"rad", " % Radiance", "Radiance", "Radiating", "Radiance"},
    {"har", " % Nature's Harmony", "Harmony", "Harmonic", "Harmony"},
    {"tow", " % Tower of Chaos", "Tower", "Towering", "Towers"},
    {"mig", " % Netherfusion", "Nether", "Nether", "Netherfusion"},
    {"swi", " % Swift Mending", "Healing", "Healing", "Healing"},
    {"div", " % Divine Shield", "Shielding", "Shielding", "Shields"},
    {"chi", " % Chivalry", "Chivalry", "Knightly", "Chivalry"},
    {"mou", " % Boulder Giant", "Boulder", "Boulder", "Boulders"},
    {"thu", " % Thunder Giant", "Thunder", "Thunderous", "Thunder"},
    {"alc", " % Alchemist", "Alchemist", "Toxic", "Alchemists"},
    {"mwo", " Manaworm", "Manaworm", "Manaworm", "Manaworms"},
    {"mma", " % Massive Massacre", "Massacre", "Massive", "Massacre"},
    {"lio", " % Lion King", "Lion King", "Lion King's", "Lion Kings"},
    {"mtk", " % Mountain King", "Mountain King", "Mountainous", "Mountain Kings"},
    {"sup", " Supercharge", "Supercharge", "Supercharging", "Supercharges"},
    {"alm", " % Almighty", "Almighty", "Almighty", "Almighty Gods"},
    {"bop", " % Balance of Power", "Balance of Power", "Balanced", "Balance of Power"},
    {"con", " % Conjurer", "Conjurer", "Conjuring", "Conjurers"},
    {"hun", " % Hunter", "Hunter", "Hunting", "Hunters"},
    {"sac", " % Sacred Protection", "Sacred Protection", "Protective", "Protection"},
    {"ovp", " % Overpower", "Overpowered", "Overpowering", "Overpowering"},
    {"coc", " % Cold Chain", "Cold", "Cool", "Cold"},
    {"ovh", " % Overheat", "Overheating", "Overheated", "Overheating"},
    {"met", " % Metamorphosis", "Metamorphosis", "Morphing", "Metamorphosis"} --must be last! to track end of list

    --[[path
    {"y01", "Grizzly's Power",
	{"y02", "Sharp Claws",
	{"y03", "Wound Mending",
	{"y04", "Flesh Wounds",
	{"y05", "Iron Skin",
	{"y06", "Presence of Power",
	{"y07", "Maul",
	{"y08", "Colossal Strikes",
	{"y09", "Momentum of Mass",
	{"y10", "Iron Muscles",
	{"y10", "Bear of War",
	{"y10", "Iron Fury",
	{"y10", "Tiger's Swiftness",
	{"y10", "Armored War Tiger",
	{"y10", "Flow of Combat",
	{"y10", "Moonlight Fairies",
	{"y10", "Full Moon",
	{"y10", "Tigerbites",
	{"y10", "Sharpened Senses",
	{"y10", "Careful Aim",
	{"y10", "Fragile Moon",
	{"The Stars Aligned",
	{"Rain of Stars",
	{"Moonglaive Shield",
	{"Dragon's Knowledge",
	{"Mindstorm",
	{"Netherdragon Scales",
	{"Timebender",
	{"Dragon's Breath",
	{"Blizzard",
	{"Master Magician",
	{"Focussed Mind",
	{"Mana Shield",
	{"Knowledge is Power",
	{"Sharpeye",
	{"Dragon Fire",
	{"Deadly Hits",
	{"Wolf's Versatility",
	{"Lick Wounds",
	{"Tenacity",
	{"Howl of Time",
	{"Spiritwolf Protection",
	{"Rip Armor",
	{"Backstab",
	{"Alpha Blood",
	{"Blood Wolf",
	{"Wolf Rage",
	{"Hunt the Weak",
	{"Steadiness",
	{"Swipe of Ursa",
	--{" ",
	{"Patient Prowler",
	{"Windfury",
	--{" ",
	{"Ice Storm",
	{"Lizard Wizard",
	--{" ",
	{"Lifeblood",
	{"Howl of the Pact",
	--{" ",
	{"Demon Fury",
	{"Dark Wizardry",
	{"Warden of Souls",
	{"A Light in the Dark",
	{"Shadow Colossus",
	{"Shadow Claws",
	{"Hellborn",
	{"Apocalypse",
	{"Cruel Taskmaster",
	{"From the Shadows",
	{"Overwhelm",
	{"Dark Offering",
	{"Shadow Form",
	{"Sacrifice of Souls",
	--{" ",
	{"Crow Feathers",
	{"Raven Onslaught",
	{"Storm Claws",
	{"Murder of Crows",
	{"Wings of Liberty",
	{"Skyfall",
	{"Pure Pecking",
	{"Windbreaker",
	{"Wings of Dominance",
	{"A Feast for Crows",
	{"Sky Combat",
	{"Storm Harpy",
	{"Ravencraft",
	{"Crowfall" --]]
}

--new path class items
COverthrowGameMode.PathTalentNames = {
	"Grizzly's Power",
	"Sharp Claws",
	"Wound Mending",
	"Iron Skin",
	"Presence of Power",
	"Flesh Wounds",
	"Maul",
	"Colossal Strikes",
	"Momentum of Mass",
	"Iron Muscles",
	"Bear of War",
	"Iron Fury",
	"Tiger's Swiftness",
	"Armored War Tiger",
	"Flow of Combat",
	"Moonlight Fairies",
	"Full Moon",
	"Tigerbites",
	"Phantom Assassin",
	"Careful Aim",
	"Fragile Moon",
	"The Stars Aligned",
	"Rain of Stars",
	"Moonglaive Shield",
	"Dragon's Knowledge",
	"Mindstorm",
	"Netherdragon Scales",
	"Timebender",
	"Dragon's Breath",
	"Blizzard",
	"Master Magician",
	"Focussed Mind",
	"Mana Shield",
	"Knowledge is Power",
	"Sharpeye",
	"Deathwing",
	"Deadly Hits",
	"Wolf's Versatility",
	"Lick Wounds",
	"Tenacity",
	"Howl of Time",
	"Spiritwolf Protection",
	"Rip Armor",
	"Backstab",
	"Alpha Blood",
	"Blood Wolf",
	"Wolf Rage",
	"Impale",
	"Steadiness",
	"Swipe of Ursa",
	"Steel Mammoth",
	"Patient Prowler",
	"Windfury",
	"Tiger's Fury",
	"Ice Storm",
	"Lizard Wizard",
	"Rise of the Phoenix",
	"Lifeblood",
	"Bestial Wrath",
	"Wolf Rider",
	"Demon Fury",
	"Dark Wizardry",
	"Warden of Souls",
	"A Light in the Dark",
	"Shadow Colossus",
	"Shadow Claws",
	"Hellborn",
	"Apocalypse",
	"Cruel Taskmaster",
	"From the Shadows",
	"Overwhelm",
	"Dark Offering",
	"Shadow Form",
	"Sacrifice of Souls",
	"Three Face God",
	"Crow Feathers",
	"Raven Onslaught",
	"Storm Claws",
	"Murder of Crows",
	"Wings of Liberty",
	"Skyfall",
	"Pure Pecking",
	"Windbreaker",
	"Wings of Dominance",
	"A Feast for Crows",
	"Sky Combat",
	"Storm Harpy",
	"Ravencraft",
	"Crowfall",
	"Fury of the Eagle",
	"Dreadsteed",
	"Frostmourne",
	"Bone Shield",
	"Deadfury",
	"Shadowfrost",
	"Epidemic",
	"Bloodflow",
	"Unholy Frenzy",
	"Reign of Chaos",
	"Chaos Knight",
	"Unholy Aura",
	"Lord of Bones",
	"Heartbreaker",
	"Frostwyrm's Fury",
	"Reaper of Souls",
	"Guardian Shield",
	"Lone Druid",
	"Mountain Ranger",
	"Stone Skin",
	"Meditation",
	"Overgrowth",
	"Bark Skin",
	"Elder Wisdom",
	"Aspect of the Viper",
	"Ancient of War",
	"Ram Guardian",
	"Bull Rush",
	"Molten Giant",
	"Storm Giant",
	"Arcane Giant",
	"Giant Growth",
	"Critical Mass",
	"Growing Pains",
	"Lunar Eclipse",
	"Butterfly Effect",
	"Starfire",
	"Dragonfury",
	"Cataclysm",
	"Song of Ice and Fire",
	"Savagery",
	"Lycanthrope",
	"Primal Power",
	"Mimesis",
	"Nemesis",
	"Genesis",
	"Typhoon Thunder",
	"Hysteria",
	"Natural Disaster",
	"Four Horsemen",
	"Mutation",
	"Infestor",
	"Tree of Life",
	"Mountain Giant",
	"Mark of Nature",
	"Elusiveness",
	"Dual Wielding",
	"Dark Initiation",
	"Weapon Mastery",
	"Marked for Death",
	"Shield Shatter",
	"Alacrity",
	"Cold Blood",
	"Blood Moon",
	"Trickster",
	"Executioner",
	"Rogue Resistance",
	"Inner Focus",
	"Deadly Arsenal",
	"Ambush",
	"Preparation",
	"Killing Spree",
	"Phantom Shade",
	"Vitality",
	"Flurry",
	"Tunnel Vision",
	"Witch Doctor",
	"Jungle Roamer",
	"Unpredictable",
	"Troll Regeneration",
	"Poison Darts",
	"Voodoo Magic",
	"Fresh Blood",
	"Bloodthirst",
	"Gargantuan",
	"Tribal Power",
	"Slash and Burn",
	"Stampede",
	"Aspect of the Jungle",
	"Duelist",
	"Aspect of the Snake"
}

function IsStatAllowedForItemSlot(stat, slot, quality)
	--new exceptions
	if stat == "fid" or stat == "shd" or stat == "ard" or stat == "frd" or stat == "nad" or stat == "chd" or stat == "hod" or stat == "phd" then
		if slot == 1 then
			return true
		else
			return false
		end
	end
	if stat == "sid" then
		return slot == 4
	end
	if stat == "cdr" then --disabled cdr on most artifacts
		return slot == 1
	end
	if stat == "res" or stat == "arm" then --disabled cdr on most artifacts
		return slot == 2 or slot == 5
	end
	if stat == "abi" then
		if slot == 3 or slot == 7 or slot == 8 then
			return true
		else
			return false
		end
	end
	if (slot ~= 1 or (quality and quality <= 5)) and (stat == "lio" or stat == "alm" or stat == "bop" or stat == "con" or stat == "hun" or stat == "coc" or stat == "mtk" or stat == "ovh" or stat == "ovp") then
		return false --mainhand
	end
	if (slot ~= 2 or (quality and quality <= 5)) and (stat == "ffe" or stat == "fof" or stat == "woz" or stat == "und" or stat == "shw" or stat == "nec" or stat == "hog" or stat == "sac" or stat == "sup") then
		return false --offhand
	end
	if slot ~= 2 and stat == "blo" then
		return false
	end
	if (slot ~= 9 or (quality and quality <= 5)) and (stat == "fis" or stat == "scl" or stat == "fea" or stat == "ins" or stat == "mul" or stat == "aft" or stat == "fbi" or stat == "twi" or stat == "stc" or stat == "hem" or stat == "har" or stat == "div" or stat == "alc") then
		return false --gloves
	end
	if (slot ~= 10 or (quality and quality <= 5)) and (stat == "csk" or stat == "cru" or stat == "wra" or stat == "eot" or stat == "tsc" or stat == "frt" or stat == "ifi" or stat == "ber" or stat == "bwi" or stat == "fla" or stat == "tow" or stat == "chi" or stat == "mou" or stat == "thu" or stat == "mma") then
		return false --legs
	end
	if (slot ~= 11 or (quality and quality <= 5)) and (stat == "ech" or stat == "shc" or stat == "swa" or stat == "war" or stat == "pac" or stat == "mag" or stat == "shs" or stat == "tid" or stat == "fon" or stat == "bla" or stat == "rad" or stat == "mig" or stat == "swi" or stat == "met" or stat == "mwo") then
		return false --cape
	end
	if slot >= 9 and slot <= 11 and (COverthrowGameMode:IsRunePowerStat(stat) or stat == "abi" or stat == "pat" or stat == "abc" or stat == "aac" or stat == "hea" or stat == "abp" or stat == "cdr" ) then --no runes crit abi points etc for these
		return false
	end
	--old
	if (quality and quality <= 5) and (stat:sub(1,1) == "y" or stat:sub(1,1) == "z" or COverthrowGameMode:IsRunePowerStat(stat)) then
		return false
	end
	if slot == 7 and (stat:sub(1,1) == "y" or stat:sub(1,1) == "z" or stat == "arr" or stat == "srr" or stat == "aad" or stat == "mov" or stat == "fah" or stat == "loo" or stat == "wii" or stat == "sid" or stat == "tal" or stat == "zer"
	 		or stat == "nah"  or stat == "tem"  or stat == "tic"  or stat == "kil" or stat == "roh"  or stat == "aoe"  or stat == "sin" or stat == "dot" or stat == "mhp" or stat == "sph") then
		return false
	end
	if slot == 4 and (stat:sub(1,1) == "y" or stat:sub(1,1) == "z" or stat == "arr" or stat == "srr" or stat == "aaa" or stat == "ats" or stat == "crd" or stat == "abc" or stat == "aac" or stat == "ene" or stat == "abp" or stat == "hea" or stat == "cdr" or stat == "blo" or stat == "aad" or stat == "abi" or stat == "pat" or stat == "mov"
			 or stat == "tal" or stat == "zer"
	 		or stat == "nah"  or stat == "tem"  or stat == "tic" or stat == "kil" or stat == "roh" or stat == "aoe" or stat == "sin" or stat == "dot" or stat == "mhp" or stat == "sph") then
		return false
	end
	if slot == 5 and (stat:sub(1,1) == "y" or (stat:sub(1,1) == "z" and not stat == "zer") or stat == "arr" or stat == "srr" or stat == "aaa" or stat == "ats" or stat == "crd" or stat == "abc" or stat == "aac" or stat == "ene" or stat == "abp" or stat == "hea" or stat == "cdr" or stat == "blo" or stat == "aad" or stat == "abi" or stat == "pat" or stat == "mov"
			 or stat == "fah" or stat == "loo" or stat == "wii" or stat == "sid" 
	 		  or stat == "tem"  or stat == "tic"  or stat == "kil" or stat == "aoe" or stat == "sin" or stat == "dot" or stat == "sph") then
		return false
	end
	if slot == 6 and (stat:sub(1,1) == "y" or stat:sub(1,1) == "z" or stat == "arr" or stat == "srr" or stat == "aaa" or stat == "ats" or stat == "crd" or stat == "abc" or stat == "aac" or stat == "ene" or stat == "abp" or stat == "hea" or stat == "cdr" or stat == "blo" or stat == "aad" or stat == "abi" or stat == "pat"
			 or stat == "fah" or stat == "loo" or stat == "wii" or stat == "sid" or stat == "tal" or stat == "zer"
	 		or stat == "nah" or stat == "roh"  or stat == "aoe" or stat == "sin" or stat == "dot" or stat == "mhp" or stat == "sph") then
		return false
	end
	if slot == 1 and (stat:sub(1,1) == "y" or stat:sub(1,1) == "z" or stat == "arr" or stat == "srr" or stat == "crd" or stat == "arm" or stat == "res" or stat == "hpp" or stat == "blo" or stat == "abi" or stat == "pat" or stat == "mov" or stat == "fah" or stat == "loo" or stat == "wii" or stat == "sid" or stat == "tal" or stat == "zer"
	 		or stat == "nah"  or stat == "tem" or stat == "tic" or stat == "kil" or stat == "roh" or stat == "mhp") then
		return false
	end
	if slot == 2 and (stat:sub(1,1) == "y" or stat:sub(1,1) == "z" or stat == "arm" or stat == "res" or stat == "hpp" or stat == "abi" or stat == "pat" or stat == "mov" or stat == "fah" or stat == "loo" or stat == "wii" or stat == "sid" or stat == "tal" or stat == "zer"
	 		or stat == "nah"  or stat == "tem" or stat == "tic" or stat == "kil" or stat == "roh" or stat == "mhp" or stat == "sph") then
		return false
	end
	if slot == 3 and (stat == "arr" or stat == "pat" or stat == "srr" or stat == "aaa" or stat == "ats" or stat == "arm" or stat == "res" or stat == "aac" or stat == "hpp" or stat == "ene" or stat == "abp" or stat == "cdr" or stat == "blo" or stat == "mov"
			 or stat == "fah" or stat == "loo" or stat == "wii" or stat == "sid" or stat == "tal" or stat == "zer"
	 		or stat == "nah"  or stat == "tem"  or stat == "tic"  or stat == "kil" or stat == "roh"  or stat == "aoe" or stat == "sin" or stat == "dot" or stat == "mhp" or stat == "sph") then
		return false
	end
	if slot == 8 and (stat == "fah" or stat == "loo" or stat == "wii" or stat == "sid" or stat == "tal" or stat == "zer" or stat == "pat"
	 		or stat == "nah"  or stat == "tem" or stat == "tic" or stat == "kil" or stat == "roh" or stat == "mhp" or stat == "sph") then
		return false
	end
	return true
end

function GetGeneratedItemTypeName( weapon )
	local slot = COverthrowGameMode:GetMythicWeaponSlot(weapon)
	local itemtype = GetGeneratedItemType(weapon)
	local itemtypenames = {} --first array slots, 2nd array str/agi/int
	itemtypenames[1] = { --main hand
		"Hammer",
		"Dagger",
		"Staff",
		"Sword",
		"Axe"
	}
	itemtypenames[2] = { --off hand
		"Mace",
		"Knife",
		"Orb",
		"Shield",
		"Claw"
	}
	itemtypenames[3] = { --ring
		"Ring",
		"Loop",
		"Band",
		"Band",
		"Ring"
	}
	itemtypenames[4] = { --head
		"Helmet",
		"Hood",
		"Crown",
		"Faceguard",
		"Mask"
	}
	itemtypenames[5] = { --chest
		"Chainmail",
		"Tunic",
		"Robe",
		"Chestplate",
		"Raiment"
	}
	itemtypenames[6] = { --boots
		"Boots",
		"Slippers",
		"Sandals",
		"Steelboots",
		"Treads"
	}
	itemtypenames[7] = { --shoulders
		"Shoulders",
		"Spaulders",
		"Shoulderguards",
		"Shoulderplates",
		"Pauldrons"
	}
	itemtypenames[8] = { --Amulet
		"Amulet",
		"Necklace",
		"Necklet",
		"Jewelry",
		"Pendant"
	}
	itemtypenames[9] = { --gloves
		"Gauntlets",
		"Gloves",
		"Armwraps",
		"Warfists",
		"Handguards"
	}
	itemtypenames[10] = { --legs
		"Legs",
		"Leggings",
		"Skirt",
		"Legplates",
		"Legguards"
	}
	itemtypenames[11] = { --cape
		"Cloak",
		"Cape",
		"Mantle",
		"Greatcloak",
		"Drape"
	}
	local attributes = COverthrowGameMode:GetMythicWeaponAttributeCount(weapon)
	local itemtype = " " .. itemtypenames[slot][itemtype] .. " of "
	if attributes and attributes == 1 and itemtype then
		print(itemtypenames[slot][itemtype])
		--itemtype = " " .. itemtypenames[slot][itemtype] .. " " --its very weird but this causes an error, makes no sense
		--itemtype = " " .. itemtypenames[slot][itemtype] .. " of "
		local length = string.len(itemtype)
		itemtype = string.sub(itemtype, 1, length - 4) --removing the " of "
	end
	return itemtype
end

function COverthrowGameMode:GetGeneratedItemName(weapon)
	local first = weapon:sub(9,11)
	local second = weapon:sub(12,14)
	local third = weapon:sub(15,17)
	local slot = COverthrowGameMode:GetMythicWeaponSlot(weapon)
	local itemtype = GetGeneratedItemTypeName( weapon )
	local attributes = COverthrowGameMode:GetMythicWeaponAttributeCount(weapon)
	local itemquality = "[Divine]"
	if COverthrowGameMode:GetMythicWeaponQuality(weapon) == "aim" then
		itemquality = "[Ancient]"
	end
	if COverthrowGameMode:GetMythicWeaponQuality(weapon) == "myth" then
		itemquality = "[Mythical]"
	end
	if COverthrowGameMode:GetMythicWeaponQuality(weapon) == "epic" then
		itemquality = ""
	end
	if COverthrowGameMode:GetMythicWeaponQuality(weapon) == "leg" then
		itemquality = ""
	end
	if COverthrowGameMode:GetMythicWeaponQuality(weapon) == "im" then
		itemquality = ""
	end
	if attributes == 1 then
		return itemquality .. " " .. COverthrowGameMode:GetGeneratedItemDataBySuffix(first)[3] .. itemtype
	end
	if attributes == 2 then
		return itemquality .. " " .. COverthrowGameMode:GetGeneratedItemDataBySuffix(first)[3] .. itemtype .. COverthrowGameMode:GetGeneratedItemDataBySuffix(second)[5]
	end
	local itemname = itemquality .. " " .. COverthrowGameMode:GetGeneratedItemDataBySuffix(first)[3] .. itemtype .. COverthrowGameMode:GetGeneratedItemDataBySuffix(second)[4] .. " " .. COverthrowGameMode:GetGeneratedItemDataBySuffix(third)[5]
	return itemname
end

function COverthrowGameMode:GetGeneratedShoulderItemStatBySlot(weapon, attribute)
	local attributesuffix = weapon:sub(6 + attribute*3, 8 + attribute*3)
	if attributesuffix == "non" then --2 attribute generated items need this placeholder
		return "non"
	end
	return COverthrowGameMode:GetGeneratedItemDataBySuffix(attributesuffix)[2]
end

function COverthrowGameMode:GetGeneratedItemDataBySuffix(suffix)
	for i=1, #COverthrowGameMode.GeneratedItemData do
		if COverthrowGameMode.GeneratedItemData[i] and COverthrowGameMode.GeneratedItemData[i][1] == suffix then
			return COverthrowGameMode.GeneratedItemData[i]
		end
	end
	return nil
end

function COverthrowGameMode:GetGeneratedItemRandomStatTypes(slot, quality)
	local chance_for_reroll_on_elemental_stat = 100 --twice reroll ele bonus
	local stats = {}
	stats[1] = COverthrowGameMode:GetGeneratedItemRandomStatType("no", "no", slot, quality)
	if COverthrowGameMode:IsElementalStat(stats[1]) and math.random(1,100) <= chance_for_reroll_on_elemental_stat then
		stats[1] = COverthrowGameMode:GetGeneratedItemRandomStatType("no", "no", slot, quality)
		if COverthrowGameMode:IsElementalStat(stats[1]) and math.random(1,100) <= chance_for_reroll_on_elemental_stat then
			stats[1] = COverthrowGameMode:GetGeneratedItemRandomStatType("no", "no", slot, quality)
		end
	end
	stats[2] = COverthrowGameMode:GetGeneratedItemRandomStatType(stats[1], "no", slot, quality)
	if COverthrowGameMode:IsElementalStat(stats[2]) and math.random(1,100) <= chance_for_reroll_on_elemental_stat then
		stats[2] = COverthrowGameMode:GetGeneratedItemRandomStatType(stats[1], "no", slot, quality)
		if COverthrowGameMode:IsElementalStat(stats[2]) and math.random(1,100) <= chance_for_reroll_on_elemental_stat then
			stats[2] = COverthrowGameMode:GetGeneratedItemRandomStatType(stats[1], "no", slot, quality)
		end
	end
	if math.random(1,100) <= 40 then --only 1 stat
		stats[2] = "non"
		stats[3] = "non"
		return stats
	end
	if math.random(1,100) <= 80 then --only 2 stats for most items
		stats[3] = "non"
		return stats
	end
	stats[3] = COverthrowGameMode:GetGeneratedItemRandomStatType(stats[1], stats[2], slot, quality)
	if COverthrowGameMode:IsElementalStat(stats[3]) and math.random(1,100) <= chance_for_reroll_on_elemental_stat then
		stats[3] = COverthrowGameMode:GetGeneratedItemRandomStatType(stats[1], stats[2], slot, quality)
		if COverthrowGameMode:IsElementalStat(stats[3]) and math.random(1,100) <= chance_for_reroll_on_elemental_stat then
			stats[3] = COverthrowGameMode:GetGeneratedItemRandomStatType(stats[1], stats[2], slot, quality)
		end
	end
	return stats
end

function COverthrowGameMode:IsElementalStat(stat)
	if stat and (stat == "arc" or stat == "fir" or stat == "fro" or stat == "hol" or stat == "cha" or stat == "nat" or stat == "phy" or stat == "sha" or stat == "ard" or stat == "fid" or stat == "frd" or stat == "hod" or stat == "chd" or stat == "nad" or stat == "phd" or stat == "shd") then
		return true
	else
		return false
	end
end

function COverthrowGameMode:GetGeneratedItemRandomStatType(exclude_1, exclude_2, slot, quality)
	--print(COverthrowGameMode.GeneratedItemData[134][1])
	--print(COverthrowGameMode.GeneratedItemData[135][1])
	--print(COverthrowGameMode.GeneratedItemData[136][1])
	--print("GetGeneratedItemRandomStatType")
	local roll = math.random(1,COverthrowGameMode.GeneratedItemDataPathIndex - 1)
	--print("stat roll index " .. roll)
	--print(COverthrowGameMode.GeneratedItemData)
	--print(#COverthrowGameMode.GeneratedItemData)
	--print(COverthrowGameMode.GeneratedItemData[roll])
	local stat = COverthrowGameMode.GeneratedItemData[roll][1]
	if slot == 8 or slot == 3 then
		--amulets and rings have a chance to roll path bonuses
		if math.random(1,100) <= 15 then
			local index = math.random(COverthrowGameMode.GeneratedItemDataPathIndex,#COverthrowGameMode.GeneratedItemData)
			--print("path index " .. index .. " max is " .. #COverthrowGameMode.GeneratedItemData)
			stat = COverthrowGameMode.GeneratedItemData[index][1]
		end
	end
	--if stat ~= "y51" and stat ~= "y54" and stat ~= "y57" and stat ~= "y60" and stat ~= "y75" and stat ~= exclude_1 and stat ~= exclude_2 and IsStatAllowedForItemSlot(stat, slot) and ((not COverthrowGameMode:IsRunePowerStat( stat )) or ((not COverthrowGameMode:IsRunePowerStat( exclude_1 )) and (not COverthrowGameMode:IsRunePowerStat( exclude_2 )))) then
	if stat ~= exclude_1 and stat ~= exclude_2 and IsStatAllowedForItemSlot(stat, slot, quality) and ((not COverthrowGameMode:IsRunePowerStat( stat )) or ((not COverthrowGameMode:IsRunePowerStat( exclude_1 )) and (not COverthrowGameMode:IsRunePowerStat( exclude_2 )))) then
		return stat
	else
		return COverthrowGameMode:GetGeneratedItemRandomStatType(exclude_1, exclude_2, slot, quality)
	end
end

function COverthrowGameMode:IsRunePowerStat( stat )
	if not stat then
		return false
	end
	if stat == "zer" or stat == "nah" or stat == "tem" or stat == "tic" or stat == "kil" or stat == "fah" or stat == "loo" or stat == "wii" or stat == "tal" or stat == "roh" or stat == "sid" then
		--print("yes")
		return true
	else
		return false
	end
end

function COverthrowGameMode:GetMythicWeaponAttributeName(weapon, attribute)
	--new generated shoulder
	if IsGeneratedItem(weapon) then --old weapon:sub(1,8) == "aimo7gen"
		if attribute == 0 then
			return COverthrowGameMode:GetGeneratedItemName(weapon)
		end
		if attribute == 1 then
			return COverthrowGameMode:GetGeneratedShoulderItemStatBySlot(weapon, attribute)
		end
		if attribute == 2 then
			return COverthrowGameMode:GetGeneratedShoulderItemStatBySlot(weapon, attribute)
		end
		if attribute == 3 then
			return COverthrowGameMode:GetGeneratedShoulderItemStatBySlot(weapon, attribute)
		end
	end
	------------------------ EPIC
	-- AA Neutral
	if weapon == "epic1aaasaacrit" then
		if attribute == 0 then
			return "Golden Shortblade" -- item name
		end
		if attribute == 1 then
			return " Damage"
		end
		if attribute == 2 then
			return "% Attack Speed"
		end
		if attribute == 3 then
			return "% Attack Crit (300%)"
		end
	end
	if weapon == "epic1aastragi" then
		if attribute == 0 then
			return "Master's Sword" -- item name
		end
		if attribute == 1 then
			return " Damage"
		end
		if attribute == 2 then
			return " Strength"
		end
		if attribute == 3 then
			return " Agility"
		end
	end
	if weapon == "epic2aaas" then
		if attribute == 0 then
			return "Royal Dagger" -- item name
		end
		if attribute == 1 then
			return " Damage"
		end
		if attribute == 2 then
			return "% Attack Speed"
		end
		if attribute == 3 then
			return " Armor Reduction"
		end
	end
	--Strength
	if weapon == "epic1straacrit" then
		if attribute == 0 then
			return "Mithril Longsword" -- item name
		end
		if attribute == 1 then
			return " Strength"
		end
		if attribute == 2 then
			return " Damage"
		end
		if attribute == 3 then
			return "% Ability Crit (500%)"
		end
	end
	if weapon == "epic1straaas" then
		if attribute == 0 then
			return "Blacksteel Edge" -- item name
		end
		if attribute == 1 then
			return " Strength"
		end
		if attribute == 2 then
			return " Damage"
		end
		if attribute == 3 then
			return "% Attack Speed"
		end
	end
	if weapon == "epic2strabil" then
		if attribute == 0 then
			return "Mace of Spikes" -- item name
		end
		if attribute == 1 then
			return " Strength"
		end
		if attribute == 2 then
			return "% Damage"
		end
		if attribute == 3 then
			return ""
		end
	end
	--Agi
	if weapon == "epic1agiaacrit" then
		if attribute == 0 then
			return "Swiftwind Bow" -- item name
		end
		if attribute == 1 then
			return " Agility"
		end
		if attribute == 2 then
			return " Damage"
		end
		if attribute == 3 then
			return "% Ability Crit (500%)"
		end
	end
	if weapon == "epic1agiaaas" then
		if attribute == 0 then
			return "Moon Glaive" -- item name
		end
		if attribute == 1 then
			return " Agility"
		end
		if attribute == 2 then
			return " Damage"
		end
		if attribute == 3 then
			return "% Attack Speed"
		end
	end
	if weapon == "epic2agiabil" then
		if attribute == 0 then
			return "Flameforge Dagger" -- item name
		end
		if attribute == 1 then
			return " Agility"
		end
		if attribute == 2 then
			return "% Damage"
		end
		if attribute == 3 then
			return ""
		end
	end
	--Intellect
	if weapon == "epic1intspcrit" then
		if attribute == 0 then
			return "Thundercall Hammer" -- item name
		end
		if attribute == 1 then
			return " Intellect"
		end
		if attribute == 2 then
			return " Spellpower"
		end
		if attribute == 3 then
			return "% Ability Crit (500%)"
		end
	end
	if weapon == "epic1intspmana" then
		if attribute == 0 then
			return "Arcane Dagger" -- item name
		end
		if attribute == 1 then
			return " Intellect"
		end
		if attribute == 2 then
			return " Spellpower"
		end
		if attribute == 3 then
			return " Max Mana"
		end
	end
	if weapon == "epic2intabil" then
		if attribute == 0 then
			return "Chaos Rod" -- item name
		end
		if attribute == 1 then
			return " Intellect"
		end
		if attribute == 2 then
			return "% Damage"
		end
		if attribute == 3 then
			return ""
		end
	end
	-- Element Damage Types
	if weapon == "epic1firenaturearcane" then
		if attribute == 0 then
			return "Staff of Elements" -- item name
		end
		if attribute == 1 then
			return "% Fire Damage"
		end
		if attribute == 2 then
			return "% Nature Damage"
		end
		if attribute == 3 then
			return "% Arcane Damage"
		end
	end
	if weapon == "epic2spearcanefire" then
		if attribute == 0 then
			return "Arcanefire Flower" -- item name
		end
		if attribute == 1 then
			return " Spellpower"
		end
		if attribute == 2 then
			return "% Arcane Damage"
		end
		if attribute == 3 then
			return "% Fire Damage"
		end
	end
	if weapon == "epic2shadowfrostcrit" then
		if attribute == 0 then
			return "Darkfrost Spellblade" -- item name
		end
		if attribute == 1 then
			return "% Shadow Damage"
		end
		if attribute == 2 then
			return "% Frost Damage"
		end
		if attribute == 3 then
			return "% Ability Crit (500%)"
		end
	end
	if weapon == "epic2abilnature" then
		if attribute == 0 then
			return "Druid's Woodstick" -- item name
		end
		if attribute == 1 then
			return "% Damage"
		end
		if attribute == 2 then
			return "% Nature Damage"
		end
		if attribute == 3 then
			return "% Resistance Reduction"
		end
	end

	--Utility
	if weapon == "epic2abilms" then
		if attribute == 0 then
			return "Rider's Pike" -- item name
		end
		if attribute == 1 then
			return "% Healing"
		end
		if attribute == 2 then
			return "% Movement Speed"
		end
		if attribute == 3 then
			return " Max Health"
		end
	end
	if weapon == "epic2critcd" then
		if attribute == 0 then
			return "Divine Mace" -- item name
		end
		if attribute == 1 then
			return "% Ability Crit (500%)"
		end
		if attribute == 2 then
			return "% Cooldown Reduction"
		end
		if attribute == 3 then
			return ""
		end
	end
	if weapon == "epic2liferes" then
		if attribute == 0 then
			return "Fleshbite" -- item name
		end
		if attribute == 1 then
			return " Max Health"
		end
		if attribute == 2 then
			return " Spell Resistance"
		end
		if attribute == 3 then
			return ""
		end
	end
	if weapon == "epic2armoraggro" then
		if attribute == 0 then
			return "Steelwall" -- item name
		end
		if attribute == 1 then
			return " Armor"
		end
		if attribute == 2 then
			return "% Aggro Caused"
		end
		if attribute == 3 and COverthrowGameMode.version == 2 then
			return " Block"
		end
	end

	----------------------- LEGENDARY
	-- AA Neutral
	if weapon == "lege1aaasaacrit" then
		if attribute == 0 then
			return "Butcher's Carver" -- item name
		end
		if attribute == 1 then
			return " Damage"
		end
		if attribute == 2 then
			return "% Attack Speed"
		end
		if attribute == 3 then
			return "% Attack Crit (1000%)"
		end
	end
	if weapon == "lege1aastragi" then
		if attribute == 0 then
			return "Honor's Call" -- item name
		end
		if attribute == 1 then
			return " Damage"
		end
		if attribute == 2 then
			return " Strength"
		end
		if attribute == 3 then
			return " Agility"
		end
	end
	if weapon == "lege2aaas" then
		if attribute == 0 then
			return "Deathraze" -- item name
		end
		if attribute == 1 then
			return " Damage"
		end
		if attribute == 2 then
			return "% Attack Speed"
		end
		if attribute == 3 then
			return " Armor Reduction"
		end
	end
	--Strength
	if weapon == "lege1straacrit" then
		if attribute == 0 then
			return "Demolition" -- item name
		end
		if attribute == 1 then
			return " Strength"
		end
		if attribute == 2 then
			return " Damage"
		end
		if attribute == 3 then
			return "% Ability Crit (500%)"
		end
	end
	if weapon == "lege1straaas" then
		if attribute == 0 then
			return "Dragon's Bite" -- item name
		end
		if attribute == 1 then
			return " Strength"
		end
		if attribute == 2 then
			return " Damage"
		end
		if attribute == 3 then
			return "% Attack Speed"
		end
	end
	if weapon == "lege2strabil" then
		if attribute == 0 then
			return "The Impaler" -- item name
		end
		if attribute == 1 then
			return " Strength"
		end
		if attribute == 2 and COverthrowGameMode.version == 1 then
			return "% Damage"
		end
		if attribute == 2 and COverthrowGameMode.version == 2 then
			return "% Damage"
		end
		if attribute == 3 then
			return ""
		end
	end
	--Agi
	if weapon == "lege1agiaacrit" then
		if attribute == 0 then
			return "Arctic Longbow" -- item name
		end
		if attribute == 1 then
			return " Agility"
		end
		if attribute == 2 then
			return " Damage"
		end
		if attribute == 3 then
			return "% Ability Crit (500%)"
		end
	end
	if weapon == "lege1agiaaas" then
		if attribute == 0 then
			return "Widow Maker" -- item name
		end
		if attribute == 1 then
			return " Agility"
		end
		if attribute == 2 then
			return " Damage"
		end
		if attribute == 3 then
			return "% Attack Speed"
		end
	end
	if weapon == "lege2agiabil" then
		if attribute == 0 then
			return "Dragontongue Staff" -- item name
		end
		if attribute == 1 then
			return " Agility"
		end
		if attribute == 2 and COverthrowGameMode.version == 1 then
			return "% Damage"
		end
		if attribute == 2 and COverthrowGameMode.version == 2 then
			return "% Damage"
		end
		if attribute == 3 then
			return ""
		end
	end
	--Intellect
	if weapon == "lege1intspcrit" then
		if attribute == 0 then
			return "Blade of the Lich" -- item name
		end
		if attribute == 1 then
			return " Intellect"
		end
		if attribute == 2 then
			return " Spellpower"
		end
		if attribute == 3 then
			return "% Ability Crit (500%)"
		end
	end
	if weapon == "lege1intspmana" then
		if attribute == 0 then
			return "Overflow" -- item name
		end
		if attribute == 1 then
			return " Intellect"
		end
		if attribute == 2 then
			return " Spellpower"
		end
		if attribute == 3 then
			return " Max Mana"
		end
	end
	if weapon == "lege2intabil" then
		if attribute == 0 then
			return "Lonely Crow" -- item name
		end
		if attribute == 1 then
			return " Intellect"
		end
		if attribute == 2 and COverthrowGameMode.version == 1 then
			return "% Damage"
		end
		if attribute == 2 and COverthrowGameMode.version == 2 then
			return "% Damage"
		end
		if attribute == 3 then
			return ""
		end
	end
	-- Element Damage Types
	if weapon == "lege1firenaturearcane" then
		if attribute == 0 then
			return "Overspark" -- item name
		end
		if attribute == 1 then
			return "% Fire Damage"
		end
		if attribute == 2 then
			return "% Nature Damage"
		end
		if attribute == 3 then
			return "% Arcane Damage"
		end
	end
	if weapon == "lege2spearcanefire" then
		if attribute == 0 then
			return "Mace of Might" -- item name
		end
		if attribute == 1 then
			return " Spellpower"
		end
		if attribute == 2 then
			return "% Arcane Damage"
		end
		if attribute == 3 then
			return "% Fire Damage"
		end
	end
	if weapon == "lege2shadowfrostcrit" then
		if attribute == 0 then
			return "Night of Frost" -- item name
		end
		if attribute == 1 then
			return "% Frost Damage"
		end
		if attribute == 2 then
			return "% Shadow Damage"
		end
		if attribute == 3 then
			return "% Ability Crit (500%)"
		end
	end
	if weapon == "lege2abilnature" then
		if attribute == 0 then
			return "Defender of the Wild" -- item name
		end
		if attribute == 1 and COverthrowGameMode.version == 1 then
			return "% Damage"
		end
		if attribute == 1 and COverthrowGameMode.version == 2 then
			return "% Damage"
		end
		if attribute == 2 then
			return "% Nature Damage"
		end
		if attribute == 3 then
			return "% Resistance Reduction"
		end
	end

	--Utility
	if weapon == "lege2abilms" then
		if attribute == 0 then
			return "Sacred Spellshield" -- item name
		end
		if attribute == 1 then
			return "% Healing"
		end
		if attribute == 2 then
			return "% Movement Speed"
		end
		if attribute == 3 then
			return " Spell Resistance"
		end
	end
	if weapon == "lege2critcd" then
		if attribute == 0 then
			return "Chrono Blade" -- item name
		end
		if attribute == 1 then
			return "% Ability Crit (500%)"
		end
		if attribute == 2 then
			return "% Cooldown Reduction"
		end
		if attribute == 3 then
			return ""
		end
	end
	if weapon == "lege2liferes" then
		if attribute == 0 then
			return "Edge of Deflection" -- item name
		end
		if attribute == 1 then
			return " Max Health"
		end
		if attribute == 2 then
			return " Spell Resistance"
		end
		if attribute == 3 and COverthrowGameMode.version == 1 then
			return "% Aggro Lowered"
		end
		if attribute == 3 and COverthrowGameMode.version == 2 then
			return ""
		end
	end
	if weapon == "lege2armoraggro" then
		if attribute == 0 then
			return "Ebony Mastershield" -- item name
		end
		if attribute == 1 and COverthrowGameMode.version == 1 then
			return " Strength"
		end
		if attribute == 1 and COverthrowGameMode.version == 2 then
			return " Block"
		end
		if attribute == 2 then
			return " Armor"
		end
		if attribute == 3 then
			return "% Aggro Caused"
		end
	end
	if weapon == "immo2armorres" then
		if attribute == 0 then
			return "Starbouncer" -- item name
		end
		if attribute == 1 then
			return " Armor"
		end
		if attribute == 2 then
			return " Block"
		end
		if attribute == 3 then
			return " Spell Resistance"
		end
	end

	--------------------- IMMORTAL
	--rings
	if weapon == "immo3agipath" then
		if attribute == 0 then
			return "Emerald Eagle Ring" -- item name
		end
		if attribute == 1 then
			return " Agility"
		end
		if attribute == 2 then
			return " Path Point(s)"
		end
		if attribute == 3 then
			return ""
		end
	end
	if weapon == "immo3strpath" then
		if attribute == 0 then
			return "Ruby Eagle Ring" -- item name
		end
		if attribute == 1 then
			return " Strength"
		end
		if attribute == 2 then
			return " Path Point(s)"
		end
		if attribute == 3 then
			return ""
		end
	end
	if weapon == "immo3intpath" then
		if attribute == 0 then
			return "Sapphire Eagle Ring" -- item name
		end
		if attribute == 1 then
			return " Intellect"
		end
		if attribute == 2 then
			return " Path Point(s)"
		end
		if attribute == 3 then
			return ""
		end
	end
	if weapon == "immo3intmana" then
		if attribute == 0 then
			return "Obsidian Wizard Ring" -- item name
		end
		if attribute == 1 then
			return " Intellect"
		end
		if attribute == 2 then
			return " Max Mana"
		end
		if attribute == 3 then
			return ""
		end
	end
	if weapon == "immo3stragi" then
		if attribute == 0 then
			return "Imperial Topaz Ring" -- item name
		end
		if attribute == 1 then
			return " Strength"
		end
		if attribute == 2 then
			return " Agility"
		end
		if attribute == 3 then
			return ""
		end
	end
	if weapon == "immo3dmgabilp" then
		if attribute == 0 then
			return "Soulstone Ring" -- item name
		end
		if attribute == 1 then
			return " Damage"
		end
		if attribute == 2 then
			return " Ability Point(s)"
		end
		if attribute == 3 then
			return ""
		end
	end
	if weapon == "immo3spabilp" then
		if attribute == 0 then
			return "Soulshatter Ring" -- item name
		end
		if attribute == 1 then
			return " Spellpower"
		end
		if attribute == 2 then
			return " Ability Point(s)"
		end
		if attribute == 3 then
			return ""
		end
	end
	if weapon == "immo3physhafro" then
		if attribute == 0 then
			return "Winternight Ring" -- item name
		end
		if attribute == 1 then
			return "% Physical Damage"
		end
		if attribute == 2 then
			return "% Frost Damage"
		end
		if attribute == 3 then
			return "% Shadow Damage"
		end
	end
	if weapon == "immo3natarcfir" then
		if attribute == 0 then
			return "Sunbloom Ring" -- item name
		end
		if attribute == 1 then
			return "% Nature Damage"
		end
		if attribute == 2 then
			return "% Arcane Damage"
		end
		if attribute == 3 then
			return "% Fire Damage"
		end
	end
	if weapon == "immo3critcrit" then
		if attribute == 0 then
			return "Eye of Talos" -- item name
		end
		if attribute == 1 then
			return "% Ability Crit (500%)"
		end
		if attribute == 2 then
			return "% Ability Critical Damage"
		end
		if attribute == 3 then
			return ""
		end
	end
	-- AA Neutral
	if weapon == "immo1abilphys" and COverthrowGameMode.version == 1 then
		if attribute == 0 then
			return "Wild Claw" -- item name
		end
		if attribute == 1 then
			return "% Damage"
		end
		if attribute == 2 then
			return "% Damage"
		end
		if attribute == 3 then
			return ""
		end
	end
	if weapon == "immo1abilphys" and COverthrowGameMode.version == 2 then
		if attribute == 0 then
			return "Wild Claw" -- item name
		end
		if attribute == 1 then
			return "% Attack Speed"
		end
		if attribute == 2 then
			return "% Physical Damage"
		end
		if attribute == 3 then
			return ""
		end
	end
	if weapon == "immo1aaasaacrit" then
		if attribute == 0 then
			return "Claw of Terror" -- item name
		end
		if attribute == 1 then
			return " Damage"
		end
		if attribute == 2 then
			return "% Attack Speed"
		end
		if attribute == 3 then
			return "% Attack Crit (1000%)"
		end
	end
	if weapon == "immo1aastragi" then
		if attribute == 0 then
			return "Titanium Worldcleaver" -- item name
		end
		if attribute == 1 then
			return " Damage"
		end
		if attribute == 2 then
			return " Strength"
		end
		if attribute == 3 then
			return " Agility"
		end
	end
	if weapon == "immo2aaas" then
		if attribute == 0 then
			return "Corrupted Boneblade" -- item name
		end
		if attribute == 1 then
			return " Damage"
		end
		if attribute == 2 then
			return "% Attack Speed"
		end
		if attribute == 3 then
			return " Armor Reduction"
		end
	end
	if weapon == "immo2armorphys" then
		if attribute == 0 then
			return "Titanblade" -- item name
		end
		if attribute == 1 then
			return "% Physical Damage"
		end
		if attribute == 2 then
			return "% Ability Crit (500%)"
		end
		if attribute == 3 then
			return ""
		end
	end
	--Strength
	if weapon == "immo1straacrit" then
		if attribute == 0 then
			return "Valkyrie" -- item name
		end
		if attribute == 1 then
			return " Strength"
		end
		if attribute == 2 then
			return " Damage"
		end
		if attribute == 3 then
			return "% Ability Crit (500%)"
		end
	end
	if weapon == "immo1straaas" then
		if attribute == 0 then
			return "Scar" -- item name
		end
		if attribute == 1 then
			return " Strength"
		end
		if attribute == 2 then
			return " Damage"
		end
		if attribute == 3 then
			return "% Attack Speed"
		end
	end
	if weapon == "immo2strabil" then
		if attribute == 0 then
			return "Skullcrusher" -- item name
		end
		if attribute == 1 then
			return " Strength"
		end
		if attribute == 2 and COverthrowGameMode.version == 1 then
			return "% Damage"
		end
		if attribute == 2 and COverthrowGameMode.version == 2 then
			return "% Damage"
		end
		if attribute == 3 then
			return ""
		end
	end
	--Agi
	if weapon == "immo1agiaacrit" then
		if attribute == 0 then
			return "Dawnbreaker" -- item name
		end
		if attribute == 1 then
			return " Agility"
		end
		if attribute == 2 then
			return " Damage"
		end
		if attribute == 3 then
			return "% Ability Crit (500%)"
		end
	end
	if weapon == "immo1agiaaas" then
		if attribute == 0 then
			return "Big Game Gun" -- item name
		end
		if attribute == 1 then
			return " Agility"
		end
		if attribute == 2 then
			return " Damage"
		end
		if attribute == 3 then
			return "% Attack Speed"
		end
	end
	if weapon == "immo2agiabil" then
		if attribute == 0 then
			return "Devastation" -- item name
		end
		if attribute == 1 then
			return " Agility"
		end
		if attribute == 2 and COverthrowGameMode.version == 1 then
			return "% Damage"
		end
		if attribute == 2 and COverthrowGameMode.version == 2 then
			return "% Damage"
		end
		if attribute == 3 then
			return ""
		end
	end
	--Intellect
	if weapon == "immo1intspcrit" then
		if attribute == 0 then
			return "Tyranny of Magic" -- item name
		end
		if attribute == 1 then
			return " Intellect"
		end
		if attribute == 2 then
			return " Spellpower"
		end
		if attribute == 3 then
			return "% Ability Crit (500%)"
		end
	end
	if weapon == "immo1intspmana" then
		if attribute == 0 then
			return "Arcane Overload" -- item name
		end
		if attribute == 1 then
			return " Intellect"
		end
		if attribute == 2 then
			return " Spellpower"
		end
		if attribute == 3 then
			return " Max Mana"
		end
	end
	if weapon == "immo1healcd" then
		if attribute == 0 then
			return "Holy Staff" -- item name
		end
		if attribute == 1 then
			return " Intellect"
		end
		if attribute == 2 then
			return "% Healing"
		end
		if attribute == 3 then
			return "% Cooldown Reduction"
		end
	end
	if weapon == "immo2intabil" then
		if attribute == 0 then
			return "Twilight Barrier" -- item name
		end
		if attribute == 1 then
			return " Intellect"
		end
		if attribute == 2 then
			return "% Healing"
		end
		if attribute == 3 then
			return " Spell Resistance"
		end
	end
	-- Element Damage Types
	if weapon == "immo1firenaturearcane" then
		if attribute == 0 then
			return "Triumvirate" -- item name
		end
		if attribute == 1 then
			return "% Fire Damage"
		end
		if attribute == 2 then
			return "% Nature Damage"
		end
		if attribute == 3 then
			return "% Arcane Damage"
		end
	end
	if weapon == "immo2spearcanefire" then
		if attribute == 0 then
			return "Netherflame" -- item name
		end
		if attribute == 1 then
			return " Spellpower"
		end
		if attribute == 2 then
			return "% Arcane Damage"
		end
		if attribute == 3 then
			return "% Fire Damage"
		end
	end
	if weapon == "immo2shadowfrostcrit" then
		if attribute == 0 then
			return "Winter's Darkness" -- item name
		end
		if attribute == 1 then
			return "% Shadow Damage"
		end
		if attribute == 2 then
			return "% Frost Damage"
		end
		if attribute == 3 then
			return "% Ability Crit (500%)"
		end
	end
	if weapon == "immo2abilnature" then
		if attribute == 0 then
			return "Thundercrush" -- item name
		end
		if attribute == 1 and COverthrowGameMode.version == 1 then
			return "% Damage"
		end
		if attribute == 1 and COverthrowGameMode.version == 2 then
			return "% Damage"
		end
		if attribute == 2 then
			return "% Nature Damage"
		end
		if attribute == 3 then
			return "% Resistance Reduction"
		end
	end

	--Utility
	if weapon == "immo2abilms" then
		if attribute == 0 then
			return "Light Rider's Wand" -- item name
		end
		if attribute == 1 and COverthrowGameMode.version == 1 then
			return "% Damage"
		end
		if attribute == 1 and COverthrowGameMode.version == 2 then
			return "% Damage"
		end
		if attribute == 2 then
			return "% Movement Speed"
		end
		if attribute == 3 then
			return "% Energy Regeneration"
		end
	end
	if weapon == "immo2critcd" then
		if attribute == 0 then
			return "Timewarp" -- item name
		end
		if attribute == 1 then
			return "% Ability Crit (500%)"
		end
		if attribute == 2 then
			return "% Cooldown Reduction"
		end
		if attribute == 3 then
			return ""
		end
	end
	if weapon == "immo2liferes" then
		if attribute == 0 then
			return "Lazarus" -- item name
		end
		if attribute == 1 then
			return " Max Health"
		end
		if attribute == 2 then
			return " Spell Resistance"
		end
		if attribute == 3 and COverthrowGameMode.version == 1 then
			return "% Aggro Lowered"
		end
		if attribute == 3 and COverthrowGameMode.version == 2 then
			return ""
		end
	end
	if weapon == "immo2armoraggro" then
		if attribute == 0 then
			return "Giant Dragon Scale" -- item name
		end
		if attribute == 1 then
			return " Armor"
		end
		if attribute == 2 then
			return "% Aggro Caused"
		end
		if attribute == 3 and COverthrowGameMode.version == 2 then
			return " Block"
		end
	end
	--head
	if weapon == "immo4fahhp" then
		if attribute == 0 then
			return "Sacred Headplate" -- item name
		end
		if attribute == 1 then
			return " Max Health"
		end
		if attribute == 2 then
			return " Spell Resistance"
		end
		if attribute == 3 then
			return " Rune Power: FAH"
		end
	end
	if weapon == "immo4loohp" then
		if attribute == 0 then
			return "Icerealm Helmet" -- item name
		end
		if attribute == 1 then
			return " Max Health"
		end
		if attribute == 2 then
			return " Spell Resistance"
		end
		if attribute == 3 then
			return " Rune Power: LOO"
		end
	end
	if weapon == "immo4wiihp" then
		if attribute == 0 then
			return "Darkfall Helmet" -- item name
		end
		if attribute == 1 then
			return " Max Health"
		end
		if attribute == 2 then
			return " Spell Resistance"
		end
		if attribute == 3 then
			return " Rune Power: WII"
		end
	end
	if weapon == "immo4looprim" then
		if attribute == 0 then
			return "Battle Leader's Helmet" -- item name
		end
		if attribute == 1 then
			return " Primary Attribute"
		end
		if attribute == 2 then
			return " Armor"
		end
		if attribute == 3 then
			return " Rune Power: LOO"
		end
	end
	if weapon == "immo4wiiprim" then
		if attribute == 0 then
			return "Wood Warden's Guard" -- item name
		end
		if attribute == 1 then
			return " Primary Attribute"
		end
		if attribute == 2 then
			return " Armor"
		end
		if attribute == 3 then
			return " Rune Power: WII"
		end
	end
	if weapon == "immo4fahprimas" then
		if attribute == 0 then
			return "Deep Sea Skull" -- item name
		end
		if attribute == 1 then
			return " Primary Attribute"
		end
		if attribute == 2 then
			return "% Attack Speed"
		end
		if attribute == 3 then
			return " Rune Power: FAH"
		end
	end
	--ancient head
	if weapon == "aimo4fahhp" then
		if attribute == 0 then
			return "[Ancient] Crown of Kings" -- item name
		end
		if attribute == 1 then
			return " Max Health"
		end
		if attribute == 2 then
			return " Spell Resistance"
		end
		if attribute == 3 then
			return " Rune Power: FAH"
		end
	end
	if weapon == "aimo4loohp" then
		if attribute == 0 then
			return "[Ancient] Leoric's Faceguard" -- item name
		end
		if attribute == 1 then
			return " Max Health"
		end
		if attribute == 2 then
			return " Spell Resistance"
		end
		if attribute == 3 then
			return " Rune Power: LOO"
		end
	end
	if weapon == "aimo4wiihp" then
		if attribute == 0 then
			return "[Ancient] Nightfall Crown" -- item name
		end
		if attribute == 1 then
			return " Max Health"
		end
		if attribute == 2 then
			return " Spell Resistance"
		end
		if attribute == 3 then
			return " Rune Power: WII"
		end
	end
	if weapon == "aimo4looprim" then
		if attribute == 0 then
			return "[Ancient] Templar Mask" -- item name
		end
		if attribute == 1 then
			return " Primary Attribute"
		end
		if attribute == 2 then
			return " Armor"
		end
		if attribute == 3 then
			return " Rune Power: LOO"
		end
	end
	if weapon == "aimo4wiiprim" then
		if attribute == 0 then
			return "[Ancient] Helmet of War" -- item name
		end
		if attribute == 1 then
			return " Primary Attribute"
		end
		if attribute == 2 then
			return " Armor"
		end
		if attribute == 3 then
			return " Rune Power: WII"
		end
	end
	if weapon == "aimo4fahprimas" then
		if attribute == 0 then
			return "[Ancient] Monkey Crown" -- item name
		end
		if attribute == 1 then
			return " Primary Attribute"
		end
		if attribute == 2 then
			return "% Attack Speed"
		end
		if attribute == 3 then
			return " Rune Power: FAH"
		end
	end
	--chest
	if weapon == "immo5talhp" then
		if attribute == 0 then
			return "Nobleman's Chest"
		end
		if attribute == 1 then
			return " Max Health"
		end
		if attribute == 2 then
			return " Armor"
		end
		if attribute == 3 then
			return " Rune Power: TAL"
		end
	end
	if weapon == "immo5serhp" then
		if attribute == 0 then
			return "Twilight Order Chest"
		end
		if attribute == 1 then
			return " Max Health"
		end
		if attribute == 2 then
			return " Armor"
		end
		if attribute == 3 then
			return " Rune Power: ZER"
		end
	end
	if weapon == "immo5nahhp" then
		if attribute == 0 then
			return "Nethersky Chest"
		end
		if attribute == 1 then
			return " Max Health"
		end
		if attribute == 2 then
			return " Armor"
		end
		if attribute == 3 then
			return " Rune Power: NAH"
		end
	end
	if weapon == "immo5talprim" then
		if attribute == 0 then
			return "Guardian's Chest"
		end
		if attribute == 1 then
			return " Primary Attribute"
		end
		if attribute == 2 then
			return " Spell Resistance"
		end
		if attribute == 3 then
			return " Rune Power: TAL"
		end
	end
	if weapon == "immo5serprim" then
		if attribute == 0 then
			return "Magma Chest"
		end
		if attribute == 1 then
			return " Primary Attribute"
		end
		if attribute == 2 then
			return " Spell Resistance"
		end
		if attribute == 3 then
			return " Rune Power: ZER"
		end
	end
	if weapon == "immo5nahsp" then
		if attribute == 0 then
			return "Arcane Robe"
		end
		if attribute == 1 then
			return " Spellpower"
		end
		if attribute == 2 then
			return " Max Mana"
		end
		if attribute == 3 then
			return " Rune Power: ZER"
		end
	end
	--chest ancient
	if weapon == "aimo5talhp" then
		if attribute == 0 then
			return "[Ancient] Demonic Chestguard"
		end
		if attribute == 1 then
			return " Max Health"
		end
		if attribute == 2 then
			return " Armor"
		end
		if attribute == 3 then
			return " Rune Power: TAL"
		end
	end
	if weapon == "aimo5serhp" then
		if attribute == 0 then
			return "[Ancient] Ranger Chestguard"
		end
		if attribute == 1 then
			return " Max Health"
		end
		if attribute == 2 then
			return " Armor"
		end
		if attribute == 3 then
			return " Rune Power: ZER"
		end
	end
	if weapon == "aimo5nahhp" then
		if attribute == 0 then
			return "[Ancient] Steelplate Chestguard"
		end
		if attribute == 1 then
			return " Max Health"
		end
		if attribute == 2 then
			return " Armor"
		end
		if attribute == 3 then
			return " Rune Power: NAH"
		end
	end
	if weapon == "aimo5talprim" then
		if attribute == 0 then
			return "[Ancient] Ancient Voodoo Chest"
		end
		if attribute == 1 then
			return " Primary Attribute"
		end
		if attribute == 2 then
			return " Spell Resistance"
		end
		if attribute == 3 then
			return " Rune Power: TAL"
		end
	end
	if weapon == "aimo5serprim" then
		if attribute == 0 then
			return "[Ancient] Magma Harness"
		end
		if attribute == 1 then
			return " Primary Attribute"
		end
		if attribute == 2 then
			return " Spell Resistance"
		end
		if attribute == 3 then
			return " Rune Power: ZER"
		end
	end
	if weapon == "aimo5nahsp" then
		if attribute == 0 then
			return "[Ancient] Naga Chest Armor"
		end
		if attribute == 1 then
			return " Spellpower"
		end
		if attribute == 2 then
			return " Max Mana"
		end
		if attribute == 3 then
			return " Rune Power: ZER"
		end
	end
	--boots
	if weapon == "immo6minems" then
		if attribute == 0 then
			return "Holy Ghost Treads"
		end
		if attribute == 1 then
			return " Max Health"
		end
		if attribute == 2 then
			return "% Movement Speed"
		end
		if attribute == 3 then
			return " Rune Power: TEM"
		end
	end
	if weapon == "immo6ticms" then
		if attribute == 0 then
			return "Treads of Anger"
		end
		if attribute == 1 then
			return " Max Health"
		end
		if attribute == 2 then
			return "% Movement Speed"
		end
		if attribute == 3 then
			return " Rune Power: TIC"
		end
	end
	if weapon == "immo6kilms" then
		if attribute == 0 then
			return "Treads of Darkness"
		end
		if attribute == 1 then
			return " Max Health"
		end
		if attribute == 2 then
			return "% Movement Speed"
		end
		if attribute == 3 then
			return " Rune Power: KIL"
		end
	end
	if weapon == "immo6mineprim" then
		if attribute == 0 then
			return "Striders of Might"
		end
		if attribute == 1 then
			return " Primary Attribute"
		end
		if attribute == 2 then
			return "% Movement Speed"
		end
		if attribute == 3 then
			return " Rune Power: TEM"
		end
	end
	if weapon == "immo6ticprim" then
		if attribute == 0 then
			return "Forest Boots"
		end
		if attribute == 1 then
			return " Primary Attribute"
		end
		if attribute == 2 then
			return "% Movement Speed"
		end
		if attribute == 3 then
			return " Rune Power: TIC"
		end
	end
	if weapon == "immo6kilcrit" then
		if attribute == 0 then
			return "Demonclaw Treads"
		end
		if attribute == 1 then
			return "% Ability Crit (500%)"
		end
		if attribute == 2 then
			return "% Movement Speed"
		end
		if attribute == 3 then
			return " Rune Power: KIL"
		end
	end
	--ancient boots
	if weapon == "aimo6minems" then
		if attribute == 0 then
			return "[Ancient] Winter Boots"
		end
		if attribute == 1 then
			return " Max Health"
		end
		if attribute == 2 then
			return "% Movement Speed"
		end
		if attribute == 3 then
			return " Rune Power: TEM"
		end
	end
	if weapon == "aimo6ticms" then
		if attribute == 0 then
			return "[Ancient] Runic Steel Boots"
		end
		if attribute == 1 then
			return " Max Health"
		end
		if attribute == 2 then
			return "% Movement Speed"
		end
		if attribute == 3 then
			return " Rune Power: TIC"
		end
	end
	if weapon == "aimo6kilms" then
		if attribute == 0 then
			return "[Ancient] Nightstalker Steelboots"
		end
		if attribute == 1 then
			return " Max Health"
		end
		if attribute == 2 then
			return "% Movement Speed"
		end
		if attribute == 3 then
			return " Rune Power: KIL"
		end
	end
	if weapon == "aimo6mineprim" then
		if attribute == 0 then
			return "[Ancient] Shadow Striders"
		end
		if attribute == 1 then
			return " Primary Attribute"
		end
		if attribute == 2 then
			return "% Movement Speed"
		end
		if attribute == 3 then
			return " Rune Power: TEM"
		end
	end
	if weapon == "aimo6ticprim" then
		if attribute == 0 then
			return "[Ancient] Arcanite Iron Boots"
		end
		if attribute == 1 then
			return " Primary Attribute"
		end
		if attribute == 2 then
			return "% Movement Speed"
		end
		if attribute == 3 then
			return " Rune Power: TIC"
		end
	end
	if weapon == "aimo6kilcrit" then
		if attribute == 0 then
			return "[Ancient] Valyrian Warboots"
		end
		if attribute == 1 then
			return "% Ability Crit (500%)"
		end
		if attribute == 2 then
			return "% Movement Speed"
		end
		if attribute == 3 then
			return " Rune Power: KIL"
		end
	end
	--------------------------------------------------------------------------------------------------------------------------
	--weapons and ring ancients
	-- AA Neutral

	--rings
	if weapon == "aimo3class_drow_ranger" then
		if attribute == 0 then
			return "[Ancient] Seal of Snow" -- item name
		end
		if attribute == 1 then
			return " Path: The Stars Aligned"
		end
		if attribute == 2 then
			return " Path: Careful Aim"
		end
		if attribute == 3 then
			return " Path: Blizzard"
		end
	end
	if weapon == "aimo3class_windrunner" then
		if attribute == 0 then
			return "[Ancient] Seal of the Jungle" -- item name
		end
		if attribute == 1 then
			return " Path: Steadiness"
		end
		if attribute == 2 then
			return " Path: Tigerbites"
		end
		if attribute == 3 then
			return " Path: Spiritwolf Protection"
		end
	end
	if weapon == "aimo3class_sniper" then
		if attribute == 0 then
			return "[Ancient] Seal of the Beast" -- item name
		end
		if attribute == 1 then
			return " Path: Bestial Wrath"
		end
		if attribute == 2 then
			return " Path: Murder of Crows"
		end
		if attribute == 3 then
			return " Path: Storm Claws"
		end
	end
	if weapon == "aimo3class_phantom_assassin" then
		if attribute == 0 then
			return "[Ancient] Seal of Cruelty" -- item name
		end
		if attribute == 1 then
			return " Path: Backstab"
		end
		if attribute == 2 then
			return " Path: Impale"
		end
		if attribute == 3 then
			return " Path: Full Moon"
		end
	end
	if weapon == "aimo3class_riki" then
		if attribute == 0 then
			return "[Ancient] Seal of Dire Shadows" -- item name
		end
		if attribute == 1 then
			return " Path: Shadow Form"
		end
		if attribute == 2 then
			return " Path: Tiger's Swiftness"
		end
		if attribute == 3 then
			return " Path: Overwhelm"
		end
	end
	if weapon == "aimo3class_bounty_hunter" then
		if attribute == 0 then
			return "[Ancient] Seal of Fatality" -- item name
		end
		if attribute == 1 then
			return " Path: Steadiness"
		end
		if attribute == 2 then
			return " Path: Flesh Wounds"
		end
		if attribute == 3 then
			return " Path: Armored War Tiger"
		end
	end
	if weapon == "aimo3class_slark" then
		if attribute == 0 then
			return "[Ancient] Seal of the Shadowstalker" -- item name
		end
		if attribute == 1 then
			return " Path: Storm Claws"
		end
		if attribute == 2 then
			return " Path: Crowfall"
		end
		if attribute == 3 then
			return " Path: Storm Harpy"
		end
	end
	if weapon == "aimo3class_axe" then
		if attribute == 0 then
			return "[Ancient] Seal of Brutality" -- item name
		end
		if attribute == 1 then
			return " Path: Steadiness" --x2
		end
		if attribute == 2 then
			return " Path: Swipe of Ursa"
		end
		if attribute == 3 then
			return " Path: Hellborn"
		end
	end
	if weapon == "aimo3class_dragon_knight" then
		if attribute == 0 then
			return "[Ancient] Seal of Plated Iron" -- item name
		end
		if attribute == 1 then
			return " Path: Iron Skin"
		end
		if attribute == 2 then
			return " Path: Momentum of Mass"
		end
		if attribute == 3 then
			return " Path: Swipe of Ursa"
		end
	end
	if weapon == "aimo3class_beastmaster" then
		if attribute == 0 then
			return "[Ancient] Seal of Fury" -- item name
		end
		if attribute == 1 then
			return " Path: Flow of Combat"
		end
		if attribute == 2 then
			return " Path: Crowfall"
		end
		if attribute == 3 then
			return " Path: Windfury"
		end
	end
	if weapon == "aimo3class_ursa" then
		if attribute == 0 then
			return "[Ancient] Seal of Fury" -- item name
		end
		if attribute == 1 then
			return " Path: Bear of War"
		end
		if attribute == 2 then
			return " Path: Steel Mammoth"
		end
		if attribute == 3 then
			return " Path: Phantom Assassin"
		end
	end
	if weapon == "aimo3class_dazzle" then
		if attribute == 0 then
			return "[Ancient] Seal of Wilderness" -- item name
		end
		if attribute == 1 then
			return " Path: Wolf's Versatility"
		end
		if attribute == 2 then
			return " Path: Blood Wolf"
		end
		if attribute == 3 then
			return " Path: Alpha Blood"
		end
	end
	if weapon == "aimo3class_vengefulspirit" then
		if attribute == 0 then
			return "[Ancient] Seal of the Astral Realm" -- item name
		end
		if attribute == 1 then
			return " Path: Dark Wizardry"
		end
		if attribute == 2 then
			return " Path: Focussed Mind"
		end
		if attribute == 3 then
			return " Path: Moonlight Fairies"
		end
	end
	if weapon == "aimo3class_furion" then
		if attribute == 0 then
			return "[Ancient] Seal of Peace" -- item name
		end
		if attribute == 1 then
			return " Path: Moonlight Fairies" --x2
		end
		if attribute == 2 then
			return " Path: Spiritwolf Protection"
		end
		if attribute == 3 then
			return " Path: Steadiness" --x3
		end
	end
	if weapon == "aimo3class_legion_commander" then
		if attribute == 0 then
			return "[Ancient] Seal of Fanaticism" -- item name
		end
		if attribute == 1 then
			return " Path: Iron Fury"
		end
		if attribute == 2 then
			return " Path: Tigerbites" --x2
		end
		if attribute == 3 then
			return " Path: A Light in the Dark"
		end
	end
	if weapon == "aimo3class_phantom_lancer" then
		if attribute == 0 then
			return "[Ancient] Seal of the Sanctuary" -- item name
		end
		if attribute == 1 then
			return " Path: Wound Mending"
		end
		if attribute == 2 then
			return " Path: Tenacity"
		end
		if attribute == 3 then
			return " Path: Lick Wounds"
		end
	end
	if weapon == "aimo3class_omniknight" then
		if attribute == 0 then
			return "[Ancient] Seal of Divinity" -- item name
		end
		if attribute == 1 then
			return " Path: Timebender"
		end
		if attribute == 2 then
			return " Path: Presence of Power"
		end
		if attribute == 3 then
			return " Path: Wings of Dominance"
		end
	end
	if weapon == "aimo3class_shadow_shaman" then
		if attribute == 0 then
			return "[Ancient] Seal of Elements" -- item name
		end
		if attribute == 1 then
			return " Path: Moonlight Fairies" --x3
		end
		if attribute == 2 then
			return " Path: Lizard Wizard"
		end
		if attribute == 3 then
			return " Path: Hellborn" --x2
		end
	end
	if weapon == "aimo3class_witch_doctor" then
		if attribute == 0 then
			return "[Ancient] Seal of Spirits" -- item name
		end
		if attribute == 1 then
			return " Path: Spiritwolf Protection"
		end
		if attribute == 2 then
			return " Path: Presence of Power"
		end
		if attribute == 3 then
			return " Path: Knowledge is Power"
		end
	end
	if weapon == "aimo3class_bloodseeker" then
		if attribute == 0 then
			return "[Ancient] Seal of Savagery" -- item name
		end
		if attribute == 1 then
			return " Path: Rain of Stars"
		end
		if attribute == 2 then
			return " Path: Demon Fury"
		end
		if attribute == 3 then
			return " Path: Moonglaive Shield"
		end
	end
	if weapon == "aimo3class_skeleton_king" then
		if attribute == 0 then
			return "[Ancient] Seal of the Colossus" -- item name
		end
		if attribute == 1 then
			return " Path: Shadow Colossus"
		end
		if attribute == 2 then
			return " Path: Bear of War"
		end
		if attribute == 3 then
			return " Path: Grizzly's Power"
		end
	end
	if weapon == "aimo3class_sven" then
		if attribute == 0 then
			return "[Ancient] Seal of Arctic Winds" -- item name
		end
		if attribute == 1 then
			return " Path: Blizzard" --x2
		end
		if attribute == 2 then
			return " Path: Iron Muscles" --x2
		end
		if attribute == 3 then
			return " Path: Windfury" --x2
		end
	end
	if weapon == "aimo3class_pudge" then
		if attribute == 0 then
			return "[Ancient] Seal of Unholy Power" -- item name
		end
		if attribute == 1 then
			return " Path: Cruel Taskmaster" --x2
		end
		if attribute == 2 then
			return " Path: Shadow Claws"
		end
		if attribute == 3 then
			return " Path: Lifeblood"
		end
	end
	if weapon == "aimo3class_invoker" then
		if attribute == 0 then
			return "[Ancient] Seal of the Nethersky" -- item name
		end
		if attribute == 1 then
			return " Path: Timebender" --x2
		end
		if attribute == 2 then
			return " Path: Ice Storm"
		end
		if attribute == 3 then
			return " Path: Netherdragon Scales"
		end
	end
	if weapon == "aimo3class_lina" then
		if attribute == 0 then
			return "[Ancient] Seal of Flames" -- item name
		end
		if attribute == 1 then
			return " Path: Dragon's Breath" --x2
		end
		if attribute == 2 then
			return " Path: Master Magician"
		end
		if attribute == 3 then
			return " Path: Mana Shield"
		end
	end
	if weapon == "aimo3class_crystal_maiden" then
		if attribute == 0 then
			return "[Ancient] Seal of Winter" -- item name
		end
		if attribute == 1 then
			return " Path: Dragon's Knowledge" --x2
		end
		if attribute == 2 then
			return " Path: Blizzard"
		end
		if attribute == 3 then
			return " Path: Iron Skin"
		end
	end
	if weapon == "aimo3class_pugna" then
		if attribute == 0 then
			return "[Ancient] Seal of Chaos" -- item name
		end
		if attribute == 1 then
			return " Path: Apocalypse" --x2
		end
		if attribute == 2 then
			return " Path: Deathwing"
		end
		if attribute == 3 then
			return " Path: Focussed Mind"
		end
	end
	if weapon == "aimo3class_warlock" then
		if attribute == 0 then
			return "[Ancient] Seal of Decay" -- item name
		end
		if attribute == 1 then
			return " Path: Steadiness" --x2
		end
		if attribute == 2 then
			return " Path: Dark Offering"
		end
		if attribute == 3 then
			return " Path: Lifeblood"
		end
	end
	if weapon == "aimo3class_antimage" then
		if attribute == 0 then
			return "[Ancient] Seal of Inferal Slaying" -- item name
		end
		if attribute == 1 then
			return " Path: Tiger's Swiftness" --x2
		end
		if attribute == 2 then
			return " Path: Shadow Claws"
		end
		if attribute == 3 then
			return " Path: Shadow Form"
		end
	end
	if weapon == "aimo3class_juggernaut" then
		if attribute == 0 then
			return "[Ancient] Seal of Death" -- item name
		end
		if attribute == 1 then
			return " Path: Lifeblood" --x2
		end
		if attribute == 2 then
			return " Path: Dragon's Breath"
		end
		if attribute == 3 then
			return " Path: Iron Fury"
		end
	end
	if weapon == "aimo3class_dark_seer" then
		if attribute == 0 then
			return "[Ancient] Seal of Shadows" -- item name
		end
		if attribute == 1 then
			return " Path: Shadow Form" --x2
		end
		if attribute == 2 then
			return " Path: A Light in the Dark"
		end
		if attribute == 3 then
			return " Path: Steadiness"
		end
	end
	if weapon == "aimo3class_silencer" then
		if attribute == 0 then
			return "[Ancient] Seal of the Twilight Order" -- item name
		end
		if attribute == 1 then
			return " Path: Master Magician" --x2
		end
		if attribute == 2 then
			return " Path: Timebender"
		end
		if attribute == 3 then
			return " Path: Netherdragon Scales"
		end
	end
	if weapon == "aimo3class_oracle" then
		if attribute == 0 then
			return "[Ancient] Seal of Holiness" -- item name
		end
		if attribute == 1 then
			return " Path: Dragon's Knowledge" --x2
		end
		if attribute == 2 then
			return " Path: Wound Mending"
		end
		if attribute == 3 then
			return " Path: Mana Shield"
		end
	end
	if weapon == "aimo3class_keeper_of_the_light" then
		if attribute == 0 then
			return "[Ancient] Seal of the Cleric" -- item name
		end
		if attribute == 1 then
			return " Path: Dragon's Knowledge" --x2
		end
		if attribute == 2 then
			return " Path: Knowledge is Power"
		end
		if attribute == 3 then
			return " Path: Warden of Souls"
		end
	end
	if weapon == "aimo3class_ogre_magi" then
		if attribute == 0 then
			return "[Ancient] Seal of the Wizard" -- item name
		end
		if attribute == 1 then
			return " Path: Ice Storm" --x2
		end
		if attribute == 2 then
			return " Path: Wolf Rage"
		end
		if attribute == 3 then
			return " Path: Hellborn"
		end
	end
	if weapon == "aimo3class_bristleback" then
		if attribute == 0 then
			return "[Ancient] Seal of the Brawler" -- item name
		end
		if attribute == 1 then
			return " Path: Grizzly's Power" --x2
		end
		if attribute == 2 then
			return " Path: Iron Muscles"
		end
		if attribute == 3 then
			return " Path: Swipe of Ursa"
		end
	end
	if weapon == "aimo3class_clinkz" then
		if attribute == 0 then
			return "[Ancient] Seal of the Ranger" -- item name
		end
		if attribute == 1 then
			return " Path: Tigerbites" --x2
		end
		if attribute == 2 then
			return " Path: Careful Aim"
		end
		if attribute == 3 then
			return " Path: Windfury"
		end
	end
	if weapon == "aimo3class_chen" then
		if attribute == 0 then
			return "[Ancient] Seal of the Crusader" -- item name
		end
		if attribute == 1 then
			return " Path: Momentum of Mass"
		end
		if attribute == 2 then
			return " Path: Flow of Combat"
		end
		if attribute == 3 then
			return " Path: Wolf's Versatility"
		end
	end
	if weapon == "aimo3class_enchantress" then
		if attribute == 0 then
			return "[Ancient] Seal of the Guardian" -- item name
		end
		if attribute == 1 then
			return " Path: Presence of Power" --x2
		end
		if attribute == 2 then
			return " Path: Moonlight Fairies"
		end
		if attribute == 3 then
			return " Path: Timebender"
		end
	end
	if weapon == "aimo3class_elder_titan" then
		if attribute == 0 then
			return "[Ancient] Seal of the Voodoo" -- item name
		end
		if attribute == 1 then
			return " Path: Lizard Wizard" --x2
		end
		if attribute == 2 then
			return " Path: Master Magician"
		end
		if attribute == 3 then
			return " Path: Murder of Crows"
		end
	end
	if weapon == "aimo3class_abaddon" then
		if attribute == 0 then
			return "[Ancient] Seal of the Deathbringer" -- item name
		end
		if attribute == 1 then
			return " Path: Warden of Souls" --x2
		end
		if attribute == 2 then
			return " Path: Flow of Combat"
		end
		if attribute == 3 then
			return " Path: Hellborn"
		end
	end
	--lege class rings
	if weapon == "lege3class_drow_ranger" then
		if attribute == 0 then
			return "[Ancient] Seal of Snow" -- item name
		end
		if attribute == 1 then
			return " Path: The Stars Aligned"
		end
		if attribute == 2 then
			return " Path: Careful Aim"
		end
		if attribute == 3 then
			return " Path: Blizzard"
		end
	end
	if weapon == "lege3class_windrunner" then
		if attribute == 0 then
			return "[Ancient] Seal of the Jungle" -- item name
		end
		if attribute == 1 then
			return " Path: Steadiness"
		end
		if attribute == 2 then
			return " Path: Tigerbites"
		end
		if attribute == 3 then
			return " Path: Spiritwolf Protection"
		end
	end
	if weapon == "lege3class_sniper" then
		if attribute == 0 then
			return "[Ancient] Seal of the Beast" -- item name
		end
		if attribute == 1 then
			return " Path: Bestial Wrath"
		end
		if attribute == 2 then
			return " Path: Murder of Crows"
		end
		if attribute == 3 then
			return " Path: Storm Claws"
		end
	end
	if weapon == "lege3class_phantom_assassin" then
		if attribute == 0 then
			return "[Ancient] Seal of Cruelty" -- item name
		end
		if attribute == 1 then
			return " Path: Backstab"
		end
		if attribute == 2 then
			return " Path: Impale"
		end
		if attribute == 3 then
			return " Path: Full Moon"
		end
	end
	if weapon == "lege3class_riki" then
		if attribute == 0 then
			return "[Ancient] Seal of Dire Shadows" -- item name
		end
		if attribute == 1 then
			return " Path: Shadow Form"
		end
		if attribute == 2 then
			return " Path: Tiger's Swiftness"
		end
		if attribute == 3 then
			return " Path: Overwhelm"
		end
	end
	if weapon == "lege3class_bounty_hunter" then
		if attribute == 0 then
			return "[Ancient] Seal of Fatality" -- item name
		end
		if attribute == 1 then
			return " Path: Steadiness"
		end
		if attribute == 2 then
			return " Path: Flesh Wounds"
		end
		if attribute == 3 then
			return " Path: Armored War Tiger"
		end
	end
	if weapon == "aimo3class_terrorblade" then
		if attribute == 0 then
			return "[Ancient] Seal of Terror" -- item name
		end
		if attribute == 1 then
			return " Path: Shadow Reflexes"
		end
		if attribute == 2 then
			return " Path: Hellborn"
		end
		if attribute == 3 then
			return " Path: Shadow Colossus"
		end
	end
	if weapon == "lege3class_terrorblade" then
		if attribute == 0 then
			return "[Ancient] Seal of Terror" -- item name
		end
		if attribute == 1 then
			return " Path: Shadow Reflexes"
		end
		if attribute == 2 then
			return " Path: Hellborn"
		end
		if attribute == 3 then
			return " Path: Shadow Colossus"
		end
	end
	if weapon == "lege3class_templar_assassin" then
		if attribute == 0 then
			return "[Ancient] Seal of Destruction" -- item name
		end
		if attribute == 1 then
			return " Path: Apocalypse"
		end
		if attribute == 2 then
			return " Path: Tiger's Fury"
		end
		if attribute == 3 then
			return " Path: Fury of the Eagle"
		end
	end
	if weapon == "aimo3class_templar_assassin" then
		if attribute == 0 then
			return "[Ancient] Seal of Destruction" -- item name
		end
		if attribute == 1 then
			return " Path: Apocalypse"
		end
		if attribute == 2 then
			return " Path: Tiger's Fury"
		end
		if attribute == 3 then
			return " Path: Fury of the Eagle"
		end
	end
	if weapon == "lege3class_slark" then
		if attribute == 0 then
			return "[Ancient] Seal of the Shadowstalker" -- item name
		end
		if attribute == 1 then
			return " Path: Storm Claws"
		end
		if attribute == 2 then
			return " Path: Crowfall"
		end
		if attribute == 3 then
			return " Path: Storm Harpy"
		end
	end
	if weapon == "lege3class_axe" then
		if attribute == 0 then
			return "[Ancient] Seal of Brutality" -- item name
		end
		if attribute == 1 then
			return " Path: Steadiness" --x2
		end
		if attribute == 2 then
			return " Path: Swipe of Ursa"
		end
		if attribute == 3 then
			return " Path: Hellborn"
		end
	end
	if weapon == "lege3class_dragon_knight" then
		if attribute == 0 then
			return "[Ancient] Seal of Plated Iron" -- item name
		end
		if attribute == 1 then
			return " Path: Iron Skin"
		end
		if attribute == 2 then
			return " Path: Momentum of Mass"
		end
		if attribute == 3 then
			return " Path: Swipe of Ursa"
		end
	end
	if weapon == "lege3class_beastmaster" then
		if attribute == 0 then
			return "[Ancient] Seal of Fury" -- item name
		end
		if attribute == 1 then
			return " Path: Flow of Combat"
		end
		if attribute == 2 then
			return " Path: Crowfall"
		end
		if attribute == 3 then
			return " Path: Windfury"
		end
	end
	if weapon == "lege3class_ursa" then
		if attribute == 0 then
			return "[Ancient] Seal of Fury" -- item name
		end
		if attribute == 1 then
			return " Path: Bear of War"
		end
		if attribute == 2 then
			return " Path: Steel Mammoth"
		end
		if attribute == 3 then
			return " Path: Phantom Assassin"
		end
	end
	if weapon == "lege3class_dazzle" then
		if attribute == 0 then
			return "[Ancient] Seal of Wilderness" -- item name
		end
		if attribute == 1 then
			return " Path: Wolf's Versatility"
		end
		if attribute == 2 then
			return " Path: Blood Wolf"
		end
		if attribute == 3 then
			return " Path: Alpha Blood"
		end
	end
	if weapon == "lege3class_vengefulspirit" then
		if attribute == 0 then
			return "[Ancient] Seal of the Astral Realm" -- item name
		end
		if attribute == 1 then
			return " Path: Dark Wizardry"
		end
		if attribute == 2 then
			return " Path: Focussed Mind"
		end
		if attribute == 3 then
			return " Path: Moonlight Fairies"
		end
	end
	if weapon == "lege3class_furion" then
		if attribute == 0 then
			return "[Ancient] Seal of Peace" -- item name
		end
		if attribute == 1 then
			return " Path: Moonlight Fairies" --x2
		end
		if attribute == 2 then
			return " Path: Spiritwolf Protection"
		end
		if attribute == 3 then
			return " Path: Steadiness" --x3
		end
	end
	if weapon == "lege3class_legion_commander" then
		if attribute == 0 then
			return "[Ancient] Seal of Fanaticism" -- item name
		end
		if attribute == 1 then
			return " Path: Iron Fury"
		end
		if attribute == 2 then
			return " Path: Tigerbites" --x2
		end
		if attribute == 3 then
			return " Path: A Light in the Dark"
		end
	end
	if weapon == "lege3class_phantom_lancer" then
		if attribute == 0 then
			return "[Ancient] Seal of the Sanctuary" -- item name
		end
		if attribute == 1 then
			return " Path: Wound Mending"
		end
		if attribute == 2 then
			return " Path: Tenacity"
		end
		if attribute == 3 then
			return " Path: Lick Wounds"
		end
	end
	if weapon == "lege3class_omniknight" then
		if attribute == 0 then
			return "[Ancient] Seal of Divinity" -- item name
		end
		if attribute == 1 then
			return " Path: Timebender"
		end
		if attribute == 2 then
			return " Path: Presence of Power"
		end
		if attribute == 3 then
			return " Path: Wings of Dominance"
		end
	end
	if weapon == "lege3class_shadow_shaman" then
		if attribute == 0 then
			return "[Ancient] Seal of Elements" -- item name
		end
		if attribute == 1 then
			return " Path: Moonlight Fairies" --x3
		end
		if attribute == 2 then
			return " Path: Lizard Wizard"
		end
		if attribute == 3 then
			return " Path: Hellborn" --x2
		end
	end
	if weapon == "lege3class_witch_doctor" then
		if attribute == 0 then
			return "[Ancient] Seal of Spirits" -- item name
		end
		if attribute == 1 then
			return " Path: Spiritwolf Protection"
		end
		if attribute == 2 then
			return " Path: Presence of Power"
		end
		if attribute == 3 then
			return " Path: Knowledge is Power"
		end
	end
	if weapon == "lege3class_bloodseeker" then
		if attribute == 0 then
			return "[Ancient] Seal of Savagery" -- item name
		end
		if attribute == 1 then
			return " Path: Rain of Stars"
		end
		if attribute == 2 then
			return " Path: Demon Fury"
		end
		if attribute == 3 then
			return " Path: Moonglaive Shield"
		end
	end
	if weapon == "lege3class_skeleton_king" then
		if attribute == 0 then
			return "[Ancient] Seal of the Colossus" -- item name
		end
		if attribute == 1 then
			return " Path: Shadow Colossus"
		end
		if attribute == 2 then
			return " Path: Bear of War"
		end
		if attribute == 3 then
			return " Path: Grizzly's Power"
		end
	end
	if weapon == "lege3class_sven" then
		if attribute == 0 then
			return "[Ancient] Seal of Arctic Winds" -- item name
		end
		if attribute == 1 then
			return " Path: Blizzard" --x2
		end
		if attribute == 2 then
			return " Path: Iron Muscles" --x2
		end
		if attribute == 3 then
			return " Path: Windfury" --x2
		end
	end
	if weapon == "lege3class_pudge" then
		if attribute == 0 then
			return "[Ancient] Seal of Unholy Power" -- item name
		end
		if attribute == 1 then
			return " Path: Cruel Taskmaster" --x2
		end
		if attribute == 2 then
			return " Path: Shadow Claws"
		end
		if attribute == 3 then
			return " Path: Lifeblood"
		end
	end
	if weapon == "lege3class_invoker" then
		if attribute == 0 then
			return "[Ancient] Seal of the Nethersky" -- item name
		end
		if attribute == 1 then
			return " Path: Timebender" --x2
		end
		if attribute == 2 then
			return " Path: Ice Storm"
		end
		if attribute == 3 then
			return " Path: Netherdragon Scales"
		end
	end
	if weapon == "lege3class_grimstroke" then
		if attribute == 0 then
			return "[Ancient] Seal of Demonology" -- item name
		end
		if attribute == 1 then
			return " Path: Murder of Crows" --x2
		end
		if attribute == 2 then
			return " Path: Shadow Runes"
		end
		if attribute == 3 then
			return " Path: Deathwing"
		end
	end
	if weapon == "aimo3class_grimstroke" then
		if attribute == 0 then
			return "[Ancient] Seal of Demonology" -- item name
		end
		if attribute == 1 then
			return " Path: Murder of Crows" --x2
		end
		if attribute == 2 then
			return " Path: Shadow Runes"
		end
		if attribute == 3 then
			return " Path: Deathwing"
		end
	end
	if weapon == "lege3class_lina" then
		if attribute == 0 then
			return "[Ancient] Seal of Flames" -- item name
		end
		if attribute == 1 then
			return " Path: Dragon's Breath" --x2
		end
		if attribute == 2 then
			return " Path: Master Magician"
		end
		if attribute == 3 then
			return " Path: Mana Shield"
		end
	end
	if weapon == "lege3class_crystal_maiden" then
		if attribute == 0 then
			return "[Ancient] Seal of Winter" -- item name
		end
		if attribute == 1 then
			return " Path: Dragon's Knowledge" --x2
		end
		if attribute == 2 then
			return " Path: Blizzard"
		end
		if attribute == 3 then
			return " Path: Iron Skin"
		end
	end
	if weapon == "lege3class_pugna" then
		if attribute == 0 then
			return "[Ancient] Seal of Chaos" -- item name
		end
		if attribute == 1 then
			return " Path: Apocalypse" --x2
		end
		if attribute == 2 then
			return " Path: Deathwing"
		end
		if attribute == 3 then
			return " Path: Focussed Mind"
		end
	end
	if weapon == "lege3class_warlock" then
		if attribute == 0 then
			return "[Ancient] Seal of Decay" -- item name
		end
		if attribute == 1 then
			return " Path: Steadiness" --x2
		end
		if attribute == 2 then
			return " Path: Dark Offering"
		end
		if attribute == 3 then
			return " Path: Lifeblood"
		end
	end
	if weapon == "lege3class_antimage" then
		if attribute == 0 then
			return "[Ancient] Seal of Inferal Slaying" -- item name
		end
		if attribute == 1 then
			return " Path: Tiger's Swiftness" --x2
		end
		if attribute == 2 then
			return " Path: Shadow Claws"
		end
		if attribute == 3 then
			return " Path: Shadow Form"
		end
	end
	if weapon == "lege3class_juggernaut" then
		if attribute == 0 then
			return "[Ancient] Seal of Death" -- item name
		end
		if attribute == 1 then
			return " Path: Lifeblood" --x2
		end
		if attribute == 2 then
			return " Path: Dragon's Breath"
		end
		if attribute == 3 then
			return " Path: Iron Fury"
		end
	end
	if weapon == "lege3class_dark_seer" then
		if attribute == 0 then
			return "[Ancient] Seal of Shadows" -- item name
		end
		if attribute == 1 then
			return " Path: Shadow Form" --x2
		end
		if attribute == 2 then
			return " Path: A Light in the Dark"
		end
		if attribute == 3 then
			return " Path: Steadiness"
		end
	end
	if weapon == "lege3class_silencer" then
		if attribute == 0 then
			return "[Ancient] Seal of the Twilight Order" -- item name
		end
		if attribute == 1 then
			return " Path: Master Magician" --x2
		end
		if attribute == 2 then
			return " Path: Timebender"
		end
		if attribute == 3 then
			return " Path: Netherdragon Scales"
		end
	end
	if weapon == "lege3class_oracle" then
		if attribute == 0 then
			return "[Ancient] Seal of Holiness" -- item name
		end
		if attribute == 1 then
			return " Path: Dragon's Knowledge" --x2
		end
		if attribute == 2 then
			return " Path: Wound Mending"
		end
		if attribute == 3 then
			return " Path: Mana Shield"
		end
	end
	if weapon == "lege3class_keeper_of_the_light" then
		if attribute == 0 then
			return "[Ancient] Seal of the Cleric" -- item name
		end
		if attribute == 1 then
			return " Path: Dragon's Knowledge" --x2
		end
		if attribute == 2 then
			return " Path: Knowledge is Power"
		end
		if attribute == 3 then
			return " Path: Warden of Souls"
		end
	end
	if weapon == "lege3class_ogre_magi" then
		if attribute == 0 then
			return "[Ancient] Seal of the Cleric" -- item name
		end
		if attribute == 1 then
			return " Path: Ice Storm" --x2
		end
		if attribute == 2 then
			return " Path: Wolf Rage"
		end
		if attribute == 3 then
			return " Path: Hellborn"
		end
	end
	if weapon == "lege3class_lion" then
		if attribute == 0 then
			return "[Ancient] Seal of the Witcher" -- item name
		end
		if attribute == 1 then
			return " Path: Dark Wizardry" --x2
		end
		if attribute == 2 then
			return " Path: Steadiness"
		end
		if attribute == 3 then
			return " Path: Cruel Taskmaster"
		end
	end
	if weapon == "aimo3class_lion" then
		if attribute == 0 then
			return "[Ancient] Seal of the Witcher" -- item name
		end
		if attribute == 1 then
			return " Path: Dark Wizardry" --x2
		end
		if attribute == 2 then
			return " Path: Steadiness"
		end
		if attribute == 3 then
			return " Path: Cruel Taskmaster"
		end
	end
	if weapon == "lege3class_bristleback" then
		if attribute == 0 then
			return "[Ancient] Seal of the Brawler" -- item name
		end
		if attribute == 1 then
			return " Path: Grizzly's Power" --x2
		end
		if attribute == 2 then
			return " Path: Iron Muscles"
		end
		if attribute == 3 then
			return " Path: Swipe of Ursa"
		end
	end
	if weapon == "lege3class_clinkz" then
		if attribute == 0 then
			return "[Ancient] Seal of the Ranger" -- item name
		end
		if attribute == 1 then
			return " Path: Tigerbites" --x2
		end
		if attribute == 2 then
			return " Path: Careful Aim"
		end
		if attribute == 3 then
			return " Path: Windfury"
		end
	end
	if weapon == "lege3class_chen" then
		if attribute == 0 then
			return "[Ancient] Seal of the Crusader" -- item name
		end
		if attribute == 1 then
			return " Path: Momentum of Mass"
		end
		if attribute == 2 then
			return " Path: Flow of Combat"
		end
		if attribute == 3 then
			return " Path: Wolf's Versatility"
		end
	end
	if weapon == "lege3class_enchantress" then
		if attribute == 0 then
			return "[Ancient] Seal of the Guardian" -- item name
		end
		if attribute == 1 then
			return " Path: Presence of Power" --x2
		end
		if attribute == 2 then
			return " Path: Moonlight Fairies"
		end
		if attribute == 3 then
			return " Path: Timebender"
		end
	end
	if weapon == "lege3class_elder_titan" then
		if attribute == 0 then
			return "[Ancient] Seal of the Voodoo" -- item name
		end
		if attribute == 1 then
			return " Path: Lizard Wizard" --x2
		end
		if attribute == 2 then
			return " Path: Master Magician"
		end
		if attribute == 3 then
			return " Path: Murder of Crows"
		end
	end
	if weapon == "lege3class_abaddon" then
		if attribute == 0 then
			return "[Ancient] Seal of the Deathbringer" -- item name
		end
		if attribute == 1 then
			return " Path: Warden of Souls" --x2
		end
		if attribute == 2 then
			return " Path: Flow of Combat"
		end
		if attribute == 3 then
			return " Path: Netherdragon Scales"
		end
	end

	if weapon == "aimo3agipath" then
		if attribute == 0 then
			return "[Ancient] Swift Hawk Ring" -- item name
		end
		if attribute == 1 then
			return " Agility"
		end
		if attribute == 2 then
			return " Path Point(s)"
		end
		if attribute == 3 then
			return " Armor"
		end
	end
	if weapon == "aimo3strpath" then
		if attribute == 0 then
			return "[Ancient] Fierce Hawk Ring" -- item name
		end
		if attribute == 1 then
			return " Strength"
		end
		if attribute == 2 then
			return " Path Point(s)"
		end
		if attribute == 3 then
			return " Armor"
		end
	end
	if weapon == "aimo3intpath" then
		if attribute == 0 then
			return "[Ancient] Spellflow Hawk Ring" -- item name
		end
		if attribute == 1 then
			return " Intellect"
		end
		if attribute == 2 then
			return " Path Point(s)"
		end
		if attribute == 3 then
			return " Armor"
		end
	end
	if weapon == "aimo3intmana" then
		if attribute == 0 then
			return "[Ancient] Nightglow Ring" -- item name
		end
		if attribute == 1 then
			return " Intellect"
		end
		if attribute == 2 then
			return " Max Mana"
		end
		if attribute == 3 then
			return " Armor"
		end
	end
	if weapon == "aimo3stragi" then
		if attribute == 0 then
			return "[Ancient] Bloodflow Ring" -- item name
		end
		if attribute == 1 then
			return " Strength"
		end
		if attribute == 2 then
			return " Agility"
		end
		if attribute == 3 then
			return " Armor"
		end
	end
	if weapon == "aimo3dmgabilp" then
		if attribute == 0 then
			return "[Ancient] Soulmight Ring" -- item name
		end
		if attribute == 1 then
			return " Damage"
		end
		if attribute == 2 then
			return " Ability Point(s)"
		end
		if attribute == 3 then
			return " Max Health"
		end
	end
	if weapon == "aimo3spabilp" then
		if attribute == 0 then
			return "[Ancient] Soulcast Ring" -- item name
		end
		if attribute == 1 then
			return " Spellpower"
		end
		if attribute == 2 then
			return " Ability Point(s)"
		end
		if attribute == 3 then
			return " Max Health"
		end
	end
	if weapon == "aimo3physhafro" then
		if attribute == 0 then
			return "[Ancient] Steelfrost Ring" -- item name
		end
		if attribute == 1 then
			return "% Physical Damage"
		end
		if attribute == 2 then
			return "% Frost Damage"
		end
		if attribute == 3 then
			return "% Shadow Damage"
		end
	end
	if weapon == "aimo3natarcfir" then
		if attribute == 0 then
			return "[Ancient] Elemental Mastery Ring" -- item name
		end
		if attribute == 1 then
			return "% Nature Damage"
		end
		if attribute == 2 then
			return "% Arcane Damage"
		end
		if attribute == 3 then
			return "% Fire Damage"
		end
	end
	if weapon == "aimo3critcrit" then
		if attribute == 0 then
			return "[Ancient] Eye of Doom" -- item name
		end
		if attribute == 1 then
			return "% Ability Crit (500%)"
		end
		if attribute == 2 then
			return "% Ability Critical Damage"
		end
		if attribute == 3 then
			return ""
		end
	end
	
	-- AA Neutral
	if weapon == "aimo1aaasaacrit" then
		if attribute == 0 then
			return "[Ancient] Infested Claw" -- item name
		end
		if attribute == 1 then
			return " Damage"
		end
		if attribute == 2 then
			return "% Attack Speed"
		end
		if attribute == 3 then
			return "% Attack Crit (1000%)"
		end
	end
	if weapon == "aimo1aastragi" then
		if attribute == 0 then
			return "[Ancient] Titancleave" -- item name
		end
		if attribute == 1 then
			return " Damage"
		end
		if attribute == 2 then
			return " Strength"
		end
		if attribute == 3 then
			return " Agility"
		end
	end
	if weapon == "aimo2aaas" then
		if attribute == 0 then
			return "[Ancient] Corruptor" -- item name
		end
		if attribute == 1 then
			return " Damage"
		end
		if attribute == 2 then
			return "% Physical Damage"
		end
		if attribute == 3 then
			return " Armor Reduction"
		end
	end
	--Strength
	if weapon == "aimo1straacrit" then
		if attribute == 0 then
			return "[Ancient] Godstrike" -- item name
		end
		if attribute == 1 then
			return " Strength"
		end
		if attribute == 2 then
			return " Damage"
		end
		if attribute == 3 then
			return "% Ability Crit (500%)"
		end
	end
	if weapon == "aimo1straaas" then
		if attribute == 0 then
			return "[Ancient] Silveredge" -- item name
		end
		if attribute == 1 then
			return " Strength"
		end
		if attribute == 2 then
			return " Damage"
		end
		if attribute == 3 then
			return "% Physical Damage"
		end
	end
	if weapon == "aimo2strabil" then
		if attribute == 0 then
			return "[Ancient] Bullstrike" -- item name
		end
		if attribute == 1 then
			return " Strength"
		end
		if attribute == 2 and COverthrowGameMode.version == 1 then
			return "% Damage"
		end
		if attribute == 2 and COverthrowGameMode.version == 2 then
			return "% Damage"
		end
		if attribute == 3 then
			return ""
		end
	end
	--Agi
	if weapon == "aimo1agiaacrit" then
		if attribute == 0 then
			return "[Ancient] Bloodbath" -- item name
		end
		if attribute == 1 then
			return " Agility"
		end
		if attribute == 2 then
			return " Damage"
		end
		if attribute == 3 then
			return "% Ability Crit (500%)"
		end
	end
	if weapon == "aimo1agiaaas" then
		if attribute == 0 then
			return "[Ancient] Powershot" -- item name
		end
		if attribute == 1 then
			return " Agility"
		end
		if attribute == 2 then
			return " Damage"
		end
		if attribute == 3 then
			return "% Physical Damage"
		end
	end
	if weapon == "aimo2agiabil" then
		if attribute == 0 then
			return "[Ancient] Executioner" -- item name
		end
		if attribute == 1 then
			return " Agility"
		end
		if attribute == 2 and COverthrowGameMode.version == 1 then
			return "% Damage"
		end
		if attribute == 2 and COverthrowGameMode.version == 2 then
			return "% Damage"
		end
		if attribute == 3 then
			return ""
		end
	end
	--Intellect
	if weapon == "aimo1intspcrit" then
		if attribute == 0 then
			return "[Ancient] Spellcleaver" -- item name
		end
		if attribute == 1 then
			return " Intellect"
		end
		if attribute == 2 then
			return " Spellpower"
		end
		if attribute == 3 then
			return "% Ability Crit (500%)"
		end
	end
	if weapon == "aimo1healcd" then
		if attribute == 0 then
			return "Angel Staff" -- item name
		end
		if attribute == 1 then
			return " Intellect"
		end
		if attribute == 2 then
			return "% Healing"
		end
		if attribute == 3 then
			return "% Cooldown Reduction"
		end
	end
	if weapon == "aimo1intspmana" then
		if attribute == 0 then
			return "[Ancient] Netherstorm" -- item name
		end
		if attribute == 1 then
			return " Intellect"
		end
		if attribute == 2 then
			return " Spellpower"
		end
		if attribute == 3 then
			return " Max Mana"
		end
	end
	if weapon == "aimo2intabil" then
		if attribute == 0 then
			return "[Ancient] Lifeguard" -- item name
		end
		if attribute == 1 then
			return " Intellect"
		end
		if attribute == 2 then
			return "% Healing"
		end
		if attribute == 3 then
			return " Spell Resistance"
		end
	end
	-- Element Damage Types
	if weapon == "aimo1firenaturearcane" then
		if attribute == 0 then
			return "[Ancient] Evoker" -- item name
		end
		if attribute == 1 then
			return "% Fire Damage"
		end
		if attribute == 2 then
			return "% Nature Damage"
		end
		if attribute == 3 then
			return "% Arcane Damage"
		end
	end
	if weapon == "aimo2spearcanefire" then
		if attribute == 0 then
			return "[Ancient] Twister" -- item name
		end
		if attribute == 1 then
			return " Spellpower"
		end
		if attribute == 2 then
			return "% Arcane Damage"
		end
		if attribute == 3 then
			return "% Fire Damage"
		end
	end
	if weapon == "aimo2shadowfrostcrit" then
		if attribute == 0 then
			return "[Ancient] Sunfreezer" -- item name
		end
		if attribute == 1 then
			return "% Shadow Damage"
		end
		if attribute == 2 then
			return "% Frost Damage"
		end
		if attribute == 3 then
			return "% Ability Crit (500%)"
		end
	end
	if weapon == "aimo2abilnature" then
		if attribute == 0 then
			return "[Ancient] Thunderbolt" -- item name
		end
		if attribute == 1 and COverthrowGameMode.version == 1 then
			return "% Damage"
		end
		if attribute == 1 and COverthrowGameMode.version == 2 then
			return "% Damage"
		end
		if attribute == 2 then
			return "% Nature Damage"
		end
		if attribute == 3 then
			return "% Resistance Reduction"
		end
	end

	--Utility
	if weapon == "aimo2abilms" then
		if attribute == 0 then
			return "[Ancient] Dreamsteed" -- item name
		end
		if attribute == 1 and COverthrowGameMode.version == 1 then
			return "% Damage"
		end
		if attribute == 1 and COverthrowGameMode.version == 2 then
			return "% Damage"
		end
		if attribute == 2 then
			return "% Movement Speed"
		end
		if attribute == 3 then
			return "% Energy Regeneration"
		end
	end
	if weapon == "aimo2critcd" then
		if attribute == 0 then
			return "[Ancient] Timebreaker" -- item name
		end
		if attribute == 1 then
			return "% Ability Crit (500%)"
		end
		if attribute == 2 then
			return "% Cooldown Reduction"
		end
		if attribute == 3 then
			return " Primary Attribute"
		end
	end
	if weapon == "aimo2liferes" then
		if attribute == 0 then
			return "[Ancient] Soul Lance" -- item name
		end
		if attribute == 1 then
			return " Max Health"
		end
		if attribute == 2 then
			return " Spell Resistance"
		end
		if attribute == 3 and COverthrowGameMode.version == 1 then
			return "% Aggro Lowered"
		end
		if attribute == 3 and COverthrowGameMode.version == 2 then
			return ""
		end
	end
	if weapon == "aimo2armoraggro" then
		if attribute == 0 then
			return "[Ancient] Shadowscale" -- item name
		end
		if attribute == 1 then
			return " Max Health"
		end
		if attribute == 2 then
			return " Armor"
		end
		if attribute == 3 then
			return "% Aggro Caused"
		end
	end
	if weapon == "aimo2armorres" then
		if attribute == 0 then
			return "[Ancient] Evil Stopper" -- item name
		end
		if attribute == 1 then
			return " Armor"
		end
		if attribute == 2 then
			return " Block"
		end
		if attribute == 3 then
			return " Spell Resistance"
		end
	end

	return ""
end

function COverthrowGameMode:GetMythicWeaponSlot(weapon)
	local ret = tonumber(weapon:sub(5,5)) -- 1 for mainhand, 2 for offhand
	if not ret then --higher numbers are coded differently: T for 10 and E for 11
		if weapon:sub(5,5) == "T" then
			return 10
		end
		if weapon:sub(5,5) == "E" then
			return 11
		end
	end
	return ret
end

function COverthrowGameMode:GetMythicWeaponLevel(hero, slot)
	local power = 0
	if hero and hero.inventory and hero.inventory[slot] and self:IsWeapon(hero.inventory[slot][1]) and hero.inventory[slot][4] then
		local weapon = hero.inventory[slot][1]
		local attributes = hero.inventory[slot][4]
		
		for i=1, attributes do
			local attribute_name = self:GetMythicWeaponAttributeName(weapon, i)
			if attribute_name then
				local value = self:MythicWeaponAttributeValue(attribute_name)
				local amount = hero.inventory[slot][4+i]
				if value > 0 then
					power = power + (amount / value)
				end
			end
		end
	end
	return math.floor(power+0.5)
end

function COverthrowGameMode:IsWeapon(weapon)
	if weapon and string.len(weapon) > 2 then
		return true
	end
	return false
end

function COverthrowGameMode:GetMythicWeaponQuality(weapon)
	if weapon:sub(1,1) == "e" and weapon:sub(2,2) == "p" then
		return "epic"
	end
	if weapon:sub(1,1) == "i" and weapon:sub(2,2) == "m" then
		return "im"
	end
	if weapon:sub(1,1) == "a" and weapon:sub(2,2) == "i" then
		return "aim"
	end
	if weapon:sub(1,1) == "d" and weapon:sub(2,2) == "i" then
		return "divi"
	end
	if weapon:sub(1,1) == "l" and weapon:sub(2,2) == "e" then
		return "leg"
	end
	if weapon:sub(1,1) == "m" and weapon:sub(2,2) == "y" then
		return "myth"
	end
	return "epic"
end

function COverthrowGameMode:GetMythicWeaponQualityNumber(weapon)
	if weapon:sub(1,1) == "e" then
		return 4
	end
	if weapon:sub(1,1) == "i" then
		return 6
	end
	if weapon:sub(1,1) == "a" then
		return 7
	end
	if weapon:sub(1,1) == "d" then
		return 8
	end
	if weapon:sub(1,1) == "l" and weapon:sub(2,2) == "e" then
		return 5
	end
	if weapon:sub(1,1) == "m" then
		return 9
	end
	return 1
end

function COverthrowGameMode:GetMythicWeaponAttributeCount(weapon)
	if string.len(COverthrowGameMode:GetMythicWeaponAttributeName(weapon, 3)) > 4 then
		return 3
	elseif string.len(COverthrowGameMode:GetMythicWeaponAttributeName(weapon, 2)) > 4 then
		return 2
	else
		return 1
	end
end

function COverthrowGameMode:GenerateMythicWeaponStats( totalstats, attributes )
	if attributes == 1 then
		local ret = {}
		ret[1] = totalstats
		ret[2] = 0
		ret[3] = 0
		return ret
	end
	if attributes == 2 then
		local ret = {}
		local v1 = math.random(11,100)
		local v2 = math.random(11,100)
		local total = v1+v2
		v1 = v1 / total
		v2 = v2 / total
		v1 = v1 * totalstats + 0.5
		v2 = v2 * totalstats + 0.5
		ret[1] = v1
		ret[2] = v2
		ret[3] = 0
		return ret
	end
	if attributes == 3 then
		local ret = {}
		local v1 = math.random(4,100) --22
		local v2 = math.random(4,100)
		local v3 = math.random(4,100)
		local total = v1+v2+v3
		v1 = v1 / total
		v2 = v2 / total
		v3 = v3 / total
		v1 = v1 * totalstats
		v2 = v2 * totalstats + 0.5
		v3 = v3 * totalstats + 0.5
		ret[1] = v1
		ret[2] = v2
		ret[3] = v3
		return ret
	end
	local ret = {}
	ret[1] = 0
	ret[2] = 0
	ret[3] = 0
	return ret
end

function COverthrowGameMode:GetMythicWeaponMaxLevel(quality, number_attributes, weaponslot)
	local value = 0
	if quality == "epic" then
		value = 7
	end
	if quality == "leg" then
		value = 15
	end
	if quality == "im" then
		value = 30
	end
	if quality == "aim" then
		value = 45 --60 --45
	end
	if quality == "divi" then
		value = 75 --60 --100 --60
	end
	if quality == "myth" then
		value = 90 --75 --200 --80
	end
	--if number_attributes == 1 then
	--	value = math.floor(value * 0.7)
	--end
	--if number_attributes == 2 then
	--	value = math.floor(value * 0.85)
	--end
	return value
end
function COverthrowGameMode:GetMythicWeaponMinLevel(quality, number_attributes, weaponslot)
	local value = 0
	if quality == "epic" then
		value = 5
	end
	if quality == "leg" then
		value = 10
	end
	if quality == "im" then
		value = 20
	end
	if quality == "aim" then
		value = 35 --50
	end
	if quality == "divi" then
		value = 50 --90
	end
	if quality == "myth" then
		value = 80 --65 -- 180
	end
	--if number_attributes == 1 then
	--	value = value * 0.7
	--end
	--if number_attributes == 2 then
	--	value = value * 0.85
	--end
	return value
end

function COverthrowGameMode:IncreaseMythicWeaponStats( hero, weaponslot)
	if hero.inventory and hero.inventory[weaponslot] then
		local weapon = hero.inventory[weaponslot][1]
		if self:IsWeapon(weapon) then
			local number_attributes = COverthrowGameMode:GetMythicWeaponAttributeCount(weapon)
			local quality = COverthrowGameMode:GetMythicWeaponQuality(weapon)
			for i=1, number_attributes do
				--print("stat increase")
				if hero.inventory[weaponslot][4+i] then
					--print(hero.inventory[weaponslot][4+i])
					local old_value = hero.inventory[weaponslot][4+i]
					hero.inventory[weaponslot][4+i] = math.floor(hero.inventory[weaponslot][4+i] * 1.2 + 0.5)
					if old_value == hero.inventory[weaponslot][4+i] then
						hero.inventory[weaponslot][4+i] = hero.inventory[weaponslot][4+i] + 1
					end
					--print(hero.inventory[weaponslot][4+i])
				end
			end
			--new stat level
			local totalstats = self:GetMythicWeaponLevel(hero, weaponslot)
			hero.inventory[weaponslot][11] = "Item Level: "..totalstats.." / "..self:GetMythicWeaponMaxLevel(quality,number_attributes,weaponslot)
			hero.inventory[weaponslot][12] = totalstats --item level
			hero.inventory[weaponslot][13] = self:GetMythicWeaponMaxLevel(quality,number_attributes,weaponslot) --max item level
			return true
		end
	end
	return false
end

function IsGeneratedItem( weapon )
	if weapon:sub(6,8) == "gen" then -- or (tonumber(weapon:sub(6,6)) and weapon:sub(7,9) == "gen") then
		return true
	end
	return false
end

function COverthrowGameMode:CreateMythicWeapon( hero, weapon, fromserver, a1, a2, a3, dropped_from_boss )
	--local average_stats = 25 --epic trifecta
	--print("create my thic weapon")
	local is_generated_shoulder = false
	local weaponslot = COverthrowGameMode:GetMythicWeaponSlot(weapon) -- 1 = mainhand, 2 = offhand
	local qualityNumber = COverthrowGameMode:GetMythicWeaponQualityNumber(weapon)
	if not fromserver and weapon and IsGeneratedItem(weapon) then --is it a generated item?
		is_generated_shoulder = true
		local generated_stat_types = COverthrowGameMode:GetGeneratedItemRandomStatTypes(weaponslot, qualityNumber)
		local new_item_name = weapon:sub(1,8) .. generated_stat_types[1] .. generated_stat_types[2] .. generated_stat_types[3] -- "aimo7gen" before
		weapon = new_item_name
		--print("generated item: " .. weapon)
	end
	local totalstats = math.random(5,15)
	local number_attributes = COverthrowGameMode:GetMythicWeaponAttributeCount(weapon)
	local quality = COverthrowGameMode:GetMythicWeaponQuality(weapon)
	if not fromserver then
		totalstats = math.floor(math.random(self:GetMythicWeaponMinLevel(quality,number_attributes,weaponslot), self:GetMythicWeaponMaxLevel(quality,number_attributes,weaponslot)))
		--if dropped_from_boss and quality == "im" and self.jungledifficulty >= 100.0 and (weaponslot == 1 or weaponslot == 2) then
			--print("double value artifact chance")
			--if math.random(1,100) <= 0 then
			--	totalstats = totalstats * 2
				--print("double value artifact")
			--end
		--end
	end

	--dont override if previous item not sold or equipped and new of same or worse quality
	--[[
	if (not fromserver) and hero.weapondrop and self:IsWeapon(hero.weapondrop[1]) and self:GetMythicWeaponQualityNumber(hero.weapondrop[1]) >= self:GetMythicWeaponQualityNumber(weapon) then
		--print("dont override " .. hero.weapondrop[1] .. " cuz of " .. weapon)
		return
	end
	]]

	local weapondrop = {}
	weapondrop[0] = self:GetMythicWeaponAttributeName(weapon, 0)
	weapondrop[1] = weapon
	weapondrop[2] = weaponslot
	weapondrop[3] = quality
	weapondrop[4] = number_attributes
	weapondrop[8] = self:GetMythicWeaponAttributeName(weapon, 1)
	weapondrop[9] = self:GetMythicWeaponAttributeName(weapon, 2)
	weapondrop[10] = self:GetMythicWeaponAttributeName(weapon, 3)
	if not fromserver then
		local stats = self:GenerateMythicWeaponStats( totalstats, number_attributes )
		local minimum_roll = 0.0
		--if string.sub(weapondrop[8], 1, 6) == " Path:" then
		--	minimum_roll = 0
		--end
		weapondrop[5] = math.floor(stats[1] * self:MythicWeaponAttributeValue( weapondrop[8] ) + minimum_roll)
		weapondrop[6] = math.floor(stats[2] * self:MythicWeaponAttributeValue( weapondrop[9] ) + minimum_roll)
		weapondrop[7] = math.floor(stats[3] * self:MythicWeaponAttributeValue( weapondrop[10] ) + minimum_roll)
		if weapondrop[5] < 1.0 then -- and not (string.sub(weapondrop[8], 1, 6) == " Path:") then
			weapondrop[5] = 1
		end
		if weapondrop[6] < 1.0 then -- and not (string.sub(weapondrop[9], 1, 6) == " Path:") then
			weapondrop[6] = 1
		end
		if weapondrop[7] < 1.0 then -- and not (string.sub(weapondrop[10], 1, 6) == " Path:") then
			weapondrop[7] = 1
		end
		--safety for atleast 1 path + 1
		if weapondrop[5] < 1.0 and weapondrop[6] < 1.0 and weapondrop[7] < 1.0 and string.sub(weapondrop[8], 1, 6) == " Path:" and string.sub(weapondrop[9], 1, 6) == " Path:" and string.sub(weapondrop[10], 1, 6) == " Path:" then
			if math.random(1,100) <= 34 then
				weapondrop[5] = 1
			else
				if math.random(1,100) <= 50 then
					weapondrop[6] = 1
				else
					weapondrop[7] = 1
				end
			end
		end
	else
		weapondrop[5] = a1
		weapondrop[6] = a2
		weapondrop[7] = a3
	end

	--send data to display weapon in panorama
	local player = PlayerResource:GetPlayer(hero:GetPlayerID())
	if not fromserver then
		--generate item level if from server
		weapondrop[11] = "Item Level: "..totalstats.." / "..self:GetMythicWeaponMaxLevel(quality,number_attributes,weaponslot)
		weapondrop[12] = totalstats --item level
		weapondrop[13] = self:GetMythicWeaponMaxLevel(quality,number_attributes,weaponslot) --max item level
		weapondrop[14] = GetGeneratedItemType(weapon)
		--old display in bottom left
		--CustomGameEventManager:Send_ServerToPlayer(player, "lasttempleweapondrop", { item = weapondrop[1], itemname = weapondrop[0], attributes = number_attributes, stat1 = weapondrop[5], stat1name = weapondrop[8], stat2 = weapondrop[6], stat2name = weapondrop[9], stat3 = weapondrop[7], stat3name = weapondrop[10], ilevel = weapondrop[11], slot = weaponslot, rarity = quality, playerid = hero:GetPlayerID() } )
		--instant equip for debugging
		--CustomGameEventManager:Send_ServerToAllClients("templeweaponequip", { item = hero.weapondrop[1], itemname = hero.weapondrop[0], attributes = hero.weapondrop[4], stat1 = hero.weapondrop[5], stat1name = hero.weapondrop[8], stat2 = hero.weapondrop[6], stat2name = hero.weapondrop[9], stat3 = hero.weapondrop[7], stat3name = hero.weapondrop[10], slot = hero.weapondrop[2], rarity = hero.weapondrop[3], playerid = hero:GetPlayerID() } )
		
		--show each player which artifact dropped
		CustomGameEventManager:Send_ServerToAllClients("lasttempleweapondropshow", { item = weapondrop[1], itemname = weapondrop[0], attributes = number_attributes, stat1 = weapondrop[5], stat1name = weapondrop[8], stat2 = weapondrop[6], stat2name = weapondrop[9], stat3 = weapondrop[7], stat3name = weapondrop[10], ilevel = weapondrop[11], slot = weaponslot, rarity = quality, playerid = hero:GetPlayerID(), heroname = hero:GetUnitName(), weapontype = weapondrop[14] } )
		--new sell list
		AddItemToSellList(hero, player, weapondrop, number_attributes, weaponslot, quality)
		--print("artifact dropped")
		--if totalstats > self:GetMythicWeaponMaxLevel(quality,number_attributes,weaponslot) * 10 then --old was 3
		--	hero.cheater = true
		--end
	else
		--print("lua data insert")
		for i=0,10 do
			hero.inventory[weaponslot][i] = weapondrop[i]
			--print(hero.inventory[weaponslot][i])
		end
		totalstats = self:GetMythicWeaponLevel(hero, weaponslot)
		weapondrop[11] = "Item Level: "..totalstats.." / "..self:GetMythicWeaponMaxLevel(quality,number_attributes,weaponslot)
		weapondrop[12] = totalstats --item level
		weapondrop[13] = self:GetMythicWeaponMaxLevel(quality,number_attributes,weaponslot) --max item level
		weapondrop[14] = GetGeneratedItemType(weapon)
		for i=11,14 do
			hero.inventory[weaponslot][i] = weapondrop[i]
			--print(hero.inventory[weaponslot][i])
		end

		CustomGameEventManager:Send_ServerToAllClients("templeweaponequip", { item = weapondrop[1], itemname = weapondrop[0], attributes = weapondrop[4], stat1 = weapondrop[5], stat1name = weapondrop[8], stat2 = weapondrop[6], stat2name = weapondrop[9], stat3 = weapondrop[7], stat3name = weapondrop[10], ilevel = weapondrop[11], slot = weapondrop[2], rarity = weapondrop[3], playerid = hero:GetPlayerID(), weapontype = weapondrop[14] } )
		--update attributes for hero (buffs!)
		COverthrowGameMode:UpdateMythicWeaponStats(hero)
		--if from server, it was not a drop, so clear weapondrop
		--Timers:CreateTimer(0.5,function() 
		weapondrop[1] = nil
		--end)
		--if totalstats > self:GetMythicWeaponMaxLevel(quality,number_attributes,weaponslot) * 10 then --old was 3
		--	hero.cheater = true
		--end
	end
	--DeepPrintTable(weapondrop)
end

function COverthrowGameMode:SendHeroInventoryToAll( hero )
	--print("send inv to all")
	if hero and hero.inventory then
		for slot=1, self.mythic_slots do
			if hero.inventory[slot] and hero.inventory[slot][1] and string.len(hero.inventory[slot][1]) > 3 then
				--print("item "..slot)
				CustomGameEventManager:Send_ServerToAllClients("templeweaponequip", { item = hero.inventory[slot][1], itemname = hero.inventory[slot][0], attributes = hero.inventory[slot][4], stat1 = hero.inventory[slot][5],
				stat1name = hero.inventory[slot][8], stat2 = hero.inventory[slot][6], stat2name = hero.inventory[slot][9], stat3 = hero.inventory[slot][7], stat3name = hero.inventory[slot][10], ilevel = hero.inventory[slot][11], slot = hero.inventory[slot][2],
				rarity = hero.inventory[slot][3], playerid = hero:GetPlayerID() } )
			end
		end
	end
end

function GetItemPool( rarity, monster_level, act, quest_reward_level, unit )
	print("???")
end

function GetItemSlotByAct( act ) --1 = 1, 2 = 2, 3 = 4, 4 = 5, 6 = 9, 9 = 4/5/6, 10 = 9,10,11, 11 = 8, 12 = 7, 13 = 3, 10 = T, 11 = E
	local mappings = {1, 2, 4, 5, 9, 6, 3, 7, "E", "T", 8} --act to item slot mapping
	if act >= 11 then
		return mappings[math.random(1,11)]
	end
	if act <= 1 then
		act = 1
	end
	return mappings[act]

	--[[
	local slot = act
	if act >= 3 then
		slot = act + 1
	end
	if act >= 6 then
		slot = act + 3
	end
	if act == 9 then
		slot = math.random(4,6)
	end
	if act == 10 then
		slot = math.random(9,11)
	elseif act == 11 then
		slot = 8
	end
	if act == 12 then
		slot = 7
	end
	if act == 13 then
		slot = 3
	end
	slot = slot % 12
	if slot == 10 then
		slot = "T"
	end
	if slot == 11 then
		slot = "E"
	end
	return slot]]
end

function GetAllArtifacts(unit, include_craft_only_items, always_show_boss_specific_drops)
	local act = math.random(1,13)
	if unit and unit.act then
		act = unit.act
	end
	if unit and (unit.act11_boss or unit.act11_merge_boss) then
		--act = 11
		act = math.random(1,13)
	end
	--print("artifact drop, unit act ")
	--print(unit.act)
	--print(unit:GetName())
	--print("final slot " .. act)
	local itemSlot = GetItemSlotByAct( act )
	--print(" real final slot itemSlot " .. itemSlot)
	local items = {}
	items[4] = {} --epic
	table.insert(items[4], "epic" .. itemSlot .. "generate")
	items[5] = {}
	table.insert(items[5], "lege" .. itemSlot .. "generate")
	items[8] = {}
	table.insert(items[8], "immo" .. itemSlot .. "generate")
	items[10] = {}
	table.insert(items[10], "aimo" .. itemSlot .. "generate")
	items[12] = {}
	table.insert(items[12], "divi" .. itemSlot .. "generate")
	items[13] = {}
	table.insert(items[13], "myth" .. itemSlot .. "generate")

	--[[
	items[4] = --epic
	{
		"epic1aaasaacrit",
		"epic1aastragi",
		"epic2aaas",	

		"epic1straacrit",	
		"epic1straaas",	
		"epic2strabil",

		"epic1agiaacrit",
		"epic1agiaaas",
		"epic2agiabil",

		"epic1intspcrit",
		"epic1intspmana",
		"epic2intabil",

		"epic1firenaturearcane",
		"epic2spearcanefire",
		"epic2shadowfrostcrit",
		"epic2abilnature",

		"epic2liferes",
		"epic2armoraggro",
		"epic2abilms",
		"epic2critcd",
		"epic1generate",
		"epic2generate"
	}

	items[5] = --lege
	{
		"lege1aaasaacrit",
		"lege1aastragi",
		"lege2aaas",	

		"lege1straacrit",	
		"lege1straaas",	
		"lege2strabil",

		"lege1agiaacrit",
		"lege1agiaaas",
		"lege2agiabil",

		"lege1intspcrit",
		"lege1intspmana",
		"lege2intabil",

		"lege1firenaturearcane",
		"lege2spearcanefire",
		"lege2shadowfrostcrit",
		"lege2abilnature",

		"lege2liferes",
		"lege2armoraggro",
		"lege2abilms",
		"lege2critcd"
	}
	items[8] = --immo
	{
		--weapons
		"immo1aaasaacrit",
		"immo1abilphys",
		"immo1aastragi",
		"immo2aaas",	

		"immo1straacrit",	
		"immo1straaas",	
		"immo2strabil",

		"immo1agiaacrit",
		"immo1agiaaas",
		"immo2agiabil",

		"immo1intspcrit",
		"immo1intspmana",
		"immo2intabil",

		"immo1firenaturearcane",
		"immo2spearcanefire",
		"immo2shadowfrostcrit",
		"immo2abilnature",

		"immo2armorphys",
		"immo2liferes",
		"immo2armoraggro",
		"immo2abilms",
		"immo2critcd",
		--chests
		"immo5talhp",
		"immo5nahhp",
		"immo5serhp",
		"immo5talprim",
		"immo5serprim",
		--artifact rings
		"immo3agipath",
		"immo3strpath",
		"immo3intpath",
		"immo3intmana",
		"immo3stragi",
		"immo3dmgabilp",
		"immo3spabilp",
		"immo3physhafro",
		"immo3natarcfir",
		-- artifact boots
		"immo6minems",
		"immo6ticms",
		"immo6kilms",
		"immo6mineprim",
		"immo6ticprim",
		-- artifact head
		"immo4fahhp",
		"immo4loohp",
		"immo4wiihp",
		"immo4looprim",
		"immo4wiiprim"
	}
	items[10] = {} --aimo
	local tablename = items[10]
	table.insert(tablename, "aimo5talhp")
	table.insert(tablename, "aimo5nahhp")
	table.insert(tablename, "aimo5serhp")
	table.insert(tablename, "aimo6minems")
	table.insert(tablename, "aimo6ticms")
	table.insert(tablename, "aimo6kilms")
	table.insert(tablename, "aimo5talprim")
	table.insert(tablename, "aimo5serprim")
	table.insert(tablename, "aimo6mineprim")
	table.insert(tablename, "aimo6ticprim")
	table.insert(tablename, "aimo4fahhp")
	table.insert(tablename, "aimo4loohp")
	table.insert(tablename, "aimo4wiihp")
	table.insert(tablename, "aimo4looprim")
	table.insert(tablename, "aimo4wiiprim")
	table.insert(tablename, "aimo1aaasaacrit")
	table.insert(tablename, "aimo1aastragi")
	table.insert(tablename, "aimo2aaas")
	table.insert(tablename, "aimo1straacrit")
	table.insert(tablename, "aimo1straaas")
	table.insert(tablename, "aimo2strabil")
	table.insert(tablename, "aimo2shadowfrostcrit")
	table.insert(tablename, "aimo2liferes")
	table.insert(tablename, "aimo2armoraggro")
	table.insert(tablename, "aimo2abilms")
	table.insert(tablename, "aimo2critcd")
	table.insert(tablename, "aimo3strpath")
	table.insert(tablename, "aimo3stragi")
	table.insert(tablename, "aimo3dmgabilp")
	table.insert(tablename, "aimo3physhafro")
	table.insert(tablename, "aimo3natarcfir")
	table.insert(tablename, "aimo1agiaacrit")
	table.insert(tablename, "aimo1agiaaas")
	table.insert(tablename, "aimo2agiabil")
	table.insert(tablename, "aimo2abilnature")
	table.insert(tablename, "aimo3agipath")
	table.insert(tablename, "aimo1intspcrit")
	table.insert(tablename, "aimo1intspmana")
	table.insert(tablename, "aimo2intabil")
	table.insert(tablename, "aimo1firenaturearcane")
	table.insert(tablename, "aimo2spearcanefire")
	table.insert(tablename, "aimo3intpath")
	table.insert(tablename, "aimo3spabilp")
	table.insert(tablename, "aimo3intmana")
	if include_craft_only_items then
		tablename = items[8]
		table.insert(tablename, "immo1healcd")
		table.insert(tablename, "immo2armorres")
		table.insert(tablename, "immo3critcrit")
		table.insert(tablename, "immo4fahprimas")
		table.insert(tablename, "immo5nahsp")
		table.insert(tablename, "immo6kilcrit")
		tablename = items[10]
		table.insert(tablename, "aimo1healcd")
		table.insert(tablename, "aimo2armorres")
		table.insert(tablename, "aimo3critcrit")
		table.insert(tablename, "aimo4fahprimas")
		table.insert(tablename, "aimo5nahsp")
		table.insert(tablename, "aimo6kilcrit")
	end
	tablename = items[10]
	if unit and unit.act and (unit.act == 12  or unit.act == 13) then
		--new generated crafted items
		table.insert(tablename, "aimo1generate")
		table.insert(tablename, "aimo2generate")
		table.insert(tablename, "aimo3generate")
		table.insert(tablename, "aimo4generate")
		table.insert(tablename, "aimo5generate")
		table.insert(tablename, "aimo6generate")
		--print("added aimo special")
	end

	--new shoulder items
	table.insert(tablename, "aimo7generate")
	table.insert(tablename, "aimo7generate")

	--divine
	items[12] = {} --divine
	tablename = items[12]
	table.insert(tablename, "divi1generate")
	table.insert(tablename, "divi2generate")
	table.insert(tablename, "divi3generate")
	table.insert(tablename, "divi4generate")
	table.insert(tablename, "divi5generate")
	table.insert(tablename, "divi6generate")
	table.insert(tablename, "divi7generate")
	--mythical
	items[13] = {} --mythical
	tablename = items[13]
	table.insert(tablename, "myth1generate")
	table.insert(tablename, "myth2generate")
	table.insert(tablename, "myth3generate")
	table.insert(tablename, "myth4generate")
	table.insert(tablename, "myth5generate")
	table.insert(tablename, "myth6generate")
	table.insert(tablename, "myth7generate")
	--if COverthrowGameMode.jungledifficulty >= 10 then --???
		table.insert(tablename, "myth9generate")
	--end
	--if COverthrowGameMode.jungledifficulty >= 50 then
		table.insert(tablename, "mythTgenerate")
	--end
	--if COverthrowGameMode.jungledifficulty >= 200 then
		table.insert(tablename, "mythEgenerate")
	--end
	if COverthrowGameMode.jungledifficulty >= 500 then
		table.insert(tablename, "myth8generate")
	end
	--act based generated artifacts
	if unit and (unit.act11_boss or unit.act11_merge_boss) then
		local actBelonging = unit.act11_boss
		if unit.act11_merge_boss then
			actBelonging = unit.act11_merge_boss
		end
		if actBelonging == 1 or actBelonging == 2 then
			table.insert(items[4], "epic1generate")
			table.insert(items[5], "lege1generate")
			table.insert(items[8], "immo1generate")
		end
		if actBelonging == 3 or actBelonging == 4 then
			table.insert(items[4], "epic2generate")
			table.insert(items[5], "lege2generate")
			table.insert(items[8], "immo2generate")
		end
		if actBelonging == 5 or actBelonging == 6 then
			table.insert(items[4], "epic6generate")
			table.insert(items[5], "lege6generate")
			table.insert(items[8], "immo6generate")
		end
		if actBelonging == 7 or actBelonging == 8 then
			table.insert(items[4], "epic4generate")
			table.insert(items[5], "lege4generate")
			table.insert(items[8], "immo4generate")
		end
		if actBelonging == 9 then
			table.insert(items[4], "epic5generate")
			table.insert(items[5], "lege5generate")
			table.insert(items[8], "immo5generate")
		end
		if actBelonging == 10 then
			table.insert(items[4], "epic3generate")
			table.insert(items[5], "lege3generate")
			table.insert(items[8], "immo3generate")
		end
		--local actNumberToItemSlot = actBelonging % 7
		--if actNumberToItemSlot < 1 then
		--	actNumberToItemSlot = 1
		--end
		--local actNumberAsString = tostring(actNumberToItemSlot)
		--[[
		if actNumberToItemSlot == 1 or actNumberToItemSlot == 2 then
			table.insert(items[4], "epic" .. actNumberAsString .. "generate")
			table.insert(items[5], "lege" .. actNumberAsString .. "generate")
			table.insert(items[8], "immo" .. actNumberAsString .. "generate")
		end
		if actNumberToItemSlot == 1 or actNumberToItemSlot == 2 then
			table.insert(items[4], "epic" .. actNumberAsString .. "generate")
			table.insert(items[5], "lege" .. actNumberAsString .. "generate")
			table.insert(items[8], "immo" .. actNumberAsString .. "generate")
		end
		--print("added aimo special")
	end
	--if GetDifficultyModeUniqueArtifactDropable() then
	--	table.insert(items[4], "epic9generate")
	--	table.insert(items[4], "epicTgenerate")
	--	table.insert(items[4], "epicEgenerate")
	--end
	--if unit and unit.act11_merge_boss then
	
	--end
	--DeepPrintTable(items)]]

	return items
end

function GetActSpecificItemsByRarity( act )
	local unit = {act = act}
	local all_items = GetAllItems(unit, false, false, 1)
	unit.act = nil
	local base_items = GetAllItems(unit, false, false, 1)
	local result = {}
	for i=1,12 do
		result[i] = {}
		for j=1,#all_items[i] do
			if not table.contains(base_items[i], all_items[i][j]) then
				table.insert(result[i], all_items[i][j])
			end
		end
	end
	--DeepPrintTable(result)
	return result
end

function GetActSpecificItems( act )
	local unit = {act = act}
	local all_items = GetAllItems(unit, false, false, 1)
	unit.act = nil
	local base_items = GetAllItems(unit, false, false, 1)
	local result = {}
	for i=1,12 do
		for j=1,#all_items[i] do
			if not table.contains(base_items[i], all_items[i][j]) then
				table.insert(result, all_items[i][j])
			end
		end
	end
	--DeepPrintTable(result)
	return result
end

function UnitDropsSoul( unit, soul )
	if unit and unit.act then
		local act = unit.act
		if act == 11 then
			if unit.act11_boss then
				--act 11 bosses, must find their act they belong to
				act = unit.act11_boss
			end
		end
		if act == 1 and soul >= 37 and soul <= 45 then --wolf tier 1
			return true
		end
		if act == 2 and ((soul >= 46 and soul <= 48) or (soul >= 58 and soul <= 60)) then -- wolf tier 2
			return true
		end
		if act == 3 and soul >= 13 and soul <= 21 then -- tiger tier 1
			return true
		end
		if act == 4 and soul >= 61 and soul <= 69 then -- demon tier 1
			return true
		end
		if act == 5 and soul >= 25 and soul <= 33 then --dragon tier 1
			return true
		end
		if act == 6 and soul >= 1 and soul <= 9 then -- bear tier 1
			return true
		end
		if act == 7 and ((soul >= 34 and soul <= 36) or (soul >= 55 and soul <= 57)) then -- dragon tier 2
			return true
		end
		if act == 8 and soul >= 70 and soul <= 75 then -- demon tier 2
			return true
		end
		if act == 9 and ((soul >= 10 and soul <= 12) or (soul >= 49 and soul <= 51)) then -- bear tier 2
			return true
		end
		if act == 10 and ((soul >= 22 and soul <= 24) or (soul >= 52 and soul <= 54)) then -- tiger tier 2
			return true
		end
		if (act == 12) and (soul >= 76 and soul <= 84) then -- crow tier 1
			return true
		end
		if (act == 13) and (soul >= 85 and soul <= 90) then -- crow tier 2
			return true
		end
		if (act == 7) and (soul >= 91 and soul <= 99) then -- dk tier 1
			return true
		end
		if (act == 13) and (soul >= 100 and soul <= 105) then -- dk tier 2
			return true
		end
		if act == 6 and soul >= 106 and soul <= 114 then -- guardian tier 1
			return true
		end
		if act == 2 and soul >= 115 and soul <= 120 then -- guardian tier 2
			return true
		end
		if act == 11 then --act 11 can potentially drop all souls
			return true
		end
	end
	return false
end

function table.contains(table, element)
	for _, value in pairs(table) do
		if value == element then
			return true
		end
	end
	return false
end

function GetAllItems(unit, always_show_boss_specific_drops, return_drop_quantity, act_specific_loot_factor)
	local act = 0
	if unit and unit.act then
		act = unit.act
	end
	if unit and unit.act11_boss and (unit.act11_boss <= 10 and math.random(1,100) <= 50 and not always_show_boss_specific_drops) then --make act 11 bosses also drop their corresponding act loot 50% of time
		unit.act = unit.act11_boss
	end
	local items = {}
	items[1] = --white
	{
		"item_str1",
		"item_agi1",
		"item_int1",
		"item_boots1",
		"item_hp1",
		"item_mana1",
		"item_manareg1",
		"item_armor1",
		"item_magicres1",
		"item_gloves1",
		"item_dmg1",
		"item_sp1",
		"item_shield21",
		"item_evasion",
		"item_all1",
		"item_gloves2",
		"item_cdr",
		"item_strarm",
		"item_intreg",
		"item_hpregen1"
	}
	--items[1] = --white
	--{
	--	"item_dragon_scale"
	--}
	items[2] = --green <font color=\"#32cd32\">
	{
		"item_bootssas",
		"item_bootshp",
		"item_bootsswift",
		"item_bootsmana",
		"item_strrecipe",
		"item_agirecipe",
		"item_intrecipe",
		"item_allrecipe",
		"item_str2",
		"item_agi2",
		"item_int2",
		"item_str3",
		"item_agi3",
		"item_int3",
		"item_dmg2",
		"item_dmg3",
		"item_armor2",
		"item_armor3",
		"item_magicres2",
		"item_magicres3",
		"item_hp2",
		"item_weaponpoison",
		"item_caster2",
		"item_weaponpoison2",
		"item_shield10",
		"item_shield1",
		"item_shield2",
		"item_active1",
		"item_active2",
		"item_weapon3",
		"item_sprecipe",
		"item_activedruid",
		"item_activedk",
		"item_activedk_frost",
		"item_activeshaman",
		"item_activerogue",
		"item_activerogue2",
		"item_activepaladin",
		"item_activehunter",
		"item_activemage2",
		"item_activewarlock",
		"item_activewarrior",
		"item_activedh",
		"item_irontalon",
		"item_caster55",
		"item_activepriest",
		"item_crit1",
		"item_crit2",
		"item_mana2",
		"item_hpregen2",
	}
	items[3] = -- rare <font color=\"#0000ff\">
	{
		"item_weapon1",
		"item_headarmor1",
		"item_weapon9",
		"item_active13",
		"item_weapon7",
		"item_weapon5up",
		"item_cooldown",
		"item_weapon20",
		"item_caster3",
		"item_caster1",
		"item_caster4",
		"item_caster5",
		"item_caster6",
		"item_active5",
		"item_weapon8",
		"item_weapon2",
		"item_weapon10",
		"item_nightblade",
		"item_active9",
		"item_shield3",
		"item_active1up",
		"item_active2up",
		"item_allstats3",
		"item_weapon4",
		"item_stunitem",
		"item_weapon6",
		"item_bowcasttime",
		"item_curseblade",
		"item_bootsswiftup",
		"item_allrecipe4",
		"item_allstats2up",
		"item_aura1",
		"item_aura4",
		"item_devilsoul",
		"item_active99",
		"item_active7",
		"item_weapon14",
		"item_lifesteal2",
		"item_crit_pure",
		"item_endgame1",
		"item_shield1up",
		"item_shield2up",
		"item_chainlightning",
		"item_active9up",
		"item_activemage",
		"item_wolf_belt",
		"item_aa_mana1"
	}
	items[4] = --epic <font color=\"#ff69b4\">
	{
		"item_valyrian",
		"item_bootshp2",
		"item_caster7",
		"item_wolf_belt_standard",
		--"item_dragonpike",
		"item_elements",
		"item_holyhammer2",
		"item_active6",
		--"item_aether_lens",
		"item_flamefury",
		"item_beastmaster",
		"item_active3",
		"item_active4",
		"item_weaponpoison3",
		"item_libramoflight",
		"item_fireball",
		"item_weapon5",
		"item_shieldluna",
		"item_aura3",
		"item_allstats4",
		"item_lightbringer",
		"item_aura2",
		"item_straxe2",
		"item_halberd",
		"item_weapon7up",
		"item_stunitem2",
		"item_shield3up",
		"item_bootstime",
		"item_bootscurse",
		"item_weapon11",
		"item_weapon40",
		"item_crit_pure_2",
		"item_weapon5_magma",
		"item_active7up",
		--"item_wolf_cloak",
		"item_activedruid2",
		"item_activedk2",
		"item_activedk_frost2",
		"item_activeshaman2",
		"item_activerogue3",
		"item_activerogue4",
		"item_activepaladin2",
		"item_activehunter2",
		"item_activemage3",
		"item_activewarlock2",
		"item_activewarrior2",
		"item_endgame6",
		"item_activedh2",
		"item_irontalon2",
		"item_active5up",
		"item_endgame14",
		"item_activepriest2"
		--"item_molten_steel"
	}
	items[5] = -- legendary <font color=\"#ff8c00\">
	{
		"item_endgame9",	
		"item_endgame2",	
		"item_endgame4",
 		"item_endgame12",
 		"item_endgame5",	
 		"item_endgame10",
 		"item_endgame3",
 		"item_endgame8",
 		"item_aura_eagle",
 		"item_wolf_cloak_2",
 		--"item_endgame7",
 		--"item_endgame13",
 		--"item_hasteproc",
 		"item_bowupgrade",
 		"item_sharpeye",
 		"item_viper_blade",
 		--"item_wolf_claw",
 		--"item_shield_aggro",
 		--"item_shield_stun",
 		--"item_sandstorm",
 		--"item_nova_blade",
 		--"item_shield_immolation",
 		"item_ice_cleaver",
		--"item_shadowmourne",
		--"item_nova_blade_shadow",
		--"item_mother_of_dragons",
		"item_needle",
		"item_netherchaos",
		"item_bootsreflect2",
		--"item_zeus_cloud",
		--"item_arcaneblaster",
		--"item_silvermoon",
		"item_hunterbow",
		"item_rogueblades",
		"item_holypike",
		"item_bootscrit_2",
		--"item_crit_pure_3",
		--"item_beastbracer",
		"item_purgeblade",
		"item_demonglaive",
		"item_allstats5",
		"item_bootsblood2",
		"item_needleaa",
		"item_aa_mana3"
	}
	items[6] = 
	{
		"item_set_int_dmg_3",
 		"item_set_int_dmg_2",
 		"item_set_int_dmg_1",
 		"item_set_agi_dmg_3",
 		"item_set_agi_dmg_2",
 		"item_set_agi_dmg_1",
 		"item_set_str_dmg_3",
 		"item_set_str_dmg_2",
 		"item_set_str_dmg_1",
 		"item_set_str_tank_3",
 		"item_set_str_tank_2",
 		"item_set_str_tank_1",
 		"item_set_str_t2_1",
		"item_set_str_t2_2",
		"item_set_str_t2_3",
		"item_set_agi_t2_1",
		"item_set_agi_t2_2",
		"item_set_agi_t2_3",
		"item_set_int_t2_1",
		"item_set_int_t2_2",
		"item_set_int_t2_3",
		"item_warglaive_2",
		"item_warglaive_1",
		"item_spellhaste_1",
		"item_spellhaste_2",
		"item_ring_arcane_2",
 		"item_ring_arcane"
	}
	--ancient legendaries
	items[7] = 
	{
		"item_lotusguard",
 		"item_shivacape",
 		"item_windforce",
 		"item_winterbreeze",
 		"item_silverblood",
 		"item_frostfire",
 		"item_handoffirelord",
 		"item_warglaive",
 		"item_eternallife",
 		"item_arcaniteshield",
 		"item_frostmourne"
	}
	--immortals <font color=\"#00bfff\">
	items[8] =
	{
		"item_helmthunder",	
		"item_silverblood2",
		"item_winterbreeze2",	
		"item_windforce2",	
		"item_needle2",	
		"item_crit_pure_immortal",	
		"item_spellblood",	
		"item_powerhelm",	
		"item_outburst2",
		"item_staffheal",
		"item_fireball2",
		"item_flyingdagger",
		"item_armoraxe",
		"item_tankaxe",
		"item_totemlife",
		"item_auraspimmortal",
		"item_aura_empire",
		"item_bootsheal",
		"item_beastmaster2",
		"item_stormrider",
		"item_shadowflame",
		"item_spellhaste_4",
		"item_crit_frost_immortal",
		"item_intmana",
		"item_inthp",
		"item_agihp",
		"item_attackpoint",
		"item_weapon7up2",
		"item_weapon7up3",
		"item_crit_pure_5",
		"item_lotusguard2",
		"item_fireball3",
		"item_bootsblood3",
		"item_crit_pure_immortal2",
		"item_winterbreeze3",
		"item_silverblood3",
		"item_windforce3",
		"item_wolf_claw2",
		"item_shadowstrike",
		"item_agistr2",
		"item_allstats6",
		"item_purgeblade2",
		"item_viper_blade_2",
		"item_nova_blade2",
		"item_wolf_cloak_3",
		"item_bootscrit2",
		"item_elements3",
		"item_activepaladin3",
		"item_straxe3",
		"item_dmgminusas" --reworked until here
	}
	--immortal sets
	items[9] =
	{
		--2 piece immortal sets
		"item_set_int_t3_1",
		"item_set_int_t3_2",
		"item_set_agi_t3_1",
		"item_set_agi_t3_2",
		"item_set_str_t3_1",
		"item_set_str_t3_2",
		--3 piece immortal
		"item_set_str_t3_2_1",
		"item_set_str_t3_2_2",
		"item_set_str_t3_2_3",
		"item_set_agi_t3_2_1",
		"item_set_agi_t3_2_2",
		"item_set_agi_t3_2_3",
		"item_set_int_t3_2_1",
		"item_set_int_t3_2_2",
		"item_set_int_t3_2_3"
	}

	--ancient immortals
	items[10] =
	{
		"item_silverblood4",
		"item_windforce4",
		"item_winterbreeze4",
		"item_dmg4",
		"item_sp4",
		"item_buff_str",
		"item_buff_agi",
		"item_buff_int"
	}
	--ancient immortals, second generation, boss specific
	local act_11_drop_factor = 6 * act_specific_loot_factor --3 * act_specific_loot_factor -- bonus factor on some bosses
	if not return_drop_quantity then
		act_11_drop_factor = 1
	end
	if (unit and unit.act) or always_show_boss_specific_drops then
		if (unit and unit.act == 1) or always_show_boss_specific_drops then
			local anc_item = "item_ancient_dmg"
			for i=1, act_11_drop_factor do
				table.insert(items[10], anc_item)
			end
			anc_item = "item_ancient_def_wolf"
			for i=1, act_11_drop_factor do
				table.insert(items[10], anc_item)
			end
			anc_item = "item_bootscrit3"
			for i=1, act_11_drop_factor do
				table.insert(items[10], anc_item)
			end
		end
		if (unit and unit.act == 2) or always_show_boss_specific_drops then
			local anc_item = "item_lotusguard3"
			for i=1, act_11_drop_factor do
				table.insert(items[10], anc_item)
			end
			anc_item = "item_aura_ancient" --
			for i=1, act_11_drop_factor do
				table.insert(items[10], anc_item)
			end
			anc_item = "item_nature"
			for i=1, act_11_drop_factor do
				table.insert(items[10], anc_item)
			end
		end
		if (unit and unit.act == 3) or always_show_boss_specific_drops then
			local anc_item = "item_spellhaste_5"
			for i=1, act_11_drop_factor do
				table.insert(items[10], anc_item)
			end
			anc_item = "item_ancient_allstats"
			for i=1, act_11_drop_factor do
				table.insert(items[10], anc_item)
			end
			anc_item = "item_set_t4_panther"
			for i=1, act_11_drop_factor do
				table.insert(items[10], anc_item)
			end
		end
		if (unit and unit.act == 4) or always_show_boss_specific_drops then
			local anc_item = "item_ancient_agi"
			for i=1, act_11_drop_factor do
				table.insert(items[10], anc_item)
			end
			anc_item = "item_ancient_elune"
			for i=1, act_11_drop_factor do
				table.insert(items[10], anc_item)
			end
			anc_item = "item_ancient_dot" --
			for i=1, act_11_drop_factor do
				table.insert(items[10], anc_item)
			end
			anc_item = "item_night_shoulders"
			for i=1, act_11_drop_factor do
				table.insert(items[10], anc_item)
			end
		end
		if (unit and unit.act == 5) or always_show_boss_specific_drops then
			local anc_item = "item_voodoo_scythe"
			for i=1, act_11_drop_factor do
				table.insert(items[10], anc_item)
			end
			anc_item = "item_ancient_dragon"
			for i=1, act_11_drop_factor do
				table.insert(items[10], anc_item)
			end
			anc_item = "item_crit_pure_immortal_2"
			for i=1, act_11_drop_factor do
				table.insert(items[10], anc_item)
			end
			anc_item = "item_dragonshield"
			for i=1, act_11_drop_factor do
				table.insert(items[10], anc_item)
			end
		end
		if (unit and unit.act == 6) or always_show_boss_specific_drops then
			local anc_item = "item_helmthunder2"
			for i=1, act_11_drop_factor do
				table.insert(items[10], anc_item)
			end
			anc_item = "item_ancient_8"
			for i=1, act_11_drop_factor do
				table.insert(items[10], anc_item)
			end
			anc_item = "item_longbow"
			for i=1, act_11_drop_factor do
				table.insert(items[10], anc_item)
			end
		end
		if (unit and unit.act == 7) or always_show_boss_specific_drops then
			local anc_item = "item_ancient_def"
			for i=1, act_11_drop_factor do
				table.insert(items[10], anc_item)
			end
			anc_item = "item_dmg5"
			for i=1, act_11_drop_factor do
				table.insert(items[10], anc_item)
			end
		end
		if (unit and unit.act == 8) or always_show_boss_specific_drops then
			local anc_item = "item_sandstorm2"
			for i=1, act_11_drop_factor do
				table.insert(items[10], anc_item)
			end
			anc_item = "item_ancient_wolf"
			for i=1, act_11_drop_factor do
				table.insert(items[10], anc_item)
			end
			anc_item = "item_fireball4"
			for i=1, act_11_drop_factor do
				table.insert(items[10], anc_item)
			end
		end
		if (unit and unit.act == 9) or always_show_boss_specific_drops then
			local anc_item = "item_ancient_str"
			for i=1, act_11_drop_factor do
				table.insert(items[10], anc_item)
			end
			anc_item = "item_ancient_grizzly"
			for i=1, act_11_drop_factor do
				table.insert(items[10], anc_item)
			end
			anc_item = "item_weapon7up4"
			for i=1, act_11_drop_factor do
				table.insert(items[10], anc_item)
			end
			anc_item = "item_crit_pure_immortal_3"
			for i=1, act_11_drop_factor do
				table.insert(items[10], anc_item)
			end
		end
		if (unit and unit.act == 10) or always_show_boss_specific_drops then
			local anc_item = "item_bootsreflect3"
			for i=1, act_11_drop_factor do
				table.insert(items[10], anc_item)
			end
			anc_item = "item_ancient_primary"
			for i=1, act_11_drop_factor do
				table.insert(items[10], anc_item)
			end
			anc_item = "item_frostfire2"
			for i=1, act_11_drop_factor do
				table.insert(items[10], anc_item)
			end
		end
		if (unit and unit.act == 11) or always_show_boss_specific_drops then
			local anc_item = "item_crit_pure_immortal3"
			for i=1, act_11_drop_factor do
				table.insert(items[10], anc_item)
			end
			anc_item = "item_crusader_mount"
			for i=1, act_11_drop_factor do
				table.insert(items[10], anc_item)
			end
		end
	end
	--ancient immortal jungle sets
	items[11] =
	{
		"item_set_t4_agi_1",
		"item_set_t4_aa_2",
		"item_set_t4_aad_2",
		"item_set_t4_int_1",
		"item_set_t4_sp_1",
		"item_set_t4_str_1",
		"item_set_t4_aa_1",
		"item_set_t4_aad_1",
		"item_set_t4_agi_2",
		"item_set_t4_sp_2",
		"item_set_t4_int_2",
		"item_set_t4_new_3",
		"item_set_t4_new_1",
		"item_set_t4_str_3",
		"item_set_t4_int_3",
		"item_set_t4_sp_3",
		"item_set_t4_agi_3",
		"item_set_t4_aa_3",
		"item_set_t4_aad_3",
		"item_set_t4_new_2",
		"item_set_t4_str_2",
		"item_set_t2_combine_token" --temple shard
	}
	--new soul items, first 3 rows
	for j=1, 45 do
		--exlude last 20 path talents
		if j ~= 51 and j ~= 54 and j ~= 57 and j ~= 10 and j ~= 11 and j ~= 12 and j ~= 22 and j ~= 23 and j ~= 24 and j ~= 34 and j ~= 35 and j ~= 36 and j ~= 46 and j ~= 47 and j ~= 48 then
			local item_name = "item_mastery_0"..tostring(j).."_002"
			if j < 10 then
				item_name = "item_mastery_00"..tostring(j).."_002"
			end
			if UnitDropsSoul(unit, j) or always_show_boss_specific_drops then
				table.insert(items[10], item_name)
			end
		end
	end
	for j=61, 69 do
		--last 5 path talents
		local item_name = "item_mastery_0"..tostring(j).."_002"
		if UnitDropsSoul(unit, j) or always_show_boss_specific_drops then
			table.insert(items[10], item_name)
		end
	end
	--last 2 rows
	for j=10, 60 do
		--last 20 path talents
		if j == 10 or j == 11 or j == 12 or j == 22 or j == 23 or j == 24 or j == 34 or j == 35 or j == 36 or j == 46 or j == 47 or j == 48 or j == 49 or j == 50 or j == 51 or j == 52 or j == 53 or j == 54 or j == 55 or j == 56 or j == 57 or j == 58 or j == 59 or j == 60 then
			local item_name = "item_mastery_0"..tostring(j).."_002"
			if j < 10 then
				item_name = "item_mastery_00"..tostring(j).."_002"
			end
			if UnitDropsSoul(unit, j) or always_show_boss_specific_drops then
				table.insert(items[11], item_name)
			end
		end
	end
	--new shadow demon souls
	for j=70, 75 do
		--last 5 path talents
		local item_name = "item_mastery_0"..tostring(j).."_002"
		if UnitDropsSoul(unit, j) or always_show_boss_specific_drops then
			table.insert(items[11], item_name)
		end
	end
	--new storm crow souls
	for j=76, 84 do
		--first 3 path rows
		local item_name = "item_mastery_0"..tostring(j).."_002"
		if UnitDropsSoul(unit, j) or always_show_boss_specific_drops then
			table.insert(items[10], item_name)
		end
	end
	for j=85, 90 do
		--last 5 path rows
		local item_name = "item_mastery_0"..tostring(j).."_002"
		if UnitDropsSoul(unit, j) or always_show_boss_specific_drops then
			table.insert(items[11], item_name)
		end
	end
	--new death knight souls
	for j=91, 99 do
		--first 3 path rows
		local item_name = "item_mastery_0"..tostring(j).."_002"
		if UnitDropsSoul(unit, j) or always_show_boss_specific_drops then
			table.insert(items[10], item_name)
		end
	end
	for j=100, 105 do
		--last 5 path rows
		local item_name = "item_mastery_"..tostring(j).."_002"
		if UnitDropsSoul(unit, j) or always_show_boss_specific_drops then
			table.insert(items[11], item_name)
		end
	end
	--new death knight souls
	for j=106, 114 do
		--first 3 path rows
		local item_name = "item_mastery_"..tostring(j).."_002"
		if UnitDropsSoul(unit, j) or always_show_boss_specific_drops then
			table.insert(items[10], item_name)
		end
	end
	for j=115, 120 do
		--last 5 path rows
		local item_name = "item_mastery_"..tostring(j).."_002"
		if UnitDropsSoul(unit, j) or always_show_boss_specific_drops then
			table.insert(items[11], item_name)
		end
	end
	items[12] = COverthrowGameMode:GetAllDivineItems()
	--act and boss specific drops
	for k=1, act_11_drop_factor do
		if (unit and unit.act and unit.act == 1) or always_show_boss_specific_drops then
			table.insert(items[5], "item_wolf_claw")
			table.insert(items[4], "item_wolf_cloak")
			table.insert(items[7], "item_bloodlust")
			table.insert(items[12], "item_bloodlust_2")
			table.insert(items[7], "item_wolf_sword")
			table.insert(items[12], "item_wolf_sword_2")
			table.insert(items[10], "item_outburst3")
			table.insert(items[10], "item_class_wild")
			table.insert(items[10], "item_resaura")
			table.insert(items[12], "item_bloodbrother")
		end
		if (unit and unit.act and unit.act == 2) or always_show_boss_specific_drops then
			table.insert(items[5], "item_nova_blade")
			table.insert(items[5], "item_sandstorm")
			table.insert(items[7], "item_windfury")
			table.insert(items[12], "item_windfury_2")
			table.insert(items[10], "item_class_cruel")
			table.insert(items[10], "item_class_bounty")
			table.insert(items[10], "item_rune")
			table.insert(items[10], "item_class_pa2")
			table.insert(items[12], "item_divine_phys")
		end
		if (unit and unit.act and unit.act == 3) or always_show_boss_specific_drops then
			table.insert(items[5], "item_endgame13")
			table.insert(items[5], "item_silvermoon")
			table.insert(items[7], "item_aa_mana4")
			table.insert(items[7], "item_cd_43")
			table.insert(items[12], "item_cd_43_2")
			table.insert(items[10], "item_attackpoint2")
			table.insert(items[10], "item_moonlighttiger")
			table.insert(items[10], "item_class_venge")
			table.insert(items[10], "item_inttohp")
			table.insert(items[10], "item_class_venge2")
			table.insert(items[10], "item_class_bounty2")
			
		end
		if (unit and unit.act and unit.act == 4) or always_show_boss_specific_drops then --shadowlands
			table.insert(items[5], "item_shadowmourne")
			table.insert(items[5], "item_nova_blade_shadow")
			table.insert(items[7], "item_channel")
			table.insert(items[12], "item_channel_2")
			table.insert(items[7], "item_focus_dagger")
			table.insert(items[12], "item_focus_dagger_2")
			table.insert(items[10], "item_class_dire")
			table.insert(items[10], "item_rogueblades2")
			table.insert(items[10], "item_class_warlock")
			table.insert(items[10], "item_class_darkseer")
			table.insert(items[10], "item_dark")
			table.insert(items[10], "item_new3")
			table.insert(items[10], "item_class_warlock2")
			table.insert(items[10], "item_class_pugna2")
			table.insert(items[10], "item_class_pudge2")
			table.insert(items[10], "item_class_skele2")
			table.insert(items[12], "item_nameless")
			table.insert(items[12], "item_killer")
			table.insert(items[12], "item_pathbuff_152")
			
		end
		if (unit and unit.act and unit.act == 5) or always_show_boss_specific_drops then --dragon
			table.insert(items[5], "item_mother_of_dragons")
			table.insert(items[4], "item_dragonpike")
			table.insert(items[7], "item_agihaste")
			table.insert(items[12], "item_agihaste_2")
			table.insert(items[10], "item_class_snow")
			table.insert(items[10], "item_class_arctic")
			table.insert(items[10], "item_class_flame")
			table.insert(items[10], "item_dragonmind")
			table.insert(items[10], "item_wing")
			table.insert(items[10], "item_class_ghost2")
			table.insert(items[10], "item_aaa2")
			table.insert(items[12], "item_pathbuff_129")
			
		end
		if (unit and unit.act and unit.act == 6) or always_show_boss_specific_drops then --mountain
			table.insert(items[5], "item_endgame7")
			table.insert(items[4], "item_aa_mana2")
			table.insert(items[7], "item_cd_54")
			table.insert(items[12], "item_cd_54_2")
			table.insert(items[10], "item_longbow2")
			table.insert(items[10], "item_class_savage")
			table.insert(items[10], "item_class_elemental")
			table.insert(items[10], "item_class_grizzly")
			table.insert(items[10], "item_firenature")
			table.insert(items[10], "item_summon")
			table.insert(items[10], "item_storm")
			table.insert(items[10], "item_class_legion2")
			table.insert(items[10], "item_class_peaceful2")
			table.insert(items[10], "item_class_sanct2")
			table.insert(items[12], "item_summoner")
			table.insert(items[12], "item_thunderclub")
			
		end
		if (unit and unit.act and unit.act == 7) or always_show_boss_specific_drops then --graveyard
			table.insert(items[5], "item_shield_aggro")
			table.insert(items[5], "item_crit_pure_3")
			table.insert(items[7], "item_bighit")
			table.insert(items[12], "item_bighit_2")
			table.insert(items[10], "item_class_retri")
			table.insert(items[10], "item_deathknight")
			table.insert(items[10], "item_class_colossal")
			table.insert(items[10], "item_class_sanctified")
			table.insert(items[10], "item_class_deadly")
			table.insert(items[10], "item_class_terror")
			table.insert(items[10], "item_purecrit")
			table.insert(items[10], "item_hptosp")
			table.insert(items[10], "item_holyaaa")
			table.insert(items[10], "item_class_wl2")
			table.insert(items[10], "item_class_dh2")
			table.insert(items[10], "item_class_ds2")
			table.insert(items[12], "item_pathbuff_156")
		end
		if (unit and unit.act and unit.act == 8) or always_show_boss_specific_drops then --forge
			table.insert(items[5], "item_dreihander")
			table.insert(items[5], "item_shield_immolation")
			table.insert(items[7], "item_titanarmor")
			table.insert(items[12], "item_titanarmor_2")
			table.insert(items[10], "item_class_beast")
			table.insert(items[10], "item_class_plated")
			table.insert(items[10], "item_class_chaos")
			table.insert(items[10], "item_class_am")
			table.insert(items[10], "item_firebow")
			table.insert(items[10], "item_class_jungle2")
			table.insert(items[10], "item_class_flame2")
			table.insert(items[10], "item_class_ele2")
			table.insert(items[12], "item_firestone")
			table.insert(items[12], "item_rider_boots")
			
		end
		if (unit and unit.act and unit.act == 9) or always_show_boss_specific_drops then --arena
			table.insert(items[5], "item_shield_stun")
			table.insert(items[7], "item_cleavemace")
			table.insert(items[12], "item_cleavemace_2")
			table.insert(items[12], "item_straxe4")
			table.insert(items[10], "item_class_spirit")
			table.insert(items[10], "item_class_unholy")
			table.insert(items[10], "item_aad")
			table.insert(items[10], "item_class_brawler")
			table.insert(items[10], "item_class_fury")
			table.insert(items[10], "item_dragonmind2")
			table.insert(items[10], "item_crowndefender")
			table.insert(items[10], "item_giant")
			table.insert(items[10], "item_coloss")
			table.insert(items[10], "item_class_plated2")
			table.insert(items[10], "item_class_bm2")
			table.insert(items[12], "item_pikepower")
			
		end
		if (unit and unit.act and unit.act == 10) or always_show_boss_specific_drops then --invoker
			table.insert(items[5], "item_aa_mana3")
			table.insert(items[5], "item_hasteproc")
			table.insert(items[5], "item_arcaneblaster")
			table.insert(items[7], "item_cd_65")
			table.insert(items[12], "item_cd_65_2")
			table.insert(items[7], "item_multi_element")
			table.insert(items[12], "item_multi_element_2")
			table.insert(items[10], "item_netherchaos3")
			table.insert(items[10], "item_class_arcane")
			table.insert(items[10], "item_arcanabracers")
			table.insert(items[10], "item_whiterobe")
			table.insert(items[10], "item_crown3")
			table.insert(items[10], "item_class_invo2")
			table.insert(items[12], "item_fusion")
			table.insert(items[12], "item_wandwisdom")
			
		end
		if (unit and unit.act and unit.act == 11) or always_show_boss_specific_drops then
			table.insert(items[5], "item_zeus_cloud")
			table.insert(items[12], "item_netherchaos2")
			table.insert(items[10], "item_beastmaster3")
			table.insert(items[5], "item_attackpoint0")
			table.insert(items[10], "item_big")
			table.insert(items[10], "item_chaosshield")
			table.insert(items[10], "item_class_demo")
			table.insert(items[10], "item_new7")
			table.insert(items[10], "item_class_axe2")
			table.insert(items[10], "item_class_shaolin2")
			table.insert(items[10], "item_class_mars2")
			table.insert(items[10], "item_class_riki2")
			table.insert(items[12], "item_endboss")
			table.insert(items[12], "item_pathbuff_158")
			table.insert(items[12], "item_divinedef")
			
		end
		if (unit and unit.act and unit.act == 12) or always_show_boss_specific_drops then --jugnle
			table.insert(items[5], "item_beastbracer")
			table.insert(items[10], "item_immo_1")
			table.insert(items[10], "item_class_jungle")
			table.insert(items[10], "item_class_peaceful")
			table.insert(items[10], "item_critmaster")
			table.insert(items[10], "item_naturedot")
			table.insert(items[10], "item_rage")
			table.insert(items[10], "item_new8")
			table.insert(items[10], "item_class_dazz2")
			table.insert(items[10], "item_class_sniper2")
			table.insert(items[10], "item_class_ursa2")
			table.insert(items[10], "item_class_ench2")
			table.insert(items[10], "item_class_sham2")
			table.insert(items[12], "item_pathbuff_132")
			table.insert(items[12], "item_spearspeed")
			
		end
		if (unit and unit.act and unit.act == 13) or always_show_boss_specific_drops then
			table.insert(items[10], "item_frostmourne2")
			table.insert(items[10], "item_crit_frost_immortal2")
			table.insert(items[10], "item_class_invoker")
			table.insert(items[10], "item_class_winter")
			table.insert(items[10], "item_snowl")
			table.insert(items[10], "item_frostcrit")
			table.insert(items[10], "item_class_drow2")
			table.insert(items[10], "item_class_winter2")
			table.insert(items[10], "item_class_sven2")
			table.insert(items[12], "item_wise_eye")
			table.insert(items[12], "item_icelotus")
			table.insert(items[12], "item_divine_frost")
		end
		--cain chest bonus rewards
		if (unit and unit.main_quest_boss and (unit.main_quest_boss == 13 or unit.main_quest_boss == 14 or unit.main_quest_boss == 15)) or always_show_boss_specific_drops then
			table.insert(items[5], "item_cain_legendary")
			table.insert(items[8], "item_cain_immo")
			table.insert(items[12], "item_cain_divine")
		end
	end
	items[13] = {
		"item_myth_str",
		"item_myth_agi",
		"item_myth_aa",
		"item_myth_aad",
		"item_myth_int",
		"item_myth_sp",
		"item_myth_def",
		"item_aura33",
		"item_allstats2",
		"item_attackpoint3",
		"item_bootscrit4",
		"item_crit_myth",
		"item_xset_str_t3_2_2",
		"item_set_t3_combine_token",
		"item_weapon7up6",
		"item_weapon7up5",
		"item_tamerbond",
		"item_purecrit2",
		"item_resaura2",
		"item_arcanabracers2",
		"item_crowndefender2",
		"item_critmaster2",
		"item_giant2",
		"item_firebow2",
		"item_snowl2",
		"item_naturedot2",
		"item_hptosp2",
		"item_firenature2",
		"item_holyaaa2",
		"item_summon2",
		"item_frostcrit2",
		"item_whiterobe2",
		"item_dark2",
		"item_big2",
		"item_chaosshield2",
		"item_rage2",
		"item_storm2",
		"item_coloss2",
		"item_crown2",
		"item_rune2",
		"item_wing2",
		"item_inttohp2",
		"item_elements4",
		"item_new82",
		"item_new72",
		"item_new32",
		"item_purgeblade3"
	}
	if COverthrowGameMode.jungledifficulty >= 500 then
		table.insert(items[13], "item_set_t4_combine_token")
	end
	--DeepPrintTable(items)
	--reset unit act, changed for act specific loot
	if unit and unit.act then
		unit.act = act
	end
	return items
end

function COverthrowGameMode:GetLootTableByItemQuality( loottable, ilevel)
	if ilevel == 1 or ilevel == 2 or ilevel == 3 or ilevel == 4 or ilevel == 5 or ilevel == 8 or ilevel == 12 or ilevel == 13 then --pure item categories
		return loottable[ilevel]
	else --combined item categories
		local loot
		if ilevel == 6 then
			loot = loottable[5]
			for k,v in pairs(loottable[6]) do
		        --print(k)
		        --print(v)
		        table.insert(loot, v)
		    end
		end
		if ilevel == 7 then
			loot = loottable[5]
			for k,v in pairs(loottable[6]) do
		        table.insert(loot, v)
		    end
		    for k,v in pairs(loottable[7]) do
		        table.insert(loot, v)
		    end
		end
		if ilevel == 9 then
			loot = loottable[8]
			for k,v in pairs(loottable[9]) do
		        table.insert(loot, v)
		    end
		end
		if ilevel == 10 then
			loot = loottable[8]
			for k,v in pairs(loottable[9]) do
		        table.insert(loot, v)
		    end
		    --problem: higer drop chance bonuses dont affect immo / aimo proportion
		    local aimo_weighting = 1
		    if COverthrowGameMode.jungledifficulty >= 50 then
		    	aimo_weighting = 2
		    end
		    for k=1, aimo_weighting do
			    for k,v in pairs(loottable[10]) do
			        table.insert(loot, v)
			    end
			end
		end
		if ilevel == 11 then
			loot = loottable[8]
			for k,v in pairs(loottable[9]) do
		        table.insert(loot, v)
		    end
		    for k,v in pairs(loottable[10]) do
		        table.insert(loot, v)
		    end
		    for k,v in pairs(loottable[11]) do
		        table.insert(loot, v)
		    end
		end
		return loot
	end
end

function COverthrowGameMode:DropTempleItem( unit, reward, drop_type, buy_quality, artifact )
	local mythic_drop_chance = 30 --% for artifacts
	local normal_drop = true --normal drop or bought?
	local quest_completed = false
	local team_quest_reward = 0
	local drop_chance_factor = 1
	local act_specific_loot_factor = 1
	if unit and unit.drop_chance_factor then
		drop_chance_factor = drop_chance_factor * unit.drop_chance_factor
	end
	--if unit and unit.act and unit.act == 7 then
	--	mythic_drop_chance = mythic_drop_chance * 2
	--end
	--if unit and unit.act and unit.act == 13 then
	--	mythic_drop_chance = mythic_drop_chance * 2
	--end
	if unit and unit.loot_goblin_artifact_factor then
		mythic_drop_chance = mythic_drop_chance * unit.loot_goblin_artifact_factor
	end
	--if unit and unit.act_specific_loot_factor then
	--	act_specific_loot_factor = unit.act_specific_loot_factor
	--end

	--quests
	if unit.main_quest_boss then
		if not self.main_quests_completed then
			self.main_quests_completed = 0
		end
		self.main_quests_completed = self.main_quests_completed + 1
		drop_chance_factor = drop_chance_factor * 15 * self.main_quests_completed
		if unit.main_quest_boss == 1 then
			Notifications:BottomToAll({text="Quest completed: Retrieving the Essence of the Forest", duration=12, style={color="lightgreen"}})
		end
		if unit.main_quest_boss == 2 then
			Notifications:BottomToAll({text="Quest completed: Retrieving the Essence of the Desert", duration=12, style={color="lightgreen"}})
		end
		if unit.main_quest_boss == 3 then
			Notifications:BottomToAll({text="Quest completed: Retrieving the Essence of Water", duration=12, style={color="lightgreen"}})
		end
		if unit.main_quest_boss == 4 then
			Notifications:BottomToAll({text="Quest completed: Retrieving the Essence of the Shadow", duration=12, style={color="lightgreen"}})
		end
		if unit.main_quest_boss == 5 then
			Notifications:BottomToAll({text="Quest completed: Retrieving the Essence of the Sky", duration=12, style={color="lightgreen"}})
		end
		if unit.main_quest_boss == 6 then
			Notifications:BottomToAll({text="Quest completed: Retrieving the Essence of the Mountain", duration=12, style={color="lightgreen"}})
		end
		if unit.main_quest_boss == 7 then
			Notifications:BottomToAll({text="Quest completed: Retrieving the Essence of the Underworld", duration=12, style={color="lightgreen"}})
		end
		if unit.main_quest_boss == 8 then
			Notifications:BottomToAll({text="Quest completed: Retrieving the Essence of Fire", duration=12, style={color="lightgreen"}})
		end
		if unit.main_quest_boss == 9 then
			Notifications:BottomToAll({text="Quest completed: Retrieving the Essence of Power", duration=12, style={color="lightgreen"}})
		end
		if unit.main_quest_boss == 10 then
			Notifications:BottomToAll({text="Quest completed: Retrieving the Essence of Magic", duration=12, style={color="lightgreen"}})
		end
		if unit.main_quest_boss == 11 then
			Notifications:BottomToAll({text="Quest completed: Defeating the Warden of the Temple", duration=12, style={color="lightgreen"}})
		end
		if unit.main_quest_boss == 12 then
			Notifications:BottomToAll({text="Quest completed: Defeating the King of the Jungle", duration=12, style={color="lightgreen"}})
		end
		if unit.main_quest_boss == 13 then
			Notifications:BottomToAll({text="Quest completed: Reviving Cain's daughters", duration=12, style={color="lightgreen"}})
		end
		if unit.main_quest_boss == 16 then
			Notifications:BottomToAll({text="Quest completed: Defending Castle Winterwall", duration=12, style={color="lightgreen"}})
		end
		Notifications:BottomToAll({text="Reward: "..(15*self.main_quests_completed).."x improved drop chances for this Monster's loot.", duration=12, style={color="lightgreen"}})
		EmitGlobalSound("valve_dota_001.stinger.dire_win")
		--COverthrowGameMode:MainQuestVoice()
	end
	--merge titan bosses
	if unit.is_merge_boss then
		if not self.main_quests_completed then
			--fix for tests
			self.main_quests_completed = 1
		end
		drop_chance_factor = drop_chance_factor * 15 * self.main_quests_completed
		Notifications:BottomToAll({text=""..(15*self.main_quests_completed).."x improved drop chances for this Monster's loot.", duration=12, style={color="lightgreen"}})
		EmitGlobalSound("valve_dota_001.stinger.dire_win")
	end

	if drop_type == 2 then -- 1 = normal drop, 2 = bought item
		normal_drop = false
	end
	local spot = unit:GetAbsOrigin()
	local wasbosskill = false
	if reward >= 100 then
		wasbosskill = true
	end
	if normal_drop then
		CustomGameEventManager:Send_ServerToAllClients( "report_drop_chance", {value = unit.pvescale, boss = wasbosskill, mode = COverthrowGameMode.difficultyMode} )
	end
	local loot_table = GetAllItems(unit, false, true, act_specific_loot_factor)
	local loot_table_artifacts = GetAllArtifacts(unit, not normal_drop, false)
	--save for showing drop table
	self.last_drop_table_imm = loot_table
	self.last_drop_table_art_imm = loot_table_artifacts

	-- chance for drops
	local t8chance = 0
	local t7chance = 0
	local t6chance = 0
	local t5chance = 0
	local t4chance = 0
	local t3chance = 0
	local t2chance = 0
	local maxItemDropCount = 1
	if normal_drop then
		t8chance = 0.00005 * 100 * unit.pvescale * drop_chance_factor --0.00005 myth
		t7chance = 0.0005 * 100 * unit.pvescale * drop_chance_factor --0.0005 divine
		t6chance = 0.03 * 100 * unit.pvescale * drop_chance_factor --immortal
		t5chance = 0.15 * 100 * unit.pvescale * drop_chance_factor --1 legendary
		t4chance = 0.75 * 100 * unit.pvescale * drop_chance_factor --3 epic
		t3chance = 3 * 100 * unit.pvescale * drop_chance_factor -- 10 blue
		t2chance = 10 * 100 * unit.pvescale * drop_chance_factor -- 25 green
		--bad drops for trash mobs
		local trash_discount = 10
		if not wasbosskill and false then --disabled 5.5, drop chance lowered instead
			t8chance = t8chance / trash_discount
			t7chance = t7chance / trash_discount
			t6chance = t6chance / trash_discount
			t5chance = t5chance / trash_discount
			t4chance = t4chance / trash_discount
			t3chance = t3chance / trash_discount
			t2chance = t2chance / trash_discount
		end
		if wasbosskill and COverthrowGameMode.jungledifficulty >= 5 then
			maxItemDropCount = 2
		end
	end
	--no t6 below 5
	if normal_drop and unit.pvescale < 5 then
		t6chance = 0
	end
	if normal_drop and COverthrowGameMode.jungledifficulty < 5 then
		t6chance = 0
	end
	--no t7 below 100
	if normal_drop and COverthrowGameMode.jungledifficulty < 100 then
		t7chance = 0
	end
	--no t8 below 200
	if normal_drop and COverthrowGameMode.jungledifficulty < 200 then
		t8chance = 0
	end
	
	
	
	--item was bought
	if not normal_drop then
		if buy_quality == 9 then
			t8chance = 10000
		end
		if buy_quality == 8 then
			t7chance = 10000
		end
		if buy_quality == 7 then
			t6chance = 10000
		end
		if buy_quality == 6 then
			t6chance = 10000
		end
		if buy_quality == 5 then
			t5chance = 10000
		end
		if buy_quality == 4 then
			t4chance = 10000
		end
		if buy_quality == 3 then
			t3chance = 10000
		end
		if buy_quality == 2 then
			t2chance = 10000
		end
		mythic_drop_chance = 0
		if artifact then
			mythic_drop_chance = 100
		end
	end
	
	-- roll for each allied player
	local all = HeroList:GetAllHeroes()
	local delay = 1 -- -1    4.8
	if not normal_drop then
		delay = 3.2
	end
	local max_boss_kills = 0
	local best_drop = 0
	--local divine_non_artifact_drop = false
	--[[
	--gold drop?
	local gold_drop = 0.0
	local dust_drop = -1
	if normal_drop and reward >= 100 and unit.pvescale and not unit.nobosskill and not loot_goblin then
		--print(GetTotalBossKills())
		if GetTotalBossKills() > 0 and (GetTotalBossKills() % 6) == 0 then --self.templebossgoldcounter >= 6 then
			gold_drop = 1 * unit.pvescale
			delay = delay + 5
			Timers:CreateTimer(2.5,function() 
				EmitSoundOn("abaddon_abad_lasthit_07", unit)
				Notifications:BottomToAll({text="Quest completed: Plundering", duration=9, style={color="yellow"}})
				if COverthrowGameMode.jungledifficulty < 50 then
					Notifications:BottomToAll({text=tostring(math.floor(gold_drop)).." Gold for each Hero", duration=9, style={color="yellow"}})
				else
					dust_drop = math.random(1,5)
					local player_name = all[dust_drop]
					if player_name then
						player_name = PlayerResource:GetPlayerName(player_name:GetPlayerID())
						Notifications:BottomToAll({text="1 Mythic Dust for "..player_name.." and "..tostring(math.floor(gold_drop)).." Gold for all other Heroes", duration=9, style={color="violet"}})
					else
						Notifications:BottomToAll({text=tostring(math.floor(gold_drop)).." Gold for each Hero [No Dust, Missing Player Penalty]", duration=9, style={color="yellow"}})
					end
				end
			end)
			if gold_drop < 0.0 then
				gold_drop = 0.0
			end
			if gold_drop > 500 then
				gold_drop = 500
			end
		end
	end
	if loot_goblin then
		gold_drop = math.random(4,30) * unit.pvescale
		delay = delay + 5
		Timers:CreateTimer(2.5,function()
			EmitSoundOn("abaddon_abad_lasthit_07", unit)
			Notifications:BottomToAll({text="A mighty treasure was found!", duration=6, style={color="yellow"}})
			Notifications:BottomToAll({text=tostring(math.floor(gold_drop)).." Gold for each Hero", duration=6, style={color="yellow"}})
		end)
		if gold_drop < 0.0 then
			gold_drop = 0.0
		end
		if gold_drop > 500 then
			gold_drop = 500
		end
	end
	]]
	local i = 1
	for itemDropCount = 1, maxItemDropCount do
		Timers:CreateTimer(0.05 + (itemDropCount - 1) * 3.25 * (#all),function()
			for i=1, #all do
				local hero = all[i]
				--does an item drop?
				local finalDropChance = reward * 100
				if normal_drop then
					finalDropChance = finalDropChance * GetDifficultyModeDropChanceFactor()
				end
				if math.random(1,10000) <= finalDropChance then
					--skip heroes when item was bought
					if normal_drop or ( not normal_drop and hero == unit ) then
						local spawnedItem = ""
						local itemdrop = false
						local lootquality = 1
						local fxpath = ""
						local fxpath_ray = nil
						-- pick the item we're giving them
						local roll = math.random(1,10000)
						--new: chance to not drop items, but increased drop quality, patch 4.3.1, --removed 5.0
						if normal_drop and math.random(1,100) <= 0 then
							itemdrop = false
						else
							if roll <= t8chance then --mythical
								local mythicalItems = COverthrowGameMode:GetLootTableByItemQuality( GetAllItems(unit, false, true, act_specific_loot_factor), 13)
								spawnedItem = mythicalItems[math.random(1, #mythicalItems)]
								itemdrop = true
								lootquality = 8
								if lootquality > best_drop then
									best_drop = lootquality
								end
								fxpath = "particles/item_quality_mythical.vpcf"
								fxpath_ray = "particles/units/heroes/hero_enigma/enigma_blackhole.vpcf"
								--Timers:CreateTimer(3.0,function() 
								--	EmitGlobalSound("abaddon_abad_respawn_06")
								--end)
							elseif roll <= t7chance then --divine
								local divineItems = COverthrowGameMode:GetLootTableByItemQuality( GetAllItems(unit, false, true, act_specific_loot_factor), 12)
								spawnedItem = divineItems[math.random(1, #divineItems)]
								itemdrop = true
								lootquality = 7
								if lootquality > best_drop then
									best_drop = lootquality
								end
								fxpath = "particles/item_quality_divine.vpcf"
								fxpath_ray = "particles/econ/items/enigma/enigma_world_chasm/enigma_blackhole_ti5.vpcf"
								--Timers:CreateTimer(3.0,function() 
								--	EmitGlobalSound("abaddon_abad_respawn_06")
								--end)
							elseif roll <= t6chance then --immortal
								local immortal_item_level = 8
								if self.jungledifficulty == 10 then
									immortal_item_level = 9
								end
								if self.jungledifficulty == 20 then
									immortal_item_level = 10
								end
								if self.jungledifficulty >= 50 then
									immortal_item_level = 11
								end
								local immortalItems = COverthrowGameMode:GetLootTableByItemQuality( GetAllItems(unit, false, true, act_specific_loot_factor), immortal_item_level)
								spawnedItem = immortalItems[math.random(1, #immortalItems)]
								itemdrop = true
								lootquality = 6
								if lootquality > best_drop then
									best_drop = lootquality
								end
								fxpath = "particles/item_quality_immortal_new.vpcf"
								fxpath_ray = "particles/invoker_sun_strike_team_big_ray_legendary_long.vpcf"
								EmitGlobalSound("abaddon_abad_immort_01")
								Timers:CreateTimer(3.0,function() 
									EmitGlobalSound("abaddon_abad_respawn_06")
								end)
								--new material drop chance
								if COverthrowGameMode.jungledifficulty >= 100 and hero and hero.combat_system_ability then
									if unit.act and unit.act == 12 and math.random(1,100) <= 50 then
										--local gold = 50 * COverthrowGameMode.jungledifficulty
										--Notifications:Top(hero:GetPlayerID(), {text="Quest completed: Jungle Villain", duration=10, style={color="orange"}})
										--Notifications:Top(hero:GetPlayerID(), {text= gold .. " Gold as a reward for killing this Villain!", duration=10, style={color="orange"}})
										EmitGlobalSound("DOTA_Item.HavocHammer.Cast")
										Notifications:Top(hero:GetPlayerID(), {text="You received 1 Badge of Honor! Use it at the Molten Force to get a 50% Crafting Discount!", duration=5, style={color="orange"}})
										ApplyBuffStack({caster = hero, target = hero, ability = hero.combat_system_ability, dur = -1, addstacks = 1, buff = "modifier_jungle_token", alwaysapply = 1})
									end
									if unit.act and unit.act == 13 and math.random(1,100) <= 100 then
										EmitGlobalSound("DOTA_Item.HavocHammer.Cast")
										Notifications:Top(hero:GetPlayerID(), {text="You received 1 Badge of Honor! Use it at the Molten Force to get a 50% Crafting Discount!", duration=5, style={color="orange"}})
										ApplyBuffStack({caster = hero, target = hero, ability = hero.combat_system_ability, dur = -1, addstacks = 1, buff = "modifier_jungle_token", alwaysapply = 1})
									end
								end
							elseif roll <= t5chance then --legendary
								print("legendary drop")
								local immortal_item_level = 6
								if self.jungledifficulty >= 2 then
									immortal_item_level = 7
								end
								local legendaryItems = COverthrowGameMode:GetLootTableByItemQuality( GetAllItems(unit, false, true, act_specific_loot_factor), immortal_item_level)
								spawnedItem = legendaryItems[math.random(1, #legendaryItems)]
								itemdrop = true
								lootquality = 5
								if lootquality > best_drop then
									best_drop = lootquality
								end
								fxpath = "particles/item_quality_legendary.vpcf"
								fxpath_ray = "particles/invoker_sun_strike_team_big_ray_immortal1_long.vpcf"
								EmitGlobalSound("abaddon_abad_borrowedtime_01")
								Timers:CreateTimer(2.0,function() 
									EmitGlobalSound("abaddon_abad_levelup_04")
								end)
							elseif roll <= t4chance then -- epic
								local epicItems = COverthrowGameMode:GetLootTableByItemQuality( GetAllItems(unit, false, true, act_specific_loot_factor), 4)
								spawnedItem = epicItems[math.random(1, #epicItems)]
								itemdrop = true
								lootquality = 4
								if lootquality > best_drop then
									best_drop = lootquality
								end
								fxpath = "particles/item_quality_epic.vpcf"
							elseif roll <= t3chance then --rare
								local rareItems = COverthrowGameMode:GetLootTableByItemQuality( GetAllItems(unit, false, true, act_specific_loot_factor), 3)
								spawnedItem = rareItems[math.random(1, #rareItems)]
								itemdrop = true
								lootquality = 3
								if lootquality > best_drop then
									best_drop = lootquality
								end
								fxpath = "particles/item_quality_rare.vpcf"
							elseif roll <= t2chance then --common
								local uncommonItems = COverthrowGameMode:GetLootTableByItemQuality( GetAllItems(unit, false, true, act_specific_loot_factor), 2)
								spawnedItem = uncommonItems[math.random(1, #uncommonItems)]
								itemdrop = true
								lootquality = 2
								if lootquality > best_drop then
									best_drop = lootquality
								end
								fxpath = "particles/item_quality_green.vpcf"
							else --white
								local commonItems = COverthrowGameMode:GetLootTableByItemQuality( GetAllItems(unit, false, true, act_specific_loot_factor), 1)
								spawnedItem = commonItems[math.random(1, #commonItems)]
								itemdrop = true
								lootquality = 1
							end
							--new drop lights here
							--screen fx best drop
							if reward >= 100 or loot_goblin then
								if best_drop >= 8 then --and divine_non_artifact_drop then
									PopupKillbanner(unit, "doublekill")
								elseif best_drop >= 7 then
									PopupKillbanner(unit, "rampage_flames")
								elseif best_drop >= 6 then
									PopupKillbanner(unit, "rampage_g")
								elseif best_drop >= 5 then
									PopupKillbanner(unit, "rampage")
								elseif best_drop > 0 then
									PopupKillbanner(unit, "triplekill_flare_d")
								end
							end
						end
						
						--autosell feature
						if hero and COverthrowGameMode:IsAutoSellForTempleItem(hero, lootquality, spawnedItem) then
							itemdrop = false
							COverthrowGameMode:AutoSellTempleItem(hero, lootquality, spawnedItem, false)
						end

						--boss kill, update kill stats, update quests,  heal and screen sparks
						if normal_drop and wasbosskill and itemDropCount == 1 then
							--heal
							if all[i]:IsAlive() then
								all[i]:SetHealth(all[i]:GetHealth()+all[i]:GetMaxHealth()*0.5)
								all[i]:SetMana(all[i]:GetMana()+all[i]:GetMaxMana()*0.5)
							end
							local particle = ParticleManager:CreateParticle("particles/items2_fx/mekanism.vpcf", PATTACH_POINT_FOLLOW, all[i])
							ParticleManager:ReleaseParticleIndex(particle)
							if hero.bosskills then
								local boss_kill_factor = 1
								if unit and unit.boss_kill_factor then
									boss_kill_factor = unit.boss_kill_factor
								end
								if not hero.templepermadead and not unit.nobosskill then
									hero.bosskills = hero.bosskills + 1 * boss_kill_factor
								end
							else
								if unit.nobosskill then
									hero.bosskills = 0
								else
									hero.bosskills = 1
								end
							end
							--report new boss kill highscore stats
							if hero.bosskills >= max_boss_kills then
								self:ReportBossKills(hero.bosskills)
								max_boss_kills = hero.bosskills
							end
						end
						-- add the item to the inventory and broadcast
						if itemdrop then
							--artifact or normal item?
							local normal_item = false
							if lootquality < 4 or (math.random(1,100) > mythic_drop_chance and lootquality >= 4) then
								normal_item = true
							end
							if lootquality == 8 then
				        		EmitGlobalSound("abaddon_abad_purch_03")
				        	end
							if lootquality == 7 then
				        		--divine_non_artifact_drop = true
				        		EmitGlobalSound("omniknight_omni_regen_02")
				        	end
							if not normal_drop then
								--save hero so u cant abuse gold
								self:SaveChar(hero)
								EmitSoundOn("DOTA_Item.Hand_Of_Midas", hero)
							end
							delay = delay + 3
							Timers:CreateTimer(delay,function() 
								if lootquality >= 4 then
					        		local particle = ParticleManager:CreateParticle("particles/econ/events/ti6/hero_levelup_ti6_flash_hit_magic.vpcf", PATTACH_POINT_FOLLOW, all[i])
					        		ParticleManager:DestroyParticle(particle, false)
					        		ParticleManager:ReleaseParticleIndex(particle)
					        	end
						        local item
						        if normal_item then
						        	--print(spawnedItem)
						        	-- normal item drop, not artifact
							        if all[i]:GetNumItemsInInventory() >= 6 then --and all[i]:GetNumItemsInStash() >= 6 then
							        	item = CreateItem(spawnedItem, hero, hero)
							        	item.isItemDroppedThisSession = true
							        	local item2 = CreateItemOnPositionSync(spot, item)
							        	local particle3 = ParticleManager:CreateParticle( "particles/econ/items/alchemist/alchemist_midas_knuckles/alch_knuckles_lasthit_coins.vpcf", PATTACH_CUSTOMORIGIN, hero)
										ParticleManager:SetParticleControl(particle3, 1, spot)
										ParticleManager:DestroyParticle(particle3, false)
										ParticleManager:ReleaseParticleIndex(particle3)
							        	Timers:CreateTimer(0.1,function()
								        	if item and not item:IsNull() then
								        		--item:GetContainer():SetAbsOrigin(spot)
								        		local offset_y = math.random(65,125)
								        		local offset_x = math.random(-75,75)
								        		local itemContainer = item:GetContainer()
									        	item:LaunchLoot(false, 125, 0.9, all[i]:GetAbsOrigin()+Vector(offset_x,-offset_y,0), nil)
									        	local particle2 = ParticleManager:CreateParticle("particles/units/heroes/hero_omniknight/omniknight_purification_d_glow.vpcf", PATTACH_POINT_FOLLOW, itemContainer)
										        -- Destroy & release item particle on item pickup
												Timers:CreateTimer(1,function()
													if(itemContainer == nil or itemContainer:IsNull()) then
														ParticleManager:DestroyParticle(particle2, true)
														ParticleManager:ReleaseParticleIndex(particle2)
														return
													end
													return 1
												end)
									        	Timers:CreateTimer(0.95,function() 
										        	if lootquality > 1 then
										        		local particle = ParticleManager:CreateParticle(fxpath, PATTACH_POINT_FOLLOW, itemContainer)
										        		-- Destroy & release item particle on item pickup
														Timers:CreateTimer(1,function()
															if(itemContainer == nil or itemContainer:IsNull()) then
																ParticleManager:DestroyParticle(particle, true)
																ParticleManager:ReleaseParticleIndex(particle)
																return
															end
															return 1
														end)
										        		if fxpath_ray then
										        			local itemContainer = item:GetContainer()
										        			-- Destroy & release ray particle on item pickup
										        			local rayParticle = ParticleManager:CreateParticle(fxpath_ray, PATTACH_POINT_FOLLOW, itemContainer)
										        			Timers:CreateTimer(1,function()
																if(itemContainer == nil or itemContainer:IsNull()) then
																	ParticleManager:DestroyParticle(rayParticle, true)
																	ParticleManager:ReleaseParticleIndex(rayParticle)
																	return
																end
																return 1
										        			end)
										        		end
										        	end
										        end)
									        end
								        end)
							        else
							        	item = all[i]:AddItemByName( spawnedItem )
							        	Timers:CreateTimer(0.95,function() 
								        	if lootquality > 1 then
								        		if fxpath_ray then
								        			local div_particle = ParticleManager:CreateParticle(fxpath_ray, PATTACH_POINT_FOLLOW, all[i])
								        			Timers:CreateTimer(4,function() 
								        				ParticleManager:DestroyParticle(div_particle,true)
								        				ParticleManager:ReleaseParticleIndex(div_particle)
								        			end)
								        		end
								        	end
								        end)
							        end
							    else
							    	-- artifact drop
							    	spawnedItem = loot_table_artifacts[4][math.random(1,#loot_table_artifacts[4])]
							    	if lootquality == 5 then
							    		spawnedItem = loot_table_artifacts[5][math.random(1,#loot_table_artifacts[5])]
							    	end
							    	if lootquality == 6 then --immo or better = immo or ancient immo
							    		spawnedItem = loot_table_artifacts[8][math.random(1,#loot_table_artifacts[8])]
							    		if math.random(1,100) <= 50 and COverthrowGameMode.jungledifficulty >= 20 then
							    			spawnedItem = loot_table_artifacts[10][math.random(1,#loot_table_artifacts[10])]
							    		end
							    	end
							    	if lootquality == 7 then --immo or better = immo or ancient immo
							    		spawnedItem = loot_table_artifacts[12][math.random(1,#loot_table_artifacts[12])]
							    	end
							    	if lootquality == 8 then --immo or better = immo or ancient immo
							    		spawnedItem = loot_table_artifacts[13][math.random(1,#loot_table_artifacts[13])]
							    	end
							    	--buying immortal or ancient immortal
							    	if not normal_drop and buy_quality == 6 then
										spawnedItem = loot_table_artifacts[8][math.random(1,#loot_table_artifacts[10])]
									end
							    	if not normal_drop and buy_quality == 7 then
										spawnedItem = loot_table_artifacts[10][math.random(1,#loot_table_artifacts[10])]
									end
									if not normal_drop and buy_quality == 8 then
										spawnedItem = loot_table_artifacts[12][math.random(1,#loot_table_artifacts[12])]
									end
									if not normal_drop and buy_quality == 9 then
										spawnedItem = loot_table_artifacts[13][math.random(1,#loot_table_artifacts[13])]
									end

									-- Auto sell dropped and rerolled artifacts if required
									if(normal_drop and not item) then
										if(COverthrowGameMode:IsAutoSellForTempleItem(hero, lootquality, spawnedItem)) then
											COverthrowGameMode:AutoSellTempleItem(hero, lootquality, spawnedItem, true)
										else
											self:CreateMythicWeapon(hero, spawnedItem, false, 0, 0 ,0, normal_drop)
										end
									else
										-- If somebody buying artifact then gives it to him
										self:CreateMythicWeapon(hero, spawnedItem, false, 0, 0 ,0, normal_drop)
									end
							    end

						        if item and not item:IsNull() then
						        	item.droppedthisgame = true
						        	--track dropped items
						        	hero.lasttempledrop_2 = hero.lasttempledrop_1
						        	hero.lasttempledrop_1 = item

						        	item:SetPurchaseTime(GameRules:GetGameTime()-20.0)
						        	local sellvalue = GetSellValueByItemLevel(lootquality) --math.floor(item:GetCost() / 200.0)
						        	if sellvalue < 1 then
						        		sellvalue = 1
						        	end
						        	local player = PlayerResource:GetPlayer(hero:GetPlayerID())
						        	local itemname = string.sub(spawnedItem, 6)
						        	--tototo
						        	AddItemToSellList( hero, player, item, -1, sellvalue, lootquality )
						        end
								
								if lootquality >= 6 and normal_item then
									EmitSoundOn("DOTA_Item.EtherealBlade.Target", all[i])
								elseif lootquality >= 6 then
									PopupKillbanner(hero, "rampage_g")
									COverthrowGameMode:ThunderEffectAndSound(hero)
								elseif lootquality == 5 then
									if self.jungledifficulty <= 5.0 then
										EmitGlobalSound("DOTA_Item.DoE.Activate")
									end
								elseif lootquality == 4 then
									if self.jungledifficulty <= 5.0 then
										EmitGlobalSound("DOTA_Item.DustOfAppearance.Activate")
									end
								else
									if self.jungledifficulty <= 5.0 then
										EmitGlobalSound("DOTA_Item.Hand_Of_Midas")
									end
								end
								local overthrow_item_drop =
								{
									hero_id = all[i]:GetClassname(),
									dropped_item = spawnedItem
								}
								if normal_item then
									CustomGameEventManager:Send_ServerToAllClients( "overthrow_item_drop", overthrow_item_drop )
								end
						    end)
						end
					end
				end
			end
		end)
	end
end

function COverthrowGameMode:IsAutoSellForTempleItem(hero, lootquality, spawnedItem)
	local itemdrop = string.sub(spawnedItem, 1, string.len("item_")) == "item_"
	local artifact = true
	local isAutoSell = false
	
	if(itemdrop == true) then
		artifact = false
	end

	local autoSellItems = hero.autosell
	if(autoSellItems == nil) then
		autoSellItems = 0
	end

	local autoSellArti = hero.autosellArti
	if(autoSellArti == nil) then
		autoSellArti = 0
	end

	local autoSellSpecial = hero.autosellSpecial
	if(autoSellSpecial == nil) then
		autoSellSpecial = 0
	end

	if(artifact) then
		-- Auto Sell: Epic Artifacts and below
		if(autoSellArti == 2) then
			isAutoSell = lootquality <= 4
		end
		-- Auto Sell: Legendary Artifacts and below
		if(autoSellArti == 4) then
			isAutoSell = lootquality <= 5
		end
		-- Auto Sell: Immortal Artifacts and below
		if(autoSellArti == 6) then
			isAutoSell = lootquality <= 6
		end
		-- Auto Sell: Divine Artifacts and below
		if(autoSellArti == 8) then
			isAutoSell = lootquality <= 7
		end
		-- Auto Sell: Mythical Artifacts and below
		if(autoSellArti == 10) then
			isAutoSell = lootquality <= 8
		end
	else
		if(itemdrop) then
			local isSoulDrop = string.sub(spawnedItem, 1, string.len("item_mastery_")) == "item_mastery_"

			-- Don't Auto Sell Souls and Temple Shard
			local isSoulProtected = true
			if(isSoulDrop and (autoSellSpecial == 0 or autoSellSpecial == 2)) then
				isSoulProtected = false
			end

			local isTempleShardDrop = spawnedItem == "item_set_t2_combine_token"
			local isTempleShardProtected = true

			-- Auto Sell: Temple Shard
			if(isTempleShardDrop and specialItemsFilter == 0) then
				isTempleShardProtected = false
			end

			local isSpecialItemProtected = isSoulProtected and isTempleShardProtected

			-- Auto Sell: Common Items and below
			if(autoSellItems == 2) then
				isAutoSell = lootquality <= 1 and isSpecialItemProtected
			end
			-- Auto Sell: Uncommon Items and below
			if(autoSellItems == 4) then
				isAutoSell = lootquality <= 2 and isSpecialItemProtected
			end
			-- Auto Sell: Rare Items and below
			if(autoSellItems == 6) then
				isAutoSell = lootquality <= 3 and isSpecialItemProtected
			end
			-- Auto Sell: Epic Items and below
			if(autoSellItems == 8) then
				isAutoSell = lootquality <= 4 and isSpecialItemProtected
			end
			-- Auto Sell: Legendary Items and below
			if(autoSellItems == 10) then
				isAutoSell = lootquality <= 5 and isSpecialItemProtected
			end
			-- Auto Sell: Immortal Items and below
			if(autoSellItems == 12) then
				isAutoSell = lootquality <= 6 and isSpecialItemProtected
			end
			-- Auto Sell: Divine Items and below
			if(autoSellItems == 14) then
				isAutoSell = lootquality <= 7 and isSpecialItemProtected
			end
			-- Auto Sell: Mythical Items and below
			if(autoSellItems == 16) then
				isAutoSell = lootquality <= 8 and isSpecialItemProtected
			end
		end
	end

	return isAutoSell
end

function COverthrowGameMode:AutoSellTempleItem(hero, lootQuality, spawnedItem, isArtifact)
	local gold = GetSellValueByItemLevel(lootQuality)

	if(isArtifact) then
		gold = GetSellValueByArtifactLevel(lootQuality)
	end

	EmitSoundOn("DOTA_Item.Hand_Of_Midas", hero)
	local particle = ParticleManager:CreateParticle( "particles/econ/items/alchemist/alchemist_midas_knuckles/alch_knuckles_lasthit_coins.vpcf", PATTACH_CUSTOMORIGIN, hero)
	ParticleManager:SetParticleControl(particle, 1, hero:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(particle)
	--hero:SetGold(hero:GetGold()+gold, true)
	--hero:SetGold(0, false)
	AddGold(hero, gold)

	-- Artifacts not supported for now
	if(isArtifact == false) then
		COverthrowGameMode:AddAutoSoldItemToStash(hero, lootQuality, spawnedItem, gold)
	end
end

function COverthrowGameMode:AddAutoSoldItemToStash(hero, lootQuality, spawnedItem, gold)
	local playerId = hero:GetPlayerID()

	if(COverthrowGameMode._autoSellStash == nil) then
		COverthrowGameMode._autoSellStash = {}
	end

	if(COverthrowGameMode._autoSellStash[playerId] == nil) then
		COverthrowGameMode._autoSellStash[playerId] = {}
	end

	-- I hope that "Generate a string guaranteed to be unique across the life of the script VM" will be really unique
	local key = DoUniqueString(tostring(playerId).."_autoSellStash")
	COverthrowGameMode._autoSellStash[playerId][key] = {
		itemName = spawnedItem,
		gold = gold
	}

	-- Check for disconnected guys
	local player = PlayerResource:GetPlayer(playerId)

	if(player ~= nil) then
		CustomGameEventManager:Send_ServerToPlayer(player, "auto_sell_stash_item", {
			key = key,
			item = COverthrowGameMode._autoSellStash[playerId][key]
		})
	end
end

function COverthrowGameMode:SendAutoSoldStashItems(player, playerId)
	if(COverthrowGameMode._autoSellStash == nil) then
		return
	end

	if(COverthrowGameMode._autoSellStash[playerId] == nil) then
		return
	end

	for key, itemData in pairs(COverthrowGameMode._autoSellStash[playerId]) do
		CustomGameEventManager:Send_ServerToPlayer(player, "auto_sell_stash_item", {
			key = key,
			item = itemData
		})
	end
end

function COverthrowGameMode:BuyItemFromAutoSellStash(params)
	local playerId = params["player_id"]
	local player = PlayerResource:GetPlayer(playerId)
  
	-- Disconnected player or broken request
	if(player == nil) then
	  return
	end
  
	local key = params["key"]

	if(COverthrowGameMode._autoSellStash == nil) then
		Notifications:Bottom(playerId, {text="Can't find auto sell stash. Report this please.", duration=5, style={color="red"}})
		return
	end

	if(COverthrowGameMode._autoSellStash[playerId] == nil) then
		Notifications:Bottom(playerId, {text="Can't find auto sell stash for this player. Report this please.", duration=5, style={color="red"}})
		return
	end

	if(COverthrowGameMode._autoSellStash[playerId][key] == nil) then
		Notifications:Bottom(playerId, {text="Can't find item in auto sell stash. Report this please.", duration=5, style={color="red"}})
		return
	end

	local hero = PlayerResource:GetSelectedHeroEntity(playerId)
  
	if(hero == nil) then
	  return
	end

    if hero:IsHero() then
        local cost = COverthrowGameMode._autoSellStash[playerId][key].gold
        if TryPayGold(hero, cost) then
			local itemname = COverthrowGameMode._autoSellStash[playerId][key].itemName
            local spot = hero:GetAbsOrigin() + Vector(0,-65,0)
            local item = CreateItem(itemname, hero, hero)
			item.isItemDroppedThisSession = true
            local item2 = CreateItemOnPositionSync(spot, item)
            local particle3 = ParticleManager:CreateParticle( "particles/econ/items/alchemist/alchemist_midas_knuckles/alch_knuckles_lasthit_coins.vpcf", PATTACH_CUSTOMORIGIN, hero)
            ParticleManager:SetParticleControl(particle3, 1, spot)
            ParticleManager:ReleaseParticleIndex(particle3)
            EmitSoundOn("DOTA_Item.Hand_Of_Midas", hero)
            Notifications:Bottom(playerId, {text="Item Purchased!", duration=5, style={color="yellow"}})

			CustomGameEventManager:Send_ServerToPlayer(player, "buyautosellstashitemresponse", {
				key = key
			})
        else
            Notifications:Bottom(playerId, {text="Not enough Gold!", duration=5, style={color="red"}})
        end
    end
end

function COverthrowGameMode:ThunderEffectAndSound(hero)
	local smokepart = ParticleManager:CreateParticle("particles/econ/items/crystal_maiden/crystal_maiden_cowl_of_ice/maiden_crystal_nova_cowlofice.vpcf", PATTACH_CUSTOMORIGIN, hero)
	ParticleManager:SetParticleControl(smokepart, 0, hero:GetAbsOrigin())
	ParticleManager:SetParticleControl(smokepart, 1, Vector(900,1,900))
	ParticleManager:ReleaseParticleIndex(smokepart)
	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_zuus/zuus_thundergods_wrath_start.vpcf", PATTACH_POINT_FOLLOW, hero)
	ParticleManager:SetParticleControl(particle, 0, hero:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 1, hero:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 2, hero:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 3, hero:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(particle)
	particle = ParticleManager:CreateParticle("particles/units/heroes/hero_disruptor/disruptor_thunder_strike_aoe.vpcf", PATTACH_POINT_FOLLOW, hero)
	ParticleManager:ReleaseParticleIndex(particle)
	particle = ParticleManager:CreateParticle("particles/econ/items/zeus/lightning_weapon_fx/zuus_lightning_bolt_castfx_ground2.vpcf", PATTACH_POINT_FOLLOW, hero)
	ParticleManager:ReleaseParticleIndex(particle)
	--EmitSoundOn("DOTA_Item.Mjollnir.Activate", hero)
	EmitSoundOn("Hero_Razor.Storm.Cast", hero)
	if true then
		return
	end
	Timers:CreateTimer(0.4,function()
		EmitSoundOn("DOTA_Item.Mjollnir.Activate", hero)
		particle = ParticleManager:CreateParticle("particles/units/heroes/hero_disruptor/disruptor_thunder_strike_bolt.vpcf", PATTACH_POINT_FOLLOW, hero)
    	ParticleManager:SetParticleControl(particle, 0, hero:GetAbsOrigin())
		ParticleManager:SetParticleControl(particle, 1, hero:GetAbsOrigin())
		ParticleManager:SetParticleControl(particle, 2, hero:GetAbsOrigin())
		ParticleManager:SetParticleControl(particle, 3, hero:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(particle)
	end)
	Timers:CreateTimer(0.6,function()
		EmitSoundOn("DOTA_Item.Mjollnir.Activate", hero)
		particle = ParticleManager:CreateParticle("particles/units/heroes/hero_disruptor/disruptor_thunder_strike_bolt.vpcf", PATTACH_POINT_FOLLOW, hero)
    	ParticleManager:SetParticleControl(particle, 0, hero:GetAbsOrigin())
		ParticleManager:SetParticleControl(particle, 1, hero:GetAbsOrigin())
		ParticleManager:SetParticleControl(particle, 2, hero:GetAbsOrigin())
		ParticleManager:SetParticleControl(particle, 3, hero:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(particle)
	end)
	Timers:CreateTimer(0.8,function()
		EmitSoundOn("DOTA_Item.Mjollnir.Activate", hero)
		particle = ParticleManager:CreateParticle("particles/units/heroes/hero_zuus/zuus_thundergods_wrath_start.vpcf", PATTACH_POINT_FOLLOW, hero)
    	ParticleManager:SetParticleControl(particle, 0, hero:GetAbsOrigin())
		ParticleManager:SetParticleControl(particle, 1, hero:GetAbsOrigin())
		ParticleManager:SetParticleControl(particle, 2, hero:GetAbsOrigin())
		ParticleManager:SetParticleControl(particle, 3, hero:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(particle)
		particle = ParticleManager:CreateParticle("particles/econ/items/zeus/lightning_weapon_fx/zuus_lightning_bolt_castfx_ground2.vpcf", PATTACH_POINT_FOLLOW, hero)
		ParticleManager:ReleaseParticleIndex(particle)
	end)
	Timers:CreateTimer(1.2,function()
		EmitSoundOn("DOTA_Item.Mjollnir.Activate", hero)
		particle = ParticleManager:CreateParticle("particles/units/heroes/hero_disruptor/disruptor_thunder_strike_bolt.vpcf", PATTACH_POINT_FOLLOW, hero)
    	ParticleManager:SetParticleControl(particle, 0, hero:GetAbsOrigin())
		ParticleManager:SetParticleControl(particle, 1, hero:GetAbsOrigin())
		ParticleManager:SetParticleControl(particle, 2, hero:GetAbsOrigin())
		ParticleManager:SetParticleControl(particle, 3, hero:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(particle)
	end)
end

function COverthrowGameMode:ThinkSpecialItemDrop()
	-- Stop spawning items after 15
	if self.nNextSpawnItemNumber >= 15 then
		return
	end
	-- Don't spawn if the game is about to end
	if nCOUNTDOWNTIMER < 20 then
		return
	end
	local t = GameRules:GetDOTATime( false, false )
	local tSpawn = ( self.spawnTime * self.nNextSpawnItemNumber )
	local tWarn = tSpawn - 15
	
	if not self.hasWarnedSpawn and t >= tWarn then
		-- warn the item is about to spawn
		self:WarnItem()
		self.hasWarnedSpawn = true
	elseif t >= tSpawn then
		-- spawn the item
		self:SpawnItem()
		self.nNextSpawnItemNumber = self.nNextSpawnItemNumber + 1
		self.hasWarnedSpawn = false
	end
end

function COverthrowGameMode:PlanNextSpawn()
	local spawnPath =
	{
		"item_spawn_1",
		"item_spawn_2",
		"item_spawn_3",
		"item_spawn_4",
		"item_spawn_5",
		"item_spawn_6",
		"item_spawn_7",
		"item_spawn_8"
	}
	local missingSpawnPoint =
	{
		origin = "0 0 384",
		targetname = "item_spawn_missing"
	}

	local r = RandomInt( 1, #spawnPath )
	local path_track = spawnPath[ r ]
	local spawnPoint = Vector( 0, 0, 700 )
	local spawnLocation = Entities:FindByName( nil, path_track )

	if spawnLocation == nil then
		spawnLocation = SpawnEntityFromTableSynchronous( "path_track", missingSpawnPoint )
		spawnLocation:SetAbsOrigin(spawnPoint)
	end
	
	self.itemSpawnLocation = spawnLocation
	self.itemSpawnIndex = r
end

function COverthrowGameMode:WarnItem()
	-- find the spawn point
	self:PlanNextSpawn()

	local spawnLocation = self.itemSpawnLocation:GetAbsOrigin();

	-- notify everyone
	CustomGameEventManager:Send_ServerToAllClients( "item_will_spawn", { spawn_location = spawnLocation } )
	EmitGlobalSound( "powerup_03" )
	
	-- fire the destination particles
	DoEntFire( "item_spawn_particle_" .. self.itemSpawnIndex, "Start", "0", 0, self, self )

	-- Give vision to the spawn area (unit is on goodguys, but shared vision)
	local visionRevealer = CreateUnitByName( "npc_vision_revealer", spawnLocation, false, nil, nil, DOTA_TEAM_GOODGUYS )
	visionRevealer:SetContextThink( "KillVisionRevealer", function() return visionRevealer:RemoveSelf() end, 35 )
end

function COverthrowGameMode:SpawnItem()
	-- notify everyone
	CustomGameEventManager:Send_ServerToAllClients( "item_has_spawned", {} )
	EmitGlobalSound( "powerup_05" )

	-- spawn the item
	local startLocation = Vector( 0, 0, 700 )
	local treasureCourier = CreateUnitByName( "npc_dota_treasure_courier" , startLocation, true, nil, nil, DOTA_TEAM_BADGUYS )
	local treasureAbility = treasureCourier:FindAbilityByName( "dota_ability_treasure_courier" )
	treasureAbility:SetLevel( 1 )
    --print ("Spawning Treasure")
    targetSpawnLocation = self.itemSpawnLocation
    treasureCourier:SetInitialGoalEntity(targetSpawnLocation)
    --local particleTreasure = ParticleManager:CreateParticle( "particles/items_fx/black_king_bar_avatar.vpcf", PATTACH_ABSORIGIN, treasureCourier )
	--ParticleManager:SetParticleControlEnt( particleTreasure, PATTACH_ABSORIGIN, treasureCourier, PATTACH_ABSORIGIN, "attach_origin", treasureCourier:GetAbsOrigin(), true )
	--treasureCourier:Attribute_SetIntValue( "particleID", particleTreasure )
end

function COverthrowGameMode:ForceSpawnItem()
	self:WarnItem()
	self:SpawnItem()
end

function COverthrowGameMode:KnockBackFromTreasure( center, radius, knockback_duration, knockback_distance, knockback_height )
	local targetType = bit.bor( DOTA_UNIT_TARGET_CREEP, DOTA_UNIT_TARGET_HERO )
	local knockBackUnits = FindUnitsInRadius( DOTA_TEAM_NOTEAM, center, nil, radius, DOTA_UNIT_TARGET_TEAM_BOTH, targetType, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false )
 
	local modifierKnockback =
	{
		center_x = center.x,
		center_y = center.y,
		center_z = center.z,
		duration = knockback_duration,
		knockback_duration = knockback_duration,
		knockback_distance = knockback_distance,
		knockback_height = knockback_height,
	}

	for _,unit in pairs(knockBackUnits) do
--		print( "knock back unit: " .. unit:GetName() )
		unit:AddNewModifier( unit, nil, "modifier_knockback", modifierKnockback );
	end
end


function COverthrowGameMode:TreasureDrop( treasureCourier )
	--Create the death effect for the courier
	local spawnPoint = treasureCourier:GetInitialGoalEntity():GetAbsOrigin()
	spawnPoint.z = 400
	local fxPoint = treasureCourier:GetInitialGoalEntity():GetAbsOrigin()
	fxPoint.z = 400
	local deathEffects = ParticleManager:CreateParticle( "particles/treasure_courier_death.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl( deathEffects, 0, fxPoint )
	ParticleManager:SetParticleControlOrientation( deathEffects, 0, treasureCourier:GetForwardVector(), treasureCourier:GetRightVector(), treasureCourier:GetUpVector() )
	EmitGlobalSound( "lockjaw_Courier.Impact" )
	EmitGlobalSound( "lockjaw_Courier.gold_big" )

	--Spawn the treasure chest at the selected item spawn location
	local newItem = CreateItem( "item_treasure_chest", nil, nil )
	local drop = CreateItemOnPositionForLaunch( spawnPoint, newItem )
	drop:SetForwardVector( treasureCourier:GetRightVector() ) -- oriented differently
	newItem:LaunchLootInitialHeight( false, 0, 50, 0.25, spawnPoint )

	--Stop the particle effect
	DoEntFire( "item_spawn_particle_" .. self.itemSpawnIndex, "stopplayendcap", "0", 0, self, self )

	--Knock people back from the treasure
	self:KnockBackFromTreasure( spawnPoint, 375, 0.25, 400, 100 )
		
	--Destroy the courier
	UTIL_Remove( treasureCourier )
end

function COverthrowGameMode:ForceSpawnGold()
	--self:SpawnGold()
end

function GetTotalBossKills()
    local kills = 0
    for i=1,11 do
        if COverthrowGameMode.act_kills and COverthrowGameMode.act_kills[i] then
            kills = kills + COverthrowGameMode.act_kills[i]
        end
    end
    return kills
end

function AddItemToSellList( hero, player, weapondrop, number_attributes, weaponslot, quality )
	if hero.item_sell_list_index then
		hero.item_sell_list_index = hero.item_sell_list_index + 1
		if hero.item_sell_list_index > 1000000000 then
			hero.item_sell_list_index = 1
		end
	else
		hero.item_sell_list_index = 1
	end
	local index = hero.item_sell_list_index
	if not hero.item_sell_list then
		hero.item_sell_list = {}
	end
	local artifact = false
	if number_attributes and number_attributes > 0 then
		artifact = true
	end
	if artifact then
		hero.item_sell_list[index] = weapondrop
		CustomGameEventManager:Send_ServerToPlayer(player, "additemtoselllist", { sell_list_index = index, is_artifact = 1, item = weapondrop[1], itemname = weapondrop[0], attributes = number_attributes, stat1 = weapondrop[5], stat1name = weapondrop[8], stat2 = weapondrop[6], stat2name = weapondrop[9], stat3 = weapondrop[7], stat3name = weapondrop[10], ilevel = weapondrop[11], slot = weaponslot, rarity = quality, playerid = hero:GetUnitName(), weapontype = weapondrop[14] } )
	else
		hero.item_sell_list[index] = weapondrop
		CustomGameEventManager:Send_ServerToPlayer(player, "additemtoselllist", { sell_list_index = index, is_artifact = 0, item = weapondrop[1], itemname = weapondrop:GetName(), attributes = nil, stat1 = nil, stat1name = nil, stat2 = nil, stat2name = nil, stat3 = nil, stat3name = nil, ilevel = nil, slot = weaponslot, rarity = tostring(quality), playerid = hero:GetUnitName() } )
		--tototo
	end
end

function COverthrowGameMode:GetRandomDivineItem()
	local name = "item_pathbuff_0"
	local index = math.random(1,120) --math.random(1,COverthrowGameMode.maxtalents) no divines for new talents
	if index <= 9 then
		name = "item_pathbuff_00"
	end
	if index >= 100 then
		name = "item_pathbuff_"
	end
	name = name..index
	--if index ~= 51 and index ~= 54 and index ~= 57 and index ~= 60 and index ~= 75 then
	return name
	--else
	--	return COverthrowGameMode:GetRandomDivineItem()
	--end
end

function COverthrowGameMode:GetAllDivineItems()
	local items = {}
	for index=1, 120 do --COverthrowGameMode.maxtalents do
		local name = "item_pathbuff_0"
		if index <= 9 then
			name = "item_pathbuff_00"
		end
		if index >= 100 then
			name = "item_pathbuff_"
		end
		name = name..index
		--if index ~= 51 and index ~= 54 and index ~= 57 and index ~= 60 and index ~= 75 then
		table.insert(items, name)
		--end
	end
	return items
end

function COverthrowGameMode:MainQuestVoice()
	local sound
	sound = "treant_treant_levelup_03"
	if math.random(1,100) > 50 then
		sound = "treant_treant_regen_02"
	end
	EmitGlobalSound(sound)
end

function COverthrowGameMode:TestDropAllItems( hero )
	local items = GetAllItems({act = 1}, true, false, 1)
	for k, v in pairs( items ) do
		for k2, v2 in pairs( v ) do
			local item = CreateItem(v2, hero, hero)
			local item2 = CreateItemOnPositionSync(hero:GetAbsOrigin() + RandomVector(600), item)
			if v2 == nil or not item or not item2 then
				print("found bugged item")
			end
		end
	end
end

function COverthrowGameMode:TestDropAllArtifacts( hero, min_quality )
	local items = GetAllArtifacts({act = 1}, true, true)
	for k, v in pairs( items ) do
		for k2, v2 in pairs( v ) do
			if v2 == nil then
				--print("found bugged artifact")
			end
			if min_quality and tonumber(string.sub(v2, 5, 5)) and tonumber(string.sub(v2, 5, 5)) < min_quality then
				--skip
			else
				COverthrowGameMode:CreateMythicWeapon( hero, v2, false, 10, 10, 10, true )
			end
		end
	end
end

function GetSellValueByItemLevel( level )
	if level == 1 then
		return 1
	end
	if level == 2 then
		return 2
	end
	if level == 3 then
		return 3
	end
	if level == 4 then
		return 10
	end
	if level == 5 then
		return 50
	end
	if level == 6 then
		return 125
	end
	if level == 7 then
		return 250
	end
	if level == 8 then
		return 500
	end
	return 1
end

function GetSellValueByArtifactLevel( level )
	if level == 1 then -- common, not exists
		return 1
	end
	if level == 2 then -- uncommon, not exists
		return 2
	end
	if level == 3 then -- rare, not exists
		return 2
	end
	if level == 4 then -- epic
		return 2
	end
	if level == 5 then -- legendary
		return 5
	end
	if level == 6 then -- immortal
		return 25 -- should be 50 for ancient immortals, but probably nobody will notice
	end
	if level == 7 then -- divine
		return 100
	end
	if level == 8 then -- mythical
		return 500
	end
	return 1
end

function GetCostByItemLevel( level )
	if level == 1 then
		return 5
	end
	if level == 2 then
		return 10
	end
	if level == 3 then
		return 25
	end
	if level == 4 then
		return 100
	end
	if level == 5 then --recipes
		return 5
	end
	return 1
end

function SendItemsToShop(player)
	if(player == nil) then
		return
	end

    local items = GetAllItems(nil, true, false, 1)
    items[5] = GetAllRecipes()
	local currentBatchQuantity = 0
	local itemsToSend = {}

    for j=1,5 do
    	--if j <= 5 then
	    	for i=1,#items[j] do
	    		--local lastItem = 0
	    		--if j == 5 and i == #items[j] then
	    		--	lastItem = 1
	    		--end

				table.insert(itemsToSend, {
					item = items[j][i],
					rarity = j,
					cost = GetCostByItemLevel(j),
					--isLastItem = lastItem
				})

				currentBatchQuantity = currentBatchQuantity + 1
				-- Send items in batches of 100
	        end
			if(currentBatchQuantity >= 100) then
				CustomGameEventManager:Send_ServerToPlayer(player, "additemstoshop", itemsToSend )
				itemsToSend = {}
				currentBatchQuantity = 0
			end
		--end
    end

	-- Send last batch, if not sended still
	if(currentBatchQuantity > 0) then
		CustomGameEventManager:Send_ServerToPlayer(player, "additemstoshop", itemsToSend )
	end
end

function GetAllRecipes()
	local recipes = {}
	table.insert(recipes, "item_molten_steel")
	table.insert(recipes, "item_recipe_set_t4_aad_4")
	table.insert(recipes, "item_recipe_cain_set")
	table.insert(recipes, "item_recipe_cain_set2")
	table.insert(recipes, "item_recipe_set_t4_str_4")
	table.insert(recipes, "item_recipe_set_t4_agi_4")
	table.insert(recipes, "item_recipe_set_t4_int_4")
	table.insert(recipes, "item_recipe_set_t4_sp_4")
	table.insert(recipes, "item_recipe_set_t4_aa_4")
	table.insert(recipes, "item_recipe_set_t4_new_4")
	table.insert(recipes, "item_recipe_set_t4_str_5")
	table.insert(recipes, "item_recipe_set_t4_agi_5")
	table.insert(recipes, "item_recipe_set_t4_int_5")
	table.insert(recipes, "item_recipe_set_t4_sp_5")
	table.insert(recipes, "item_recipe_set_t4_aa_5")
	table.insert(recipes, "item_recipe_set_t4_new_5")
	table.insert(recipes, "item_recipe_set_t4_aad_5")
	table.insert(recipes, "item_recipe_warglaive_full_dream")
	table.insert(recipes, "item_recipe_warglaive_full_dream_2")
	table.insert(recipes, "item_recipe_set_agi_t3_2_full_dream_2")
	table.insert(recipes, "item_recipe_set_agi_t3_2_full_dream")
	table.insert(recipes, "item_recipe_set_str_t3_2_full_dream")
	table.insert(recipes, "item_recipe_set_str_t3_2_full_dream_2")
	table.insert(recipes, "item_recipe_set_int_t3_2_full_dream")
	table.insert(recipes, "item_recipe_set_int_t3_2_full_dream_2")
	table.insert(recipes, "item_recipe_set_int_t3_full_dream")
	table.insert(recipes, "item_recipe_set_int_t3_full_dream_2")
	table.insert(recipes, "item_recipe_set_str_t3_full_dream")
	table.insert(recipes, "item_recipe_set_str_t3_full_dream_2")
	table.insert(recipes, "item_recipe_set_agi_t3_full_dream")
	table.insert(recipes, "item_recipe_set_agi_t3_full_dream_2")
	table.insert(recipes, "item_recipe_set_str_t2_full_dream")
	table.insert(recipes, "item_recipe_set_str_t2_full_dream_2")
	table.insert(recipes, "item_recipe_set_agi_t2_full_dream")
	table.insert(recipes, "item_recipe_set_agi_t2_full_dream_2")
	table.insert(recipes, "item_recipe_set_int_t2_full_dream")
	table.insert(recipes, "item_recipe_set_int_t2_full_dream_2")
	table.insert(recipes, "item_recipe_set_str_tank_full_dream")
	table.insert(recipes, "item_recipe_set_str_tank_full_dream_2")
	table.insert(recipes, "item_recipe_set_int_dmg_full_dream")
	table.insert(recipes, "item_recipe_set_int_dmg_full_dream_2")
	table.insert(recipes, "item_recipe_set_agi_dmg_full_dream")
	table.insert(recipes, "item_recipe_set_agi_dmg_full_dream_2")
	table.insert(recipes, "item_recipe_set_str_dmg_full_dream_2")
	table.insert(recipes, "item_recipe_set_str_dmg_full_dream")
	table.insert(recipes, "item_recipe_set_agi_t3_2_full")
	table.insert(recipes, "item_recipe_set_str_t3_2_full")
	table.insert(recipes, "item_recipe_set_int_t3_2_full")
	table.insert(recipes, "item_recipe_set_int_t3_full")
	table.insert(recipes, "item_recipe_set_agi_t3_full")
	table.insert(recipes, "item_recipe_set_str_t3_full")
	table.insert(recipes, "item_recipe_purgeblade")
	table.insert(recipes, "item_recipe_activedh2")
	table.insert(recipes, "item_recipe_demonglaive")
	table.insert(recipes, "item_recipe_chainlightning")
	table.insert(recipes, "item_recipe_set_str_t2_full")
	table.insert(recipes, "item_recipe_set_agi_t2_full")
	table.insert(recipes, "item_recipe_set_int_t2_full")
	table.insert(recipes, "item_recipe_warglaive_full")
	table.insert(recipes, "item_recipe_nova_blade_shadow")
	table.insert(recipes, "item_recipe_ring_arcane_full")
	table.insert(recipes, "item_recipe_wolf_cloak_2")
	table.insert(recipes, "item_recipe_wolf_belt_standard")
	table.insert(recipes, "item_recipe_set_str_tank_full")
	table.insert(recipes, "item_recipe_set_str_dmg_full")
	table.insert(recipes, "item_recipe_set_agi_dmg_full")
	table.insert(recipes, "item_recipe_set_int_dmg_full")
	table.insert(recipes, "item_recipe_spellhaste_3")
	table.insert(recipes, "item_recipe_bowupgrade")
	table.insert(recipes, "item_recipe_holyhammer2")
	table.insert(recipes, "item_recipe_active7")
	table.insert(recipes, "item_recipe_active7up")
	table.insert(recipes, "item_recipe_devilsoul")
	table.insert(recipes, "item_recipe_active6")
	table.insert(recipes, "item_recipe_hellbringer")
	table.insert(recipes, "item_recipe_active5")
	table.insert(recipes, "item_recipe_active5up")
	table.insert(recipes, "item_recipe_active4")
	table.insert(recipes, "item_recipe_irontalon")
	table.insert(recipes, "item_recipe_irontalon2")
	table.insert(recipes, "item_recipe_activeshaman2")
	table.insert(recipes, "item_recipe_activerogue3")
	table.insert(recipes, "item_recipe_activerogue4")
	table.insert(recipes, "item_recipe_activepaladin2")
	table.insert(recipes, "item_recipe_activedruid2")
	table.insert(recipes, "item_recipe_activehunter2")
	table.insert(recipes, "item_recipe_activemage")
	table.insert(recipes, "item_recipe_activemage3")
	table.insert(recipes, "item_recipe_activewarlock2")
	table.insert(recipes, "item_recipe_activewarrior2")
	table.insert(recipes, "item_recipe_activedk2")
	table.insert(recipes, "item_recipe_activedk_frost2")
	table.insert(recipes, "item_recipe_activepriest2")
	table.insert(recipes, "item_recipe_active3")
	table.insert(recipes, "item_recipe_active2")
	table.insert(recipes, "item_recipe_active2up")
	table.insert(recipes, "item_recipe_silvermoon")
	table.insert(recipes, "item_recipe_active9")
	table.insert(recipes, "item_recipe_active9up")
	table.insert(recipes, "item_recipe_valyrian")
	table.insert(recipes, "item_recipe_active99")
	table.insert(recipes, "item_recipe_aura_eagle")
	table.insert(recipes, "item_recipe_beastmaster")
	table.insert(recipes, "item_recipe_beastbracer")
	table.insert(recipes, "item_recipe_helmofice")
	table.insert(recipes, "item_recipe_active13")
	table.insert(recipes, "item_recipe_active1up")
	table.insert(recipes, "item_recipe_active1")
	table.insert(recipes, "item_recipe_endgame6")
	table.insert(recipes, "item_recipe_dreihander")
	table.insert(recipes, "item_recipe_allstats5")
	table.insert(recipes, "item_recipe_bootsreflect2")
	table.insert(recipes, "item_recipe_arcaneblaster")
	table.insert(recipes, "item_recipe_endgame3")
	table.insert(recipes, "item_recipe_bootsblood2")
	table.insert(recipes, "item_recipe_bootscrit")
	table.insert(recipes, "item_recipe_bootscrit_2")
	table.insert(recipes, "item_recipe_shield3")
	table.insert(recipes, "item_recipe_weapon9")
	table.insert(recipes, "item_recipe_allrecipe")
	table.insert(recipes, "item_recipe_shieldluna")
	table.insert(recipes, "item_recipe_weapon7up")
	table.insert(recipes, "item_recipe_weapon5")
	table.insert(recipes, "item_recipe_allstats4")
	table.insert(recipes, "item_recipe_crit_pure_2")
	table.insert(recipes, "item_recipe_endgame4")
	table.insert(recipes, "item_recipe_elements")
	table.insert(recipes, "item_recipe_elements2")
	table.insert(recipes, "item_recipe_hasteproc")
	table.insert(recipes, "item_recipe_lifepatron")
	table.insert(recipes, "item_recipe_endgame13")
	table.insert(recipes, "item_recipe_endgame12")
	table.insert(recipes, "item_recipe_angel")
	return recipes
end

function COverthrowGameMode:GetAllNeutralItems()
	local neutrals = {}
	for i = 1, 40 do
		table.insert(neutrals, "item_neutral_" .. i)
	end
	return neutrals
end

function COverthrowGameMode:GetAllNeutralItemsByTier(tier)
	local neutrals = COverthrowGameMode:GetAllNeutralItems()
	local tierlist = {}
	if tier == 1 then
		for i = 33, 40 do
			table.insert(tierlist, neutrals[i])
		end
	end
	if tier == 2 then
		for i = 1, 32 do
			table.insert(tierlist, neutrals[i])
		end
	end
	return tierlist
end

function COverthrowGameMode:DropRandomNeutralItemForHero(hero, showEffect, tier)
	local neutrals = COverthrowGameMode:GetAllNeutralItemsByTier(tier)
	local item = neutrals[math.random(1,#neutrals)]
	if item then
		COverthrowGameMode:DropNeutralItemForHero(hero, item)
		if showEffect then
			EmitGlobalSound("DOTA_Item.DoE.Activate")
			PopupKillbanner(hero, "doublekill")
		end
	end
end

function COverthrowGameMode:DropNeutralItemForHero(hero, item)
	if item then
		local spot = hero:GetAbsOrigin()
		item = CreateItem(item, hero, hero)
		item.heroOwner = hero
		local item2 = CreateItemOnPositionSync(spot, item)
		Timers:CreateTimer(0.1,function()
        	if item and not item:IsNull() then
        		local offset_y = math.random(65,125)
        		local offset_x = math.random(-75,75)
	        	item:LaunchLoot(false, 125, 0.9, spot + Vector(offset_x,-offset_y,0), nil)
	        end
	    end)
	end
end

function COverthrowGameMode:DropRandomNeutralItemForAllHeroes(showEffect, tier)
	local all = HeroList:GetAllHeroes()
	for i = 1, #all do
		Timers:CreateTimer(i * 3,function()
			COverthrowGameMode:DropRandomNeutralItemForHero(all[i], showEffect, tier)
		end)
	end
end