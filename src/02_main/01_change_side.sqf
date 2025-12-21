MAZ_EZM_fnc_switchGroupSetup = {
	params ["_side"];
	private _group = createGroup [_side,true];
	private _groupName = "Mount Olympus";
	[player] join _group;
	[_group, player] remoteExec ["selectLeader"];					
	_group setGroupIdGlobal [_groupName];
	private _leader = leader _group;
	private _data = ["Curator", _groupName, false]; comment " [<Insignia>, <Group Name>, <Private>] ";
	["RegisterGroup", [_group, player, _data]] remoteExec ['BIS_fnc_dynamicGroups'];
	["AddGroupMember", [_group,player]] remoteExec ['BIS_fnc_dynamicGroups'];
	["SwitchLeader", [_group,player]] remoteExec ['BIS_fnc_dynamicGroups'];
	["SetPrivateState", [_group,true]] remoteExec ['BIS_fnc_dynamicGroups'];	
	["SetName", [_group,_groupName]] remoteExec ['BIS_fnc_dynamicGroups'];
};

MAZ_EZM_fnc_groupMenuTeamSwitcher = {
	if (!isNull findDisplay 60490) exitWith {};
	with uiNamespace do 
	{
		disableSerialization;
		closeDialog 1;
		createDialog "RscDisplayDynamicGroups";
		showChat true;
		_display = findDisplay 60490;
		if (!isNull _display) then 
		{
			_bcknd1 = _display ctrlCreate ['RscText',-1];
			_bcknd1 ctrlSetPosition [0.345312 * safezoneW + safezoneX,0.093 * safezoneH + safezoneY,0.309375 * safezoneW,0.099 * safezoneH];
			_bcknd1 ctrlSetBackgroundColor [0,0,0,0.5];
			_bcknd1 ctrlCommit 0;
			_bcknd2 = _display ctrlCreate ['RscText',-1];
			_bcknd2 ctrlSetPosition [0.350469 * safezoneW + safezoneX,0.104 * safezoneH + safezoneY,0.299062 * safezoneW,0.077 * safezoneH];
			_bcknd2 ctrlSetBackgroundColor [0,0,0,0.5];
			_bcknd2 ctrlCommit 0;
			_ttile = _display ctrlCreate ["RscStructuredText", -1];
			_ttile ctrlSetPosition [0.360781 * safezoneW + safezoneX,0.104 * safezoneH + safezoneY,0.278437 * safezoneW,0.033 * safezoneH];
			_ttile ctrlSetStructuredText parseText ("<t size='" + (str (0.5 * safeZoneH)) + "' align='center'>CHANGE SIDE:</t>");
			_ttile ctrlSetBackgroundColor [0,0,0,0];
			_ttile ctrlCommit 0;
			_btn_west = _display ctrlCreate ['RscButtonMenu',-1];
			_btn_west ctrlSetPosition [0.360781 * safezoneW + safezoneX,0.137 * safezoneH + safezoneY,0.0515625 * safezoneW,0.033 * safezoneH];
			_btn_west ctrlSetBackgroundColor [0,0,0.5,0.8];
			_btn_west ctrlSetStructuredText parseText ("<t size='" + (str (0.5 * safeZoneH)) + "' align='center'>BLUFOR</t>");
			_btn_west ctrladdEventHandler ["ButtonClick", 
			{
				[west] call MAZ_EZM_fnc_switchGroupSetup;
			}];
			_btn_west ctrlCommit 0;
			_btn_east = _display ctrlCreate ['RscButtonMenu',-1];
			_btn_east ctrlSetPosition [0.4175 * safezoneW + safezoneX,0.137 * safezoneH + safezoneY,0.0515625 * safezoneW,0.033 * safezoneH];
			_btn_east ctrlSetBackgroundColor [0.5,0,0,0.8];
			_btn_east ctrlSetStructuredText parseText ("<t size='" + (str (0.5 * safeZoneH)) + "' align='center'>OPFOR</t>");
			_btn_east ctrladdEventHandler ["ButtonClick", 
			{
				[east] call MAZ_EZM_fnc_switchGroupSetup;
			}];
			_btn_east ctrlCommit 0;
			_btn_indep = _display ctrlCreate ['RscButtonMenu',-1];
			_btn_indep ctrlSetPosition [0.474219 * safezoneW + safezoneX,0.137 * safezoneH + safezoneY,0.0515625 * safezoneW,0.033 * safezoneH];
			_btn_indep ctrlSetBackgroundColor [0,0.5,0,0.8];
			_btn_indep ctrlSetStructuredText parseText ("<t size='" + (str (0.5 * safeZoneH)) + "' align='center'>INDEP</t>");
			_btn_indep ctrladdEventHandler ["ButtonClick", 
			{
				[independent] call MAZ_EZM_fnc_switchGroupSetup;
			}];
			_btn_indep ctrlCommit 0;
			_btn_civ = _display ctrlCreate ['RscButtonMenu',-1];
			_btn_civ ctrlSetPosition [0.530937 * safezoneW + safezoneX,0.137 * safezoneH + safezoneY,0.0515625 * safezoneW,0.033 * safezoneH];
			_btn_civ ctrlSetBackgroundColor [0.4,0,0.4,0.8];
			_btn_civ ctrlSetStructuredText parseText ("<t size='" + (str (0.5 * safeZoneH)) + "' align='center'>CIV</t>");
			_btn_civ ctrladdEventHandler ["ButtonClick", 
			{
				[civilian] call MAZ_EZM_fnc_switchGroupSetup;
			}];
			_btn_civ ctrlCommit 0;
			_btn_zeus = _display ctrlCreate ['RscButtonMenu',-1];
			_btn_zeus ctrlSetPosition [0.587656 * safezoneW + safezoneX,0.137 * safezoneH + safezoneY,0.0515625 * safezoneW,0.033 * safezoneH];
			_btn_zeus ctrlSetBackgroundColor [0.4,0.4,0.4,0.8];
			_btn_zeus ctrlSetStructuredText parseText ("<t size='" + (str (0.5 * safeZoneH)) + "' align='center'>ZEUS</t>");
			_btn_zeus ctrladdEventHandler ["ButtonClick", 
			{
				[sideLogic] call MAZ_EZM_fnc_switchGroupSetup;
			}];
			_btn_zeus ctrlCommit 0;
		};
	};
};