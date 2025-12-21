MAZ_EZM_fnc_airDropSupportModule = {
			params ["_pos","_mode","_aioArsenal","_direction","_vehType","_sideOf","_sfx"];
			private ["_typeMode","_dropType","_dropLoad","_dir","_vehPos","_doorAnim"];
			private _typeMode = _mode select 0; _dropType = nil; if(count _mode == 2) then {_dropType = _mode select 1;};
			_typeMode = toLower _typeMode; if(count _mode == 2) then {_dropType = toLower _dropType;}; _vehType = toLower _vehType;
			private _grp = createGroup [_sideOf,true];
			switch (_typeMode) do {
				case "arsenal": {_dropLoad = 'B_CargoNet_01_ammo_F';};
				case "vehicle": {_dropLoad = _dropType;};
			};

			switch (_vehType) do {
				case "blackfish": {_vehType = 'B_T_VTOL_01_vehicle_F'; _doorAnim = 'Door_1_source';};
				case "huron": {_vehType = 'B_Heli_Transport_03_F'; _doorAnim = 'Door_rear_source';};
				case "xian": {_vehType = 'O_T_VTOL_02_vehicle_F'; _doorAnim = 'Door_1_source';};
				case "mohawk": {_vehType = 'I_Heli_Transport_02_F'; _doorAnim = 'CargoRamp_Open';};
			};

			switch (_direction) do {
				case "NW": {_dir = 135; _vehPos = _pos getPos [3500,315];};
				case "N": {_dir = 180; _vehPos = _pos getPos [3500,0];};
				case "NE": {_dir = 225; _vehPos = _pos getPos [3500,45];};
				case "E": {_dir = 270; _vehPos = _pos getPos [3500,90];};
				case "SE": {_dir = 315; _vehPos = _pos getPos [3500,135];};
				case "S": {_dir = 0; _vehPos = _pos getPos [3500,180];};
				case "SW": {_dir = 45; _vehPos = _pos getPos [3500,225];};
				case "W": {_dir = 90; _vehPos = _pos getPos [3500,270];};
			};

			private _result = [[_vehPos select 0,_vehPos select 1,(_pos select 2) + 300],_dir,_vehType,_grp] call BIS_fnc_spawnVehicle;
			private _spawnedVeh = _result select 0;

			waitUntil {!isNull driver _spawnedVeh};
			_spawnedVeh flyInHeight 250;
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
					format ["%1 Airdrop Pilot",_sideName],
					_textLine
				] remoteExec ['BIS_fnc_showSubtitle',_sideOf];
				{
					deleteVehicle _x;
				}forEach (crew _unit);
			}];
			_grp setBehaviour "CARELESS";

			_spawnedVeh animateDoor [_doorAnim,1,true];
			private _textLine = selectRandom [
				"We're inbound with your supplies.",
				"Supplies are inbound, wait one.",
				"We're on our way with your supplies.",
				"Your package is being shipped."
			];
			private _sideName = [_sideOf] call BIS_fnc_sideName;
			[
				format ["%1 Airdrop Pilot",_sideName],
				_textLine
			] remoteExec ['BIS_fnc_showSubtitle',_sideOf];
			if(_sfx) then {
				private _radioChatter = selectRandom ["RadioAmbient2","RadioAmbient6","RadioAmbient8"];
				[[_radioChatter],{
					params ['_radioChatter'];
					switch (_radioChatter) do {
						case "RadioAmbient2": {playSound _radioChatter;};
						case "RadioAmbient6": {playSound _radioChatter; sleep 6; playSound "RadioAmbient2";};
						case "RadioAmbient8": {playSound _radioChatter;};
					};
				}] remoteExec ['spawn',0];
			};

			private _wayPointMove = _grp addWaypoint [[(_pos select 0),(_pos select 1),300],0];
			_wayPointMove setWaypointType "MOVE";
			private _nextWaypointPos = _pos getPos [6000,_dir];
			private _wayPointLeave = _grp addWaypoint [[(_nextWaypointPos select 0),(_nextWaypointPos select 1),300],0];
			_wayPointLeave setWaypointType "MOVE";

			waitUntil {(_spawnedVeh distance2D _pos) < 150};
			if(!alive _spawnedVeh) exitWith {
				sleep 120;
				deleteVehicle _spawnedVeh;
			};
			sleep 1.5;
			_textLine = selectRandom [
				"Supplies have been dropped.",
				"Supplies are coming down.",
				"Your supplies are on their way down.",
				"Watch out above! Your supplies are coming down."
			];
			[
				format ["%1 Airdrop Pilot",_sideName],
				_textLine
			] remoteExec ['BIS_fnc_showSubtitle',_sideOf];
			if(_sfx) then {
				_radioChatter = selectRandom ["RadioAmbient2","RadioAmbient6","RadioAmbient8"];
				[[_radioChatter],{
					params ['_radioChatter'];
					switch (_radioChatter) do {
						case "RadioAmbient2": {playSound _radioChatter;};
						case "RadioAmbient6": {playSound _radioChatter; sleep 6; playSound "RadioAmbient2";};
						case "RadioAmbient8": {playSound _radioChatter;};
					};
				}] remoteExec ['spawn',0];
			};

			private _dropPos = position _spawnedVeh getPos [10,getDir _spawnedVeh+180];
			private _para = createVehicle ["B_Parachute_02_F", [0,0,300], [], 0, ""];
			_para setPosATL [(_dropPos select 0),(_dropPos select 1),(getPosATL _spawnedVeh select 2)];
			private _veh = createVehicle [_dropLoad, [0,0,80], [], 0, ""];
			_veh attachTo [_para,[0,0,0]]; 

			WaitUntil {((((position _veh) select 2) < 0.6) || (isNil "_para"))};
			detach _veh;
			_veh SetVelocity [0,0,-5];           
			sleep 0.3;
			_veh setPos [(position _veh) select 0, (position _veh) select 1, 0.6];
			private _smoke = "SmokeShellRed" createVehicle position _veh;
			_smoke attachTo [_veh,[0,0,0]];
			private _light = "Chemlight_green" createVehicle position _veh;
			_light attachTo [_veh,[0,0,0]];
			detach _smoke;
			detach _light;
			if(_mode select 0 == 'arsenal') then {
				if(_aioArsenal) then {
					[_veh,nil,true,false,false] call JAM_EZM_fnc_createAIOArsenalModule;
				} else {
					["AmmoboxInit",[_veh,true]] spawn BIS_fnc_arsenal;
				};
			};
			if(_vehType == 'B_Heli_Transport_03_F') then {
				sleep 20;
				{
					deleteVehicle _x;
				} forEach crew _spawnedVeh;
				deleteVehicle _spawnedVeh;
			} else {

				{
					deleteVehicle _x;
				} forEach crew _spawnedVeh;
				deleteVehicle _spawnedVeh;
			};
		};