modifier_shadow_cleric_path_of_darkness_shadow_priest_form = class({
	IsHidden = function() 
        return false 
    end,
	IsPurgable = function() 
        return false 
    end,
    IsDebuff = function()
		return false
	end,
    GetTexture = function()
        return "fix/shadow_priest_form"
    end
})

function modifier_shadow_cleric_path_of_darkness_shadow_priest_form:OnCreated()
    if(not IsServer()) then
        return
    end

    self.parent = self:GetParent()

    self.parent.dsModel = self.parent:GetModelName()
    self.parent:SetModel("models/items/enigma/eidolon/enigma_seer_of_infinity_space_eidolon/enigma_seer_of_infinity_space_eidolon.vmdl")
    self.parent:SetOriginalModel("models/items/enigma/eidolon/enigma_seer_of_infinity_space_eidolon/enigma_seer_of_infinity_space_eidolon.vmdl")
    self.parent:SetModelScale(1.25)

    self:AdjustMindshatterAbilityCharges()
end

function modifier_shadow_cleric_path_of_darkness_shadow_priest_form:OnDestroy()
    if(not IsServer()) then
        return
    end

    if self.parent.dsModel then
        self.parent:SetModel(self.parent.dsModel)
        self.parent:SetOriginalModel(self.parent.dsModel)
        self.parent:SetModelScale(1)
    end

    self:AdjustMindshatterAbilityCharges()
end

function modifier_shadow_cleric_path_of_darkness_shadow_priest_form:AdjustMindshatterAbilityCharges()
    local abilityName = "shadow11"
    local mindshatterAbility = self.parent:FindAbilityByName(abilityName)

    if(mindshatterAbility == nil) then
        return
    end

    -- Destroy charges modifier if class item equipped
    if self.parent:HasModifier("modifier_shadow_cleric_path_of_darkness_shadow_priest_form") then
        local chargesModifiers = self.parent:FindAllModifiersByName("modifier_charges")
        for _, chargeModifier in pairs(chargesModifiers) do
            local chargeModifierAbility = chargeModifier:GetAbility()
            if(chargeModifierAbility == mindshatterAbility) then
                chargeModifier:Destroy()
                mindshatterAbility:EndCooldown()
                break
            end
        end
    else
        -- Restore charges modifier (await hero respawn because dead units can't recieve new modifiers)
        if(self.parent:IsAlive()) then
            modifier_shadow_cleric_path_of_darkness_shadow_priest_form:RestoreCharges(self.parent, abilityName)
        else
            Timers:CreateTimer(1, function()
                if(self.parent:IsAlive()) then
                    modifier_shadow_cleric_path_of_darkness_shadow_priest_form.RestoreCharges(nil, self.parent, abilityName)
                else
                    return 1
                end
            end)
        end

    end
end

function modifier_shadow_cleric_path_of_darkness_shadow_priest_form:RestoreCharges(hero, abilityName)
    hero[abilityName.."_is_init"] = false
    COverthrowGameMode:CheckForHeroChargeAbilities(hero)
end