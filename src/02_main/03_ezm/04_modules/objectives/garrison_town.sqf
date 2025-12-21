MAZ_EZM_fnc_createGarrisonTownDialog = {
			["Garrison Town",[
				[
					"EDIT",
					["Town Name:","Enter a town name, like 'Kavala' or 'Athira'."],
					["None"]
				],
				[
					"SIDES",
					"Side of Garrison:",
					east
				],
				[
					"SLIDER",
					"Percent of Garrison:",
					[0.1,0.4,0.2,objNull,[0,0,0,0],true]
				],
				[
					"SLIDER",
					"Number of Patrols",
					[2,4,3]
				],
				[
					"TOOLBOX",
					"Fortify Houses?:",
					[
						true,
						["Don't Fortify","Fortify"]
					]
				],
				[
					"TOOLBOX",
					["Notify Players?:","Shows players a task popup after the town has been garrisoned."],
					[
						true,
						["Don't Notify","Notify"]
					]
				]
			],{
				params ["_values","_args","_display"];
				_values params ["_town","_side","_garrPercent","_patrols","_fortify","_notify"];
				private _locationNames = [];
				{	
					private _lct = _forEachIndex;
					{	
						_locationNames pushBack (toUpper (text _x));
					} forEach nearestLocations [getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition"), [_x], worldSize];	
				} forEach ["NameVillage", "NameCity", "NameCityCapital"];
				if(!(toUpper _town in _locationNames) && ((toUpper _town) != "NONE" && (toUpper _town) != "")) exitWith {["No such town!","addItemFailed"] call MAZ_EZM_fnc_systemMessage;};
				[_town,_sideNew,_garrPercent,_patrols,_fortify,_notify] spawn MAZ_EZM_fnc_garrisonTown; 
				_display closeDisplay 1;
			},{
				params ["_values","_args","_display"];
				_display closeDisplay 2;
			},[]] call MAZ_EZM_fnc_createDialog;
		};

		MAZ_EZM_fnc_garrisonGroup = {
			params [
				["_group",grpNull,[grpNull]],
				["_fortify",false,[false]]
			];
			if(isNull _group) exitWith {};

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
				if(isNil "_nearestBuilding") exitWith {};
				private _positionsInBuilding = [_nearestBuilding] call BIS_fnc_buildingPositions;
				_positionsInBuilding = [_positionsInBuilding] call _arrayShuffle;
				_positionsInBuilding
			};

			private _fnc_orderToPositions = {
				params ["_units","_positions","_houseIndex"];
				private _newUnits = _units;
				{
					private _unit = objNull;
					if((count _units) -1 >= _forEachIndex) then {
						private _unit = _units select _forEachIndex;
						_unit setPos _x;
						_newUnits = _newUnits - [_unit];
						_unit forceSpeed 0;
					};
				}forEach _positions;
				if((count _buildingPoses) < (count _units)) then {
					_houseIndex = _houseIndex + 1;
					if(_fortify) then {
						private _house = _nearestBuildings # _houseIndex;
						[_house,[],false] call MAZ_EZM_fnc_createBuildingInterior;
					};
					_buildingPoses = [_houseIndex,_nearestBuildings] call _fnc_getHousePositions;
					[_newUnits,_buildingPoses,_houseIndex] call _fnc_orderToPositions;
				};
			};

			{
				deleteWaypoint [_group,_forEachIndex];
			}forEach (waypoints _group);

			private _nearestBuildings = [getPosATL _leader,50] call MAZ_EZM_fnc_getGarrisonBuildings;

			if (_nearestBuildings isEqualTo []) exitWith { false };
			_group setbehaviour "AWARE";

			private _houseIndex = 0;
			private _buildingPoses = [_houseIndex,_nearestBuildings] call _fnc_getHousePositions;

			private _units = (units _group) select {!isNull _x && alive _x};

			[_units,_buildingPoses,_houseIndex] call _fnc_orderToPositions;

			true
		};

		MAZ_EZM_fnc_getGarrisonBuildings = {
			params ["_pos","_radius"];
			private _buildings = nearestTerrainObjects [_pos,["BUILDING","HOUSE"],_radius];
			private _buildingBlacklist = ["Land_Metal_Shed_F","Land_i_Addon_04_V1_F","Land_i_Addon_03_V1_F","Land_i_Addon_01_V1_F","Land_Slum_House03_F","Land_Slum_House01_F","Land_i_Garage_V1_F","Land_u_Addon_01_V1_F","Land_i_Addon_03mid_V1_F"];
			_buildings = _buildings select {
				!(_x isKindOf "Church") &&
				!(_x isKindOf "Cemetery_base_F") && 
				!("grave" in toLower (str _x)) &&
				!("chapel" in (toLower (typeOf _x))) && 
				!(typeOf _x in _buildingBlacklist) &&
				(alive _x || damage _x < 1)
			};
			_buildings;
		};

		MAZ_EZM_fnc_garrisonTown = {
			params [
				["_town","NONE",[""]],
				["_side",east,[east]],
				["_percentGarrison",0.2,[0.2]],
				["_numOfPatrols",selectRandom [2,3,4],[3]],
				["_fortify",true,[false]],
				["_notify",false,[true]]
			];
			if(_side isEqualTo civilian) exitWith {false};

			private ["_position","_sizeTown"];
			_town = toUpper _town;
			private _locations = [];
			{	
				{	
					_locations pushBack [toUpper (text _x), locationPosition _x,size _x];
				} forEach nearestLocations [getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition"), [_x], worldSize];	
			} forEach ["NameVillage", "NameCity", "NameCityCapital"];
			if(_town == "NONE" || _town == "") then {
				_position = [true] call MAZ_EZM_fnc_getScreenPosition;
				_sizeTown = 200;
			} else {
				private _index = _locations findIf {(_x select 0) == _town};
				_townData = _locations select _index;
				_town = _townData select 0;
				_position = _townData select 1;
				(_townData select 2) params ["_x","_y"];
				_sizeTown = (_x max _y) * 0.75;
			};
			private _townAlert = format ["%1 IS UNDER ATTACK",toUpper _town];
			if(toUpper _town == "NONE") then {
				_townAlert = "A TOWN IS UNDER ATTACK";
			};

			private _unitTypes = [_side] call MAZ_EZM_fnc_getAutoMissionUnitTypes;
			private _buildings = [_position,_sizeTown] call MAZ_EZM_fnc_getGarrisonBuildings;
			private _maxUnits = 200;
			private _units = [];
			{
				if(count _units >= _maxUnits) exitWith {};
				if((random 1) < _percentGarrison) then {
					private _randomNumOfUnits = [2,5] call BIS_fnc_randomInt;
					if(_fortify) then {
						[_x,[],false] call MAZ_EZM_fnc_createBuildingInterior;
					};
					private _grp = createGroup [_side,true];
					for "_i" from 1 to _randomNumOfUnits do {
						private _unitType = selectRandom _unitTypes;
						private _unit = _grp createUnit [_unitType,_x,[],0,"CAN_COLLIDE"];
						_unit setSkill 0.4;
						_unit setUnitPos MAZ_EZM_stanceForAI;
						_units pushBack _unit;
					};
					[_grp,_fortify] call MAZ_EZM_fnc_garrisonGroup;
				};
			}forEach _buildings;

			for "_i" from 0 to _numOfPatrols do {
				private _randPos = [[[_position,150]]] call BIS_fnc_randomPos;
				private _nearRoads = _randPos nearRoads 150;
				private _nearRoad = getPosATL (selectRandom _nearRoads);
				private _randomNumOfUnits = [4,6] call BIS_fnc_randomInt;

				private _grp = createGroup [_side,true];
				for "_j" from 1 to _randomNumOfUnits do {
					private _unitType = selectRandom _unitTypes;
					private _unit = _grp createUnit [_unitType, _nearRoad,[],0,"CAN_COLLIDE"];
					_unit setSkill 0.4;
					_unit setUnitPos MAZ_EZM_stanceForAI;
					_units pushBack _unit;
				};

				for "_j" from 0 to 5 do {
					private _waypoint = _grp addWaypoint [getPosATL (selectRandom _nearRoads),0];
					_waypoint setWaypointType "MOVE";
					_waypoint setWaypointBehaviour "SAFE";
					_waypoint setWaypointSpeed "LIMITED";
				};
				private _waypoint = _grp addWaypoint [_nearRoad,0];
				_waypoint setWaypointType "CYCLE";
				_waypoint setWaypointBehaviour "SAFE";
				_waypoint setWaypointSpeed "LIMITED";
			};

			[_units] call MAZ_EZM_fnc_addObjectToInterface;

			if(_notify) then {
				["TaskAssignedIcon",["A3\UI_F\Data\Map\Markers\Military\warning_CA.paa",_townAlert]] remoteExec ['BIS_fnc_showNotification'];
			};

			true
		};