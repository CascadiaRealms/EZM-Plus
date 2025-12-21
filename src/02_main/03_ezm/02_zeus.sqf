MAZ_EZM_fnc_createZeusUnit = {
	params ["_joinSide","_sideToJoin"];
	if(!_joinSide) then {
		_sideToJoin = sideLogic;
	};
	private _pos = getPosWorld player;
	private _zeusLogic = getAssignedCuratorLogic player;
	if(isNull _zeusLogic) exitWith {};
	private _zeusIndex = allCurators find _zeusLogic;
	private _isGameMod = false;
	private _grp = createGroup [_sideToJoin, true];
	private _zeusObject = (createGroup [_sideToJoin,true]) createUnit ["C_Man_French_universal_F",[0,0,0],[],0,"CAN_COLLIDE"];
	[_zeusObject] joinSilent _grp;
	_grp selectLeader _zeusObject;
	_zeusObject setPosWorld _pos;
	private _oldPlayer = player;
	private _namePlayer = name player;
	selectPlayer _zeusObject;
	waitUntil{player == _zeusObject};
	[_zeusObject,false] remoteExec ["allowDamage"];
	[_zeusLogic] remoteExec ["unassignCurator",2];
	waitUntil{(getAssignedCuratorUnit _zeusLogic) != _oldPlayer};
	deleteVehicle _oldPlayer;
	waitUntil{isNull (getAssignedCuratorUnit _zeusLogic)};
	private _wl = missionNamespace getVariable ["MAZ_EZM_CuratorWhitelist",[]];
	_wl pushBackUnique _zeusLogic;
	missionNamespace setVariable ["MAZ_EZM_CuratorWhitelist",_wl,true];
	waitUntil {_zeusLogic in (missionNamespace getVariable ["MAZ_EZM_CuratorWhitelist",[]])};
	while{isNull (getAssignedCuratorUnit (allCurators select _zeusIndex))} do {
		[player,allCurators select _zeusIndex] remoteExec ["assignCurator",2];
		sleep 0.1;
	};
	waitUntil{getAssignedCuratorLogic player == _zeusLogic};
	private _zeusLoadout = profileNamespace getVariable "MAZ_EZM_ZeusLoadout";
	if(isNil "_zeusLoadout") then {
		_zeusObject setUnitLoadout [[],[],["hgun_Pistol_heavy_01_green_F","","","",["11Rnd_45ACP_Mag",11],[],""],["U_Marshal",[["11Rnd_45ACP_Mag",2,11]]],["V_PlateCarrier_Kerry",[["11Rnd_45ACP_Mag",1,11]]],[],"H_Beret_02","G_Spectacles",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]];
		profileNamespace setVariable ["MAZ_EZM_ZeusLoadout",getUnitLoadout player];
	} else {
		_zeusObject setUnitLoadout _zeusLoadout;
	};
	sleep 0.2;
	while {(isNull (findDisplay 312))} do {
		openCuratorInterface;
	};
	waitUntil{!(isNull (findDisplay 312))};
	playSound "beep_target";
	sleep 0.2;
	[_zeusObject] call MAZ_EZM_fnc_addObjectToInterface;
	["Zeus Unit created, you can adjust its loadout by setting a Zeus Loadout."] call MAZ_EZM_fnc_systemMessage;
	if(isNil "MAZ_EZM_mainLoop_Active") then {
		[] spawn MAZ_EZM_fnc_initMainLoop;
	};
};

MAZ_EZM_fnc_runZeusModule = {
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

	if(!(typeOf _entity isKindOf "CAManBase") && alive _entity && !isNull _entity && typeOf _entity isKindOf "AllVehicles") then {
		if (!MAZ_EZM_spawnWithCrew) then {
			{
				deleteVehicle _x;
			}forEach (crew _entity);
		};
		[_entity] spawn MAZ_EZM_fnc_cleanerWaitTilNoPlayers;
		[missionNamespace, "EZM_onVehicleCreated", [_entity]] call BIS_fnc_callScriptedEventHandler;
	};
	
	if(_entityType isKindOf "CAManBase") then {
		[_entity] call MAZ_EZM_fnc_autoResupplyAI; 
		[_entity] spawn MAZ_EZM_fnc_cleanerWaitTilNoPlayers;
		[_entity] call MAZ_EZM_fnc_addNVGs;
		[missionNamespace, "EZM_onManCreated", [_entity]] call BIS_fnc_callScriptedEventHandler;
	};

	if !(_entityType in ["ModuleEmpty_F","B_Soldier_VR_F","O_Soldier_VR_F","I_Soldier_VR_F","C_Soldier_VR_F"]) exitWith {};
	
	_entity spawn {
		waitUntil {(findDisplay -1) isEqualTo displayNull};
		deleteVehicle _this;
	};
	if ((uiNamespace getVariable ["MAZ_EZM_SelectionPath", []]) isEqualTo []) exitWith {hint "No selection path"};
	private _tvModulePath = uiNamespace getVariable ["MAZ_EZM_SelectionPath", []];
	private _parentDisplay = findDisplay 312;
	private _parentTree = switch (_entityType) do {
		case "ModuleEmpty_F": {
			uiNamespace getVariable ["MAZ_zeusModulesTree", _parentDisplay displayCtrl 280];
		};
		case "B_Soldier_VR_F": {
			uiNamespace getVariable ["MAZ_UnitsTree_BLUFOR", _parentDisplay displayCtrl 270];
		};
		case "O_Soldier_VR_F": {
			uiNamespace getVariable ["MAZ_UnitsTree_OPFOR", _parentDisplay displayCtrl 271];
		};
		case "I_Soldier_VR_F": {
			uiNamespace getVariable ["MAZ_UnitsTree_INDEP", _parentDisplay displayCtrl 272];
		};
		case "C_Soldier_VR_F": {
			uiNamespace getVariable ["MAZ_UnitsTree_CIVILIAN", _parentDisplay displayCtrl 273];
		};
	};
	[_parentTree, _tvModulePath] call MAZ_EZM_fnc_runZeusFunction;
	[_parentTree, _tvModulePath] spawn {
		params ["_parentTree", "_tvModulePath"];
		_parentTree tvSetPictureColor [_tvModulePath, EZM_themeColor];
		uiSleep 0.5;
		_parentTree tvSetPictureColor [_tvModulePath, [1,1,1,1]];
	};
};

MAZ_EZM_fnc_runZeusFunction = {
	params ["_control", "_selectionPath"];
	private _tooltip = _control tvTooltip _selectionPath;
	private _tooltipArray = _tooltip splitString "\n";
	private _tooltipArrayIndex = parseNumber (_tooltipArray select (count _tooltipArray - 1));
	if (_tooltipArrayIndex in [-1,0]) exitWith {};

	private _functionName = "";
	_functionArray = missionNamespace getVariable ["MAZ_zeusModulesWithFunction", []];
	{
		_x params ["_functionID","_functionVar"];
		if (_functionID == _tooltipArrayIndex) exitWith {
			_functionName = _functionVar;
		};
	} forEach _functionArray;
	if (_functionName == "") exitWith {};
	private _function = missionNamespace getVariable [_functionName, {
		private _message = format ["<t font='puristaBold' align='center' color='#f96302' size='2'>MODULE ERROR<br/><t size='0.6' color='#FFFFFF' font='puristaLight'>( UNDEFINED FUNCTION - MODULE DID NOT RUN )<br/><t size='1.5' align='center' color='#f96302' font='puristaSemiBold'>Function Name:<br/><t size='1' color='#FFFFFF' font='puristaMedium'>“%1”<t size='0.7'><br/> <t/>", _functionName]; 
		[_message, "Enhanced Zeus Modules", true, false, (findDisplay 312)] spawn BIS_fnc_guiMessage;
	}];
	private _targetObjArray = curatorMouseOver;
	private _position = [true] call MAZ_EZM_fnc_getScreenPosition;
	if ((_targetObjArray isEqualTo []) or (_targetObjArray isEqualTo [""])) then {
		[objNull,_position] call _function;
	} else {
		[_targetObjArray # 1,_position] call _function;
	};
};