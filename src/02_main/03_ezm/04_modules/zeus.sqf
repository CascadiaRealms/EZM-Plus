MAZ_EZM_fnc_toggleGameModerator = {
			private _mod = missionNamespace getVariable ["bis_curator_1",objNull];
			private _curator = getAssignedCuratorLogic player;
			if(isNull _curator) exitWith {};
			if(_curator == _mod) exitWith {
				["You cannot disable the Game Mod slot as the Game Mod you dingus!","addItemFailed"] call MAZ_EZM_fnc_systemMessage;
			};
			["Disable Game Moderator?",[
				[
					"TOOLBOX",
					"Disable Game Mod?",
					[missionNamespace getVariable ["MAZ_EZM_disableModerator",true],[["No, enable","Enables Game Moderator Rights."],["Yes, disable","Removes Game Moderator rights."]]]
				]
			],{
				params ["_values","_args","_display"];
				_values params ["_disable"];
				missionNamespace setVariable ["MAZ_EZM_disableModerator",_disable,true];

				_display closeDisplay 1;
			},{
				params ["_values","_args","_display"];
				_display closeDisplay 2;
			},[]] call MAZ_EZM_fnc_createDialog;
		};

		MAZ_EZM_fnc_editZeusInterfaceColors = {
			[
				"EDIT INTERFACE COLORS",
				[
					[
						"COLOR",
						"Theme Color:",
						[EZM_themeColor]
					],
					[
						"COLOR",
						"Dialog Color:",
						[EZM_dialogColor]
					],
					[
						"SLIDER",
						"Opacity:",
						[
							0,
							1,
							EZM_zeusTransparency,
							objNull,
							[1,1,1,1],
							true
						]
					]
				],
				{
					params ["_values","_args","_display"];
					_values params ["_theme","_dialog","_transparency"];
					EZM_themeColor = _theme;
					uiNamespace setVariable ["EZM_themeColor", EZM_themeColor];
					profileNamespace setVariable ["MAZ_EZM_ThemeColor",EZM_themeColor];
					EZM_dialogColor = _dialog;
					profileNamespace setVariable ["MAZ_EZM_DialogColor",EZM_dialogColor];
					EZM_zeusTransparency = _transparency;
					profileNamespace setVariable ["MAZ_EZM_Transparency",EZM_zeusTransparency];
					[] spawn MAZ_EZM_fnc_refreshInterface;
					_display closeDisplay 1;
				},
				{
					params ["_values","_args","_display"];
					
					_display closeDisplay 2;
				},
				[]
			] call MAZ_EZM_fnc_createDialog;
		};