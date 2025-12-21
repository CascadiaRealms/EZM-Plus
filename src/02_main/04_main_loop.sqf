MAZ_EZM_fnc_initMainLoop = {
	MAZ_EZM_mainLoop_Active = true;
	["Enhanced Zeus Modules Initialized!","beep_target"] call MAZ_EZM_fnc_systemMessage;

	comment "Put Zeus in a locked squad called Mount Olympus to avoid hearing random ungrouped people in group chat.";
	private _groupName = "Mount Olympus";
	private _grp = group player;
	_grp setGroupIdGlobal [_groupName];
	private _leader = leader _grp;
	private _data = ["Curator", _groupName, true]; comment " [<Insignia>, <Group Name>, <Private>] ";
	["RegisterGroup", [_grp, _leader, _data]] remoteExecCall ['BIS_fnc_dynamicGroups'];
	["AddGroupMember", [_grp,player]] remoteExecCall ['BIS_fnc_dynamicGroups'];
	["SwitchLeader", [_grp,player]] remoteExecCall ['BIS_fnc_dynamicGroups'];
	["SetPrivateState", [_grp,true]] remoteExecCall ['BIS_fnc_dynamicGroups'];	
	["SetName", [_grp,_groupName]] remoteExecCall ['BIS_fnc_dynamicGroups'];
	
	while {MAZ_EZM_mainLoop_Active} do {
		waitUntil {uiSleep 0.01; (!isNull (findDisplay 312))};
		if(!isNil "MAZ_EP_ServerDLCs" && !isNil "MAZ_CDLC_EP_fnc_newZeus" && isNil "MAZ_CDLC_Setup") then {
			[getAssignedCuratorLogic player] remoteExec ["unassignCurator",2];
			waitUntil {isNull (getAssignedCuratorLogic player)};
			[[player],{
				params ["_unit"];
				[_unit,getPlayerUID _unit] spawn MAZ_CDLC_EP_fnc_newZeus;
			}] remoteExec ["spawn",2];
			waitUntil {!isNull (getAssignedCuratorLogic player)};
			MAZ_CDLC_Setup = true;
		};

		call MAZ_EZM_editZeusLogic;
		[] spawn MAZ_EZM_addZeusKeybinds_312;
		call MAZ_EZM_fnc_editZeusInterface;
		call MAZ_EZM_fnc_addRespawnModules;
		playSound "beep_target";
		[missionNamespace, "EZM_onZeusInterfaceOpened", [findDisplay 312]] call BIS_fnc_callScriptedEventHandler;
		waitUntil {uiSleep 0.1; (isNull (findDisplay 312))};
		[missionNamespace, "EZM_onZeusInterfaceClosed", [displayNull]] call BIS_fnc_callScriptedEventHandler;
	};
};