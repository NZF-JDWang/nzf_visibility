// Compute target audibleCoef (lower is quieter)
params ["_stance", "_moveCat", "_surface", "_timeLight", "_fog", "_overcast", "_rain", "_cover", "_denseBush"];

private _base = 1.0;

// Movement dominates - still should be nearly silent
switch (_moveCat) do {
	case 0: { _base = _base - 0.70; }; // still - nearly silent, no movement noise
	case 1: { _base = _base - 0.30; }; // walk - careful movement, quiet
	case 2: { _base = _base + 0.30; }; // jog - moderate noise
	case 3: { _base = _base + 0.60; }; // sprint - very loud
};

// Stance - crouching and prone reduce audio significantly
switch (_stance) do {
	case "PRONE": { _base = _base - 0.20; }; // laying prone adds to stillness
	case "CROUCH": { _base = _base - 0.15; }; // crouching reduces audio
	default { }; // standing - no additional bonus
};

// Surface influence (only matters when moving)
if (_moveCat > 0) then {
	private _surfLower = toLower _surface;
	if ([_surfLower, "concrete"] call BIS_fnc_inString) then { _base = _base + 0.10; };
	if ([_surfLower, "metal"] call BIS_fnc_inString) then { _base = _base + 0.15; };
	if ([_surfLower, "grass"] call BIS_fnc_inString) then { _base = _base - 0.05; };
};

// Weather masking
_base = _base - (0.10 * _rain) - (0.05 * _overcast);

// Rustle noise when moving through vegetation: only when moving
if (_moveCat > 0) then {
	private _speedScale = [0.3, 0.8, 1.4] select (_moveCat - 1) max 0;
	_base = _base + (0.20 * _denseBush * _speedScale);
};


// Clamp
_base max 0.15 min 1.3

