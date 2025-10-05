// Compute target camouflageCoef (lower is better)
params ["_stance", "_moveCat", "_surface", "_timeLight", "_fog", "_overcast", "_rain", "_immediateCover", "_mediumCover", "_denseBush", "_forestDensity"];

private _base = 1.0;

// Ghillie bonuses from CBA settings (goggles slot)
private _gh = goggles player;
private _ghLight = missionNamespace getVariable ["nzfVisibilityGhillieLightClass", "nzf_ghillie_standalone"];
private _ghHeavy = missionNamespace getVariable ["nzfVisibilityGhillieHeavyClass", "nzf_ghillie_2_standalone"];
private _ghBonus = 0;
if (_gh == _ghLight) then { _ghBonus = 0.25; };
if (_gh == _ghHeavy) then { _ghBonus = 0.45; };

// Layered cover system - bushes and trees provide excellent natural camouflage
_base = _base - (0.50 * _immediateCover) - (0.35 * _mediumCover) - _ghBonus - (0.30 * _denseBush);

// Forest/Jungle environment bonus - significant reduction in dense forests
_base = _base - (0.40 * _forestDensity);


// Light level: at night _timeLight ~ 0
_base = _base - (0.25 * (1 - _timeLight));

// Fog/overcast reduce visibility (stronger fog impact)
_base = _base - (0.30 * _fog) - (0.06 * _overcast);

// Stance: prone best, then crouch, then stand
switch (_stance) do {
	case "PRONE": { _base = _base - 0.25; };
	case "CROUCH": { _base = _base - 0.15; };
	default { };
};

// Movement: still < walk < run < sprint
if (_moveCat == 1) then { _base = _base + 0.12; };
if (_moveCat == 2) then { _base = _base + 0.30; };
if (_moveCat == 3) then { _base = _base + 0.45; };

// Clamp conservative
_base max 0.2 min 1.2

