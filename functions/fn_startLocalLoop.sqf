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

		private _env = call nzf_visibility_fnc_collectEnvironment;
		private _camo = _env call nzf_visibility_fnc_computeCamo;
		private _audio = _env call nzf_visibility_fnc_computeAudio;

		[_camo, _audio] call nzf_visibility_fnc_applyTraits;

		// draw handled by Draw3D EH when debug is on
	},
	_tick
] call CBA_fnc_addPerFrameHandler;

player setVariable ["nzfVisibilityPfhKey", _key, false];

