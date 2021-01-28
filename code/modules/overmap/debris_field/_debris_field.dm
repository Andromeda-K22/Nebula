/obj/effect/overmap/visitable/sector/debris_field
	name = "debris_field"
	icon = 'icons/obj/overmap.dmi'
	icon_state = "globe"
	sector_flags = OVERMAP_SECTOR_KNOWN
	free_landing = TRUE

	var/ruin_tags_whitelist
	var/ruin_tags_blacklist
	var/features_budget = 4
	var/list/spawned_features = list()

/obj/effect/overmap/visitable/sector/debris_field/Initialize(mapload, z_level)
	. = ..()
	generate_debris()

/obj/effect/overmap/visitable/sector/debris_field/find_z_levels()
	INCREMENT_WORLD_Z_SIZE
	map_z += world.maxz

/obj/effect/overmap/visitable/sector/debris_field/proc/generate_debris()
	var/list/possible_features = list()
	for(var/T in subtypesof(/datum/map_template/ruin/space))
		var/datum/map_template/ruin/space/ruin = T
		if(ruin_tags_whitelist && !(ruin_tags_whitelist & initial(ruin.ruin_tags)))
			continue
		if(ruin_tags_blacklist & initial(ruin.ruin_tags))
			continue
		possible_features += new ruin
	spawned_features = seedRuins(map_z, features_budget, /area/space, possible_features, world.maxx, world.maxy)