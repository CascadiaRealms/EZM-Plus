if(!isNil "MAZ_EZM_action_teleportHere") then {
	[MAZ_EZM_action_teleportHere] call MAZ_EZM_fnc_removeContextAction;
};
MAZ_EZM_action_teleportHere = [
	"Teleport Here",
	{
		params ["_pos"];
		if(surfaceIsWater _pos) exitWith {
			private _newPos = [true] call MAZ_EZM_fnc_getScreenPosition;
			_newPos = AGLtoASL _newPos;
			player setPosASL _newPos;
		};
		player setPosATL _pos;
	},
	{true},
	5.9,
	"a3\3den\data\cfgwaypoints\move_ca.paa",
	[1,1,1,1],
	[
		[
			"Teleport Player Here",
			{
				params ["_pos","_entity"];
				[objNull,_pos] call MAZ_EZM_fnc_teleportPlayerModule;
			},
			{true},
			3,
			"a3\ui_f\data\gui\rsc\rscdisplaymain\menu_singleplayer_ca.paa",
			[1,1,1,1]
		],
		[
			"Teleport Everyone",
			{
				params ["_pos","_entity"];
				{
					_x setPos _pos;
				}forEach allPlayers;
			},
			{true},
			3,
			"a3\ui_f\data\gui\rsc\rscdisplaymain\menu_multiplayer_ca.paa",
			[1,1,1,1]
		],
		[
			"Teleport In Vehicle",
			{
				params ["_pos","_entity"];
				private _crewData = fullCrew [_entity,"",true];
				private _return = false;
				private _moveInCode = "";
				{
					_x params ["_unit","_role","_cargoIndex","_turretPath","_personTurret"];
					if(_return) exitWith {};
					if(_role != "turret") then {
						if(isNull _unit || !alive _unit) then {
							if(!isNull _unit) then {moveOut _unit};
							_moveInCode = compile (format ["player moveIn%1 _this",_role]);
							_return = true;
						};
					} else {
						if(isNull _unit || !alive _unit) then {
							if(!isNull _unit) then {moveOut _unit};
							_moveInCode = compile (format ["player moveIn%1 [_this,%2]",_role,_turretPath]);
							_return = true;
						};
					};
				}forEach _crewData;
				_entity call _moveInCode;
			},
			{
				private _return = false;
				if(_this isEqualType grpNull) exitWith {_return};
				if(!((typeOf _this) isKindOf "CAManBase") && (alive _this) && !(isNull _this) && ((typeOf _this) isKindOf "AllVehicles") && ([_this] call MAZ_EZM_fnc_canMoveIn)) then {
					_return = true;
				};

				_return
			},
			3,
			"a3\3den\data\cfgwaypoints\getin_ca.paa",
			[1,1,1,1]
		]
	]
] call MAZ_EZM_fnc_createNewContextAction;