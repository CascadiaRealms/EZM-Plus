MAZ_EZM_fnc_3DSpeakModule = {
			params ["_entity"];
			if (isNull _entity) exitWith {["Place this module onto a unit!","addItemFailed"] call MAZ_EZM_fnc_systemMessage;};
			[
				"3D Speak Message",
				[
					[
						"EDIT:MULTI",
						"Message:",
						[
							"3D spoken message",
							3
						]
					],
					[
						"SLIDER",
						"Message Duration:",
						[
							5,
							10,
							8
						]
					]
				],
				{
					params ["_values","_unit","_display"];
					_values params ["_message","_duration"];
					_message = [_message] call MAZ_EZM_fnc_checkForBlacklistedWords;
					true remoteExec ['showChat'];

					private _objName = if (isPlayer _unit) then {name _unit} else {getText (configFile >> 'cfgVehicles' >> typeOf _unit >> 'displayName');};
					if (_objName == '') then {
						_objName = typeOf _unit;
					};

					(format ['%3 (%1): %2', _objName, _message, str (side (group _unit))]) remoteExec ['systemChat'];

					[[_unit, _message,_duration],{
						params [["_unit", objnull], ["_message", "lorem ipsum..."], ["_duration", 8]];
						if (!isNil "MAZ_EZM_MEH_Draw3D_3DSpeak") then {
							removeMissionEventHandler ['Draw3D', MAZ_EZM_MEH_Draw3D_3DSpeak];
						};
						MAZ_EZM_MEH_Draw3D_3DSpeak = addMissionEventHandler ['Draw3D', {
							_thisArgs params ["_unit","_message"];
							private _pos = _unit modelToWorldVisual (_unit selectionPosition "Head");
							_pos set [2, (_pos select 2) + 0.35];
							private _intersects = lineIntersectsSurfaces [eyePos player, AGLtoASL _pos, player];
							if(count _intersects > 0) exitWith {};
							if(player distance _pos > 45) exitWith {};
							drawIcon3D 
							[
								"",
								[1,1,1,1],
								_pos,
								0, 
								-2, 
								0,
								_message,
								2,
								0.035,
								"RobotoCondensedBold",
								"center",
								false
							];
						},[_unit,_message]];
						uiSleep _duration;
						if (!isNil 'MAZ_EZM_MEH_Draw3D_3DSpeak') then {
							removeMissionEventHandler ['Draw3D', MAZ_EZM_MEH_Draw3D_3DSpeak];
						};
					}] remoteExec ['spawn'];
					
					_display closeDisplay 1;
				},
				{
					params ["_values","_args","_display"];
					_display closeDisplay 2;
				},
				_entity
			] call MAZ_EZM_fnc_createDialog;
		};