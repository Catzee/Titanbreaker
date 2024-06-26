

--if _G.RageSystem == nil then
--	_G.RageSystem = class({}) -- put COverthrowGameMode in the global scope
--	print("global maker called Rage")
	--refer to: http://stackoverflow.com/questions/6586145/lua-require-with-global-local
--end

-- Rage System -----------------------------------------------------------------------------------------

-- Energy System ------------------------------------------------------------

function SetEnergy( event ) 
  local hero = event.caster
  return
  hero:SetMana(event.energy)
end

function GetMaxEnergy( event ) 
  local hero = event.caster
  local maxEnergy = 100
  local rogue_abil = hero:GetAbilityByIndex(5)
  if rogue_abil and rogue_abil:GetLevel() >= 2 and rogue_abil:GetName() == "Shadow_Walk" then
    maxEnergy = maxEnergy + 50
  end
  rogue_abil = hero:FindAbilityByName("deadly4")
  if rogue_abil and rogue_abil:GetLevel() >= 3 then
    maxEnergy = maxEnergy + 100
  end
  if hero:HasModifier("modifier_item_weapon14") then
    maxEnergy = maxEnergy + 20
  end
  if hero:HasModifier("modifier_item_hunterbow") then
    maxEnergy = maxEnergy + 20
  end
  if hero:HasModifier("modifier_item_hunterbow2") then
    maxEnergy = maxEnergy + 20
  end
  if hero:HasModifier("modifier_item_rogueblades") then
    maxEnergy = maxEnergy + 20
  end
  if hero:HasModifier("modifier_item_demonglaive") then
    maxEnergy = maxEnergy + 20
  end
  --if hero:HasModifier("modifier_special_bonus_respawn_reduction") then
  --  maxEnergy = maxEnergy + 25
  --end
  if hero.resourcesystem then
    maxEnergy = maxEnergy + hero:GetModifierStackCount("modifier_mana_from_custom_int", nil)
  end
  if hero:HasModifier("modifier_special_bonus_mp") then
    maxEnergy = maxEnergy + 50
  end
  if hero:HasModifier("modifier_item_weapon7up4") then
    maxEnergy = maxEnergy + 50
  end
    if hero:GetName() == "npc_dota_hero_juggernaut" then
        maxEnergy = maxEnergy + 25
    end
    if hero.talents and hero.talents[120] then
      maxEnergy = maxEnergy + 15 * hero.talents[120]
    end
  if GetLevelOfAbility( hero, "Snipe" ) >= 2 then
        maxEnergy = maxEnergy + 100
    end
  return maxEnergy
end

function GetEnergyBonusFactor( event ) 
  local hero = event.caster
  local energygain = 1
  local rogue_abil = hero:GetAbilityByIndex(5)
  if hero:HasModifier("modifier_ranger_regen_bonus") then
    energygain = energygain + 1
  end
  if hero:HasModifier("modifier_ranger_regen_bonus2") then
    energygain = energygain + 2
  end
  if hero:HasModifier("modifier_heartbreaker") then
    energygain = energygain + 0.5
  end
  if hero:HasModifier("modifier_companion") then
    energygain = energygain + 0.5
  end
  if hero:HasModifier("modifier_item_weapon7up2") then
    energygain = energygain + 0.25
  end
  if hero:HasModifier("modifier_item_weapon7up5") then
    energygain = energygain + 0.3
  end
  if hero:HasModifier("modifier_eneriki") then
    energygain = energygain + 0.5
  end
  
  if hero:HasModifier("modifier_class_terror") and hero:HasModifier("modifier_dh_aa_heal") then
    energygain = energygain + 1
  end
  if hero:HasModifier("modifier_item_weapon7up") then
    energygain = energygain + 0.2
  end
  if hero:HasModifier("modifier_special_bonus_hp_regen") then
    energygain = energygain + 0.1
  end
  if hero:HasModifier("modifier_special_bonus_mp_regen") then
    energygain = energygain + 0.2
  end
  if hero:HasModifier("modifier_hawk4_regen") then
    energygain = energygain + 0.5
  end
  local windbreaker = hero:GetModifierStackCount("modifier_windbreaker", nil)
  if windbreaker > 0 then
    energygain = energygain + 0.1 * windbreaker
  end
  if hero.talents and hero.talents[26] then
    energygain = energygain + 0.05 * hero.talents[26]
  end
  if hero.talents and hero.talents[157] > 0 then
    energygain = energygain + 0.1 * hero.talents[157]
  end
  if hero.talents and hero.talents[74] and hero.talents[74] > 0 then
    energygain = energygain - 0.5
  end
  if hero.runeword and hero.runeword[18] then
    energygain = energygain + 0.01 * hero.runeword[18]
  end
  if rogue_abil and rogue_abil:GetLevel() >= 3 and rogue_abil:GetName() == "combat6" then
    energygain = energygain + 0.5
  end
  if hero:HasModifier("modifier_energy_doubled") then
    energygain = energygain + 1
  end
  local standsstill = hero.standsstill
    if standsstill and standsstill >= 5 then
        if hero:HasModifier("modifier_pathbuff_020") then
          energygain = energygain + 1
        end
    end
  if hero:HasModifier("modifier_mythic_resource") then
    energygain = energygain * (1 + hero:GetModifierStackCount("modifier_mythic_resource", nil) / 100)
  end
  return energygain
end

function AddEnergy( event ) 
    local hero = event.caster
    --return
    local energy = event.energy
    if event.targetchange then
        hero = event.target
    end
    if event.energypercent then
      energy = GetMaxEnergy(event) * event.energy / 100
    end
    if event.exludedh and hero.demonhunter then
        energy = 0
    end
    if event.demoncondition and not hero:HasModifier("modifier_item_demonglaive") then
        energy = 0
    end
    if event.classfactor then
        if hero.resourcesystem and hero.resourcesystem == 1 then
            energy = energy / 2
        end
    end
    if event.deathknight and hero:HasModifier("modifier_deathknight") then
        energy = energy * 2
    end
    local energy = energy * GetEnergyBonusFactor(event)
    if event.degeneration then
        energy = energy - event.degeneration
    end

    if not IsManaHero(hero) then
        if event.cap and energy > event.cap then
          energy = event.cap
        end
        local newEnergy = hero:GetMana() + energy
        if newEnergy < 0 then
            newEnergy = 0
        end
        if hero.Catform ~= nil and hero.Catform == 0 then

        else
            hero:SetMana(newEnergy)
        end
    end
end

function EnergyCost( event )
  local hero = event.caster
  local cost = 0 --event.cost
  if not hero then
    hero = event.attacker
  end
  if hero:HasModifier("modifier_manacost_reduction") then
    cost = event.cost * 0.25
  end
  if event.minus then
    cost = event.cost
  end
  if event.pay then
    hero:SetMana(hero:GetMana() - event.cost)
  end
  if event.minus or cost >= 1 then
      hero:SetMana(hero:GetMana() + cost)
  end
  --if event.minus then
  --  hero:SetMana(hero:GetMana() + cost)
  --else
    --hero:SetMana(hero:GetMana() - cost)
  --end
end

function EnergyCostRestore( event )
    local hero = event.caster
    hero:SetMana(hero:GetMana() + event.cost)
end

function AddComboPoints( event )
  local hero = event.caster
  if hero == nil then
    hero = event.attacker
  end
  --hero:GiveMana(3)
  if not hero.ComboPoints then
    hero.ComboPoints = 0
  end
  hero.ComboPoints = hero.ComboPoints + event.amount

  if event.max ~= nil then
    if hero.ComboPoints > event.max then
      hero.ComboPoints = event.max
    end
  else
    local maxCP = 3
    if hero:GetName() == "npc_dota_hero_dazzle" then
      maxCP = 4
    end
    if hero.ComboPoints > maxCP then
      hero.ComboPoints = maxCP
    end
  end
  if event.fixbufficon ~= nil then
    if hero:GetName() == "npc_dota_hero_riki" then
      hero:RemoveModifierByName("modifier_combopoint")
      hero:GetAbilityByIndex(2):ApplyDataDrivenModifier(hero, hero, "modifier_combopoint", nil)
    end
  end
  hero:SetModifierStackCount("modifier_combopoint", event.ability, hero.ComboPoints)
  AddCPEffect(event)
end

function SubComboPoints( event )
  	 local hero = event.caster
   --hero:GiveMana(3)
   	hero.ComboPoints=hero.ComboPoints+event.amount
   	if hero.ComboPoints < 0 then
   		hero.ComboPoints = 0
   	end
end

function MaxComboPoints( event )
     local hero = event.caster
     if hero == nil then
        hero = event.attacker
     end
    hero.ComboPoints = 3
    event.ability:ApplyDataDrivenModifier(hero, hero, "modifier_combopoint", nil)
    hero:SetModifierStackCount("modifier_combopoint", event.ability, hero.ComboPoints)
end