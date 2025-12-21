if(!isNil "MAZ_EZM_action_repairVehicle") then {
	[MAZ_EZM_action_repairVehicle] call MAZ_EZM_fnc_removeContextAction;
};
MAZ_EZM_action_repairVehicle = [
	"Repair",
	{
		params ["_pos","_entity"];
		_entity setDamage 0;
	},
	{
		private _return = false;
		if(_this isEqualType grpNull) exitWith {_return};
		if(!(typeOf _this isKindOf "CAManBase") && alive _this && !isNull _this && typeOf _this isKindOf "AllVehicles") then {
			_return = true;
		};

		_return
	},
	2,
	"a3\ui_f\data\igui\cfg\cursors\iconrepairvehicle_ca.paa",
	[1,1,1,1]
] call MAZ_EZM_fnc_createNewContextAction;

if(!isNil "MAZ_EZM_action_refuelVehicle") then {
	[MAZ_EZM_action_refuelVehicle] call MAZ_EZM_fnc_removeContextAction;
};
MAZ_EZM_action_refuelVehicle = [
	"Refuel",
	{
		params ["_pos","_entity"];
		[_entity,1] remoteExec ['setFuel'];
	},
	{
		private _return = false;
		if(_this isEqualType grpNull) exitWith {_return};
		if(!(typeOf _this isKindOf "CAManBase") && alive _this && !isNull _this && typeOf _this isKindOf "AllVehicles") then {
			_return = true;
		};

		_return
	},
	2,
	"a3\ui_f\data\igui\cfg\actions\refuel_ca.paa",
	[1,1,1,1]
] call MAZ_EZM_fnc_createNewContextAction;

if(!isNil "MAZ_EZM_action_rearmVehicle") then {
	[MAZ_EZM_action_rearmVehicle] call MAZ_EZM_fnc_removeContextAction;
};
MAZ_EZM_action_rearmVehicle = [
	"Rearm",
	{
		params ["_pos","_entity"];
		[_entity,1] remoteExec ['setVehicleAmmo'];
	},
	{
		private _return = false;
		if(_this isEqualType grpNull) exitWith {_return};
		if(!(typeOf _this isKindOf "CAManBase") && alive _this && !isNull _this && typeOf _this isKindOf "AllVehicles") then {
			_return = true;
		};

		_return
	},
	2,
	"a3\ui_f\data\igui\cfg\simpletasks\types\rearm_ca.paa",
	[1,1,1,1]
] call MAZ_EZM_fnc_createNewContextAction;

if(!isNil "MAZ_EZM_action_editPylons") then {
	[MAZ_EZM_action_editPylons] call MAZ_EZM_fnc_removeContextAction;
};
MAZ_EZM_action_editPylons = [
	"Edit Pylons",
	{
		params ["_pos","_entity"];
		[_entity] spawn MAZ_EZM_fnc_editVehiclePylons;
	},
	{
		private _return = false;
		if(_this isEqualType grpNull) exitWith {_return};
		private _pylons = (configFile >> "CfgVehicles" >> typeOf _this >> "Components" >> "TransportPylonsComponent" >> "Pylons") call BIS_fnc_getCfgSubClasses; 
		if(count _pylons == 0) exitWith {false}; 
		true
	},
	1,
	"a3\ui_f\data\igui\cfg\actions\gear_ca.paa",
	[1,1,1,1],
	[
		[
			"Change Pylons",
			{
				params ["_pos","_entity"];
				[_entity] spawn MAZ_EZM_fnc_editVehiclePylons;
			},
			{true},
			3,
			"",
			[1,1,1,1]
		],
		[
			"Reset Pylons",
			{
				params ["_pos","_entity"];
				private _pylons = (configFile >> "CfgVehicles" >> typeOf _entity >> "Components" >> "TransportPylonsComponent" >> "Pylons") call BIS_fnc_getCfgSubClasses;
				{
					private _pylon = _x;
					private _pylonDefaultMag = getText (configfile >> "CfgVehicles" >> typeOf _entity >> "Components" >> "TransportPylonsComponent" >> "Pylons" >> _pylon >> "attachment");
					private _pylonMaxAmmo = getNumber (configFile >> "CfgMagazines" >> _pylonDefaultMag >> "count");
					_entity setPylonLoadout [_pylon,_pylonDefaultMag];
					_entity setAmmoOnPylon [_pylon,_pylonMaxAmmo];
				}forEach _pylons;
			},
			{true},
			3,
			"",
			[1,1,1,1]
		]
	]
] call MAZ_EZM_fnc_createNewContextAction;

if(!isNil "MAZ_EZM_action_garageEdit") then {
	[MAZ_EZM_action_garageEdit] call MAZ_EZM_fnc_removeContextAction;
};
MAZ_EZM_action_garageEdit = [
	"Edit Appearance",
	{
		params ["_pos","_entity"];
		[_entity] spawn MAZ_EZM_fnc_createGarageInterface;
	},
	{
		private _return = false;
		if(_this isEqualType grpNull) exitWith {_return};
		if(typeOf _entity isKindOf "AllVehicles" && !(typeOf _entity isKindOf "Animal") && !(typeOf _entity isKindOf "CAManBase")) then {_return = true};
		_return
	},
	1,
	"a3\ui_f\data\gui\rsc\rscdisplayarsenal\spacegarage_ca.paa",
	[1,1,1,1]
] call MAZ_EZM_fnc_createNewContextAction;
