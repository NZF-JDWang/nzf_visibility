// Compute target audibleCoef (lower is quieter)
params ["_stance", "_moveCat", "_surface", "_timeLight", "_fog", "_overcast", "_rain", "_cover", "_denseBush"];

private _base = 1.0;

// Movement dominates
switch (_moveCat) do {
	case 0: { _base = _base - 0.20; }; // still
	case 1: { _base = _base + 0.12; }; // walk
	case 2: { _base = _base + 0.40; }; // run
	case 3: { _base = _base + 0.65; }; // sprint
};

// Stance
if (_stance == "PRONE") then { _base = _base - 0.35; }; // laying prone is very quiet

// Surface influence (simplified buckets)
private _surfLower = toLower _surface;
if ([_surfLower, "concrete"] call BIS_fnc_inString) then { _base = _base + 0.10; };
if ([_surfLower, "metal"] call BIS_fnc_inString) then { _base = _base + 0.15; };
if ([_surfLower, "grass"] call BIS_fnc_inString) then { _base = _base - 0.05; };

// Weather masking
_base = _base - (0.10 * _rain) - (0.05 * _overcast);

// Rustle noise when moving through vegetation: scales with speed and density
if (_moveCat > 0) then {
	private _speedScale = [0.6, 1.0, 1.4] select (_moveCat - 1) max 0;
	_base = _base + (0.25 * _denseBush * _speedScale);
};


// Clamp
_base max 0.2 min 1.3

