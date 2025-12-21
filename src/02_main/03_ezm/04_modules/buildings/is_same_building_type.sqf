MAZ_EZM_fnc_isSameBuildingType = {
			params ["_typeOfBuilding","_searchType"];
			if(_searchType isEqualType [] && _typeOfBuilding in _searchType) exitWith {true};
			if(_searchType isEqualType []) exitWith {false};
			if(_searchType isEqualType "" && {_typeOfBuilding isKindOf _searchType}) exitWith {true};
			false
		};
