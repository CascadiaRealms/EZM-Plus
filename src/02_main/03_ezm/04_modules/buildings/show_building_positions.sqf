MAZ_EZM_DEBUG_fnc_showBuildingPositions = {
			if(!is3DEN) exitWith {};
			params ["_building"];
			{
				private _marker = "Sign_Arrow_Cyan_F" createVehicleLocal [0,0,0];
				_marker setPos _x;
			}forEach ([_building] call BIS_fnc_buildingPositions);
		};

		MAZ_EZM_DEBUG_fnc_showBuildingPositionsCall = {
			params ["_entity"];
			if(!((typeOf _entity) isKindOf "House")) exitWith {
				private _pos = [true] call MAZ_EZM_fnc_getScreenPosition;
				private _building = nearestObject [_pos, "House"];
				if(_building distance _pos < 20) then {
					[_building] call MAZ_EZM_DEBUG_fnc_showBuildingPositions;
				};
			};
			[_entity] call MAZ_EZM_DEBUG_fnc_showBuildingPositions;
		};
