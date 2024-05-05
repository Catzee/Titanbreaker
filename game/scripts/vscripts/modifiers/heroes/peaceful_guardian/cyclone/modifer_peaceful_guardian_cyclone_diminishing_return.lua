modifer_peaceful_guardian_cyclone_diminishing_return = class({
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
        return "enraged_wildkin_tornado"
    end
})

function modifer_peaceful_guardian_cyclone_diminishing_return:OnCreated()
    if(not IsServer()) then
        return
    end
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self.buffName = self:GetName()
    
    self:StartIntervalThink(self.ability:GetSpecialValueFor("diminishingtickrate"))
end

function modifer_peaceful_guardian_cyclone_diminishing_return:OnIntervalThink()
    DecreaseBuffStack({
		caster = self.parent,
		target = self.parent,
		ability = self.ability,
        buff = self.buffName
    })
end