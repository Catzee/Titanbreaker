modifier_shadow_cleric_dream_feast_buff = class({
	IsHidden = function() 
        return false 
    end,
	IsPurgable = function() 
        return false 
    end,
    IsDebuff = function()
		return false
	end
})

function modifier_shadow_cleric_dream_feast_buff:OnCreated()
    if(not IsServer()) then
        return
    end
end