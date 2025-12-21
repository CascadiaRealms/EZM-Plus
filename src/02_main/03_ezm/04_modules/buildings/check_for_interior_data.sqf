MAZ_EZM_fnc_checkForInteriorData = {
	private _data = profileNamespace getVariable ["MAZ_EZM_BuildingCompositionData",[]];
	if(_data isEqualTo []) then {
		call MAZ_EZM_fnc_getDefaultInteriors;
	};
};

call MAZ_EZM_fnc_checkForInteriorData;