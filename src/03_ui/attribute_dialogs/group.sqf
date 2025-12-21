MAZ_EZM_fnc_createGroupAttributesDialog = {
	params ["_group"];
	if(dialog) then {
		closeDialog 2;
	};
	[_group] spawn {
		params ["_group"];
		sleep 0.1;
		[format ["EDIT %1",toUpper (groupID _group)],[
			[ 
				"EDIT", 
				"Edit Callsign:", 
				[groupID _group] 
			], 
			[
				"SLIDER",
				"Set Skill:",
				[skill (leader _group),0,1,true]
			],
			[
				"ICONS",
				"Set Formation:",
				[
					formation _group,
					[
						"WEDGE",
						"VEE",
						"LINE",
						"COLUMN",
						"FILE",
						"STAG COLUMN",
						"ECH LEFT",
						"ECH RIGHT",
						"DIAMOND"
					],[
						"A3\ui_f_curator\data\RscCommon\RscAttributeFormation\wedge_ca.paa",
						"A3\ui_f_curator\data\RscCommon\RscAttributeFormation\vee_ca.paa",
						"A3\ui_f_curator\data\RscCommon\RscAttributeFormation\line_ca.paa",
						"A3\ui_f_curator\data\RscCommon\RscAttributeFormation\column_ca.paa",
						"A3\ui_f_curator\data\RscCommon\RscAttributeFormation\file_ca.paa",
						"A3\ui_f_curator\data\RscCommon\RscAttributeFormation\stag_column_ca.paa",
						"A3\ui_f_curator\data\RscCommon\RscAttributeFormation\ech_left_ca.paa",
						"A3\ui_f_curator\data\RscCommon\RscAttributeFormation\ech_right_ca.paa",
						"A3\ui_f_curator\data\RscCommon\RscAttributeFormation\diamond_ca.paa"
					],[
						"WEDGE",
						"VEE",
						"LINE",
						"COLUMN",
						"FILE",
						"STAGGERED COLUMN",
						"ECHELON LEFT",
						"ECHELON RIGHT",
						"DIAMOND"
					],[
						[10,0],
						[13,0],
						[16,0],
						[19,0],
						[22,0],
						[12,2],
						[15,2],
						[18,2],
						[21,2]
					],[
						2.5,
						2.5,
						2.5,
						2.5,
						2.5,
						2.5,
						2.5,
						2.5,
						2.5
					],
					4.5
				]
			],
			[
				"ICONS",
				"Set Behaviour:",
				[
					behaviour (leader _group),
					[
						"CARELESS",
						"SAFE",
						"AWARE",
						"COMBAT",
						"STEALTH"
					],[
						"A3\ui_f_curator\data\RscCommon\RscAttributeBehaviour\safe_ca.paa",
						"A3\ui_f_curator\data\RscCommon\RscAttributeBehaviour\safe_ca.paa",
						"A3\ui_f_curator\data\RscCommon\RscAttributeBehaviour\aware_ca.paa",
						"A3\ui_f_curator\data\RscCommon\RscAttributeBehaviour\combat_ca.paa",
						"A3\ui_f_curator\data\RscCommon\RscAttributeBehaviour\stealth_ca.paa"
					],[
						"CARELESS",
						"SAFE",
						"AWARE",
						"COMBAT",
						"STEALTH"
					],[
						[11,0.3],
						[14,0.3],
						[17,0.3],
						[20,0.3],
						[23,0.3]
					],[
						1.75,1.75,1.75,1.75,1.75
					],
					2.5,
					[
						[[0,1,0,1],[0,0.5,0,0.7]],
						[[0,1,0,1],[0,0.5,0,0.7]],
						[[1,1,0,1],[0.5,0.5,0,0.7]],
						[[1,0,0,1],[0.5,0,0,0.7]],
						[[0,1,1,1],[0,0.5,0.5,0.7]]
					]
				]
			],
			[
				"ICONS",
				"Set Combat Mode:",
				[
					combatMode _group,
					[
						"BLUE",
						"GREEN",
						"WHITE",
						"YELLOW",
						"RED"
					],[
						"A3\ui_f_curator\data\RscCommon\RscAttributeBehaviour\safe_ca.paa",
						"A3\ui_f_curator\data\RscCommon\RscAttributeBehaviour\aware_ca.paa",
						"A3\ui_f_curator\data\RscCommon\RscAttributeBehaviour\aware_ca.paa",
						"A3\ui_f_curator\data\RscCommon\RscAttributeBehaviour\combat_ca.paa",
						"A3\ui_f_curator\data\RscCommon\RscAttributeBehaviour\combat_ca.paa"
					],[
						"Forced Hold Fire",
						"Do Not Fire Unless Fired Upon, Keep Formation",
						"Do Not Fire Unless Fired Upon",
						"Open Fire, Keep Formation",
						"Open Fire"
					],[
						[11,0.3],
						[14,0.3],
						[17,0.3],
						[20,0.3],
						[23,0.3]
					],[
						1.75,1.75,1.75,1.75,1.75
					],
					2.5,
					[
						[[0,1,0,1],[0,0.5,0,0.7]],
						[[1,1,0,1],[0.5,0.5,0,0.7]],
						[[1,1,0,1],[0.5,0.5,0,0.7]],
						[[1,0,0,1],[0.5,0,0,0.7]],
						[[1,0,0,1],[0.5,0,0,0.7]]
					]
				]
			],
			[
				"ICONS",
				"Set Speed:",
				[
					speedMode _group,
					[
						"LIMITED",
						"NORMAL",
						"FULL"
					],[
						"A3\ui_f_curator\data\RscCommon\RscAttributeSpeedMode\limited_ca.paa",
						"A3\ui_f_curator\data\RscCommon\RscAttributeSpeedMode\normal_ca.paa",
						"A3\ui_f_curator\data\RscCommon\RscAttributeSpeedMode\full_ca.paa"
					],[
						"",
						"",
						""
					],[
						[13,0],
						[16,0],
						[19,0]
					],[
						2.5,2.5,2.5
					],
					2.5
				]
			],
			[
				"ICONS",
				"Set Stance:",
				[
					unitPos (leader _group),
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
						"AUTO"
					],[
						[13,0],
						[16,0],
						[19,0],
						[24,0.4]
					],[
						2.5,2.5,2.5,1.5
					]
				]
			]
		],{
			params ["_display","_values","_args"];
			_display closeDisplay 1;
		},{
			params ["_display","_values","_args"];
			[_args,_values] call MAZ_EZM_fnc_applyAttributeChangesToGroup;
			_display closeDisplay 0;
		},_group] call MAZ_EZM_fnc_createAttributesDialog;
	};
};

MAZ_EZM_fnc_applyAttributeChangesToGroup = {
	params ["_group","_attributes"];
	_attributes params ["_name","_skill","_form","_beh","_comMode","_sped","_stance"];
	_group setGroupIdGlobal [_name];
	[_group,_form] remoteExec ["setFormation"];
	[_group,_beh] remoteExec ["setBehaviour"];
	[_group,_comMode] remoteExec ["setCombatMode"];
	[_group,_sped] remoteExec ["setSpeedMode"];
	{
		[_x,_skill] remoteExec ["setSkill"];
		[_x,_stance] remoteExec ["setUnitPos"];
	}forEach (units _group);
};