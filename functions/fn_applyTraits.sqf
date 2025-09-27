// Apply traits with smoothing and shot spikes
params ["_camoTarget", "_audioTarget"];

private _state = player getVariable ["nzfVisibilityState", [1,1,0,0]];
_state params ["_lastCamo", "_lastAudio", "_camoShot", "_audioShot"];

// Read actual engine traits to track external changes/resets
private _engineCamo = player getUnitTrait "camouflageCoef";
private _engineAudio = player getUnitTrait "audibleCoef";
if (isNil "_engineCamo") then { _engineCamo = _lastCamo; };
if (isNil "_engineAudio") then { _engineAudio = _lastAudio; };

// Decay shot boosts (slower to show strong spikes)
_camoShot = _camoShot * 0.80;
_audioShot = _audioShot * 0.80;

// Smooth towards BASE target from actual engine values
private _alpha = 0.25;
private _camo = _engineCamo + (_camoTarget - _engineCamo) * _alpha;
private _audio = _engineAudio + (_audioTarget - _engineAudio) * _alpha;

// Add instantaneous shot boosts AFTER smoothing so spikes are visible immediately
// Final clamps: both traits capped at 2.5; audio can drop very low
_camo = (_camo + _camoShot) max 0.2 min 2.5;
_audio = (_audio + _audioShot) max 0.05 min 2.5;

// Only update traits if change is significant (rate limiting)
if (abs(_camo - _lastCamo) > 0.05 || abs(_audio - _lastAudio) > 0.05) then {
	player setUnitTrait ["camouflageCoef", _camo];
	player setUnitTrait ["audibleCoef", _audio];
};

player setVariable ["nzfVisibilityState", [_camo, _audio, _camoShot, _audioShot], false];

