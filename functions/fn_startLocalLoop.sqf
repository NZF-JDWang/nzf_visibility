// Player-local update using CBA per-frame handler (PFH)
// Fixed cadence via delay; CBA schedules efficiently
private _tick = 1.0; // seconds

// Remove any existing PFH
private _key = player getVariable ["nzfVisibilityPfhKey", -1];
if (_key != -1) then {
	[_key] call CBA_fnc_removePerFrameHandler;
};


_key = [
	{
		// Only run while player alive and has interface
		if (!alive player || !hasInterface) exitWith {
			[_thisId] call CBA_fnc_removePerFrameHandler;
		};

		// Check if visibility system is enabled
		if (nzfVisibilityEnabled) then {
			private _env = call nzf_visibility_fnc_collectEnvironment;
			private _camo = _env call nzf_visibility_fnc_computeCamo;
			private _audio = _env call nzf_visibility_fnc_computeAudio;

			[_camo, _audio] call nzf_visibility_fnc_applyTraits;
		};
	},
	_tick
] call CBA_fnc_addPerFrameHandler;

// Only set the variable if _key is valid (not nil or -1)
if (!isNil "_key" && _key != -1) then {
	player setVariable ["nzfVisibilityPfhKey", _key, false];
} else {
	diag_log "NZF Visibility: Failed to create per-frame handler";
};

// Log that the visibility loop is active
diag_log "NZF Visibility: Player visibility monitoring loop started";

