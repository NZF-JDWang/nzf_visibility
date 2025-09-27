class CfgPatches
{
	class nzf_visibility
	{
		name = "nzf visibility";
		author = "NZF";
		requiredVersion = 2.10;
		requiredAddons[] = {"cba_main", "cba_xeh"};
		units[] = {};
		weapons[] = {};
	};
};

class CfgFunctions
{
	class nzf_visibility
	{
		tag = "nzf_visibility";
		class main
		{
			file = "\nzf_visibility\functions";
			class startLocalLoop {};
			class collectEnvironment {};
			class computeCamo {};
			class computeAudio {};
			class applyTraits {};
			class debugRender {};
			class updateDebugEh {};
			class onDraw3D {};
			class onFired {};
			class registerDebugClient {};
			class unregisterDebugClient {};
			class initLocal { postInit = 1; };
		};
	};
};

class Extended_PreInit_EventHandlers
{
	class nzf_visibility_PreInit
	{
		init = "call compile preprocessFileLineNumbers '\nzf_visibility\XEH_preInit.sqf'";
	};
};

class Extended_PostInit_EventHandlers
{
	class nzf_visibility_PostInit
	{
		init = "call compile preprocessFileLineNumbers '\nzf_visibility\XEH_postInit.sqf'";
	};
};
