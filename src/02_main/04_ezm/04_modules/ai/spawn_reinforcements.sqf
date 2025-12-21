MAZ_EZM_fnc_spawnReinforcements = {
			private _fnc_processParams = {
				params ["_pos","_side","_groupType","_dir","_endPos"];
				private _factionData = [_side] call MAZ_EZM_fnc_getAllFactionGroups;
				private _groupCfg = [_factionData,parseNumber _groupType] call MAZ_EZM_fnc_getGroupDataFromIndex;
				_side = switch (getNumber(_groupCfg >> "side")) do {
					case 0: {east};
					case 1: {west};
					case 2: {independent};
				};
				private _heliType = switch (_side) do {
					case west: {"B_Heli_Transport_01_F"};
					case east: {"O_Heli_Light_02_unarmed_F"};
					case independent: {"I_Heli_Transport_02_F"};
				};
				_dir = switch (parseNumber _dir) do {
					case 0: {0};
					case 1: {180};
					case 2: {90};
					case 3: {270};
				};
				private _startPos = _pos getPos [5000,_dir];

				[_startPos,_heliType,_pos,_side,_groupCfg,_dir,_endPos]
			};
			(_this call _fnc_processParams) params ["_startPos","_heliType","_pos","_side","_groupType","_dir","_endPos"];
			_startPos set [2,150];
			private _grp = createGroup [_side,true];
			private _result = [_startPos,_dir+180,_heliType,_grp] call BIS_fnc_spawnVehicle;
			private _spawnedVeh = _result # 0;

			waitUntil{!isNull driver _spawnedVeh};
			_grp setBehaviour "CARELESS";
			[_spawnedVeh,2] remoteExec ['lock'];

			private _heliParams = switch (_heliType) do {
				case "B_Heli_Transport_01_F": {
					[4,["Door_L","Door_R"]]
				};
				case "O_Heli_Light_02_unarmed_F": {
					[2,["dvere1_posunZ","dvere2_posunZ"]]
				};
				case "I_Heli_Transport_02_F": {
					[2,["Door_Back_L","Door_Back_R"]]
				};
			};
			_heliParams params ["_crewCount","_doorAnims"];

			private _group = [[0,0,0], _side, _groupType] call BIS_fnc_spawnGroup;
			private _units = units _group;
			{
				_x moveInCargo _spawnedVeh;
				_x setUnitPos MAZ_EZM_stanceForAI;
			}forEach _units;

			private _heliPad1 = "Land_HelipadEmpty_F" createVehicle _pos;
			_heliPad1 setPos _pos;
			private _waypointPickup = _grp addWaypoint [position _heliPad1,0];
			_waypointPickup setWaypointType "TR UNLOAD";

			private _wayPointGetOut = _group addWaypoint [_pos,0];
			_wayPointGetOut setWaypointType "GETOUT";

			waitUntil {isTouchingGround _spawnedVeh};

			if(_heliType == "O_Heli_Light_02_unarmed_F") then {
				{
					_spawnedVeh animate [_x,1];
				}forEach _doorAnims;
			} else {
				{
					_spawnedVeh animateDoor [_x,1,false];
				}forEach _doorAnims;
			};

			sleep 1.5;
			commandGetOut _units;

			waitUntil {count (crew _spawnedVeh) <= _crewCount};

			if(_heliType == "O_Heli_Light_02_unarmed_F") then {
				{
					_spawnedVeh animate [_x,0];
				}forEach _doorAnims;
			} else {
				{
					_spawnedVeh animateDoor [_x,0,false];
				}forEach _doorAnims;
			};

			private _moveWaypoint = _group addWaypoint [_endPos,0];
			_moveWaypoint setWaypointType "SAD";
			_moveWaypoint setWaypointCombatMode "YELLOW";
			_moveWaypoint setWaypointBehaviour "AWARE";
			_moveWaypoint setWaypointSpeed "FULL";

			sleep 1.5;

			private _wayPointHeliLeave = _grp addWayPoint [_startPos,0];
			_wayPointHeliLeave setWayPointType "MOVE";
			sleep 50;
			{
				deleteVehicle _x;
			} forEach crew _spawnedVeh;
			deleteVehicle _spawnedVeh;
			deleteVehicle _heliPad1;
		};