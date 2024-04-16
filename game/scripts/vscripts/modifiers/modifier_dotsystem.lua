modifier_dotsystem = class({})

if IsServer() then
    function modifier_dotsystem:OnCreated(kv)
        self.kv = kv
        local haste = GetChannelSpellhaste(caster)
        self:StartIntervalThink(self.kv.dur / haste)
    end

    function modifier_dotsystem:OnIntervalThink()
        DamageUnit(self.kv.damagedata)
        --self:GetAbility():ApplyDataDrivenModifier(self:GetCaster(), self:GetParent(), "modifier_dot_proc", {Duration = 0.05})
    end
end

function modifier_dotsystem:DestroyOnExpire()
    return true
end

function modifier_dotsystem:IsPurgable()
    return true
end

function modifier_dotsystem:RemoveOnDeath()
    return true
end

function modifier_dotsystem:IsHidden()
    return true
end

function modifier_dotsystem:GetAttributes()
  return MODIFIER_ATTRIBUTE_MULTIPLE
end