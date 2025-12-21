MAZ_EZM_fnc_changeDifficultyModule = {
			params ["_entity"];
			private _content = [
				[
					"TOOLBOX:YESNO",
					["Advanced Difficulty?","Whether to set each skill individually."],
					[false],
					{true},
					{
						params ["_display","_value"];
						_display setVariable ["MAZ_EZM_advancedDifficulty",_value];
					}
				],
				[
					"LIST",
					"Difficulty",
					[
						[
							"easy",
							"medium",
							"hard"
						],
						[
							"Easy (0%)",
							"Medium (50%)",
							"Hard (100%)"
						],
						0
					],
					{
						params ["_display"];
						!(_display getVariable ["MAZ_EZM_advancedDifficulty",false]);
					}
				],
				[
					"SLIDER",
					"SKILL OVERRIDE",
					[
						0,
						1,
						0,
						objNull,
						[1,1,1,1],
						true
					],
					{
						params ["_display"];
						!(_display getVariable ["MAZ_EZM_advancedDifficulty",false]);
					}
				]
			];

			{
				private _default = missionNamespace getVariable [format ["MAZ_EZM_Skill_%1",_x], 0.5];
				_content pushBack [
					"SLIDER",
					_x,
					[
						0,
						1,
						_default,
						objNull,
						[1,1,1,1],
						true
					],
					{
						params ["_display"];
						_display getVariable ["MAZ_EZM_advancedDifficulty",false];
					}
				]
			}forEach ["Courage","AimingAccuracy","AimingShake","AimingSpeed","Commanding","SpotDistance","SpotTime","ReloadSpeed"];

			["Set Difficulty",_content,{
				params ["_values","_args","_display"];
				_values params ["_advanced","_listSelection","_overrideValue"];
				if(!_advanced) exitWith {
					if(_overrideValue != 0) exitWith {
						_overrideValue = (round (_overrideValue * 100)) / 100;
						[[_overrideValue], {
							params ["_skillLevel"];
							{
								_x setSkill _skillLevel;
							} forEach allUnits;
						}] remoteExec ["spawn"];
						[format ["Difficulty set to %1.",_overrideValue]] call MAZ_EZM_fnc_systemMessage;
					};
					private _skill = switch (_value) do {
						case "easy": {0};
						case "medium": {0.5};
						case "hard": {1};
					};
					[_skill, {
						{
							_x setSkill _this;
						} forEach allUnits;
					}] remoteExec ["spawn"];
					[format ["Difficulty set to %1.",toUpper _value],"addItemOk"] call MAZ_EZM_fnc_systemMessage;
				};
				private _advancedValues = _values select [3,8];
				[_advancedValues, {
					{
						private _unit = _x;
						{
							private _skillValue = _this select _forEachIndex;
							_unit setSkill [_x,_skillValue];
						}forEach ["Courage","AimingAccuracy","AimingShake","AimingSpeed","Commanding","SpotDistance","SpotTime","ReloadSpeed"];
					}forEach (allUnits - allPlayers);
				}] remoteExec ["spawn"];

				{
					missionNamespace setVariable [format ["MAZ_EZM_Skill_%1",_x], _advancedValues # _forEachIndex];
				}forEach ["Courage","AimingAccuracy","AimingShake","AimingSpeed","Commanding","SpotDistance","SpotTime","ReloadSpeed"];
				["Custom difficulty applied to all units.","addItemOk"] call MAZ_EZM_fnc_systemMessage;

				_display closeDisplay 1;
			},{
				params ["_values","_args","_display"];
				_display closeDisplay 2;
			},[],{
				params ["_display"];
				_display setVariable ["MAZ_EZM_advancedDifficulty",false];
			}] call MAZ_EZM_fnc_createDialog;
		};