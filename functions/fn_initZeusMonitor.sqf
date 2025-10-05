// Integrated Zeus Monitor for FPS, Audio, and Camo coefficients
// Based on DriftingNitro's FPS monitor with NZF visibility integration

if (isMultiplayer) then {
	[[], {
		if (hasinterface) then {
			if(isNil "nzf_zeusMonitorActive") then 
			{
				nzf_zeusMonitorActive = true;
				
				// Use CBA PFH instead of while loop for better performance
				private _key = [
					{
						// FPS monitoring
						player setVariable ["nzf_PlayerFPS", floor diag_fps, true];
						
						// Visibility coefficients monitoring (only if visibility system is enabled)
						if (nzfVisibilityEnabled && 
							!isNil "nzf_visibility_fnc_collectEnvironment" && 
							!isNil "nzf_visibility_fnc_computeCamo" && 
							!isNil "nzf_visibility_fnc_computeAudio") then {
							
							private _env = call nzf_visibility_fnc_collectEnvironment;
							private _camo = _env call nzf_visibility_fnc_computeCamo;
							private _audio = _env call nzf_visibility_fnc_computeAudio;
							
							player setVariable ["nzf_PlayerCamo", _camo, true];
							player setVariable ["nzf_PlayerAudio", _audio, true];
						} else {
							// Set default values when visibility system is disabled
							player setVariable ["nzf_PlayerCamo", 1.0, true];
							player setVariable ["nzf_PlayerAudio", 1.0, true];
						};
					},
					1.0  // 1 second interval
				] call CBA_fnc_addPerFrameHandler;
				
				// Store the PFH key for cleanup if needed
				player setVariable ["nzf_zeusMonitorPfhKey", _key, false];
			};
		};
	}] remoteExec ["spawn", 0, true];
};

// Wait for Zeus/Admin detection - more robust check
waitUntil {
	_adminState = call BIS_fnc_admin;
	sleep 1;
	(!isNull (findDisplay 312)) || (_adminState == 2) || (_adminState == 1)
};

// Initialize display toggle
nzf_showPlayerStats = true;

// Key handler for Zeus interface - use CBA PFH instead of while loop
private _zeusKey = [
	{
		if (!isNull (findDisplay 312)) then {
			// Zeus interface is open, add key handler if not already added
			if (isNil "nzf_zeusKeyHandlerAdded") then {
				nzf_zeusKeyHandlerAdded = true;
				(findDisplay 312) displayAddEventHandler ["keyDown", {    
					if (inputAction "user12" > 0) then {
						if(nzf_showPlayerStats) then {nzf_showPlayerStats=false} else {nzf_showPlayerStats = true};
					}; 
				}];
			};
		} else {
			// Zeus interface closed, reset handler flag
			nzf_zeusKeyHandlerAdded = nil;
		};
	},
	0.1  // Check every 100ms
] call CBA_fnc_addPerFrameHandler;

// Key handler for main interface
(findDisplay 46) displayAddEventHandler ["keyDown", {    
	if (inputAction "user12" > 0) then {
		if(nzf_showPlayerStats) then {nzf_showPlayerStats=false} else {nzf_showPlayerStats = true};
	}; 
}];

// Draw3D event handler for displaying stats - optimized for performance
addMissionEventHandler ["Draw3D", {
	// Early exit if display is disabled
	if (!nzf_showPlayerStats) exitWith {};
	
	// Cache camera position to avoid repeated calculations
	private _cameraPos = ASLToAGL (positionCameraToWorld [0,0,0]);
	
	// Cache visibility system state
	private _visibilityEnabled = nzfVisibilityEnabled;
	
	{
		// Early distance check for performance
		private _distance = _cameraPos distance _x;
		if (_distance >= 1200) then { continue; };
		
		// Get player data
		private _playerFPS = _x getVariable ["nzf_PlayerFPS", 50];
		private _playerCamo = _x getUnitTrait "camouflageCoef";
		private _playerAudio = _x getUnitTrait "audibleCoef";
		
		// Determine colors and sizes based on FPS
		private _isLowFPS = _playerFPS < 20;
		private _fpsColor = if (_isLowFPS) then { [1,0,0,0.8] } else { [1,1,1,0.7] };
		private _fpsSize = if (_isLowFPS) then { 0.05 } else { 0.03 };
		private _coefSize = if (_isLowFPS) then { 0.05 } else { 0.035 }; // Slightly larger than FPS
		private _coefColor = if (_isLowFPS) then { [1,0,0,0.8] } else { [1,1,1,0.7] };
		
		// FPS line (top)
		drawIcon3D
		[
			"",
			_fpsColor,
			ASLToAGL getPosASL _x,
			1,
			2.0,
			0,
			format["%1 FPS: %2", name _x, str _playerFPS],
			0,
			_fpsSize,
			"PuristaMedium",
			"center"
		];
		
		// Audio and Camo coefficients line (below FPS)
		drawIcon3D
		[
			"",
			_coefColor,
			ASLToAGL getPosASL _x,
			1,
			3.0,
			0,
			format["A: %1 | V: %2", (_playerAudio toFixed 2), (_playerCamo toFixed 2)],
			0,
			_coefSize,
			"PuristaMedium",
			"center"
		];
	} forEach allPlayers;
}];
