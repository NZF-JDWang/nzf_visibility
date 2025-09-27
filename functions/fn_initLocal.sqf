// Initialize local visibility system
if (!hasInterface) exitWith {};

if (nzfVisibilityDebug) then { systemChat "NZF Visibility: Player found, initializing..."; };

// Initialize local state container with current traits
private _cInit = player getUnitTrait "camouflageCoef";
private _aInit = player getUnitTrait "audibleCoef";
if (isNil "_cInit") then { _cInit = 1; };
if (isNil "_aInit") then { _aInit = 1; };
player setVariable ["nzfVisibilityState", [_cInit, _aInit, 0, 0], false]; // [lastCamo, lastAudio, camoShotBoost, audioShotBoost]

// Hook FiredMan locally
if (nzfVisibilityDebug) then { systemChat "NZF Visibility: Adding FiredMan event handler..."; };
player addEventHandler ["FiredMan", {
	if (nzfVisibilityDebug) then { systemChat "FiredMan event triggered!"; };
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_mag", "_projectile", "_vehicle"];
	[_unit, _weapon, _muzzle, _ammo] call nzf_visibility_fnc_onFired;
}];

// Start the PFH loop
[] call nzf_visibility_fnc_startLocalLoop;

// Force an immediate first apply to avoid staying at 1 until first tick
private _env0 = call nzf_visibility_fnc_collectEnvironment;
private _c0 = _env0 call nzf_visibility_fnc_computeCamo;
private _a0 = _env0 call nzf_visibility_fnc_computeAudio;
player setUnitTrait ["camouflageCoef", _c0];
player setUnitTrait ["audibleCoef", _a0];
player setVariable ["nzfVisibilityState", [_c0, _a0, 0, 0], false];

// Use CBA player event for respawn
["respawn", {
	[] call nzf_visibility_fnc_onRespawn;
}] call CBA_fnc_addPlayerEventHandler;

// Ensure Draw3D handler state matches debug setting
[] call nzf_visibility_fnc_updateDebugEh;

// Fallback: ensure PFH is running after a short delay
[{ (missionNamespace getVariable ["nzfVisibilityPfhKey", -1]) != -1 }, {
	// ok
}, {
	[] call nzf_visibility_fnc_startLocalLoop;
}] call CBA_fnc_waitUntilAndExecute;

