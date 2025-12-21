MAZ_EZM_fnc_addNewModulesToZeusInterface = {
	{
		private _fnc = missionNamespace getVariable [_x,{}];
		call _fnc;
	}forEach MAZ_EZM_moduleAddons;
};

MAZ_EZM_fnc_addNewModulesToDynamicModules = {
	params [["_moduleFunction","",[""]]];
	if(_moduleFunction == "") exitWith {};
	MAZ_EZM_moduleAddons pushBack _moduleFunction;
	[] spawn MAZ_EZM_fnc_setInterfaceToRefresh;
};