/decl/cultural_info/faction/csd
	name =  "Central Solar Dominion"
	description = "The Central Solar Dominion is the 'official' government of the entirety of Sol, at least \
	in name. It administrates the solar system from the government hub on Mars, overseeing industry and science \
	and ensuring the safety of its citizens through judicious application of the Jovian and Saturnian navies. \
	Critics like the Pan-National Concord call the Dominion authoritarian, top-heavy and brutal when enforcing the Pax Solar."
	secondary_langs = list(/decl/language/sign)

/decl/cultural_info/faction/ts
	name = "Pan-National Concord"
	description = "The Pan-National Concord is something of a dinosaur, tracing its roots to the early days of human \
	expansion into space. It harks back to the United Nations and other cross-border organizations, and claims to \
	represent the disparate people of Earth, while largely being concerned only with the workers labouring under the \
	heel of the hypercapitalist elite of the Lunar Trade Council. The Concord as a whole presents as fiercely, violently \
	independent of 'upstarts' like the Central Solar Dominion, but is more or less a stalking horse for political actions \
	controlled by the LTC."
	economic_power = 0.5
	secondary_langs = list(/decl/language/sign, /decl/language/human/common)

/decl/cultural_info/faction/ltc
	name = "Lunar Trade Council"
	description = "The Lunar Trade Council is an aggregate of glitterati, industrial tycoons and politicians and \
	within the complex ruling body of Asphodel and the other Lunar dome cities. The LTC wields a great deal of \
	political power, and their weapon emplacement provide them with a more literal form. Generally speaking, \
	members affiliated with the LTC find themselves at odds with other groups, especially the Central Solar Government."
	economic_power = 1.3
	secondary_langs = list(/decl/language/sign, /decl/language/human/common, /decl/language/lunar)

/decl/cultural_info/faction/firstwave
	name = "First Wave"
	description = "The First Wave was a major genetic engineering project conducted during the mass exodus from Earth \
	in the 2000s. Many genotypes trace their roots to the modification programs executed during those hectic \
	decades, and in many places they still suffer from prejudice that damages their quality of life. Around Saturn and \
	the Kuiper belt they represent a political bloc with a tendency to stick together against the 'baselines'."
	economic_power = 0.85
	secondary_langs = list(/decl/language/sign, /decl/language/human/common)

/decl/cultural_info/faction/outer
	name = "Outer System Bloc"
	description = "The Outer System bloc is a loose collection of political interests found beyond the orbit of \
	Jupiter, largely centralized on Saturn, Uranus and Neptune. Outer System groups tend to align with a more liberal \
	view of humanity than baseline, advocating for increased freedoms on self-experimentation, inclusion of gene-adapts in society, \
	and the adoption of more 'radical' technologies like psychosurgery and genome fabrication."
	economic_power = 0.85
	secondary_langs = list(/decl/language/sign, /decl/language/exterior)

/decl/cultural_info/faction/inner
	name = "Inner System Bloc"
	description = "The Inner System bloc is a socially and technologically conservative grouping centered on Mars and \
	generally covers all planets and habitats from there inward, with the notable exclusion of Earth under the aegis \
	of the Lunar Trade Council. Most Inner System bloc adherents spurn posthuman intelligences and radical \
	genetic alteration as reckless and unnatural, and push for strong, stable, democractic government."
	economic_power = 1.15
	secondary_langs = list(/decl/language/sign, /decl/language/human/common, /decl/language/belter)

/decl/cultural_info/faction/cuchulain
	name = "Cuchulain Foundation"
	description = "The Cuchulain Foundation, located on Neptune, represents the single largest psionic research body \
	in human space. They offer funding, training and logistical support for groups across Sol in the interests of \
	educating psi-operant individuals before they hurt themselves or others. Due to the legislative censorship efforts \
	of the Inner System, they tend to operate beyond Mars orbit, and often serve as consultants to larger organizations."
	secondary_langs = list(/decl/language/sign, /decl/language/human/common, /decl/language/exterior)

/decl/cultural_info/faction/posthuman
	name = "Posthuman Bloc"
	description = "The posthuman bloc represents non-human interests across Sol, such as uplifted species like octopodes \
	and corvidae, as well as digitals like AGIs and disembodied mind-states. Such minority groups find it difficult to retain \
	cultural cohesion and exert power in the human political sphere due to their significant physical and cultural differences \
	from baseline humanity, and often act as a group, combining a multitude of small voices into a single loud one."
	economic_power = 0.7
	secondary_langs = list(/decl/language/sign, /decl/language/cephlapoda, /decl/language/corvid)

/decl/cultural_info/faction/posthuman/get_random_name(var/gender, var/species)
	switch(species)
		if(SPECIES_AVIAN)
			name_language = /decl/language/corvid
		//if(SPECIES_OCTOPUS)
		//	name_language = /decl/language/cephlapoda
		else
			name_language = initial(name_language)
	. = ..(gender, species)
