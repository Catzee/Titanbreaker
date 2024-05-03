-- Guard in case valve decide to rename CDOTABaseAbility to destroy every custom game (happened at least once already with GameRules)...
if(CDOTABaseAbility == nil) then
    return
end

function CDOTABaseAbility:IsAltCasted()
    if(self._isAbilityAltCasted ~= nil) then
        return self._isAbilityAltCasted
    end

    return false
end

function CDOTABaseAbility:_ToggleAltCast(altCasted)
    self._isAbilityAltCasted = not self:IsAltCasted()
end

if(CDOTA_Ability_DataDriven ~= nil and CDOTA_Ability_DataDriven._internalApplyDataDrivenModifier == nil) then
    CDOTA_Ability_DataDriven._internalApplyDataDrivenModifier = CDOTA_Ability_DataDriven.ApplyDataDrivenModifier
end

-- Duct tape to make lua compat with data driven abilities
function CDOTABaseAbility:ApplyDataDrivenModifier(caster, target, modifierName, modifierTable)
    -- Should be safe and fast way to determine data driven ability
    if(self.ApplyDataDrivenThinker) then
        -- Valve renamed or removed data driven, too bad...
        if(CDOTA_Ability_DataDriven == nil) then
            print("Valve did something to break data driven. Fix manually...")
        else
            -- Calls data driven AddNewModifier
            if(CDOTA_Ability_DataDriven._internalApplyDataDrivenModifier) then
                CDOTA_Ability_DataDriven._internalApplyDataDrivenModifier(self, caster, target, modifierName, modifierTable)
            else
                -- Last resort to make all work
                CDOTA_Ability_DataDriven.ApplyDataDrivenModifier(self, caster, target, modifierName, modifierTable)
            end
        end
    else
		target:AddNewModifier(caster, self, modifierName, modifierTable)
    end
end