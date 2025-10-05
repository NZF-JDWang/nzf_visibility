// nzf camo - PostInit
// Start local loop on each client
if (!hasInterface) exitWith {};

// One-shot init when player exists
[] spawn {
	waitUntil { !isNull player };
	[] call nzf_visibility_fnc_initLocal;
};

// Start AI group management on server
if (isServer) then {
	[] call nzf_visibility_fnc_startAIGroupManagement;
};

