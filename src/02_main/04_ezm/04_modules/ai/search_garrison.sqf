MAZ_EZM_fnc_garrisonSearchModule = {
			params ["_entity"];
			if(isNull _entity || !((typeOf _entity) isKindOf "Man")) exitWith {["Unit is not suitable.","addItemFailed"] call MAZ_EZM_fnc_systemMessage;};
			[_entity] spawn {
				params ["_entity"];
				private _group = group _entity;
				if (_group isEqualType objNull) then {_group = group _group};
				private _leader = leader _group;
				private _previousBehaviour = behaviour _leader;

				private _arrayShuffle = {
					private _array = _this select 0;
					private _count = count _array;
					private _arrayN = [];
					private _arrayT = [];
					private _c = 0;
					private _r = 0;

					while {_c < _count} do
					{
						while {_r in _arrayT} do
						{_r = floor (random _count);
						};
						_arrayT pushBack _r;
						_arrayN set [_c, _array select _r];
						_c = _c + 1;
					};

					_arrayN
				};

				private _fnc_getHousePositions = {
					params ["_index","_houses"];
					private _nearestBuilding = _houses select _index;
					private _positionsInBuilding = [_nearestBuilding] call BIS_fnc_buildingPositions;
					_positionsInBuilding = [_positionsInBuilding] call _arrayShuffle;
					_positionsInBuilding
				};

				private _fnc_disableMoveAfterReachPos = {
					params ["_unit","_pos"];
					waitUntil {moveToCompleted _unit};
					_unit setPos _pos;
					_unit setBehaviour "SAFE";
					[_unit,0] remoteExec ['forceSpeed'];
					_unit addEventHandler ["Suppressed", {
						params ["_unit", "_distance", "_shooter", "_instigator", "_ammoObject", "_ammoClassName", "_ammoConfig"];
						[_unit,-1] remoteExec ['forceSpeed'];
					}];
				};

				private _fnc_orderToPositions = {
					params ["_units","_positions","_houseIndex"];
					private _newUnits = _units;
					{
						private _unit = objNull;
						if((count _units) -1 >= _forEachIndex) then {
							private _unit = _units select _forEachIndex;
							_unit doMove _x;
							_newUnits = _newUnits - [_unit];
							_unit forceSpeed -1;
							[_unit,_x] spawn _fnc_disableMoveAfterReachPos;
						};
					}forEach _positions;
					if((count _buildingPoses) < (count _units)) then {
						_houseIndex = _houseIndex + 1;
						_buildingPoses = [_houseIndex,_nearestBuildings] call _fnc_getHousePositions;
						[_newUnits,_buildingPoses,_houseIndex] call _fnc_orderToPositions;
					};
				};

				{
					deleteWaypoint [_group,_forEachIndex];
				}forEach (waypoints _group);

				private _nearestBuildings = nearestObjects [getPosATL _entity, ["building"], 50, true];
				_nearestBuildings = _nearestBuildings select {count ([_x] call BIS_fnc_buildingPositions) > 0};

				if (_nearestBuildings isEqualTo []) exitWith { false };
				_group setbehaviour "AWARE";
				
				private _houseIndex = 0;
				
				private _buildingPoses = [_houseIndex,_nearestBuildings] call _fnc_getHousePositions;

				private _units = (units _group) select {!isNull _x && alive _x};

				[_units,_buildingPoses,_houseIndex] call _fnc_orderToPositions;

				true
			};
		};