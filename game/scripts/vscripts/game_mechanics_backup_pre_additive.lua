if _G.GameMechanics == nil then
	_G.GameMechanics = class({}) -- put COverthrowGameMode in the global scope
	--print("global maker called")
	--refer to: http://stackoverflow.com/questions/6586145/lua-require-with-global-local
end

function GameMechanics:PeriodicDebug(hero)
	local caster = hero
    Timers:CreateTimer(0.5, function()
	   	--print("iscastervalue")
	   	--print(caster.IsCasting)
	    GameMechanics:PeriodicDebug(caster)
	end)
end

function GetSpellpower(event)
	local spelldamagefromitem = 0
	local factor = 1
	local caster = event.caster
	local mods = caster:GetModifierCount()-1
	for i=0, mods do
		local name = caster:GetModifierNameByIndex(i)
		--print(name)
		if name == "modifier_item_set_int_dmg_full" then
    		factor = factor + 0.25
	    end
        if name == "modifier_item_set_int_dmg_full_2" then
            factor = factor + 0.25
        end
        if name == "modifier_item_set_int_dmg_full_2_dream" then
            factor = factor + 0.4
        end
        if name == "modifier_item_set_int_dmg_full_2" then
            spelldamagefromitem = spelldamagefromitem + 22
        end
        if name == "modifier_item_set_int_dmg_full_2_dream" then
            spelldamagefromitem = spelldamagefromitem + 22
        end
        if name == "modifier_item_sp25" then
            spelldamagefromitem = spelldamagefromitem + 25
        end
        if name == "modifier_stormrider" then
            spelldamagefromitem = spelldamagefromitem + 75
        end
        if name == "modifier_item_shadowstrike" then
            spelldamagefromitem = spelldamagefromitem + 100
        end
		if name == "modifier_item_caster5" then
    		spelldamagefromitem = spelldamagefromitem + 7.5
	    end
	    if name == "modifier_item_sprecipe" then
    		spelldamagefromitem = spelldamagefromitem + 4
	    end
	    if name == "modifier_item_sp" then
    		spelldamagefromitem = spelldamagefromitem + 2.5
	    end
	    if name == "modifier_item_caster55" then
	    	spelldamagefromitem = spelldamagefromitem + 10*caster:GetMana()/caster:GetMaxMana()
	    end
        if name == "modifier_item_active9up" then
            spelldamagefromitem = spelldamagefromitem + 10*caster:GetMana()/caster:GetMaxMana()
        end
        if name == "modifier_item_ring_arcane_full" then
            spelldamagefromitem = spelldamagefromitem + 0.005*(caster:GetMana()+caster:GetHealth())
        end
        if name == "modifier_item_ring_arcane_full_2" then
            spelldamagefromitem = spelldamagefromitem + 0.005*(caster:GetMana()+caster:GetHealth())
        end
        if name == "modifier_talent_manasp" then
            local ancient = 1
            if caster:HasModifier("modifier_item_winterbreeze4") then
                ancient = 2
            end
            spelldamagefromitem = spelldamagefromitem + 0.015 * caster:GetMana() * caster.talents[34] * ancient
        end
        if name == "modifier_item_winterbreeze3" then
            spelldamagefromitem = spelldamagefromitem + 0.01 * caster:GetMana()
        end
	    if name == "modifier_item_endgame4" then
	    	spelldamagefromitem = spelldamagefromitem + 22
	    end
	    if name == "modifier_item_nova_blade_shadow" then
	    	spelldamagefromitem = spelldamagefromitem + 8
	    end
	    if name == "modifier_item_active5" then
	    	spelldamagefromitem = spelldamagefromitem + 10
	    end
        if name == "modifier_item_active5up" then
            spelldamagefromitem = spelldamagefromitem + 10
        end
	    if name == "modifier_active5" then
	    	spelldamagefromitem = spelldamagefromitem + 10
	    end
        if name == "modifier_active5up_haste" then
            spelldamagefromitem = spelldamagefromitem + 10
        end
	    if name == "modifier_item_aura_sp" then
	    	spelldamagefromitem = spelldamagefromitem + 4
	    end
        if name == "modifier_item_ringofflames" then
            spelldamagefromitem = spelldamagefromitem + 4
        end
	    if name == "modifier_inner_int" then
	    	spelldamagefromitem = spelldamagefromitem + 4
	    end
	    if name == "modifier_item_fireball" then
	    	spelldamagefromitem = spelldamagefromitem + 4
	    end
	    if name == "modifier_item_curseblade" then
	    	spelldamagefromitem = spelldamagefromitem + 3
	    end
	    if name == "modifier_item_allrecipe4" then
	    	spelldamagefromitem = spelldamagefromitem + 4
	    end
        if name == "modifier_item_shield1up" then
            spelldamagefromitem = spelldamagefromitem + 4
        end
	    if name == "modifier_item_aether_lens" then
	    	spelldamagefromitem = spelldamagefromitem + 9
	    end
	    if name == "modifier_item_shadowmourne" then
	    	spelldamagefromitem = spelldamagefromitem + 10
	    end
        if name == "modifier_aura_sp_immo" then
            spelldamagefromitem = spelldamagefromitem + 50
        end
        if name == "modifier_item_elements3" then
            spelldamagefromitem = spelldamagefromitem + 25
        end
        if name == "modifier_item_set_int_t3_full" then
            spelldamagefromitem = spelldamagefromitem + 75
        end
        if name == "modifier_item_set_int_t3_1" then
            spelldamagefromitem = spelldamagefromitem + 75
        end
        if name == "modifier_item_aura_sp_immo" then
            spelldamagefromitem = spelldamagefromitem + 50
        end
        if name == "modifier_item_sp4" then
            spelldamagefromitem = spelldamagefromitem + 300
        end
        if name == "modifier_item_set_int_t3_2_full" then
            spelldamagefromitem = spelldamagefromitem + 150
        end
        if name == "modifier_item_set_int_t3_1_2" then
            spelldamagefromitem = spelldamagefromitem + 60
        end
	    if name == "modifier_shaman_sp_buff" then
	    	spelldamagefromitem = spelldamagefromitem + 5
            factor = factor + 0.15
	    end
	    if name == "modifier_elemental_sp" then
	    	spelldamagefromitem = spelldamagefromitem + 0.5*caster:GetModifierStackCount("modifier_elemental_sp", nil)
	    end
        if name == "modifier_mythic_sp" then
            spelldamagefromitem = spelldamagefromitem + caster:GetModifierStackCount("modifier_mythic_sp", nil)
        end
	    if name == "modifier_item_set_int_dmg_1" then
	    	spelldamagefromitem = spelldamagefromitem + 12
	    end
	    if name == "modifier_item_set_int_dmg_3" then
	    	spelldamagefromitem = spelldamagefromitem + 10
	    end
        if name == "modifier_item_wolf_cloak_aura_2" then
            spelldamagefromitem = spelldamagefromitem + 8
        end
        if name == "modifier_item_frostfire" then
            spelldamagefromitem = spelldamagefromitem + 20
        end
        if name == "modifier_item_spellhaste_2" then
            spelldamagefromitem = spelldamagefromitem + 25
        end
        if name == "modifier_itemhaste50" then
            spelldamagefromitem = spelldamagefromitem + 25
        end
        if name == "modifier_spellblood" then
            spelldamagefromitem = spelldamagefromitem + 125
            factor = factor + 0.1
        end
	    if name == "modifier_item_spellpower_stack" and event.spelldamagefactor and event.spelldamagefactor > 0.0 then
	    	local spproc = caster:GetModifierStackCount("modifier_item_spellpower_stack", nil)
	    	if spproc >= 20 then
	    		spelldamagefromitem = spelldamagefromitem + 60
	    		caster:RemoveModifierByName("modifier_item_spellpower_stack")
	    	end
	    end
	end
	local heroName = caster:GetUnitName()
	if heroName == "npc_dota_hero_disruptor" then
		spelldamagefromitem = spelldamagefromitem + 10
	end
    --runeword
    if caster.runeword and caster.runeword[7] then
        spelldamagefromitem = spelldamagefromitem + caster.runeword[7]
    end
    if caster.talents and caster.talents[31] then
        factor = factor + 0.12 * caster.talents[31]
    end
	spelldamagefromitem = spelldamagefromitem * factor
    return spelldamagefromitem
end

function HasDamageReflect(target)
    if target:HasModifier("modifier_shieldreflect") or target:HasModifier("modifier_shieldreflect_only_dmg") then
        return true
    end
    return false
end

function DamageUnit( event )
    local caster = event.caster
	local target = event.target
    local real_caster = caster
	local ability = event.ability
    local elemental_bonus = 1
    local ability_bonus = 1
    if caster == nil then
        return
    else
        if caster:IsNull() then
            return
        end
    end
    if event.ComesFromPet and caster.owner then
        caster = caster.owner
    end
	if event.ondealdamagetarget then
		target = event.unit
	end
    if event.fromcompanion and target and HasDamageReflect(target) then
        return
    end
    if event.ontakedamage then
        caster = event.unit
        target = event.attacker
        if (target == caster) or event.isreflected or target:HasModifier("modifier_shieldreflect") or target:HasModifier("modifier_shieldreflect_only_dmg") or caster:HasModifier("modifier_shieldreflect") or caster:HasModifier("modifier_shieldreflect_only_dmg") then
            return
        end
        event.isreflected = true
    end
	if event.targetchangeattacker then
		target = event.attacker
	end
    if event.pveownerbased and event.caster and event.caster.owner then
        caster = event.caster.owner
    end
    if caster == nil then
        return
    else
        if caster:IsNull() then
            return
        end
    end
    if caster and caster:IsNull() then
        return
    end
    if not caster:IsAlive() then
        return
    end
    if event.movedenydmg and target:IsMoving() then
        return
    end
    if event.nodmgbuffcondition and target and target:HasModifier("fire_save_zone") then
        return
    end
    if event.dmgonbuffcondition and target then
        if not caster:HasModifier(event.dmgonbuffcondition) or caster:GetAbilityByIndex(1):GetLevel() < 4 then
            return
        end
    end
    if event.zonecondition and target and ((target:HasModifier("modifier_farring_buff") and not target:HasModifier("modifier_midring_buff")) or ( not target:HasModifier("modifier_farring_buff") and target:HasModifier("modifier_midring_buff")) ) then
        return
    end
    local passive_ability
    if caster.talents then
        passive_ability = caster:FindAbilityByName("combat_system")
    end

    local behindtarget = false
    local angleDiff = target:GetAngles()[2]-caster:GetAngles()[2]
    if angleDiff < 0.0 then
        angleDiff = -angleDiff
    end

    if (angleDiff <= 90.0 or angleDiff >= 270.0) then
        behindtarget = true
    end

    if event.damage == nil then
    	event.damage = 0.0
    end
    if event.enemyhealth then
    	if not target:HasModifier("modifier_pvebosssystem") then
    		event.damage = target:GetHealth()*event.enemyhealth/100.0
    	else
    		event.damage = target:GetHealth()*event.enemyhealth/100.0
    	end
    end

    -- warlock souls
    -- generate
    if 	event.generatesoul ~= nil then
    	if caster.souls ~= nil then
    		caster.souls = caster.souls + event.generatesoul
    		if caster.souls > event.maxsouls then
    			caster.souls = event.maxsouls
    		end
    	else
    		caster.souls = event.generatesoul
    	end
    	event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_souls", nil)
    	caster:SetModifierStackCount("modifier_souls", event.ability, caster.souls)
    end
    -- consume
    local nodamageatall = 1
    if 	event.consumesouls ~= nil then
    	if caster.souls == nil then
    		caster.souls = 0
    	end
    	if caster.souls >= event.consumesouls then
    		caster.souls = caster.souls - event.consumesouls
    		caster:SetModifierStackCount("modifier_souls", event.ability, caster.souls)
    		if caster.souls == 0 then
    			caster:RemoveModifierByName("modifier_souls")
    		end
    	else
    		nodamageatall = 0
    	end
    end
    

    -- add auto attack damage?
	if event.includeauto ~= nil then
    	event.damage = caster:GetAttackDamage()*event.includeauto/100
        if caster:HasModifier("modifier_retri_crit") then
            event.damage = event.damage * 2.5
        end
    end

    if event.strikeofvengeance and event.strikeofvengeance > 0 then
        if caster.lastdamagetaken then
            event.damage = event.damage + caster.lastdamagetaken * event.strikeofvengeance / 100
            if event.damage > caster:GetMaxHealth() * 10 then
                event.damage = caster:GetMaxHealth() * 10
            end
            caster.lastdamagetaken = nil
            caster:RemoveModifierByName("modifier_strikeofvengeance")
        end
    end

    if event.difficultyscale and caster.pvescale then
        event.damage = event.difficultyscale + (event.difficultyscale * caster.pvescale * 0.25)
    end
    if event.difficultyscalelinear and caster.pvescale then
        event.damage = event.difficultyscalelinear * caster.pvescale
    end

    local finaldamage = event.damage

    if event.adjustdamage then
        finaldamage = finaldamage * event.adjustdamage
    end

    if event.retaliationstacks then
        finaldamage = finaldamage + caster:GetModifierStackCount("modifier_godschosen_2", nil)*event.retaliationstacks/100
        if finaldamage > caster:GetMaxHealth()*15 then
            finaldamage = caster:GetMaxHealth()*15
        end
    end
    -- Spelldamage
    local spelldamagefromitem = 0

    if event.spelldamagefactor == nil then
    	event.spelldamagefactor = 0.0
    end
    if caster.spelldamage == nil then
    	caster.spelldamage = 0.0
    end
    if event.spelldamagefactor > 0.0 then
    	spelldamagefromitem = GetSpellpower(event)
    	finaldamage = event.damage + event.spelldamagefactor*(caster.spelldamage+spelldamagefromitem)/100.0
    end

    --stat scaling
    -- if its a pet, need owner stats
    if event.attributefactor == nil then
        --print("attr null in damage function")
    	event.attributefactor = 0.0
    end
    if caster:IsHero() then
	    if caster:GetPrimaryStatValue() > 0.0 then
	    	if event.attributechangeint ~= nil then
	    		finaldamage = finaldamage + caster:GetIntellect()*event.attributefactor/100.0
	    	elseif event.attributechangestr ~= nil then
	    		finaldamage = finaldamage + caster:GetStrength()*event.attributefactor/100.0
	    	elseif event.attributechangeagi ~= nil then
	    		finaldamage = finaldamage + caster:GetAgility()*event.attributefactor/100.0
	    	elseif event.attributechangeall ~= nil then
	    		finaldamage = finaldamage + caster:GetAgility()*event.attributefactor/100.0 + caster:GetStrength()*event.attributefactor/100.0 + caster:GetIntellect()*event.attributefactor/100.0
	    	else
	    		finaldamage = finaldamage + caster:GetPrimaryStatValue()*event.attributefactor/100.0
	    	end
	    	-- based on bleed dot stacks
	    	if event.feralbleedstack ~= nil then
	    		finaldamage = finaldamage * event.feralbleedstack
	    		--print("bleed stack incr dmg")
	    	end
	    	-- based on combo points (feral finisher) and strenth
	    	if event.feralcombopointbased ~= nil then
	    		finaldamage = finaldamage + caster:GetStrength()*event.attributefactor/100.0
	    		finaldamage = finaldamage * caster.FeralFinisher
	    		--print("bleed 2 dot adjusted")
	    	end
            if event.feral4x ~= nil then
                finaldamage = finaldamage + caster:GetStrength()*event.attributefactor/100.0
                finaldamage = finaldamage * caster.FeralFinisher * 4
                --print("bleed 2 dot adjusted")
            end
	    end
	end
    --end

    if event.furyexedamage then
        local lifepercent = target:GetHealth()/target:GetMaxHealth()
        local inversed_percent = 1 - lifepercent
        finaldamage = caster:GetAttackDamage()*event.furyexedamage*inversed_percent/100
        if event.furyexecutetalent and event.furyexecutetalent == 1 and caster:GetMana() >= 40 and lifepercent > 0.50 then
            finaldamage = caster:GetAttackDamage()*event.furyexedamage*0.5/100
        end
    end

    if event.counterblow and event.counterblow > 0 then
    	if event.missinghp ~= nil then
    		local missinghealth = target:GetMaxHealth()-target:GetHealth()
    		finaldamage = missinghealth*event.counterblow/100
            if event.ownerhealthcap and caster.owner then
                if finaldamage > caster.owner:GetMaxHealth() * event.ownerhealthcap / 100 then
                    finaldamage = caster.owner:GetMaxHealth() * event.ownerhealthcap / 100
                end
            end
    	else
    		finaldamage = caster:GetHealth()*event.counterblow/100
    		if event.counterblowmax and event.counterblowmax == 1 then
    			finaldamage = caster:GetMaxHealth()*event.counterblow/100
    		end
    	end
    end

    if event.currenthp then
        finaldamage = target:GetHealth()*event.currenthp/100
        if event.cap then
            local cap = caster:GetMaxHealth()*event.cap/100
            if finaldamage > cap then
                finaldamage = cap
            end
        end
    end

    if event.deadlypoisonstack ~= nil then
        local stack = target:GetModifierStackCount("modifier_deadlypoison", nil)
        finaldamage = finaldamage * stack
    end

    if event.arcanepowerbonus ~= nil then
        if caster:HasModifier("modifier_arcanepower") and not caster:HasModifier("modifier_burning_nether") then
            local stack = caster:GetModifierStackCount("modifier_arcanepower", caster)
            if stack <= event.apcharges then
                caster:RemoveModifierByName("modifier_arcanepower")
            else
                caster:SetModifierStackCount("modifier_arcanepower", event.ability, stack-event.apcharges)
                stack = event.apcharges
            end
            if event.maxmanabonus and event.maxmanabonus > 0 then
                finaldamage = finaldamage + caster:GetMana()*event.maxmanabonus/100
            end
            finaldamage = finaldamage*stack
            caster.ArcanePowerDot = finaldamage
        else
            -- in burning nether, no new dot applied
            if event.maxmanabonus and event.maxmanabonus > 0 then
                finaldamage = finaldamage + caster:GetMana()*event.maxmanabonus/100
            end
            finaldamage = (finaldamage * (1 + event.netherwizarddot / 25) ) * event.apcharges
            --caster.ArcanePowerDot = finaldamage
            -- no resources
            if not caster:HasModifier("modifier_burning_nether") and not caster:HasModifier("modifier_arcanepower") then
                finaldamage = 0
                caster.ArcanePowerDot = 0
            end
        end 
    end

    if event.arcanepowerbonusdot ~= nil then
        finaldamage = caster.ArcanePowerDot * event.arcanepowerbonusdot / 100
    end

    if caster.talents then
        if caster.talents[2] then
            finaldamage = finaldamage + (caster:GetAverageTrueAttackDamage(caster) + GetSpellpower(event)) * 0.05 * caster.talents[2]
        end
        if caster.talents[8] then
            local ancient = 1
            if caster:HasModifier("modifier_item_silverblood4") then
                ancient = 2
            end
            finaldamage = finaldamage + caster:GetHealth() * 0.01 * caster.talents[8] * ancient
        end
    end

    local is_big_hit = false
    if caster:IsRealHero() and finaldamage > caster:GetPrimaryStatValue() * 2 then
        is_big_hit = true
    end

    ------------------------------------------------------------------------------------------------------------------------
    --base damage calcs finished, after here amplifications
    ability_bonus = GetAbilityModifierAdditive(event, caster, target)
    elemental_bonus = GetElementalDamageModifierAdditive(event, caster, target)
    caster.ability_bonus = ability_bonus
    caster.elemental_bonus = elemental_bonus
    
function GetAbilityDamageModifierAdditive( event )
    local value = 1

    return value
end

function GetElementalDamageModifierAdditive( event, caster, target )
    local value = 1
    if event.firedmg and caster:HasModifier("modifier_burning_nether") then
        value = value + 0.25
    end
    return value
end

    

    

    --moonfire
    if event.consumesuncharge then
  		local stack = caster:GetModifierStackCount("modifier_mooncharge", caster)
  		if stack >= 5 then
  			caster:RemoveModifierByName("modifier_mooncharge")
	    	finaldamage = finaldamage * 1.35
  		end
    end

    if event.shieldbashbonus ~= nil then
	    finaldamage = finaldamage+finaldamage*0.1*event.shieldbashbonus
    end

    if event.moltenlavabonus then
    	if target:HasModifier("fireslow50") and caster:GetAbilityByIndex(2):GetLevel() >= 3 then
	    	finaldamage = finaldamage *1.4
	    end
    end
    if event.firelance and target:HasModifier("modifier_magmaburn") and target:HasModifier("fireslow50") then
        finaldamage = finaldamage * event.firelance
    end
    if caster.elemental_item3 and caster:HasModifier("modifier_item_elements3") then
        local bonusdmg = 1
        if caster:HasModifier("modifier_dmgitem_fire") then
            bonusdmg = bonusdmg + 0.15
        end
        if caster:HasModifier("modifier_dmgitem_arcane") then
            bonusdmg = bonusdmg + 0.15
        end
        if caster:HasModifier("modifier_dmgitem_shadow") then
            bonusdmg = bonusdmg + 0.15
        end
        if caster:HasModifier("modifier_dmgitem_nature") then
            bonusdmg = bonusdmg + 0.15
        end
        if caster:HasModifier("modifier_dmgitem_holy") then
            bonusdmg = bonusdmg + 0.15
        end
        if caster:HasModifier("modifier_dmgitem_frost") then
            bonusdmg = bonusdmg + 0.15
        end
        finaldamage = finaldamage * bonusdmg
        local buffdur = 15
        if event.firedmg then
            caster.elemental_item3:ApplyDataDrivenModifier(caster, caster, "modifier_dmgitem_fire", {Duration = buffdur})
        end
        if event.arcanedmg then
            caster.elemental_item3:ApplyDataDrivenModifier(caster, caster, "modifier_dmgitem_arcane", {Duration = buffdur})
        end
        if event.shadowdmg then
            caster.elemental_item3:ApplyDataDrivenModifier(caster, caster, "modifier_dmgitem_shadow", {Duration = buffdur})
        end
        if event.naturedmg then
            caster.elemental_item3:ApplyDataDrivenModifier(caster, caster, "modifier_dmgitem_nature", {Duration = buffdur})
        end
        if event.holydmg then
            caster.elemental_item3:ApplyDataDrivenModifier(caster, caster, "modifier_dmgitem_holy", {Duration = buffdur})
        end
        if event.frostdmg then
            caster.elemental_item3:ApplyDataDrivenModifier(caster, caster, "modifier_dmgitem_frost", {Duration = buffdur})
        end
    end
    local fury_stacks = caster:GetModifierStackCount("modifier_furyas", nil)
    if event.furyexedamage and fury_stacks > 0 then
        finaldamage = finaldamage * (1 + 0.05 * fury_stacks)
    end
    local shadow_stance_cleric = caster:GetModifierStackCount("modifier_shadow_stance", nil)
    if event.shadowdmg and shadow_stance_cleric > 0 then
        finaldamage = finaldamage * (1 + 0.05 * shadow_stance_cleric)
    end
    local dk_blood_stacks = caster:GetModifierStackCount("modifier_strikeofvengeance2", nil)
    if dk_blood_stacks > 0 then
        finaldamage = finaldamage * (1 + 0.05 * dk_blood_stacks)
    end
    local pala_retal_stacks = caster:GetModifierStackCount("modifier_strikeofvengeance3", nil)
    if pala_retal_stacks > 0 then
        finaldamage = finaldamage * (1 + 0.1 * pala_retal_stacks)
    end
    if event.shadowdmg and target:HasModifier("modifier_rooted_self_slow") then
        finaldamage = finaldamage * 1.25
    end
    if caster:GetAbilityByIndex(5) and caster:GetAbilityByIndex(5):GetName() == "moon6" and caster:GetAbilityByIndex(5):GetLevel() >= 2 then
        --finaldamage = finaldamage *1.15
        ability_bonus = ability_bonus + 0.3
    end 

    if event.fireconsecbonus and event.fireconsecbonus > 0 and target:HasModifier("modifier_magmaburn") then
	    finaldamage = finaldamage * (1 + event.fireconsecbonus/100)
	    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_techies/techies_remote_mine_detonate_embers.vpcf", PATTACH_POINT_FOLLOW, target)
    end

    if event.immolatebonus ~= nil then
    	if target:HasModifier("modifier_magmaburn2") then
	    	finaldamage = finaldamage*(1+event.immolatebonus/100.0)
	    end 
    end

    if event.ancientlongbow and caster:HasModifier("modifier_itemhastebow") then
	    finaldamage = finaldamage*1.25
    end
    if event.ancientlongbow and caster:HasModifier("modifier_item_hunterbow") then
        finaldamage = finaldamage*1.35
    end

    if caster:HasModifier("modifier_active9") then
	    finaldamage = finaldamage*1.3
    end
    if event.ambushblade and caster:HasModifier("modifier_item_armoriron2") then
        finaldamage = finaldamage*1.15
    end
    if event.cruelabils and target:HasModifier("modifier_rogue_ambush_bonus") then
        finaldamage = finaldamage*1.15
    end
    if caster:HasModifier("modifier_dmgbonus_cruel") then
        finaldamage = finaldamage*1.15
    end
    if (event.shadowdmg or event.holydmg) and target:HasModifier("modifier_holy_shadow_weakness") then
        finaldamage = finaldamage*1.2
    end
    
    if caster:HasModifier("modifier_activepaladin") then
	    finaldamage = finaldamage*1.25
    end

    if event.untamed and caster:HasModifier("modifier_item_straxe3") then
        finaldamage = finaldamage*event.untamed
    end

    if caster:HasModifier("modifier_elemental_lust2") then
        finaldamage = finaldamage*1.25
    end

    if real_caster and real_caster:HasModifier("modifier_active99") then
	    finaldamage = finaldamage*1.5
    end

    if event.rampupdamage then
        if caster.rampupdamage then
            finaldamage = finaldamage*caster.rampupdamage
        end
    end

    --talents1
    if caster.talents then
        if caster.talents[9] then
            ability_bonus = ability_bonus + 0.0015 * caster.talents[9] * caster:GetPhysicalArmorValue()
        end
        if caster.talents[11] then
            --finaldamage = finaldamage * (1 + 0.05 * caster.talents[11])
            ability_bonus = ability_bonus + 0.05 * caster.talents[11]
        end
        if caster.talents[20] and caster.standsstill and caster.standsstill >= 4 then
            finaldamage = finaldamage * (1 + 0.12 * caster.talents[20])
            --ability_bonus = ability_bonus + 0.2 * caster.talents[20]
        end
        if caster.talents[21] and (event.arcanedmg or event.naturedmg) then
            ability_bonus = ability_bonus + 0.15 * caster.talents[21]
        end
        if event.bloodwolf and caster.talents[32] then --channel bonus
            finaldamage = finaldamage * (1 + 0.2 * caster.talents[32])
        end
        if event.talentscale and caster.talents[event.talentscale] then
            finaldamage = finaldamage * caster.talents[event.talentscale]
        end
        if behindtarget and caster.talents[44] then
            finaldamage = finaldamage * (1 + 0.1 * caster.talents[44])
        end
        if caster.talents[35] and caster.talents[35] > 0 then
            if (caster:GetAbsOrigin() - target:GetAbsOrigin()):Length() > 500 then
                finaldamage = finaldamage * (1 + 0.15 * caster.talents[35])
            end
        end
        if caster.talents[24] and caster.talents[24] > 0 then
            ability_bonus = ability_bonus + 0.25 * caster.talents[24]
        end
        if caster.talents[52] and caster.talents[52] > 0 then
            local tiger_stacks = caster:GetModifierStackCount("modifier_talent_tiger_prowl", nil)
            finaldamage = finaldamage * (1 + 0.03 * caster.talents[52] * tiger_stacks)
            local myevent = {}
            myevent.caster = caster
            myevent.target = caster
            myevent.buff = "modifier_talent_tiger_prowl"
            myevent.ability = passive_ability
            myevent.dur = -1
            myevent.addstacks = -1
            myevent.max = 10
            ApplyBuffStack(myevent)
        end
        if caster.talents[52] and caster.talents[52] > 0 then
            if event.firedmg then
                caster.talent_next_non_fire_bonus = 1 + 0.2 * caster.talents[52]
            end
            if not event.firedmg and caster.talent_next_non_fire_bonus and caster.talent_next_non_fire_bonus > 0 then
                finaldamage = finaldamage * caster.talent_next_non_fire_bonus
                caster.talent_next_non_fire_bonus = 0
            end
        end
    end
    --rune words
    if caster.runeword then
        if event.bloodwolf and caster.runeword[17] then
            finaldamage = finaldamage * (1 + 0.01 * caster.runeword[17])
        end
        if caster.runeword[19] then
            --finaldamage = finaldamage * (1 + 0.01 * caster.runeword[19])
            ability_bonus = ability_bonus + 0.01 * caster.runeword[19]
        end
        if caster.runeword[24] and ability and ability == caster:GetAbilityByIndex(2) then
            --finaldamage = finaldamage * (1 + 0.01 * caster.runeword[24])
            ability_bonus = ability_bonus + 0.01 * caster.runeword[24]
        end
        if caster.runeword[25] and ability and ability == caster:GetAbilityByIndex(3) then
            --finaldamage = finaldamage * (1 + 0.01 * caster.runeword[25])
            ability_bonus = ability_bonus + 0.01 * caster.runeword[25]
        end
        if caster.runeword[26] and ability and ability == caster:GetAbilityByIndex(4) then
            --finaldamage = finaldamage * (1 + 0.01 * caster.runeword[26])
            ability_bonus = ability_bonus + 0.01 * caster.runeword[26]
        end
        if caster.runeword[27] and ability and ability == caster:GetAbilityByIndex(1) then
            --finaldamage = finaldamage * (1 + 0.01 * caster.runeword[27])
            ability_bonus = ability_bonus + 0.01 * caster.runeword[27]
        end
        if event.runewordscale and event.runewordscale == 10 and caster.runeword[event.runewordscale] and caster.runeword[event.runewordscale] > 0 then
            finaldamage = finaldamage * (100 + caster.runeword[event.runewordscale]) / 100
        end
    end
    if target.talents then
        if target.talents[11] then
            finaldamage = finaldamage * (1 - 0.1 * target.talents[11])
        end
        --if target.talents[19] and target:IsMoving() then
        --    finaldamage = finaldamage * (1 - 0.1 * target.talents[19])
        --end
    end

    if event.rangerexecute then
    	if 	target:GetHealth()/target:GetMaxHealth() < 0.3 then
	    	finaldamage = finaldamage + finaldamage*event.rangerexecute/100
	    	local particle = ParticleManager:CreateParticle("particles/econ/items/gyrocopter/hero_gyrocopter_gyrotechnics/gyro_death_explosion.vpcf", PATTACH_POINT_FOLLOW, target)
	    	particle = ParticleManager:CreateParticle("particles/units/heroes/hero_skeletonking/skeletonking_mortalstrike_explosion.vpcf", PATTACH_POINT_FOLLOW, target)
	    	ParticleManager:SetParticleControl(particle, 2, target:GetAbsOrigin())
	    end 
    end

    if event.execute ~= nil then
    	if 	target:GetHealth()/target:GetMaxHealth() < 0.5 then
	    	finaldamage = finaldamage*(100+event.execute)/100
	    end 
    end

    if event.bloodexecute then
    	if target:GetHealth()/target:GetMaxHealth() >= 0.5 then
	    	return
	    end 
	    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_nyx_assassin/nyx_assassin_vendetta_blood.vpcf", PATTACH_POINT_FOLLOW, target)
	    ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin())
	    --if event.bloodworm and event.bloodworm > 0 then
	    --	event.ability:ApplyDataDrivenModifier(caster, target, "modifier_blood_worm_spawn", nil)
	    --end
    end

    if event.executesp ~= nil then
    	if 	target:GetHealth()/target:GetMaxHealth() < 0.2 then
	    	finaldamage = finaldamage*event.executesp
	    end 
    end

    if event.feralbonus ~= nil then
    	local bonusfactor = 1.0 + 0.15*target:GetModifierStackCount("modifier_bleedslow", nil)
	    finaldamage = finaldamage*bonusfactor
    end

    if event.thunderstacks then
    	local bonusfactor = 1.0 + 0.15*caster:GetModifierStackCount("modifier_ele_thunder_stacks", nil)
	    finaldamage = finaldamage*bonusfactor
    end

    if event.shadoworb then
    	local bonusfactor = target:GetModifierStackCount("modifier_swd", nil)
	    finaldamage = finaldamage*bonusfactor
    end

    local snowrangerbonus = caster:GetModifierStackCount("modifier_ranger_as_bonus", nil)
    if snowrangerbonus > 0 then
        finaldamage = finaldamage + finaldamage * 0.05 * snowrangerbonus
        --ability_bonus = ability_bonus + 0.05 * snowrangerbonus
    end

    if event.rangeinverted and event.rangeinverted > 0.0 then
        local r = event.rangeinverted - 150
        local dist = (caster:GetAbsOrigin() - target:GetAbsOrigin()):Length()-150
        if dist < 0.0 then
            dist = 1.0
        end
        if r < 0.0 then
            r = 1.0
        end
        local bonusfactor = dist / r
        if bonusfactor > 1.0 then
            bonusfactor = 1.0
        end
        finaldamage = finaldamage*bonusfactor
    end

    if event.stackbased then
        local bonusfactor = 2*(target:GetModifierStackCount("modifier_dragon_dot", nil)-1)
        finaldamage = finaldamage + finaldamage*bonusfactor
    end

    if event.buffstackbasedbuff then
        local bonusfactor = target:GetModifierStackCount(event.buffstackbasedbuff, nil)
        finaldamage = finaldamage*bonusfactor
    end

    if event.stackpercentbased then
        local max = event.stackpercentbased
        local bonusfactor = target:GetModifierStackCount(event.stackbasedbuff, nil) / max
        finaldamage = finaldamage*bonusfactor
    end
    if event.stackthresholdbased then
        local max = event.stackthresholdbased
        local bonusfactor = target:GetModifierStackCount(event.stackbasedbuff, nil) / max
        if bonusfactor < 1.0 then
            finaldamage = 0.0
        end
    end

    local distance = (caster:GetAbsOrigin()-target:GetAbsOrigin()):Length()
    if event.rangeddoubledamage and event.rangeddoubledamage > 0 and distance > event.rangeddoubledamage then
        finaldamage = finaldamage*2
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_abaddon/abaddon_death_coil_explosion_e.vpcf", PATTACH_POINT_FOLLOW, target)
    end

    if caster:HasModifier("modifier_str_unholy") then
        finaldamage = finaldamage*1.4
        --ability_bonus = ability_bonus + 0.4
    end

    if event.warlockagony ~= nil then
    	finaldamage = 0.2*finaldamage*caster.AgonyCounter
    end

    if event.shadowstrikewl and caster:HasModifier("modifier_item_shadowstrike") then
        local b = 1
        if target:HasModifier("modifier_dot1") then
            b = b + 0.35
        end
        b = b + 0.35*target:GetModifierStackCount("modifier_dot2", nil)
        if target:HasModifier("modifier_dot4") then
            b = b + 0.35
        end
        finaldamage = finaldamage*b
    end

    if event.shadowstrikesp and caster:HasModifier("modifier_item_shadowstrike") then
        local b = 1
        if target:HasModifier("modifier_swd") then
            b = b + 0.35
        end
        local mods = target:GetModifierCount()-1
        for k=0, mods do
            local name = target:GetModifierNameByIndex(k)
            if name == "modifier_swd_2" then
                b = b + 0.35
            end
        end
        finaldamage = finaldamage*b
    end

    local dhabiltalent = caster:GetAbilityByIndex(0)
    if dhabiltalent and dhabiltalent:GetLevel() >= 4 and dhabiltalent:GetName() == "dh1" then
        --finaldamage = finaldamage * (1 + caster:GetAgility() * 0.0005)
        ability_bonus = ability_bonus + caster:GetAgility() * 0.0005
    end

    local dhchaostalent = caster:GetAbilityByIndex(3)
    if dhchaostalent and dhchaostalent:GetLevel() >= 3 and event.chaosstrike and caster:HasModifier("modifier_aoeantimagic_dh_buff") then
        finaldamage = finaldamage * 1.5
    end

    if caster:HasModifier("item_mother_of_dragons") then
	    --finaldamage = finaldamage*1.15
        ability_bonus = ability_bonus + 0.15
    end

    if event.t3bonus and caster:HasModifier("modifier_item_set_str_t3_full") then
        finaldamage = finaldamage*1.3
    end
    if event.brutalsetscale and caster:HasModifier("modifier_item_set_str_t3_2_full_dream") then
        finaldamage = finaldamage*3
    end

    --if event.t3bonus and caster:HasModifier("modifier_item_set_int_t3_full") then
    --    finaldamage = finaldamage*1.2
    --end

    if event.t3bonus and caster:HasModifier("modifier_item_set_agi_t3_full") then
        finaldamage = finaldamage*1.3
    end

    if caster:HasModifier("modifier_warlockrage") then
        finaldamage = finaldamage*1.4
    end

    local arcane_barrage_stacks = caster:GetModifierStackCount("modifier_arcane_barrage_bonus", nil)
    if event.isarcanebarrage and arcane_barrage_stacks > 0 then
        finaldamage = finaldamage * (1 + 0.1 * arcane_barrage_stacks)
    end
    
    if event.dreamfeastbonus and target:HasModifier("modifier_swd") then
        finaldamage = finaldamage * event.dreamfeastbonus
    end
    
    if event.starfallbonus and caster:HasModifier("modifier_starfall_talent_bonus") then
        caster:RemoveModifierByName("modifier_starfall_talent_bonus")
        finaldamage = finaldamage*1.5
    end
    if event.starfallbonus and caster:HasModifier("modifier_item_dmg4") then
        finaldamage = finaldamage*2
    end

    if caster:HasModifier("modifier_polybonusdamage") then
	    finaldamage = finaldamage*1.25
    end
    if caster:HasModifier("modifier_item_silverblood2_active") then
        finaldamage = finaldamage*1.25
    end
    if caster:HasModifier("modifier_item_int_set_t3_active") then
        finaldamage = finaldamage*1.3
    end
    if event.shadowdmg and caster:HasModifier("modifier_shadowdmgaura") then
	    --finaldamage = finaldamage*1.10
        elemental_bonus = elemental_bonus + 0.1
    end

    if event.warlockdrainbonus ~= nil then
    	local drainbonus = 1.0
    	if 	target:HasModifier("modifier_dot1") then
    		drainbonus = drainbonus + event.warlockdrainbonus
    	end
    	drainbonus = drainbonus + event.warlockdrainbonus*target:GetModifierStackCount("modifier_dot2", nil)
    	if 	target:HasModifier("modifier_dot4") then
    		drainbonus = drainbonus + event.warlockdrainbonus
    	end
    	finaldamage = finaldamage*drainbonus
    end

    local heroName = caster:GetUnitName()
	if heroName == "npc_dota_hero_disruptor" then
		finaldamage = finaldamage*1.25
	end

    if event.dragondmg and caster:HasModifier("item_mother_of_dragons") then
        finaldamage = finaldamage*3
    end

    -- Special effects for missiles
    if event.missileeffect == "icelance" and (target:HasModifier("modifier_icenova") or target:HasModifier("modifier_deepfreeze") or target:HasModifier("modifier_icenova_slow")) then
    	finaldamage = finaldamage*3
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_ancient_apparition/ancient_apparition_ice_blast_death.vpcf", PATTACH_POINT_FOLLOW, target)
    end
    if event.missileeffect == "icelance" and caster:HasModifier("modifier_winterschill") then
    	finaldamage = finaldamage*(1 + 0.5*caster:GetModifierStackCount("modifier_winterschill", nil))
    	caster:RemoveModifierByName("modifier_winterschill")
    end

    if finaldamage == 0 then 
        return
    end
    --spellcrits ALL
    local critchance = 0
    local critchancefactor = 1.0
    local critdmgbonusfactor = 1.0
    local critpossible = true
    if event.cannotcrit then
    	critpossible = false
    end
    local dmgtype = 1
    if ability ~= nil and not ability:IsNull() then
 		dmgtype = ability:GetAbilityDamageType()
 	end
 	if event.chaosbolt ~= nil then
 		critdmgbonusfactor = 1.15
 		critchancefactor = 2.5
 	end
 	if event.critchancefactor ~= nil then
 		critchancefactor = event.critchancefactor
 	end
 	if event.critdmgbonusfactor ~= nil then
 		critdmgbonusfactor = event.critdmgbonusfactor
 	end
 	local rangercritdmg = caster:GetAbilityByIndex(5)
 	if rangercritdmg and rangercritdmg:GetLevel() >= 4 and rangercritdmg:GetName() == "glacier_crack_spell" then
 		critdmgbonusfactor = critdmgbonusfactor + 0.25
 	end
    local roguecritchance = caster:GetAbilityByIndex(5)
    if roguecritchance and roguecritchance:GetLevel() >= 4 and roguecritchance:GetName() == "Shadow_Walk" then
        critchancefactor = critchancefactor + 0.4
    end
    if arcane_barrage_stacks > 0 and caster:GetAbilityByIndex(1):GetLevel() >= 3 then
        critchancefactor = critchancefactor + 0.06 * arcane_barrage_stacks
    end
    local dhcrittalent = caster:GetAbilityByIndex(3)
    if dhcrittalent and dhcrittalent:GetLevel() >= 3 and dhcrittalent:GetName() == "dh4" then
        critdmgbonusfactor = critdmgbonusfactor + 0.25
    end
    local axecrittalent = caster:GetAbilityByIndex(0)
    if axecrittalent and axecrittalent:GetLevel() >= 4 and axecrittalent:GetName() == "Wounding_Strike" then
        critdmgbonusfactor = critdmgbonusfactor + 0.25
    end
 	if caster:HasModifier("modifier_item_element_frost") then
 		critdmgbonusfactor = critdmgbonusfactor + 0.25
 	end
    if caster:HasModifier("modifier_item_crit_frost_immortal") then
        critdmgbonusfactor = critdmgbonusfactor + 0.3
    end
    if caster:HasModifier("modifier_crit_aura_dragon") then
        critdmgbonusfactor = critdmgbonusfactor + 0.2
    end
    if caster:HasModifier("modifier_item_windforce2") then
        critdmgbonusfactor = critdmgbonusfactor + 0.25
    end
    if caster:HasModifier("modifier_item_bootscrit_2") then
        critdmgbonusfactor = critdmgbonusfactor + 0.5
    end
    if caster:HasModifier("modifier_item_bootscrit2") then
        critdmgbonusfactor = critdmgbonusfactor + 0.75
    end
    if caster:HasModifier("modifier_crit_dmg_t3") then
        critdmgbonusfactor = critdmgbonusfactor + 0.4
    end
    if caster.runeword and caster.runeword[12] then
        critdmgbonusfactor = critdmgbonusfactor + caster.runeword[12] / 100
    end
    
    if critpossible == true and caster:HasModifier("modifier_fury_crit") then
        critchance = critchancefactor * caster:GetModifierStackCount("modifier_fury_crit", nil)
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*10*critdmgbonusfactor
            critpossible = false
            caster:RemoveModifierByName("modifier_fury_crit")
        end
    end
    if critpossible == true and caster.talents and caster.talents[22] and caster.talents[22] > 0 and caster.moonlightcrits and caster.moonlightcrits > 0 and not event.dragondmg then
        finaldamage = finaldamage*2.75*caster.talents[22]*critdmgbonusfactor
        critpossible = false
        if caster:HasModifier("modifier_item_windforce4") then
            finaldamage = finaldamage*1.25
        end
        caster.moonlightcrits = caster.moonlightcrits - 1
    end
    if critpossible == true and is_big_hit and caster.talents and caster.talents[22] and caster.talents[22] > 0 and not caster:HasModifier("modifier_crit_moon_cd") and not event.dragondmg then
        finaldamage = finaldamage*2.75*caster.talents[22]*critdmgbonusfactor
        critpossible = false
        local ancient = 0
        if caster:HasModifier("modifier_item_windforce4") then
            ancient = 5
            finaldamage = finaldamage*1.25
        end
        passive_ability:ApplyDataDrivenModifier(caster, caster, "modifier_crit_moon_cd", { Duration = 20-ancient})
        if caster:HasModifier("modifier_item_set_agi_t3_full_dream") then
            caster.moonlightcrits = 2
        end
    end
    local prot_counter_blow = caster:GetModifierStackCount("modifier_counter_blow", nil)
    if critpossible == true and prot_counter_blow >= 5 then
        critchance = 100*critchancefactor
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*7.5*critdmgbonusfactor
            critpossible = false
            caster:RemoveModifierByName("modifier_counter_blow")
        end
    end
 	if critpossible == true and event.envenom and caster:HasModifier("modifier_coldblood") then
 		local lvl = caster:GetAbilityByIndex(4):GetLevelSpecialValueFor("crit", (caster:GetAbilityByIndex(4):GetLevel() - 1))
	    finaldamage = finaldamage*lvl*critdmgbonusfactor
	    critpossible = false
	    caster:RemoveModifierByName("modifier_coldblood")
    end
    if critpossible == true and caster:HasModifier("modifier_mythic_abilcrit") then
        critchance = critchancefactor * caster:GetModifierStackCount("modifier_mythic_abilcrit", nil)
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*5*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and caster:HasModifier("modifier_item_crit_pure_immortal2") then
        critchance = 20*critchancefactor
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*5*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and caster:HasModifier("modifier_item_crit_pure_immortal3") then
        critchance = 20*critchancefactor
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*6*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and caster:HasModifier("modifier_ancient_def") then
        critchance = 5*critchancefactor
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*5*critdmgbonusfactor
            critpossible = false
        end
    end
    local sptocrit = caster:GetAbilityByIndex(2)
    if critpossible == true and sptocrit and sptocrit:GetName() == "Molten_Lava" and sptocrit:GetLevel() >= 4 then
        critchance = 0.01*GetSpellpower(event)*critchancefactor
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*5*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and caster:HasModifier("modifier_druid_sun_crit") then
        critchance = 5
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*5*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and caster:HasModifier("modifier_item_crit_pure_5") then
        critchance = 15*critchancefactor
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*4.5*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and caster:HasModifier("modifier_item_crit_pure_immortal") then
        critchance = 20*critchancefactor
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*4*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and caster:HasModifier("modifier_item_warglaive") then
        critchance = 6*critchancefactor
        if event.eviscritbonus ~= nil then
            critchance = critchance*1.35
        end
        if caster:HasModifier("modifier_bow_crit_legendary") then
            critchance = 100
        end
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*3.5*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and caster:HasModifier("modifier_item_crit_pure_3") then
        critchance = 15*critchancefactor
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*3*critdmgbonusfactor
            critpossible = false
        end
    end
    local agitocrit = caster:GetAbilityByIndex(4)
    if critpossible == true and agitocrit and agitocrit:GetName() == "wind5" and agitocrit:GetLevel() >= 4 then
        critchance = caster:GetPrimaryStatValue()*0.05*critchancefactor
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*3*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and caster.runeword and caster.runeword[20] and caster.runeword[20] > 0 then
        critchance = caster.runeword[20]
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*3*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and caster:HasModifier("modifier_lifesteal_double") then
        critchance = 20*critchancefactor
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*3*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and caster:HasModifier("modifier_item_crit_pure") then
        critchance = 7*critchancefactor
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*2.5*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and caster.talents and caster.talents[37] and caster.talents[37] > 0 then
        critchance = 3*caster.talents[37]
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*2.5*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and caster:HasModifier("modifier_item_druid_glove_crit") then
        critchance = 7*critchancefactor
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*2.5*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and caster:HasModifier("modifier_item_crit_pure_2") then
        critchance = 10*critchancefactor
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*2.5*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and caster:HasModifier("modifier_item_crit_pure_4") then
        critchance = 10*critchancefactor
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*2.5*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and caster:HasModifier("modifier_item_set_agi_set_crit") then
        critchance = 5*critchancefactor
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*2.75*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and (caster:HasModifier("modifier_item_crit_pure_5_lifesteal") or caster:HasModifier("modifier_item_crit_pure_5_lifesteal_no_ls") ) then
        finaldamage = finaldamage*2.25*critdmgbonusfactor
        critpossible = false
    end
    if critpossible == true and caster:HasModifier("modifier_item_bootscrit2") then
        critchance = 12*critchancefactor
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*2.5*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and caster:HasModifier("modifier_item_endgame5") then
    	critchance = 16*critchancefactor
    	if event.eviscritbonus ~= nil then
    		critchance = critchance*1.35
    	end
    	if math.random(1,100) <= critchance then
	    	finaldamage = finaldamage*2.25*critdmgbonusfactor
	    	critpossible = false
    	end
    end
    if critpossible == true and event.naturedmg and caster:HasModifier("modifier_item_elements") and not caster:HasModifier("modifier_innercd_nature") then
    	local table3 = {}
    	table3.Duration = 20
	    caster.itemelemental:ApplyDataDrivenModifier(caster, caster, "modifier_innercd_nature", table3)
	    finaldamage = finaldamage*6*critdmgbonusfactor
	    critpossible = false
    end
    if critpossible == true and caster:HasModifier("modifier_item_bootscurse") then
        critchance = 15*critchancefactor
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*2*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and caster:HasModifier("modifier_item_bootscrit") then
    	critchance = 11*critchancefactor
    	if event.eviscritbonus ~= nil then
    		critchance = critchance*1.35
    	end
    	if math.random(1,100) <= critchance then
	    	finaldamage = finaldamage*1.85*critdmgbonusfactor
	    	critpossible = false
    	end
    end
    if critpossible == true and caster:HasModifier("modifier_item_bootscrit_2") then
        critchance = 11*critchancefactor
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*2.25*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and event.froststrikecrit and caster:GetModifierStackCount("modifier_frostrune", nil) >= 3 then
        critchance = 100*critchancefactor
        if math.random(1,100) <= critchance then
            caster:RemoveModifierByName("modifier_frostrune")
            finaldamage = finaldamage*3*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and caster:HasModifier("modifier_item_caster6") then
    	critchance = 12*critchancefactor
    	if event.eviscritbonus ~= nil then
    		critchance = critchance*1.35
    	end
    	if math.random(1,100) <= critchance then
	    	finaldamage = finaldamage*1.75*critdmgbonusfactor
	    	critpossible = false
    	end
    end
    if critpossible == true and caster:HasModifier("modifier_item_bowupgradeproc") then
    	critchance = 100*critchancefactor
    	if event.eviscritbonus ~= nil then
    		critchance = critchance*1.35
    	end
    	if math.random(1,100) <= critchance then
    		local dist = (caster:GetAbsOrigin()-target:GetAbsOrigin()):Length()
    		if dist > 300.0 then
		    	finaldamage = finaldamage*1.75*critdmgbonusfactor
		    	critpossible = false
		    end
    	end
    end
    if critpossible == true and caster:HasModifier("modifier_item_weapon9") then
    	critchance = 21*critchancefactor
    	if event.eviscritbonus ~= nil then
    		critchance = critchance*1.35
    	end
    	if math.random(1,100) <= critchance then
	    	finaldamage = finaldamage*1.5*critdmgbonusfactor
	    	critpossible = false
    	end
    end
    if event.inspiringshot and caster:HasModifier("glacier_trap_guaranteed_crit") then
    	caster:RemoveModifierByName("glacier_trap_guaranteed_crit")
	    finaldamage = finaldamage*1.5
    end
    if critpossible == true and caster:HasModifier("modifier_item_endgame9") then
    	critchance = 21*critchancefactor
    	if event.eviscritbonus ~= nil then
    		critchance = critchance*1.35
    	end
    	if math.random(1,100) <= critchance then
	    	finaldamage = finaldamage*2.05*critdmgbonusfactor
	    	critpossible = false
    	end
    end
    if critpossible == true and caster:HasModifier("modifier_item_weapon10") then
    	critchance = 10*critchancefactor
    	if event.eviscritbonus ~= nil then
    		critchance = critchance*1.35
    	end
    	if math.random(1,100) <= critchance then
	    	finaldamage = finaldamage*2.15*critdmgbonusfactor
	    	critpossible = false
    	end
    end
    if critpossible == true and caster:HasModifier("modifier_item_endgame10") then
    	critchance = 14*critchancefactor
    	if event.eviscritbonus ~= nil then
    		critchance = critchance*1.35
    	end
    	--print("test for blade")
    	if math.random(1,100) <= critchance then
	    	finaldamage = finaldamage*2.75*critdmgbonusfactor
	    	--print("high crit")
	    	critpossible = false
    	end
    end
    if caster:HasModifier("modifier_guaranteed_dmg_once") then
	    finaldamage = finaldamage*5.0
	    caster:RemoveModifierByName("modifier_guaranteed_dmg_once")
    end
    if caster:HasModifier("modifier_energy_doubled") then
        finaldamage = finaldamage*1.25
    end
    if critpossible == true and caster:HasModifier("modifier_crit_aura_dragon") then
        critchance = 3*critchancefactor
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*2.0*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and caster:HasModifier("modifier_guaranteed_crit_once") then
        critchance = 100*critchancefactor
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*2.0*critdmgbonusfactor
            critpossible = false
            caster:RemoveModifierByName("modifier_guaranteed_crit_once")
        end
    end
    local armortocrit = caster:GetAbilityByIndex(5)
    if critpossible == true and armortocrit and armortocrit:GetName() == "Switch_Battle_Stance_Prot" and armortocrit:GetLevel() >= 3 then
    	critchance = caster:GetPhysicalArmorValue()*critchancefactor/2
    	if math.random(1,100) <= critchance then
	    	finaldamage = finaldamage*1.75*critdmgbonusfactor
	    	critpossible = false
    	end
    end
    if critpossible == true and event.beartrapcrit and caster.owner and caster.owner:GetAbilityByIndex(2) and caster.owner:GetAbilityByIndex(2):GetLevel() >= 3 and target:HasModifier("modifier_bear_trap") then
	    finaldamage = finaldamage*2.5*critdmgbonusfactor
	    critpossible = false
    end
    if critpossible == true and caster:HasModifier("modifier_item_allrecipe4") then
    	local life = math.floor(100-(100*caster:GetHealth()/caster:GetMaxHealth()))
    	if event.eviscritbonus ~= nil then
    		critchance = critchance*1.35
    	end
    	if math.random(1,100) <= life then
	    	finaldamage = finaldamage*1.5*critdmgbonusfactor
	    	critpossible = false
    	end
    end
    if critpossible == true and caster.FeralFinisherCrit ~= nil and target:HasModifier("modifier_bleed2") then
    	critchance = caster:GetStrength()*2
    	if math.random(1,100) <= critchance then
	    	finaldamage = finaldamage*1.5*critdmgbonusfactor
	    	critpossible = false
    	end
    end
    if critpossible == true and heroName == "npc_dota_hero_oracle" and caster:GetAbilityByIndex(1):GetLevel() >= 3 then
    	critchance = 10*critchancefactor
    	if math.random(1,100) <= critchance then
	    	finaldamage = finaldamage*2*critdmgbonusfactor
	    	critpossible = false
    	end
    end
    local talentcritstacks = caster:GetModifierStackCount("modifier_crit_stacks", nil)
    if critpossible == true and talentcritstacks > 0 then
    	critchance = talentcritstacks*15*critchancefactor
    	if math.random(1,100) <= critchance then
	    	finaldamage = finaldamage*1.5*critdmgbonusfactor
	    	critpossible = false
    	end
    end
    if critpossible == true and event.rikicrit and caster:GetAbilityByIndex(0):GetName() == "hawk1" and caster:GetAbilityByIndex(0):GetLevel() >= 3 then
    	critchance = 10*critchancefactor
    	if math.random(1,100) <= critchance then
	    	finaldamage = finaldamage*2*critdmgbonusfactor
	    	critpossible = false
    	end
    end
    if critpossible == true and caster:HasModifier("modifier_guaranteed_crit") then
    	critchance = 100*critchancefactor
    	if math.random(1,100) <= critchance then
	    	finaldamage = finaldamage*1.5*critdmgbonusfactor
	    	critpossible = false
    	end
    end
    if critpossible == true and event.critchance200 then
    	critchance = event.critchance200*critchancefactor
    	if event.eviscritbonus ~= nil then
    		critchance = critchance*1.35
    	end
    	if math.random(1,100) <= critchance then
	    	finaldamage = finaldamage*2.0*critdmgbonusfactor
	    	critpossible = false
    	end
    end
    if critpossible == true and event.lavaburst and target:HasModifier("modifier_lavashock") then
    	critchance = 100*critchancefactor
    	--print("test for blade")
    	if math.random(1,100) <= critchance then
	    	finaldamage = finaldamage*event.lavaburst*critdmgbonusfactor
	    	--print("high crit")
	    	critpossible = false
    	end
    end
    if critpossible == true and event.alwayscrit125onbuff and target:HasModifier(event.alwayscrit125onbuff) then
        critchance = 30*critchancefactor
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*1.25*critdmgbonusfactor
            critpossible = false
        end
    end
    

    local was_crit = false
    if critpossible == false and not event.cannotcrit then
        was_crit = true
    end

    if caster.consecutive_crits then
        if was_crit then
            caster.consecutive_crits = caster.consecutive_crits + 1
        else
            caster.consecutive_crits = 0
        end
    else
        if was_crit then
            caster.consecutive_crits = 1
        else
            caster.consecutive_crits = 0
        end
    end

    if was_crit and caster:HasModifier("modifier_crit_dmg_riki_50") then
        finaldamage = finaldamage*1.5
    end
    if caster:HasModifier("modifier_shadowstep1") then
        finaldamage = finaldamage*1.15
    end
    if caster:HasModifier("modifier_axe_dmg_titan") then
        finaldamage = finaldamage*1.25
    end
    if caster:HasModifier("modifier_tigerfury") then
        finaldamage = finaldamage*1.4
    end
    local furycatstacks = caster:GetModifierStackCount("modifier_furycat", nil)
    if event.feralleapbonus and furycatstacks > 0 then
        finaldamage = finaldamage* (1 + 0.25 * furycatstacks)
    end
    local icenovastacks = caster:GetModifierStackCount("modifier_ice_nova_bonus", nil)
    if event.frostdmg and icenovastacks > 0 then
        finaldamage = finaldamage* (1 + 0.1 * icenovastacks)
    end
    local abil_dmg_stacks_5 = caster:GetModifierStackCount("modifier_abil_bonus_5_percent", nil)
    if abil_dmg_stacks_5 > 0 then
        finaldamage = finaldamage* (1 + 0.05 * abil_dmg_stacks_5)
    end
    
    
    --talents2
    if caster.talents then
        if was_crit and caster.talents[17] then
            finaldamage = finaldamage * (1 + 0.06 * caster.talents[17])
        end
        if was_crit and caster.talents[45] and caster.talents[45] > 0 and caster.consecutive_crits and caster.consecutive_crits >= 5 then
            passive_ability:ApplyDataDrivenModifier(caster, caster, "modifier_talent_enrage_2", {Duration = 2*caster.talents[45]})
        end
        if was_crit and caster.talents[47] and caster.talents[47] > 0 then
            if caster.critcounter then
                caster.critcounter = caster.critcounter + 1
                if caster.critcounter == 50 then
                    caster.critcounter = 0
                    passive_ability:ApplyDataDrivenModifier(caster, caster, "modifier_talent_enrage", {Duration = 5*caster.talents[47]})
                end
            else
                caster.critcounter = 1
            end
            if caster.critcounter == 0 then
                caster:RemoveModifierByName("modifier_talent_critcounter")
            else
                passive_ability:ApplyDataDrivenModifier(caster, caster, "modifier_talent_critcounter", {Duration = -1})
                caster:SetModifierStackCount("modifier_talent_critcounter", passive_ability, caster.critcounter)
            end
        end
        if caster:HasModifier("modifier_talent_enrage") then
            local ancient = 1.5
            if caster:HasModifier("modifier_item_sp4") then
                ancient = 1.75
            end
            finaldamage = finaldamage * ancient
            if caster.runeword and caster.runeword[14] then
                finaldamage = finaldamage * (1 + caster.runeword[14]/100)
            end
        end
        if caster:HasModifier("modifier_talent_enrage_2") then
            finaldamage = finaldamage * 1.5
        end
        --unused
        --if not was_crit and caster.talents[32] then
        --    finaldamage = finaldamage * (1 + 0.10 * caster.talents[32])
        --end
    end

    --cp on crit
    if event.cponcrit and event.cponcrit > 0 and critpossible == false then
    	if not caster.ComboPoints then
    		caster.ComboPoints = 0
    	end
    	if caster.ComboPoints < 3 then
    		caster.ComboPoints = caster.ComboPoints + 1
    	end
		event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_combopoint", tab)
		caster:SetModifierStackCount("modifier_combopoint", event.ability, caster.ComboPoints)
    end
    if event.oncritrunic and was_crit and caster.Energy then
        local myevent = {}
        myevent.caster = caster
        myevent.energy = event.oncritrunic
        if caster:GetMana() > 35 then
            Timers:CreateTimer(0.02,function()
                AddEnergy(myevent)
            end)
        else
            AddEnergy(myevent)
        end
    end
    if event.refundoncrit and event.refundoncrit > 0 and critpossible == false and not caster:HasModifier("modifier_manacost_reduction") then
		event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_manacost_reduction", tab)
		EmitSoundOn("drowranger_dro_spawn_04", caster)
    end

    if event.critmanareg and critpossible == false then
    	caster:SetMana(caster:GetMana()+(caster:GetMaxMana()*event.critmanareg/100.0))
    	ParticleManager:CreateParticle("particles/items3_fx/mango_active.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
    end

    if event.oncritswp and event.oncritswp > 0 and critpossible == false and not event.cannotcrit then
    	if math.random(1,100) <= event.oncritswp and not caster:HasModifier("modifier_swd_2_proc_cd") and (caster:GetAbsOrigin()-target:GetAbsOrigin()):Length() < 2500 then
	    	event.ability:ApplyDataDrivenModifier(caster, target, "modifier_swd_2_proc", nil)
            event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_swd_2_proc_cd", nil)
    	end
    end

    if event.oncritbuff and was_crit then
        event.ability:ApplyDataDrivenModifier(caster, caster, event.oncritbuff, nil)
    end
    if event.on2critbuff then
        if was_crit then
            if caster.on2crit then
                caster.on2crit = caster.on2crit  + 1
                if caster.on2crit >= 2 then
                    event.ability:ApplyDataDrivenModifier(caster, caster, event.on2critbuff, nil)
                    caster.on2crit = 0
                end
            else
                caster.on2crit = 1
            end
        else
            caster.on2crit = 0
        end
    end
    if event.oncritdebuff and was_crit then
        event.ability:ApplyDataDrivenModifier(caster, target, event.oncritdebuff, nil)
    end

    if was_crit and caster:HasModifier("modifier_item_netherchaos") and event.netherchaos then
        finaldamage = finaldamage * 2.5
    end
    if was_crit and caster:HasModifier("modifier_item_netherchaos") and event.netherchaos_low then
        finaldamage = finaldamage * 1.5
    end
    if event.chaosstrike and caster:HasModifier("modifier_metamorph_dh") then
        finaldamage = finaldamage * event.chaosstrike
    end
    --champion prot
    if event.championprot and caster:HasModifier("modifier_item_straxe2") then
        local shieldbashstack = caster:GetModifierStackCount("modifier_shieldbash", caster)
        finaldamage = finaldamage * (1.0 + 0.1 * shieldbashstack)
    end

    if event.oncritcdreduce and event.oncritcdreduce > 0 and critpossible == false and not event.cannotcrit then
    	event.amount = event.oncritcdreduce
    	ReduceCooldown(event)
    end

    if event.asoncrit and event.asoncrit > 0 and critpossible == false and not event.cannotcrit then
    	event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_asbonus", nil)
    end

    if event.critmanacat and event.critmanacat > 0 and critpossible == false then
    	if caster.OldMana then
    		caster.OldMana = caster.OldMana + event.critmanacat
    	end
    end

    local talentwarriorcritdot = caster:GetAbilityByIndex(5)
    if critpossible == false and not event.cannotcrit and not caster.armstalentdotcd and not event.talentarmsnodot and talentwarriorcritdot and talentwarriorcritdot:GetLevel() >= 4 and talentwarriorcritdot:GetName() == "Switch_Battle_Stance" then
    	caster.armstalentdotcd = true
        Timers:CreateTimer(2,function()
            caster.armstalentdotcd = false
        end)
        local myevent = {}
		myevent.caster = caster
		myevent.target = target
		myevent.buff = "modifier_arms_bleed_crit"
		myevent.ability = talentwarriorcritdot
		myevent.dur = 6
		ApplyBuff(myevent)
    end
    local talentfurytitan = caster:GetAbilityByIndex(5)
    if talentfurytitan and talentfurytitan:GetLevel() >= 4 and talentfurytitan:GetName() == "fury6" then
        finaldamage = finaldamage * 1.15
    end

    if critpossible == false and not event.cannotcrit and event.lancecritproc and event.lancecritproc > 0 then
    	if math.random(1,100) <= event.lancecritproc then
	    	event.ability:ApplyDataDrivenModifier(caster, target, "modifier_lavalance_proc", nil)
		end
    end

    if event.lancestunproc and event.lancestunproc > 0 then
    	local lancestacks = caster:GetModifierStackCount("modifier_lancestun_proc", nil)
	    if lancestacks >= 5 then
            finaldamage = finaldamage * 2
	    	caster:RemoveModifierByName("modifier_lancestun_proc")
	    	local myevent = {}
    		myevent.caster = caster
    		myevent.target = target
    		myevent.buff = "modifier_stunned"
			myevent.ability = event.ability
			myevent.dur = event.lancestunproc
			ApplyBuff(myevent)
	    end
    end

    --beastmaster crits cd reduce
    local beastcdreduce = caster:GetAbilityByIndex(3)
    if critpossible == false and not event.cannotcrit and beastcdreduce and beastcdreduce:GetName() == "Beastrage" and beastcdreduce:GetLevel() >= 4 then
    	local abil = beastcdreduce:GetCooldownTimeRemaining()
    	if abil > 0.1 then
    		beastcdreduce:EndCooldown()
    		beastcdreduce:StartCooldown(abil-5)
    	end
    end

    -- elemental item stuff
 	if caster:HasModifier("modifier_item_elements") then
 		local table3 = {}
    	if event.frostdmg and caster.itemelemental then
    		local myevent = {}
    		myevent.caster = caster
    		myevent.target = target
    		myevent.buff = "modifier_frostslow10"
			myevent.ability = caster.itemelemental
			myevent.dur = 5
			ApplyBuff(myevent)
    		--caster.itemelemental:ApplyDataDrivenModifier(caster, target, "modifier_frostslow10", nil)
    	end
    	if event.firedmg then
    		if event.burndot then
    			finaldamage = finaldamage * 1.25
    		end
    		if caster.itemelemental and not caster:HasModifier("modifier_innercd_fire") then
	    		if math.random(1,100) <= 100 then
			    	local myevent = {}
		    		myevent.caster = caster
		    		myevent.target = target
		    		myevent.buff = "modifier_stunned"
					myevent.ability = event.ability
					myevent.dur = 2
					ApplyBuff(myevent)

	    			ParticleManager:CreateParticle("particles/econ/items/invoker/glorious_inspiration/invoker_forge_spirit_death_esl_explode.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
	    			table3.Duration = 30
	    			caster.itemelemental:ApplyDataDrivenModifier(caster, caster, "modifier_innercd_fire", table3)
	    			particle = ParticleManager:CreateParticle("particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_shadowraze_end_smoke.vpcf", PATTACH_POINT_FOLLOW, target)
			    end
			end
    	end
    end

    if event.firedmg and caster:HasModifier("firedmgaura") then
    	--finaldamage = finaldamage * 1.1
        elemental_bonus = elemental_bonus + 0.1
    end
    if (event.firedmg or event.shadowdmg) and caster:HasModifier("modifier_shadowflame") then
        --finaldamage = finaldamage * 1.25
        elemental_bonus = elemental_bonus + 0.25
    end
    if (event.arcanedmg or event.naturedmg) and caster:HasModifier("modifier_stormrider") then
        --finaldamage = finaldamage * 1.25
        elemental_bonus = elemental_bonus + 0.25
    end
    if event.arcanedmg and caster:HasModifier("modifier_nether_explosion_buff") then
        --finaldamage = finaldamage * 1.15
        elemental_bonus = elemental_bonus + 0.25
    end
    if event.firedmg and caster:HasModifier("modifier_stormrider2") then
        --finaldamage = finaldamage * 1.4
        elemental_bonus = elemental_bonus + 0.4
    end
    --mythic
    if event.firedmg and caster:HasModifier("modifier_mythic_firedmg") then
        --finaldamage = finaldamage * (1 + )
        elemental_bonus = elemental_bonus + caster:GetModifierStackCount("modifier_mythic_firedmg", nil)/100
    end
    if event.arcanedmg and caster:HasModifier("modifier_mythic_arcanedmg") then
        --finaldamage = finaldamage * (1 + caster:GetModifierStackCount("modifier_mythic_arcanedmg", nil)/100)
        elemental_bonus = elemental_bonus + caster:GetModifierStackCount("modifier_mythic_arcanedmg", nil)/100
    end
    if event.naturedmg and caster:HasModifier("modifier_mythic_naturedmg") then
        --finaldamage = finaldamage * (1 + caster:GetModifierStackCount("modifier_mythic_naturedmg", nil)/100)
        elemental_bonus = elemental_bonus + caster:GetModifierStackCount("modifier_mythic_naturedmg", nil)/100
    end
    if event.naturedmg and caster:HasModifier("modifier_ranger_as_bonus_surv") then
        elemental_bonus = elemental_bonus + 0.25
    end
    if event.shadowdmg and caster:HasModifier("modifier_mythic_shadowdmg") then
        --finaldamage = finaldamage * (1 + caster:GetModifierStackCount("modifier_mythic_shadowdmg", nil)/100)
        elemental_bonus = elemental_bonus + caster:GetModifierStackCount("modifier_mythic_shadowdmg", nil)/100
    end
    if event.frostdmg and caster:HasModifier("modifier_mythic_frostdmg") then
        --finaldamage = finaldamage * (1 + caster:GetModifierStackCount("modifier_mythic_frostdmg", nil)/100)
        elemental_bonus = elemental_bonus + caster:GetModifierStackCount("modifier_mythic_frostdmg", nil)/100
    end
    if dmgtype == 1 and caster:HasModifier("modifier_mythic_physicaldmg") then
        --finaldamage = finaldamage * (1 + caster:GetModifierStackCount("modifier_mythic_physicaldmg", nil)/100)
        elemental_bonus = elemental_bonus + caster:GetModifierStackCount("modifier_mythic_physicaldmg", nil)/100
    end

    if caster:HasModifier("modifier_mythic_abil") then
        --finaldamage = finaldamage * (1 + caster:GetModifierStackCount("modifier_mythic_abil", nil)/100)
        ability_bonus = ability_bonus + caster:GetModifierStackCount("modifier_mythic_abil", nil)/100
    end

    if event.poisondmg and caster:HasModifier("modifier_item_viper_blade") then
        --finaldamage = finaldamage * 1.75
        elemental_bonus = elemental_bonus + 0.75
    end
    if event.poisondmg and caster:HasModifier("modifier_item_viper_blade2") then
        --finaldamage = finaldamage * 1.75
        elemental_bonus = elemental_bonus + 0.75
    end

    if event.moonburn and caster:HasModifier("modifier_moonburn_cd") then
        finaldamage = finaldamage * 2
    end

    if (event.firedmg or event.naturedmg or event.frostdmg) and caster:HasModifier("modifier_master_elements") then
    	--finaldamage = finaldamage * 1.2
        elemental_bonus = elemental_bonus + 0.2
    end
    if event.naturedmg and caster:HasModifier("modifier_item_nova_blade") then
        --finaldamage = finaldamage * 1.25
        elemental_bonus = elemental_bonus + 0.25
    end
    if event.naturedmg and caster:HasModifier("modifier_item_nova_blade2") then
        --finaldamage = finaldamage * 1.25
        elemental_bonus = elemental_bonus + 0.4
    end
    local rangerelementtalent = caster:GetAbilityByIndex(5)
    if (event.firedmg or event.naturedmg or event.shadowdmg) and rangerelementtalent and rangerelementtalent:GetName() == "wind7" and rangerelementtalent:GetLevel() >= 4 then
        --finaldamage = finaldamage * 1.15
        elemental_bonus = elemental_bonus + 0.15
    end
    local disctalent = caster:GetAbilityByIndex(3)
    if disctalent and disctalent:GetName() == "Soul_Burn" and disctalent:GetLevel() >= 3 then
        finaldamage = finaldamage * 1.1
    end
    if (event.firedmg or event.frostdmg) and caster:HasModifier("modifier_item_frostfire") then
        --finaldamage = finaldamage * 1.2
        elemental_bonus = elemental_bonus + 0.2
    end

    if event.frostdmg then
        if caster:HasModifier("modifier_item_element_frost") then
            --frostbonus = frostbonus + 0.3
            elemental_bonus = elemental_bonus + 0.3
        end
        if caster:HasModifier("modifier_item_crit_frost_immortal") then
            --frostbonus = frostbonus + 0.45
            elemental_bonus = elemental_bonus + 0.45
        end
    end
    if event.shadowdmg and caster:HasModifier("modifier_item_elements") then
        --finaldamage = finaldamage * 1.25
        elemental_bonus = elemental_bonus + 0.25
    end

    if event.feralleapbonus and caster:HasModifier("modifier_asbonus") then
        finaldamage = finaldamage * 1.5
    end

    --arcane weaken
    if caster:HasModifier("modifier_arcaneweak") and event.arcanedmg and event.netherblast then
    	local stacks = caster:GetModifierStackCount("modifier_arcaneweak", nil)
    	if caster:GetMana() >= 0.4*15*stacks then
 			finaldamage = finaldamage * (1.0 + 0.3*stacks)
 			caster:SetMana(caster:GetMana() - 0.4*15*stacks)
 		end
 	end

 	if target:HasModifier("modifier_frost_bonus_arctic") and event.frostdmg then
 		--finaldamage = finaldamage * 1.2
        elemental_bonus = elemental_bonus + 0.2
 	end

    --cp based scaling
    if event.cpbaseddmg then
    	finaldamage = finaldamage * caster.cpbaseddmg
    end

    if event.mutilate then
    	finaldamage = finaldamage * (1 + (event.mutilate*target:GetModifierStackCount("modifier_deadlypoison", nil)/100))
    end

    --pve scaling
    if event.pvescale then
    	finaldamage = finaldamage * caster.pvescale
    end

    --block
    if target and target:HasModifier("modifier_temple_block_boss") then
        local reduction = target:GetMaxHealth() * 0.0015
        finaldamage = finaldamage - reduction
        if finaldamage < 0.0 then
            finaldamage = 0.0
        end
    end

    -- set damage table
    finaldamage = finaldamage * nodamageatall * ability_bonus * elemental_bonus

    local damage_table = {}
 	damage_table.victim = target
 	damage_table.attacker = caster
 	damage_table.ability = ability
 	if ability == nil then
 		damage_table.damage_type = 1
 	else
        if ability:IsNull() then
            return
        end
 		damage_table.damage_type = ability:GetAbilityDamageType()
 		if (target:HasModifier("modifier_armoriron") and ability:GetAbilityDamageType() == 1 and math.random(1,100) <= 1000 ) or caster:HasModifier("modifier_valyrian") or (event.critignorearmor and not critpossible) then
 			--damage_table.damage_flag = DOTA_DAMAGE_FLAG_IGNORES_PHYSICAL_ARMOR
 			damage_table.damage_type = DAMAGE_TYPE_PURE
 			--local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_riki/riki_tricks_dagger_hit_sparks.vpcf", PATTACH_POINT_FOLLOW, target)
 			local particle = ParticleManager:CreateParticle("particles/econ/items/antimage/antimage_weapon_basher_ti5_gold/am_manaburn_basher_ti_5_gold.vpcf", PATTACH_POINT_FOLLOW, target)
 		end
 	end
    if event.puredmg then
        damage_table.damage_type = DAMAGE_TYPE_PURE
    end

    --fix damage
    --finaldamage = finaldamage * 0.01
 	
 	--print("total dmg " .. finaldamage)
 	damage_table.damage = finaldamage

 	if damage_table.damage_type == 0 then
 		damage_table.damage_type = 2
 	end

    --print(event.includeauto)
    --print(finaldamage)

 	if event.dontbreakcc ~= nil and CheckForBreakableCC(target) then

 	else
 		--print("final dmg " .. damage_table.damage)

        --talents applied late, after amplifications
        if caster.talents then
            if caster.talents[4] then
                if not event.notalent4proc and not caster.talent4cd and math.random(1,100) <= 3*caster.talents[4] then
                    caster.talent4cd = true
                    Timers:CreateTimer(2.5,function() 
                        caster.talent4cd = false
                    end)
                    local myevent = { caster = caster, target = target, dur = 10, buff = "modifier_dot", ability = passive_ability}
                    ApplyBuff(myevent)
                end
            end
            if caster.talents[7] then
                local buff = "modifier_strength_multi"
                if caster:GetPrimaryAttribute() == 1 then
                    buff = "modifier_agility_multi"
                elseif caster:GetPrimaryAttribute() == 2 then
                    buff = "modifier_intellect_multi"
                end
                for i=1, caster.talents[7] * 2 do
                    local myevent = { caster = caster, target = caster, dur = 2, buff = buff, ability = passive_ability}
                    ApplyBuff(myevent)
                end
            end
        end
        --rune word
        if caster.runeword and caster.runeword[15] then
            damage_table.damage = damage_table.damage + caster:GetHealth() * 0.01 * caster.runeword[15]
        end

 		ApplyDamage(damage_table)

        --bloodswipe proc
        --[[
        if (caster:HasModifier("modifier_item_set_str_tank_full_t1") or caster:HasModifier("modifier_item_set_str_tank_3") or caster:HasModifier("modifier_item_set_str_tank_full_t1_dream")) and not event.isbloodswipeproc then
            if math.random(1,100) <= 10 then
                local factor = 0.5
                if caster:HasModifier("modifier_item_set_str_tank_full_t1_dream") then
                    factor = 1.0
                end
                local tab = {}
                tab.isbloodswipeproc = true
                tab.caster = caster
                tab.target = target
                tab.damage = damage_table.damage * factor
                tab.cannotcrit = true
                DamageUnit(tab)
                BloodHitFX(event)
            end
        end]]

        if was_crit then
            CriticalStrikeFX(caster, target, finaldamage, dmgtype, 1)
        end
 		if caster:HasModifier("modifier_item_flamefury") or caster:HasModifier("modifier_item_flamefury2") then
     		FlameFury(event)
 		end
        
 		-- self damaging spells
 		if event.damageself ~= nil then
 			damage_table.victim = caster
 			damage_table.attacker = target
 			damage_table.damage = damage_table.damage*event.damageself
 			ApplyDamage(damage_table)
 			
 		end
 	end
	 
	if event.mindflaybonus ~= nil and target:HasModifier("modifier_swd") then
		local tab = {}
		tab.caster = caster
		tab.target = caster
		tab.heal = finaldamage / 10
		tab.spelldamagefactor = 0.0
		tab.attributefactor = 0.0
		tab.ability = event.ability
		tab.hidenumber = 1
		HealUnit(tab)
		local tab2 = {}
		tab2.caster = caster
		tab2.amount = finaldamage / 10
		RestoreMana(tab2)
	end

	if event.lifesteal ~= nil then
		local tab = {}
		tab.caster = caster
		tab.target = caster
		tab.heal = finaldamage * event.lifesteal / 100
		tab.spelldamagefactor = 0.0
		tab.attributefactor = 0.0
		tab.ability = event.ability
		if tab.heal < 10 then
			tab.hidenumber = 1
		end
		HealUnit(tab)
	end

	if event.lifestealowner ~= nil and caster.owner then
		local tab = {}
		
		local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_centaur/centaur_double_edge_src_rope.vpcf", PATTACH_POINT_FOLLOW, caster.owner)
		ParticleManager:SetParticleControlEnt(particle, 4, caster.owner, PATTACH_POINT_FOLLOW, "attach_hitloc", caster.owner:GetAbsOrigin(), true)
		ParticleManager:SetParticleControlEnt(particle, 5, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), true)
		tab.caster = caster.owner
		tab.target = caster.owner
		tab.heal = finaldamage * event.lifestealowner / 100
		tab.spelldamagefactor = 0.0
		tab.attributefactor = 0.0
		tab.ability = event.ability
		--tab.hidenumber = 1
		HealUnit(tab)
	end

	--if event.shadowdmg and caster:HasModifier("modifier_item_elements") then
	--	local tab = {}
	--	tab.caster = caster
	--	tab.target = caster
	--	tab.heal = finaldamage * 0.22
	--	tab.spelldamagefactor = 0.0
	--	tab.attributefactor = 0.0
	--	tab.ability = event.ability
	--	tab.hidenumber = 1
	--	HealUnit(tab)
	--end

	if event.vampiricemb and event.vampiricemb > 0 then
		event.heal = finaldamage*0.6
		VampiricEmbrace(event)
	end

	if caster:HasModifier("modifier_item_weapon5") or caster:HasModifier("modifier_item_dreihander") then
        local maxprocs = 10
		if math.random(1,100) <= 12 and event.dontprocaoe == nil and (caster:GetAbsOrigin()-target:GetAbsOrigin()):Length() < 2500 then
            if not caster.zweiprocs then
                caster.zweiprocs = 1
            else
                caster.zweiprocs = caster.zweiprocs + 1
            end
            if caster:HasModifier("modifier_item_dreihander") then
                maxprocs = 15
            end
            if caster.zweiprocs <= maxprocs then
    			local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_centaur/centaur_warstomp_shockwave.vpcf", PATTACH_ABSORIGIN, target)
    			EmitSoundOn("DOTA_Item.BladeMail.Activate", target)
    			local tab = {}
    			tab.caster = caster
    			tab.target = target
    			tab.damage = 0.0
    			tab.spelldamagefactor = 0.0
    			tab.attributefactor = 50
    			tab.ability = event.ability
    			tab.aoe = 250
    			tab.targeteffect = "blood"
    			tab.targetpos = 1
    			tab.dontprocaoe = 1
    			tab.dontbreakcc = 1
    			DamageAOE(tab)
            else
                Timers:CreateTimer(5,function() 
                    caster.zweiprocs = 0
                end)
            end
		end
	end

	if event.arcanedmg and caster:HasModifier("modifier_item_elements") and caster.itemelemental then
		event.max = 25
		event.buff = "modifier_elemental_sp"
		event.ability = caster.itemelemental
		event.target = caster
		ApplyBuffStack(event)
	end

	if event.holydmg and caster:HasModifier("modifier_item_elements") and caster.itemelemental then
		event.max = 7
		event.buff = "modifier_elemental_kings"
		event.ability = caster.itemelemental
		event.target = caster
		ApplyBuffStack(event)
	end

end

function LockReloadProc(event)
	local caster = event.caster
	event.max = 12
	event.buff = "modifier_lockreload"
	event.ability = caster:GetAbilityByIndex(1)
	event.target = caster
	ApplyBuffStack(event)
end

function CriticalStrikeFX(casterarg, targetarg, amountarg, dmgorheal, crit) --dmgorheal: 0 = heal, 1 = dmg, 2 = dmg pure, 3 = dps
	--print("call")
	local target = targetarg
	local caster = casterarg
	local amount = amountarg
	local particle = nil
	local particlepath = nil
	local pos = target:GetAbsOrigin()+Vector(math.random(0,50),math.random(-25,25),75)
	if dmgorheal == 1 or dmgorheal == 2 then
		particlepath = "particles/criticalstrike.vpcf"
		if dmgorheal == 1 then
			--physical fx
			--particle = ParticleManager:CreateParticle("particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_crit_impact_dagger_arcana.vpcf", PATTACH_POINT_FOLLOW, target)
	    	--ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())
			--ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin())
			--ParticleManager:SetParticleControl(particle, 2, target:GetAbsOrigin())
			local event2 = {}
			event2.caster = caster
			event2.target = target
			if caster and target and not COverthrowGameMode.crit_effect_cooldown then
				BloodArcana(event2)
                COverthrowGameMode.crit_effect_cooldown = true
                Timers:CreateTimer(3,function()
                    COverthrowGameMode.crit_effect_cooldown = nil
                end)
			end
		else
			--magic fx
            if not COverthrowGameMode.crit_effect_cooldown then
                particle = ParticleManager:CreateParticle("particles/econ/items/antimage/antimage_weapon_basher_ti5/am_manaburn_basher_ti_5_b.vpcf", PATTACH_POINT_FOLLOW, target)
                particle = ParticleManager:CreateParticle("particles/units/heroes/hero_templar_assassin/templar_assassin_trap_explode_points.vpcf", PATTACH_POINT_FOLLOW, target)
                particle = ParticleManager:CreateParticle("particles/units/heroes/hero_invoker/invoker_emp_lightning_thick_child.vpcf", PATTACH_POINT_FOLLOW, target)
                local tar = target:GetAbsOrigin()
                ParticleManager:SetParticleControl(particle, 0, tar)
                tar = tar + Vector(0,0,200)
                ParticleManager:SetParticleControl(particle, 1, tar)
                COverthrowGameMode.crit_effect_cooldown = true
                Timers:CreateTimer(3,function()
                    COverthrowGameMode.crit_effect_cooldown = nil
                end)
            end
		end
	else
		particlepath = "particles/criticalheal.vpcf"
		pos = target:GetAbsOrigin()+Vector(math.random(0,50),math.random(-175,-125),75)
	end
    --dps position different
    if dmgorheal == 3 then
        particlepath = "particles/criticalstrike.vpcf"
        pos = target:GetAbsOrigin() + Vector(-100,0,0)
    end
	
	--calc digits
    local test7 = math.floor((amount%10000000)/1000000)
    local test6 = math.floor((amount%1000000)/100000)
    local test5 = math.floor((amount%100000)/10000)
    local test4 = math.floor((amount%10000)/1000)
	local test3 = math.floor((amount%1000)/100)
	local test2 = math.floor((amount%100)/10)
	local test1 = math.floor(amount%10)

    --healing numbers
    --1st
    particle = ParticleManager:CreateParticle(particlepath, PATTACH_ABSORIGIN, target)
    ParticleManager:SetParticleControl(particle, 0, pos)
	ParticleManager:SetParticleControl(particle, 1, Vector(0,test1,0))
	--2nd
    if test2 >= 1.0 or test7 >= 1.0 or test6 >= 1.0 or test5 >= 1.0 or test4 >= 1.0 or test3 >= 1.0 then
    	particle = ParticleManager:CreateParticle(particlepath, PATTACH_ABSORIGIN, target)
	    pos = pos+Vector(-16,0,0)
	    ParticleManager:SetParticleControl(particle, 0, pos)
		ParticleManager:SetParticleControl(particle, 1, Vector(0,test2,0))
	end
	if test3 >= 1.0 or test5 >= 1.0 or test4 >= 1.0 or test7 >= 1.0 or test6 >= 1.0 then
    	particle = ParticleManager:CreateParticle(particlepath, PATTACH_ABSORIGIN, target)
	    pos = pos+Vector(-16,0,0)
	    ParticleManager:SetParticleControl(particle, 0, pos)
		ParticleManager:SetParticleControl(particle, 1, Vector(0,test3,0))
	end
    if test4 >= 1.0 or test5 >= 1.0 or test7 >= 1.0 or test6 >= 1.0 then
        particle = ParticleManager:CreateParticle(particlepath, PATTACH_ABSORIGIN, target)
        pos = pos+Vector(-16,0,0)
        ParticleManager:SetParticleControl(particle, 0, pos)
        ParticleManager:SetParticleControl(particle, 1, Vector(0,test4,0))
    end
    if test5 >= 1.0 or test7 >= 1.0 or test6 >= 1.0 then
        particle = ParticleManager:CreateParticle(particlepath, PATTACH_ABSORIGIN, target)
        pos = pos+Vector(-16,0,0)
        ParticleManager:SetParticleControl(particle, 0, pos)
        ParticleManager:SetParticleControl(particle, 1, Vector(0,test5,0))
    end
    if test7 >= 1.0 or test6 >= 1.0 then
        particle = ParticleManager:CreateParticle(particlepath, PATTACH_ABSORIGIN, target)
        pos = pos+Vector(-16,0,0)
        ParticleManager:SetParticleControl(particle, 0, pos)
        ParticleManager:SetParticleControl(particle, 1, Vector(0,test6,0))
    end
    if test7 >= 1.0 then
        particle = ParticleManager:CreateParticle(particlepath, PATTACH_ABSORIGIN, target)
        pos = pos+Vector(-16,0,0)
        ParticleManager:SetParticleControl(particle, 0, pos)
        ParticleManager:SetParticleControl(particle, 1, Vector(0,test7,0))
    end

	--blitz icon
	if crit == 1 then
		pos = pos+Vector(-20,0,0)
		particle = ParticleManager:CreateParticle(particlepath, PATTACH_ABSORIGIN, target)
		ParticleManager:SetParticleControl(particle, 0, pos)
		ParticleManager:SetParticleControl(particle, 1, Vector(0,14,0))
	end
end

function DamageAOEDelayed( event )
	Timers:CreateTimer(event.delay,function() 
		DamageAOE(event)
	end)
end

function DamageUnitDelayed(event)
	Timers:CreateTimer(event.delay,function() 
		DamageUnit(event)
	end)
end

function DamageAOESplitHero( event )
    if event.caster == nil then
        return
    end
    local caster2 = event.caster
    local target2 = event.target
    if target2 == nil then
        target2 = event.unit
    end
    local ability2 = event.ability
    local range = event.aoe
    local pos = caster2:GetOrigin()
    if event.targetpos then
        pos = target2:GetOrigin()
    end
    if event.target_points ~= nil then
        pos = event.target_points[1]
    end
    if event.zeus ~= nil then
        pos = target2:GetOrigin()
        --print("zeus target detected")
    end

    enemies = FindUnitsInRadius( caster2:GetTeamNumber(), pos, caster2, range, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, 0, 0, false )
    
    local targets = 0
    local guy
    if #enemies > 0 then
        for _,enemy in pairs(enemies) do
            if enemy ~= nil and ((enemy:GetUnitLabel()=="hero") or (enemy:GetUnitLabel()==pet) or (enemy:GetUnitLabel()=="tower"))  then
                targets = targets + 1
                guy = enemy
            end
        end
    end
    if targets > 0 then
        if event.stunsingle and targets == 1 then
            local myevent = {}
            myevent.caster = caster2
            myevent.target = guy
            myevent.buff = "modifier_stunned"
            myevent.ability = event.ability
            myevent.dur = 1.1
            ApplyBuff(myevent)
        end
        event.includeauto = event.includeauto / targets
        DamageAOE(event)
    end
end

function DamageAOE( event )
	if event.caster == nil then
		return
	end
	local caster2 = event.caster
	local target2 = event.target
	if target2 == nil then
		target2 = event.unit
	end
	local ability2 = event.ability
	local range = event.aoe
	local pos = caster2:GetOrigin()
	if event.targetpos then
		pos = target2:GetOrigin()
	end
	if event.target_points ~= nil then
		pos = event.target_points[1]
	end
	if event.zeus ~= nil then
		pos = target2:GetOrigin()
		--print("zeus target detected")
	end

	local event2 = {
		caster = caster2,
		target = target2,
		ability = ability2,
		damage = event.damage,
		spelldamagefactor = event.spelldamagefactor,
		attributefactor = event.attributefactor,
		pvescale = event.pvescale,
		critdmgbonusfactor = event.critdmgbonusfactor,
		critchancefactor = event.critchancefactor,
		includeauto = event.includeauto,
		critmanareg = event.critmanareg,
		championcleaver = event.championcleaver,
        difficultyscale = event.difficultyscale,
        difficultyscalelinear = event.difficultyscalelinear,
        t3bonus = event.t3bonus
	}


	if event.naturedmg then
		event2.naturedmg = 1
	end
	if event.firedmg then
		event2.firedmg = 1
	end
	if event.shadowdmg then
		event2.shadowdmg = 1
	end
	if event.arcanedmg then
		event2.arcanedmg = 1
	end
	if event.frostdmg then
		event2.frostdmg = 1
	end
	if event.holydmg then
		event2.holydmg = 1
	end

	local agha = caster2:HasModifier("modifier_item_straxe2") or caster2:HasModifier("modifier_item_straxe3")

	if event.arrowsound then
		EmitSoundOn("Hero_LegionCommander.Overwhelming.Hero", caster2)
		local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_legion_commander/legion_commander_odds_hero_arrow_group.vpcf", PATTACH_ABSORIGIN, caster2)
		ParticleManager:SetParticleControl(particle, 0, pos+Vector(-125,0,0))
		ParticleManager:SetParticleControl(particle, 1, pos)
		particle = ParticleManager:CreateParticle("particles/units/heroes/hero_legion_commander/legion_commander_odds_hero_arrow_group.vpcf", PATTACH_ABSORIGIN, caster2)
		ParticleManager:SetParticleControl(particle, 0, pos+Vector(125,0,0))
		ParticleManager:SetParticleControl(particle, 1, pos)
		particle = ParticleManager:CreateParticle("particles/units/heroes/hero_legion_commander/legion_commander_odds_hero_arrow_group.vpcf", PATTACH_ABSORIGIN, caster2)
		ParticleManager:SetParticleControl(particle, 0, pos+Vector(0,125,0))
		ParticleManager:SetParticleControl(particle, 1, pos)
		particle = ParticleManager:CreateParticle("particles/units/heroes/hero_legion_commander/legion_commander_odds_hero_arrow_group.vpcf", PATTACH_ABSORIGIN, caster2)
		ParticleManager:SetParticleControl(particle, 0, pos+Vector(0,-125,0))
		ParticleManager:SetParticleControl(particle, 1, pos)
	end

	local enemies
	local pet = "pet"
	if event.onlyhero then
		--enemies = FindUnitsInRadius( caster2:GetTeamNumber(), pos, caster2, range, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, 0, 0, false )
		pet = "hero"
	end
	enemies = FindUnitsInRadius( caster2:GetTeamNumber(), pos, caster2, range, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )

	local crusaderheal = 0
	if #enemies > 0 then
		for _,enemy in pairs(enemies) do
			if enemy and not enemy:IsNull() and (enemy:GetUnitLabel() == "hero" or enemy:GetUnitLabel() == pet or enemy:GetUnitLabel() == "tower" )  then
				if (not CheckForBreakableCC(enemy)) or event.breakcc then
					event2.target = enemy
					DamageUnit( event2 )
					if event.targeteffect == "blood" then
						local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_beastmaster/beastmaster_wildaxes_hit.vpcf", PATTACH_ABSORIGIN_FOLLOW, enemy)
					end
					if event.targeteffect == "thunder" then
						local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_disruptor/disruptor_thunder_strike_aoe.vpcf", PATTACH_ABSORIGIN_FOLLOW, enemy)
					end
					if event.targeteffect == "fire" then
						local particle = ParticleManager:CreateParticle("particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_shadowraze_lava.vpcf", PATTACH_ABSORIGIN_FOLLOW, enemy)
						ParticleManager:SetParticleControl(particle, 0, enemy:GetAbsOrigin()+Vector(0,0,15))
					end
					if event.targeteffect == "water" then
						local particle = ParticleManager:CreateParticle("particles/econ/items/kunkka/divine_anchor/hero_kunkka_dafx_skills/kunkka_spell_x_spot_return_fxset.vpcf", PATTACH_ABSORIGIN_FOLLOW, enemy)
					end
					if event.targeteffect == "holy" then
						local particle = ParticleManager:CreateParticle("particles/econ/items/legion/legion_weapon_voth_domosh/legion_commander_duel_dmg_flare.vpcf", PATTACH_ABSORIGIN_FOLLOW, enemy)
						ParticleManager:SetParticleControl(particle, 3, enemy:GetAbsOrigin()+Vector(0,0,0))
					end
					if event.healpertarget ~= nil then
						crusaderheal = crusaderheal + 2
					end
					if event.stun then
						--local tab = {}
						--tab.Duration = event.stun
						event.target = enemy
						event.dur = event.stun
						StunTarget(event)
						--event.ability:ApplyDataDrivenModifier(caster2, enemy, "modifier_stunned", tab)
					end
					if event.championslowproc and agha then
						local myevent = {}
			    		myevent.caster = caster2
			    		myevent.target = enemy
			    		myevent.buff = "modifier_slow25"
						myevent.ability = event.ability
						myevent.dur = 2
						ApplyBuff(myevent)
						--event.ability:ApplyDataDrivenModifier(caster2, enemy, "modifier_slow25", nil)
					end

					if event.arrowsound then
						--local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_legion_commander/legion_commander_odds_hero_arrow_start_pos.vpcf", PATTACH_ABSORIGIN_FOLLOW, enemy)
						
						--ParticleManager:SetParticleControl(particle, 1, enemy:GetAbsOrigin())
						local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_invoker/invoker_forged_spirit_projectile_explosion.vpcf", PATTACH_ABSORIGIN_FOLLOW, enemy)
						ParticleManager:SetParticleControl(particle, 3, enemy:GetAbsOrigin()+Vector(0,0,75))
                        local myevent = {}
                        myevent.caster = caster2
                        myevent.energy = event.energy
                        AddEnergy(myevent)
					end
				end
			end
		end
	end
	if crusaderheal > 0 then
		event.target = caster2
		event.heal = caster2:GetMaxHealth()*crusaderheal/100
		event.attributefactor = 0.0
		event.spelldamagefactor = 0.0
		if event.retrisound ~= nil then
			EmitSoundOn("Hero_LegionCommander.Attack", event.caster)
		end
		if event.warlockfx ~= nil then
			local particle = ParticleManager:CreateParticle("particles/econ/events/ti5/blink_dagger_start_smoke_ti5.vpcf", PATTACH_POINT_FOLLOW, caster2)
		end
		HealUnit(event)
	end
end

function ApplyBuffAOE( event )
	if event.caster == nil or event.target == nil then
		return
	end
	local caster = event.caster
	local target = event.target
	if target == nil then
		target = event.unit
	end
	local ability = event.ability
	local range = event.aoe
	local pos = caster:GetOrigin()
	if event.targetpos then
		pos = target:GetOrigin()
	end
	if event.target_points ~= nil then
		pos = event.target_points[1]
	end
	local pet = "pet"
	if event.onlyhero then
		local pet = "hero"
	end
	local team = DOTA_UNIT_TARGET_TEAM_ENEMY
	if event.friend then
		team = DOTA_UNIT_TARGET_TEAM_FRIENDLY
	end

	local enemies = FindUnitsInRadius( caster:GetTeamNumber(), pos, caster, range, team, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )

	if #enemies > 0 then
		for _,enemy in pairs(enemies) do
			if enemy ~= nil and ((enemy:GetUnitLabel()=="hero") or (enemy:GetUnitLabel()==pet) or (enemy:GetUnitLabel()=="tower")) then
				local myevent = {}
	    		myevent.caster = caster
	    		myevent.target = enemy
	    		myevent.buff = event.buff
				myevent.ability = event.ability
				myevent.dur = event.dur
				if not event.dontbreakccbuff or ( event.dontbreakccbuff and not CheckForBreakableCC(enemy) ) then
					ApplyBuff(myevent)
				end
			end
		end
	end
end

function ApplyBuffAOERandom( event )
    if event.caster == nil or event.target == nil then
        return
    end
    local caster = event.caster
    local target = event.target
    if target == nil then
        target = event.unit
    end
    local ability = event.ability
    local range = event.aoe
    local pos = caster:GetOrigin()
    if event.targetpos then
        pos = target:GetOrigin()
    end
    if event.target_points ~= nil then
        pos = event.target_points[1]
    end
    local pet = "pet"
    if event.onlyhero then
        local pet = "hero"
    end
    local team = DOTA_UNIT_TARGET_TEAM_ENEMY
    if event.friend then
        team = DOTA_UNIT_TARGET_TEAM_FRIENDLY
    end
    local excludetarget = nil
    if event.excludetarget then
        excludetarget = target
    end

    local enemies = FindUnitsInRadius( caster:GetTeamNumber(), pos, caster, range, team, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
    local result = {}
    if #enemies > 0 then
        for _,enemy in pairs(enemies) do
            if enemy ~= nil and ((enemy:GetUnitLabel()=="hero") or (enemy:GetUnitLabel()==pet) or (enemy:GetUnitLabel()=="tower")) and enemy ~= excludetarget then
                if not event.dontbreakccbuff or ( event.dontbreakccbuff and not CheckForBreakableCC(enemy) ) then
                    table.insert( result, enemy )
                end
            end
        end
    end
    --print("result " .. #result )
    if result[1] then
        local chosen_target = result[math.random(1,#result)]
        if event.limitdkswarm then
            if caster.limitdkswarm then
                if caster.limitdkswarm > event.limitdkswarm then
                    return
                end
            end
        end
        if event.alwaysapply then
            event.ability:ApplyDataDrivenModifier(caster, chosen_target, event.buff, {Duration = event.dur})
        else
            local myevent = {}
            myevent.caster = caster
            myevent.target = enemy
            myevent.buff = event.buff
            myevent.ability = event.ability
            myevent.dur = event.dur
            ApplyBuff(myevent)
        end
    else
        if event.limitdkswarm then
            caster.limitdkswarm = caster.limitdkswarm - 1
        end
    end
end

function LimitDKSwarm( event )
    local caster = event.caster
    if caster.limitdkswarm then
        caster.limitdkswarm = caster.limitdkswarm + 1
    else
        caster.limitdkswarm = 1
    end
end

function HeroTakesDamage( event )
	--print("damage taken " .. event.damagetaken)
end

function CheckForBreakableCC( target )
	if target:HasModifier("modifier_sap") or target:HasModifier("modifier_sap2") or target:HasModifier("modifier_confused") or target:HasModifier("modifier_voodoo_datadriven") or target:HasModifier("glacier_trap") then
		return true
	else
		return false
	end
end

function IsHardCC( buff )
    if buff == "modifier_stunned" or buff == "modifier_delay_impale" or buff == "modifier_deepfreeze" or buff == "glacier_trap" or buff == "modifier_rootedfx" 
        or buff == "modifier_rootedpull" or buff == "modifier_sap" or buff == "modifier_fear2" or buff == "modifier_fearsp_bonus" 
        or buff == "modifier_sap2" or buff == "modifier_cyclone_self" or buff == "modifier_fearsp" or buff == "modifier_confused"
        or buff == "modifier_confused_unbreakable" or buff == "modifier_frostarmorbuff" or buff == "modifier_iceexplode" or buff == "modifier_stomp"
        or buff == "modifier_voodoo_datadriven"
            then
        return true
    else
        return false
    end
end

function CheckForCC( target )
    if target:HasModifier("modifier_stunned") or target:HasModifier("modifier_delay_impale") or target:HasModifier("modifier_deepfreeze") or target:HasModifier("glacier_trap") or target:HasModifier("modifier_rootedfx") 
        or target:HasModifier("modifier_rootedpull") or target:HasModifier("modifier_sap") or target:HasModifier("modifier_fear2") or target:HasModifier("modifier_fearsp_bonus") 
        or target:HasModifier("modifier_sap2") or target:HasModifier("modifier_cyclone_self") or target:HasModifier("modifier_fearsp") or target:HasModifier("modifier_confused")
        or target:HasModifier("modifier_confused_unbreakable") or target:HasModifier("modifier_frostarmorbuff") or target:HasModifier("modifier_iceexplode") or target:HasModifier("modifier_stomp")
        or target:HasModifier("modifier_voodoo_datadriven")
            then
        return true
    else
        return false
    end
end

function CheckForSilence( target )
    if target:HasModifier("modifier_silenced") or target:HasModifier("modifier_zonesilence") then
        return true
    else
        return false
    end
end

function BreakModifierOnDamage(event)
	--print("breaking dmg")
	if event.dmg ~= nil and event.dmg > 0.0 then
		if event.attacker.warddontbreakit ~= nil then
			--print("ward not breaking itself")
		else
			if not (event.dontbreak and event.dontbreak == 1) then
				local caster = event.unit
				caster:RemoveModifierByName("modifier_sap")
				caster:RemoveModifierByName("modifier_sap2")
				caster:RemoveModifierByName("modifier_voodoo_datadriven")
				caster:RemoveModifierByName("modifier_confused")
				caster:RemoveModifierByName("glacier_trap")
			end
		end
	end
end

function RemoveSlows(event)
	local caster = event.target
	if caster == nil then
		caster = event.caster
	end
	if event.castertarget then
		caster = event.caster
	end
	if event.levelcondition and event.levelcondition == 0 then
		return
	end
	caster:RemoveModifierByName("modifier_slow25")
	caster:RemoveModifierByName("modifier_slow75")
	caster:RemoveModifierByName("modifier_aoeslow50")
	caster:RemoveModifierByName("modifier_frostslow50")
	caster:RemoveModifierByName("modifier_netherblast_enemy")
	caster:RemoveModifierByName("modifier_aoeslowaura")
	caster:RemoveModifierByName("aoeslow50")
	caster:RemoveModifierByName("modifier_slow50")
	caster:RemoveModifierByName("aoeslow20")
	caster:RemoveModifierByName("aoeslow40")
	caster:RemoveModifierByName("modifier_slow40storm")
	caster:RemoveModifierByName("pyroslow75")
	caster:RemoveModifierByName("hellfire50")
	caster:RemoveModifierByName("modifier_furyslow")
	caster:RemoveModifierByName("modifier_item_aura13dmg")
	caster:RemoveModifierByName("modifier_item_aura13")
	caster:RemoveModifierByName("modifier_bleedslow")
	caster:RemoveModifierByName("modifier_frostslow50_2")
	caster:RemoveModifierByName("modifier_frostchains")
	caster:RemoveModifierByName("modifier_slowpoison")
	caster:RemoveModifierByName("modifier_slowpoison2")
	caster:RemoveModifierByName("modifier_frostslow10")
	caster:RemoveModifierByName("modifier_slowstack10")
	caster:RemoveModifierByName("modifier_slowpoisonsnake")
	caster:RemoveModifierByName("modifier_shivpoison")
	caster:RemoveModifierByName("modifier_frostslow40")
    caster:RemoveModifierByName("modifier_ice_armor_slow")
    caster:RemoveModifierByName("modifier_hammerslow")
    caster:RemoveModifierByName("modifier_slowmsas50")
    caster:RemoveModifierByName("modifier_surv_aapoison")
    caster:RemoveModifierByName("modifier_dhslow")
    caster:RemoveModifierByName("modifier_icenova_slow")
end

function RemoveRoots(event)
	local caster = event.target
	if caster == nil then
		caster = event.caster
	end
	caster:RemoveModifierByName("modifier_rootsdruid")
	caster:RemoveModifierByName("modifier_rootedfx")
	caster:RemoveModifierByName("modifier_icenova")
	caster:RemoveModifierByName("modifier_rooted_self")
	
end

function SpellInterrupt( event )
	local target = event.target
	local caster = event.caster
	local manafactor = 1.0
	if target.IsCasting == 1 and not (target:HasModifier("modifier_activemage") or target:HasModifier("modifier_interruptimune")) then
		manafactor = 2.0
		if target.Castbar ~= nil then
    		ParticleManager:DestroyParticle(target.Castbar,true)
    	end
		if event.feralcdreduce then
			--event.ability:ApplyDataDrivenModifier(event.caster, event.caster, "modifier_feralfury", nil)
			--event.caster.Energy = event.caster.Energy+25
			StunTarget(event)
		elseif event.stun ~= nil then
			--local damage_table = {}
 			--damage_table.Duration = event.dur
			--event.ability:ApplyDataDrivenModifier(event.caster, target, "modifier_stunned", damage_table)

			local myevent = {}
    		myevent.caster = event.caster
    		myevent.target = target
    		myevent.buff = "modifier_stunned"
			myevent.ability = event.ability
			myevent.dur = event.dur
			ApplyBuff(myevent)
			--also short silence
 			--damage_table.Duration = 0.05
			--event.ability:ApplyDataDrivenModifier(event.caster, target, "modifier_silence", damage_table)

			local myevent = {}
    		myevent.caster = event.caster
    		myevent.target = target
    		myevent.buff = "modifier_silence"
			myevent.ability = event.ability
			myevent.dur = 0.05
			ApplyBuff(myevent)
		else
			local damage_table = {}
 			damage_table.Duration = event.dur
 			if event.curseblade then
 				damage_table.Duration = event.dur*GetCCPower(event)
 			end
			--event.ability:ApplyDataDrivenModifier(event.caster, target, "modifier_silence", damage_table)

			local myevent = {}
    		myevent.caster = event.caster
    		myevent.target = target
    		myevent.buff = "modifier_silence"
    		if event.trystun and event.trystun > 0 then
    			myevent.buff = "modifier_stunned"
    		end
			myevent.ability = event.ability
			myevent.dur = damage_table.Duration
			ApplyBuff(myevent)

			ParticleManager:CreateParticle("particles/radiant_fx/tower_good3_dest_lvl2_hit.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		end
		if event.csfx ~= nil then
			event.ability:ApplyDataDrivenModifier(event.caster, target, "modifier_csfx", nil)
		end
		ParticleManager:CreateParticleForPlayer("particles/units/heroes/hero_zeus/zues_screen_empty.vpcf", PATTACH_POINT_FOLLOW, target, target:GetOwner())
		ParticleManager:CreateParticleForPlayer("particles/econ/events/killbanners/screen_killbanner_compendium14_rampage_burst.vpcf", PATTACH_POINT_FOLLOW, caster, caster:GetOwner())
		
		if event.shamanhaste and event.shamanhaste > 0 then
			event.ability:ApplyDataDrivenModifier(event.caster, event.caster, "modifier_hasteproc25", nil)
		end
		if event.rageproc and event.rageproc > 0 then
            local myevent = {}
            myevent.caster = caster
            myevent.energy = event.rageproc
            AddEnergy(myevent)
		end
		if event.enemyhaste and event.enemyhaste > 0 then
			local myevent = {}
    		myevent.caster = event.caster
    		myevent.target = event.target
    		myevent.buff = "modifier_mindnumb"
			myevent.ability = event.ability
			myevent.dur = event.enemyhaste
			ApplyBuff(myevent)
		end
		if event.qspellcd and event.qspellcd > 0 then
			local abil = target:GetAbilityByIndex(0)
			if abil and abil:GetCooldownTimeRemaining() < event.qspellcd then
				abil:EndCooldown()
				abil:StartCooldown(event.qspellcd)
			end
		end
	else
		if event.feraljumpcd and event.feraljumpcd > 0 then
			event.ability:EndCooldown()
			event.ability:StartCooldown(event.feraljumpcd)
		end
	end
	if event.manasteal and event.manasteal > 0 then
		caster:SetMana(caster:GetMana() + caster:GetMaxMana()*manafactor*event.manasteal/100)
	end
end

function PurgeUnit(event)
	local target = event.target
	local silencepenalty = false
	if target == nil then
		target = event.unit
	end
	if target == nil then
		target = event.caster
	end

	--silence if dot2
	if target:HasModifier("modifier_dot2") and event.trinket == nil then
		silencepenalty = true
	end
    --[[
    if target:HasModifier("modifier_swd") and target.devouringsource then
        local myevent = {}
        local stackcount = target:GetModifierStackCount("modifier_swd", nil)
        myevent.caster = target.devouringsource
        myevent.target = event.caster
        myevent.ability = event.ability
        myevent.damage = 0.0
        myevent.spelldamagefactor = 150*0.75*stackcount
        myevent.attributefactor = 150*0.75*stackcount
        myevent.shadowdmg = 1
        DamageUnit(myevent)
    end ]]
	if event.nopenalty then
		silencepenalty = false
	end

	-- Strong Dispel
	local RemovePositiveBuffs = false
	local RemoveDebuffs = true
	local BuffsCreatedThisFrameOnly = false
	local RemoveStuns = true
	local RemoveExceptions = false


	target:RemoveModifierByName("modifier_voodoo_datadriven")
	target:RemoveModifierByName("modifier_silence")
	target:RemoveModifierByName("modifier_zonesilence")


	target:Purge( RemovePositiveBuffs, RemoveDebuffs, BuffsCreatedThisFrameOnly, RemoveStuns, RemoveExceptions)

	-- do the silence
	if silencepenalty == true then
		--local damage_table = {}
 		--damage_table.Duration = 5
		--event.ability:ApplyDataDrivenModifier(event.caster, event.caster, "modifier_silence", damage_table)
		--print("self silence penalty cuz of dispel")
		local myevent = {}
		myevent.caster = event.caster
		myevent.target = event.caster
		myevent.buff = "modifier_silence"
		myevent.ability = event.ability
		myevent.dur = 5
		ApplyBuff(myevent)
	end

	if event.trinket then
		target:RemoveModifierByName("modifier_dot4")
		target:RemoveModifierByName("modifier_infested")
		target:RemoveModifierByName("modifier_cyclone_self")
	end

	if event.massdispel then
		--print("try")
		target:RemoveModifierByName("modifier_cyclone_self")
		target:RemoveModifierByName("modifier_infested")
	end
end

function PurgeEnemyUnit(event)
	if event.purge and event.purge == 0 then
		return
	end
    if event.purge then
        ParticleManager:CreateParticle("particles/generic_gameplay/generic_purge.vpcf", PATTACH_ABSORIGIN_FOLLOW, event.target)
    end
	local target = event.target
	if target == nil then
		target = event.unit
	end
	-- Strong Dispel
	local RemovePositiveBuffs = true
	local RemoveDebuffs = false
	local BuffsCreatedThisFrameOnly = false
	local RemoveStuns = false
	local RemoveExceptions = false
	target:Purge( RemovePositiveBuffs, RemoveDebuffs, BuffsCreatedThisFrameOnly, RemoveStuns, RemoveExceptions)
	if event.massdispel then
		--print("try")
		target:RemoveModifierByName("modifier_invul")
		target:RemoveModifierByName("modifier_frostarmorbuff")
	end
end

function BuffFriendlyTarget ( event )
    local caster = event.caster
    local target = event.target
    if target ~= nil and caster:GetTeamNumber()==target:GetTeamNumber() then
    	event.ability:ApplyDataDrivenModifier(caster, target, event.buff, nil)
	end
end

function ReduceAbilityCooldown ( event )
    local caster = event.caster
    event.ability = caster:GetAbilityByIndex(event.index)
    ReduceCooldown(event)
end

function HealUnit( event )
    local caster = event.caster
    local target = event.target
    local heroName = caster:GetUnitName()
    local displaynumber = true

    if event.retridmgtoheal ~= nil then
    	target = caster
    	event.heal = event.heal*2
    end
    if event.shadowdmgtoheal ~= nil then
    	target = caster
    	event.heal = event.heal*event.shadowdmgtoheal / 100
    end
    if event.attacktargetswitch ~= nil then
    	target = caster
    end
    if event.affectattacker then
    	target = event.attacker
    end
    if target == nil and caster ~= nil then
    	target = caster
    end
    if target == nil then
    	return
    end
    if target:GetUnitLabel() == "tower" then
    	return
    end
    if target:HasModifier("modifier_cyclone_self") then
  		return
    end
    if event.demoncondition and not caster:HasModifier("modifier_item_demonglaive") then
        return
    end
    if caster.spelldamage == nil then
    	caster.spelldamage = 0.0
    end
    if 	event.heal == nil then
    	event.heal = 0.0
    end

    if  event.spelldamagefactor == nil then
    	event.spelldamagefactor = 0.0
    end

    if event.percenthp then
    	event.heal = event.heal + event.percenthp*target:GetMaxHealth()/100.0
    	--print("shaman " .. event.heal)
    end

    -- Spelldamage
    local spelldamagefromitem = 0

    -- add spelldamage

    if  event.spelldamagefactor > 0.0 and event.FromGuardian ~= 1 then
    	spelldamagefromitem = GetSpellpower(event)
    	event.heal = event.heal + event.spelldamagefactor*(caster.spelldamage+spelldamagefromitem)/100.0
    end
    -- healing from stats
    --also add bonus factor
    local statbonus = 1.0
    if caster:HasModifier("modifier_holyhammer2") then
    	--statbonus = 1.75
    	--caster:RemoveModifierByName("modifer_holyhammer2")
    end
    if event.attributefactor ~= nil then
    	-- normal heroes
    	if event.attributechangeint ~= nil then
    		event.heal = event.heal + caster:GetIntellect()*event.attributefactor*statbonus/100.0
    	elseif event.attributechangestr ~= nil then
    		event.heal = event.heal + caster:GetStrength()*event.attributefactor*statbonus/100.0
    	elseif event.attributechangeagi ~= nil then
    		event.heal = event.heal + caster:GetAgility()*event.attributefactor*statbonus/100.0
    	elseif event.attributechangeall ~= nil then
    		event.heal = event.heal + caster:GetAgility()*event.attributefactor*statbonus/100.0 + caster:GetStrength()*event.attributefactor*statbonus/100.0 + caster:GetIntellect()*event.attributefactor*statbonus/100.0
    	else
    		if caster:IsHero() then
    			event.heal = event.heal + caster:GetPrimaryStatValue()*event.attributefactor*statbonus/100.0
    		end
    	end
	end

	-- lifebloom increases per stack
	if event.lifebloom ~= nil then
		local stackcount = target:GetModifierStackCount("modifier_lifebloom", caster)
		if target:HasModifier("modifier_lifebloomfull") then
			stackcount = target:GetModifierStackCount("modifier_lifebloomfull", caster)
		end
	    event.heal = event.heal * stackcount
	    --print("stack count considered" .. caster:GetPrimaryStatValue()*event.attributefactor)
	end

    if caster.talents then
        if caster.talents[8] then
            local ancient = 1
            if caster:HasModifier("modifier_item_silverblood4") then
                ancient = 2
            end
            event.heal = event.heal + caster:GetHealth() * 0.01 * caster.talents[8] * ancient
        end
    end

	-- spellcrit  NEW NEW NEW
	local critchancefactor = 1.0
    local critdmgbonusfactor = 1.0
    local critchance = 0
    local critpossible = true
    if event.cannotcrit then
    	critpossible = false
    end
    if event.critchancefactor ~= nil then
 		critchancefactor = event.critchancefactor
 	end
 	if event.critdmgbonusfactor ~= nil then
 		critdmgbonusfactor = event.critdmgbonusfactor
 	end
    if event.caster:HasModifier("modifier_crit_aura_dragon") then
        critdmgbonusfactor = critdmgbonusfactor + 0.2
    end
    if caster.runeword and caster.runeword[12] then
        critdmgbonusfactor = critdmgbonusfactor + caster.runeword[12] / 100
    end
    if critpossible == true and event.caster:HasModifier("modifier_mythic_abilcrit") then
        critchance = critchancefactor * caster:GetModifierStackCount("modifier_mythic_abilcrit", nil)
        if math.random(1,100) <= critchance then
            event.heal = event.heal*5*critdmgbonusfactor
            displaynumber = 1
            critpossible = false
        end
    end
    if critpossible == true and event.caster:HasModifier("modifier_item_crit_pure_immortal2") then
        critchance = 20*critchancefactor
        if math.random(1,100) <= critchance then
            event.heal = event.heal*5*critdmgbonusfactor
            displaynumber = 1
            critpossible = false
        end
    end
    if critpossible == true and event.caster:HasModifier("modifier_item_crit_pure_immortal3") then
        critchance = 20*critchancefactor
        if math.random(1,100) <= critchance then
            event.heal = event.heal*6*critdmgbonusfactor
            displaynumber = 1
            critpossible = false
        end
    end
    if critpossible == true and event.caster:HasModifier("modifier_ancient_def") then
        critchance = 5*critchancefactor
        if math.random(1,100) <= critchance then
            event.heal = event.heal*5*critdmgbonusfactor
            displaynumber = 1
            critpossible = false
        end
    end
    if critpossible == true and event.caster:HasModifier("modifier_item_crit_pure_immortal") then
        critchance = 20*critchancefactor
        if math.random(1,100) <= critchance then
            event.heal = event.heal*4*critdmgbonusfactor
            displaynumber = 1
            critpossible = false
        end
    end
    if critpossible == true and event.caster:HasModifier("modifier_item_warglaive") then
        critchance = 6*critchancefactor
        if event.eviscritbonus ~= nil then
            critchance = critchance*1.35
        end
        if event.caster:HasModifier("modifier_bow_crit_legendary") then
            critchance = 100
        end
        if math.random(1,100) <= critchance then
            event.heal = event.heal*3.5*critdmgbonusfactor
            displaynumber = 1
            critpossible = false
        end
    end
    if critpossible == true and caster.runeword and caster.runeword[20] and caster.runeword[20] > 0 then
        critchance = caster.runeword[20]
        if math.random(1,100) <= critchance then
            event.heal = event.heal*3*critdmgbonusfactor
            displaynumber = 1
            critpossible = false
        end
    end
    if critpossible == true and event.caster:HasModifier("modifier_item_endgame10") then
        critchance = 14*critchancefactor
        if math.random(1,100) <= critchance then
            event.heal = event.heal*2.75*critdmgbonusfactor
            displaynumber = 1
            critpossible = false
        end
    end
    if critpossible == true and event.caster:HasModifier("modifier_item_crit_pure") then
        critchance = 7*critchancefactor
        if math.random(1,100) <= critchance then
            event.heal = event.heal*2.5*critdmgbonusfactor
            displaynumber = 1
            critpossible = false
        end
    end
    if critpossible == true and event.caster:HasModifier("modifier_item_druid_glove_crit") then
        critchance = 7*critchancefactor
        if math.random(1,100) <= critchance then
            event.heal = event.heal*2.5*critdmgbonusfactor
            displaynumber = 1
            critpossible = false
        end
    end
    if critpossible == true and event.caster:HasModifier("modifier_item_bootscrit2") then
        critchance = 12*critchancefactor
        if math.random(1,100) <= critchance then
            event.heal = event.heal*2.5*critdmgbonusfactor
            displaynumber = 1
            critpossible = false
        end
    end
    if critpossible == true and event.caster:HasModifier("modifier_item_endgame9") then
        critchance = 21*critchancefactor
        if math.random(1,100) <= critchance then
            event.heal = event.heal*2.05*critdmgbonusfactor
            displaynumber = 1
            critpossible = false
        end
    end
    if critpossible == true and event.caster:HasModifier("modifier_item_weapon10") then
        critchance = 10*critchancefactor
        if math.random(1,100) <= critchance then
            event.heal = event.heal*2.15*critdmgbonusfactor
            displaynumber = 1
            critpossible = false
        end
    end
    if critpossible == true and event.caster:HasModifier("modifier_crit_aura_dragon") then
        critchance = 3*critchancefactor
        if math.random(1,100) <= critchance then
            event.heal = event.heal*2.0*critdmgbonusfactor
            displaynumber = 1
            critpossible = false
        end
    end
    if critpossible == true and event.caster:HasModifier("modifier_guaranteed_crit_once") then
        critchance = 100*critchancefactor
        if math.random(1,100) <= critchance then
            event.heal = event.heal*2.0*critdmgbonusfactor
            displaynumber = 1
            critpossible = false
            event.caster:RemoveModifierByName("modifier_guaranteed_crit_once")
        end
    end
    if critpossible == true and event.caster:HasModifier("modifier_item_endgame5") then
    	critchance = 16 * critchancefactor
    	if math.random(1,100) <= critchance then
	    	event.heal = event.heal*2.25*critdmgbonusfactor
    		displaynumber = 1
	    	critpossible = false
	    end
    end
    if critpossible == true and event.caster:HasModifier("modifier_item_bootscrit") then
    	critchance = 11*critchancefactor
    	if math.random(1,100) <= critchance then
	    	event.heal = event.heal*1.85*critdmgbonusfactor
    		displaynumber = 1
	    	critpossible = false
    	end
    end
    if critpossible == true and event.caster:HasModifier("modifier_item_bootscurse") then
        critchance = 15*critchancefactor
        if math.random(1,100) <= critchance then
            event.heal = event.heal*2*critdmgbonusfactor
            displaynumber = 1
            critpossible = false
        end
    end
    if critpossible == true and event.caster:HasModifier("modifier_item_bootscrit_2") then
        critchance = 11*critchancefactor
        if math.random(1,100) <= critchance then
            event.heal = event.heal*2.25*critdmgbonusfactor
            displaynumber = 1
            critpossible = false
        end
    end
    if critpossible == true and event.caster:HasModifier("modifier_item_bowupgradeproc") then
        critchance = 100*critchancefactor
        if math.random(1,100) <= critchance then
            local dist = (caster:GetAbsOrigin()-target:GetAbsOrigin()):Length()
            if dist > 300.0 then
                event.heal = event.heal*1.75*critdmgbonusfactor
                displaynumber = 1
                critpossible = false
            end
        end
    end
    if critpossible == true and event.caster:HasModifier("modifier_item_caster6") then
    	critchance = 12*critchancefactor
    	if math.random(1,100) <= critchance then
	    	event.heal = event.heal*1.75*critdmgbonusfactor
    		displaynumber = 1
	    	critpossible = false
    	end
    end
    if critpossible == true and event.caster:HasModifier("modifier_item_weapon9") then
    	critchance = 21*critchancefactor
    	if math.random(1,100) <= critchance then
	    	event.heal = event.heal*1.5*critdmgbonusfactor
    		displaynumber = 1
	    	critpossible = false
    	end
    end
    if critpossible == true and event.caster:HasModifier("modifier_item_caster7") and target:GetHealth()/target:GetMaxHealth() < 0.3 then
	    event.heal = event.heal*1.25*critdmgbonusfactor
    	displaynumber = 1
	    critpossible = false
    end
    if critpossible == true and heroName == "npc_dota_hero_oracle" and caster:GetAbilityByIndex(1):GetLevel() >= 3 then
    	critchance = 10*critchancefactor
    	if math.random(1,100) <= critchance then
	    	event.heal = event.heal*2*critdmgbonusfactor
    		displaynumber = 1
	    	critpossible = false
    	end
    end
    if critpossible == true and caster:HasModifier("modifier_guaranteed_crit") then
    	critchance = 100*critchancefactor
    	if math.random(1,100) <= critchance then
	    	event.heal = event.heal*1.5*critdmgbonusfactor
    		displaynumber = 1
	    	critpossible = false
    	end
    end
    local talentcritstacks = caster:GetModifierStackCount("modifier_crit_stacks", nil)
    if critpossible == true and talentcritstacks > 0 then
    	critchance = talentcritstacks*15*critchancefactor
    	if math.random(1,100) <= critchance then
	    	event.heal = event.heal*1.5*critdmgbonusfactor
    		displaynumber = 1
	    	critpossible = false
    	end
    end
    
    local was_crit = false
    if critpossible == false and not event.cannotcrit then
        was_crit = true
    end

    --talents3
    if caster.talents then
        if was_crit and caster.talents[17] then
            event.heal = event.heal * (1 + 0.06 * caster.talents[17])
        end
        if event.bloodwolf and caster.talents[32] then
            event.heal = event.heal * (1 + 0.2 * caster.talents[32])
        end
        if caster.talents[20] and caster.talents[20] > 0 and caster.standsstill and caster.standsstill >= 4 then
            event.heal = event.heal * (1 + 0.12 * caster.talents[20])
        end
    end


    if caster:HasModifier("modifier_activepaladin") then
	    event.heal = event.heal*1.25
    end

    local kingcharge = 1 + caster:GetModifierStackCount("modifier_elemental_kings", caster)*0.03
    if kingcharge > 1 then
    	event.heal = event.heal * kingcharge
    end

    local heavencharge = 1 + caster:GetModifierStackCount("modifier_heaven_charge", caster)*1
    if event.heavencharge and heavencharge > 1 then
    	event.heal = event.heal * heavencharge
    	caster:RemoveModifierByName("modifier_heaven_charge")
    end

    if caster:HasModifier("modifier_shapeshifttravel") and caster:GetAbilityByIndex(5):GetLevel() >= 4 then
	    event.heal = event.heal*1.3
    end
    
    local healreceived = 1
    if target:HasModifier("modifier_deathwish") then
        healreceived = healreceived + 0.25
    end
    if target:HasModifier("modifier_item_lifesteal_10") then
        healreceived = healreceived + 0.1
    end
    if target:HasModifier("modifier_item_crit_pure_2") then
        healreceived = healreceived + 0.1
    end
    if target:HasModifier("modifier_item_crit_pure_3") then
        healreceived = healreceived + 0.15
    end
    if target:HasModifier("modifier_item_crit_pure_4") then
        healreceived = healreceived + 0.1
    end
    if target:HasModifier("modifier_item_set_str_tank_full_t1") or target:HasModifier("modifier_item_set_str_tank_full_t1_dream") then
        healreceived = healreceived + 0.20
    end
    if target:HasModifier("modifier_lifesteal_double") then
        healreceived = healreceived + 0.5
    end
    event.heal = event.heal * healreceived

    if caster:HasModifier("modifier_mythic_abil") then
        event.heal = event.heal * (1 + caster:GetModifierStackCount("modifier_mythic_abil", nil)/100)
    end

    if caster:HasModifier("modifier_priest_talent_mana") and caster:GetAbilityByIndex(5):GetLevel() >= 3 then
	    event.heal = event.heal*1.08
    end

    if caster:GetName() == "npc_dota_hero_dazzle" and caster:GetAbilityByIndex(5):GetLevel() >= 4 then
        event.heal = event.heal*1.5
    end

    if caster:HasModifier("item_mother_of_dragons") then
        event.heal = event.heal*1.15
    end

    if event.innercdbonus and event.innercdbonus > 0 and not caster:HasModifier("modifier_inner_cd_bonus") then
	    event.heal = event.heal*event.innercdbonus/100
	    event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_inner_cd_bonus", nil)
    end

    if target:HasModifier("modifier_master_elements") then
	    event.heal = event.heal*1.2
    end

    if target:HasModifier("modifier_voidhp") then
        event.heal = event.heal*1.06
    end

    if event.druidlowbonus and event.druidlowbonus > 0 and target:GetHealth()/target:GetMaxHealth() < 0.35 then
    	event.heal = event.heal*(1 + event.druidlowbonus/100)
    end

    if event.critmanareg and critpossible == false then
    	caster:SetMana(caster:GetMana()+(caster:GetMaxMana()*event.critmanareg/100.0))
    	ParticleManager:CreateParticle("particles/items3_fx/mango_active.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
    end

    local talentshamancritheal = caster:GetAbilityByIndex(5)
    if critpossible == false and not event.crithealnoproc and not event.cannotcrit and talentshamancritheal and talentshamancritheal:GetLevel() >= 3 and talentshamancritheal:GetName() == "resto6" then
    	talentshamancritheal:ApplyDataDrivenModifier(caster, target, "modifier_shaman_crithot", nil)
    end

    -- Mortal Strike debuff
    if target:HasModifier("modifier_woundpoison") and event.retridmgtoheal == nil then
    	event.heal=event.heal *0.90
    end
    if target:HasModifier("modifier_woundpoison2") and event.retridmgtoheal == nil then
    	event.heal=event.heal *0.85
    end
    if target:HasModifier("modifier_healdebuff10") and event.retridmgtoheal == nil then
    	event.heal=event.heal *0.9
    end
    if target:HasModifier("modifier_healdebuff") and event.retridmgtoheal == nil then
    	event.heal=event.heal / 2
    end
    if target:HasModifier("modifier_healdebuff75") and event.retridmgtoheal == nil then
        event.heal = event.heal *0.25
    end
    if target:HasModifier("modifier_unholyheal") and event.retridmgtoheal == nil then
    	event.heal = 0
    end
    if target:HasModifier("modifier_item_shieldluna") then
    	event.heal=event.heal * 1.05
    end
    if caster:HasModifier("modifier_item_eternallife") then
    	event.heal=event.heal * 1.2
    end
    if target:HasModifier("modifier_earth_shield") and event.eshieldbonus then
    	event.heal=event.heal * event.eshieldbonus
    end
    if target:HasModifier("modifier_eternallife") then
    	event.heal = event.heal * 2
    end
    if caster:HasModifier("modifier_active9") then
        event.heal = event.heal * 1.3
    end
    -- Healing Dampening


    if COverthrowGameMode.RoundCountdown <= 360 and event.FromGuardian ~= 1 and COverthrowGameMode.GameState == 2 and COverthrowGameMode.PVEMode == 0 then
    	local factor = (100 + COverthrowGameMode.RoundCountdown - 360) / 100
    	if factor < 0.25 then
    		factor = 0.25
    	end
    	event.heal=event.heal * factor
    	--print("healing dampening on")
    end

    -- guardian bonus heal on same target
    if caster:HasModifier("modifier_guardian_self") and target:HasModifier("modifier_guardian") and event.FromGuardian ~= 1 then
    	event.heal=event.heal*1.25
    end

    local protpalatalent = target:GetAbilityByIndex(5)
    if protpalatalent and protpalatalent:GetLevel() >= 4 and protpalatalent:GetName() == "pala6" then
        event.heal=event.heal*1.25
    end

    -- sp heal bonus same target
    if event.alwaysself ~= nil then
    	if caster == target then
    		event.heal=event.heal*(1+event.alwaysself)
    	end
    end

    if event.healfactor then
    	event.heal = event.heal * event.healfactor / 100
    end

    -- healing absorb, dk spell
    local healabsorb = target:GetModifierStackCount("modifier_healabsorb", nil)
    if healabsorb > 0 and target.healabsorbability then
    	local diff = event.heal - healabsorb
    	if diff <= 0 then
    		target:SetModifierStackCount("modifier_healabsorb", target.healabsorbability, healabsorb-event.heal)
    		event.heal = 0	
    	else
    		event.heal = event.heal - healabsorb
    		target:RemoveModifierByName("modifier_healabsorb")
    	end
    end

    --track overhealing
    local missinghealth = target:GetMaxHealth()-target:GetHealth()
    local overhealing = event.heal - missinghealth
    if caster:GetUnitLabel() == "hero" and caster.healingdone then
    	if overhealing > 0 then
    		caster.healingdone = caster.healingdone + missinghealth
    	else
 			caster.healingdone = caster.healingdone + event.heal
 		end
    end

    if COverthrowGameMode.heal_collector and not COverthrowGameMode.heal_collector:IsNull() and target:HasModifier("modifier_heal_collector") then
        target = COverthrowGameMode.heal_collector
    end

    --talent
    if caster.talents and caster.talents[3] then
        event.heal = event.heal * (1 + 0.05*caster.talents[3])
    end
    if target.talents and target.talents[3] then
        event.heal = event.heal * (1 + 0.05*target.talents[3])
    end
    if caster.runeword and caster.runeword[13] then
        event.heal = event.heal * (1 + 0.01*caster.runeword[13])
    end
    if target.runeword and target.runeword[13] then
        event.heal = event.heal * (1 + 0.01*target.runeword[13])
    end

    if event.heal > 0 then
    	target:Heal(event.heal, caster)
        --talents
        if caster.talents and caster.talents[50] then
            local talent_ability = caster:FindAbilityByName("combat_system")
            if caster.talents[50] > 0 then
                local myevent = {}
                myevent.caster = caster
                myevent.target = caster
                myevent.buff = "modifier_talent_onheal_armor"
                myevent.ability = talent_ability
                myevent.dur = 4
                myevent.addstacks = 1
                myevent.max = 3 * caster.talents[50]
                ApplyBuffStack(myevent)
                if caster ~= target then
                    myevent.target = target
                    ApplyBuffStack(myevent)
                end
            end
        end
    else
    	return
    end
    if event.buffonfullheal and target:GetHealth() / target:GetMaxHealth() >= 1.0 then
        event.ability:ApplyDataDrivenModifier(caster, target, "modifier_holy_ring", {Duration = event.buffdur})
    end
    
    if caster:GetUnitLabel() == "pet" and caster.owner and caster.owner.healingdone then
 		caster.owner.healingdone = caster.owner.healingdone + event.heal
    end
    --print("healing for " .. event.heal)

    -- display fx
    if 	event.hidenumber ~= nil then
    	displaynumber = false
    else
    	CriticalStrikeFX(nil, target, event.heal, 0, displaynumber)
    end


    --special effect for guardian
    if 	event.FromGuardian ~= nil then
    	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_omniknight/omniknight_purification.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())
		ParticleManager:SetParticleControl(particle, 1, Vector(100,0,0))
    end

    if caster:HasModifier("modifier_guardian_self") and event.FromGuardian ~= 1 then
        local all = HeroList:GetAllHeroes()
        for i=1, #all do
            if all[i] and all[i] ~= target and all[i]:HasModifier("modifier_guardian") then
            	local myevent = {}
                myevent.caster = caster
                myevent.target = all[i]
                myevent.FromGuardian = 1
        		myevent.attributefactor = 0.0
        		myevent.spelldamagefactor = 0.0
                myevent.heal = event.heal
                HealUnit(myevent)
            end
    	end
    end

    -- sp heal bonus seperate target
    if event.alwaysself ~= nil then
    	if caster ~= target then
    		event.target=caster
    		event.attributefactor = 0.0
    		event.spelldamagefactor = 0.0
    		event.heal = event.heal*event.alwaysself
    		event.alwaysself = nil
    		HealUnit(event)
    	end
    end
end

function AddSpelldamage(event)
	target = event.target
	if target.spelldamage ~= nil then
		target.spelldamage = target.spelldamage+event.amount
	else
		target.spelldamage = event.amount
	end
end

function RemoveSpelldamage(event)
	target = event.target
	if target.spelldamage ~= nil then
		target.spelldamage = target.spelldamage-event.amount
	else
		target.spelldamage = 0
	end
end

function Arcane5(event)
	local caster = event.caster
	local target = event.target
	if target:GetTeamNumber() == caster:GetTeamNumber() then
  		ApplyBuff(event)
	else
		event.buff = "modifier_arcane_asslow"
		ApplyBuff(event)
	end
end

function Bookoflight(event)
	local caster = event.caster
	local a = event.event_ability
	if a then
		if a:GetManaCost(-1) > 0.0 then
			Timers:CreateTimer(0.05,function() 
	        	caster:SetMana(caster:GetMana()+4)
	    	end)
		end
	end
end

function RestoreMana( event)
	local caster = event.caster
	if event.affectunit then
		caster = event.unit
	end
	local manaclass = true
	local amount = event.amount
	if event.percent then
		amount = caster:GetMaxMana()*event.amount/100
	end
	if event.affectmanaform and caster:HasModifier("modifier_catform") and caster.OldMana then
		caster.OldMana = caster.OldMana+amount
	else
		if caster.Energy then
			manaclass = false
		end
		if manaclass or caster:HasModifier("modifier_catform_off") then
			caster:SetMana(caster:GetMana()+amount)
		end
	end

	if event.spfx ~= nil then
		particle = ParticleManager:CreateParticle("particles/units/heroes/hero_templar_assassin/templar_assassin_refraction_ring_base.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	end
end

function PayWithLife( event)
	caster = event.caster
	local reduce = event.life
	if event.percent ~= nil then
		reduce = caster:GetMaxHealth()*event.life/100
	end
	if caster:GetHealth() < reduce then
		caster:SetHealth(1)
	else
		caster:SetHealth(caster:GetHealth()-reduce)
	end
end


function ChannelManaFixStart( event )
    local caster = event.caster
    local target = event.target
    local ability = event.ability
    local heroName = caster:GetUnitName()
    --caster:GiveMana(event.mana)  

    if caster.Castbar ~= nil then
    	ParticleManager:DestroyParticle(caster.Castbar,true)
    end
    local particle = nil

    ability.wasinstant = false

    --first reset if it has ever been changed
    if ability.originalcastpoint ~= nil then
    	ability:SetOverrideCastPoint(ability.originalcastpoint)
    end
    --invis fix patrol and ambush
    if caster:HasModifier("modifier_invisible") then
        caster:RemoveModifierByName("modifier_invisible")
    end

    --handle instant casttime, warlock item
    local isalreadyinstant = 0
    if event.casttimeadjust ~= nil then
    	ability.warlockinstant = 0
    	if caster:HasModifier("modifier_activewarlock") then
    		if ability.originalcastpoint == nil then
    			ability.originalcastpoint = ability:GetCastPoint()
	    	end
	    	isalreadyinstant = 1
	    	ability.warlockinstant = 1
	    	local castpoint = 0.2
	    	event.casttime = castpoint
	    	ability:SetOverrideCastPoint(castpoint)
    	end
    end
    if isalreadyinstant == 0 and event.instantcast and event.instantcast == 1 then
        if ability.originalcastpoint == nil then
            ability.originalcastpoint = ability:GetCastPoint()
        end
        ability.wasinstant = true
        isalreadyinstant = 1
        local castpoint = 0.2
        event.casttime = castpoint
        ability:SetOverrideCastPoint(castpoint)
    end
    local reload = caster:GetModifierStackCount("modifier_lockreload", caster)
	if isalreadyinstant == 0 and reload >= 12 then
		if ability.originalcastpoint == nil then
			ability.originalcastpoint = ability:GetCastPoint()
    	end
    	ability.wasinstant = true
    	isalreadyinstant = 1
    	local castpoint = 0.2
    	event.casttime = castpoint
    	ability:SetOverrideCastPoint(castpoint)
	end
	--priest proc
	local priestcharge = caster:GetModifierStackCount("modifier_light_charge", caster)
	if isalreadyinstant == 0 and priestcharge >= 4 and ability:GetName() == "Light_of_Heaven" then
		if ability.originalcastpoint == nil then
			ability.originalcastpoint = ability:GetCastPoint()
    	end
    	ability.wasinstant = true
    	isalreadyinstant = 1
    	local castpoint = 0.2
    	event.casttime = castpoint
    	ability:SetOverrideCastPoint(castpoint)
	end
    --retri proc
    local retricharge = caster:GetModifierStackCount("modifier_fanatism", nil)
    if isalreadyinstant == 0 and retricharge >= 10 and event.retriinstant then
        if ability.originalcastpoint == nil then
            ability.originalcastpoint = ability:GetCastPoint()
        end
        ability.wasinstant = true
        isalreadyinstant = 1
        local castpoint = 0.2
        event.casttime = castpoint
        ability:SetOverrideCastPoint(castpoint)
    end
	--druid lifebloom proc
	if target then
		local lifebloomcharge = target:HasModifier("modifier_lifebloomfull")
		if isalreadyinstant == 0 and event.instantlifebloom and event.instantlifebloom == 1 and lifebloomcharge and ability:GetName() == "Regrowth" then
			if ability.originalcastpoint == nil then
				ability.originalcastpoint = ability:GetCastPoint()
	    	end
	    	ability.wasinstant = true
	    	isalreadyinstant = 1
	    	local castpoint = 0.2
	    	event.casttime = castpoint
	    	ability:SetOverrideCastPoint(castpoint)
		end
	end
	--moonkin instant roots
	local mooncharge = caster:GetModifierStackCount("modifier_suncharge", caster)
	if isalreadyinstant == 0 and event.rootinstant and mooncharge >= 5 then
		if ability.originalcastpoint == nil then
			ability.originalcastpoint = ability:GetCastPoint()
    	end
    	ability.wasinstant = true
    	isalreadyinstant = 1
    	local castpoint = 0.2
    	event.casttime = castpoint
    	ability:SetOverrideCastPoint(castpoint)
	end

	local instantbolt = caster:GetModifierStackCount("modifier_instantbolt", nil)
	if isalreadyinstant == 0 and instantbolt > 0 then
        if instantbolt == 1 then
            caster:RemoveModifierByName("modifier_instantbolt")
        else
            caster:SetModifierStackCount("modifier_instantbolt", event.ability, instantbolt-1)
        end
		if ability.originalcastpoint == nil then
			ability.originalcastpoint = ability:GetCastPoint()
    	end
    	ability.wasinstant = true
    	isalreadyinstant = 1
    	local castpoint = 0.2
    	event.casttime = castpoint
    	ability:SetOverrideCastPoint(castpoint)
	end

    local channel = ability:GetChannelTime()

    local speedbonus = 0
    local slowbonus = 0

    --local castpoint
   	if isalreadyinstant == 0 and channel <= 0.1 then
        --find bonuses
        local mods = caster:GetModifierCount()-1
        for i=0, mods do
            local name = caster:GetModifierNameByIndex(i)
    	    if name == "modifier_itemhaste20" then
    	    	speedbonus = speedbonus + 0.2
    	    end
            if name == "modifier_item_active5up" then
                speedbonus = speedbonus + 0.2
            end
            if name == "modifier_item_hasteproc" then
                speedbonus = speedbonus + 0.2
            end
            if name == "modifier_bloodlust_ele" then
                speedbonus = speedbonus + 2
            end
            if name == "modifier_bloodlust_ele_monster" then
                speedbonus = speedbonus + 0.5
            end
    	    if name == "modifier_activemage" then
                speedbonus = speedbonus + 0.25
    	    end
            if name == "modifier_itemhastebow" then
                speedbonus = speedbonus + 0.25
            end
            if name == "modifier_item_hunterbow" then
                speedbonus = speedbonus + 0.25
            end
            if name == "modifier_hasteproc25" then
                speedbonus = speedbonus + 0.25
            end
            if name == "modifier_active5up_haste" then
                speedbonus = speedbonus + 0.25
            end
            if name == "modifier_item_spellhaste_2" then
                speedbonus = speedbonus + 0.25
            end
            if name == "modifier_itemhaste50" then
                speedbonus = speedbonus + 0.5
            end
            if name == "modifier_itemhaste100" then
                speedbonus = speedbonus + 1
            end
            if name == "modifier_itemhaste100_2" then
                speedbonus = speedbonus + 1
            end
            local shadow_stance_cleric = caster:GetModifierStackCount("modifier_shadow_stance", nil)
            if shadow_stance_cleric > 0 and name == "modifier_shadow_stance" then
                speedbonus = speedbonus + 0.05 * shadow_stance_cleric
            end
            local as_path_talent = caster:GetModifierStackCount("modifier_attackspeed", nil)
            if as_path_talent > 0 and name == "modifier_attackspeed" then
                speedbonus = speedbonus + 0.005 * as_path_talent
            end
            --slows
    	    if name == "modifier_mindnumb" then
    	    	slowbonus = slowbonus + 0.2
    	    end
        end
        if (heroName == "npc_dota_hero_warlock" and caster:GetAbilityByIndex(4):GetLevel() >= 3) then
            speedbonus = speedbonus + 0.25
        end
        if (heroName == "npc_dota_hero_furion" and caster:GetAbilityByIndex(5):GetLevel() >= 3) then
            speedbonus = speedbonus + 0.5
        end
        if (event.hastebonus and event.hastebonus == 25) then
            speedbonus = speedbonus + 0.25
        end
        if caster.talents and caster.talents[32] and caster.talents[32] > 0 then
            speedbonus = speedbonus + 0.25 * caster.talents[32]
        end
        
        --set spell data
        if ability.originalcastpoint == nil then
            ability.originalcastpoint = ability:GetCastPoint()
        end
        local castpoint = ability:GetCastPoint() * (1 + slowbonus) / ( 1 + speedbonus)
        event.casttime = castpoint
        ability:SetOverrideCastPoint(castpoint)
	end


    if event.casttime ~= nil then
    	--print("casttime " .. event.casttime)
    	if event.casttime == 2.5 then
    		particle = ParticleManager:CreateParticle("particles/castbar25.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
    	elseif event.casttime >= 5 then
    		particle = ParticleManager:CreateParticle("particles/castbar5.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
		elseif event.casttime <= 0.35 then --almost instant, wont be noticable
			particle = ParticleManager:CreateParticle("particles/castbar02.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
		elseif event.casttime <= 1.77 and event.casttime >= 1.63 then
			particle = ParticleManager:CreateParticle("particles/castbar16.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
		elseif event.casttime <= 1.96 and event.casttime >= 1.78 then
			particle = ParticleManager:CreateParticle("particles/castbar1.92.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
		elseif event.casttime <= 2.45 and event.casttime >= 2.3 then
			particle = ParticleManager:CreateParticle("particles/castbar2.4.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
		elseif event.casttime <= 1.62 and event.casttime >= 1.53 then
			particle = ParticleManager:CreateParticle("particles/castbar160.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
		elseif event.casttime <= 1.52 and event.casttime >= 1.3 then
			particle = ParticleManager:CreateParticle("particles/castbar14.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
		elseif event.casttime <= 2.2 and event.casttime >= 2.03 then
			particle = ParticleManager:CreateParticle("particles/castbar21.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
		elseif event.casttime == 1 then
			particle = ParticleManager:CreateParticle("particles/castbar1.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
		elseif event.casttime <= 2.02 and event.casttime >= 1.98 then
			particle = ParticleManager:CreateParticle("particles/castbar.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
    	elseif event.casttime <= 3.25 and event.casttime >= 2.75 then
    		particle = ParticleManager:CreateParticle("particles/castbar3.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
        elseif event.casttime >= 0.36 and event.casttime < 0.5 then
            particle = ParticleManager:CreateParticle("particles/castbar04.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
        elseif event.casttime >= 0.5 and event.casttime < 0.7 then
            particle = ParticleManager:CreateParticle("particles/castbar06.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
        elseif event.casttime >= 0.7 and event.casttime < 0.9 then
            particle = ParticleManager:CreateParticle("particles/castbar08.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
        elseif event.casttime >= 0.9 and event.casttime < 1.1 then
            particle = ParticleManager:CreateParticle("particles/castbar10.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
        elseif event.casttime >= 1.1 and event.casttime < 1.3 then
            particle = ParticleManager:CreateParticle("particles/castbar12.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
    	end
    else
    	particle = ParticleManager:CreateParticle("particles/castbar.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
    	--particle = ParticleManager:CreateParticle("particles/castbardynamic.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
    	--ParticleManager:SetParticleControl(particle, 1, Vector(0.3,0,0))
    end
    
    --print("casttime "..event.casttime)
    --Set IsCasting
    caster.IsCasting = 1
    caster.Castbar = particle

    if caster:HasAbility("pveboss_system") then
        particle = ParticleManager:CreateParticle("particles/techies_suicide_dud_arcana_skull.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
        ParticleManager:SetParticleControlEnt(particle, 3, caster, PATTACH_POINT_FOLLOW, "attach_origin", caster:GetAbsOrigin(), true)
        --particle = ParticleManager:CreateParticle("particles/units/heroes/hero_oracle/oracle_false_promise_dmg_burst.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
    end

    --no longer change animation cuz of startpoint use
    --if event.ability:GetName() == "Snipe" then
    	--StartAnimation(caster, {activity=ACT_DOTA_CAST_ABILITY_4, duration=2.0, rate=0.5})
    --elseif event.ability:GetName() == "RootsDruid" or event.ability:GetName() == "CycloneDruid" then
    	--StartAnimation(caster, {activity=ACT_DOTA_CAST_ABILITY_4, duration=2.0, rate=0.5})
    --else
    	--StartAnimation(caster, {activity=ACT_DOTA_ATTACK, duration=2.0, rate=0.3})
    --end
end

function ChannelInterrupt( event )
    local caster = event.caster
    local ability = event.ability
    caster.IsCasting = 0
    EndAnimation(caster)
    if caster.Castbar ~= nil then
    	ParticleManager:DestroyParticle(caster.Castbar,true)
    end

    --[[if ability.originalcastpoint ~= nil then
	    if ability:GetCastPoint() ~= ability.originalcastpoint then
	    	ability:SetOverrideCastPoint(ability.originalcastpoint)
	    	print("resetting castpoint")
	    end
	end]]
    

end

function ChannelManaFixEnd( event )
    local caster = event.caster
    local ability = event.ability

    caster.IsCasting = 0

    if caster.Castbar ~= nil then
    	ParticleManager:DestroyParticle(caster.Castbar,true)
    end

    if ability.warlockinstant ~= nil then
    	if ability.warlockinstant == 1 then
    		caster:RemoveModifierByName("modifier_activewarlock")
    	end
    end

    --[[if ability.originalcastpoint ~= nil then
	    if ability:GetCastPoint() ~= ability.originalcastpoint then
	    	ability:SetOverrideCastPoint(ability.originalcastpoint)
	    	print("resetting castpoint")
	    end
	end]]
end

-- Castbar!
CastbarString = {"[_________]","[o________]","[oo_______]","[ooo______]","[oooo_____]","[ooooo____]","[oooooo___]","[ooooooo__]","[oooooooo_]","[ooooooooo]"}
function round(num) return math.floor(num+.5) end

function TalentBlinkPassive( event )
	local ability = event.event_ability
    local caster = event.caster
    event.ability = caster:GetAbilityByIndex(1)
    event.buff = "modifier_lavalance_proc"
    event.target = caster
    event.aoe = 600
    event.dontbreakccbuff = 1
    ApplyBuffAOE(event)
    event.buff = "modifier_lavalance_proc_delay"
    ApplyBuffAOE(event)
    
    --[[old stuff
	if event.dmgtaken then
        local blinkability = event.caster:GetAbilityByIndex(5)
		if blinkability and blinkability:GetLevel() >= 4 and event.dmgtaken > event.caster:GetMaxHealth()*0.15 then
  			blinkability:EndCooldown()
  			local particle = ParticleManager:CreateParticle("particles/econ/events/ti5/blink_dagger_end_ti5.vpcf", PATTACH_POINT_FOLLOW, event.caster)
  			EmitSoundOn("DOTA_Item.ClarityPotion.Activate", event.caster)
		end
		return
	end
	if ability:GetName() == "antimage_blink" then
		local caster = event.caster
        if ability:GetLevel() >= 2 then
            local myevent = {}
            myevent.caster = event.caster
            myevent.target = event.caster
            myevent.ability = caster:GetAbilityByIndex(3)
            myevent.buff = "modifier_reduction_50"
            myevent.dur = 3
            ApplyBuff(myevent)
        end
        
		if ability:GetLevel() >= 3 then
			event.ability = caster:GetAbilityByIndex(1)
			event.buff = "modifier_lavalance_proc"
			event.target = caster
			event.aoe = 600
			event.dontbreakccbuff = 1
			ApplyBuffAOE(event)
			event.buff = "modifier_lavalance_proc_delay"
			ApplyBuffAOE(event)
		end
		if ability:GetLevel() >= 2 then
			RemoveSlows(event)
		end
	end
    --]]
end

function LavaLanceProc( event )
	local caster = event.caster
	local target = event.attacker
	caster:GetAbilityByIndex(1):ApplyDataDrivenModifier(caster, target, "modifier_lavalance_proc", nil)
end

function OutOfCombat( event )
    if event.onflamebasher then
        event.caster.ooc = 8
        event.caster:RemoveModifierByName("modifier_oocmana")
    end
    if event.onattacked then
        event.attacker.ooc = 8
        event.caster.ooc = 8
        event.attacker:RemoveModifierByName("modifier_oocmana")
        event.caster:RemoveModifierByName("modifier_oocmana")
    end
	if event.onattack then
		event.attacker.ooc = 8
		event.target.ooc = 8
		event.attacker:RemoveModifierByName("modifier_oocmana")
		event.target:RemoveModifierByName("modifier_oocmana")
	end
	if event.onspell ~= nil then
		local ability = event.event_ability
		if ability:GetName() == "ShapeshiftFeral" or ability:GetName() == "Shapeshift" or ability:GetName() == "item_bootsswiftup" then
			return
		end
		event.caster.ooc = 8
		event.caster:RemoveModifierByName("modifier_oocmana")
		if event.target ~= nil then
			--print(event.target:GetName())

			event.target.ooc = 8
			event.target:RemoveModifierByName("modifier_oocmana")
		end
	end
	--print(caster:GetName())
end

function RemoveOutOfCombat( event )
	local caster = event.caster
	caster.ooc = 8
	caster:RemoveModifierByName("modifier_oocmana")
	--print(caster:GetName())
end

function StartLoopSound( event )
    local caster = event.caster
	EmitSoundOn(event.sound, caster)
end

function StopLoopSound( event )
    local caster = event.caster
    StopSoundOn(event.sound, caster)
end

function SetChannelTarget( event )
    local caster = event.caster
    local target = event.target
    caster.channeltarget = target
end

function StopChannelTarget( event )
    local caster = event.caster
    local target = caster.channeltarget
    if target and not target:IsNull() then
        target:RemoveModifierByName(event.buff)
    end
end

function DruidTalentManaregen( event )
    local caster = event.caster
	local mana = caster:GetConstantBasedManaRegen() + caster:GetStatsBasedManaRegen()
	mana = math.floor(mana * event.percent / 10)
	caster:RemoveModifierByName("modifier_shapeshifttravel_mana_value")
	event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_shapeshifttravel_mana_value", nil)
	caster:SetModifierStackCount("modifier_shapeshifttravel_mana_value", event.ability, mana)
end

function DruidTalentAOERoots( event )
    local caster = event.caster
    local target = event.target

    if event.dur and event.dur > 0 then
    	event.ability = caster:GetAbilityByIndex(3)
    	event.buff = "modifier_rootsdruid"
    	CCTarget(event)
    	if event.ability:GetLevel() >= 4 then
    		event.buff = "modifier_mindnumb"
    		event.dur = 8
    		CCTarget(event)
    	end
    	event.damage = 0.0
    	event.spelldamagefactor = 150
    	event.attributefactor = 100
    	event.naturedmg = 1
    	DamageUnit(event)
    end
end

function OutOfCombatCounter( event )
	local caster = event.caster

	if caster:HasModifier("modifier_item_aether_lens") then
		if caster:HasModifier("modifier_oocmana") then
			event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_aether_lens_mana", nil)
			event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_aether_lens_mana", nil)
			--caster:SetMana(caster:GetMana()+2)
		else
			event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_aether_lens_mana", nil)
			--caster:SetMana(caster:GetMana()+1)
		end
	end
	if caster.OOCCounter ~= 1 or event.OOCCounterallow ~= nil then
		caster.OOCCounter = 1
		event.OOCCounterallow = 1
		if caster.ooc == nil then
			caster.ooc = 8
		end
		caster.ooc = caster.ooc - 1
		if caster.ooc < 0 then
			caster.ooc = 0
		end
		--print(caster:GetName())
		--print(caster.ooc)
		if caster.ooc == 0 then
			--mount
			local heroName = caster:GetUnitName()
			if heroName == "npc_dota_hero_mirana" or heroName == "npc_dota_hero_abaddon" or heroName == "npc_dota_hero_chen" or heroName == "npc_dota_hero_disruptor" or caster:HasModifier("modifier_mount_standard") or (caster.hasmount and caster.hasmount == 1) then
				event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_mount_speed", nil)
			end
            if  caster.hasmount and caster.hasmount == 2 then
                event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_mount_speed_epic", nil)
            end
			--homeland speed
			if COverthrowGameMode.GameState == 4 then
				if caster:HasModifier("modifier_fountain_aura_buff") then
					event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_homeland_speed", nil)
				end
			end

			if caster.oocmana > 0 or GetMapName() == "10vs10_city_raid" or COverthrowGameMode.junglemode then
				event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_oocmana", nil)
			end
			local nightbladebonus = 0
			if caster:HasModifier("modifier_item_nightblade") or caster:HasModifier("modifier_item_rogueblades") then
				nightbladebonus = 1
			end
			if caster.oocmana == 2 then
				--stealth users here
				local ability = caster:GetAbilityByIndex(5)
				if ability ~= nil then
					local cdremaining = ability:GetCooldownTimeRemaining()
					if cdremaining > 0.1 and not caster:HasModifier("modifier_stealthrogue") then
						ability:EndCooldown()
						ability:StartCooldown(cdremaining-(3+nightbladebonus))
						local particle = ParticleManager:CreateParticle("particles/items3_fx/glimmer_cape_initial_flash_smoke.vpcf", PATTACH_POINT_FOLLOW, caster)
					end
 					--if ability:GetCooldownTimeRemaining() <= 10.0 and ability:GetCooldownTimeRemaining() > 0.1 then
 					--	ability:EndCooldown()
 					--	local particle = ParticleManager:CreateParticle("particles/econ/events/ti4/blink_dagger_steam_ti4.vpcf", PATTACH_POINT_FOLLOW, caster)
 					--end
				end
			end
			if caster.oocmana == 3 then
				--feral druid here
				local ability = caster:GetAbilityByIndex(3)
				if ability ~= nil then
					local cdremaining = ability:GetCooldownTimeRemaining()
					if cdremaining > 0.1 and not caster:HasModifier("modifier_stealthcat") then
						ability:EndCooldown()
						ability:StartCooldown(cdremaining-(3+nightbladebonus))
						local particle = ParticleManager:CreateParticle("particles/items3_fx/glimmer_cape_initial_flash_smoke.vpcf", PATTACH_POINT_FOLLOW, caster)
					end
					--print(ability:GetName())
 					--if ability:GetName() == "Feral1" and ability:GetCooldownTimeRemaining() > 0.1 and ability:GetCooldownTimeRemaining() <= 10.0 then
 					--	ability:EndCooldown()
 					--	local particle = ParticleManager:CreateParticle("particles/econ/events/ti4/blink_dagger_steam_ti4.vpcf", PATTACH_POINT_FOLLOW, caster)
 					--end
				end
			end
		else
			caster:RemoveModifierByName("modifier_mount_speed")
            caster:RemoveModifierByName("modifier_mount_speed_epic")
		end
		Timers:CreateTimer(1.0,function() 
        	OutOfCombatCounter(event)
    	end)
	end
end

function OutOfCombatManaReg( event )
	local caster = event.caster
	local oldpos = caster.OOCPosition
	if oldpos ~= nil then
		local distance = (oldpos-caster:GetAbsOrigin()):Length()
		if distance < 25.0 and (caster.oocmana == 1 or caster.oocmana == 3) then
			local amount = 0.03
			if COverthrowGameMode.junglemode then
				amount = 0.05
			end
			caster:SetMana(caster:GetMana()+caster:GetMaxMana()*amount)
			if (COverthrowGameMode.GameState >= 2 or COverthrowGameMode.junglemode) and caster:GetMana() / caster:GetMaxMana() < 1.0 then
				local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_obsidian_destroyer/obsidian_destroyer_sanity_eclipse_mana_loss.vpcf", PATTACH_POINT_FOLLOW, caster)
				ParticleManager:SetParticleControl(particle, 0, caster:GetAbsOrigin())
				ParticleManager:SetParticleControl(particle, 1, caster:GetAbsOrigin())
			end
		end
		if distance < 25.0 and (GetMapName() == "10vs10_city_raid" or COverthrowGameMode.junglemode) and caster:GetHealth() / caster:GetMaxHealth() < 1.0 then
			--city raid hp regen
			--if GetMapName() == "10vs10_city_raid" then
				caster:SetHealth(caster:GetHealth()+caster:GetMaxHealth()*0.03)
				local particle = ParticleManager:CreateParticle("particles/generic_gameplay/generic_lifesteal.vpcf", PATTACH_POINT_FOLLOW, caster)
		  	--end
		end
	end
	caster.OOCPosition = caster:GetAbsOrigin()
end

function CastbarMaker(event)
	local caster = event.caster

	if caster.IsCasting == 1 then
		if caster.Castbar == nil then
			caster.Castbar = 0.0
		else
			--caster.Castbar = caster.Castbar + 0.13
		end

		percentage = caster.Castbar / event.ability:GetChannelTime()
		--print("cahnneltime")
		--print(event.ability:GetChannelTime())
		--print(percentage)
		if percentage > 1.1 then
			caster.Castbar = 0.0
		else
			local s = round(percentage*10)
			print(s)
			if s < 1 then
				s = 1
			end
			--DebugScreenTextPretty(caster:GetOrigin()[1], caster:GetOrigin()[3], 10, CastbarString[s], 255, 255, 255, 100, 1.0, "Arial", 10, true)
			if s>=10 then
				DebugDrawText(caster:GetOrigin(), CastbarString[s], true, 0.5)
			else
				DebugDrawText(caster:GetOrigin(), CastbarString[s], true, 0.13)
			end
			--local ve = vec.new(2,2,2)
			--DebugDrawLine(caster:GetOrigin(), caster:GetOrigin()*2, 255, 255, 255, true, 0.11)
			local vec = caster:GetOrigin()
			local vec2 = caster:GetOrigin()
			vec[1]=vec[1]-50
			vec[2]=vec[2]-50
			vec[3]=vec[3]-50
			vec2[1]=vec2[1]+250
			vec2[2]=vec2[2]+250
			vec2[3]=vec2[3]+250

			local rot = AxisAngleToQuaternion(vec, 0) --[[Returns:Quaternion
			(''vector'',''float'') constructs a quaternion representing a rotation by angle around the specified ''vector'' axis
			]]
			--print("testforcoord")
			--print(vec[1])
			--CDebugOverlayScriptHelper.SweptBox(caster:GetOrigin(), caster:GetOrigin(), caster:GetOrigin(), caster:GetOrigin(), rot, 255, 255, 255, 255, 10.0)
			--OverlayScriptHelper:VectorText3D(caster:GetOrigin(), rot, "hellofuc", 255, 255, 255, 255,true, 10.0) 
			--DebugDrawBox(caster:GetOrigin(), vec, vec2, 255, 255, 255, 255, 10.0)
			--DebugDrawBoxDirection(Vector a, Vector b, Vector c, Vector d, Vector e, float f, float g)

			--DebugDrawSphere(caster:GetOrigin(), color, 100, 20, true, 0.11)
			caster.Castbar = caster.Castbar + 0.10
			Timers:CreateTimer(0.1,function() 
		        CastbarMaker(event)
		    end)
		end
	end
end

function GameMechanics:DamageTaken(event)
	--print("damage taken")
	--print(event.damage)
end





SwitchStancesLvl1 = {0,0,0,0,0,0,0,0,0,0}
SwitchStancesLvl2 = {0,0,0,0,0,0,0,0,0,0}
SwitchStancesLvl3 = {0,0,0,0,0,0,0,0,0,0}

-- Warrior -------------------------------------------------------------------------------------------------------------------------------------------------------------

function ShieldReflect(event)
	--DeepPrintTable(event)

	local caster = event.caster
	local target = event.attacker
	local damage = event.dmg
	--print(event.ability)
    if not event.dontheal then
	   caster:Heal(damage, caster)
    end
	if target:HasModifier("modifier_shieldreflect") then

	else
		if event.lowcondition and caster:GetHealth()/caster:GetMaxHealth() >= event.lowcondition/100.0 then
            return
        end
        if event.returnfactor then
            damage = damage * event.returnfactor / 100
        end
        if damage > caster:GetMaxHealth()*0.15 then
            damage = caster:GetMaxHealth()*0.15
        end
        if event.attackerhpcap and damage > target:GetMaxHealth() * event.attackerhpcap then
            damage = target:GetMaxHealth()*event.attackerhpcap
        end
        event.damage = damage
		event.target = target
		--event.ability = caster:GetAbilityByIndex(5)
		event.attributefactor = 0.0
        event.spelldamagefactor = 0.0
        event.cannotcrit = 1
        event.isreflected = true
    	DamageUnit(event)
    end
end

function FixCDStance(event)
	--print("charge test")
end

function SwitchStances(event)
	local hero = event.caster
	local abil1 = hero:GetAbilityByIndex(0)
	local abil2 = hero:GetAbilityByIndex(1)
	local abil3 = hero:GetAbilityByIndex(2)
	local id = hero:GetPlayerOwnerID()+1

	if abil1:GetAbilityName() == "Wounding_Strike" then
		--print("to defensive")
		event.ability:ApplyDataDrivenModifier(hero, hero, "modifier_defstance", nil)
		SwitchStancesLvl1[id]=abil1:GetLevel()
		SwitchStancesLvl2[id]=abil2:GetLevel()
		SwitchStancesLvl3[id]=abil3:GetLevel()

  		hero:RemoveAbility(abil1:GetAbilityName())
  		hero:RemoveAbility(abil2:GetAbilityName())
  		hero:RemoveAbility(abil3:GetAbilityName())

  		hero:AddAbility("WarriorCharge")
  		hero:FindAbilityByName("WarriorCharge"):SetLevel(hero:FindAbilityByName("Switch_Battle_Stance"):GetLevel())
  		hero:AddAbility("Shield_Reflect")
  		hero:FindAbilityByName("Shield_Reflect"):SetLevel(hero:FindAbilityByName("Switch_Battle_Stance"):GetLevel())
  		hero:AddAbility("Terror_Shout")
  		hero:FindAbilityByName("Terror_Shout"):SetLevel(hero:FindAbilityByName("Switch_Battle_Stance"):GetLevel())
  	else
  		--print("to offensive")
  		hero:RemoveModifierByName("modifier_defstance")
  		-- fix crash on switch while charging
		if hero:HasModifier("modifier_WarriorCharge") then
	 		Timers:CreateTimer(1.0,function() 
		        fixChargeStanceSwitch(hero)
		    end)
		else
	  		hero:RemoveAbility(abil1:GetAbilityName())
	  		hero:AddAbility("Wounding_Strike")
	  		hero:FindAbilityByName("Wounding_Strike"):SetLevel(SwitchStancesLvl1[id])
		end

  		hero:RemoveAbility(abil2:GetAbilityName())
  		hero:AddAbility("Mortal_Swing")
  		hero:FindAbilityByName("Mortal_Swing"):SetLevel(SwitchStancesLvl2[id])

  		hero:RemoveAbility(abil3:GetAbilityName())
  		hero:AddAbility("Concussive_Blow")
  		hero:FindAbilityByName("Concussive_Blow"):SetLevel(SwitchStancesLvl3[id])
  		
  	end
end

function fixChargeStanceSwitch(hero)
	if hero:HasModifier("modifier_WarriorCharge") then
 		Timers:CreateTimer(1.0,function() 
	        fixChargeStanceSwitch(hero)
	    end)
	else
		local abil1 = hero:GetAbilityByIndex(0)
  		hero:RemoveAbility(abil1:GetAbilityName())
  		hero:AddAbility("Wounding_Strike")
  		local id = hero:GetPlayerOwnerID()+1
  		hero:FindAbilityByName("Wounding_Strike"):SetLevel(SwitchStancesLvl1[id])
	end
end

function SwordStorm(event)
	DamageAOE(event)
	Timers:CreateTimer(1.5,function() 
        DamageAOE(event)
    end)
    Timers:CreateTimer(3.0,function() 
        DamageAOE(event)
    end)
    Timers:CreateTimer(4.5,function() 
        DamageAOE(event)
    end)
    Timers:CreateTimer(6.0,function() 
        DamageAOE(event)
    end)
    --event.amount=60
    --event.interval=0.1
    --PurgePeriodic(event)
end

function PurgePeriodic(event)
	for i=0,event.amount-1 do 
		local RemovePositiveBuffs = false
		local RemoveDebuffs = true
		local BuffsCreatedThisFrameOnly = false
		local RemoveStuns = true
		local RemoveExceptions = false
		Timers:CreateTimer(i*event.interval+0.01,function() 
        	event.caster:Purge( RemovePositiveBuffs, RemoveDebuffs, BuffsCreatedThisFrameOnly, RemoveStuns, RemoveExceptions)
        	if i%3==0 then
        		StartAnimation(event.caster, {activity=ACT_DOTA_CAST_ABILITY_3, duration=0.3, rate=1.2})
        		local target = event.caster
				local particle = ParticleManager:CreateParticle("particles/econ/items/axe/axe_weapon_bloodchaser/axe_attack_blur_counterhelix_bloodchaser.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
				--StartSoundEventFromPosition("sounds/weapons/hero/axe/counterhelix.wav" ,event.caster:GetOrigin())
				--event.caster:EmitSound("sounds/weapons/hero/axe/counterhelix.wav")
				EmitSoundOn( "Hero_Axe.CounterHelix_Blood_Chaser", event.caster)
        	end
    	end)
		
	end
end

function DamageUnitConditional(event)
    local caster = event.caster
    local target = event.target

    if caster:GetTeamNumber() == target:GetTeamNumber() then

    else
        DamageUnit(event)
    end
end

function ApplyBuffFriendEnemy(event)
    local caster = event.caster
    local target = event.target

    if caster:GetTeamNumber() == target:GetTeamNumber() then
        event.buff = event.bufffriend
        ApplyBuff(event)
    end
    if caster:GetTeamNumber() ~= target:GetTeamNumber() then
        event.buff = event.buffenemy
        ApplyBuff(event)
    end
end

function ApplyBuffConditional(event)
    local caster = event.caster
    local target = event.target

    if caster:GetTeamNumber() == target:GetTeamNumber() and event.onlyfriend then
        ApplyBuff(event)
    end
    if caster:GetTeamNumber() ~= target:GetTeamNumber() and event.onlyenemy then
        ApplyBuff(event)
    end
end

function NinjaSetBuff(event)
    local caster = event.caster
    if caster:HasModifier("modifier_talent_enrage") then
        event.dur = event.dur * 2
    end
    ApplyBuff(event)
end

function PurgeConditional(event)
    local caster = event.caster
    local target = event.target
    if caster:GetTeamNumber() == target:GetTeamNumber() then
        PurgeUnit(event)
    else
        PurgeEnemyUnit(event)
    end
end

function PurgeIfFriend(event)
    local caster = event.caster
    local target = event.target
    if caster:GetTeamNumber() == target:GetTeamNumber() then
        PurgeUnit(event)
    end
end

function RestoreManaIfFriend(event)
    local caster = event.caster
    local target = event.target
    if caster:GetTeamNumber() == target:GetTeamNumber() then
        RestoreMana(event)
    end
end

function HealUnitIfFriend(event)
    local caster = event.caster
    local target = event.target
    if caster:GetTeamNumber() == target:GetTeamNumber() then
        HealUnit(event)
    end
end

function WarlockPurge(event)
	local caster = event.caster
	local target = event.target

	if caster:GetTeamNumber() == target:GetTeamNumber() then
		PurgeUnit(event)
	else
		PurgeEnemyUnit(event)

		local myevent = {}
		myevent.caster = caster
		myevent.target = target
		myevent.buff = "modifier_slow50"
		myevent.ability = event.ability
		myevent.dur = event.dur
		ApplyBuff(myevent)
	end
end

--Paladin -------------------------------------------------------------------------------------------------------------------------------------------

function HolyJudgement(event)
	local caster = event.caster
	local target = event.target

	if caster:GetTeamNumber() == target:GetTeamNumber() then
		HealUnit(event)
	else
		event.spelldamagefactor = event.spelldamagefactor * event.dmgfactor/100
		event.attributefactor = event.attributefactor * event.dmgfactor/100
        event.critdmgbonusfactor = nil
		DamageUnit(event)
		local table = {}
		table.Duration = 5
		event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_wisdom", table)
	end
end

function Penance(event)
    local caster = event.caster
    local target = event.target

    if caster:GetTeamNumber() == target:GetTeamNumber() then
        HealUnit(event)
    else
        if event.darkstacks and event.darkstacks > 0 then
            local myevent = {}
            myevent.caster = caster
            myevent.target = target
            myevent.darkstacks = event.darkstacks
            ShadowCrippleStacks(myevent)
        end
        event.spelldamagefactor = event.spelldamagefactor * event.dmgfactor/100
        event.attributefactor = event.attributefactor * event.dmgfactor/100
        DamageUnit(event)
    end
end

function HealPercentage( event )
	local caster = event.target
	if event.selftarget ~= nil then
		caster = event.caster
	end
	caster:SetHealth(caster:GetHealth()+caster:GetMaxHealth()*event.heal/100)
end

-- Rogue -----------------------------------------------------------------------------------------------------------------------------------------------------

function AddCPEffect(event)

	local caster = event.caster
	local cp = caster.ComboPoints
	if cp == nil or caster == nil then
		return
	end

	if caster.cpparticle then
		ParticleManager:DestroyParticle(caster.cpparticle, false)
	end

	local fx = "particles/combopoint3.vpcf"
	if caster:GetName() == "npc_dota_hero_dazzle" then
		fx = "particles/combopoint4.vpcf"
	end

	local particle = ParticleManager:CreateParticleForPlayer(fx, PATTACH_POINT_FOLLOW, caster, caster:GetOwner())
	if caster.ComboPoints == 1 then
		ParticleManager:SetParticleControl(particle, 1, Vector(1,0,0))
	elseif caster.ComboPoints == 2 then
		ParticleManager:SetParticleControl(particle, 1, Vector(1,0,0))
		ParticleManager:SetParticleControl(particle, 2, Vector(1,0,0))
	elseif caster.ComboPoints == 3 then
		ParticleManager:SetParticleControl(particle, 1, Vector(1,0,0))
		ParticleManager:SetParticleControl(particle, 2, Vector(1,0,0))
		ParticleManager:SetParticleControl(particle, 3, Vector(1,0,0))
	elseif caster.ComboPoints == 4 then
		ParticleManager:SetParticleControl(particle, 1, Vector(1,0,0))
		ParticleManager:SetParticleControl(particle, 2, Vector(1,0,0))
		ParticleManager:SetParticleControl(particle, 3, Vector(1,0,0))
		ParticleManager:SetParticleControl(particle, 4, Vector(1,0,0))
	elseif caster.ComboPoints == 5 then
		ParticleManager:SetParticleControl(particle, 1, Vector(1,0,0))
		ParticleManager:SetParticleControl(particle, 2, Vector(1,0,0))
		ParticleManager:SetParticleControl(particle, 3, Vector(1,0,0))
		ParticleManager:SetParticleControl(particle, 4, Vector(1,0,0))
		ParticleManager:SetParticleControl(particle, 5, Vector(1,0,0))
	end
	caster.cpparticle = particle
	
end

function RemoveCPEffect(event)

	local caster = event.caster
	local cp = caster.ComboPoints

	if caster.cpparticle then
		ParticleManager:DestroyParticle(caster.cpparticle, false)
	end

	local fx = "particles/combopoint3.vpcf"
	if caster:GetName() == "npc_dota_hero_dazzle" then
		fx = "particles/combopoint4.vpcf"
	end

	local particle = ParticleManager:CreateParticleForPlayer(fx, PATTACH_POINT_FOLLOW, caster, caster:GetOwner())
	--if caster.ComboPoints == 1 then
	--	ParticleManager:SetParticleControl(particle, 1, Vector(1,0,0))
	--elseif caster.ComboPoints == 2 then
	--	ParticleManager:SetParticleControl(particle, 1, Vector(1,0,0))
	--	ParticleManager:SetParticleControl(particle, 2, Vector(1,0,0))
	--elseif caster.ComboPoints >= 3 then
	--	ParticleManager:SetParticleControl(particle, 1, Vector(1,0,0))
	--	ParticleManager:SetParticleControl(particle, 2, Vector(1,0,0))
	--	ParticleManager:SetParticleControl(particle, 3, Vector(1,0,0))
	--end
	caster.cpparticle = particle
	
end

function NumbingCut(event)
	local caster = event.caster
	local target = event.target
	local cp = caster.ComboPoints
	local damage_table = {}

	if cp > 0 then
		--damage_table.Duration = cp*event.buffduration
		--event.ability:ApplyDataDrivenModifier(caster, target, "modifier_stunned", damage_table)

		local myevent = {}
		myevent.caster = caster
		myevent.target = target
		myevent.buff = "modifier_stunned"
		myevent.ability = event.ability
		myevent.dur = cp*event.buffduration
		ApplyBuff(myevent)

		caster.ComboPoints = 0
		caster:RemoveModifierByName("modifier_combopoint")
	else
		event.ability:EndCooldown()
	end

	-- test todo
	--DebugDrawText(caster:GetOrigin() , "IIIIIIIIII", true, 10.0)
	--Text(caster:GetOrigin(), 20, "Yo |||||||||", 10.0, 5, 5, 5, 5, 10.0)
	--CDebugOverlayScriptHelper:VectorText3D(caster:GetOrigin(), caster:GetAngles(), "Yo |||||||||", 5, 5, 5, 5, 5, 10.0)
	--DebugDrawBoxDirection(caster:GetOrigin(), caster:GetOrigin(), caster:GetOrigin()*3, caster:GetOrigin(), caster:GetOrigin(), 100.0, 10.0) 
end

function SetPositionAhead( event )
    local caster = event.caster
    local target = event.target
    local offset = caster:GetForwardVector():Normalized()*event.range*20
    --print(offset)
    target:SetAbsOrigin(offset)
end

function FatalThrow(event)
	local caster = event.caster
	local target = event.target
	local cp = caster.ComboPoints
	local damage_table = {}
	caster.FatalThrowCP = 0

	if cp > 0 then
		caster.FatalThrowCP = cp
		caster.ComboPoints = 0
		caster:RemoveModifierByName("modifier_combopoint")
		--blink
		if event.ability:GetLevel() >= 4 then
			local offset = target:GetForwardVector():Normalized()*80
			offset = Vector(offset[1], offset[2],0)
            Timers:CreateTimer(0.05, function()
                caster:SetAbsOrigin(target:GetAbsOrigin()-offset)
            end)
			local tab = {}
			tab.Duration = 0.2
			event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_phased", tab)
		end
	else
		event.ability:EndCooldown()
	end
end

function ItemCastAllowed(event)
	local caster = event.caster
	if caster:HasModifier("modifier_voodoo_datadriven") then
		return false
	end
	return true
end

function Lightbringer(event)
	local caster = event.caster
	local ability = event.ability
	if true or ItemCastAllowed(event) then --itemcastallowed could be used later
		ApplyBuff(event)
	else
 		ability:EndCooldown()
	end
end

function SmokeBomb(event)
	local caster = event.unit
	local target = event.target
	--print(caster:GetName())
	--print(target:GetName())
	if target == nil or caster == target or (target:HasModifier("modifier_smokebomb") and caster:HasModifier("modifier_smokebomb")) or (not target:HasModifier("modifier_smokebomb") and not caster:HasModifier("modifier_smokebomb"))  then
		return
	else
		--print("smoke bombed")	
		event.dur = 0.1
		event.buff = "modifier_silence"
		event.target = caster
		ApplyBuff(event)
		
		Timers:CreateTimer(0.03, function()
			caster:Stop()
		end)
		ParticleManager:CreateParticleForPlayer("particles/screen_smoke_1.vpcf", PATTACH_POINT_FOLLOW, caster, caster:GetOwner())
		--local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_riki/riki_tricks_cast.vpcf", PATTACH_POINT_FOLLOW, caster)
		--particle = ParticleManager:CreateParticle("particles/econ/events/ti4/dagon_ti4.vpcf", PATTACH_POINT_FOLLOW, target)
		--ParticleManager:SetParticleControl(particle, 1, caster:GetAbsOrigin()+Vector(0,0,80))
		--ParticleManager:SetParticleControl(particle, 2, Vector(1,0,0))
		--EmitSoundOn("Hero_BountyHunter.Target", caster)
	end
end

function Envenom(event)
	local caster = event.caster
	local target = event.target
	local cp = caster.ComboPoints
	caster.cpbaseddmg = cp

	if cp > 0 then
		caster.ComboPoints = 0
		caster:RemoveModifierByName("modifier_combopoint")
		--event.ability:ApplyDataDrivenModifier(caster, target, "modifier_envenom", nil)
		event.includeauto = event.includeauto * cp
		DamageUnit(event)
		event.target = event.caster
		ApplyBuff(event)
	else
		event.ability:EndCooldown()
	end
end

function Bladerush(event)
	local caster = event.caster
	local cp = caster.ComboPoints

	if cp > 0 then
		caster.ComboPoints = 0
		caster:RemoveModifierByName("modifier_combopoint")
		local tab = {}
		tab.Duration = 7*cp
		event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_bladerush", tab)
	else
		event.ability:EndCooldown()
	end
end

function Tigerfury(event)
	local caster = event.caster
	local cp = caster.ComboPoints

	if cp > 0 then
		caster.ComboPoints = 0
		caster:RemoveModifierByName("modifier_combopoint")
		local tab = {}
		tab.Duration = event.dur*cp
		event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_tigerfury", tab)
	else
		event.ability:EndCooldown()
	end
end

function FatalThrowHit(event)
	local caster = event.caster
	local target = event.target

	if caster.FatalThrowCP > 0 then

		local myevent = {}
		myevent.caster = caster
		myevent.target = target
		myevent.buff = "modifier_silence"
		myevent.ability = event.ability
		myevent.dur = caster.FatalThrowCP*event.silence
		ApplyBuff(myevent)

		event.attributefactor = event.attributefactor * caster.FatalThrowCP
        event.includeauto = event.includeauto * caster.FatalThrowCP
		DamageUnit(event)

		--damage_table.Duration = caster.FatalThrowCP*2
		--event.ability:ApplyDataDrivenModifier(caster, target, "modifier_slow50", damage_table)

		local myevent = {}
		myevent.caster = caster
		myevent.target = target
		myevent.buff = "modifier_slow50"
		myevent.ability = event.ability
		myevent.dur = caster.FatalThrowCP*event.slow
		ApplyBuff(myevent)
		
	end
end

function Ambush(event)
	local caster = event.caster
	local target = event.target

	local angleDiff = target:GetAngles()[2]-caster:GetAngles()[2]
	if angleDiff < 0.0 then
		angleDiff = -angleDiff
	end

	if (angleDiff <= 90.0 or angleDiff >= 270.0) then
		local damage_table = {}
		damage_table.Duration = -1
		event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_combopoint", damage_table)
		caster.ComboPoints=caster.ComboPoints+2
		if caster.ComboPoints > 3 then
   			caster.ComboPoints = 3
   		end
   		caster:SetModifierStackCount("modifier_combopoint", event.ability, caster.ComboPoints)
   		AddCPEffect(event)
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_nyx_assassin/nyx_assassin_vendetta_blood.vpcf", PATTACH_POINT_FOLLOW, target)
        ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin())
   		DamageUnit(event)
   	else
   		--print("end")
   		--event.ability:EndCooldown()
	end

	--print(caster:GetAngles()[2])

	--if caster:GetRotat
end

function Stealth(event)
	--print("steaklth test")
	local hero = event.caster
	local level = event.ability:GetLevel()
	local abil1 = hero:GetAbilityByIndex(0)
	local abil2 = hero:GetAbilityByIndex(1)

	hero.StealthSpell1=abil1:GetLevel()
	hero.StealthSpell2=abil2:GetLevel()

	hero:RemoveAbility(abil1:GetAbilityName())
	hero:RemoveAbility(abil2:GetAbilityName())

	if hero:GetName() == "npc_dota_hero_bounty_hunter" then
		hero:AddAbility("combat7")
		hero:FindAbilityByName("combat7"):SetLevel(level)
	else
		hero:AddAbility("Narcotic_Strike")
		hero:FindAbilityByName("Narcotic_Strike"):SetLevel(level)
	end
	hero:AddAbility("Paralyse")
	hero:FindAbilityByName("Paralyse"):SetLevel(level)
	hero:FindAbilityByName("Paralyse"):EndCooldown()
end

function StealthSapBuffFix(event)
	local caster = event.caster
	local damage_table = {}
 	damage_table.Duration = 10
 	if caster:GetName() == "npc_dota_hero_riki" then
 		caster:FindAbilityByName("hawk6"):ApplyDataDrivenModifier(caster, caster, "modifier_invisible", damage_table)
 	elseif caster:GetName() == "npc_dota_hero_bounty_hunter" then
		caster:FindAbilityByName("combat6"):ApplyDataDrivenModifier(caster, caster, "modifier_invisible", damage_table)
	else
		caster:FindAbilityByName("Shadow_Walk"):ApplyDataDrivenModifier(caster, caster, "modifier_invisible", damage_table)
	end
	StartAnimation(caster, {activity=ACT_DOTA_ATTACK, duration=0.3, rate=3.0})
end

function StealthEnd(event)
	local hero = event.caster

	if event.checkinvisbreak then
		local a = event.event_ability
		if a then
			if a:GetName() == "Shadow_Blend" or a:GetName() == "Ambush" or a:GetName() == "Fatal_Throw" or a:GetName() == "hawk4" or a:GetName() == "hawk3" or a:GetName() == "hawk7" or a:GetName() == "combat5" or a:GetName() == "combat4" or a:GetName() == "combat2" then
				hero:RemoveModifierByName("modifier_invisible")
				hero:RemoveModifierByName("modifier_stealthrogue")
			end
		end
		return
	end

	hero:RemoveModifierByName("modifier_invisible")
	hero:RemoveModifierByName("modifier_stealthrogue")

	local abil1 = hero:GetAbilityByIndex(0)
	local abil2 = hero:GetAbilityByIndex(1)

	hero:RemoveAbility(abil1:GetAbilityName())
	hero:RemoveAbility(abil2:GetAbilityName())

	if hero:GetName() == "npc_dota_hero_riki" then
		hero:AddAbility("hawk1")
		hero:FindAbilityByName("hawk1"):SetLevel(hero.StealthSpell1)
		hero:AddAbility("hawk2")
		hero:FindAbilityByName("hawk2"):SetLevel(hero.StealthSpell2)
	elseif hero:GetName() == "npc_dota_hero_bounty_hunter" then
		hero:AddAbility("combat1")
		hero:FindAbilityByName("combat1"):SetLevel(hero.StealthSpell1)
		hero:AddAbility("combat3")
		hero:FindAbilityByName("combat3"):SetLevel(hero.StealthSpell2)
	else
		hero:AddAbility("Dagger_Strike")
		hero:FindAbilityByName("Dagger_Strike"):SetLevel(hero.StealthSpell1)
		hero:AddAbility("Numbing_Cut")
		hero:FindAbilityByName("Numbing_Cut"):SetLevel(hero.StealthSpell2)
	end
end



-- Mage ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function Waterelemental (event)
	local caster = event.caster
	local owner = caster:GetOwner()
	local teamid = caster:GetTeamNumber()
	local origin = caster:GetAbsOrigin() + RandomVector(100)

	if caster.Pet ~= nil and not caster.Pet:IsNull() then
		caster.Pet:Destroy()
	end

	caster.Pet = CreateUnitByName("npc_dota_creature_waterelemental", origin, true, owner, nil, teamid)
	--caster.Pet:SetPlayerID(owner:GetPlayerID())
 	caster.Pet:SetControllableByPlayer(caster:GetPlayerID(), true)
 	caster.Pet:CreatureLevelUp(event.ability:GetLevel()-1)
 	caster.Pet.owner = caster

 	local ability = caster.Pet:GetAbilityByIndex(0)
	if ability and event.ability then
		ability:SetLevel(event.ability:GetLevel())
	end

 	local table = {}
 	table.Duration = 0.5
 	event.ability:ApplyDataDrivenModifier(event.caster, caster.Pet, "modifier_phased", table)
 	event.ability:ApplyDataDrivenModifier(event.caster, caster.Pet, "modifier_wefx", nil)

 	if caster.gladiator and caster.gladiator >= 2200 then	
		local particle = ParticleManager:CreateParticle("particles/econ/courier/courier_wyvern_hatchling/courier_wyvern_hatchling_ice.vpcf", PATTACH_POINT_FOLLOW, caster.Pet)
		--ParticleManager:SetParticleControlEnt(particle, 1, caster.Pet, PATTACH_POINT_FOLLOW, "attach_attack1", caster.Pet:GetAbsOrigin(), true)
		particle = ParticleManager:CreateParticle("particles/econ/courier/courier_wyvern_hatchling/courier_wyvern_hatchling_ice.vpcf", PATTACH_POINT_FOLLOW, caster.Pet)
		--ParticleManager:SetParticleControlEnt(particle, 1, caster.Pet, PATTACH_POINT_FOLLOW, "attach_attack2", caster.Pet:GetAbsOrigin(), true)
	end

	if event.ringoffrost and event.ringoffrost == 1 then
		caster.Pet:AddAbility("ringoffrost"):SetLevel(1)
	end

	ability = caster.Pet:GetAbilityByIndex(2)
	if ability and event.ability then
		ability:SetLevel(event.ability:GetLevel())
	end
    event.ability:ApplyDataDrivenModifier(caster, caster.Pet, "modifier_pet_system", nil)
end

-- Shaman --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function ElementalConversion (event)
	local caster = event.caster
	local target = event.target
	local ability = event.ability
	local range = event.radius

	local enemies = FindUnitsInRadius( caster:GetTeamNumber(), event.target_points[1], caster, range, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	--print(#enemies)
	if #enemies > 0 then
		for _,enemy in pairs(enemies) do
			if enemy ~= nil then
				if ((enemy:GetUnitLabel()=="hero") or (enemy:GetUnitLabel()=="pet")) then
					local table = {}
					table.Duration = event.dur
					ability:ApplyDataDrivenModifier(caster, enemy, "modifier_elemental_lust", table)
				end
			end
		end
	end

	enemies = FindUnitsInRadius( caster:GetTeamNumber(), event.target_points[1], caster, range, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	--print(#enemies)
	if #enemies > 0 then
		for _,enemy in pairs(enemies) do
			if enemy ~= nil then
				if ((enemy:GetUnitLabel()=="hero") or (enemy:GetUnitLabel()=="pet")) then
					local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_dark_seer/dark_seer_wall_of_replica_replicate.vpcf", PATTACH_POINT_FOLLOW, enemy)
					ParticleManager:SetParticleControl(particle, 0, enemy:GetAbsOrigin())
					ParticleManager:SetParticleControl(particle, 1, enemy:GetAbsOrigin())
					event.target = enemy
					PurgeEnemyUnit(event)
				end
			end
		end
	end
end

function LightningStorm (event)
	local caster = event.caster
	local target = event.target
	local ability = event.ability
	local range = 350

	local tab = {}
	tab.Duration = event.stun


	local enemies = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetOrigin(), caster, range, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	--print(#enemies)
	if #enemies > 0 then
		for _,enemy in pairs(enemies) do
			if enemy ~= nil then
				if ((enemy:GetUnitLabel()=="hero") or (enemy:GetUnitLabel()=="pet")) then
					--[[
					vec = enemy:GetAbsOrigin()-caster:GetAbsOrigin()
					vec = vec:Normalized()
					--enemy:ApplyAbsVelocityImpulse(vec)
					local npc = enemy
					Physics:Unit(npc)
					npc:PreventDI(false)
					npc:SetAutoUnstuck(true)
					npc:SetNavCollisionType(PHYSICS_NAV_BOUNCE)
					npc:FollowNavMesh(true)
					npc:SetPhysicsVelocityMax(1000)
					npc:SetPhysicsFriction(0.05)
					npc:Hibernate(false)
					npc:SetGroundBehavior(PHYSICS_GROUND_LOCK)
					npc:SetPhysicsVelocity(500 * vec)
					--enemy:AddVelocity(vec, Vector(0,0,0))
					]]
					event.fixedforce = 300
					event.target = enemy
					KnockBack(event)

					--event.ability:ApplyDataDrivenModifier(caster, npc, "modifier_stunned", tab)

					local myevent = {}
					myevent.caster = caster
					myevent.target = enemy
					myevent.buff = "modifier_stunned"
					myevent.ability = event.ability
					myevent.dur = event.stun
					ApplyBuff(myevent)

					Timers:CreateTimer(3.0, function()
						local table = {}
						table.Duration = 0.02
					   	event.ability:ApplyDataDrivenModifier(caster, enemy, "modifier_phased", table)
					end)
				end
			end
		end
	end

	caster:SetMana(caster:GetMana()+caster:GetMaxMana()*event.manapercent/100)
end

function Holybolt(event)
	local caster = event.caster
	local target = event.target
	local ability = event.ability
	local range = 300

	local tab = {}
	tab.Duration = event.dur


	local enemies = FindUnitsInRadius( caster:GetTeamNumber(), target:GetOrigin(), caster, range, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	--print(#enemies)
	if #enemies > 0 then
		
		for _,enemy in pairs(enemies) do
			if enemy ~= nil then
				if ((enemy:GetUnitLabel()=="hero") or (enemy:GetUnitLabel()=="pet")) and enemy ~= target then
					
					--event.ability:ApplyDataDrivenModifier(enemy, target, "modifier_stunnedshackle", tab)
					--event.ability:ApplyDataDrivenModifier(target, enemy, "modifier_stunnedshackle", tab)
					--event.ability:ApplyDataDrivenModifier(caster, enemy, "modifier_stunned", tab)
					--event.ability:ApplyDataDrivenModifier(caster, target, "modifier_stunned", tab)
					event.buff = "modifier_stunnedshackle"
					event.caster = enemy
					event.target = target
					ApplyBuff(event)
					event.buff = "modifier_stunnedshackle"
					event.caster = target
					event.target = enemy
					ApplyBuff(event)
                    --[[
					event.buff = "modifier_stunned"
					event.caster = caster
					event.target = enemy
					ApplyBuff(event)
					event.buff = "modifier_stunned"
					event.caster = caster
					event.target = target
					ApplyBuff(event)]]
				end
			end
		end
	end
end

function SetWardDamage( event )
	local caster = event.caster
	local target = event.target
	local ability = event.ability
	local attack_damage_min = (caster:GetPrimaryStatValue() + GetSpellpower(event)) * event.dmg / 100
	local attack_damage_max = (caster:GetPrimaryStatValue() + GetSpellpower(event)) * event.dmg / 100

	target:SetBaseDamageMax(attack_damage_max)
	target:SetBaseDamageMin(attack_damage_min)

	if event.fireele then
		caster.fireele = target
	end
	--target:SetOriginalModel("models/props_structures/statue_dragon003.vmdl")
end

function FireEleNova( event )
	local caster = event.caster
	if caster.fireele and not caster.fireele:IsNull() and caster.fireele:IsAlive() then
		event.target_points = {}
		event.target_points[1] = caster.fireele:GetAbsOrigin()
		local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_ember_spirit/ember_spirit_hit_fire.vpcf", PATTACH_POINT_FOLLOW, caster.fireele)
		particle = ParticleManager:CreateParticle("particles/econ/items/earthshaker/egteam_set/hero_earthshaker_egset/earthshaker_echoslam_start_magma_egset.vpcf", PATTACH_POINT_FOLLOW, caster.fireele)
		DamageAOE(event)
	end
end

function SetWardDamageResto( event )
	local target = event.target
	local ability = event.ability
	target:CreatureLevelUp(event.ability:GetLevel()-1)
	target.warddontbreakit = 1
end

function SetWardAnimationResto( event )
	local target = event.target
	StartAnimation(target, {activity=ACT_DOTA_IDLE, duration=10.0, rate=1.0})
end

function WardDeathAnimationResto( event )
	local target = event.target
	StartAnimation(target, {activity=ACT_DOTA_DIE, duration=4.0, rate=1.0})
end

function voodoo_start( keys )
	local target = keys.target
	local model = keys.model

	if target:IsIllusion() then
		target:ForceKill(true)
	else
		if target:GetModelName() == "models/props_gameplay/chicken.vmdl" or target:GetModelName() == "models/props_gameplay/frog.vmdl" then
			--print("skip saving old model, is already saved")
			if model == target:GetModelName() then
				-- no change in model
			else
				target:SetOriginalModel(model)
			end
		else
			target.aftersheepmodel = target:GetModelName()
			target:SetOriginalModel(model)
		end
	end
end

function voodoo_end( keys )
	local target = keys.target

	-- Checking for errors
	if target.aftersheepmodel ~= nil then
		target:SetModel(target.aftersheepmodel)
		target:SetOriginalModel(target.aftersheepmodel)
		target.aftersheepmodel = nil
	end
end

function HideWearables( event )
    print("hide wears")
    --if true then
    --    return
    --end
	local target = event.caster
	if event.target ~= nil then
		target = event.target
	end

	--gladiator gear
	RemoveCosmetics(target)

	local children = target:GetChildren()

    for _,child in ipairs(children) do
      if child:GetClassname() == "dota_item_wearable" then
      	--print("hiding")
      	--print(child:GetModelName())
      	--keep the head model
      	if IsServer() then
	      	--if child:GetModelName() ~= "models/heroes/dazzle/dazzle_mohawk.vmdl" and child:GetModelName() ~= "models/items/dazzle/dotapit_s3_sunshield_back/dotapit_s3_sunshield_back.vmdl" and child:GetModelName() ~= "models/items/dazzle/headdress_of_the_yuwipi/headdress_of_the_yuwipi.vmdl" and child:GetModelName() ~= "models/items/dazzle/back_feathery/back_feathery.vmdl" and child:GetModelName() ~= "models/items/dazzle/shadowflame_back_s1/shadowflame_back_s1.vmdl" then
	        if event.destroywearables then
                child:Destroy()
            else
                child:AddEffects(EF_NODRAW)
            end
	        --end
    	end
      end
    end

    --treant form
    if IsServer() then
        if target.treanthead and not target.treanthead:IsNull() then
            target.treanthead:AddEffects(EF_NODRAW)
        end
        if target.treanthead and not target.treanthead:IsNull() then
            target.treanthead:AddEffects(EF_NODRAW)
        end
        if target.treanthand and not target.treanthand:IsNull() then
            target.treanthand:AddEffects(EF_NODRAW)
        end
        if target.treantfeet and not target.treantfeet:IsNull() then
            target.treantfeet:AddEffects(EF_NODRAW)
        end
    end
end

function ShowWearables( event )
    print("show wears")
    --if true then
    --    return
    --end
	if not IsServer() then
		return
	end
	local target = event.target
	if target == nil then
		target = event.caster
	end
	local children = target:GetChildren()
	if target:HasModifier("modifier_catform") or target:HasModifier("modifier_shapeshifttravel") then
		--print("nope")
	else
		if target ~= nil then
			children = target:GetChildren()
		end

		for _,child in ipairs(children) do
		  if child:GetClassname() == "dota_item_wearable" then
		    child:RemoveEffects(EF_NODRAW)
		  end
		end

		COverthrowGameMode:ShowCosmetics(target)
	end	

    --treant form
    if IsServer() then
        if target.treanthead and not target.treanthead:IsNull() then
            target.treanthead:RemoveEffects(EF_NODRAW)
        end
        if target.treanthead and not target.treanthead:IsNull() then
            target.treanthead:RemoveEffects(EF_NODRAW)
        end
        if target.treanthand and not target.treanthand:IsNull() then
            target.treanthand:RemoveEffects(EF_NODRAW)
        end
        if target.treantfeet and not target.treantfeet:IsNull() then
            target.treantfeet:RemoveEffects(EF_NODRAW)
        end
    end
end

-- Priest Holy ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function SacredShield( event )
	local target = event.target
	local caster = event.caster
	if caster.sacredtarget ~= nil and not caster.sacredtarget:IsNull() then
		caster.sacredtarget:RemoveModifierByName("modifier_sacred_shield")
	end
	target.pwssource = caster
	caster.sacredtarget = target
	--also add bonus factor
    local statbonus = 1.0
    if event.lowbonus and event.lowbonus > 0 and target:GetHealth()/target:GetMaxHealth() < 0.35 then
    	statbonus = statbonus + event.lowbonus/100
    end
    local heavencharge = 1 + caster:GetModifierStackCount("modifier_heaven_charge", caster)*0.5
    caster:RemoveModifierByName("modifier_heaven_charge")
	local max_damage_absorb = heavencharge * statbonus * (caster:GetPrimaryStatValue() + GetSpellpower(event)) * event.intfactor / 100

	local shield_size = 75 -- could be adjusted to model scale
	-- Reset the shield
	target.AphoticShieldRemaining = max_damage_absorb
	--target.AphoticShieldPostHealth = target:GetHealth()
	-- Particle. Need to wait one frame for the older particle to be destroyed
	--[[Timers:CreateTimer(0.03, function() 
		target.ShieldParticle = ParticleManager:CreateParticle("particles/abaddon_aphotic_shield_holy2.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(target.ShieldParticle, 1, Vector(shield_size,0,shield_size))
		ParticleManager:SetParticleControl(target.ShieldParticle, 2, Vector(shield_size,0,shield_size))
		ParticleManager:SetParticleControl(target.ShieldParticle, 4, Vector(shield_size,0,shield_size))
		ParticleManager:SetParticleControl(target.ShieldParticle, 5, Vector(shield_size,0,0))

		-- Proper Particle attachment courtesy of BMD. Only PATTACH_POINT_FOLLOW will give the proper shield position
		ParticleManager:SetParticleControlEnt(target.ShieldParticle, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
	end)]]
end

function SacredShieldAbsorb( event )
	-- Variables
	local damage = event.DamageTaken
	local unit = event.unit
	local ability = event.ability
	local caster = event.caster

	if event.darkboltchance and event.darkboltchance > 0 then
		if math.random(1,100) <= event.darkboltchance then
			event.ability:ApplyDataDrivenModifier(event.caster, event.attacker, "modifier_darkbolt_proc", nil)
		end
	end

	if unit.AphoticShieldRemaining then 
		unit:SetModifierStackCount("modifier_sacred_shield", event.ability, unit.AphoticShieldRemaining)
	end
	if true then
		return
	end
	
	-- Track how much damage was already absorbed by the shield
	if unit.AphoticShieldRemaining == nil then
		unit.AphoticShieldRemaining = 0
	end
	local shield_remaining = unit.AphoticShieldRemaining
	--print("Shield Remaining: "..shield_remaining)
	--print("Damage Taken pre Absorb: "..damage)

	unit.AphoticShieldRemaining = unit.AphoticShieldRemaining-damage
	-- If the damage is bigger than what the shield can absorb, heal a portion
	local currenthealth = unit:GetHealth()

	
	if damage > shield_remaining then
		--print(currenthealth)
		--print(damage)
		--print(shield_remaining)
		if currenthealth <= 0 then
			--let him die
			--print("special lethal treatment, more dmg than shield")
		else
			local newHealth = currenthealth + shield_remaining
			--print("Old Health: "..unit.OldHealth.." - New Health: "..newHealth.." - Absorbed: "..shield_remaining)
			unit:SetHealth(newHealth)
			if caster and caster.healingdone then
				caster.healingdone = caster.healingdone + shield_remaining
			end
		end
	else
		--print(currenthealth)
		--print(damage)
		--print(shield_remaining)
		if currenthealth <= 0 then
			--let him die
			unit:SetHealth(unit.AphoticShieldPostHealth)
			--print("special lethal treatment, less dmg than shield")
		else
			local newHealth = currenthealth + damage	
			unit:SetHealth(newHealth)
			--print("Old Health: "..unit.OldHealth.." - New Health: "..newHealth.." - Absorbed: "..damage)
		end
		unit:SetModifierStackCount("modifier_sacred_shield", event.ability, unit.AphoticShieldRemaining)
		if caster and caster.healingdone then
			caster.healingdone = caster.healingdone + damage
		end
	end

	--update last dmg info
	unit.AphoticShieldPostHealth = unit:GetHealth()
	-- Reduce the shield remaining and remove
	
	if unit.AphoticShieldRemaining <= 0 then
		unit.AphoticShieldRemaining = nil
		unit:RemoveModifierByName("modifier_sacred_shield")
		unit.AphoticShieldPostHealth = nil
		--print("--Shield removed--")
	end

	--if unit.AphoticShieldRemaining then
		--print("Shield Remaining after Absorb: "..unit.AphoticShieldRemaining)
		--print("---------------")
	--end
	
end

-- Destroys the particle when the modifier is destroyed. Also plays the sound
function EndShieldParticle( event )
	local target = event.target
	ParticleManager:DestroyParticle(target.ShieldParticle,false)
end

function SacredShieldStacks( event )
	local target = event.target
	if target:HasModifier("modifier_sacred_shield") then
		target:SetModifierStackCount("modifier_sacred_shield", event.ability, target.AphoticShieldRemaining)
	end
end

function SacredShieldHealth( event )
	local target = event.target

	target.OldHealth = target:GetHealth()
end

function CycloneDiminishing(event)
	local caster = event.caster
	local target = event.target

	local diminishing = caster:GetModifierStackCount("cyclone_diminishing_return", caster)
	event.dur = event.dur * (event.diminish - diminishing) / event.diminish
	CCTarget(event)
end

function ManaBurn (event)
	local caster = event.caster
	local target = event.target
	local amount = event.mana
	local mana = target:GetMana()

	if event.manaburnpercent then
		amount = amount + event.manaburnpercent*caster:GetMaxMana()/100
		if target:HasModifier("modifier_manaburn_debuff") then
   			amount = amount * 1.4
		end
	end
	if target.Rage ~= nil or ( target.Energy ~= nil and target:GetUnitName() ~= "npc_dota_hero_dazzle" ) or (target:GetUnitName() == "npc_dota_hero_dazzle" and target:HasModifier("modifier_catform") ) then
		--print("dont fire manaburn")
	else
		if mana >= amount then
			target:SetMana(target:GetMana()-amount)
		else
			target:SetMana(0)
			amount = mana
		end
		event.damage = amount
		DamageUnit(event)
		--manasteal talent
		if event.manasteal and event.manasteal > 0 then
			event.amount = amount * event.manasteal / 100
			RestoreMana(event)
		end
	end
end

function ShadowCreeper (event)
	local caster = event.caster
	local unit = event.target
	caster.Pet = unit
	unit.sourcepriest = caster
	unit:SetHullRadius(35)
	unit:CreatureLevelUp(event.ability:GetLevel()-1)

	Timers:CreateTimer(0.1, function()
		local order = 
		{
			UnitIndex = unit:entindex(),
			OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
			TargetIndex = caster.creepertarget:entindex()
		}

		ExecuteOrderFromTable(order)
	end)
end

function WarlockAgonyCounter (event)
	local caster = event.caster
	caster.AgonyCounter = 0.8
end

function WarlockSacrifice (event)
	local caster = event.caster
	local target = caster.owner
	local owner = target

	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_clinkz/clinkz_death_pact.vpcf", PATTACH_POINT_FOLLOW, owner)
	ParticleManager:SetParticleControl(particle, 1, owner:GetAbsOrigin())

	local health = caster:GetHealth()*event.amount / 100.0
	event.caster = target
	event.target = target
	event.spelldamagefactor = 0.0
	event.attributefactor = 0.0
	event.heal = health
	event.amount = health
	RestoreMana(event)
	HealUnit(event)

	caster:Kill(event.ability, caster)
end

function ShadowCreeperMana (event)
	local caster = event.attacker
	local target = event.target
	local priest = caster.sourcepriest
	if priest ~= nil then
		priest:SetMana(priest:GetMana()+priest:GetMaxMana()*event.amount/100)	
		local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_pugna/pugna_life_drain_beam_2b.vpcf", PATTACH_POINT_FOLLOW, priest)
        ParticleManager:SetParticleControlEnt(particle, 0, priest, PATTACH_POINT_FOLLOW, "attach_hitloc", priest:GetAbsOrigin(), true)
		--ParticleManager:SetParticleControl(particle, 0, priest:GetAbsOrigin()+Vector(0,0,90))
		ParticleManager:SetParticleControl(particle, 1, caster:GetAbsOrigin()+Vector(0,0,90))
		ParticleManager:SetParticleControl(particle, 10, Vector(1,0,0))
		ParticleManager:SetParticleControl(particle, 11, Vector(1,0,0))
		Timers:CreateTimer(0.75, function()
			ParticleManager:DestroyParticle(particle,false)
		end)
	end
	local ability = priest:FindAbilityByName("Shadow_Creeper")
	local myevent = {}
	myevent.caster = priest
	myevent.target = target
	myevent.buff = "modifier_shadowcreepercriple"
	myevent.ability = ability
	myevent.dur = event.dur
	myevent.addstacks = 1
    myevent.max = 12
	ApplyBuffStack(myevent)
end

function ShadowCrippleStacks(event)
	local caster = event.caster
	local target = event.target
	local priest = caster
	if event.darkstacks and event.darkstacks > 0 then
		local ability = priest:FindAbilityByName("Shadow_Creeper")

		local myevent = {}
		myevent.caster = priest
		myevent.target = target
		myevent.buff = "modifier_shadowcreepercriple"
		myevent.ability = ability
		myevent.dur = 4
        myevent.max = 12
        if event.addstacks then
            myevent.addstacks = event.addstacks
        end
		ApplyBuffStack(myevent)
	end
end

function LightChargeStack(event)
	if event.lightstacks and event.lightstacks > 0 then
		local ability = event.caster:GetAbilityByIndex(0)
		event.ability = ability
		ApplyBuffStack(event)
	end
end

function ShadowCreeperEnd (event)
	caster = event.target
	caster:Destroy()
end

-- Hunter Frost

function HideDeathAnimation (event)
	Timers:CreateTimer(event.delay-1, function()
		event.time = 0
	   	SinkUnitInGround(event)
	end)
end

function SetGroundingTotem (event)
	local caster = event.caster
	local target = event.target
	if event.shaman then
		caster.groundingtotem = target
	end
	if event.victim then
		target.groundingtotemsource = caster.groundingtotem
	end
end

function SinkUnitInGround (event)
	local target = event.target
	Timers:CreateTimer(0.1, function()
		if not target:IsNull() then
			event.time = event.time + 1
		   	target:SetAbsOrigin(target:GetAbsOrigin()+Vector(0,0,-1.5))
		   	if event.time < 20 then
		    	SinkUnitInGround(event)
		    end
		end
	end)
end

function SinkUnitInGroundNow (event)
	local target = event.target
	target:SetAbsOrigin(target:GetAbsOrigin()+Vector(0,0,-200))
	target:AddEffects(EF_NODRAW)
end

function GlacierTrapTrigger( event )
	if event.caster.trap.trapused == nil then


		if event.caster.trap ~= nil and not event.caster.trap:IsNull() then
			event.caster.trap.trapused = 1
			--event.ability:ApplyDataDrivenModifier(event.caster, event.target, "glacier_trap", nil)

			local myevent = {}
			myevent.caster = event.caster
			myevent.target = event.target
			myevent.buff = "glacier_trap"
			myevent.ability = event.ability
			myevent.dur = event.dur

            if event.dealdmg then
                local myevent2 = {}
                myevent2.caster = event.caster
                myevent2.target = event.target
                myevent2.ability = event.ability
                myevent2.damage = 0.0
                myevent2.attributefactor = event.dealdmg
                DamageUnit(myevent2)
            end

			ApplyBuff(myevent)
			--myevent.dur = event.critdur
			--myevent.buff = "glacier_trap_guaranteed_crit"
			--ApplyBuff(myevent)

			EmitSoundOn( "Hero_DrowRanger.Silence", event.caster)
			Timers:CreateTimer(0.5, function()
			if not event.caster.trap:IsNull() then
			   	event.caster.trap:Destroy()
			end
		end)
		end
	end
end

function TripleFocussedShot( event )
    local caster = event.caster
    if caster:HasModifier("glacier_trap_focus_tripleshot") then
        caster:RemoveModifierByName("glacier_trap_focus_tripleshot")
        event.ability:ApplyDataDrivenModifier(caster, event.target, "modifier_triple_shot", nil)
    end
end

function SnakeTrapTrigger( event )
	if event.caster.trap ~= nil and not event.caster.trap:IsNull() and event.caster.trap.trapused == nil then
		event.caster.trap.trapused = 1
		--event.caster.owner:GetAbilityByIndex(3):ApplyDataDrivenModifier(event.caster.owner, event.target, "snake_trap", nil)

		local myevent = {}
		myevent.caster = event.caster
		myevent.target = event.target
		myevent.buff = "snake_trap"
		myevent.ability = event.caster:GetAbilityByIndex(3)
		myevent.dur = 0.5
		ApplyBuff(myevent)

		--fire aoe trap
		if event.aoe and event.aoe > 0 then
			local particle = ParticleManager:CreateParticle("particles/econ/items/clockwerk/clockwerk_paraflare/clockwerk_para_rocket_flare_explosion.vpcf", PATTACH_POINT_FOLLOW, event.target)
			ParticleManager:SetParticleControl(particle, 3, event.target:GetAbsOrigin())
			particle = ParticleManager:CreateParticle("particles/econ/items/gyrocopter/hero_gyrocopter_gyrotechnics/gyro_calldown_explosion_flash_c.vpcf", PATTACH_POINT_FOLLOW, event.target)
			ParticleManager:SetParticleControl(particle, 3, event.target:GetAbsOrigin())
			DamageAOE(event)
			EmitSoundOn("Hero_LegionCommander.Courage", event.target)
		else
			EmitSoundOn("Hero_Sniper.AssassinateDamage", event.target)
		end

		if event.dur and event.dur > 0 then
			ApplyBuffAOE(event)
		end

		Timers:CreateTimer(0.5, function()
			if not event.caster.trap:IsNull() then
			   	event.caster.trap:Destroy()
			end
		end)
	end
end

function BearTrapTrigger( event )
	local target = event.target
	if event.caster.trap ~= nil and not event.caster.trap:IsNull() and event.caster.trap.trapused == nil then
		target.BearTrapPos = target:GetAbsOrigin()
		event.caster.trap.trapused = 1
		local myevent = {}
		myevent.caster = event.caster
		myevent.target = event.target
		myevent.buff = "modifier_bear_trap"
		myevent.dur = event.dur
		myevent.ability = event.ability
		ApplyBuff(myevent)
		EmitSoundOn( "Hero_Beastmaster.Wild_Axes_Damage", target)
		Timers:CreateTimer(0.25, function()
			if not event.caster.trap:IsNull() then
			   	event.caster.trap:Destroy()
			end
		end)
	end
end

function GhoulMasterEnrage( event )
    local caster = event.caster
    local target = caster.owner
    if target then
        event.ability:ApplyDataDrivenModifier(caster, target, "modifier_bearcharge", {Duration = event.buffduration})
        event.ability:ApplyDataDrivenModifier(caster, target, "modifier_phased", {Duration = event.buffduration})
    end
end

function GetPrimaryAndSpellpower( target )
    local tab = {caster = target}
    return target:GetPrimaryStatValue() + GetSpellpower(tab)
end

function PetSystem( event )
    local caster = event.target
    local target = caster.owner
    if target and caster then
        if event.aa then
            local dmg = event.dmg*target:GetAverageTrueAttackDamage(target)/100
            if target:HasModifier("modifier_item_beastmaster") then
                dmg = dmg + 3
            end
            if target:HasModifier("modifier_item_beastmaster2") then
                dmg = dmg + 3000
            end
            caster:SetBaseDamageMin(dmg)
            caster:SetBaseDamageMax(dmg)
        end
        if event.str then
            caster:SetBaseDamageMin(event.dmg*target:GetStrength()/100)
            caster:SetBaseDamageMax(event.dmg*target:GetStrength()/100)
        end
        if event.int then
            caster:SetBaseDamageMin(event.dmg*target:GetIntellect()/100)
            caster:SetBaseDamageMax(event.dmg*target:GetIntellect()/100)
        end
        if event.intsp then
            local dmg = GetPrimaryAndSpellpower(target)
            caster:SetBaseDamageMin(event.dmg*dmg/100)
            caster:SetBaseDamageMax(event.dmg*dmg/100)
        end
        if (caster:GetAbsOrigin() - target:GetAbsOrigin()):Length() > 2250 then
            caster:SetAbsOrigin(target:GetAbsOrigin())
            local tab = {}
            tab.Duration = 0.5
            event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_phased", tab)
            local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_chen/chen_teleport.vpcf", PATTACH_POINT_FOLLOW, caster)
        end
    end
end

function BearTrapMoveDamage( event )
	local target = event.target
	local caster = event.caster
	local distance = (target:GetAbsOrigin()-target.BearTrapPos):Length()
	--print(distance)
	target.BearTrapPos = target:GetAbsOrigin()
	if distance > 10.0 then
		--event.damage = caster:GetPrimaryStatValue()*caster:GetAbilityByIndex(2):GetLevelSpecialValueFor("dmgfromstat", (caster:GetAbilityByIndex(2):GetLevel() - 1))
		--print(caster:GetAbilityByIndex(2):GetLevelSpecialValueFor("dmgfromstat", (caster:GetAbilityByIndex(2):GetLevel() - 1)))
		--print(event.damage)
		--event.caster = caster.TrapOwner
		EmitSoundOn( "Hero_Beastmaster.Wild_Axes_Damage", event.caster)
		DamageUnit(event)
		target.beartraplasttick = 1
	else
		target.beartraplasttick = 0
	end
end

function FierceShotProc( event )
    local target = event.target
    local caster = event.caster
    local distance = (target:GetAbsOrigin()-caster:GetAbsOrigin()):Length()
    if distance > 350 then
        event.ability:ApplyDataDrivenModifier(caster, target, "modifier_multi_arrows_fierce", {Duration = 0.25})
    end
end

function BearTrapEnd( event )
	local target = event.target
	local caster = event.caster
	if target.beartraplasttick and target.beartraplasttick == 1 then
		local myevent = {}
		myevent.caster = event.caster
		myevent.target = event.target
		myevent.buff = "modifier_bear_trap"
		myevent.dur = event.dur
		myevent.ability = event.ability
		ApplyBuff(myevent)
	end
end

function SetTrapOwner( event )
	event.target.TrapOwner = event.caster
	event.target.owner = event.caster
	event.caster.trap = event.target
end

function SetSummonOwner( event )
	event.target.owner = event.caster
end

function SetTrapHunter( event )
	event.caster.trap = event.target
end

function SetLookDirection( event )
    event.target:SetForwardVector(Vector(0,1,0))
end

function TurnUnit( event )
    local target = event.target
    local angle = event.angle
    local radangle = math.rad(angle)
    local cos = math.cos(radangle)
    local sin = math.sin(radangle)
    local forward = target:GetForwardVector()
    local vec = Vector(forward[1]*cos - forward[2]*sin, forward[1]*sin + forward[2]*cos, 0):Normalized()
    target:SetForwardVector(vec)
end

function StopKnockBack ( event )
	local npc = event.target
	if npc ~= nil and npc:IsAlive() and not npc:IsNull() then
		Physics:Unit(npc)
		npc:SetPhysicsVelocity(Vector(0,0,0))
		npc:SetNavCollisionType(PHYSICS_NAV_BOUNCE)
	end
end

function KnockBackNear( event )
    local caster = event.caster
    local target = event.target
    if (target:GetAbsOrigin()-caster:GetAbsOrigin()):Length() < event.neartarget then
        KnockBack(event)
    end
end

function KnockBack ( event )
	local npc = event.target
	local dir = 1
	local jumpdur = 0.5
	local vec
    if event.minrange and (event.caster:GetAbsOrigin() - event.target:GetAbsOrigin()):Length() < event.minrange then
        return
    end
	if event.moltenlava then
		vec = -event.target_points[1]+npc:GetAbsOrigin()
	else
		if event.notarget then
			vec = event.caster:GetForwardVector():Normalized()*event.notarget
		else
			if npc == nil then
				vec = event.target_points[1]-event.caster:GetAbsOrigin()
			elseif event.random ~= nil then
				local vec1 = RandomVector(1.0)
				vec = Vector(vec1[1],vec1[2],0)
				if not event.dontface then
					npc:SetForwardVector(vec)
				end
            elseif event.forward then
                local vec1 = npc:GetForwardVector()
                vec = Vector(vec1[1],vec1[2],0)
                if not event.dontface then
                    npc:SetForwardVector(vec)
                end
			else
				if event.aoepull then
					vec = npc:GetAbsOrigin()-event.target_points[1]
				else
					vec = npc:GetAbsOrigin()-event.caster:GetAbsOrigin()
				end
			end
		end
	end

	vec[3] = 0

	-- if its feral charge
	if event.charge ~= nil then
		npc = event.caster
	end

	-- if its the ranger
	if event.chargeranger ~= nil then
		dir = -1
		npc = event.caster
	end
	-- if its feral crush (prot warrior)
	if event.crush then
		npc = event.caster
	end

    local overtimefactor = 1.0
    if event.increaseovertime then
        if npc.forceincreaseovertime then
            npc.forceincreaseovertime = npc.forceincreaseovertime + event.increaseovertime
        else
            npc.forceincreaseovertime = event.increaseovertime
        end
        overtimefactor = overtimefactor + npc.forceincreaseovertime
    end

	Physics:Unit(npc)
	npc:SetPhysicsFriction(0.0)

	if event.fixedforce then
		vec = vec:Normalized()*event.fixedforce*0.85
		npc:SetPhysicsFriction(0.08)
	else
		vec = vec - vec:Normalized()*150
	end

	-- if its deathgrip
	if event.inversed ~= nil then
		dir = -1
	end

	if npc:GetUnitLabel() == "tower" or npc.forceimune then
 		return
	end

	
	npc:PreventDI(false)
	npc:SetAutoUnstuck(true)
	npc:SetNavCollisionType(PHYSICS_NAV_BOUNCE)
	npc:FollowNavMesh(true)
	npc:SetPhysicsVelocityMax(2500)
	if event.friction then
		npc:SetPhysicsFriction(event.friction)
        --print("friction" .. event.friction)
	end
	npc:Hibernate(false)
	npc:SetGroundBehavior(PHYSICS_GROUND_LOCK)
	vec = vec * 2.0 * dir * overtimefactor
	if event.upintheair and event.upintheair > 0 then
		npc:SetGroundBehavior(PHYSICS_GROUND_NOTHING)
		npc:SetNavCollisionType(PHYSICS_NAV_NOTHING)
		vec[3] = 300*event.upintheair
		Timers:CreateTimer(jumpdur/2, function()
			npc:AddPhysicsVelocity(Vector(0,0,-300*event.upintheair*2))
		end)
	end

	if npc.isunderforce then
		npc.isunderforce = npc.isunderforce + 1
	else
		npc.isunderforce = 1
	end

	npc:SetPhysicsVelocity(vec)


	Timers:CreateTimer(jumpdur, function()
		if npc.isunderforce <= 1 then
            if not event.forever then
                npc:SetPhysicsVelocity(Vector(0,0,0))
                npc:SetNavCollisionType(PHYSICS_NAV_BOUNCE)
                npc:Hibernate(true)
            end
		end
		npc.isunderforce = npc.isunderforce - 1
	end)

	Timers:CreateTimer(2.0, function()
		local table = {}
		table.Duration = 0.02
        if event.ability and npc and not npc:IsNull() and not event.ability:IsNull() then
	   	   event.ability:ApplyDataDrivenModifier(npc, npc, "modifier_phased", table)
        end
	end)
end

function ForceOvertimeReset(event)
    event.caster.forceincreaseovertime = nil
end

function ArenaTeleporter( event )
	local caster = event.caster
	local npc = event.target
	local amount = event.amount
	local dir = 1
	local power = 1
	local vec = Vector(950,-480,500)
	if caster.teleporter == 2 then
		vec = Vector(-950,480,500)
	end

	local label = npc:GetUnitLabel()
	if label ~= "hero" and label ~= "pet" then
		return
	end

	Physics:Unit(npc)
	npc:PreventDI(false)
	npc:SetAutoUnstuck(true)
	npc:SetNavCollisionType(PHYSICS_NAV_BOUNCE)
	npc:FollowNavMesh(false)
	npc:SetPhysicsVelocityMax(2500)
	
	npc:SetPhysicsFriction(0.05)
	
	npc:Hibernate(false)
	npc:SetGroundBehavior(PHYSICS_GROUND_NOTHING)
	npc:SetPhysicsVelocity(vec)

	--root
	local table1 = {}
	table1.Duration = 1.0
	event.ability:ApplyDataDrivenModifier(npc, npc, "modifier_rootedteleporter", table1)

	Timers:CreateTimer(0.5, function()
		npc:AddPhysicsVelocity(Vector(0,0,-1050))
	end)

	Timers:CreateTimer(1.0, function()
		StopKnockBack(event)
		local table = {}
		table.Duration = 0.02
	   	event.ability:ApplyDataDrivenModifier(npc, npc, "modifier_phased", table)
	end)
end

-- DK

function InfestedWound( event )
	local target = event.target
	if target ~= nil and target:GetHealth() < target:GetMaxHealth()/2 then
		event.attributefactor = event.attributefactor * 1.3
	end
	DamageUnit(event)
end

function DeafeningCoil( event )
	local caster = event.caster
	local target = event.target
	local vec = caster:GetAbsOrigin()-target:GetAbsOrigin() 
	local power = (vec:Length()-200)/400.0
	if power < 0.0 then
		power = 0.0
	end
	
	if power > 1.0 then
		power = 1.0
	end

	local myevent = {}
	myevent.caster = event.caster
	myevent.target = target
	myevent.buff = "modifier_silence"
	myevent.ability = event.ability
	myevent.dur = event.duration*power
    if myevent.dur < 0.25 then
        myevent.dur = 0.25
    end
	ApplyBuff(myevent)

	if power < 1.0 then
		local myevent = {}
		myevent.caster = event.caster
		myevent.target = target
		myevent.buff = "modifier_unholyheal"
		myevent.ability = event.ability
		myevent.dur = event.duration*(1-power)
		ApplyBuff(myevent)
	end
end

function MulticastItem( event )
    local caster = event.caster
    local item = caster:HasModifier("modifier_item_frostfire")
    if not caster:IsRealHero() and caster.owner then
        item = caster.owner:HasModifier("modifier_item_frostfire")
    end
    print(item)
    local target = event.target
    if item then
        event.ability:ApplyDataDrivenModifier(caster, target, "modifier_multicast_item", nil)
    end
end

function DeathForLife( event )
	local caster = event.caster
	local target = event.target
	if caster ~= nil then
		event.attributefactor = 0.0
		event.spelldamagefactor = 0.0
		event.heal = caster:GetMaxHealth()*0.04

		local abil = caster:GetAbilityByIndex(3)
		--if abil:GetLevel() >= 2 then
		--	local particle = ParticleManager:CreateParticle("particles/items3_fx/octarine_core_lifesteal.vpcf", PATTACH_POINT_FOLLOW, caster)
		--	event.target = caster
			--HealUnit(event)
		--end
        --abil = caster:GetAbilityByIndex(1)
        --if abil:GetLevel() >= 2 then
            local myevent = {}
            myevent.caster = caster
            myevent.target = target
            myevent.buff = "modifier_slow75"
            myevent.ability = abil
            myevent.dur = 5
            ApplyBuff(myevent)
        --end
	end
end

-- Warlock ------------------------------------------------------------------

function RemoveTamerOfLegendsBonus(event)
    local caster = event.caster
    if caster.Pet and not caster.Pet:IsNull() and caster.Pet.tamer_of_legends_wolf and not caster:HasModifier("modifier_item_beastmaster2") then
        caster.Pet:Destroy()
        caster.Pet = nil
    end
end

function SummonPet (event)
	local caster = event.caster
	local owner = caster:GetOwner()
	local teamid = caster:GetTeamNumber()
	local origin = caster:GetAbsOrigin() + RandomVector(100)

	if caster.Pet ~= nil and not caster.Pet:IsNull() then
		caster.Pet:Destroy()
	end
    if caster.PermanentPet ~= nil and not caster.PermanentPet:IsNull() then
        caster.PermanentPet:Destroy()
    end

	if event.pet == "bear" then
		if caster:HasModifier("modifier_item_beastmaster") or caster:HasModifier("modifier_item_beastmaster2") then
			caster.Pet = CreateUnitByName("npc_dota_creature_wolf", origin, true, owner, nil, teamid)
			EmitSoundOn("hero_Lycan.SummonWolves", caster)
            caster.Pet.tamer_of_legends_wolf = true
		else
			caster.Pet = CreateUnitByName("npc_dota_creature_bear", origin, true, owner, nil, teamid)
			EmitSoundOn("Lycan_Wolf.PreAttack", caster)
		end
        
        
		caster.Pet:GetAbilityByIndex(0):SetLevel(event.ability:GetLevel())
		caster.Pet:GetAbilityByIndex(1):SetLevel(event.ability:GetLevel())
		caster.Pet:GetAbilityByIndex(4):SetLevel(event.ability:GetLevel())
        caster.Pet:GetAbilityByIndex(0):ToggleAutoCast()

        local dmg = event.scale*caster:GetAverageTrueAttackDamage(caster)/100
        if caster:HasModifier("modifier_item_beastmaster2") then
            dmg = dmg + 3000
            caster.Pet:SetModelScale(1.35)
        end
        caster.Pet:SetBaseDamageMin(dmg)
        caster.Pet:SetBaseDamageMax(dmg)
        event.ability:ApplyDataDrivenModifier(caster, caster.Pet, "modifier_pet_system", nil)
	end
	if event.pet == "ghoul" then
		caster.Pet = CreateUnitByName("npc_dota_creature_ghoul", origin, true, owner, nil, teamid)
		if event.crit and event.crit > 0 then
			caster.Pet:AddAbility("pve_crit_high"):SetLevel(1)
		end
        caster.Pet:SetBaseDamageMin(event.damageset*caster:GetStrength()/100)
        caster.Pet:SetBaseDamageMax(event.damageset*caster:GetStrength()/100)
        if event.frenzymaster then
            caster.Pet:GetAbilityByIndex(1):SetLevel(event.frenzymaster)
        end
        event.ability:ApplyDataDrivenModifier(caster, caster.Pet, "modifier_pet_system", nil)
	end
	if event.pet == "fel" then
		caster.Pet = CreateUnitByName("npc_dota_creature_felhunter", origin, true, owner, nil, teamid)
		--event.ability:ApplyDataDrivenModifier(caster, caster.Pet, "modifier_felhunterfx", nil)
		caster.Pet:GetAbilityByIndex(0):StartCooldown(6.0)
		caster.Pet:GetAbilityByIndex(1):StartCooldown(6.0)
		event.ability:ApplyDataDrivenModifier(caster, caster.Pet, "modifier_felhunterfx", nil)
		event.ability:ApplyDataDrivenModifier(caster, caster.Pet, "modifier_aura_voidhp", nil)
		if caster.gladiatorwins and caster.gladiatorwins >= 2200 then
			
			local particle = ParticleManager:CreateParticle("particles/econ/items/enigma/enigma_world_chasm/enigma_world_chasm_ambient.vpcf", PATTACH_POINT_FOLLOW, caster.Pet)
			ParticleManager:SetParticleControlEnt(particle, 0, caster.Pet, PATTACH_POINT_FOLLOW, "attach_attack1", caster.Pet:GetAbsOrigin(), true)
			ParticleManager:SetParticleControlEnt(particle, 1, caster.Pet, PATTACH_POINT_FOLLOW, "attach_attack2", caster.Pet:GetAbsOrigin(), true)
		end
		if event.freecast and event.freecast == 1 then
			caster.Pet:AddAbility("Felhunter_Freecast"):SetLevel(1)
		end
		event.ability:ApplyDataDrivenModifier(caster, caster.Pet, "modifier_pet_system", nil)
	end
	--caster.Pet:SetPlayerID(owner:GetPlayerID())
 	caster.Pet:SetControllableByPlayer(caster:GetPlayerID(), true)
 	caster.Pet:CreatureLevelUp(event.ability:GetLevel()-1)

 	caster.Pet.owner = caster
    caster.PermanentPet = caster.Pet

 	local table = {}
 	table.Duration = 0.5
 	event.ability:ApplyDataDrivenModifier(event.caster, caster.Pet, "modifier_phased", table)

 	--instant sacrafice
 	if event.pet == "fel" and event.dur and event.dur > 0 then
		event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_warlockrage", nil)
		local tab = {}
		tab.caster = caster.Pet
		tab.amount = 60.0
		WarlockSacrifice(tab)
	end
end

function BuffPet (event)
	caster = event.caster
	if caster.Pet ~= nil then
		local table = {}
		table.Duration = event.dur
 		event.ability:ApplyDataDrivenModifier(event.caster, caster.Pet, "modifier_companion", table)
 	end
end

function Beastrage (event)
	caster = event.caster
	if caster.Pet ~= nil and (not caster.Pet:IsNull()) and caster.Pet:IsAlive() then
 		event.ability:ApplyDataDrivenModifier(event.caster, caster.Pet, "modifier_beastrage", nil)
 		event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_beastrage", nil)
 		caster:SetRenderColor(255, 0, 0)
 		caster.Pet:SetRenderColor(255, 0, 0)
 	end
end

function BeastrageEnd(event)
	caster = event.caster
	caster:SetRenderColor(255, 255, 255)
	if caster.Pet ~= nil and (not caster.Pet:IsNull()) and caster.Pet:IsAlive() then
 		caster.Pet:SetRenderColor(255, 255, 255)
 	end
end

function Beastheal (event)
	local caster = event.caster
	if caster.Pet ~= nil then
 		event.ability:ApplyDataDrivenModifier(event.caster, caster.Pet, "modifier_beastheal", nil)
 	end
end

function BeasthealProc (event)
	local caster = event.attacker
	if caster ~= nil then
		local target = caster.owner
		if target ~= nil then
			event.heal = caster:GetMaxHealth()*event.amount/100
			event.attributefactor = 0.0
			event.spelldamagefactor = 0.0
			event.caster = target
			event.target = caster
			HealUnit(event)
			event.heal = target:GetMaxHealth()*event.amount/100
			event.target = target
			HealUnit(event)
			local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_lone_druid/lone_druid_bear_blink_start.vpcf", PATTACH_POINT_FOLLOW, target)
			ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())
			ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin())
			particle = ParticleManager:CreateParticle("particles/units/heroes/hero_lone_druid/lone_druid_bear_blink_start.vpcf", PATTACH_POINT_FOLLOW, caster)
			ParticleManager:SetParticleControl(particle, 0, caster:GetAbsOrigin())
			ParticleManager:SetParticleControl(particle, 1, caster:GetAbsOrigin())
			if event.focus and event.focus > 0 then
                local myevent = {}
                myevent.caster = target
                myevent.energy = event.focus
                AddEnergy(myevent)
			end
		end
 	end
end

function PetFocusProc (event)
    local caster = event.attacker
    if caster ~= nil then
        local target = caster.owner
        if target ~= nil then
            local myevent = {}
            myevent.caster = target
            myevent.energy = event.focus
            AddEnergy(myevent)
        end
    end
end

function BeasthealProcPassive(event)
	local caster = event.caster
	local pet = caster.Pet
	local amount = event.amount
	if caster then
		event.heal = caster:GetMaxHealth()*amount/100
		event.attributefactor = 0.0
		event.spelldamagefactor = 0.0
		event.caster = caster
		event.target = caster
		HealUnit(event)
		if pet and not pet:IsNull() then
			event.heal = pet:GetMaxHealth()*amount/100
			event.attributefactor = 0.0
			event.spelldamagefactor = 0.0
			event.caster = caster
			event.target = pet
			HealUnit(event)
	 	end
 	end
end

-- Druid

function Lifebloom(event)
	local caster = event.caster
	local target = event.target
	local ability = event.ability
	local stackcount = 1

	if target:HasModifier("modifier_lifebloom") or target:HasModifier("modifier_lifebloomfull") then
		if target:HasModifier("modifier_lifebloom") then
			stackcount = target:GetModifierStackCount("modifier_lifebloom", caster)+1
		else
			stackcount = target:GetModifierStackCount("modifier_lifebloomfull", caster)+1
		end
 		if stackcount > 3 then
 			stackcount = 3
 		end
 		--print(stackcount)
 		local table = {}
 		table.Duration = 7
 		target:RemoveModifierByName("modifier_lifebloom")
 		target:RemoveModifierByName("modifier_lifebloomfull")
 		if stackcount == 3 then
 			--ability:ApplyDataDrivenModifier(caster, target, "modifier_lifebloomfull", table)

 			local myevent = {}
			myevent.caster = caster
			myevent.target = target
			myevent.buff = "modifier_lifebloomfull"
			myevent.ability = ability
			myevent.dur = 7
			ApplyBuff(myevent)

 			target:SetModifierStackCount("modifier_lifebloomfull", ability, stackcount)
 		else
 			--ability:ApplyDataDrivenModifier(caster, target, "modifier_lifebloom", table)

 			local myevent = {}
			myevent.caster = caster
			myevent.target = target
			myevent.buff = "modifier_lifebloom"
			myevent.ability = ability
			myevent.dur = 7
			ApplyBuff(myevent)

 			target:SetModifierStackCount("modifier_lifebloom", ability, stackcount)
 		end
 		
 	else
 		--table = {}
 		--table.Duration = 7
 		target:RemoveModifierByName("modifier_lifebloom")
 		--ability:ApplyDataDrivenModifier(caster, target,"modifier_lifebloom", table)

 		local myevent = {}
		myevent.caster = caster
		myevent.target = target
		myevent.buff = "modifier_lifebloom"
		myevent.ability = ability
		myevent.dur = 7
		ApplyBuff(myevent)

 		target:SetModifierStackCount("modifier_lifebloom", ability, stackcount)
 	end
end

function shapeshift_start( keys )
	if COverthrowGameMode.EnableShapeshift == 1 then
		local target = keys.target
		local model = keys.model
		local scale = 1.32
		--new form
		--if target.gladiator >= 1100 then
		--	model = "models/items/courier/jin_yin_black_fox/jin_yin_black_fox.vmdl"
		--	scale = 1.45
		--end
        --tree form
        if keys.ability:GetLevel() >= 4 then
          model = "models/heroes/treant_protector/treant_protector.vmdl"
          scale = 0.75--0.95
        end

        --fake cd to disable accidental shift out
        --keys.ability:EndCooldown()
        --keys.ability:StartCooldown(3.5)

        HideWearables(keys)
		target:SetOriginalModel(model)
		target:SetModelScale(scale)
        if keys.ability:GetLevel() >= 4 then
            --print("attach feet")
            local feet = SpawnEntityFromTableSynchronous("prop_dynamic", {model = "models/heroes/treant_protector/legs.vmdl"})
            feet:FollowEntity(target, true)
            target.treantfeet = feet
            local head = SpawnEntityFromTableSynchronous("prop_dynamic", {model = "models/heroes/treant_protector/foliage.vmdl"})
            head:FollowEntity(target, true)
            target.treanthead = head
            local hand = SpawnEntityFromTableSynchronous("prop_dynamic", {model = "models/heroes/treant_protector/hands.vmdl"})
            hand:FollowEntity(target, true)
            target.treanthand = hand
        end
		


	end
	RemoveSlows(keys)
	if keys.rootremove and keys.rootremove == 1 then
		RemoveRoots(keys)
	end
end

function RemoveCosmetics(target)
	if target.tier1prop then
		target.tier1prop:RemoveSelf()
		target.tier1prop = nil
		target.tier1 = nil
	end
	if target.tier2prop then
		target.tier2prop:RemoveSelf()
		target.tier2prop = nil
		target.tier2 = nil
	end
	if target.tier3prop then
		target.tier3prop:RemoveSelf()
		target.tier3prop = nil
		target.tier3 = nil
	end
	if target.tier4prop then
		target.tier4prop:RemoveSelf()
		target.tier4prop = nil
		target.tier4 = nil
	end
end

function shapeshift_end( keys )
	if COverthrowGameMode.EnableShapeshift == 1 then
		local target = keys.target
		local model = keys.model
		-- Checking for errors

		target:SetModel(model)
		target:SetOriginalModel(model)
		target:SetModelScale(0.8)
		ShowWearables(keys)

        if target.treantfeet and not target.treantfeet:IsNull() then
            target.treantfeet:Destroy()
        end
        if target.treanthead and not target.treanthead:IsNull() then
            target.treanthead:Destroy()
        end
        if target.treanthand and not target.treanthand:IsNull() then
            target.treanthand:Destroy()
        end
	end
	--target:Stop()
	--EndAnimation(target)
	--target:SetAnimation("taunt_bazooka")
end

function FurionRunAnimation( event )
	--StartAnimation(event.caster, {activity=ACT_DOTA_RUN, duration=1.2, rate=1.0})
end

function ShapeshiftOut( event )
	--print("out called")
	local caster = event.caster
	local ability = caster:GetAbilityByIndex(5)

	if not caster:HasModifier("modifier_shapeshifttravel") then
		return
	end
    --tree talent
    if ability:GetLevel() >= 4 then
        if event.event_ability then
            if GetAbilityIndexCustom(event.event_ability) == 0 or GetAbilityIndexCustom(event.event_ability) == 2 or GetAbilityIndexCustom(event.event_ability) == 5 then
                --StartAnimation(caster, {activity=ACT_DOTA_ATTACK, duration=0.25, rate=2.5})
            else
                --StartAnimation(caster, {activity=ACT_DOTA_SPAWN, duration=1.5, rate=0.27})
            end
        end
        return
    end

	--Timers:CreateTimer(0.1, function()
		--print(event.event_ability:GetName())
		if event.event_ability and event.event_ability:GetName() ~= "Shapeshift" then
			ability:ToggleAbility()
		elseif event.ability:GetName() ~= "Shapeshift" then
			ability:ToggleAbility()
		end
		--if event.ability:GetName() == "Shapeshift" then
		--	StartAnimation(event.caster, {activity=ACT_DOTA_RUN, duration=1.2, rate=1.0})
		--end
		--event.ability:TOgg
	   	--caster:RemoveModifierByName("modifier_shapeshifttravel")
		--print(event.ability:GetToggleState())
	--end)
end

function ShapeshiftOutNow( keys )
	local caster = keys.caster
	caster.FurionAnimation = 1
	caster:RemoveModifierByName("modifier_shapeshifttravel")
	Timers:CreateTimer(0.05, function()
	   	EndAnimation(caster)
	   	StartAnimation(caster, {activity=ACT_DOTA_CAST_ABILITY_1, duration=1.95, rate=0.3})
	   	caster.FurionAnimation = nil
	end)
end

function ShapeshiftIn( event )
	local caster = event.caster

	if not caster:HasModifier("modifier_shapeshifttravel") then
		local table = {}
		table.Duration = -1
		event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_shapeshifttravel", table)
		--print("recur")
	end
end

function IceBlock(event)
	local caster = event.caster
	local target = event.target
	local healamount = event.heal

	local table = {}
	if caster:GetTeamNumber()==target:GetTeamNumber() then
		--table.Duration = event.duration
		--event.ability:ApplyDataDrivenModifier(caster, target, "modifier_frostarmorbuff", table)

		local myevent = {}
		myevent.caster = caster
		myevent.target = target
		myevent.buff = "modifier_frostarmorbuff"
		myevent.ability = event.ability
		myevent.dur = event.duration
		ApplyBuff(myevent)
        if event.ability:GetLevel() >= 4 then
            myevent.buff = "modifier_ice_armor"
            myevent.dur = 25
            ApplyBuff(myevent)
        end
	else
		--table.Duration = event.duration/2
		--event.ability:ApplyDataDrivenModifier(caster, target, "modifier_frostarmorbuff", table)

		local myevent = {}
		myevent.caster = caster
		myevent.target = target
		myevent.buff = "modifier_frostarmorbuff"
		myevent.ability = event.ability
		myevent.dur = event.duration*event.percent/100
		ApplyBuff(myevent)
	end
end

function ItemProc(event)
	local caster = event.attacker
	local target = event.target
	local proctype = event.proc
	if proctype == "haste" then
		local ability = event.event_ability
		if ability:GetName() == "ShapeshiftFeral" or ability:GetName() == "Shapeshift" then
			return
		end
		caster = event.caster
	end

	-- Basher
	if proctype == "stun" and not (caster:HasModifier("modifier_cdbasher")) then
		event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_cdbasher", nil)
		local table = {}
		table.Duration = 3.5
		if caster:IsRangedAttacker() then
			table.Duration = 2.5
		end
		--event.ability:ApplyDataDrivenModifier(caster, target, "modifier_stunned", table)

		local myevent = {}
		myevent.caster = caster
		myevent.target = target
		myevent.buff = "modifier_stunned"
		myevent.ability = event.ability
		myevent.dur = table.Duration
		ApplyBuff(myevent)
		--fx
		--local particle = ParticleManager:CreateParticle("particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_crit_impact_dagger_arcana.vpcf", PATTACH_POINT_FOLLOW, target)
    	--ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())
		--ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin())
		--ParticleManager:SetParticleControl(particle, 2, target:GetAbsOrigin())

		local particle = ParticleManager:CreateParticle("particles/econ/items/antimage/antimage_weapon_basher_ti5_gold/am_manaburn_basher_ti_5_gold.vpcf", PATTACH_POINT_FOLLOW, target)
		ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())

		particle = ParticleManager:CreateParticle("particles/items2_fx/soul_ring_blood.vpcf", PATTACH_POINT_FOLLOW, target)
		ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())
		
		particle = ParticleManager:CreateParticle("particles/units/heroes/hero_bloodseeker/bloodseeker_bloodritual_impact_c.vpcf", PATTACH_POINT_FOLLOW, target)
		ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())
		
		
		

		EmitSoundOn( "DOTA_Item.DiffusalBlade.Kill", target)
	end

	-- Zeus
	if proctype == "zeus" and not (caster:HasModifier("modifier_cdzeus")) then
		event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_cdzeus", nil)
		--fx
		local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_disruptor/disruptor_thunder_strike_aoe.vpcf", PATTACH_POINT_FOLLOW, target)
		particle = ParticleManager:CreateParticle("particles/units/heroes/hero_disruptor/disruptor_thunder_strike_bolt.vpcf", PATTACH_POINT_FOLLOW, target)
    	ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())
		ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin())
		ParticleManager:SetParticleControl(particle, 2, target:GetAbsOrigin())
		ParticleManager:SetParticleControl(particle, 3, target:GetAbsOrigin())
		particle = ParticleManager:CreateParticle("particles/units/heroes/hero_zuus/zuus_thundergods_wrath_start.vpcf", PATTACH_POINT_FOLLOW, target)
    	ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())
		ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin())
		ParticleManager:SetParticleControl(particle, 2, target:GetAbsOrigin())
		ParticleManager:SetParticleControl(particle, 3, target:GetAbsOrigin())
		particle = ParticleManager:CreateParticle("particles/econ/items/zeus/lightning_weapon_fx/zuus_lightning_bolt_castfx_ground2.vpcf", PATTACH_POINT_FOLLOW, target)
		--sound
		EmitSoundOn( "DOTA_Item.Mjollnir.Activate", target)
		--dmg
		DamageAOE(event)
	end

	-- Fury
	if proctype == "fury" and not (caster:HasModifier("modifier_cdfury")) then
		event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_cdfury", nil)
		event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_wfproc", nil)
		--sound
		EmitSoundOn( "DOTA_Item.MaskOfMadness.Activate", caster)
	end
	-- Haste Proc 25%
	if proctype == "haste" and not (caster:HasModifier("modifier_cdhasteproc")) then
		event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_cdhasteproc", nil)
		event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_hasteproc25", nil)
		--sound
		EmitSoundOn( "DOTA_Item.MaskOfMadness.Activate", caster)
	end
	
end

function AstralGuardianProcs(event)
	local caster = event.caster
	local target = event.target

	if event.id <= 3 then
  		local stack = caster:GetModifierStackCount("modifier_mooncharge", caster)
  		if stack >= 5 then
  			caster:RemoveModifierByName("modifier_mooncharge")	
	    	if event.id == 1 then
	    		event.amount = event.procmana
	    		event.percent = 1
	    		RestoreMana(event)
	    	end
	    	if event.id == 2 then
	    		--event.max = 5
	    		--event.buff = "modifier_suncharge"
	    		--ApplyBuffStack(event)
	    		--event.max = 5
	    		--event.buff = "modifier_suncharge"
	    		--ApplyBuffStack(event)
                event.chooseability = 3
                event.amount = 8
                ReduceCooldown(event)
                event.chooseability = 4
                ReduceCooldown(event)
	    	end
  		end
    else
    	local stack = caster:GetModifierStackCount("modifier_suncharge", caster)
  		if stack >= 5 then
  			caster:RemoveModifierByName("modifier_suncharge")	
	    	if event.id == 4 then
	    		--event.buff = "modifier_stunned"
	    		--event.dur = event.stun
	    		--ApplyBuff(event)
                event.chooseability = 1
                event.amount = 8
                ReduceCooldown(event)
                event.chooseability = 4
                ReduceCooldown(event)
	    	end
	    	if event.id == 5 then
	    		event.buff = "modifier_fairyfire"
	    		event.dur = event.moondur
	    		ApplyBuff(event)
	    	end
            if event.id == 6 then
                event.buff = "modifier_druid_sun_crit"
                event.dur = 30
                event.ability = caster:GetAbilityByIndex(5)
                event.target = caster
                ApplyBuff(event)
            end
  		end
    end
end

function AstralAOERoots(event)
	local caster = event.caster
	local stack = caster:GetModifierStackCount("modifier_suncharge", caster)
	if stack >= 5 then
		return
		CCTarget(event)
	end
end

function ChainLightning(event)
	local caster = event.caster
	local target = event.target
	local heroName = caster:GetUnitName()
	if heroName == "npc_dota_hero_disruptor" then
		event.attributefactor = event.attributefactor*1.4*event.reduction/100
		event.spelldamagefactor = event.spelldamagefactor*1.4*event.reduction/100
	else
		event.attributefactor = event.attributefactor*event.reduction/100
		event.spelldamagefactor = event.spelldamagefactor*event.reduction/100
	end
	
	local enemies = FindUnitsInRadius( caster:GetTeamNumber(), target:GetAbsOrigin(), caster, 400, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	local damagedone = 0
	if #enemies > 0 then
		for _,enemy in pairs(enemies) do
			if enemy ~= nil and enemy ~= target and damagedone == 0 and ((enemy:GetUnitLabel()=="hero") or (enemy:GetUnitLabel()=="pet") or (enemy:GetUnitLabel()=="tower"))  then
				if not CheckForBreakableCC(enemy) then
					local oldtarget = event.target
					event.target = enemy
					damagedone = 1

					-- damage delayed
					Timers:CreateTimer(0.4, function()
						local thunderstacks = caster:GetModifierStackCount("modifier_ele_thunder_stacks", nil)
						DamageUnit( event )
						local vec1 = oldtarget:GetAbsOrigin()+Vector(0,0,150)
						local vec2 = event.target:GetAbsOrigin()+Vector(0,0,150)
						local particle = ParticleManager:CreateParticle("particles/econ/items/razor/razor_punctured_crest/razor_storm_lightning_strike_blade.vpcf", PATTACH_POINT_FOLLOW, event.target)
						ParticleManager:SetParticleControl(particle, 0, vec2)
						ParticleManager:SetParticleControl(particle, 1, vec1)
						ParticleManager:SetParticleControl(particle, 2, vec2)
						EmitSoundOn( "DOTA_Item.Mjollnir.Activate", event.target)
						if thunderstacks >= 3 and event.stun and event.stun > 0 then
							local myevent = {}
							myevent.caster = caster
							myevent.target = enemy
							myevent.buff = "modifier_stunned"
							myevent.ability = event.ability
							myevent.dur = event.stun
							ApplyBuff(myevent)
						end
					end)
				end
			end
		end
	end

	--[[ double hit!
	if damagedone == 0 then
		Timers:CreateTimer(1.0, function()
		    
			local vec1 = caster:GetAbsOrigin()+Vector(0,0,150)
			local vec2 = event.target:GetAbsOrigin()+Vector(0,0,150)
			print(vec1)
			print(vec2)
			local particle = ParticleManager:CreateParticle("particles/econ/items/razor/razor_punctured_crest/razor_storm_lightning_strike_blade.vpcf", PATTACH_POINT_FOLLOW, event.target)
			ParticleManager:SetParticleControl(particle, 0, vec2)
			ParticleManager:SetParticleControl(particle, 1, vec1)
			ParticleManager:SetParticleControl(particle, 2, vec2)
			EmitSoundOn( "DOTA_Item.Mjollnir.Activate", event.target)
			DamageUnit( event )
		end)
		
	end
	]]
end


function ShapeshiftFeral(event)
	local caster = event.caster
	local level = caster:GetAbilityByIndex(5):GetLevel()
	if caster:HasModifier("modifier_catform") then
        -- to human form
        caster.resourcesystem = nil
        caster.Catform = 0
		caster:RemoveModifierByName("modifier_combopoint")
		caster:RemoveModifierByName("modifier_season2gladiator")
		caster.ComboPoints = 0
		caster:RemoveModifierByName("modifier_catform")
        event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_catform_off", nil)
		caster:SetMana(caster.OldMana)
		caster.spell1 = caster:GetAbilityByIndex(0):GetLevel()
		caster.spell2 = caster:GetAbilityByIndex(1):GetLevel()
		caster.spell3 = caster:GetAbilityByIndex(2):GetLevel()
		caster.spell4 = caster:GetAbilityByIndex(3):GetLevel()
		caster.spell5 = caster:GetAbilityByIndex(4):GetLevel()
		caster:RemoveAbility("Feral2")
		caster:RemoveAbility("Feral3")
		caster:RemoveAbility("Feral4")
		caster:RemoveAbility("Feral1")
		caster:RemoveAbility("Feral5")
		caster:AddAbility("RegrowthFeral")
		caster:GetAbilityByIndex(0):SetLevel(level)
		caster:AddAbility("RootsDruidFeral")
		caster:GetAbilityByIndex(1):SetLevel(level)
		--if caster:HasModifier("modifier_feralpowercast") then
 		--	caster:AddAbility("CycloneDruidFeralInstant")
		--else
			caster:AddAbility("CycloneDruidFeral")
		--end
		caster:GetAbilityByIndex(2):SetLevel(level)
		caster:AddAbility("empty_spell1")
		caster:GetAbilityByIndex(3):SetLevel(1)
		caster:AddAbility("empty_spell2")
		caster:GetAbilityByIndex(4):SetLevel(1)

		--model change
		if COverthrowGameMode.EnableShapeshift == 1 then
			local model = "models/heroes/dazzle/dazzle.vmdl"
			caster:SetOriginalModel(model)
			caster:SetModelScale(0.80)
			ShowWearables(event)
			StartAnimation(caster, {activity=ACT_DOTA_RUN, duration=0.1, rate=1.0})
		end
	else 
        -- to feral form
        caster.resourcesystem = 4
        caster.Catform = 1
		caster.OldMana = caster:GetMana()
        caster:RemoveModifierByName("modifier_catform_off")
		event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_catform", nil)
        if caster.feralfirstshift then
    		caster:RemoveAbility("RegrowthFeral")
    		caster:RemoveAbility("RootsDruidFeral")
    		caster:RemoveAbility("CycloneDruidFeral")
    		caster:RemoveAbility("CycloneDruidFeralInstant")
    		caster:RemoveAbility("empty_spell1")
    		caster:RemoveAbility("empty_spell2")
    		caster:AddAbility("Feral2")
    		caster:GetAbilityByIndex(0):SetLevel(caster.spell1)
    		caster:AddAbility("Feral3")
    		caster:GetAbilityByIndex(1):SetLevel(caster.spell2)
    		caster:AddAbility("Feral4")
    		caster:GetAbilityByIndex(2):SetLevel(caster.spell3)
    		caster:AddAbility("Feral1")
    		caster:GetAbilityByIndex(3):SetLevel(caster.spell4)
    		caster:AddAbility("Feral5")
    		caster:GetAbilityByIndex(4):SetLevel(caster.spell5)
        else
            caster.feralfirstshift = true
        end

		--model change, only when synced
		if COverthrowGameMode.EnableShapeshift == 1 then
			local model = "models/items/lycan/wolves/hunter_kings_wolves/hunter_kings_wolves.vmdl"
			local scale = 0.9
			--new form
			if caster.season2_2vs2 and caster.season2_2vs2 == 1 then
				model = "models/items/lycan/ultimate/hunter_kings_trueform/hunter_kings_trueform.vmdl"
				scale = 0.65
			end

			caster.old_model = caster:GetModelName()
			caster:SetOriginalModel(model)
			caster:SetModelScale(scale)
			HideWearables(event)

			StartAnimation(caster, {activity=ACT_DOTA_RUN, duration=0.1, rate=1.0})
			if caster.season2_2vs2 and caster.season2_2vs2 == 1 then
				caster:GetAbilityByIndex(5):ApplyDataDrivenModifier(caster, caster, "modifier_season2gladiator", nil)
			end
		end
		
	end
end


function RemoveInstantAbility(event)
	local caster = event.caster
	local target = event.target
	Timers:CreateTimer(0.1, function()
		if caster:GetAbilityByIndex(event.position-1):GetName() == "CycloneDruidFeralInstant" then
			caster:RemoveAbility("CycloneDruidFeralInstant")
			caster:AddAbility("CycloneDruidFeral")
			caster:GetAbilityByIndex(2):SetLevel(caster:GetAbilityByIndex(5):GetLevel())
			caster:GetAbilityByIndex(2):StartCooldown(15.0)
			--local tab = {}
			--tab.Duration = event.time*GetCCPower(event)
			--caster:GetAbilityByIndex(2):ApplyDataDrivenModifier(caster, target, "modifier_cyclone_self", tab)

			local myevent = {}
			myevent.caster = caster
			myevent.target = target
			myevent.buff = "modifier_cyclone_self"
			myevent.ability = caster:GetAbilityByIndex(2)
			myevent.dur = event.time*GetCCPower(event)
			ApplyBuff(myevent)
			--print(tab.Duration)
		end
	end)
end

function FeralAttackHeal(event)
	local caster = event.attacker
	if caster ~= nil and caster:GetUnitName() == "npc_dota_hero_dazzle" then
		event.caster = caster
		event.target = caster
		event.heal = caster:GetStrength()*0.4
		event.spelldamagefactor = 0.0
		event.attributefactor = 0.0
		HealUnit(event)
		particle = ParticleManager:CreateParticle("particles/units/heroes/hero_dazzle/dazzle_shadow_wave_magic.vpcf", PATTACH_POINT_FOLLOW, caster)
		ParticleManager:SetParticleControl(particle, 0, caster:GetAbsOrigin())
		ParticleManager:SetParticleControl(particle, 1, caster:GetAbsOrigin())
		
	end
end

function Feral5(event)
	local caster = event.caster
	local target = event.target
	
	Timers:CreateTimer(0.35, function()
			if target:IsAlive() then
				local vec2 = RandomVector(125)
				local vec = target:GetAbsOrigin()+Vector(vec2[1],vec2[2],0)
				caster:SetAbsOrigin(vec)
			end
		end)
end

function Bleed1(event)
	local caster = event.caster
	local target = event.target
	local ability = event.ability
	
	--[[
	if target:HasModifier("modifier_bleed1_1") then
		target:RemoveModifierByName("modifier_bleed1_1")
		ability:ApplyDataDrivenModifier(caster, target, "modifier_bleed1_2", nil)
		target:SetModifierStackCount("modifier_bleed1_2", ability, 2)
	elseif target:HasModifier("modifier_bleed1_2") then
		target:RemoveModifierByName("modifier_bleed1_2")
		ability:ApplyDataDrivenModifier(caster, target, "modifier_bleed1_3", nil)
		target:SetModifierStackCount("modifier_bleed1_3", ability, 3)
	elseif target:HasModifier("modifier_bleed1_3") then
		target:RemoveModifierByName("modifier_bleed1_3")
		ability:ApplyDataDrivenModifier(caster, target, "modifier_bleed1_3", nil)
		target:SetModifierStackCount("modifier_bleed1_3", ability, 3)
	else
		ability:ApplyDataDrivenModifier(caster, target, "modifier_bleed1_1", nil)
		target:SetModifierStackCount("modifier_bleed1_1", ability, 1)
	end--]]

	if target:HasModifier("modifier_bleedslow") then
		local stackcount = target:GetModifierStackCount("modifier_bleedslow", caster)+1
		if stackcount > 3 then
			stackcount = 3
		end
		target:RemoveModifierByName("modifier_bleedslow")
		--ability:ApplyDataDrivenModifier(caster, target, "modifier_bleedslow", nil)

		local myevent = {}
		myevent.caster = caster
		myevent.target = target
		myevent.buff = "modifier_bleedslow"
		myevent.ability = ability
		myevent.dur = event.dur
		ApplyBuff(myevent)

		target:SetModifierStackCount("modifier_bleedslow", ability, stackcount)
	else
		--ability:ApplyDataDrivenModifier(caster, target, "modifier_bleedslow", nil)

		local myevent = {}
		myevent.caster = caster
		myevent.target = target
		myevent.buff = "modifier_bleedslow"
		myevent.ability = ability
		myevent.dur = event.dur
		ApplyBuff(myevent)

		target:SetModifierStackCount("modifier_bleedslow", ability, 1)
	end
end

function HealAbsorb(event)
	local caster = event.caster
	local target = event.target
	local ability = event.ability

	local stackcount = target:GetModifierStackCount("modifier_healabsorb", caster)

	local stackcount = stackcount + event.amount*caster:GetPrimaryStatValue()/100

	local tab = {}
	tab.Duration = event.dur
	target:RemoveModifierByName("modifier_healabsorb")
	--ability:ApplyDataDrivenModifier(caster, target, "modifier_healabsorb", tab)

	local myevent = {}
	myevent.caster = caster
	myevent.target = target
	myevent.buff = "modifier_healabsorb"
	myevent.ability = ability
	myevent.dur = event.dur
	ApplyBuff(myevent)

	target:SetModifierStackCount("modifier_healabsorb", ability, stackcount)
	target.healabsorbability = ability
end

function FeralFinisher(event)
	local caster = event.caster
	local target = event.target
	local ability = event.ability
	
	if caster.ComboPoints > 0 then
		if event.mana and event.mana > 0 then
			caster.OldMana = caster.OldMana + event.mana*caster.ComboPoints
		end
		--caster.FeralPowerCast = 1 + caster.ComboPoints/5
		if caster.ComboPoints == 4 then
			ability:ApplyDataDrivenModifier(caster, caster, "modifier_instantbolt", nil)
            caster:SetModifierStackCount("modifier_instantbolt", ability, 1)
		end
		--caster:SetModifierStackCount("modifier_feralpowercast", ability, caster.ComboPoints)
		local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_dazzle/dazzle_shadow_wave_magic.vpcf", PATTACH_POINT_FOLLOW, caster)
		ParticleManager:SetParticleControl(particle, 0, caster:GetAbsOrigin())
		ParticleManager:SetParticleControl(particle, 1, caster:GetAbsOrigin())

		caster:RemoveModifierByName("modifier_combopoint")
		caster.FeralFinisher = caster.ComboPoints / 4
		caster.ComboPoints = 0
		--ability:ApplyDataDrivenModifier(caster, target, "modifier_bleed2", nil)

        if event.chance and event.chance < 100 then
    		local myevent = {}
    		myevent.caster = caster
    		myevent.target = target
    		myevent.buff = "modifier_bleed2"
    		myevent.ability = ability
    		myevent.dur = event.dur
    		ApplyBuff(myevent)
        else
            local myevent = {}
            myevent.caster = caster
            myevent.target = target
            myevent.damage = 0.0
            myevent.attributefactor = event.dmgfromstat
            myevent.ability = ability
            myevent.feral4x = 1
            myevent.critchancefactor = event.critchancefactor
            myevent.t3bonus = event.t3bonus
            DamageUnit(myevent)
        end
	end
end

function ShieldBash(event)
	local caster = event.caster
	local target = event.target
	local ability = event.ability
	local stackcount = 0
	
	if caster:HasModifier("modifier_shieldbash") then
		stackcount = caster:GetModifierStackCount("modifier_shieldbash", caster)+1
		if stackcount > event.stacks then
			stackcount = event.stacks
		end
		target:RemoveModifierByName("modifier_shieldbash")
		ability:ApplyDataDrivenModifier(caster, caster, "modifier_shieldbash", nil)
		caster:SetModifierStackCount("modifier_shieldbash", ability, stackcount)
	else
		ability:ApplyDataDrivenModifier(caster, caster, "modifier_shieldbash", nil)
		stackcount = 1
		caster:SetModifierStackCount("modifier_shieldbash", ability, stackcount)
	end

	event.shieldbashbonus = stackcount
	DamageUnit(event)

end

function SwordSwipe(event)
	local caster = event.caster
	local target = event.target
	local ability = event.ability
	local stackcount = 0
	
	local range = 250

	local targetamount = 0

	local enemies = FindUnitsInRadius( caster:GetTeamNumber(), event.target_points[1], caster, range, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	if #enemies > 0 then
		for _,enemy in pairs(enemies) do
			if enemy ~= nil then
				if ((enemy:GetUnitLabel()=="hero") or (enemy:GetUnitLabel()=="pet") or (enemy:GetUnitLabel()=="tower")) then
					targetamount = targetamount + 1
				end
			end
		end
	end

    if targetamount > event.swordcap then
        targetamount = event.swordcap
    end
	event.attributefactor = event.attributefactor + event.attributefactor*targetamount*event.aoebonus/100
    event.includeauto = event.includeauto + event.includeauto*targetamount*event.aoebonus/100

	if #enemies > 0 then
		for _,enemy in pairs(enemies) do
			if enemy ~= nil then
				if ((enemy:GetUnitLabel()=="hero") or (enemy:GetUnitLabel()=="pet") or (enemy:GetUnitLabel()=="tower")) then
					ability:ApplyDataDrivenModifier(caster, caster, "modifier_prot_str_bonus", nil)
					local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_bloodseeker/bloodseeker_rupture_nuke.vpcf", PATTACH_POINT_FOLLOW, enemy)
					event.target = enemy
					DamageUnit(event)
				end
			end
		end
	end

end
	
function Crush(event)
	local caster = event.caster
	local target = event.target
	local ability = event.ability
	local pos = event.target_points[1]
	local range = 250

	local enemies = FindUnitsInRadius( caster:GetTeamNumber(), pos, caster, range, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )

	if #enemies > 0 then
		for _,enemy in pairs(enemies) do
			if enemy ~= nil then
				if ((enemy:GetUnitLabel()=="hero") or (enemy:GetUnitLabel()=="pet") or (enemy:GetUnitLabel()=="tower")) then
					local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_bloodseeker/bloodseeker_rupture_nuke.vpcf", PATTACH_POINT_FOLLOW, enemy)
					--ability:ApplyDataDrivenModifier(caster, enemy, "modifier_slow25", nil)

					local myevent = {}
					myevent.caster = caster
					myevent.target = enemy
					myevent.buff = "modifier_slow25"
					myevent.ability = ability
					myevent.dur = event.dur
					ApplyBuff(myevent)
				end
			end
		end
	end

	Timers:CreateTimer(3.0, function()
            if event.thunder and event.thunder > 0 then
                particle = ParticleManager:CreateParticle("particles/units/heroes/hero_disruptor/disruptor_thunder_strike_bolt.vpcf", PATTACH_POINT_FOLLOW, caster)
                ParticleManager:SetParticleControl(particle, 0, caster:GetAbsOrigin())
                ParticleManager:SetParticleControl(particle, 1, caster:GetAbsOrigin())
                ParticleManager:SetParticleControl(particle, 2, caster:GetAbsOrigin())
                ParticleManager:SetParticleControl(particle, 3, caster:GetAbsOrigin())
                EmitSoundOn( "DOTA_Item.Mjollnir.Activate", caster)
                Timers:CreateTimer(0.5, function()
                    particle = ParticleManager:CreateParticle("particles/units/heroes/hero_disruptor/disruptor_thunder_strike_bolt.vpcf", PATTACH_POINT_FOLLOW, caster)
                    ParticleManager:SetParticleControl(particle, 0, caster:GetAbsOrigin())
                    ParticleManager:SetParticleControl(particle, 1, caster:GetAbsOrigin())
                    ParticleManager:SetParticleControl(particle, 2, caster:GetAbsOrigin())
                    ParticleManager:SetParticleControl(particle, 3, caster:GetAbsOrigin())
                    EmitSoundOn( "DOTA_Item.Mjollnir.Activate", caster)
                end)
                Timers:CreateTimer(1.0, function()
                    particle = ParticleManager:CreateParticle("particles/units/heroes/hero_disruptor/disruptor_thunder_strike_bolt.vpcf", PATTACH_POINT_FOLLOW, caster)
                    ParticleManager:SetParticleControl(particle, 0, caster:GetAbsOrigin())
                    ParticleManager:SetParticleControl(particle, 1, caster:GetAbsOrigin())
                    ParticleManager:SetParticleControl(particle, 2, caster:GetAbsOrigin())
                    ParticleManager:SetParticleControl(particle, 3, caster:GetAbsOrigin())
                    EmitSoundOn( "DOTA_Item.Mjollnir.Activate", caster)
                end)
            else
			    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_ursa/ursa_earthshock.vpcf", PATTACH_POINT_FOLLOW, caster)
                EmitSoundOn( "Hero_DragonKnight.BreathFire", caster)
            end
            
			local enemies = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetOrigin(), caster, range, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
			if #enemies > 0 then
				for _,enemy in pairs(enemies) do
					if enemy ~= nil then
						if ((enemy:GetUnitLabel()=="hero") or (enemy:GetUnitLabel()=="pet") or (enemy:GetUnitLabel()=="tower")) then
							local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_bloodseeker/bloodseeker_rupture_nuke.vpcf", PATTACH_POINT_FOLLOW, enemy)
							--ability:ApplyDataDrivenModifier(caster, enemy, "modifier_slow75", nil)

							local myevent = {}
							myevent.caster = caster
							myevent.target = enemy
							myevent.buff = "modifier_slow75"
							myevent.ability = ability
							myevent.dur = event.dur
							ApplyBuff(myevent)
                            if event.thunder and event.thunder > 0 then
                                local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_disruptor/disruptor_thunder_strike_aoe.vpcf", PATTACH_ABSORIGIN_FOLLOW, enemy)
                                local myevent = {}
                                myevent.caster = caster
                                myevent.target = enemy
                                myevent.ability = ability
                                myevent.damage = 0.0
                                myevent.spelldamagefactor = 0.0
                                myevent.attributefactor = event.thunder
                                myevent.naturedmg = 1
                                DamageUnit(myevent)
                                Timers:CreateTimer(0.5, function()
                                    DamageUnit(myevent)
                                end)
                                Timers:CreateTimer(1.0, function()
                                    DamageUnit(myevent)
                                end)
                            end
						end
					end
				end
			end
		end)
end

function CloakOfConceal(event)
	local caster = event.caster
	local heroName = caster:GetUnitName()
	if heroName == "npc_dota_hero_phantom_assassin" or heroName == "npc_dota_hero_riki" or heroName == "npc_dota_hero_bounty_hunter" or COverthrowGameMode.junglemode  then

		local target = event.target
		local ability = event.ability
		local pos = event.target_points[1]
		local range = 450

		local enemies = FindUnitsInRadius( caster:GetTeamNumber(), pos, caster, range, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )

		local tab = {}
		tab.Duration = 12
		if #enemies > 0 then
			for _,enemy in pairs(enemies) do
				if enemy ~= nil then
					if ((enemy:GetUnitLabel()=="hero") or (enemy:GetUnitLabel()=="pet")) and not enemy:IsNull() then
						local particle = ParticleManager:CreateParticle("particles/generic_gameplay/rune_invisibility_refract_plasma_sparks.vpcf", PATTACH_POINT_FOLLOW, enemy)
						ability:ApplyDataDrivenModifier(caster, enemy, "modifier_invisible", tab)
						ability:ApplyDataDrivenModifier(caster, enemy, "modifier_cloakitem", tab)
					end
				end
			end
		end
	end
end

function Counterblow( event )
	local target = event.target
	local caster = event.caster

	if event.protstun and event.protstun > 0.0 then
		local myevent = {}
		myevent.caster = caster
		myevent.target = target
		myevent.buff = "modifier_stunned"
		myevent.ability = event.ability
		myevent.dur = event.protstun
		ApplyBuff(myevent)
	end
	DamageUnit(event)
end

function Kingsguard( event )
	local target = event.target
	local caster = event.caster
	local vec = (event.target:GetAbsOrigin()-event.caster:GetAbsOrigin()):Length()

	if vec >= 450 then
		target:RemoveModifierByName("modifier_kingsguard")
	end
end

function SwitchStancesProt(event)

	local hero = event.caster
	local abil1 = hero:GetAbilityByIndex(0)
	local abil2 = hero:GetAbilityByIndex(1)
	local abil3 = hero:GetAbilityByIndex(2)

	if abil1:GetAbilityName() == "Protect1" then
		--print("to defensive")
		event.ability:ApplyDataDrivenModifier(hero, hero, "modifier_defstance", nil)
        hero:RemoveModifierByName("modifier_offstance")
		hero.abil1=abil1:GetLevel()
		hero.abil2=abil2:GetLevel()
		hero.abil3=abil3:GetLevel()

  		hero:RemoveAbility(abil1:GetAbilityName())
  		hero:RemoveAbility(abil2:GetAbilityName())
  		hero:RemoveAbility(abil3:GetAbilityName())

  		hero:AddAbility("WarriorCharge")
  		hero:FindAbilityByName("WarriorCharge"):SetLevel(hero:FindAbilityByName("Switch_Battle_Stance_Prot"):GetLevel())
  		hero:AddAbility("Shield_Reflect")
  		hero:FindAbilityByName("Shield_Reflect"):SetLevel(hero:FindAbilityByName("Switch_Battle_Stance_Prot"):GetLevel())
  		hero:AddAbility("Terror_ShoutProt")
  		hero:FindAbilityByName("Terror_ShoutProt"):SetLevel(hero:FindAbilityByName("Switch_Battle_Stance_Prot"):GetLevel())
  	else
  		--print("to offensive")
        if event.alwaysdef and event.alwaysdef == 1 then
            event.ability:ApplyDataDrivenModifier(hero, hero, "modifier_offstance", nil)
        end
  		hero:RemoveModifierByName("modifier_defstance")
  		-- fix crash on switch while charging
		if hero:HasModifier("modifier_WarriorCharge") then
	 		Timers:CreateTimer(1.0,function() 
		        fixChargeStanceSwitchProt(hero)
		    end)
		else
	  		hero:RemoveAbility(abil1:GetAbilityName())
	  		hero:AddAbility("Protect1")
	  		hero:FindAbilityByName("Protect1"):SetLevel(hero.abil1)
		end



  		

  		hero:RemoveAbility(abil2:GetAbilityName())
  		hero:AddAbility("Protect2")
  		hero:FindAbilityByName("Protect2"):SetLevel(hero.abil2)

  		hero:RemoveAbility(abil3:GetAbilityName())
  		hero:AddAbility("Protect3")
  		hero:FindAbilityByName("Protect3"):SetLevel(hero.abil3)
  		
  	end
end

function fixChargeStanceSwitchProt(hero)
	if hero:HasModifier("modifier_WarriorCharge") then
 		Timers:CreateTimer(1.0,function() 
	        fixChargeStanceSwitchProt(hero)
	    end)
	else
		local abil1 = hero:GetAbilityByIndex(0)
  		hero:RemoveAbility(abil1:GetAbilityName())
  		hero:AddAbility("Protect1")
  		hero:FindAbilityByName("Protect1"):SetLevel(hero.abil1)
	end
end

function SwitchStancesFury(event)

	local hero = event.caster
	local abil1 = hero:GetAbilityByIndex(0)
	local abil2 = hero:GetAbilityByIndex(1)
	local abil3 = hero:GetAbilityByIndex(2)

	if abil1:GetAbilityName() == "fury1" then
		--print("to defensive")
		event.ability:ApplyDataDrivenModifier(hero, hero, "modifier_defstance", nil)
		hero.abil1=abil1:GetLevel()
		hero.abil2=abil2:GetLevel()
		hero.abil3=abil3:GetLevel()

  		hero:RemoveAbility(abil1:GetAbilityName())
  		hero:RemoveAbility(abil2:GetAbilityName())
  		hero:RemoveAbility(abil3:GetAbilityName())

  		hero:AddAbility("WarriorCharge")
  		hero:FindAbilityByName("WarriorCharge"):SetLevel(hero:FindAbilityByName("fury6"):GetLevel())
  		hero:AddAbility("Shield_Reflect")
  		hero:FindAbilityByName("Shield_Reflect"):SetLevel(hero:FindAbilityByName("fury6"):GetLevel())
  		hero:AddAbility("Terror_ShoutFury")
  		hero:FindAbilityByName("Terror_ShoutFury"):SetLevel(hero:FindAbilityByName("fury6"):GetLevel())
  	else
  		--print("to offensive")
  		hero:RemoveModifierByName("modifier_defstance")
  		-- fix crash on switch while charging
		if hero:HasModifier("modifier_WarriorCharge") then
	 		Timers:CreateTimer(1.0,function() 
		        fixChargeStanceSwitchFury(hero)
		    end)
		else
	  		hero:RemoveAbility(abil1:GetAbilityName())
	  		hero:AddAbility("fury1")
	  		hero:FindAbilityByName("fury1"):SetLevel(hero.abil1)
		end



  		

  		hero:RemoveAbility(abil2:GetAbilityName())
  		hero:AddAbility("fury2")
  		hero:FindAbilityByName("fury2"):SetLevel(hero.abil2)

  		hero:RemoveAbility(abil3:GetAbilityName())
  		hero:AddAbility("fury3")
  		hero:FindAbilityByName("fury3"):SetLevel(hero.abil3)
  		
  	end
end

function fixChargeStanceSwitchFury(hero)
	if hero:HasModifier("modifier_WarriorCharge") then
 		Timers:CreateTimer(1.0,function() 
	        fixChargeStanceSwitchFury(hero)
	    end)
	else
		local abil1 = hero:GetAbilityByIndex(0)
  		hero:RemoveAbility(abil1:GetAbilityName())
  		hero:AddAbility("fury1")
  		hero:FindAbilityByName("fury1"):SetLevel(hero.abil1)
	end
end

function LightningFurySetup( event )
	local target = event.caster
	if target.LFury then
		if target.LFury > 0 then
			target.LFury = target.LFury + event.charges
		else
			target.LFury = event.charges + 1
		end
	else
		target.LFury = event.charges + 1
	end
end

function LightningFury( event )
	local caster = event.attacker
	caster.LFury = caster.LFury - 1
	if caster.LFury <= 0 then
		caster:RemoveModifierByName("modifier_lightningfury")
		caster.LFury = 0
	end
end

function LightningFuryEnd( event )
	event.target.LFury = 0
end

function GhostWolf1(event)
	local caster = event.caster
	local unit = event.target
	unit.owner = caster
	caster.Pet1 = unit
	unit:CreatureLevelUp(event.ability:GetLevel()-1)

	unit:SetHullRadius(35)
end

function GhostWolf2(event)
	local caster = event.caster
	local unit = event.target
	unit.owner = caster
	caster.Pet2 = unit
	unit:CreatureLevelUp(event.ability:GetLevel()-1)

	unit:SetHullRadius(35)
end

function GhostWolfAttack (event)
	local caster = event.attacker
	local damage = event.heal
	local target = caster.owner
	if target ~= nil then
		target:SetMana(target:GetMana()+damage)
		--target:SetHealth(target:GetHealth()+damage)
		--local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_rubick/rubick_fade_bolt_head_b.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_skeletonking/wraith_king_vampiric_aura_lifesteal.vpcf", PATTACH_POINT_FOLLOW, target)
		--ParticleManager:SetParticleControl(particle, 0, caster:GetAbsOrigin())
		ParticleManager:SetParticleControl(particle, 1, caster:GetAbsOrigin())
		event.target = target
		event.caster = target	
		HealUnit(event)
	end
end

function PetLifestealOwner(event)
	local caster = event.attacker
    if event.factor then
        event.heal = event.factor * event.heal / 100
    end
	local target = caster.owner
	if target ~= nil then
		local particle = ParticleManager:CreateParticle("particles/generic_gameplay/generic_lifesteal_lanecreeps.vpcf", PATTACH_POINT_FOLLOW, target)
		--ParticleManager:SetParticleControl(particle, 1, caster:GetAbsOrigin())
		event.target = target
		event.caster = target	
		HealUnit(event)
	end
end

function StormWard(event)
	local caster = event.caster
	local unit = event.target
	unit.owner = caster
	if event.offset ~= nil then
		unit:SetAbsOrigin(unit:GetAbsOrigin()+Vector(event.offset,0,0))
	end
	unit:CreatureLevelUp(event.ability:GetLevel()-1)
	event.target:SetForwardVector(Vector(0,-1,0))
	unit:SetRenderColor(255, 255, 255)
	EmitSoundOn("DOTA_Item.Cyclone.Activate", unit)
end

function WFTotem(event)
	local caster = event.caster
	if caster and caster:HasModifier("modifier_stormaurabuff1") then
		local abil = caster:GetAbilityByIndex(0)
		if abil then
			if event.ability:GetLevel() >= 4 then
				--aoe talent
				local enemies = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetOrigin(), caster, 99999, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, 0, 0, false )
				if #enemies > 0 then
					for _,enemy in pairs(enemies) do
						if enemy ~= nil then
							if enemy:HasModifier("modifier_stormaurabuff1") then
								local myevent = {}
								myevent.caster = caster
								myevent.target = enemy
								myevent.buff = "modifier_lightningfury"
								myevent.ability = abil
								myevent.dur = nil
								myevent.charges = event.charges
								ApplyBuff(myevent)
								local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_brewmaster/brewmaster_windwalk_sparks.vpcf", PATTACH_POINT_FOLLOW, enemy)
								EmitSoundOn("DOTA_Item.Cyclone.Activate", enemy)
								myevent.caster = enemy
								LightningFurySetup(myevent)
							end
						end
					end
				end
			else
				abil:ApplyDataDrivenModifier(caster, caster, "modifier_lightningfury", nil)
				local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_brewmaster/brewmaster_windwalk_sparks.vpcf", PATTACH_POINT_FOLLOW, caster)
				EmitSoundOn("DOTA_Item.Cyclone.Activate", caster)
				LightningFurySetup(event)
			end
		end
	end
end

function SummonSuccubus(event)
	--local caster = event.caster
	local unit = event.target
	local caster = event.caster
	
	if caster.Pet ~= nil and not caster.Pet:IsNull() then
		caster.Pet:Destroy()
	end
	
	local vec = caster:GetForwardVector():Normalized()*event.offset
	if event.offset ~= nil then
		unit:SetAbsOrigin(unit:GetAbsOrigin()+vec)
	end
	unit:CreatureLevelUp(event.ability:GetLevel()-1)
	caster.Pet = unit
	unit.owner = caster
	--Attachments:AttachProp(unit, "attach_hitloc", "models/items/queenofpain/unchained_tormented_wings/unchained_tormented_wings.vmdl", 1.0)
	--Attachments:AttachProp(unit, "mouth", "models/items/queenofpain/dotapit_s3_abyssal_temptress_head/dotapit_s3_abyssal_temptress_head.vmdl", 1.0)
	
	local ability = unit:GetAbilityByIndex(0)
	if ability and event.ability then
		ability:SetLevel(event.ability:GetLevel())
	end
	ability = unit:GetAbilityByIndex(1)
	if ability and event.ability then
		ability:SetLevel(event.ability:GetLevel())
	end
end

function SummonImpReset(event)
    local caster = event.caster
    caster.impcounter = 1
    for i=1,3 do
        if caster.imps and caster.imps[i] and not caster.imps[i]:IsNull() then
            caster.imps[i]:Destroy()
            caster.imps[i] = nil
        end
    end
    caster.imps = {}
end

function SummonImp(event)
	--local caster = event.caster
	local unit = event.target
	local caster = event.caster

	unit:CreatureLevelUp(event.ability:GetLevel()-1)
	unit.owner = caster

    local health = caster:GetMaxHealth() * 0.2
    unit:SetBaseMaxHealth(health)
    unit:SetMaxHealth(health)                           
    unit:SetHealth(health)
    caster.imps[caster.impcounter] = unit
    caster.impcounter = caster.impcounter + 1
end

function ImpFireballProc(event)
    local target = event.target
    local caster = event.caster
    local ability = caster:GetAbilityByIndex(5)
    for i=1,3 do
        if ability and caster.imps and caster.imps[i] and not caster.imps[i]:IsNull() and caster.imps[i]:IsAlive() then
            ability:ApplyDataDrivenModifier(caster.imps[i], target, event.buff, nil)
        end
    end
end

function EleBalance(event)
	local caster = event.caster
	local target = event.target
	local stackcount = caster:GetModifierStackCount("modifier_elementalfury", caster)
	caster:RemoveModifierByName("modifier_elementalfury")

	--self stun
	local stuntime = 7 - stackcount
	if stuntime > 0 then
		--local damage_table = {}
 		--damage_table.Duration = stuntime*0.75
		--event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_stunned", damage_table)

		local myevent = {}
		myevent.caster = caster
		myevent.target = caster
		myevent.buff = "modifier_stunned"
		myevent.ability = event.ability
		myevent.dur = stuntime*0.75
		ApplyBuff(myevent)

		particle = ParticleManager:CreateParticle("particles/econ/items/zeus/lightning_weapon_fx/zuus_lightning_bolt_castfx_ground2.vpcf", PATTACH_POINT_FOLLOW, caster)
		EmitSoundOn( "DOTA_Item.Mjollnir.Activate", caster)
	end

	event.spelldamagefactor = stackcount*event.spelldamagefactor/7
	event.attributefactor = stackcount*event.attributefactor/7

	if caster:GetTeamNumber()==target:GetTeamNumber() then
		
		local vec1 = caster:GetAbsOrigin()+Vector(0,0,150)
		local vec2 = target:GetAbsOrigin()+Vector(0,0,150)
		local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_earth_spirit/espirit_magnet_arclightning.vpcf", PATTACH_POINT_FOLLOW, target)
		ParticleManager:SetParticleControl(particle, 0, vec2)
		ParticleManager:SetParticleControl(particle, 1, vec1)
		ParticleManager:SetParticleControl(particle, 2, vec2)
		particle = ParticleManager:CreateParticle("particles/units/heroes/hero_undying/undying_fg_heal_impact_body.vpcf", PATTACH_POINT_FOLLOW, target)
		
		EmitSoundOn("DOTA_Item.HealingSalve.Activate", target)

		HealUnit(event)
	else
		event.spelldamagefactor = event.spelldamagefactor / 2
		event.attributefactor = event.attributefactor / 2

		local vec1 = caster:GetAbsOrigin()+Vector(0,0,150)
		local vec2 = target:GetAbsOrigin()+Vector(0,0,150)
		local particle = ParticleManager:CreateParticle("particles/econ/items/razor/razor_punctured_crest/razor_storm_lightning_strike_blade.vpcf", PATTACH_POINT_FOLLOW, target)
		ParticleManager:SetParticleControl(particle, 0, vec2)
		ParticleManager:SetParticleControl(particle, 1, vec1)
		ParticleManager:SetParticleControl(particle, 2, vec2)
		EmitSoundOn( "DOTA_Item.Mjollnir.Activate", target)

		DamageUnit(event)
	end
end

function EleConv(event)
	local caster = event.attacker

	if caster:HasModifier("modifier_elementalfury") then
		local stackcount = caster:GetModifierStackCount("modifier_elementalfury", caster)+1
		if stackcount > 7 then
			stackcount = 7
		end
		caster:SetModifierStackCount("modifier_elementalfury", event.ability, stackcount)
	else
		event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_elementalfury", nil)
		caster:SetModifierStackCount("modifier_elementalfury", event.ability, 1)
	end
end

function Fanatism(event)
	local caster = event.attacker
	local target = event.target

	if caster:HasModifier("modifier_fanatism") then
		local stackcount = caster:GetModifierStackCount("modifier_fanatism", caster)+1
		caster:SetModifierStackCount("modifier_fanatism", event.ability, stackcount)
		if stackcount > 5 then
			local particle = ParticleManager:CreateParticle("particles/econ/items/antimage/antimage_weapon_basher_ti5_gold/am_basher_c_gold.vpcf", PATTACH_POINT_FOLLOW, event.target)
			ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin())
			local vec = (target:GetAbsOrigin()-caster:GetAbsOrigin()):Normalized()
			ParticleManager:SetParticleControlForward(particle, 1, vec)
		end
	end
end

function ShadowDanceFXGladiator(event)
    local caster = event.attacker
    local target = event.target

    if caster.season4_2vs2 and caster.season4_2vs2 == 1 then
        local particle = ParticleManager:CreateParticle("particles/econ/items/antimage/antimage_weapon_basher_ti5/am_basher_c.vpcf", PATTACH_POINT_FOLLOW, event.target)
        ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin())
        local vec = (target:GetAbsOrigin()-caster:GetAbsOrigin()):Normalized()
        ParticleManager:SetParticleControlForward(particle, 1, vec)
    end
end

function TraumFX(event)
	local caster = event.attacker
	local target = event.target
	if event.swap then
		caster = event.caster
		target = event.attacker
	end

	local particle = ParticleManager:CreateParticle("particles/econ/items/antimage/antimage_weapon_basher_ti5/am_basher_c.vpcf", PATTACH_POINT_FOLLOW, target)
	ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin())
	local vec = (target:GetAbsOrigin()-caster:GetAbsOrigin()):Normalized()
	ParticleManager:SetParticleControlForward(particle, 1, vec)
end

function FanatismSetup(event)
	local caster = event.attacker
	caster:SetModifierStackCount("modifier_fanatism", event.ability, 1)
end

function Punishment( event )
	local caster = event.caster
	local target = event.target
	local vec = (caster:GetAbsOrigin()-target:GetAbsOrigin()):Length()
	if vec < 100.0 then
		vec = 100.0
	else
		local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_nyx_assassin/nyx_assassin_mana_burn_bloom.vpcf", PATTACH_POINT_FOLLOW, caster)
	end
	if vec > 600.0 then
		vec = 600.0
	end
	vec = vec - 100
	local power = vec/500.0
	if power > 1.0 then
		power = 1.0
	end
	--mana
	caster:SetMana(caster:GetMana()+event.amount*power)
	--stun
	local damage_table = {}
	if power > 0.9 then
		power = 0.9
	end
	--agha
	if caster:HasModifier("modifier_item_straxe2") then
		power = -0.1
	end
	damage_table.Duration = event.dur*(1-power)
	event.dur = event.dur*(1-power)
	StunTarget(event)
end

function Infested(event)
	local caster = event.caster
	local target = event.target

	local table = {}
	table.Duration = event.dur

	if target:HasModifier("modifier_infested") then
		local stackcount = target:GetModifierStackCount("modifier_infested", caster)+1
		target:RemoveModifierByName("modifier_infested")
		--event.ability:ApplyDataDrivenModifier(caster, target, "modifier_infested", table)

		local myevent = {}
		myevent.caster = caster
		myevent.target = target
		myevent.buff = "modifier_infested"
		myevent.ability = event.ability
		myevent.dur = event.dur
		ApplyBuff(myevent)

		target:SetModifierStackCount("modifier_infested", event.ability, stackcount)
	else
		event.ability:ApplyDataDrivenModifier(caster, target, "modifier_infested", table)

		local myevent = {}
		myevent.caster = caster
		myevent.target = target
		myevent.buff = "modifier_infested"
		myevent.ability = event.ability
		myevent.dur = event.dur
		ApplyBuff(myevent)

		target:SetModifierStackCount("modifier_infested", event.ability, 1)
	end
end

function Rot(event)
	local caster = event.caster
	local target = event.target
	local ability = event.ability
	local pos = event.target_points[1]
	local range = 300

	local enemies = FindUnitsInRadius( caster:GetTeamNumber(), pos, caster, range, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	local table = {}
	table.Duration = event.dur

	if #enemies > 0 then
		for _,enemy in pairs(enemies) do
			if enemy ~= nil then
				if ((enemy:GetUnitLabel()=="hero") or (enemy:GetUnitLabel()=="pet") or (enemy:GetUnitLabel()=="tower")) then
					local myevent = {}
					myevent.caster = caster
					myevent.target = enemy
					myevent.buff = "modifier_rotdk"
					myevent.ability = ability
					myevent.dur = event.dur
					ApplyBuff(myevent)
					--if enemy:GetUnitLabel() == "hero" then
					--	event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_blood_weapon", nil)
					--else
					--	event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_blood_weapon_1", nil)
					--end
				end
			end
		end
	end
end

function WarlockHeal(event)
	local caster = event.caster
	local target = event.target

	if target:HasModifier("modifier_dot1") or target:HasModifier("modifier_dot2") or event.always ~= nil then
		if event.green ~= nil then
			local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_undying/undying_soul_rip_heal_impact_body.vpcf", PATTACH_POINT_FOLLOW, caster)
		else
			local particle = ParticleManager:CreateParticle("particles/econ/events/ti5/blink_dagger_start_smoke_ti5.vpcf", PATTACH_POINT_FOLLOW, caster)
		end
		event.heal = event.heal*caster:GetMaxHealth()/100.0
		event.target = caster
		HealUnit(event)
	end
end

function ArcanePower(event)
	local caster = event.caster

	if caster:HasModifier("modifier_arcanepower") then
		local stackcount = caster:GetModifierStackCount("modifier_arcanepower", caster)+1
		if stackcount > 5 then
			stackcount = 5
		end
		caster:SetModifierStackCount("modifier_arcanepower", event.ability, stackcount)
	else
		caster:GetAbilityByIndex(0):ApplyDataDrivenModifier(caster, caster, "modifier_arcanepower", nil)
		caster:SetModifierStackCount("modifier_arcanepower", event.ability, 1)
	end
end

function NetherBlastAP(event)
    local caster = event.caster
    event.ability = caster:GetAbilityByIndex(0)

    if caster:GetModifierStackCount("modifier_arcaneweak", nil) >= 5 then
        if caster:HasModifier("modifier_arcanepower") then
            local stackcount = caster:GetModifierStackCount("modifier_arcanepower", caster)+1
            if stackcount > 5 then
                stackcount = 5
            end
            caster:SetModifierStackCount("modifier_arcanepower", event.ability, stackcount)
        else
            caster:GetAbilityByIndex(0):ApplyDataDrivenModifier(caster, caster, "modifier_arcanepower", nil)
            caster:SetModifierStackCount("modifier_arcanepower", event.ability, 1)
        end
    end
end

function ArcaneBarrier(event)
	local caster = event.caster

	if caster:HasModifier("modifier_arcanebarrierbuff") then
		local stackcount = caster:GetModifierStackCount("modifier_arcanebarrierbuff", caster)+1
		caster:RemoveModifierByName("modifier_arcanebarrierbuff")
		event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_arcanebarrierbuff", nil)
		caster:SetModifierStackCount("modifier_arcanebarrierbuff", event.ability, stackcount)
	else
		event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_arcanebarrierbuff", nil)
		caster:SetModifierStackCount("modifier_arcanebarrierbuff", event.ability, 1)
	end
end

function ArcaneBarrageFX(event)
    local caster = event.caster
    local target = event.target
    --if caster.season4_3vs3 and caster.season4_3vs3 == 1 then
    --    event.ability:ApplyDataDrivenModifier(caster, target, "modifier_am_gladiator", {Duration = event.dur})
    --else
    event.ability:ApplyDataDrivenModifier(caster, target, "modifier_am", {Duration = event.dur})
    --end
end

function Meteor(event)
	local caster = event.caster
	local target = event.target

	if caster:HasModifier("modifier_arcanepower") or caster:HasModifier("modifier_burning_nether") then
        if caster.season4_3vs3 and caster.season4_3vs3 == 1 then
		    event.ability:ApplyDataDrivenModifier(caster, target, "modifier_meteor_proc_gladiator", nil)
        else
            event.ability:ApplyDataDrivenModifier(caster, target, "modifier_meteor_proc", nil)
        end
        --[[
		local vec = (target:GetAbsOrigin()-caster:GetAbsOrigin()):Normalized()*1080

		local particle
		if event.fireballfx then
			particle = ParticleManager:CreateParticle("particles/fireball_2.vpcf", PATTACH_POINT_FOLLOW, caster)
			vec = (target:GetAbsOrigin()-caster:GetAbsOrigin()):Normalized()*800
		else
			particle = ParticleManager:CreateParticle("particles/fireball_3.vpcf", PATTACH_POINT_FOLLOW, caster)
		end
		ParticleManager:SetParticleControl(particle, 1, vec)
		caster.Meteor = particle
        ]]
	else
		caster:SetMana(caster:GetMana()+45)
	end
end

function MeteorEnd(event)
	local caster = event.caster
    if not caster:HasModifier("modifier_burning_nether") then
        ApplyBuff(event)
    end
	if caster.Meteor ~= nil then
		ParticleManager:DestroyParticle(caster.Meteor,false)
	end
end

function LakeArmorSetup(event)
	local caster = event.caster
	caster.Lake = event.target_points[1]
end

function LakeArmor(event)
	local caster = event.caster
	local vec = (caster.Lake-caster:GetAbsOrigin()):Length()
	if vec > 500.0 then
		caster:RemoveModifierByName("lakearmor")
	end
end

function StormStunCD(event)
	local caster = event.caster
	local abil = caster:GetAbilityByIndex(3)
	if abil:GetLevel() >= 4 then
 		local cd = abil:GetCooldownTimeRemaining()
    	if cd > 0.1 then
    		abil:EndCooldown()
    		abil:StartCooldown(cd-1)
    	end
	end
end

function PalaUltiCD(event)
	local caster = event.caster
	local abil = caster:GetAbilityByIndex(2)
	if abil:GetLevel() >= 4 then
		abil = caster:GetAbilityByIndex(5)
 		local ab = abil:GetCooldownTimeRemaining()
    	if ab > 0.1 then
    		abil:EndCooldown()
    		abil:StartCooldown(ab-0.5)
    	end
	end
end

function DPSMeter(event)
	local target = event.unit
	local damage = event.dmg
	
	if target.dmgtaken == nil then
		target.dmgtaken = damage
		target.dpsmetertime = 1
	else
		target.dmgtaken = target.dmgtaken + damage
	end
end

function DPSMeterTimer(event)
	local target = event.caster
	
	if target.dmgtaken ~= nil then
		target.dpsmetertime = target.dpsmetertime + 1
		CriticalStrikeFX(nil, target, target.dmgtaken/target.dpsmetertime, 0, 0)
	end
end

function Eviscerate(event)
	local caster = event.caster
	local target = event.target
	local cp = caster.ComboPoints

	if cp > 0 then
		caster.ComboPoints = 0
		caster:RemoveModifierByName("modifier_combopoint")
		event.attributefactor = event.attributefactor*cp
		DamageUnit(event)

        local buff = "particles/units/heroes/hero_nyx_assassin/nyx_assassin_vendetta.vpcf"
        if caster.season4_2vs2 and caster.season4_2vs2 == 1 then
            buff = "particles/econ/items/riki/riki_immortal_ti6/riki_immortal_ti6_blinkstrike_stab.vpcf"
        end
		local particle = ParticleManager:CreateParticle(buff, PATTACH_POINT_FOLLOW, target)
		ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin())
		EmitSoundOn("Hero_Riki.Backstab", target)

		local tab = {}
		tab.Duration = 1.0*cp
		--event.ability:ApplyDataDrivenModifier(caster, target, "modifier_slow50", tab)

		local myevent = {}
		myevent.caster = caster
		myevent.target = target
		myevent.buff = "modifier_slow50"
		myevent.ability = event.ability
		myevent.dur = event.dur*cp
		ApplyBuff(myevent)
	end
end

function CheaterStun(event)
    local caster = event.caster
    if caster.cheater then
        event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_phased", {Duration = 10})
        event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_cheater", {Duration = 10})
        for i=0,5 do
            local item = caster:GetItemInSlot(i)
            caster:RemoveItem(item)
        end
        local base = caster.ArenaControl
        if base then
            caster:SetAbsOrigin(base:GetAbsOrigin())
        end
    end
end

function SinisterStrike(event)
    local caster = event.caster
    local target = event.target
    local buff = "particles/units/heroes/hero_nyx_assassin/nyx_assassin_vendetta.vpcf"
    if caster.season4_2vs2 and caster.season4_2vs2 == 1 then
        buff = "particles/econ/items/riki/riki_immortal_ti6/riki_immortal_ti6_blinkstrike_r_stab.vpcf"
    end
    local particle = ParticleManager:CreateParticle(buff, PATTACH_POINT_FOLLOW, target)
    ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin())
end

function Shadowstep(event)
	local caster = event.caster
	local target = event.target
	--local power = (caster:GetAbsOrigin()-target:GetAbsOrigin()):Length()/600
	--local stack = event.maxstack
	--caster.ShadowstepAttacks = 3
	--if power > 1.0 then
	--	power = 1.0
	--end
	--stack = stack*power
	--event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_shadowstep1", nil)
	--caster:SetModifierStackCount("modifier_shadowstep", event.ability, stack)

	local offset = RandomVector(1):Normalized()*80
	offset = Vector(offset[1], offset[2],0)
	caster:SetAbsOrigin(target:GetAbsOrigin()+offset)
	local table = {}
	table.Duration = 0.05
	event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_phased", table)
end

function ShadowstepAttack(event)
	local caster = event.attacker
	if caster.ShadowstepAttacks > 1 then
		caster.ShadowstepAttacks = caster.ShadowstepAttacks - 1
	else
		Timers:CreateTimer(0.1, function()
		    caster:RemoveModifierByName("modifier_shadowstep")
		end)
	end
end

function Blind(event)
	local caster = event.caster
	local target = event.target
    local ability = event.ability
	local duration = event.dur
	local angleDiff = target:GetAngles()[2]-caster:GetAngles()[2]
	if angleDiff < 0.0 then
		angleDiff = -angleDiff
	end

	if (angleDiff <= 90.0 or angleDiff >= 270.0) then
		duration = duration
	else
		duration = duration + 1.0
        DamageUnit(event)
	end
	local table = {}
	table.Duration = duration
	--event.ability:ApplyDataDrivenModifier(caster, target, "modifier_sap2", table)

	local myevent = {}
	myevent.caster = caster
	myevent.target = target
	myevent.buff = "modifier_sap2"
	myevent.ability = ability
	myevent.dur = duration
	ApplyBuff(myevent)
end

function Preparation(event)
	local caster = event.caster
	caster:GetAbilityByIndex(3):EndCooldown()
	caster:GetAbilityByIndex(5):EndCooldown()
end

--function RogueAgiBonus(event)
--	local caster = event.caster
--	if event.percent > 0 then
--		caster:RemoveModifierByName("modifier_rogue_agi_bonus")
--		local agi = caster:GetAgility()*event.percent/100
		--print("stat bonus " .. agi)
--		event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_rogue_agi_bonus", nil)
--		caster:SetModifierStackCount("modifier_rogue_agi_bonus", event.ability, agi)
--	end
--end

function RoguePrimaryBonus(event)
	local caster = event.caster
	if event.percent > 0 then
		caster:RemoveModifierByName("modifier_rogue_primary_bonus")
		local agi = caster:GetPrimaryStatValue()*event.percent/100
		event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_rogue_primary_bonus", nil)
		caster:SetModifierStackCount("modifier_rogue_primary_bonus", event.ability, agi)
	end
end

function AghaStun( event )
	local caster = event.attacker
	local target = event.target

	--agha
	if caster:HasModifier("modifier_item_straxe2") then
		--local tab = {}
		--tab.Duration = 1.5
		--event.ability:ApplyDataDrivenModifier(caster, target, "modifier_stunned", tab)

		--local myevent = {}
		--myevent.caster = caster
		--myevent.target = target
		--myevent.buff = "modifier_stunned"
		--myevent.ability = event.ability
		--myevent.dur = 2
		--ApplyBuff(myevent)
        event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_furycharge_aa_buff", nil)
	end
end

function AxeThrow( event )
	local caster = event.caster
	local target = event.target

	local vec = (caster:GetAbsOrigin()-target:GetAbsOrigin()):Length()
	if vec > 300 then
		event.attributefactor = event.attributefactormax
	end
    event.includeauto = event.attributefactor
    event.attributefactor = 0.0

	DamageUnit(event)
	if caster.AxeThrow ~= nil then
		ParticleManager:DestroyParticle(caster.AxeThrow,false)
	end
end

function AxeThrowAxe(event)
	local caster = event.caster
	local target = event.target

	local vec = target:GetAbsOrigin()+Vector(0,0,95)
	local vec2 = caster:GetAbsOrigin()+Vector(0,0,95)

	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_troll_warlord/troll_warlord_whirling_axe_melee.vpcf", PATTACH_POINT_FOLLOW, caster)
	ParticleManager:SetParticleControl(particle, 0, vec2)
	ParticleManager:SetParticleControl(particle, 1, vec)
	ParticleManager:SetParticleControl(particle, 4, Vector(0.4,0,0))
	caster.AxeThrow = particle
end

function FuryAxeFX(event)
	local caster = event.caster
	local target = event.target
	if event.duration == 0 then
		return
	end

	local vec = target:GetAbsOrigin()+Vector(0,0,95)
	local vec2 = caster:GetAbsOrigin()+Vector(0,0,95)

	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_troll_warlord/troll_warlord_whirling_axe_melee.vpcf", PATTACH_POINT_FOLLOW, caster)
	ParticleManager:SetParticleControl(particle, 0, vec2)
	ParticleManager:SetParticleControl(particle, 1, vec)
	ParticleManager:SetParticleControl(particle, 4, Vector(event.duration,0,0))
end

function FurySlow(event)
	local caster = event.caster
	local target = event.target

	local power = 10*target:GetHealth()/target:GetMaxHealth()
	--event.ability:ApplyDataDrivenModifier(caster, target, "modifier_furyslow", nil)

	local myevent = {}
	myevent.caster = caster
	myevent.target = target
	myevent.buff = "modifier_furyslow"
	myevent.ability = event.ability
	myevent.dur = event.dur
	ApplyBuff(myevent)

	target:SetModifierStackCount("modifier_furyslow", event.ability, power)
end

function FuryAS(event)
	local caster = event.caster

	if caster:HasModifier("modifier_furyas") then
		local stackcount = caster:GetModifierStackCount("modifier_furyas", caster)+1
		if stackcount > event.max then
			stackcount = event.max
		end
		caster:RemoveModifierByName("modifier_furyas")
		event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_furyas", nil)
		caster:SetModifierStackCount("modifier_furyas", event.ability, stackcount)
	else
		event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_furyas", nil)
		caster:SetModifierStackCount("modifier_furyas", event.ability, 1)
	end
end

function BloodArcana(event)
	local caster = event.caster
	local target = event.target

	local vec = (caster:GetAbsOrigin()-target:GetAbsOrigin()):Normalized()
	local vec2 = target:GetAbsOrigin()
	local particle
	if event.mech ~= nil then
		particle = ParticleManager:CreateParticle("particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_crit_impact_dagger_mechanical_arcana.vpcf", PATTACH_POINT_FOLLOW, target)
	else
		particle = ParticleManager:CreateParticle("particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_crit_impact_dagger_arcana.vpcf", PATTACH_POINT_FOLLOW, target)
	end
	ParticleManager:SetParticleControl(particle, 0, vec2)
	ParticleManager:SetParticleControl(particle, 1, vec2)
	ParticleManager:SetParticleControlForward(particle, 1, vec)
	ParticleManager:SetParticleControl(particle, 6, vec2)
	ParticleManager:SetParticleControl(particle, 10, vec2)
end

function HookFX(event)
	local caster = event.caster
	local target = event.target

	local vec = Vector(1000,1000,0)
	--local vec2 = target:GetAbsOrigin()

	local particle = ParticleManager:CreateParticle("particles/econ/items/pudge/pudge_dragonclaw/pudge_meathook_dragonclaw.vpcf", PATTACH_POINT_FOLLOW, caster)

	ParticleManager:SetParticleControlEnt(particle, 0, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
	ParticleManager:SetParticleControl(particle, 1, vec)
	ParticleManager:SetParticleControl(particle, 2, Vector(3500,0,0))
	ParticleManager:SetParticleControl(particle, 3, Vector(0.3,0,0))
	ParticleManager:SetParticleControl(particle, 4, Vector(0.3,0,0))
	ParticleManager:SetParticleControl(particle, 5, Vector(0.3,0,0))
	--ParticleManager:SetParticleControlForward(particle, 1, vec)
	--ParticleManager:SetParticleControl(particle, 6, vec2)
	--ParticleManager:SetParticleControl(particle, 10, vec2)
end

function EarthShield( event )
	local target = event.target
	local caster = event.caster
	if caster.earthtarget ~= nil and not caster.earthtarget:IsNull() then
		caster.earthtarget:RemoveModifierByName("modifier_earth_shield")
	end
	caster.earthtarget = target
	target.earthshieldsource = caster
	caster.earthshieldCD = 0
end

function PrayerShield( event )
	local target = event.target
	local caster = event.caster
	if caster.earthtarget ~= nil and not caster.earthtarget:IsNull() then
		caster.earthtarget:RemoveModifierByName("modifier_prayer_shield")
	end
	caster.earthtarget = target
	target.prayershieldsource = caster
	local tab = {}
	tab.Duration = event.dur
	--event.ability:ApplyDataDrivenModifier(caster, target, "modifier_prayer_shield", tab)
	event.buff = "modifier_prayer_shield"
	ApplyBuff(event)
	target:SetModifierStackCount("modifier_prayer_shield", event.ability, event.stack)
end

function InnerFlame( event )
	local target = event.target
	local caster = event.caster
	local tab = {}
	tab.Duration = event.dur
	local buff = "modifier_inner_str"
	if target:GetPrimaryAttribute() == 1 then
		buff = "modifier_inner_agi"
	elseif target:GetPrimaryAttribute() == 2 then
		buff = "modifier_inner_int"
	end
	event.ability:ApplyDataDrivenModifier(caster, target, buff, tab)
	event.buff = buff
	ApplyBuff(event)
end

function EternalLife( event )
	local target = event.target
	local caster = event.caster
	local tab = {}
	tab.Duration = event.dur
	local buff = "modifier_inner_str"
	if target:GetPrimaryAttribute() == 1 then
		buff = "modifier_inner_agi"
	elseif target:GetPrimaryAttribute() == 2 then
		buff = "modifier_inner_int"
	end
	event.ability:ApplyDataDrivenModifier(caster, target, buff, tab)
	event.buff = buff
	ApplyBuff(event)
end

function EarthShieldHeal( event )
	local target = event.unit
	local caster = target.earthshieldsource
	if caster.earthshieldCD <= 0 then
		caster.earthshieldCD = 3
		event.target = target
		event.caster = caster
		HealUnit(event)
		local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_dazzle/dazzle_shadow_wave_b.vpcf", PATTACH_POINT_FOLLOW, target)
		ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin()+Vector(0,0,0))
		ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin()+Vector(0,0,125))
		Timers:CreateTimer(3.0, function()
		    caster.earthshieldCD = 0
		end)
	end
end

function PrayerShieldHeal( event )
	local target = event.unit
	local caster = target.prayershieldsource
	event.target = target
	event.caster = caster
    local stack = target:GetModifierStackCount("modifier_prayer_shield", nil)
    event.spelldamagefactor = event.spelldamagefactor * (1+0.1*stack)
    event.attributefactor = event.attributefactor * (1+0.1*stack)
	HealUnit(event)
	
	if caster and stack > 1 then
		--find target
		event.range = 900
		event.target = target
		event.caster = caster
        event.onlyhero = true
		local newtarget = MostWoundedTarget(event)
		if newtarget == nil then
			target:RemoveModifierByName("modifier_prayer_shield")
			return
		end
		caster.earthtarget = newtarget
		--apply buff
		newtarget.prayershieldsource = caster
		--local tab = {}
		--tab.Duration = 12
		--event.ability:ApplyDataDrivenModifier(caster, newtarget, "modifier_prayer_shield", tab)

		event.buff = "modifier_prayer_shield"
		event.caster = caster
		event.target = newtarget
		event.dur = 12
		ApplyBuff(event)
		newtarget:SetModifierStackCount("modifier_prayer_shield", event.ability, stack-1)

		local particle = ParticleManager:CreateParticle("particles/dazzle_holy_wave_b.vpcf", PATTACH_POINT_FOLLOW, target)
		ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin()+Vector(0,0,75))
		ParticleManager:SetParticleControl(particle, 1, newtarget:GetAbsOrigin()+Vector(0,0,75))
	end
	target:RemoveModifierByName("modifier_prayer_shield")
end

function resto3(event)
	local caster = event.caster
	local ability = event.ability
	local range = 425
	if caster.meditation ~= nil then
		caster.meditation = caster.meditation + 0.05
	else
		caster.meditation = 1.0
	end

	local enemies = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetAbsOrigin(), caster, range, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	print(#enemies)
	if #enemies > 0 then
		for _,enemy in pairs(enemies) do
			if enemy ~= nil then
				if ((enemy:GetUnitLabel()=="hero") or (enemy:GetUnitLabel()=="pet") or (enemy:GetUnitLabel()=="tower")) then
					local table = {}
					table.caster = caster
					table.target = enemy
					table.ability = ability
					table.attributefactor = event.attributefactor * caster.meditation
					table.spelldamagefactor = event.spelldamagefactor * caster.meditation
					table.heal = 0
					HealUnit(table)
					local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_dazzle/dazzle_shadow_wave_b.vpcf", PATTACH_POINT_FOLLOW, caster)
					ParticleManager:SetParticleControl(particle, 0, caster:GetAbsOrigin()+Vector(0,0,75))
					ParticleManager:SetParticleControl(particle, 1, enemy:GetAbsOrigin()+Vector(0,0,75))
				end
			end
		end
	end
	if caster.meditation >= 1.29 then
		caster.meditation = nil
	end
end

function Massdispel(event)
	local caster = event.caster
	local ability = event.ability
	local range = 300
	local targetpos = event.target_points[1]

	local enemies = FindUnitsInRadius( caster:GetTeamNumber(), targetpos, caster, range, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	if #enemies > 0 then
		for _,enemy in pairs(enemies) do
			if enemy ~= nil then
				if ((enemy:GetUnitLabel()=="hero") or (enemy:GetUnitLabel()=="pet")) then
					event.target = enemy
					event.massdispel = 1
					PurgeUnit(event)
					local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_tidehunter/tidehunter_krakenshell_purge_d.vpcf", PATTACH_POINT_FOLLOW, enemy)
				end
			end
		end
	end
	enemies = FindUnitsInRadius( caster:GetTeamNumber(), targetpos, caster, range, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, 0, false )
	if #enemies > 0 then
		for _,enemy in pairs(enemies) do
			--print(enemy:GetName())
			if enemy ~= nil then
				if ((enemy:GetUnitLabel()=="hero") or (enemy:GetUnitLabel()=="pet")) then
					event.target = enemy
					event.massdispel = 1
					PurgeEnemyUnit(event)
					local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_tidehunter/tidehunter_krakenshell_purge_d.vpcf", PATTACH_POINT_FOLLOW, enemy)
					if event.dur and event.dur > 0 then
						--print("mass root ")
						local myevent = {}
						myevent.caster = caster
						myevent.target = enemy
						myevent.buff = event.buff
						myevent.ability = ability
						myevent.dur = event.dur
						ApplyBuff(myevent)
					end
				end
			end
		end
	end
end

function MostWoundedTarget (event)
	local caster = event.caster
	local target = event.target
	local ability = event.ability
	local range = event.range

    local pets = "pet"
    if event.onlyhero then
        pets = "hero"
    end

	local enemies = FindUnitsInRadius( caster:GetTeamNumber(), target:GetAbsOrigin(), caster, range, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	local hp = 1.2
	local friend = nil
	if #enemies > 0 then
		for _,enemy in pairs(enemies) do
			if enemy ~= nil then
				if ((enemy:GetUnitLabel()=="hero") or (enemy:GetUnitLabel()==pets) or (enemy:GetUnitLabel()=="tower")) and enemy ~= target then
					local hp2 = enemy:GetHealth()/enemy:GetMaxHealth()
					if hp2 < hp then
 						friend = enemy
 						hp = hp2
					end
					
				end
			end
		end
	end
	return friend
end

function HealingWave(event)
	local caster = event.caster
	local target = event.target
	local ability = event.ability
	local range = event.jumpdistance

	local enemies = FindUnitsInRadius( caster:GetTeamNumber(), target:GetAbsOrigin(), caster, range, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	local hp = 1.2
	local friend = nil
	if #enemies > 0 then
		for _,enemy in pairs(enemies) do
			if enemy ~= nil then
				if ((enemy:GetUnitLabel()=="hero") or (enemy:GetUnitLabel()=="pet")) and enemy ~= target then
					local hp2 = enemy:GetHealth()/enemy:GetMaxHealth()
					if hp2 < hp then
 						friend = enemy
 						hp = hp2
					end
				end
			end
		end
	end
	if friend then
        Timers:CreateTimer(0.25, function()
    		event.attributefactor = event.attributefactor*event.healreduction/100
    		event.spelldamagefactor = event.spelldamagefactor*event.healreduction/100
    		event.heal = event.heal * event.healreduction/100
    		event.target = friend
    		local particle = ParticleManager:CreateParticle("particles/dazzle_shadow_wave_green.vpcf", PATTACH_POINT_FOLLOW, target)
            ParticleManager:SetParticleControlEnt(particle, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
    		ParticleManager:SetParticleControlEnt(particle, 1, friend, PATTACH_POINT_FOLLOW, "attach_hitloc", friend:GetAbsOrigin(), true)
			HealUnit(event)
            --3 jumps?
            if event.maxtargets >= 3 then
                enemies = FindUnitsInRadius( caster:GetTeamNumber(), friend:GetAbsOrigin(), caster, range, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
                hp = 1.2
                local friend2 = nil
                if #enemies > 0 then
                    for _,enemy in pairs(enemies) do
                        if enemy ~= nil then
                            if ((enemy:GetUnitLabel()=="hero") or (enemy:GetUnitLabel()=="pet")) and (enemy ~= target) and (enemy ~= friend) then
                                local hp2 = enemy:GetHealth()/enemy:GetMaxHealth()
                                if hp2 < hp then
                                    friend2 = enemy
                                    hp = hp2
                                end
                            end
                        end
                    end
                end
                if friend2 then
                    Timers:CreateTimer(0.5, function()
                        event.attributefactor = event.attributefactor*(event.healreduction/100)*(event.healreduction/100)
                        event.spelldamagefactor = event.spelldamagefactor*(event.healreduction/100)*(event.healreduction/100)
                        event.heal = event.heal * (event.healreduction/100) * (event.healreduction/100)
                        event.target = friend2
                        local particle = ParticleManager:CreateParticle("particles/dazzle_shadow_wave_green.vpcf", PATTACH_POINT_FOLLOW, friend)
                        ParticleManager:SetParticleControlEnt(particle, 0, friend, PATTACH_POINT_FOLLOW, "attach_hitloc", friend:GetAbsOrigin(), true)
                        ParticleManager:SetParticleControlEnt(particle, 1, friend2, PATTACH_POINT_FOLLOW, "attach_hitloc", friend2:GetAbsOrigin(), true)
                        HealUnit(event)
                    end)
                end
            end
		end)
	end
end

function Resto3Sound( event )
	local caster = event.caster
	EmitSoundOn("Hero_WitchDoctor.Voodoo_Restoration.Loop", caster)
end

function Resto3SoundEnd( event )
	local caster = event.caster
	StopSoundEvent("Hero_WitchDoctor.Voodoo_Restoration.Loop", caster)
end

function DragonFX(event)
	local caster = event.caster
	local target = event.target_points[1]

	local vec = (target-caster:GetAbsOrigin()):Normalized()
	local vec2 = target
	local particle = ParticleManager:CreateParticle("particles/econ/items/dragon_knight/dk_immortal_dragon/dragon_knight_dragon_tail_iron_dragon.vpcf", PATTACH_ABSORIGIN, caster)
	ParticleManager:SetParticleControl(particle, 0, vec2)
	ParticleManager:SetParticleControl(particle, 2, vec2)
	ParticleManager:SetParticleControlForward(particle, 0, vec)
	ParticleManager:SetParticleControl(particle, 4, vec2)
	ParticleManager:SetParticleControl(particle, 5, vec2)

	particle = ParticleManager:CreateParticle("particles/econ/items/lina/lina_head_headflame/lina_spell_dragon_slave_headflame_d.vpcf", PATTACH_ABSORIGIN, caster)
	ParticleManager:SetParticleControl(particle, 0, vec2)
	ParticleManager:SetParticleControl(particle, 3, vec2)
	ParticleManager:SetParticleControlForward(particle, 0, vec)
end

function ItemCourage( event )
	local caster = event.caster
	event.target = caster
	PayWithLife(event)
	local particle = ParticleManager:CreateParticle("particles/items_fx/bloodstone_glyph.vpcf", PATTACH_ABSORIGIN, caster)
	ParticleManager:SetParticleControl(particle, 0, caster:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 1, Vector(3,0,0))
	Timers:CreateTimer(3.0, function()
	    HealPercentage(event)
	    particle = ParticleManager:CreateParticle("particles/items_fx/bloodstone_heal.vpcf", PATTACH_ABSORIGIN, caster)
	    particle = ParticleManager:CreateParticle("particles/items_fx/etherial_copycat_trail.vpcf", PATTACH_ABSORIGIN, caster)
	    ParticleManager:SetParticleControl(particle, 1, caster:GetAbsOrigin())
	    EmitSoundOn( "DOTA_Item.UrnOfShadows.Activate", caster)
        if event.invis then
            event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_invisible", {Duration = 5})
        end
	end)
end

function StopChannelMaxRange( event )
	local caster = event.caster
	local target = event.target
	local distance = (caster:GetAbsOrigin()-target:GetAbsOrigin()):Length()
	local max = 850
	if caster:HasModifier("modifier_item_aether_lens") then
		distance = distance - 120
	end
	if event.spellrange then
		max = event.spellrange + 250
	end
	if event.dontbreak and event.dontbreak == 1 then
		max = 99999
	end
	if distance > max or target:HasModifier("modifier_invisible") then
		caster:Stop()
	end
end

function Mindflay( event )
	local caster = event.caster
	local target = event.target
	local ability = event.ability
	if event.ability ~= nil then
		local vec1 = caster:GetAbsOrigin()+Vector(0,0,75)
		local vec2 = caster:GetAbsOrigin()+Vector(0,0,75)
		--local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_puck/puck_dreamcoil_tether.vpcf", PATTACH_ROOTBONE_FOLLOW, target)
		--ParticleManager:SetParticleControl(particle, 0, vec1)
		--ParticleManager:SetParticleControl(particle, 1, vec2)
		--if target:HasModifier("modifier_swd") then
		--ability:ApplyDataDrivenModifier(caster, target, "modifier_slow50", nil)

		local myevent = {}
		myevent.caster = caster
		myevent.target = target
		myevent.buff = "modifier_slow50"
		myevent.ability = ability
		myevent.dur = event.dur
		ApplyBuff(myevent)
		--end
		local distance = (caster:GetAbsOrigin()-target:GetAbsOrigin()):Length()
		if caster:HasModifier("modifier_item_aether_lens") then
			distance = distance - 120
		end
		if distance > 850.0 or target:HasModifier("modifier_invisible") then
			caster:Stop()
		end
	else
		caster:Stop()
		target:RemoveModifierByName("modifier_sh")
	end
end

function DevouringPlague( event )
	local caster = event.caster
	local target = event.target
	local ability = event.ability
    if ability:GetLevel() >= 3 then
        target.devouringsource = caster
    else
        target.devouringsource = nil
    end
	if caster:HasModifier("modifier_shadoworb") then
		event.addstacks = caster:GetModifierStackCount("modifier_shadoworb", nil) + 1
	end
	caster:RemoveModifierByName("modifier_shadoworb")
	ApplyBuffStack(event)
end

function ShadowFear( event )
	local caster = event.caster
	local target = event.target
	local ability = event.ability
	if caster:HasModifier("modifier_shadoworb") then
		event.dur = event.dur * (caster:GetModifierStackCount("modifier_shadoworb", nil) + 1)
	end
	ApplyBuff(event)
end

function HolyForm(event)

	local hero = event.caster
	local abil1 = hero:GetAbilityByIndex(0)
	local abil2 = hero:GetAbilityByIndex(1)
	local abil3 = hero:GetAbilityByIndex(2)

	if abil1:GetAbilityName() == "shadow11" then
		--print("to holy")
		hero:RemoveModifierByName("modifier_shadowstance")
		hero:RemoveModifierByName("modifier_selffxshadow")
		event.ability:ApplyDataDrivenModifier(hero, hero, "modifier_holystance", nil)
		event.ability:ApplyDataDrivenModifier(hero, hero, "modifier_selffx", nil)
		hero.abil1=abil1:GetLevel()
		hero.abil2=abil2:GetLevel()
		hero.abil3=abil3:GetLevel()

  		hero:RemoveAbility(abil1:GetAbilityName())
  		hero:RemoveAbility(abil2:GetAbilityName())
  		hero:RemoveAbility(abil3:GetAbilityName())

  		hero:AddAbility("spholy1")
  		hero:FindAbilityByName("spholy1"):SetLevel(hero:FindAbilityByName("shadow6"):GetLevel())
  		hero:AddAbility("spholy2")
  		hero:FindAbilityByName("spholy2"):SetLevel(hero:FindAbilityByName("shadow6"):GetLevel())
  		hero:AddAbility("spholy3")
  		hero:FindAbilityByName("spholy3"):SetLevel(hero:FindAbilityByName("shadow6"):GetLevel())
  		hero:SetRenderColor(255, 255, 255)
  		
  		EmitSoundOn("dark_seer_dkseer_respawn_04", hero)		
	
  		
  		Timers:CreateTimer(0.1, function()
		    event.ability:EndCooldown()
  			event.ability:StartCooldown(1.0)
		end)
  	else
  		--print("to offensive")
  		hero:RemoveModifierByName("modifier_holystance")
  		hero:RemoveModifierByName("modifier_selffx")
  		event.ability:ApplyDataDrivenModifier(hero, hero, "modifier_shadowstance", nil)
  		event.ability:ApplyDataDrivenModifier(hero, hero, "modifier_selffxshadow", nil)
  		hero:RemoveAbility(abil1:GetAbilityName())
  		hero:AddAbility("shadow11")
  		hero:FindAbilityByName("shadow11"):SetLevel(hero.abil1)

  		hero:RemoveAbility(abil2:GetAbilityName())
  		hero:AddAbility("shadow1")
  		hero:FindAbilityByName("shadow1"):SetLevel(hero.abil2)
  		hero:RemoveAbility(abil3:GetAbilityName())
  		hero:AddAbility("shadow3")
  		hero:FindAbilityByName("shadow3"):SetLevel(hero.abil3)
  		local c = 50
  		--hero:SetRenderColor(c, c, c)
  		EmitSoundOn("dark_seer_dkseer_attack_05", hero)		

  	end
end

function SunForm(event)

	local hero = event.caster
	local abil1 = hero:GetAbilityByIndex(0)
	local abil2 = hero:GetAbilityByIndex(1)
	local abil3 = hero:GetAbilityByIndex(2)
	local abil4 = hero:GetAbilityByIndex(3)
	local abil5 = hero:GetAbilityByIndex(4)

	if abil3:GetAbilityName() == "moon2" then
		--print("to holy")
		hero:RemoveModifierByName("modifier_moonstance")
		event.ability:ApplyDataDrivenModifier(hero, hero, "modifier_sunstance", nil)
		hero.abil1=abil1:GetLevel()
		hero.abil2=abil2:GetLevel()
		hero.abil3=abil3:GetLevel()
		hero.abil4=abil4:GetLevel()
		hero.abil5=abil5:GetLevel()

  		hero:RemoveAbility(abil1:GetAbilityName())
  		hero:RemoveAbility(abil2:GetAbilityName())
  		hero:RemoveAbility(abil3:GetAbilityName())
  		hero:RemoveAbility(abil4:GetAbilityName())
  		hero:RemoveAbility(abil5:GetAbilityName())

  		hero:AddAbility("moon1")
  		hero:FindAbilityByName("moon1"):SetLevel(hero.abil1)
  		hero:AddAbility("RootsDruidMoon")
  		hero:FindAbilityByName("RootsDruidMoon"):SetLevel(hero.abil2)
  		hero:AddAbility("moon12")
  		hero:FindAbilityByName("moon12"):SetLevel(hero.abil3)
  		hero:AddAbility("moon9")
  		hero:FindAbilityByName("moon9"):SetLevel(hero.abil4)
  		hero:AddAbility("moon10")
  		hero:FindAbilityByName("moon10"):SetLevel(hero.abil5)
  		hero:SetRenderColor(255, 255, 255)
  		
  		--EmitSoundOn("vengefulspirit_vng_levelup_03", hero)		
  	else
  		--print("to moon")
  		hero:RemoveModifierByName("modifier_sunstance")
		event.ability:ApplyDataDrivenModifier(hero, hero, "modifier_moonstance", nil)

		hero.abil1=abil1:GetLevel()
		hero.abil2=abil2:GetLevel()
		hero.abil3=abil3:GetLevel()
		hero.abil4=abil4:GetLevel()
		hero.abil5=abil5:GetLevel()

  		hero:RemoveAbility(abil1:GetAbilityName())
  		hero:RemoveAbility(abil2:GetAbilityName())
  		hero:RemoveAbility(abil3:GetAbilityName())
  		hero:RemoveAbility(abil4:GetAbilityName())
  		hero:RemoveAbility(abil5:GetAbilityName())

  		hero:AddAbility("moon11")
  		hero:FindAbilityByName("moon11"):SetLevel(hero.abil1)
  		hero:AddAbility("moon3")
  		hero:FindAbilityByName("moon3"):SetLevel(hero.abil2)
  		hero:AddAbility("moon2")
  		hero:FindAbilityByName("moon2"):SetLevel(hero.abil3)
  		hero:AddAbility("moon4")
  		hero:FindAbilityByName("moon4"):SetLevel(hero.abil4)
  		hero:AddAbility("moon5")
  		hero:FindAbilityByName("moon5"):SetLevel(hero.abil5)
  		
  		--EmitSoundOn("vengefulspirit_vng_levelup_03", hero)	
  		local c = 200
  		hero:SetRenderColor(c, c, c)
  		--EmitSoundOn("vengefulspirit_vng_attack_12", hero)		

  	end
end

function holynova(event)
	local caster = event.caster
	local ability = event.ability
	local range = 400

	local enemies = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetAbsOrigin(), caster, range, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	print(#enemies)
	if #enemies > 0 then
		for _,enemy in pairs(enemies) do
			if enemy ~= nil then
				if enemy:GetUnitLabel()=="hero" then
					local table = {}
					table.caster = caster
					table.target = enemy
					table.ability = ability
					table.attributefactor = event.attributefactor
					table.spelldamagefactor = event.spelldamagefactor
					table.heal = 0
					table.critmanareg = event.critmanareg
					HealUnit(table)
					local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_omniknight/omniknight_purification_light_b.vpcf", PATTACH_POINT_FOLLOW, enemy)
				end
			end
		end
	end

	--event.breakcc = 1
	event.aoe = range
	event.attributefactor = event.attributefactor * event.dmgfactor / 100
	event.spelldamagefactor = event.spelldamagefactor * event.dmgfactor / 100
	event.targeteffect = "holy"
	DamageAOE(event)
end

function HeadArmor( event )
	local caster = event.caster
	--print(event.ability:GetName())
	if caster:GetHealth()/caster:GetMaxHealth() < 0.5 then
		event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_item_headarmor1proc", nil)
	else
		caster:RemoveModifierByName("modifier_item_headarmor1proc")
	end
end

function LastLight( event )
	local caster = event.caster
	--print(event.ability:GetName())
	if caster:GetHealth()/caster:GetMaxHealth() <= 0.5 then
		event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_item_lastlightproc", nil)
	else
		caster:RemoveModifierByName("modifier_item_lastlightproc")
	end
end

function ReduceStealthCooldown( event )
	local caster = event.caster
	--print("called")
	local boo = caster:HasModifier("modifier_item_nightblade") or caster:HasModifier("modifier_item_rogueblades")
	local boo2 = caster:HasModifier("modifier_item_allstats2up")
	if boo or boo2 then
		--print("called")
		local ability = event.ability
		--print(ability:GetCooldownTimeRemaining())
		--Timers:CreateTimer(0.01, function()
			local t = ability:GetCooldownTimeRemaining()-5.0
			if event.percent ~= nil then
				t = ability:GetCooldownTimeRemaining()*event.percent
			end
			ability:EndCooldown()
			ability:StartCooldown(t)
		--end)
	end
end

function Polymorph( event )
	local caster = event.caster
	local target = event.target
	local power = GetCCPower(event)
	local tab = {}
	tab.Duration = event.dur*power
	--event.ability:ApplyDataDrivenModifier(caster, target, "modifier_voodoo_datadriven", tab)
	if target:GetUnitLabel() == "tower" then
 		return
	end

	local myevent = {}
	myevent.caster = caster
	myevent.target = target
	myevent.buff = "modifier_voodoo_datadriven"
	myevent.ability = event.ability
	myevent.dur = event.dur*power
	ApplyBuff(myevent)
end

function SilenceTarget( event )
	local caster = event.caster
	local target = event.target
	local power = 1.0
	if event.curseblade then
		power = GetCCPower(event)
	end
	event.dur = event.dur*power
	--event.ability:ApplyDataDrivenModifier(caster, target, "modifier_silence", tab)
	event.buff = "modifier_silence"
	ApplyBuff(event)
end

function CCTarget( event )
	local caster = event.caster
	local target = event.target
	local power = 1.0
	if event.curseblade then
		power = GetCCPower(event)
	end
	event.dur = event.dur*power
	ApplyBuff(event)
end

function GetCCPower( event )
	local caster = event.caster
	--print("called")
	local power = 1.0
	if caster:HasModifier("modifier_item_curseblade") then
		power = power * 1.25
	end
	return power
end

function CooldownReduction( event ) --also instant ability resets
	local caster = event.caster
	local ability = event.event_ability
	local factor = 1.0
	if not ability then
		return
	end
	local cd = ability:GetCooldown(ability:GetLevel()-1)
	local newcd = cd

	--cooldown item
	local hoodoftime = caster:HasModifier("modifier_item_cooldown")
	if hoodoftime then
		factor = 0.85
	end
    if caster:HasModifier("modifier_item_set_int_cdgloves") then
        factor = factor * 0.92
    end
    if caster:HasModifier("modifier_item_set_int_full") then
        factor = factor * 0.92
    end
    if caster:HasModifier("modifier_item_winterbreeze2") then
        factor = factor * 0.9
    end
    if caster.talents and caster.talents[28] then
        factor = factor * (1 - 0.05 * caster.talents[28])
    end
    if caster.talents and caster.talents[41] > 0 and ability == caster:GetAbilityByIndex(4) then
        factor = factor * (1 - 0.15 * caster.talents[41])
    end
    if caster.talents and caster.talents[19] > 0 and ability == caster:GetAbilityByIndex(2) then
        factor = factor * (1 - 0.08 * caster.talents[19])
    end
    if caster.runeword and caster.runeword[22] > 0 and ability == caster:GetAbilityByIndex(3) then
        factor = factor * (1 - 0.01 * caster.runeword[22])
    end
    if caster.runeword and caster.runeword[23] > 0 and ability == caster:GetAbilityByIndex(5) then
        factor = factor * (1 - 0.01 * caster.runeword[23])
    end
    if caster:HasModifier("modifier_mythic_cd") then
        factor = factor * (100 - caster:GetModifierStackCount("modifier_mythic_cd", nil)) / 100
    end

	--pala divine shield
	local divine = caster:HasModifier("modifier_cd_reduce_50")
	if divine and ability:GetName() == "Holy_Judgement" then
		factor = factor*0.5
	end
    --druid moonburn
    local moonburn = caster:HasModifier("modifier_moonburn_cd")
    if moonburn and ability:GetName() == "moon2" then
        factor = factor*0.25
    end

	-- hunter proc for reset
	local reload = caster:GetModifierStackCount("modifier_lockreload", caster)
	local hunterproc = false
	if reload >= 12 and event.event_ability:GetName() == "wind2" and ability.wasinstant then
		factor = 0.0
		hunterproc = true
	end
	if reload >= 12 and event.event_ability:GetName() == "wind7" and ability.wasinstant then
		caster:RemoveModifierByName("modifier_lockreload")
	end
	local priestcharge = caster:GetModifierStackCount("modifier_light_charge", caster)
	if priestcharge >= 4 and event.event_ability:GetName() == "Light_of_Heaven" and ability.wasinstant then
		caster:RemoveModifierByName("modifier_light_charge")
	end

	-- str aghanim item
	local agha = caster:HasModifier("modifier_item_straxe2")
	if agha and ability:GetName() == "Sword_Storm" then
		newcd = newcd * 0.8
	end
    local agha2 = caster:HasModifier("modifier_item_straxe3")
    if agha2 and ability:GetName() == "Sword_Storm" then
        newcd = newcd * 0.5
    end
    if agha2 and ability:GetName() == "Retri2" then
        newcd = newcd * 0.5
    end

	--apply factor
	newcd = newcd*factor

	if newcd < cd then
		Timers:CreateTimer(0.02, function()
            if ability and not ability:IsNull() then
    			ability:EndCooldown()
    			if newcd > 0.0 then
    				ability:StartCooldown(newcd)
    			end
    			if hunterproc then
    				caster:RemoveModifierByName("modifier_lockreload")
    				ParticleManager:CreateParticle("particles/units/heroes/hero_windrunner/windrunner_loadout_magic.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
    				EmitSoundOn("windrunner_wind_respawn_08", caster)
    			end
            end
		end)
	end
end

function PetEnrageItem (event)
	caster = event.caster
	
	--[[if caster.Pet ~= nil and not caster.Pet:IsNull() then
		event.ability:ApplyDataDrivenModifier(caster, caster.Pet, "modifier_active99", nil)
		particle = ParticleManager:CreateParticle("particles/items2_fx/orchid_pop.vpcf", PATTACH_POINT_FOLLOW, caster.Pet)
		ParticleManager:SetParticleControl(particle, 1, Vector(1,0,0))
		ParticleManager:SetParticleControl(particle, 2, Vector(1,0,0))
	end
	if caster.Pet1 ~= nil and not caster.Pet1:IsNull() then
		event.ability:ApplyDataDrivenModifier(caster, caster.Pet1, "modifier_active99", nil)
		particle = ParticleManager:CreateParticle("particles/items2_fx/orchid_pop.vpcf", PATTACH_POINT_FOLLOW, caster.Pet1)
		ParticleManager:SetParticleControl(particle, 1, Vector(1,0,0))
		ParticleManager:SetParticleControl(particle, 2, Vector(1,0,0))
	end
	if caster.Pet2 ~= nil and not caster.Pet2:IsNull() then
		event.ability:ApplyDataDrivenModifier(caster, caster.Pet2, "modifier_active99", nil)
		particle = ParticleManager:CreateParticle("particles/items2_fx/orchid_pop.vpcf", PATTACH_POINT_FOLLOW, caster.Pet2)
		ParticleManager:SetParticleControl(particle, 1, Vector(1,0,0))
		ParticleManager:SetParticleControl(particle, 2, Vector(1,0,0))
	end]]--
    local heal = 0
	local enemies = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetAbsOrigin(), caster, 99999, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	if #enemies > 0 then
		for _,enemy in pairs(enemies) do
			if enemy:GetPlayerOwnerID() == caster:GetPlayerOwnerID()  then
				--print("yo3")
			end
			if enemy ~= nil and (enemy:GetPlayerOwnerID() == caster:GetPlayerOwnerID() or enemy == caster.Pet or enemy == caster.Pet1 or enemy == caster.Pet2) and enemy:GetUnitLabel() == "pet" and not enemy:IsNull() then
				event.ability:ApplyDataDrivenModifier(caster, enemy, "modifier_active99", nil)
				local particle = ParticleManager:CreateParticle("particles/items2_fx/orchid_pop.vpcf", PATTACH_POINT_FOLLOW, enemy)
				ParticleManager:SetParticleControl(particle, 1, Vector(1,0,0))
				ParticleManager:SetParticleControl(particle, 2, Vector(1,0,0))
                heal = heal + 1
			end
		end
	end
    if event.healpertarget then
        local myevent = {}
        myevent.caster = caster
        myevent.percenthp = event.healpertarget*heal
        myevent.heal = 0.0
        HealUnit(myevent)
    end
end

function BowCrit( event )
	local caster = event.caster
	local oldpos = caster.bowcritpos
	if oldpos ~= nil then
		local distance = (oldpos-caster:GetAbsOrigin()):Length()
		if distance < 25.0 then
			if caster.bowcritcounter ~= nil then
				caster.bowcritcounter = caster.bowcritcounter + 1
			else
				caster.bowcritcounter = 1
			end
			if caster.bowcritcounter > 10 then
				event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_item_bowupgradeproc", nil)
			end
		else
			caster:RemoveModifierByName("modifier_item_bowupgradeproc")
			caster.bowcritcounter = 0
		end
	end
	caster.bowcritpos = caster:GetAbsOrigin()
end

function BowCritSell( event )
	local caster = event.caster
	if caster:HasModifier("modifier_item_bowupgrade") then

	else
  		caster:RemoveModifierByName("modifier_item_bowupgradeproc")
	end
end

function WarriorCharge( event )
	local caster = event.caster
	local target = event.target
	local order = 
		{
			UnitIndex = caster:entindex(),
			OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
			TargetIndex = target:entindex()
		}

	ExecuteOrderFromTable(order)
end

function AttackOrder( event )
	local caster = event.attacker
	local target = event.target
	local order = 
		{
			UnitIndex = caster:entindex(),
			OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
			TargetIndex = target:entindex()
		}
	ExecuteOrderFromTable(order)
end

function StunTarget( event )
	local caster = event.caster
	local target = event.target
	local ability = caster:GetAbilityByIndex(5)
	if ability == nil then
		ability = caster:GetAbilityByIndex(0)
	end
	local dur = event.dur
	if caster:HasModifier("modifier_item_stunitem") then
 		dur = dur + 1.5
	else
		if caster.owner ~= nil and caster.owner:HasModifier("modifier_item_stunitem") then
 			dur = dur + 1.5
 		end
	end
    if caster:HasModifier("modifier_item_stunitem2") then
        dur = event.dur + 2
        local myevent = {}
        myevent.caster = caster
        myevent.percenthp = 15
        myevent.heal = 0.0
        HealUnit(myevent)
        particle = ParticleManager:CreateParticle("particles/econ/items/omniknight/hammer_ti6_immortal/omniknight_purification_immortal_cast.vpcf", PATTACH_POINT_FOLLOW, caster)
        ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin())
    else
        if caster.owner ~= nil and caster.owner:HasModifier("modifier_item_stunitem2") then
            dur = event.dur + 2
            local myevent = {}
            myevent.caster = caster
            myevent.percenthp = 45
            myevent.heal = 0.0
            HealUnit(myevent)
            particle = ParticleManager:CreateParticle("particles/econ/items/omniknight/hammer_ti6_immortal/omniknight_purification_immortal_cast.vpcf", PATTACH_POINT_FOLLOW, caster)
            ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin())
        end
    end
	local tab = {}
	tab.ability = ability
	tab.dur = dur
	tab.caster = caster
	tab.target = target
	tab.buff = "modifier_stunned"
	ApplyBuff(tab)
	--ability:ApplyDataDrivenModifier(caster, target, "modifier_stunned", tab)
end

function DeadlyPoisonProc(event)
	local caster = event.caster
	local chance = event.chance
	if caster:HasModifier("modifier_bladerush") then
  		chance = chance * 2
	end
	--print(chance)
	if math.random(1,100) <= chance then
		ApplyBuffStack(event)
	end
end

function ApplyBuff(event)
	local caster = event.caster
	local target = event.target
	local ability = event.ability
	local duration = event.dur
	local buff = event.buff
	local isBuff = true

	if ability == nil then
		ability = caster:GetAbilityByIndex(0)
	end
	if ability == nil then
		return
	end
	if event.attacker then
		caster = event.attacker
	end
	if event.casterchangeattacked then
		caster = event.unit
		target = event.attacker
	end
	if event.casterchangeattackedaura then
		caster = event.target
		target = event.attacker
	end
	if event.ondealdamagetarget then
		target = event.unit
	end
	if target == nil then
		target = caster
	end
	
	--cycloned targets are imune new buffs
	if target:HasModifier("modifier_cyclone_self") or (not isBuff and target:HasModifier("modifier_invul")) then
 		return
	end

	--silence and interrupt imunity
	if target:HasModifier("modifier_activemage") and buff == "modifier_silence" then
		return
	end

    --silence and stun imunity
    if target:HasModifier("modifier_interruptimune") and (buff == "modifier_silence" or buff == "modifier_stunned") then
        return
    end

	--bladestorm makes cyclone imune
	if target:HasModifier("modifier_axestorm") and buff == "modifier_cyclone_self" then
 		return
	end

	--smokebomb
	if (target:HasModifier("modifier_smokebomb") and not caster:HasModifier("modifier_smokebomb")) or (target:HasModifier("modifier_smokebomb") and not caster:HasModifier("modifier_smokebomb")) then
		--maybe silence briefly
		--return disabled!
	end

	if target:GetTeamNumber() == caster:GetTeamNumber() then --buff

	else --debuff
		isBuff = false
	end


	--adjust time of buff
	if duration and event.cursebladespecial and caster:HasModifier("modifier_item_curseblade") and not isBuff then
    	duration = duration * GetCCPower(event)
	end
	if duration and target:HasModifier("modifier_item_bootshp2") and not isBuff then
    	duration = duration * 0.75
	end
    if duration and not isBuff and (caster:HasModifier("modifier_item_bootscurse") or caster:HasModifier("modifier_item_bootscurse_2")) then
        duration = duration * 1.15
    end
    if duration and not isBuff and caster.talents and caster.talents[6] then
        duration = duration * (1 + caster.talents[6]*0.1)
    end
    --extra buff dur talent
    if duration and isBuff and caster.talents and caster.talents[6] and (buff == "modifier_resto" or buff == "modifier_prayerprotection" or buff == "modifier_pain_supression" or buff == "modifier_hot3" or buff == "modifier_eternallife" or buff == "modifier_regrowth" or buff == "modifier_bloodlust_ele") then
        duration = duration * (1 + caster.talents[6]*0.05)
    end

	--debuff imunity
	if not isBuff and target:HasModifier("modifier_buff_imune") then
		EmitSoundOn("Item.CrimsonGuard.Cast", target)
		local particle = ParticleManager:CreateParticle("particles/items3_fx/lotus_orb_reflect.vpcf", PATTACH_POINT_FOLLOW, target)
		if target.groundingtotemsource and not target.groundingtotemsource:IsNull() then
			particle = ParticleManager:CreateParticle("particles/econ/events/ti5/dagon_ti5.vpcf", PATTACH_POINT_FOLLOW, target)
			ParticleManager:SetParticleControl(particle, 1, target.groundingtotemsource:GetAbsOrigin()+Vector(0,0,80))
			ParticleManager:SetParticleControl(particle, 2, Vector(1,0,0))
		end
 		return
	end

	--shield reflect swap targets
	if (not isBuff) and (target:HasModifier("modifier_shieldreflect") or target:HasModifier("modifier_shieldreflect_charges") or target:HasModifier("modifier_buffreflect") or caster:HasModifier("modifier_dark_mirror")) then
        local reflectcharges = target:GetModifierStackCount("modifier_shieldreflect_charges", nil)
        if reflectcharges > 1 then
            target:SetModifierStackCount("modifier_shieldreflect_charges", ability, reflectcharges-1)
        else
            target:RemoveModifierByName("modifier_shieldreflect_charges")
        end
		--local particle = ParticleManager:CreateParticle("particles/items3_fx/lotus_orb_reflect.vpcf", PATTACH_POINT_FOLLOW, target)
		EmitSoundOn("Item.CrimsonGuard.Cast", target)
		EmitSoundOn("terrorblade_terr_reflection_02", target)
		--particle = ParticleManager:CreateParticle("particles/econ/events/ti5/dagon_ti5.vpcf", PATTACH_POINT_FOLLOW, target)
		--ParticleManager:SetParticleControl(particle, 1, caster:GetAbsOrigin()+Vector(0,0,80))
		--ParticleManager:SetParticleControl(particle, 2, Vector(1,0,0))
        if target:HasModifier("modifier_buffreflect") and duration and duration > 0.1 then
            local myevent = {}
            myevent.caster = caster
            myevent.target = target
            myevent.buff = "modifier_buffreflect"
            myevent.ability = ability
            DecreaseBuffStack(myevent)
        end
		target = caster
	end

    if target:GetUnitName() == "temple_water_boss_4" and (buff == "modifier_worm_skinpoison1" or buff == "modifier_worm_skinpoison2" or buff == "modifier_worm_skinpoison3") then
        return
    end

	if buff == "modifier_stunned" then
		--ParticleManager:CreateParticleForPlayer("particles/screen_blood_3.vpcf", PATTACH_POINT_FOLLOW, target, target:GetOwner())
		ParticleManager:CreateParticleForPlayer("particles/econ/events/killbanners/screen_killbanner_compendium14_firstblood_drips.vpcf", PATTACH_POINT_FOLLOW, caster, caster:GetOwner())
		ParticleManager:CreateParticleForPlayer("particles/econ/events/killbanners/screen_killbanner_compendium14_firstblood_drips.vpcf", PATTACH_POINT_FOLLOW, target, target:GetOwner())

		--prot talent
		local stuntalent = caster:GetAbilityByIndex(5)
	    if stuntalent and stuntalent:GetName() == "Switch_Battle_Stance_Prot" and stuntalent:GetLevel() >= 4 then
	    	if duration then
				duration = duration * 1.25
                local myevent = {}
                myevent.caster = caster
                myevent.percenthp = 2
                myevent.heal = 0.0
                HealUnit(myevent)
                myevent = {}
                myevent.caster = caster
                myevent.target = target
                myevent.counterblow = 200
                myevent.cannotcrit = true
                DamageUnit(myevent)
			end
	    end
	end
	--pve debuff downscaling on bosses for hard CC, non breakable (stun, silence, fear)
	if target:HasModifier("modifier_pvebosssystem") and IsHardCC(buff) and not event.pvedontroot then
        local discount = 0.65
        if COverthrowGameMode.jungledifficulty >= 10.0 then
            discount = 0.3
        end
        if (target.rewardchance and target.rewardchance >= 100) or target.isboss then
	       duration = duration * discount
        end
	end
    if not isBuff and caster:HasModifier("modifier_shapeshifttravel") and caster:GetAbilityByIndex(5):GetLevel() >= 4 then
        duration = duration * 0.7
        --print(duration)
    end

    if event.bearpvedontroot then
        buff = "modifier_bear_slow_pve"
    end

	if buff == "modifier_sap2" then
		ParticleManager:CreateParticleForPlayer("particles/screen_blind_1.vpcf", PATTACH_POINT_FOLLOW, target, target:GetOwner())
	end

	--print(duration)
	if duration and duration == 0 then
		return
	end
	local tab = {}
	tab.Duration = duration
	--print("buff duration " .. duration)
    if (not target:IsNull()) and (not caster:IsNull()) and not ability:IsNull() then
	   ability:ApplyDataDrivenModifier(caster, target, buff, tab)
    end
    if not isBuff then
        OnApplyDebuff(event)
    end
end

function KillUnit( event )
	local caster = event.caster
	caster:Kill(event.ability, event.target)
end

function KillSummon(event)	
	local caster = event.target
	Timers:CreateTimer(0.5, function()
	    if caster ~= nil and not caster:IsNull() then
			caster:Destroy()
		end
	end)
end

function ShadowTentacleHealth(event)
    local caster = event.caster
    local target = event.target
    local health = caster:GetHealth() * 0.2
    target:SetBaseMaxHealth(health)
    target:SetMaxHealth(health)                           
    target:SetHealth(health)
end

function ArmyDead(event)
	local caster = event.caster
	local target = event.target
	caster.Pet = target
	target.owner = caster
	caster.armydeadskeleton = 0
	--local unit = event.victim
	local dista = math.random(200,350)
	local vec = caster:GetAbsOrigin() + caster:GetForwardVector():Normalized()*dista
	target:SetAbsOrigin(vec)

	target:SetRenderColor(190, 190, 255)

	--unit:CreatureLevelUp(event.ability:GetLevel()-1)
	--print(caster:GetName())
	--print(target:GetName())
	--local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_jakiro/jakiro_base_attack_frost_explosion_c.vpcf", PATTACH_POINT_FOLLOW, target)
	local dmg = caster:GetAverageTrueAttackDamage(caster) * event.basedamage / 100
    if event.strength then
        dmg = 0
    end
	local health = caster:GetMaxHealth() * 0.05

	target:SetBaseDamageMin(dmg)
	target:SetBaseDamageMax(dmg)
	target:SetBaseMaxHealth(health)
	target:SetMaxHealth(health)                           
	target:SetHealth(health)
	
	Timers:CreateTimer(0.1, function()
	    local order = 
		{
			UnitIndex = target:entindex(),
			OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
			TargetIndex = caster.armydeadtarget:entindex()
		}
		ExecuteOrderFromTable(order)
	end)
end

function ArmyDeadAttackOrder(event)
    local caster = event.caster
    local target = event.target
    if caster and target and caster.armydeadtarget and not caster.armydeadtarget:IsNull() and caster.armydeadtarget:IsAlive() then
        local order = 
        {
            UnitIndex = target:entindex(),
            OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
            TargetIndex = caster.armydeadtarget:entindex()
        }
        ExecuteOrderFromTable(order)
    end
end

function IronTalon(event)
	local caster = event.caster
	local target = event.target
	local ability = event.ability

	local armor = math.floor(target:GetPhysicalArmorValue()*0.5) + 6
	--ability:ApplyDataDrivenModifier(caster, target, "modifier_armoriron", nil)

	local myevent = {}
	myevent.caster = caster
	myevent.target = target
	myevent.buff = "modifier_armoriron"
	myevent.ability = ability
	myevent.dur = event.dur
	ApplyBuff(myevent)

	target:SetModifierStackCount("modifier_armoriron", ability, armor)
end

function MythicMinusArmor(event)
    local caster = event.attacker
    local target = event.target
    local ability = event.ability
    local armor = caster:GetModifierStackCount("modifier_mythic_minusarmor", nil)
    local myevent = {}
    local playerid = caster:GetPlayerID()
    myevent.caster = event.caster
    myevent.target = target
    myevent.buff = "modifier_piercearmor_m_"..playerid
    myevent.ability = ability
    myevent.dur = 8
    ApplyBuff(myevent)
    target:SetModifierStackCount(myevent.buff, ability, armor)
end

function MythicMinusSpellres(event)
    local caster = event.attacker
    local target = event.unit
    local ability = event.ability
    local armor = caster:GetModifierStackCount("modifier_mythic_minusspellres", nil)
    local myevent = {}
    local playerid = caster:GetPlayerID()
    myevent.caster = event.caster
    myevent.target = target
    myevent.buff = "modifier_mythic_minusres_"..playerid
    myevent.ability = ability
    myevent.dur = 8
    ApplyBuff(myevent)
    target:SetModifierStackCount(myevent.buff, ability, armor)
end

function ArmyDeadTarget(event)
	local caster = event.attacker
	caster.armydeadtarget = event.target
	local target = caster.Pet

	if caster.armydeadskeleton == 0 and not target:IsNull() and target:IsAlive() then
		local ability = event.ability
		local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_drow/drow_frost_arrow_explosion.vpcf", PATTACH_POINT_FOLLOW, target)
		ParticleManager:SetParticleControlEnt(particle, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
		ParticleManager:SetParticleControlEnt(particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
		ParticleManager:SetParticleControlEnt(particle, 2, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
		ParticleManager:SetParticleControlEnt(particle, 3, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
	end
end

function IceSkeleton(event)
	local caster = event.caster
	caster.armydeadskeleton = 1
end

function ShadowCreeperTargetSet(event)
	local caster = event.caster
	caster.creepertarget = event.target
end

function BloodWormTargetSet(event)
	local caster = event.caster
	caster.wormtarget = event.target
end

function BloodWormTargetSet2(event)
	event.target.wormtarget = event.caster.wormtarget
end

function WormTargetAttack(event)
	local caster = event.caster
	local target = event.target

    if target.wormtarget and target.wormtarget:IsNull() then
        return
    end
	
	local order = 
	{
		UnitIndex = target:entindex(),
		OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
		TargetIndex = target.wormtarget:entindex()
	}
	ExecuteOrderFromTable(order)
end

function DancingRune(event)
	local caster = event.caster
	local target = event.target

	if not event.justorder then
		caster.Pet = target
		target.owner = caster
	end

    if caster.creepertarget and caster.creepertarget:IsNull() then
        return
    end
	
	local order = 
	{
		UnitIndex = target:entindex(),
		OrderType = DOTA_UNIT_ORDER_MOVE_TO_TARGET,
		TargetIndex = caster.creepertarget:entindex()
	}
	ExecuteOrderFromTable(order)
end

function DancingRuneDamage(event)
	local caster = event.caster
	local target = caster.creepertarget
	
	if caster.Pet and not caster.Pet:IsNull() and caster.Pet:IsAlive() then
		event.caster = caster.Pet
		event.target = target
		event.damage = event.dmg * event.sworddmg / 100
		local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_ogre_magi/ogre_magi_bloodlust_buff_circle.vpcf", PATTACH_POINT_FOLLOW, event.caster)
		particle = ParticleManager:CreateParticle("particles/units/heroes/hero_centaur/centaur_double_edge_bloodspray_src.vpcf", PATTACH_POINT_FOLLOW, event.caster)
		ParticleManager:SetParticleControl(particle, 4, target:GetAbsOrigin()+Vector(0,0,75))
		ParticleManager:SetParticleControl(particle, 5, event.caster:GetAbsOrigin()+Vector(0,0,75))
		event.cannotcrit = 1
		DamageUnit(event)
	end
end

function BloodHitFX(event)
	local caster = event.caster
	local target = event.unit
    if not target then
        target = event.target
    end
	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_centaur/centaur_double_edge_bloodspray_src.vpcf", PATTACH_POINT_FOLLOW, caster)
	ParticleManager:SetParticleControl(particle, 4, target:GetAbsOrigin()+Vector(0,0,75))
	ParticleManager:SetParticleControl(particle, 5, caster:GetAbsOrigin()+Vector(0,0,75))
end

function TrapGrizzlyBear(event)
	local caster = event.caster
	local ability = event.ability
	if caster:HasModifier("modifier_item_beastmaster") or caster:HasModifier("modifier_item_beastmaster2") then
		ability:ApplyDataDrivenModifier(caster, event.target, "grizzly_summon_trap", nil)
	end
end

function BeastmasterWolfSummon(event)
	local caster = event.attacker
	local ability = event.ability
	local heroName = caster:GetUnitName()
	if heroName == "npc_dota_hero_drow_ranger" or heroName == "npc_dota_hero_mirana" then
		ability:ApplyDataDrivenModifier(caster, event.target, "wolf_summon_proc", nil)
	end
end

function GhostWolfSummon(event)
	local caster = event.caster
	if not (caster:HasModifier("modifier_item_beastmaster") or caster:HasModifier("modifier_item_beastmaster2")) then
 		return
	end
	local ability = event.ability
	ability:ApplyDataDrivenModifier(caster, caster, "ghostwolf_summon", nil)
end

function AshbringerProc(event)
	local caster = event.caster
	local target = event.unit
    local dist = (caster:GetAbsOrigin() - target:GetAbsOrigin()):Length()
	if caster:HasModifier("modifier_innercd_ashbringer") or dist >= 2500 or caster:HasModifier("modifier_invisible") then
 		return
	end
	local ability = event.ability
	ability:ApplyDataDrivenModifier(caster, target, "modifier_item_fireball_proc", nil)
    if caster:HasModifier("modifier_active6_self") and math.random(1,100) <= 20 then
        Timers:CreateTimer(0.25, function()
            ability:ApplyDataDrivenModifier(caster, target, "modifier_item_fireball_proc", nil)
        end)
    end
	Timers:CreateTimer(0.05, function()
	    ability:ApplyDataDrivenModifier(caster, caster, "modifier_innercd_ashbringer", nil)
	end)
end

function ItemBuffApply(event)
    local caster = event.caster
    local target = event.target
    local ability = event.ability
    if event.ondealdamage then
        target = event.unit
    end
    local dist = (caster:GetAbsOrigin() - target:GetAbsOrigin()):Length()
    if dist >= 2500 then
        return
    end
    if event.blastercd then
        if caster:HasModifier("modifier_blaster_cd") or caster:HasModifier("modifier_invisible") then
            return
        else
            event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_blaster_cd", nil)
        end
    end
    if event.daggercd then
        if caster:HasModifier("modifier_dagger_cd") or caster:HasModifier("modifier_invisible") then
            return
        else
            event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_dagger_cd", nil)
        end
    end
    ability:ApplyDataDrivenModifier(caster, target, event.buff, nil)
end

function FaceTarget(event)
	local vec = event.caster:GetAbsOrigin()-event.target:GetAbsOrigin()
	--event.target:SetForwardVector(vec:Normalized())
	--event.target:
	local target = event.target
	local caster = event.caster

	particle = ParticleManager:CreateParticle("particles/frost_breath.vpcf", PATTACH_POINT_FOLLOW, target)
	ParticleManager:SetParticleControl(particle, 1, vec)
	--[[
	local order = 
	{
		UnitIndex = target:entindex(),
		OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
		TargetIndex = caster:entindex()
	}
	ExecuteOrderFromTable(order)
	
	Timers:CreateTimer(0.11, function()
	    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_queenofpain/queen_sonic_wave_streak.vpcf", PATTACH_POINT_FOLLOW, target)
	    particle = ParticleManager:CreateParticle("particles/econ/courier/courier_wyvern_hatchling/courier_wyvern_anim_icebreath.vpcf", PATTACH_POINT_FOLLOW, target)
	    ParticleManager:SetParticleControlEnt(particle, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
	    target:Stop()
	end)
	
	--ParticleManager:SetParticleControlEnt(particle, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
	--ParticleManager:SetParticleControlEnt(particle, 1, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), true)
	--ParticleManager:SetParticleControl(particle, 2, Vector(800,0,0))
	]]
end

function ChainsIce(event)
	local caster = event.caster
	local target = event.target
	local ability = event.ability

	caster.icechains1 = target

	local enemies = FindUnitsInRadius( caster:GetTeamNumber(), target:GetAbsOrigin(), caster, 400, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	--print("chainlight enemies")
	--print(#enemies)
	local distance = 10000.0
	local closesttarget = nil
	if #enemies > 0 then
		for _,enemy in pairs(enemies) do
			if enemy ~= nil and enemy ~= target and enemy:GetUnitLabel()=="hero" then

				local tempdistance = (enemy:GetAbsOrigin()-target:GetAbsOrigin()):Length()
				if tempdistance < distance then
					closesttarget = enemy
					distance = tempdistance
				end
			end
		end
	end

	if closesttarget ~= nil then
		caster.icechains2 = closesttarget
		--ability:ApplyDataDrivenModifier(caster, closesttarget, "modifier_frostchains", nil)

		local myevent = {}
		myevent.caster = caster
		myevent.target = closesttarget
		myevent.buff = "modifier_frostchains"
		myevent.ability = ability
		myevent.dur = event.dur
		ApplyBuff(myevent)

		local particle = ParticleManager:CreateParticle("particles/rattletrap_hookshot_self.vpcf", PATTACH_POINT_FOLLOW, target)
		ParticleManager:SetParticleControlEnt(particle, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
		ParticleManager:SetParticleControlEnt(particle, 1, closesttarget, PATTACH_POINT_FOLLOW, "attach_hitloc", closesttarget:GetAbsOrigin(), true)
		ParticleManager:SetParticleControl(particle, 2, Vector(500,0,0))
		ParticleManager:SetParticleControl(particle, 3, Vector(event.dur,0,0))

		local particle2 = ParticleManager:CreateParticle("particles/rattletrap_hookshot_self.vpcf", PATTACH_POINT_FOLLOW, target)
		ParticleManager:SetParticleControlEnt(particle2, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin()+Vector(0,0,50), true)
		ParticleManager:SetParticleControlEnt(particle2, 1, closesttarget, PATTACH_POINT_FOLLOW, "attach_hitloc", closesttarget:GetAbsOrigin()+Vector(0,0,50), true)
		ParticleManager:SetParticleControl(particle2, 2, Vector(500,0,0))
		ParticleManager:SetParticleControl(particle2, 3, Vector(event.dur,0,0))

		caster.chainsiceparticle = particle
		caster.chainsiceparticle2 = particle2

		EmitSoundOn("Hero_Rattletrap.Hookshot.Fire", target)
	else
		caster.icechains2 = nil
		caster.icechains1 = nil
	end
end

function ChainsIceDistance(event)
	local caster = event.caster
	local target1 = caster.icechains1
	local target2 = caster.icechains2

	if target1 ~= nil and not target1:IsNull() and target2 ~= nil and not target2:IsNull() then
		local distance = (target1:GetAbsOrigin()-target2:GetAbsOrigin()):Length()
		if distance > 600.0 then
			local tab = {}
			tab.Duration = event.dur
			--event.ability:ApplyDataDrivenModifier(caster, target1, "modifier_stunned", tab)
			--event.ability:ApplyDataDrivenModifier(caster, target2, "modifier_stunned", tab)

			local myevent = {}
			myevent.caster = caster
			myevent.target = target1
			myevent.buff = "modifier_stunned"
			myevent.ability = event.ability
			myevent.dur = event.dur
			ApplyBuff(myevent)

			local myevent = {}
			myevent.caster = caster
			myevent.target = target2
			myevent.buff = "modifier_stunned"
			myevent.ability = event.ability
			myevent.dur = event.dur
			ApplyBuff(myevent)

			target1:RemoveModifierByName("modifier_frostchains")
			target2:RemoveModifierByName("modifier_frostchains")
			ParticleManager:DestroyParticle(caster.chainsiceparticle,true)
			ParticleManager:DestroyParticle(caster.chainsiceparticle2,true)

			local particle = ParticleManager:CreateParticle("particles/econ/items/crystal_maiden/crystal_maiden_cowl_of_ice/maiden_crystal_nova_i_cowlofice.vpcf", PATTACH_POINT_FOLLOW, target1)
			ParticleManager:SetParticleControlEnt(particle, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target1:GetAbsOrigin(), true)
			particle = ParticleManager:CreateParticle("particles/econ/items/crystal_maiden/crystal_maiden_cowl_of_ice/maiden_crystal_nova_i_cowlofice.vpcf", PATTACH_POINT_FOLLOW, target2)
			ParticleManager:SetParticleControlEnt(particle, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target2:GetAbsOrigin(), true)

			EmitSoundOn("Hero_Lich.ChainFrostImpact.Hero", target1)
		end
	end
end

function VoodooHex( event )
	local heroName = event.caster:GetUnitName()
	if heroName == "npc_dota_hero_bloodseeker" or heroName == "npc_dota_hero_shadow_shaman" or heroName == "npc_dota_hero_witch_doctor" or heroName == "npc_dota_hero_disruptor" or COverthrowGameMode.junglemode then
		--local tab = {}
		--tab.Duration = event.dur
		--event.ability:ApplyDataDrivenModifier(event.caster, event.target, "modifier_voodoo_datadriven", nil)

		if event.target:GetUnitLabel() == "tower" then
	 		return
		end

		local myevent = {}
		myevent.caster = event.caster
		myevent.target = event.target
		myevent.buff = "modifier_voodoo_datadriven"
		myevent.ability = event.ability
		myevent.dur = event.dur
		ApplyBuff(myevent)
	end
end

function PaladinWrath( event )
	local heroName = event.caster:GetUnitName()
	if heroName == "npc_dota_hero_omniknight" or heroName == "npc_dota_hero_legion_commander" or heroName == "npc_dota_hero_phantom_lancer" or heroName == "npc_dota_hero_chen" or COverthrowGameMode.junglemode then
		--local tab = {}
		--tab.Duration = event.dur
		--event.ability:ApplyDataDrivenModifier(event.caster, event.target, "modifier_activepaladin", nil)

		local myevent = {}
		myevent.caster = event.caster
		myevent.target = event.target
		myevent.buff = "modifier_activepaladin"
		myevent.ability = event.ability
		myevent.dur = event.dur
		ApplyBuff(myevent)

		local particle = ParticleManager:CreateParticle("particles/chen_holy_persuasion_sparks_holy.vpcf", PATTACH_POINT_FOLLOW, event.target)
		
	else
		event.ability:EndCooldown()
	end
end

function DruidGloves( event )
	local heroName = event.caster:GetUnitName()
	if heroName == "npc_dota_hero_furion" or heroName == "npc_dota_hero_dazzle" or heroName == "npc_dota_hero_vengefulspirit" or COverthrowGameMode.junglemode then
		--local tab = {}
		--tab.Duration = event.dur
		--event.ability:ApplyDataDrivenModifier(event.caster, event.target, "modifier_activedruid", nil)

		local myevent = {}
		myevent.caster = event.caster
		myevent.target = event.target
		myevent.buff = "modifier_activedruid"
		myevent.ability = event.ability
		myevent.dur = event.dur
		ApplyBuff(myevent)
	end
end

function DHGloves( event )
    local heroName = event.caster:GetUnitName()
    if heroName == "npc_dota_hero_antimage" or COverthrowGameMode.junglemode then
        ApplyBuff(event)
    end
end

function RogueGloves( event )
	local heroName = event.caster:GetUnitName()
	local target = event.target
	if heroName == "npc_dota_hero_riki" or heroName == "npc_dota_hero_phantom_assassin" or heroName == "npc_dota_hero_bounty_hunter" or COverthrowGameMode.junglemode then
		--local tab = {}
		--tab.Duration = event.dur
		local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_viper/viper_poison_attack_explosion.vpcf", PATTACH_POINT_FOLLOW, event.target)
		--ParticleManager:SetParticleControl(particle, 0, event.target:GetAbsOrigin())
		--ParticleManager:SetParticleControl(particle, 1, event.target:GetAbsOrigin())
		ParticleManager:SetParticleControlEnt(particle, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
		ParticleManager:SetParticleControlEnt(particle, 3, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
		--event.ability:ApplyDataDrivenModifier(event.caster, event.target, "modifier_healdebuff", nil)

		local myevent = {}
		myevent.caster = event.caster
		myevent.target = event.target
		myevent.buff = "modifier_healdebuff"
		myevent.ability = event.ability
		myevent.dur = event.dur
		ApplyBuff(myevent)

		event.spelldamagefactor = 0.0
		DamageUnit(event)
	end
end

function HunterGloves( event )
	local heroName = event.caster:GetUnitName()
	if heroName == "npc_dota_hero_drow_ranger" or heroName == "npc_dota_hero_sniper" or heroName == "npc_dota_hero_windrunner" or heroName == "npc_dota_hero_mirana" or COverthrowGameMode.junglemode then
		--local tab = {}
		--tab.Duration = event.dur
		event.ability:ApplyDataDrivenModifier(event.caster, event.caster, "modifier_activehunter", nil)

	end
end

function RemoveAllPolymorphs( event )
	local target = event.target
	target:RemoveModifierByName("modifier_voodoo_datadriven")
end

function PriestGloves( event )
	local heroName = event.caster:GetUnitName()
	if heroName == "npc_dota_hero_silencer" or heroName == "npc_dota_hero_dark_seer" or heroName == "npc_dota_hero_oracle" or COverthrowGameMode.junglemode then
		--local tab = {}
		--tab.Duration = event.dur
		event.ability:ApplyDataDrivenModifier(event.caster, event.caster, "modifier_activepriest", nil)
	end
end

function WarriorGloves( event )
	local caster = event.caster
	local pos = caster:GetAbsOrigin()
	local heroName = event.caster:GetUnitName()
	if heroName == "npc_dota_hero_axe" or heroName == "npc_dota_hero_beastmaster" or heroName == "npc_dota_hero_dragon_knight" or COverthrowGameMode.junglemode then
		event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_activewarriorrage", nil)
		local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_axe/axe_beserkers_call_owner_b.vpcf", PATTACH_POINT_FOLLOW, caster)
		local enemies = FindUnitsInRadius( caster:GetTeamNumber(), pos, caster, 900, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
		if #enemies > 0 then
			for _,enemy in pairs(enemies) do
				if enemy ~= nil and (enemy:GetUnitLabel()=="hero") then
					--event.ability:ApplyDataDrivenModifier(caster, enemy, "modifier_activewarrior", nil)

					local myevent = {}
					myevent.caster = caster
					myevent.target = enemy
					myevent.buff = "modifier_activewarrior"
					myevent.ability = event.ability
					myevent.dur = event.dur
					ApplyBuff(myevent)
				end
			end
		end	
	end
end

function DKGloves( event )
	local heroName = event.caster:GetUnitName()
	if heroName == "npc_dota_hero_skeleton_king" or heroName == "npc_dota_hero_sven" or heroName == "npc_dota_hero_pudge" or heroName == "npc_dota_hero_abaddon" or COverthrowGameMode.junglemode then
		local ability = event.caster:GetAbilityByIndex(5)
		if ability ~= nil then
			ability:EndCooldown()
		end
	end
end

function DKGlovesApplyBuff( event )
    local heroName = event.caster:GetUnitName()
    if heroName == "npc_dota_hero_skeleton_king" or heroName == "npc_dota_hero_sven" or heroName == "npc_dota_hero_pudge" or heroName == "npc_dota_hero_abaddon" or COverthrowGameMode.junglemode then
        ApplyBuff(event)
    end
end

function DKGlovesDamageUnit( event )
    local heroName = event.caster:GetUnitName()
    if heroName == "npc_dota_hero_skeleton_king" or heroName == "npc_dota_hero_sven" or heroName == "npc_dota_hero_pudge" or heroName == "npc_dota_hero_abaddon" or COverthrowGameMode.junglemode then
        DamageUnit(event)
    end
end

function MageGloves( event )
	local caster = event.caster
	local heroName = event.caster:GetUnitName()
	if true or heroName == "npc_dota_hero_lina" or heroName == "npc_dota_hero_crystal_maiden" or heroName == "npc_dota_hero_invoker" or COverthrowGameMode.junglemode then
		event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_activemage", nil)
		local particle = ParticleManager:CreateParticle("particles/econ/items/crystal_maiden/crystal_maiden_cowl_of_ice/maiden_crystal_nova_i_cowlofice.vpcf", PATTACH_POINT_FOLLOW, caster)
		ParticleManager:SetParticleControlEnt(particle, 0, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), true)
	end
end

function MageGloves2( event )
	local caster = event.caster
	local heroName = event.caster:GetUnitName()
	if heroName == "npc_dota_hero_lina" or heroName == "npc_dota_hero_crystal_maiden" or heroName == "npc_dota_hero_invoker" or COverthrowGameMode.junglemode then
		event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_evocation", nil)
		local particle = ParticleManager:CreateParticle("particles/econ/items/abaddon/abaddon_alliance/abaddon_death_coil_explosion_alliance_sparks.vpcf", PATTACH_POINT_FOLLOW, caster)
		ParticleManager:SetParticleControl(particle, 3, caster:GetAbsOrigin())
		EmitSoundOn("Item.MoonShard.Consume", caster)
	end
end

function ReduceCooldown( event )
	local caster = event.caster
	if event.amount <= 0 then
		return
	end
	if event.onauto then
		caster = event.attacker
	end
    if event.buffcondition and not caster:HasModifier(event.buffcondition) then
        return
    end
	if caster ~= nil then
		local ability = event.ability
        if event.chooseability then
            ability = caster:GetAbilityByIndex(event.chooseability)
        end
		if ability ~= nil then
            if event.onself and event.caster ~= event.target then
                return
            end
 			local cd = ability:GetCooldownTimeRemaining()
 			if cd > 0.1 then
                if not event.delaycdreduce then
 				   ability:EndCooldown()
 				   ability:StartCooldown(cd - event.amount)
                else
                    Timers:CreateTimer(event.delaycdreduce, function()
                        ability:EndCooldown()
                        ability:StartCooldown(cd - event.amount)
                    end)
                end
 			end
		end
	end
end

function StartCooldownPVE( event )
	event.ability:EndCooldown()
	event.ability:StartCooldown(event.ability:GetCooldown(1))
end

function WarlockGloves( event )
	local caster = event.caster
	local heroName = caster:GetUnitName()

	if heroName == "npc_dota_hero_warlock" or COverthrowGameMode.junglemode then
		--caster.originalcastpoint = 2.0
		--caster.originalcastpointabil = 4
		--caster:GetAbilityByIndex(4):SetOverrideCastPoint(0.2)
		event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_activewarlock", nil)
	end

	if heroName == "npc_dota_hero_pugna" then
		--caster.originalcastpoint = 2.0
		--caster.originalcastpointabil = 0
		--caster:GetAbilityByIndex(0):SetOverrideCastPoint(0.2)
		event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_activewarlock", nil)
	end
end

--[[function ResetCastpoint( event )
	local caster = event.caster
	caster:GetAbilityByIndex(caster.originalcastpointabil):SetOverrideCastPoint(caster.originalcastpoint)
end]]

function DemonWall( event )
	local target = event.caster
	local ability = event.ability
	if target:HasModifier("modifier_item_shield3up_buff") then
		local stackcount = target:GetModifierStackCount("modifier_item_shield3up_buff", target)+1
		if stackcount > 50 then
			stackcount = 50
		end
		--target:RemoveModifierByName("modifier_item_shield3up_buff")
		ability:ApplyDataDrivenModifier(target, target, "modifier_item_shield3up_buff", nil)
		target:SetModifierStackCount("modifier_item_shield3up_buff", ability, stackcount)
		--target:Duration
	else
		ability:ApplyDataDrivenModifier(target, target, "modifier_item_shield3up_buff", nil)
		target:SetModifierStackCount("modifier_item_shield3up_buff", ability, 1)
	end
end

function FlameFury( event )
	local target = event.caster
	local ability = target:FindAbilityByName("combat_system")
	if not ability then
		return
	end
	if target:HasModifier("modifier_item_flamefury_buff") then
		local stackcount = target:GetModifierStackCount("modifier_item_flamefury_buff", target)+1
		if stackcount > 10 then
			stackcount = 10
		end
		--target:RemoveModifierByName("modifier_item_shield3up_buff")
		ability:ApplyDataDrivenModifier(target, target, "modifier_item_flamefury_buff", nil)
		target:SetModifierStackCount("modifier_item_flamefury_buff", ability, stackcount)
		--target:Duration
	else
		ability:ApplyDataDrivenModifier(target, target, "modifier_item_flamefury_buff", nil)
		target:SetModifierStackCount("modifier_item_flamefury_buff", ability, 1)
	end
end

function MythicAACrit( event )
    local target = event.attacker
    local ability = event.ability
    local stackcount = target:GetModifierStackCount("modifier_mythic_aacrit", nil)
    if math.random(1,100) <= stackcount then
        ability:ApplyDataDrivenModifier(target, target, "crit6", nil)
    end
end

function TalentAACrit( event )
    local target = event.attacker
    local ability = event.ability
    local stackcount = target:GetModifierStackCount("modifier_talent_crit", nil) * 4
    if math.random(1,100) <= stackcount then
        ability:ApplyDataDrivenModifier(target, target, "crit7", nil)
    end
end

function Sharpeye( event )
	local target = event.attacker
	local ability = event.ability
	if target:HasModifier("modifier_item_sharpeye_buff") then
		local stackcount = target:GetModifierStackCount("modifier_item_sharpeye_buff", target)+1
		if stackcount > 40 then
			stackcount = 40
		end
		--target:RemoveModifierByName("modifier_item_shield3up_buff")
		ability:ApplyDataDrivenModifier(target, target, "modifier_item_sharpeye_buff", nil)
		target:SetModifierStackCount("modifier_item_sharpeye_buff", ability, stackcount)
		--target:Duration
	else
		ability:ApplyDataDrivenModifier(target, target, "modifier_item_sharpeye_buff", nil)
		target:SetModifierStackCount("modifier_item_sharpeye_buff", ability, 1)
	end
end

function Disarm( event )
	local target = event.target
	local caster = event.caster
	local name = target:GetName()
	if not target:IsRangedAttacker() or name == "npc_dota_hero_drow_ranger" or name == "npc_dota_hero_sniper" or name == "npc_dota_hero_windrunner" or name == "npc_dota_hero_mirana" then
		--stop on dazzle
		if name == "npc_dota_hero_dazzle" and not target:HasModifier("modifier_catform") then
			return
		end
		local tab = {}
		tab.Duration = event.dur
		--event.ability:ApplyDataDrivenModifier(caster, target, "modifier_heavens_halberd_debuff", tab)
		--event.ability:ApplyDataDrivenModifier(caster, target, "modifier_silence", tab)

		local myevent = {}
		myevent.caster = caster
		myevent.target = target
		myevent.buff = "modifier_heavens_halberd_debuff"
		myevent.ability = event.ability
		myevent.dur = event.dur
		ApplyBuff(myevent)

		local myevent = {}
		myevent.caster = caster
		myevent.target = target
		myevent.buff = "modifier_silence"
		myevent.ability = event.ability
		myevent.dur = event.dur
		ApplyBuff(myevent)
	end
end

function SetBuffStack( event )
    local caster = event.caster
    local amount = 1
    local buff = event.buff
    local ability = event.ability
    if event.addstacks then
        amount = event.addstacks
    end
    local stackcount = caster:GetModifierStackCount(buff, nil)+amount
    caster:SetModifierStackCount(buff, ability, stackcount)
end

function ApplyBuffStack( event )
	local target = event.attacker
	local amount = 1
	if event.notself then
		target = event.target
	end
    if event.ondealdamagetarget then
        target = event.unit
    end
	if event.self then
		target = event.caster
	end
	local caster = event.caster
	if target == nil then
		target = event.target
		--print("1")
		--print(target:GetUnitName())
	end
	if target == nil then
		target = event.caster
		--print("2")
	end
	if target == nil then
		return
	end
	if caster == nil then
		return
	end
    
	if event.addstacks then
		amount = event.addstacks
	end
	if event.resetplague then
		target:RemoveModifierByName("modifier_slowstack10")
	end
	local buff = event.buff
	local max = event.max
	local ability = event.ability
	if event.threshold and target:GetModifierStackCount(buff, nil) >= event.threshold then
		return
	end
	if target:HasModifier(buff) then
		local stackcount = target:GetModifierStackCount(buff, nil)+amount
		if max and stackcount > max then
			stackcount = max
		end

        --pve tank stacks
        if event.pveonstacklimit and stackcount == max then
            event.ability:ApplyDataDrivenModifier(caster, target, "modifier_piercearmor", {Duration = 8})
        end
		--target:RemoveModifierByName("modifier_item_shield3up_buff")
		--ability:ApplyDataDrivenModifier(caster, target, buff, nil)
		event.caster = caster
		event.target = target
		event.buff = buff
        if event.alwaysapply then
            event.ability:ApplyDataDrivenModifier(event.caster, event.target, event.buff, {Duration = event.dur})
        else
		    ApplyBuff(event)
        end
		target:SetModifierStackCount(buff, ability, stackcount)
		--target:Duration
	else
		--print("run")
		--ability:ApplyDataDrivenModifier(caster, target, buff, nil)
		event.caster = caster
		event.target = target
		event.buff = buff
		if event.alwaysapply then
            event.ability:ApplyDataDrivenModifier(event.caster, event.target, event.buff, {Duration = event.dur})
        else
            ApplyBuff(event)
        end
		target:SetModifierStackCount(buff, ability, amount)
	end
end

function StrikeOfVengeance( event )
    local caster = event.caster
    local dmg = event.dmg
    if dmg > 0 and event.on and event.on == 1 then
        if caster.lastdamagetaken and caster.lastdamagetaken > dmg then
            return
        end
        local buff = "modifier_strikeofvengeance"
        local ability = event.ability
        caster:RemoveModifierByName(buff)
        ability:ApplyDataDrivenModifier(caster, caster, buff, {Duration = -1})
        caster:SetModifierStackCount(buff, ability, dmg)
        caster.lastdamagetaken = dmg
    end
end

function StrikeOfVengeance2( event )
    local caster = event.caster
    --local dmg = event.dmg
    if event.on and event.on == 1 then
        event.buff = "modifier_strikeofvengeance2"
        event.dur = 10
        event.target = caster
        event.max = 50
        event.self = true
        ApplyBuffStack(event)

        --ability:ApplyDataDrivenModifier(caster, caster, buff, {Duration = -1})
        --caster:SetModifierStackCount(buff, ability, dmg)
        --caster.lastdamagetaken = dmg
    end
end

function StrikeOfVengeance3( event )
    local caster = event.caster
    --local dmg = event.dmg
    if event.on and event.on == 1 then
        event.buff = "modifier_strikeofvengeance3"
        event.dur = 10
        event.target = caster
        event.max = 25
        event.self = true
        ApplyBuffStack(event)
    end
end

function RotApplyBuff( event )
	if not event.target:HasModifier("modifier_rotdk") then
		ApplyBuff(event)
	end
end

function ExorApplyBuff( event )
	if not event.target:HasModifier("modifier_sap") then
		ApplyBuff(event)
	end
end

function DecreaseBuffStack( event )
	local target = event.target
	local amount = 1
	if event.notself then
		target = event.target
	end
	if event.self then
		target = event.caster
	end
	local caster = event.caster
	if target == nil then
		target = event.attacker
	end
	if target == nil then
		target = event.caster
	end
	if target == nil then
		return
	end
	if caster == nil then
		return
	end
	if event.amount then
		amount = event.amount
	end
	local buff = event.buff
	local ability = event.ability

	if target:HasModifier(buff) then
		local stackcount = target:GetModifierStackCount(buff, nil)
		if stackcount > 1 then
			target:SetModifierStackCount(buff, ability, stackcount-1)
		else
			target:RemoveModifierByName(buff)
		end
	end
end

function WingsOfHell( event )
	local caster = event.attacker
	local target = event.unit
	local ability = event.ability

	local myevent = {}
	myevent.caster = caster
	myevent.target = target
	myevent.buff = "modifier_active6"
	myevent.ability = ability
	myevent.dur = event.dur
	ApplyBuff(myevent)

	if caster:HasModifier("modifier_active6_self") then
		--print(ability:GetName())
		--ability:ApplyDataDrivenModifier(caster, target, "modifier_active6_2", nil)

		local myevent = {}
		myevent.caster = caster
		myevent.target = target
		myevent.buff = "modifier_active6_2"
		myevent.ability = ability
		myevent.dur = event.dur
		ApplyBuff(myevent)
	end
end

function KnockbackAOE(event)
	local caster = event.caster
	local ability = event.ability
	local range = event.range
	local amount = event.amount
	local pos
	if event.target_points ~= nil then
		pos = event.target_points[1]
	else
		return
	end

	local enemies = FindUnitsInRadius( caster:GetTeamNumber(), pos, caster, range, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	--print(#enemies)
	if #enemies > 0 then
		for _,enemy in pairs(enemies) do
			if enemy ~= nil then
				if ((enemy:GetUnitLabel()=="hero") or (enemy:GetUnitLabel()=="pet")) then

					event.target = enemy
					event.fixedforce = 400
					KnockBack(event)

					Timers:CreateTimer(5.0, function()
						local table = {}
						table.Duration = 0.02
					   	event.ability:ApplyDataDrivenModifier(enemy, enemy, "modifier_phased", table)
					end)
				end
			end
		end
	end
end

function DPSCounter( event )
	local caster = event.attacker
    local target = event.unit
	--print(event.damage)
	if event.hero ~= nil then
		if caster.damagedone then
			caster.damagedone = caster.damagedone + event.damage
		else
			caster.damagedone = event.damage
		end
	end
	if event.pet ~= nil and caster.owner then
		if caster.owner.damagedone then
			caster.owner.damagedone = caster.owner.damagedone + event.damage
			--print(event.damage)
		else
			caster.owner.damagedone = event.damage
		end
	end
    --set current target for dps meter
    local thrash_too = true
    if thrash_too or target.isboss or (target.rewardchance and target.rewardchance >= 100) then
        caster.current_boss_target = event.unit
    end
end

function CheckDegeneration( event )
	local caster = event.caster
	if GetMapName() == "special_test_map" then
		return
	end
	if COverthrowGameMode.GameState == 2 and COverthrowGameMode.RoundCountdown <= 420 then
		local h = 8
		event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_health_degen_debuff", nil)
		--if caster:HasModifier("modifier_invisible") then
			--event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_health_degen_debuff_inv", nil)
			--h = 24
		--end
		if caster:GetHealth() <= h then
    		h = caster:GetHealth()-1
		end
		caster:SetHealth(caster:GetHealth()-h)

	end
end

function ArenaStats( event )
	local caster = event.caster.controlowner
	if COverthrowGameMode.GameState ~= 2 then
		if caster then

			if caster.hpsthisturn then
				CriticalStrikeFX(nil, caster, caster.hpsthisturn, 0, 0)
			end
			if caster.dpsthisturn then
				CriticalStrikeFX(nil, caster, caster.dpsthisturn, 1, 0)
			end
			Timers:CreateTimer(1.5, function()
				if caster.hpsthisturn then
				CriticalStrikeFX(nil, caster, caster.hpsthisturn, 0, 0)
				end
				if caster.dpsthisturn then
					CriticalStrikeFX(nil, caster, caster.dpsthisturn, 1, 0)
				end
			end)
			Timers:CreateTimer(3.0, function()
				if caster.hpsthisturn then
				CriticalStrikeFX(nil, caster, caster.hpsthisturn, 0, 0)
				end
				if caster.dpsthisturn then
					CriticalStrikeFX(nil, caster, caster.dpsthisturn, 1, 0)
				end
			end)
		end
	end
end

function ItemElemental( event )
	local caster = event.caster
	local ability = event.ability
	if caster then
		caster.itemelemental = ability
	end
end

function WardKillAttackCounter( event )
	local caster = event.unit
	local target = event.attacker
	if caster.attackstokill and target then
		caster.attackstokill = caster.attackstokill - 1
		if caster.attackstokill <= 0 then
			EndAnimation(caster)
			StartAnimation(caster, {activity=ACT_DOTA_DIE, duration=2.0, rate=0.3})
			caster:Kill(event.ability, target)
		else
			caster:SetHealth(caster:GetMaxHealth()/2)
		end
	end
end

function WardKillAttackCounterSet( event )
	local target = event.target
	target.attackstokill = event.amount
end

function Boss1Add( event )
	local caster = event.caster
	local pos = caster:GetAbsOrigin() + Vector(150,0,0)
	local boss = CreateUnitByName("npc_dota_creature_pveboss1_add1", pos, true, nil, nil, DOTA_TEAM_NEUTRALS )
	--if caster.PVEAdd1 and caster.PVEAdd1:IsAlive() then
 	--	caster.PVEAdd1:Destroy()
	--end
	caster.PVEAdd1 = boss
	local particle = ParticleManager:CreateParticle("particles/items2_fx/shadow_amulet_activate_end_flash.vpcf", PATTACH_ABSORIGIN_FOLLOW, boss)
end

function ChampionUnholy(event)
	local caster = event.attacker.owner
	if caster and caster.championunholy then
		--local ability = caster:GetAbilityByIndex(1)
		--ability:EndCooldown()
		local myevent = {}
        myevent.caster = caster
        myevent.energy = 20 * caster.championunholy
        AddEnergy(myevent)
	end
end

function SetPetStuff(event)
	local caster = event.caster
	local unit = event.target
    if not event.dontsetaspet then
    	if event.nr and event.nr == 2 then
    		caster.Pet2 = unit
    	else
    		caster.Pet = unit
    	end
    end
	unit:SetHullRadius(35)
	unit.owner = caster

	--agha
    caster.championunholy = 0
	if caster:HasModifier("modifier_item_straxe2") then
		caster.championunholy = 1
	end
	if caster:HasModifier("modifier_item_straxe3") then
        caster.championunholy = caster.championunholy + 1
    end

	if event.levelup then
		unit:CreatureLevelUp(event.ability:GetLevel()-1)
	end

	if event.setaa then
        local bonus = 1.0
        if event.talentscale and caster.talents and caster.talents[event.talentscale] then
            bonus = caster.talents[event.talentscale]
        end
        if event.runewordscale and event.runewordscale == 11 and caster.runeword and caster.runeword[event.runewordscale] then
            bonus = bonus + caster.runeword[event.runewordscale]
        end
		unit:SetBaseDamageMin(math.floor(bonus*event.caster:GetAverageTrueAttackDamage(caster)*event.setaa/100.0))
		unit:SetBaseDamageMax(math.floor(bonus*event.caster:GetAverageTrueAttackDamage(caster)*event.setaa/100.0))
	end
    if event.immortaldmg then
        unit:SetBaseDamageMin(event.immortaldmg)
        unit:SetBaseDamageMax(event.immortaldmg)
        unit:SetModelScale(0.7)
    end
    if event.immortalbear and caster:HasModifier("modifier_item_beastmaster2") then
        unit:SetBaseDamageMin(5000)
        unit:SetBaseDamageMax(5000)
        unit:SetModelScale(0.9)
    end
    if event.currenthp then
        local health = caster:GetHealth() * event.currenthp / 100
        unit:SetBaseMaxHealth(health)
        unit:SetMaxHealth(health)                           
        unit:SetHealth(health)
    end
	local dmg2
	if event.setaa_int then
		dmg2 = math.floor((event.caster:GetIntellect()*event.setaa_int/100))
		unit:SetBaseDamageMin(dmg2)
		unit:SetBaseDamageMax(dmg2)
	end
	if event.setaa_sp then
		local sp = GetSpellpower(event)
		unit:SetBaseDamageMin(dmg2+math.floor(sp*event.setaa_sp/100))
		unit:SetBaseDamageMax(dmg2+math.floor(sp*event.setaa_sp/100))
	end
	if event.phased then
		local tab = {}
		tab.Duration = 20
		event.ability:ApplyDataDrivenModifier(caster, unit, "modifier_phased", tab)
	end

    if event.beastmasterghostwolf then
        local dmg = caster:GetAverageTrueAttackDamage(caster) * event.setghostdmg / 100
        if caster:HasModifier("modifier_item_beastmaster") then
            dmg = dmg + event.caster:GetStrength() * 0.1
        end
        if caster:HasModifier("modifier_item_beastmaster2") then
            dmg = dmg + event.caster:GetStrength() * 10
            unit:SetModelScale(0.45)
        end
        unit:SetBaseDamageMin(math.floor(dmg))
        unit:SetBaseDamageMax(math.floor(dmg))
        local tab = {}
        tab.Duration = 60.0
        event.ability:ApplyDataDrivenModifier(caster, unit, "modifier_phased", tab)
    end

	if caster.creepertarget then
		Timers:CreateTimer(0.1, function()
			local order = 
			{
				UnitIndex = unit:entindex(),
				OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
				TargetIndex = caster.creepertarget:entindex()
			}
			ExecuteOrderFromTable(order)
		end)
	end
end

function PetTargetSet(event)
    local caster = event.attacker
    caster.pettarget = event.target
end

function PetTargetOrder(event)
    local caster = event.caster
    local target = event.target
    if caster and target and caster.pettarget and not caster.pettarget:IsNull() and caster.pettarget:IsAlive() then
        local order = 
        {
            UnitIndex = target:entindex(),
            OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
            TargetIndex = caster.pettarget:entindex()
        }
        ExecuteOrderFromTable(order)
    end
end

function PetFollowOrder(event)
    local caster = event.caster
    local target = event.target
    if caster and target then
        local order = 
        {
            UnitIndex = target:entindex(),
            OrderType = DOTA_UNIT_ORDER_MOVE_TO_TARGET,
            TargetIndex = caster:entindex()
        }
        ExecuteOrderFromTable(order)
    end
end

function UnholyInsectFX(event)
	local target = event.target
	local particle = ParticleManager:CreateParticle("particles/econ/items/death_prophet/death_prophet_acherontia/death_prophet_acher_swarm_pnt.vpcf", PATTACH_POINT_FOLLOW, target)
	--ParticleManager:SetParticleControlEnt(particle, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
	ParticleManager:SetParticleControl(particle, 1, Vector(1,1,1))
	--ParticleManager:SetParticleControlEnt(particle, 2, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(particle, 3, target, PATTACH_POINT_FOLLOW, "attach_origin", target:GetAbsOrigin(), true)
end

function GhoulJump(event)
	if event.jump > 0 then
		event.caster:SetAbsOrigin(event.target:GetAbsOrigin() - event.target:GetForwardVector()*100)
        local tab = {}
        tab.Duration = 0.05
        event.ability:ApplyDataDrivenModifier(event.caster, event.caster, "modifier_phased", tab)
	end
end

function GhoulTransform(event)
	local caster = event.caster
	local target = caster.Pet
	if target == nil then
		return
	end
	if target:IsNull() then
		return
	end
	if event.transform > 0 then
		local stack = target:GetModifierStackCount("modifier_ghoul_transform", nil)
		if stack >= 4 then
			target:RemoveModifierByName("modifier_ghoul_transform")
            --target:SetOriginalModel("models/heroes/undying/undying_flesh_golem.vmdl")
			caster:GetAbilityByIndex(3):ApplyDataDrivenModifier(target, target, "modifier_ghoul_transform_active", nil)
		elseif not target:HasModifier("modifier_ghoul_transform_active") then
			event.caster = caster
			event.target = target
			event.buff = "modifier_ghoul_transform"
			event.max = 5
			ApplyBuffStack(event)
		end
	end
end

function GhoulTransformEnd(event)
    local target = event.target
    --target:SetModel("models/heroes/life_stealer/life_stealer.vmdl")
    --target:SetOriginalModel("models/heroes/life_stealer/life_stealer.vmdl")
end

function RootedProcInnerCD(event)
	local caster = event.caster
	local target = event.target
	if not caster:HasModifier("rooted_proc_innercd") then
		event.ability:ApplyDataDrivenModifier(caster, caster, "rooted_proc_innercd", nil)
		ApplyBuff(event)
	end
end

function SilenceShadow(event)
	local caster = event.caster
	local target = event.target

	local myevent = {}
	myevent.caster = caster
	myevent.target = target
	myevent.buff = "modifier_silence"
	myevent.ability = event.ability
	local b = 0
	if target:HasModifier("modifier_fearsp_bonus") then
  		b = event.silence1
	end
	myevent.dur = (event.silence + b)*GetCCPower(event)
	ApplyBuff(myevent)

	if event.ring and event.ring > 0 then
		myevent.buff = "modifier_silence_ring"
		ApplyBuff(myevent)
	end
end

function DamageUnitRange( event )
	local caster = event.caster
	local target = event.target
	local range = event.rangedepend
	local vec = (caster:GetAbsOrigin()-target:GetAbsOrigin()):Length()
	if vec < 100.0 then
		vec = 100.0
	end
	if vec > range then
		vec = range
	end
	vec = vec - 100
	local power = vec/(range - 100)
	--local power = 0.25 + 0.75*vec/(range - 100)
	if power > 1.0 then
		power = 1.0
	end
	if power < event.mindmg/100 then
		power = event.mindmg/100
	end

    --print(power)

	event.attributefactor = event.attributefactor*power
	event.spelldamagefactor = event.spelldamagefactor*power
    event.includeauto = event.includeauto*power

	DamageUnit(event)
end

function CDResetChance( event )
	local caster = event.caster
	local ability = event.ability

	if event.chance >= math.random(1,100) then
		ability:EndCooldown()
		ParticleManager:CreateParticle("particles/units/heroes/hero_windrunner/windrunner_loadout_magic.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
		EmitSoundOn("windrunner_wind_respawn_08", caster)
	end
end

function StunAggroChange(event)
	local caster = event.attacker
	local target = event.target
	local damage_table = {}

	if not target:HasModifier("modifier_hasaggro") then
		damage_table.Duration = 2
		event.ability:ApplyDataDrivenModifier(caster, target, "modifier_stunned", damage_table)
	end
end

function KillDance (event)
	local caster = event.caster
	local target = event.target
	local ability = event.ability
	local distance = event.range

	local vec1 = RandomVector(75.0)
	local vec = target:GetAbsOrigin() + Vector(vec1[1],vec1[2],0)
			
	caster:SetAbsOrigin(vec)
	caster:SetForwardVector(target:GetAbsOrigin()-caster:GetAbsOrigin())
	EmitSoundOn("Hero_BountyHunter.Jinada", target)
	StartAnimation(caster, {activity=ACT_DOTA_CAST_ABILITY_1, duration=0.40, rate=2.2})
	KillDanceFX(event)
	

	local myevent = {}
	myevent.caster = caster
	myevent.target = target
	myevent.buff = "modifier_deadlypoison"
	myevent.max = 20
    if caster:GetAbilityByIndex(2):GetLevel() >= 4 then
        myevent.max = 40
    end
	myevent.ability = caster:GetAbilityByIndex(2)
	myevent.dur = 10
	myevent.notself = 1
	ApplyBuffStack(myevent)

    local ev = {caster = caster, target = target, ability = event.ability, targetpos = 1, damage = 0, includeauto = event.includeauto, aoe = 250, targeteffect = "blood" }
    if event.aoedmg and event.aoedmg == 1 then
        DamageAOE(ev)
    else
	   DamageUnit(event)
    end

	for i=1,12 do
		Timers:CreateTimer(0.33*i,function() 
	        KillDanceProc(event, caster, target, distance)
	    end)
	end
end

function KillDanceProc (event, caster, target, distance)
	if not caster:HasModifier("modifier_killdance") then
		return
	end

	local range = distance

	local enemies = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetAbsOrigin(), caster, range, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, 0, 0, false )
	if #enemies > 0 then
		--print
	else
		enemies = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetAbsOrigin(), caster, range, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	end
	if #enemies > 0 then
		local unit = enemies[math.random(1,#enemies)]
		if unit ~= nil then
			event.caster = caster
			event.target = unit
			local vec1 = RandomVector(100.0)
			local vec = unit:GetAbsOrigin() + Vector(vec1[1],vec1[2],0)
			caster:SetAbsOrigin(vec)
			caster:SetForwardVector(unit:GetAbsOrigin()-caster:GetAbsOrigin())
			EmitSoundOn("Hero_BountyHunter.Jinada", unit)
			StartAnimation(caster, {activity=ACT_DOTA_CAST_ABILITY_1, duration=0.25, rate=3.0})
			KillDanceFX(event)

			local myevent = {}
			myevent.caster = caster
			myevent.target = unit
			myevent.buff = "modifier_deadlypoison"
			myevent.max = 20
            if caster:GetAbilityByIndex(2):GetLevel() >= 4 then
                myevent.max = 40
            end
			myevent.ability = caster:GetAbilityByIndex(2)
			myevent.dur = 10
			myevent.notself = 1
			ApplyBuffStack(myevent)
			
			local ev = {caster = caster, target = target, ability = event.ability, targetpos = 1, damage = 0, includeauto = event.includeauto, aoe = 250, targeteffect = "blood" }
            if event.aoedmg and event.aoedmg == 1 then
                DamageAOE(ev)
            else
               DamageUnit(event)
            end

			local tab = {}
		 	tab.Duration = 0.05
		 	event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_phased", tab)
		end
	else
		caster:RemoveModifierByName("modifier_killdance")
	end
end

function KillDanceFX(event)
	local caster = event.caster
	local target = event.target

	local vec = (caster:GetAbsOrigin()-target:GetAbsOrigin()):Normalized()
	local vec2 = target:GetAbsOrigin()
	local particle = ParticleManager:CreateParticle("particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_crit_arcana_swoop.vpcf", PATTACH_POINT_FOLLOW, target)

	ParticleManager:SetParticleControl(particle, 0, vec2)
	ParticleManager:SetParticleControl(particle, 1, vec2)
	ParticleManager:SetParticleControlForward(particle, 1, vec)
	ParticleManager:SetParticleControl(particle, 6, vec2)
	ParticleManager:SetParticleControl(particle, 10, vec2)
end

function DeepFreeze (event)
	local caster = event.caster
	local target = event.target
	local ability = event.ability
	if target:HasModifier("modifier_icenova") or target:HasModifier("modifier_icenova_slow") then
		--ability:ApplyDataDrivenModifier(caster, target, "modifier_rootedfx", nil)

		local myevent = {}
		myevent.caster = caster
		myevent.target = target
		myevent.buff = "modifier_deepfreeze"
		myevent.ability = ability
		myevent.dur = event.dur
		ApplyBuff(myevent)

		particle = ParticleManager:CreateParticle("particles/econ/events/winter_major_2016/blink_dagger_start_sparkles_wm.vpcf", PATTACH_POINT_FOLLOW, target)
		--ParticleManager:SetParticleControlEnt(particle, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
		EmitSoundOn("DOTA_Item.ShivasGuard.Activate", target)
	else
 		ability:EndCooldown()
	end
end

function VampiricEmbrace(event)
	local caster = event.caster
	local ability = event.ability
	local range = 900

	local enemies = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetAbsOrigin(), caster, range, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, 0, 0, false )
	if #enemies > 0 then
		for _,enemy in pairs(enemies) do
			if enemy ~= nil then
				if ((enemy:GetUnitLabel()=="hero") or (enemy:GetUnitLabel()=="pet")) then
					local table = {}
					table.caster = caster
					table.target = enemy
					table.ability = ability
					table.attributefactor = 0.0
					table.spelldamagefactor = 0.0
					table.heal = event.heal
					if enemy == caster then
						--table.heal = event.heal * event.healfactor / 100
					else
						HealUnit(table)
					end
					
					local particle = ParticleManager:CreateParticle("particles/items3_fx/glimmer_cape_initial_flash_ember.vpcf", PATTACH_POINT_FOLLOW, enemy)
					--ParticleManager:SetParticleControl(particle, 0, caster:GetAbsOrigin()+Vector(0,0,75))
					--ParticleManager:SetParticleControl(particle, 1, enemy:GetAbsOrigin()+Vector(0,0,75))
				end
			end
		end
	end
end

function SiegeDamageTower(event)
	local target = event.target
	if target:GetUnitLabel() == "tower" then
		if target:GetUnitName() == "npc_dota_creature_city_boss_1" or target:GetUnitName() == "npc_dota_creature_city_boss_2" then
			return
		end
		event.damage = event.damage*4
		local particle = ParticleManager:CreateParticle("particles/items_fx/dagon_tgt_sparks.vpcf", PATTACH_POINT_FOLLOW, target)
		ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin())
		EmitSoundOn("Hero_Lina.DragonSlave", target)
		DamageUnit(event)
	end
end

function MindControl(event)
	local caster = event.caster
	local target = event.target

	local owner = target:GetOwner()
	--print(PlayerResource:GetPlayerName(5))
	if owner == nil then
		--print("fixed owner")
		target:SetOwner(PlayerResource:GetPlayer(5))
		owner = target:GetOwner()
	end

	local id = caster:GetPlayerID()
	local id2 = owner:GetPlayerID()


	--target:SetControllableByPlayer(id, true)
	--target:SetControllableByPlayer(id2, false)
	PlayerResource:SetUnitShareMaskForPlayer(id, id2, 1, true)
end
function MindControlEnd(event)
	local caster = event.caster
	local target = event.target

	local owner = target:GetOwner()
	local id = caster:GetPlayerID()
	local id2 = owner:GetPlayerID()


	--target:SetControllableByPlayer(id, true)
	--target:SetControllableByPlayer(id2, false)
	PlayerResource:SetUnitShareMaskForPlayer(id, id2, 1, false)
end

function UpgradeSpell(event)
	local hero = event.caster
	local charges = event.charges
	hero:RemoveModifierByName("modifier_charges")
	hero:AddNewModifier(hero, event.ability, "modifier_charges",
	    {
	        max_count = charges,
	        start_count = charges-1,
	        replenish_time = 25
	    }
	)
end

function SoulBrotherRing(event)
	local caster = event.caster
	if caster:GetHealth() / caster:GetMaxHealth() <= caster:GetMana() / caster:GetMaxMana() then
		event.amount = nil
		event.percent = nil
		HealUnit(event)
	else
		event.heal = nil
		event.percenthp = nil
		RestoreMana(event)
	end
end

function SetCombine(event)
	local caster = event.caster
	if caster and caster:HasModifier("modifier_item_set_str_tank_3") and caster:HasModifier("modifier_item_set_str_tank_2") and caster:HasModifier("modifier_item_set_str_tank_1") then
     	event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_item_set_str_tank_full", nil)
	end
	if caster and caster:HasModifier("modifier_item_set_str_dmg_3") and caster:HasModifier("modifier_item_set_str_dmg_2") and caster:HasModifier("modifier_item_set_str_dmg_1") then
     	event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_item_set_str_dmg_full", nil)
	end
	if caster and caster:HasModifier("modifier_item_set_agi_dmg_3") and caster:HasModifier("modifier_item_set_agi_dmg_2") and caster:HasModifier("modifier_item_set_agi_dmg_1") then
     	event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_item_set_agi_dmg_full", nil)
	end
	if caster and caster:HasModifier("modifier_item_set_int_dmg_3") and caster:HasModifier("modifier_item_set_int_dmg_2") and caster:HasModifier("modifier_item_set_int_dmg_1") then
     	event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_item_set_int_dmg_full", nil)
	end
	if caster and caster:HasModifier("modifier_item_ring_arcane_2") and caster:HasModifier("modifier_item_ring_arcane") then
     	event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_item_ring_arcane_full", nil)
	end
end

function PVELifestealLow(event)
	local caster = event.caster
	if caster:GetHealth()/caster:GetMaxHealth() <= 0.5 then
        local particle = ParticleManager:CreateParticle("particles/neutral_fx/troll_heal.vpcf", PATTACH_POINT_FOLLOW, caster)
		HealUnit(event)
	end
end

function WispArmyLow(event)
    local caster = event.caster
    if (caster:GetHealth()/caster:GetMaxHealth() <= 0.8 and caster:GetHealth()/caster:GetMaxHealth() >= 0.7) or (caster:GetHealth()/caster:GetMaxHealth() <= 0.5 and caster:GetHealth()/caster:GetMaxHealth() >= 0.35) or (caster:GetHealth()/caster:GetMaxHealth() <= 0.2 and caster:GetHealth()/caster:GetMaxHealth() >= 0.0) then
        event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_spawn_wips", nil)
    end
end

function PVEBashLow(event)
    local caster = event.caster
    if caster:GetHealth()/caster:GetMaxHealth() <= 0.15 then
        ApplyBuff(event)
    end
end

function PVESprintLow(event)
    local caster = event.caster
    if caster:GetHealth()/caster:GetMaxHealth() <= 0.25 then
        ApplyBuff(event)
    end
end

function Damaged(unit)
    if unit:GetHealth() / unit:GetMaxHealth() < 1.0 then
        return true
    end
    return false
end

function SharedLife(event)
	local caster = event.caster
	local other = caster.sharedhealth
    local heal = event.heal
	if other and not other:IsNull() and other:IsAlive() then
        if Damaged(caster) then
            if COverthrowGameMode.jungledifficulty >= 0 and (caster:GetAbsOrigin() - other:GetAbsOrigin()):Length() < 600 then
                caster:SetHealth(caster:GetMaxHealth()*heal+caster:GetHealth())
                local particle = ParticleManager:CreateParticle("particles/items3_fx/fish_bones_active.vpcf", PATTACH_POINT_FOLLOW, caster)
            end
        end
		if other:GetHealth() > caster:GetHealth() then
 			caster:SetHealth(other:GetHealth())
            local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_warlock/warlock_fatal_bonds_pulse.vpcf", PATTACH_POINT_FOLLOW, caster)
            ParticleManager:SetParticleControlEnt(particle, 0, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), true)
            ParticleManager:SetParticleControlEnt(particle, 1, other, PATTACH_POINT_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), true)
		end
	end
end

function TempleTeleport( event )
    local caster = event.caster.controlowner
    local point = event.target_points[1]
    if caster and point then
        for i=0, 10 do
            local tp = COverthrowGameMode.teleporters[i]
            if tp and (tp.tp_active or (COverthrowGameMode.jungledifficulty >= 50.0 and i ~= 8)) then
                Timers:CreateTimer(i*0.7-0.65, function()
                    if caster:HasModifier("in_aggro_range") then
                        MinimapEvent(caster:GetTeamNumber(), caster, tp:GetAbsOrigin()[1], tp:GetAbsOrigin()[2], DOTA_MINIMAP_EVENT_BASE_UNDER_ATTACK, 1 )
                    else
                        MinimapEvent(caster:GetTeamNumber(), caster, tp:GetAbsOrigin()[1], tp:GetAbsOrigin()[2], DOTA_MINIMAP_EVENT_TEAMMATE_TELEPORTING, 1 )
                    end
                end)
            end
        end
        if caster:HasModifier("in_aggro_range") then
            event.ability:EndCooldown()
            event.ability:StartCooldown(0.5)
            Notifications:Top(caster:GetPlayerID(), {text="Can not teleport when enemies too close!", duration=4, style={color="red"}})
        else
            for i=0, 10 do
                local tp = COverthrowGameMode.teleporters[i]
                if i == 0 then
                    tp = event.caster
                    event.caster.tp_active = true
                end
                if tp and (tp.tp_active or (COverthrowGameMode.jungledifficulty >= 50.0 and i ~= 8)) and (point-tp:GetAbsOrigin()):Length() <= 3500 then
                    caster:SetAbsOrigin(tp:GetAbsOrigin())
                    local tab = {}
                    tab.Duration = 0.5
                    event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_phased", tab)
                    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_chen/chen_teleport.vpcf", PATTACH_POINT_FOLLOW, caster)
                    EmitGlobalSound("DOTA_Item.ArcaneBoots.Activate")
                    return
                end
            end
            Notifications:Top(caster:GetPlayerID(), {text="No unlocked Teleporter selected!", duration=4, style={color="white"}})
            event.ability:EndCooldown()
        end
        EmitGlobalSound("DOTA_Item.Necronomicon.Bow")
    end
end

function TempleTeleportActivate( event )
    local caster = event.caster.controlowner
    if caster then
        local point = caster:GetAbsOrigin()
        for i=1, 9 do
            local tp = COverthrowGameMode.teleporters[i]
            if tp then
                --print(tp:GetName())
                --print(tp.tp_active)
                if not tp.tp_active and (point-tp:GetAbsOrigin()):Length() <= 900 then
                    tp.tp_active = true
                    local particle = ParticleManager:CreateParticle("particles/items3_fx/glimmer_cape_initial.vpcf", PATTACH_POINT_FOLLOW, caster)
                    EmitGlobalSound("DOTA_Item.LinkensSphere.Target")
                end
            end
        end
    end
end

function RandomPosition(event)
    local caster = event.caster
    local target = event.target
    local range = event.range
    local min = 200
    if event.min then
        min = event.min
    end
    local vec = RandomVector(1.0)
    local vec2 = Vector(vec[1],vec[2],0):Normalized()*math.random(min,range)

    if event.circledynamic and event.circledynamic > 0 and caster then
        local i = 1
        if event.clockwise and caster:GetHealth() / caster:GetMaxHealth() < 0.75 and caster:GetHealth() / caster:GetMaxHealth() > 0.25 then
            i = -1
        end
        if caster.circle_array then
            caster.circle_array = caster.circle_array + i
        else
            caster.circle_array = 1
        end
        if caster.circle_array > event.circledynamic then
            caster.circle_array = 1
        end
        if caster.circle_array < 1 then
            caster.circle_array = event.circledynamic
        end
        local vecs = {}
        local offset_degree = 360 / event.circledynamic
        local offset_start = 0
        if event.degreeoffset then
            offset_start = event.degreeoffset
        end
        --for i=1, event.circledynamic do
        --    print("degree " .. offset_start+offset_degree*i .. " rad " .. math.rad(offset_start+offset_degree*i))
        --    vecs[i] = Vector(range*math.cos(math.rad(offset_start+offset_degree*i),range*math.sin(math.rad(offset_start+offset_degree*i))))
        --end
        --vec2 = vecs[caster.circle_array]
        --print("offset degree " .. offset_degree .. "  casterarray " .. caster.circle_array)
        --print("degree " .. offset_start+offset_degree*caster.circle_array .. " rad " .. math.rad(offset_start+offset_degree*caster.circle_array))

        vec2 = Vector(range*math.cos(math.rad(offset_start+offset_degree*caster.circle_array)), range*math.sin(math.rad(offset_start+offset_degree*caster.circle_array)), 0)
        --print(vec2)
    end
    target:SetAbsOrigin(caster:GetAbsOrigin()+vec2)
end

function OrderToCaster (event)
    local caster = event.caster
    local unit = event.target
    unit.sourcepriest = caster

    Timers:CreateTimer(0.1, function()
        if caster then
            local order = 
            {
                UnitIndex = unit:entindex(),
                OrderType = DOTA_UNIT_ORDER_MOVE_TO_TARGET,
                TargetIndex = caster:entindex()
            }

            ExecuteOrderFromTable(order)
        end
    end)
end

function HealCloseCaster (event)
    local caster = event.target
    local target = event.caster
    if target and caster and not caster.healdone then
        if (target:GetAbsOrigin()-caster:GetAbsOrigin()):Length() <= 200 then
            caster.healdone = 1
            caster:AddAbility("pveboss_system"):SetLevel(1)
            caster:RemoveModifierByName("modifier_heavens_halberd_debuff")
            event.caster = target
            event.target = target
            local particle = ParticleManager:CreateParticle("particles/econ/events/ti6/blink_dagger_start_ti6_lvl2.vpcf", PATTACH_POINT_FOLLOW, target)
            HealUnit(event)
        end
    end
end

function ReleaseCloseCaster (event)
    local caster = event.target
    local target = event.caster
    if target and caster and not caster.healdone then
        if (target:GetAbsOrigin()-caster:GetAbsOrigin()):Length() <= 200 then
            caster.healdone = 1
            caster:AddAbility("pveboss_system"):SetLevel(1)
            caster:RemoveModifierByName("modifier_heavens_halberd_debuff")
            local particle = ParticleManager:CreateParticle("particles/econ/events/ti6/blink_dagger_start_ti6_lvl2.vpcf", PATTACH_POINT_FOLLOW, target)
        end
    end
end

function MagmaSphere (event)
    local caster = event.caster
    local target = event.target
    if event.abil_exe then
        if caster and target and caster:GetTeamNumber() ~= target:GetTeamNumber() then
            local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_ember_spirit/ember_spirit_hit_fire.vpcf", PATTACH_POINT_FOLLOW, target)
            particle = ParticleManager:CreateParticle("particles/econ/items/earthshaker/egteam_set/hero_earthshaker_egset/earthshaker_echoslam_start_magma_egset.vpcf", PATTACH_POINT_FOLLOW, target)
            EmitSoundOn("DOTA_Item.Armlet.DeActivate", target)
            DamageAOE(event)
        end
    else
        caster = event.attacker
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_ember_spirit/ember_spirit_hit_fire.vpcf", PATTACH_POINT_FOLLOW, target)
        particle = ParticleManager:CreateParticle("particles/econ/items/earthshaker/egteam_set/hero_earthshaker_egset/earthshaker_echoslam_start_magma_egset.vpcf", PATTACH_POINT_FOLLOW, target)
        EmitSoundOn("DOTA_Item.Armlet.DeActivate", target)
        DamageAOE(event)
    end
end

function ChainLightningItem (event)
    local caster = event.caster
    local target = event.target
    event.hit_targets = {}
    event.total_targets = event.jumps
    event.maxtargets = event.jumps
    if event.includeauto and event.includeauto > 0 then
        event.damage = event.damage + caster:GetAverageTrueAttackDamage(caster) * event.includeauto / 100
    end
    if event.attributefactor and event.attributefactor > 0 then
        event.damage = event.damage + caster:GetPrimaryStatValue() * event.attributefactor / 100
    end
    ZeusCloudProc(event)
end

function ZeusCloud (event)
    local caster = event.caster
    local target = event.target
    if caster and target and caster:GetTeamNumber() ~= target:GetTeamNumber() then
        event.hit_targets = {}
        event.total_targets = event.jumps
        event.maxtargets = event.jumps
        ZeusCloudProc(event)
    end
end

function ZeusCloudProc(event)
    --print(event.total_targets)
    local caster = event.caster
    local target = event.target
    local pos = target:GetAbsOrigin()
    --do dmg and fx
    local particle = ParticleManager:CreateParticle("particles/items_fx/chain_lightning.vpcf", PATTACH_POINT_FOLLOW, caster)
    local fxcaster = caster
    if event.hit_targets[event.total_targets+1] then
        fxcaster = event.hit_targets[event.total_targets+1]
    end
    ParticleManager:SetParticleControlEnt(particle, 0, fxcaster, PATTACH_POINT_FOLLOW, "attach_hitloc", fxcaster:GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
    EmitSoundOn("Item.Maelstrom.Chain_Lightning.Jump", target)
    DamageUnit(event)
    --save target hit already
    event.hit_targets[event.total_targets] = event.target
    event.total_targets = event.total_targets - 1
    --find next target, if charges left
    if event.total_targets >= 1 then
        local valid_targets = {}
        local index = 1
        local enemies = FindUnitsInRadius( caster:GetTeamNumber(), pos, caster, event.jumprange, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
        for _,enemy in pairs(enemies) do
            if enemy ~= nil and enemy:IsAlive() and ((enemy:GetUnitLabel()=="hero") or (enemy:GetUnitLabel()=="pet") or (enemy:GetUnitLabel()=="tower")) and not CheckForBreakableCC(target) then
                local valid = true
                for i=1, event.maxtargets do
                    if event.hit_targets[i] and (enemy == event.hit_targets[i]) then
                        valid = false
                    end
                end
                if valid then
                    valid_targets[index] = enemy
                    index = index + 1
                end
            end
        end
        local final_target = valid_targets[math.random(1,index-1)]
        if final_target then
            Timers:CreateTimer(0.3, function()
                local myevent = {}
                myevent.caster = caster
                myevent.target = final_target
                myevent.damage = event.damage / 2
                myevent.ability = event.ability
                myevent.hit_targets = event.hit_targets
                myevent.total_targets = event.total_targets
                myevent.maxtargets = event.maxtargets
                myevent.jumprange = event.jumprange
                ZeusCloudProc(myevent)
            end)
        end
    end
end

function CoilDamageUnit (event)
    local caster = event.caster
    local target = event.target
    if caster:GetTeamNumber() ~= target:GetTeamNumber() then
        DamageUnit(event)
    elseif target:GetUnitName() == "npc_dota_creature_ghoul" or target:GetUnitName() == "npc_dota_creature_unholy_dragon" then
        --event.attributefactor = event.attributefactor * 3
        --HealUnit(event)
        event.ability:ApplyDataDrivenModifier(caster, target, "modifier_dk_coil_enrage", {Duration = 30})
    end
end

function CoilApplyBuffStack (event)
    local caster = event.caster
    local target = event.target
    if caster:GetTeamNumber() ~= target:GetTeamNumber() then
        ApplyBuffStack (event)
    end
end

function InnerCDSystem (event)
    local caster = event.caster
    if not caster:HasModifier(event.debuff) then
        if event.resistancebuff then
            local tab = {dur = event.resistancebuff}
            tab.caster = caster
            tab.target = event.target
            tab.buff = "modifier_polybonusdamage_enemy"
            tab.ability = event.ability
            --event.ability:ApplyDataDrivenModifier(caster, target, "modifier_polybonusdamage_enemy", tab)
            ApplyBuff(tab)
        end
        local tab = {Duration = event.innercd}
        event.ability:ApplyDataDrivenModifier(caster, caster, event.debuff, tab)
        ApplyBuff(event)
    end
end

function InnerCDSystemTarget (event)
    local caster = event.caster
    local target = event.target
    if not target:HasModifier(event.debuff) then
        local tab = {Duration = event.innercd}
        event.ability:ApplyDataDrivenModifier(caster, target, event.debuff, tab)
        ApplyBuff(event)
    end
end

function ApplyBuffNonDuplicate (event)
    local caster = event.caster
    local target = event.target
    if not target:HasModifier(event.buff) then
        if event.alwaysapply then
            local tab = {Duration = event.dur}
            event.ability:ApplyDataDrivenModifier(caster, target, event.buff, tab)
        else
            ApplyBuff(event)
        end
    end
end

function CompanionAI (event)
    local caster = event.caster
    local companion = caster.companion
    local tab = {Duration = -1}
    if companion and not companion:IsNull() and companion:IsAlive() then
        --blink if far away
        if (caster:GetAbsOrigin()-companion:GetAbsOrigin()):Length() > 890 then
            companion:SetAbsOrigin(caster:GetAbsOrigin()+Vector(0,100,0))
            event.ability:ApplyDataDrivenModifier(caster, companion, "modifier_phased", tab)
        end
        --standard behavior
        if event.fight then
            local target = caster.companiontarget
            if target and not target:IsNull() and target:IsAlive() and (caster:GetAbsOrigin()-target:GetAbsOrigin()):Length() < 750 then
                local order = 
                {
                    UnitIndex = companion:entindex(),
                    OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
                    TargetIndex = target:entindex()
                }
                ExecuteOrderFromTable(order)
            else
                local order = 
                {
                    UnitIndex = companion:entindex(),
                    OrderType = DOTA_UNIT_ORDER_MOVE_TO_TARGET,
                    TargetIndex = caster:entindex()
                }
                ExecuteOrderFromTable(order)
            end
        end
        if event.follow then
            local order = 
            {
                UnitIndex = companion:entindex(),
                OrderType = DOTA_UNIT_ORDER_MOVE_TO_TARGET,
                TargetIndex = caster:entindex()
            }
            ExecuteOrderFromTable(order)
        end
    else
        if event.dragon then
            event.ability:ApplyDataDrivenModifier(caster, caster, "dragon_summon_proc", nil)
        end
    end
end

function CompanionTargetSet(event)
    local caster = event.attacker
    caster.companiontarget = event.unit
end

function CompanionRegister(event)
    local caster = event.caster
    caster.companion = event.target
    event.target.owner = caster
end

function CompanionRemoval(event)
    local caster = event.caster
    if IsCompanionAlive(caster) then
        caster.companion:Destroy()
        caster.companion = nil
    end
end

function IsCompanionAlive(caster)
    local companion = caster.companion
    if companion and not companion:IsNull() and companion:IsAlive() then
        return true
    else
        return false
    end
end

function HealMostWoundedHero(event)
    local caster = event.caster
    local target = MostWoundedTarget(event)
    if target and IsCompanionAlive(caster) then
        local particle = ParticleManager:CreateParticle("particles/dazzle_shadow_wave_green.vpcf", PATTACH_POINT_FOLLOW, caster.companion)
        ParticleManager:SetParticleControlEnt(particle, 0, caster.companion, PATTACH_POINT_FOLLOW, "attach_hitloc", caster.companion:GetAbsOrigin(), true)
        ParticleManager:SetParticleControlEnt(particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
        event.target = target
        HealUnit(event)
    end
end

function IncreaseAgonyCounter(event)
    local caster = event.caster
    caster.AgonyCounter = caster.AgonyCounter + 0.2
end

function ShowDamageTaken(event)
    local caster = event.caster
    --print(event.attacker:GetUnitName())
    if event.attacker and (event.attacker:GetUnitName() == "dota_fountain" or event.attacker:GetUnitName() == "npc_dota_goodguys_tower1_bot") then
        event.attacker:SetAcquisitionRange(1.0)
        event.attacker:RemoveModifierByName("modifier_invulnerable")
        event.ability:ApplyDataDrivenModifier(event.attacker, event.attacker, "modifier_disarmed", {Duration = -1})
    end
    local damage = event.dmg
    CriticalStrikeFX(caster, caster, damage, 0, 0)
    --dps calc
    if caster.dummy_dps_taken then
        caster.dummy_dps_taken = caster.dummy_dps_taken + damage
    else
        caster.dummy_dps_taken = damage
    end
end

function TutorialCastOrder(event)
    local caster = event.caster
    --reset dps counter
    caster.dummy_dps_time = 0
    caster.dummy_dps_taken = 0

    local ability = caster:GetAbilityByIndex(1)
    local order = 
    {
        UnitIndex = caster:entindex(),
        OrderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
        AbilityIndex = ability:GetEntityIndex(), 
        Queue = false
        --TargetIndex = caster.creepertarget:entindex()
    }
    ExecuteOrderFromTable(order)
end

function TutorialDummyPosition(event)
    local caster = event.caster
    if caster.dummy_dps_time then
        caster.dummy_dps_time = caster.dummy_dps_time + 3
    else
        caster.dummy_dps_time = 3
    end
    --no damage, no time counting
    if not caster.dummy_dps_taken or caster.dummy_dps_taken <= 0 then
        caster.dummy_dps_time = 0
    end

    if caster.dummy_dps_taken and caster.dummy_dps_taken > 0 and caster.dummy_dps_time > 0 then
        local dps = caster.dummy_dps_taken / caster.dummy_dps_time
        CriticalStrikeFX(caster, caster, dps, 3, 0)
    end

    if caster.dummy_dps_time > 10 then
        local pos = caster.position
        local pos2 = caster:GetAbsOrigin()
        if (pos-pos2):Length() > 20 then
            caster:SetAbsOrigin(pos)
        end
    end
end

function TempleEggCorrupted(event)
    local caster = event.caster
    local target = event.target
    target:SetRenderColor(100, 100, 175)
end

function SetUnitColor(event)
    local caster = event.caster
    local target = event.target
    if not target then
        target = caster
    end
    target:SetRenderColor(event.r, event.g, event.b)
end

function DeathEggPosition(event)
    local caster = event.caster
    local target = event.unit
    target:SetAbsOrigin(target:GetAbsOrigin()+Vector(0,5000,0))
end

function DragonEggHatch(event)
    local caster = event.target
    if not caster:HasModifier("modifier_hatch_dragon") and caster:GetUnitName() == "temple_dragon_egg" then
        event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_hatch_dragon", nil)
    end
end

function KillCaster(event)
    local caster = event.caster
    caster:Destroy()
end

function RemoveUnit(event)
    local caster = event.caster
    local target = event.unit
    target:SetAbsOrigin(target:GetAbsOrigin()+Vector(0,5000,0))
end

function FaceTargetCondition(event)
    local caster = event.caster
    local target = event.target

    local len1 = (target:GetAbsOrigin() - caster:GetAbsOrigin()):Length()
    local len2 = (target:GetAbsOrigin()+(target:GetForwardVector():Normalized()*5) - caster:GetAbsOrigin()):Length()

    if len2 < len1 then
        local particle = ParticleManager:CreateParticle("particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_shadowraze.vpcf", PATTACH_POINT_FOLLOW, target)
        DamageUnit(event)
    end
end

function TempleHealCollector(event)
    local caster = event.caster
    COverthrowGameMode.heal_collector = caster
end

function DamageAOESplitHeroLow(event)
    local caster = event.caster
    if caster:GetHealth()/caster:GetMaxHealth() < event.lowconditional / 100 then
        if not caster:HasModifier("modifier_fx_frost") then
            event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_fx_frost", nil)
        end
        DamageAOESplitHero(event)
    end
end

function TempleDelayBuff(event)
    local caster = event.caster
    if caster:GetHealth()/caster:GetMaxHealth() < event.maxhp and event.ability then
        event.ability:ApplyDataDrivenModifier(caster, caster, event.buff, nil)
    end
end

function TempleRandomArrowLaunch(event)
    local caster = event.caster
    local ability = event.ability
    local time = 2.25
    local speed = 1 / time

    local missiles = 4
    if event.missiles then
        missiles = event.missiles
    end

    if caster:GetHealth()/caster:GetMaxHealth() <= event.maxhp then
        event.range = math.random(400,625)
        EmitSoundOn("Ability.LightStrikeArray", caster)
        for i=1, missiles do
            local spot = RandomPointAroundUnit(event)
            local particle = ParticleManager:CreateParticle("particles/meteor_arrow.vpcf", PATTACH_ABSORIGIN, caster)
            ParticleManager:SetParticleControl(particle, 1, spot)
            ParticleManager:SetParticleControl(particle, 2, Vector(event.range*speed,0,0))
            Timers:CreateTimer(time+0.25, function()
                EmitSoundOn("Ability.TossImpact", caster)
                local particle2 = ParticleManager:CreateParticle("particles/units/heroes/hero_ember_spirit/ember_spirit_hit_fire.vpcf", PATTACH_ABSORIGIN, caster)
                ParticleManager:SetParticleControl(particle2, 0, spot)
                particle2 = ParticleManager:CreateParticle("particles/econ/items/wraith_king/wraith_king_ti6_bracer/wraith_king_ti6_hellfireblast_explosion.vpcf", PATTACH_ABSORIGIN, caster)
                ParticleManager:SetParticleControl(particle2, 3, spot)
                if particle then
                    ParticleManager:DestroyParticle(particle, true)
                end
                local tab = {}
                tab.caster = caster
                tab.target = caster
                tab.damage = 0.0
                tab.spelldamagefactor = 0.0
                tab.attributefactor = 0.0
                tab.difficultyscalelinear = 400
                tab.ability = ability
                tab.aoe = 250
                tab.targeteffect = "fire"
                tab.firedmg = 1
                tab.target_points = {}
                tab.target_points[1] = spot
                tab.onlyhero = 1
                DamageAOE(tab)
            end)
        end
    end
end

function RandomPointAroundUnit(event)
    local caster = event.caster
    local range = event.range
    local vec = RandomVector(1.0)
    return Vector(vec[1],vec[2],0):Normalized() * range + caster:GetAbsOrigin()
end

function GlobalLifesteal(event)
    local caster = event.caster
    event.target = caster
    local factor = 0
    --if caster:HasModifier("modifier_item_lifesteal_10") then
    --    factor = 0.10
    --end
    --if caster:HasModifier("modifier_item_shadowmourne") then
    --    factor = factor + 0.15
    --end
    if caster:HasModifier("modifier_lifesteal_100") then
        factor = factor + 1
    end
    if caster:HasModifier("modifier_item_shadowmourne_active") then
        factor = factor + 1.5
    end
    if caster:HasModifier("modifier_item_silverblood3_active") then
        factor = factor + 1
    end
    --if caster:HasModifier("modifier_item_crit_pure_2") then
    --    factor = factor + 0.15
    --end
    --if caster:HasModifier("modifier_item_crit_pure_4") then
    --    factor = factor + 0.15
    --end
    --if caster:HasModifier("modifier_item_crit_pure_3") then
    --    factor = factor + 0.15
    --end
    if caster:HasModifier("modifier_item_crit_pure_5_lifesteal") then
        factor = factor + 0.05
    end
    --if caster:HasModifier("modifier_deathwish") then
    --    factor = factor + 0.2
    --end
    --if caster.talents and caster.talents[40] and caster.talents[40] > 0 then
    --    factor = factor + 0.02 * caster.talents[40]
    --end
    --mythic
    --factor = factor + caster:GetModifierStackCount("modifier_mythic_lifesteal", nil) / 100

    --if caster:HasModifier("modifier_rogue_leech") and caster:GetAbilityByIndex(5) and caster:GetAbilityByIndex(5):GetLevel() >= 2 then
    --    factor = factor + 0.1
    --end
    --if caster:HasModifier("modifier_lifesteal_double") then
    --    factor = factor * 2
    --end
    if factor > 0 then
        event.heal = event.damage*factor
        event.damage = nil
        if event.heal > 0.5 then
            HealUnit(event)
        end
    end
end

function CheckBearEnrage(event)
    local caster = event.caster
    if not caster.bearform and caster:GetModifierStackCount("modifier_pvefrenzy_bear", nil) >= 50 then
        caster.bearform = true
        HideWearables(event)
        caster:SetModel("models/items/lone_druid/true_form/dark_wood_true_form/dark_wood_true_form.vmdl")
        caster:SetOriginalModel("models/items/lone_druid/true_form/dark_wood_true_form/dark_wood_true_form.vmdl")
        event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_lowest_aggro_hunt", nil)
    end
end

function DragonCouncilTP(event)
    local caster = event.caster
    local c1 = caster:GetAbsOrigin()
    if caster.dragoncouncil1 and caster and not caster:IsNull() and not caster.dragoncouncil1:IsNull() and (c1-caster.dragoncouncil1:GetAbsOrigin()):Length() > 2000 then
        caster.dragoncouncil1:SetAbsOrigin(c1+Vector(0,-50,0))
        local tab = {Duration = 0.1}
        event.ability:ApplyDataDrivenModifier(caster, caster.dragoncouncil1, "modifier_phased", tab)
        local particle = ParticleManager:CreateParticle("particles/econ/events/ti5/blink_dagger_start_smoke_ti5.vpcf", PATTACH_POINT_FOLLOW, caster.dragoncouncil1)
    end
    if caster.dragoncouncil2 and caster and not caster:IsNull() and not caster.dragoncouncil2:IsNull() and(c1-caster.dragoncouncil2:GetAbsOrigin()):Length() > 2000 then
        caster.dragoncouncil2:SetAbsOrigin(c1+Vector(0,-50,0))
        local tab = {Duration = 0.1}
        event.ability:ApplyDataDrivenModifier(caster, caster.dragoncouncil2, "modifier_phased", tab)
        local particle = ParticleManager:CreateParticle("particles/econ/events/ti5/blink_dagger_start_smoke_ti5.vpcf", PATTACH_POINT_FOLLOW, caster.dragoncouncil2)
    end
end

function Autocast(event)
    local caster = event.caster
    local target = event.target
    local ability = event.ability
    if ability:GetAutoCastState() and ability:GetCooldownTimeRemaining() <= 0.0 then
        ability:StartCooldown(ability:GetCooldown(0))
        ApplyBuff(event)
        EmitSoundOn("Hero_Ursa.Attack", target)
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_ursa/ursa_fury_sweep_cross.vpcf", PATTACH_POINT_FOLLOW, caster)
    end
end

function Retaliation(event)
    local caster = event.caster
    local stacks = caster:GetModifierStackCount("modifier_godschosen_2", caster) + event.dmg
    caster:SetModifierStackCount("modifier_godschosen_2", event.ability, stacks)
end

function WaveOfGlory(event)
    local caster = event.caster
    local target = event.target
    local ability = event.ability
    if target:GetTeamNumber() == caster:GetTeamNumber() then
        if ability:GetLevel() >= 4 and caster ~= target then
            local particle = ParticleManager:CreateParticle("particles/econ/events/ti6/hero_levelup_ti6_flash_hit_magic.vpcf", PATTACH_POINT_FOLLOW, target)
            event.heal = 0.0
            HealUnit(event)
        end
    else
        local particle = ParticleManager:CreateParticle("particles/econ/items/magnataur/shock_of_the_anvil/magnataur_shockanvil_hit.vpcf", PATTACH_POINT_FOLLOW, target)
        local myevent = {}
        myevent.caster = caster
        myevent.target = target
        myevent.dur = 0.1
        myevent.ability = ability
        SpellInterrupt(myevent)
        DamageUnit(event)
    end
end

function HolyBashMissile(event)
    local caster = event.caster
    local target = event.target
    local ability = event.ability
    local pos = target:GetAbsOrigin()
    local info = {
        Target = target,
        Source = caster,
        Ability = ability,
        EffectName = "particles/econ/items/phantom_lancer/phantom_lancer_immortal_ti6/phantom_lancer_immortal_ti6_spiritlance.vpcf",
        bDodgeable = true,
        bProvidesVision = true,
        iMoveSpeed = 600,
        iVisionRadius = 300,
        iVisionTeamNumber = caster:GetTeamNumber(),
        iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_HITLOCATION,
        vSpawnOrigin = pos
    }
    ProjectileManager:CreateTrackingProjectile( info )
end

function LinearMissileSetCustomSpawn(event)
    --DeepPrintTable(event)
    if event.caster then
        event.caster.customMissileSpawn = event.target
    end
end

function LinearMissileCustomSpawn(event)
    local caster = event.caster
    if caster and not caster:IsNull() and caster:IsAlive() and caster.customMissileSpawn and not caster.customMissileSpawn:IsNull() and caster.customMissileSpawn:IsAlive() and caster.customMissileSpawn ~= event.target then
        local origin = caster.customMissileSpawn:GetAbsOrigin()
        local targetpos = (event.target:GetAbsOrigin()-origin):Normalized()
        --A Liner Projectile must have a table with projectile info
        local info = 
        {
            Ability = event.ability,
            EffectName = event.EffectName,
            vSpawnOrigin = origin,--caster:GetAbsOrigin(),--origin,
            fDistance = 3000,
            fStartRadius = 100,
            fEndRadius = 100,
            Source = caster,
            bHasFrontalCone = false,
            bReplaceExisting = false,
            iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
            iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
            iUnitTargetType = DOTA_UNIT_TARGET_HERO,
            fExpireTime = GameRules:GetGameTime() + 60.0,
            bDeleteOnHit = false,
            vVelocity = targetpos * event.speed,
            bProvidesVision = true,
            iVisionRadius = 1000,
            iVisionTeamNumber = caster:GetTeamNumber()
        }
        local projectile = ProjectileManager:CreateLinearProjectile(info)
    end
end

function ForwardPosition(event)
    local caster = event.caster
    local target = event.target
    caster.eyebeamdummy = target
    local pos = caster:GetAbsOrigin() + caster:GetForwardVector()*event.range
    target:SetAbsOrigin(pos)
end

function EyeBeamPosUpdate(event)
    local caster = event.caster
    local target = caster.eyebeamdummy
    if target and not target:IsNull() then
        local pos = caster:GetAbsOrigin() + caster:GetForwardVector()*event.range
        target:SetAbsOrigin(pos)
        if caster.eyebeamdummyfx then
            local height = 137
            if caster:HasModifier("modifier_metamorph_dh") then
                height = 167
            end
            ParticleManager:SetParticleControl(caster.eyebeamdummyfx, 0, caster:GetAbsOrigin()+Vector(0,0,height))
            ParticleManager:SetParticleControl(caster.eyebeamdummyfx, 1, target:GetAbsOrigin()+Vector(0,0,100))
        end
    end
end

function EyeBeamFX(event)
    local caster = event.caster
    local target = caster.eyebeamdummy
    if target and not target:IsNull() then
        local particle = ParticleManager:CreateParticle("particles/eye_beam_2.vpcf", PATTACH_ABSORIGIN, target)
        caster.eyebeamdummyfx = particle
        --ParticleManager:SetParticleControlEnt(particle, 0, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", caster:GetAbsOrigin()+Vector(0,0,100), true)
        --ParticleManager:SetParticleControlEnt(particle, 1, target, PATTACH_POINT_FOLLOW, "attach_origin", target:GetAbsOrigin()+Vector(0,0,200), true)
        ParticleManager:SetParticleControl(particle, 0, caster:GetAbsOrigin()+Vector(0,0,137))
        ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin()+Vector(0,0,100))
        --ParticleManager:SetParticleControl(particle, 3, target:GetAbsOrigin()+Vector(0,0,200))
    end
end

function JumpToTarget(event)
    local caster = event.caster
    local target = event.target
    local condition = event.condition

    if condition and condition == 1 then
        local offset = target:GetForwardVector():Normalized()*95
        offset = Vector(offset[1], offset[2],0)
        caster:SetAbsOrigin(target:GetAbsOrigin()-offset)
        local tab = {}
        tab.Duration = 0.2
        event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_phased", tab)
        EmitSoundOn("Hero_Antimage.PreAttack", caster)
    end
end

function ShapeshiftDHEnd(event)
    local caster = event.caster
    -- to human
    --model change
    if COverthrowGameMode.EnableShapeshift == 1 then
        local model = "models/heroes/antimage/antimage.vmdl"
        caster:SetOriginalModel(model)
        caster:SetModelScale(1.0)
        ShowWearables(event)
        StartAnimation(caster, {activity=ACT_DOTA_RUN, duration=0.1, rate=1.0})
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_nevermore/nevermore_wings_dust_hit.vpcf", PATTACH_ABSORIGIN, caster)
    end
end

function ShapeshiftDH(event)
    local caster = event.caster

    --to meta
    --model change, only when synced
    if COverthrowGameMode.EnableShapeshift == 1 then
        local model = "models/items/terrorblade/dotapit_s3_fallen_light_metamorphosis/dotapit_s3_fallen_light_metamorphosis.vmdl"
        local scale = 0.8

        caster.old_model = caster:GetModelName()
        caster:SetOriginalModel(model)
        caster:SetModelScale(scale)
        HideWearables(event)
        StartAnimation(caster, {activity=ACT_DOTA_RUN, duration=0.1, rate=1.0})
    end
end

function StandStill(event)
    local caster = event.caster
    if caster:IsMoving() then
        caster.standsstill = 0
    else
        if caster.standsstill then
            caster.standsstill = caster.standsstill + 1
            if caster.standsstill >= 7 and caster.standsstill % 3 == 1 then
                local particle = ParticleManager:CreateParticle("particles/moon_light.vpcf", PATTACH_ABSORIGIN, caster)
                ParticleManager:SetParticleControlEnt(particle, 2, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), true)
            end
        else
            caster.standsstill = 1
        end
    end
end

function TalentArmorMinus(event)
    local caster = event.caster
    local target = event.target
    local ability = event.ability
    for i=1, caster.talents[43] do
        local myevent = { caster = caster, target = target, dur = 2.5, buff = "modifier_aa_minus_armordebuff", ability = ability}
        ApplyBuff(myevent)
    end
end

function GetRuneWordValue(rune1, rune2, rune3, weight)
    if rune1 < 1 or rune2 < 1 or rune3 < 1 then
        return 0
    end
    local number = (rune1 + rune2 + rune3) * weight

    if number <= 0 then
        return 0
    end
    if number < 1.0 then
        return 1
    end
    return math.floor(number + 0.5)
end

function PassiveStatCalculation(event)
    local hero = event.caster
    local ability = event.ability
    local dur = 10
    if hero.cheater then
        return
    end

    --rune words
    local fah = hero:GetModifierStackCount("modifier_runeword_fah", nil)
    local loo = hero:GetModifierStackCount("modifier_runeword_loo", nil)
    local wii = hero:GetModifierStackCount("modifier_runeword_wii", nil)
    local tal = hero:GetModifierStackCount("modifier_runeword_tal", nil)
    local nah = hero:GetModifierStackCount("modifier_runeword_nah", nil)
    local ser = hero:GetModifierStackCount("modifier_runeword_ser", nil)
    local time = hero:GetModifierStackCount("modifier_runeword_mine", nil)
    local tic = hero:GetModifierStackCount("modifier_runeword_tic", nil)
    local kil = hero:GetModifierStackCount("modifier_runeword_kil", nil)

    hero.runeword = {}
    hero.runeword[1] = GetRuneWordValue(  loo , nah , time, 100 / 30 )
    hero.runeword[2] = GetRuneWordValue(  wii , ser , time, 100/ 30 )
    hero.runeword[3] = GetRuneWordValue(  wii , tal , time, 20/ 30 )
    hero.runeword[4] = GetRuneWordValue(  wii , tal , tic, 35/ 30 )
    hero.runeword[5] = GetRuneWordValue(  fah , tal , time, 100/ 30 )
    hero.runeword[6] = GetRuneWordValue(  fah , nah , tic, 300/ 30 )
    hero.runeword[7] = GetRuneWordValue(  fah , ser , time, 175/ 30 )
    hero.runeword[8] = GetRuneWordValue(  fah , tal , kil, 25/ 30 )
    hero.runeword[9] = GetRuneWordValue(  loo , nah , kil, 3/ 30 )
    hero.runeword[10] = GetRuneWordValue(  fah , ser , kil, 125/ 30 )
    hero.runeword[11] = GetRuneWordValue(  loo , ser , time, 4/ 30 )
    hero.runeword[12] = GetRuneWordValue(  fah , tal , tic, 30/ 30 )
    hero.runeword[13] = GetRuneWordValue(  wii , ser , tic, 40/ 30 )
    hero.runeword[14] = GetRuneWordValue(  loo , nah , tic, 40/ 30 )
    hero.runeword[15] = GetRuneWordValue(  wii , tal , kil, 5/ 30 )
    hero.runeword[16] = GetRuneWordValue(  loo , tal , time, 50/ 30 )
    hero.runeword[17] = GetRuneWordValue(  wii , nah , tic, 50/ 30 )
    hero.runeword[18] = GetRuneWordValue(  loo , tal , tic, 50/ 30 )
    hero.runeword[19] = GetRuneWordValue(  wii , ser , kil, 15/ 30 )
    hero.runeword[20] = GetRuneWordValue(  wii , nah , kil, 5/ 30 )
    hero.runeword[21] = GetRuneWordValue(  fah , ser , tic, 3/ 30 )
    hero.runeword[22] = GetRuneWordValue(  fah , nah , time, 45/ 30 )
    hero.runeword[23] = GetRuneWordValue(  wii , nah , time, 45/ 30 )
    hero.runeword[24] = GetRuneWordValue(  fah , nah , kil, 50/ 30 )
    hero.runeword[25] = GetRuneWordValue(  loo , tal , kil, 50/ 30 )
    hero.runeword[26] = GetRuneWordValue(  loo , ser , tic, 60/ 30 )
    hero.runeword[27] = GetRuneWordValue(  loo , ser , kil, 20/ 30 )
    
    --send word over to panorama
    local runeword_id = 0
    local runepower = 0
    for j=1,48 do
        if hero.runeword[j] and hero.runeword[j] > 0 then
            runeword_id = j
        end
    end
    if runeword_id > 0 then
        runepower = hero.runeword[runeword_id]
        CustomGameEventManager:Send_ServerToAllClients("runewordequip", { word = runeword_id, power = runepower, playerid = hero:GetPlayerID() } )
    end

    for i=1,60 do
        local level = hero.talents[i]
        if level > 0 or i == 1 or i == 13 or i == 25 or (i == 18 and hero.runeword[6] > 0) or (i == 25 and hero.runeword[2] > 0) or (i == 5 and hero.runeword[3] > 0)
                or (i == 27 and hero.runeword[4] > 0) or (i == 16 and hero.runeword[8] > 0) or (i == 23 and hero.runeword[9] > 0) or (i == 30 and hero.runeword[10] > 0) or (i == 46 and hero.runeword[11] > 0) then
            if i == 1 then
                local buff = "modifier_strength"
                hero:RemoveModifierByName(buff)
                local value = hero:GetStrength() * (0.06 * level + 0.04 * hero.talents[38]) + hero.runeword[5] + hero.runeword[16]
                if hero:HasModifier("modifier_pala_str_bonus_check") then
                    value = value + hero:GetStrength() * 0.75
                end
                local ghost3 = hero:GetAbilityByIndex(2)
                if ghost3 and ghost3:GetLevel() >= 4 and ghost3:GetName() == "Ghost3" then
                    value = value + hero:GetStrength() * 0.3
                end
                if value >= 1 then
                    ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
                    hero:SetModifierStackCount(buff, ability, value)
                end
            end
            if i == 18 then
                local buff = "modifier_attackdamage"
                hero:RemoveModifierByName(buff)
                local value = hero:GetAttackDamage() * 0.05 * level + hero.runeword[6]
                ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
                hero:SetModifierStackCount(buff, ability, value)
            end
            if i == 5 then
                local buff = "modifier_armor"
                hero:RemoveModifierByName(buff)
                local value = hero:GetPhysicalArmorValue() * 0.08 * level + hero.runeword[3]
                ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
                hero:SetModifierStackCount(buff, ability, value)
            end
            if i == 10 then
                local buff = "modifier_health_armor"
                hero:RemoveModifierByName(buff)
                local value = level
                ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
                hero:SetModifierStackCount(buff, ability, value)
            end
            if i == 13 then
                local buff = "modifier_agility"
                hero:RemoveModifierByName(buff)
                local value = hero:GetAgility() * (0.06 * level + 0.04 * hero.talents[38]) + hero.runeword[1] + hero.runeword[16]
                local hawk5 = hero:GetAbilityByIndex(4)
                if hawk5 and hawk5:GetLevel() >= 4 and hawk5:GetName() == "hawk7" then
                    value = value + hero:GetAgility() * 0.25
                end
                local wind5 = hero:GetAbilityByIndex(4)
                if wind5 and wind5:GetLevel() >= 4 and wind5:GetName() == "wind5" then
                    value = value + hero:GetAgility() * 0.1
                end
                if hero:HasModifier("modifier_beastrage") then
                    local beast4 = hero:GetAbilityByIndex(3)
                    if beast4 and beast4:GetLevel() <= 2 then
                        value = value + hero:GetAgility() * 0.5
                    else
                        value = value + hero:GetAgility()
                    end
                end
                if value >= 1 then
                    ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
                    hero:SetModifierStackCount(buff, ability, value)
                end
                --print(hero:GetModifierStackCount("modifier_agility",nil))
                --print("agi"..hero:GetAgility())
                --hero:GetAgility()
            end
            if i == 14 then
                local buff = "modifier_movement"
                hero:RemoveModifierByName(buff)
                local value = level * 5
                ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
                hero:SetModifierStackCount(buff, ability, value)
            end
            if i == 15 then
                local buff = "modifier_attackspeed"
                hero:RemoveModifierByName(buff)
                local value = level * 20
                ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
                hero:SetModifierStackCount(buff, ability, value)
            end
            if i == 16 then
                local buff = "modifier_talent_crit"
                hero:RemoveModifierByName(buff)
                local value = level + hero.runeword[8]
                ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
                hero:SetModifierStackCount(buff, ability, value)
            end
            if i == 19 then
                local buff = "modifier_evasion"
                hero:RemoveModifierByName(buff)
                local value = level
                ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
                hero:SetModifierStackCount(buff, ability, value)
            end
            if i == 20 then
                local buff = "modifier_stand_still"
                ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
            end
            if i == 23 then
                local buff = "modifier_aa_starfall"
                hero:RemoveModifierByName(buff)
                local value = level + hero.runeword[9]
                ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
                hero:SetModifierStackCount(buff, ability, value)
            end
            if i == 25 then
                local buff = "modifier_intellect"
                hero:RemoveModifierByName(buff)
                local value = hero:GetIntellect() * 0.06 * level + hero.runeword[2]
                local ghost2 = hero:GetAbilityByIndex(1)
                if ghost2 and ghost2:GetLevel() >= 3 and ghost2:GetName() == "Ghost2" then
                    value = value + hero:GetIntellect() * 0.5
                end
                if value >= 1 then
                    ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
                    hero:SetModifierStackCount(buff, ability, value)
                end
            end
            if i == 26 then
                local value = hero:GetMaxMana() * 0.03 * level
                local myevent = {caster = hero, target = hero, amount = value}
                RestoreMana(myevent)
            end
            if i == 27 then
                local buff = "modifier_spellres"
                hero:RemoveModifierByName(buff)
                local value = level * 5 + hero.runeword[4]
                ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
                hero:SetModifierStackCount(buff, ability, value)
            end
            if i == 29 then
                local buff = "modifier_cast_firenova"
                hero:RemoveModifierByName(buff)
                local value = level
                ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
                hero:SetModifierStackCount(buff, ability, value)
            end
            if i == 30 then
                local buff = "modifier_talent_blizzard"
                hero:RemoveModifierByName(buff)
                local value = level + hero.runeword[10]
                ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
                hero:SetModifierStackCount(buff, ability, value)
            end
            if i == 34 then
                local buff = "modifier_talent_manasp"
                --hero:RemoveModifierByName(buff)
                --local value = level
                ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
                --hero:SetModifierStackCount(buff, ability, value)
            end
            if i == 39 then
                local value = 2 * level
                local fixedheal = 75 * level
                local myevent = {caster = hero, target = hero, percenthp = value, heal = fixedheal, cannotcrit = 1}
                HealUnit(myevent)
            end
            if i == 40 then
                local buff = "modifier_health_path"
                hero:RemoveModifierByName(buff)
                local value = level
                ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
                hero:SetModifierStackCount(buff, ability, value)
            end
            if i == 43 then
                local buff = "modifier_aa_minus_armortalent"
                hero:RemoveModifierByName(buff)
                local value = level
                ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
                hero:SetModifierStackCount(buff, ability, value)
            end
            if i == 46 then
                local buff = "modifier_talent_beastmaster"
                hero:RemoveModifierByName(buff)
                local value = level + hero.runeword[11]
                ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
                hero:SetModifierStackCount(buff, ability, value)
            end
            if i == 24 then
                local buff = "modifier_talent_glass_cannon"
                hero:RemoveModifierByName(buff)
                local value = level
                ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
                hero:SetModifierStackCount(buff, ability, value)
            end
            if i == 52 then
                local myevent = {}
                myevent.caster = hero
                myevent.target = hero
                myevent.buff = "modifier_talent_tiger_prowl"
                myevent.ability = ability
                myevent.dur = -1
                myevent.addstacks = 5
                myevent.max = 10
                ApplyBuffStack(myevent)
            end
        end
    end
end

function BloodwolfBuff(event)
    local caster = event.caster
    local ability = event.ability
    local amount = caster:GetModifierStackCount("modifier_talent_beastmaster", nil)
    for i=1,amount do
        ability:ApplyDataDrivenModifier(caster, caster, "modifier_bloodwolf_buff", {Duration = 15})
    end
end

function RampUpDamage(event)
    local caster = event.target
    local tick = event.percent
    if not caster.rampupdamage then
        caster.rampupdamage = tick
    else
        caster.rampupdamage = caster.rampupdamage + tick
    end
    if caster.rampupdamage > 1.0 then
        caster.rampupdamage = 1.0
    end
end

function IsImmortal(hero)
    if hero:HasModifier("modifier_godschosen") or hero:HasModifier("modifier_invul") or hero:HasModifier("modifier_eternallife") or hero:HasModifier("modifier_totem_life_buff") or hero:HasModifier("modifier_last_stand")
         or hero:HasModifier("x") or hero:HasModifier("y") then
        return true
    end
    return false
end

function SetElementalItem(event)
    event.caster.elemental_item3 = event.ability
end

function AddAbilityToUnit(event)
    local caster = event.target
    caster:AddAbility(event.abil):SetLevel(1)
end

function SetModelForModel(event)
    local caster = event.target
    caster:SetModel(event.model)
    caster:SetOriginalModel(event.model)
end

function BlizzardEffect(event)
    local caster = event.target
    local pos = caster:GetAbsOrigin()
    local distance = event.aoe / 2
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_explosion.vpcf", PATTACH_WORLDORIGIN, caster)
    ParticleManager:SetParticleControl(particle, 0, pos)
    pos = pos + Vector(distance,0,0)
    particle = ParticleManager:CreateParticle("particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_explosion.vpcf", PATTACH_WORLDORIGIN, caster)
    ParticleManager:SetParticleControl(particle, 0, pos)
    pos = pos + Vector(-2*distance,0,0)
    particle = ParticleManager:CreateParticle("particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_explosion.vpcf", PATTACH_WORLDORIGIN, caster)
    ParticleManager:SetParticleControl(particle, 0, pos)
    pos = pos + Vector(distance,distance,0)
    particle = ParticleManager:CreateParticle("particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_explosion.vpcf", PATTACH_WORLDORIGIN, caster)
    ParticleManager:SetParticleControl(particle, 0, pos)
    pos = pos + Vector(0,-2*distance,0)
    particle = ParticleManager:CreateParticle("particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_explosion.vpcf", PATTACH_WORLDORIGIN, caster)
    ParticleManager:SetParticleControl(particle, 0, pos)
end

function ProtCounterBlow(event)
    local caster = event.caster
    if caster:HasModifier("modifier_shieldbash") and caster.q_level and caster.q_level >= 3 then
        ApplyBuffStack(event)
    end
end

function ProtCounterBlowSetLevel(event)
    local caster = event.caster
    caster.q_level = event.ability:GetLevel()
end

function BossAOESpells(event)
    local caster = event.caster
    local ability = event.ability
    local pos = caster:GetAbsOrigin()
    local aoetype = event.aoetype
    local aoe = event.aoe
    local startdelay = event.startdelay
    local tickdelay = event.tickdelay
    local movement = event.movement
    local lifetimeinticks = event.lifetimeinticks
    local aoefx = "particles/econ/items/centaur/centaur_ti6/centaur_ti6_warstomp.vpcf"
    local sound = "Hero_Tiny.Attack"
    local warningfx = event.warningfx
    local warningfxpath = "particles/econ/items/earthshaker/egteam_set/hero_earthshaker_egset/earthshaker_echoslam_start_egset.vpcf"
    local aoeamount = event.aoeamount
    local dmg = event.dmg
    if event.theme == "rock" then
        aoefx = "particles/units/heroes/hero_centaur/centaur_warstomp.vpcf"
    end
    if event.theme == "water" then
        aoefx = "particles/econ/items/kunkka/divine_anchor/hero_kunkka_dafx_skills/kunkka_spell_torrent_splash_fxset.vpcf"
        sound = "hero_Crystal.projectileImpact"--"Ability.GushCast"
        warningfxpath = "particles/econ/items/kunkka/divine_anchor/hero_kunkka_dafx_skills/kunkka_spell_torrent_splash_fxset.vpcf"
    end
    if event.theme == "frost" then
        aoefx = "particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_explosion.vpcf"
        sound = "hero_Crystal.projectileImpact"
        warningfxpath = "particles/econ/items/crystal_maiden/crystal_maiden_cowl_of_ice/maiden_crystal_nova_cowlofice.vpcf"
    end
    if event.rootboss then
        caster:ApplyDataDrivenModifier(caster, caster, "modifier_rooted", {Duration = event.rootboss})
    end
    if warningfx then
        EmitSoundOn("DOTA_Item.HeavensHalberd.Activate", caster)
        local particle = ParticleManager:CreateParticle(warningfxpath, PATTACH_ABSORIGIN_FOLLOW, caster)
        ParticleManager:SetParticleControl(particle, 1, Vector(600,1,1))
    end
    for j=1,aoeamount do
        Timers:CreateTimer(startdelay, function()
            if aoetype == "outercircle_innercircle" then
                local radius = 600
                local offset_start = math.random(0,359)
                for i=1, lifetimeinticks do
                    Timers:CreateTimer(tickdelay*(i-1), function()
                        if i > lifetimeinticks / 2 then
                            radius = 200
                        end
                        local strikepos = pos + Vector(radius*math.cos(math.rad(offset_start+2*i*360/lifetimeinticks)), radius*math.sin(math.rad(offset_start+2*i*360/lifetimeinticks)), 0)
                        local particle = ParticleManager:CreateParticle(aoefx, PATTACH_WORLDORIGIN, caster)
                        ParticleManager:SetParticleControl(particle, 0, strikepos)
                        ParticleManager:SetParticleControl(particle, 1, Vector(aoe,aoe,aoe))
                        EmitSoundOn(sound, caster)
                        local tab = {}
                        tab.caster = caster
                        tab.damage = 0.0
                        tab.spelldamagefactor = 0.0
                        tab.attributefactor = 0.0
                        tab.includeauto = dmg
                        tab.ability = ability
                        tab.aoe = aoe
                        tab.targeteffect = "blood"
                        tab.onlyhero = 1
                        tab.target_points = {}
                        tab.target_points[1] = strikepos
                        DamageAOE(tab)
                    end)
                end
            end
            if aoetype == "spiral_in_random" then
                local offset_start = math.random(0,359)
                local strikepos = pos
                for i=1, lifetimeinticks do
                    Timers:CreateTimer(tickdelay*(lifetimeinticks-i), function()
                        strikepos = strikepos + Vector((i-1)*movement*math.cos(math.rad(offset_start+i*20)), (i-1)*movement*math.sin(math.rad(offset_start+i*20)), 0)
                        local particle = ParticleManager:CreateParticle(aoefx, PATTACH_WORLDORIGIN, caster)
                        ParticleManager:SetParticleControl(particle, 0, strikepos)
                        ParticleManager:SetParticleControl(particle, 1, Vector(aoe,aoe,aoe))
                        EmitSoundOn(sound, caster)
                        local tab = {}
                        tab.caster = caster
                        tab.damage = 0.0
                        tab.spelldamagefactor = 0.0
                        tab.attributefactor = 0.0
                        tab.includeauto = dmg
                        tab.ability = ability
                        tab.aoe = 225
                        tab.targeteffect = "blood"
                        tab.onlyhero = 1
                        tab.target_points = {}
                        tab.target_points[1] = strikepos
                        DamageAOE(tab)
                    end)
                end
            end
            if aoetype == "spiral_out_random" then
                local offset_start = math.random(0,359)
                local strikepos = pos
                for i=1, lifetimeinticks do
                    Timers:CreateTimer(tickdelay*(i-1), function()
                        strikepos = strikepos + Vector(i*movement*math.cos(math.rad(offset_start+i*20)), i*movement*math.sin(math.rad(offset_start+i*20)), 0)
                        local particle = ParticleManager:CreateParticle(aoefx, PATTACH_WORLDORIGIN, caster)
                        ParticleManager:SetParticleControl(particle, 0, strikepos)
                        ParticleManager:SetParticleControl(particle, 1, Vector(aoe,aoe,aoe))
                        EmitSoundOn(sound, caster)
                        local tab = {}
                        tab.caster = caster
                        tab.damage = 0.0
                        tab.spelldamagefactor = 0.0
                        tab.attributefactor = 0.0
                        tab.includeauto = dmg
                        tab.ability = ability
                        tab.aoe = 225
                        tab.targeteffect = "blood"
                        tab.onlyhero = 1
                        tab.target_points = {}
                        tab.target_points[1] = strikepos
                        DamageAOE(tab)
                    end)
                end
            end
            if aoetype == "from_out_inwards" then
                local offset_start = math.random(0,359)
                local strikepos = pos + Vector(1500*math.cos(math.rad(offset_start)), 1500*math.sin(math.rad(offset_start)), 0)
                local direction = (pos - strikepos):Normalized()
                for i=1, lifetimeinticks do
                    Timers:CreateTimer(tickdelay*(i-1), function()
                        strikepos = strikepos + i*movement*direction
                        local particle = ParticleManager:CreateParticle(aoefx, PATTACH_WORLDORIGIN, caster)
                        ParticleManager:SetParticleControl(particle, 0, strikepos)
                        ParticleManager:SetParticleControl(particle, 1, Vector(aoe,aoe,aoe))
                        EmitSoundOn(sound, caster)
                        local tab = {}
                        tab.caster = caster
                        tab.damage = 0.0
                        tab.spelldamagefactor = 0.0
                        tab.attributefactor = 0.0
                        tab.includeauto = dmg
                        tab.ability = ability
                        tab.aoe = 225
                        tab.targeteffect = "blood"
                        tab.onlyhero = 1
                        tab.target_points = {}
                        tab.target_points[1] = strikepos
                        DamageAOE(tab)
                    end)
                end
            end
            if aoetype == "random" then
                local offset_start = math.random(0,359)
                local strikepos = pos + Vector(math.random(150,200)*math.cos(math.rad(offset_start)), math.random(150,200)*math.sin(math.rad(offset_start)), 0)
                for i=1, lifetimeinticks do
                    Timers:CreateTimer(tickdelay*(i-1), function()
                        strikepos = strikepos + movement*Vector(math.random(0,100),math.random(0,100),0)/100
                        local particle = ParticleManager:CreateParticle(aoefx, PATTACH_WORLDORIGIN, caster)
                        ParticleManager:SetParticleControl(particle, 0, strikepos)
                        ParticleManager:SetParticleControl(particle, 1, Vector(aoe,aoe,aoe))
                        EmitSoundOn(sound, caster)
                        local tab = {}
                        tab.caster = caster
                        tab.damage = 0.0
                        tab.spelldamagefactor = 0.0
                        tab.attributefactor = 0.0
                        tab.includeauto = dmg
                        tab.ability = ability
                        tab.aoe = 225
                        tab.targeteffect = "blood"
                        tab.onlyhero = 1
                        tab.target_points = {}
                        tab.target_points[1] = strikepos
                        DamageAOE(tab)
                    end)
                end
            end
        end)
    end
end

function HeartBuffItem( event )
    local caster = event.caster
    local target = event.target
    if event.target ~= event.caster then
        event.ability:ApplyDataDrivenModifier(caster, target, event.buff, {Duration = 45})
    end
end

function TalentOnAttacked( event )
    local caster = event.caster
    local attacker = event.attacker
    if caster.talents and caster.talents[12] and caster.talents[12] > 0 then
        local talent_level = caster.talents[12]
        if math.random(1,100) <= 2 * talent_level then
            local particle = ParticleManager:CreateParticle("particles/items_fx/necronomicon_spawn_warrior.vpcf", PATTACH_POINT_FOLLOW, attacker)
            local myevent = {}
            myevent.caster = caster
            myevent.target = attacker
            myevent.ability = event.ability
            myevent.damage = 0.0
            myevent.spelldamagefactor = 0.0
            myevent.attributefactor = 0.0
            myevent.counterblow = 25
            DamageUnit(myevent)
            local myevent2 = {}
            myevent2.caster = caster
            myevent2.target = attacker
            myevent2.buff = "modifier_stunned"
            myevent2.ability = event.ability
            myevent2.dur = 2
            ApplyBuff(myevent2)
        end
    end
end

function TalentOnAttack( event )
    local caster = event.caster
    local target = event.target
    if caster.talents and caster.talents[53] and caster.talents[53] > 0 then
        local talent_level = caster.talents[53]
        if math.random(1,100) <= 1 * talent_level then
            for i=1, 5 do
                Timers:CreateTimer(0.15*i, function()
                    caster:PerformAttack(target, true, true, true, true, true, false, false)
                end)
            end
        end
    end
end

function OnApplyDebuff(event)
    local caster = event.caster
    local target = event.target
    if caster.talents and caster.talents[49] and caster.talents[49] > 0 then
        local myevent = {}
        myevent.caster = caster
        myevent.target = target
        myevent.ability = event.ability
        myevent.damage = 0.0
        myevent.spelldamagefactor = 0.0
        myevent.attributefactor = 10 * caster.talents[49]
        Timers:CreateTimer(0.01*math.random(25,75), function()
            DamageUnit(myevent)
        end)
    end
end






