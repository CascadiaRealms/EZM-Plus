MAZ_EZM_fnc_removeBuildingInterior = {
			params ["_building"];
			if(!(_building getVariable ["MAZ_EZM_hasCompSetup",false])) exitWith {
				["This building does not already have a composition!","addItemFailed"] call MAZ_EZM_fnc_systemMessage;
			};
			if(!isNull (_building getVariable ["MAZ_EZM_compParent",objNull])) then {
				_building setVariable ["MAZ_EZM_hasCompSetup",false,true];
				_building = _building getVariable "MAZ_EZM_compParent";
			};
			private _isTerrainBuilding = if(_building in (nearestTerrainObjects [getPosATL _building, ["House"], 50])) then {true} else {false};
			if(_isTerrainBuilding) then {
				comment "Replace building, terrain buildings don't invoke BuildingChanged MEH";
				_building setVariable ["MAZ_EZM_hasCompSetup",false,true];
				_building hideObjectGlobal false;
				[_building,true] remoteExec ['allowDamage'];
				private _buildings = nearestObjects [_building,[typeOf _building],20,true];
				{
					if(_x getVariable ["MAZ_EZM_isCompClone",false]) then {
						deleteVehicle _x;
					};
				}forEach _buildings;
			} else {
				_building setVariable ["MAZ_EZM_hasCompSetup",false,true];
				private _objs = _building getVariable ["MAZ_EZM_CompObjects",[]];
				{
					_x params ["_obj"];
					detach _obj;
					deleteVehicle _obj;
				}forEach _objs;
				_building setVariable ["MAZ_EZM_CompObjects",[],true];
			};
		};

		MAZ_EZM_fnc_removeBuildingInteriorCall = {
			params ["_entity"];
			if(
				isNull _entity ||
				{!(_entity isEqualType objNull)} ||
				{!((typeOf _entity) isKindOf "House")}
			) exitWith {
				private _pos = [true] call MAZ_EZM_fnc_getScreenPosition;
				private _building = nearestBuilding _pos;
				if(_building distance2D _pos < 20) then {
					[_building] call MAZ_EZM_fnc_removeBuildingInterior;
				};
			};
			[_entity] call MAZ_EZM_fnc_removeBuildingInterior;
		};