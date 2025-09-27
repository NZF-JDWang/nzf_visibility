// Add or remove mission Draw3D EH based on CBA setting
private _ehId = missionNamespace getVariable ["nzfVisibilityDraw3D", -1];
if (nzfVisibilityDebug) then {
	if (_ehId == -1) then {
		_ehId = addMissionEventHandler ["Draw3D", {
			call nzf_visibility_fnc_onDraw3D;
		}];
		missionNamespace setVariable ["nzfVisibilityDraw3D", _ehId];
		// register for server-side knowsAbout streaming
		if (isMultiplayer && hasInterface && isServer) then {
			[player] call nzf_visibility_fnc_registerDebugClient;
		} else {
			if (isMultiplayer && hasInterface) then {
				[player] remoteExecCall ["nzf_visibility_fnc_registerDebugClient", 2];
			};
		};
	};
} else {
	if (_ehId != -1) then {
		removeMissionEventHandler ["Draw3D", _ehId];
		missionNamespace setVariable ["nzfVisibilityDraw3D", -1];
		if (isMultiplayer && hasInterface && isServer) then {
			[player] call nzf_visibility_fnc_unregisterDebugClient;
		} else {
			if (isMultiplayer && hasInterface) then {
				[player] remoteExecCall ["nzf_visibility_fnc_unregisterDebugClient", 2];
			};
		};
	};
};

