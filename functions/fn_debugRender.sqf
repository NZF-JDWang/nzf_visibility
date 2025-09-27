// Draw simple overlay
params ["_env", "_camo", "_audio"];
_env params ["_stance", "_moveCat", "_surface", "_timeLight", "_fog", "_overcast", "_rain", "_cover", "_denseBush"];

private _state = player getVariable ["nzfVisibilityState", [1,1,0,0]];
_state params ["_lc", "_la", "_cShot", "_aShot"];

private _txt = format [
	"nzf camo\nstance=%1 move=%2 cover=%.2f light=%.2f fog=%.2f rain=%.2f\ncam=%.2f (shot +%.2f) aud=%.2f (shot +%.2f)",
	_stance, _moveCat, _cover, _timeLight, _fog, _rain, _camo, _cShot, _audio, _aShot
];

drawIcon3D ["#(argb,8,8,3)color(0,0,0,0)", [1,1,1,1], ASLToAGL eyePos player, 0, 0, 0, _txt, 2, 0.04, "PuristaMedium", "center", true];

