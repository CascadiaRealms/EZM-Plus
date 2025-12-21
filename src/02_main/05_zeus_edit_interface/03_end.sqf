			comment "Zeus Preview";
				[] call MAZ_EZM_fnc_zeusPreviewImage;
				[] call MAZ_EZM_fnc_addZeusPreviewEvents;
			
			comment "End";

				comment "Select respawns if no respawns";
				private _serverMainSide = west;
				private _sideCount = [0,0,0];
				private _max = 0;
				{
					private _side = side (group _x);
					private _index = switch (_side) do {
						case west: {0};
						case east: {1};
						case independent: {2};
						default {0};
					};
					_sideCount set [_index, (_sideCount select _index) + 1];
				}forEach allPlayers;
				{
					if(_x > _max) then {
						_serverMainSide = switch (_forEachIndex) do {
							case 0: {west};
							case 1: {east};
							case 2: {independent};
						};
					};
				}forEach _sideCount;
				if(count (_serverMainSide call BIS_fnc_getRespawnPositions) == 0) then {
					private _respawnIndex = switch (_serverMainSide) do {
						case WEST: {1};
						case EAST: {4};
						case INDEPENDENT: {3};
						case CIVILIAN: {2};
					};
					[((findDisplay 312) displayCtrl 152)] call (missionNamespace getVariable "MAZ_EZM_fnc_emulateModeClick");
					private _respawnLocalText = localize "$STR_A3_RSCRESPAWNCONTROLS_RESPAWN";
					private _index = [uiNamespace getVariable "MAZ_zeusModulesTree",_respawnLocalText,[]] call (uiNamespace getVariable "MAZ_EZM_fnc_findTree");
					(uiNamespace getVariable "MAZ_zeusModulesTree") tvExpand [_index];
					(uiNamespace getVariable "MAZ_zeusModulesTree") tvSetCurSel [_index];
				};
		};
		call MAZ_EZM_fnc_addNewFactionsToZeusInterface;
		call MAZ_EZM_fnc_addNewModulesToZeusInterface;
		call MAZ_EZM_fnc_sortFactionModules;
	};
	[] call _fnc_editInterface;
};