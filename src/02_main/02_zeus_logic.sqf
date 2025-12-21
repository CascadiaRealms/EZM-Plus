MAZ_EZM_editZeusLogic = {
	private _zeusLogic = objNull;
	private _zeusLogic = getAssignedCuratorLogic player;
	if (isNull _zeusLogic) exitWith {};
	player setVariable ["MAZ_EZM_ZeusLogic",_zeusLogic];

	if(!isNil "MAZ_EZM_zeusRespawnFix") then {
		player removeEventHandler ["Respawn",MAZ_EZM_zeusRespawnFix];
	};
	MAZ_EZM_zeusRespawnFix = player addEventhandler ["Respawn",{
		[] spawn {
			waitUntil {alive player && !isNull (findDisplay 46)};
			private _zeusLogic = player getVariable "MAZ_EZM_ZeusLogic";
			if(isNil "_zeusLogic") exitWith {
				["Error! Zeus Logic not found!","addItemFailed"] call MAZ_EZM_fnc_systemMessage;
			};
			[_zeusLogic] remoteExec ['unassignCurator',2];

			waitUntil{isNull (getAssignedCuratorUnit _zeusLogic)};
			["Curator unassigned."] call MAZ_EZM_fnc_systemMessage;

			["Attempting to assign..."] call MAZ_EZM_fnc_systemMessage;
			while{isNull (getAssignedCuratorUnit _zeusLogic)} do {
				[player,_zeusLogic] remoteExec ['assignCurator',2];
				sleep 0.1;
			};
			["Curator assigned! Press Y to open/close Zeus."] call MAZ_EZM_fnc_systemMessage;
			private _zeusLoadout = profileNamespace getVariable "MAZ_EZM_ZeusLoadout";
			player setUnitLoadout _zeusLoadout;
		};
	}];
	[] call MAZ_EZM_fnc_addToInterface;

	if((_zeusLogic getVariable ["MAZ_zeusEH_modulePlaced",-200]) != -200) then {
		_zeusLogic removeEventHandler ['CuratorObjectPlaced',(_zeusLogic getVariable 'MAZ_zeusEH_modulePlaced')];
	};
	_zeusLogic setVariable [
		"MAZ_zeusEH_modulePlaced",
		_zeusLogic addEventHandler [
			'CuratorObjectPlaced',
			{
				_this call MAZ_EZM_fnc_runZeusModule
			}
		]
	];

	_zeusLogic addEventHandler ["CuratorGroupPlaced", {
		params ["_curator", "_group"];
		_group deleteGroupWhenEmpty true;
		[units _group] call MAZ_EZM_fnc_addObjectToInterface;
	}];

	if((_zeusLogic getVariable ["MAZ_zeusEH_objectDblClicked",-200]) != -200) then {
		_zeusLogic removeEventHandler ['CuratorObjectDoubleClicked',(_zeusLogic getVariable 'MAZ_zeusEH_objectDblClicked')];
	};
	_zeusLogic setVariable [
		"MAZ_zeusEH_objectDblClicked",
		_zeusLogic addEventhandler ["CuratorObjectDoubleClicked",{
			params ["_curator", "_entity"];
			private _entityType = typeOf _entity;
			private _objectiveModules = [
				"ModuleObjectiveAttackDefend_F",
				"ModuleObjectiveSector_F",
				"ModuleObjective_F",
				"ModuleObjectiveGetIn_F",
				"ModuleObjectiveMove_F",
				"ModuleObjectiveNeutralize_F",
				"ModuleObjectiveProtect_F",
				"ModuleObjectiveRaceCP_F",
				"ModuleObjectiveRaceFinish_F",
				"ModuleObjectiveRaceStart_F",
				"ModuleCASBomb_F",
				"ModuleCASGunMissile_F",
				"ModuleCASMissile_F",
				"ModuleCASGun_F"
			];
			if (_entityType in _objectiveModules && !(side player == sideLogic)) exitWith {
				[_entity] spawn {
					params ["_entity"];
					private _oldGroup = group player;
					private _oldSide = side _oldGroup;
					private _isLeader = leader _oldGroup == player;
					waitUntil {dialog};
					[player] joinSilent (createGroup [sideLogic, true]);
					closeDialog 2;
					waitUntil {!dialog};
					_entity call BIS_fnc_showCuratorAttributes;
					waitUntil {dialog};
					if (isNull _oldGroup) exitWith {[player] joinSilent (createGroup [_oldSide, true])};
					[player] joinSilent _oldGroup;
					if(_isLeader) then {
						_oldGroup selectLeader player;
					};
				};
			};
			if(isPlayer _entity) exitWith {
				if(_entity isKindOf "CAManBase") then {
					[_entity] spawn MAZ_EZM_fnc_createPlayerAttributesDialog;
				} else {
					private _veh = vehicle _entity;
					if((typeOf _veh) isKindOf "LandVehicle" && alive _veh) then {
						[_veh] spawn MAZ_EZM_fnc_createLandVehicleAttributesDialog;
					} else {
						[_veh] spawn MAZ_EZM_fnc_createVehicleAttributesDialog;
					};
				};
				true
			};
			if((typeOf _entity) isKindOf "CAManBase" && !isPlayer _entity && alive _entity) exitWith {
				[_entity] spawn MAZ_EZM_fnc_createManAttributesDialog;
				true
			};
			if((typeOf _entity) isKindOf "LandVehicle" && alive _entity) exitWith {
				[_entity] spawn MAZ_EZM_fnc_createLandVehicleAttributesDialog;
				true
			};
			if(((typeOf _entity) isKindOf "Air" || (typeOf _entity) isKindOf "Ship") && alive _entity) exitWith {
				[_entity] spawn MAZ_EZM_fnc_createVehicleAttributesDialog;
				true
			};
			false
		}]
	];
	if((_zeusLogic getVariable ["MAZ_zeusEH_groupDblClicked",-200]) != -200) then {
		_zeusLogic removeEventHandler ['CuratorGroupDoubleClicked',(_zeusLogic getVariable 'MAZ_zeusEH_groupDblClicked')];
	};
	_zeusLogic setVariable [
		"MAZ_zeusEH_groupDblClicked",
		_zeusLogic addEventhandler ["CuratorGroupDoubleClicked",{
			params ["_curator", "_group"];
			[_group] spawn MAZ_EZM_fnc_createGroupAttributesDialog;
			true
		}]
	];

	if((_zeusLogic getVariable ["MAZ_zeusEH_markerDblClicked",-200]) != -200) then {
		_zeusLogic removeEventHandler ['CuratorMarkerDoubleClicked',(_zeusLogic getVariable 'MAZ_zeusEH_markerDblClicked')];
	};
	_zeusLogic setVariable [
		"MAZ_zeusEH_markerDblClicked",
		_zeusLogic addEventhandler ["CuratorMarkerDoubleClicked",{
			params ["_curator", "_marker"];
			[_marker] spawn MAZ_EZM_fnc_createMarkerAttributesDialog;
			true
		}]
	];
	if((_zeusLogic getVariable ["MAZ_zeusEH_markerPlaced",-200]) != -200) then {
		_zeusLogic removeEventHandler ['CuratorMarkerPlaced',(_zeusLogic getVariable 'MAZ_zeusEH_markerPlaced')];
	};
	_zeusLogic setVariable [
		"MAZ_zeusEH_markerPlaced",
		_zeusLogic addEventhandler ["CuratorMarkerPlaced",{
			params ["_curator", "_marker"];
			private _tab = RscDisplayCurator_sections select 0;
			if(_tab == 1) exitWith {comment "IN GROUPS TAB";};
			if(missionNamespace getVariable ["MAZ_EZM_isInGroupTabVar",false]) exitWith {};

			if(isNil "MAZ_EZM_markerColorDefault") then {
				MAZ_EZM_markerColorDefault = "Default";
			};
			_marker setMarkerColor MAZ_EZM_markerColorDefault;
		}]
	];

	if((_zeusLogic getVariable ["MAZ_zeusEH_waypointPlaced",-200]) != -200) then {
		_zeusLogic removeEventHandler ['CuratorWaypointPlaced',(_zeusLogic getVariable 'MAZ_zeusEH_waypointPlaced')];
	};
	_zeusLogic setVariable [
		"MAZ_zeusEH_waypointPlaced",
		_zeusLogic addEventhandler ["CuratorWaypointPlaced",{
			params ["_curator", "_group", "_waypointID"];
			private _wp = [_group,_waypointID];
			private _hovering = curatorMouseOver;
			if(_hovering isEqualTo [""] || {_group != (group (_hovering # 1))}) then {
				[] spawn {
					waitUntil {call MAZ_EZM_fnc_isContextMenuOpen};
					call MAZ_EZM_fnc_closeContextMenu;
				};
			} else {
				deleteWaypoint _wp;
			};
			private _pos = [true] call MAZ_EZM_fnc_getScreenPosition;
			if(surfaceIsWater _pos) then {
				_pos = AGLtoASL _pos;
				_wp setWaypointPosition [_pos,-1];
			};
		}]
	];

	if((_zeusLogic getVariable ["MAZ_zeusEH_curatorObjectPlaced",-200]) != -200) then {
		_zeusLogic removeEventHandler ['CuratorObjectPlaced',(_zeusLogic getVariable 'MAZ_zeusEH_curatorObjectPlaced')];
	};
	_zeusLogic setVariable [
		"MAZ_zeusEH_curatorObjectPlaced",
		_zeusLogic addEventHandler ["CuratorObjectPlaced", {
			params ["_curator", "_entity"];
			private _tab = RscDisplayCurator_sections select 0;
			if(_tab == 1) exitWith {comment "IN GROUPS TAB";};
			if(missionNamespace getVariable ["MAZ_EZM_isInGroupTabVar",false]) exitWith {};
			if(missionNamespace getVariable ["MAZ_EZM_copyingTimerOn",false]) exitWith {};

			private _objPos = getPosATL _entity;
			private _newPos = [true] call MAZ_EZM_fnc_getScreenPosition;
			if(surfaceIsWater _objPos) then {
				private _isOnCarrier = false;
				if(_newPos # 2 != 0) then {
					"Carrier terrain over water!";
					_isOnCarrier = true;
				};
				_newPos = AGLtoASL _newPos;
				_newPos = if((typeOf _entity) isKindOf "Air" && !_isOnCarrier) then {
					private _newVehicle = createVehicle [typeOf _entity,[0,0,100],[],0,"FLY"];
					createVehicleCrew _newVehicle;
					[crew _newVehicle + [_newVehicle]] call MAZ_EZM_fnc_addObjectToInterface;
					{
						deleteVehicle _x;
					}forEach (crew _entity);
					deleteVehicle _entity;
					_entity = _newVehicle;
					_newPos vectorAdd [0,0,50]
				} else {_newPos vectorAdd [0,0,0.12]};
				_entity setPosASL _newPos;
				private _sim = getText(configFile >> "CfgVehicles" >> (typeOf _entity) >> "simulation");
				if (toLower _sim == "airplanex" && !_isOnCarrier) then {
					private _dir = getDir _entity;
					_entity setVelocity [100 * (sin _dir), 100 * (cos _dir), 0];
				};
				if(_isOnCarrier) then {
					_entity setVectorDirAndUp [[0, 0, 0], [0,0,1]];
					_entity setPosASL (_newPos vectorAdd [0,0,0.1]);
				};
			} else {
				if(_entity isKindOf "AllVehicles") then {
					_newPos set [2,0];
					_entity setPosATL _newPos;
				};
			};
		}]
	];

	if((_zeusLogic getVariable ["MAZ_zeusEH_pinged",-200]) != -200) then {
		_zeusLogic removeEventHandler ['CuratorPinged',(_zeusLogic getVariable 'MAZ_zeusEH_pinged')];
	};
	_zeusLogic setVariable [
		"MAZ_zeusEH_pinged",
		_zeusLogic addEventHandler [
			"CuratorPinged", {
				params ["_curator", "_player"];
				if(isNil "MAZ_EZM_pingPad" || {isNull MAZ_EZM_pingPad}) then {
					MAZ_EZM_pingPad = "Land_HelipadEmpty_F" createVehicle [0,0,0];
				};
				detach MAZ_EZM_pingPad;
				MAZ_EZM_pingPad attachTo [_player,[0,0,0]];
				missionNamespace setVariable ["bis_fnc_curatorPinged_player",MAZ_EZM_pingPad];
			}
		]
	];
};