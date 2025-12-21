MAZ_EZM_fnc_changeStanceModule = {
			params ["_entity"];

			["Set Stance",[
				[
					"LIST",
					"Stance Mode",
					[
						[
							"AUTO",
							"UP",
							"MIDDLE",
							"DOWN"
						],
						[
							"Automatic Stance",
							"Forced Standing",
							"Forced Crouching",
							"Forced Prone"
						],
						0
					]
				]
			],{
				params ["_values","_args","_display"];
				private _value = _values select 0;
				MAZ_EZM_stanceForAI = _value;
				[[_value],{
					params ["_mode"];
					{
						_x setUnitPos _mode;
					}forEach allUnits;
				}] remoteExec ['spawn'];
				[format ["All units stance mode set to %1.",_value],"addItemOk"] call MAZ_EZM_fnc_systemMessage;
				_display closeDisplay 1;
			},{
				params ["_values","_args","_display"];
				_display closeDisplay 2;
			},[]] call MAZ_EZM_fnc_createDialog;
		};
