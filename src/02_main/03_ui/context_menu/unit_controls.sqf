if(!isNil "MAZ_EZM_action_remoteControl") then {
	[MAZ_EZM_action_remoteControl] call MAZ_EZM_fnc_removeContextAction;
};
MAZ_EZM_action_remoteControl = [
	"Remote Control",
	{
		params ["_pos","_entity"];
		private _logic = createVehicle ["Land_HelipadEmpty_F",[0,0,0],[],0,"CAN_COLLIDE"];
		[_logic,_entity,true] spawn MAZ_EZM_BIS_fnc_remoteControlUnit;
	},
	{
		private _return = false;
		if(_this isEqualType grpNull) exitWith {_return};
		if(typeOf _this isKindOf "CAManBase" && alive _this && !isNull _this && !(isPlayer _this)) then {
			_return = true;
		};

		_return
	},
	5,
	"\a3\Modules_F_Curator\Data\portraitRemoteControl_ca.paa",
	[1,1,1,1]
] call MAZ_EZM_fnc_createNewContextAction;

if(!isNil "MAZ_EZM_action_suppressiveFire") then {
	[MAZ_EZM_action_suppressiveFire] call MAZ_EZM_fnc_removeContextAction;
};
MAZ_EZM_action_suppressiveFire = [
	"Suppressive Fire",
	{
		params ["_pos","_entity"];
		[_entity] spawn MAZ_EZM_fnc_suppressiveFireModule;
	},
	{
		private _return = false;
		if(_this isEqualType grpNull) exitWith {_return};
		if(typeOf _this isKindOf "CAManBase" && alive _this && !isNull _this && !(isPlayer _this)) then {
			_return = true;
		};

		_return
	},
	5,
	"a3\static_f_oldman\hmg_02\data\ui\icon_hmg_02_ca.paa",
	[1,1,1,1]
] call MAZ_EZM_fnc_createNewContextAction;

if(!isNil "MAZ_EZM_action_editLoadout") then {
	[MAZ_EZM_action_editLoadout] call MAZ_EZM_fnc_removeContextAction;
};
MAZ_EZM_action_editLoadout = [
	"Edit Loadout",
	{
		params ["_pos","_entity"];
		["Preload"] call BIS_fnc_arsenal;
		["Open",[true,nil,_entity]] call BIS_fnc_arsenal;
	},
	{
		private _return = false;
		if(_this isEqualType grpNull) exitWith {_return};
		if(player == _this) exitWith {!_return};
		if(typeOf _this isKindOf "CAManBase" && alive _this && !isNull _this && !(isPlayer _this)) then {
			_return = true;
		};

		_return
	},
	4,
	"a3\ui_f\data\igui\cfg\actions\gear_ca.paa",
	[1,1,1,1],
	[
		[
			"Change Loadout",
			{
				params ["_pos","_entity"];
				["Preload"] call BIS_fnc_arsenal;
				["Open",[true,nil,_entity]] call BIS_fnc_arsenal;
			},
			{true},
			3,
			"",
			[1,1,1,1]
		],
		[
			"Reset Loadout",
			{
				params ["_pos","_entity"];
				_entity setUnitLoadout (getUnitLoadout (configFile >> "CfgVehicles" >> typeOf _entity));
			},
			{true},
			3,
			"",
			[1,1,1,1]
		],
		[
			"Copy Loadout",
			{
				params ["_pos","_entity"];
				MAZ_EZM_copiedUnitLoadout = getUnitLoadout _entity;
			},
			{true},
			3,
			"",
			[1,1,1,1]
		],
		[
			"Paste Loadout",
			{
				params ["_pos","_entity"];
				_entity setUnitLoadout MAZ_EZM_copiedUnitLoadout;
			},
			{
				(!isNil "MAZ_EZM_copiedUnitLoadout")
			},
			3,
			"",
			[1,1,1,1]
		],
		[
			"Set Zeus Loadout",
			{
				params ["_pos","_entity"];
				profileNamespace setVariable ["MAZ_EZM_ZeusLoadout",getUnitLoadout _entity];
				["Zeus loadout saved","addItemOK"] call MAZ_EZM_fnc_systemMessage;
			},
			{true},
			3,
			"a3\ui_f_curator\data\logos\arma3_zeus_icon_ca.paa",
			[1,1,1,1]
		]
	]
] call MAZ_EZM_fnc_createNewContextAction;

if(!isNil "MAZ_EZM_action_healUnit") then {
	[MAZ_EZM_action_healUnit] call MAZ_EZM_fnc_removeContextAction;
};
MAZ_EZM_action_healUnit = [
	"Heal Unit",
	{
		params ["_pos","_entity"];
		[_entity] call MAZ_EZM_fnc_healAndReviveModule;
	},
	{
		private _return = false;
		if(_this isEqualType grpNull) exitWith {_return};
		if(typeOf _this isKindOf "CAManBase" && alive _this && !isNull _this) then {
			_return = true;
		};

		_return
	},
	3,
	"a3\ui_f\data\map\vehicleicons\pictureheal_ca.paa",
	[1,1,1,1]
] call MAZ_EZM_fnc_createNewContextAction;

if(!isNil "MAZ_EZM_action_changeSide") then {
	[MAZ_EZM_action_changeSide] call MAZ_EZM_fnc_removeContextAction;
};
MAZ_EZM_action_changeSide = [
	"Change Unit Side",
	{
		
	},
	{
		private _return = false;
		if(_this isEqualType grpNull) exitWith {_return};
		if(typeOf _this isKindOf "CAManBase" && alive _this && !isNull _this) then {
			_return = true;
		};

		_return
	},
	3,
	"a3\ui_f_curator\data\displays\rscdisplaycurator\side_unknown_ca.paa",
	[1,1,1,1],
	[
		[
			"BLUFOR",
			{
				params ["_pos","_entity"];
				[_entity] joinSilent (createGroup [west,true]);
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
				[_entity] joinSilent (createGroup [east,true]);
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
				[_entity] joinSilent (createGroup [independent,true]);
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
				[_entity] joinSilent (createGroup [civilian,true]);
			},
			{true},
			3,
			"a3\3den\data\displays\display3den\panelright\side_civ_ca.paa",
			[1,1,1,1]
		]
	]
] call MAZ_EZM_fnc_createNewContextAction;
