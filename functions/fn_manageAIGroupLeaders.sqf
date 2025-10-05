// Monitor group leaders for behavior changes - server-side only
if (!isServer) exitWith {};

private _tick = 3.0; // Check every 3 seconds

// Remove any existing AI PFH
private _key = missionNamespace getVariable ["nzfVisibilityGroupLeaderKey", -1];
if (_key != -1) then {
	[_key] call CBA_fnc_removePerFrameHandler;
};

_key = [
	{
		if (!isServer) exitWith {
			[_thisId] call CBA_fnc_removePerFrameHandler;
		};

		// Check if AI behavior adjustments are enabled
		if (!nzfVisibilityAIBehavior) exitWith {};

		// Get all groups with AI units
		private _allGroups = allGroups select { 
			{ !isPlayer _x && { alive _x } } count units _x > 0 
		};
		
		// Process each group leader
		{
			private _group = _x;
			private _leader = leader _group;
			
			// Only process if leader is alive and not a player
			if (alive _leader && !isPlayer _leader) then {
				[_group] call nzf_visibility_fnc_adjustGroupSpotting;
			};
		} forEach _allGroups;

	}, _tick
] call CBA_fnc_addPerFrameHandler;

missionNamespace setVariable ["nzfVisibilityGroupLeaderKey", _key];

// Log that the monitoring loop is active
diag_log "NZF Visibility: AI behavior monitoring loop started";
