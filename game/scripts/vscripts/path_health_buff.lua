path_health_buff = class({})
--path_health_buff.stackcount = 0

function path_health_buff:DeclareFunctions()
    return { MODIFIER_PROPERTY_HEALTH_BONUS }
end

function path_health_buff:GetModifierHealthBonus()
	--print("grab")
	--print(self.stackcount)
    return self:GetStackCount() --self.stackcount
end

function path_health_buff:OnStackCountChanged(stacks)
	--print("before change")
	--print(self.stackcount)
    --self.stackcount = self:GetStackCount()
    --print("after change")
	--print(self.stackcount)
end

function path_health_buff:IsHidden()
    return true
end

function path_health_buff:IsPurgable()
    return false
end