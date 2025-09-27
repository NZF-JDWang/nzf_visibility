// Reinitialize local state on respawn and restart PFH
player setVariable ["nzfVisibilityState", [0, 0, 0, 0], false];

// Re-add FiredMan EH (safeguard)
player addEventHandler ["FiredMan", {
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_mag", "_projectile", "_vehicle"];
	[_unit, _weapon, _muzzle, _ammo] call nzf_visibility_fnc_onFired;
}];

[] call nzf_visibility_fnc_startLocalLoop;

