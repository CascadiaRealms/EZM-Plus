MAZ_EZM_fnc_heliEvacExec = {
			params ["_pos","_direction","_sideOf","_type","_destination",["_passengerNeeded",3]];
			private ["_vehType","_crewCount","_dir","_vehPos","_heliPad1","_heliPad2","_wayPointPickup","_wayPointMove","_wayPointReturn","_pilot","_textLine","_byePos"];
			private _grp = createGroup [_sideOf,true];
			private _direction = toLower _direction;
			private _type = toLower _type;
			switch (_type) do {
				case "hummingbird": {_vehType = "B_Heli_Light_01_F"; _crewCount = _passengerNeeded + 2;};
				case "ghosthawk": {_vehType = "B_Heli_Transport_01_F"; _crewCount = _passengerNeeded + 4;};
				case "ghosthawk ctrg": {if(worldName == 'Tanoa') then {_vehType = "B_CTRG_Heli_Transport_01_tropic_F";} else {_vehType = "B_CTRG_Heli_Transport_01_sand_F";}; _crewCount = _passengerNeeded + 4;};
				case "huron": {_vehType = "B_Heli_Transport_03_F"; _crewCount = _passengerNeeded + 4;};
				case "orca": {_vehType = "O_Heli_Light_02_unarmed_F"; _crewCount = _passengerNeeded + 2;};
				case "taru": {_vehType = "O_Heli_Transport_04_covered_F"; _crewCount = _passengerNeeded + 3;};
				case "hellcat": {_vehType = "I_Heli_light_03_unarmed_F"; _crewCount = _passengerNeeded + 2;};
				case "mohawk": {_vehType = "I_Heli_Transport_02_F"; _crewCount = _passengerNeeded + 2;};
			};
			switch (_direction) do {
				case "north": {_dir = 180; _vehPos = _pos getPos [2000,0];};
				case "south": {_dir = 0; _vehPos = _pos getPos [2000,180];};
				case "east": {_dir = 270; _vehPos = _pos getPos [2000,90];};
				case "west": {_dir = 90; _vehPos = _pos getPos [2000,270];};
			};
			
			private _result = [[_vehPos select 0,_vehPos select 1,100],_dir,_vehType,_grp] call BIS_fnc_spawnVehicle;
			private _spawnedVeh = _result select 0;

			waitUntil {!isNull driver _spawnedVeh};
			_grp setBehaviour "CARELESS";
			{
				_x allowDamage false;
			}forEach (crew _spawnedVeh);

			_spawnedVeh addEventHandler ["Killed",{
				params ["_unit", "_killer", "_instigator", "_useEffects"];
				private _sideOf = side (driver _unit);
				private _textLine = selectRandom [
					"Mayday mayday! We're going down!",
					"We're going down! Auto-rotating!",
					"I always knew this is how I'd go...",
					"I guess a captain goes down with his ship...",
					"We're hit! Going down!",
					"We're not making it to the LZ!"
				];

				private _sideName = [_sideOf] call BIS_fnc_sideName;
				[
					format ["%1 Evac Pilot",_sideName],
					_textLine
				] remoteExec ['BIS_fnc_showSubtitle',_sideOf];
				{
					deleteVehicle _x;
				}forEach (crew _unit);
			}];

			private _heliPad1 = "Land_HelipadEmpty_F" createVehicle _pos;
			_waypointPickup = _grp addWaypoint [position _heliPad1,0];
			_waypointPickup setWaypointType "SCRIPTED";
			_waypointPickup setWaypointScript "A3\functions_f\waypoints\fn_wpLand.sqf";

			private _textLine = selectRandom [
				"Evac is on the way, hang tight.",
				"Location received, evac is inbound.",
				"Coordinates received, your ride is on the way.",
				"Your Uber driver is on their way.",
				"We're on our way, stay put."
			];

			private _sideName = [_sideOf] call BIS_fnc_sideName;
			[
				format ["%1 Evac Pilot",_sideName],
				_textLine
			] remoteExec ['BIS_fnc_showSubtitle',_sideOf];

			waitUntil {isTouchingGround _spawnedVeh};

			if(_vehType == "B_Heli_Transport_01_F" || _vehType == "B_CTRG_Heli_Transport_01_tropic_F" || _vehType == "B_CTRG_Heli_Transport_01_sand_F") then {
				_spawnedVeh animateDoor ["Door_L",1,false]; _spawnedVeh animateDoor ["Door_R",1,false];
				_spawnedVeh lockTurret [[1],true];
				_spawnedVeh lockTurret [[2],true];
			};
			if(_vehType == "B_Heli_Transport_03_F") then {
				_spawnedVeh animateDoor ['Door_rear_source',1,false];
				_spawnedVeh lockTurret [[1],true];
				_spawnedVeh lockTurret [[2],true];
			};
			if(_vehType == "O_Heli_Light_02_unarmed_F") then {
				_spawnedVeh animate ["dvere1_posunZ",1]; _spawnedVeh animate ["dvere2_posunZ",1];
			};

			if(!alive _spawnedVeh) exitWith {
				sleep 120;
				deleteVehicle _spawnedVeh;
				deleteVehicle _heliPad1;
			};
			_textLine = selectRandom [
				"Your Uber has arrived.",
				"Let's get you guys outta here.",
				"We're here, load up.",
				"We haven't got all day, get in the heli.",
				"Touchdown. Everyone, load up.",
				"Pile in, there's plenty of space for all of you."
			];
			[
				format ["%1 Evac Pilot",_sideName],
				_textLine
			] remoteExec ['BIS_fnc_showSubtitle',_sideOf];

			waitUntil {count crew _spawnedVeh >= _crewCount};
			
			_textLine = selectRandom [
				"Prepping for takeoff, if you wanna get out of here get loaded up.",
				"We're leaving in 20 seconds, hurry up.",
				"Get a move on, we're leaving in 20 seconds.",
				"We're not waiting much longer, leaving in 20 seconds.",
				"In 20 seconds we're RTB, hurry up.",
				"We want our RnR, if you're not here in 20 seconds you'll be stuck out here!"
			];
			[
				format ["%1 Evac Pilot",_sideName],
				_textLine
			] remoteExec ['BIS_fnc_showSubtitle',_sideOf];
			sleep 20;
			deleteVehicle _heliPad1;
			if(_vehType == "B_Heli_Transport_01_F") then {
				_spawnedVeh animateDoor ["Door_L",0,false]; _spawnedVeh animateDoor ["Door_R",0,false];
			};
			if(_vehType == "B_Heli_Transport_03_F") then {
				_spawnedVeh animateDoor ['Door_rear_source',0,false];
			};
			if(_vehType == "O_Heli_Light_02_unarmed_F") then {
				_spawnedVeh animate ["dvere1_posunZ",0]; _spawnedVeh animate ["dvere2_posunZ",0];
			};
			_textLine = selectRandom [
				"Alright, lets get outta here.",
				"Dusting off now. Hold on to something.",
				"And we're off. Fasten your seatbelts.",
				"We're outta here. Hope you guys aren't prone to being motion sick.",
				"Taking off now. Don't fall off now.",
				"We're heading out. And, please, don't touch the rotors blades, we've had... accidents."
			];
			[
				format ["%1 Evac Pilot",_sideName],
				_textLine
			] remoteExec ['BIS_fnc_showSubtitle',_sideOf];
			private _heliPad2 = "Land_HelipadEmpty_F" createVehicle _destination;
			_wayPointMove = _grp addWaypoint [[(getPosATL _heliPad2 select 0),(getPosATL _heliPad2 select 1),(getPosATL _heliPad2 select 2)+40],0];
			_wayPointMove setWaypointType "MOVE";
			sleep 5;
			private _waypointReturn = _grp addWaypoint [position _heliPad2,0];
			_waypointReturn setWaypointType "SCRIPTED";
			_waypointReturn setWaypointScript "A3\functions_f\waypoints\fn_wpLand.sqf";
			waitUntil {isTouchingGround _spawnedVeh && _spawnedVeh distance _heliPad2 < 200};
			if(_vehType == "B_Heli_Transport_01_F") then {
				_spawnedVeh animateDoor ["Door_L",1,false]; _spawnedVeh animateDoor ["Door_R",1,false];
			};
			if(_vehType == "B_Heli_Transport_03_F") then {
				_spawnedVeh animateDoor ['Door_rear_source',1,false];
			};
			if(_vehType == "O_Heli_Light_02_unarmed_F") then {
				_spawnedVeh animate ["dvere1_posunZ",1]; _spawnedVeh animate ["dvere2_posunZ",1];
			};
			_textLine = selectRandom [
				"Hope you enjoyed the ride.",
				"Oh, now that landing was butter!",
				"Thanks for riding with us, if you'd like you can leave us a tip.",
				"And to think this is my first day flying!",
				"Thanks for giving us something to do.",
				"Now get out of my bird."
			];
			[
				format ["%1 Evac Pilot",_sideName],
				_textLine
			] remoteExec ['BIS_fnc_showSubtitle',_sideOf];
			switch (_type) do {
				case "hummingbird": {waitUntil {count crew _spawnedVeh == 2};};
				case "ghosthawk": {waitUntil {count crew _spawnedVeh == 4};};
				case "huron": {waitUntil {count crew _spawnedVeh == 4};};
				case "orca": {waitUntil {count crew _spawnedVeh == 2};};
				case "taru": {waitUntil {count crew _spawnedVeh == 3};};
				case "hellcat": {waitUntil {count crew _spawnedVeh == 2};};
				case "mohawk": {waitUntil {count crew _spawnedVeh == 2};};
			};
			deleteVehicle _heliPad2;
			if(_vehType == "B_Heli_Transport_01_F") then {
				_spawnedVeh animateDoor ["Door_L",0,false]; _spawnedVeh animateDoor ["Door_R",0,false];
			};
			if(_vehType == "B_Heli_Transport_03_F") then {
				_spawnedVeh animateDoor ['Door_rear_source',0,false];
			};
			if(_vehType == "O_Heli_Light_02_unarmed_F") then {
				_spawnedVeh animate ["dvere1_posunZ",0]; _spawnedVeh animate ["dvere2_posunZ",0];
			};
			private _byePos = _spawnedVeh getPos [1500,(getDir _spawnedVeh)];
			private _wayPointLeave = _grp addWaypoint [[(_byePos select 0),(_byePos select 1),60],0];
			_wayPointLeave setWaypointType "MOVE";
			sleep 50;
			{
				deleteVehicle _x;
			} forEach crew _spawnedVeh;
			deleteVehicle _spawnedVeh;
		};