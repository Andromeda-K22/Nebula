/datum/map_template/ruin/space/cargo_pod
	name = "Cargo Pod"
	id = "ejected_cargo_pod"
	description = "A cargo pod."
	suffixes = list("cargo_pod/cargo_pod.dmm")
	cost = 1

/obj/effect/landmark/cargo_pod_master
	name = "cargo pod master landmark"
	var/decl/cargo_pod_contents/cargo

/obj/effect/landmark/cargo_pod_master/Initialize()
	var/list/possible_cargo_types = decls_repository.get_decls_of_subtype(/decl/cargo_pod_contents)
	var/podtype = pick(possible_cargo_types)
	cargo = possible_cargo_types[podtype]


	for(var/obj/effect/landmark/cargo_pod/C in range(5))
		C.master = src
		C.do_spawn()
	. = ..()

/obj/effect/landmark/cargo_pod
	var/obj/effect/landmark/cargo_pod_master/master

/obj/effect/landmark/cargo_pod/Initialize()

/obj/effect/landmark/cargo_pod/proc/do_spawn()
	return

/obj/effect/landmark/cargo_pod/container_spawner
	name = "cargo pod container spawner"

/obj/effect/landmark/cargo_pod/container_spawner/do_spawn()
	var/container = pick(master.cargo.container_types)
	new container(get_turf(src))

/obj/effect/landmark/cargo_pod/item_spawner
	name = "cargo pod item spawner"

/obj/effect/landmark/cargo_pod/item_spawner/do_spawn()
	for(1 to rand(1,5))
		var/spawner = pick(master.cargo.spawner_types)
		new spawner(get_turf(src))

/obj/effect/landmark/cargo_pod/painter
	name = "cargo pod paint spawner"

/obj/effect/landmark/cargo_pod/painter/do_spawn()
	for(var/turf/simulated/wall/W in loc)
		W.paint_color = master.cargo.paint_color
		W.update_icon()

/decl/cargo_pod_contents
	var/container_types
	var/spawner_types
	var/paint_color

/decl/cargo_pod_contents/test
	container_types = list(/obj/structure/closet)
	spawner_types = list(/obj/random/loot)
	paint_color = "#32a852"