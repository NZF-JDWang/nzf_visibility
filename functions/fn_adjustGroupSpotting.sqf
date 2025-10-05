// Adjust AI group spotting based on combat behaviour
// Reduces spotTime and spotDistance for non-alert groups
params ["_group"];

private _leader = leader _group;
if (isNull _leader || !alive _leader) exitWith {};

// Get current combat behaviour
private _combatBehaviour = combatBehaviour _leader;

// Default values (alert state)
private _spotTimeMultiplier = 1.0;
private _spotDistanceMultiplier = 1.0;

// Adjust based on combat behaviour
switch (_combatBehaviour) do {
	case "CARELESS": {
		// Careless: not expecting contact, very slow to react
		_spotTimeMultiplier = 0.3;      // Much slower to spot
		_spotDistanceMultiplier = 0.7;   // Reduced spotting distance
	};
	case "SAFE": {
		// Safe: cautious but not alert
		_spotTimeMultiplier = 0.5;      // Slower to spot
		_spotDistanceMultiplier = 0.85;  // Slightly reduced distance
	};
	case "AWARE": {
		// Aware: normal alert state
		_spotTimeMultiplier = 1.0;      // Normal spotting
		_spotDistanceMultiplier = 1.0;   // Normal distance
	};
	case "COMBAT": {
		// Combat: highly alert - capped at normal values
		_spotTimeMultiplier = 1.0;      // Normal spotting
		_spotDistanceMultiplier = 1.0;   // Normal distance
	};
	default {
		// Default to normal values
		_spotTimeMultiplier = 1.0;
		_spotDistanceMultiplier = 1.0;
	};
};

// Apply adjustments to all units in the group
{
	if (alive _x && !isPlayer _x) then {
		// Set spot time multiplier (lower = slower to spot)
		_x setVariable ["spotTime", _spotTimeMultiplier, true];
		
		// Set spot distance multiplier (lower = shorter range)
		_x setVariable ["spotDistance", _spotDistanceMultiplier, true];
		
		// Optional: Add some randomization to make it more realistic
		private _timeRandom = 0.8 + (random 0.4); // ±20% variation
		private _distRandom = 0.8 + (random 0.4);  // ±20% variation
		
		_x setVariable ["spotTimeRandom", _timeRandom, true];
		_x setVariable ["spotDistanceRandom", _distRandom, true];
	};
} forEach units _group;

