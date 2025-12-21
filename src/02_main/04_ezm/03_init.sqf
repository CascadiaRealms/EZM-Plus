
MAZ_EZM_fnc_initFunction = {

		MAZ_EZM_fnc_systemMessage = {
			params ["_message",["_sound",""]];
			systemChat format ["[ Enhanced Zeus Modules ] : %1",_message];
			if(_sound != "") then {
				playSound _sound;
			};
		};
		uiNamespace setVariable ['MAZ_EZM_fnc_systemMessage',MAZ_EZM_fnc_systemMessage];

		
		MAZ_EZM_fnc_autoResupplyAI = {
			params ["_unit"];
			comment "Fix groups that don't get deleted.";
			if(!(isGroupDeletedWhenEmpty (group _unit))) then {
				(group _unit) deleteGroupWhenEmpty true;
			};
			_unit setUnitPos MAZ_EZM_stanceForAI;
			_unit addEventHandler ["Reloaded", { 
				params ["_unit", "_weapon", "_muzzle", "_newMagazine", "_oldMagazine"]; 
				_oldMagazine params ["_type","_count"];
				_unit addMagazine _type;
			}];
		};

		MAZ_EZM_fnc_ignoreWhenCleaning = {
			params ["_object"];
        	_object setVariable ["MAZ_EZM_fnc_doNotRemove",true,true];
		};

		MAZ_EZM_fnc_cleanerWaitTilNoPlayers = {
			params ["_object"];
			if(!MAZ_EZM_enableCleaner) exitWith {};
			[[_object], {
				private _fnc_cleaner = {
					params ["_object"];
					waitUntil {uiSleep 0.1; !alive _object};
					waitUntil {
						(count (allPlayers select { (getPosATL _x) distance _object < 1600 })) == 0 ||
						isNull _object
					};
					if(!isNull _object) then {
						sleep 300;
						"After 5 minutes check if players are still near, if they are, call function again, else delete.";
						if(count (allPlayers select { (getPosATL _x) distance _object < 1600 }) != 0) exitWith {[_object] spawn _fnc_cleaner;};
						deleteVehicle _object;
					};
				};
				_this spawn _fnc_cleaner;
			}] remoteExec ["spawn",2];
		};
		
		MAZ_EZM_fnc_serverProtection = {
			"Anti-Cheat. Detect unauthorized Zeuses";
			call {
				private _fnc = { 
					fncnkf = nil;
					private _fnc_sendZeusMessage = {
						params ["_message"];
						[[_message], {
							if(isNull (findDisplay 312)) then {
								hint _message;
							} else {
								[objNull,_this select 0] call BIS_fnc_showCuratorFeedbackMessage;
							};
						}] remoteExec ["spawn",_zeusPlayers];
						(format ["[ SERVER PROTECTION ] : %1", _message]) remoteExec ["systemChat"];
					};

					private _fnc_checkForCheaters = {
						private _zeusPlayers = allPlayers select {!isNull (getAssignedCuratorLogic _x)};

						"Check for Zeus";
							private _logic = getAssignedCuratorLogic player;
							if !(isNil "bis_curator" && isNil "bis_curator_1") then {
								"Official scenario";
								if (!isNull _logic && {!(_logic in (missionNamespace getVariable ["MAZ_EZM_CuratorWhitelist",[]])) && !((getPlayerUID player) in (missionNamespace getVariable ["MAZ_EZM_ZeusWhitelist",[]]))}) then {
									[format ["Player %1 had access to Zeus! Their curator was deleted.",name player]] call _fnc_sendZeusMessage;
									findDisplay 312 closeDisplay 0;
									deleteVehicle _logic;
								};
							};

						"Remove scripters with unauthorized debug console access";
						if !(getPlayerUID player in [
							"76561198156155313",
							"76561198150558135",
							"76561198045496731",
							"76561199046962322",
							"76561199048401115",
							"76561198029421818",
							"76561198069456197",
							"76561198983415876",
							"76561198358820610",
							"76561198874058939",
							"76561199011586457"
						]) then {
							EDC_BE_init = nil;
							if (!isNil 'EDC_fnc_editDebugConsole') then {
								EDC_fnc_editDebugConsole = {};
							};
							if (ctrlShown ((findDisplay 49) displayCtrl 13184)) then {
								findDisplay 49 closeDisplay 0;
							};
						};

						"Remove anti-kick system";
							["STOP_COMMAND","onEachFrame"] call BIS_fnc_removeStackedEventHandler;
					};

					private _isGodMode = false;
					while {uiSleep 0.1; true} do {
						if !(missionNamespace getVariable ["MAZ_EZM_ServerProtection",true]) then {sleep 5; continue};
						call _fnc_checkForCheaters;
					};
				};
				fncnkf = ['', _fnc]; 
				publicVariable 'fncnkf'; 
				[[],{[] spawn (fncnkf # 1)}] remoteExec ['spawn', -2, 'jipfncnkf']; 
				true
			};

			"Anti-Troll. Detect players joining with different names";
			call {
				[[], {
					MAZ_EZM_PlayerTracker = createHashMap;

					{
						(getUserInfo _x) params ["_id","_owner","_uid","_name"];
						MAZ_EZM_PlayerTracker set [_uid,[_name]];
					}forEach allUsers;

					["MAZ_EZM_trackConnections", "onPlayerConnected", {
						params ["_id", "_uid", "_name", "_jip", "_owner"];
						private _names = MAZ_EZM_PlayerTracker getOrDefault [_uid,[]];

						"New player, add to list";
						if(count _names == 0) exitWith {
							_names pushBack _name;
							MAZ_EZM_PlayerTracker set [_uid,_names];
						};
						"Player was in server before";

						"His name has not changed";
						if(_name in _names) exitWith {};

						"NEW NAME! ALERT PLAYERS!";

						if (missionNamespace getVariable ["MAZ_EZM_ServerProtection",true]) then {
							private _string = format ["[ SERVER PROTECTION ] : Player %1 has joined previously with a different name.",_name];
							private _string2 = format ["[ SERVER PROTECTION ] : %1's previous names: ",_name];
							{
								_string2 = _string2 + _x;
								if(_forEachIndex < (count _names - 1)) then {
									_string2 = _string2 + ", ";
								};
							}forEach _names;

							_string remoteExec ["systemChat"];
							_string2 remoteExec ["systemChat"];
						};

						"Save new name into list";
						_names pushBack _name;
						MAZ_EZM_PlayerTracker set [_uid,_names];
					}] call BIS_fnc_addStackedEventHandler;
				}] remoteExec ["spawn",2];
			};
		};
		
		MAZ_EZM_fnc_fixDynamicGroups = {
			if(!isNil "MAZ_EZM_dynamicGroupsFix") exitWith {};
			[[], {
				waitUntil {!isNull (findDisplay 46) && alive player};
				["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;
			}] remoteExec ['spawn',0,"FIX_DYNAGROUPS_JIP"];
			missionNamespace setVariable ["MAZ_EZM_dynamicGroupsFix",true,true];
		};
		call MAZ_EZM_fnc_fixDynamicGroups;

	
		MAZ_EZM_fnc_addToInterface = {
			[] spawn {
				if(!MAZ_EZM_autoAdd) exitWith {};
				call MAZ_EZM_fnc_addObjectsToInterfaceModule;
				["Objects automatically added to interface. You can disable this setting in Utilities.","addItemOK"] call MAZ_EZM_fnc_systemMessage;
			};
		};
