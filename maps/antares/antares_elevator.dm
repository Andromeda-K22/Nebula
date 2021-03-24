/obj/turbolift_map_holder/antares
	name = "Antares elevator placeholder"
	depth = 4
	lift_size_x = 4
	lift_size_y = 4
	areas_to_use = list(
		/area/turbolift/antares/first,
		/area/turbolift/antares/second,
		/area/turbolift/antares/third,
		/area/turbolift/antares/fourth
	)

/area/turbolift/antares/alert_on_fall(var/mob/living/carbon/human/H)
	if(H.client && SSpersistence.elevator_fall_shifts > 0)
		SSwebhooks.send(WEBHOOK_ELEVATOR_FALL, list("text" = "We managed to make it [SSpersistence.elevator_fall_shifts] shift\s without someone falling down an elevator shaft."))
		SSpersistence.elevator_fall_shifts = -1

/area/turbolift/antares/first
	name = "Elevator - Hangar Deck"
	base_turf = /turf/simulated/floor
	lift_announce_str = "Now arriving on Hangar Deck."

/area/turbolift/antares/second
	name = "Elevator - Operations Deck"
	base_turf = /turf/simulated/open
	lift_announce_str = "Now arriving on Operations Deck."

/area/turbolift/antares/third
	name = "Elevator - Habitation Deck"
	base_turf = /turf/simulated/open
	lift_announce_str = "Now arriving on Habitation Deck."

/area/turbolift/antares/fourth
	name = "Elevator - Command Deck"
	base_turf = /turf/simulated/open
	lift_announce_str = "Now arriving on Command Deck."
