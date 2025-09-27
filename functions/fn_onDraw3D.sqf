// Draw knowsAbout over AI (player overlay removed)
if (!nzfVisibilityDebug) exitWith {};

// Debug: Check if we have AI units
private _aiCount = { !isPlayer _x && { alive _x } } count allUnits;
if (_aiCount == 0) exitWith {};


// AI knowsAbout values for this player (use cached server values when available)
{
	if (!isPlayer _x && { alive _x }) then {
		private _k = _x getVariable ["nzfVisibilityKA", _x knowsAbout player];
		private _txt = format ["KA: %1", _k toFixed 2];
		drawIcon3D ["#(argb,8,8,3)color(0,0,0,0)", [1,1,0,1], ASLToAGL eyePos _x, 0, 0, 0, _txt, 2, 0.04, "PuristaMedium", "center", true];
	};
} forEach allUnits;

