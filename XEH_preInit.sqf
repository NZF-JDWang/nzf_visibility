// nzf camo - PreInit
// CBA settings for visibility system and ghillie classnames

if !(isNil "CBA_Settings_fnc_init") then {
	// Main visibility system toggle
	[
		"nzfVisibilityEnabled",
		"CHECKBOX",
		["Enable Visibility System", "Enable camo and audio coefficient calculations"],
		["[NZF] Visibility", "Main"],
		[true],
		1,
		{},
		false
	] call CBA_Settings_fnc_init;

	// AI Behavior adjustments
	[
		"nzfVisibilityAIBehavior",
		"CHECKBOX",
		["Enable AI Behavior Adjustments", "Adjust AI spotting based on combat behaviour"],
		["[NZF] Visibility", "Main"],
		[true],
		1,
		{},
		false
	] call CBA_Settings_fnc_init;

	// Ghillie classnames (light / heavy)
	["nzfVisibilityGhillieLightClass", "EDITBOX", ["Ghillie Light classname", "Classname equipped in goggles slot"], ["[NZF] VISIBILITY", "Ghillie"], ["nzf_ghillie_standalone"], 1, {}, true] call CBA_Settings_fnc_init;
	["nzfVisibilityGhillieHeavyClass", "EDITBOX", ["Ghillie Heavy classname", "Classname equipped in goggles slot"], ["[NZF] VISIBILITY", "Ghillie"], ["nzf_ghillie_2_standalone"], 1, {}, true] call CBA_Settings_fnc_init;
};


// Extra-safe: ensure local loop starts once player exists (preInit scheduler)
if (hasInterface) then {
	[] spawn {
		waitUntil { !isNull player };
		[] call nzf_visibility_fnc_startLocalLoop;
	};
};

