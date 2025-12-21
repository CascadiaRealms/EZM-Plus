MAZ_EZM_fnc_getBuildingInteriorData = {
			params ["_building",["_save",false]];
			if(!((typeOf _building) isKindOf "House")) exitWith {["Not a building","addItemFailed"] call MAZ_EZM_fnc_systemMessage;};
			private _bbr = boundingBoxReal _building;
			private _p1 = _bbr select 0;
			private _p2 = _bbr select 1;
			private _maxWidth = abs ((_p2 select 0) - (_p1 select 0));
			private _maxLength = abs ((_p2 select 1) - (_p1 select 1));
			private _maxHeight = abs ((_p2 select 2) - (_p1 select 2));
			if(!isNil "MAZ_EZM_buildingCompMarker") then {
				deleteMarker MAZ_EZM_buildingCompMarker;
			};
			MAZ_EZM_buildingCompMarker = createMarker ["BuildingSizeMarker", position _building];
			MAZ_EZM_buildingCompMarker setMarkerPos (getPosATL _building);
			MAZ_EZM_buildingCompMarker setMarkerDir (getDir _building);
			MAZ_EZM_buildingCompMarker setMarkerBrush "Solid";
			MAZ_EZM_buildingCompMarker setMarkerShape "RECTANGLE";
			MAZ_EZM_buildingCompMarker setMarkerSize [_maxWidth/2,_maxLength/2];
			MAZ_EZM_buildingCompMarker setMarkerColor "ColorBlack";
			MAZ_EZM_buildingCompMarker setMarkerAlpha 1;

			private _allObjects = (allSimpleObjects []) + (allMissionObjects "all");

			private _compositionData = [];
			{
				if(_x == _building) then {continue};
				if(isAgent teamMember _x) then {continue};
				if(_x isKindOf "Man") then {continue};
				if(!(_x inArea MAZ_EZM_buildingCompMarker)) then {continue};
				private _worldPos = getPosWorld _x;
				if (!(surfaceIsWater _worldPos)) then {
					_worldPos = ASLToATL _worldPos;
				};
				private _relPos = _building worldToModel _worldPos;
				_relPos = _relPos vectorAdd (boundingCenter _building);
				private _relDirAndUp = [_x,_building] call BIS_fnc_vectorDirAndUpRelative;
				private _scale = getObjectScale _x;
				
				if(is3DEN) then {
					if((_x get3DENAttribute "CSObject") # 0) then {
						comment "CSO simple";
						private _isVanilla = [_x] call MAZ_EZM_fnc_getIfObjectIsVanilla;
						if(_isVanilla) then {
							_compositionData pushBack [
								typeOf _x,
								_relPos,
								_relDirAndUp,
								true,
								getObjectTextures _x,
								_scale
							];
						} else {
							(getModelInfo _x) params ["","_modelPath","",""];
							_compositionData pushBack [
								_modelPath,
								_relPos,
								_relDirAndUp,
								true,
								[],
								_scale
							];
						};
					} else {
						if ((_x get3DENAttribute "objectIsSimple") select 0) exitWith {
							comment "Normally Simple";
							_compositionData pushBack [
								typeOf _x,
								_relPos,
								_relDirAndUp,
								true,
								getObjectTextures _x,
								_scale
							];
						};
						comment "Normal object with simulation";
						_compositionData pushBack [
							typeOf _x,
							_relPos,
							_relDirAndUp,
							isSimpleObject _x,
							getObjectTextures _x,
							_scale
						];
					};
				} else {
					comment "In Zeus";
					_compositionData pushBack [
						typeOf _x,
						_relPos,
						_relDirAndUp,
						isSimpleObject _x,
						getObjectTextures _x,
						_scale
					];
				};
			}forEach _allObjects;

			deleteMarker MAZ_EZM_buildingCompMarker;
			MAZ_EZM_buildingCompMarker = nil;

			private _buildingType = [_building] call MAZ_EZM_fnc_getBaseType;
			if(_save) then {
				private _data = profileNamespace getVariable ["MAZ_EZM_BuildingCompositionData",[]];
				_data = [_data,[_buildingType,_compositionData]] call MAZ_EZM_fnc_addBuildingDataToVar;
				profileNamespace setVariable ["MAZ_EZM_BuildingCompositionData",_data];
				saveProfileNamespace;
			} else {
				MAZ_EZM_buildingCompData = [_buildingType,_compositionData];
				systemChat "Saved to variable 'MAZ_EZM_buildingCompData'";
			};

			[_buildingType,_compositionData]
		};
		
		MAZ_EZM_fnc_getBuildingInteriorDataCall = {
			params ["_entity"];
			if(!((typeOf _entity) isKindOf "House")) exitWith {
				private _pos = [true] call MAZ_EZM_fnc_getScreenPosition;
				private _building = nearestBuilding _pos;
				if(_building distance2D _pos < 20) then {
					[_building] call MAZ_EZM_fnc_getBuildingInteriorData;
				};
			};
			[_entity,true] call MAZ_EZM_fnc_getBuildingInteriorData;
		};