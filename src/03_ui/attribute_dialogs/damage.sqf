MAZ_EZM_fnc_createDamageDialog = {
	params ["_vehicle"];
	private _damages = getAllHitPointsDamage _vehicle;
	_damages params ["_hitPoints","_sections","_damage"];
	private _dialogData = [];
	{
		_dialogData pushBack [
			"SLIDER",
			_x,
			[[_damage select _forEachIndex,2] call BIS_fnc_cutDecimals,0,1,true]
		];
	}forEach _hitPoints;

	[format ["EDIT DAMAGE %1",toUpper (getText (configFile >> "CfgVehicles" >> typeOf _vehicle >> "displayName"))],
	_dialogData,
	{
		params ["_display","_values","_args"];
		if(typeOf _args isKindOf "LandVehicle") then {
			[_args] spawn MAZ_EZM_fnc_createLandVehicleAttributesDialog;
		} else {
			[_args] spawn MAZ_EZM_fnc_createVehicleAttributesDialog;
		};
		_display closeDisplay 1;
	},{
		params ["_display","_values","_args"];
		_display closeDisplay 0;
		[_args,_values] call MAZ_EZM_fnc_applyDamagesToVehicle;
	},_vehicle,25] call MAZ_EZM_fnc_createAttributesDialog;
};