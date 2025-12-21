MAZ_EZM_fnc_localBuildingDestruct = {
			if(!isNil "MAZ_EZM_MEH_BuildingCHanged_CompDestruct") then {
				removeMissionEventhandler ["BuildingChanged",MAZ_EZM_MEH_BuildingCHanged_CompDestruct];
			};
			MAZ_EZM_MEH_BuildingCHanged_CompDestruct = addMissionEventHandler ["BuildingChanged", {
				params ["_from", "_to", "_isRuin"];
				private _objects = _from getVariable ["MAZ_EZM_CompObjects",[]];
				{
					_x params ["_object","_objectPos"];
					detach _object;
				}forEach _objects;
				[_from,_to,_isRuin,_objects] spawn {
					params ["_from", "_to", "_isRuin","_objects"];
					sleep 0.8;
					private _deleteObjects = [];
					{
						_x params ["_object","_objectPos"];
						private _relPos = _objectPos vectorDiff (boundingCenter _to);
						private _absPos = _to modelToWorldWorld _relPos;
						_object setPosWorld _absPos;
						[_object,_to] call BIS_fnc_attachToRelative;
						if(!isTouchingGround _object) then {
							_deleteObjects pushBack _x;
						};
					}forEach _objects;

					{
						_x params ["_object","_objectPos"];
						_objects deleteAt (_objects find _x);
						deleteVehicle _object;
					}forEach _deleteObjects;

					_to addEventhandler ["Deleted", {
						params ["_entity"];
						private _objects = _entity getVariable ["MAZ_EZM_CompObjects",[]];
						{
							_x params ["_object","_objectPos"];
							deleteVehicle _object;
						}forEach _objects;
					}];

					_to addEventhandler ["Killed", {
						params ["_unit", "_killer", "_instigator", "_useEffects"];
						[_unit] spawn {
							params ["_unit"];
							sleep 0.8;
							private _objects = _unit getVariable ["MAZ_EZM_CompObjects",[]];
							private _deleteObjects = [];
							{
								_x params ["_object","_objectPos"];
								if(!isTouchingGround _object) then {
									_deleteObjects pushBack _x;
								};
								detach _object;
							}forEach _objects;

							{
								_x params ["_object","_objectPos"];
								_objects deleteAt (_objects find _x);
								deleteVehicle _object;
							}forEach _deleteObjects;

							_unit setVariable ["MAZ_EZM_CompObjects",_objects,true];
						};
					}];
					
					_to setVariable ["MAZ_EZM_CompObjects",_objects,true];
					_to setVariable ["MAZ_EZM_hasCompSetup",true,true];
				};
			}];
		};