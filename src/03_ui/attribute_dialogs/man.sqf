MAZ_EZM_fnc_createManAttributesDialog = {
	params ["_entity"];
	if(dialog) then {
		closeDialog 2;
	};
	[_entity] spawn {
		params ["_entity"];
		sleep 0.1;

		[format ["EDIT %1",toUpper (getText (configFile >> "CfgVehicles" >> typeOf _entity >> "displayName"))],[
			[
				"EDIT",
				"Name:",
				[name _entity]
			],
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
				"ICONS",
				"Stance:",
				[
					unitPos _entity,
					[
						"DOWN",
						"MIDDLE",
						"UP",
						"AUTO"
					],[
						"A3\3den\Data\Attributes\Stance\down_ca.paa",
						"A3\3den\Data\Attributes\Stance\middle_ca.paa",
						"A3\3den\Data\Attributes\Stance\up_ca.paa",
						"A3\3den\Data\Attributes\default_ca.paa"
					],[
						"",
						"",
						"",
						""
					],[
						[13,0],
						[16,0],
						[19,0],
						[24,0.4]
					],[
						2.5,2.5,2.5,1.5
					]
				]
			],
			[
				"SLIDER",
				"Health/Armor:",
				[[(1 - damage _entity),2] call BIS_fnc_cutDecimals,0,1,true]
			],
			[
				"SLIDER",
				"Skill:",
				[skill _entity,0,1,true]
			],
			[
				"RESPAWN",
				"Respawn on Unit For:",
				[
					_entity getVariable ["MAZ_EZM_respawnType",4],
					_entity
				]
			],
			[ 
				"NEWBUTTON", 
				"ARSENAL", 
				[ 
					"Edit Unit's arsenal loadout.", 
					{
						params ["_display","_args"];
						_display closeDisplay 0;
						["Preload"] call BIS_fnc_arsenal;
						["Open",[true,nil,_args]] call BIS_fnc_arsenal;
					}, 
					_entity
				] 
			],
			[ 
				"NEWBUTTON", 
				"SKILLS", 
				[ 
					"Edit Unit's skills.", 
					{
						params ["_display","_args"];
						_display closeDisplay 0;
						[_args] spawn MAZ_EZM_fnc_createSkillsDialog;
					}, 
					_entity
				] 
			],
			[
				"NEWBUTTON", 
				"EDIT AI", 
				[ 
					"Toggle AI.", 
					{
						params ["_display","_args"];
						_display closeDisplay 0;
						[_args] spawn MAZ_EZM_fnc_createToggleAIDialog;
					}, 
					_entity
				] 
			]
		],{
			params ["_display","_values","_args"];
			_display closeDisplay 1;
		},{
			params ["_display","_values","_args"];
			[_args,_values] call MAZ_EZM_applyAttributeChangesToMan;
			_display closeDisplay 0;
		},_entity] call MAZ_EZM_fnc_createAttributesDialog;
	};
};

MAZ_EZM_fnc_applyUnitRespawn = {
	params ["_unit","_respawn"];
	private _currentRespawn = _unit getVariable ["MAZ_EZM_respawnType",4];
	if(_currentRespawn == _respawn) exitWith {};
	private _respawnInfo = _unit getVariable "MAZ_EZM_respawnPosition";
	if(!isNil "_respawnInfo") then {
		_respawnInfo call BIS_fnc_removeRespawnPosition;
	};
	if(_respawn == 4) exitWith {
		_unit setVariable ["MAZ_EZM_respawnPosition",nil,true];
		_unit setVariable ["MAZ_EZM_respawnType",4,true];
	};
	private _respawnSide = [_respawn] call BIS_fnc_sideType;
	private _respawnName = "";
	if(typeOf _unit isKindOf "CAManBase") then {
		_respawnName = name _unit;
	} else {
		_respawnName = getText (configFile >> "CfgVehicles" >> typeOf _unit >> "displayName")
	};
	private _respawnData = [_respawnSide,_unit,_respawnName] call BIS_fnc_addRespawnPosition;
	_unit setVariable ["MAZ_EZM_respawnPosition",_respawnData,true];
	_unit setVariable ["MAZ_EZM_respawnType",_respawn,true];
};

MAZ_EZM_applyAttributeChangesToMan = {
	params ["_unit","_attributes"];
	_attributes params ["_name","_rank","_stance","_health","_skill","_respawn"];
	[_unit,_name] remoteExec ['setName'];
	[_unit,_rank] remoteExec ["setRank"];
	[_unit,_stance] remoteExec ["setUnitPos"];
	_unit setDamage (1 - _health);
	if(!(_unit getVariable ["MAZ_EZM_doesHaveCustomSkills",false])) then {
		[_unit, _skill] remoteExec ["setSkill"];
	};

	[_unit,_respawn] call MAZ_EZM_fnc_applyUnitRespawn;
};