/obj/effect/fluid
	name = ""
	icon = 'icons/effects/liquids.dmi'
	anchored = 1
	simulated = 0
	opacity = 0
	mouse_opacity = 0
	layer = FLY_LAYER
	alpha = 0
	color = COLOR_OCEAN

	var/list/neighbors = list()
	var/last_flow_strength = 0
	var/next_fluid_act = 0
	var/update_lighting = FALSE

/obj/effect/fluid/airlock_crush()
	qdel(src)

/obj/effect/fluid/Move()
	crash_with("A fluid overlay had Move() called!")
	return FALSE

/obj/effect/fluid/on_reagent_change()
	if(reagents?.total_volume <= FLUID_EVAPORATION_POINT)
		qdel(src)
		return
	. = ..()
	ADD_ACTIVE_FLUID(src)
	update_lighting = TRUE
	queue_icon_update()

/obj/effect/fluid/Initialize()
	START_PROCESSING(SSobj, src)
	atom_flags |= ATOM_FLAG_OPEN_CONTAINER
	create_reagents(FLUID_MAX_DEPTH)
	. = ..()
	var/turf/simulated/T = get_turf(src)
	if(!isturf(T) || T.flooded)
		return INITIALIZE_HINT_QDEL
	if(istype(T))
		T.unwet_floor(FALSE)
	for(var/checkdir in GLOB.cardinal)
		var/obj/effect/fluid/F = locate() in get_step(src, checkdir)
		if(F)
			LAZYSET(neighbors, F, TRUE)
			LAZYSET(F.neighbors, src, TRUE)
			ADD_ACTIVE_FLUID(F)
	ADD_ACTIVE_FLUID(src)

/obj/effect/fluid/Destroy()
	var/turf/simulated/T = get_turf(src)
	if(istype(T))
		LAZYREMOVE(T.zone.fuel_objs, src)
		T.wet_floor()
	STOP_PROCESSING(SSobj, src)
	for(var/thing in neighbors)
		var/obj/effect/fluid/F = thing
		LAZYREMOVE(F.neighbors, src)
		ADD_ACTIVE_FLUID(F)
	neighbors = null
	REMOVE_ACTIVE_FLUID(src)
	. = ..()

/obj/effect/fluid/proc/remove_fuel(var/amt)
	for(var/rtype in reagents.reagent_volumes)
		var/decl/reagent/fuel = decls_repository.get_decl(rtype)
		if(fuel.fuel_value)
			var/removing = min(amt, reagents.reagent_volumes[rtype])
			reagents.remove_reagent(rtype, removing)
			amt -= removing
		if(amt <= 0)
			break

/obj/effect/fluid/proc/get_fuel_amount()
	. = 0
	for(var/rtype in reagents?.reagent_volumes)
		var/decl/reagent/fuel = decls_repository.get_decl(rtype)
		if(fuel.fuel_value)
			. += REAGENT_VOLUME(reagents, rtype) * fuel.fuel_value

/obj/effect/fluid/Process()
	if(reagents.total_volume <= FLUID_EVAPORATION_POINT)
		qdel(src)
		return
	if(isturf(loc) && reagents.total_volume)
		reagents.touch_turf(loc)
	if(world.time >= next_fluid_act && last_flow_strength >= 10 && length(loc.contents) > 1 && reagents.total_volume > FLUID_SHALLOW)
		next_fluid_act = world.time + SSfluids.fluid_act_delay
		if(prob(1))
			playsound(loc, 'sound/effects/slosh.ogg', 25, 1)
		for(var/thing in loc.contents)
			if(thing == src)
				continue
			var/atom/movable/AM = thing
			if(AM.simulated)
				AM.fluid_act(reagents)
			if(AM.is_fluid_pushable(last_flow_strength))
				step(AM, dir)

/obj/effect/fluid/on_update_icon()

	overlays.Cut()

	if(reagents.total_volume > FLUID_OVER_MOB_HEAD)
		layer = DEEP_FLUID_LAYER
	else
		layer = SHALLOW_FLUID_LAYER

	color = reagents.get_color()

	if(reagents.total_volume > FLUID_DEEP)
		alpha = FLUID_MAX_ALPHA
	else
		alpha = min(FLUID_MAX_ALPHA,max(FLUID_MIN_ALPHA,ceil(255*(reagents.total_volume/FLUID_DEEP))))

	if(reagents.total_volume <= FLUID_EVAPORATION_POINT)
		APPLY_FLUID_OVERLAY("shallow_still")
	else if(reagents.total_volume > FLUID_EVAPORATION_POINT && reagents.total_volume < FLUID_SHALLOW)
		APPLY_FLUID_OVERLAY("mid_still")
	else if(reagents.total_volume >= FLUID_SHALLOW && reagents.total_volume < (FLUID_DEEP*2))
		APPLY_FLUID_OVERLAY("deep_still")
	else if(reagents.total_volume >= (FLUID_DEEP*2))
		APPLY_FLUID_OVERLAY("ocean")

	if(update_lighting)
		update_lighting = FALSE
		var/glowing
		for(var/rtype in reagents.reagent_volumes)
			var/decl/reagent/reagent = decls_repository.get_decl(rtype)
			if(REAGENT_VOLUME(reagents, rtype) >= 3 && reagent.radioactive)
				glowing = TRUE
				break
		if(glowing)
			set_light(0.2, 0.1, 1, l_color = COLOR_GREEN)
		else
			set_light(0)	

// Map helper.
/obj/effect/fluid_mapped
	name = "mapped flooded area"
	alpha = 125
	icon_state = "shallow_still"
	color = COLOR_OCEAN

	var/fluid_type = /decl/reagent/water
	var/fluid_initial = FLUID_MAX_DEPTH

/obj/effect/fluid_mapped/Initialize()
	..()
	var/turf/T = get_turf(src)
	if(istype(T))
		var/obj/effect/fluid/F = locate() in T
		if(!F) F = new(T)
		F.reagents.add_reagent(fluid_type, fluid_initial)
	return INITIALIZE_HINT_QDEL

/obj/effect/fluid_mapped/fuel
	name = "spilled fuel"
	fluid_type = /decl/reagent/fuel
	fluid_initial = 10

// Permaflood overlay.
/obj/effect/flood
	name = ""
	mouse_opacity = 0
	layer = DEEP_FLUID_LAYER
	color = COLOR_OCEAN
	icon = 'icons/effects/liquids.dmi'
	icon_state = "ocean"
	alpha = FLUID_MAX_ALPHA
	simulated = 0
	density = 0
	opacity = 0
	anchored = 1

/obj/effect/flood/explosion_act()
	SHOULD_CALL_PARENT(FALSE)
	return

/obj/effect/flood/Initialize()
	. = ..()
	verbs.Cut()