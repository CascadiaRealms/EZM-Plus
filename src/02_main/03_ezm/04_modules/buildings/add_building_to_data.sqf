MAZ_EZM_fnc_addBuildingDataToVar = {
			params ["_data","_comp"];
			_comp params ["_buildingType","_compData"];
			private _isFound = false;
			{
				_x params ["_type","_comps"];
				if(_isFound) exitWith {};
				if(_type isEqualType []) then {
					if(_buildingType in _type || [_buildingType,_type] call MAZ_EZM_fnc_interiorTypeInArray) exitWith {
						_isFound = true;
						_comps pushBack _compData;
						_data set [_forEachIndex,[_type,_comp]];
					};
				};
				if(_type isEqualType "") then {
					if(_buildingType == _type || _buildingType isKindOf _type) exitWith {
						_isFound = true;
						_comps pushBack _compData;
						_data set [_forEachIndex,[_type,_comps]];
					};
				};
			}forEach _data;

			if(!_isFound) then {
				_data pushBack [_buildingType,[_compData]];
			};
			_data
		};