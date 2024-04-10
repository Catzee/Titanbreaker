function modifier_armor_formula:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_armor_formula:GetModifierPhysicalArmorBonus()
    if not self.calculatingArmor then
        self.calculatingArmor = true
        local parent = self:GetParent()
        local armor = parent:GetPhysicalArmorValue(false)
        parent.current_armor = armor
        local resistance = ( 0.05 * armor ) / ( 1 + 0.05 * armor ) --DESIRED ARMOR FORMULA
        local correctedArmor = ( 0.9 * resistance ) / ( 0.052 - 0.048 * resistance )
        self.calculatingArmor = nil
        return -parent.current_armor + correctedArmor
    end
    return 0
end

if IsClient() then
    function modifier_armor_formula:GetModifierPhysicalArmorBonus() return 0 end
end

function modifier_armor_formula:DestroyOnExpire()
    return false
end

function modifier_armor_formula:IsPurgable()
    return false
end

function modifier_armor_formula:RemoveOnDeath()
    return false
end

function modifier_armor_formula:IsHidden()
    return true
end

function modifier_armor_formula:GetAttributes()
  return MODIFIER_ATTRIBUTE_MULTIPLE
end