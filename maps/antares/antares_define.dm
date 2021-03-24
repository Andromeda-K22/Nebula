/datum/map/antares
	name = "Antares"
	full_name = "LTV Antares"
	path = "antares"
	ground_noun = "deck"

	station_levels = list(1)
	contact_levels = list(1)
	player_levels =  list(1)

	station_name  = "LTV Antares"
	station_short = "Antares"

	dock_name     = "1 Ceres Gateway Terminus"
	boss_name     = "Dominion Transit Authority"
	boss_short    = "DTA"
	company_name  = "Spinward Survey Corps"
	company_short = "SSC"

	//lobby_screens = list('maps/antares/lobby.png')

	use_overmap = 1
	num_exoplanets = 1
	welcome_sound = 'sound/effects/cowboysting.ogg'
	emergency_shuttle_leaving_dock = "Attention all hands: the escape pods have been launched, maintaining burn for %ETA%."
	emergency_shuttle_called_message = "Attention all hands: emergency evacuation procedures are now in effect. Escape pods will launch in %ETA%"
	emergency_shuttle_recall_message = "Attention all hands: emergency evacuation sequence aborted. Return to normal operating conditions."
	evac_controller_type = /datum/evacuation_controller/lifepods

	radiation_detected_message = "High levels of radiation have been detected in proximity of the %STATION_NAME%. Please move to a shielded area such as the cargo bay, dormitories or medbay until the radiation has passed."

	apc_test_exempt_areas = list(
		/area/space = NO_SCRUBBER|NO_VENT|NO_APC,
		/area/exoplanet = NO_SCRUBBER|NO_VENT|NO_APC,
		/area/turbolift = NO_SCRUBBER|NO_VENT|NO_APC,
		/area/shuttle/escape = NO_SCRUBBER|NO_VENT|NO_APC
	)

/datum/map/antares/get_map_info()
	return "You're aboard the <b>[station_name]</b>, a logistics and transportation vessel akin to a floating city. Hosting a variety of \
	smaller ships in her hangars, she follows the trail of the Dominion survey fleet, exploring and cataloguing the exoplanets, asteroids \
	and derelicts marked by those who came before."

/datum/map/antares/create_trade_hubs()
	new /datum/trade_hub/singleton/antares

/datum/trade_hub/singleton/antares
	name = "Dominion Freight Network"

/datum/trade_hub/singleton/antares/get_initial_traders()
	return list(
		/datum/trader/xeno_shop,
		/datum/trader/medical,
		/datum/trader/mining,
		/datum/trader/books
	)
