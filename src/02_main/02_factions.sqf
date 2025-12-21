MAZ_EZM_fnc_addNewFactionsToZeusInterface = {
	{
		private _fnc = missionNamespace getVariable [_x,{}];
		call _fnc;
	}forEach MAZ_EZM_factionAddons;
};

MAZ_EZM_fnc_sortFactionModules = {
	with uiNamespace do {
		{
			_x tvSort [[]];
		}forEach [MAZ_UnitsTree_BLUFOR,MAZ_UnitsTree_OPFOR,MAZ_UnitsTree_INDEP,MAZ_UnitsTree_CIVILIAN]
	};
};

MAZ_EZM_fnc_addNewFactionToDynamicFactions = {
	params [["_factionFunction","",[""]]];
	if(_factionFunction == "") exitWith {};
	MAZ_EZM_factionAddons pushBack _factionFunction;
	[] spawn MAZ_EZM_fnc_setInterfaceToRefresh;
};
