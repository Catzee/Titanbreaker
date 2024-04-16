--[[
modifier_path_health_buff = class({})
--modifier_path_health_buff.stackcount = 0

function modifier_path_health_buff:DeclareFunctions()
    return { MODIFIER_PROPERTY_HEALTH_BONUS }
end

function modifier_path_health_buff:GetModifierHealthBonus()
	--print("grab")
	--print(self.stackcount)
    return self:GetStackCount() --self.stackcount
end

function modifier_path_health_buff:OnStackCountChanged(stacks)
	--print("before change")
	--print(self.stackcount)
    --self.stackcount = self:GetStackCount()
    --print("after change")
	--print(self.stackcount)
end

function modifier_path_health_buff:IsHidden()
    return true
end

function modifier_path_health_buff:IsPurgable()
    return false
end
--]]