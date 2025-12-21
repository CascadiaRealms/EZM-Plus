comment "EZM Eventhandlers";
MAZ_EZM_fnc_addEZMEventHandler = {
	params ["_type","_code"];
	private _var = format ["EZM_%1",_type];
	private _index = switch (toLower _type) do {
		case "onzeusinterfaceopened";
		case "onzeusinterfaceclosed";
		case "onvehiclecreated";
		case "onmancreated": {
			[missionNamespace, _var, _code] call BIS_fnc_addScriptedEventHandler;
		};
		default {-1};
	};
	_index
};

MAZ_EZM_fnc_removeEZMEventHandler = {
	params ["_type","_index"];
	private _var = format ["EZM_%1",_type];
	switch (toLower _type) do {
		case "onzeusinterfaceopened";
		case "onzeusinterfaceclosed";
		case "onvehiclecreated";
		case "onmancreated": {
			[missionNamespace,_var,_index] call BIS_fnc_removeScriptedEventHandler;
			true;
		};
		default {false};
	};
};

MAZ_EZM_EH_VehCreated_Dismount = ["onVehicleCreated", {
	params ["_vehicle"];
	_vehicle allowCrewInImmobile true;
}] call MAZ_EZM_fnc_addEZMEventHandler;