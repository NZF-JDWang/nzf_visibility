// SERVER: remove client from KA stream
if (!isServer) exitWith {};
params ["_unit"];
private _arr = missionNamespace getVariable ["nzfVisibilityDebugClients", []];
_arr = _arr - [_unit];
missionNamespace setVariable ["nzfVisibilityDebugClients", _arr];

if ((count _arr) == 0) then {
	private _key = missionNamespace getVariable ["nzfVisibilityServerKAKey", -1];
	if (_key != -1) then {
		[_key] call CBA_fnc_removePerFrameHandler;
		missionNamespace setVariable ["nzfVisibilityServerKAKey", -1];
	};
};

