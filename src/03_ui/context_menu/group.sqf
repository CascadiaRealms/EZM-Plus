if(!isNil "MAZ_EZM_action_garrison") then {
	[MAZ_EZM_action_garrison] call MAZ_EZM_fnc_removeContextAction;
};
MAZ_EZM_action_garrison = [
	"Garrison",
	{
		params ["_pos","_entity"];
		[leader _entity] call MAZ_EZM_fnc_garrisonInstantModule;
	},
	{
		if(_this isEqualType grpNull) exitWith {true};
		false
	},
	1,
	'\A3\ui_f\data\IGUI\Cfg\simpleTasks\types\run_ca.paa',
	[1,1,1,1],
	[
		[
			"Garrison (Instant)",
			{
				params ["_pos","_entity"];
				[leader _entity] call MAZ_EZM_fnc_garrisonInstantModule;
			},
			{true},
			3,
			"",
			[1,1,1,1]
		],
		[
			"Garrison (Search)",
			{
				params ["_pos","_entity"];
				[leader _entity] call MAZ_EZM_fnc_garrisonSearchModule;
			},
			{true},
			3,
			"",
			[1,1,1,1]
		],
		[
			"Un-Garrison",
			{
				params ["_pos","_entity"];
				[leader _entity] call MAZ_EZM_fnc_unGarrisonModule;
			},
			{true},
			3,
			"",
			[1,1,1,1]
		]
	]
] call MAZ_EZM_fnc_createNewContextAction;

if(!isNil "MAZ_EZM_action_changeSideGroup") then {
	[MAZ_EZM_action_changeSideGroup] call MAZ_EZM_fnc_removeContextAction;
};
MAZ_EZM_action_changeSideGroup = [
	"Change Group Side",
	{
		
	},
	{
		if(_this isEqualType grpNull) exitWith {true};
		false
	},
	3,
	"a3\ui_f_curator\data\displays\rscdisplaycurator\side_unknown_ca.paa",
	[1,1,1,1],
	[
		[
			"BLUFOR",
			{
				params ["_pos","_entity"];
				private _group = createGroup [west,true];
				private _leader = leader _entity;
				(units _entity) joinSilent _group;
			},
			{true},
			3,
			"a3\3den\data\displays\display3den\panelright\side_west_ca.paa",
			[1,1,1,1]
		],
		[
			"OPFOR",
			{
				params ["_pos","_entity"];
				private _group = createGroup [east,true];
				private _leader = leader _entity;
				(units _entity) joinSilent _group;
			},
			{true},
			3,
			"a3\3den\data\displays\display3den\panelright\side_east_ca.paa",
			[1,1,1,1]
		],
		[
			"INDFOR",
			{
				params ["_pos","_entity"];
				private _group = createGroup [independent,true];
				private _leader = leader _entity;
				(units _entity) joinSilent _group;
			},
			{true},
			3,
			"a3\3den\data\displays\display3den\panelright\side_guer_ca.paa",
			[1,1,1,1]
		],
		[
			"CIVILIAN",
			{
				params ["_pos","_entity"];
				private _group = createGroup [civilian,true];
				private _leader = leader _entity;
				(units _entity) joinSilent _group;
			},
			{true},
			3,
			"a3\3den\data\displays\display3den\panelright\side_civ_ca.paa",
			[1,1,1,1]
		]
	]
] call MAZ_EZM_fnc_createNewContextAction;

MAZ_EZM_fnc_canMoveIn = {
params ["_vehicle"];
private _crewData = fullCrew [_vehicle,"",true];
private _return = false;
{
	_x params ["_unit","_role","_cargoIndex","_turretPath","_personTurret"];
	if(_return) exitWith {};
	if(isNull _unit || !alive _unit) then {
		_return = true;
	};
}forEach _crewData;
_return
};