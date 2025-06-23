demonic_witcher_precache = class({})

function demonic_witcher_precache:Precache(context)
	-- fire summon
	PrecacheUnitByNameSync("npc_dota_creature_hellguard", context)
	-- shadow summon
	PrecacheUnitByNameSync("npc_dota_creature_shadowimp", context)
end