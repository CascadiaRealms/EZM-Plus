MAZ_EZM_fnc_createToggleAIDialog = {
	params ["_unit"];
	sleep 0.1;
	[format ["TOGGLE %1 AI",toUpper (getText (configFile >> "CfgVehicles" >> typeOf _unit >> "displayName"))],[
		[
			"TOOLBOX",
			["AIMING ERROR:","Prevents AI's aiming from being distracted by its shooting, moving, turning, reloading, hit, injury, fatigue, suppression or concealed / lost target."],
			[
				_unit checkAIFeature "AIMINGERROR",
				["DISABLE","ENABLE"]
			]
		],
		[
			"TOOLBOX",
			["ANIMATION:","Disables all animations of the unit. Completely freezes the unit, including breathing and blinking. No move command works until the unit is unfrozen."],
			[
				_unit checkAIFeature "ANIM",
				["DISABLE","ENABLE"]
			]
		],
		[
			"TOOLBOX",
			["AUTO-COMBAT:","Disables autonomous switching to 'COMBAT' AI Behaviour when in danger."],
			[
				_unit checkAIFeature "AUTOCOMBAT",
				["DISABLE","ENABLE"]
			]
		],
		[
			"TOOLBOX",
			["AUTO-TARGET:","Essentially makes single units without a group 'deaf'. The unit still goes prone and combat ready if it hears gunfire. \nIt will not turn around when gunfire comes from behind, but if an enemy walks in front of it it will target the enemy and fire as normal."],
			[
				_unit checkAIFeature "AUTOTARGET",
				["DISABLE","ENABLE"]
			]
		],
		[
			"TOOLBOX",
			["COVER:","Disables usage of cover positions by the AI."],
			[
				_unit checkAIFeature "COVER",
				["DISABLE","ENABLE"]
			]
		],
		[
			"TOOLBOX",
			["FSM:","Disables the attached FSM scripts which are responsible for the AI behaviour. \nEnemies react slower to enemy fire and the enemy stops using hand signals."],
			[
				_unit checkAIFeature "FSM",
				["DISABLE","ENABLE"]
			]
		],
		[
			"TOOLBOX",
			["LIGHTS:","Stops AI from operating vehicle headlights and collision lights."],
			[
				_unit checkAIFeature "LIGHTS",
				["DISABLE","ENABLE"]
			]
		],
		[
			"TOOLBOX",
			["MINE DETECTION:","Disable AI's mine detection."],
			[
				_unit checkAIFeature "MINEDETECTION",
				["DISABLE","ENABLE"]
			]
		],
		[
			"TOOLBOX",
			["MOVE:","This will stop units from turning and moving, including vehicles. \nUnits will still change stance and fire at the enemy if the enemy happens to walk right in front of the barrel."],
			[
				_unit checkAIFeature "MOVE",
				["DISABLE","ENABLE"]
			]
		],
		[
			"TOOLBOX",
			["NVG:","Stops AI from putting on NVGs (but not from taking them off)."],
			[
				_unit checkAIFeature "NVG",
				["DISABLE","ENABLE"]
			]
		],
		[
			"TOOLBOX",
			["PATH:","Stops the AI's movement but not the target alignment."],
			[
				_unit checkAIFeature "PATH",
				["DISABLE","ENABLE"]
			]
		],
		[
			"TOOLBOX",
			["RADIO:","Stops AI from talking and texting while still being able to issue orders."],
			[
				_unit checkAIFeature "RADIOPROTOCOL",
				["DISABLE","ENABLE"]
			]
		],
		[
			"TOOLBOX",
			["SUPPRESSION:","Prevents AI from being suppressed."],
			[
				_unit checkAIFeature "SUPPRESSION",
				["DISABLE","ENABLE"]
			]
		],
		[
			"TOOLBOX",
			["TARGET:","Prevents units from engaging targets. Units still move around for cover, but will not hunt down enemies. \nWorks in groups as well."],
			[
				_unit checkAIFeature "TARGET",
				["DISABLE","ENABLE"]
			]
		],
		[
			"TOOLBOX",
			["WEAPON AIM:","Disables weapon aiming."],
			[
				_unit checkAIFeature "WEAPONAIM",
				["DISABLE","ENABLE"]
			]
		]
	],{
		params ["_display","_values","_args"];
		[_args] spawn MAZ_EZM_fnc_createManAttributesDialog;
		_display closeDisplay 1;
	},{
		params ["_display","_values","_args"];
		_display closeDisplay 0;
		[_args,_values] call MAZ_EZM_fnc_applyToggleAI;
	},_unit] call MAZ_EZM_fnc_createAttributesDialog;
};

MAZ_EZM_fnc_applyToggleAI = {
	params ["_unit","_aiData"];
	{
		private _setting = _aiData select _forEachIndex;
		if(_setting) then {
			_unit enableAI _x;
		} else {
			_unit disableAI _x;
		};
	}forEach [
		"AIMINGERROR",
		"ANIM",
		"AUTOCOMBAT",
		"AUTOTARGET",
		"COVER",
		"FSM",
		"LIGHTS",
		"MINEDETECTION",
		"MOVE",
		"NVG",
		"PATH",
		"RADIOPROTOCOL",
		"SUPPRESSION",
		"TARGET",
		"WEAPONAIM"
	];
};