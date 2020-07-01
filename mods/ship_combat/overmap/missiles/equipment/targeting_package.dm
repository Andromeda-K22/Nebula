/obj/item/missile_equipment/targeting_package
	name = "targeting package"
	desc = "A bog-standard targeting package, used in missiles to target ships."
	icon_state = "guidance"

/obj/item/missile_equipment/targeting_package/proc/set_target() //Use target ref or coords to set target, then hand over to guide_missile.
	return

/obj/item/missile_equipment/targeting_package/proc/guide_missile() //If tracking, update target x and y.
	return

/obj/item/missile_equipment/targeting_package/point
	name = "point to point targeting package"
	desc = "A dumb set of avionics capable of navigating through space and avoiding objects, until it arrives at a designated point."

	var/target_x
	var/target_y

/obj/item/missile_equipment/targeting_package/point/set_target(var/n_x, var/n_y)
	target_x = n_x
	target_y = n_y

/obj/item/missile_equipment/targeting_package/point/guide_missile()
	if(!target_x || !target_y)
		return

	missile.overmap_missile.target_x = target_x
	missile.overmap_missile.target_y = target_y

/obj/item/missile_equipment/targeting_package/point/attackby(var/obj/item/I, var/mob/user)
	var/targ_x = 0
	var/targ_y = 0

	if(isMultitool(I))
		targ_x = input(user, "Enter target X coordinate", "Input coordinates") as null|num
		targ_y = input(user, "Enter target Y coordinate", "Input coordinates") as null|num
	if(!targ_x || !targ_y || targ_x <= 0 || targ_x >= GLOB.using_map.overmap_size || targ_y <= 0 || targ_y >= GLOB.using_map.overmap_size)
		to_chat(user, SPAN_NOTICE("The targeting computer display lets you know that's an invalid target."))
		return

	set_target(targ_x, targ_y)
	to_chat(user, SPAN_NOTICE("Target successfully set to [targ_x], [targ_y]."))
	return

	..()



