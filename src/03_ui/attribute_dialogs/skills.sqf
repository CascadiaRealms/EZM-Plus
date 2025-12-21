MAZ_EZM_fnc_createSkillsDialog = {
	params ["_unit"];
	sleep 0.1;
	[format ["EDIT SKILLS %1",toUpper (getText (configFile >> "CfgVehicles" >> typeOf _unit >> "displayName"))],[
		[
			"SLIDER",
			"Accuracy:",
			[[(_unit skill "aimingAccuracy"),2] call BIS_fnc_cutDecimals,0,1,true]
		],
		[
			"SLIDER",
			"Aim Shake:",
			[[(_unit skill "aimingShake"),2] call BIS_fnc_cutDecimals,0,1,true]
		],
		[
			"SLIDER",
			"Aiming Speed:",
			[[(_unit skill "aimingSpeed"),2] call BIS_fnc_cutDecimals,0,1,true]
		],
		[
			"SLIDER",
			"Endurance:",
			[[(_unit skill "endurance"),2] call BIS_fnc_cutDecimals,0,1,true]
		],
		[
			"SLIDER",
			"Spotting Distance:",
			[[(_unit skill "spotDistance"),2] call BIS_fnc_cutDecimals,0,1,true]
		],
		[
			"SLIDER",
			"Spotting Time:",
			[[(_unit skill "spotTime"),2] call BIS_fnc_cutDecimals,0,1,true]
		],
		[
			"SLIDER",
			"Courage:",
			[[(_unit skill "courage"),2] call BIS_fnc_cutDecimals,0,1,true]
		],
		[
			"SLIDER",
			"Reload Speed:",
			[[(_unit skill "reloadSpeed"),2] call BIS_fnc_cutDecimals,0,1,true]
		],
		[
			"SLIDER",
			"Commanding:",
			[[(_unit skill "commanding"),2] call BIS_fnc_cutDecimals,0,1,true]
		],
		[
			"SLIDER",
			"General Skill:",
			[[(_unit skill "general"),2] call BIS_fnc_cutDecimals,0,1,true]
		]
	],{
		params ["_display","_values","_args"];
		[_args] spawn MAZ_EZM_fnc_createManAttributesDialog;
		_display closeDisplay 1;
	},{
		params ["_display","_values","_args"];
		_display closeDisplay 0;
		[_args,_values] call MAZ_EZM_fnc_applySkillsToUnit;
	},_unit] call MAZ_EZM_fnc_createAttributesDialog;
};

MAZ_EZM_fnc_applySkillsToUnit = {
	params ["_unit","_skillsData"];
	{
		_unit setSkill [_x,_skillsData select _forEachIndex];
	}forEach ["aimingAccuracy","aimingShake","aimingSpeed","endurance","spotDistance","spotTime","courage","reloadSpeed","commanding","general"];
	_unit setVariable ["MAZ_EZM_doesHaveCustomSkills",true,true];
};
