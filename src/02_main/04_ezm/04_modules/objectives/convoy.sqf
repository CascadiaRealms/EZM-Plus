MAZ_EZM_fnc_getAutoMissionUnitTypes = {
	params ["_side"];
	private _return = [];
	switch (_side) do {
		case west: {
			switch (worldName) do {
				case "Stratis";
				case "Malden";
				case "Altis": {
					_return = [
						"B_Soldier_A_F",
						"B_Soldier_AR_F",
						"B_Medic_F",
						"B_Soldier_GL_F",
						"B_Soldier_M_F",
						"B_Soldier_F",
						"B_Soldier_LAT_F",
						"B_Soldier_LAT2_F"
					];
				};
				case "Tanoa": {
					_return = [
						"B_T_Soldier_A_F",
						"B_T_Soldier_AR_F",
						"B_T_Medic_F",
						"B_T_Soldier_GL_F",
						"B_T_Soldier_M_F",
						"B_T_Soldier_F",
						"B_T_Soldier_LAT_F",
						"B_T_Soldier_LAT2_F"
					];
				};
				case "Enoch": {
					_return = [
						"B_W_Soldier_A_F",
						"B_W_Soldier_AR_F",
						"B_W_Medic_F",
						"B_W_Soldier_GL_F",
						"B_W_Soldier_M_F",
						"B_W_Soldier_F",
						"B_W_Soldier_LAT_F",
						"B_W_Soldier_LAT2_F"
					];
				};
			};
		};
		case east: {
			switch (worldName) do {
				case "Stratis";
				case "Malden";
				case "Altis": {
					_return = [
						"O_Soldier_A_F",
						"O_Soldier_AR_F",
						"O_Medic_F",
						"O_Soldier_GL_F",
						"O_Soldier_M_F",
						"O_Soldier_F",
						"O_Soldier_LAT_F"
					];
				};
				case "Tanoa": {
					_return = [
						"O_T_Soldier_A_F",
						"O_T_Soldier_AR_F",
						"O_T_Medic_F",
						"O_T_Soldier_GL_F",
						"O_T_Soldier_M_F",
						"O_T_Soldier_F",
						"O_T_Soldier_LAT_F"
					];
				};
				case "Enoch": {
					_return = [
						"O_R_JTAC_F",
						"O_R_Soldier_AR_F",
						"O_R_Medic_F",
						"O_R_Soldier_GL_F",
						"O_R_Soldier_M_F",
						"O_R_Soldier_LAT_F"
					]
				};
			};
		};
		case independent: {
			switch (worldName) do {
				case "Stratis";
				case "Malden";
				case "Altis": {
					_return = [
						"I_Soldier_A_F",
						"I_Soldier_AR_F",
						"I_Medic_F",
						"I_Soldier_GL_F",
						"I_Soldier_M_F",
						"I_Soldier_F",
						"I_Soldier_LAT_F",
						"I_Soldier_LAT2_F"
					];
				};
				case "Tanoa": {
					_return = [
						"I_C_Soldier_Para_7_F",
						"I_C_Soldier_Para_3_F",
						"I_C_Soldier_Para_4_F",
						"I_C_Soldier_Para_6_F",
						"I_C_Soldier_Para_8_F",
						"I_C_Soldier_Para_1_F",
						"I_C_Soldier_Para_5_F"
					];
				};
				case "Enoch": {
					_return = [
						"I_E_Soldier_A_F",
						"I_E_Soldier_AR_F",
						"I_E_Medic_F",
						"I_E_Soldier_GL_F",
						"I_E_Soldier_M_F",
						"I_E_Soldier_F",
						"I_E_Soldier_LAT_F",
						"I_E_Soldier_LAT2_F"
					];
				};
			};
		};
	};
	_return
};

MAZ_EZM_fnc_newConvoyMission = {
	MAZ_EZM_fnc_getConvoyInfo = {
		params ["_convoyType"];
		private _returnInfo = [];
		switch (_convoyType) do {
			case 0: {
				comment "Vehicle Types";
				_returnInfo pushBack [
					"O_APC_Wheeled_02_rcws_v2_F",
					"O_Truck_03_ammo_F",
					"O_APC_Wheeled_02_rcws_v2_F"
				];

				comment "Starting location";
				_returnInfo pushBack [10801.153,10591.354];

				comment "Starting locations";
				_returnInfo pushBack [
					[10800.998,10625.687],
					[10801.449,10578.907],
					[10799.197,10537.174]
				];

				comment "Starting direction";
				_returnInfo pushBack [0,0,0];

				comment "Waypoints";
				_returnInfo pushBack [
					[11003.723,15674.568],
					[15139.83,17539.145],
					[15797.84,16290.967],
					[15374.077,16232.825],
					[15477.943,15886.842]
				];

				comment "Ending location";
				_returnInfo pushBack [15483.02,15867.24];

				comment "Marker Locations";
				_returnInfo pushBack [
					[11256.663,13165.631],
					[11330.834,14107.15],
					[11334.651,15318.223],
					[12872.64,15937.588],
					[14940.22,17353.176],
					[15929.533,16978.57]
				];

				comment "Convoy Side";
				_returnInfo pushBack east;
			};
			case 1: {
				comment "Vehicle Types";
				_returnInfo pushBack [
					"I_APC_Wheeled_03_cannon_F",
					"I_Truck_02_ammo_F",
					selectRandom ["I_MRAP_03_hmg_F","I_MRAP_03_gmg_F"]
				];

				comment "Starting location";
				_returnInfo pushBack [21580.479,7823.819];

				comment "Starting locations";
				_returnInfo pushBack [
					[21572.172,7857.319],
					[21584.908,7820.114],
					[21598.602,7780.707]
				];
				
				comment "Starting direction";
				_returnInfo pushBack [344.183,341.303,339.796];

				comment "Waypoints";
				_returnInfo pushBack [
					[19363.201,13328.431],
					[19378.586,15294.969],
					[25343.486,21053.148],
					[24317.18,21512.117],
					[22506.36,20784.482],
					[22019.516,21063.064]
				];

				comment "Ending location";
				_returnInfo pushBack [22024.95,21072.063];

				comment "Marker Locations";
				_returnInfo pushBack [
					[19912.098,11622.105],
					[19340.213,14848.896],
					[20502.85,16353.783],
					[22899.82,19291.697],
					[25281.32,21018.078],
					[24252.854,21534.236],
					[22653.04,20858.324]
				];

				comment "Convoy Side";
				_returnInfo pushBack independent;
			};
			case 2: {
				comment "Vehicle Types";
				_returnInfo pushBack [
					"O_APC_Tracked_02_cannon_F",
					"O_Truck_03_device_F",
					"O_APC_Wheeled_02_rcws_v2_F"
				];

				comment "Starting location";
				_returnInfo pushBack [17506.146,13205.87];

				comment "Starting locations";
				_returnInfo pushBack [
					[17488.219,13224.532],
					[17519.352,13192.043],
					[17548.129,13161.36]
				];
				
				comment "Starting direction";
				_returnInfo pushBack [316.789,316.911,313.466];

				comment "Waypoints";
				_returnInfo pushBack [
					[17284.742,13438.548],
					[15813.545,17391.84],
					[10317.244,19004.494],
					[7437.338,17151.658],
					[6188.207,16181.874],
					[6171.746,16300.393]
				];

				comment "Ending location";
				_returnInfo pushBack [6175.534,16252.588];

				comment "Marker Locations";
				_returnInfo pushBack [
					[16886.854,15487.035],
					[15497.099,17511.123],
					[12414.757,18786.67],
					[8403.481,18231.346]
				];

				comment "Convoy Side";
				_returnInfo pushBack east;
			};
			case 3: {
				comment "Vehicle Types";
				_returnInfo pushBack [
					"I_APC_Wheeled_03_cannon_F",
					"I_Truck_02_ammo_F",
					"I_APC_Wheeled_03_cannon_F",
					selectRandom ["I_MRAP_03_hmg_F","I_MRAP_03_gmg_F"]
				];

				comment "Starting location";
				_returnInfo pushBack [3260.870,12509.276];

				comment "Starting locations";
				_returnInfo pushBack [
					[3254.868,12504.7],
					[3237.267,12498.41],
					[3220.510,12492.701],
					[3203.243,12486.627]
				];
				
				comment "Starting direction";
				_returnInfo pushBack [72.490,72.509,72.572,72.178];

				comment "Waypoints";
				_returnInfo pushBack [
					[9289.280,15856.197],
					[17870.432,18199.361]
				];

				comment "Ending location";
				_returnInfo pushBack [17870.432,18199.361];

				comment "Marker Locations";
				_returnInfo pushBack [
					[6299.041,15151.183],
					[9218.906,15837.3],
					[14542.193,16940.186],
					[17211.178,17898.922]
				];

				comment "Convoy Side";
				_returnInfo pushBack independent;
			};
		};
		_returnInfo;
	};

	MAZ_EZM_fnc_createVehicleUnitConvoy = {
		params ["_group","_unitType"];
		private _soldier = _group createUnit [_unitType,[23405.7,17895.8,0],[],0,"CAN_COLLIDE"];
		_soldier setVectorDirAndUp [[0,1,0],[0,0,1]];
		_soldier setUnitPos MAZ_EZM_stanceForAI;
		_soldier;
	};

	MAZ_EZM_fnc_createConvoyVehicle = {
		params ["_type","_vehPos","_vehDir","_group"];
		private _veh = createVehicle [_type,_vehPos,[],0,"None"];
		_veh setDir _vehDir;
		private _unitType = selectRandom ([side _group] call MAZ_EZM_fnc_getAutoMissionUnitTypes);
		private _vehDriver = [_group,_unitType] call MAZ_EZM_fnc_createVehicleUnitConvoy;
		_vehDriver moveInDriver _veh;
		_vehDriver limitSpeed 57;
		_vehDriver setSkill ["courage",1];
		_vehDriver setSkill ["commanding",1];
		if(_type isKindOf "Truck_F") then {
			_unitType = selectRandom ([side _group] call MAZ_EZM_fnc_getAutoMissionUnitTypes);
			private _vehCargo = [_group,_unitType] call MAZ_EZM_fnc_createVehicleUnitConvoy;
			_vehCargo moveInCargo _veh;
		} else {
			_unitType = selectRandom ([side _group] call MAZ_EZM_fnc_getAutoMissionUnitTypes);
			private _vehGunner = [_group,_unitType] call MAZ_EZM_fnc_createVehicleUnitConvoy;
			_vehGunner moveInGunner _veh;
			if (_veh emptyPositions "commander" > 0) then {
				_unitType = selectRandom ([side _group] call MAZ_EZM_fnc_getAutoMissionUnitTypes);
				private _vehCommander = [_group,_unitType] call MAZ_EZM_fnc_createVehicleUnitConvoy;
				_vehCommander moveInCommander _veh;
			};
		};
		_veh;
	};

	private _convoyType = [0,3] call BIS_fnc_randomInt;
	private _convoyInfo = [_convoyType] call MAZ_EZM_fnc_getConvoyInfo;
	
	private _vehTypes = _convoyInfo select 0;
	private _startPos = _convoyInfo select 1;
	private _startLocations = _convoyInfo select 2;
	private _startDirs = _convoyInfo select 3;
	private _wayPoints = _convoyInfo select 4;
	private _endPos = _convoyInfo select 5;
	private _markerLocations = _convoyInfo select 6;
	private _convoySide = _convoyInfo select 7;

	private _convoyGroup = createGroup _convoySide;
	private _vehicles = [];
	for "_i" from 0 to (count _vehTypes-1) do {
		private _vehType = _vehTypes select _i;
		private _vehPos = _startLocations select _i;
		private _vehDir = _startDirs select _i;
		private _return = [_vehType,_vehPos,_vehDir,_convoyGroup] call MAZ_EZM_fnc_createConvoyVehicle;
		_vehicles pushBack _return;
	};

	private _leader = effectiveCommander (_vehicles select 0);
	_convoyGroup selectLeader _leader;
	_leader setSkill ["courage",1];
	_leader setSkill ["commanding",1];

	_convoyGroup setCombatMode "YELLOW";
	_convoyGroup setBehaviour "SAFE";
	_convoyGroup setFormation "COLUMN";
	_convoyGroup setSpeedMode "LIMITED";

	[[false,true]] remoteExec ['enableEnvironment',2];

	{
		private _waypoint = _convoyGroup addWaypoint [_x, 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 35;
		_waypoint setWaypointCombatMode "YELLOW";
		_waypoint setWaypointBehaviour "SAFE";
		_waypoint setWaypointFormation "COLUMN";
		_waypoint setWaypointSpeed "LIMITED";
	} forEach _wayPoints;
	private _numWaypoints = count waypoints _convoyGroup;

	private _cargoVehicles = [];
	{
		_x allowCrewInImmobile true;
		[_x,2] remoteExec ["lock"];
		_x limitSpeed 57;
		(driver _x) limitSpeed 57;
		_x forceSpeed 15.84;
		_x setConvoySeparation 90;
		private _driverVeh = driver _x;
		_driverVeh allowFleeing 0;
		_driverVeh disableAI "AUTOCOMBAT";
		_driverVeh disableAI "TARGET";
		_driverVeh disableAI "MINEDETECTION";
		if(typeOf _x isKindOf "Truck_F") then {
			_cargoVehicles pushBack _x;
		};
	}forEach _vehicles;

	{
		_x limitSpeed 57;
		_x disableAI "MINEDETECTION";
	}forEach (units _convoyGroup);

	private _markers = [];

	private _markerColor = "ColorEAST";
	switch (_convoySide) do {
		case east: {_markerColor = "ColorEAST";};
		case independent: {_markerColor = "ColorGUER";};
	};
	private _convoyStartMarker = createMarker ["convoyStart_MAZ",_startPos];
	_convoyStartMarker setMarkerType "mil_marker";
	_convoyStartMarker setMarkerColor _markerColor;
	_convoyStartMarker setMarkerText "Convoy Start";
	_markers pushBack _convoyStartMarker;

	{
		private _checkpointMarker = createMarker [format ["checkPointMarker_MAZ_%1",_forEachIndex],_x];
		_checkpointMarker setMarkerType "mil_marker";
		_checkpointMarker setMarkerColor _markerColor;
		_checkpointMarker setMarkerText format ["Checkpoint #%1",_forEachIndex+1];
		_markers pushBack _checkpointMarker;
	}forEach _markerLocations;

	["TaskAssignedIcon",["A3\UI_F\Data\Map\Markers\Military\warning_CA.paa","A Convoy is Moving"]] remoteExec ['BIS_fnc_showNotification'];

	[_vehicles] spawn {
		params ["_vehicles"];
		while {({alive _x} count _vehicles) != 0} do {
			{
				_x limitSpeed 57;
				(driver _x) limitSpeed 57;
				_x forceSpeed 15.84;
				_x setConvoySeparation 90;
			}forEach _vehicles;
			sleep 1;
		};
	};

	[_markers,_vehicles] spawn {
		params ["_markers","_vehicles"];
		for "_i" from 0 to (count _markers - 2) do {
			waitUntil {
				(
					({
						(_x distance (getMarkerPos (_markers select (_i + 1)))) < 30
					} count _vehicles) != 0
				)
			};
			["TaskAssignedIcon",["A3\UI_F\Data\Map\Markers\Military\warning_CA.paa",format ["The Convoy Has Reached Checkpoint %1",_i + 1]]] remoteExec ['BIS_fnc_showNotification'];
		};
	};

	[_convoyGroup,_numWaypoints,_vehicles,_markers,_cargoVehicles] spawn {
		params ["_convoyGroup","_numWaypoints","_vehicles","_markers","_trucks"];
		private _soldiersArray = units _convoyGroup;
		waitUntil {currentWaypoint _convoyGroup >= _numWaypoints || (({alive _x} count _soldiersArray) == 0) || (({alive _x} count _trucks) == 0)};
		if(({alive _x} count _soldiersArray) == 0) exitWith {
			comment "Success";
			["TaskSucceeded",["","Convoy Stopped!"]] remoteExec ['BIS_fnc_showNotification'];
			{
				deleteMarker _x;
			}forEach _markers;
			sleep 90;
			waitUntil {{isPlayer _x} count ((_vehicles select 0) nearEntities ["Man",1600]) == 0};
			{
				deleteVehicle _x;
			} forEach _vehicles + _soldiersArray;
			sleep 600;
			if(MAZ_EZM_autoConvoy) then {
				[] call MAZ_EZM_fnc_newConvoyMission;
			};
		};
		if(currentWaypoint _convoyGroup >= _numWaypoints) exitWith {
			comment "Failure";
			["TaskFailed",["","Convoy Reached Their End"]] remoteExec ['BIS_fnc_showNotification'];
			{
				deleteMarker _x;
			}forEach _markers;
			{
				deleteVehicle _x;
			} forEach _vehicles + _soldiersArray;
			sleep 600;
			if(MAZ_EZM_autoConvoy) then {
				[] call MAZ_EZM_fnc_newConvoyMission;
			};
		};
		if(({alive _x} count _trucks) == 0) exitWith {
			comment "Failure";
			["TaskFailed",["","Convoy Cargo Destroyed!"]] remoteExec ['BIS_fnc_showNotification'];
			{
				deleteMarker _x;
			}forEach _markers;
			sleep 90;
			waitUntil {{isPlayer _x} count ((_vehicles select 0) nearEntities ["Man",1600]) == 0};
			{
				deleteVehicle _x;
			} forEach _vehicles + _soldiersArray;
			sleep 600;
			if(MAZ_EZM_autoConvoy) then {
				[] call MAZ_EZM_fnc_newConvoyMission;
			};
		};
	};
};

MAZ_EZM_fnc_toggleRandomConvoyModule = {
	if(worldName != "Altis") exitWith {["Currently only configured for Altis! You can create your own by contacting Expung3d!","addItemFailed"] call MAZ_EZM_fnc_systemMessage;};
	if(missionNamespace getVariable ["MAZ_EZM_autoConvoy",false]) then {
		missionNamespace setVariable ["MAZ_EZM_autoConvoy",false,true];
		["Automated Convoy Missions disabled.","addItemOk"] call MAZ_EZM_fnc_systemMessage;
	} else {
		missionNamespace setVariable ["MAZ_EZM_autoConvoy",true,true];
		["Automated Convoy Missions enabled.","addItemOk"] call MAZ_EZM_fnc_systemMessage;
		[] call MAZ_EZM_fnc_newConvoyMission;
	};
};
