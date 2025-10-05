// Start AI group leader management (server-side)
if (!isServer) exitWith {};


// Start the AI group management loop
[] call nzf_visibility_fnc_manageAIGroupLeaders;

// Log system initialization
diag_log "NZF Visibility: AI behavior system initialized and running";
