MAZ_EZM_fnc_createVehicleAttributesDialog = {
	params ["_vehicle"];
	if(dialog) then {
		closeDialog 2;
	};
	[_vehicle] spawn {
		params ["_vehicle"];
		sleep 0.1;
		[format ["EDIT %1",toUpper (getText (configFile >> "CfgVehicles" >> typeOf _vehicle >> "displayName"))],[
			[
				"SLIDER",
				"Health/Armor:",
				[[(1 - damage _vehicle),2] call BIS_fnc_cutDecimals,0,1,true]
			],
			[
				"SLIDER",
				"Fuel:",
				[[fuel _vehicle,3] call BIS_fnc_cutDecimals,0,1,true]
			],
			[
				"ICONS",
				"Vehicle Lock:",
				[
					locked _vehicle,
					[0,1,2,3],
					[
						"a3\modules_f\data\iconunlock_ca.paa",
						"a3\modules_f\data\iconunlock_ca.paa",
						"a3\modules_f\data\iconlock_ca.paa",
						"a3\modules_f\data\iconlock_ca.paa"
					],
					[
						"UNLOCKED",
						"DEFAULT",
						"LOCKED",
						"LOCKED FOR PLAYERS"
					],
					[[11,0.5],[15,0.5],[19,0.5],[23,0.5]],
					[1.75,1.75,1.75,1.75],
					2.5
				]
			],
			[
				"ICONS",
				"Engine State:",
				[
					isEngineOn _vehicle,
					[false,true],
					["A3\ui_f\data\igui\cfg\actions\engine_off_ca.paa","A3\ui_f\data\igui\cfg\actions\engine_on_ca.paa"],
					["Turn engine off","Turn engine on"],
					[[15,0.4],[19,0.4]],
					[1.75,1.75],
					2.5
				]
			],
			[
				"ICONS",
				"Lights State:",
				[
					isLightOn _vehicle,
					[false,true],
					["A3\ui_f\data\igui\cfg\actions\ico_cpt_land_off_ca.paa","A3\ui_f\data\igui\cfg\actions\ico_cpt_land_on_ca.paa"],
					["Turn lights off","Turn lights on"],
					[[15,0.4],[19,0.4]],
					[1.75,1.75],
					2.5
				]
			],
			[
				"ICONS",
				"Anti-Collision Lights:",
				[
					isCollisionLightOn _vehicle,
					[false,true],
					["A3\ui_f\data\igui\cfg\actions\ico_cpt_col_off_ca.paa","A3\ui_f\data\igui\cfg\actions\ico_cpt_col_on_ca.paa"],
					["Turn anti-collision lights off","Turn anti-collision lights on"],
					[[15,0.4],[19,0.4]],
					[1.75,1.75],
					2.5
				]
			],
			[
				"RESPAWN",
				["Respawn on Vehicle For:","Makes this vehicle a respawn for the specified side."],
				[
					_vehicle getVariable ["MAZ_EZM_respawnType",4],
					_vehicle
				]
			],
			[ 
				"NEWBUTTON", 
				"DAMAGE", 
				[ 
					"Edit the vehicle's damage in specific hit points.", 
					{
						params ["_display","_args"];
						_display closeDisplay 0;
						[_args] spawn MAZ_EZM_fnc_createDamageDialog;
					}, 
					_vehicle
				] 
			],
			[ 
				"NEWBUTTON", 
				"RESPAWN", 
				[ 
					"Set the vehicle to respawn at it's position.", 
					{
						params ["_display","_args"];
						_display closeDisplay 0;
						[_args] spawn MAZ_EZM_fnc_createVehicleRespawnDialog;
					}, 
					_vehicle
				] 
			]
		],{
			params ["_display","_values","_args"];
			_display closeDisplay 1;
		},{
			params ["_display","_values","_args"];
			[_args,_values] call MAZ_EZM_fnc_applyAttributeChangesToVehicle;
			_display closeDisplay 0;
		},_vehicle] call MAZ_EZM_fnc_createAttributesDialog;
	};
};

MAZ_EZM_fnc_applyDamagesToVehicle = {
	params ["_vehicle","_damagesData"];
	private _damages = getAllHitPointsDamage _vehicle;
	_damages params ["_hitPoints","_sections","_damage"];
	{
		_vehicle setHitPointDamage [(_hitpoints select _forEachIndex),_x];
	}forEach _damagesData;
};

MAZ_EZM_fnc_applyAttributeChangesToVehicle = {
	params ["_vehicle","_attributes"];
	_attributes params [["_health",damage _vehicle],["_fuel",fuel _vehicle],["_lockState",locked _vehicle],["_engineState",isEngineOn _vehicle],["_lightState",isLightOn _vehicle],["_colLightState",isCollisionLightOn _vehicle],"_respawn"];
	_vehicle setDamage (1-_health);
	[_vehicle,_fuel] remoteExec ["setFuel"];
	[_vehicle,_lockState] remoteExec ["lock"];
	[_vehicle,_engineState] remoteExec ["engineOn"];
	[_vehicle,_lightState] remoteExec ["setPilotLight"];
	[_vehicle,_colLightState] remoteExec ["setCollisionLight"];

	[_vehicle,_respawn] call MAZ_EZM_fnc_applyUnitRespawn;
};