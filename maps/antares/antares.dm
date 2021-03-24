#if !defined(USING_MAP_DATUM)

	#include "../../mods/content/mundane.dm"
	#include "../../mods/content/bigpharma/_bigpharma.dme"
	#include "../../mods/content/corporate/_corporate.dme"
	#include "../../mods/content/government/_government.dme"
	#include "../../mods/content/modern_earth/_modern_earth.dme"
	#include "../../mods/content/psionics/_psionics.dme"
	#include "../../mods/content/xenobiology/_xenobiology.dme"

	#include "../../mods/mobs/dionaea/_dionaea.dme"
	#include "../../mods/mobs/borers/_borers.dme"

	#include "../../mods/species/ascent/_ascent.dme"
	#include "../../mods/species/utility_frames/_utility_frames.dme"
	#include "../../mods/species/tajaran/_tajaran.dme"
	#include "../../mods/species/tritonian/_tritonian.dme"
	#include "../../mods/species/neoavians/_neoavians.dme"
	#include "../../mods/species/lizard/_lizard.dme"
	#include "../../mods/species/vox/_vox.dme"
	#include "../../mods/species/adherent/_adherent.dme"

	#include "lore/culture.dm"
	#include "lore/factions.dm"
	#include "lore/languages.dm"
	#include "lore/locations.dm"

	#include "antares_areas.dm"
	#include "antares_elevator.dm"
	#include "antares_lore.dm"

	#include "antares-1.dmm"
	#include "antares-2.dmm"
	#include "antares-3.dmm"
	#include "antares-4.dmm"

	#define USING_MAP_DATUM /datum/map/antares

#elif !defined(MAP_OVERRIDE)

	#warn A map has already been included, ignoring Antares

#endif
