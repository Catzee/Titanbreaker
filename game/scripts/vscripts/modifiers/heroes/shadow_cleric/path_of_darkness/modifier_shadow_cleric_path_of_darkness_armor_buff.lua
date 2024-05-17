modifier_shadow_cleric_path_of_darkness_armor_buff = class({
	IsHidden = function() 
        return false 
    end,
	IsPurgable = function() 
        return false 
    end,
    IsDebuff = function()
		return false
	end,
    DeclareFunctions = function()
        return
        {
            MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
            MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
        }
    end,
    GetModifierPhysicalArmorBonus = function(self)
        return self.bonusArmor
    end,
    GetModifierMagicalResistanceBonus = function(self)
        return self.bonusSpellResistance
    end
})

function modifier_shadow_cleric_path_of_darkness_armor_buff:OnCreated()
    self:OnRefresh()

    if(not IsServer()) then
        return
    end

    self.parent = self:GetParent()

    local particle = ParticleManager:CreateParticle("particles/shadow_cleric_darkness_armor.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
    ParticleManager:SetParticleControlEnt(particle, 3, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
    self:AddParticle(particle, false, false, 1, false, false)
end

function modifier_shadow_cleric_path_of_darkness_armor_buff:OnRefresh()
    self.ability = self:GetAbility()
    self.bonusArmor = self.ability:GetSpecialValueFor("damage_proc_armor")
    self.bonusSpellResistance = self.ability:GetSpecialValueFor("damage_proc_spell_resistance")
end