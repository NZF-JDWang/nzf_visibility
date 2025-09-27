// Handle local FiredMan to add short spikes
params ["_unit", "_weapon", "_muzzle", "_ammo"];
if (_unit != player) exitWith {};

// Rate limit firing spikes to 5 seconds
private _lastShot = _unit getVariable ["nzfVisibilityLastShot", 0];
private _currentTime = time;
if (_currentTime - _lastShot < 5) exitWith { systemChat "Firing spike rate limited (5s cooldown)"; };
_unit setVariable ["nzfVisibilityLastShot", _currentTime, false];
systemChat "Firing spike triggered!";

private _state = _unit getVariable ["nzfVisibilityState", [1,1,0,0]];
_state params ["_lastC", "_lastA", "_cShot", "_aShot"];

// Determine suppressor (muzzle attachment present)
private _att = _unit weaponAccessories _weapon; // [muzzle, pointer, optics, bipod]
private _hasSuppressor = false;
if (!isNil "_att" && { (count _att) > 0 }) then {
	private _muzzleAtt = _att select 0;
	_hasSuppressor = !isNil "_muzzleAtt" && { _muzzleAtt != "" };
};

// Night factor from light
private _night = 1 - sunOrMoon; // 0 day .. 1 night

// Visual spike: at least +1.0 unsuppressed, stronger at night; heavily reduced with suppressor
private _cAdd = 1 max (0.20 + (0.60 * _night));
if (_hasSuppressor) then { _cAdd = 0.10; };

// Audio spike: at least +1.0 unsuppressed; heavily reduced with suppressor
private _aAdd = 1.2;
if (_hasSuppressor) then { _aAdd = 0.10; };

// No cap on stacking; overall clamp happens during apply
_cShot = _cShot + _cAdd;
_aShot = _aShot + _aAdd;

_unit setVariable ["nzfVisibilityState", [_lastC, _lastA, _cShot, _aShot], false];

// Debug output
systemChat format ["Shot spikes: Camo +%1, Audio +%2", _cAdd, _aAdd];
systemChat format ["New state: [%1, %2, %3, %4]", _lastC, _lastA, _cShot, _aShot];

