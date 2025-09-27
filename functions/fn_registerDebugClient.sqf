// SERVER: track clients requesting KA stream
if (!isServer) exitWith {};
params ["_unit"];
private _arr = missionNamespace getVariable ["nzfVisibilityDebugClients", []];
if (!(_unit in _arr)) then {
	_arr pushBack _unit;
	missionNamespace setVariable ["nzfVisibilityDebugClients", _arr];
};

// start server PFH if not running
private _key = missionNamespace getVariable ["nzfVisibilityServerKAKey", -1];
if (_key == -1) then {
	_key = [{
		private _clients = missionNamespace getVariable ["nzfVisibilityDebugClients", []];
		if ((count _clients) == 0) exitWith {};
		{
			private _ka = _x knowsAbout objNull; // placeholder
		} forEach allUnits; // noop to keep handler alive
		// broadcast KA for each AI to each client (optimized minimal)
		{
			if (!isPlayer _x && { alive _x }) then {
				private _ka = _x knowsAbout player; // server POV may be different
				_x setVariable ["nzfVisibilityKA", _ka, true];
			};
		} forEach allUnits;
	}, 0.5] call CBA_fnc_addPerFrameHandler;
	missionNamespace setVariable ["nzfVisibilityServerKAKey", _key];
};

