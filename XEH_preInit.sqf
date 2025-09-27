// nzf camo - PreInit
// Minimal CBA setting: debug toggle only (inline)

if !(isNil "CBA_Settings_fnc_init") then {
	[
		"nzfVisibilityDebug",
		"CHECKBOX",
		["Enable debug overlay", "Show camo/audio over player and AI knowsAbout"],
		["[NZF] CAMO", "Main"],
		[false],
		1,
		{ [] call nzf_visibility_fnc_updateDebugEh },
		false
	] call CBA_Settings_fnc_init;

	// Ghillie classnames (light / heavy)
	["nzfVisibilityGhillieLightClass", "EDITBOX", ["Ghillie Light classname", "Classname equipped in goggles slot"], ["[NZF] VISIBILITY", "Ghillie"], ["nzf_ghillie_standalone"], 1, {}, true] call CBA_Settings_fnc_init;
	["nzfVisibilityGhillieHeavyClass", "EDITBOX", ["Ghillie Heavy classname", "Classname equipped in goggles slot"], ["[NZF] VISIBILITY", "Ghillie"], ["nzf_ghillie_2_standalone"], 1, {}, true] call CBA_Settings_fnc_init;
};

// Extra-safe: ensure local loop starts once player exists (preInit scheduler)
if (hasInterface) then {
	[{ !isNull player }, { [] call nzf_visibility_fnc_startLocalLoop; }] call CBA_fnc_waitUntilAndExecute;
};

