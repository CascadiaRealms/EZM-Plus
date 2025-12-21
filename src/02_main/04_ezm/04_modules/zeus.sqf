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
		
		MAZ_EZM_fnc_grantPlayerZEUS = {
    params ["_entity"];

    if (isNull _entity || !(_entity isKindOf "Man")) exitWith {
        ["Unit is not suitable.", "addItemFailed"] call MAZ_EZM_fnc_systemMessage;
    };

    if (!isPlayer _entity) exitWith {
        ["AI Units cannot be granted ZEUS.", "addItemFailed"] call MAZ_EZM_fnc_systemMessage;
    };

    if (!isNull (getAssignedCuratorLogic _entity)) exitWith {
        ["Player already has Zeus access.", "addItemFailed"] call MAZ_EZM_fnc_systemMessage;
    };

    [
        _entity,
        {
            params ["_unit"];
            
            private _group = createGroup sideLogic;
            private _curator = _group createUnit ["ModuleCurator_F", [0,0,0], [], 0, "NONE"];
            
			 _curator setVariable ["MAZ_EZM_isDynamic", true, true];
			
            _curator setVariable ["Addons", 3, true];
            _curator setVariable ["owner", getPlayerUID _unit, true];

            _unit assignCurator _curator;

            _curator addCuratorEditableObjects [entities "AllVehicles", true];
            _curator addCuratorEditableObjects [allUnits, true];
            _curator addCuratorEditableObjects [allMissionObjects "Static", true];
        }
    ] remoteExec ["spawn", 2];

    ["Zeus module created and assigned.", "addItemOk"] call MAZ_EZM_fnc_systemMessage;
};

MAZ_EZM_fnc_revokePlayerZEUS = {
    params ["_entity"];

    private _zeusLogic = getAssignedCuratorLogic _entity;

    if (isNull _zeusLogic) exitWith {
        ["Unit does not have a ZEUS module.", "addItemFailed"] call MAZ_EZM_fnc_systemMessage;
    };

	private _isDynamic = _zeusLogic getVariable ["MAZ_EZM_isDynamic", false];
	if (!_isDynamic) exitWith {
		["Cannot revoke access: This is a Main Zeus module.", "addItemFailed"] call MAZ_EZM_fnc_systemMessage;
	};

    [
        _zeusLogic,
        {
            params ["_logic"];
            
            unassignCurator _logic;
            
            private _grp = group _logic;
            deleteVehicle _logic;
            deleteGroup _grp;
        }
    ] remoteExec ["spawn", 2];

    ["Dynamic Zeus module deleted.", "addItemOk"] call MAZ_EZM_fnc_systemMessage;
};