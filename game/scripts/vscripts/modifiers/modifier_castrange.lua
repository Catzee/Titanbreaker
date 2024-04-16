--[[
modifier_castrange = class({})

if IsServer() then
    function modifier_castrange:DeclareFunctions()
        local funcs = {
            MODIFIER_PROPERTY_CAST_RANGE_BONUS,
            MODIFIER_PROPERTY_HEALTH_BONUS
        }

        return funcs
    end

    function modifier_castrange:OnRefresh()
        local ability = self:GetAbility()
        local StackCount = self:GetStackCount()
        local caster = self:GetParent()
    end
end

function modifier_castrange:DestroyOnExpire()
    return false
end

function modifier_castrange:IsPurgable()
    return false
end

function modifier_castrange:RemoveOnDeath()
    return false
end

function modifier_castrange:GetModifierCastRangeBonus()
    return self:GetStackCount()
end

function modifier_castrange:GetModifierHealthBonus()
    return self:GetStackCount()
end

function modifier_castrange:GetAttributes()
    return MODIFIER_ATTRIBUTE_PERMANENT
end
--]]