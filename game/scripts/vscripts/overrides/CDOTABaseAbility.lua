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

function CDOTABaseAbility:OnAltCastToggled() end

function CDOTABaseAbility:_ToggleAltCast(altCasted)
    self._isAbilityAltCasted = not self:IsAltCasted()
end