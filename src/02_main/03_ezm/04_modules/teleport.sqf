MAZ_EZM_fnc_teleportSelfModule = {
			private _pos = [true] call MAZ_EZM_fnc_getScreenPosition;
			if(surfaceIsWater _pos) then {
				_pos = AGLtoASL _pos;
				player setPosASL _pos;
			} else {
				player setPosATL _pos;
			};

			["Teleported.","addItemOk"] call MAZ_EZM_fnc_systemMessage;
		};

		MAZ_EZM_fnc_teleportAllPlayersModule = {
			private _pos = [true] call MAZ_EZM_fnc_getScreenPosition;
			if(surfaceIsWater _pos) then {
				_pos = AGLtoASL _pos;
				{
					_x setPosASL _pos;
				}forEach allPlayers;
			} else {
				{
					_x setPosATL _pos;
				}forEach allPlayers;
			};

			["All players teleported.","addItemOk"] call MAZ_EZM_fnc_systemMessage;
		};

		MAZ_EZM_fnc_teleportPlayerModule = {
			params ["_entity",["_pos",nil]];
			if(isNil "_pos") then {
				_pos = [true] call MAZ_EZM_fnc_getScreenPosition;
			};
			["Teleport Player",[
				[
					"LIST",
					"Player to Teleport",
					[
						[],
						(allPlayers apply {name _x}),
						0
					]
				]
			],{
				params ["_values","_args","_display"];
				private _value = _values # 0;
				private _unit = (allPlayers select (parseNumber _value));
				if(surfaceIsWater _args) then {
					_args = AGLtoASL _args;
					_unit setPosASL _args;
				} else {
					_unit setPosATL _args;
				};
				_display closeDisplay 1;
			},{
				params ["_values","_args","_display"];
				_display closeDisplay 2;
			},_pos] call MAZ_EZM_fnc_createDialog;
		};

		MAZ_EZM_fnc_teleportSideModule = {
			["Teleport Side",[
				[
					"SIDES",
					"Side to teleport:",
					[west]
				]
			],{
				params ["_values","_args","_display"];
				_values = _values # 0;
				private _allPlayers = allPlayers select {side (group _x) in _values};

				if(surfaceIsWater _args) then {
					_args = AGLtoASL _args;
					{
						_x setPosASL _args;
					}forEach _allPlayers;
				} else {
					{
						_x setPosATL _args;
					}forEach _allPlayers;
				};
				
				_display closeDisplay 1;
			},{
				params ["_values","_args","_display"];
				_display closeDisplay 2;
			},[true] call MAZ_EZM_fnc_getScreenPosition] call MAZ_EZM_fnc_createDialog;
		};