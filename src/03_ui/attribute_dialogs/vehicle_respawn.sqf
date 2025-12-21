MAZ_EZM_fnc_createVehicleRespawnDialog = {
	params ["_vehicle"];
	[format ["CREATE RESPAWNING %1",toUpper (getText (configFile >> "CfgVehicles" >> typeOf _vehicle >> "displayName"))],[
		[
			"SLIDER",
			"Respawn Delay:",
			[15,10,60,false]
		],
		[
			"SLIDER",
			["Deserted Delay:","How long it takes to respawn when abandoned (no crew)."],
			[600,600,1800,false]
		],
		[
			"SLIDER",
			["Number of Respawns:","How many times the vehicle can respawn (-1 is infinite)."],
			[-1,-1,30,false]
		],
		[
			"SLIDER",
			["Dist from Players Deserted:","How far players must be before the vehicle can be considered abandonded."],
			[3000,3000,12000,false]
		]
	],{
		params ["_display","_values","_args"];
		if(typeOf _args isKindOf "LandVehicle") then {
			[_args] spawn MAZ_EZM_fnc_createLandVehicleAttributesDialog;
		} else {
			[_args] spawn MAZ_EZM_fnc_createVehicleAttributesDialog;
		};
		_display closeDisplay 1;
	},{
		params ["_display","_values","_args"];
		[_args,_values] call MAZ_EZM_fnc_createVehicleRespawn;
		_display closeDisplay 0;
	},_vehicle] call MAZ_EZM_fnc_createAttributesDialog;
};


MAZ_EZM_fnc_createVehicleRespawn = {
	params ["_vehicle","_values"];
	_values params ["_respawnDelay","_abandonDelay","_numOfRespawns","_distAbandon"];
	private _logic = (createGroup [sideLogic,true]) createUnit ["ModuleRespawnVehicle_F",position _vehicle, [], 0, "NONE"];
	_logic setVariable ["Delay",str (round _respawnDelay),true];
	_logic setVariable ["DesertedDelay",str (round _abandonDelay),true];
	_logic setVariable ["DesertedDistance",str (round _distAbandon),true];
	_logic setVariable ["RespawnCount",str (round _numOfRespawns),true];
	_logic setVariable ["Position","0",true];
	_logic setVariable ["PositionType","0",true];
	_logic setVariable ["Wreck","1",true];
	_logic setVariable ["ShowNotification","1",true];
	_logic setVariable ["ForcedRespawn","0",true];
	_logic setVariable ["RespawnWhenDisabled",true,true];
	_logic synchronizeObjectsAdd [_vehicle];
	[[_logic],{
			params ["_logic"];
			sleep 0.1;
			[_logic,[],true] call BIS_fnc_moduleRespawnVehicle;
	[_vehicle,round _respawnDelay,round _abandonDelay,round _numOfRespawns,{},0,2,1,true,true,round _distAbandon,true] call BIS_fnc_moduleRespawnVehicle;
	}] remoteExec ['spawn',2];
};