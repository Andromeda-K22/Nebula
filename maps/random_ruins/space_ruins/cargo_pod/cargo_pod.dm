/datum/map_template/ruin/space/cargo_pod
	name = "Cargo Pod"
	id = "ejected_cargo_pod"
	description = "A cargo pod."
	suffixes = list("cargo_pod/cargo_pod.dmm")
	cost = 1

/obj/effect/landmark/cargo_pod_master
	name = "cargo pod master landmark"

/obj/effect/landmark/cargo_pod_master/Initialize()
	. = ..()
	if(!SSatoms.initialized)
		return INITIALIZE_HINT_LATELOAD
	else
		// give the maploader time to load the landmarks since we're post-init and can't rely on LateInitialize()
		addtimer(CALLBACK(src, .proc/handle_spawning), 5 SECONDS)

/obj/effect/landmark/cargo_pod_master/LateInitialize()
	..()
	handle_spawning()

/obj/effect/landmark/cargo_pod_master/proc/handle_spawning()
	var/list/possible_cargo_types = decls_repository.get_decls_of_subtype(/decl/cargo_pod_contents)
	var/podtype = pick(possible_cargo_types)
	var/decl/cargo_pod_contents/cargo = possible_cargo_types[podtype]
	var/turf/myturf = get_turf(src)
	if(!istype(myturf))
		return
	for(var/turf/T in RANGE_TURFS(myturf, 5))
		for(var/obj/effect/landmark/cargo_pod/C in T)
			C.do_spawn(cargo)
			qdel(C)
	qdel(src)

/obj/effect/landmark/cargo_pod/proc/do_spawn(var/decl/cargo_pod_contents/cargo)
	. = !!cargo && isturf(loc) && !QDELETED(src)

/obj/effect/landmark/cargo_pod/container_spawner
	name = "cargo pod container spawner"

/obj/effect/landmark/cargo_pod/container_spawner/do_spawn(var/decl/cargo_pod_contents/cargo)
	. = ..()
	if(.)
		var/container = pick(cargo.container_types)
		new container(loc)

/obj/effect/landmark/cargo_pod/item_spawner
	name = "cargo pod item spawner"

/obj/effect/landmark/cargo_pod/item_spawner/do_spawn(var/decl/cargo_pod_contents/cargo)
	. = ..()
	if(.)
		for(var/i = 1 to rand(1,5))
			var/spawner = pick(cargo.spawner_types)
			new spawner(loc)

/obj/effect/landmark/cargo_pod/painter
	name = "cargo pod paint spawner"

/obj/effect/landmark/cargo_pod/painter/do_spawn(var/decl/cargo_pod_contents/cargo)
	. = ..()
	if(.)
		var/turf/simulated/wall/W = loc
		if(istype(W))
			W.paint_color = cargo.paint_color
			W.update_icon()

/decl/cargo_pod_contents
	var/container_types
	var/spawner_types
	var/paint_color

/decl/cargo_pod_contents/test
	container_types = list(/obj/structure/closet)
	spawner_types = list(/obj/random/loot)
	paint_color = "#32a852"
