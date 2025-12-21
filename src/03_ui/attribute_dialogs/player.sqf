MAZ_EZM_fnc_createPlayerAttributesDialog = {
	params ["_entity"];
	if(dialog) then {
		closeDialog 2;
	};
	[_entity] spawn {
		params ["_entity"];
		sleep 0.1;
		
		[format ["EDIT %1",toUpper (name _entity)],[
			[
				"ICONS",
				"Rank:",
				[
					rank _entity,
					[
						"PRIVATE",
						"CORPORAL",
						"SERGEANT",
						"LIEUTENANT",
						"CAPTAIN",
						"MAJOR",
						"COLONEL"
					],[
						"A3\ui_f\data\GUI\cfg\Ranks\private_gs.paa",
						"A3\ui_f\data\GUI\cfg\Ranks\corporal_gs.paa",
						"A3\ui_f\data\GUI\cfg\Ranks\sergeant_gs.paa",
						"A3\ui_f\data\GUI\cfg\Ranks\lieutenant_gs.paa",
						"A3\ui_f\data\GUI\cfg\Ranks\captain_gs.paa",
						"A3\ui_f\data\GUI\cfg\Ranks\major_gs.paa",
						"A3\ui_f\data\GUI\cfg\Ranks\colonel_gs.paa"
					],[
						"",
						"",
						"",
						"",
						"",
						"",
						""
					],[
						[11,0.5],
						[13,0.5],
						[15,0.5],
						[17,0.5],
						[19,0.5],
						[21,0.5],
						[23,0.5]
					],[
						1.5,1.5,1.5,1.5,1.5,1.5,1.5
					]
				]
			],
			[
				"RESPAWN",
				"Respawn on Player For:",
				[
					_entity getVariable ["MAZ_EZM_respawnType",4],
					_entity
				]
			],
			[ 
				"NEWBUTTON", 
				"HEAL", 
				[ 
					"Heals the player and revives them if possible.", 
					{
						params ["_display","_args"];
						_display closeDisplay 0;
						[_args] spawn MAZ_EZM_fnc_healAndReviveModule;
					}, 
					_entity
				] 
			]
		],{
			params ["_display","_values","_args"];
			_display closeDisplay 1;
		},{
			params ["_display","_values","_args"];
			[_args,_values] call MAZ_EZM_fnc_applyAttributeChangesToPlayer;
			_display closeDisplay 0;
		},_entity] call MAZ_EZM_fnc_createAttributesDialog;
	};
};


MAZ_EZM_fnc_applyAttributeChangesToPlayer = {
	params ["_unit","_values"];
	_values params ["_rank","_respawnType"];
	_unit setRank _rank;
	[_unit,_respawnType] call MAZ_EZM_fnc_applyUnitRespawn;
};