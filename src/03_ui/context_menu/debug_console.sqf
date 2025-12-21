if(!isNil "MAZ_EZM_action_openDebugConsole") then {
	[MAZ_EZM_action_openDebugConsole] call MAZ_EZM_fnc_removeContextAction;
};
MAZ_EZM_action_openDebugConsole = [
	"Open Debug Console",
	{
		params ["_pos","_entity"];
		[_entity] call MAZ_EZM_fnc_debugConsoleLocalModule;
	},
	{true},
	6,
	"a3\3den\data\displays\display3den\entitymenu\findconfig_ca.paa",
	[1,1,1,1],
	[]
] call MAZ_EZM_fnc_createNewContextAction;