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
    if not caster:IsRealHero() then
        return 0
    end
	local mods = caster:GetModifierCount()-1
	for i=0, mods do
		local name = caster:GetModifierNameByIndex(i)
		--print(name)
		if name == "modifier_item_set_int_dmg_full" then
    		factor = factor + 0.1
	    end
        if name == "modifier_item_set_int_dmg_full_2" then
            factor = factor + 0.1
        end
        if name == "modifier_item_set_int_dmg_full_2_dream" then
            factor = factor + 0.15
            spelldamagefromitem = spelldamagefromitem + 125
        end
        if name == "modifier_item_set_int_dmg_full_2_dream_2" then
            factor = factor + 0.15
            spelldamagefromitem = spelldamagefromitem + 250
        end
        if name == "modifier_item_set_int_dmg_full_2" then
            spelldamagefromitem = spelldamagefromitem + 25
        end
        if name == "modifier_item_sp25" then
            spelldamagefromitem = spelldamagefromitem + 50
        end
        if name == "modifier_stormrider" then
            spelldamagefromitem = spelldamagefromitem + 75
        end
        if name == "modifier_item_shadowstrike" then
            spelldamagefromitem = spelldamagefromitem + 75
        end
        if name == "modifier_pathbuff_003" then
            spelldamagefromitem = spelldamagefromitem + 100
        end
        if name == "modifier_item_ancient_dragon" then
            spelldamagefromitem = spelldamagefromitem + 80
        end
        if name == "modifier_ancient_allstats" then
            spelldamagefromitem = spelldamagefromitem + 100
        end
        if name == "modifier_item_dreihander_2" then
            spelldamagefromitem = spelldamagefromitem + 200
        end
        if name == "modifier_class_darkseer" then
            spelldamagefromitem = spelldamagefromitem + 125
        end
        --if name == "modifier_pathbuff_064" then
        --    spelldamagefromitem = spelldamagefromitem + 250
        --end
		if name == "modifier_item_caster5" then
    		spelldamagefromitem = spelldamagefromitem + 12
	    end
	    if name == "modifier_item_sprecipe" then
    		spelldamagefromitem = spelldamagefromitem + 5
	    end
	    if name == "modifier_item_sp" then
    		spelldamagefromitem = spelldamagefromitem + 2
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
            --local ancient = 1
            --if caster:HasModifier("modifier_item_winterbreeze4") then
            --    ancient = 1.5
            --end
            spelldamagefromitem = spelldamagefromitem + 0.005 * caster:GetMana() * caster.talents[34]
        end
        if name == "modifier_item_winterbreeze3" then
            spelldamagefromitem = spelldamagefromitem + 0.01 * caster:GetMana()
        end
	    if name == "modifier_item_endgame4" then
	    	spelldamagefromitem = spelldamagefromitem + 50
	    end
	    if name == "modifier_item_nova_blade_shadow" then
	    	spelldamagefromitem = spelldamagefromitem + 40
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
	    	spelldamagefromitem = spelldamagefromitem + 5
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
            spelldamagefromitem = spelldamagefromitem + 5
        end
	    if name == "modifier_item_aether_lens" then
	    	spelldamagefromitem = spelldamagefromitem + 12
	    end
	    if name == "modifier_item_shadowmourne" then
	    	spelldamagefromitem = spelldamagefromitem + 25
	    end
        if name == "modifier_aura_sp_immo" then
            spelldamagefromitem = spelldamagefromitem + 50
        end
        if name == "modifier_item_elements3" then
            spelldamagefromitem = spelldamagefromitem + 25
        end
        if name == "modifier_item_aura_ancient" then
            spelldamagefromitem = spelldamagefromitem + 25
        end
        if name == "modifier_item_aura_sp_immo" then
            spelldamagefromitem = spelldamagefromitem + 50
        end
        if name == "modifier_item_sp4" then
            spelldamagefromitem = spelldamagefromitem + 125
        end
        if name == "modifier_item_set_int_t3_2_full" then
            spelldamagefromitem = spelldamagefromitem + 60
        end
        if name == "modifier_item_set_int_t3_1_2" then
            spelldamagefromitem = spelldamagefromitem + 50
        end
	    if name == "modifier_shaman_sp_buff" then
	    	spelldamagefromitem = spelldamagefromitem + 5
            factor = factor + 0.15
	    end
	    if name == "modifier_elemental_sp" then
	    	spelldamagefromitem = spelldamagefromitem + caster:GetModifierStackCount("modifier_elemental_sp", nil)
	    end
        if name == "modifier_mythic_sp" then
            spelldamagefromitem = spelldamagefromitem + caster:GetModifierStackCount("modifier_mythic_sp", nil)
        end
	    if name == "modifier_item_set_int_dmg_1" then
	    	spelldamagefromitem = spelldamagefromitem + 10
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
        if name == "modifier_item_frostfire2" then
            spelldamagefromitem = spelldamagefromitem + 30
        end
        if name == "modifier_item_spellhaste_2" then
            spelldamagefromitem = spelldamagefromitem + 20
        end
        if name == "modifier_itemhaste50" then
            spelldamagefromitem = spelldamagefromitem + 20
        end
        if name == "modifier_spellblood" then
            spelldamagefromitem = spelldamagefromitem + 100
            factor = factor + 0.1
        end
        if name == "modifier_item_item_set_t4_sp_1" then
            spelldamagefromitem = spelldamagefromitem + 50
        end
        if name == "modifier_item_item_set_t4_sp_2" then
            spelldamagefromitem = spelldamagefromitem + 50
        end
        if name == "modifier_item_item_set_t4_sp_3" then
            spelldamagefromitem = spelldamagefromitem + 100
        end
        if name == "modifier_item_item_set_t4_new_3" then
            spelldamagefromitem = spelldamagefromitem + 85
        end
        if name == "modifier_item_item_set_t4_new_4" then
            spelldamagefromitem = spelldamagefromitem + 85
        end
        if name == "modifier_item_spellpower_stack" then
            local spproc = caster:GetModifierStackCount("modifier_item_spellpower_stack", nil)
            spelldamagefromitem = spelldamagefromitem + spproc
        end
        if name == "modifier_pathbuff_031" then
            spelldamagefromitem = spelldamagefromitem + 100
        end
        if name == "modifier_item_myth_sp" then
            spelldamagefromitem = spelldamagefromitem + 400
        end
        if name == "modifier_pathbuff_080" then
            spelldamagefromitem = spelldamagefromitem + 150
        end
	end
    --talents
    local astral_talent_allstats = caster:FindAbilityByName("moon6")
    if not astral_talent_allstats then
        astral_talent_allstats = caster:FindAbilityByName("moon6Temple")
    end
    if astral_talent_allstats and astral_talent_allstats:GetLevel() >= 3 then
        spelldamagefromitem = spelldamagefromitem + GetStrengthCustom(caster) + caster:GetAgility()
    end
    astral_talent_allstats = caster:FindAbilityByName("Guardian")
    if astral_talent_allstats and astral_talent_allstats:GetLevel() >= 4 then
        spelldamagefromitem = spelldamagefromitem + 0.75 * GetStrengthCustom(caster)
    end
    --runeword
    if caster.runeword and caster.runeword[7] then
        spelldamagefromitem = spelldamagefromitem + caster.runeword[7]
    end
    if caster:HasModifier("modifier_item_item_set_t4_sp_4") then
        spelldamagefromitem = spelldamagefromitem + 200
        factor = factor + 0.1
    end
    if caster:HasModifier("modifier_item_item_set_t4_sp_5") then
        spelldamagefromitem = spelldamagefromitem + 300
        factor = factor + 0.1
    end
    if caster:HasModifier("modifier_path_shadowform") and caster:HasModifier("modifier_pathbuff_073") then
        factor = factor + 0.15
    end
    if caster:HasModifier("modifier_item_spellpower_knowledge") then
        factor = factor + 0.5
    end
    if caster.talents then
        if caster.talents[31] then
            factor = factor + 0.1 * caster.talents[31]
        end
        if caster.talents[62] then
            spelldamagefromitem = spelldamagefromitem + 0.03 * caster.talents[62] * (GetStrengthCustom(caster) + caster:GetAgility() + GetIntellectCustom(caster))
        end
        if caster.talents[2] and caster.talents[2] > 0 then
            spelldamagefromitem = spelldamagefromitem + 25 * caster.talents[2]
        end
        if caster.talents[80] and caster.talents[80] > 0 then
            local bonusfromms = caster:GetMoveSpeedModifier(caster:GetBaseMoveSpeed()) - 300
            bonusfromms = bonusfromms * 0.5 * caster.talents[80]
            if bonusfromms > 0 then
                spelldamagefromitem = spelldamagefromitem + bonusfromms
            end
        end
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
    local isaoe = false
    local pure_dmg = false
    if event.puredmg then
    	pure_dmg = true
    end
    local pvescale = 1
    if caster and not caster:IsNull() and caster.pvescale then
        pvescale = caster.pvescale
    end
    if event.isaoe and event.isaoe >= 1 then
        isaoe = true
    end
    if event.changedamagetoselfcaused then
        caster = target
    end
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
	if event.ignore_when_target_has_reflect and HasDamageReflect(target) then
		return
	end
    if (event.fromcompanion or event.fromsummon) and target and HasDamageReflect(target) then
        return
    end
    if event.ontakedamage or event.ontakedamagenew then
        caster = event.unit
        target = event.attacker
        if event.ontakedamagenew then
            caster = event.caster
        end
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
    	if not event.whiledead then
        	return
        end
        if caster:IsNull() then
        	return
        end
    end
    if event.movedenydmg and target:IsMoving() then
        return
    end
    if event.movedenydmg then
        local particle = ParticleManager:CreateParticle("particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_shadowraze.vpcf", PATTACH_POINT_FOLLOW, target)
        ParticleManager:ReleaseParticleIndex(particle)
        EmitSoundOn("Hero_Lina.DragonSlave", target)
    end
    if event.nodmgbuffcondition and target and target:HasModifier("fire_save_zone") then
        EmitSoundOn("Item.CrimsonGuard.Cast", target)
        local particle = ParticleManager:CreateParticle("particles/items3_fx/lotus_orb_reflect.vpcf", PATTACH_POINT_FOLLOW, target)
        ParticleManager:ReleaseParticleIndex(particle)
        return
    end
    if event.dmgonbuffcondition and target then
        if not caster:HasModifier(event.dmgonbuffcondition) or caster:GetAbilityByIndex(1):GetLevel() < 4 then
            return
        end
    end
    if event.zonecondition and target and ((target:HasModifier("modifier_farring_buff") and not target:HasModifier("modifier_midring_buff")) or ( not target:HasModifier("modifier_farring_buff") and target:HasModifier("modifier_midring_buff")) ) then
        EmitSoundOn("Item.CrimsonGuard.Cast", target)
        local particle = ParticleManager:CreateParticle("particles/items3_fx/lotus_orb_reflect.vpcf", PATTACH_POINT_FOLLOW, target)
        ParticleManager:ReleaseParticleIndex(particle)
        return
    end
    if event.poisondmg then
        event.naturedmg = 1
    end
    if event.naturedmg then
        event.poisondmg = 1
    end
    local passive_ability
    if caster.talents then
        passive_ability = caster.combat_system_ability
    end
    local distance = (caster:GetAbsOrigin()-target:GetAbsOrigin()):Length()
    if distance > 2500 and not caster.trap_timer and caster:IsRealHero() then
        return
    end
    if target:HasModifier("modifier_pve_act_affix_reflexes") and distance > 600 then
        return
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

    local attribute_scaling = 0
    local damage_scaling = 0
    local auto_attack_damage_scaling = 0
    local spelldamage_scaling = 0
    if event.attributefactor then
        attribute_scaling = event.attributefactor
    end
    if event.includeauto then
        damage_scaling = event.includeauto
    end
    if event.includefullauto then
        auto_attack_damage_scaling = event.includefullauto
    end
    if event.spelldamagefactor then
        spelldamage_scaling = event.spelldamagefactor
    end


    --update scalings before calc, important for threshold based triggers
    local scaling_factor = 1
    if event.deadlypoisonstack ~= nil then
        local stack = target:GetModifierStackCount("modifier_deadlypoison", nil)
        scaling_factor = scaling_factor * stack
    end
    if event.talentscale and caster.talents[event.talentscale] and caster.talents[event.talentscale] > 0 then
        scaling_factor = scaling_factor * caster.talents[event.talentscale]
    end
    -- based on bleed dot stacks
    if event.feralbleedstack ~= nil then
        scaling_factor = scaling_factor * event.feralbleedstack
    end
    if event.feralcombopointbased ~= nil then
        scaling_factor = scaling_factor * caster.FeralFinisher
    end
    if scaling_factor > 1 then
        attribute_scaling = attribute_scaling * scaling_factor
        damage_scaling = damage_scaling * scaling_factor
        auto_attack_damage_scaling = auto_attack_damage_scaling * scaling_factor
        spelldamage_scaling = spelldamage_scaling * scaling_factor
    end

    if event.enemyhealth then
    	if not target:HasModifier("modifier_pvebosssystem") then
    		event.damage = target:GetHealth()*event.enemyhealth/100.0
    	else
    		event.damage = target:GetHealth()*event.enemyhealth/100.0
    	end
    end

    -- warlock souls
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
	if damage_scaling > 0 then
        local retri_bonus = 0
        if caster:HasModifier("modifier_retri_crit") then
            retri_bonus = 0.5
        end
    	event.damage = caster:GetAttackDamage()*(retri_bonus + damage_scaling/100)
    end
    --include green aa damage
    if auto_attack_damage_scaling > 0 then
        event.damage = event.damage + caster:GetAverageTrueAttackDamage(caster) * auto_attack_damage_scaling / 100 
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

    if event.difficultyscale and pvescale and COverthrowGameMode.player_count_scale then
        local weaken = 1.0
        if COverthrowGameMode.jungledifficulty >= 20.0 then 
            weaken = 0.75
        end
        if COverthrowGameMode.jungledifficulty >= 500.0 then 
            weaken = weaken * 0.6
        end
        event.damage = event.difficultyscale * 0.75 + (event.difficultyscale * pvescale * 0.5)
        event.damage = event.damage * COverthrowGameMode.player_count_scale * weaken
    end
    if event.difficultyscalelinear and pvescale and COverthrowGameMode.player_count_scale then
        local weaken = 1.0
        if COverthrowGameMode.jungledifficulty >= 20.0 then 
            weaken = 0.75
        end
        if COverthrowGameMode.jungledifficulty >= 500.0 then 
            weaken = weaken * 0.6
        end
        event.damage = event.difficultyscalelinear * pvescale
        event.damage = event.damage * COverthrowGameMode.player_count_scale * weaken
    end

    local finaldamage = event.damage

    if event.adjustdamage then
        finaldamage = finaldamage * event.adjustdamage
    end

    if event.retaliationstacks then
        finaldamage = finaldamage + caster:GetModifierStackCount("modifier_godschosen_2", nil)*event.retaliationstacks/100
        if finaldamage > caster:GetMaxHealth()*2 then
            finaldamage = caster:GetMaxHealth()*2
        end
    end
    -- Spelldamage
    local spelldamagefromitem = 0
    if caster and caster.spelldamage == nil then
    	caster.spelldamage = 0.0
    end
    if spelldamage_scaling > 0.0 and caster.spellpower then
    	spelldamagefromitem = caster.spellpower
    	finaldamage = event.damage + spelldamage_scaling*spelldamagefromitem/100.0
    end
    --stat scaling
    if caster:IsHero() then
    	if event.attributechangeint ~= nil then
    		finaldamage = finaldamage + GetIntellectCustom(caster)*attribute_scaling/100.0
    	elseif event.attributechangestr ~= nil then
    		finaldamage = finaldamage + GetStrengthCustom(caster)*attribute_scaling/100.0
    	elseif event.attributechangeagi ~= nil then
    		finaldamage = finaldamage + caster:GetAgility()*attribute_scaling/100.0
    	elseif event.attributechangeall ~= nil then
    		finaldamage = finaldamage + caster:GetAgility()*attribute_scaling/100.0 + GetStrengthCustom(caster)*attribute_scaling/100.0 + GetIntellectCustom(caster)*attribute_scaling/100.0
        elseif event.attributechangestragi ~= nil then
            finaldamage = finaldamage + caster:GetAgility()*attribute_scaling/100.0 + GetStrengthCustom(caster)*attribute_scaling/100.0
    	else
    		finaldamage = finaldamage + GetPrimaryStatValueCustom(caster)*attribute_scaling/100.0
    	end
	end

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

    if event.maxmanabonus and event.maxmanabonus > 0 then
        finaldamage = finaldamage + caster:GetMana()*event.maxmanabonus/100
    end

    if event.changefiredmgtoarcane then
        if event.changefiredmgtoarcane == 1 then
            event.firedmg = nil
            event.arcanedmg = 1
            EmitSoundOn("Hero_Invoker.EMP.Cast", target)
        else
            EmitSoundOn("Hero_Invoker.ChaosMeteor.Impact", target)
        end
    end

    if event.shieldbashbonus then
        finaldamage = finaldamage * ( 1 + 0.1*event.shieldbashbonus)
    end
    local fury_stacks = caster:GetModifierStackCount("modifier_furyas", nil)
    if event.furyexedamage and fury_stacks > 0 then
        finaldamage = finaldamage * (1 + 0.05 * fury_stacks)
    end
    if event.arcanepowerbonusdot ~= nil then
        finaldamage = caster.ArcanePowerDot * event.arcanepowerbonusdot / 100
    end

    if event.shadoworb then
        local bonusfactor = target:GetModifierStackCount("modifier_swd", nil)
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

    if event.stackthresholdbased then
        local max = event.stackthresholdbased
        local bonusfactor = target:GetModifierStackCount(event.stackbasedbuff, nil) / max
        if bonusfactor < 1.0 then
            finaldamage = 0.0
        end
    end
    
    if event.stackthresholdbasedfactor then
        local max = event.stackthresholdbasedfactor
        local bonusfactor = target:GetModifierStackCount(event.stackbasedbuff, nil) / max
        if bonusfactor >= 1.0 then
            print("here")
            finaldamage = finaldamage * event.stackthresholdbaseddamagefactor
            print(finaldamage)
        end
    end

    if event.rangerexecute then
        if  target:GetHealth()/target:GetMaxHealth() < 0.5 then
            finaldamage = finaldamage * (1 + event.rangerexecute/100)
            local particle = ParticleManager:CreateParticle("particles/econ/items/gyrocopter/hero_gyrocopter_gyrotechnics/gyro_death_explosion.vpcf", PATTACH_POINT_FOLLOW, target)
            particle = ParticleManager:CreateParticle("particles/units/heroes/hero_skeletonking/skeletonking_mortalstrike_explosion.vpcf", PATTACH_POINT_FOLLOW, target)
            ParticleManager:SetParticleControl(particle, 2, target:GetAbsOrigin())
            ParticleManager:ReleaseParticleIndex(particle)
        end
    end
    if event.execute ~= nil then
        if target:GetHealth()/target:GetMaxHealth() < 0.5 then
            finaldamage = finaldamage * (1 + event.execute/100)
        end 
    end

    if event.warlockagony ~= nil then
        finaldamage = 0.2*finaldamage*caster.AgonyCounter
    end

    local winter_chills = caster:GetModifierStackCount("modifier_winterschill", nil)
    if event.icelance and (winter_chills >= 2 or target:HasModifier("modifier_icenova") or target:HasModifier("modifier_deepfreeze") or target:HasModifier("modifier_icenova_slow")) then
        if not (target:HasModifier("modifier_icenova") or target:HasModifier("modifier_deepfreeze") or target:HasModifier("modifier_icenova_slow")) then
            caster:RemoveModifierByName("modifier_winterschill")
        end
        finaldamage = finaldamage * 3
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_ancient_apparition/ancient_apparition_ice_blast_death.vpcf", PATTACH_POINT_FOLLOW, target)
        ParticleManager:ReleaseParticleIndex(particle)
    end

    --cp based scaling
    if event.cpbaseddmg then
        finaldamage = finaldamage * caster.cpbaseddmg
    end
    --pve scaling
    if event.pvescale then
        finaldamage = finaldamage * pvescale
    end
    if event.damage_scale then
        finaldamage = finaldamage * event.damage_scale
    end
    if event.missing_hp_scale then
        finaldamage = finaldamage * (1 - (caster:GetHealth() / caster:GetMaxHealth()))
        if finaldamage == 0 then
            return
        end
    end
    
    --[[unused
    if event.stackpercentbased then
        local max = event.stackpercentbased
        local bonusfactor = target:GetModifierStackCount(event.stackbasedbuff, nil) / max
        finaldamage = finaldamage*bonusfactor
    end
    --]]

    --test
    --print(caster:GetAttackSpeed())
    --print(caster:GetAttacksPerSecond())
    --print(caster:GetIncreasedAttackSpeed())
    --local is_big_hit = false
    --if caster:IsRealHero() and finaldamage >= caster:GetPrimaryStatValue() * 6 then
    --    is_big_hit = true
    --end
    local is_very_big_hit = false
    local very_big_hit_threshold = 600
    if (damage_scaling >= very_big_hit_threshold) or (attribute_scaling >= very_big_hit_threshold) or (spelldamage_scaling >= very_big_hit_threshold) or (auto_attack_damage_scaling >= very_big_hit_threshold) then
    --if GetHighestAbilityScaling(event) >= very_big_hit_threshold then
        is_very_big_hit = true
    end
    if event.furyexedamage and event.furyexedamage >= very_big_hit_threshold then
    	is_very_big_hit = true
    end

    if caster.talents then
        if caster.talents[2] then
            finaldamage = finaldamage + (caster:GetAttackDamage() + GetSpellpower(event)) * 0.1 * caster.talents[2]
        end
        --if caster.talents[49] then
        --    finaldamage = finaldamage + caster:GetPrimaryStatValue() * 0.15 * caster.talents[49]
        --end
        if caster.talents[8] then
            local ancient = 1
            if caster:HasModifier("modifier_item_silverblood4") then
                ancient = 2
            end
            finaldamage = finaldamage + caster:GetHealth() * 0.005 * caster.talents[8] * ancient
        end
    end
    if (event.fromsummon or event.fromcompanion or event.ComesFromPet) and caster:HasModifier("modifier_beastrage") then
        local beast_rage = caster:FindAbilityByName("Beastrage")
        if beast_rage and beast_rage:GetLevel() >= 4 then
            finaldamage = finaldamage + caster:GetHealth() * 0.1
        end
    end

    -- range based
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

    if finaldamage == 0 then 
        return
    end

    if event.damage_factor_single_target then
        finaldamage = finaldamage * event.damage_factor_single_target
    end

    --new artifact ele dmg attribute
    if event.firedmg then
    	local eledmg_bonus = 0
    	local constant_ele_dmg_factor = 1
    	if caster.talents and caster.talents[55] and caster.talents[55] > 0 then
    		local ice_storm_bonus = (1 + 0.25 * caster.talents[55])
    		if ice_storm_bonus > 2.5 then
    			ice_storm_bonus = 2.5
    		end
	        constant_ele_dmg_factor = constant_ele_dmg_factor * ice_storm_bonus
	    end
	    if caster:HasModifier("modifier_pathbuff_029") then
	    	eledmg_bonus = eledmg_bonus + 150
	    end
        finaldamage = finaldamage + (caster:GetModifierStackCount("modifier_mythic_firedmgd", nil) + eledmg_bonus) * constant_ele_dmg_factor
    end
    if event.arcanedmg then
    	local constant_ele_dmg_factor = 1
    	local eledmg_bonus = 0
    	if caster.talents and caster.talents[55] and caster.talents[55] > 0 then
    		local ice_storm_bonus = (1 + 0.25 * caster.talents[55])
    		if ice_storm_bonus > 2.5 then
    			ice_storm_bonus = 2.5
    		end
	        constant_ele_dmg_factor = constant_ele_dmg_factor * ice_storm_bonus
	    end
	    if caster:HasModifier("modifier_pathbuff_025") then
	    	eledmg_bonus = eledmg_bonus + 250
	    end
        finaldamage = finaldamage + (caster:GetModifierStackCount("modifier_mythic_arcanedmgd", nil) + eledmg_bonus) * constant_ele_dmg_factor
    end
    if event.naturedmg then
    	local constant_ele_dmg_factor = 1
    	local eledmg_bonus = 0
    	if caster.talents and caster.talents[55] and caster.talents[55] > 0 then
    		local ice_storm_bonus = (1 + 0.25 * caster.talents[55])
    		if ice_storm_bonus > 2.5 then
    			ice_storm_bonus = 2.5
    		end
	        constant_ele_dmg_factor = constant_ele_dmg_factor * ice_storm_bonus
	    end
    	if caster:HasModifier("modifier_bladerush") and caster:HasModifier("modifier_item_rogueblades2") then
    		constant_ele_dmg_factor = constant_ele_dmg_factor * 2
    	end
    	if event.starfallbonus then
    		constant_ele_dmg_factor = constant_ele_dmg_factor * 2
    	end
    	if caster:HasModifier("modifier_pathbuff_056") then
	    	eledmg_bonus = eledmg_bonus + 150
	    end
        finaldamage = finaldamage + (caster:GetModifierStackCount("modifier_mythic_naturedmgd", nil) + eledmg_bonus) * constant_ele_dmg_factor
    end
    if event.shadowdmg then
    	local constant_ele_dmg_factor = 1
    	if caster.talents and caster.talents[55] and caster.talents[55] > 0 then
    		local ice_storm_bonus = (1 + 0.25 * caster.talents[55])
    		if ice_storm_bonus > 2.5 then
    			ice_storm_bonus = 2.5
    		end
	        constant_ele_dmg_factor = constant_ele_dmg_factor * ice_storm_bonus
	    end
    	if caster:HasModifier("modifier_class_warlock") and target:HasModifier("modifier_dot1") then
    		constant_ele_dmg_factor = constant_ele_dmg_factor * 2
    	end
    	local divine_bonus = 0
    	if caster:HasModifier("modifier_pathbuff_062") then
	        divine_bonus = 250
	    end
        finaldamage = finaldamage + (caster:GetModifierStackCount("modifier_mythic_shadowdmgd", nil) + divine_bonus) * constant_ele_dmg_factor
    end
    if event.frostdmg then
    	local constant_ele_dmg_factor = 1
    	if caster.talents and caster.talents[55] and caster.talents[55] > 0 then
    		local ice_storm_bonus = (1 + 0.25 * caster.talents[55])
    		if ice_storm_bonus > 2.5 then
    			ice_storm_bonus = 2.5
    		end
	        constant_ele_dmg_factor = constant_ele_dmg_factor * ice_storm_bonus
	    end
    	if caster:HasModifier("modifier_pathbuff_055") then
    		constant_ele_dmg_factor = constant_ele_dmg_factor * 2
    	end
        finaldamage = finaldamage + caster:GetModifierStackCount("modifier_mythic_frostdmgd", nil) * constant_ele_dmg_factor
    end
    if event.holydmg then
    	local constant_ele_dmg_factor = 1
    	if caster.talents and caster.talents[55] and caster.talents[55] > 0 then
    		local ice_storm_bonus = (1 + 0.25 * caster.talents[55])
    		if ice_storm_bonus > 2.5 then
    			ice_storm_bonus = 2.5
    		end
	        constant_ele_dmg_factor = constant_ele_dmg_factor * ice_storm_bonus
	    end
        finaldamage = finaldamage + caster:GetModifierStackCount("modifier_mythic_holydmgd", nil) * constant_ele_dmg_factor
    end
    if event.chaosdmg then
    	local constant_ele_dmg_factor = 1
    	if caster.talents and caster.talents[55] and caster.talents[55] > 0 then
    		local ice_storm_bonus = (1 + 0.25 * caster.talents[55])
    		if ice_storm_bonus > 2.5 then
    			ice_storm_bonus = 2.5
    		end
	        constant_ele_dmg_factor = constant_ele_dmg_factor * ice_storm_bonus
	    end
        finaldamage = finaldamage + caster:GetModifierStackCount("modifier_mythic_chaosdmgd", nil) * constant_ele_dmg_factor
    end
    if dmgtype == 1 then
    	local constant_ele_dmg_factor = 1
    	if caster.talents and caster.talents[55] and caster.talents[55] > 0 then
    		local ice_storm_bonus = (1 + 0.25 * caster.talents[55])
    		if ice_storm_bonus > 2.5 then
    			ice_storm_bonus = 2.5
    		end
	        constant_ele_dmg_factor = constant_ele_dmg_factor * ice_storm_bonus
	    end
    	if caster:HasModifier("modifier_bladerush") and caster:HasModifier("modifier_item_rogueblades2") then
    		constant_ele_dmg_factor = constant_ele_dmg_factor * 2
    	end
        finaldamage = finaldamage + caster:GetModifierStackCount("modifier_mythic_physicaldmgd", nil) * constant_ele_dmg_factor
    end
    

    ------------------------------------------------------------------------------------------------------------------------
    --base damage calcs finished

    --dmgprocs
    if event.bloodwolf then
        ChannelProcs(caster)
    end

    --------------------------------------------------------------------------------------------------------------------------------
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
    if event.changedmgtypetophys then
        dmgtype = 1
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
    local rangercritdmg = caster:FindAbilityByName("glacier_crack_spell")
    if rangercritdmg and rangercritdmg:GetLevel() >= 4 then
        critdmgbonusfactor = critdmgbonusfactor + 0.25
    end
    local shaolincritdmg = caster:FindAbilityByName("deadly1")
    if shaolincritdmg and shaolincritdmg:GetLevel() >= 3 then
        critdmgbonusfactor = critdmgbonusfactor + 0.25
    end
    local roguecritchance = caster:FindAbilityByName("Shadow_Walk")
    if roguecritchance and roguecritchance:GetLevel() >= 4 then
        critchancefactor = critchancefactor + 0.25
    end
    if event.starfallbonus and caster:HasModifier("modifier_pathbuff_023") then
        critchancefactor = critchancefactor + 0.25
    end
    if event.ignitecritchancefactor and target:HasModifier("modifier_magmaburn2") then
        critchancefactor = critchancefactor + 1
    end
    --local arcane_barrage_stacks = caster:GetModifierStackCount("modifier_arcane_barrage_bonus", nil)
    --local arcane_barrage_ability = caster:FindAbilityByName("Arcane2")
    --if arcane_barrage_stacks > 0 and arcane_barrage_ability and arcane_barrage_ability:GetLevel() >= 3 then
    --   critchancefactor = critchancefactor + 0.06 * arcane_barrage_stacks
    --end
    local dhcrittalent = caster:FindAbilityByName("dh4")
    if dhcrittalent and dhcrittalent:GetLevel() >= 3 then
        critdmgbonusfactor = critdmgbonusfactor + 0.25
    end
    --local riki_dance_shadows_crit_talent = caster:FindAbilityByName("hawk3")
    --if riki_dance_shadows_crit_talent and riki_dance_shadows_crit_talent:GetLevel() >= 4 then
    --    critdmgbonusfactor = critdmgbonusfactor + 0.5
    --end
    if caster:HasModifier("modifier_item_ancient_elune") then
        --local tiger_stack = caster:GetModifierStackCount("modifier_talent_tiger_prowl", nil)
        critdmgbonusfactor = critdmgbonusfactor + 0.25  -- + 0.05 * tiger_stack
    end
    --agility stat
    --if caster:IsRealHero() then
    --    critdmgbonusfactor = critdmgbonusfactor + 0.0002 * caster:GetAgility()
    --end
    local axecrittalent = caster:FindAbilityByName("Wounding_Strike")
    if axecrittalent and axecrittalent:GetLevel() >= 4 then
        critdmgbonusfactor = critdmgbonusfactor + 0.25
    end
    local artifact_crit_dmg = caster:GetModifierStackCount("modifier_mythic_critdmg", nil)
    if artifact_crit_dmg > 0 then
        critdmgbonusfactor = critdmgbonusfactor + 0.01 * artifact_crit_dmg
    end
    if caster:HasModifier("modifier_item_element_frost") then
        critdmgbonusfactor = critdmgbonusfactor + 0.25
    end
    if caster.lifeblood and caster.lifeblood > 1 and caster.talents and caster.talents[74] and caster.talents[74] > 0 and caster.path_sacrifice_souls_paid and caster:HasModifier("modifier_pathbuff_074") then
        critdmgbonusfactor = critdmgbonusfactor + 0.25
    end
    if caster:HasModifier("modifier_pathbuff_082") then
        critdmgbonusfactor = critdmgbonusfactor + 0.5
    end
    if caster:HasModifier("modifier_element_chaos") then
        critdmgbonusfactor = critdmgbonusfactor + 0.3
    end
    if caster:HasModifier("modifier_item_crit_frost_immortal") then
        critdmgbonusfactor = critdmgbonusfactor + 0.4
    end
    if caster:HasModifier("modifier_item_crit_frost_immortal2") then
        critdmgbonusfactor = critdmgbonusfactor + 0.5
    end
    if caster:HasModifier("modifier_molten_blade") then
        critdmgbonusfactor = critdmgbonusfactor + 0.25
    end
    if caster:HasModifier("modifier_crit_aura_dragon") then
        critdmgbonusfactor = critdmgbonusfactor + 0.2
    end
    if caster:HasModifier("modifier_crit_aura_dragon_2") then
        critdmgbonusfactor = critdmgbonusfactor + 0.3
    end
    if caster:HasModifier("modifier_item_windforce2") then
        critdmgbonusfactor = critdmgbonusfactor + 0.25
    end
    if caster:HasModifier("modifier_item_bootscrit_2") then
        critdmgbonusfactor = critdmgbonusfactor + 0.25
    end
    if caster:HasModifier("modifier_pathbuff_049") then
        critdmgbonusfactor = critdmgbonusfactor + 0.25
    end
    if caster:HasModifier("modifier_special_bonus_vision") then
        critdmgbonusfactor = critdmgbonusfactor + 0.1
    end
    if caster:HasModifier("modifier_item_bootscrit4") then
        critdmgbonusfactor = critdmgbonusfactor + 1
    elseif caster:HasModifier("modifier_item_bootscrit3") then
        critdmgbonusfactor = critdmgbonusfactor + 0.75
    elseif caster:HasModifier("modifier_item_bootscrit2") then
        critdmgbonusfactor = critdmgbonusfactor + 0.5
    end
    if caster:HasModifier("modifier_crit_dmg_t3") then
        critdmgbonusfactor = critdmgbonusfactor + 0.4
    end
    if caster:HasModifier("modifier_crit_dmg_t3_2") then
        critdmgbonusfactor = critdmgbonusfactor + 0.5
    end
    if caster:HasModifier("modifier_crit_dmg_riki_50") then
        critdmgbonusfactor = critdmgbonusfactor + 0.5
    end
    if caster:HasModifier("modifier_path_shadowform") then
        critdmgbonusfactor = critdmgbonusfactor + 0.25 * caster.talents[73]
    end
    local armortocrit = caster:FindAbilityByName("Switch_Battle_Stance_Prot")
    if not armortocrit then
        armortocrit = caster:FindAbilityByName("temple_brawler_defstance")
    end
    if armortocrit and armortocrit:GetLevel() >= 3 then
        critdmgbonusfactor = critdmgbonusfactor + 0.005 * caster:GetPhysicalArmorValue()
    end
    armortocrit = caster:FindAbilityByName("Waterelemental")
    if armortocrit and armortocrit:GetLevel() >= 4 then
        critdmgbonusfactor = critdmgbonusfactor + 0.01 * caster:GetPhysicalArmorValue()
    end
    --local empowertocrit = caster:GetModifierStackCount("modifier_talent_onheal_armor", nil)
    --if empowertocrit and empowertocrit > 0 then
    --    critdmgbonusfactor = critdmgbonusfactor + 0.01 * empowertocrit
    --end
    
    if caster.talents and caster.talents[17] then
        local fullmoon_critbonus = 0.05 * caster.talents[17]
        if event.starfallbonus and caster:HasModifier("modifier_pathbuff_023") then
            fullmoon_critbonus = fullmoon_critbonus * 2
        end
        critdmgbonusfactor = critdmgbonusfactor + fullmoon_critbonus
    end
    if caster.talents and caster.talents[79] and (event.fromcompanion or event.fromsummon or event.ComesFromPet) then
        critdmgbonusfactor = critdmgbonusfactor + 0.1 * caster.talents[79]
    end
    --if caster.runeword and caster.runeword[12] then
    --    critdmgbonusfactor = critdmgbonusfactor + caster.runeword[12] / 100
    --end
    if critpossible == true and is_very_big_hit and caster.talents and caster.talents[22] and caster.talents[22] > 0 and caster.moonlightcrits and caster.moonlightcrits > 0 and not event.dragondmg then
        finaldamage = finaldamage * critdmgbonusfactor * (1 + 1 * caster.talents[22])
        critpossible = false
        if caster:HasModifier("modifier_item_windforce4") then
            finaldamage = finaldamage*1.25
        end
        caster.moonlightcrits = caster.moonlightcrits - 1
        StarsAlignFX(target)
        if caster:HasModifier("modifier_pathbuff_022") then
            event.arcanedmg = 1
        end
    end
    if critpossible == true and is_very_big_hit and caster.talents and caster.talents[22] and caster.talents[22] > 0 and not caster:HasModifier("modifier_crit_moon_cd") and not event.dragondmg then
        finaldamage = finaldamage * critdmgbonusfactor * (1 + 1 * caster.talents[22])
        critpossible = false
        local ancient = 0
        if caster:HasModifier("modifier_item_windforce4") then
            ancient = 5
            finaldamage = finaldamage*1.25
        end
        if not caster:HasModifier("modifier_pathbuff_017") or (caster:HasModifier("modifier_pathbuff_017") and math.random(1,100) <= 75) then
            local stars_aligned_cd = 15 - ancient
            if (not caster:IsRangedAttacker()) and caster:HasModifier("modifier_pathbuff_012") then
                stars_aligned_cd = stars_aligned_cd / 2
            end
            passive_ability:ApplyDataDrivenModifier(caster, caster, "modifier_crit_moon_cd", { Duration = stars_aligned_cd})
        end
        if caster:HasModifier("modifier_item_set_agi_t3_full_dream") then
            caster.moonlightcrits = 1 -- 1 extra crit
        end
        StarsAlignFX(target)
        event.was_stars_aligned_first_crit = true
        if caster:HasModifier("modifier_pathbuff_022") then
            event.arcanedmg = 1
        end
    end
    if critpossible == true and event.envenom and caster:HasModifier("modifier_coldblood") then
        local killdance = caster:FindAbilityByName("combat5")
        if killdance then
            local lvl = killdance:GetLevelSpecialValueFor("crit", (caster:GetAbilityByIndex(4):GetLevel() - 1))
            finaldamage = finaldamage*lvl*critdmgbonusfactor
            critpossible = false
            caster:RemoveModifierByName("modifier_coldblood")
        end
    end
    if critpossible == true and caster:HasModifier("modifier_item_set_agi_set_crit_t1_2") then
        critchance = 5*critchancefactor
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*10*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and caster:HasModifier("modifier_item_crit_pure_immortal2") then
        critchance = 10*critchancefactor
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*6*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and caster:HasModifier("modifier_mythic_abilcrit") then
        critchance = critchancefactor * caster:GetModifierStackCount("modifier_mythic_abilcrit", nil)
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*5*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and caster:HasModifier("modifier_fury_crit") then
        critchance = critchancefactor * caster:GetModifierStackCount("modifier_fury_crit", nil)
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*5*critdmgbonusfactor
            critpossible = false
            caster:RemoveModifierByName("modifier_fury_crit")
        end
    end
    if critpossible == true and caster:HasModifier("modifier_item_crit_myth") then
        critchance = 15*critchancefactor
        if caster:HasModifier("modifier_crit_myth") then
            critchance = critchance * 2
        end
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*6*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and caster:HasModifier("modifier_pathbuff_069") and (event.fromcompanion or event.fromsummon or event.ComesFromPet) then
        critchance = 15 * critchancefactor
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*5*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and caster:HasModifier("modifier_ancient_def") then
        critchance = 5*critchancefactor
        if caster:HasModifier("modifier_horror_proc") then
            critchance = 30 * critchancefactor
        end
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*5*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and caster:HasModifier("modifier_item_ancient_wolf") then
        critchance = 10*critchancefactor
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*2.25*critdmgbonusfactor
            critpossible = false
        end
    end
    --local sptocrit = caster:FindAbilityByName("Molten_Lava")
    --if critpossible == true and sptocrit and sptocrit:GetLevel() >= 4 then
    --    critchance = 0.01*GetSpellpower(event)*critchancefactor
    --    if math.random(1,100) <= critchance then
    --        finaldamage = finaldamage*5*critdmgbonusfactor
    --        critpossible = false
    --    end
    --end
    if critpossible == true and caster:HasModifier("modifier_druid_sun_crit") then
        critchance = 5
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*5*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and caster:HasModifier("modifier_item_crit_pure_immortal_2") then
        critchance = 5*critchancefactor
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*5*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and caster:HasModifier("modifier_item_crit_pure_immortal3") then
        critchance = 15*critchancefactor
        if caster:HasModifier("modifier_item_crit_pure_5_lifesteal_no_ls") then
            critchance = critchance * 2
        end
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*5*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and caster:HasModifier("modifier_element_shadow") then
        critchance = 5*critchancefactor
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*5*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and caster:HasModifier("modifier_item_crit_pure_5") then
        critchance = 20*critchancefactor
        if caster:HasModifier("modifier_item_crit_pure_5_lifesteal") then
            critchance = critchance * 2
        end
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*2.0*critdmgbonusfactor
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
        if caster:HasModifier("modifier_bow_crit_legendary") then
            critchance = 30
        end
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*3.5*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and caster:HasModifier("modifier_item_set_agi_set_crit_2") then
        critchance = 3*critchancefactor
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*2.75*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and caster:HasModifier("modifier_item_set_agi_set_crit_t1") then
        critchance = 5*critchancefactor
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*2.75*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and caster:HasModifier("modifier_item_crit_pure_3") then
        critchance = 20*critchancefactor
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*1.5*critdmgbonusfactor
            critpossible = false
        end
    end
    --local agitocrit = caster:FindAbilityByName("wind5")
    --if critpossible == true and agitocrit and agitocrit:GetLevel() >= 4 then
    --    critchance = caster:GetPrimaryStatValue()*0.05*critchancefactor
    --    if math.random(1,100) <= critchance then
    --        finaldamage = finaldamage*3*critdmgbonusfactor
    --        critpossible = false
    --    end
    --end
    if critpossible == true and caster:HasModifier("modifier_lifesteal_double") then
        critchance = 10*critchancefactor
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*2*critdmgbonusfactor
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
    if critpossible == true and caster.talents and caster.talents[45] and caster.talents[45] > 0 and ((ability:GetAbilityIndex() == 0 or ability:GetAbilityIndex() == 1) or (ability:GetAbilityIndex() == 2 and caster:HasModifier("modifier_pathbuff_013"))) then
        local alphablood_divine = caster:HasModifier("modifier_pathbuff_045")
        local alphablood_chance = 3
        if ability:GetAbilityIndex() == 1 then
            alphablood_chance = 2
            if alphablood_divine then
                alphablood_chance = 4
            end
        end
        critchance = alphablood_chance*caster.talents[45]
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*5*critdmgbonusfactor
            critpossible = false
            PathAlphaBloodProc( caster, ability )
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
        critchance = 15*critchancefactor
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*1.5*critdmgbonusfactor
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
    --if critpossible == true and caster:HasModifier("modifier_item_crit_pure_5_lifesteal") then
    --    finaldamage = finaldamage*2.0*critdmgbonusfactor
    --    critpossible = false
    --end
    if critpossible == true and caster:HasModifier("modifier_item_bootscrit4") then
        critchance = 10*critchancefactor
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*2.5*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and caster:HasModifier("modifier_item_bootscrit3") then
        critchance = 10*critchancefactor
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*2.25*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and caster:HasModifier("modifier_item_bootscrit2") then
        critchance = 10*critchancefactor
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*2*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and caster:HasModifier("modifier_item_endgame5") then
        critchance = 8*critchancefactor
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*2.5*critdmgbonusfactor
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
    local prot_counter_blow = caster:GetModifierStackCount("modifier_counter_blow", nil)
    if critpossible == true and prot_counter_blow >= 1 then
        critchance = 100*critchancefactor
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*2*critdmgbonusfactor
            critpossible = false
            caster:RemoveModifierByName("modifier_counter_blow")
        end
    end
    if critpossible == true and caster.talents and caster.talents[37] and caster.talents[37] > 0 then
        critchance = 3*caster.talents[37]
        if math.random(1,100) <= critchance then
            local factor = 2
            if caster:HasModifier("modifier_pathbuff_037") and GetHighestAbilityScaling(event) <= 500 then
                factor = 4
            end
            finaldamage = finaldamage*factor*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and caster:HasModifier("modifier_item_bootscrit") then
        critchance = 10*critchancefactor
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*1.5*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and caster:HasModifier("modifier_item_bootscrit_2") then
        critchance = 10*critchancefactor
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*1.75*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and event.froststrikecrit and caster:GetModifierStackCount("modifier_frostrune", nil) >= 5 then
        critchance = 100*critchancefactor
        if math.random(1,100) <= critchance then
            caster:RemoveModifierByName("modifier_frostrune")
            finaldamage = finaldamage*5*critdmgbonusfactor
            critpossible = false
            event.lifesteal = 5
        end
    end
    if critpossible == true and caster:HasModifier("modifier_crit_aura_dragon_2") then
        critchance = 3*critchancefactor
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*5.0*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and caster:HasModifier("modifier_item_caster6") then
        critchance = 12*critchancefactor
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*1.75*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and caster:HasModifier("modifier_item_bowupgradeproc") then
        critchance = 50*critchancefactor
        if math.random(1,100) <= critchance then
            local dist = (caster:GetAbsOrigin()-target:GetAbsOrigin()):Length()
            if dist > 300.0 then
                finaldamage = finaldamage*2*critdmgbonusfactor
                critpossible = false
            end
        end
    end
    if critpossible == true and caster:HasModifier("modifier_item_weapon9") then
        critchance = 12*critchancefactor
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
        critchance = 10*critchancefactor
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*2.0*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and caster:HasModifier("modifier_item_weapon10") then
        critchance = 10*critchancefactor
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*2.15*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and caster:HasModifier("modifier_item_endgame10") then
        critchance = 5*critchancefactor
        --print("test for blade")
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*3*critdmgbonusfactor
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
    if critpossible == true and event.beartrapcrit and caster.owner and caster.owner:GetAbilityByIndex(2) and caster.owner:GetAbilityByIndex(2):GetLevel() >= 3 and target:HasModifier("modifier_bear_trap") then
        finaldamage = finaldamage*2.5*critdmgbonusfactor
        critpossible = false
    end
    if critpossible == true and caster:HasModifier("modifier_item_allrecipe4") then
        local life = math.floor(100-(100*caster:GetHealth()/caster:GetMaxHealth()))
        if math.random(1,100) <= life / 2 then
            finaldamage = finaldamage*1.5*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and caster.FeralFinisherCrit ~= nil and target:HasModifier("modifier_bleed2") then
        critchance = GetStrengthCustom(caster)*2
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*1.5*critdmgbonusfactor
            critpossible = false
        end
    end
    local holy_priest_crit = caster:FindAbilityByName("holy2")
    if critpossible == true and holy_priest_crit and holy_priest_crit:GetLevel() >= 3 then
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
    local riki_passive_crit = caster:FindAbilityByName("hawk1")
    if critpossible == true and event.rikicrit and riki_passive_crit and riki_passive_crit:GetLevel() >= 3 then
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
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*2.0*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and event.lavaburst and target:HasModifier("modifier_lavashock") then
        critchance = 100*critchancefactor
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*event.lavaburst*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and event.alwayscrit200onbuff and target:HasModifier(event.alwayscrit200onbuff) then
        critchance = 10*critchancefactor
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*2.0*critdmgbonusfactor
            critpossible = false
        end
    end
    if critpossible == true and event.dire1 and caster:HasModifier("modifier_npc_dota_hero_riki") then
        critchance = 100*critchancefactor
        if math.random(1,100) <= critchance then
            finaldamage = finaldamage*2.5*critdmgbonusfactor
            critpossible = false
        end
    end
    
    local was_crit = false
    if critpossible == false and not event.cannotcrit then
        was_crit = true
    end

    -- END CRIT CALC

    -------------------------------------------------------------------------------------------------------------------------------------------------------
    

    --procs
    --primal totem staff
    if caster.elemental_item3 and caster:HasModifier("modifier_item_elements3") then
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

    --pure damage check
    if (caster.talents and caster.talents[82] and caster.talents[82] > 0 and caster.talents[82] * 10 >= math.random(1,100)) or (caster:HasModifier("modifier_item_valyrian") and math.random(1,100) <= 5) or (caster:HasModifier("modifier_item_dreihander") and math.random(1,100) <= 10) or (caster:HasModifier("modifier_pathbuff_030") and math.random(1,100) <= 10) or (event.critignorearmor and was_crit) or caster:HasModifier("modifier_valyrian") then
        pure_dmg = true
    end
    local standsstill = caster.standsstill
    if standsstill then
        if standsstill > 5 then
            standsstill = 5
        end
        if caster:HasModifier("modifier_pathbuff_020") and math.random(1,100) <= 5 * standsstill then
            pure_dmg = true
        end
    end

    --multiplicative buffs
    ------------------------------------------------------------------------------------------------------------------------------------------------------
    if ability then
        ability_bonus = GetAbilityDamageModifierMultiplicative(event, caster, real_caster, target, ability, behindtarget, is_very_big_hit, isaoe, true, was_crit, pure_dmg)
        elemental_bonus = GetElementalDamageModifierAdditive(event, caster, real_caster, target, ability, behindtarget, true, dmgtype)
    end
    --local aoe_bonus = 1
    --if isaoe then
    --    aoe_bonus = GetAbilityAOEDamageModifierAdditive(event, caster, real_caster, target, ability, behindtarget, true)
    --end

    -------------------------------------------------
    --summon stuff
    local dragon_bonus = GetDragonBonusDamage(event, caster)
    local summon_bonus = GetSummonBonusDamage(event, caster, empowertocrit)

    --saving stats for statistics
    if caster:IsRealHero() then
        caster.ability_bonus = ability_bonus
        caster.elemental_bonus = elemental_bonus
        caster.crit_chance_factor = critchancefactor
        caster.crit_dmg_factor = critdmgbonusfactor
        --caster.multiplicative_bonus = multiplicative_bonus
    end

    --patient prowler, must be after getting bonus
    if caster.talents then
        if caster.talents[52] and caster.talents[52] > 0 then
            local myevent = {}
            myevent.caster = caster
            myevent.target = caster
            myevent.buff = "modifier_talent_tiger_prowl"
            myevent.ability = passive_ability
            myevent.dur = -1
            myevent.addstacks = -1
            local max_stack = 10
            if caster:HasModifier("modifier_item_ancient_elune") then
                max_stack = 15
            end
            myevent.max = max_stack
            ApplyBuffStack(myevent)
        end
    end

    --critical strike tracking
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

    if event.killdance_crit_extra_hit then
        if was_crit then
            caster.killdance_last_hit_was_crit = true
        else
            caster.killdance_last_hit_was_crit = false
        end
    end

    --new buffs based on improved talents, 4.3
    local drow_consec_crit_talent = caster:FindAbilityByName("Icy_Shot")
    if drow_consec_crit_talent and drow_consec_crit_talent:GetLevel() >= 4 and caster.consecutive_crits and caster.consecutive_crits >= 3 then
        if caster.agility_bonus_100 then
            caster.agility_bonus_100 = caster.agility_bonus_100 + 1
        else
            caster.agility_bonus_100 = 1
        end
        drow_consec_crit_talent:ApplyDataDrivenModifier(caster, caster, "modifier_icy_agi", {Duration = 20})
        Timers:CreateTimer(20,function()
            caster.agility_bonus_100 = caster.agility_bonus_100 - 1
        end)
    end
    local darkseer_class_consec_bonus = caster:FindAbilityByName("shadow1")
    if darkseer_class_consec_bonus and caster.consecutive_crits and caster.consecutive_crits >= 3 and caster:HasModifier("modifier_class_darkseer") then
        if caster.ds_shadow_bonus_50 then
            caster.ds_shadow_bonus_50 = caster.ds_shadow_bonus_50 + 1
        else
            caster.ds_shadow_bonus_50 = 1
        end
        --drow_consec_crit_talent:ApplyDataDrivenModifier(caster, caster, "modifier_icy_agi", {Duration = 20})
        Timers:CreateTimer(10,function()
            caster.ds_shadow_bonus_50 = caster.ds_shadow_bonus_50 - 1
        end)
    end

    --talent procs 2, based on crits, bloodwolf
    if caster.talents then
        --if was_crit and caster.talents[45] and caster.talents[45] > 0 and caster.consecutive_crits and caster.consecutive_crits >= 5 then
        --    passive_ability:ApplyDataDrivenModifier(caster, caster, "modifier_talent_enrage_2", {Duration = 5})
        --end
        if was_crit and caster.talents[47] and caster.talents[47] > 0 then
            if caster.critcounter then
                caster.critcounter = caster.critcounter + 1
                local crits_needed = 10 + 5 * caster.talents[47]
                --if caster:HasModifier("modifier_item_ancient_wolf") then
                --   crits_needed = crits_needed * 2
                --end
                if caster.critcounter >= crits_needed then
                    caster.critcounter = 0
                    passive_ability:ApplyDataDrivenModifier(caster, caster, "modifier_talent_enrage", {Duration = 15})
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
        --[[
        if caster.talents[50] and caster.talents[50] > 0 and math.random(1,100) <= 1 then
            local myevent = {}
            myevent.caster = caster
            myevent.target = caster
            myevent.buff = "modifier_talent_onheal_armor"
            myevent.ability = caster.combat_system_ability
            myevent.dur = 3 + 3 * caster.talents[50]
            ApplyBuff(myevent)
            caster.creepertarget = target
            myevent.target = target
            myevent.dur = nil
            myevent.buff = "irongrizzly_summon_proc"
            ApplyBuff(myevent)
        end
        ]]
        if caster.talents[30] and caster.talents[30] > 0 and not caster.talent_30_cd then
            BlizzardTalent(caster, target, event)
        end
    end
    --cp on crit
    if event.cponcrit and event.cponcrit > 0 and critpossible == false then
    	if not caster.ComboPoints then
    		caster.ComboPoints = 0
    	end
    	if caster.ComboPoints < 3 then
    		caster.ComboPoints = caster.ComboPoints + event.cponcrit
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
        if event.critmanaregnonpercent then
    	   caster:SetMana(caster:GetMana()+event.critmanareg)
        else
            caster:SetMana(caster:GetMana()+(caster:GetMaxMana()*event.critmanareg/100.0))
        end
    	local particle = ParticleManager:CreateParticle("particles/items3_fx/mango_active.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
        ParticleManager:ReleaseParticleIndex(particle)
    end

    if event.oncritswp and event.oncritswp > 0 and critpossible == false and not event.cannotcrit then
    	if math.random(1,100) <= event.oncritswp and not caster:HasModifier("modifier_swd_2_proc_cd") and (caster:GetAbsOrigin()-target:GetAbsOrigin()):Length() < 2500 then
	    	event.ability:ApplyDataDrivenModifier(caster, target, "modifier_swd_2_proc", nil)
            if caster:HasModifier("modifier_class_darkseer") then
                Timers:CreateTimer(0.3,function()
                    event.ability:ApplyDataDrivenModifier(caster, target, "modifier_swd_2_proc", nil)
                    Timers:CreateTimer(0.3,function()
                        event.ability:ApplyDataDrivenModifier(caster, target, "modifier_swd_2_proc", nil)
                    end)
                end)
            end
            local swpcd = 10
            event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_swd_2_proc_cd", {Duration = swpcd})
    	end
    end

    if event.oncritbuff and was_crit then
        if not event.oncritbuffchance then
            event.ability:ApplyDataDrivenModifier(caster, caster, event.oncritbuff, nil)
        else
            if math.random(1,100) <= event.oncritbuffchance then
                event.ability:ApplyDataDrivenModifier(caster, caster, event.oncritbuff, nil)
            end
        end
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
    if event.on3critbuff then
        if was_crit then
            if caster.on3crit then
                caster.on3crit = caster.on3crit  + 1
                if caster.on3crit >= 3 then
                    event.ability:ApplyDataDrivenModifier(caster, caster, event.on3critbuff, nil)
                    caster.on3crit = 0
                end
            else
                caster.on3crit = 1
            end
        else
            caster.on3crit = 0
        end
    end
    if event.oncritdebuff and was_crit then
        event.ability:ApplyDataDrivenModifier(caster, target, event.oncritdebuff, nil)
    end

    if event.oncritcdreduce and event.oncritcdreduce > 0 and critpossible == false and not event.cannotcrit then
    	event.amount = event.oncritcdreduce
    	ReduceCooldown(event)
    end

    if event.oncritcdreduce3rd and event.oncritcdreduce3rd > 0 and critpossible == false and not event.cannotcrit then
        event.amount = event.oncritcdreduce3rd
        event.chooseability = 2
        ReduceCooldown(event)
    end

    if event.oncritcdreduce4th and event.oncritcdreduce4th > 0 and critpossible == false and not event.cannotcrit then
        event.amount = event.oncritcdreduce4th
        event.chooseability = 3
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

    --ability crit in last 5 secs counter
    if was_crit then
        if not caster.ab_crit_counter_last_5_secs then
        	caster.ab_crit_counter_last_5_secs = 0
        end
        caster.ab_crit_counter_last_5_secs = caster.ab_crit_counter_last_5_secs + 1
        local sniper_bonus = caster:FindAbilityByName("Bear")
        if caster.ab_crit_counter_last_5_secs == 1 and sniper_bonus and sniper_bonus:GetLevel() >= 4 then
        	caster.sniper_blood_particle = ParticleManager:CreateParticle("particles/items4_fx/spirit_vessel_damage_ground.vpcf", PATTACH_POINT_FOLLOW, caster)
        end
        Timers:CreateTimer(5, function()
        	caster.ab_crit_counter_last_5_secs = caster.ab_crit_counter_last_5_secs - 1
        	if caster.ab_crit_counter_last_5_secs == 0 and caster.sniper_blood_particle then
        		ParticleManager:DestroyParticle(caster.sniper_blood_particle,false)
        		ParticleManager:ReleaseParticleIndex(caster.sniper_blood_particle)
        	end
        end)
    end

    local talentwarriorcritdot = caster:FindAbilityByName("Switch_Battle_Stance")
    if not talentwarriorcritdot then
        talentwarriorcritdot = caster:FindAbilityByName("temple_brawler_battlestance")
    end
    if critpossible == false and not event.cannotcrit and not caster.armstalentdotcd and not event.talentarmsnodot and talentwarriorcritdot and talentwarriorcritdot:GetLevel() >= 4 then
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
    		if caster.itemelemental and not caster:HasModifier("modifier_innercd_fire") then
	    		if math.random(1,100) <= 100 then
			    	local myevent = {}
		    		myevent.caster = caster
		    		myevent.target = target
		    		myevent.buff = "modifier_stunned"
					myevent.ability = event.ability
					myevent.dur = 2
					ApplyBuff(myevent)
	    			local particle = ParticleManager:CreateParticle("particles/econ/items/invoker/glorious_inspiration/invoker_forge_spirit_death_esl_explode.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
                    ParticleManager:ReleaseParticleIndex(particle)
	    			table3.Duration = 30
	    			caster.itemelemental:ApplyDataDrivenModifier(caster, caster, "modifier_innercd_fire", table3)
	    			particle = ParticleManager:CreateParticle("particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_shadowraze_end_smoke.vpcf", PATTACH_POINT_FOLLOW, target)
                    ParticleManager:ReleaseParticleIndex(particle)
			    end
			end
    	end
    end

    --------------------------------------------------------------------------------------------------------------------------------------------------
    --final damage determined

    -- set damage table
    finaldamage = finaldamage * nodamageatall * ability_bonus * elemental_bonus * dragon_bonus * summon_bonus

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
 		damage_table.damage_type = dmgtype
 	end
    --pure dmg?
    if event.puredmg or pure_dmg then
        damage_table.damage_type = DAMAGE_TYPE_PURE
        local particle = ParticleManager:CreateParticle("particles/econ/items/antimage/antimage_weapon_basher_ti5_gold/am_manaburn_basher_ti_5_gold.vpcf", PATTACH_POINT_FOLLOW, target)
        ParticleManager:ReleaseParticleIndex(particle)
    end

 	damage_table.damage = finaldamage

 	if damage_table.damage_type == 0 then
 		damage_table.damage_type = 2
 	end

 	if event.dontbreakcc and CheckForBreakableCC(target) then

 	else
        if caster.talents then
            if caster.talents[4] and caster.talents[4] > 0 then
                if not event.notalent4proc and not caster.talent4cd and math.random(1,100) <= 10 then
                    caster.talent4cd = true
                    Timers:CreateTimer(2.5,function()
                        caster.talent4cd = false
                    end)
                    local dot_dur = 5
                    if caster:HasModifier("modifier_item_ancient_grizzly") then
                        dot_dur = dot_dur * 2
                    end
                    local myevent = { caster = caster, target = target, dur = dot_dur, buff = "modifier_dot", ability = passive_ability}
                    if not target:IsRealHero() then
                        ApplyBuff(myevent)
                    end
                end
            end
            if caster.talents[7] and caster.talents[7] > 0 then
                local buff = "modifier_talent_maul"
                local dot_dur = 3
                if caster:HasModifier("modifier_item_ancient_grizzly") then
                    dot_dur = dot_dur * 2
                end
                local myevent = { caster = caster, target = caster, dur = dot_dur, buff = buff, ability = passive_ability, addstacks = 1, max = caster.talents[7] * 33}
                ApplyBuffStack(myevent)
                --[[if false and math.random(1,100) <= caster.talents[7] and not event.maul_proc then
                    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_centaur/centaur_warstomp_shockwave.vpcf", PATTACH_ABSORIGIN, target)
                    ParticleManager:ReleaseParticleIndex(particle)
                    EmitSoundOn("DOTA_Item.BladeMail.Activate", target)
                    local tab = {}
                    tab.caster = caster
                    tab.target = target
                    tab.damage = 0.0
                    tab.spelldamagefactor = 0.0
                    tab.attributefactor = 400
                    tab.ability = event.ability
                    tab.maul_proc = true
                    DamageUnit(tab)
                end]]
            end
        end

 		ApplyDamage(damage_table)

        --extra hit procs
        if caster:HasModifier("modifier_dancing_rune_dmg") and caster.DancingRune and not caster.DancingRune:IsNull() then
            local hit_ability = caster:FindAbilityByName("Death_For_Life")
            if hit_ability then
                local damage_table_2 = {}
                damage_table_2.victim = target
                damage_table_2.attacker = caster
                damage_table_2.ability = hit_ability
                damage_table_2.damage_type = hit_ability:GetAbilityDamageType()
                damage_table_2.damage = finaldamage * 0.5
                Timers:CreateTimer(0.25,function() 
                    ApplyDamage(damage_table_2)
                    DancingRuneDamageFX(caster, target)
                end)
            end
        end

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

    --PROCS AFTER DEALING THE DMG

	if event.lifesteal then
		local tab = {}
		tab.caster = caster
		tab.target = caster
		tab.heal = finaldamage * event.lifesteal / 100
		tab.spelldamagefactor = 0.0
		tab.attributefactor = 0.0
		tab.ability = event.ability
        tab.cap_healing_at_max_health = event.cap_healing_at_max_health
        tab.bloodwolf = event.bloodwolf
		if tab.heal < 10 then
			tab.hidenumber = 1
		end
        if event.lifestealbuffcondition and not caster:HasModifier(event.lifestealbuffcondition) then
            --skip
        else
            HealUnit(tab)
        end
	end

    if caster:HasModifier("modifier_heal_on_summon_dmg") and caster:HasModifier("modifier_class_unholy") and event.ghoul and caster.Pet then
        HealUnit({caster = caster, target = caster, heal = 0, percenthp = 10, ability = ability})
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_centaur/centaur_double_edge_tgt_rope.vpcf", PATTACH_POINT_FOLLOW, caster.Pet)
        ParticleManager:SetParticleControl(particle, 4, caster:GetAbsOrigin()+Vector(0,0,75))
        ParticleManager:SetParticleControl(particle, 5, caster.Pet:GetAbsOrigin()+Vector(0,0,75))
        ParticleManager:ReleaseParticleIndex(particle)
        ApplyBuff({caster = caster, target = target, dur = 5, buff = "modifier_ghoul_res", ability = ability})
    end

    if caster.pathdarknesslevel and caster.pathdarknesslevel >= 3 and caster:HasModifier("modifier_shadow_stance_def") then
        local tab = {}
        tab.caster = caster
        tab.target = caster
        tab.heal = 0
        tab.percenthp = 1
        tab.ability = event.ability
        HealUnit(tab)
    end

	if event.lifestealowner ~= nil and caster.owner then
		local tab = {}
		local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_centaur/centaur_double_edge_src_rope.vpcf", PATTACH_POINT_FOLLOW, caster.owner)
        ParticleManager:ReleaseParticleIndex(particle)
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

	if event.vampiricemb and event.vampiricemb > 0 then
		event.heal = finaldamage*0.6
		VampiricEmbrace(event)
	end

	if caster:HasModifier("modifier_item_weapon5") or caster:HasModifier("modifier_item_dreihander") then
        local maxprocs = 10
		if math.random(1,100) <= 6 and event.dontprocaoe == nil and (caster:GetAbsOrigin()-target:GetAbsOrigin()):Length() < 2500 then
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
                ParticleManager:ReleaseParticleIndex(particle)
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
                tab.max_targets = 5
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
    if caster:HasModifier("modifier_item_multi_element") or caster:HasModifier("modifier_item_multi_element_2") then
        MultiElementProcs(event, caster, target)
    end
    if caster:HasModifier("modifier_item_beastmaster3") and caster.item_beastmaster3 and event.fromsummon then
        ApplyBuffStack({caster = caster, target = caster, ability = caster.item_beastmaster3, dur = 5, max = 25, buff = "modifier_beastitem"})
    end
    if caster.talents then
        if caster.talents[79] and caster.talents[79] > 0 and (event.fromsummon or event.fromcompanion or event.ComesFromPet) and caster.combat_system_ability and not event.pathcrow then
            local proc_threshold = 25
            local stacks = ApplyBuffStack({caster = caster, target = caster, ability = caster.combat_system_ability, dur = -1, max = proc_threshold, buff = "modifier_murdercrow"})
            if stacks >= proc_threshold then
                caster:RemoveModifierByName("modifier_murdercrow")
                caster.combat_system_ability:ApplyDataDrivenModifier(caster, target, "crow_summon_proc", {Duration = 2})
            end
        end
    end
    --pet windfury
    if (event.fromsummon or event.fromcompanion or event.ComesFromPet) and caster:HasModifier("modifier_pathbuff_041") and math.random(1,100) <= 4 then
        caster.pet_proc_windfury_on_next_aa = true
    end
    if event.fromsummon and caster.pet_proc_windfury_on_next_aa and caster:HasModifier("modifier_pathbuff_041") then
        caster.pet_proc_windfury_on_next_aa = nil
        local pet = event.attacker
        if pet then
            Multistrike( {caster = pet, target = target} )
        end
    end
    local track_ability_stats = true
    if track_ability_stats then
        if not caster.ability_stats then
            caster.ability_stats = {}
        end
        if ability then
            local index = ability:GetAbilityIndex()
            if not caster.ability_stats[index] then
                caster.ability_stats[index] = 0
            end
            caster.ability_stats[index] = caster.ability_stats[index] + damage_table.damage
        end
    end
end

function MultiElementProcs(event, caster, target)
    local dur = {Duration = 20}
    local ability = caster.item_multi_element_ability
    if event.firedmg then
        ability:ApplyDataDrivenModifier(caster, caster, "modifier_element_fire", dur)
        if math.random(1,100) <= 3 then
            local myevent = {}
            myevent.caster = caster
            myevent.target = target
            myevent.buff = "modifier_stunned"
            myevent.ability = ability
            myevent.dur = 3
            ApplyBuff(myevent)
        end
    end
    if event.shadowdmg then
        ability:ApplyDataDrivenModifier(caster, caster, "modifier_element_shadow", dur)
    end
    if event.frostdmg then
        ability:ApplyDataDrivenModifier(caster, caster, "modifier_element_frost", dur)
        local myevent = {}
        myevent.caster = caster
        myevent.target = target
        myevent.buff = "modifier_frostslow10"
        myevent.ability = ability
        myevent.dur = 15
        ApplyBuff(myevent)
    end
    if event.holydmg then
        ability:ApplyDataDrivenModifier(caster, caster, "modifier_element_holy", dur)
    end
    if event.naturedmg then
        ability:ApplyDataDrivenModifier(caster, caster, "modifier_element_nature", dur)
    end
    if event.arcanedmg then
        ability:ApplyDataDrivenModifier(caster, caster, "modifier_element_arcane", dur)
        local myevent = {}
        myevent.caster = caster
        myevent.target = target
        myevent.buff = "modifier_element_arcane_weaken"
        myevent.ability = ability
        myevent.dur = 15
        ApplyBuff(myevent)
    end
    if event.chaosdmg then
        ability:ApplyDataDrivenModifier(caster, caster, "modifier_element_chaos", dur)
    end
end

function CalcAbilityStatsPercent( caster )
    local sum = 0
    local sum_heal = 0
    for i=0, 6 do
        if caster.ability_stats and caster.ability_stats[i] then
            sum = sum + caster.ability_stats[i]
        end
        if caster.ability_stats_heal and caster.ability_stats_heal[i] then
            sum_heal = sum_heal + caster.ability_stats_heal[i]
        end
    end
    caster.ability_stats_percent = {}
    caster.ability_stats_percent_heal = {}
    for i=0, 6 do
        caster.ability_stats_percent[i] = 0
        caster.ability_stats_percent_heal[i] = 0
        if caster.ability_stats and caster.ability_stats[i] and sum > 0 then
            caster.ability_stats_percent[i] = math.floor(caster.ability_stats[i] * 100 / sum)
        end
        if caster.ability_stats_heal and caster.ability_stats_heal[i] and sum_heal > 0 then
            caster.ability_stats_percent_heal[i] = math.floor(caster.ability_stats_heal[i] * 100 / sum_heal)
        end
    end
end

function GetDragonBonusDamage( event, caster )
    local value = 1
    if not event.dragondmg then
        return value
    end
    if caster.talents then
        if caster.talents[36] and caster.talents[36] > 0 then
            value = value + 0.15 * caster.talents[36]
        end
        if caster.talents[69] and caster.talents[69] > 0 then
            value = value + 0.15 * caster.talents[69]
        end
    end
    if caster:HasModifier("modifier_pathbuff_059") and caster:HasModifier("modifier_path_shadowform") and caster:HasModifier("modifier_talent_invul") then
        value = value + 0.5
    end
    if caster:HasModifier("modifier_item_aura_ancient") then
        value = value + 0.3
    end
    if caster:HasModifier("modifier_active99") then
        value = value + 0.25
    end
    if caster:HasModifier("item_mother_of_dragons") then
        value = value + 1
    end
    if caster:HasModifier("modifier_item_aura_empire") then
        value = value + 0.25
    end
    if caster:HasModifier("modifier_summon_companion_50") then
        value = value + 0.5
    end
    if caster:HasModifier("modifier_item_ancient_primary") then
        value = value + 0.1
    end
    if caster:HasModifier("modifier_item_dragonshield") then
        value = value + 0.25
    end
    local felhunter = caster:FindAbilityByName("Felhunter")
    if felhunter and felhunter:GetLevel() >= 3 then
        value = value + 0.5
    end
    return value
end

function GetSummonBonusDamage( event, caster, empower_stacks )
    local value = 1
    if not event.fromsummon and not event.ComesFromPet then
        return value
    end
    if caster.talents then
        if caster.talents[59] and caster.talents[59] > 0 then
            value = value + 0.1 * caster.talents[59]
        end
        if caster.talents[69] then
            value = value + 0.15 * caster.talents[69]
        end
    end
    if caster:HasModifier("modifier_active99") then
        value = value + 0.25
    end
    if caster:HasModifier("modifier_pathbuff_059") and caster:HasModifier("modifier_path_shadowform") and caster:HasModifier("modifier_talent_invul") then
        value = value + 0.5
    end
    if caster:HasModifier("modifier_pathbuff_046") then
        value = value + 0.25
    end
    if caster:HasModifier("modifier_item_aura_empire") then
        value = value + 0.25
    end
    if caster:HasModifier("modifier_item_aura_ancient") then
        value = value + 0.25
    end
    if caster:HasModifier("modifier_summon_companion_50") then
        value = value + 0.5
    end
    local felhunter = caster:FindAbilityByName("Felhunter")
    if felhunter and felhunter:GetLevel() >= 3 then
        value = value + 0.5
    end
    if empower_stacks and empower_stacks > 0 then
        value = value + 0.01 * empower_stacks
    end
    if caster:HasModifier("modifier_item_ancient_primary_heal") then
        value = value + 0.1
    end
    return value
end

function GetElementalDamageModifierAdditive( event, caster, real_caster, target, ability, behindtarget, process_procs, dmgtype )
    local value = 1
    if event.frostdmg and caster:HasModifier("modifier_class_invoker") then -- and caster:HasModifier("modifier_arcane_barrage_bonus") then
        event.arcanedmg = 1
    end
    if caster:IsRealHero() and dmgtype == 1 then
        value = value + 0.0005 * caster:GetAgility() --0.0008
    end
    if caster:HasModifier("modifier_class_brawler") and target:HasModifier("modifier_arms_bleed") and caster:IsRealHero() and dmgtype == 1 then
        value = value + 0.001 * GetStrengthCustom(caster) --0.0008
    end
    if event.naturedmg and caster:HasModifier("modifier_class_bounty") and caster:IsRealHero() then
        value = value + 0.001 * caster:GetAgility()
    end
    if dmgtype == 1 and caster:HasModifier("modifier_guardian_temple_phys") then
        value = value + 0.25
    end
    if event.shadowdmg and caster:HasModifier("modifier_heal_on_summon_dmg") and caster:HasModifier("modifier_class_unholy") then
        value = value + 0.5
    end
    if event.arcanedmg and caster:HasModifier("modifier_pathbuff_081") and caster:HasModifier("modifier_skyfall") and caster:HasModifier("modifier_crit_moon_cd") then
        value = value + 0.5
    end
    if dmgtype == 1 and caster:HasModifier("modifier_pathbuff_089") and caster:HasModifier("modifier_crowfall") and caster:HasModifier("modifier_talent_enrage") then
        value = value + 0.5
    end
    if event.naturedmg and caster:HasModifier("modifier_pathbuff_089") and caster:HasModifier("modifier_crowfall") and caster:HasModifier("modifier_talent_enrage") then
        value = value + 0.5
    end
    if event.firedmg and caster.path_dragon_fire and caster.path_dragon_fire > 0 and caster:HasModifier("modifier_pathbuff_071") and caster:HasModifier("modifier_path_overwhelm") then
        value = value + 1
    end
    if event.shadowdmg and caster.ds_shadow_bonus_50 and caster.ds_shadow_bonus_50 > 0 then
        value = value + 0.5
    end
    --if event.firedmg and caster:HasModifier("modifier_burning_nether") then
    --    value = value + 0.25
    --end
    local shadow_stance_cleric = caster:GetModifierStackCount("modifier_shadow_stance", nil)
    if event.shadowdmg and shadow_stance_cleric > 0 then
        value = value + 0.05 * shadow_stance_cleric
    end
    if event.shadowdmg and target:HasModifier("modifier_rooted_self_slow") then
        value = value + 0.1
    end
    if event.shadowdmg and caster:HasModifier("modifier_nightmare_sp") then
        value = value + 0.5
    end
    if event.holydmg and caster:HasModifier("modifier_item_item_set_t4_aad_4") then
        value = value + 0.25
    end
    if event.naturedmg and caster:HasModifier("modifier_item_item_set_t4_aad_4") then
        value = value + 0.25
    end
    if event.naturedmg and caster:HasModifier("modifier_special_bonus_respawn_reduction") then
        value = value + 0.25
    end
    if event.naturedmg and caster:HasModifier("modifier_pathbuff_087") then
        value = value + 0.25
    end
    if event.naturedmg and target:HasModifier("modifier_bear_slow_pve") then
        value = value + 0.3
    end
    if event.arcanedmg and caster:HasModifier("modifier_class_invoker") then
        value = value + 0.25
    end
    if (event.shadowdmg or event.holydmg) and target:HasModifier("modifier_holy_shadow_weakness") then
        value = value + 0.1
    end
    if event.chaosdmg and caster:HasModifier("modifier_class_am") and caster:HasModifier("modifier_asfury") then
        value = value + 0.5
    end
    if caster.talents then
        if caster.talents[16] and (event.arcanedmg or event.naturedmg) then
            value = value + 0.1 * caster.talents[16]
        end
        if caster.talents[42] and event.naturedmg then
            value = value + 0.15 * caster.talents[42]
        end
        if caster.talents[27] and event.arcanedmg then
            value = value + 0.1 * caster.talents[27]
        end
        if caster.talents[29] and event.firedmg then
            value = value + 0.1 * caster.talents[29]
        end
        if caster.talents[30] and event.frostdmg then
            value = value + 0.1 * caster.talents[30]
        end
        if caster.talents[64] and caster.talents[64] > 0 and (event.holydmg or event.shadowdmg) then
            value = value + 0.1 * caster.talents[64]
        end
        if caster.talents[68] and caster.talents[68] > 0 and (event.shadowdmg or event.chaosdmg) and process_procs then
            if caster.path_dark_ritual then
                caster.path_dark_ritual = caster.path_dark_ritual + 1
            else
                caster.path_dark_ritual = 1
            end
            Timers:CreateTimer(15,function()
                caster.path_dark_ritual = caster.path_dark_ritual - 1
            end)
        end
        if caster.talents[36] and caster.talents[36] > 0 and event.firedmg and process_procs then
            if caster.path_dragon_fire then
                caster.path_dragon_fire = caster.path_dragon_fire + 1
            else
                caster.path_dragon_fire = 1
            end
            Timers:CreateTimer(15,function()
                caster.path_dragon_fire = caster.path_dragon_fire - 1
            end)
        end
    end
    local distance = (caster:GetAbsOrigin()-target:GetAbsOrigin()):Length()
    if dmgtype == 1 and distance > 700 and caster:HasModifier("modifier_item_longbow") then
        value = value + 0.5
    end
    local icenovastacks = caster:GetModifierStackCount("modifier_ice_nova_bonus", nil)
    if event.frostdmg and icenovastacks > 0 then
        value = value + 0.1 * icenovastacks
    end
    if caster:HasModifier("modifier_polybonusdamage") then
        value = value + 0.25
    end
    if event.shadowdmg and caster:HasModifier("modifier_shadowdmgaura") then
        value = value + 0.25
    end
    if event.shadowdmg and caster:HasModifier("modifier_str_unholy") then
        value = value + 0.25
    end
    if event.firedmg and event.isdot and caster:HasModifier("modifier_item_elements") then
        value = value + 0.25
    end
    if event.firedmg and caster:HasModifier("firedmgaura") then
        value = value + 0.1
    end
    local arcane_resi_dmg = caster:FindAbilityByName("Arcane6")
    if (event.firedmg or event.arcanedmg ) and arcane_resi_dmg and arcane_resi_dmg:GetLevel() >= 4 then
        value = value + caster:GetMagicalArmorValue()
    end
    arcane_resi_dmg = caster:FindAbilityByName("frost_lake")
    if event.frostdmg and arcane_resi_dmg and arcane_resi_dmg:GetLevel() >= 4 then
        value = value + 0.5
    end
    local mage1_abil = caster:FindAbilityByName("mage1")
    if target:HasModifier("modifier_frostfire_slow") and (event.firedmg or event.frostdmg ) and mage1_abil and mage1_abil:GetLevel() >= 4 then
        value = value + 0.5
    end
    if event.firedmg and caster:HasModifier("modifier_firedmg_50") then
        value = value + 0.25
    end
    if event.holydmg and caster:HasModifier("modifier_item_bootshp3") then
        value = value + 0.1
    end
    if event.shadowdmg and caster:HasModifier("modifier_item_bootshp4") then
        value = value + 0.1
    end
    if event.holydmg and caster:HasModifier("modifier_holymagicres") then
        value = value + 0.25
    end
    if event.firedmg and caster:HasModifier("modifier_item_fireball4") then
        value = value + 0.05
    end
    if event.firedmg and caster:HasModifier("modifier_item_sandstorm2") then
        value = value + 0.25
    end
    if event.cruelabils and target:HasModifier("modifier_stunned") then
        value = value + 1
    end
    if (event.firedmg or event.shadowdmg) and caster:HasModifier("modifier_shadowflame") then
        value = value + 0.25
    end
    if (event.firedmg or event.shadowdmg) and caster:HasModifier("modifier_ancient_def") then
        value = value + 0.25
    end
    if (event.arcanedmg or event.naturedmg) and caster:HasModifier("modifier_stormrider") then
        value = value + 0.25
    end
    local arcane2_stacks = caster:GetModifierStackCount("modifier_arcane_barrage_bonus", nil)
    if event.arcanedmg and arcane2_stacks > 0 then
        value = value + 0.05 * arcane2_stacks
    end
    if event.arcanedmg and caster:HasModifier("modifier_nether_explosion_buff") then
        value = value + 0.25
    end
    if event.firedmg and caster:HasModifier("modifier_stormrider2") then
        value = value + 0.5
    end
    if event.shadowdmg and caster:HasModifier("modifier_warlockrage") then
        value = value + 0.5
    end
    --mythic
    if event.firedmg and caster:HasModifier("modifier_mythic_firedmg") then
        value = value + caster:GetModifierStackCount("modifier_mythic_firedmg", nil)/100
    end
    if event.arcanedmg and caster:HasModifier("modifier_mythic_arcanedmg") then
        value = value + caster:GetModifierStackCount("modifier_mythic_arcanedmg", nil)/100
    end
    if event.naturedmg and caster:HasModifier("modifier_mythic_naturedmg") then
        value = value + caster:GetModifierStackCount("modifier_mythic_naturedmg", nil)/100
    end
    if event.shadowdmg and caster:HasModifier("modifier_mythic_shadowdmg") then
        value = value + caster:GetModifierStackCount("modifier_mythic_shadowdmg", nil)/100
    end
    if event.frostdmg and caster:HasModifier("modifier_mythic_frostdmg") then
        value = value + caster:GetModifierStackCount("modifier_mythic_frostdmg", nil)/100
    end
    if event.holydmg and caster:HasModifier("modifier_mythic_holydmg") then
        value = value + caster:GetModifierStackCount("modifier_mythic_holydmg", nil)/100
    end
    if event.chaosdmg and caster:HasModifier("modifier_mythic_chaosdmg") then
        value = value + caster:GetModifierStackCount("modifier_mythic_chaosdmg", nil)/100
    end
    if dmgtype == 1 and caster:HasModifier("modifier_mythic_physicaldmg") then
        value = value + caster:GetModifierStackCount("modifier_mythic_physicaldmg", nil)/100
    end

    if event.naturedmg and caster:HasModifier("modifier_ranger_as_bonus_surv") then
        value = value + 0.5
    end
    if event.poisondmg and caster:HasModifier("modifier_item_viper_blade") then
        value = value + 0.25
    end
    if event.poisondmg and caster:HasModifier("modifier_item_viper_blade2") then
        value = value + 0.4
    end
    if (event.firedmg or event.naturedmg or event.frostdmg or event.arcanedmg) and caster:HasModifier("modifier_master_elements") then
        value = value + 0.5
    end
    if event.naturedmg and caster:HasModifier("modifier_item_nova_blade") then
        value = value + 0.25
    end
    if event.naturedmg and caster:HasModifier("modifier_item_nature") then
        value = value + 0.5
    end
    if event.naturedmg and caster:HasModifier("modifier_item_nova_blade2") then
        value = value + 0.4
    end
    local rangerelementtalent = caster:FindAbilityByName("wind7")
    if (event.firedmg or event.naturedmg or event.shadowdmg) and rangerelementtalent and rangerelementtalent:GetLevel() >= 4 then
        value = value + 0.15
    end
    local rogue_bounty_poison_talent = caster:FindAbilityByName("combat6")
    if (event.poisondmg or event.naturedmg) and rogue_bounty_poison_talent and rogue_bounty_poison_talent:GetLevel() >= 4 then
        value = value + 0.5
    end
    local polymorph_talent = caster:FindAbilityByName("Polymorph")
    if polymorph_talent and polymorph_talent:GetLevel() >= 4 then
        local speed = caster:GetMoveSpeedModifier(caster:GetBaseMoveSpeed()) - 300
        if speed > 0 then
            value = value + 0.0025 * speed
        end
    end
    local int_to_holy_pala = caster:FindAbilityByName("pala4")
    if event.holydmg and int_to_holy_pala and int_to_holy_pala:GetLevel() >= 4 then
        local bonus_fire = GetIntellectCustom(caster) * 0.001
        --if bonus_fire > 0.3 then
        --    bonus_fire = 0.3
        --end
        value = value + bonus_fire
    end
    local agi_to_holy_pala = caster:FindAbilityByName("pala5")
    if event.holydmg and agi_to_holy_pala and agi_to_holy_pala:GetLevel() >= 4 then
        local bonus_fire = caster:GetAgility() * 0.001
        --if bonus_fire > 0.3 then
        --    bonus_fire = 0.3
        --end
        value = value + bonus_fire
    end
    local haste_to_fire = caster:FindAbilityByName("Magma_Bolt")
    if caster and caster.spellhaste and event.firedmg and haste_to_fire and haste_to_fire:GetLevel() >= 4 then
        local bonus_fire = caster.spellhaste * 0.15
        --if bonus_fire > 0.3 then
        --    bonus_fire = 0.3
        --end
        value = value + bonus_fire
    end
    local templedk_shadow = caster:FindAbilityByName("templedk1")
    if event.shadowdmg and templedk_shadow and templedk_shadow:GetLevel() >= 4 then
        value = value + 0.25
    end
    haste_to_fire = caster:FindAbilityByName("Shadowfury")
    if caster and caster.spellhaste and event.shadowdmg and haste_to_fire and haste_to_fire:GetLevel() >= 4 then
        local bonus_fire = caster.spellhaste * 0.25
        --if bonus_fire > 0.5 then
        --    bonus_fire = 0.5
        --end
        value = value + bonus_fire
    end
    if caster and caster.spellhaste and event.frostdmg and caster:HasModifier("modifier_class_winter") and caster:HasModifier("modifier_ice_armor") then
        value = value + caster.spellhaste * 0.5
    end
    if (event.firedmg or event.frostdmg) and caster:HasModifier("modifier_item_frostfire") then
        value = value + 0.2
    end
    if (event.firedmg or event.frostdmg) and caster:HasModifier("modifier_item_frostfire2") then
        value = value + 0.3
    end
    if event.frostdmg then
        if caster:HasModifier("modifier_item_element_frost") then
            value = value + 0.25
        end
        if caster:HasModifier("modifier_item_crit_frost_immortal") then
            value = value + 0.4
        end
        if caster:HasModifier("modifier_item_crit_frost_immortal2") then
            value = value + 0.5
        end
    end
    if event.shadowdmg and caster:HasModifier("modifier_item_elements") then
        value = value + 0.25
    end
    if event.holydmg and caster:HasModifier("modifier_crusader_mount") then
        value = value + 0.25
    end
    if event.frostdmg and target:HasModifier("modifier_frost_bonus_arctic") then
        value = value + 0.2
    end
    --multiplicative bonuses
    if (dmgtype == 1 or event.naturedmg) and caster:HasModifier("modifier_bladerush") and caster:HasModifier("modifier_item_rogueblades2") then
        value = (value - 1) * 2 + 1
    end
    if event.shadowdmg and caster:HasModifier("modifier_class_warlock") and target:HasModifier("modifier_dot1") then
        value = (value - 1) * 2 + 1
    end
    if event.frostdmg and caster:HasModifier("modifier_pathbuff_055") then
        value = (value - 1) * 2 + 1
    end
    if caster.talents and caster.talents[55] and caster.talents[55] > 0 then
    	local icestorm_factor = 0.25 * caster.talents[55]
    	if icestorm_factor > 2.5 then
    		icestorm_factor = 2.5
    	end
        value = (value - 1) * (1 + icestorm_factor) + 1
    end
    if event.starfallbonus and event.naturedmg then
    	value = (value - 1) * 2 + 1
    end
    return value
end
--22222

function GetAbilityAOEDamageModifierAdditive( event, caster, real_caster, target, ability, behindtarget, process_procs )
    local value = 1
    --talents
    if caster.talents then
  
    end
    --rune words
    if caster.runeword then

    end
    return value
end

--[[
function GetAbilityDamageModifierAdditive( event, caster, real_caster, target, ability, behindtarget, process_procs )
    local value = 1
    if event.consumesuncharge then
        local stack = caster:GetModifierStackCount("modifier_mooncharge", caster)
        if stack >= 5 then
            caster:RemoveModifierByName("modifier_mooncharge")
            value = value + 1.35
        end
    end
    --if event.moltenlavabonus then
        --local molten_lava_ability = caster:FindAbilityByName("Molten_Lava")
        --if target:HasModifier("fireslow50") and molten_lava_ability and molten_lava_ability:GetLevel() >= 3 then
        --   value = value + 0.4
        --end
    --end
    if event.firelance and target:HasModifier("modifier_magmaburn") and target:HasModifier("fireslow50") then
        value = value + event.firelance - 1
    end
    if caster.elemental_item3 and caster:HasModifier("modifier_item_elements3") then
        local bonusdmg = 0
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
        value = value + bonusdmg
    end
    
    local dk_blood_stacks = caster:GetModifierStackCount("modifier_strikeofvengeance2", nil)
    if dk_blood_stacks > 0 then
        value = value + 0.1 * dk_blood_stacks
    end
    local pala_retal_stacks = caster:GetModifierStackCount("modifier_strikeofvengeance3", nil)
    if pala_retal_stacks > 0 then
        value = value + 0.1 * pala_retal_stacks
    end
    if caster:GetAbilityByIndex(5) and caster:GetAbilityByIndex(5):GetName() == "moon6" and caster:GetAbilityByIndex(5):GetLevel() >= 2 then
        value = value + 0.3
    end
    if event.immolatebonus ~= nil then
        if target:HasModifier("modifier_magmaburn2") then
            value = value + event.immolatebonus/100.0
        end 
    end
    if caster:HasModifier("modifier_item_longbow") and ability == caster:GetAbilityByIndex(2) then
        value = value + 1
    end
    if event.ancientlongbow and caster:HasModifier("modifier_itemhastebow") then
        value = value + 0.25
    end
    if event.ancientlongbow and caster:HasModifier("modifier_item_hunterbow") then
        value = value + 0.35
    end
    if caster:HasModifier("modifier_active9") then
        value = value + 0.3
    end
    if caster:HasModifier("modifier_item_ancient_grizzly") then
        value = value + 0.5
    end
    if event.ambushblade and caster:HasModifier("modifier_item_armoriron2") then
        value = value + 0.15
    end
    if caster:HasModifier("modifier_dmgbonus_cruel") then
        value = value + 0.25
    end
    if (event.shadowdmg or event.holydmg) and target:HasModifier("modifier_holy_shadow_weakness") then
        value = value + 0.2
    end
    if caster:HasModifier("modifier_activepaladin") then
        value = value + 0.25
    end
    if event.untamed and caster:HasModifier("modifier_item_straxe3") then
        value = value + event.untamed - 1
    end
    if caster:HasModifier("modifier_elemental_lust2") then
        value = value+0.25
    end

    if event.rampupdamage then
        if caster.rampupdamage then
            value = value + caster.rampupdamage - 1
        end
    end
    
    --rune words
    if caster.runeword then
        --if event.bloodwolf and caster.runeword[17] then
        --    value = value + 0.01 * caster.runeword[17]
        --end
        if caster.runeword[19] then
            --finaldamage = finaldamage * (1 + 0.01 * caster.runeword[19])
            value = value + 0.01 * caster.runeword[19]
        end
        if caster.runeword[24] and ability and ability == caster:GetAbilityByIndex(2) then
            --finaldamage = finaldamage * (1 + 0.01 * caster.runeword[24])
            value = value + 0.01 * caster.runeword[24]
        end
        if caster.runeword[25] and ability and ability == caster:GetAbilityByIndex(3) then
            --finaldamage = finaldamage * (1 + 0.01 * caster.runeword[25])
            value = value + 0.01 * caster.runeword[25]
        end
        if caster.runeword[26] and ability and ability == caster:GetAbilityByIndex(4) then
            --finaldamage = finaldamage * (1 + 0.01 * caster.runeword[26])
            value = value + 0.01 * caster.runeword[26]
        end
        if caster.runeword[27] and ability and ability == caster:GetAbilityByIndex(1) then
            --finaldamage = finaldamage * (1 + 0.01 * caster.runeword[27])
            value = value + 0.01 * caster.runeword[27]
        end
        if event.runewordscale and event.runewordscale == 10 and caster.runeword[event.runewordscale] and caster.runeword[event.runewordscale] > 0 then
            value = value + caster.runeword[event.runewordscale] / 100
        end
    end

    --target talents, unused
    --if target.talents then
    --    if target.talents[11] then
    --        value = value - 0.1 * target.talents[11]
    --    end
    --end

    
    if event.feralbonus ~= nil then
        value = value + 0.15*target:GetModifierStackCount("modifier_bleedslow", nil)
    end
    if event.thunderstacks then
        value = value + 0.15*caster:GetModifierStackCount("modifier_ele_thunder_stacks", nil)
    end
    local snowrangerbonus = caster:GetModifierStackCount("modifier_ranger_as_bonus", nil)
    if snowrangerbonus > 0 then
        value = value + 0.05 * snowrangerbonus
    end
    local distance = (caster:GetAbsOrigin()-target:GetAbsOrigin()):Length()
    if event.rangeddoubledamage and event.rangeddoubledamage > 0 and distance > event.rangeddoubledamage then
        value = value + 1
        if process_procs then
            local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_abaddon/abaddon_death_coil_explosion_e.vpcf", PATTACH_POINT_FOLLOW, target)
            ParticleManager:ReleaseParticleIndex(particle)
        end
    end
    if event.shadowstrikewl and caster:HasModifier("modifier_item_shadowstrike") then
        local b = 0
        if target:HasModifier("modifier_dot1") then
            b = b + 0.35
        end
        b = b + 0.35*target:GetModifierStackCount("modifier_dot2", nil)
        if target:HasModifier("modifier_dot4") then
            b = b + 0.35
        end
        value = value + b
    end
    if event.shadowstrikesp and caster:HasModifier("modifier_item_shadowstrike") then
        local b = 0
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
        value = value + b
    end
    local dhabiltalent = caster:FindAbilityByName("dh1")
    if dhabiltalent and dhabiltalent:GetLevel() >= 4 then
        value = value + caster:GetAgility() * 0.002
    end
    
    local bearroartalent = caster:FindAbilityByName("bear6")
    if bearroartalent and bearroartalent:GetLevel() >= 3 and caster:HasModifier("modifier_bear_roar_armor") then
        value = value + 0.5
    end
    local fury_as_abil = caster:FindAbilityByName("fury2")
    if fury_as_abil and fury_as_abil:GetLevel() >= 4 then
        value = value + 0.05 * caster:GetIncreasedAttackSpeed()
    end
    local arcane_resi_dmg = caster:FindAbilityByName("Arcane6")
    if arcane_resi_dmg and arcane_resi_dmg:GetLevel() >= 4 then
        value = value + 1 * caster:GetMagicalArmorValue()
    end
    local dk_resi_dmg = caster:FindAbilityByName("Rot")
    if dk_resi_dmg and dk_resi_dmg:GetLevel() >= 4 then
        value = value + 1 * caster:GetMagicalArmorValue()
    end
    if caster:HasModifier("item_mother_of_dragons") then
        value = value + 0.15
    end
    
    if event.brutalsetscale and caster:HasModifier("modifier_item_set_str_t3_2_full_dream") then
        value = value + 2
    end

    local arcane_barrage_stacks = caster:GetModifierStackCount("modifier_arcane_barrage_bonus", nil)
    if event.isarcanebarrage and arcane_barrage_stacks > 0 then
        value = value + 0.1 * arcane_barrage_stacks
    end
    
    if event.dreamfeastbonus and target:HasModifier("modifier_swd") then
        value = value + event.dreamfeastbonus - 1
    end
    
    if event.starfallbonus and caster:HasModifier("modifier_item_dmg4") then
        value = value + 1
    end
    if caster:HasModifier("modifier_item_silverblood2_active") then
        value = value + 0.25
    end
    if caster:HasModifier("modifier_item_int_set_t3_active") then
        value = value + 1.3
    end
    if event.warlockdrainbonus ~= nil then
        local drainbonus = 0
        if target:HasModifier("modifier_dot1") then
            drainbonus = drainbonus + event.warlockdrainbonus
        end
        drainbonus = drainbonus + event.warlockdrainbonus*target:GetModifierStackCount("modifier_dot2", nil)
        if target:HasModifier("modifier_dot4") then
            drainbonus = drainbonus + event.warlockdrainbonus
        end
        value = value + drainbonus
    end
    if caster:HasModifier("modifier_shadowstep1") then
        value = value + 0.3
    end
    --if caster:HasModifier("modifier_axe_dmg_titan") then
    --    value = value+0.25
    --end
    if caster:HasModifier("modifier_tigerfury") then
        value = value+0.4
    end
    local furycatstacks = caster:GetModifierStackCount("modifier_furycat", nil)
    if event.feralleapbonus and furycatstacks > 0 then
        value = value + 0.25 * furycatstacks
    end
    local icenovastacks = caster:GetModifierStackCount("modifier_ice_nova_bonus", nil)
    if event.frostdmg and icenovastacks > 0 then
        value = value+ 0.1 * icenovastacks
    end
    local abil_dmg_stacks_5 = caster:GetModifierStackCount("modifier_abil_bonus_5_percent", nil)
    if abil_dmg_stacks_5 > 0 then
        value = value + 0.05 * abil_dmg_stacks_5
    end
    --if caster:HasModifier("modifier_talent_enrage") then
    --    if caster.runeword and caster.runeword[14] then
    --        value = value + caster.runeword[14]/100
    --   end
    --end
    --if caster:HasModifier("modifier_talent_enrage_2") and caster.talents and caster.talents[45] and caster.talents[45] > 0 then
    --    value = value + 0.25 * caster.talents[45]
    --end
    if event.chaosstrike and caster:HasModifier("modifier_metamorph_dh") then
        value = value + event.chaosstrike - 1
    end
    if event.championprot and caster:HasModifier("modifier_item_straxe2") then
        local shieldbashstack = caster:GetModifierStackCount("modifier_shieldbash", caster)
        value = value + 0.1 * shieldbashstack
    end
    local talentfurytitan = caster:FindAbilityByName("fury6")
    if talentfurytitan and talentfurytitan:GetLevel() >= 4 then
        value = value + 0.15
    end
    if caster:HasModifier("modifier_mythic_abil") then
        value = value + caster:GetModifierStackCount("modifier_mythic_abil", nil)/100
    end
    if event.moonburn and caster:HasModifier("modifier_moonburn_cd") then
        value = value + 1
    end
    local disctalent = caster:FindAbilityByName("Soul_Burn")
    if disctalent and disctalent:GetLevel() >= 3 then
        value = value + 0.1
    end
    if event.feralleapbonus and caster:HasModifier("modifier_asbonus") then
        value = value + 0.5
    end
    if caster:HasModifier("modifier_item_night_shoulders") and caster:GetAbilityByIndex(4) == ability then
        value = value + 2
    end
    if caster:HasModifier("modifier_arcaneweak") and event.arcanedmg and event.netherblast then
        local stacks = caster:GetModifierStackCount("modifier_arcaneweak", nil)
        if caster:GetMana() >= 0.4*15*stacks then
            value = value + 0.3*stacks
            if process_procs then
                caster:SetMana(caster:GetMana() - 0.4*15*stacks)
            end
        end
    end
    if event.mutilate then
        value = value + (event.mutilate*target:GetModifierStackCount("modifier_deadlypoison", nil)/100)
    end

    return value
end
]]

function HasClassItem( caster, level )
    local buffname = "modifier_"..caster:GetUnitName()
    if level > 1 then
        buffname = buffname..tostring(level)
    end
    if caster:HasModifier(buffname) then
        return true
    end
    --[[
    if buffname == "modifier_npc_dota_hero_furion" and caster:GetUnitName() == "npc_dota_hero_enchantress" then
        return true
    end
    --if buffname == "modifier_npc_dota_hero_furion" and caster:GetUnitName() == "npc_dota_hero_abaddon" then
    --    return true
    --end
    if buffname == "modifier_npc_dota_hero_windrunner" and caster:GetUnitName() == "npc_dota_hero_clinkz" then
        return true
    end
    if buffname == "modifier_npc_dota_hero_sniper" and caster:GetUnitName() == "npc_dota_hero_clinkz" then
        return true
    end
    if buffname == "npc_dota_hero_drow_ranger" and caster:GetUnitName() == "npc_dota_hero_clinkz" then
        return true
    end
    if buffname == "modifier_npc_dota_hero_furion" and caster:GetUnitName() == "npc_dota_hero_enchantress" then
        return true
    end
    if buffname == "modifier_npc_dota_hero_furion" and caster:GetUnitName() == "npc_dota_hero_enchantress" then
        return true
    end
    if buffname == "modifier_npc_dota_hero_furion" and caster:GetUnitName() == "npc_dota_hero_enchantress" then
        return true
    end
    if buffname == "modifier_npc_dota_hero_furion" and caster:GetUnitName() == "npc_dota_hero_enchantress" then
        return true
    end
    if buffname == "modifier_npc_dota_hero_furion" and caster:GetUnitName() == "npc_dota_hero_enchantress" then
        return true
    end]]
    return false
end

function GetAbilityDamageModifierMultiplicative( event, caster, real_caster, target, ability, behindtarget, is_very_big_hit, isaoe, process_procs, wascrit, pure_dmg )
    local multiplicative_bonus = 1
    local hp_percent = target:GetHealth() / target:GetMaxHealth()
    --spellcast frenzy
    if ability == caster:GetAbilityByIndex(1) and ((not event.spellcastfrenzy) or (event.spellcastfrenzy and event.spellcastfrenzy == 0)) and caster:HasModifier("modifier_pathbuff_044") then
        event.spellcastfrenzy = 0.05
        event.spellcastfrenzy_max = 0.5
    end
    if ability == caster:GetAbilityByIndex(2) and ((not event.spellcastfrenzy) or (event.spellcastfrenzy and event.spellcastfrenzy == 0)) and caster:HasModifier("modifier_pathbuff_002") then
        event.spellcastfrenzy = 0.03
        event.spellcastfrenzy_max = 0.6
    end
    if event.iceflame_bolt then
        multiplicative_bonus = multiplicative_bonus * 1.25
    end
    if caster:IsRealHero() and caster:GetPrimaryAttribute() == 2 then
        multiplicative_bonus = multiplicative_bonus * (1 + 0.0007 * GetIntellectCustom(caster))
    end
    if isaoe and caster:HasModifier("modifier_item_shadowmourne_active") then
        multiplicative_bonus = multiplicative_bonus * 2
    end
    if caster:HasModifier("modifier_windfury_path") and caster:HasModifier("modifier_windbreaker") and caster:HasModifier("modifier_pathbuff_083") then
        multiplicative_bonus = multiplicative_bonus * 1.25
    end
    if event.starfallbonus and caster:HasModifier("modifier_pathbuff_068") and caster.path_dark_ritual and caster.path_dark_ritual > 0 then
        multiplicative_bonus = multiplicative_bonus * 2
    end
    if event.icestorm and caster:HasModifier("modifier_pathbuff_072") then
        multiplicative_bonus = multiplicative_bonus * 1.5
    end
    if event.spellcastfrenzy and event.spellcastfrenzy > 0 and caster.spellcast_tracking then
        local dmg_bonus = event.spellcastfrenzy
        local abilityname = ability:GetName()
        local found_ability = false
        for k, v in pairs( caster.spellcast_tracking ) do
            if k == abilityname then
                found_ability = true
                if v and v[1] and v[1] == target and v[2] then
                    --same target, increase bonus
                    multiplicative_bonus = multiplicative_bonus * (1 + v[2])
                    v[2] = v[2] + event.spellcastfrenzy
                    if caster:HasModifier("modifier_pathbuff_015") and event.spellcastfrenzy_max then
                        event.spellcastfrenzy_max = event.spellcastfrenzy_max * 1.5
                    end
                    if event.spellcastfrenzy_max and v[2] > event.spellcastfrenzy_max then
                        v[2] = event.spellcastfrenzy_max
                    end 
                else
                    --new target
                    v = {target, dmg_bonus}
                    caster.spellcast_tracking[abilityname] = {target, dmg_bonus}
                end
            end
        end
        if not found_ability then
            caster.spellcast_tracking[abilityname] = {target, dmg_bonus}
        end
    end
    if hp_percent > 0.75 and caster:HasModifier("modifier_pathbuff_070") then
        multiplicative_bonus = multiplicative_bonus * 1.25
    end
    if wascrit and pure_dmg and caster:HasModifier("modifier_pathbuff_052") then
        multiplicative_bonus = multiplicative_bonus * 1.5
    end
    if caster:IsRealHero() then
        if not caster.temple_class then
            multiplicative_bonus = multiplicative_bonus * (1 + 0.01 * caster:GetLevel())
        else
            multiplicative_bonus = multiplicative_bonus * (1 + 0.005 * caster:GetLevel())
        end
    end
    if (event.netherchaos or event.netherchaos_low) and caster:HasModifier("modifier_item_netherchaos") then
        multiplicative_bonus = multiplicative_bonus * 2
    end
    if is_very_big_hit and (caster:HasModifier("modifier_item_bighit") or caster:HasModifier("modifier_item_bighit_2")) then
        multiplicative_bonus = multiplicative_bonus * 1.5
        --[[if process_procs then
            if not caster.very_big_hit_cd then
                local particle = ParticleManager:CreateParticle("particles/necro_ti7_immortal_scythe_start_only_ghost.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
                ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin())
                ParticleManager:ReleaseParticleIndex(particle)
                caster.very_big_hit_cd = true
                Timers:CreateTimer(2.0, function()
                    caster.very_big_hit_cd = nil
                end)
            end
        end]]
    end
    if caster:HasModifier("modifier_pathbuff_032") and ability == caster:GetAbilityByIndex(0) then
        multiplicative_bonus = multiplicative_bonus * 1.15
    end
    if caster:HasModifier("modifier_special_bonus_day_vision") then
        multiplicative_bonus = multiplicative_bonus * 1.05
    end
    if hp_percent > 0.5 and caster:HasModifier("modifier_pathbuff_021") then
        multiplicative_bonus = multiplicative_bonus * 1.15
    end
    if caster:HasModifier("modifier_myth_str_abil") then
        multiplicative_bonus = multiplicative_bonus * 1.25
    end
    if caster:HasModifier("modifier_item_myth_str") then
        multiplicative_bonus = multiplicative_bonus * 1.25
    end
    if caster:HasModifier("modifier_item_myth_agi") then
        multiplicative_bonus = multiplicative_bonus * 1.25
    end
    if caster:HasModifier("modifier_item_myth_int") then
        multiplicative_bonus = multiplicative_bonus * 1.25
    end
    if event.warlockdot2 and caster:HasModifier("modifier_class_warlock") then
        multiplicative_bonus = multiplicative_bonus * 2
    end
    if event.warlockdot then
        local warlocktalent = caster:FindAbilityByName("Pain_Warlock")
        if warlocktalent and warlocktalent:GetLevel() >= 4 and caster:HasModifier("modifier_dot1") and caster:HasModifier("modifier_dot2") and caster:HasModifier("modifier_dot4") then
            multiplicative_bonus = multiplicative_bonus * 2
        end
    end
    if pure_dmg then
        local drow_pure_bonus = caster:FindAbilityByName("Mindfreezing_Shot")
        if drow_pure_bonus and drow_pure_bonus:GetLevel() >= 3 then
            multiplicative_bonus = multiplicative_bonus * 1.25
        end
    end
    if caster:HasModifier("modifier_wl_shield") then
        local fear_ability = caster:FindAbilityByName("Fear_Warlock")
        if fear_ability and fear_ability:GetLevel() >= 4 and ability and ability:GetName() == "dark_ranger_life_drain" then
            multiplicative_bonus = multiplicative_bonus * 2
        end
    end
    if event.isdot and caster:HasModifier("modifier_item_rogueblades2") and caster:HasModifier("modifier_furycat") then
        multiplicative_bonus = multiplicative_bonus * 1.5
    end
    if event.isdot and caster:HasModifier("modifier_axestorm_dot") then
        multiplicative_bonus = multiplicative_bonus * 2
    end
    if not event.was_stars_aligned_first_crit and caster:HasModifier("modifier_crit_moon_cd") and caster:HasModifier("modifier_moonlighttiger") then
        multiplicative_bonus = multiplicative_bonus * 1.25
    end
    if caster:HasModifier("modifier_fanatism_2") and caster:HasModifier("modifier_class_sanctified") then
        multiplicative_bonus = multiplicative_bonus * 1.25
    end
    if caster:HasModifier("modifier_divine_sprint") and caster:HasModifier("modifier_class_deadly") then
        multiplicative_bonus = multiplicative_bonus * 1.5
    end
    if (event.viperpoison or event.serpentpoison) and caster:HasModifier("modifier_npc_dota_hero_windrunner") then
        multiplicative_bonus = multiplicative_bonus * 3
    end
    if event.classitemdmgfactor and caster:HasModifier(event.classitemdmgfactorbuff) then
        multiplicative_bonus = multiplicative_bonus * event.classitemdmgfactor
    end
    if caster.channel_item_bonus then
        multiplicative_bonus = multiplicative_bonus * 1.25
    end
    if caster.ability_combo_6_bonus and (caster:HasModifier("modifier_item_titanarmor") or caster:HasModifier("modifier_item_titanarmor_2")) then
        multiplicative_bonus = multiplicative_bonus * 2
    end
    if caster:HasModifier("modifier_element_chaos") and isaoe then
        multiplicative_bonus = multiplicative_bonus * 1.3
    end
    if caster:HasModifier("modifier_pathbuff_085") and isaoe then
        multiplicative_bonus = multiplicative_bonus * 1.3
    end
    if ability:GetCooldown(ability:GetLevel()) <= 0 and caster:HasModifier("modifier_item_myth_aa") then
        multiplicative_bonus = multiplicative_bonus * 1.5
    end
    if caster:HasModifier("modifier_talent_enrage") and caster.talents and caster.talents[47] and caster.talents[47] > 0 then
        local ancient = 0.15 * caster.talents[47]
        if caster:HasModifier("modifier_item_sp4") then
            ancient = ancient + 0.3
        end
        --if caster:HasModifier("modifier_item_ancient_wolf") then
         --   ancient = ancient + 0.3
       --end
        multiplicative_bonus = multiplicative_bonus * ( 1 + ancient )
    end
    if event.fireconsecbonus and event.fireconsecbonus > 0 and target:HasModifier("modifier_magmaburn") then
        multiplicative_bonus = multiplicative_bonus * (1 + event.fireconsecbonus/100)
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_techies/techies_remote_mine_detonate_embers.vpcf", PATTACH_POINT_FOLLOW, target)
        ParticleManager:ReleaseParticleIndex(particle)
    end
    if caster.lifeblood then
    	local true_blood_bonus = 1
    	if caster.aa_crit_counter_last_10_secs and caster.aa_crit_counter_last_10_secs > 0 then
    		true_blood_bonus = 3
    	end
        multiplicative_bonus = multiplicative_bonus * ((caster.lifeblood - 1) * true_blood_bonus + 1)
    end
    if caster:HasModifier("modifier_pathbuff_058") then
        local percent_hp = caster:GetHealth() / caster:GetMaxHealth()
        multiplicative_bonus = multiplicative_bonus * (1 + 1 - percent_hp)
    end
    if caster:HasModifier("modifier_axe_dmg_titan") and caster:GetAbilityByIndex(4) and caster:GetAbilityByIndex(4) == ability then
        multiplicative_bonus = multiplicative_bonus * 1.25
    end
    local dhchaostalent = caster:FindAbilityByName("dh4")
    if dhchaostalent and dhchaostalent:GetLevel() >= 3 and event.chaosstrike and caster:HasModifier("modifier_aoeantimagic_dh_buff") then
        multiplicative_bonus = multiplicative_bonus * 1.5
    end
    if caster.talents then
        if caster.talents[5] and caster.talents[5] > 0 and isaoe then
            local bonus_per_armor = 0.0033
            local bonus_factor = 1 + bonus_per_armor * caster.talents[5] * caster:GetPhysicalArmorValue()
            --if caster:GetPrimaryAttribute() == 1 then
            --    bonus_per_armor = 0.0016
            --end
            if bonus_factor > 2 then
                bonus_factor = 2
            end
            multiplicative_bonus = multiplicative_bonus * bonus_factor
        end
        if caster.talents and caster.talents[7] and caster.talents[7] > 0 then
            local talent7_buff = caster:GetModifierStackCount("modifier_talent_maul", nil)
            multiplicative_bonus = multiplicative_bonus * (1 + 0.005 * talent7_buff)
        end
        if caster.talents[9] and caster.talents[9] > 0 then
            local factor = (1 + 0.0016 * caster.talents[9] * caster:GetPhysicalArmorValue())
            local max = 1 + 0.15 * caster.talents[9]
            if factor > max then
                factor = max
            end
            multiplicative_bonus = multiplicative_bonus * factor
        end
        if caster.talents[11] and caster.talents[11] > 0 then
            multiplicative_bonus = multiplicative_bonus * (1 + 0.03 * caster.talents[11])
        end
        if caster.talents[28] and caster.talents[28] > 0 and ability and ability:GetCooldown(ability:GetLevel()) >= 20 then
            multiplicative_bonus = multiplicative_bonus * (1 + 0.05 * caster.talents[28])
        end
        if event.isdot and caster.talents[49] and caster.talents[49] > 0 then
            multiplicative_bonus = multiplicative_bonus * (1 + 0.2 * caster.talents[49])
        end
        if event.isdot and caster.talents[36] and caster.talents[36] > 0 then
            multiplicative_bonus = multiplicative_bonus * (1 + 0.05 * caster.talents[36])
        end
        if caster.talents[72] and caster.talents[72] > 0 then
            multiplicative_bonus = multiplicative_bonus * (1 + 0.08 * caster.talents[72])
        end
        if caster.talents[64] and caster.talents[64] > 0 and caster:GetAbilityByIndex(3) == ability then
            multiplicative_bonus = multiplicative_bonus * (1 + 0.07 * caster.talents[64])
        end
        if caster.talents and caster.talents[74] and caster.talents[74] > 0 and caster.path_sacrifice_souls_paid then
        	local bonus_first_3 = 1
        	if caster.path_sacrifice_souls_paid >= 2 then
        		caster.path_sacrifice_souls_paid = caster.path_sacrifice_souls_paid - 1
        		bonus_first_3 = 2
        		local particle = ParticleManager:CreateParticle("particles/econ/items/shadow_demon/sd_ti7_shadow_poison/sd_ti7_shadow_poison_kill.vpcf", PATTACH_ABSORIGIN, target)
				ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin() + Vector(0,0,50))
				ParticleManager:SetParticleControl(particle, 2, target:GetAbsOrigin() + Vector(0,0,50))
			    ParticleManager:ReleaseParticleIndex(particle)
        	end
            multiplicative_bonus = multiplicative_bonus * (1 + 0.1 * caster.talents[74] * bonus_first_3)
            if ability:GetCooldown(ability:GetLevel()) >= 10 and caster:HasModifier("modifier_pathbuff_074") then
                multiplicative_bonus = multiplicative_bonus * 1.25
            end
        end
        if caster.standsstill and caster.talents[20] then
            local standsstill = caster.standsstill
            if standsstill > 5 then
                standsstill = 5
            end
            multiplicative_bonus = multiplicative_bonus * (1 + 0.02 * caster.talents[20] * standsstill)
        end
        local glass_cannon = caster:GetModifierStackCount("modifier_talent_glass_cannon", nil)
        if glass_cannon > 0 then
            multiplicative_bonus = multiplicative_bonus * (1 + 0.15 * glass_cannon)
        end
        if event.bloodwolf and caster.talents[32] then --channel bonus
             multiplicative_bonus = multiplicative_bonus * (1 + 0.4 * caster.talents[32])
        end
        local keeper1_stacks = caster:GetModifierStackCount("modifier_keeper_spellhaste", nil)
        if event.bloodwolf and keeper1_stacks > 0 then --channel bonus
             multiplicative_bonus = multiplicative_bonus * (1 + 0.15 * keeper1_stacks)
        end
        if behindtarget and caster.talents[44] then
             multiplicative_bonus = multiplicative_bonus * (1 + 0.1 * caster.talents[44])
        end
        if caster.talents[35] and caster.talents[35] > 0 then
            if (caster:GetAbsOrigin() - target:GetAbsOrigin()):Length() > 500 then
                 multiplicative_bonus = multiplicative_bonus * (1 + 0.08 * caster.talents[35])
            end
        end
        if caster.talents[86] and caster.talents[86] > 0 then
            local point_of_damaging_unit = caster:GetAbsOrigin()
            if event.fromsummon or event.fromcompanion then --summons and companions cause master dmg, need to adjust position to summon position
                if event.attacker then
                    point_of_damaging_unit = event.attacker:GetAbsOrigin()
                end
            end
            local distance = (point_of_damaging_unit - target:GetAbsOrigin()):Length()
            if distance > 600 then
                if distance > 1200 then
                    distance = 1200
                end
                distance = (distance - 600) / 100
                multiplicative_bonus = multiplicative_bonus * (1 + 0.0333 * caster.talents[86] * distance)
            end
        end
        --if caster.talents[24] and caster.talents[24] > 0 then
        --     multiplicative_bonus = multiplicative_bonus * (1 + 0.25 * caster.talents[24])
        --end
        if caster.talents[52] and caster.talents[52] > 0 then
            local tiger_stacks = caster:GetModifierStackCount("modifier_talent_tiger_prowl", nil)
            multiplicative_bonus = multiplicative_bonus * (1 + 0.01 * caster.talents[52] * tiger_stacks)
        end
        if caster.talents[36] and caster.talents[36] > 0 then
            if caster.path_dragon_fire and caster.path_dragon_fire > 0 then
                multiplicative_bonus = multiplicative_bonus * (1 + 0.05 * caster.talents[36])
            end
            --[[
            if event.firedmg then
                caster.talent_next_non_fire_bonus = 0.1 * caster.talents[36]
                caster.talent_next_non_fire_counter = 5
            end
            if not event.firedmg and caster.talent_next_non_fire_bonus and caster.talent_next_non_fire_bonus > 0 and caster.talent_next_non_fire_counter and caster.talent_next_non_fire_counter > 0 then
                multiplicative_bonus = multiplicative_bonus * (1 + caster.talent_next_non_fire_bonus)
                caster.talent_next_non_fire_counter = caster.talent_next_non_fire_counter - 1
            end
            ]]
        end
        if caster.talents[48] and caster.talents[48] > 0 and (target:GetPhysicalArmorValue() < 15 or target:GetMagicalArmorValue() < 45) then
             multiplicative_bonus = multiplicative_bonus * (1 + 0.07 * caster.talents[48])
        end
        --if caster.talents[50] and caster.talents[50] > 0 and not isaoe then
        --     multiplicative_bonus = multiplicative_bonus * (1 + 0.05 * caster.talents[50])
        --end
        if caster.talents[12] and caster.talents[12] > 0 and ability and (ability:GetCooldown(ability:GetLevel()) <= 5 or (ability:GetCooldown(ability:GetLevel()) <= 10 and caster:HasModifier("modifier_pathbuff_001"))) then
            local factor = 0.1
            if not caster:IsRangedAttacker() then
                factor = 0.2
            end
            multiplicative_bonus = multiplicative_bonus * (1 + factor * caster.talents[12])
        end
        if caster.talents[67] and caster.talents[67] > 0 and isaoe then
            multiplicative_bonus = multiplicative_bonus * (1 + 0.07 * caster.talents[67])
        end
        if caster.talents[36] and caster.talents[36] > 0 and isaoe then
            multiplicative_bonus = multiplicative_bonus * (1 + 0.05 * caster.talents[36])
        end
        if caster.talents[66] and caster.talents[66] > 0 and (ability == caster:GetAbilityByIndex(1) or (ability == caster:GetAbilityByIndex(3) and caster:HasModifier("modifier_pathbuff_038"))) then
            multiplicative_bonus = multiplicative_bonus * (1 + 0.08 * caster.talents[66])
            if math.random(1,100) <= 25 and caster.combat_system_ability then
            	caster.combat_system_ability:ApplyDataDrivenModifier(caster, caster, "system_aacrit", nil)
        		caster:SetModifierStackCount("system_aacrit", caster.combat_system_ability, 1500 + 500 * caster.talents[66])
            end
        end
        if caster.talents[4] and caster.talents[4] > 0 and ability == caster:GetAbilityByIndex(2) then
            multiplicative_bonus = multiplicative_bonus * (1 + 0.07 * caster.talents[4])
        end
        if caster.talents[8] and caster.talents[8] > 0 and (ability == caster:GetAbilityByIndex(4) or is_very_big_hit) then
            multiplicative_bonus = multiplicative_bonus * (1 + 0.08 * caster.talents[8])
        end
        if caster.talents[68] and caster.talents[68] > 0 then
            if caster.path_dark_ritual and caster.path_dark_ritual > 0 then
                multiplicative_bonus = multiplicative_bonus * (1 + 0.05 * caster.talents[68])
            end
            if ability:GetAbilityIndex() == 5 then
                multiplicative_bonus = multiplicative_bonus * (1 + 0.15 * caster.talents[68])
            end
        end
        if caster.talents[70] and caster:HasModifier("modifier_path_from_shadows") then
            multiplicative_bonus = multiplicative_bonus * (1 + 0.1 * caster.talents[70])
        end
        if caster.talents[77] and not wascrit then
            multiplicative_bonus = multiplicative_bonus * (1 + 0.2 * caster.talents[77])
        end
        if caster.talents[81] and caster:HasModifier("modifier_skyfall") then
            multiplicative_bonus = multiplicative_bonus * (1 + 0.15 * caster.talents[81])
        end
        local stack = caster:GetModifierStackCount("modifier_stormclaws", caster)
        if (not event.fromcompanion) and stack >= 5 and caster.talents[78] then
            caster:RemoveModifierByName("modifier_stormclaws")
            multiplicative_bonus = multiplicative_bonus * (1 + 0.15 * caster.talents[78])
        end
        if caster.nearby_enemies and caster.nearby_enemies > 0 and caster.talents[85] and caster.talents[85] > 0 then
            local enemy_count = caster.nearby_enemies
            local enemy_cap = 8
            if not caster:IsRangedAttacker() then
                enemy_cap = 12
            end
            if enemy_count > enemy_cap then
                enemy_count = enemy_cap
            end
            multiplicative_bonus = multiplicative_bonus * (1 + 0.02 * caster.talents[85] * enemy_count)
        end
        local crowfall = caster:GetModifierStackCount("modifier_crowfall", nil)
        if crowfall > 0 then
            multiplicative_bonus = multiplicative_bonus * (1 + 0.0333 * crowfall)
        end
    end
    local fire_dot_talent = caster:FindAbilityByName("Molten_Lava")
    if fire_dot_talent and fire_dot_talent:GetLevel() >= 4 then
        multiplicative_bonus = multiplicative_bonus * 1.25
    end
    if event.isdot and caster:HasModifier("modifier_item_ancient_dot") then
        multiplicative_bonus = multiplicative_bonus * 1.25
    end
    if event.isdot and caster:HasModifier("modifier_item_nature") then
        multiplicative_bonus = multiplicative_bonus * 1.5
    end
    if event.isfireball and caster:HasModifier("modifier_fireball_bonus") then
        multiplicative_bonus = multiplicative_bonus * 1.25
    end
    if event.t3bonus and caster:HasModifier("modifier_item_set_agi_t3_full") then
        multiplicative_bonus = multiplicative_bonus * 1.3
    end
    if event.t3bonus and caster:HasModifier("modifier_item_set_str_t3_full") then
        multiplicative_bonus = multiplicative_bonus * 1.3
    end
    if event.ancientlongbow and caster:HasModifier("modifier_item_hunterbow") then
        multiplicative_bonus = multiplicative_bonus * 1.25
    end
    if event.ancientlongbow and caster:HasModifier("modifier_item_hunterbow2") then
        multiplicative_bonus = multiplicative_bonus * 1.3
    end
    if caster:HasModifier("modifier_item_silverblood2_active") then
        multiplicative_bonus = multiplicative_bonus * 1.25
    end
    if event.bloodwolf and caster:HasModifier("modifier_item_shadowstrike") then
        multiplicative_bonus = multiplicative_bonus * 1.5
    end
    if caster:HasModifier("modifier_elemental_lust2") then
        multiplicative_bonus = multiplicative_bonus * 1.25
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
        multiplicative_bonus = multiplicative_bonus * bonusdmg
    end
    if caster:HasModifier("modifier_activepaladin") then
        multiplicative_bonus = multiplicative_bonus * 1.25
    end
    if event.untamed and caster:HasModifier("modifier_item_straxe3") then
        multiplicative_bonus = multiplicative_bonus * 2
    end
    if caster:HasModifier("modifier_item_int_set_t3_active") then
        multiplicative_bonus = multiplicative_bonus * 1.3
    end
    if caster:HasModifier("modifier_item_night_shoulders") and caster:GetAbilityByIndex(4) == ability then
        multiplicative_bonus = multiplicative_bonus * 2
    end
    if caster:HasModifier("modifier_item_longbow") and ability == caster:GetAbilityByIndex(2) then
        multiplicative_bonus = multiplicative_bonus * 1.5
    end
    if caster:HasModifier("modifier_item_ancient_grizzly") then
        multiplicative_bonus = multiplicative_bonus * 1.25
    end
    if caster:HasModifier("modifier_active9") then
        multiplicative_bonus = multiplicative_bonus * 1.25
    end
    if event.thunderstacks then
        multiplicative_bonus = multiplicative_bonus * (1 + 0.1 *caster:GetModifierStackCount("modifier_ele_thunder_stacks", nil))
    end
    if not event.fromsummon then
        multiplicative_bonus = multiplicative_bonus * (1 + 0.01 *caster:GetModifierStackCount("modifier_beastitem", nil))
    end
    if caster:HasModifier("modifier_tigerfury") then
        multiplicative_bonus = multiplicative_bonus * 1.25
    end
    if event.feralleapbonus and caster:HasModifier("modifier_asbonus") then
        multiplicative_bonus = multiplicative_bonus * 2
    end
    if event.moonburn and caster:HasModifier("modifier_moonburn_cd") then
        multiplicative_bonus = multiplicative_bonus * 2
    end
    if event.consumesuncharge then
        local stack = caster:GetModifierStackCount("modifier_mooncharge", caster)
        if stack >= 5 then
            caster:RemoveModifierByName("modifier_mooncharge")
            multiplicative_bonus = multiplicative_bonus * 1.35
        end
    end
    local dk_blood_stacks = caster:GetModifierStackCount("modifier_strikeofvengeance2", nil)
    if dk_blood_stacks > 0 then
        multiplicative_bonus = multiplicative_bonus * (1 + 0.1 * dk_blood_stacks)
    end
    local pala_retal_stacks = caster:GetModifierStackCount("modifier_strikeofvengeance3", nil)
    if pala_retal_stacks > 0 then
        multiplicative_bonus = multiplicative_bonus * (1 + 0.1 * pala_retal_stacks)
    end
    if event.immolatebonus ~= nil then
        if target:HasModifier("modifier_magmaburn2") then
            multiplicative_bonus = multiplicative_bonus * (1 + event.immolatebonus/100.0)
        end 
    end
    if event.ancientlongbow and caster:HasModifier("modifier_itemhastebow") then
        multiplicative_bonus = multiplicative_bonus * 1.25
    end
    if event.ambushblade and caster:HasModifier("modifier_item_armoriron2") then
        multiplicative_bonus = multiplicative_bonus * 1.15
    end
    --reworked until here

    if caster:HasModifier("modifier_dmgbonus_cruel") then
        multiplicative_bonus = multiplicative_bonus * 1.25
    end
    
    --rune words
    if caster.runeword then
        if caster.runeword[19] then
            multiplicative_bonus = multiplicative_bonus * (1 + 0.01 * caster.runeword[19])
        end
        --if caster.runeword[24] and ability and ability == caster:GetAbilityByIndex(2) then
        --    multiplicative_bonus = multiplicative_bonus * (1 + 0.01 * caster.runeword[24])
        --end
        if caster.runeword[25] and ability and ability == caster:GetAbilityByIndex(3) then
            multiplicative_bonus = multiplicative_bonus * (1 + 0.01 * caster.runeword[25])
        end
        --if caster.runeword[26] and ability and ability == caster:GetAbilityByIndex(4) then
        --    multiplicative_bonus = multiplicative_bonus * (1 + 0.01 * caster.runeword[26])
        --end
        if caster.runeword[27] and ability and ability == caster:GetAbilityByIndex(1) then
            multiplicative_bonus = multiplicative_bonus * (1 + 0.01 * caster.runeword[27])
        end
        if event.runewordscale and event.runewordscale == 10 and caster.runeword[event.runewordscale] and caster.runeword[event.runewordscale] > 0 then
            multiplicative_bonus = multiplicative_bonus * (1 + caster.runeword[event.runewordscale] / 100)
        end
    end

    
    local snowrangerbonus = caster:GetModifierStackCount("modifier_ranger_as_bonus", nil)
    if snowrangerbonus > 0 then
        multiplicative_bonus = multiplicative_bonus * (1 + 0.05 * snowrangerbonus)
    end
    local distance = (caster:GetAbsOrigin()-target:GetAbsOrigin()):Length()
    if event.rangeddoubledamage and event.rangeddoubledamage > 0 and distance > event.rangeddoubledamage then
        multiplicative_bonus = multiplicative_bonus * 2
        if process_procs then
            local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_abaddon/abaddon_death_coil_explosion_e.vpcf", PATTACH_POINT_FOLLOW, target)
            ParticleManager:ReleaseParticleIndex(particle)
        end
    end
    --[[
    if event.shadowstrikewl and caster:HasModifier("modifier_item_shadowstrike") then
        local b = 0
        if target:HasModifier("modifier_dot1") then
            b = b + 0.35
        end
        b = b + 0.35*target:GetModifierStackCount("modifier_dot2", nil)
        if target:HasModifier("modifier_dot4") then
            b = b + 0.35
        end
        value = value + b
    end
    if event.shadowstrikesp and caster:HasModifier("modifier_item_shadowstrike") then
        local b = 0
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
        value = value + b
    end
    ]]
    local bearroartalent = caster:FindAbilityByName("bear6")
    if bearroartalent and bearroartalent:GetLevel() >= 3 and caster:HasModifier("modifier_bear_roar_armor") then
        multiplicative_bonus = multiplicative_bonus * 1.5
    end
    local fury_as_abil = caster:FindAbilityByName("fury2")
    if fury_as_abil and fury_as_abil:GetLevel() >= 4 then
        multiplicative_bonus = multiplicative_bonus * (1 + 0.05 * caster:GetIncreasedAttackSpeed())
    end
    local dk_resi_dmg = caster:FindAbilityByName("Rot")
    if dk_resi_dmg and dk_resi_dmg:GetLevel() >= 4 then
        multiplicative_bonus = multiplicative_bonus * (1 + 1.5 * caster:GetMagicalArmorValue())
    end
    if caster:HasModifier("item_mother_of_dragons") then
        multiplicative_bonus = multiplicative_bonus * 1.15
    end

    local arcane_barrage_stacks = caster:GetModifierStackCount("modifier_arcane_barrage_bonus", nil)
    if event.isarcanebarrage and arcane_barrage_stacks > 0 then
        multiplicative_bonus = multiplicative_bonus * (1 + 0.05 * arcane_barrage_stacks)
    end
    
    if event.starfallbonus and caster:HasModifier("modifier_item_dmg4") then
        multiplicative_bonus = multiplicative_bonus * 2
    end
    
    --[[
    if event.warlockdrainbonus then
        local drainbonus = 0
        if target:HasModifier("modifier_dot1") then
            drainbonus = drainbonus + event.warlockdrainbonus
        end
        drainbonus = drainbonus + event.warlockdrainbonus*target:GetModifierStackCount("modifier_dot2", nil)
        if target:HasModifier("modifier_dot4") then
            drainbonus = drainbonus + event.warlockdrainbonus
        end
        value = value + drainbonus
    end
    ]]
    if caster:HasModifier("modifier_shadowstep1") then
        multiplicative_bonus = multiplicative_bonus * 1.3
    end
    
    local abil_dmg_stacks_5 = caster:GetModifierStackCount("modifier_abil_bonus_5_percent", nil)
    if abil_dmg_stacks_5 > 0 then
        multiplicative_bonus = multiplicative_bonus * (1 + 0.05 * abil_dmg_stacks_5)
    end
    if event.chaosstrike and caster:HasModifier("modifier_metamorph_dh") then
        multiplicative_bonus = multiplicative_bonus * 1.25
    end
    if event.championprot and caster:HasModifier("modifier_item_straxe2") then
        local shieldbashstack = caster:GetModifierStackCount("modifier_shieldbash", caster)
        multiplicative_bonus = multiplicative_bonus * (1 + 0.1 * shieldbashstack)
    end
    if caster:HasModifier("modifier_mythic_abil") then
        multiplicative_bonus = multiplicative_bonus * (1 + caster:GetModifierStackCount("modifier_mythic_abil", nil)/100)
    end
    if caster:HasModifier("modifier_mythic_aoe") and isaoe then
        multiplicative_bonus = multiplicative_bonus * (1 + caster:GetModifierStackCount("modifier_mythic_aoe", nil)/100)
    end
    if caster:HasModifier("modifier_mythic_dot") and event.isdot then
        multiplicative_bonus = multiplicative_bonus * (1 + caster:GetModifierStackCount("modifier_mythic_dot", nil)/100)
    end
    if caster:HasModifier("modifier_mythic_single") and not isaoe then
        multiplicative_bonus = multiplicative_bonus * (1 + caster:GetModifierStackCount("modifier_mythic_single", nil)/100)
    end

    --[[
    if caster:HasModifier("modifier_arcaneweak") and event.arcanedmg and event.netherblast then
        local stacks = caster:GetModifierStackCount("modifier_arcaneweak", nil)
        if caster:GetMana() >= 0.4*15*stacks then
            value = value + 0.3*stacks
            if process_procs then
                caster:SetMana(caster:GetMana() - 0.4*15*stacks)
            end
        end
    end
    ]]
    return multiplicative_bonus
end
--3333333

function LockReloadProc(event)
	local caster = event.caster
	event.max = 12
	event.buff = "modifier_lockreload"
	--event.ability = caster:FindAbilityByName("wind2")
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
    if target and target:IsNull() then
        return
    end
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
			BloodArcana(event2)
		else
			--magic fx
            if false and not COverthrowGameMode.crit_effect_cooldown then
                particle = ParticleManager:CreateParticle("particles/econ/items/antimage/antimage_weapon_basher_ti5/am_manaburn_basher_ti_5_b.vpcf", PATTACH_POINT_FOLLOW, target)
                ParticleManager:ReleaseParticleIndex(particle)
                particle = ParticleManager:CreateParticle("particles/units/heroes/hero_templar_assassin/templar_assassin_trap_explode_points.vpcf", PATTACH_POINT_FOLLOW, target)
                ParticleManager:ReleaseParticleIndex(particle)
                particle = ParticleManager:CreateParticle("particles/units/heroes/hero_invoker/invoker_emp_lightning_thick_child.vpcf", PATTACH_POINT_FOLLOW, target)
                local tar = target:GetAbsOrigin()
                ParticleManager:SetParticleControl(particle, 0, tar)
                tar = tar + Vector(0,0,200)
                ParticleManager:SetParticleControl(particle, 1, tar)
                ParticleManager:ReleaseParticleIndex(particle)
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
    local test9 = math.floor((amount%1000000000)/100000000)
    local test8 = math.floor((amount%100000000)/10000000)
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
    ParticleManager:ReleaseParticleIndex(particle)
	--2nd
    if test2 >= 1.0 or test7 >= 1.0 or test6 >= 1.0 or test5 >= 1.0 or test4 >= 1.0 or test3 >= 1.0 or test8 >= 1.0 or test9 >= 1.0 then
    	particle = ParticleManager:CreateParticle(particlepath, PATTACH_ABSORIGIN, target)
	    pos = pos+Vector(-16,0,0)
	    ParticleManager:SetParticleControl(particle, 0, pos)
		ParticleManager:SetParticleControl(particle, 1, Vector(0,test2,0))
        ParticleManager:ReleaseParticleIndex(particle)
	end
	if test3 >= 1.0 or test5 >= 1.0 or test4 >= 1.0 or test7 >= 1.0 or test6 >= 1.0 or test8 >= 1.0 or test9 >= 1.0 then
    	particle = ParticleManager:CreateParticle(particlepath, PATTACH_ABSORIGIN, target)
	    pos = pos+Vector(-16,0,0)
	    ParticleManager:SetParticleControl(particle, 0, pos)
		ParticleManager:SetParticleControl(particle, 1, Vector(0,test3,0))
        ParticleManager:ReleaseParticleIndex(particle)
	end
    if test4 >= 1.0 or test5 >= 1.0 or test7 >= 1.0 or test6 >= 1.0 or test8 >= 1.0 or test9 >= 1.0 then
        particle = ParticleManager:CreateParticle(particlepath, PATTACH_ABSORIGIN, target)
        pos = pos+Vector(-16,0,0)
        ParticleManager:SetParticleControl(particle, 0, pos)
        ParticleManager:SetParticleControl(particle, 1, Vector(0,test4,0))
        ParticleManager:ReleaseParticleIndex(particle)
    end
    if test5 >= 1.0 or test7 >= 1.0 or test6 >= 1.0 or test8 >= 1.0 or test9 >= 1.0 then
        particle = ParticleManager:CreateParticle(particlepath, PATTACH_ABSORIGIN, target)
        pos = pos+Vector(-16,0,0)
        ParticleManager:SetParticleControl(particle, 0, pos)
        ParticleManager:SetParticleControl(particle, 1, Vector(0,test5,0))
        ParticleManager:ReleaseParticleIndex(particle)
    end
    if test7 >= 1.0 or test6 >= 1.0 or test8 >= 1.0 or test9 >= 1.0 then
        particle = ParticleManager:CreateParticle(particlepath, PATTACH_ABSORIGIN, target)
        pos = pos+Vector(-16,0,0)
        ParticleManager:SetParticleControl(particle, 0, pos)
        ParticleManager:SetParticleControl(particle, 1, Vector(0,test6,0))
        ParticleManager:ReleaseParticleIndex(particle)
    end
    if test7 >= 1.0 or test8 >= 1.0 or test9 >= 1.0 then
        particle = ParticleManager:CreateParticle(particlepath, PATTACH_ABSORIGIN, target)
        pos = pos+Vector(-16,0,0)
        ParticleManager:SetParticleControl(particle, 0, pos)
        ParticleManager:SetParticleControl(particle, 1, Vector(0,test7,0))
        ParticleManager:ReleaseParticleIndex(particle)
    end
    if test8 >= 1.0 or test9 >= 1.0 then
        particle = ParticleManager:CreateParticle(particlepath, PATTACH_ABSORIGIN, target)
        pos = pos+Vector(-16,0,0)
        ParticleManager:SetParticleControl(particle, 0, pos)
        ParticleManager:SetParticleControl(particle, 1, Vector(0,test8,0))
        ParticleManager:ReleaseParticleIndex(particle)
    end
    if test9 >= 1.0 then
        particle = ParticleManager:CreateParticle(particlepath, PATTACH_ABSORIGIN, target)
        pos = pos+Vector(-16,0,0)
        ParticleManager:SetParticleControl(particle, 0, pos)
        ParticleManager:SetParticleControl(particle, 1, Vector(0,test9,0))
        ParticleManager:ReleaseParticleIndex(particle)
    end

	--blitz icon
	if crit == 1 then
		pos = pos+Vector(-20,0,0)
		particle = ParticleManager:CreateParticle(particlepath, PATTACH_ABSORIGIN, target)
		ParticleManager:SetParticleControl(particle, 0, pos)
		ParticleManager:SetParticleControl(particle, 1, Vector(0,14,0))
        ParticleManager:ReleaseParticleIndex(particle)
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

    local enemies = FindUnitsInRadius( caster2:GetTeamNumber(), pos, caster2, range, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, 0, 0, false )
    
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
            myevent.dur = 0.5
            ApplyBuff(myevent)
        end
        event.includeauto = event.includeauto / targets
        DamageAOE(event)
    end
end

function PathFeastForCrows( event )
    local caster = event.caster
    caster.nearby_enemies = CountNearbyEnemies(caster, 900)
end

function PathFeastForCrowsAOE( caster )
	Timers:CreateTimer(0.5,function()
		EmitSoundOn("DOTA_Item.Mjollnir.Activate", caster)
	    local enemies = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetAbsOrigin(), caster, 900, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	    if #enemies > 0 then
	        for _,enemy in pairs(enemies) do
	            if enemy and not enemy:IsNull() and (enemy:GetUnitLabel() == "hero" or enemy:GetUnitLabel() == "tower" ) and math.random(1,100) <= 50 then
	            	PathFeastForCrowsShadowStorm( caster, enemy )
	            end
	        end
	    end
	end)
end

function PathFeastForCrowsShadowStorm( caster, target )
	local particle = ParticleManager:CreateParticle("particles/econ/items/riki/riki_immortal_ti6/riki_immortal_ti6_blinkstrike.vpcf", PATTACH_ABSORIGIN, caster)
	ParticleManager:SetParticleControl(particle, 0, caster:GetAbsOrigin() + Vector(0,0,50))
	ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin() + Vector(0,0,50))
	ParticleManager:SetParticleControl(particle, 2, target:GetAbsOrigin() + Vector(0,0,50))
	ParticleManager:SetParticleControl(particle, 3, target:GetAbsOrigin() + Vector(0,0,50))
    ParticleManager:ReleaseParticleIndex(particle)
	local event = {}
	event.caster = caster
	event.target = target
	event.includeauto = caster.talents[85] * 250
	event.spelldamagefactor = caster.talents[85] * 250
	event.shadowdmg = 1
	event.puredmg = 1
	event.ability = caster.passive_ability
	event.ignore_when_target_has_reflect = true
	DamageUnit(event)
end

function AstralShock( caster )
	Timers:CreateTimer(0.25,function()
		EmitSoundOn("DOTA_Item.Mjollnir.Activate", caster)
	    local enemies = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetAbsOrigin(), caster, 900, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	    if #enemies > 0 then
	        for _,enemy in pairs(enemies) do
	            if enemy and not enemy:IsNull() and (enemy:GetUnitLabel() == "hero" or enemy:GetUnitLabel() == "tower" ) then
	            	AstralShockProc( caster, enemy )
	            end
	        end
	    end
	end)
end

function AstralShockProc( caster, target )
	local particle = ParticleManager:CreateParticle("particles/econ/items/riki/riki_immortal_ti6/riki_immortal_ti6_blinkstrike.vpcf", PATTACH_ABSORIGIN, caster)
	ParticleManager:SetParticleControl(particle, 0, caster:GetAbsOrigin() + Vector(0,0,50))
	ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin() + Vector(0,0,50))
	ParticleManager:SetParticleControl(particle, 2, target:GetAbsOrigin() + Vector(0,0,50))
	ParticleManager:SetParticleControl(particle, 3, target:GetAbsOrigin() + Vector(0,0,50))
    ParticleManager:ReleaseParticleIndex(particle)
	local event = {}
	event.caster = caster
	event.target = target
	event.attributefactor = 0
	event.spelldamagefactor = 1000
	event.arcanedmg = 1
	event.ability = caster.passive_ability
	event.ignore_when_target_has_reflect = true
	DamageUnit(event)
end

function CountNearbyEnemies(caster, range)
    local enemies = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetAbsOrigin(), caster, range, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
    local targets_hit = 0
    if #enemies > 0 then
        for _,enemy in pairs(enemies) do
            if enemy and not enemy:IsNull() and (enemy:GetUnitLabel() == "hero" or enemy:GetUnitLabel() == "tower" )  then
                targets_hit = targets_hit + 1
            end
        end
    end
    return targets_hit
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
    if not caster2 then
        return
    end
    if caster2 and caster2:IsNull() then
        return
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
    local targets_hit = 0
    local max_targets = 1000
    if event.max_targets then
        max_targets = event.max_targets
    end

	local event2 = {
		caster = caster2,
		target = target2,
		ability = ability2,
		damage = event.damage,
		spelldamagefactor = event.spelldamagefactor,
		attributefactor = event.attributefactor,
        attributechangestr = event.attributechangestr,
        counterblow = event.counterblow,
		pvescale = event.pvescale,
		critdmgbonusfactor = event.critdmgbonusfactor,
		critchancefactor = event.critchancefactor,
		includeauto = event.includeauto,
        includefullauto = event.includefullauto,
		critmanareg = event.critmanareg,
		championcleaver = event.championcleaver,
        difficultyscale = event.difficultyscale,
        difficultyscalelinear = event.difficultyscalelinear,
        t3bonus = event.t3bonus,
        isdot = event.isdot,
        isaoe = event.isaoe,
        changedmgtypetophys = event.changedmgtypetophys,
        classitemdmgfactor = event.classitemdmgfactor,
        classitemdmgfactorbuff = event.classitemdmgfactorbuff

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

    if event.oncritcdreduce3rd then
        event2.oncritcdreduce3rd = event.oncritcdreduce3rd
    end
    if event.oncritcdreduce4th then
        event2.oncritcdreduce4th = event.oncritcdreduce4th
    end

	local agha = caster2:HasModifier("modifier_item_straxe2") or caster2:HasModifier("modifier_item_straxe3")

	if event.arrowsound then
		EmitSoundOn("Hero_LegionCommander.Overwhelming.Hero", caster2)
		local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_legion_commander/legion_commander_odds_hero_arrow_group.vpcf", PATTACH_ABSORIGIN, caster2)
		ParticleManager:SetParticleControl(particle, 0, pos+Vector(-125,0,0))
		ParticleManager:SetParticleControl(particle, 1, pos)
        ParticleManager:ReleaseParticleIndex(particle)
		particle = ParticleManager:CreateParticle("particles/units/heroes/hero_legion_commander/legion_commander_odds_hero_arrow_group.vpcf", PATTACH_ABSORIGIN, caster2)
		ParticleManager:SetParticleControl(particle, 0, pos+Vector(125,0,0))
		ParticleManager:SetParticleControl(particle, 1, pos)
        ParticleManager:ReleaseParticleIndex(particle)
		particle = ParticleManager:CreateParticle("particles/units/heroes/hero_legion_commander/legion_commander_odds_hero_arrow_group.vpcf", PATTACH_ABSORIGIN, caster2)
		ParticleManager:SetParticleControl(particle, 0, pos+Vector(0,125,0))
		ParticleManager:SetParticleControl(particle, 1, pos)
        ParticleManager:ReleaseParticleIndex(particle)
		particle = ParticleManager:CreateParticle("particles/units/heroes/hero_legion_commander/legion_commander_odds_hero_arrow_group.vpcf", PATTACH_ABSORIGIN, caster2)
		ParticleManager:SetParticleControl(particle, 0, pos+Vector(0,-125,0))
		ParticleManager:SetParticleControl(particle, 1, pos)
        ParticleManager:ReleaseParticleIndex(particle)
	end

	local enemies
	local pet = "pet"
	if event.onlyhero then
		--enemies = FindUnitsInRadius( caster2:GetTeamNumber(), pos, caster2, range, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, 0, 0, false )
		pet = "hero"
	end
	enemies = FindUnitsInRadius( caster2:GetTeamNumber(), pos, caster2, range, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )

	local crusaderheal = 0
    --count targets
    if #enemies > 0 then
        for _,enemy in pairs(enemies) do
            if enemy and not enemy:IsNull() and (enemy:GetUnitLabel() == "hero" or enemy:GetUnitLabel() == pet or enemy:GetUnitLabel() == "tower" )  then
                if targets_hit < max_targets and ((not CheckForBreakableCC(enemy)) or event.breakcc) then
                    targets_hit = targets_hit + 1
                end
            end
        end
    end
    if event.damage_divided and targets_hit > 0 then
        event2.damage_scale = 1 / targets_hit
    end
    targets_hit = 0
    if event.damage_factor_single_target and #enemies == 1 then
        event2.damage_factor_single_target = event.damage_factor_single_target
    end
	if #enemies > 0 then
		for _,enemy in pairs(enemies) do
			if enemy and not enemy:IsNull() and (enemy:GetUnitLabel() == "hero" or enemy:GetUnitLabel() == pet or enemy:GetUnitLabel() == "tower" )  then
				if targets_hit < max_targets and ((not CheckForBreakableCC(enemy)) or event.breakcc) then
					event2.target = enemy
					DamageUnit( event2 )
                    targets_hit = targets_hit + 1
                    if event.targeteffect then
    					if event.targeteffect == "blood" then
    						local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_beastmaster/beastmaster_wildaxes_hit.vpcf", PATTACH_ABSORIGIN_FOLLOW, enemy)
                            ParticleManager:ReleaseParticleIndex(particle)
    					end
                        if event.targeteffect == "arcanablood" then
                            local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_beastmaster/beastmaster_wildaxes_hit.vpcf", PATTACH_ABSORIGIN_FOLLOW, enemy)
                            ParticleManager:ReleaseParticleIndex(particle)
                            local particle = ParticleManager:CreateParticle("particles/econ/items/troll_warlord/troll_warlord_ti7_axe/troll_ti7_axe_bash_explosion.vpcf", PATTACH_POINT_FOLLOW, enemy)
                            ParticleManager:SetParticleControl(particle, 3, caster2:GetAbsOrigin())
                            ParticleManager:ReleaseParticleIndex(particle)
                            BloodArcana({caster = caster2, target = enemy, ignore_crit_effect_cooldown = true })
                        end
    					if event.targeteffect == "thunder" then
    						local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_disruptor/disruptor_thunder_strike_aoe.vpcf", PATTACH_ABSORIGIN_FOLLOW, enemy)
                            ParticleManager:ReleaseParticleIndex(particle)
    					end
    					if event.targeteffect == "fire" then
    						local particle = ParticleManager:CreateParticle("particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_shadowraze_lava.vpcf", PATTACH_ABSORIGIN_FOLLOW, enemy)
    						ParticleManager:SetParticleControl(particle, 0, enemy:GetAbsOrigin()+Vector(0,0,15))
                            ParticleManager:ReleaseParticleIndex(particle)
    					end
    					if event.targeteffect == "water" then
    						local particle = ParticleManager:CreateParticle("particles/econ/items/kunkka/divine_anchor/hero_kunkka_dafx_skills/kunkka_spell_x_spot_return_fxset.vpcf", PATTACH_ABSORIGIN_FOLLOW, enemy)
                            ParticleManager:ReleaseParticleIndex(particle)
    					end
    					if event.targeteffect == "holy" then
    						local particle = ParticleManager:CreateParticle("particles/econ/items/legion/legion_weapon_voth_domosh/legion_commander_duel_dmg_flare.vpcf", PATTACH_ABSORIGIN_FOLLOW, enemy)
    						ParticleManager:SetParticleControl(particle, 3, enemy:GetAbsOrigin()+Vector(0,0,0))
                            ParticleManager:ReleaseParticleIndex(particle)
    					end
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
                        ParticleManager:ReleaseParticleIndex(particle)
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
            ParticleManager:ReleaseParticleIndex(particle)
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
                myevent.is_already_aoe_buff = true
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

function ChannelProcs( caster )
    if caster:HasModifier("modifier_item_channel") or caster:HasModifier("modifier_item_channel_2") then
        if not caster.channel_item_bonus then
            caster.channel_item_bonus = 1
        else
            caster.channel_item_bonus = caster.channel_item_bonus + 1
        end
        if caster.channel_item_bonus == 1 then
            local particle = ParticleManager:CreateParticle("particles/econ/items/spectre/spectre_transversant_soul/spectre_transversant_spectral_dagger_path_owner_energy.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
            caster.channel_item_bonus_fx = particle
        end
        Timers:CreateTimer(12,function()
            caster.channel_item_bonus = caster.channel_item_bonus - 1
            if caster.channel_item_bonus == 0 then
                caster.channel_item_bonus = nil
                ParticleManager:DestroyParticle(caster.channel_item_bonus_fx,true)
                ParticleManager:ReleaseParticleIndex(caster.channel_item_bonus_fx)
            end
        end)
    end
end

function CheckForBreakableCC( target )
	if target:HasModifier("modifier_sap") or target:HasModifier("modifier_sap2") or target:HasModifier("modifier_confused") or target:HasModifier("modifier_voodoo_datadriven") or target:HasModifier("glacier_trap") or target:HasModifier("modifier_bane_nightmare") then
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

			local particle = ParticleManager:CreateParticle("particles/radiant_fx/tower_good3_dest_lvl2_hit.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
            ParticleManager:ReleaseParticleIndex(particle)
		end
		if event.csfx ~= nil then
			event.ability:ApplyDataDrivenModifier(event.caster, target, "modifier_csfx", nil)
		end
		local particle = ParticleManager:CreateParticleForPlayer("particles/units/heroes/hero_zeus/zues_screen_empty.vpcf", PATTACH_POINT_FOLLOW, target, target:GetOwner())
        ParticleManager:ReleaseParticleIndex(particle)
		particle = ParticleManager:CreateParticleForPlayer("particles/econ/events/killbanners/screen_killbanner_compendium14_rampage_burst.vpcf", PATTACH_POINT_FOLLOW, caster, caster:GetOwner())
        ParticleManager:ReleaseParticleIndex(particle)
		
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
        local particle = ParticleManager:CreateParticle("particles/generic_gameplay/generic_purge.vpcf", PATTACH_ABSORIGIN_FOLLOW, event.target)
        ParticleManager:ReleaseParticleIndex(particle)
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
    local isaoe = false
    local ability = event.ability
    if event.isaoeheal and event.isaoeheal >= 1 then
        isaoe = true
    end
    local displaynumber = true

    if event.heal_owner and caster then
        --caster = caster.owner
        target = caster
    end
    if event.heal_summoner and caster and caster.owner then
        caster = caster.owner
        target = caster.owner
    end
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
    if caster.has_used_ravencraft_abilitypoint_item and not caster:HasModifier("modifier_pathbuff_088") then
        return
    end
    --if target:GetUnitLabel() == "tower" then
    --	return
    --end
    if target:HasModifier("modifier_cyclone_self") and not event.healthroughcyclone then
  		return
    end
    if event.only_heal_on_caster_buff_condition and not caster:HasModifier(event.only_heal_on_caster_buff_condition) then
        return
    end
    if event.demoncondition and not caster:HasModifier("modifier_item_demonglaive") then
        return
    end
    if event.health_threshold and target:GetHealth() / target:GetMaxHealth() >= event.health_threshold then
        return
    end
    if event.only_heal_when_low then
        if target:GetHealth() / target:GetMaxHealth() >= event.only_heal_when_low then
            return
        else
            if event.only_heal_when_low_with_cost then
                if caster:GetMana() >= event.only_heal_when_low_with_cost then
                    caster:SetMana(caster:GetMana() - event.only_heal_when_low_with_cost)
                else
                    return
                end
            end
            local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_nyx_assassin/nyx_assassin_vendetta_blood.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
            ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())
            ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin())
            ParticleManager:SetParticleControl(particle, 2, target:GetAbsOrigin())
            ParticleManager:ReleaseParticleIndex(particle)
        end
    end
    if caster and caster.spelldamage == nil then
    	caster.spelldamage = 0.0
    end
    if event.heal == nil then
    	event.heal = 0.0
    end

    if event.spelldamagefactor == nil then
    	event.spelldamagefactor = 0.0
    end

    if event.percenthp then
    	event.heal = event.heal + event.percenthp*target:GetMaxHealth()/100.0
    end
    -- Spelldamage
    local spelldamagefromitem = 0
    -- add spelldamage
    if event.spelldamagefactor > 0.0 and event.FromGuardian ~= 1 then
    	spelldamagefromitem = GetSpellpower(event)
    	event.heal = event.heal + event.spelldamagefactor*(caster.spelldamage+spelldamagefromitem)/100.0
    end
    -- healing from stats
    --also add bonus factor
    local statbonus = 1.0
    if event.attributefactor ~= nil then
    	-- normal heroes
    	if event.attributechangeint ~= nil then
    		event.heal = event.heal + GetIntellectCustom(caster)*event.attributefactor*statbonus/100.0
    	elseif event.attributechangestr ~= nil then
    		event.heal = event.heal + GetStrengthCustom(caster)*event.attributefactor*statbonus/100.0
    	elseif event.attributechangeagi ~= nil then
    		event.heal = event.heal + caster:GetAgility()*event.attributefactor*statbonus/100.0
    	elseif event.attributechangeall ~= nil then
    		event.heal = event.heal + caster:GetAgility()*event.attributefactor*statbonus/100.0 + GetStrengthCustom(caster)*event.attributefactor*statbonus/100.0 + GetIntellectCustom(caster)*event.attributefactor*statbonus/100.0
    	else
    		if caster:IsHero() then
    			event.heal = event.heal + GetPrimaryStatValueCustom(caster)*event.attributefactor*statbonus/100.0
    		end
    	end
	end

    local base_healing = event.heal
	-- lifebloom increases per stack
	if event.lifebloom ~= nil then
		local stackcount = target:GetModifierStackCount("modifier_lifebloom", caster)
		if target:HasModifier("modifier_lifebloomfull") then
			stackcount = target:GetModifierStackCount("modifier_lifebloomfull", caster)
		end
	    event.heal = event.heal * stackcount
	    --print("stack count considered" .. caster:GetPrimaryStatValue()*event.attributefactor)
	end

    --bonus calcs
    local healing_bonus = 1
    if caster and caster:IsRealHero() then
        if not caster.temple_class then
            healing_bonus = healing_bonus + 0.001 * caster:GetLevel()
        else
            healing_bonus = healing_bonus + 0.0005 * caster:GetLevel()
        end
    end

    if caster.talents then
        if caster.talents[8] and not event.no_bonus_talent then
            local ancient = 1
            if caster:HasModifier("modifier_item_silverblood4") then
                ancient = 2
            end
            event.heal = event.heal + caster:GetHealth() * 0.005 * caster.talents[8] * ancient
        end
        if event.isdot and caster.talents[49] and caster.talents[49] > 0 then
            healing_bonus = healing_bonus + 0.2 * caster.talents[49]
        end
        if caster.talents[7] and caster.talents[7] > 0 then
            local buff = "modifier_talent_maul"
            local dot_dur = 3
            if caster:HasModifier("modifier_item_ancient_grizzly") then
                dot_dur = dot_dur * 2
            end
            local myevent = { caster = caster, target = caster, dur = dot_dur, buff = buff, ability = caster.combat_system_ability, addstacks = 1, max = caster.talents[7] * 33}
            ApplyBuffStack(myevent)
            local talent7_buff = caster:GetModifierStackCount("modifier_talent_maul", nil)
            healing_bonus = healing_bonus + 0.005 * talent7_buff
        end
        if caster.talents[16] and caster.talents[16] > 0 then
            healing_bonus = healing_bonus + 0.05 * caster.talents[16]
        end
        if caster.talents[67] and caster.talents[67] > 0 and isaoe then
            healing_bonus = healing_bonus + 0.07 * caster.talents[67]
        end
        if caster.talents[39] and caster.talents[39] > 0 and ability and ability:GetAbilityIndex() == 0 then
            healing_bonus = healing_bonus + 0.1 * caster.talents[39]
        end
    end

    --healprocs
    if event.bloodwolf then
        ChannelProcs(caster)
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
    local artifact_crit_dmg = caster:GetModifierStackCount("modifier_mythic_critdmg", nil)
    if artifact_crit_dmg > 0 then
        critdmgbonusfactor = critdmgbonusfactor + 0.01 * artifact_crit_dmg
    end
    if caster:HasModifier("modifier_crit_aura_dragon") then
        critdmgbonusfactor = critdmgbonusfactor + 0.2
    end
    if caster:HasModifier("modifier_element_chaos") then
        critdmgbonusfactor = critdmgbonusfactor + 0.3
    end
    if caster:HasModifier("modifier_path_shadowform") then
        critdmgbonusfactor = critdmgbonusfactor + 0.25 * caster.talents[73]
    end
    --if caster.runeword and caster.runeword[12] then
    --    critdmgbonusfactor = critdmgbonusfactor + caster.runeword[12] / 100
    --end
    if critpossible == true and event.caster:HasModifier("modifier_item_crit_myth") then
        critchance = 15*critchancefactor
        if caster:HasModifier("modifier_crit_myth") then
            critchance = critchance * 2
        end
        if math.random(1,100) <= critchance then
            event.heal = event.heal*6*critdmgbonusfactor
            displaynumber = 1
            critpossible = false
        end
    end
    if critpossible == true and event.caster:HasModifier("modifier_item_crit_pure_immortal2") then
        critchance = 10*critchancefactor
        if math.random(1,100) <= critchance then
            event.heal = event.heal*6*critdmgbonusfactor
            displaynumber = 1
            critpossible = false
        end
    end
    if critpossible == true and event.caster:HasModifier("modifier_mythic_abilcrit") then
        critchance = critchancefactor * caster:GetModifierStackCount("modifier_mythic_abilcrit", nil)
        if math.random(1,100) <= critchance then
            event.heal = event.heal*5*critdmgbonusfactor
            displaynumber = 1
            critpossible = false
        end
    end
    if critpossible == true and event.caster:HasModifier("modifier_item_crit_pure_immortal3") then
        critchance = 15*critchancefactor
        if caster:HasModifier("modifier_item_crit_pure_5_lifesteal_no_ls") then
            critchance = critchance * 2
        end
        if math.random(1,100) <= critchance then
            event.heal = event.heal*5*critdmgbonusfactor
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
    if critpossible == true and event.caster:HasModifier("modifier_crit_aura_dragon_2") then
        critchance = 3*critchancefactor
        if math.random(1,100) <= critchance then
            event.heal = event.heal*5.0*critdmgbonusfactor
            displaynumber = 1
            critpossible = false
        end
    end
    if critpossible == true and event.caster:HasModifier("modifier_item_ancient_wolf") then
        critchance = 10*critchancefactor
        if math.random(1,100) <= critchance then
            event.heal = event.heal*2.25*critdmgbonusfactor
            displaynumber = 1
            critpossible = false
        end
    end
    if critpossible == true and event.caster:HasModifier("modifier_item_crit_pure_immortal_2") then
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
        if event.caster:HasModifier("modifier_bow_crit_legendary") then
            critchance = 100
        end
        if math.random(1,100) <= critchance then
            event.heal = event.heal*3.5*critdmgbonusfactor
            displaynumber = 1
            critpossible = false
        end
    end
    --if critpossible == true and caster.runeword and caster.runeword[20] and caster.runeword[20] > 0 then
    --    critchance = caster.runeword[20]
    --    if math.random(1,100) <= critchance then
    --        event.heal = event.heal*3*critdmgbonusfactor
    --        displaynumber = 1
    --        critpossible = false
    --    end
    --end
    if critpossible == true and event.caster:HasModifier("modifier_item_endgame10") then
        critchance = 5*critchancefactor
        if math.random(1,100) <= critchance then
            event.heal = event.heal*3*critdmgbonusfactor
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
    if critpossible == true and event.caster:HasModifier("modifier_item_bootscrit4") then
        critchance = 10*critchancefactor
        if math.random(1,100) <= critchance then
            event.heal = event.heal*2.5*critdmgbonusfactor
            displaynumber = 1
            critpossible = false
        end
    end
    if critpossible == true and event.caster:HasModifier("modifier_item_bootscrit3") then
        critchance = 10*critchancefactor
        if math.random(1,100) <= critchance then
            event.heal = event.heal*2.25*critdmgbonusfactor
            displaynumber = 1
            critpossible = false
        end
    end
    if critpossible == true and event.caster:HasModifier("modifier_item_bootscrit2") then
        critchance = 10*critchancefactor
        if math.random(1,100) <= critchance then
            event.heal = event.heal*2.0*critdmgbonusfactor
            displaynumber = 1
            critpossible = false
        end
    end
    if critpossible == true and caster.talents and caster.talents[45] and caster.talents[45] > 0 and (ability:GetAbilityIndex() == 0 or ability:GetAbilityIndex() == 1) then
        local alphablood_divine = caster:HasModifier("modifier_pathbuff_045")
        local alphablood_chance = 3
        if ability:GetAbilityIndex() == 1 then
            alphablood_chance = 2
            if alphablood_divine then
                alphablood_chance = 4
            end
        end
        critchance = alphablood_chance*caster.talents[45]
        if math.random(1,100) <= critchance then
            event.heal = event.heal*5*critdmgbonusfactor
            displaynumber = 1
            critpossible = false
            PathAlphaBloodProc( caster, ability )
        end
    end
    if critpossible == true and event.caster:HasModifier("modifier_item_endgame9") then
        critchance = 10*critchancefactor
        if math.random(1,100) <= critchance then
            event.heal = event.heal*2.0*critdmgbonusfactor
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
    	critchance = 8 * critchancefactor
    	if math.random(1,100) <= critchance then
	    	event.heal = event.heal*2.5*critdmgbonusfactor
    		displaynumber = 1
	    	critpossible = false
	    end
    end
    if critpossible == true and event.caster:HasModifier("modifier_element_shadow") then
        critchance = 5*critchancefactor
        if math.random(1,100) <= critchance then
            event.heal = event.heal*2*critdmgbonusfactor
            displaynumber = 1
            critpossible = false
        end
    end
    if critpossible == true and caster.talents and caster.talents[37] and caster.talents[37] > 0 then
        critchance = 3*caster.talents[37]
        if math.random(1,100) <= critchance then
            event.heal = event.heal*2*critdmgbonusfactor
            displaynumber = 1
            critpossible = false
        end
    end
    if critpossible == true and event.caster:HasModifier("modifier_item_bootscrit") then
    	critchance = 11*critchancefactor
    	if math.random(1,100) <= critchance then
	    	event.heal = event.heal*1.5*critdmgbonusfactor
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
    	critchance = 12*critchancefactor
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
    local holy_priest_crit = caster:FindAbilityByName("holy_priest_crit")
    if critpossible == true and holy_priest_crit and holy_priest_crit:GetLevel() >= 3 then
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
    --changed to multiplicative 5.0 patch
    if caster.talents then
        if was_crit and caster.talents[17] then
            healing_bonus = healing_bonus + 0.05 * caster.talents[17]
        end
        if event.bloodwolf and caster.talents[32] then
            healing_bonus = healing_bonus + 0.4 * caster.talents[32]
        end
        if caster.standsstill and caster.talents[20] and caster.talents[20] > 0 then
            local standsstill = caster.standsstill
            if standsstill > 5 then
                standsstill = 5
            end
            healing_bonus = healing_bonus + 0.02 * caster.talents[20] * standsstill
        end
        if caster.talents[66] and caster.talents[66] > 0 and ability == caster:GetAbilityByIndex(1) then
            healing_bonus = healing_bonus + 0.15 * caster.talents[66]
        end
        if caster.talents[68] and caster.talents[68] > 0 then
            if caster.path_dark_ritual and caster.path_dark_ritual > 0 then
                healing_bonus = healing_bonus + 0.05 * caster.talents[68]
            end
            if ability:GetAbilityIndex() == 5 then
                healing_bonus = healing_bonus + 0.1 * caster.talents[68]
            end
        end
    end
    --multi healing
    if event.bloodwolf and caster:HasModifier("modifier_item_shadowstrike") then
        healing_bonus = healing_bonus + 0.5
    end
    if caster:HasModifier("modifier_activepaladin") then
        healing_bonus = healing_bonus + 0.25
    end
    if caster:HasModifier("modifier_item_int_set_t3_active") then
        healing_bonus = healing_bonus + 0.3
    end
    if caster.channel_item_bonus then
        healing_bonus = healing_bonus + 0.25
    end
    if caster.ability_combo_6_bonus then
        healing_bonus = healing_bonus + 2
    end
    if caster:HasModifier("modifier_element_chaos") and isaoe then
        healing_bonus = healing_bonus + 0.3
    end
    
    --need rework
    
    if target:HasModifier("modifier_warlockrage") then
        healing_bonus = healing_bonus + 0.06
    end

    local kingcharge = caster:GetModifierStackCount("modifier_elemental_kings", caster)*0.03
    if kingcharge > 0 then
    	healing_bonus = healing_bonus + kingcharge
    end

    local heavencharge = caster:GetModifierStackCount("modifier_heaven_charge", caster)
    if event.heavencharge and heavencharge > 0 then
    	healing_bonus = healing_bonus + heavencharge
    	caster:RemoveModifierByName("modifier_heaven_charge")
    end

    if caster:HasModifier("modifier_shapeshifttravel") and caster:GetAbilityByIndex(5):GetLevel() >= 4 then
	    healing_bonus = healing_bonus + 0.6
    end
    
    local healreceived = 1
    if caster:HasModifier("modifier_special_bonus_lifesteal") then
        healreceived = healreceived + 0.1
    end
    if caster:HasModifier("modifier_invul") then
        healreceived = healreceived + 0.25
    end
    if target:HasModifier("modifier_special_bonus_lifesteal") then
        healreceived = healreceived + 0.1
    end
    if target:HasModifier("modifier_deathwish") then
        healreceived = healreceived + 0.25
    end
    if target:HasModifier("modifier_item_lifesteal_10") then
        healreceived = healreceived + 0.1
    end
    if target:HasModifier("modifier_item_crit_pure_2") then
        healreceived = healreceived + 0.05
    end
    if target:HasModifier("modifier_item_crit_pure_3") then
        healreceived = healreceived + 0.1
    end
    if target:HasModifier("modifier_item_crit_pure_4") then
        healreceived = healreceived + 0.1
    end
    if target:HasModifier("modifier_item_set_str_tank_full_t1") then
        healreceived = healreceived + 0.1
    end
    if target:HasModifier("modifier_item_set_str_tank_full_t1_dream") then
        healreceived = healreceived + 0.15
    end
    if caster:HasModifier("modifier_item_straxe3") and event.commandershout then
        healreceived = healreceived + 1
    end
    if target:HasModifier("modifier_lifesteal_double") then
        healreceived = healreceived + 0.1
    end
    if target:HasModifier("modifier_deathknight") then
        healreceived = healreceived + 0.25
    end
    if caster:HasModifier("modifier_element_holy") then
        healreceived = healreceived + 0.2
    end
    if caster:HasModifier("modifier_mythic_heal") then
        healing_bonus = healing_bonus + caster:GetModifierStackCount("modifier_mythic_heal", nil)/100
    end
    local priest_heal_talent = caster:FindAbilityByName("holy6")
    if priest_heal_talent and priest_heal_talent:GetLevel() >= 3 then
	    healing_bonus = healing_bonus + 0.08
    end
    if caster:GetName() == "npc_dota_hero_dazzle" and caster:GetAbilityByIndex(5):GetLevel() >= 4 then
        healing_bonus = healing_bonus + 0.25
    end

    if caster:HasModifier("item_mother_of_dragons") then
        healing_bonus = healing_bonus + 0.15
    end

    if event.innercdbonus and event.innercdbonus > 0 and not caster:HasModifier("modifier_inner_cd_bonus") then
	    healing_bonus = healing_bonus + event.innercdbonus/100 - 1
	    event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_inner_cd_bonus", nil)
    end

    if target:HasModifier("modifier_master_elements") then
	    healing_bonus = healing_bonus + 0.5
    end

    if target:HasModifier("modifier_voidhp") then
        healing_bonus = healing_bonus + 0.05
    end

    if caster:HasModifier("modifier_crusader_mount") then
        healing_bonus = healing_bonus + 0.25
    end

    if event.druidlowbonus and event.druidlowbonus > 0 and target:GetHealth()/target:GetMaxHealth() < 0.5 then
    	healing_bonus = healing_bonus + event.druidlowbonus/100
    end

    if event.critmanareg and critpossible == false then
    	caster:SetMana(caster:GetMana()+(caster:GetMaxMana()*event.critmanareg/100.0))
    	local particle = ParticleManager:CreateParticle("particles/items3_fx/mango_active.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
        ParticleManager:ReleaseParticleIndex(particle)
    end

    local talentshamancritheal = caster:FindAbilityByName("resto6")
    if critpossible == false and not event.crithealnoproc and not event.cannotcrit and talentshamancritheal and talentshamancritheal:GetLevel() >= 3 then
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
    	event.heal = event.heal / 2
    end
    if target.talents then
        if target.talents[72] and target.talents[72] > 0 then
            event.heal = event.heal / 2
        end
        if caster.talents and caster.talents[74] and caster.talents[74] > 0 and caster.path_sacrifice_souls_paid then
            event.heal = event.heal  * (1 + 0.1 * caster.talents[74])
        end
    end
    local fury_heal_stacks = target:GetModifierStackCount("modifier_bleedingpve", nil)
    if fury_heal_stacks and fury_heal_stacks > 0 then
        event.heal=event.heal / fury_heal_stacks
    end
    if target:HasModifier("modifier_healdebuff90") and event.retridmgtoheal == nil and not target:HasModifier("modifier_omni_allow_heal") then
        event.heal = event.heal * 0.1
    end
    if target:HasModifier("modifier_heal_curse") and event.retridmgtoheal == nil then
        event.heal = event.heal * 0.5
    end
    if target:HasModifier("modifier_healdebuff75") and event.retridmgtoheal == nil then
        event.heal = event.heal *0.25
    end
    if target:HasModifier("modifier_healdebuff50") and event.retridmgtoheal == nil then
        event.heal = event.heal *0.5
    end
    if target:HasModifier("modifier_healdebuff25") and event.retridmgtoheal == nil then
        event.heal = event.heal *0.75
    end
    if target:HasModifier("modifier_unholyheal") and event.retridmgtoheal == nil then
    	event.heal = 0
    end
    if target:HasModifier("modifier_item_shieldluna") then
    	healing_bonus=healing_bonus + 0.05
    end
    if caster:HasModifier("modifier_item_eternallife") then
    	healing_bonus=healing_bonus + 0.15
    end
    if target:HasModifier("modifier_earth_shield") and event.eshieldbonus then
    	healing_bonus=healing_bonus + event.eshieldbonus - 1
    end
    if target:HasModifier("modifier_eternallife") then
    	healing_bonus = healing_bonus + 1
    end
    if caster:HasModifier("modifier_active9") then
        healing_bonus = healing_bonus + 0.3
    end
    if target:HasModifier("modifier_fanatism_2") and target:HasModifier("modifier_class_sanctified") then
        healing_bonus = healing_bonus + 2
    end

    -- guardian bonus heal on same target
    if caster:HasModifier("modifier_guardian_self") and target:HasModifier("modifier_guardian") and event.FromGuardian ~= 1 then
    	healing_bonus=healing_bonus + 0.25
    end

    local protpalatalent = target:FindAbilityByName("pala6")
    if protpalatalent and protpalatalent:GetLevel() >= 3 then
        healing_bonus=healing_bonus + 0.25
    end

    -- sp heal bonus same target
    if event.alwaysself ~= nil then
    	if caster == target then
    		healing_bonus = healing_bonus + event.alwaysself
    	end
    end

    if event.healfactor then
    	event.heal = event.heal * event.healfactor / 100
    end

    if caster.talents and caster.talents[72] and caster.talents[72] > 0 then
        event.heal = event.heal * (1 + 0.07 * caster.talents[72])
    end

    --talent
    if caster.talents and caster.talents[3] then
        healing_bonus = healing_bonus + 0.03*caster.talents[3]
    end
    if target.talents and target.talents[3] then
        healing_bonus = healing_bonus + 0.03*target.talents[3]
    end
    --if caster.runeword and caster.runeword[13] then
    --    healing_bonus = healing_bonus + 0.01*caster.runeword[13]
    --end
    --if target.runeword and target.runeword[13] then
    --    healing_bonus = healing_bonus + 0.01*target.runeword[13]
    --end
    --local aoe_bonus = 1
    --if isaoe then
    --    aoe_bonus = GetAbilityAOEDamageModifierAdditive(event, caster, real_caster, target, ability, behindtarget, true)
    --    event.heal = event.heal * aoe_bonus
    --end

    -------------------------------------------------------------------------------------------------------------
    --final heal value
    if event.not_affected_by_heal_bonuses then
        event.heal = base_healing
    end
    if caster:IsRealHero() then
        caster.heal_bonus = healing_bonus
    end
    event.heal = event.heal * healreceived * healing_bonus

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
    --heal capped?
    if event.cap_healing_at_max_health then
        local max_heal = target:GetMaxHealth() * event.cap_healing_at_max_health / 100
        if event.heal > max_heal then
            event.heal = max_heal
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

    if event.heal > 0 then
        if caster:IsRealHero() then
            caster.healing_done = caster.healing_done + event.heal
        end
    	target:Heal(event.heal, caster)
        --aggro from heal in 900 area
        if caster ~= target then
            local aggro_caused = event.heal-overhealing
            if COverthrowGameMode.jungledifficulty <= 1 then
                aggro_caused = aggro_caused / 3
            end
            COverthrowGameMode:PVEAggroAddAOE(caster, target, aggro_caused, 625)
        end
        --talents
        --[[
        if caster.talents and caster.talents[50] then
            if caster.talents[50] > 0 and math.random(1,100) <= 1 then
                local myevent = {}
                myevent.caster = caster
                myevent.target = caster
                myevent.buff = "modifier_talent_onheal_armor"
                myevent.ability = caster.combat_system_ability
                myevent.dur = 3 + 3 * caster.talents[50]
                ApplyBuff(myevent)
                caster.creepertarget = target
                myevent.target = target
                myevent.dur = nil
                myevent.buff = "irongrizzly_summon_proc"
                ApplyBuff(myevent)
            end
        end
        ]]
    else
    	return
    end

    --stat tracking
    local track_ability_stats = true
    if track_ability_stats then
        if not caster.ability_stats_heal then
            caster.ability_stats_heal = {}
        end
        local index = -1
        if event.ability then
            index = event.ability:GetAbilityIndex()
        end
        if index >= 0 then
            if not caster.ability_stats_heal[index] then
                caster.ability_stats_heal[index] = 0
            end
            caster.ability_stats_heal[index] = caster.ability_stats_heal[index] + event.heal
        end
    end

    if event.buffonfullheal and target:GetHealth() / target:GetMaxHealth() >= 1.0 then
        event.ability:ApplyDataDrivenModifier(caster, target, "modifier_holy_ring", {Duration = event.buffdur})
    end
    
    if caster:GetUnitLabel() == "pet" and caster.owner and caster.owner.healingdone then
 		caster.owner.healingdone = caster.owner.healingdone + event.heal
    end
    --print("healing for " .. event.heal)

    -- display fx
    if event.hidenumber ~= nil then
    	displaynumber = false
    else
    	CriticalStrikeFX(nil, target, event.heal, 0, displaynumber)
    end

    --proc
    if event.oncritbuff and was_crit then
        if not event.oncritbuffchance then
            ability:ApplyDataDrivenModifier(caster, caster, event.oncritbuff, nil)
        else
            if math.random(1,100) <= event.oncritbuffchance then
                ability:ApplyDataDrivenModifier(caster, caster, event.oncritbuff, nil)
            end
        end
    end

    --special effect for guardian
    if 	event.FromGuardian ~= nil then
    	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_omniknight/omniknight_purification.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())
		ParticleManager:SetParticleControl(particle, 1, Vector(100,0,0))
        ParticleManager:ReleaseParticleIndex(particle)
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
                myevent.isaoeheal = 1
                myevent.ability = ability
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
		if a:GetManaCost(a:GetLevel()) > 0.0 then
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
		local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_templar_assassin/templar_assassin_refraction_ring_base.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
        ParticleManager:ReleaseParticleIndex(particle)
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
    ability.is_casttime_ability = true

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
        caster:RemoveModifierByName("modifier_lockreload")
        Timers:CreateTimer(0.25,function()
            if ability:GetName() == "wind2" then
                ability:EndCooldown()
            end
        end)
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
	if isalreadyinstant == 0 and caster.book_of_runes_instants and caster.book_of_runes_instants > 0 then
		caster.book_of_runes_instants = caster.book_of_runes_instants - 1
		if caster.book_of_runes_ability then
			caster:SetModifierStackCount("modifier_book_instant_casts", caster.book_of_runes_ability, caster.book_of_runes_instants)
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
                speedbonus = speedbonus + 1
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
            if name == "modifier_item_hunterbow2" then
                speedbonus = speedbonus + 0.3
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
            if name == "modifier_spellhaste_50" then
                speedbonus = speedbonus + 0.5
            end
            if name == "modifier_itemhaste100" then
                speedbonus = speedbonus + 0.75
            end
            if name == "modifier_itemhaste100_2" then
                speedbonus = speedbonus + 1
            end
            if name == "modifier_item_set_t4_panther" then
                speedbonus = speedbonus + 0.5
            end
            if name == "modifier_item_bloodlust" then
                speedbonus = speedbonus + 0.75
            end
            if name == "modifier_item_bloodlust_proc" then
                speedbonus = speedbonus + 1
            end
            if name == "modifier_full_moon" then
                speedbonus = speedbonus + 1
            end
            if name == "modifier_item_bloodlust_2" then
                speedbonus = speedbonus + 1.5
            end
            if name == "modifier_item_bloodlust_proc_2" then
                speedbonus = speedbonus + 2
            end
            if name == "modifier_element_fire" then
                speedbonus = speedbonus + 0.5
            end
            if name == "modifier_divine_haste" then
                speedbonus = speedbonus + 1
            end
            if name == "modifier_item_agihaste_2" or name == "modifier_item_agihaste" then
                speedbonus = speedbonus + caster:GetAgility() / 100
            end
            local shadow_stance_cleric = caster:GetModifierStackCount("modifier_shadow_stance", nil)
            if shadow_stance_cleric > 0 and name == "modifier_shadow_stance" then
                speedbonus = speedbonus + 0.05 * shadow_stance_cleric
            end
            local keeper1_stacks = caster:GetModifierStackCount("modifier_keeper_spellhaste", nil)
            if keeper1_stacks > 0 and name == "modifier_keeper_spellhaste" then
                speedbonus = speedbonus + 0.15 * keeper1_stacks
            end
            local as_path_talent = caster:GetModifierStackCount("modifier_attackspeed", nil)
            if as_path_talent > 0 and name == "modifier_attackspeed" then
                speedbonus = speedbonus + as_path_talent * 0.005
            end
            --slows
    	    if name == "modifier_mindnumb" or name == "modifier_cripple_curse" then
    	    	slowbonus = slowbonus + 0.2
    	    end
        end
        local warlock_haste_talent = caster:FindAbilityByName("Fear_Warlock")
        if warlock_haste_talent and warlock_haste_talent:GetLevel() >= 3 then
            speedbonus = speedbonus + 0.25
        end
        if (heroName == "npc_dota_hero_furion" and caster:GetAbilityByIndex(5):GetLevel() >= 3) then
            speedbonus = speedbonus + 0.5
        end
        if caster:HasModifier("modifier_elune_grace") then
        	speedbonus = speedbonus + 0.25
        end
        if (event.hastebonus and event.hastebonus == 25) then
            speedbonus = speedbonus + 0.25
        end
        if caster.talents and caster.talents[26] and caster.talents[26] > 0 then
            local int_to_haste = 0.0004 * caster.talents[26] * GetIntellectCustom(caster)
            local haste_cap = 0.7 + 0.1 * caster.talents[26]
            if int_to_haste > haste_cap then
                int_to_haste = haste_cap
            end
            speedbonus = speedbonus + int_to_haste
        end
        if caster.talents and caster.talents[32] and caster.talents[32] > 0 then
            speedbonus = speedbonus + 0.5 * caster.talents[32]
        end

        --if caster:HasModifier("modifier_cripple_curse") then
        --    speedbonus = 0
        --end
        if caster:HasModifier("modifier_cripple_curse") then
            slowbonus = slowbonus + 1
        end
            

        --set spell data
        caster.spellhaste = speedbonus
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

    --if particle then
    --    ParticleManager:ReleaseParticleIndex(particle)
    --end
    
    --print("casttime "..event.casttime)
    --Set IsCasting
    caster.IsCasting = 1
    caster.Castbar = particle

    if caster:HasAbility("pveboss_system") then
        particle = ParticleManager:CreateParticle("particles/techies_suicide_dud_arcana_skull.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
        ParticleManager:SetParticleControlEnt(particle, 3, caster, PATTACH_POINT_FOLLOW, "attach_origin", caster:GetAbsOrigin(), true)
        ParticleManager:ReleaseParticleIndex(particle)
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
        ParticleManager:ReleaseParticleIndex(caster.Castbar)
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

    --event.is_end_of_channel = true
    --GlobalOnAbilityExecuted( event )

    --[[if ability.originalcastpoint ~= nil then
	    if ability:GetCastPoint() ~= ability.originalcastpoint then
	    	ability:SetOverrideCastPoint(ability.originalcastpoint)
	    	print("resetting castpoint")
	    end
	end]]
end

function round(num)
    return math.floor(num+.5)
end

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
    local lavalance = caster:FindAbilityByName("Fire_Lance")
    if lavalance then
        lavalance:ApplyDataDrivenModifier(caster, target, "modifier_lavalance_proc", nil)
    end
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
        local entangle_ability_for_talents = caster:FindAbilityByName("RootsDruid")
        if entangle_ability_for_talents then
            event.ability = entangle_ability_for_talents
        end
    	event.buff = "modifier_rootsdruid"
    	CCTarget(event)
    	if event.ability:GetLevel() >= 4 and entangle_ability_for_talents then
    		event.buff = "modifier_mindnumb"
    		event.dur = 15
    		CCTarget(event)
    	end
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
            local mount_speed = 15
            if caster:HasModifier("modifier_item_myth_def") or caster:HasModifier("modifier_moonlighttiger") or caster:HasModifier("modifier_pathbuff_014") or caster:HasModifier("modifier_pathbuff_018") or caster:HasModifier("modifier_item_crit_frost_immortal2") or caster:HasModifier("modifier_item_bootscrit3") or caster:HasModifier("modifier_item_bootscrit4") or caster:HasModifier("modifier_crusader_mount") then --caster.hasmount and caster.hasmount == 2 then
                mount_speed = 45
            end
			if not has_mount and caster:HasModifier("modifier_item_bootscrit2") or caster:HasModifier("modifier_item_lotusguard2") or caster:HasModifier("modifier_item_crit_frost_immortal") or caster:HasModifier("modifier_item_bootsblood3") then --heroName == "npc_dota_hero_mirana" or heroName == "npc_dota_hero_abaddon" or heroName == "npc_dota_hero_chen" or heroName == "npc_dota_hero_disruptor" or caster:HasModifier("modifier_mount_standard") or (caster.hasmount and caster.hasmount == 1) then
                mount_speed = 30
			end
            event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_mount_speed", nil)
            caster:SetModifierStackCount("modifier_mount_speed", event.ability, mount_speed)
            
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
                        ParticleManager:ReleaseParticleIndex(particle)
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
                        ParticleManager:ReleaseParticleIndex(particle)
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
                ParticleManager:ReleaseParticleIndex(particle)
			end
		end
		if distance < 25.0 and (GetMapName() == "10vs10_city_raid" or COverthrowGameMode.junglemode) and caster:GetHealth() / caster:GetMaxHealth() < 1.0 then
			--city raid hp regen
			--if GetMapName() == "10vs10_city_raid" then
                HealUnit({caster = caster, target = caster, ability = event.ability, heal = caster:GetMaxHealth()*0.03})
				--caster:SetHealth(caster:GetHealth()+caster:GetMaxHealth()*0.03)
				local particle = ParticleManager:CreateParticle("particles/generic_gameplay/generic_lifesteal.vpcf", PATTACH_POINT_FOLLOW, caster)
                ParticleManager:ReleaseParticleIndex(particle)
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
			--print(s)
			if s < 1 then
				s = 1
			end
			--DebugScreenTextPretty(caster:GetOrigin()[1], caster:GetOrigin()[3], 10, CastbarString[s], 255, 255, 255, 100, 1.0, "Arial", 10, true)
			--if s>=10 then
			--	DebugDrawText(caster:GetOrigin(), CastbarString[s], true, 0.5)
			--else
			--	DebugDrawText(caster:GetOrigin(), CastbarString[s], true, 0.13)
			--end
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
    --make totem not imune in reflect zone
    if caster:HasModifier("modifier_affix_totem_aura") then
        return
    end
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
        if damage > caster:GetMaxHealth()*0.25 then
            damage = caster:GetMaxHealth()*0.25
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
                ParticleManager:ReleaseParticleIndex(particle)
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
    --if caster:HasModifier("modifier_talent_enrage") then
    --    event.dur = event.dur * 2
    --end
    ApplyBuff(event)
end

function GuardianSpear(event)
    local caster = event.caster
    local target = event.target
    local ability = event.ability
    if caster:GetTeamNumber() == target:GetTeamNumber() then
        ability:ApplyDataDrivenModifier(caster, target, "temple_guardian_hot", {Duration = event.dur})
    else
        event.buff = "temple_guardian_spearslow"
        ApplyBuff(event)
        DamageUnit(event)
    end
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
        event.ability:ApplyDataDrivenModifier(caster, target, "modifier_judgement_spellres", {Duration = event.spellresduration})
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
        if event.ability:GetLevel() >= 4 then
            event.ability:ApplyDataDrivenModifier(caster, target, "modifier_judgement_spellres", {Duration = 6})
        end
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
    --ParticleManager:ReleaseParticleIndex(particle)
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
		--event.ability:EndCooldown()
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
		local particle = ParticleManager:CreateParticleForPlayer("particles/screen_smoke_1.vpcf", PATTACH_POINT_FOLLOW, caster, caster:GetOwner())
        ParticleManager:ReleaseParticleIndex(particle)
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
		event.attributefactor = event.attributefactor * cp
		DamageUnit(event)
		event.target = event.caster
		ApplyBuff(event)
        if event.cd3rd and event.cd3rd > 0 then
            local shiv = caster:FindAbilityByName("combat2")
            if shiv then
                shiv:EndCooldown()
            end
        end
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
        event.ability:StartCooldown(1)
	end
end

function FatalThrowHit(event)
	local caster = event.caster
	local target = event.target

	if caster.FatalThrowCP > 0 then
        local cp = caster.FatalThrowCP

		local myevent = {}
		myevent.caster = caster
		myevent.target = target
		myevent.buff = "modifier_silence"
		myevent.ability = event.ability
		myevent.dur = caster.FatalThrowCP*event.silence
		ApplyBuff(myevent)

		event.attributefactor = event.attributefactor * cp
        event.includeauto = event.includeauto * cp
		DamageUnit(event)

		--damage_table.Duration = caster.FatalThrowCP*2
		--event.ability:ApplyDataDrivenModifier(caster, target, "modifier_slow50", damage_table)

		local myevent = {}
		myevent.caster = caster
		myevent.target = target
		myevent.buff = "modifier_slow50"
		myevent.ability = event.ability
		myevent.dur = cp * event.slow
		ApplyBuff(myevent)
		
        if caster:HasModifier("modifier_shadowblend") and caster:HasModifier("modifier_item_rogueblades2") then
            ChainProjectile( caster, target, event.ability, 1, "particles/units/heroes/hero_phantom_assassin/phantom_assassin_stifling_dagger.vpcf", {target}, "Hero_PhantomAssassin.Dagger.Cast", 0.25, 300 )
        end
	end
end

function ListContainsString( list, text )
    for i=1, #list do
        if list[i] == text then
            return true
        end
    end
    return false
end

function ChainProjectile( caster, target, ability, count, projectile_fx, targets_hit, sound, delay, jumprange )
    local enemies = FindUnitsInRadius( caster:GetTeamNumber(), target:GetAbsOrigin(), caster, jumprange, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
    local enemies_valid = {}
    if count < 1 then
        return
    end
    count = count - 1
    for _,enemy in pairs(enemies) do
        if enemy and ((enemy:GetUnitLabel()=="hero") or (enemy:GetUnitLabel()=="pet")) and not ListContainsString( targets_hit, enemy ) then
            table.insert(enemies_valid, enemy)
        end
    end
    if #enemies_valid > 0 then
        local newtarget = enemies_valid[math.random(1,#enemies_valid)]
        local info = {
            Target = newtarget,
            Source = target,
            Ability = ability,
            EffectName = projectile_fx,
            bDodgeable = true,
            bProvidesVision = true,
            iMoveSpeed = 600,
            iVisionRadius = 300,
            iVisionTeamNumber = caster:GetTeamNumber(),
            iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_HITLOCATION
        }
        ProjectileManager:CreateTrackingProjectile( info )
        EmitSoundOn(sound, caster)
        table.insert(targets_hit, newtarget)
        Timers:CreateTimer(delay, function()
            ChainProjectile( target, newtarget, ability, count, projectile_fx, targets_hit, sound, delay, jumprange )
        end)
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
		caster.ComboPoints = caster.ComboPoints + 3
		if caster.ComboPoints > 3 then
   			caster.ComboPoints = 3
   		end
   		caster:SetModifierStackCount("modifier_combopoint", event.ability, caster.ComboPoints)
   		AddCPEffect(event)
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_nyx_assassin/nyx_assassin_vendetta_blood.vpcf", PATTACH_POINT_FOLLOW, target)
        ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin())
        ParticleManager:ReleaseParticleIndex(particle)
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

 	if caster.artifact_ring and caster.artifact_ring >= 7 then
		local particle = ParticleManager:CreateParticle("particles/econ/courier/courier_wyvern_hatchling/courier_wyvern_hatchling_ice.vpcf", PATTACH_POINT_FOLLOW, caster.Pet)
		--ParticleManager:SetParticleControlEnt(particle, 1, caster.Pet, PATTACH_POINT_FOLLOW, "attach_attack1", caster.Pet:GetAbsOrigin(), true)
        ParticleManager:ReleaseParticleIndex(particle)
		--particle = ParticleManager:CreateParticle("particles/econ/courier/courier_wyvern_hatchling/courier_wyvern_hatchling_ice.vpcf", PATTACH_POINT_FOLLOW, caster.Pet)
        --ParticleManager:ReleaseParticleIndex(particle)
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
                    ParticleManager:ReleaseParticleIndex(particle)
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
	local attack_damage_min = (GetPrimaryStatValueCustom(caster) + GetSpellpower(event)) * event.dmg / 100
	local attack_damage_max = (GetPrimaryStatValueCustom(caster) + GetSpellpower(event)) * event.dmg / 100

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
        ParticleManager:ReleaseParticleIndex(particle)
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

function HideWearablesByItemValue(event)
    DestroyWearablesByItemValue(event.caster)
end

function DestroyWearablesByItemValue(hero) -- not working
    print("destroy wears")
    local item_value = 0
    local k
    for k=0, 5 do
        local item = hero:GetItemInSlot(k)
        if item then
            item_value = item_value + item:GetCost()
        end
    end
    item_value = item_value / 6 -- get average item value
    local item_rank = 0
    if item_value >= 100 then
        item_rank = 1
    end
    if item_value >= 1000 then
        item_rank = 2
    end
    if item_value >= 10000 then
        item_rank = 3
    end
    if item_value >= 30000 then
        item_rank = 4
    end
    local children = hero:GetChildren()
    for _,child in ipairs(children) do
      if child:GetClassname() == "dota_item_wearable" then
        local name = child:GetModelName()
        print(name)
        if IsServer() and name and string.len(name) > 2 then
            --if child:GetModelName() ~= "models/heroes/dazzle/dazzle_mohawk.vmdl" and child:GetModelName() ~= "models/items/dazzle/dotapit_s3_sunshield_back/dotapit_s3_sunshield_back.vmdl" and child:GetModelName() ~= "models/items/dazzle/headdress_of_the_yuwipi/headdress_of_the_yuwipi.vmdl" and child:GetModelName() ~= "models/items/dazzle/back_feathery/back_feathery.vmdl" and child:GetModelName() ~= "models/items/dazzle/shadowflame_back_s1/shadowflame_back_s1.vmdl" then
            child:AddNoDraw()
            --child:SetModel("models/heroes/dazzle/dazzle_mohawk.vmdl")
            --UTIL_Remove(child)
            --child:Destroy()
            print("destroyed")
        end
      end
    end
end

function HideWearables( event )
    --print("hide wears")
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
            --print("hide wear")
            --print(child:GetModelName())
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
    --print("show wears")
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
    if event.lowbonus and event.lowbonus > 0 and target:GetHealth()/target:GetMaxHealth() < 0.50 then
    	statbonus = statbonus + event.lowbonus/100
    end
    local heavencharge = 1 + caster:GetModifierStackCount("modifier_heaven_charge", caster)*0.5
    caster:RemoveModifierByName("modifier_heaven_charge")
	local max_damage_absorb = heavencharge * statbonus * (GetPrimaryStatValueCustom(caster) + GetSpellpower(event)) * event.intfactor / 100

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
    event.ability:ApplyDataDrivenModifier(caster, target, "modifier_invul_warlock", {Duration = 2.5})
	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_clinkz/clinkz_death_pact.vpcf", PATTACH_POINT_FOLLOW, owner)
	ParticleManager:SetParticleControl(particle, 1, owner:GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(particle)

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
		priest:SetMana(priest:GetMana()+event.amount)	
		local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_pugna/pugna_life_drain_beam_2b.vpcf", PATTACH_POINT_FOLLOW, priest)
        ParticleManager:SetParticleControlEnt(particle, 0, priest, PATTACH_POINT_FOLLOW, "attach_hitloc", priest:GetAbsOrigin(), true)
		--ParticleManager:SetParticleControl(particle, 0, priest:GetAbsOrigin()+Vector(0,0,90))
		ParticleManager:SetParticleControl(particle, 1, caster:GetAbsOrigin()+Vector(0,0,90))
		ParticleManager:SetParticleControl(particle, 10, Vector(1,0,0))
		ParticleManager:SetParticleControl(particle, 11, Vector(1,0,0))
		Timers:CreateTimer(0.75, function()
			ParticleManager:DestroyParticle(particle,false)
            ParticleManager:ReleaseParticleIndex(particle)
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
    myevent.max = 10
	ApplyBuffStack(myevent)
end

function ShadowCrippleStacks(event)
	local caster = event.caster
	local target = event.target
	local priest = caster
	if event.darkstacks and event.darkstacks > 0 then
		local ability = priest:FindAbilityByName("Shadow_Creeper")
        if not ability then
            return
        end
		local myevent = {}
		myevent.caster = priest
		myevent.target = target
		myevent.buff = "modifier_shadowcreepercriple"
		myevent.ability = ability
		myevent.dur = 4
        myevent.max = 10
        if event.addstacks then
            myevent.addstacks = event.addstacks
        end
		ApplyBuffStack(myevent)
	end
end

function LightChargeStack(event)
	if event.lightstacks and event.lightstacks > 0 then
		local ability = event.caster:FindAbilityByName("Light_of_Heaven")
        if ability then
		  event.ability = ability
		  ApplyBuffStack(event)
        end
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

function HideUnitDeathInFrost( event )
    local caster = event.caster
    if event.switchtounit then
        caster = event.unit
    end
    local particle2 = ParticleManager:CreateParticle("particles/econ/items/crystal_maiden/crystal_maiden_cowl_of_ice/maiden_crystal_nova_cowlofice.vpcf", PATTACH_WORLDORIGIN, caster)
    ParticleManager:SetParticleControl(particle2, 0, caster:GetAbsOrigin())
    ParticleManager:SetParticleControl(particle2, 1, Vector(200,1,200))
    ParticleManager:ReleaseParticleIndex(particle2)
    caster:SetModelScale(0.001)
    EmitSoundOn("hero_Crystal.frostbite", caster)
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
		if event.caster.trap ~= nil and not event.caster.trap:IsNull() and not event.target:HasModifier("dummy_unit") then
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
                myevent2.frostdmg = 1
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
        local dur = 1.05
        if caster:HasModifier("modifier_npc_dota_hero_drow_ranger") then
            dur = 3.05
        end
        event.ability:ApplyDataDrivenModifier(caster, event.target, "modifier_triple_shot", {Duration = dur})
    end
end

function SnakeTrapTrigger( event )
	if event.caster.trap ~= nil and not event.caster.trap:IsNull() and event.caster.trap.trapused == nil and not event.target:HasModifier("dummy_unit") then
		event.caster.trap.trapused = 1
		--event.caster.owner:GetAbilityByIndex(3):ApplyDataDrivenModifier(event.caster.owner, event.target, "snake_trap", nil)

		local myevent = {}
		myevent.caster = event.caster
		myevent.target = event.target
		myevent.buff = "snake_trap"
		myevent.ability = event.caster:FindAbilityByName("wind4")
		myevent.dur = 0.5
		ApplyBuff(myevent)

		--fire aoe trap
		if event.aoe and event.aoe > 0 then
			local particle = ParticleManager:CreateParticle("particles/econ/items/clockwerk/clockwerk_paraflare/clockwerk_para_rocket_flare_explosion.vpcf", PATTACH_POINT_FOLLOW, event.target)
			ParticleManager:SetParticleControl(particle, 3, event.target:GetAbsOrigin())
            ParticleManager:ReleaseParticleIndex(particle)
			particle = ParticleManager:CreateParticle("particles/econ/items/gyrocopter/hero_gyrocopter_gyrotechnics/gyro_calldown_explosion_flash_c.vpcf", PATTACH_POINT_FOLLOW, event.target)
			ParticleManager:SetParticleControl(particle, 3, event.target:GetAbsOrigin())
            ParticleManager:ReleaseParticleIndex(particle)
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
    return GetPrimaryStatValueCustom(target) + GetSpellpower(tab)
end

function PetSystem( event )
    local caster = event.target
    local target = event.caster
    --print(target)
    caster.owner = target
    --if event.setpetowner then
    --    target = event.caster
    --end
    if target and caster then
        local dmg = 0
        if event.dmg then
            dmg = dmg + event.dmg
        end
        if event.aa then
            dmg = dmg + event.aa* target:GetAttackDamage()/100 --target:GetAverageTrueAttackDamage(target)/100
        end
        if event.primary then
            dmg = dmg + event.primary*GetPrimaryStatValueCustom(target)/100
        end
        if event.str then
            dmg = dmg + event.str*GetStrengthCustom(target)/100
        end
        if event.agi then
            dmg = dmg + event.agi*target:GetAgility()/100
        end
        if event.int then
            dmg = dmg + event.int*GetIntellectCustom(target)/100
        end
        if event.sp then
            dmg = dmg + event.sp*GetSpellpower({caster = target})/100
        end
        if event.intsp then
            dmg = dmg + GetPrimaryAndSpellpower(target) * event.intsp / 100
        end
        if event.beastmasterghostwolf and target:HasModifier("modifier_item_beastmaster") then
            dmg = dmg + GetStrengthCustom(target) * 0.25
        end
        if event.beastmasterghostwolf and target:HasModifier("modifier_item_beastmaster2") then
            dmg = dmg + GetStrengthCustom(target) * 0.5
        end

        --talents
        local bonus = 1.0
        if event.talentscale and target.talents and target.talents[event.talentscale] then
            bonus = target.talents[event.talentscale]
        end
        if event.runewordscale and event.runewordscale == 11 and target.runeword and target.runeword[event.runewordscale] then
            bonus = bonus + target.runeword[event.runewordscale]
        end
        dmg = dmg * bonus

        caster:SetBaseDamageMin(dmg)
        caster:SetBaseDamageMax(dmg)
        if (caster:GetAbsOrigin() - target:GetAbsOrigin()):Length() > 2250 then
            caster:SetAbsOrigin(target:GetAbsOrigin())
            local tab = {}
            tab.Duration = 0.5
            event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_phased", tab)
            local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_chen/chen_teleport.vpcf", PATTACH_POINT_FOLLOW, caster)
            ParticleManager:ReleaseParticleIndex(particle)
        end
        --talents
        if target and target.talents and target.talents[69] and target.talents[69] > 0 and not caster.path_heal_on_summon_done then
            local myevent = {caster = target, target = target, heal = target:GetMaxHealth() * 0.03 * target.talents[69]}
            HealUnit(myevent)
            caster.path_heal_on_summon_done = true
            --local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_vengeful/vengeful_wave_of_terror_recipient.vpcf", PATTACH_POINT_FOLLOW, target)
            --ParticleManager:ReleaseParticleIndex(particle)
            local particle = ParticleManager:CreateParticle("particles/items3_fx/glimmer_cape_initial_flash_ember.vpcf", PATTACH_POINT_FOLLOW, target)
            ParticleManager:ReleaseParticleIndex(particle)
            if target.path_demonic_pact then
                target.path_demonic_pact = target.path_demonic_pact + 1
            else
                target.path_demonic_pact = 1
            end
            Timers:CreateTimer(15,function()
                target.path_demonic_pact = target.path_demonic_pact - 1
            end)
        end
        if event.companionbehavior then
            local target_to_attack = target.last_attack_target
            if not target_to_attack then
                target_to_attack = target.creepertarget
            end
            if target_to_attack and not target_to_attack:IsNull() and target_to_attack:IsAlive() and (target_to_attack:GetAbsOrigin() - target:GetAbsOrigin()):Length() < 890 then
                local order = 
                {
                    UnitIndex = caster:entindex(),
                    OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
                    TargetIndex = target_to_attack:entindex()
                }
                ExecuteOrderFromTable(order)
            else
                local order = 
                {
                    UnitIndex = caster:entindex(),
                    OrderType = DOTA_UNIT_ORDER_MOVE_TO_TARGET,
                    TargetIndex = target:entindex()
                }
                ExecuteOrderFromTable(order)
            end
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
        event.ability:ApplyDataDrivenModifier(caster, target, "modifier_multi_arrows_fierce", {Duration = 0.31})
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
    if event.jumpdur then
        jumpdur = event.jumpdur
    end
    if event.ondealdamagetarget then
        npc = event.unit
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
            elseif event.left then
                local set_pos = event.caster:GetAbsOrigin() - event.caster:GetForwardVector() * 125
                npc:SetAbsOrigin(set_pos)
                local vec1 = RotateVectorAroundAngle(event.caster:GetForwardVector(), 225)
                vec = Vector(vec1[1],vec1[2],0)
                npc:SetForwardVector(vec)
            elseif event.right then
                local set_pos = event.caster:GetAbsOrigin() - event.caster:GetForwardVector() * 125
                npc:SetAbsOrigin(set_pos)
                local vec1 = RotateVectorAroundAngle(event.caster:GetForwardVector(), 135)
                vec = Vector(vec1[1],vec1[2],0)
                npc:SetForwardVector(vec)
            elseif event.leftcurve then
                --event.leftcurve = 90
                local angle = event.leftcurve
                if not npc.leftcurve then
                    npc.leftcurve = event.leftcurve
                else
                    npc.leftcurve = npc.leftcurve - 30
                    angle = npc.leftcurve
                end
                if angle < -90 then
                    angle = -30
                    --npc.leftcurve = npc.leftcurve + 15
                    --angle = npc.leftcurve
                end
                local vec1 = RotateVectorAroundAngle(npc:GetForwardVector(), -angle)
                vec = Vector(vec1[1],vec1[2],0)
                npc:SetForwardVector(vec)
            elseif event.rightcurve then
                --event.rightcurve = 90
                local angle = event.rightcurve
                if not npc.rightcurve then
                    npc.rightcurve = event.rightcurve
                else
                    npc.rightcurve = npc.rightcurve - 30
                    angle = npc.rightcurve
                end
                if angle < -90 then
                    angle = -30
                    --npc.rightcurve = npc.rightcurve + 15
                    --angle = npc.rightcurve
                end
                local vec1 = RotateVectorAroundAngle(npc:GetForwardVector(), angle)
                vec = Vector(vec1[1],vec1[2],0)
                npc:SetForwardVector(vec)
            elseif event.zigzag then
                local angle = 30 --event.zigzag
                event.fixedforce = 150
                if not npc.zigzag then
                    --initial force is to the side
                    local vec1 = RotateVectorAroundAngle(npc:GetForwardVector(), 90)
                    vec = Vector(vec1[1],vec1[2],0)
                    npc:SetForwardVector(vec)
                    npc.zigzag = 0
                else
                    --after initial direction, rotate a bit every tick
                    npc.zigzag = npc.zigzag + angle
                    local vec1
                    if (npc.zigzag % 361) < 180 then
                        vec1 = RotateVectorAroundAngle(npc:GetForwardVector(), angle)
                    else
                        vec1 = RotateVectorAroundAngle(npc:GetForwardVector(), -angle)
                    end
                    vec = Vector(vec1[1],vec1[2],0)
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
    npc:SetGroundBehavior(PHYSICS_GROUND_LOCK)
    if event.leftcurve or event.rightcurve or event.right or event.left then
        npc:SetNavCollisionType(PHYSICS_NAV_NOTHING)
        npc:SetGroundBehavior(PHYSICS_GROUND_ABOVE)
    else
        npc:SetNavCollisionType(PHYSICS_NAV_BOUNCE)
    end
	npc:FollowNavMesh(true)
	npc:SetPhysicsVelocityMax(2500)
	if event.friction then
		npc:SetPhysicsFriction(event.friction)
        --print("friction" .. event.friction)
	end
	npc:Hibernate(false)
	
	vec = vec * 2.0 * dir * overtimefactor
	if event.upintheair and event.upintheair > 0 then
        vec = vec * 0.5 / jumpdur
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

    --dust fx
    --local particle = ParticleManager:CreateParticle("particles/econ/events/fall_major_2016/force_staff_fm06_dust.vpcf", PATTACH_POINT_FOLLOW, npc)
    --ParticleManager:ReleaseParticleIndex(particle)
    

	Timers:CreateTimer(jumpdur, function()
		if npc.isunderforce <= 1 then
            if not event.forever and not event.leftcurve and not event.rightcurve and not event.left and not event.right then
                npc:SetPhysicsVelocity(Vector(0,0,0))
                npc:SetGroundBehavior(PHYSICS_GROUND_LOCK)
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

function ForceMovementPattern( event )
    local unit = event.target
    local caster = event.caster
    local speed = 15 --event.speed
    local angle = 5 --event.zigzag
    if unit:IsNull() or not unit:IsAlive() then
        return
    end
    if event.zigzag then
        event.fixedforce = 150
        if not event.is_already_initialized then
            --initial force is to the side
            event.is_already_initialized = true
            local forward = event.caster:GetForwardVector()
            local random_hero = COverthrowGameMode:PVERandomTargetNearTarget(caster, 2500)
            if random_hero then
                forward = (random_hero:GetAbsOrigin()-caster:GetAbsOrigin()):Normalized()
            end
            local new_forward = RotateVectorAroundAngle(forward, -90)
            unit:SetForwardVector(new_forward)
            unit:SetAbsOrigin(unit:GetAbsOrigin()+new_forward*speed)
            unit.zigzag_angle = 0
        else
            --after initial direction, rotate a bit every tick
            local forward = unit:GetForwardVector()
            local new_forward
            --go straight after curve
            if ((unit.zigzag_angle % 361) >= 170 and (unit.zigzag_angle % 361) <= 190) or ((unit.zigzag_angle % 361) >= 350 or (unit.zigzag_angle % 361) <= 10) then
                angle = 0.5
            end
            if (unit.zigzag_angle % 361) < 180 then
                new_forward = RotateVectorAroundAngle(forward, angle)
            else
                new_forward = RotateVectorAroundAngle(forward, -angle)
            end
            unit:SetForwardVector(new_forward)
            unit:SetAbsOrigin(unit:GetAbsOrigin()+new_forward*speed)
            unit.zigzag_angle = unit.zigzag_angle + angle
        end
    end
    if event.circleout then
        if not event.is_already_initialized then
            --initial force is to back
            event.is_already_initialized = true
            local forward = event.caster:GetForwardVector()
            local new_forward = -forward
            unit:SetForwardVector(new_forward)
            unit:SetAbsOrigin(unit:GetAbsOrigin()+new_forward*speed+Vector(0,0,60))
            event.angle = 5
            if math.random(1,100) <= 50 then
                event.angle = -5
            end
        else
            event.angle = event.angle * 0.995
            local forward = RotateVectorAroundAngle(unit:GetForwardVector(), event.angle)
            unit:SetForwardVector(forward)
            unit:SetAbsOrigin(unit:GetAbsOrigin()+forward*speed)
        end
    end
    if event.frombehindtofront then
        if not event.is_already_initialized then
            --initial force is to back
            event.is_already_initialized = true
            local forward = event.caster:GetForwardVector()
            local spawnpos = caster:GetAbsOrigin() - forward * 2000
            unit:SetAbsOrigin(spawnpos)
            local all = HeroList:GetAllHeroes()
            local random_target = all[math.random(1,#all)]
            local new_forward = (random_target:GetAbsOrigin() - spawnpos):Normalized()
            unit:SetForwardVector(new_forward)
            unit:SetAbsOrigin(unit:GetAbsOrigin()+new_forward*speed+Vector(0,0,60))
            event.forward = new_forward
        else
            speed = 25
            local forward = event.forward
            unit:SetAbsOrigin(unit:GetAbsOrigin()+forward*speed)
        end
    end
    Timers:CreateTimer(0.03, function()
        ForceMovementPattern( event )
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
    local target = event.target
    local chance = 0
    local dur = 0.7 -- 2 procs, tick = 0.3
    local item = caster:HasModifier("modifier_item_frostfire2")
    if not caster:IsRealHero() and caster.owner then
        item = caster.owner:HasModifier("modifier_item_frostfire2")
    end
    if item then
        chance = 15
        dur = 1.0
    else
        --maybe frostfire old
        item = caster:HasModifier("modifier_item_frostfire")
        if not caster:IsRealHero() and caster.owner then
            item = caster.owner:HasModifier("modifier_item_frostfire")
        end
        if item then
            chance = 10
        end
    end
    if item and math.random(1,100) <= chance then
        event.ability:ApplyDataDrivenModifier(caster, target, "modifier_multicast_item", {Duration = dur})
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
    if caster.Pet and not caster.Pet:IsNull() then
        caster.Pet:Destroy()
        caster.Pet = nil
    end
end

function SummonPet (event)
	local caster = event.caster
	local owner = caster:GetOwner()
	local teamid = caster:GetTeamNumber()
	local origin = caster:GetAbsOrigin() + RandomVector(100)
    local ability = event.ability
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
		caster.Pet:GetAbilityByIndex(3):SetLevel(event.ability:GetLevel())
        caster.Pet:GetAbilityByIndex(0):ToggleAutoCast()

        --local dmg = event.scale*caster:GetAverageTrueAttackDamage(caster)/100
        if caster:HasModifier("modifier_item_beastmaster2") then
            --dmg = dmg + 3000
            caster.Pet:SetModelScale(1.35)
        end
        --caster.Pet:SetBaseDamageMin(dmg)
        --caster.Pet:SetBaseDamageMax(dmg)
        event.ability:ApplyDataDrivenModifier(caster, caster.Pet, "modifier_pet_system", nil)
	end
	if event.pet == "ghoul" then
		caster.Pet = CreateUnitByName("npc_dota_creature_ghoul", origin, true, owner, nil, teamid)
		if event.crit and event.crit > 0 then
			caster.Pet:AddAbility("pve_passive_as_25"):SetLevel(1)
		end
        --caster.Pet:SetBaseDamageMin(event.damageset*caster:GetStrength()/100)
        --caster.Pet:SetBaseDamageMax(event.damageset*caster:GetStrength()/100)
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
		if caster.cosmetic_warlock_pet then
			local particle = ParticleManager:CreateParticle("particles/econ/items/enigma/enigma_world_chasm/enigma_world_chasm_ambient.vpcf", PATTACH_POINT_FOLLOW, caster.Pet)
			ParticleManager:SetParticleControlEnt(particle, 0, caster.Pet, PATTACH_POINT_FOLLOW, "attach_attack1", caster.Pet:GetAbsOrigin(), true)
			ParticleManager:SetParticleControlEnt(particle, 1, caster.Pet, PATTACH_POINT_FOLLOW, "attach_attack2", caster.Pet:GetAbsOrigin(), true)
            ParticleManager:ReleaseParticleIndex(particle)
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
 	ability:ApplyDataDrivenModifier(event.caster, caster.Pet, "modifier_phased", table)

 	--instant sacrafice
 	if event.pet == "fel" and event.dur and event.dur > 0 then
		event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_warlockrage", nil)
		--local tab = {}
		--tab.caster = caster.Pet
		--tab.amount = 60.0
        --tab.ability = ability
		--WarlockSacrifice(tab)
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
    event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_beastrage", nil)
    caster:SetRenderColor(255, 0, 0)
	if caster.PermanentPet ~= nil and (not caster.PermanentPet:IsNull()) and caster.PermanentPet:IsAlive() then
 		event.ability:ApplyDataDrivenModifier(event.caster, caster.PermanentPet, "modifier_beastrage", nil)
 		caster.PermanentPet:SetRenderColor(255, 0, 0)
 	end
end

function BeastrageEnd(event)
	caster = event.caster
	caster:SetRenderColor(255, 255, 255)
	if caster.PermanentPet ~= nil and (not caster.PermanentPet:IsNull()) and caster.PermanentPet:IsAlive() then
 		caster.PermanentPet:SetRenderColor(255, 255, 255)
 	end
end

function BeastrageCD( event )
    local pet = event.attacker
    local caster = pet.owner
    if caster then
        local ability = caster:FindAbilityByName("Beastrage")
        if ability and ability:GetLevel() >= 3 then
            local myevent = {caster = caster, amount = 1, ability = ability }
            ReduceCooldown(myevent)
        end
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
            ParticleManager:ReleaseParticleIndex(particle)
			particle = ParticleManager:CreateParticle("particles/units/heroes/hero_lone_druid/lone_druid_bear_blink_start.vpcf", PATTACH_POINT_FOLLOW, caster)
			ParticleManager:SetParticleControl(particle, 0, caster:GetAbsOrigin())
			ParticleManager:SetParticleControl(particle, 1, caster:GetAbsOrigin())
            ParticleManager:ReleaseParticleIndex(particle)
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
        COverthrowGameMode:RemoveAllCosmeticsGlobal(target)
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
        COverthrowGameMode:EquipArtifactCosmeticRewardsGlobal(target)
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
            if event.event_ability:GetAbilityIndex() == 0 or event.event_ability:GetAbilityIndex() == 2 or event.event_ability:GetAbilityIndex() == 5 then
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
    local qualities = COverthrowGameMode:GetAllArtifactItemQuality(caster)
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
            myevent.dur = 60
            ApplyBuff(myevent)
        end
        if qualities and qualities[2] and qualities[2] >= 7 then
            event.ability:ApplyDataDrivenModifier(target, target, "modifier_frostarmorbuff_fx", {Duration = event.duration})
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
        if qualities and qualities[2] and qualities[2] >= 7 then
            event.ability:ApplyDataDrivenModifier(target, target, "modifier_frostarmorbuff_fx", {Duration = myevent.dur})
        end
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
        ParticleManager:ReleaseParticleIndex(particle)

		particle = ParticleManager:CreateParticle("particles/items2_fx/soul_ring_blood.vpcf", PATTACH_POINT_FOLLOW, target)
		ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())
        ParticleManager:ReleaseParticleIndex(particle)
		
		particle = ParticleManager:CreateParticle("particles/units/heroes/hero_bloodseeker/bloodseeker_bloodritual_impact_c.vpcf", PATTACH_POINT_FOLLOW, target)
		ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())
        ParticleManager:ReleaseParticleIndex(particle)
		
		
		

		EmitSoundOn( "DOTA_Item.DiffusalBlade.Kill", target)
	end

	-- Zeus
	if proctype == "zeus" and not (caster:HasModifier("modifier_cdzeus")) then
		event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_cdzeus", nil)
		--fx
		local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_disruptor/disruptor_thunder_strike_aoe.vpcf", PATTACH_POINT_FOLLOW, target)
        ParticleManager:ReleaseParticleIndex(particle)
		particle = ParticleManager:CreateParticle("particles/units/heroes/hero_disruptor/disruptor_thunder_strike_bolt.vpcf", PATTACH_POINT_FOLLOW, target)
    	ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())
		ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin())
		ParticleManager:SetParticleControl(particle, 2, target:GetAbsOrigin())
		ParticleManager:SetParticleControl(particle, 3, target:GetAbsOrigin())
        ParticleManager:ReleaseParticleIndex(particle)
		particle = ParticleManager:CreateParticle("particles/units/heroes/hero_zuus/zuus_thundergods_wrath_start.vpcf", PATTACH_POINT_FOLLOW, target)
    	ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())
		ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin())
		ParticleManager:SetParticleControl(particle, 2, target:GetAbsOrigin())
		ParticleManager:SetParticleControl(particle, 3, target:GetAbsOrigin())
        ParticleManager:ReleaseParticleIndex(particle)
		particle = ParticleManager:CreateParticle("particles/econ/items/zeus/lightning_weapon_fx/zuus_lightning_bolt_castfx_ground2.vpcf", PATTACH_POINT_FOLLOW, target)
        ParticleManager:ReleaseParticleIndex(particle)
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

function ChainLightningOld(event)
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
                        ParticleManager:ReleaseParticleIndex(particle)
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
            COverthrowGameMode:EquipArtifactCosmeticRewardsGlobal(caster)
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
            COverthrowGameMode:RemoveAllCosmeticsGlobal(caster)
			local model = "models/items/lycan/wolves/hunter_kings_wolves/hunter_kings_wolves.vmdl"
			local scale = 0.9
			--new form
			if caster.artifact_offhand and caster.artifact_offhand == 6 then
				model = "models/items/lycan/wolves/blood_moon_hunter_wolves/blood_moon_hunter_wolves.vmdl"
				scale = 0.9
			end
            if caster.artifact_offhand and caster.artifact_offhand == 7 then
                model = "models/items/lycan/ultimate/blood_moon_hunter_shapeshift_form/blood_moon_hunter_shapeshift_form.vmdl"
                scale = 0.7
            end
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
		event.heal = GetStrengthCustom(caster)*0.4
		event.spelldamagefactor = 0.0
		event.attributefactor = 0.0
		HealUnit(event)
		particle = ParticleManager:CreateParticle("particles/units/heroes/hero_dazzle/dazzle_shadow_wave_magic.vpcf", PATTACH_POINT_FOLLOW, caster)
		ParticleManager:SetParticleControl(particle, 0, caster:GetAbsOrigin())
		ParticleManager:SetParticleControl(particle, 1, caster:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(particle)
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

	local stackcount = stackcount + event.amount*GetPrimaryStatValueCustom(caster)/100

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
		if caster.ComboPoints >= 4 then
			ability:ApplyDataDrivenModifier(caster, caster, "modifier_instantbolt", nil)
            caster:SetModifierStackCount("modifier_instantbolt", ability, 1)
		end
		--caster:SetModifierStackCount("modifier_feralpowercast", ability, caster.ComboPoints)
		local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_dazzle/dazzle_shadow_wave_magic.vpcf", PATTACH_POINT_FOLLOW, caster)
		ParticleManager:SetParticleControl(particle, 0, caster:GetAbsOrigin())
		ParticleManager:SetParticleControl(particle, 1, caster:GetAbsOrigin())
        ParticleManager:ReleaseParticleIndex(particle)

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
            for i=0, 3 do
                Timers:CreateTimer(0.20*i, function()
                    local myevent = {}
                    myevent.caster = caster
                    myevent.target = target
                    myevent.damage = 0.0
                    myevent.attributefactor = event.dmgfromstat * caster.FeralFinisher
                    myevent.attributechangestragi = 1
                    myevent.ability = ability
                    --myevent.feral4x = 1
                    myevent.critchancefactor = event.critchancefactor
                    myevent.t3bonus = event.t3bonus
                    DamageUnit(myevent)
                    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_bloodseeker/bloodseeker_rupture_nuke.vpcf", PATTACH_POINT_FOLLOW, target)
                    ParticleManager:ReleaseParticleIndex(particle)
                    EmitSoundOn("Hero_LoneDruid.TrueForm.Attack", target)
                end)
            end
        end
	end
end

function ShieldBash(event)
	local caster = event.caster
	local target = event.target
	local ability = event.ability
	local stackcount = 0
    local stacks_added = 1
    if caster:HasModifier("modifier_npc_dota_hero_dragon_knight") then
        stacks_added = 5
    end
	if caster:HasModifier("modifier_shieldbash") then

		stackcount = caster:GetModifierStackCount("modifier_shieldbash", caster) + stacks_added
		if stackcount > event.stacks then
			stackcount = event.stacks
		end
		target:RemoveModifierByName("modifier_shieldbash")
		ability:ApplyDataDrivenModifier(caster, caster, "modifier_shieldbash", nil)
		caster:SetModifierStackCount("modifier_shieldbash", ability, stackcount)
	else
		ability:ApplyDataDrivenModifier(caster, caster, "modifier_shieldbash", nil)
		stackcount = stacks_added
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
    --event.includeauto = event.includeauto + event.includeauto*targetamount*event.aoebonus/100

	if #enemies > 0 then
		for _,enemy in pairs(enemies) do
			if enemy ~= nil then
				if ((enemy:GetUnitLabel()=="hero") or (enemy:GetUnitLabel()=="pet") or (enemy:GetUnitLabel()=="tower")) then
                    if CountBuffs( caster, "modifier_prot_str_bonus" ) <= 30 then
					   ability:ApplyDataDrivenModifier(caster, caster, "modifier_prot_str_bonus", nil)
                    end
					local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_bloodseeker/bloodseeker_rupture_nuke.vpcf", PATTACH_POINT_FOLLOW, enemy)
                    ParticleManager:ReleaseParticleIndex(particle)
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
                    ParticleManager:ReleaseParticleIndex(particle)
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
            ParticleManager:ReleaseParticleIndex(particle)
            EmitSoundOn( "DOTA_Item.Mjollnir.Activate", caster)
            Timers:CreateTimer(0.5, function()
                particle = ParticleManager:CreateParticle("particles/units/heroes/hero_disruptor/disruptor_thunder_strike_bolt.vpcf", PATTACH_POINT_FOLLOW, caster)
                ParticleManager:SetParticleControl(particle, 0, caster:GetAbsOrigin())
                ParticleManager:SetParticleControl(particle, 1, caster:GetAbsOrigin())
                ParticleManager:SetParticleControl(particle, 2, caster:GetAbsOrigin())
                ParticleManager:SetParticleControl(particle, 3, caster:GetAbsOrigin())
                ParticleManager:ReleaseParticleIndex(particle)
                EmitSoundOn( "DOTA_Item.Mjollnir.Activate", caster)
            end)
            Timers:CreateTimer(1.0, function()
                particle = ParticleManager:CreateParticle("particles/units/heroes/hero_disruptor/disruptor_thunder_strike_bolt.vpcf", PATTACH_POINT_FOLLOW, caster)
                ParticleManager:SetParticleControl(particle, 0, caster:GetAbsOrigin())
                ParticleManager:SetParticleControl(particle, 1, caster:GetAbsOrigin())
                ParticleManager:SetParticleControl(particle, 2, caster:GetAbsOrigin())
                ParticleManager:SetParticleControl(particle, 3, caster:GetAbsOrigin())
                ParticleManager:ReleaseParticleIndex(particle)
                EmitSoundOn( "DOTA_Item.Mjollnir.Activate", caster)
            end)
        else
		    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_ursa/ursa_earthshock.vpcf", PATTACH_POINT_FOLLOW, caster)
            ParticleManager:ReleaseParticleIndex(particle)
            EmitSoundOn( "Hero_DragonKnight.BreathFire", caster)
        end
        
        local procs = 1
        if event.thunder and event.thunder > 0 then
            procs = 3
        end
        for k=1,procs do
            Timers:CreateTimer(0.05+(0.5*(k-1)), function()
        		local enemies = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetOrigin(), caster, range, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
        		if #enemies > 0 then
        			for _,enemy in pairs(enemies) do
        				if enemy ~= nil then
        					if ((enemy:GetUnitLabel()=="hero") or (enemy:GetUnitLabel()=="pet") or (enemy:GetUnitLabel()=="tower")) then
                                if k == 1 then
            						local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_bloodseeker/bloodseeker_rupture_nuke.vpcf", PATTACH_POINT_FOLLOW, enemy)
                                    ParticleManager:ReleaseParticleIndex(particle)
            						local myevent = {}
            						myevent.caster = caster
            						myevent.target = enemy
            						myevent.buff = "modifier_slow75"
            						myevent.ability = ability
            						myevent.dur = event.dur
            						ApplyBuff(myevent)
                                end
                                if event.thunder and event.thunder > 0 then
                                    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_disruptor/disruptor_thunder_strike_aoe.vpcf", PATTACH_ABSORIGIN_FOLLOW, enemy)
                                    ParticleManager:ReleaseParticleIndex(particle)
                                    local myevent = {}
                                    myevent.caster = caster
                                    myevent.target = enemy
                                    myevent.ability = ability
                                    myevent.damage = 0.0
                                    myevent.spelldamagefactor = 0.0
                                    myevent.attributefactor = event.thunder
                                    myevent.naturedmg = 1
                                    myevent.isaoe = 1
                                    DamageUnit(myevent)
                                end
        					end
        				end
        			end
        		end
    	   end)
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
                        ParticleManager:ReleaseParticleIndex(particle)
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

    local myevent = {}
	if event.protstun and event.protstun > 0.0 then
		myevent.caster = caster
		myevent.target = target
		myevent.buff = "modifier_stunned"
		myevent.ability = event.ability
		myevent.dur = event.protstun
	end
	DamageUnit(event)
    if event.protstun and event.protstun > 0.0 then
        ApplyBuff(myevent)
    end
end

function Kingsguard( event )
	local target = event.target
	local caster = event.caster
	local vec = (event.target:GetAbsOrigin()-event.caster:GetAbsOrigin()):Length()

	if vec >= 900 then
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
        ParticleManager:ReleaseParticleIndex(particle)
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
        ParticleManager:ReleaseParticleIndex(particle)
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
		local abil = caster:FindAbilityByName("Ghost1")
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
                                ParticleManager:ReleaseParticleIndex(particle)
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
                ParticleManager:ReleaseParticleIndex(particle)
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
    local ability = caster:FindAbilityByName("destro6")
    if ability then
        for i=1,3 do
            if ability and caster.imps and caster.imps[i] and not caster.imps[i]:IsNull() and caster.imps[i]:IsAlive() then
                ability:ApplyDataDrivenModifier(caster.imps[i], target, event.buff, nil)
            end
        end
    end
end

function EleBalance(event)
	local caster = event.caster
	local target = event.target
	local stackcount = caster:GetModifierStackCount("modifier_elementalfury", caster)
	caster:RemoveModifierByName("modifier_elementalfury")

	--self stun
	local stuntime = 10 - stackcount
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

		local particle = ParticleManager:CreateParticle("particles/econ/items/zeus/lightning_weapon_fx/zuus_lightning_bolt_castfx_ground2.vpcf", PATTACH_POINT_FOLLOW, caster)
        ParticleManager:ReleaseParticleIndex(particle)
		EmitSoundOn( "DOTA_Item.Mjollnir.Activate", caster)
	end

	event.spelldamagefactor = stackcount*event.spelldamagefactor/10
	event.attributefactor = stackcount*event.attributefactor/10

	if caster:GetTeamNumber()==target:GetTeamNumber() then
		
		local vec1 = caster:GetAbsOrigin()+Vector(0,0,150)
		local vec2 = target:GetAbsOrigin()+Vector(0,0,150)
		local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_earth_spirit/espirit_magnet_arclightning.vpcf", PATTACH_POINT_FOLLOW, target)
		ParticleManager:SetParticleControl(particle, 0, vec2)
		ParticleManager:SetParticleControl(particle, 1, vec1)
		ParticleManager:SetParticleControl(particle, 2, vec2)
        ParticleManager:ReleaseParticleIndex(particle)
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
        ParticleManager:ReleaseParticleIndex(particle)
		EmitSoundOn( "DOTA_Item.Mjollnir.Activate", target)

		DamageUnit(event)
	end
end

function EleConv(event)
	local caster = event.attacker

	if caster:HasModifier("modifier_elementalfury") then
		local stackcount = caster:GetModifierStackCount("modifier_elementalfury", caster)+1
		if stackcount > 10 then
			stackcount = 10
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
            ParticleManager:ReleaseParticleIndex(particle)
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
        ParticleManager:ReleaseParticleIndex(particle)
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
    ParticleManager:ReleaseParticleIndex(particle)
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
        ParticleManager:ReleaseParticleIndex(particle)
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
            ParticleManager:ReleaseParticleIndex(particle)
		else
			local particle = ParticleManager:CreateParticle("particles/econ/events/ti5/blink_dagger_start_smoke_ti5.vpcf", PATTACH_POINT_FOLLOW, caster)
            ParticleManager:ReleaseParticleIndex(particle)
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
        if stackcount > 20 then
            stackcount = 20
        end
		caster:SetModifierStackCount("modifier_arcanepower", event.ability, stackcount)
	else
        event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_arcanepower", nil)
        caster:SetModifierStackCount("modifier_arcanepower", event.ability, 1)
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
    --get arcane power stacks
    local stackcount = caster:GetModifierStackCount("modifier_arcanepower", caster)
    if stackcount >= 10 and not caster:HasModifier("modifier_burning_nether") then
        --caster:RemoveModifierByName("modifier_arcanepower")
        caster:SetModifierStackCount("modifier_arcanepower", event.ability, stackcount - 10)
        event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_burning_nether", {Duration = 20})
        caster:SetModifierStackCount("modifier_burning_nether", event.ability, 5)
    end
    stackcount = caster:GetModifierStackCount("modifier_burning_nether", caster)
	if stackcount > 0 then
        stackcount = stackcount - 1
        if stackcount >= 1 then
            caster:SetModifierStackCount("modifier_burning_nether", event.ability, stackcount)
        else
            caster:RemoveModifierByName("modifier_burning_nether")
        end
        if event.arcane and event.arcane == 1 then
		    event.ability:ApplyDataDrivenModifier(caster, target, "modifier_meteor_proc_arcane", nil)
        else
            event.ability:ApplyDataDrivenModifier(caster, target, "modifier_meteor_proc", nil)
        end
	else
		caster:SetMana(caster:GetMana() + 45)
	end
end

function MeteorEnd(event)
	local caster = event.caster
    ApplyBuff(event)
    --if caster:HasModifier("modifier_burning_nether") then
    --    ApplyBuff(event)
    --end
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
	local abil = caster:FindAbilityByName("Retri4")
	if abil and abil:GetLevel() >= 4 then
 		local cd = abil:GetCooldownTimeRemaining()
    	if cd > 0.1 then
    		abil:EndCooldown()
    		abil:StartCooldown(cd-1)
    	end
	end
end

function PalaUltiCD(event)
	local caster = event.caster
	local abil = event.ability
	if abil:GetLevel() >= 4 then
		abil = caster:FindAbilityByName("Retri6")
        if abil then
     		local ab = abil:GetCooldownTimeRemaining()
        	if ab > 0.1 then
        		abil:EndCooldown()
        		abil:StartCooldown(ab-0.25)
        	end
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
        ParticleManager:ReleaseParticleIndex(particle)
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
    ParticleManager:ReleaseParticleIndex(particle)
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
		local agi = GetPrimaryStatValueCustom(caster)*event.percent/100
		event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_rogue_primary_bonus", nil)
		caster:SetModifierStackCount("modifier_rogue_primary_bonus", event.ability, agi)
	end
end

function AghaStun( event )
	local caster = event.attacker
	local target = event.target
	--agha
	if caster:HasModifier("modifier_item_straxe2") then
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
    ParticleManager:ReleaseParticleIndex(particle)
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
    ParticleManager:ReleaseParticleIndex(particle)
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
    if caster and target then
        if not event.ignore_crit_effect_cooldown then
            if not COverthrowGameMode.crit_effect_cooldown then
                COverthrowGameMode.crit_effect_cooldown = true
                Timers:CreateTimer(5,function()
                    COverthrowGameMode.crit_effect_cooldown = nil
                end)
            else
                return
            end
        end
    else
        return
    end
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
    ParticleManager:ReleaseParticleIndex(particle)
end

function CosmeticEffectsFromItems( event )
    local caster = event.caster
    local target = event.target
    local ability = event.ability
    local qualities = COverthrowGameMode:GetAllArtifactItemQuality(caster)
    if event.pa and qualities and qualities[1] and qualities[1] >= 5 then
        event.ignore_crit_effect_cooldown = true
        BloodArcana(event)
    end
    if (event.pa2 and qualities and qualities[2] and qualities[2] >= 6) or false then
        local particle = ParticleManager:CreateParticle("particles/econ/items/bristleback/ti7_head_nasal_goo/bristleback_ti7_nasal_goo_debuff.vpcf", PATTACH_POINT_FOLLOW, target)
        ParticleManager:SetParticleControlEnt(particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
        Timers:CreateTimer(1,function()
            if not target or target:IsNull() or not target:HasModifier("modifier_pa_poison") then
                ParticleManager:DestroyParticle(particle,true)
                ParticleManager:ReleaseParticleIndex(particle)
            else
                return 1
            end
        end)
    end
    if (event.moon and qualities and qualities[1] and qualities[1] >= 6) or false then
        local particle = ParticleManager:CreateParticle("particles/econ/items/mirana/mirana_starstorm_bow/mirana_starstorm_starfall_attack.vpcf", PATTACH_POINT_FOLLOW, target)
        ParticleManager:ReleaseParticleIndex(particle)
    end
    if event.moon and ((qualities and qualities[1] and qualities[1] >= 7) or false) then
        local particle = ParticleManager:CreateParticle("particles/invoker_chaos_meteor_fly_blue.vpcf", PATTACH_WORLDORIGIN, target)
        ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin() + Vector(0,0,900))
        ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin() + Vector(0,0,50))
        ParticleManager:SetParticleControl(particle, 2, Vector(0.5,0,0))
        ParticleManager:ReleaseParticleIndex(particle)
    end
    if event.moon4 and ((qualities and qualities[2] and qualities[1] >= 7) or false) then
        local count = 2
        if event.duration and event.duration >= 3.6 then
            count = 3
        end
        local pos = event.target_points[1]
        for i=1,count do
            local time = i*1.8-0.25
            if time < 0 then
                time = 0
            end
            Timers:CreateTimer(time, function()
                local particle = ParticleManager:CreateParticle("particles/invoker_chaos_meteor_fly_fast.vpcf", PATTACH_WORLDORIGIN, caster)
                ParticleManager:SetParticleControl(particle, 0, pos + Vector(0,0,1000))
                ParticleManager:SetParticleControl(particle, 1, pos + Vector(0,0,50))
                ParticleManager:SetParticleControl(particle, 2, Vector(0.25,0,0))
                ParticleManager:ReleaseParticleIndex(particle)
                EmitSoundOn("Hero_Luna.Eclipse.Cast", target)
            end)
        end
    end
    if (event.holy5 and qualities and qualities[2] and qualities[2] >= 6) or false then
        ability:ApplyDataDrivenModifier(caster, target, event.buff, {Duration = event.dur})
        local particle = ParticleManager:CreateParticle("particles/econ/events/ti7/hero_levelup_ti7_godray.vpcf", PATTACH_POINT_FOLLOW, target)
        ParticleManager:ReleaseParticleIndex(particle)
    end
    if (event.stealthfx and qualities and qualities[3] and qualities[3] >= 6) or false then
        local particle = ParticleManager:CreateParticle("particles/econ/items/antimage/antimage_ti7/antimage_blink_start_ti7_pyro.vpcf", PATTACH_POINT_FOLLOW, caster)
        ParticleManager:ReleaseParticleIndex(particle)
        particle = ParticleManager:CreateParticle("particles/econ/items/antimage/antimage_ti7/antimage_blink_start_ti7_ashes.vpcf", PATTACH_POINT_FOLLOW, caster)
        ParticleManager:ReleaseParticleIndex(particle)
    end
    if (event.armosdot2 and qualities and qualities[1] and qualities[1] >= 6) or false then
        ability:ApplyDataDrivenModifier(caster, target, event.buff, {Duration = event.dur})
    end
    if (event.arcane5 and qualities and qualities[3] and qualities[3] >= 7) or false then
        local particle = ParticleManager:CreateParticle("particles/econ/items/elder_titan/elder_titan_ti7/elder_titan_echo_stomp_ti7_magical.vpcf", PATTACH_POINT_FOLLOW, caster)
        ParticleManager:ReleaseParticleIndex(particle)
    end
    if (event.wind5 and qualities and qualities[3] and qualities[3] >= 7) or false then
        local pos = event.target_points[1]
        local particle = ParticleManager:CreateParticle("particles/econ/items/legion/legion_overwhelming_odds_ti7/legion_commander_odds_ti7.vpcf", PATTACH_WORLDORIGIN, caster)
        ParticleManager:SetParticleControl(particle, 0, pos)
        ParticleManager:SetParticleControl(particle, 1, pos+Vector(250,250,0))
        ParticleManager:ReleaseParticleIndex(particle)
    end
    if (event.arms5 and qualities and qualities[1] and qualities[1] >= 7) or false then
        local particle = ParticleManager:CreateParticle("particles/econ/items/legion/legion_overwhelming_odds_ti7/legion_commander_odds_ti7_proj_impact.vpcf", PATTACH_POINT_FOLLOW, caster)
        ParticleManager:ReleaseParticleIndex(particle)
    end
end

function BullRushFX( event )
    local caster = event.caster
    local pos = caster:GetAbsOrigin() + caster:GetForwardVector() * 250
    local particle = ParticleManager:CreateParticle("particles/econ/items/beastmaster/bm_shoulder_ti7/bm_shoulder_ti7_roar.vpcf", PATTACH_POINT_FOLLOW, caster)
    ParticleManager:SetParticleControl(particle, 1, pos)
    ParticleManager:ReleaseParticleIndex(particle)
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
    ParticleManager:ReleaseParticleIndex(particle)
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
        ParticleManager:ReleaseParticleIndex(particle)
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
        ParticleManager:ReleaseParticleIndex(particle)
	end
	target:RemoveModifierByName("modifier_prayer_shield")
end

function HolyLightMissile( event )
    local caster = event.caster
    local target = event.target
    local particle = ParticleManager:CreateParticle("particles/dazzle_holy_wave_b.vpcf", PATTACH_POINT_FOLLOW, caster)
    ParticleManager:SetParticleControl(particle, 0, caster:GetAbsOrigin()+Vector(0,0,75))
    ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin()+Vector(0,0,75))
    ParticleManager:ReleaseParticleIndex(particle)
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
                    table.isaoeheal = event.isaoeheal
					HealUnit(table)
					local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_dazzle/dazzle_shadow_wave_b.vpcf", PATTACH_POINT_FOLLOW, caster)
					ParticleManager:SetParticleControl(particle, 0, caster:GetAbsOrigin()+Vector(0,0,75))
					ParticleManager:SetParticleControl(particle, 1, enemy:GetAbsOrigin()+Vector(0,0,75))
                    ParticleManager:ReleaseParticleIndex(particle)
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
                    ParticleManager:ReleaseParticleIndex(particle)
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
					--PurgeEnemyUnit(event) --removed 6.0.6
					local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_tidehunter/tidehunter_krakenshell_purge_d.vpcf", PATTACH_POINT_FOLLOW, enemy)
                    ParticleManager:ReleaseParticleIndex(particle)
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

	local enemies = FindUnitsInRadius( caster:GetTeamNumber(), target:GetAbsOrigin(), caster, range, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, 0, 0, false )
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

function HealingWaveJump(event, target, from_target, target_list)
    --charges left?
    local caster = event.caster
    local range = event.jumpdistance
    if not event.chainhealtargets or event.chainhealtargets <= 0 or not target then
        return
    end
    event.chainhealtargets = event.chainhealtargets - 1
    --heal
    HealUnit(event)
    local particle = ParticleManager:CreateParticle("particles/dazzle_shadow_wave_green.vpcf", PATTACH_POINT_FOLLOW, from_target)
    ParticleManager:SetParticleControlEnt(particle, 0, from_target, PATTACH_POINT_FOLLOW, "attach_hitloc", from_target:GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
    ParticleManager:ReleaseParticleIndex(particle)
    table.insert(target_list, target)
    --find next target
    local friends = FindUnitsInRadius( caster:GetTeamNumber(), target:GetAbsOrigin(), caster, range, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, 0, 0, false )
    local hp = 1.2
    local friend = nil
    if #friends > 0 then
        for _,enemy in pairs(friends) do
            if enemy ~= nil then
                for i=1, #target_list do
                    if ((enemy:GetUnitLabel()=="hero") or (enemy:GetUnitLabel()=="pet")) and (enemy ~= target_list[i] or (event.can_hit_same_target_again and event.can_hit_same_target_again == 1) ) then
                        local hp2 = enemy:GetHealth()/enemy:GetMaxHealth()
                        if hp2 < hp then
                            friend = enemy
                            hp = hp2
                        end
                    end
                end
            end
        end
    end
    --reduce healing for next jump and heal
    Timers:CreateTimer(0.4, function()
        event.attributefactor = event.attributefactor*event.healreduction/100
        event.spelldamagefactor = event.spelldamagefactor*event.healreduction/100
        event.heal = event.heal * event.healreduction/100
        event.target = friend
        HealingWaveJump(event, friend, target, target_list)
    end)
end

function HealingWave(event)
	local caster = event.caster
	local target = event.target
    local target_list = {}
    if caster:HasModifier("modifier_npc_dota_hero_witch_doctor") then
        event.can_hit_same_target_again = 1
        event.chainhealtargets = event.chainhealtargets + 1
    end
    HealingWaveJump(event, target, caster, target_list)
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
    ParticleManager:ReleaseParticleIndex(particle)

	particle = ParticleManager:CreateParticle("particles/econ/items/lina/lina_head_headflame/lina_spell_dragon_slave_headflame_d.vpcf", PATTACH_ABSORIGIN, caster)
	ParticleManager:SetParticleControl(particle, 0, vec2)
	ParticleManager:SetParticleControl(particle, 3, vec2)
	ParticleManager:SetParticleControlForward(particle, 0, vec)
    ParticleManager:ReleaseParticleIndex(particle)
end

function ItemCourage( event )
	local caster = event.caster
	event.target = caster
	PayWithLife(event)
	local particle = ParticleManager:CreateParticle("particles/items_fx/bloodstone_glyph.vpcf", PATTACH_ABSORIGIN, caster)
	ParticleManager:SetParticleControl(particle, 0, caster:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 1, Vector(3,0,0))
    ParticleManager:ReleaseParticleIndex(particle)
	Timers:CreateTimer(3.0, function()
	    HealPercentage(event)
	    particle = ParticleManager:CreateParticle("particles/items_fx/bloodstone_heal.vpcf", PATTACH_ABSORIGIN, caster)
	    particle = ParticleManager:CreateParticle("particles/items_fx/etherial_copycat_trail.vpcf", PATTACH_ABSORIGIN, caster)
	    ParticleManager:SetParticleControl(particle, 1, caster:GetAbsOrigin())
        ParticleManager:ReleaseParticleIndex(particle)
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
    if event.spselfbuff then
        event.target = caster
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
	local range = event.range

	local enemies = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetAbsOrigin(), caster, range, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	if #enemies > 0 then
		for _,enemy in pairs(enemies) do
			if enemy ~= nil then
				if enemy:GetUnitLabel()=="hero" then
                    if ability:GetLevel() >= 4 then
                        ability:ApplyDataDrivenModifier(caster, enemy, "modifier_judgement_armor", {Duration = 8})
                    end
					local table = {}
					table.caster = caster
					table.target = enemy
					table.ability = ability
					table.attributefactor = event.attributefactor
					table.spelldamagefactor = event.spelldamagefactor
					table.heal = 0
					table.critmanareg = event.critmanareg
                    table.isaoeheal = event.isaoeheal
					HealUnit(table)
					local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_omniknight/omniknight_purification_light_b.vpcf", PATTACH_POINT_FOLLOW, enemy)
                    ParticleManager:ReleaseParticleIndex(particle)
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
	--local boo2 = caster:HasModifier("modifier_item_allstats2up")
	if boo then
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

function GlobalOnAbilityExecuted( event )
    local caster = event.caster
    local target = event.target
    local ability = event.event_ability
    if caster and caster.talents and ability and not ability:IsItem() then
        local chance = 10
        if event.event_ability and event.event_ability.is_casttime_ability then
            chance = 20
        end
        if caster.talents[29] and caster.talents[29] > 0 and target and caster ~= target and target:GetTeamNumber() ~= caster:GetTeamNumber() and math.random(1,100) <= chance then
            local duration = 0.4
            if caster:HasModifier("modifier_pathbuff_029") then
                duration = duration * 3
            end
            caster.combat_system_ability:ApplyDataDrivenModifier(caster, target, "modifier_cast_firenova", {Duration = duration})
        end
        if (caster.talents[56] and caster.talents[56] > 0 and not event.is_end_of_channel and caster.combat_system_ability) then
            --if ability and ability.is_casttime_ability then
                local max = 8
                ApplyBuffStack({ caster = caster, target = caster, buff = "modifier_lizard_wizard", ability = caster.combat_system_ability, max = max, dur = -1})
                if caster:GetModifierStackCount("modifier_lizard_wizard", nil) >= max then
                    caster:RemoveModifierByName("modifier_lizard_wizard")
                    if not target then
                        --fire aoe
                        for i=1,3 do
                            Timers:CreateTimer(0.3*i, function()
                                local dmgevent = {caster = caster, ability = caster.combat_system_ability, damage = 0, attributechangeint, firedmg = 1, stun = 1.5, attributefactor = 300*caster.talents[56], spelldamagefactor = 300*caster.talents[56], aoe = 900, targeteffect = "fire", isaoe = 1, dontbreakcc = 1 }
                                EmitSoundOn("Ability.LightStrikeArray", caster)
                                local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_lina/lina_spell_light_strike_array.vpcf", PATTACH_POINT_FOLLOW, caster)
                                ParticleManager:SetParticleControl(particle, 1, Vector(900,1,1))
                                ParticleManager:ReleaseParticleIndex(particle)
                                DamageAOE(dmgevent)
                            end)
                        end
                    end
                    if target then
                        if target:GetTeamNumber() == caster:GetTeamNumber() then
                            --heal
                            for i=1,5 do
                                Timers:CreateTimer(0.3*i, function()
                                    local dmgevent = {caster = caster, target = target, ability = caster.combat_system_ability, heal = 0, percenthp = 3*caster.talents[56] }
                                    EmitSoundOn("DOTA_Item.HealingSalve.Activate", target)
                                    HealUnit(dmgevent)
                                    local particle = ParticleManager:CreateParticle("particles/dazzle_shadow_wave_green.vpcf", PATTACH_POINT_FOLLOW, caster)
                                    ParticleManager:SetParticleControlEnt(particle, 0, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), true)
                                    ParticleManager:SetParticleControlEnt(particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
                                    ParticleManager:ReleaseParticleIndex(particle)
                                end)
                            end
                        else
                            --dmg
                            for i=1,5 do
                                Timers:CreateTimer(0.15*i, function()
                                    local dmgevent = {caster = caster, target = target, ability = caster.combat_system_ability, attributechangeint = 1, damage = 0, naturedmg = 1, attributefactor = 200*caster.talents[56], spelldamagefactor = 200*caster.talents[56] }
                                    EmitSoundOn("Item.Maelstrom.Chain_Lightning.Jump", target)
                                    DamageUnit(dmgevent)
                                    --local particle = ParticleManager:CreateParticle("particles/items_fx/chain_lightning.vpcf", PATTACH_POINT_FOLLOW, caster)
                                    --ParticleManager:SetParticleControlEnt(particle, 0, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), true)
                                    --ParticleManager:SetParticleControlEnt(particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
                                    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_zeus/zeus_cloud_strike.vpcf", PATTACH_WORLDORIGIN, target)
                                    ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin() + Vector(0,0,75))
                                    ParticleManager:SetParticleControl(particle, 1, caster:GetAbsOrigin() + Vector(0,0,75))
                                    ParticleManager:SetParticleControl(particle, 6, Vector(1,1,1))
                                    ParticleManager:ReleaseParticleIndex(particle)
                                end)
                            end
                        end
                    end
                end
            --end
        end
    end
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

    --big cooldown procs
    if cd >= 20 then
        if caster.talents then
            if caster.talents[81] and caster.talents[81] > 0 and caster.combat_system_ability then
                caster.combat_system_ability:ApplyDataDrivenModifier(caster, caster, "modifier_skyfall", {duration = 7})
                caster:SetModifierStackCount("modifier_skyfall", caster.combat_system_ability, caster.talents[81] * 400)
            end
        end
    end
    if cd >= 30 and caster.talents and caster.talents[55] and caster.talents[55] > 0 and (not ability:IsItem()) and (not caster.ice_storm_cd) then
        local combat_ability = caster.combat_system_ability
        local target = FindClosestEnemy({caster = caster, radius = 750})
        if combat_ability and target then
        	local bolts = 5
        	caster.ice_storm_cd = true
            for i=1, bolts do
                Timers:CreateTimer(0.4*i, function()
                	if i == bolts then
                		caster.ice_storm_cd = false
                	end
                    local projectile = "particles/units/heroes/hero_lich/lich_chain_frost.vpcf"
                    if caster:HasModifier("modifier_pathbuff_036") then
                        projectile = "particles/lich_chain_frostfire.vpcf"
                    end
                    EmitSoundOn("hero_Crystal.preAttack", caster)
                    local info = {
                        Target = target,
                        Source = caster,
                        Ability = combat_ability,
                        EffectName = projectile, --"particles/units/heroes/hero_winter_wyvern/wyvern_splinter.vpcf",
                        bDodgeable = true,
                        bProvidesVision = true,
                        iMoveSpeed = 900,
                        iVisionRadius = 300,
                        iVisionTeamNumber = caster:GetTeamNumber(),
                        iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_HITLOCATION
                    }
                    ProjectileManager:CreateTrackingProjectile( info )
                end)
            end
        end
    end
    if cd >= 45 and caster.talents and caster.talents[59] and caster.talents[59] > 0 and not ability:IsItem() and not caster:HasModifier("modifier_talent_invul_cd") then
        caster.combat_system_ability:ApplyDataDrivenModifier(caster, caster, "modifier_talent_invul", {duration = 1.5 * caster.talents[59]})
        caster.combat_system_ability:ApplyDataDrivenModifier(caster, caster, "modifier_talent_invul_cd", {duration = 1.5 * 2 * caster.talents[59]})
    end
    if cd >= 60 and caster.talents and caster.talents[73] and caster.talents[73] > 0 and not ability:IsItem() then
        caster.combat_system_ability:ApplyDataDrivenModifier(caster, caster, "modifier_path_shadowform", {duration = 8 + 2 * caster.talents[73]})
    end

    --riki talent
    if ability:GetLevel() >= 4 and ability:GetName() == "hawk6" then
        for i=0, 5 do
            local item = caster:GetItemInSlot(i)
            if item then
                if item:GetName() ~= "item_activedk" and item:GetName() ~= "item_activedk2" then
                    item:EndCooldown()
                end
            end
        end
    end
    local astral_talent_shock = caster:FindAbilityByName("moon6")
    if astral_talent_shock and astral_talent_shock:GetLevel() >= 4 and math.random(1,100) <= 15 and ability:GetAbilityIndex() <= 2 then
    	AstralShock(caster)
    end
	--cooldown item
	local hoodoftime = caster:HasModifier("modifier_item_cooldown")
	if hoodoftime then
		factor = 0.85
	end
    if caster:HasModifier("modifier_item_allstats2up") then
        factor = factor * 0.9
    end
    if caster:HasModifier("modifier_special_bonus_cooldown_reduction") then
        factor = factor * 0.95
    end
    if caster:HasModifier("modifier_item_set_int_cdgloves") then
        factor = factor * 0.95
    end
    if caster:HasModifier("modifier_item_set_int_full") then
        factor = factor * 0.95
    end
    if caster:HasModifier("modifier_npc_dota_hero_pugna") and (ability:GetName() == "destro2" or ability:GetName() == "destro6") then
        factor = factor * 0.4
    end
    if caster:HasModifier("modifier_npc_dota_hero_legion_commander") and ability:GetName() == "Retri2" then
        factor = factor * 0.4
        HealUnit({caster = caster, target = caster, heal = 0, percenthp = 10, ability = ability})
    end
    if caster:HasModifier("modifier_npc_dota_hero_ursa") and ability:GetName() == "bear2" then
        factor = factor * 0.5
        HealUnit({caster = caster, target = caster, heal = 0, percenthp = 15, ability = ability})
    end
    if caster:HasModifier("modifier_npc_dota_hero_invoker") and ability:GetName() == "Arcane7" then
        factor = factor * 0.4
        RestoreMana({caster = caster, percent = 1, amount = 25})
    end
    if caster:HasModifier("modifier_item_winterbreeze2") then
        factor = factor * 0.9
    end
    if caster:HasModifier("modifier_item_night_shoulders") and ability == caster:GetAbilityByIndex(5) then
        factor = factor * 0.75
    end
    if caster.talents and caster.talents[28] then
        factor = factor * (1 - 0.05 * caster.talents[28])
    end
    if caster.talents and caster.talents[41] > 0 and ability == caster:GetAbilityByIndex(4) then
        factor = factor * (1 - 0.1 * caster.talents[41])
    end
    if caster.talents and caster.talents[83] > 0 and ability == caster:GetAbilityByIndex(3) then
        factor = factor * (1 - 0.08 * caster.talents[83])
        if caster.combat_system_ability then
            caster.combat_system_ability:ApplyDataDrivenModifier(caster, caster, "modifier_windbreaker", {Duration = 10})
            caster:SetModifierStackCount("modifier_windbreaker", caster.combat_system_ability, caster.talents[83])
        end
    end
    if caster.talents and caster.talents[17] > 0 and ability == caster:GetAbilityByIndex(2) then
        factor = factor * (1 - 0.07 * caster.talents[17])
    end
    --if caster.talents and caster.talents[19] > 0 and ability == caster:GetAbilityByIndex(2) then
    --    factor = factor * (1 - 0.05 * caster.talents[19])
    --end
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
    

	-- hunter proc for reset
    --[[
	local reload = caster:GetModifierStackCount("modifier_lockreload", caster)
	local hunterproc = false
	if reload >= 12 and event.event_ability:GetName() == "wind2" and ability.wasinstant then
		factor = 0.0
		hunterproc = true
        print("awer")
	end
	if reload >= 12 and event.event_ability:GetName() == "wind7" and ability.wasinstant then
		caster:RemoveModifierByName("modifier_lockreload")
	end]]
	local priestcharge = caster:GetModifierStackCount("modifier_light_charge", caster)
	if priestcharge >= 4 and event.event_ability:GetName() == "Light_of_Heaven" and ability.wasinstant then
		caster:RemoveModifierByName("modifier_light_charge")
	end

	-- str aghanim item
	local agha = caster:HasModifier("modifier_item_straxe2")
	if agha and ability:GetName() == "Sword_Storm" then
		factor = factor * 0.8
	end
    local agha2 = caster:HasModifier("modifier_item_straxe3")
    if agha2 and ability:GetName() == "Sword_Storm" then
        factor = factor * 0.7
    end
    local passive_cd_reduce_ability_passive = caster:FindAbilityByName("dh6")
    if passive_cd_reduce_ability_passive and passive_cd_reduce_ability_passive:GetLevel() >= 4 then
    	local current_factor = 1 - factor
        factor = 1 - current_factor * 2
    end
    passive_cd_reduce_ability_passive = caster:FindAbilityByName("Holy_Shield")
    if passive_cd_reduce_ability_passive and passive_cd_reduce_ability_passive:GetLevel() >= 4 then
    	local current_factor = 1 - factor
        factor = 1 - current_factor * 1.5
    end
    
    --if agha2 and ability:GetName() == "Retri2" then
    --    newcd = newcd * 0.6
    --end

	--apply factor
    if factor < 0.34 then
        factor = 0.34
    end

    --ignoring cap here
    --druid moonburn
    local moonburn = caster:HasModifier("modifier_moonburn_cd")
    if moonburn and ability:GetName() == "moon2" then
        factor = factor * 0.25
    end
	newcd = newcd*factor

    --minimum cooldowns
    if ability and ability:GetName() == "Holy_Shield" and newcd < 25 then
        newcd = 25
    end

	if newcd < cd then
		Timers:CreateTimer(0.02, function()
            if ability and not ability:IsNull() then
    			ability:EndCooldown()
    			if newcd > 0.0 then
    				ability:StartCooldown(newcd)
    			end
                --[[
    			if hunterproc then
    				caster:RemoveModifierByName("modifier_lockreload")
    				local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_windrunner/windrunner_loadout_magic.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
                    ParticleManager:ReleaseParticleIndex(particle)
    				EmitSoundOn("windrunner_wind_respawn_08", caster)
    			end]]
            end
		end)
	end
    --save values for statistics
    caster.cooldown_reduction = 1 - factor
    CooldownProcs(caster, ability, cd)
    AbilityComboProcs(caster, ability)
end

function PathCrowFall( event )
    local caster = event.target
    local stacks = caster:GetModifierStackCount(event.buff, nil)
    caster:SetModifierStackCount(event.buff, caster.combat_system_ability, stacks + caster.talents[89])
end

function AbilityComboProcs(caster, ability)
    --all 6 proc
    local titanarmor_proc = caster:HasModifier("modifier_item_titanarmor") or caster:HasModifier("modifier_item_titanarmor_2")
    local crowfall_proc = (caster.talents and caster.talents[89] and caster.talents[89] > 0)
    if titanarmor_proc or crowfall_proc then
        if not caster.ability_combo_6 then
            caster.ability_combo_6 = {}
        end
        local index = ability:GetAbilityIndex()
        caster.ability_combo_6[index] = true
        if caster.ability_combo_6[1] and caster.ability_combo_6[2] and caster.ability_combo_6[3] and caster.ability_combo_6[4] and caster.ability_combo_6[5] and caster.ability_combo_6[0] then
            for i=0,5 do
                caster.ability_combo_6[i] = nil
            end
            --proc
            if not caster.ability_combo_6_bonus then
                caster.ability_combo_6_bonus = 1
            else
                caster.ability_combo_6_bonus = caster.ability_combo_6_bonus + 1
            end
            if caster.ability_combo_6_bonus == 1 and titanarmor_proc then
                local particle = ParticleManager:CreateParticle("particles/econ/items/lifestealer/lifestealer_immortal_backbone_gold/lifestealer_immortal_backbone_gold_rage.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
                caster.ability_combo_6_fx = particle
            end
            if crowfall_proc and caster.combat_system_ability then
                caster:RemoveModifierByName("modifier_crowfall")
                caster.combat_system_ability:ApplyDataDrivenModifier(caster, caster, "modifier_crowfall", {Duration = 15})
                caster:SetModifierStackCount("modifier_crowfall", caster.combat_system_ability, caster.talents[89])
            end
            Timers:CreateTimer(20,function()
                caster.ability_combo_6_bonus = caster.ability_combo_6_bonus - 1
                if caster.ability_combo_6_bonus == 0 then
                    caster.ability_combo_6_bonus = nil
                    ParticleManager:DestroyParticle(caster.ability_combo_6_fx,true)
                    ParticleManager:ReleaseParticleIndex(caster.ability_combo_6_fx)
                end
            end)
        end
    end
    --first 4 proc
    local blooodlust_item = caster:HasModifier("modifier_item_bloodlust") or caster:HasModifier("modifier_item_bloodlust_2")
    local armor_knowledge_item = caster:HasModifier("modifier_pathbuff_034")
    if blooodlust_item or armor_knowledge_item then
        if not caster.ability_combo_4 then
            caster.ability_combo_4 = {}
        end
        local index = ability:GetAbilityIndex()
        caster.ability_combo_4[index] = true
        if caster.ability_combo_4[1] and caster.ability_combo_4[2] and caster.ability_combo_4[3] and caster.ability_combo_4[0] then
            for i=0,3 do
                caster.ability_combo_4[i] = nil
            end
            --proc
            if blooodlust_item and caster.item_bloodlust_ability then
                local buff = "modifier_item_bloodlust_proc"
                if caster:HasModifier("modifier_item_bloodlust_2") then
                    buff = "modifier_item_bloodlust_proc_2"
                end
                caster.item_bloodlust_ability:ApplyDataDrivenModifier(caster, caster, buff, {Duration = 12})
            end
            if armor_knowledge_item and caster.item_armor_knowledge_ability then
                local buff = "modifier_item_spellpower_knowledge"
                caster.item_armor_knowledge_ability:ApplyDataDrivenModifier(caster, caster, buff, {Duration = 10})
            end
        end
    end
    local horror_item = caster:HasModifier("modifier_ancient_def")
    if horror_item then
        if not caster.ability_combo_4_5_6 then
            caster.ability_combo_4_5_6 = {}
        end
        local index = ability:GetAbilityIndex()
        caster.ability_combo_4_5_6[index] = true
        if caster.ability_combo_4_5_6[3] and caster.ability_combo_4_5_6[4] and caster.ability_combo_4_5_6[5] then
            for i=3,5 do
                caster.ability_combo_4_5_6[i] = nil
            end
            --proc
            if caster.item_horror_ability then
                local buff = "modifier_horror_proc"
                caster.item_horror_ability:ApplyDataDrivenModifier(caster, caster, buff, {Duration = 8})
            end
        end
    end
end

function CooldownProcs( caster, ability, cd )
    if cd and cd >= 20 and ability and ability:GetAbilityIndex() == 5 and (caster:HasModifier("modifier_item_cd_65") or caster:HasModifier("modifier_item_cd_65_2")) then
        local abil_5 = caster:GetAbilityByIndex(4)
        if abil_5 then
            local particle = ParticleManager:CreateParticle("particles/econ/events/ti7/blink_dagger_start_ti7_lvl2.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
            ParticleManager:ReleaseParticleIndex(particle)
            abil_5:EndCooldown()
        end
    end
    if cd and cd >= 20 and ability and ability:GetAbilityIndex() == 4 and (caster:HasModifier("modifier_item_cd_54") or caster:HasModifier("modifier_item_cd_54_2")) then
        local abil_4 = caster:GetAbilityByIndex(3)
        if abil_4 then
            local particle = ParticleManager:CreateParticle("particles/econ/events/ti7/blink_dagger_start_ti7_lvl2.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
            ParticleManager:ReleaseParticleIndex(particle)
            abil_4:EndCooldown()
        end
    end
    if cd and cd >= 20 and ability and ability:GetAbilityIndex() == 3 and (caster:HasModifier("modifier_item_cd_43") or caster:HasModifier("modifier_item_cd_43_2")) then
        local abil_3 = caster:GetAbilityByIndex(2)
        if abil_3 then
            local particle = ParticleManager:CreateParticle("particles/econ/events/ti7/blink_dagger_start_ti7_lvl2.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
            ParticleManager:ReleaseParticleIndex(particle)
            abil_3:EndCooldown()
        end
    end
end

function PathIceStorm( event )
    local caster = event.caster
    if caster.talents and caster.talents[55] then
        EmitSoundOn("Ability.GushCast", event.target)
        if caster:HasModifier("modifier_pathbuff_036") then
            event.firedmg = 1
            event.iceflame_bolt = true
        end
        event.attributefactor = event.attributefactor * caster.talents[55]
        --event.includeauto = event.includeauto * caster.talents[55]
        event.spelldamagefactor = event.spelldamagefactor * caster.talents[55]
        DamageUnit(event)
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
                ParticleManager:ReleaseParticleIndex(particle)
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
 		--dur = dur + 1.5
	else
		if caster.owner ~= nil and caster.owner:HasModifier("modifier_item_stunitem") then
 			--dur = dur + 1.5
 		end
	end
    if caster:HasModifier("modifier_item_stunitem2") then
        --dur = event.dur + 2
        local myevent = {}
        myevent.caster = caster
        myevent.percenthp = 15
        myevent.heal = 0.0
        HealUnit(myevent)
        particle = ParticleManager:CreateParticle("particles/econ/items/omniknight/hammer_ti6_immortal/omniknight_purification_immortal_cast.vpcf", PATTACH_POINT_FOLLOW, caster)
        ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin())
        ParticleManager:ReleaseParticleIndex(particle)
    else
        if caster.owner ~= nil and caster.owner:HasModifier("modifier_item_stunitem2") then
            --dur = event.dur + 2
            local myevent = {}
            myevent.caster = caster
            myevent.percenthp = 45
            myevent.heal = 0.0
            HealUnit(myevent)
            particle = ParticleManager:CreateParticle("particles/econ/items/omniknight/hammer_ti6_immortal/omniknight_purification_immortal_cast.vpcf", PATTACH_POINT_FOLLOW, caster)
            ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin())
            ParticleManager:ReleaseParticleIndex(particle)
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
    
    if caster == nil then
        return
    end
	if ability == nil then
		ability = caster:GetAbilityByIndex(0)
	end
	if ability == nil then
		return
	end
    if not caster:IsAlive() then
    	if not event.whiledead then
        	return
        end
        if caster:IsNull() then
        	return
        end
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
    if event.ontakedamagetarget then
        target = event.attacker
    end
	if target == nil then
		target = caster
	end
    if event.requires_and_starts_cooldown then
        if ability:GetCooldownTimeRemaining() > 0 then
            return
        else
            ability:StartCooldown(event.requires_and_starts_cooldown)
        end
    end

    if event.buffstackthresholdbased then
        local max = event.buffstackthresholdbased
        local bonusfactor = target:GetModifierStackCount(event.stackbasedbuff, nil) / max
        if bonusfactor < 1.0 then
            return
        else
            target:RemoveModifierByName("modifier_moon_curse")
        end
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

    if not isBuff and not event.is_already_aoe_buff and (buff == "modifier_cyclone_self" or buff == "modifier_rootsdruid") and caster:HasModifier("modifier_npc_dota_hero_furion") then
        event.dur = event.dur * 1.1
        event.aoe = 300
        event.targetpos = 1
        ApplyBuffAOE(event)
        return
    end


	--adjust time of buff
	if duration and event.cursebladespecial and caster:HasModifier("modifier_item_curseblade") and not isBuff then
    	duration = duration * GetCCPower(event)
	end
	if duration and target:HasModifier("modifier_item_bootshp2") and not isBuff then
    	duration = duration * 0.75
	end
    --debuff durations
    if duration and not isBuff then
        if caster:HasModifier("modifier_item_bootscurse") or caster:HasModifier("modifier_item_bootscurse_2") then
            duration = duration * 1.15
        end
        if caster:HasModifier("modifier_item_ancient_dot") then
            duration = duration * 1.25
        end
        if target:HasModifier("modifier_fanatic_rage") then
            duration = duration * 2
        end
    end
    if duration and not isBuff and caster.talents and caster.talents[6] then
        duration = duration * (1 + caster.talents[6]*0.07)
    end
    if caster.talents and caster.talents[71] and caster.talents[71] > 0 and duration and not isBuff then
        duration = duration * (1 + 0.05 * caster.talents[71])
    end
    --extra buff dur talent
    if duration and isBuff and caster.talents and caster.talents[6] and (buff == "modifier_resto" or buff == "modifier_prayerprotection" or buff == "modifier_pain_supression" or buff == "modifier_hot3" or buff == "modifier_eternallife" or buff == "modifier_regrowth" or buff == "modifier_bloodlust_ele") then
        local extra_dur = 0
        if caster:HasModifier("modifier_ancient_allstats") then
            extra_dur = extra_dur + 2
        end
        duration = duration * (1 + (extra_dur + caster.talents[6])*0.05)
    end

	--debuff imunity
	if not isBuff and target:HasModifier("modifier_buff_imune") then
		EmitSoundOn("Item.CrimsonGuard.Cast", target)
		local particle = ParticleManager:CreateParticle("particles/items3_fx/lotus_orb_reflect.vpcf", PATTACH_POINT_FOLLOW, target)
        ParticleManager:ReleaseParticleIndex(particle)
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
        --return
		target = caster
	end

    if target:GetUnitName() == "temple_water_boss_4" and (buff == "modifier_worm_skinpoison1" or buff == "modifier_worm_skinpoison2" or buff == "modifier_worm_skinpoison3") then
        return
    end

	if buff == "modifier_stunned" or buff == "modifier_deepfreeze" then
        --stun bonus durations
        if duration then
            if caster:HasModifier("modifier_item_stunitem") then
                duration = duration * 1.2
            end
            if caster:HasModifier("modifier_item_stunitem2") then
                duration = duration * 1.2
            end
        end
		--ParticleManager:CreateParticleForPlayer("particles/screen_blood_3.vpcf", PATTACH_POINT_FOLLOW, target, target:GetOwner())
		--ParticleManager:CreateParticleForPlayer("particles/econ/events/killbanners/screen_killbanner_compendium14_firstblood_drips.vpcf", PATTACH_POINT_FOLLOW, caster, caster:GetOwner())
		--ParticleManager:CreateParticleForPlayer("particles/econ/events/killbanners/screen_killbanner_compendium14_firstblood_drips.vpcf", PATTACH_POINT_FOLLOW, target, target:GetOwner())

		--prot talent
		local stuntalent = caster:FindAbilityByName("Switch_Battle_Stance_Prot")
        if not stuntalent then
            stuntalent = caster:FindAbilityByName("temple_brawler_defstance")
        end
	    if stuntalent and stuntalent:GetLevel() >= 4 then
	    	if duration then
				duration = duration * 1.25
                local myevent = {}
                myevent.caster = caster
                myevent.percenthp = 5
                myevent.heal = 0.0
                myevent.ability = ability
                HealUnit(myevent)
                myevent = {}
                myevent.caster = caster
                myevent.target = target
                myevent.ability = ability
                myevent.counterblow = 25
                --myevent.cannotcrit = true
                DamageUnit(myevent)
			end
	    end
        if caster.talents and caster.talents[71] and caster.talents[71] > 0 then
            local buff = "modifier_path_overwhelm"
            local ow_ability = caster.combat_system_ability
            if ow_ability then
                ow_ability:ApplyDataDrivenModifier(caster, caster, buff, {Duration = 10})
            end
        end
	end
	--pve debuff downscaling on bosses for hard CC, non breakable (stun, silence, fear)
    if duration and not isBuff and IsHardCC(buff) and target:HasModifier("modifier_pvebosssystem") then
        if not target.isboss and not target.is_champion then
            --regular
            duration = duration * 1.5
        elseif target.isboss then
            duration = duration * 0.3 --0.5
    	end
    end

    if event.bearpvedontroot then
        buff = "modifier_bear_slow_pve"
    end

	--if buff == "modifier_sap2" then
	--	ParticleManager:CreateParticleForPlayer("particles/screen_blind_1.vpcf", PATTACH_POINT_FOLLOW, target, target:GetOwner())
	--end

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
	Timers:CreateTimer(2.5, function()
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

function FrostwyrmAttack( event )
    local caster = event.caster
    local frostwyrm = caster.frostwyrm
    if frostwyrm and not frostwyrm:IsNull() and frostwyrm:IsAlive() and math.random(1,100) <= 50 and caster.armydeadtarget and not caster.armydeadtarget:IsNull() and caster:HasModifier("modifier_npc_dota_hero_sven") then
        frostwyrm:PerformAttack(caster.armydeadtarget, true, true, true, true, true, false, false)
    end
end

function ArmyDead(event)
	local caster = event.caster
	local target = event.target
    caster.frostwyrm = target
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
	local dmg = caster:GetAttackDamage() * event.basedamage / 100
    if event.strength then
        dmg = 0
    end
	local health = caster:GetMaxHealth() * 0.05

	--target:SetBaseDamageMin(dmg)
	--target:SetBaseDamageMax(dmg)
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

	local armor = 4 --math.floor(target:GetPhysicalArmorValue()*0.25) + 3
	--ability:ApplyDataDrivenModifier(caster, target, "modifier_armoriron", nil)
    if armor < 1 then
        return
    end
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
    if caster.talents and caster.talents[43] then
        armor = armor + caster.talents[43] * 1
    end
    if armor <= 0 then
        return
    end
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
        ParticleManager:ReleaseParticleIndex(particle)
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
		caster.DancingRune = target
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
    Timers:CreateTimer(0.1, function()
	   ExecuteOrderFromTable(order)
    end)
end

function DancingRuneAADamage( event )
    local caster = event.caster
    local target = event.target
    local damage_table = {}
    damage_table.victim = target
    damage_table.attacker = caster
    damage_table.ability = event.ability
    damage_table.damage_type = 1
    damage_table.damage = event.dmg * 0.5
    Timers:CreateTimer(0.25, function()
        ApplyDamage(damage_table)
        DancingRuneDamageFX(caster, target)
    end)
end

function DancingRuneDamageFX(caster, target)	
	if caster and caster.DancingRune and target and not target:IsNull() then
		caster = caster.DancingRune
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_ogre_magi/ogre_magi_bloodlust_buff_circle.vpcf", PATTACH_POINT_FOLLOW, caster)
        particle = ParticleManager:CreateParticle("particles/units/heroes/hero_centaur/centaur_double_edge_tgt_rope.vpcf", PATTACH_POINT_FOLLOW, caster)
        ParticleManager:SetParticleControl(particle, 4, target:GetAbsOrigin()+Vector(0,0,75))
        ParticleManager:SetParticleControl(particle, 5, caster:GetAbsOrigin()+Vector(0,0,75))
        ParticleManager:ReleaseParticleIndex(particle)
	end
end

function HitFX( caster, target )
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_centaur/centaur_double_edge_tgt_rope.vpcf", PATTACH_POINT_FOLLOW, caster)
    ParticleManager:SetParticleControl(particle, 4, target:GetAbsOrigin()+Vector(0,0,75))
    ParticleManager:SetParticleControl(particle, 5, caster:GetAbsOrigin()+Vector(0,0,75))
    ParticleManager:ReleaseParticleIndex(particle)
end

function BloodHitFX(event)
	local caster = event.caster
	local target = event.unit
    if not target then
        target = event.target
    end
    if not caster or caster:IsNull() then
        return
    end
    if not target or target:IsNull() then
        return
    end
	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_centaur/centaur_double_edge_bloodspray_src.vpcf", PATTACH_POINT_FOLLOW, caster)
	ParticleManager:SetParticleControl(particle, 4, target:GetAbsOrigin()+Vector(0,0,75))
	ParticleManager:SetParticleControl(particle, 5, caster:GetAbsOrigin()+Vector(0,0,75))
    ParticleManager:ReleaseParticleIndex(particle)
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
	if heroName == "npc_dota_hero_drow_ranger" then
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
    local buff = "modifier_innercd_ashbringer"
    local count = 1
    if event.version then
        buff = buff..tostring(event.version)
        if event.version == 4 then
            count = 3
        end
    end
	if caster:HasModifier(buff) or dist >= 2500 or caster:HasModifier("modifier_invisible") then
 		return
	end
	local ability = event.ability
    for i=1, count do
        Timers:CreateTimer(0.05+i*0.3, function()
	       ability:ApplyDataDrivenModifier(caster, target, "modifier_item_fireball_proc", nil)
        end)
    end
    if caster:HasModifier("modifier_active6_self") and math.random(1,100) <= 20 then
        Timers:CreateTimer(0.25, function()
            ability:ApplyDataDrivenModifier(caster, target, "modifier_item_fireball_proc", nil)
        end)
    end
	Timers:CreateTimer(0.05, function()
	    ability:ApplyDataDrivenModifier(caster, caster, buff, nil)
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
    ParticleManager:ReleaseParticleIndex(particle)
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

function FindClosestEnemy( event )
    local caster = event.caster
    local pos = caster:GetAbsOrigin()
    local radius = event.radius
    local enemies = FindUnitsInRadius( caster:GetTeamNumber(), pos, caster, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
    local distance = radius
    local closesttarget = nil
    if #enemies > 0 then
        for _,enemy in pairs(enemies) do
            if enemy and not enemy:IsNull() and enemy:IsAlive() and (enemy:HasModifier("modifier_pvebosssystem") or enemy:HasModifier("dummy_unit_tutorial")) then
                local tempdistance = (enemy:GetAbsOrigin()-pos):Length()
                if tempdistance < distance then
                    closesttarget = enemy
                    distance = tempdistance
                end
            end
        end
    end
    return closesttarget
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
        ParticleManager:ReleaseParticleIndex(particle)

		local particle2 = ParticleManager:CreateParticle("particles/rattletrap_hookshot_self.vpcf", PATTACH_POINT_FOLLOW, target)
		ParticleManager:SetParticleControlEnt(particle2, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin()+Vector(0,0,50), true)
		ParticleManager:SetParticleControlEnt(particle2, 1, closesttarget, PATTACH_POINT_FOLLOW, "attach_hitloc", closesttarget:GetAbsOrigin()+Vector(0,0,50), true)
		ParticleManager:SetParticleControl(particle2, 2, Vector(500,0,0))
		ParticleManager:SetParticleControl(particle2, 3, Vector(event.dur,0,0))
        ParticleManager:ReleaseParticleIndex(particle2)

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
            ParticleManager:ReleaseParticleIndex(particle)
			particle = ParticleManager:CreateParticle("particles/econ/items/crystal_maiden/crystal_maiden_cowl_of_ice/maiden_crystal_nova_i_cowlofice.vpcf", PATTACH_POINT_FOLLOW, target2)
			ParticleManager:SetParticleControlEnt(particle, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target2:GetAbsOrigin(), true)
            ParticleManager:ReleaseParticleIndex(particle)

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
		ParticleManager:ReleaseParticleIndex(particle)
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
        ParticleManager:ReleaseParticleIndex(particle)
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
        ParticleManager:ReleaseParticleIndex(particle)
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
        ParticleManager:ReleaseParticleIndex(particle)
	end
end

function MageGloves2( event )
	local caster = event.caster
	local heroName = event.caster:GetUnitName()
	if heroName == "npc_dota_hero_lina" or heroName == "npc_dota_hero_crystal_maiden" or heroName == "npc_dota_hero_invoker" or COverthrowGameMode.junglemode then
		event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_evocation", nil)
		local particle = ParticleManager:CreateParticle("particles/econ/items/abaddon/abaddon_alliance/abaddon_death_coil_explosion_alliance_sparks.vpcf", PATTACH_POINT_FOLLOW, caster)
		ParticleManager:SetParticleControl(particle, 3, caster:GetAbsOrigin())
        ParticleManager:ReleaseParticleIndex(particle)
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
    local roll = math.random(1,100)
    if event.chance_to_reduce_cd and roll <= (100 - event.chance_to_reduce_cd) then
        return
    end
	if caster ~= nil then
		local ability = event.ability
        if event.chooseability then
            ability = caster:GetAbilityByIndex(event.chooseability)
        end
        if event.chooseabilityname then
            ability = caster:FindAbilityByName(event.chooseabilityname)
        end
		if ability ~= nil then
            if event.onself and event.caster ~= event.target then
                return
            end
 			local cd = ability:GetCooldownTimeRemaining()
 			if cd > 0.1 then
                if not event.delaycdreduce then
                    Timers:CreateTimer(0.1, function()
 				       ability:EndCooldown()
 				       ability:StartCooldown(cd - event.amount)
                    end)
                else
                    Timers:CreateTimer(event.delaycdreduce, function()
                        cd = ability:GetCooldownTimeRemaining()
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
		if stackcount > 25 then
			stackcount = 25
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
	local ability = target.combat_system_ability
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
    local stackcount = target:GetModifierStackCount("modifier_talent_crit", nil) * 2
    if math.random(1,100) <= stackcount then
        ability:ApplyDataDrivenModifier(target, target, "crit7", nil)
    end
end

function Sharpeye( event )
	local target = event.attacker
	local ability = event.ability
	if target:HasModifier("modifier_item_sharpeye_buff") then
		local stackcount = target:GetModifierStackCount("modifier_item_sharpeye_buff", target)+1
		if stackcount > 50 then
			stackcount = 50
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
    if event.changecastertotarget then
        caster = target
    end
	if target == nil then
		return 0
	end
	if caster == nil then
		return 0
	end
	if not caster:IsAlive() then
    	if not event.whiledead then
        	return
        end
        if caster:IsNull() then
        	return
        end
    end
    
	if event.addstacks then
		amount = event.addstacks
	end
    if event.classitemaddstackfactor and caster:HasModifier(event.classitemstackfactorbuff) then
        amount = amount * event.classitemaddstackfactor
    end
	if event.resetplague then
		target:RemoveModifierByName("modifier_slowstack10")
	end
    if event.only_when_damaged and target:GetHealth() / target:GetMaxHealth() >= 1.0 then
        return 0
    end
	local buff = event.buff
	local max = event.max
    if event.classitemmaxstackfactor and caster:HasModifier(event.classitemstackfactorbuff) then
        max = max * event.classitemmaxstackfactor
    end
	local ability = event.ability
	if event.threshold and target:GetModifierStackCount(buff, nil) >= event.threshold then
		return
	end
	if target:HasModifier(buff) then
		local stackcount = target:GetModifierStackCount(buff, nil)+amount
        if event.setstacks then
            stackcount = event.setstacks
        end
		if max and stackcount > max then
			stackcount = max
		end
        if stackcount < 0 then
            stackcount = 0
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
        amount = stackcount
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
    if event.grow_based_on_stacks then
        local base_scale = 1 --caster:GetModelScale() / ((amount-1) * event.grow_based_on_stacks + 1)
        local factor = 1 + amount * event.grow_based_on_stacks
        if factor > 1.9 then
            factor = 1.9
        end
        caster:SetModelScale(base_scale * factor)
    end
    return amount
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
        event.dur = 20
        event.target = caster
        event.max = 10
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
        event.dur = 8
        event.target = caster
        event.max = 12
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
    if event.only_when_damaged and target:GetHealth() / target:GetMaxHealth() >= 1.0 then
        return
    end
	local buff = event.buff
	local ability = event.ability
    local stackcount = target:GetModifierStackCount(buff, nil)
    local new_stackcount = stackcount-amount
	if target:HasModifier(buff) then
		if stackcount > 1 then
			target:SetModifierStackCount(buff, ability, new_stackcount)
		else
			target:RemoveModifierByName(buff)
		end
	end
    if event.grow_based_on_stacks then
        local base_scale = 1 --caster:GetModelScale() / ((amount-1) * event.grow_based_on_stacks + 1)
        local factor = 1 + stackcount * event.grow_based_on_stacks
        if factor > 1.9 then
            factor = 1.9
        end
        caster:SetModelScale(base_scale * factor)
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
    ParticleManager:ReleaseParticleIndex(particle)
end

function ChampionUnholy(event)
	local caster = event.attacker.owner
	if caster and caster.championunholy then
		--local ability = caster:GetAbilityByIndex(1)
		--ability:EndCooldown()
        local amount = 25
        if event.amount then
            amount = event.amount
        end
		local myevent = {}
        myevent.caster = caster
        myevent.energy = amount * caster.championunholy
        AddEnergy(myevent)
	end
end

function MasterEnergyRestore(event)
    local caster = event.attacker.owner
    if caster then
        local amount = event.amount
        local myevent = {}
        myevent.caster = caster
        myevent.energy = amount
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
		unit:SetBaseDamageMin(math.floor(bonus*event.caster:GetAttackDamage()*event.setaa/100.0))
		unit:SetBaseDamageMax(math.floor(bonus*event.caster:GetAttackDamage()*event.setaa/100.0))
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
		dmg2 = math.floor((GetIntellectCustom(event.caster)*event.setaa_int/100))
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
        local dmg = caster:GetAttackDamage() * event.setghostdmg / 100
        if caster:HasModifier("modifier_item_beastmaster") then
            dmg = dmg + GetStrengthCustom(event.caster) * 0.1
        end
        if caster:HasModifier("modifier_item_beastmaster2") then
            dmg = dmg + GetStrengthCustom(event.caster) * 10
            unit:SetModelScale(0.45)
        end
        unit:SetBaseDamageMin(math.floor(dmg))
        unit:SetBaseDamageMax(math.floor(dmg))
        local tab = {}
        tab.Duration = 60.0
        event.ability:ApplyDataDrivenModifier(caster, unit, "modifier_phased", tab)
    end

    if caster and caster.talents and caster.talents[69] and caster.talents[69] > 0 and not unit.path_heal_on_summon_done then
        local myevent = {caster = caster, target = caster, heal = caster:GetMaxHealth() * 0.03 * caster.talents[69], ability = event.ability}
        HealUnit(myevent)
        unit.path_heal_on_summon_done = true
        --local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_vengeful/vengeful_wave_of_terror_recipient.vpcf", PATTACH_POINT_FOLLOW, caster)
        --ParticleManager:ReleaseParticleIndex(particle)
        if caster.path_demonic_pact then
            caster.path_demonic_pact = caster.path_demonic_pact + 1
        else
            caster.path_demonic_pact = 1
        end
        Timers:CreateTimer(15,function()
            caster.path_demonic_pact = caster.path_demonic_pact - 1
        end)
    end

    if event.gargoyle and caster.cosmeti_pudge_pet then
        unit:SetOriginalModel("models/items/visage/bound_of_the_soul_keeper_familiar/bound_of_the_soul_keeper_familiar.vmdl")
    end

	if caster.creepertarget and not caster.creepertarget:IsNull() and unit and not unit:IsNull() then
        --print(caster.creepertarget:GetName())
		Timers:CreateTimer(0.1, function()
            --print(caster.creepertarget:GetName())
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
    ParticleManager:ReleaseParticleIndex(particle)
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
		local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_windrunner/windrunner_loadout_magic.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
        ParticleManager:ReleaseParticleIndex(particle)
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
    local hits = 12
    local sound = "Hero_BountyHunter.Jinada"
    if event.sound then
        sound = event.sound
    end
    if event.killdancehits then
        hits = event.killdancehits
    end
    event.killdance_hits_done = 1
	local vec1 = RandomVector(75.0)
	local vec = target:GetAbsOrigin() + Vector(vec1[1],vec1[2],0)
	
	caster:SetAbsOrigin(vec)
	caster:SetForwardVector(target:GetAbsOrigin()-caster:GetAbsOrigin())
	EmitSoundOn(sound, target)
	StartAnimation(caster, {activity=ACT_DOTA_ATTACK, duration=0.25, rate=2})
	KillDanceFX(event)
	
    if event.addroguepoison then
    	local myevent = {}
    	myevent.caster = caster
    	myevent.target = target
    	myevent.buff = "modifier_deadlypoison"
    	myevent.max = 25
        if caster:GetAbilityByIndex(2):GetLevel() >= 4 then
            myevent.max = 50
        end
    	myevent.ability = caster:GetAbilityByIndex(2)
    	myevent.dur = 10
    	myevent.notself = 1
    	ApplyBuffStack(myevent)
    end

    local ev = {caster = caster, target = target, ability = event.ability, targetpos = 1, damage = 0, attributefactor = event.attributefactor, includeauto = event.includeauto, aoe = 250, targeteffect = "blood", isaoe = 1 }
    if event.aoedmg and event.aoedmg == 1 then
        DamageAOE(ev)
    else
	   DamageUnit(event)
    end

    if event.killdance_crit_extra_hit and event.killdance_crit_extra_hit > 0 then
        if caster.killdance_last_hit_was_crit and math.random(1,100) <= 90 then
            hits = hits + 1
            caster.killdance_last_hit_was_crit = nil
            local particle = ParticleManager:CreateParticle("particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_teleport_end_model.vpcf", PATTACH_POINT_FOLLOW, caster)
            ParticleManager:ReleaseParticleIndex(particle)
            --EmitSoundOn("juggernaut_jug_attack_13", caster)
        end
    end

	--for i=1,hits do
	Timers:CreateTimer(0.33,function() 
        KillDanceProc(event, caster, target, distance, hits-1)
    end)
	--end
end

function KillDanceProc (event, caster, target, distance, hits)
    --print(hits)
	if not caster:HasModifier("modifier_killdance") or hits == 0 then
        caster:RemoveModifierByName("modifier_killdance")
        event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_killdance_imunity", {Duration = 3})
		return
	end
    caster:SetModifierStackCount("modifier_killdance", event.ability, hits)
    local sound = "Hero_BountyHunter.Jinada"
    if event.sound then
        sound = event.sound
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
			EmitSoundOn(sound, unit)
			StartAnimation(caster, {activity=ACT_DOTA_ATTACK, duration=0.25, rate=2})
			KillDanceFX(event)

            if event.addroguepoison then
    			local myevent = {}
    			myevent.caster = caster
    			myevent.target = unit
    			myevent.buff = "modifier_deadlypoison"
    			myevent.max = 25
                if caster:GetAbilityByIndex(2):GetLevel() >= 4 then
                    myevent.max = 50
                end
    			myevent.ability = caster:GetAbilityByIndex(2)
    			myevent.dur = 10
    			myevent.notself = 1
    			ApplyBuffStack(myevent)
            end
			
			local ev = {caster = caster, target = target, ability = event.ability, targetpos = 1, damage = 0, attributefactor = event.attributefactor, includeauto = event.includeauto, aoe = 250, targeteffect = "blood", isaoe = 1 }
            if event.aoedmg and event.aoedmg == 1 then
                DamageAOE(ev)
            else
               DamageUnit(event)
            end
            event.killdance_hits_done = event.killdance_hits_done + 1

            if event.killdance_crit_extra_hit and event.killdance_crit_extra_hit > 0 then
                if caster.killdance_last_hit_was_crit and math.random(1,100) <= 90 then
                    hits = hits + 1
                    caster.killdance_last_hit_was_crit = nil
                    local particle = ParticleManager:CreateParticle("particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_teleport_end_model.vpcf", PATTACH_POINT_FOLLOW, caster)
                    ParticleManager:ReleaseParticleIndex(particle)
                    --EmitSoundOn("juggernaut_jug_attack_13", caster)
                end
            end
            if event.stun_on_hit_count and event.stun_on_hit_count > 0 and event.killdance_hits_done > 10 then
                ApplyBuff({caster = caster, target = target, buff = "modifier_stunned", dur = 5})
            end

			local tab = {}
		 	tab.Duration = 0.05
		 	event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_phased", tab)
            Timers:CreateTimer(0.33,function() 
                KillDanceProc (event, caster, target, distance, hits-1)
            end)
		else
            caster:RemoveModifierByName("modifier_killdance")
            event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_killdance_imunity", {Duration = 3})
        end
	else
		caster:RemoveModifierByName("modifier_killdance")
        event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_killdance_imunity", {Duration = 3})
	end
end

function KillDanceFX(event)
	local caster = event.caster
	local target = event.target
    if event.shaolin_fx then
        local particle = ParticleManager:CreateParticle("particles/econ/items/centaur/dc_centaur_double_edge/_dc_centaur_double_edge.vpcf", PATTACH_POINT_FOLLOW, target)
        ParticleManager:SetParticleControlEnt(particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
        ParticleManager:SetParticleControlEnt(particle, 4, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
        ParticleManager:SetParticleControlEnt(particle, 5, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
        ParticleManager:SetParticleControlEnt(particle, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
        ParticleManager:ReleaseParticleIndex(particle)
    else
    	local vec = (caster:GetAbsOrigin()-target:GetAbsOrigin()):Normalized()
    	local vec2 = target:GetAbsOrigin()
    	local particle = ParticleManager:CreateParticle("particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_crit_arcana_swoop.vpcf", PATTACH_POINT_FOLLOW, target)
    	ParticleManager:SetParticleControl(particle, 0, vec2)
    	ParticleManager:SetParticleControl(particle, 1, vec2)
    	ParticleManager:SetParticleControlForward(particle, 1, vec)
    	ParticleManager:SetParticleControl(particle, 6, vec2)
    	ParticleManager:SetParticleControl(particle, 10, vec2)
        ParticleManager:ReleaseParticleIndex(particle)
    end
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

		local particle = ParticleManager:CreateParticle("particles/econ/events/winter_major_2016/blink_dagger_start_sparkles_wm.vpcf", PATTACH_POINT_FOLLOW, target)
        ParticleManager:ReleaseParticleIndex(particle)
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
                    ParticleManager:ReleaseParticleIndex(particle)
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
        ParticleManager:ReleaseParticleIndex(particle)
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

--[[
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
end]]

function PVELifestealLow(event)
	local caster = event.caster
	if caster:GetHealth()/caster:GetMaxHealth() <= 0.5 then
        local particle = ParticleManager:CreateParticle("particles/neutral_fx/troll_heal.vpcf", PATTACH_POINT_FOLLOW, caster)
        ParticleManager:ReleaseParticleIndex(particle)
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
        --[[ heal
        if Damaged(caster) then
            if COverthrowGameMode.jungledifficulty >= 0 and (caster:GetAbsOrigin() - other:GetAbsOrigin()):Length() < 600 then
                caster:SetHealth(caster:GetMaxHealth()*heal+caster:GetHealth())
                local particle = ParticleManager:CreateParticle("particles/items3_fx/fish_bones_active.vpcf", PATTACH_POINT_FOLLOW, caster)
                ParticleManager:ReleaseParticleIndex(particle)
            end
        end]]
		if other:GetHealth() > caster:GetHealth() then
 			caster:SetHealth(other:GetHealth())
            local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_warlock/warlock_fatal_bonds_pulse.vpcf", PATTACH_POINT_FOLLOW, caster)
            ParticleManager:SetParticleControlEnt(particle, 0, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), true)
            ParticleManager:SetParticleControlEnt(particle, 1, other, PATTACH_POINT_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), true)
            ParticleManager:ReleaseParticleIndex(particle)
		end
	end
end

function IsEnemyInRangeWithAggro( unit, distance )
    local playerid = unit:GetPlayerOwnerID()
    if unit and not unit:IsNull() then
        local enemies = FindUnitsInRadius( unit:GetTeamNumber(), unit:GetAbsOrigin(), unit, distance, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, 0, 0, false )
        if #enemies > 0 then
            for _,enemy in pairs(enemies) do
                if enemy.aggrolist and enemy.aggrolist[playerid] and enemy.aggrolist[playerid] > 0 then
                    return true
                end
            end
        end
    end
    return false
end

function TempleTeleportFromMenu(event, args)
    local player = PlayerResource:GetPlayer(args['player_id'])
    local tp_id = args['tp']
    local tp = COverthrowGameMode.teleporters[tp_id]
    if tp and player then
        local caster = player:GetAssignedHero()
        if not caster then
            return
        end
        if IsEnemyInRangeWithAggro( caster, 2501 ) then
            Notifications:Top(caster:GetPlayerID(), {text="Can not teleport when Monsters are too close!", duration=4, style={color="red"}})
            return
        end
        if caster.combat_system_ability then
            caster:SetAbsOrigin(tp:GetAbsOrigin())
            if tp_id == 8 and COverthrowGameMode.unlock_improved_tp_act_11 then
                caster:SetAbsOrigin(Entities:FindByName( nil, "act11_creep_3" ):GetAbsOrigin())
            end
            local tab = {}
            tab.Duration = 0.5
            caster.combat_system_ability:ApplyDataDrivenModifier(caster, caster, "modifier_phased", tab)
            local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_chen/chen_teleport.vpcf", PATTACH_POINT_FOLLOW, caster)
            ParticleManager:ReleaseParticleIndex(particle)
            EmitGlobalSound("DOTA_Item.ArcaneBoots.Activate")
            PlayerResource:SetCameraTarget(caster:GetPlayerOwnerID(), caster)
            CustomGameEventManager:Send_ServerToPlayer(player, "toggle_menu", { menu = 1 } )
            Timers:CreateTimer(0.25, function()
                PlayerResource:SetCameraTarget(caster:GetPlayerOwnerID(), nil)
            end)
        end
    end
end

function TempleTeleport( event )
    local caster = event.caster.controlowner
    local point = event.target_points[1]
    if caster and point then
        if not caster:IsAlive() then
            return
        end
        for i=0, 10 do
            local tp = COverthrowGameMode.teleporters[i]
            if tp and (tp.tp_active or (COverthrowGameMode.jungledifficulty >= 50.0 and i ~= 8)) then
                Timers:CreateTimer(i*0.7-0.65, function()
                    if IsEnemyInRangeWithAggro( caster, 2501 ) then
                        MinimapEvent(caster:GetTeamNumber(), caster, tp:GetAbsOrigin()[1], tp:GetAbsOrigin()[2], DOTA_MINIMAP_EVENT_BASE_UNDER_ATTACK, 1 )
                    else
                        MinimapEvent(caster:GetTeamNumber(), caster, tp:GetAbsOrigin()[1], tp:GetAbsOrigin()[2], DOTA_MINIMAP_EVENT_TEAMMATE_TELEPORTING, 1 )
                    end
                end)
            end
        end
        if IsEnemyInRangeWithAggro( caster, 2501 ) then
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
                    ParticleManager:ReleaseParticleIndex(particle)
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
                if not tp.tp_active and (point-tp:GetAbsOrigin()):Length() <= 1200 then
                    tp.tp_active = true
                    local particle = ParticleManager:CreateParticle("particles/items3_fx/glimmer_cape_initial.vpcf", PATTACH_POINT_FOLLOW, caster)
                    ParticleManager:ReleaseParticleIndex(particle)
                    EmitGlobalSound("DOTA_Item.LinkensSphere.Target")
                    Notifications:TopToAll({text="New Teleporter unlocked!", duration=5, style={color="lightblue"}})
                    CustomGameEventManager:Send_ServerToAllClients( "tp_unlocked", {value = id} )
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

function SetPositionPattern(event)
    local caster = event.caster
    local target = event.target
    local start_pos = caster:GetAbsOrigin()
    local distance_between_nodes = 600
    
    if event.reset then
        caster.position_pattern_index = 0
    end
    if event.maze and caster.position_pattern_index then
        if math.random(1,100) <= 55 then
            --target:Destroy()
            --print("kill")
            --return
            Timers:CreateTimer(0.5, function()
                target:RemoveModifierByName("modifier_poolfx")
            end)
        end
        local nodes_per_row = event.maze
        local x = 0.5 + (caster.position_pattern_index % 6) - nodes_per_row / 2
        local y = 0.5 + math.floor(caster.position_pattern_index / 6) - nodes_per_row / 2
        start_pos = start_pos + Vector(x*distance_between_nodes, y*distance_between_nodes, 0)
        caster.position_pattern_index = caster.position_pattern_index + 1
        target:SetAbsOrigin(start_pos)
        --print("set")
        --print(start_pos)
        --print(y)
    end
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
            ParticleManager:ReleaseParticleIndex(particle)
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
            ParticleManager:ReleaseParticleIndex(particle)
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
            ParticleManager:ReleaseParticleIndex(particle)
            EmitSoundOn("DOTA_Item.Armlet.DeActivate", target)
            DamageAOE(event)
        end
    else
        caster = event.attacker
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_ember_spirit/ember_spirit_hit_fire.vpcf", PATTACH_POINT_FOLLOW, target)
        particle = ParticleManager:CreateParticle("particles/econ/items/earthshaker/egteam_set/hero_earthshaker_egset/earthshaker_echoslam_start_magma_egset.vpcf", PATTACH_POINT_FOLLOW, target)
        ParticleManager:ReleaseParticleIndex(particle)
        EmitSoundOn("DOTA_Item.Armlet.DeActivate", target)
        DamageAOE(event)
    end
end

function ChainLightningItem(event)
    local caster = event.caster
    local target = event.target
    event.hit_targets = {}
    event.total_targets = event.jumps
    event.maxtargets = event.jumps
    if event.includeauto and event.includeauto > 0 then
        event.damage = event.damage + caster:GetAttackDamage() * event.includeauto / 100
    end
    if event.attributefactor and event.attributefactor > 0 then
        event.damage = event.damage + GetPrimaryStatValueCustom(caster) * event.attributefactor / 100
    end
    ZeusCloudProc(event)
end

function AffixChainLightning( event )
    local caster = event.caster
    event.target = COverthrowGameMode:AggroLowest(caster)
    event.hit_targets = {}
    event.total_targets = 10
    event.maxtargets = 10
    event.chain_hit_count = 0
    event.chainlight_only_hero = true
    event.damage_scale_per_target = 3
    event.difficultyscalelinear = 250
    event.jumprange = 300
    event.sky_lightning_fx = true
    event.lightning_delay = 0.5
    if event.target then
        ChainLightningProc(event)
    end
end

function PathChainLightning( event )
    local caster = event.caster
    event.hit_targets = {}
    event.total_targets = 3
    event.maxtargets = 3
    event.chain_hit_count = 0
    event.damage_scale_per_target = 0.5
    event.includefullauto = 400 * caster.talents[87]
    event.jumprange = 300
    event.sky_lightning_fx = true
    event.lightning_delay = 0.5
    event.naturedmg = 1
    event.holydmg = 1
    event.changedmgtypetophys = 1
    if event.target then
        ChainLightningProc(event)
    end
end

function ChainLightning(event)
    local caster = event.caster
    local target = event.target
    if caster and target and caster:GetTeamNumber() ~= target:GetTeamNumber() then
        event.hit_targets = {}
        if caster:HasModifier("modifier_npc_dota_hero_shadow_shaman") then
            event.jumps = event.jumps + 3
        end
        event.total_targets = event.jumps
        event.maxtargets = event.jumps
        event.chain_hit_count = 0
        event.damage_scale_per_target = event.damage_scale
        ChainLightningProc(event)
    end
end

function ChainLightningProc(event)
    --print(event.total_targets)
    local caster = event.caster
    local target = event.target
    local pos = target:GetAbsOrigin()
    local fxcaster = caster
    if event.hit_targets[event.total_targets+1] then
        fxcaster = event.hit_targets[event.total_targets+1]
    end
    --do dmg and fx
    event.chain_hit_count = event.chain_hit_count + 1
    local particle = ParticleManager:CreateParticle("particles/items_fx/chain_lightning.vpcf", PATTACH_POINT_FOLLOW, caster)
    ParticleManager:SetParticleControlEnt(particle, 0, fxcaster, PATTACH_POINT_FOLLOW, "attach_hitloc", fxcaster:GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
    ParticleManager:ReleaseParticleIndex(particle)
    if event.sky_lightning_fx then
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_zeus/zeus_cloud_strike.vpcf", PATTACH_WORLDORIGIN, target)
        ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())
        ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin() + Vector(0,0,250))
        ParticleManager:SetParticleControl(particle, 6, Vector(1,1,1))
        ParticleManager:ReleaseParticleIndex(particle)
        particle = ParticleManager:CreateParticle("particles/units/heroes/hero_zeus/zeus_cloud_strike.vpcf", PATTACH_WORLDORIGIN, target)
        ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin() + Vector(0,0,75))
        ParticleManager:SetParticleControl(particle, 1, fxcaster:GetAbsOrigin() + Vector(0,0,75))
        ParticleManager:SetParticleControl(particle, 6, Vector(1,1,1))
        ParticleManager:ReleaseParticleIndex(particle)
    end
    EmitSoundOn("Item.Maelstrom.Chain_Lightning.Jump", target)
    --dont reduce dmg of first hit
    if not caster:HasModifier("modifier_npc_dota_hero_shadow_shaman") and event.chain_hit_count ~= 1 then
        event.damage_scale = math.pow(event.damage_scale_per_target, event.chain_hit_count)
    end
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
            if enemy ~= nil and enemy:IsAlive() and ((enemy:GetUnitLabel()=="hero") or (enemy:GetUnitLabel()=="pet") or (enemy:GetUnitLabel()=="tower")) and not CheckForBreakableCC(target) and ((not event.chainlight_only_hero) or (event.chainlight_only_hero and enemy:IsRealHero())) then 
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
            local delay = 0.3
            if event.lightning_delay then 
                delay = event.lightning_delay
            end
            Timers:CreateTimer(delay, function()
                --[[
                local myevent = {}
                myevent.caster = caster
                myevent.target = final_target
                myevent.damage = event.damage / 2 --damage factor need set, also set item
                myevent.ability = event.ability
                myevent.hit_targets = event.hit_targets
                myevent.total_targets = event.total_targets
                myevent.maxtargets = event.maxtargets
                myevent.jumprange = event.jumprange]]
                event.target = final_target
                ChainLightningProc(event)
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
    local id = 1
    local position_angle = 100
    if event.companion_id then
        id = event.companion_id
        position_angle = 0
        if id == 2 then
            position_angle = 310
        end
        if id == 3 then
            position_angle = 50
        end
    end
    local companion
    if caster.companion then
        companion = caster.companion[id]
    end
    local tab = {Duration = -1}
    if companion and not companion:IsNull() and companion:IsAlive() then
        --blink if far away
        if (caster:GetAbsOrigin()-companion:GetAbsOrigin()):Length() > 1500 then --890 before
            companion:SetAbsOrigin(caster:GetAbsOrigin()+Vector(0,100,0))
            event.ability:ApplyDataDrivenModifier(caster, companion, "modifier_phased", tab)
        end
        --standard behavior
        local has_attack_order = false
        if event.fight then
            local target = caster.companiontarget
            if target and not target:IsNull() and target:IsAlive() and (caster:GetAbsOrigin()-target:GetAbsOrigin()):Length() < 900 then
                has_attack_order = true
                local order = 
                {
                    UnitIndex = companion:entindex(),
                    OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
                    TargetIndex = target:entindex()
                }
                ExecuteOrderFromTable(order)
            end
        end
        if event.follow or not has_attack_order then
            if caster:IsMoving() then
                local position = caster:GetAbsOrigin() + 350 * caster:GetForwardVector() + RotateVectorAroundAngle(caster:GetForwardVector(), position_angle) * 150
                local order = 
                {
                    UnitIndex = companion:entindex(),
                    OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
                    Position = position
                }
                ExecuteOrderFromTable(order)
                --[[ old follow, didnt work cuz unselectable
                local follow_target = caster
                if event.companion_id == 3 and IsCompanionAlive(caster, 2) then
                    follow_target = caster.companion[2]
                end
                if event.companion_id == 4 and IsCompanionAlive(caster, 3) then
                    follow_target = caster.companion[3]
                end
                local order = 
                {
                    UnitIndex = companion:entindex(),
                    OrderType = DOTA_UNIT_ORDER_MOVE_TO_TARGET,
                    TargetIndex = follow_target:entindex()
                }
                ExecuteOrderFromTable(order)]]
            else
                local position = caster:GetAbsOrigin() + RotateVectorAroundAngle(caster:GetForwardVector(), position_angle) * 150
                local order = 
                {
                    UnitIndex = companion:entindex(),
                    OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
                    Position = position
                }
                ExecuteOrderFromTable(order)
            end
        end
    else
        if event.dragon then
            local buffname = "dragon_summon_proc"
            if event.companion_id then
                buffname = "dragon_summon_proc_"..event.companion_id
            end
            event.ability:ApplyDataDrivenModifier(caster, caster, buffname, nil)
        end
    end
end

function CompanionTargetSet(event)
    local caster = event.attacker
    caster.companiontarget = event.unit
end

function CompanionRegister(event)
    local caster = event.caster
    if not caster.companion then
        caster.companion = {}
    end
    local id = 1
    if event.companion_id then
        id = event.companion_id
    end
    caster.companion[id] = event.target
    event.target.owner = caster
end

function CompanionRemoval(event)
    local caster = event.caster
    local id = 1
    if event.companion_id then
        id = event.companion_id
    end
    if IsCompanionAlive(caster, id) then
        caster.companion[id]:Destroy()
        caster.companion[id] = nil
    end
end

function IsCompanionAlive(caster, id)
    if not caster.companion then
        return false
    end
    local companion = caster.companion[id]
    if companion and not companion:IsNull() and companion:IsAlive() then
        return true
    else
        return false
    end
end

function HealMostWoundedHero(event)
    local caster = event.caster
    local target = MostWoundedTarget(event)
    if target and caster.companion and caster.companion[1] then
        local particle = ParticleManager:CreateParticle("particles/dazzle_shadow_wave_green.vpcf", PATTACH_POINT_FOLLOW, caster.companion[1])
        ParticleManager:SetParticleControlEnt(particle, 0, caster.companion[1], PATTACH_POINT_FOLLOW, "attach_hitloc", caster.companion[1]:GetAbsOrigin(), true)
        ParticleManager:SetParticleControlEnt(particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
        ParticleManager:ReleaseParticleIndex(particle)
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
    if event.attacker:HasModifier("modifier_pet_system") or event.attacker:HasModifier("modifier_pet_system_grizzly") or event.attacker:HasModifier("modifier_companion_behavior") then
        return
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
        ParticleManager:ReleaseParticleIndex(particle)
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

function ApplyBuffStackBasedOnPercentHP(event)
    local caster = event.caster
    if caster then
        local percent = 100 - math.floor(100 * caster:GetHealth() / caster:GetMaxHealth())
        if percent < 100.0 and event.ability then
            event.setstacks = percent
            ApplyBuffStack(event)
        end
    end
end

function TempleRandomArrowLaunch(event)
    local caster = event.caster
    local ability = event.ability
    local time = 2.25
    --modes
    local cast_sound = "Ability.LightStrikeArray"
    local impact_sound = "Ability.TossImpact"
    local aoe = 250
    local targeteffect = "fire"
    local impact_fx_type = 1
    local missile_fx = "particles/meteor_arrow.vpcf"
    local launch_pattern = nil
    local missiles = 4
    local random_target = nil
    if event.arrow then
        cast_sound = "Hero_PhantomAssassin.Dagger.Cast"
        impact_sound = "Hero_PhantomAssassin.Dagger.Target"
        aoe = 75
        targeteffect = "blood"
        is_fire_effect = false
        missile_fx = "particles/spear_arrow.vpcf"
        event.stun = 2.5
        impact_fx_type = 2
        time = 2.5
    end
    if event.rock then
        cast_sound = "Hero_Lina.preAttack"
        --impact_sound = "Hero_PhantomAssassin.Dagger.Target"
        aoe = 250
        targeteffect = "blood"
        is_fire_effect = false
        missile_fx = "particles/rock_arrow.vpcf"
        event.stun = 1.5
        impact_fx_type = 3
        time = 2.25
        missiles = 1
        if not caster.missile_launch_pattern_rock then
            caster.missile_launch_pattern_rock = 1
        end
    end
    if event.icerock then
        cast_sound = "Hero_Lina.preAttack"
        --impact_sound = "hero_Crystal.frostbite"
        aoe = 200
        targeteffect = "blood"
        is_fire_effect = false
        missile_fx = "particles/icerock_arrow.vpcf"
        --event.stun = 1
        impact_fx_type = 4
        time = 3
        missiles = 1
        local all = HeroList:GetAllHeroes()
        random_target = all[math.random(1,#all)]
        --if not caster.missile_launch_pattern_rock then
        --    caster.missile_launch_pattern_rock = 1
        --end
    end
    if event.rockcurve then
        cast_sound = "Hero_Lina.preAttack"
        --impact_sound = "Hero_PhantomAssassin.Dagger.Target"
        aoe = 250
        targeteffect = "blood"
        is_fire_effect = false
        missile_fx = "particles/rock_arrow.vpcf"
        event.stun = 2
        impact_fx_type = 3
        time = 1
        missiles = 1
        if caster.skip_next_rockcurve then
            caster.skip_next_rockcurve = false
            return
        end
        if event.init_rockcurve then
            caster.skip_next_rockcurve = true
            local current_target = COverthrowGameMode:AggroHighest(caster)
            if current_target then
                caster:SetForwardVector((current_target:GetAbsOrigin()-caster:GetAbsOrigin()):Normalized())
            end
            time = 2.0
            caster.missile_launch_pattern_rockcurve = 1
            if math.random(1,100) <= 50 then
                caster.missile_launch_pattern_rockcurve = -1
            end
            caster.last_rockcurve_throw_impact = caster:GetAbsOrigin()
            caster.last_rockcurve_forward = caster:GetForwardVector()
        end
    end

    local speed = 1.25 / time
    if event.missiles then
        missiles = event.missiles
    end

    if caster:GetHealth()/caster:GetMaxHealth() <= event.maxhp then
        EmitSoundOn(cast_sound, caster)
        for i=1, missiles do
            local particle
            event.range = math.random(400,925)
            if event.minrange then
                event.range = math.random(event.minrange,900)
            end
            local spot = RandomPointAroundUnit(event)
            if event.rock then
                if caster.missile_launch_pattern_rock == 1 then
                    caster.missile_launch_pattern_rock = 2
                    event.range = math.random(700,900)
                    spot = caster:GetAbsOrigin() + caster:GetForwardVector() * event.range
                    caster.last_rock_throw_impact = spot
                    particle = ParticleManager:CreateParticle(missile_fx, PATTACH_ABSORIGIN, caster)
                elseif caster.missile_launch_pattern_rock == 2 then
                    caster.missile_launch_pattern_rock = 1
                    event.range = math.random(700,900)
                    spot = caster:GetAbsOrigin()
                    particle = ParticleManager:CreateParticle(missile_fx, PATTACH_WORLDORIGIN, caster)
                    ParticleManager:SetParticleControl(particle, 0, caster.last_rock_throw_impact)
                end
            end
            if event.icerock then
                spot = random_target:GetAbsOrigin()
                event.range = (spot-caster:GetAbsOrigin()):Length()
            end
            if event.rockcurve then
                event.range = math.random(350,350)
                spot = caster.last_rockcurve_throw_impact + caster.last_rockcurve_forward * event.range
                particle = ParticleManager:CreateParticle(missile_fx, PATTACH_WORLDORIGIN, caster)
                ParticleManager:SetParticleControl(particle, 0, caster.last_rockcurve_throw_impact)
                caster.last_rockcurve_throw_impact = spot
                caster.last_rockcurve_forward = RotateVectorAroundAngle(caster.last_rockcurve_forward, 35*caster.missile_launch_pattern_rockcurve)
            end
            
            if not event.rock and not event.rockcurve then
                particle = ParticleManager:CreateParticle(missile_fx, PATTACH_ABSORIGIN, caster)
            end
            ParticleManager:SetParticleControl(particle, 1, spot)
            ParticleManager:SetParticleControl(particle, 2, Vector(event.range*speed,0,0))
            Timers:CreateTimer(time*1.0, function()
                EmitSoundOn(impact_sound, caster)
                if impact_fx_type == 1 then
                    local particle2 = ParticleManager:CreateParticle("particles/units/heroes/hero_ember_spirit/ember_spirit_hit_fire.vpcf", PATTACH_ABSORIGIN, caster)
                    ParticleManager:SetParticleControl(particle2, 0, spot)
                    ParticleManager:ReleaseParticleIndex(particle2)
                    particle2 = ParticleManager:CreateParticle("particles/econ/items/wraith_king/wraith_king_ti6_bracer/wraith_king_ti6_hellfireblast_explosion.vpcf", PATTACH_ABSORIGIN, caster)
                    ParticleManager:SetParticleControl(particle2, 3, spot)
                    ParticleManager:ReleaseParticleIndex(particle2)
                end
                if impact_fx_type == 2 then
                    local particle2 = ParticleManager:CreateParticle("particles/units/heroes/hero_bloodseeker/bloodseeker_rupture_nuke.vpcf", PATTACH_WORLDORIGIN, caster)
                    ParticleManager:SetParticleControl(particle2, 0, spot)
                    ParticleManager:ReleaseParticleIndex(particle2)
                end
                if impact_fx_type == 3 then
                    local particle2 = ParticleManager:CreateParticle("particles/units/heroes/hero_centaur/centaur_warstomp.vpcf", PATTACH_WORLDORIGIN, caster)
                    ParticleManager:SetParticleControl(particle2, 0, spot)
                    ParticleManager:SetParticleControl(particle2, 1, Vector(aoe,aoe,aoe))
                    ParticleManager:ReleaseParticleIndex(particle2)
                end
                if impact_fx_type == 4 then
                    local particle2 = ParticleManager:CreateParticle("particles/econ/items/crystal_maiden/crystal_maiden_cowl_of_ice/maiden_crystal_nova_cowlofice.vpcf", PATTACH_WORLDORIGIN, caster)
                    ParticleManager:SetParticleControl(particle2, 0, spot)
                    ParticleManager:SetParticleControl(particle2, 1, Vector(aoe,1,aoe))
                    ParticleManager:ReleaseParticleIndex(particle2)
                end
                if particle then
                    ParticleManager:DestroyParticle(particle, true)
                    ParticleManager:ReleaseParticleIndex(particle)
                end
                local tab = {}
                tab.stun = event.stun
                tab.caster = caster
                tab.target = caster
                tab.damage = 0.0
                tab.spelldamagefactor = 0.0
                tab.attributefactor = 0.0
                tab.difficultyscalelinear = 400
                tab.ability = ability
                tab.aoe = aoe
                tab.targeteffect = targeteffect
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
        factor = factor + 1
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
    --if caster:HasModifier("modifier_item_crit_pure_5_lifesteal") then
    --    factor = factor + 0.05
    --end
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
    if not caster.bearform and caster:GetModifierStackCount("modifier_pvefrenzy_bear", nil) >= 25 then
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
        ParticleManager:ReleaseParticleIndex(particle)
    end
    if caster.dragoncouncil2 and caster and not caster:IsNull() and not caster.dragoncouncil2:IsNull() and(c1-caster.dragoncouncil2:GetAbsOrigin()):Length() > 2000 then
        caster.dragoncouncil2:SetAbsOrigin(c1+Vector(0,-50,0))
        local tab = {Duration = 0.1}
        event.ability:ApplyDataDrivenModifier(caster, caster.dragoncouncil2, "modifier_phased", tab)
        local particle = ParticleManager:CreateParticle("particles/econ/events/ti5/blink_dagger_start_smoke_ti5.vpcf", PATTACH_POINT_FOLLOW, caster.dragoncouncil2)
        ParticleManager:ReleaseParticleIndex(particle)
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
        ParticleManager:ReleaseParticleIndex(particle)
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
            --heal allies hit
            local particle = ParticleManager:CreateParticle("particles/econ/events/ti6/hero_levelup_ti6_flash_hit_magic.vpcf", PATTACH_POINT_FOLLOW, target)
            ParticleManager:ReleaseParticleIndex(particle)
            local myevent = {}
            myevent.caster = caster
            myevent.target = target
            myevent.ability = ability
            myevent.heal = 0.0
            myevent.percenthp = event.healing
            HealUnit(myevent)
        end
    else
        local particle = ParticleManager:CreateParticle("particles/econ/items/magnataur/shock_of_the_anvil/magnataur_shockanvil_hit.vpcf", PATTACH_POINT_FOLLOW, target)
        ParticleManager:ReleaseParticleIndex(particle)
        local myevent = {}
        myevent.caster = caster
        myevent.target = target
        myevent.dur = 0.1
        myevent.ability = ability
        SpellInterrupt(myevent)
        DamageUnit(event)
        myevent = {}
        myevent.caster = caster
        myevent.target = caster
        myevent.ability = ability
        myevent.heal = 0.0
        myevent.percenthp = event.healing
        HealUnit(myevent)
    end
end

function SteedOfLight(event)
    local caster = event.caster
    local target = event.target
    local ability = event.ability
    if target:GetTeamNumber() == caster:GetTeamNumber() then
        --heal allies hit
        local particle = ParticleManager:CreateParticle("particles/econ/events/ti6/hero_levelup_ti6_flash_hit_magic.vpcf", PATTACH_POINT_FOLLOW, target)
        ParticleManager:ReleaseParticleIndex(particle)
        local myevent = {}
        myevent.caster = caster
        myevent.target = target
        myevent.ability = ability
        myevent.heal = 0.0
        myevent.attributefactor = event.attributefactor
        myevent.spelldamagefactor = event.spelldamagefactor
        HealUnit(myevent)
    else
        local particle = ParticleManager:CreateParticle("particles/econ/items/magnataur/shock_of_the_anvil/magnataur_shockanvil_hit.vpcf", PATTACH_POINT_FOLLOW, target)
        ParticleManager:ReleaseParticleIndex(particle)
        if event.rootdur and event.rootdur > 0 then
            local myevent = { caster = caster, target = target, buff = "modifier_stunnedshackle", ability = ability, max = 5, dur = event.rootdur}
            ApplyBuff(myevent)
        end
        local myevent = {}
        myevent.caster = caster
        myevent.target = target
        myevent.dur = 0.1
        myevent.ability = ability
        SpellInterrupt(myevent)
        DamageUnit(event)
    end
    if event.spellhasteproc and event.spellhasteproc > 0 then
        local myevent = { caster = caster, target = caster, buff = "modifier_keeper_spellhaste", ability = ability, max = 5, dur = 10}
        ApplyBuffStack(myevent)
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
        EmitSoundOn("Hero_PhantomAssassin.PreAttack", caster)
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
        ParticleManager:ReleaseParticleIndex(particle)
        COverthrowGameMode:EquipArtifactCosmeticRewardsGlobal(caster)
    end
end

function ShapeshiftDH(event)
    local caster = event.caster

    --to meta
    --model change, only when synced
    if COverthrowGameMode.EnableShapeshift == 1 then
        COverthrowGameMode:RemoveAllCosmeticsGlobal(caster)
        local model = "models/items/terrorblade/marauders_demon/marauders_demon.vmdl"
        if caster.cosmetic_reward_head then
            model = "models/items/terrorblade/dotapit_s3_fallen_light_metamorphosis/dotapit_s3_fallen_light_metamorphosis.vmdl"
        end
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
            if caster.standsstill == 5 then --and caster.standsstill % 3 == 1 then
                local particle = ParticleManager:CreateParticle("particles/moon_light.vpcf", PATTACH_ABSORIGIN, caster)
                ParticleManager:SetParticleControlEnt(particle, 2, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), true)
                ParticleManager:ReleaseParticleIndex(particle)
            end
        else
            caster.standsstill = 1
        end
    end
    if caster.standsstill and caster.standsstill > 0 and caster.combat_system_ability then
        local standsstill = caster.standsstill
        if standsstill > 5 then
            standsstill = 5
        end
        caster.combat_system_ability:ApplyDataDrivenModifier(caster, caster, "modifier_careful_aim", {Duration = -1})
        caster:SetModifierStackCount("modifier_careful_aim", caster.combat_system_ability, standsstill)
    else
        caster:RemoveModifierByName("modifier_careful_aim")
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

    --spelldamage
    hero.spellpower = GetSpellpower(event)
    hero.lifeblood = 1
    hero:RemoveModifierByName("modifier_int_custom")
    hero:RemoveModifierByName("modifier_int_custom_penalty")
    hero:RemoveModifierByName("modifier_str_custom")
    hero:RemoveModifierByName("modifier_str_custom_penalty")

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
    --fah = 10
    --nah = 10
    --kil = 10

    local assumed_max_runeword_value = 75 --pre ancient, now rather 75+, 350 abil4dmg is possible
    hero.runeword = {}
    hero.runeword[1] = GetRuneWordValue(  loo , nah , time, 500 / assumed_max_runeword_value )
    hero.runeword[2] = GetRuneWordValue(  wii , ser , time, 500/ assumed_max_runeword_value )
    hero.runeword[3] = GetRuneWordValue(  wii , tal , time, 50/ assumed_max_runeword_value )
    hero.runeword[4] = GetRuneWordValue(  wii , tal , tic, 50/ assumed_max_runeword_value )
    if hero.runeword[4] > 50 then
        hero.runeword[4] = 50
    end
    hero.runeword[5] = GetRuneWordValue(  fah , tal , time, 500 / assumed_max_runeword_value )
    hero.runeword[6] = GetRuneWordValue(  fah , nah , tic, 1000 / assumed_max_runeword_value )
    hero.runeword[7] = GetRuneWordValue(  fah , ser , time, 750 / assumed_max_runeword_value )
    hero.runeword[8] = GetRuneWordValue(  fah , tal , kil, 6 / assumed_max_runeword_value )
    hero.runeword[9] = GetRuneWordValue(  loo , nah , kil, 4 / assumed_max_runeword_value )
    hero.runeword[10] = GetRuneWordValue(  wii , nah , kil, 6 / assumed_max_runeword_value )
    hero.runeword[11] = GetRuneWordValue(  loo , ser , time, 5 / assumed_max_runeword_value )
    hero.runeword[12] = GetRuneWordValue(  fah , tal , tic, 7 / assumed_max_runeword_value )
    hero.runeword[13] = GetRuneWordValue(  wii , ser , tic, 4 / assumed_max_runeword_value )
    hero.runeword[14] = GetRuneWordValue(  loo , nah , tic, 5 / assumed_max_runeword_value )
    hero.runeword[15] = GetRuneWordValue(  wii , tal , kil, 5 / assumed_max_runeword_value )
    hero.runeword[16] = GetRuneWordValue(  loo , tal , time, 350 / assumed_max_runeword_value )
    hero.runeword[17] = GetRuneWordValue(  wii , nah , tic, 6 / assumed_max_runeword_value )
    hero.runeword[18] = GetRuneWordValue(  loo , tal , tic, 25 / assumed_max_runeword_value )
    hero.runeword[19] = GetRuneWordValue(  wii , ser , kil, 20 / assumed_max_runeword_value )
    hero.runeword[20] = GetRuneWordValue(  fah , ser , kil, 4 / assumed_max_runeword_value )
    hero.runeword[21] = GetRuneWordValue(  fah , ser , tic, 5 / assumed_max_runeword_value )
    hero.runeword[22] = GetRuneWordValue(  fah , nah , time, 50 / assumed_max_runeword_value )
    hero.runeword[23] = GetRuneWordValue(  wii , nah , time, 45 / assumed_max_runeword_value )
    hero.runeword[24] = GetRuneWordValue(  fah , nah , kil, 7 / assumed_max_runeword_value )
    hero.runeword[25] = GetRuneWordValue(  loo , tal , kil, 60 / assumed_max_runeword_value )
    hero.runeword[26] = GetRuneWordValue(  loo , ser , tic, 5 / assumed_max_runeword_value )
    hero.runeword[27] = GetRuneWordValue(  loo , ser , kil, 20 / assumed_max_runeword_value )
    
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

    --primary stat bonuses
    local primary_stats_percent_bonus = 0
    local primary_stats_static_bonus = 0
    if hero and hero.talents then
        --if hero.talents[56] and hero.talents[56] > 0 then
        --    primary_stats_percent_bonus = primary_stats_percent_bonus + 0.07 * hero.talents[56]
        --end
        if hero.talents[65] and hero.talents[65] > 0 then --and hero:GetMoveSpeedModifier(hero:GetBaseMoveSpeed()) < 300 then
            primary_stats_percent_bonus = primary_stats_percent_bonus + 0.05 * hero.talents[65]
        end
        if hero.talents[10] and hero.talents[10] > 0 then --and hero:GetMoveSpeedModifier(hero:GetBaseMoveSpeed()) < 300 then
            primary_stats_static_bonus = primary_stats_static_bonus + 25 * hero.talents[10]
        end
        if hero:HasModifier("modifier_item_ancient_primary") then
            primary_stats_percent_bonus = primary_stats_percent_bonus + 0.1
            primary_stats_static_bonus = primary_stats_static_bonus + 60
        end
        if hero:HasModifier("modifier_pathbuff_070") and hero:HasModifier("modifier_path_from_shadows") and hero:HasModifier("modifier_talent_tiger_prowl") then
            primary_stats_percent_bonus = primary_stats_percent_bonus + 0.25
        end
        if hero:HasModifier("modifier_element_holy") then
            primary_stats_percent_bonus = primary_stats_percent_bonus + 0.2
        end
        if hero:HasModifier("modifier_item_ancient_primary_heal") then
            primary_stats_static_bonus = primary_stats_static_bonus + 50
        end
        if hero:HasModifier("modifier_item_ancient_dot") then
            primary_stats_static_bonus = primary_stats_static_bonus + 60
        end
        if hero.talents[71] and hero.talents[71] > 0 and hero:HasModifier("modifier_path_overwhelm") then
            primary_stats_percent_bonus = primary_stats_percent_bonus + 0.15 * hero.talents[71]
        end
        if hero:HasModifier("modifier_cain_legendary") then
            primary_stats_static_bonus = primary_stats_static_bonus + 25
        end
        if hero:HasModifier("modifier_cain_immo") then
            primary_stats_static_bonus = primary_stats_static_bonus + 75
        end
        if hero:HasModifier("modifier_cain_divine") then
            primary_stats_static_bonus = primary_stats_static_bonus + 150
        end
        if hero:HasModifier("modifier_cain_set") then
            primary_stats_static_bonus = primary_stats_static_bonus + 250
        end
        if hero:HasModifier("modifier_item_cd_65") then
            primary_stats_static_bonus = primary_stats_static_bonus + 30
        end
        if hero:HasModifier("modifier_item_cd_65_2") then
            primary_stats_static_bonus = primary_stats_static_bonus + 100
        end
        if hero:HasModifier("modifier_item_cd_54") then
            primary_stats_static_bonus = primary_stats_static_bonus + 30
        end
        if hero:HasModifier("modifier_item_cd_54_2") then
            primary_stats_static_bonus = primary_stats_static_bonus + 100
        end
        if hero:HasModifier("modifier_item_agihaste") then
            primary_stats_static_bonus = primary_stats_static_bonus + 30
        end
        if hero:HasModifier("modifier_item_agihaste_2") then
            primary_stats_static_bonus = primary_stats_static_bonus + 200
        end
        if hero:HasModifier("modifier_item_cd_43") then
            primary_stats_static_bonus = primary_stats_static_bonus + 35
        end
        if hero:HasModifier("modifier_item_cd_43_2") then
            primary_stats_static_bonus = primary_stats_static_bonus + 125
        end
        if hero:HasModifier("modifier_item_channel") then
            primary_stats_static_bonus = primary_stats_static_bonus + 35
        end
        if hero:HasModifier("modifier_item_channel_2") then
            primary_stats_static_bonus = primary_stats_static_bonus + 125
        end
        if hero:HasModifier("modifier_item_titanarmor") then
            primary_stats_static_bonus = primary_stats_static_bonus + 35
        end
        if hero:HasModifier("modifier_item_titanarmor_2") then
            primary_stats_static_bonus = primary_stats_static_bonus + 125
        end
        if hero:HasModifier("modifier_item_windfury") then
            primary_stats_static_bonus = primary_stats_static_bonus + 30
        end
        if hero:HasModifier("modifier_item_windfury_2") then
            primary_stats_static_bonus = primary_stats_static_bonus + 100
        end
        if hero:HasModifier("modifier_item_bighit") then
            primary_stats_static_bonus = primary_stats_static_bonus + 30
        end
        if hero:HasModifier("modifier_item_bighit_2") then
            primary_stats_static_bonus = primary_stats_static_bonus + 100
        end
        if hero:HasModifier("modifier_item_multi_element") then
            primary_stats_static_bonus = primary_stats_static_bonus + 30
        end
        if hero:HasModifier("modifier_item_multi_element_2") then
            primary_stats_static_bonus = primary_stats_static_bonus + 100
        end
        if hero:HasModifier("modifier_item_wolf_sword") then
            primary_stats_static_bonus = primary_stats_static_bonus + 30
        end
        if hero:HasModifier("modifier_item_wolf_sword_2") then
            primary_stats_static_bonus = primary_stats_static_bonus + 100
        end
        if hero:HasModifier("modifier_item_silverblood3") then
            primary_stats_static_bonus = primary_stats_static_bonus + 30
        end
        if hero:HasModifier("modifier_pathbuff_004") then
            primary_stats_static_bonus = primary_stats_static_bonus + 75
        end
        if hero:HasModifier("modifier_pathbuff_006") then
            primary_stats_static_bonus = primary_stats_static_bonus + 100
        end
        if hero:HasModifier("modifier_pathbuff_007") then
            primary_stats_static_bonus = primary_stats_static_bonus + 75
        end
        if hero:HasModifier("modifier_pathbuff_009") then
            primary_stats_static_bonus = primary_stats_static_bonus + 80
        end
        if hero:HasModifier("modifier_pathbuff_010") then
            primary_stats_static_bonus = primary_stats_static_bonus + 75
        end
        if hero:HasModifier("modifier_pathbuff_011") then
            primary_stats_static_bonus = primary_stats_static_bonus + 75
        end
        if hero:HasModifier("modifier_pathbuff_030") then
            primary_stats_static_bonus = primary_stats_static_bonus + 75
        end
        if hero:HasModifier("modifier_pathbuff_035") then
            primary_stats_static_bonus = primary_stats_static_bonus + 75
        end
        if hero:HasModifier("modifier_pathbuff_036") then
            primary_stats_static_bonus = primary_stats_static_bonus + 75
        end
        if hero:HasModifier("modifier_pathbuff_042") then
            primary_stats_static_bonus = primary_stats_static_bonus + 75
        end
        if hero:HasModifier("modifier_pathbuff_047") then
            primary_stats_static_bonus = primary_stats_static_bonus + 75
        end
        if hero:HasModifier("modifier_pathbuff_048") then
            primary_stats_static_bonus = primary_stats_static_bonus + 75
        end
        if hero:HasModifier("modifier_pathbuff_056") then
            primary_stats_static_bonus = primary_stats_static_bonus + 75
        end
        if hero:HasModifier("modifier_pathbuff_063") then
            primary_stats_static_bonus = primary_stats_static_bonus + 125
        end
        if hero:HasModifier("modifier_pathbuff_064") then
            primary_stats_static_bonus = primary_stats_static_bonus + 150
        end
        if hero:HasModifier("modifier_pathbuff_065") then
            primary_stats_static_bonus = primary_stats_static_bonus + 75
        end
        if hero:HasModifier("modifier_pathbuff_066") then
            primary_stats_static_bonus = primary_stats_static_bonus + 75
        end
        if hero:HasModifier("modifier_pathbuff_067") then
            primary_stats_static_bonus = primary_stats_static_bonus + 75
        end
        if hero:HasModifier("modifier_pathbuff_068") then
            primary_stats_static_bonus = primary_stats_static_bonus + 75
        end
        if hero:HasModifier("modifier_pathbuff_071") then
            primary_stats_static_bonus = primary_stats_static_bonus + 75
        end
        if hero:HasModifier("modifier_pathbuff_072") then
            primary_stats_static_bonus = primary_stats_static_bonus + 75
        end
        if hero:HasModifier("modifier_pathbuff_077") then
            primary_stats_static_bonus = primary_stats_static_bonus + 75
        end
        if hero:HasModifier("modifier_pathbuff_079") then
            primary_stats_static_bonus = primary_stats_static_bonus + 100
        end
        if hero:HasModifier("modifier_pathbuff_081") then
            primary_stats_static_bonus = primary_stats_static_bonus + 50
        end
        if hero:HasModifier("modifier_pathbuff_083") then
            primary_stats_static_bonus = primary_stats_static_bonus + 50
        end
        if hero:HasModifier("modifier_pathbuff_086") then
            primary_stats_static_bonus = primary_stats_static_bonus + 50
        end
        if hero:HasModifier("modifier_pathbuff_088") then
            primary_stats_static_bonus = primary_stats_static_bonus + 75
        end
        if hero:HasModifier("modifier_pathbuff_089") then
            primary_stats_static_bonus = primary_stats_static_bonus + 75
        end
        if hero:HasModifier("modifier_moonlighttiger") then
            primary_stats_static_bonus = primary_stats_static_bonus + 75
        end
    end

    --pathwords
    local pathwords = GetPathBonusesFromPathWords(hero)
    SendPathWordsToUI(hero, pathwords)
    --soul items
    local soul = GetSoulItemTalent(hero)
    local classringbonus = GetClassRingPower(hero)
    local amuletpathbonus = GetAmuletPathBonus(hero)
    for i=1, COverthrowGameMode.maxtalents do
        --update talent bonuses
        local soul_item_bonus = 0
        local path_word_bonus = 0
        for k=1, 3 do
            if i == soul[k][1] then
                soul_item_bonus = soul[k][2]
            end
        end
        local path_bonus_from_ring_given = 0
        for k=1, 3 do
            if i == classringbonus[-1+k*2] then
                path_bonus_from_ring_given = classringbonus[k*2]
                soul_item_bonus = soul_item_bonus + classringbonus[k*2]
            end
        end
        for k=1, 3 do
            if i == amuletpathbonus[-1+k*2] then
                if amuletpathbonus[k*2] > path_bonus_from_ring_given then
                    --only when the amulet gives more points than the ring it takes effect
                    soul_item_bonus = soul_item_bonus + amuletpathbonus[k*2] - path_bonus_from_ring_given
                end
            end
        end
        if pathwords and pathwords[i] and pathwords[i][1] and pathwords[i][1] > 0 then
            soul_item_bonus = soul_item_bonus + pathwords[i][1]
            path_word_bonus = pathwords[i][1]
        end
        if i == 87 then
            soul_item_bonus = soul_item_bonus + hero.runeword[13]
        end
        if i == 4 then
            soul_item_bonus = soul_item_bonus + hero.runeword[24]
        end
        if i == 8 then
            soul_item_bonus = soul_item_bonus + hero.runeword[26]
        end
        if i == 49 then
            soul_item_bonus = soul_item_bonus + hero.runeword[15]
        end
        if i == 17 then
            soul_item_bonus = soul_item_bonus + hero.runeword[12]
        end
        if i == 53 then
            soul_item_bonus = soul_item_bonus + hero.runeword[20]
        end
        if i == 70 and hero:HasModifier("modifier_item_night_shoulders") then
            soul_item_bonus = soul_item_bonus + 2
        end
        if i == 71 and hero:HasModifier("modifier_item_dragonshield") then
            soul_item_bonus = soul_item_bonus + 2
        end
        if i == 2 and hero:HasModifier("modifier_item_ancient_wolf") then
            soul_item_bonus = soul_item_bonus + 2
        end
        if i == 47 and hero:HasModifier("modifier_item_ancient_wolf") then
            soul_item_bonus = soul_item_bonus + 2
        end
        if i == 47 then
            soul_item_bonus = soul_item_bonus + hero.runeword[14]
        end
        if i == 33 and hero:HasModifier("modifier_item_ancient_dragon") and hero.talents_clicked and hero.talents_clicked[i] and hero.talents_clicked[i] > 0 then
            soul_item_bonus = soul_item_bonus + 2
        end
        if i == 6 and hero:HasModifier("modifier_ancient_allstats") and hero.talents_clicked and hero.talents_clicked[i] and hero.talents_clicked[i] > 0 then
            soul_item_bonus = soul_item_bonus + 2
        end
        if i == 18 and hero:HasModifier("modifier_item_dmg5") and hero.talents_clicked and hero.talents_clicked[i] and hero.talents_clicked[i] > 0 then
            soul_item_bonus = soul_item_bonus + 3
        end
        if i == 53 and hero:HasModifier("modifier_item_dmg5") and hero.talents_clicked and hero.talents_clicked[i] and hero.talents_clicked[i] > 0 then
            soul_item_bonus = soul_item_bonus + 1
        end
        if i == 50 and hero:HasModifier("modifier_item_ancient_primary_heal") and hero.talents_clicked and hero.talents_clicked[i] and hero.talents_clicked[i] > 0 then
            soul_item_bonus = soul_item_bonus + 1
        end
        if i == 53 and hero:HasModifier("modifier_class_fury") and hero:HasModifier("modifier_furycharge") then
            soul_item_bonus = soul_item_bonus + 2
        end
        if i == 34 and hero:HasModifier("modifier_item_winterbreeze4") then
            soul_item_bonus = soul_item_bonus + 1
        end
        if i == 20 and hero:HasModifier("modifier_item_ancient_elune") and hero.talents_clicked and hero.talents_clicked[i] and hero.talents_clicked[i] > 0 then
            soul_item_bonus = soul_item_bonus + 3
        end
        if i == 56 and hero:HasModifier("modifier_item_ancient_primary") and hero.talents_clicked and hero.talents_clicked[i] and hero.talents_clicked[i] > 0 then
            soul_item_bonus = soul_item_bonus + 1
        end
        if i == 49 and hero:HasModifier("modifier_item_ancient_grizzly") and hero.talents_clicked and hero.talents_clicked[i] and hero.talents_clicked[i] > 0 then
            soul_item_bonus = soul_item_bonus + 1
        end
        if i == 46 then
            if hero:HasModifier("modifier_item_crit_pure_immortal_2") then
                soul_item_bonus = soul_item_bonus + 2
            end
            soul_item_bonus = soul_item_bonus + hero.runeword[11]
        end
        if i == 55 then
            soul_item_bonus = soul_item_bonus + hero.runeword[10]
        end
        if i == 32 then
            soul_item_bonus = soul_item_bonus + hero.runeword[17]
        end
        if i == 69 then
            soul_item_bonus = soul_item_bonus + hero.runeword[8]
        end
        if i == 22 and hero:HasModifier("modifier_moonlighttiger") then
            soul_item_bonus = soul_item_bonus + 1
        end
        if i == 23 then
            soul_item_bonus = soul_item_bonus + hero.runeword[9]
        end
        if i == 29 then
            soul_item_bonus = soul_item_bonus + hero.runeword[21]
        end
        if (i == 39 or i == 40 or i == 42) and hero:HasModifier("modifier_ancient_def_wolf") then
            soul_item_bonus = soul_item_bonus + 2
        end
        if i == 73 and hero:HasModifier("modifier_item_rogueblades2") and hero:GetUnitName() == "npc_dota_hero_riki" then
            soul_item_bonus = soul_item_bonus + 1
        end
        local new_talent_value = hero.talents_clicked[i] + soul_item_bonus
        --new divine doubling soul items
        local pathbuff = "modifier_pathbuff_00"
        if i >= 10 then
            pathbuff = "modifier_pathbuff_0"
        end
        pathbuff = pathbuff..i
        if hero:HasModifier(pathbuff) then
            local pathbuff_factor = 2
            if i == 2 or i == 3 or i == 37 or i == 39 or i == 61 or i == 62 or i == 64 or i == 67 or i == 68 then
                pathbuff_factor = 3
            end
            if i == 15 or i == 16 or i == 61 or i == 17 then
                pathbuff_factor = 4
            end
            if i == -1 then
                pathbuff_factor = 5
            end
            --ravencraft fixes
            if i == 88 and not hero:HasModifier("modifier_path_088_ability_points") then
                --not activated gives 0 extra points
                pathbuff_factor = 1
            end
            if i == 88 and hero:HasModifier("modifier_path_088_ability_points") then
                hero.has_used_ravencraft_abilitypoint_item = true
            end
            new_talent_value = new_talent_value * pathbuff_factor
            path_word_bonus = path_word_bonus * pathbuff_factor
        end
        --update talent tree when it changes, for ALL players
        --new_talent_value = 0
        --if i == 86 then
        --	new_talent_value = 3
        --end
        if hero.talents[i] ~= new_talent_value then
            local id = hero:GetPlayerID()
            CustomGameEventManager:Send_ServerToAllClients("talentleveled", { playerid = id, talent = i, level = new_talent_value } )
        end
        hero.talents[i] = new_talent_value
        hero.talents_without_pathwords[i] = new_talent_value - path_word_bonus
        --tests
        --hero.talents[61] = 3
        local level = hero.talents[i]
        
        if level > 0 or i == 1 or i == 5 or i == 13 or i == 15 or i == 18 or i == 25 or i == 26 or i == 18 or i == 34 or i == 67 or (i == 25 and hero.runeword[2] > 0) 
                or i == 27 or (i == 30 and hero.runeword[10] > 0) then
            if i == 1 then
                --some buffs must be added first
                if (hero:HasModifier("modifier_invisible") or hero:HasModifier("modifier_oocmana")) and hero.talents and hero.talents[70] and hero.talents[70] > 0 then
                    local buff = "modifier_path_from_shadows"
                    ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = 14.9})
                end
                --end special priority
                local buff = "modifier_strength"
                hero:RemoveModifierByName(buff)
                local percent_bonus = 0.05 * level + 0.04 * hero.talents[38] + 0.03 * hero.talents[76]
                local static_bonus = hero.runeword[5] + hero.runeword[16] + 15 * hero.talents[84]
                if hero:HasModifier("modifier_temple_battlestance") then
                    percent_bonus = percent_bonus + 0.3
                end
                local froststr = hero:GetModifierStackCount("modifier_froststr", nil)
                if froststr > 0 then
                    percent_bonus = percent_bonus + 0.05 * froststr
                end
                local ghost3 = hero:FindAbilityByName("Ghost3")
                if ghost3 and ghost3:GetLevel() >= 4 then
                    percent_bonus = percent_bonus + 0.25
                end
                ghost3 = hero:FindAbilityByName("Switch_Battle_Stance")
                if ghost3 and ghost3:GetLevel() >= 2 then
                    percent_bonus = percent_bonus + 0.2
                end
                if hero.talents[63] and hero.talents[63] > 0 then
                    static_bonus = static_bonus + hero.talents[63] * 15
                end
                if hero.talents[46] and hero.talents[46] > 0 then
                    static_bonus = static_bonus + 15 * hero.talents[46]
                end
                if hero:GetPrimaryAttribute() == 0 then
                    static_bonus = static_bonus + primary_stats_static_bonus
                    percent_bonus = percent_bonus + primary_stats_percent_bonus
                end
                local total_str = hero:GetStrength() + static_bonus
                local value = total_str * percent_bonus + static_bonus
                if value >= 1 then
                    ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
                    hero:SetModifierStackCount(buff, ability, value)
                end
            end
            if i == 18 then
                local buff = "modifier_attackdamage"
                hero:RemoveModifierByName(buff)
                local percent_bonus = 0
                local static_bonus = hero.runeword[6]
                if hero:HasModifier("modifier_item_item_set_t4_aa_4") then
                    percent_bonus = percent_bonus + 0.1
                end
                if hero.talents[2] and hero.talents[2] > 0 then
                    static_bonus = static_bonus + hero.talents[2] * 25
                end
                if hero.talents[7] and hero.talents[7] > 0 then
                    static_bonus = static_bonus + (hero.talents[7] * 0.05 + 0.05) * hero:GetStrength()
                end
                if hero.talents[78] and hero.talents[78] > 0 then
                    percent_bonus = percent_bonus + 0.03 * hero.talents[78]
                end
                if hero.talents[80] and hero.talents[80] > 0 then
                    local bonusfromas = 50 * (hero:GetIncreasedAttackSpeed() - 5) * hero.talents[80]
                    if bonusfromas > 0 then
                        static_bonus = static_bonus + bonusfromas
                    end
                end
                if hero:HasModifier("modifier_pala_str_bonus_check") then
                    percent_bonus = percent_bonus + 0.4
                end
                if hero:HasModifier("modifier_temple_furystance") then
                    percent_bonus = percent_bonus + 0.25
                end
                local fury5 = hero:FindAbilityByName("fury5")
                if fury5 and fury5:GetLevel() >= 4 then
                    percent_bonus = percent_bonus + 0.25
                end
                local fury6 = hero:FindAbilityByName("fury6")
                if fury6 and fury6:GetLevel() >= 4 then
                    percent_bonus = percent_bonus + 0.2
                end
                local wind5 = hero:FindAbilityByName("wind5")
                if wind5 and wind5:GetLevel() >= 3 then
                    percent_bonus = percent_bonus + 0.2
                end
                if hero:HasModifier("modifier_temple_brawler_titan") then
                    percent_bonus = percent_bonus + 0.25
                end
                if hero:HasModifier("modifier_companion") and hero:HasModifier("modifier_item_hunterbow2") then
                    static_bonus = static_bonus + 150
                end
                if hero:HasModifier("modifier_beastrage") then
                    local beast4 = hero:FindAbilityByName("Beastrage")
                    if beast4 and beast4:GetLevel() <= 2 then
                        percent_bonus = percent_bonus + 0.2
                    else
                        percent_bonus = percent_bonus + 0.4
                    end
                end
                percent_bonus = percent_bonus + 0.05 * level
                local total_str = hero:GetAttackDamage() + static_bonus
                local value = total_str * percent_bonus + static_bonus
                if value > 0 then
                    ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
                    hero:SetModifierStackCount(buff, ability, value)
                    value = level * 250
                    ability:ApplyDataDrivenModifier(hero, hero, "modifier_autoattackdamage", {Duration = dur})
                    hero:SetModifierStackCount("modifier_autoattackdamage", ability, value)
                end
            end
            if i == 5 then
                local buff = "modifier_armor"
                hero:RemoveModifierByName(buff)
                local static_bonus = hero.runeword[3]
                local percent_bonus = 0.07 * level
                if hero.talents[33] and hero.talents[33] > 0 then
                    static_bonus = static_bonus + (0.5 + 0.25 * hero.talents[33]) * hero:GetMaxMana() / 1000
                end
                if hero:HasModifier("modifier_temple_defstance") then
                    percent_bonus = 0.5
                end
                if hero.talents[5] and hero.talents[5] > 0 and hero:GetPrimaryAttribute() == 0 then
                    static_bonus = static_bonus + 3 * hero.talents[5]
                end
                if hero.nearby_enemies and hero.talents[85] and hero.talents[85] > 0 then
                    local glaive_armor_factor = 1
                    local enemy_count = hero.nearby_enemies
                    local enemy_cap = 8
                    if not hero:IsRangedAttacker() then
                        enemy_cap = 12
                    end
                    if hero:HasModifier("modifier_pathbuff_085") then
                        glaive_armor_factor = 2
                    end
                    static_bonus = static_bonus + 0.33 * hero.talents[85] * enemy_count * glaive_armor_factor
                end
                local total_armor = hero:GetPhysicalArmorValue() + static_bonus
                local value = static_bonus + total_armor * percent_bonus
                ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
                hero:SetModifierStackCount(buff, ability, value)
            end
            if i == 10 then
                local buff = "modifier_health_armor"
                hero:RemoveModifierByName(buff)
                local value = level
                --if not hero:IsRangedAttacker() then
                --    value = value * 2
                --end
                ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
                hero:SetModifierStackCount(buff, ability, value)
            end
            if i == 49 then
                local buff = "modifier_aa_percent"
                hero:RemoveModifierByName(buff)
                local value = level
                ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
                hero:SetModifierStackCount(buff, ability, value)
            end
            if i == 13 then
                local buff = "modifier_agility"
                hero:RemoveModifierByName(buff)
                local percent_bonus = 0.05 * level + 0.04 * hero.talents[38] + 0.03 * hero.talents[76]
                local static_bonus = hero.runeword[1] + hero.runeword[16] + 15 * hero.talents[84]
                local hawk5 = hero:FindAbilityByName("hawk7")
                if hawk5 and hawk5:GetLevel() >= 4 then
                    percent_bonus = percent_bonus + 0.25
                end
                local bear6 = hero:FindAbilityByName("bear6")
                if bear6 and bear6:GetLevel() >= 4 then
                    percent_bonus = percent_bonus + 0.25
                end
                local feral1 = hero:GetModifierStackCount("modifier_furycat", nil)
                if feral1 > 0 and hero:HasModifier("modifier_npc_dota_hero_dazzle") then
                    percent_bonus = percent_bonus + 0.1 * feral1
                end
                if hero.agility_bonus_100 and hero.agility_bonus_100 > 0 then
                    percent_bonus = percent_bonus + 0.5
                end
                if hero:GetPrimaryAttribute() == 1 then
                    static_bonus = static_bonus + primary_stats_static_bonus
                    percent_bonus = percent_bonus + primary_stats_percent_bonus
                end
                if hero.talents[61] and hero.talents[61] > 0 then
                    static_bonus = static_bonus + hero.talents[61] * 0.05 * (hero:GetStrength() + hero:GetIntellect())
                end
                if hero.talents[46] and hero.talents[46] > 0 then
                    static_bonus = static_bonus + 15 * hero.talents[46]
                end
                local total_str = hero:GetAgility() + static_bonus
                local value = total_str * percent_bonus + static_bonus
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
                local static_bonus = level * 5
                if hero.talents[80] and hero.talents[80] > 0 then
                    static_bonus = static_bonus + 3 * hero.talents[80]
                end
                local value = static_bonus
                if value >= 1 then
                    ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
                    hero:SetModifierStackCount(buff, ability, value)
                end
            end
            if i == 15 then
                local buff = "modifier_attackspeed"
                hero:RemoveModifierByName(buff)
                local static_bonus = 0
                local frostdk6 = hero:FindAbilityByName("frostdk6")
                if frostdk6 and frostdk6:GetLevel() >= 4 then
                    static_bonus = static_bonus + hero:GetPhysicalArmorValue() * 5
                end
                if hero:HasModifier("modifier_class_am") and hero:HasModifier("modifier_asfury") then
                    static_bonus = static_bonus + hero:GetStrength()
                end
                if hero.talents[80] and hero.talents[80] > 0 then
                    static_bonus = static_bonus + 15 * hero.talents[80]
                end
                local value = level * 20 + static_bonus
                ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
                hero:SetModifierStackCount(buff, ability, value)
                --evasion
                if value > 0 then
                    value = level * 3
                    if value > 75 then
                        value = 75
                    end
                    ability:ApplyDataDrivenModifier(hero, hero, "modifier_evasion", {Duration = dur})
                    hero:SetModifierStackCount("modifier_evasion", ability, value)
                end
            end
            if i == 24 then
                local buff = "modifier_talent_crit"
                hero:RemoveModifierByName(buff)
                local value = level * 2 -- + hero.runeword[8]
                ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
                hero:SetModifierStackCount(buff, ability, value)
                --shield buff
                local refresh_base_time = 45
                if not hero:IsRangedAttacker() then
                    refresh_base_time = 30
                end
                local refresh_time = refresh_base_time - hero:GetAgility() / 50
                if hero.moonglaive_shield then
                    hero.moonglaive_shield = hero.moonglaive_shield + 5
                    if hero.moonglaive_shield >= refresh_time then
                        hero.moonglaive_shield = hero.moonglaive_shield - refresh_time
                        --print(hero.moonglaive_shield)
                        local myevent = {}
                        myevent.caster = hero
                        myevent.target = hero
                        myevent.buff = "modifier_talent_moonglaive_shield"
                        myevent.ability = ability
                        myevent.addstacks = 1
                        local max_stack = 3
                        myevent.max = max_stack
                        ApplyBuffStack(myevent)
                    end
                else
                    hero.moonglaive_shield = 5
                end
            end
            --[[
            if i == 19 then
                local buff = "modifier_evasion"
                hero:RemoveModifierByName(buff)
                local value = level
                ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
                hero:SetModifierStackCount(buff, ability, value)
            end
            ]]
            if i == 20 then
                local buff = "modifier_stand_still"
                ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
            end
            if i == 23 then
                local buff = "modifier_aa_starfall"
                hero:RemoveModifierByName(buff)
                local value = level
                ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
                hero:SetModifierStackCount(buff, ability, value)
            end
            if i == 25 then
                local buff = "modifier_intellect"
                hero:RemoveModifierByName(buff)
                local percent_bonus = 0.05 * level + 0.03 * hero.talents[76]
                local static_bonus = hero.runeword[2] + 15 * hero.talents[84]
                local ghost2 = hero:FindAbilityByName("Ghost2")
                if ghost2 and ghost2:GetLevel() >= 3 then
                    percent_bonus = percent_bonus + 0.25
                end
                if hero.talents[35] and hero.talents[35] > 0 then
                    static_bonus = static_bonus + 25 * hero.talents[35]
                end
                if hero:GetPrimaryAttribute() == 2 then
                    static_bonus = static_bonus + primary_stats_static_bonus
                    percent_bonus = percent_bonus + primary_stats_percent_bonus
                end
                local total_str = hero:GetIntellect() + static_bonus
                local value = total_str * percent_bonus + static_bonus
                if value >= 1 then
                    ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
                    hero:SetModifierStackCount(buff, ability, value)
                end
            end
            if i == 26 then
                local percent_bonus = 0.03 * level
                if not hero.resourcesystem then --mana user
                    if hero.talents[74] and hero.talents[74] > 0 and not hero:HasModifier("modifier_oocmana") then
                        if hero:GetMana() / hero:GetMaxMana() > 0.25 then
                            percent_bonus = percent_bonus - 0.15
                            hero.path_sacrifice_souls_paid = 4
                        else
                            hero.path_sacrifice_souls_paid = false
                        end
                    end
                else
                    hero.path_sacrifice_souls_paid = 4 --energy users dont pay here
                end
                if hero:HasModifier("modifier_item_item_set_t4_int_4") then
                    percent_bonus = percent_bonus + 0.05
                end
                if percent_bonus ~= 0 then
                    local value = hero:GetMaxMana() * percent_bonus
                    local myevent = {caster = hero, target = hero, amount = value}
                    RestoreMana(myevent)
                end
            end
            if i == 58 then
                if not hero:HasModifier("modifier_oocmana") and hero:GetHealth() / hero:GetMaxHealth() >= 0.65 then
                    hero:SetHealth(hero:GetHealth() - hero:GetMaxHealth() * 0.15)
                    hero.lifeblood = 1 + 0.1 * level
                    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_bloodseeker/bloodseeker_rupture_nuke.vpcf", PATTACH_POINT_FOLLOW, hero)
                    ParticleManager:ReleaseParticleIndex(particle)
                    ability:ApplyDataDrivenModifier(hero, hero, "modifier_talent_lifeblood", {Duration = 5})
                    AddHeroResource({caster = hero, amount = 2 * level, percent = true, energy = 5 * level, energypercent = true})
                end
            end
            if i == 27 then
                local buff = "modifier_spellres"
                hero:RemoveModifierByName(buff)
                local value = level * 5 + hero.runeword[4]
                if value >= 1 then
                    ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
                    hero:SetModifierStackCount(buff, ability, value)
                end
            end
            --if i == 29 then
            --    local buff = "modifier_cast_firenova"
            --    hero:RemoveModifierByName(buff)
            --    local value = level
            --    ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
            --    hero:SetModifierStackCount(buff, ability, value)
            --end
            --[[
            if i == 30 then
                local buff = "modifier_talent_blizzard"
                hero:RemoveModifierByName(buff)
                local value = level
                ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = 0.1})
                hero:SetModifierStackCount(buff, ability, value)
            end]]
            if i == 34 then
                local buff = "modifier_talent_manasp"
                hero:RemoveModifierByName(buff)
                local percent_bonus = level * 0.03
                if hero:HasModifier("modifier_nether_explosion_buff") then
                    percent_bonus = percent_bonus + 0.25
                end
                local holy6 = hero:FindAbilityByName("holy6")
                if holy6 and holy6:GetLevel() >= 3 then
                    percent_bonus = percent_bonus + 0.25
                end
                local value = percent_bonus * hero:GetMaxMana()
                ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
                hero:SetModifierStackCount(buff, ability, value)
            end
            if i == 39 then
                local value = level
                local fixedheal = 75 * level
                local myevent = {caster = hero, target = hero, percenthp = value, heal = fixedheal, ability = ability}
                HealUnit(myevent)
            end
            if i == 40 then
                local buff = "modifier_health_path"
                hero:RemoveModifierByName(buff)
                local value = level
                ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
                hero:SetModifierStackCount(buff, ability, value)
            end
            --[[if i == 43 then
                local buff = "modifier_aa_minus_armortalent"
                hero:RemoveModifierByName(buff)
                local value = level
                ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
                hero:SetModifierStackCount(buff, ability, value)
            end]]
            if i == 46 then
                local buff = "modifier_talent_beastmaster"
                hero:RemoveModifierByName(buff)
                local value = level
                ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
                hero:SetModifierStackCount(buff, ability, value)
            end
            if i == 21 then
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
                local max_stack = 10
                if hero:HasModifier("modifier_item_ancient_elune") then
                    max_stack = 15
                end
                myevent.max = max_stack
                ApplyBuffStack(myevent)
            end
            if i == 65 then
                if not hero:HasModifier("modifier_oocmana") then
                    local buff = "modifier_movement_minus"
                    hero:RemoveModifierByName(buff)
                    local value = 15
                    ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
                    hero:SetModifierStackCount(buff, ability, value)
                end
            end
            if i == 67 then
                local buff = "path_health_buff"
                hero:RemoveModifierByName(buff)
                local percent_bonus = level * 0.07
                local static_bonus = 0
                if hero:HasModifier("modifier_item_item_set_t4_str_4") then
                    percent_bonus = percent_bonus + 0.2
                end
                if hero:HasModifier("modifier_voidhp") then
                    percent_bonus = percent_bonus + 0.15
                end
                --if hero.talents[12] and hero.talents[12] > 0 then
                --    percent_bonus = percent_bonus + 0.04 * hero.talents[12]
                --end
                if hero.talents[65] and hero.talents[65] > 0 then
                    static_bonus = static_bonus + 300 * hero.talents[65]
                end
                if hero.talents[14] and hero.talents[14] > 0 then
                    if hero:IsRangedAttacker() then
                        static_bonus = static_bonus + hero:GetAgility() * (2 + hero.talents[14])
                    else
                        static_bonus = static_bonus + hero:GetAgility() * (4 + hero.talents[14])
                    end
                end
                if hero.talents[3] and hero.talents[3] > 0 then
                    static_bonus = static_bonus + hero:GetStrength() * (2 + hero.talents[3])
                end
                if hero:HasModifier("modifier_pathbuff_084") then
                    static_bonus = static_bonus + 2 * (hero:GetStrength() + hero:GetAgility() + hero:GetIntellect())
                end
                local beast6 = hero:FindAbilityByName("Bear")
                if beast6 and beast6:GetLevel() >= 4 then
                    percent_bonus = percent_bonus + 0.25 * GetCompanionAndPetCount(hero)
                end
                local bear2 = hero:FindAbilityByName("bear2")
                if bear2 and bear2:GetLevel() >= 4 then
                    percent_bonus = percent_bonus + 0.15
                end
                local bear6 = hero:FindAbilityByName("bear6")
                if bear6 and bear6:GetLevel() >= 4 then
                    static_bonus = static_bonus + hero:GetAgility() * 15
                end
                local value = math.floor(static_bonus + percent_bonus * (hero:GetMaxHealth() + static_bonus))
                if value > 0 then
                    local modifier = hero:AddNewModifier(hero, ability, 'path_health_buff', {Duration = dur})
                    modifier:SetStackCount(value)
                end
            end
            if i == 85 then
                local buff = "modifier_feastcrow"
                hero:RemoveModifierByName(buff)
                local value = CountNearbyEnemies(hero, 900)
                ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
                hero:SetModifierStackCount(buff, ability, value)
                if value >= 4 then
                	PathFeastForCrowsAOE(hero)
                end
            end
            if i == 88 then
                if not hero.path_all_knowing_crow_points_given then
                    hero.path_all_knowing_crow_points_given = 0
                end
                if level > hero.path_all_knowing_crow_points_given then
                    local missing_points = level - hero.path_all_knowing_crow_points_given
                    hero:SetAbilityPoints(hero:GetAbilityPoints() + missing_points)
                    hero.path_all_knowing_crow_points_given = hero.path_all_knowing_crow_points_given + missing_points
                end
            end
        end
    end
    --new penalties to counter base stat gains
    if COverthrowGameMode.version >= 2 then
        --[[
        local strength = hero:GetStrength()
        local penalty = strength
        local buff = "modifier_health_penalty"
        hero:RemoveModifierByName(buff)
        if penalty >= 1 then
            ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
            hero:SetModifierStackCount(buff, ability, penalty)
        end
        ]]
        --print(hero.talents[19])
        local agility = hero:GetAgility()
        local penalty = agility * 0.103 --0.1228
                           -- 0.076 = 1armor per 15
        if hero.talents and hero.talents[19] and hero.talents[19] > 0 then
            local factor_melee_ranged = 0.006
            if not hero:IsRangedAttacker() then
                factor_melee_ranged = factor_melee_ranged * 1.25
            end
            penalty = penalty - factor_melee_ranged * hero.talents[19] * agility
        end
        local buff = "modifier_armor_penalty"
        hero:RemoveModifierByName(buff)
        if penalty >= 1 then
            ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
            hero:SetModifierStackCount(buff, ability, penalty)
        end
        penalty = agility * 49/50
        buff = "modifier_attackspeed_penalty"
        hero:RemoveModifierByName(buff)
        if penalty >= 1 then
            ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
            hero:SetModifierStackCount(buff, ability, penalty)
        end
        --counter dota 7.07 int spell res
        --[[
        if hero:GetPrimaryAttribute() == 0 then
            penalty = hero:GetStrength() * 0.15
            buff = "modifier_status_res_penalty"
            hero:RemoveModifierByName(buff)
            if penalty >= 1 then
                ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
                hero:SetModifierStackCount(buff, ability, penalty)
            end
        end]]
        if hero:GetPrimaryAttribute() == 0 then
            penalty = hero:GetStrength()
            buff = "modifier_str_custom"
            if penalty >= 1 then
                ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
                hero:SetModifierStackCount(buff, ability, penalty)
            end
            buff = "modifier_str_custom_penalty"
            if penalty >= 1 then
                ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
                hero:SetModifierStackCount(buff, ability, penalty)
            end
        end
        if hero:GetPrimaryAttribute() == 1 then
            penalty = hero:GetAgility() * 0.06
            buff = "modifier_ms_penalty"
            hero:RemoveModifierByName(buff)
            if penalty >= 1 then
                ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
                hero:SetModifierStackCount(buff, ability, penalty)
            end
        end
        if hero:GetPrimaryAttribute() == 2 then
            penalty = hero:GetIntellect()
            buff = "modifier_int_custom"
            if penalty >= 1 then
                ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
                hero:SetModifierStackCount(buff, ability, penalty)
            end
            buff = "modifier_int_custom_penalty"
            if penalty >= 1 then
                ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
                hero:SetModifierStackCount(buff, ability, penalty)
            end
        end
        
        --[[local intellect = hero:GetIntellect()
        penalty = intellect * 0.04
        buff = "modifier_mana_regen_penalty"
        hero:RemoveModifierByName(buff)
        if penalty >= 1 then
            ability:ApplyDataDrivenModifier(hero, hero, buff, {Duration = dur})
            hero:SetModifierStackCount(buff, ability, penalty)
        end]]
    end
    hero:CalculateStatBonus()
end

function GetIntellectCustom( hero )
    if hero:GetPrimaryAttribute() == 2 then
        return hero:GetModifierStackCount("modifier_int_custom", nil)
    else
        return hero:GetIntellect()
    end
end

function GetStrengthCustom( hero )
    if hero:GetPrimaryAttribute() == 0 then
        return hero:GetModifierStackCount("modifier_str_custom", nil)
    else
        return hero:GetStrength()
    end
end

function GetPrimaryStatValueCustom( hero )
    if hero:GetPrimaryAttribute() == 2 then
        return GetIntellectCustom( hero )
    elseif hero:GetPrimaryAttribute() == 0 then
    	return GetStrengthCustom( hero )
    else
        return hero:GetPrimaryStatValue()
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

function IsImmortal(hero)
    if hero:HasModifier("modifier_godschosen") or hero:HasModifier("modifier_invul") or hero:HasModifier("modifier_eternallife") or hero:HasModifier("modifier_totem_life_buff") or hero:HasModifier("modifier_last_stand")
         or hero:HasModifier("modifier_shieldreflect") then
        return true
    end
    return false
end

function SetElementalItem(event)
    event.caster.elemental_item3 = event.ability
end

function AddAbilityToUnit(event)
    local caster = event.target
    local level = 1
    if COverthrowGameMode.jungledifficulty >= 10 then
        level = 2
    end
    if COverthrowGameMode.jungledifficulty >= 100 then
        level = 3
    end
    caster:AddAbility(event.abil):SetLevel(level)
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
    ParticleManager:ReleaseParticleIndex(particle)
    pos = pos + Vector(distance,0,0)
    particle = ParticleManager:CreateParticle("particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_explosion.vpcf", PATTACH_WORLDORIGIN, caster)
    ParticleManager:SetParticleControl(particle, 0, pos)
    ParticleManager:ReleaseParticleIndex(particle)
    pos = pos + Vector(-2*distance,0,0)
    particle = ParticleManager:CreateParticle("particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_explosion.vpcf", PATTACH_WORLDORIGIN, caster)
    ParticleManager:SetParticleControl(particle, 0, pos)
    ParticleManager:ReleaseParticleIndex(particle)
    pos = pos + Vector(distance,distance,0)
    particle = ParticleManager:CreateParticle("particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_explosion.vpcf", PATTACH_WORLDORIGIN, caster)
    ParticleManager:SetParticleControl(particle, 0, pos)
    ParticleManager:ReleaseParticleIndex(particle)
    pos = pos + Vector(0,-2*distance,0)
    particle = ParticleManager:CreateParticle("particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_explosion.vpcf", PATTACH_WORLDORIGIN, caster)
    ParticleManager:SetParticleControl(particle, 0, pos)
    ParticleManager:ReleaseParticleIndex(particle)
    EmitSoundOn("hero_Crystal.preAttack", caster)
end

function BlizzardTalent( caster, target, event )
    caster.talent_30_cd = true
    local delay = 0.25
    local aoe = 300
    local event = {target = target, aoe = 300}
    BlizzardEffect(event)
    event = {caster = caster, target = target, ability = caster.combat_system_ability, targetpos = 1, damage = 0, attributefactor = 100*caster.talents[30], aoe = aoe, targeteffect = "blood", isaoe = 1, delay = delay, dontbreakcc = 1, frostdmg = 1 }
    DamageAOEDelayed( event )
    Timers:CreateTimer(delay, function()
        EmitSoundOn("hero_Crystal.freezingField.explosion", caster)
        local buffevent = { caster = caster, target = target, ability = caster.combat_system_ability, aoe = aoe, targetpos = 1, buff = "modifier_slowtalent", dur = 5}
        ApplyBuffAOE(buffevent)
    end)
    Timers:CreateTimer(5, function()
        caster.talent_30_cd = nil
    end)
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
    if event.theme == "water2" then
        aoefx = "particles/econ/items/kunkka/kunkka_immortal/kunkka_immortal_ghost_ship_impact.vpcf"
        sound = "hero_Crystal.projectileImpact"--"Ability.GushCast"
        warningfxpath = "particles/econ/items/kunkka/divine_anchor/hero_kunkka_dafx_skills/kunkka_spell_torrent_splash_fxset.vpcf"
    end
    if event.theme == "frost" then
        aoefx = "particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_explosion.vpcf"
        sound = "hero_Crystal.projectileImpact"
        warningfxpath = "particles/econ/items/crystal_maiden/crystal_maiden_cowl_of_ice/maiden_crystal_nova_cowlofice.vpcf"
    end
    if event.theme == "thunder" then
        aoefx = "particles/units/heroes/hero_zeus/zeus_cloud_strike.vpcf"
        sound = "Item.Maelstrom.Chain_Lightning.Jump"
        warningfxpath = "particles/econ/items/crystal_maiden/crystal_maiden_cowl_of_ice/maiden_crystal_nova_cowlofice.vpcf"
    end
    if event.theme == "frost_big" then
        aoefx = "particles/econ/items/crystal_maiden/crystal_maiden_cowl_of_ice/maiden_crystal_nova_cowlofice.vpcf"
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
        ParticleManager:ReleaseParticleIndex(particle)
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
                        ParticleManager:ReleaseParticleIndex(particle)
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
                        local degree = offset_start+i*20
                        local rad = math.rad(offset_start+i*20)
                        local cos = math.cos(degree)
                        strikepos = strikepos + Vector((lifetimeinticks-i)*movement*math.cos(math.rad(offset_start+i*20)), (lifetimeinticks-i)*movement*math.sin(math.rad(offset_start+i*20)), 0)
                        local particle = ParticleManager:CreateParticle(aoefx, PATTACH_WORLDORIGIN, caster)
                        ParticleManager:SetParticleControl(particle, 0, strikepos)
                        ParticleManager:SetParticleControl(particle, 1, Vector(aoe,aoe,aoe))
                        ParticleManager:ReleaseParticleIndex(particle)
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
                        ParticleManager:ReleaseParticleIndex(particle)
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
                        ParticleManager:ReleaseParticleIndex(particle)
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
                local path_direction = Vector(0,0,0) + RandomVector(1)
                for i=1, lifetimeinticks do
                    Timers:CreateTimer(tickdelay*(i-1), function()
                        strikepos = strikepos + movement*path_direction
                        local particle = ParticleManager:CreateParticle(aoefx, PATTACH_WORLDORIGIN, caster)
                        ParticleManager:SetParticleControl(particle, 0, strikepos)
                        ParticleManager:SetParticleControl(particle, 1, Vector(aoe,aoe,aoe))
                        ParticleManager:ReleaseParticleIndex(particle)
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
            if aoetype == "circleoutin" then
                local offset_start = math.random(0,359)
                local strikepos = pos
                local distance = 0
                local distance_per_tick = 30
                local angle = 0
                local angle_per_tick = 15
                local path_direction = Vector(0,0,0) + RandomVector(1)
                for i=1, lifetimeinticks do
                    Timers:CreateTimer(tickdelay*(i-1), function()
                        distance = distance + distance_per_tick
                        angle = angle + angle_per_tick
                        if i == math.floor(lifetimeinticks / 2) then
                            distance_per_tick = -1 * distance_per_tick
                        end
                        strikepos = pos + RotateVectorAroundAngle(Vector(1,0,0), angle) * distance
                        local particle = ParticleManager:CreateParticle(aoefx, PATTACH_WORLDORIGIN, caster)
                        ParticleManager:SetParticleControl(particle, 0, strikepos)
                        ParticleManager:SetParticleControl(particle, 1, Vector(aoe,1,1))
                        ParticleManager:ReleaseParticleIndex(particle)
                        EmitSoundOn(sound, caster)
                        local tab = {}
                        tab.caster = caster
                        tab.damage = 0.0
                        tab.spelldamagefactor = 0.0
                        tab.attributefactor = 0.0
                        tab.includeauto = dmg
                        tab.ability = ability
                        tab.aoe = event.aoe
                        tab.targeteffect = "blood"
                        tab.onlyhero = 1
                        tab.target_points = {}
                        tab.target_points[1] = strikepos
                        DamageAOE(tab)
                    end)
                end
            end
            if aoetype == "forwardandcircle" then
                local startpos = pos - caster:GetForwardVector() * 2000
                local radius = 650
                local angle = 0
                local angle_per_tick = 25
                local forward_per_tick = 25
                local path_direction = (pos - startpos):Normalized()
                lifetimeinticks = 150
                tickdelay = 0.2
                for i=1, lifetimeinticks do
                    Timers:CreateTimer(tickdelay*(i-1), function()
                        angle = angle + angle_per_tick
                        local strikepos = startpos + RotateVectorAroundAngle(Vector(1,0,0), angle) * radius + path_direction * i * forward_per_tick
                        local particle = ParticleManager:CreateParticle(aoefx, PATTACH_WORLDORIGIN, caster)
                        ParticleManager:SetParticleControl(particle, 0, strikepos)
                        ParticleManager:SetParticleControl(particle, 3, strikepos)
                        --ParticleManager:SetParticleControl(particle, 1, Vector(aoe,1,1))
                        ParticleManager:ReleaseParticleIndex(particle)
                        EmitSoundOn(sound, caster)
                        local tab = {}
                        tab.caster = caster
                        tab.damage = 0.0
                        tab.spelldamagefactor = 0.0
                        tab.attributefactor = 0.0
                        tab.includeauto = dmg
                        tab.ability = ability
                        tab.aoe = event.aoe
                        tab.targeteffect = "blood"
                        tab.onlyhero = 1
                        tab.target_points = {}
                        tab.target_points[1] = strikepos
                        DamageAOE(tab)
                    end)
                end
            end
            if aoetype == "forwardrandom" then
                local strikepos = pos
                local path_direction = Vector(0,0,0) + RandomVector(1)
                local angle_max = 15
                movement = 50
                for i=1, lifetimeinticks do
                    Timers:CreateTimer(tickdelay*(i-1), function()
                        strikepos = strikepos + movement*path_direction
                        path_direction = RotateVectorAroundAngle(path_direction, math.random(-angle_max, angle_max))
                        angle_max = angle_max + 3
                        local particle = ParticleManager:CreateParticle(aoefx, PATTACH_WORLDORIGIN, caster)
                        ParticleManager:SetParticleControl(particle, 0, strikepos)
                        ParticleManager:SetParticleControl(particle, 1, strikepos + Vector(0,0,450))
                        ParticleManager:SetParticleControl(particle, 6, Vector(1,1,1))
                        ParticleManager:ReleaseParticleIndex(particle)
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
        event.ability:ApplyDataDrivenModifier(caster, target, event.buff, {Duration = event.dur})
    end
end

function TalentOnAttacked( event )
    local caster = event.caster
    local attacker = event.attacker
    --[[
    if caster.talents then
        if and caster.talents[12] and caster.talents[12] > 0 then
            local talent_level = caster.talents[12]
            if not caster:HasModifier("modifier_talent12cd") and caster ~= attacker then
                caster.combat_system_ability:ApplyDataDrivenModifier(caster, caster, "modifier_talent12cd", { Duration = 85-5*caster.talents[12]})
                local particle = ParticleManager:CreateParticle("particles/items_fx/necronomicon_spawn_warrior.vpcf", PATTACH_POINT_FOLLOW, attacker)
                ParticleManager:ReleaseParticleIndex(particle)
                local myevent = {}
                myevent.caster = caster
                myevent.target = attacker
                myevent.ability = event.ability
                myevent.damage = 0.0
                myevent.spelldamagefactor = 0.0
                myevent.attributefactor = 0.0
                myevent.counterblow = 100
                DamageUnit(myevent)
                local myevent2 = {}
                myevent2.caster = caster
                myevent2.target = attacker
                myevent2.buff = "modifier_stunned"
                myevent2.ability = event.ability
                myevent2.dur = 6
                ApplyBuff(myevent2)
                --caster.path_counterclaw = true
                --Timers:CreateTimer(15, function()
                --    caster.path_counterclaw = false
                --end)
            end
        end
    end]]
end

function TalentOnAttack( event )
    local caster = event.caster
    local target = event.target
    local ability = event.ability
    local has_windfury_item = (caster:HasModifier("modifier_item_windfury") or caster:HasModifier("modifier_item_windfury_2"))
    caster.last_attack_target = target
    --aa stats tracking
    if caster.ability_stats then
        if not caster.ability_stats[6] then
            caster.ability_stats[6] = 0
        end
        caster.ability_stats[6] = caster.ability_stats[6] + event.damage
    end
    if caster.talents then
        if caster.talents[53] and caster.talents[53] > 0 and not caster.talent_cd_53 then
            local talent_level = caster.talents[53]
            local windfury_attacks = 2
            if has_windfury_item then
                windfury_attacks = windfury_attacks + 1
            end
            local bonus_chances = 1
            if caster:HasModifier("modifier_pathbuff_071") and caster:HasModifier("modifier_path_overwhelm") then
                bonus_chances = 2
            end
            if math.random(1,100) <= talent_level * 2 * bonus_chances then
                local wind_master = 1
                if caster:HasModifier("modifier_pathbuff_053") and caster:HasModifier("modifier_windbreaker") then
                    wind_master = 2
                end
                ApplyBuffStack({caster = caster, target = caster, ability = caster.combat_system_ability, dur = 5, buff = "modifier_windfury_path", addstacks = talent_level * wind_master, max = talent_level * wind_master})
                caster.talent_cd_53 = true
                local particle = ParticleManager:CreateParticle("particles/econ/items/sven/sven_ti7_sword/sven_ti7_loadout_burst.vpcf", PATTACH_POINT_FOLLOW, caster)
                ParticleManager:ReleaseParticleIndex(particle)
                local delay = 0
                if caster:IsRangedAttacker() then
                    windfury_attacks = windfury_attacks + 1
                    delay = 1
                end
                for i=1, windfury_attacks do
                    Timers:CreateTimer(0.15*(i-delay), function()
                        caster:PerformAttack(target, true, true, true, true, true, false, false)
                    end)
                end
                Timers:CreateTimer(1, function()
                    caster.talent_cd_53 = false
                end)
            end
        end
        if caster.talents[78] and caster.talents[78] > 0 then
            ApplyBuffStack({caster = caster, target = caster, ability = ability, dur = 30, buff = "modifier_stormclaws", max = 5})
        end
        if caster.talents[87] and caster.talents[87] > 0 then
            local storm_harpy_chance = 8
            if caster:HasModifier("modifier_pathbuff_007") and caster:GetModifierStackCount("modifier_talent_maul", nil) >= 25 then
                storm_harpy_chance = storm_harpy_chance + 5
            end
            if caster.storm_harpy_non_proc_counter and caster.storm_harpy_non_proc_counter >= 15 then
                storm_harpy_chance = 100
            end
            if math.random(1,100) <= storm_harpy_chance then
                caster.storm_harpy_non_proc_counter = 0
                caster.combat_system_ability:ApplyDataDrivenModifier(caster, caster, "modifier_stormharpy", {Duration = 5})
                local resistance = 10 + 5 * caster.talents[87]
                if resistance > 75 then
                    resistance = 75
                end
                caster:SetModifierStackCount("modifier_stormharpy", caster.combat_system_ability, resistance)
                PathChainLightning({caster = caster, target = target, ability = ability})
            else
                if caster:HasModifier("modifier_item_helmthunder2") then
                    if caster.storm_harpy_non_proc_counter then
                        caster.storm_harpy_non_proc_counter = caster.storm_harpy_non_proc_counter + 1
                    else
                        caster.storm_harpy_non_proc_counter = 1
                    end
                end
            end
        end
    end
    if caster and has_windfury_item and not caster.item_windfury then
        caster.item_windfury = true
        local particle = ParticleManager:CreateParticle("particles/econ/items/sven/sven_ti7_sword/sven_ti7_loadout_burst.vpcf", PATTACH_POINT_FOLLOW, caster)
        ParticleManager:ReleaseParticleIndex(particle)
        if caster.item_windfury_ability_1 and not caster.item_windfury_ability_1:IsNull() then
            caster.item_windfury_ability_1:StartCooldown(10)
        end
        if caster.item_windfury_ability_2 and not caster.item_windfury_ability_2:IsNull() then
            caster.item_windfury_ability_2:StartCooldown(10)
        end
        local strikes = 2
        if caster:IsRangedAttacker() then
            strikes = 3
        end
        for i=1,strikes do
            Timers:CreateTimer(0.15*i, function()
                caster.windfury_proc_crit_bonus = true
                caster:PerformAttack(target, true, true, true, true, true, false, false)
                if i == strikes then
                    Timers:CreateTimer(0.25, function() --some extra time for projectiles to fly
                        caster.windfury_proc_crit_bonus = false
                    end)
                end
            end)
        end
        Timers:CreateTimer(10, function()
            caster.item_windfury = nil
        end)
    end
end

function Multistrike( event )
    for i=1,event.hits do
        Timers:CreateTimer(0.15*i, function()
            if not event.caster:IsRangedAttacker() and event.target and not event.target:IsNull() then
                local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_bloodseeker/bloodseeker_rupture_nuke.vpcf", PATTACH_POINT_FOLLOW, event.target)
                ParticleManager:ReleaseParticleIndex(particle)
                 EmitSoundOn("DOTA_Item.DiffusalBlade.Activate", event.target)
            end
            if event.target and not event.target:IsNull() then
                event.caster:PerformAttack(event.target, true, true, true, true, true, false, false)
            end
        end)
    end
end

function SetWindfuryItem( event )
    if event.id == 1 then
        event.caster.item_windfury_ability_1 = event.ability
    end
    if event.id == 2 then
        event.caster.item_windfury_ability_2 = event.ability
    end
end

function SetBloodlustItem( event )
    event.caster.item_bloodlust_ability = event.ability
end

function SetArmorKnowledgeItem( event )
    event.caster.item_armor_knowledge_ability = event.ability
end

function SetHorrorItem( event )
    event.caster.item_horror_ability = event.ability
end

function SetMultiElementItem( event )
    event.caster.item_multi_element_ability = event.ability
end

function DH2( event )
    local caster = event.caster
    local target = caster.last_attack_target
    if target and not target:IsNull() and target:IsAlive() and caster.Energy and caster.Energy >= 50 and (caster:GetAbsOrigin()-target:GetAbsOrigin()):Length() <= 175 then
        event.ability:ApplyDataDrivenModifier(caster, target, "modifier_dh2_toggle_proc", nil)
    end
end

function OnApplyDebuff(event)
    local caster = event.caster
    local target = event.target
    if false and caster.talents and caster.talents[49] and caster.talents[49] > 0 then
        local myevent = {}
        myevent.caster = caster
        myevent.target = target
        myevent.ability = event.ability
        myevent.damage = 0.0
        myevent.spelldamagefactor = 0.0
        myevent.attributefactor = 20 * caster.talents[49]
        Timers:CreateTimer(0.01*math.random(25,75), function()
            DamageUnit(myevent)
        end)
    end
end

function GetSoulItemTalent(hero)
    local result = {{0,0},{0,0},{0,0}}
    local has_ravencraft_abilitypoint_soul_equipped = false
    for i=1,3 do
        local item = hero:GetItemInSlot(5+i)
        if item and not item:IsMuted() then
            item = item:GetName()
            --print(item)
            if item and string.len(item) == 20 and string.sub(item, 1, 13) == "item_mastery_" then
                local talent = tonumber(string.sub(item, 14, 16))
                local talent_level = tonumber(string.sub(item, 18, 20))
                if talent_level and talent_level > 1 and talent and (talent == 28) then
                    talent_level = 1
                end
                local talent_tree = COverthrowGameMode:GetTalentTreeByTalentPoint( talent )
                if talent_tree and hero:HasModifier("modifier_path_soul_bonus_" .. tostring(talent_tree)) then
                    talent_level = talent_level + 1
                end
                --riki +1 talent
                riki_talent = hero:FindAbilityByName("hawk2")
                if i == 1 and riki_talent and riki_talent:GetLevel() >= 4 then
                    talent_level = talent_level + 1
                end
                if talent == 88 then
                    hero.has_used_ravencraft_abilitypoint_soul = true
                    has_ravencraft_abilitypoint_soul_equipped = true
                end
                result[i] = {talent, talent_level }
            end
        end
    end
    if hero.has_used_ravencraft_abilitypoint_soul and not has_ravencraft_abilitypoint_soul_equipped then
        return {{0,0},{0,0},{0,0}}
    end
    return result
end

function AddHeroResource(event)
    local hero = event.caster
    if event.buffcondition and not hero:HasModifier(event.buffcondition) then
        return
    end
    if hero.resourcesystem and hero.resourcesystem > 0 then
        --non mana user
        if event.energypercent then
            event.energy = GetMaxEnergy(event)  * event.energy / 100
        end
        AddEnergy(event)
    else
        --mana user
        RestoreMana(event)
    end
end

function SpikeTrapActivate( event )
    local caster = event.caster
    local ability = event.ability
    --local triggerName = "temple_spike_trap" --caster:GetName()
    --local spikes = triggerName .. "_model"
    if not caster.trap_cooldown then
        ability:ApplyDataDrivenModifier(caster, caster, "modifier_dmg_aoe_trap", nil)
        caster.trap_cooldown = true
        --StartAnimation(caster, {activity=ACT_DOTA_CAST_ABILITY_4, duration=2.0, rate=0.5})
        --EmitSoundOn( "Conquest.SpikeTrap.Plate" , caster)
        --DoEntFire( spikes, "SetAnimation", "spiketrap_activate", 0, self, self )
        Timers:CreateTimer(2, function()
            caster.trap_cooldown = nil
        end)
    end
end

function MissileTrapActivate( event )
    local caster = event.caster
    if not IsEnemyInRange(caster, 5000) then
        return
    end
    local ability = event.ability
    local activate_every = 3
    local missile_fx = "particles/fireball_linear_4.vpcf"
    local sound = "Hero_Lina.PreAttack"
    local distance = 3500
    local speed = 900
    local aoe = 0
    local width = 75
    local width_end = 75
    local cone = false
    local turnspeed = 0
    if caster.trap_element and caster.trap_element == "shadow" then
        missile_fx = "particles/fireball_linear_4.vpcf"
        activate_every = 6
    end
    if caster.trap_element and caster.trap_element == "shadowshort" then
        missile_fx = "particles/fireball_linear_4.vpcf"
        activate_every = 6
        distance = 1500
        speed = 600
    end
    if caster.trap_element and caster.trap_element == "water" then
        missile_fx = "particles/units/heroes/hero_morphling/morphling_waveform.vpcf"
        distance = 6000
        speed = 750
    end
    if caster.trap_element and caster.trap_element == "ice" then
        missile_fx = "particles/units/heroes/hero_tusk/tusk_ice_shards_projectile.vpcf"
    end
    if caster.trap_element and caster.trap_element == "poison" then
        missile_fx = "particles/units/heroes/hero_venomancer/venomancer_venomous_gale.vpcf"
        activate_every = 10
    end
    if caster.trap_element and caster.trap_element == "5darts" then
        missile_fx = "particles/units/heroes/hero_windrunner/windrunner_spell_powershot.vpcf"
        aoe = 5
        speed = 600 --900
    end
    if caster.trap_element and caster.trap_element == "3skulls" then
        missile_fx = "particles/fireball_linear_5.vpcf"
        activate_every = 2
        distance = 2000
        speed = 400 --500
        aoe = 3
    end
    if caster.trap_element and caster.trap_element == "1fire" then
        missile_fx = "particles/units/heroes/hero_dragon_knight/dragon_knight_breathe_fire.vpcf"
        sound = "Hero_Lina.DragonSlave"
        distance = 2500
        speed = 450 --550
        width = 150
        width_end = 350
        cone = true
    end
    if caster.trap_element and caster.trap_element == "1fireturn" then
        missile_fx = "particles/units/heroes/hero_dragon_knight/dragon_knight_breathe_fire.vpcf"
        sound = "Hero_Lina.DragonSlave"
        distance = 2500
        speed = 450 --550
        width = 150
        width_end = 350
        cone = true
        activate_every = 2
        turnspeed = math.random(2,10)
        if math.random(1,100) <= 50 then
            turnspeed = - turnspeed
        end
    end
    if caster.trap_element and caster.trap_element == "2frostturn" then
        missile_fx = "particles/fireball_linear_6.vpcf"
        sound = "Hero_Lina.DragonSlave"
        distance = 2500
        speed = 450
        width = 150
        width_end = 150
        cone = false
        activate_every = 3
        turnspeed = math.random(2,10)
        if math.random(1,100) <= 50 then
            turnspeed = - turnspeed
        end
    end
    if caster.trap_element and caster.trap_element == "5dartsshort" then
        missile_fx = "particles/venomancer_venomous_gale_viper.vpcf"
        aoe = 5
        distance = 2000
        speed = 550
    end
    if caster.trap_element and caster.trap_element == "5darts_ice" then
        missile_fx = "particles/units/heroes/hero_tusk/tusk_ice_shards_projectile.vpcf"
        aoe = 5
    end
    if caster.trap_element and caster.trap_element == "5darts_water" then
        missile_fx = "particles/units/heroes/hero_morphling/morphling_waveform.vpcf"
        aoe = 5
    end
    if caster.trap_element and caster.trap_element == "5darts_shadow" then
        missile_fx = "particles/fireball_linear_4.vpcf"
        aoe = 5
    end
    if caster.trap_element and caster.trap_element == "fire" then
        missile_fx = "particles/fireball_linear_2.vpcf"
        speed = 400
    end
    if caster.trap_timer_set then
        activate_every = caster.trap_timer_set
    end
    if caster.trap_timer then
        caster.trap_timer = caster.trap_timer + 1
        if caster.trap_timer < activate_every then
            return
        end
    else
        caster.trap_timer = 1
        return
    end
    caster.trap_timer = 0
    EmitSoundOn(sound, caster)
    if aoe == 0 then
        local info = 
        {
            Ability = ability,
            EffectName = missile_fx,
            vSpawnOrigin = caster:GetAbsOrigin()+Vector(0,0,75),
            fDistance = distance,
            fStartRadius = width,
            fEndRadius = width_end,
            Source = caster,
            bHasFrontalCone = cone,
            bReplaceExisting = false,
            iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
            iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
            iUnitTargetType = DOTA_UNIT_TARGET_HERO,
            fExpireTime = GameRules:GetGameTime() + 60.0,
            bDeleteOnHit = false,
            vVelocity = speed * caster:GetForwardVector():Normalized(),
            bProvidesVision = true,
            iVisionRadius = 1000,
            iVisionTeamNumber = caster:GetTeamNumber()
        }
        local projectile = ProjectileManager:CreateLinearProjectile(info)
    end
    if aoe == 3 or aoe == 5 then
        for i=1, aoe do
            local shoot_vector = speed * caster:GetForwardVector():Normalized()
            local angle = 30 * (i-(0.5+aoe/2))
            shoot_vector = RotateVectorAroundAngle(shoot_vector, angle)
            local info = 
            {
                Ability = ability,
                EffectName = missile_fx,
                vSpawnOrigin = caster:GetAbsOrigin()+Vector(0,0,75),
                fDistance = distance,
                fStartRadius = 75,
                fEndRadius = 75,
                Source = caster,
                bHasFrontalCone = false,
                bReplaceExisting = false,
                iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
                iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
                iUnitTargetType = DOTA_UNIT_TARGET_HERO,
                fExpireTime = GameRules:GetGameTime() + 60.0,
                bDeleteOnHit = false,
                vVelocity = shoot_vector,
                bProvidesVision = true,
                iVisionRadius = 1000,
                iVisionTeamNumber = caster:GetTeamNumber()
            }
            local projectile = ProjectileManager:CreateLinearProjectile(info)
        end
    end
    if caster.random_new_direction then
        local new_vec = RandomVector(1.0)
        local result = Vector(new_vec[1],new_vec[2],0)
        Timers:CreateTimer(1, function()
            if caster and not caster:IsNull() then
                caster:SetForwardVector(result)
            end
        end)
    end
    if turnspeed ~= 0 and not caster.trap_has_turning_enabled then
        caster.trap_has_turning_enabled = true
        Timers:CreateTimer(0.03, function()
            if caster and not caster:IsNull() then
                local new_vec = RotateVectorAroundAngle(caster:GetForwardVector(), turnspeed)
                caster:SetForwardVector(new_vec)
                return 0.03
            end
        end)
    end
end

function IsEnemyInRange( unit, distance )
    if unit and not unit:IsNull() then
        local enemies = FindUnitsInRadius( unit:GetTeamNumber(), unit:GetAbsOrigin(), unit, distance, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, 0, 0, false )
        if #enemies > 0 then
            for _,enemy in pairs(enemies) do
                --print((unit:GetAbsOrigin()-enemy:GetAbsOrigin()):Length())
                return true
            end
        end
    end
    return false
end

function RotateVectorAroundAngle( vec, angle )
    local x = vec[1]
    local y = vec[2]
    angle = angle * 0.01745
    local vec2 = Vector(0,0,0)
    vec2[1] = x * math.cos(angle) - y * math.sin(angle)
    vec2[2] = x * math.sin(angle) + y * math.cos(angle)
    return vec2
end

function ProcBuffAfterXAttacks( event )
    local caster = event.attacker
    if not caster.proc_attack_counter then
        caster.proc_attack_counter = 1
    else
        caster.proc_attack_counter = caster.proc_attack_counter + 1
    end
    if caster.proc_attack_counter >= 10000000 then
        caster.proc_attack_counter = 0
    end
    if caster.proc_attack_counter % event.attacks == 0 then
        event.ability:ApplyDataDrivenModifier(caster, event.target, event.buff, nil)
    end
end

function GetRandomMonsterNameByAct(act)
    act_monsters = {}
    act_monsters[1] = {
        "temple_wolf",
        "temple_wolf_brown",
        "temple_wolf_rage"
    }
    act_monsters[2] = {
        "temple_sand_dustlord",
        "temple_sand_dustboar",
        "temple_sand_stonegolem",
        "temple_sand_dustgolem"
    }
    act_monsters[3] = {
        "temple_fungal_spawn",
        "temple_fungal_slark",
        "temple_fungal_morph",
        "temple_fungal_morph",
        "temple_fungal_slardar",
        "temple_fungal_ancient"
    }
    act_monsters[4] = {
        "temple_shadow_melee",
        "temple_shadow_archer",
        "temple_shadow_undying",
        "temple_shadow_nightspider",
        "temple_shadow_colossus",
        "temple_shadow_demon"
    }
    act_monsters[5] = {
        "temple_dragon_jakiro",
        "temple_dragon_garg",
        "temple_dragon_garg2",
        "temple_dragon_melee"
    }
    act_monsters[6] = {
        "temple_mount_fireele",
        "temple_mount_archer",
        "temple_mount_tree",
        "temple_mount_plant",
        "temple_mount_wisp"
    }
    act_monsters[7] = {
        "temple_tomb_spider",
        "temple_tomb_skeleton",
        "temple_tomb_shadow",
        "temple_tomb_bug"
    }
    act_monsters[8] = {
        "temple_volcano_fireborn",
        "npc_dota_creature_imp_volcano",
        "temple_volcano_flameborn"
    }
    act_monsters[9] = {
        "temple_mogushan_ranged",
        "temple_mogushan_melee",
        "temple_mogushan_runner"
    }
    act_monsters[10] = {
        "temple_tomb_shadow"
        --"temple_volcano_fireele"
        --"temple_shadow_spectre"
    }
    act_monsters[11] = {
        "temple_shadow_spectre_2",
        "temple_shadow_archer"
    }
    act_monsters[12] = {
        "temple_jungle_raptor",
        "temple_jungle_viper",
        "temple_jungle_spider",
        "temple_jungle_troll"
    }
    act_monsters[13] = {
        "act13_1",
        "act13_2",
        "act13_3",
        "act13_4",
        "act13_5",
        "act13_6"
    }
    if act_monsters[act] and act_monsters[act][1] then
        return act_monsters[act][math.random(1,#act_monsters[act])]
    end
    return "temple_wolf"
end

function SpawnMonsterSwarm( act, min_count, max_count, triggering_unit, random_offset, target_to_attack, chance_for_champion, attack_random_hero, spawn_point_list, pvescale )
    local count = math.random(min_count,max_count)
    if count <= 0 then
        count = 1
    end
    local position
    if triggering_unit then
        position = triggering_unit.swarm_on_death_position
    end
    if not position then
        position = Vector(0,0,0)
    end
    local order_position
    if triggering_unit and not triggering_unit:IsNull() then
        order_position = triggering_unit:GetAbsOrigin()
    end
    local scale = 1
    if triggering_unit and triggering_unit.pvescale then
        scale = triggering_unit.pvescale
    end
    if pvescale then
        scale = pvescale
    end
    local order_delay = 0.1
    local jump_time = 2
    if triggering_unit and not triggering_unit:IsNull() and triggering_unit.swarm_on_death_jumptolocation then
        order_delay = order_delay + jump_time
    end
    local unit_name = GetRandomMonsterNameByAct(act)
    for i=1, count do
        if triggering_unit and not triggering_unit:IsNull() and triggering_unit.swarm_on_death_force_unit_type then
            unit_name = triggering_unit.swarm_on_death_force_unit_type
        end
        if random_offset then
            position = position + RandomVector(random_offset)
        end
        if spawn_point_list then
            position = spawn_point_list[math.random(1,#spawn_point_list)]
        end
        if triggering_unit and triggering_unit.spawn_point_list then
            position = triggering_unit.spawn_point_list[math.random(1,#triggering_unit.spawn_point_list)]
        end
        local unit = CreateUnitByName(unit_name, position+RandomVector(150.0), true, nil, nil, DOTA_TEAM_NEUTRALS )
        local dmg = 75
        local hp = 2000/count
        if chance_for_champion and i == count - 1 and math.random(1,100) <= 5 and scale > 1 then
            dmg = 50
            hp = 2500
            unit.chance_for_champion = 100--5% for 2 nd champion
            unit:SetModelScale(1.25*unit:GetModelScale())
        end
        if chance_for_champion and i == count and math.random(1,100) <= 50 and scale > 1 then
            dmg = 100
            hp = 1500
            unit.chance_for_champion = 100
            unit:SetModelScale(1.15*unit:GetModelScale())
        end
        COverthrowGameMode:SetTempleStats(unit,scale,dmg,hp,25/count,0)
        local ability = unit:FindAbilityByName("pveboss_system")
        if ability then
            ability:ApplyDataDrivenModifier(unit, unit, "modifier_phased", {Duration = 0.25})
        end
        local order = 
        {
            UnitIndex = unit:entindex(),
            OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
            Position = order_position,
            Queue = false
        }
        if target_to_attack and not target_to_attack:IsNull() and target_to_attack:IsAlive() then
            order = 
            {
                UnitIndex = unit:entindex(),
                OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
                TargetIndex = target_to_attack:entindex(),
                Queue = false
            }
        end

        if attack_random_hero then
            local all = HeroList:GetAllHeroes()
            local hero_to_attack = all[math.random(1,#all)]
            if hero_to_attack then
                order = 
                {
                    UnitIndex = unit:entindex(),
                    OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
                    TargetIndex = hero_to_attack:entindex(),
                    Queue = false
                }
            end
        end
        Timers:CreateTimer(order_delay, function()
            ExecuteOrderFromTable(order)
        end)
        if triggering_unit and triggering_unit.swarm_on_death_jumptolocation then
            Timers:CreateTimer(0.3, function()
                --local target_points = {}
                --target_points[1] = order_position + RandomVector(300)
                --local myevent = {caster = unit, target_points = target_points, crush = 1, upintheair = 2, jumpdur = 2}
                --KnockBack(myevent)
                --LeapToLocation( unit, order_position, 1.5 )
                LeapToLocation( unit, order_position+RandomVector(150), jump_time)
            end)
        end
        local particle = ParticleManager:CreateParticle("particles/econ/events/fall_major_2016/force_staff_fm06_dust.vpcf", PATTACH_POINT_FOLLOW, unit)
        ParticleManager:ReleaseParticleIndex(particle)
    end
end

function ApplyBuffStackStandingStill( event )
    local caster = event.caster
    local buff = event.buff
    if caster:IsMoving() then
        caster:RemoveModifierByName(buff)
    else
        ApplyBuffStack(event)
    end
end

function SmoothCurve( x )
    return -(x*x) + 1
end

function LeapToLocation( unit, target_position, duration )
    local start_position = unit:GetAbsOrigin()
    --unit:SetForwardVector((target_position-start_position):Normalized())
    EmitSoundOn("Hero_PhantomAssassin.Dagger.Cast", unit)
    target_position = GetGroundPosition(target_position, unit)
    local distance_to_travel = (target_position - start_position):Length()
    local ticks = 30*duration
    local height = 200
    for i=1, ticks do
        Timers:CreateTimer(0.03*i, function()
            local new_position = start_position * (ticks - i) / ticks + target_position * i / ticks
            local normalized_x = SmoothCurve(-1 + i * 2 / ticks)
            new_position[3] = GetGroundHeight(new_position, unit) + normalized_x * height --height - height * math.abs(ticks/2-i) / (ticks/2) 
            unit:SetAbsOrigin(new_position)
        end)
    end
    local ability = unit:FindAbilityByName("pveboss_system")
    if ability then
        ability:ApplyDataDrivenModifier(unit, unit, "jump_animation", {Duration = duration})
        --ability:ApplyDataDrivenModifier(unit, unit, "modifier_disarmed", {Duration = duration})
    end
    local ability = unit:FindAbilityByName("pveboss_system")
    Timers:CreateTimer(duration, function()
        if ability then
            ability:ApplyDataDrivenModifier(unit, unit, "modifier_phased", {Duration = 0.1})
        end
    end)
end

function LeapToLocationWithAOEDamage( unit, target_position, duration, damage, aoe )
    LeapToLocation( unit, target_position, duration )
    local tab = {}
    tab.caster = unit
    tab.damage = 0.0
    tab.spelldamagefactor = 0
    tab.attributefactor = 0
    tab.difficultyscalelinear = damage
    tab.ability = unit:FindAbilityByName("pveboss_system")
    tab.aoe = aoe
    tab.targeteffect = "blood"
    tab.target_points = {}
    tab.target_points[1] = target_position
    Timers:CreateTimer(duration*0.95, function()
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_centaur/centaur_warstomp.vpcf", PATTACH_WORLDORIGIN, unit)
        ParticleManager:SetParticleControl(particle, 0, target_position)
        ParticleManager:SetParticleControl(particle, 1, Vector(aoe,aoe,aoe))
        ParticleManager:ReleaseParticleIndex(particle)
        DamageAOE(tab)
        EmitSoundOn("Ability.TossImpact", unit)
    end)
end

function JumpStomp( event )
    local caster = event.caster
    local delay = event.delay
    local count = event.count
    local damage = event.dmg
    local jump_duration = 2
    local ability = caster:FindAbilityByName("pveboss_system")
    local aoe = event.aoe
    caster.is_leaping = true
    Timers:CreateTimer(count*delay+jump_duration, function()
        caster.is_leaping = false
    end)
    for i=1,count do
        Timers:CreateTimer((i-1)*delay, function()
            if caster:IsAlive() then
                local target = COverthrowGameMode:PVERandomTarget( event )
                if target then
                    order = 
                    {
                        UnitIndex = caster:entindex(),
                        OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
                        TargetIndex = target:entindex(),
                        Queue = false
                    }
                    ExecuteOrderFromTable(order)
                    Timers:CreateTimer(0.1, function()
                        --if ability then
                        --    ability:ApplyDataDrivenModifier(caster, caster, "modifier_stunned", {Duration = jump_duration})
                        --end
                        LeapToLocationWithAOEDamage( caster, target:GetAbsOrigin(), jump_duration, damage, aoe )
                    end)
                end
            end
        end)
    end
end

function ShadowOrbFX( event )
    local caster = event.caster
    if caster:GetModifierStackCount("modifier_shadoworb", nil) >= 3 then
        local particle = ParticleManager:CreateParticle("particles/items3_fx/glimmer_cape_initial_flash_ember.vpcf", PATTACH_POINT_FOLLOW, caster)
        ParticleManager:ReleaseParticleIndex(particle)
    end
end

function SetPathDarknessLevel( event )
    event.caster.pathdarknesslevel = event.ability:GetLevel()
end

function AttackRandomHero( unit )
    Timers:CreateTimer(0.1, function()
        --local all = HeroList:GetAllHeroes()
        local hero_to_attack = COverthrowGameMode:PVERandomTargetNearTarget(unit, 3500)
        if hero_to_attack then
            order = 
            {
                UnitIndex = unit:entindex(),
                OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
                TargetIndex = hero_to_attack:entindex(),
                Queue = false
            }
            ExecuteOrderFromTable(order)
        end
    end)
end

function AttackHero( unit, hero )
    Timers:CreateTimer(0.1, function()
        if hero then
            order = 
            {
                UnitIndex = unit:entindex(),
                OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
                TargetIndex = hero:entindex(),
                Queue = false
            }
            ExecuteOrderFromTable(order)
        end
    end)
end

function ChainBounceSpell( event )
    local caster = event.caster
    local target = event.target
    local distance = event.jumpdistance
    Timers:CreateTimer(0.1, function()
        local next_target = COverthrowGameMode:PVERandomTargetNearTarget(target, distance)
        if next_target then
        
            EmitSoundOn("hero_Crystal.preAttack", caster)
            local info = {
                Target = next_target,
                Source = target,
                Ability = event.ability,
                EffectName = event.missilefx,
                bDodgeable = true,
                bProvidesVision = true,
                iMoveSpeed = 600,
                iVisionRadius = 300,
                iVisionTeamNumber = caster:GetTeamNumber(),
                iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_HITLOCATION
            }
            ProjectileManager:CreateTrackingProjectile( info )
        end
    end)
end

function WaveCaller( event )
    local caster = event.caster
    local start_position = caster:GetAbsOrigin() - caster:GetForwardVector() * 1500
    local direction = caster:GetForwardVector()
    local distance = 3000
    EmitSoundOn("viper_vipe_spawn_04", caster)
    for i=0,6 do
        local delay_factor = 0
        if i == 1 or i == 2 then
            delay_factor = 1
        end
        if i == 3 or i == 4 then
            delay_factor = 2
        end
        if i == 5 or i == 6 then
            delay_factor = 3
        end
        Timers:CreateTimer(2.25+delay_factor*2.5,function()
            if caster and not caster:IsAlive() then
                return
            end
            local launch_position = start_position
            if i == 1 or i == 3 or i == 5 then
                launch_position = start_position + RotateVectorAroundAngle(direction, 90) * 275 * delay_factor
            end
            if i == 2 or i == 4 or i == 6 then
                launch_position = start_position - RotateVectorAroundAngle(direction, 90) * 275 * delay_factor
            end
            if caster and caster:IsNull() then
                return
            end
            local info = 
            {
                Ability = event.ability,
                EffectName = "particles/econ/items/morphling/morphling_crown_of_tears/morphling_crown_waveform.vpcf",
                vSpawnOrigin = launch_position,
                fDistance = distance,
                fStartRadius = 125,
                fEndRadius = 125,
                Source = caster,
                bHasFrontalCone = false,
                bReplaceExisting = false,
                iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
                iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
                iUnitTargetType = DOTA_UNIT_TARGET_HERO,
                fExpireTime = GameRules:GetGameTime() + 60.0,
                bDeleteOnHit = false,
                vVelocity = 800 * direction,
                bProvidesVision = true,
                iVisionRadius = 1000,
                iVisionTeamNumber = caster:GetTeamNumber()
            }
            local projectile = ProjectileManager:CreateLinearProjectile(info)
            EmitSoundOn("Ability.GushCast", caster)
        end)
    end
end

function WaveCaller10( event )
    local caster = event.caster
    local start_position = caster:GetAbsOrigin() - caster:GetForwardVector() * 1500 + RotateVectorAroundAngle(caster:GetForwardVector(),90) * 1500
    local direction = caster:GetForwardVector()
    local distance = 5000
    local wavedelay = 3
    local gap = math.random(4,6)
    EmitSoundOn("viper_vipe_spawn_04", caster)
    for waves = 1, 5 do
        Timers:CreateTimer(wavedelay*waves,function()
            EmitSoundOn("Ability.GushCast", caster)
            if gap == 3 then
                gap = 4
            elseif gap == 7 then
                gap = 6
            elseif math.random(1,100) <= 50 then
                gap = gap + 1
            else
                gap = gap - 1
            end
            for i=-4,14 do
                if i ~= gap then
                    local launch_position = start_position - RotateVectorAroundAngle(direction,90) * 300 * i
                    local info = 
                    {
                        Ability = event.ability,
                        EffectName = "particles/econ/items/kunkka/kunkka_immortal/kunkka_immortal_ghost_ship.vpcf",
                        vSpawnOrigin = launch_position,
                        fDistance = distance,
                        fStartRadius = 150,
                        fEndRadius = 150,
                        Source = caster,
                        bHasFrontalCone = false,
                        bReplaceExisting = false,
                        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
                        iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
                        iUnitTargetType = DOTA_UNIT_TARGET_HERO,
                        fExpireTime = GameRules:GetGameTime() + 60.0,
                        bDeleteOnHit = false,
                        vVelocity = 475 * direction,
                        bProvidesVision = true,
                        iVisionRadius = 1000,
                        iVisionTeamNumber = caster:GetTeamNumber()
                    }
                    local projectile = ProjectileManager:CreateLinearProjectile(info)
                end
            end
        end)
    end
end

function WaveCaller2( event )
    local caster = event.caster
    local side_offset = 1000
    if math.random(1,100) <= 50 then
        side_offset = -1000
    end
    local start_position = caster:GetAbsOrigin() - caster:GetForwardVector() * 1000 + RotateVectorAroundAngle(caster:GetForwardVector(), 90) * side_offset
    local direction = caster:GetForwardVector()
    local step_offset = RotateVectorAroundAngle(caster:GetForwardVector(), 90) * side_offset / (-7.75)
    local distance = 3000
    for i=1,20 do
        local count = i
        Timers:CreateTimer(i*0.4,function()
            local launch_position = start_position + step_offset * count
            local info = 
            {
                Ability = event.ability,
                EffectName = "particles/econ/items/nyx_assassin/nyx_assassin_ti6_witness/nyx_assassin_impale_ti6_witness.vpcf",
                vSpawnOrigin = launch_position,
                fDistance = distance,
                fStartRadius = 125,
                fEndRadius = 125,
                Source = caster,
                bHasFrontalCone = false,
                bReplaceExisting = false,
                iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
                iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
                iUnitTargetType = DOTA_UNIT_TARGET_HERO,
                fExpireTime = GameRules:GetGameTime() + 60.0,
                bDeleteOnHit = false,
                vVelocity = 1000 * direction,
                bProvidesVision = true,
                iVisionRadius = 1000,
                iVisionTeamNumber = caster:GetTeamNumber()
            }
            local projectile = ProjectileManager:CreateLinearProjectile(info)
            EmitSoundOn("Ability.TossImpact", caster)
        end)
    end
end

function WaveCaller3( event )
    local caster = event.caster
    if event.count < 1 then
        return
    end
    if not caster or caster:IsNull() then
        return
    end
    local first_strike_delay = 0
    local distance = 500
    local current_position = caster:GetAbsOrigin() - caster:GetForwardVector() * 950
    local current_direction = RotateVectorAroundAngle(caster:GetForwardVector(), 90)
    if not event.launch_pos then
        first_strike_delay = 3
        event.angle = -30
        event.count = 30
        event.launch_pos = current_position
        if math.random(1,100) <= 50 then
            current_direction = RotateVectorAroundAngle(caster:GetForwardVector(), -90)
            event.angle = event.angle * -1
        end
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_nevermore/nevermore_shadowraze.vpcf", PATTACH_WORLDORIGIN, caster)
        ParticleManager:SetParticleControl(particle, 0, current_position)
    end
    if not event.launch_dir then
        event.launch_dir = current_direction
    end 
    
    local info = 
    {
        Ability = event.ability,
        EffectName = "particles/units/heroes/hero_dragon_knight/dragon_knight_breathe_fire.vpcf",
        vSpawnOrigin = event.launch_pos,
        fDistance = distance,
        fStartRadius = 125,
        fEndRadius = 250,
        Source = caster,
        bHasFrontalCone = false,
        bReplaceExisting = false,
        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
        iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
        iUnitTargetType = DOTA_UNIT_TARGET_HERO,
        fExpireTime = GameRules:GetGameTime() + 60.0,
        bDeleteOnHit = false,
        vVelocity = 500 * event.launch_dir,
        bProvidesVision = true,
        iVisionRadius = 1000,
        iVisionTeamNumber = caster:GetTeamNumber()
    }
    Timers:CreateTimer(first_strike_delay,function()
        local projectile = ProjectileManager:CreateLinearProjectile(info)
        EmitSoundOn("Hero_Lina.attack", caster)
    end)
    Timers:CreateTimer(1+first_strike_delay,function()
        event.count = event.count - 1
        event.angle = event.angle * 1.045
        --print(event.angle)
        event.launch_pos = event.launch_pos + event.launch_dir * distance
        event.launch_dir = RotateVectorAroundAngle(event.launch_dir,event.angle)
        WaveCaller3(event)
    end)
end

function WaveCaller4( event )
    local caster = event.caster
    if event.count < 0 then
        return
    end
    if not caster or caster:IsNull() then
        return
    end
    local distance = 500
    local current_position = caster:GetAbsOrigin()
    local current_direction = RotateVectorAroundAngle(caster:GetForwardVector(), 45*event.startangle)
    if not event.launch_pos then
        event.angle = 0
        event.count = 20
        event.launch_pos = current_position
    end
    if not event.launch_dir then
        event.launch_dir = current_direction
    end 
    
    local info = 
    {
        Ability = event.ability,
        EffectName = "particles/econ/items/nyx_assassin/nyx_assassin_ti6_witness/nyx_assassin_impale_ti6_witness.vpcf",
        vSpawnOrigin = event.launch_pos,
        fDistance = distance,
        fStartRadius = 125,
        fEndRadius = 125,
        Source = caster,
        bHasFrontalCone = false,
        bReplaceExisting = false,
        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
        iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
        iUnitTargetType = DOTA_UNIT_TARGET_HERO,
        fExpireTime = GameRules:GetGameTime() + 60.0,
        bDeleteOnHit = false,
        vVelocity = 500 * event.launch_dir,
        bProvidesVision = true,
        iVisionRadius = 1000,
        iVisionTeamNumber = caster:GetTeamNumber()
    }
    local projectile = ProjectileManager:CreateLinearProjectile(info)
    EmitSoundOn("Hero_Lina.attack", caster)
    Timers:CreateTimer(1,function()
        event.count = event.count - 1
        if (event.count > 3 and event.count <= 8) or (event.count > 13 and event.count <= 18) then
            event.angle = -47
        else
            event.angle = 0
        end
        event.launch_pos = event.launch_pos + event.launch_dir * distance
        event.launch_dir = RotateVectorAroundAngle(event.launch_dir,event.angle)
        WaveCaller4(event)
    end)
end

function WaveCaller5( event )
    local caster = event.caster
    if event.count < 0 then
        return
    end
    if not caster or caster:IsNull() then
        return
    end
    local distance = 500
    local turn_threshold = 1750
    if not event.launch_pos then
        event.launch_pos = caster:GetAbsOrigin() + RandomVector(1500)
    end
    if not event.launch_dir then
        event.launch_dir = (caster:GetAbsOrigin() - event.launch_pos):Normalized()
    end
    
    local info = 
    {
        Ability = event.ability,
        EffectName = "particles/econ/items/nyx_assassin/nyx_assassin_ti6/nyx_assassin_impale_ti6_gold.vpcf",
        vSpawnOrigin = event.launch_pos,
        fDistance = distance,
        fStartRadius = 125,
        fEndRadius = 125,
        Source = caster,
        bHasFrontalCone = false,
        bReplaceExisting = false,
        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
        iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
        iUnitTargetType = DOTA_UNIT_TARGET_HERO,
        fExpireTime = GameRules:GetGameTime() + 60.0,
        bDeleteOnHit = false,
        vVelocity = 500 * event.launch_dir,
        bProvidesVision = true,
        iVisionRadius = 1000,
        iVisionTeamNumber = caster:GetTeamNumber()
    }
    local projectile = ProjectileManager:CreateLinearProjectile(info)
    EmitSoundOn("Hero_Lina.attack", caster)
    Timers:CreateTimer(1,function()
        event.count = event.count - 1
        event.launch_pos = event.launch_pos + event.launch_dir * distance
        if (caster:GetAbsOrigin() - event.launch_pos):Length() > turn_threshold then
            event.launch_dir = (caster:GetAbsOrigin() - event.launch_pos):Normalized()
        end
        WaveCaller5(event)
    end)
end

function WaveCaller6( event )
    local caster = event.caster
    if event.count < 0 then
        return
    end
    if not caster or caster:IsNull() then
        return
    end
    local distance = 500
    local current_position = caster:GetAbsOrigin()
    local current_direction = RotateVectorAroundAngle(caster:GetForwardVector(), 45*event.startangle)
    if not event.launch_pos then
        event.angle = 0
        event.count = 20
        event.launch_pos = current_position
    end
    if not event.launch_dir then
        event.launch_dir = current_direction
    end 
    
    local info = 
    {
        Ability = event.ability,
        EffectName = "particles/econ/items/nyx_assassin/nyx_assassin_ti6/nyx_assassin_impale_ti6_gold.vpcf",
        vSpawnOrigin = event.launch_pos,
        fDistance = distance,
        fStartRadius = 125,
        fEndRadius = 125,
        Source = caster,
        bHasFrontalCone = false,
        bReplaceExisting = false,
        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
        iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
        iUnitTargetType = DOTA_UNIT_TARGET_HERO,
        fExpireTime = GameRules:GetGameTime() + 60.0,
        bDeleteOnHit = false,
        vVelocity = 500 * event.launch_dir,
        bProvidesVision = true,
        iVisionRadius = 1000,
        iVisionTeamNumber = caster:GetTeamNumber()
    }
    local projectile = ProjectileManager:CreateLinearProjectile(info)
    EmitSoundOn("Hero_Lina.attack", caster)
    Timers:CreateTimer(1,function()
        event.count = event.count - 1
        if event.count == 16 then
            event.launch_dir = - event.launch_dir
        end
        if event.count == 12 then
            event.launch_dir = RotateVectorAroundAngle(event.launch_dir,45)
        end
        event.launch_pos = event.launch_pos + event.launch_dir * distance
        --event.launch_dir = RotateVectorAroundAngle(event.launch_dir,event.angle)
        WaveCaller6(event)
    end)
end

function WaveCaller7( event )
    local caster = event.caster
    if event.count < 0 then
        return
    end
    if not caster or caster:IsNull() then
        return
    end
    local distance = 400
    if not event.launch_pos then
        event.launch_pos = caster:GetAbsOrigin() + RandomVector(1600)
    end
    if not event.launch_dir then
        event.launch_dir = (caster:GetAbsOrigin() - event.launch_pos):Normalized()
    end
    
    local info = 
    {
        Ability = event.ability,
        EffectName = "particles/units/heroes/hero_dragon_knight/dragon_knight_breathe_fire.vpcf",
        vSpawnOrigin = event.launch_pos,
        fDistance = distance,
        fStartRadius = 125,
        fEndRadius = 125,
        Source = caster,
        bHasFrontalCone = false,
        bReplaceExisting = false,
        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
        iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
        iUnitTargetType = DOTA_UNIT_TARGET_HERO,
        fExpireTime = GameRules:GetGameTime() + 60.0,
        bDeleteOnHit = false,
        vVelocity = 400 * event.launch_dir,
        bProvidesVision = true,
        iVisionRadius = 1000,
        iVisionTeamNumber = caster:GetTeamNumber()
    }
    local projectile = ProjectileManager:CreateLinearProjectile(info)
    EmitSoundOn("Hero_Lina.attack", caster)
    Timers:CreateTimer(1,function()
        event.count = event.count - 1
        event.launch_pos = event.launch_pos + event.launch_dir * distance
        if event.count == 18 then
            event.launch_dir = RotateVectorAroundAngle(event.launch_dir,45)
        end
        if event.count < 18 and event.count > 5 then
            event.launch_dir = RotateVectorAroundAngle(event.launch_dir,-45)
        end
        WaveCaller7(event)
    end)
end

function WaveCaller8( event )
    local caster = event.caster
    if event.count < 0 then
        return
    end
    if not caster or caster:IsNull() then
        return
    end
    local distance = 700
    if not event.launch_pos then
        event.launch_pos = caster:GetAbsOrigin()
        event.hero_to_follow = COverthrowGameMode:PVERandomTargetNearTarget(caster, 3500)
        if not event.hero_to_follow then
            event.hero_to_follow = caster
        end
    end
    if not event.launch_dir then
        event.launch_dir = (event.hero_to_follow:GetAbsOrigin() - event.launch_pos):Normalized()
    end
    
    local info = 
    {
        Ability = event.ability,
        EffectName = "particles/fireball_linear_2.vpcf",
        vSpawnOrigin = event.launch_pos + Vector(0,0,60),
        fDistance = distance,
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
        vVelocity = 350 * event.launch_dir,
        bProvidesVision = true,
        iVisionRadius = 1000,
        iVisionTeamNumber = caster:GetTeamNumber()
    }
    local projectile = ProjectileManager:CreateLinearProjectile(info)
    EmitSoundOn("Hero_Lina.attack", caster)
    Timers:CreateTimer(2,function()
        event.count = event.count - 1
        event.launch_pos = event.launch_pos + event.launch_dir * distance
        event.launch_dir = (event.hero_to_follow:GetAbsOrigin() - event.launch_pos):Normalized()
        WaveCaller8(event)
    end)
end

function SpawnPendulumTrap( event )
    local caster = event.caster
    local target =  COverthrowGameMode:PVERandomTarget( event )
    local cast_target = caster
    if target then
        cast_target = target
    end
    local center = cast_target:GetAbsOrigin() + cast_target:GetForwardVector() * 200 + Vector(0,0,75)
    local direction = cast_target:GetForwardVector() --Vector(0,0,0) + RandomVector(1)
    local distance = 750
    local team = caster:GetTeamNumber()
    local pendulum = SpawnEntityFromTableSynchronous("prop_dynamic", {model = "models/props/traps/pendulum/pendulum.vmdl", DefaultAnim="pendulum_swing", targetname=DoUniqueString("prop_dynamic")})
    pendulum:SetAbsOrigin(center)
    pendulum:SetForwardVector(RotateVectorAroundAngle(direction, 270))
    --direction = RotateVectorAroundAngle(direction, 90)
    --pre effect sounds
    EmitGlobalSound("Conquest.Pendulum.Trigger")
    --EmitGlobalSound("tutorial_rockslide")
    --EmitGlobalSound("Conquest.Pendulum.Scrape")
    --pre effect marker to see pendulum area
    --[[
    for i=0,7 do
        Timers:CreateTimer(1.25+i*0.20,function()
            local particle = ParticleManager:CreateParticle("particles/items_fx/dagon.vpcf", PATTACH_WORLDORIGIN, caster)
            ParticleManager:SetParticleControl(particle, 0, center - direction * distance)
            ParticleManager:SetParticleControl(particle, 1, center + direction * distance)
            ParticleManager:ReleaseParticleIndex(particle)
        end)
    end]]
    Timers:CreateTimer(2.25,function()
        local particle = ParticleManager:CreateParticle("particles/drow_ti6_silence_gold_wave_no_arrow.vpcf", PATTACH_WORLDORIGIN, caster)
        ParticleManager:SetParticleControl(particle, 0, center - direction * distance)
        ParticleManager:SetParticleControl(particle, 1, (center + direction * distance)-(center - direction * distance))
        ParticleManager:ReleaseParticleIndex(particle)
    end)
    --spawn shock wave 1
    for i=0,1 do
        Timers:CreateTimer(3.85+i*3.5,function()
            EmitGlobalSound("Conquest.Pendulum.Scrape")
            if i == 1 then
                direction = direction * -1
            end
            local info = 
            {
                Ability = event.ability,
                EffectName = "particles/econ/items/magnataur/shock_of_the_anvil/magnataur_shockanvil.vpcf",
                vSpawnOrigin = center - direction * distance,
                fDistance = distance * 2,
                fStartRadius = 175,
                fEndRadius = 175,
                Source = caster,
                bHasFrontalCone = false,
                bReplaceExisting = false,
                iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
                iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
                iUnitTargetType = DOTA_UNIT_TARGET_HERO,
                fExpireTime = GameRules:GetGameTime() + 60.0,
                bDeleteOnHit = false,
                vVelocity = 1200 * direction,
                bProvidesVision = true,
                iVisionRadius = 1000,
                iVisionTeamNumber = team
            }
            local projectile = ProjectileManager:CreateLinearProjectile(info)
        end)
    end
    Timers:CreateTimer(17,function()
        pendulum:Destroy()
    end)
end

function SetupSpawnedTrap( event )
    local unit = event.target
    local direction = Vector(0,0,0) + RandomVector(1)
    if event.trap_type == "5dartsshort" then
        unit.trap_element = event.trap_type
        unit.random_new_direction = true
    end
    if event.trap_type == "3skulls" then
        unit.trap_element = event.trap_type
        unit.random_new_direction = true
        --unit:AddAbility("pve_no_healthbar"):SetLevel(1)
    end
    if event.trap_type == "1fire" then
        unit.trap_element = event.trap_type
        unit.random_new_direction = true
        --unit:AddAbility("pve_no_healthbar"):SetLevel(1)
    end
    if event.trap_type == "1fireturn" then
        unit.trap_element = event.trap_type
        --unit:AddAbility("pve_no_healthbar"):SetLevel(1)
    end
    if event.trap_type == "2frostturn" then
        unit.trap_element = event.trap_type
        --unit:AddAbility("pve_no_healthbar"):SetLevel(1)
    end
    Timers:CreateTimer(0.03,function()
        unit:SetForwardVector(direction)
    end)
end

function YinYangSystemGenerate( event )
    local caster = event.caster
    local ability = event.ability
    if not caster.yinyangsystem then
        caster.yinyangsystem = {0,0}
    end
    if event.yin then
        for i=1, event.yin do
            if caster.yinyangsystem[1] + caster.yinyangsystem[2] < 3 then
                caster.yinyangsystem[1] = caster.yinyangsystem[1] + 1
                ability:ApplyDataDrivenModifier(caster, caster, "modifier_yin", {Duration = -1})
            end
        end
    end
    if event.yang then
        for i=1, event.yang do
            if caster.yinyangsystem[1] + caster.yinyangsystem[2] < 3 then
                caster.yinyangsystem[2] = caster.yinyangsystem[2] + 1
                ability:ApplyDataDrivenModifier(caster, caster, "modifier_yang", {Duration = -1})
            end
        end
    end
end

function YinYangSystemConsume( event )
    local caster = event.caster
    local target = event.target
    local ability = event.ability
    if not caster.yinyangsystem then
        return
    end
    if event.resolve then
        --deadly shaolin finisher
        local strike_count = 0
        local yin = caster.yinyangsystem[1]
        local yang = caster.yinyangsystem[2]
        if yin + yang >= 3 then
            strike_count = 1
            if math.random(1,100) < event.resolvechancetriple then
                strike_count = 3
            end
            YinYangSystemReset( event )
        end
        for i=1, strike_count do
            Timers:CreateTimer((i-1)*0.5,function()
                if yin == 3 then
                    event.firedmg = 1
                    event.includeauto = event.includeauto * 2
                    DamageUnit(event)
                    EmitSoundOn("Hero_OgreMagi.Fireblast.Cast", target)
                    local particle = ParticleManager:CreateParticle("particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_shadowraze.vpcf", PATTACH_POINT_FOLLOW, target)
                    ParticleManager:ReleaseParticleIndex(particle)
                end
                if yin == 2 and yang == 1 then
                    event.firedmg = 1
                    ability:ApplyDataDrivenModifier(caster, caster, "modifier_molten_blade", {Duration = 30})
                    DamageUnit(event)
                    EmitSoundOn("Hero_OgreMagi.Fireblast.Cast", target)
                    local particle = ParticleManager:CreateParticle("particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_shadowraze.vpcf", PATTACH_POINT_FOLLOW, target)
                    ParticleManager:ReleaseParticleIndex(particle)
                end
                if yin == 1 and yang == 2 then
                    event.frostdmg = 1
                    ability:ApplyDataDrivenModifier(caster, caster, "modifier_frozen_blade", {Duration = 5})
                    DamageUnit(event)
                    EmitSoundOn("Hero_Crystal.CrystalNova.Yulsaria", target)
                    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_lich/lich_frost_nova.vpcf", PATTACH_POINT_FOLLOW, target)
                    ParticleManager:ReleaseParticleIndex(particle)
                end
                if yang == 3 then
                    local target_position = target:GetAbsOrigin()
                    local tab = {}
                    local aoe = 200
                    tab.frostdmg = 1
                    tab.caster = caster
                    tab.damage = 0.0
                    tab.spelldamagefactor = 0
                    tab.attributefactor = 0
                    tab.includeauto = event.includeauto
                    tab.ability = ability
                    tab.aoe = aoe
                    tab.targeteffect = "water"
                    tab.target_points = {}
                    tab.target_points[1] = target_position
                    local particle = ParticleManager:CreateParticle("particles/econ/items/crystal_maiden/crystal_maiden_cowl_of_ice/maiden_crystal_nova_cowlofice.vpcf", PATTACH_WORLDORIGIN, target)
                    ParticleManager:SetParticleControl(particle, 0, target_position)
                    ParticleManager:SetParticleControl(particle, 1, Vector(aoe,1,1))
                    ParticleManager:ReleaseParticleIndex(particle)
                    DamageAOE(tab)
                    EmitSoundOn("Hero_Crystal.CrystalNova.Yulsaria", target)
                end
            end)
        end
    end
end

function YinYangSystemReset( event )
    local caster = event.caster
    if not caster.yinyangsystem then
        return
    end
    caster.yinyangsystem[1] = 0
    caster.yinyangsystem[2] = 0
    for i=1,3 do
        caster:RemoveModifierByName("modifier_yin")
        caster:RemoveModifierByName("modifier_yang")
    end
end

function TakeHealthPercentage( event )
    local caster = event.caster
    local target = event.target
    local health_percent = event.healthtaken
    if event.t3bonus and caster:HasModifier("modifier_item_set_str_t3_full") then
        health_percent = health_percent * 1.3
    end
    local factor = 1 - health_percent / 100
    if factor <= 0 then
        factor = 0.01
    end
    target:SetHealth(target:GetHealth()*factor)
end

function StarsAlignFX(target)
    local particle = ParticleManager:CreateParticle("particles/invoker_chaos_meteor_fly_blue_fast.vpcf", PATTACH_WORLDORIGIN, target)
    ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin() + Vector(500,250,900))
    ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin() + Vector(0,0,50))
    ParticleManager:SetParticleControl(particle, 2, Vector(0.25,0,0))
    ParticleManager:ReleaseParticleIndex(particle)
    particle = ParticleManager:CreateParticle("particles/invoker_chaos_meteor_fly_blue_fast.vpcf", PATTACH_WORLDORIGIN, target)
    ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin() + Vector(-500,-250,900))
    ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin() + Vector(0,0,50))
    ParticleManager:SetParticleControl(particle, 2, Vector(0.25,0,0))
    ParticleManager:ReleaseParticleIndex(particle)
    EmitSoundOn("Hero_Luna.Eclipse.Cast", target)
    Timers:CreateTimer(0.25,function()
        particle = ParticleManager:CreateParticle("particles/econ/items/wisp/wisp_death_ti7_model.vpcf", PATTACH_WORLDORIGIN, target)
        ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin() + Vector(0,0,0))
        ParticleManager:ReleaseParticleIndex(particle)
    end)
end

function GetCompanionAndPetCount( hero )
    local pets = 0
    if hero.Pet and not hero.Pet:IsNull() and hero.Pet:IsAlive() then
        pets = pets + 1
    end
    for i=1,10 do
        if IsCompanionAlive(hero,i) then
            pets = pets + 1
        end
    end
    return pets
end

function SteedOfLightFX( event )
    local point = event.target_points[1]
    local caster = event.caster
    local direction = (point - caster:GetAbsOrigin()):Normalized() * 750
    local particle = ParticleManager:CreateParticle("particles/econ/items/keeper_of_the_light/kotl_ti7_illuminate/kotl_ti7_illuminate.vpcf", PATTACH_WORLDORIGIN, caster)
    ParticleManager:SetParticleControl(particle, 3, caster:GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 1, direction)
    ParticleManager:SetParticleControl(particle, 8, Vector(3,0,0))
    ParticleManager:SetParticleControl(particle, 10, Vector(3,0,0))
    ParticleManager:ReleaseParticleIndex(particle)
end

function PillarsOfHope( event )
    local caster = event.caster
    local pos = {}
    local particle = {}
    local dir = {}
    local missile_counter = 0
    local lifetime = 0
    local tick_frequency = 0.5
    for i=1,3 do
        if i == 1 then
            pos[i] = caster:GetAbsOrigin() + Vector(math.random(750,1200), math.random(-750,750),0)
        end
        if i == 2 then
            pos[i] = caster:GetAbsOrigin() + Vector(math.random(-1200,-750), math.random(-750,750),0)
        end
        if i == 3 then
            pos[i] = caster:GetAbsOrigin() + RandomVector(math.random(750,1200))
        end
        dir[i] = Vector(0,0,0) + RandomVector(math.random(15,30))
        particle[i] = ParticleManager:CreateParticle("particles/econ/items/invoker/invoker_apex/invoker_sun_strike_team_big_ray_immortal1.vpcf", PATTACH_WORLDORIGIN, caster)
        ParticleManager:SetParticleControl(particle[i], 0, pos[i])
        ParticleManager:ReleaseParticleIndex(particle[i])
    end
    
    Timers:CreateTimer(tick_frequency,function()
        if caster and not caster:IsNull() and caster:IsAlive() and lifetime < 25 then
            lifetime = lifetime + tick_frequency
            missile_counter = missile_counter + 1
            for i=1,3 do
                pos[i] = pos[i] + dir[i]
                particle[i] = ParticleManager:CreateParticle("particles/econ/items/invoker/invoker_apex/invoker_sun_strike_team_big_ray_immortal1.vpcf", PATTACH_WORLDORIGIN, caster)
                ParticleManager:SetParticleControl(particle[i], 0, pos[i])
                ParticleManager:ReleaseParticleIndex(particle[i])
            end
            if missile_counter >= 6 then
                missile_counter = 0
                EmitSoundOn("Hero_Magnataur.ShockWave.Cast", caster)
                for i=1,3 do
                    for j=1,2 do
                        local index = i + j
                        if index > 3 then
                            index = index % 3
                        end
                        local direction = (pos[index] - pos[i]):Normalized()
                        local info = 
                        {
                            Ability = event.ability,
                            EffectName = "particles/econ/items/magnataur/shock_of_the_anvil/magnataur_shockanvil.vpcf",
                            vSpawnOrigin = pos[i],
                            fDistance = 2500,
                            fStartRadius = 75,
                            fEndRadius = 75,
                            Source = caster,
                            bHasFrontalCone = false,
                            bReplaceExisting = false,
                            iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_BOTH,
                            iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
                            iUnitTargetType = DOTA_UNIT_TARGET_ALL,
                            fExpireTime = GameRules:GetGameTime() + 60.0,
                            bDeleteOnHit = false,
                            vVelocity = 450 * direction,
                            bProvidesVision = true,
                            iVisionRadius = 300,
                            iVisionTeamNumber = caster:GetTeamNumber()
                        }
                        local projectile = ProjectileManager:CreateLinearProjectile(info)
                    end
                end
            end
            return tick_frequency
        end
    end)
end

function PillarsOfHopeImpact( event )
    local caster = event.caster
    local target = event.target
    if caster:GetTeamNumber() == target:GetTeamNumber() then
        if caster == target then
            HealUnit({caster = caster, target = caster, ability = event.ability, heal = caster:GetMaxHealth()*0.25})
        end
    else
        DamageUnit(event)
    end
end

function OmniRevelation( event )
    local caster = event.caster
    if caster:GetHealth() / caster:GetMaxHealth() <= 0.4 and not caster.omni_revelation_procced then
        caster.omni_revelation_procced = true
        event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_omni_revelation_proc", {Duration = -1})
        EmitSoundOn("DOTA_Item.AbyssalBlade.Activate", caster)
        EmitGlobalSound("omniknight_omni_death_03")
        Timers:CreateTimer(2.5,function()
            AddAbilityToUnit({target = caster, abil = "pve_temple_bolt_aoe_shadow_bouncing"})
            AddAbilityToUnit({target = caster, abil = "pve_temple_spottheweak"})
            caster:SetModel("models/heroes/wraith_king/wraith_frost.vmdl")
            caster:SetOriginalModel("models/heroes/wraith_king/wraith_frost.vmdl")
            HideWearables( {caster = caster} )
            local particle = ParticleManager:CreateParticle("particles/econ/events/ti7/blink_dagger_start_ti7_lvl2.vpcf", PATTACH_POINT_FOLLOW, caster)
            ParticleManager:ReleaseParticleIndex(particle)
        end)
        Timers:CreateTimer(5,function()
            EmitGlobalSound("omniknight_omni_death_05")
        end)
        PurgeUnit(event)
    end
end

function GlobalOnDealDamage( event )
    local caster = event.caster
    local target = event.unit
    caster.creepertarget = target
    if caster.talents then
        if caster.talents[50] and caster.talents[50] > 0 then
            threshold = 25
            local stackcount = caster:GetModifierStackCount("modifier_swipe_of_ursa", nil) + 1
            if stackcount >= threshold then
                stackcount = 0
                caster:RemoveModifierByName("modifier_swipe_of_ursa")
                SwipeOfUrsaTalent(caster, event.ability)
            else
                ApplyBuffStack({caster = caster, target = caster, ability = caster.combat_system_ability, dur = 30, buff = "modifier_swipe_of_ursa"})
            end
        end
        if caster.talents[44] and caster.talents[44] > 0 and not caster:HasModifier("modifier_backstab_cd") then
            ApplyBuff({caster = caster, target = target, ability = event.ability, dur = 1 + caster.talents[44], buff = "modifier_stunned"})
            ApplyBuff({caster = caster, target = caster, ability = caster.combat_system_ability, dur = 45, buff = "modifier_backstab_cd"})
            BloodArcana({caster = caster, target = target, ignore_crit_effect_cooldown = true })
        end
    end
end

function SwipeOfUrsaTalent(caster, original_ability)
    EmitSoundOn("Ability.SandKing_SandStorm.start", caster) 
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_ursa/ursa_overpower_cast.vpcf", PATTACH_POINT_FOLLOW, caster)
    ParticleManager:ReleaseParticleIndex(particle)
    local particle = ParticleManager:CreateParticle("particles/econ/items/legion/legion_overwhelming_odds_ti7/legion_commander_odds_ti7_proj_chunk_glow.vpcf", PATTACH_POINT_FOLLOW, caster)
    ParticleManager:ReleaseParticleIndex(particle)
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_nevermore/nevermore_loadout_ember_swirl.vpcf", PATTACH_POINT_FOLLOW, caster)
    ParticleManager:ReleaseParticleIndex(particle)
    Timers:CreateTimer(1.25,function()
        local event = {caster = caster, ability = caster.combat_system_ability, changedmgtypetophys = 1, damage_factor_single_target = 2, damage = 0, attributefactor = 500*caster.talents[50], attributechangestr = 1, aoe = 300, max_targets = 5, targeteffect = "arcanablood", isaoe = 1, delay = delay, dontbreakcc = 1 }
        if caster:HasModifier("modifier_pathbuff_066") and caster:GetAbilityByIndex(1) == original_ability then
            event.shadowdmg = 1
            event.attributechangestr = nil
            event.attributefactor = event.attributefactor * 1.25
        end
        EmitSoundOn("DOTA_Item.Necronomicon.Activate", caster)
        local particle = ParticleManager:CreateParticle("particles/econ/items/axe/axe_weapon_bloodchaser/axe_attack_blur_counterhelix_bloodchaser.vpcf", PATTACH_POINT_FOLLOW, caster)
        ParticleManager:ReleaseParticleIndex(particle)
        DamageAOE(event)
    end)
end

function SwipeOfUrsaItem( event )
    local caster = event.caster
    if caster and caster.talents and caster.talents[50] and caster.talents[50] > 0 and math.random(1,100) <= 100 then
        SwipeOfUrsaTalent(caster, original_ability)
    end
end

function SetBeastmasterItem( event )
    local caster = event.caster
    caster['item_beastmaster'..event.id] = event.ability
end

function GetClassRingPower( hero )
    local result = {0,0,0,0,0,0} -- 1st talent id, talent levels, 2nd ...
    local heroname = string.sub(hero:GetUnitName(), 15)
    if hero and hero.inventory and hero.inventory[3] and hero.inventory[3][1] and string.sub(hero.inventory[3][1], 12) == heroname then
        for i=1, 3 do
            result[-1 + i*2] = COverthrowGameMode:GetTalentIdByName(string.sub(hero.inventory[3][7+i], 8))
            result[0 + i*2] = hero.inventory[3][4+i]
        end
    end
    return result
end

function GetAmuletPathBonus( hero )
    local result = {0,0,0,0,0,0} -- 1st talent id, talent levels, 2nd ...
    if hero and hero.inventory and hero.inventory[8] and hero.inventory[8][1] then
        for i=1, 3 do
            if hero.inventory[8][7+i] and string.sub(hero.inventory[8][7+i], 1, 6) == " Path:" then
                result[-1 + i*2] = COverthrowGameMode:GetTalentIdByName(string.sub(hero.inventory[8][7+i], 8))
                result[0 + i*2] = hero.inventory[8][4+i]
            end
        end
    end
    return result
end

function COverthrowGameMode:GetTalentIdByName( pathname )
    for i=1, #COverthrowGameMode.PathTalentNames do
        if pathname and pathname == COverthrowGameMode.PathTalentNames[i] then
            return i
        end
    end
    return 0
end

function COverthrowGameMode:GetTalentNameById( id )
    return COverthrowGameMode.PathTalentNames[id]
end

function COverthrowGameMode:DropClassQuestReward( hero, quality, slot )
    local weapon = quality .. slot .. "class_" .. string.sub(hero:GetUnitName(), 15)
    COverthrowGameMode:CreateMythicWeapon( hero, weapon, false, nil, nil, nil, false )
    Notifications:Bottom(hero:GetPlayerID(), {text="Hero Quest completed!", duration=10, style={color="lightgreen"}})
end

function PathAlphaBloodProc( caster, ability )
    if not caster.path_alpha_blood_cd then
        caster.path_alpha_blood_cd = true
        HealUnit({caster = caster, target = caster, ability = ability, heal = caster:GetMaxHealth()*0.1})
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_lycan/lycan_summon_wolves_spawn.vpcf", PATTACH_POINT_FOLLOW, caster)
        ParticleManager:ReleaseParticleIndex(particle)
        Timers:CreateTimer(3,function()
            caster.path_alpha_blood_cd = nil
        end)
    end
end

function PathRainOfStars(event)
    local caster = event.caster
    if caster:HasModifier("modifier_pathbuff_021") then
        HealUnit({caster = caster, target = caster, ability = event.ability, heal = caster:GetMaxHealth()*0.01})
    end
end

function PathCounterattack(event)
    local caster = event.caster
    local attacker = event.attacker
    if not HasDamageReflect(attacker) and not CheckForBreakableCC(attacker) then
        event.target = attacker
        HitFX( caster, attacker )
        DamageUnit(event)
    end
end

function WalkingLaserTrap( event )
    local caster = event.caster
    local ability = event.ability
    local bots = {}
    local directions = {}
    local heroes_to_chase = {}
    local movement_pattern = 3 --1 = straight, 2 = random, 3 = chase
    local delay = 2.5
    local ticks = 0.33
    local bot_count = 3
    local duration = 15
    local can_not_be_targeted = true
    EmitSoundOn("Item.LotusOrb.Activate", caster)
    for i=1, bot_count do
        heroes_to_chase[i] = COverthrowGameMode:PVERandomTargetNearTarget(caster, 3500, heroes_to_chase[i-1])
        directions[i] = Vector(0,0,0) + RandomVector(1)
        local unit = CreateUnitByName("temple_walking_bot", caster:GetAbsOrigin() + RandomVector(300), true, nil, nil, DOTA_TEAM_NEUTRALS )
        bots[i] = unit
        unit.noexp = 1
        unit.damageimune = 1
        COverthrowGameMode:SetTempleStats(unit,COverthrowGameMode.jungledifficulty,100,1000,0,0)
        unit:SetForwardVector(directions[i])
        unit:SetModelScale(1.4)
        --ability:ApplyDataDrivenModifier(caster, unit, "modifier_stunned", {Duration = delay})
        if can_not_be_targeted then
            ability:ApplyDataDrivenModifier(caster, unit, "modifier_trap", {Duration = duration})
        end
    end
    Timers:CreateTimer(delay,function()
        Timers:CreateTimer(ticks,function()
            for i=1, bot_count do
                if bots[i] and not bots[i]:IsNull() and bots[i]:IsAlive() and caster and not caster:IsNull() then
                    --move patterns
                    --forward with slight curve
                    directions[i] = RotateVectorAroundAngle(directions[i], math.random(-10,10))
                    local move_pos = bots[i]:GetAbsOrigin() + directions[i] * 200
                    --random every 1.25 secs
                    if movement_pattern == 2 and math.random(1,100) <= ticks * 100 * 1.25 then
                        move_pos = bots[i]:GetAbsOrigin() + RandomVector(1) * 200
                    end
                    --follow hero
                    if movement_pattern == 3 and heroes_to_chase[i] then
                        move_pos = heroes_to_chase[i]:GetAbsOrigin() + (heroes_to_chase[i]:GetAbsOrigin() - bots[i]:GetAbsOrigin()):Normalized() * 200
                    end
                    local order = { UnitIndex = bots[i]:entindex(), OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION, Position = move_pos }
                    ExecuteOrderFromTable(order)
                    if i ~= bot_count then --last does not shoot
                        --dmg and fx only once
                        local info = 
                        {
                            Ability = ability,
                            EffectName = "particles/econ/generic/generic_projectile_linear_1/generic_projectile_linear_1.vpcf",
                            vSpawnOrigin = bots[i]:GetAbsOrigin(),
                            fDistance = (bots[i]:GetAbsOrigin() - bots[i+1]:GetAbsOrigin()):Length(),
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
                            vVelocity = 3000 * (bots[i+1]:GetAbsOrigin() - bots[i]:GetAbsOrigin()):Normalized(),
                            bProvidesVision = true,
                            iVisionRadius = 1000,
                            iVisionTeamNumber = caster:GetTeamNumber()
                        }
                        local projectile = ProjectileManager:CreateLinearProjectile(info)
                        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_tinker/tinker_laser.vpcf", PATTACH_POINT_FOLLOW, bots[i])
                        ParticleManager:SetParticleControl(particle, 9, bots[i]:GetAbsOrigin() + Vector(0,0,100))
                        ParticleManager:SetParticleControl(particle, 1, bots[i+1]:GetAbsOrigin() + Vector(0,0,100))
                        ParticleManager:ReleaseParticleIndex(particle)
                        particle = ParticleManager:CreateParticle("particles/units/heroes/hero_tinker/tinker_laser.vpcf", PATTACH_POINT_FOLLOW, bots[i+1])
                        ParticleManager:SetParticleControl(particle, 9, bots[i+1]:GetAbsOrigin() + Vector(0,0,100))
                        ParticleManager:SetParticleControl(particle, 1, bots[i]:GetAbsOrigin() + Vector(0,0,100))
                        ParticleManager:ReleaseParticleIndex(particle)
                    end
                    if i == bot_count then
                        --repeat
                        EmitSoundOn("DOTA_Item.Butterfly", caster)
                        return ticks
                    end
                end
            end
        end)
    end)
    Timers:CreateTimer(duration,function()
        for i=1, bot_count do
            bots[i]:ForceKill(false)
        end
    end)
end

function SpinningLaserTrap( event )
    local caster = event.caster
    local ability = event.ability
    local bots = {}
    local directions = {}
    local laser_every = 0.09
    local laser_time_counter = {}
    local turnrate = 1.35
    if math.random(1,100) <= 50 then
        turnrate = - turnrate
    end
    local delay = 2.5
    local ticks = 0.03
    local bot_count = 1
    local duration = 15
    local can_not_be_targeted = true
    EmitSoundOn("Item.LotusOrb.Activate", caster)
    for i=1, bot_count do
        laser_time_counter[i] = 0
        directions[i] = Vector(0,0,0) + RandomVector(1)
        local unit = CreateUnitByName("temple_walking_bot", caster:GetAbsOrigin() + RandomVector(250), true, nil, nil, DOTA_TEAM_NEUTRALS )
        bots[i] = unit
        unit.noexp = 1
        unit.damageimune = 1
        COverthrowGameMode:SetTempleStats(unit,COverthrowGameMode.jungledifficulty,100,1000,0,0)
        unit:SetForwardVector(directions[i])
        unit:SetModelScale(1.8)
        unit:SetRenderColor(255, 100, 100)
        --ability:ApplyDataDrivenModifier(caster, unit, "modifier_stunned", {Duration = delay})
        if can_not_be_targeted then
            ability:ApplyDataDrivenModifier(caster, unit, "modifier_trap", {Duration = duration})
        end
    end
    Timers:CreateTimer(delay,function()
        Timers:CreateTimer(ticks,function()
            for i=1, bot_count do
                if bots[i] and not bots[i]:IsNull() and bots[i]:IsAlive() then
                    laser_time_counter[i] = laser_time_counter[i] + ticks
                    directions[i] = RotateVectorAroundAngle(directions[i], turnrate)
                    bots[i]:SetForwardVector(directions[i])
                    if laser_time_counter[i] >= laser_every then
                        laser_time_counter[i] = 0
                        local info = 
                        {
                            Ability = ability,
                            EffectName = "particles/econ/generic/generic_projectile_linear_1/generic_projectile_linear_1.vpcf",
                            vSpawnOrigin = bots[i]:GetAbsOrigin(),
                            fDistance = 2000,
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
                            vVelocity = 3000 * bots[i]:GetForwardVector(),
                            bProvidesVision = true,
                            iVisionRadius = 1000,
                            iVisionTeamNumber = caster:GetTeamNumber()
                        }
                        local projectile = ProjectileManager:CreateLinearProjectile(info)
                        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_centaur/centaur_double_edge_tgt_rope.vpcf", PATTACH_POINT_FOLLOW, bots[i])
                        ParticleManager:SetParticleControl(particle, 5, bots[i]:GetAbsOrigin() + Vector(0,0,100))
                        ParticleManager:SetParticleControl(particle, 4, bots[i]:GetAbsOrigin() + 2000 * bots[i]:GetForwardVector() + Vector(0,0,100))
                        ParticleManager:ReleaseParticleIndex(particle)
                    end
                    if i == bot_count then
                        --repeat
                        EmitSoundOn("DOTA_Item.Butterfly", caster)
                        return ticks
                    end
                end
            end
        end)
    end)
    Timers:CreateTimer(duration,function()
        for i=1, bot_count do
            bots[i]:ForceKill(false)
        end
    end)
end

function CountBuffs( unit, buff )
    local count = 0
    local mods = unit:GetModifierCount()-1
    for i=0, mods do
        local name = unit:GetModifierNameByIndex(i)
        if name == buff then
            count = count + 1
        end
    end
    return count
end

function SinkUnitInGroundOverTime( event )
    local unit = event.target
    local pos = unit:GetAbsOrigin()
    local time_passed = 0
    local stepsize = event.depth / (30 * event.duration)
    Timers:CreateTimer(0.03,function()
        if unit and not unit:IsNull() then
            time_passed = time_passed + 0.03
            if time_passed < event.duration then
                unit:SetAbsOrigin(unit:GetAbsOrigin() + Vector(0,0,stepsize))
            end
            if time_passed < event.resetafter then
                return 0.03
            else
                unit:SetAbsOrigin(pos)
            end
        end
    end)
end

function AffixStunNearbyChickens( event )
    local caster = event.caster
    local target = event.target
    local ability = event.ability
    if target and target:HasModifier("modifier_chicken_affix_abil") and caster ~= target then
        ability:ApplyDataDrivenModifier(caster, target, "modifier_stunned", {Duration = 5})
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_centaur/centaur_double_edge_tgt_rope.vpcf", PATTACH_POINT_FOLLOW, caster)
        ParticleManager:SetParticleControl(particle, 5, caster:GetAbsOrigin() + Vector(0,0,100))
        ParticleManager:SetParticleControl(particle, 4, target:GetAbsOrigin() + Vector(0,0,100))
        ParticleManager:ReleaseParticleIndex(particle)
    end
end

function AffixStarboy( event )
    local caster = event.caster
    local ability = event.ability
    local duration = 20
    local stars_per_sec = 4
    local ticks = duration * stars_per_sec
    local tick_interval = 1 / stars_per_sec
    local fly_time = 3.5
    local aoe = 150
    for i=0, ticks - 1 do
        Timers:CreateTimer(tick_interval * i,function()
            if caster and caster:IsNull() then
                return
            end
            local target_point = caster:GetAbsOrigin() + RandomVector(math.random(1, 1500))
            FXStarfall(caster, target_point, Vector(600,600,1200), fly_time, aoe)
            Timers:CreateTimer(fly_time,function()
                local tab = {}
                tab.caster = caster
                tab.damage = 0.0
                tab.spelldamagefactor = 0.0
                tab.attributefactor = 0.0
                tab.includeauto = 500
                tab.ability = ability
                tab.aoe = aoe
                tab.targeteffect = "blood"
                tab.onlyhero = 1
                tab.target_points = {}
                tab.target_points[1] = target_point
                DamageAOE(tab)
            end)
        end)
    end
end

function FXStarfall(caster, target_point, offset, time, aoe)
    local particle = ParticleManager:CreateParticle("particles/invoker_chaos_meteor_fly_blue_slow2.5.vpcf", PATTACH_WORLDORIGIN, caster)
    ParticleManager:SetParticleControl(particle, 0, target_point + offset)
    ParticleManager:SetParticleControl(particle, 1, target_point + Vector(0,0,50))
    ParticleManager:SetParticleControl(particle, 2, Vector(time,0,0))
    ParticleManager:ReleaseParticleIndex(particle)
    EmitSoundOn("Hero_Luna.Eclipse.Cast", caster)
    Timers:CreateTimer(time,function()
        particle = ParticleManager:CreateParticle("particles/econ/items/wisp/wisp_death_ti7_model.vpcf", PATTACH_WORLDORIGIN, caster)
        ParticleManager:SetParticleControl(particle, 1, target_point)
        ParticleManager:ReleaseParticleIndex(particle)
        particle = ParticleManager:CreateParticle("particles/items2_fx/veil_of_discord.vpcf", PATTACH_WORLDORIGIN, caster)
        ParticleManager:SetParticleControl(particle, 0, target_point)
        ParticleManager:SetParticleControl(particle, 1, Vector(aoe,aoe,aoe))
        ParticleManager:ReleaseParticleIndex(particle)
    end)
end

function AffixGreedySaw( event )
    local caster = event.caster
    local target = event.target
    local ability = event.ability
    local target_point = Vector(0,0,0)
    local all = HeroList:GetAllHeroes()
    local enemy_count = 0
    for i=1, #all do
        if all[i] and (all[i]:GetAbsOrigin() - target:GetAbsOrigin()):Length() <= 2500 then
            target_point = target_point + all[i]:GetAbsOrigin()
            enemy_count = enemy_count + 1
        end
    end
    if enemy_count > 0 then
        target_point = target_point / enemy_count
        local order = 
        {
            UnitIndex = target:entindex(),
            OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
            Position = target_point
        }
        ExecuteOrderFromTable(order)
    end
end

function AutoAttackCriticalStrike( event )
    local caster = event.attacker
    local target = event.target
    local crit_factor = event.aacrit_factor
    local crit_factor_bonus = 1
    local crit_chance = event.aacrit_chance
    if event.aacrit_chance_buff_based then
        crit_chance = caster:GetModifierStackCount(event.aacrit_chance_buff_based, nil)
    end
    local buff = "system_aacrit"
    local ability = event.ability
    --bonuses
    if caster:HasModifier("modifier_item_item_set_t4_aad_4") then
        crit_factor_bonus = crit_factor_bonus + 0.5
    end
    if caster:HasModifier("modifier_item_set_agi_dmg_full_t1_2") then
        crit_factor_bonus = crit_factor_bonus + 0.25
    end
    if caster:HasModifier("modifier_special_bonus_gold_income") then
        crit_factor_bonus = crit_factor_bonus + 0.25
    end
    if caster:HasModifier("modifier_pathbuff_049") then
        crit_factor_bonus = crit_factor_bonus + 0.25
    end
    if caster.lifeblood and caster.lifeblood > 1 and caster.talents and caster.talents[74] and caster.talents[74] > 0 and caster.path_sacrifice_souls_paid and caster:HasModifier("modifier_pathbuff_074") then
        crit_factor_bonus = crit_factor_bonus + 0.25
    end
    if caster:HasModifier("modifier_special_bonus_vision") then
        crit_factor_bonus = crit_factor_bonus + 0.1
    end
    if caster.ab_crit_counter_last_5_secs and caster.ab_crit_counter_last_5_secs > 0 then
    	local sniper_ability = caster:FindAbilityByName("Bear")
    	if sniper_ability and sniper_ability:GetLevel() >= 4 then
    		crit_factor_bonus = crit_factor_bonus + 1
    	end
    end
    if caster.windfury_proc_crit_bonus then
        crit_chance = crit_chance * 2
    end
    if caster and caster.talents then
        --caster.talents[82] = 2
        if caster.talents[82] and caster.talents[82] > 0 and math.random(1,100) <= 25 then
            crit_factor_bonus = crit_factor_bonus + 0.5 * caster.talents[82]
        end
    end
    if event.moonglaive_shield and caster:HasModifier("modifier_pathbuff_018") then
    	crit_factor_bonus = crit_factor_bonus * 3
    end
    if math.random(1,100) <= crit_chance then
        if caster:HasModifier("modifier_item_myth_aad") then
            if caster.aa_crit_counter then
                caster.aa_crit_counter = caster.aa_crit_counter + 1
                if caster.aa_crit_counter % 3 == 0 then
                    crit_factor = crit_factor * 2
                end
                if caster.aa_crit_counter > 10000000 then
                    caster.aa_crit_counter = 1
                end
            else
                caster.aa_crit_counter = 1
            end
        end
        caster:RemoveModifierByName(buff)
        ability:ApplyDataDrivenModifier(caster, caster, buff, nil)
        caster:SetModifierStackCount(buff, ability, crit_factor * crit_factor_bonus)
        --on crit procs
        if caster and caster.talents then
            --caster.talents[78] = 2
            if caster.talents[78] and caster.talents[78] > 0 then
                ApplyBuffStack({caster = caster, target = target, ability = caster.combat_system_ability, dur = 3, addstacks = 2 * caster.talents[78], max = 2 * caster.talents[78], buff = "modifier_stormclaws_armor"})
            end
        end
        if caster:HasModifier("modifier_catform") then
        	local feral_ability = caster:FindAbilityByName("ShapeshiftFeral")
        	if feral_ability and feral_ability:GetLevel() >= 4 then
        		feral_ability:ApplyDataDrivenModifier(caster, caster, "modifier_bat_1_wildg", {Duration = 3})
        	end
        end
        --aa crit in last 10 secs counter
        if not caster.aa_crit_counter_last_10_secs then
        	caster.aa_crit_counter_last_10_secs = 0
        end
        caster.aa_crit_counter_last_10_secs = caster.aa_crit_counter_last_10_secs + 1
        if caster.aa_crit_counter_last_10_secs == 1 and caster.talents[58] and caster.talents[58] > 0 then
        	caster.true_blood_particle = ParticleManager:CreateParticle("particles/items4_fx/spirit_vessel_damage_ring_detail.vpcf", PATTACH_POINT_FOLLOW, caster)
        end
        Timers:CreateTimer(5, function()
        	caster.aa_crit_counter_last_10_secs = caster.aa_crit_counter_last_10_secs - 1
        	if caster.aa_crit_counter_last_10_secs == 0 and caster.true_blood_particle then
        		ParticleManager:DestroyParticle(caster.true_blood_particle,false)
        		ParticleManager:ReleaseParticleIndex(caster.true_blood_particle)
        	end
        end)
    end
end

function GetHighestAbilityScaling(event)
    local scaling = 0
    if event.attributefactor then
        scaling = event.attributefactor
    end
    local value = event.spelldamagefactor
    if value and value > scaling then
        scaling = value
    end
    value = event.includeauto
    if value and value > scaling then
        scaling = value
    end
    value = event.includefullauto
    if value and value > scaling then
        scaling = value
    end
    return scaling
end

function GetPathBonusesFromPathWords(hero)
    if not hero.talents_without_pathwords then
        return nil
    end
    local pathwords = {}
    for i=1, COverthrowGameMode.maxtalents do
        pathwords[i] = {0, nil}
    end
    local proc_threshold = 6
    local bonus_on_proc = 1
    local offset = 60 --30
    local max_path_words = 12
    local path_words_found = 0
    for i=1, COverthrowGameMode.maxtalents do
        if hero.talents_without_pathwords[i] and hero.talents_without_pathwords[i] >= proc_threshold then
            local first_tree = COverthrowGameMode:GetTalentTreeByTalentPoint(i)
            for j=i+1, COverthrowGameMode.maxtalents do
                local second_tree = COverthrowGameMode:GetTalentTreeByTalentPoint(j)
                if hero.talents_without_pathwords[j] and hero.talents_without_pathwords[j] >= proc_threshold and first_tree ~= second_tree and path_words_found <= max_path_words then
                    local bonus_index = 1 + ((i * j + offset) % 89)
                    if bonus_index == 51 or bonus_index == 54 or bonus_index == 57 or bonus_index == 60 or bonus_index == 75 then
                        bonus_index = bonus_index - 1
                    end
                    local name1 = GetFirstPathName(i)
                    local name2 = GetLastPathName(j)
                    --local name3 = GetLastPathName(bonus_index)
                    if name1 and name2 then --name3
                        local new_bonus = pathwords[bonus_index][1] + bonus_on_proc
                        --local bonus_name = name1 .. " " .. name2 .. " " .. name3 .. ": +" .. new_bonus .. " " .. COverthrowGameMode.PathTalentNames[bonus_index]
                        local bonus_name = name1 .. " " .. name2 .. " " .. ": +" .. new_bonus .. " " .. COverthrowGameMode.PathTalentNames[bonus_index]
                        pathwords[bonus_index] = {new_bonus, bonus_name}
                        path_words_found = path_words_found + 1
                    end
                end
            end
        end
    end
    --DeepPrintTable(pathwords)
    return pathwords
end

function GetFirstPathName( id )
    local pieces = COverthrowGameMode.PathTalentNames[id]
    local words = {}
    for w in pieces:gmatch("%S+") do 
        table.insert(words, w) 
    end
    return words[1]
end

function GetLastPathName( id )
    local pieces = COverthrowGameMode.PathTalentNames[id]
    local words = {}
    for w in pieces:gmatch("%S+") do 
        table.insert(words, w) 
    end
    return words[#words]
end

function SendPathWordsToUI(hero, pathwords)
    local bonuses = ""
    for i=1, COverthrowGameMode.maxtalents do
        if pathwords and pathwords[i] and pathwords[i][1] > 0 then
            bonuses = bonuses .. pathwords[i][2] .. "," .. i .. ","
        end
    end
    --local player = PlayerResource:GetPlayer(hero:GetPlayerID())
    --print(bonuses)
    CustomGameEventManager:Send_ServerToAllClients("pathword", { playerid = hero:GetPlayerID(), pathword = bonuses } )
end

function ApplyBuffDataDriven( event )
    local caster = event.caster
    local ability = event.ability
    local target = event.target
    if event.only_when_damaged and caster:GetHealth() / caster:GetMaxHealth() >= 1 then
        return
    end
    ability:ApplyDataDrivenModifier(caster, target, event.buff, {Duration = event.dur})
end

function WingedGrave( event )
	local caster = event.caster
	local target = event.target
	local ability = event.ability
	if not target:HasModifier("modifier_winged_grave_cd") then
		ApplyBuff(event)
		--event.buff = "modifier_guaranteed_crit"
		--event.dur = event.dur2
		--ApplyBuff(event)
		ability:ApplyDataDrivenModifier(caster, target, "modifier_winged_grave_cd", {Duration = 45})
	end
end

function CainSetGiveLife( event )
	local caster = event.caster
	local target = event.target
	local max_lives = event.count
	if not caster.cain_lives_given then
		caster.cain_lives_given = 0
	end
	if caster.cain_lives_given < max_lives and target and target.ArenaControl and target.pvelives then
		local lives = target:GetModifierStackCount("modifier_pvelives", nil)
		target.ArenaControl:GetAbilityByIndex(0):ApplyDataDrivenModifier(target.ArenaControl, target, "modifier_pvelives", nil)
		target:SetModifierStackCount("modifier_pvelives", target.ArenaControl:GetAbilityByIndex(0), lives + 1)
		target.pvelives = target.pvelives + 1
		caster.cain_lives_given = caster.cain_lives_given + 1
		EmitGlobalSound("treant_treant_spawn_04")
	end
end

function SetInstanCasts( event )
	local caster = event.caster
	local ability = event.ability
	--if not caster.book_of_runes_instants then
	--	caster.book_of_runes_instants = 0
	--end
	caster.book_of_runes_ability = ability
	caster.book_of_runes_instants = event.amount
	ability:ApplyDataDrivenModifier(caster, caster, "modifier_book_instant_casts", nil)
	caster:SetModifierStackCount("modifier_book_instant_casts", ability, caster.book_of_runes_instants)
end