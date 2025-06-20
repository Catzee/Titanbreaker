astral_guardian_precache = class({})

function astral_guardian_precache:Precache(context)
	-- moon abilities
	PrecacheItemByNameSync("moon11", context)
	PrecacheItemByNameSync("moon3", context)
	PrecacheItemByNameSync("moon2", context)
	PrecacheItemByNameSync("moon4", context)
	PrecacheItemByNameSync("moon5", context)
	-- sun abilities
	PrecacheItemByNameSync("moon1", context)
	PrecacheItemByNameSync("RootsDruidMoon", context)
	PrecacheItemByNameSync("moon12", context)
	PrecacheItemByNameSync("moon9", context)
	PrecacheItemByNameSync("moon10", context)
	PrecacheUnitByNameSync("npc_dota_creature_treant", context)
	-- swap
	PrecacheItemByNameSync("moon6", context)
end