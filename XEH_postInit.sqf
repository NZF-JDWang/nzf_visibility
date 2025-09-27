// nzf camo - PostInit
// Start local loop on each client
if (!hasInterface) exitWith {};

if (nzfVisibilityDebug) then { systemChat "NZF Visibility: PostInit starting..."; };

// One-shot init when player exists
[{ !isNull player }, {
	[] call nzf_visibility_fnc_initLocal;
}] call CBA_fnc_waitUntilAndExecute;

