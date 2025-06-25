wild_guardian_precache = class({})

function wild_guardian_precache:Precache(context)
	-- human form abilities
	PrecacheItemByNameSync("RegrowthFeral", context)
	PrecacheItemByNameSync("RootsDruidFeral", context)
	PrecacheItemByNameSync("CycloneDruidFeral", context)
	PrecacheItemByNameSync("empty_spell1", context)
	PrecacheItemByNameSync("empty_spell2", context)
end