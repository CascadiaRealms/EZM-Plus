MAZ_EZM_fnc_createBuildingInterior = {
			params ["_building",["_compDataFull",[]],["_doDebug",true]];
			if(_building getVariable ["MAZ_EZM_hasCompSetup",false]) exitWith {
				if(_doDebug) then {
					["This building already has a composition!","addItemFailed"] call MAZ_EZM_fnc_systemMessage;
				};
			};
			private _typeOfBuilding = "";
			if(_compDataFull isEqualTo []) then {
				private _buildingDatas = [_building] call MAZ_EZM_fnc_getBuildingInteriorsForBuildingType;
				if(_buildingDatas isEqualTo []) exitWith {};
				_typeOfBuilding = _buildingDatas # 0 # 0;
				_compDataFull = selectRandom (_buildingDatas # 0 # 1);
			};
			if(_compDataFull isEqualTo []) exitWith {if(_doDebug) then {["Cannot find any saved types","addItemFailed"] call MAZ_EZM_fnc_systemMessage}};
			private _compData = _compDataFull;
			if(!([typeOf _building,_typeOfBuilding] call MAZ_EZM_fnc_isSameBuildingType)) exitWith {if(_doDebug) then {["Wrong house type","addItemFailed"] call MAZ_EZM_fnc_systemMessage}};
			private _isTerrainBuilding = if(_building in (nearestTerrainObjects [getPosATL _building, ["House"], 50])) then {true} else {false};
			if(_isTerrainBuilding) then {
				comment "Replace building, terrain buildings don't invoke BuildingChanged MEH";
				_building setVariable ["MAZ_EZM_hasCompSetup",true,true];
				private _buildingType = typeOf _building;
				private _dir = vectorDir _building;
				private _up = vectorUp _building;
				private _worldPos = getPosWorld _building;
				[_building,true] remoteExec ["hideObjectGlobal",2];
				[_building,false] remoteExec ['allowDamage'];
				private _temp = _building;
				_building = _buildingType createVehicle [0,0,0];
				_building setVariable ["MAZ_EZM_isCompClone",true,true];
				_building setVariable ["MAZ_EZM_compParent",_temp,true];
				_building setPosWorld _worldPos;
				_building setVectorDirAndUp [_dir,_up];
			};
			private _objects = [];
			{
				_x params ["_type","_pos"];
				private _object = [_building,_x] call MAZ_EZM_fnc_createInteriorObject;
				_objects pushBack [_object,_pos];
			}forEach _compData;

			_building setVariable ["MAZ_EZM_CompObjects",_objects,true];
			_building setVariable ["MAZ_EZM_hasCompSetup",true,true];

			_building addEventhandler ["Deleted", {
				params ["_entity"];
				private _objects = _entity getVariable ["MAZ_EZM_CompObjects",[]];
				{
					_x params ["_object","_objectPos"];
					deleteVehicle _object;
				}forEach _objects;
			}];

			_building addEventhandler ["Killed", {
				params ["_unit", "_killer", "_instigator", "_useEffects"];
				[_unit] spawn {
					params ["_unit"];
					private _objects = _unit getVariable ["MAZ_EZM_CompObjects",[]];
					sleep 0.8;
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

			if(isNil "MAZ_EZM_buildingDestructSetup") then {
				MAZ_EZM_buildingDestructSetup = true;
				call MAZ_EZM_fnc_localBuildingDestruct;
			};

		};
		
		MAZ_EZM_fnc_createBuildingInteriorCall = {
			params ["_entity"];
			if(
				isNull _entity ||
				{!(_entity isEqualType objNull)} ||
				{!((typeOf _entity) isKindOf "House")}
			) exitWith {
				private _pos = [true] call MAZ_EZM_fnc_getScreenPosition;
				private _building = [_pos] call MAZ_EZM_fnc_getNearestBuilding;
				if(_building distance2D _pos < 20) then {
					[_building] call MAZ_EZM_fnc_createBuildingInterior;
				};
			};
			[_entity] call MAZ_EZM_fnc_createBuildingInterior;
		};