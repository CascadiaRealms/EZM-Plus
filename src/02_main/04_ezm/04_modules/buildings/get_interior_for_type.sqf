MAZ_EZM_fnc_getBuildingInteriorsForBuildingType = {
			params ["_building"];
			private _compData = [];
			private _allCompData = profileNamespace getVariable ["MAZ_EZM_BuildingCompositionData",[]];
			{
				if(!([typeOf _building,(_x # 0)] call MAZ_EZM_fnc_isSameBuildingType)) then {continue};
				_compData pushBack _x;
			}forEach _allCompData;

			_compData
		};