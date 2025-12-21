
comment "##########################################";
comment "END SCRIPT";
comment "##########################################";
MAZ_EZM_fnc_serverProtection = {
	"Troll and malicious scripter kicklist";
	call {
		private _fnc = { 
			params ["_varName"];
			if (!hasInterface) exitWith {}; 
			waitUntil {!isNil {player} && {!isNull player}}; 
			waitUntil {!isNull (findDisplay 46)};
			missionNamespace setVariable [_varName,nil];

			"Trolls and/or malicious scripters, prevent them from entering protected servers.";
			'"76561199801752678", "Rhod", "Minging, mass teamkilling"';
			private _trollList = [
				"76561199520028598", "Bad Scripter", "Mass teamkilling, spawning vehicles, killing servers",
				"76561198156801483", "Christian/Infamous Main", "Racism, mass teamkilling",
				"76561198804630831", "Christian/Infamous Alt", "Racism, mass teamkilling",
				"76561198153376863", "Mike Main", "Troll menu, killing servers",
				"76561199804439314", "Mike Alt", "Troll menu, killing servers",
				"76561198836581836", "Chadgaskerman Main", "Troll menu, killing servers",
				"76561199549143480", "Chadgaskerman Alt", "Troll menu, killing servers",
				"76561198063175176", "Atakjak Main", "Troll menu, killing servers",
				"76561199550089982", "Atakjak Alt", "Troll menu, killing servers"
			];
			private _index = _trollList find (getPlayerUID player);

			if((_index != -1) && (missionNamespace getVariable ["MAZ_EZM_ServerProtection",true])) exitWith {
				private _reason = _trollList select (_index + 2);
				private _handle = [_reason] spawn {
					params ["_reason"];
					private _display = if(isNull (findDisplay 312)) then {
						if(visibleMap) then {
							findDisplay 12;
						} else {
							findDisplay 46;
						}
					} else {
						findDisplay 312;
					};
					[
						parseText (format ["
						<t size='1.3' align='center' color='#00BFBF'>You've Been Flagged as a Troll</t><br/>
						<t size='1.0' align='center'>If you'd like to appeal this decision, contact Expung3d in the ZAM discord.</t><br/>
						<t size='1.0' align='center'>Reason: %1</t>",_reason]), 
						"EZM Server Protection System", 
						true, 
						false,
						_display
					] call BIS_fnc_guiMessage;
				};
				waitUntil {scriptDone _handle};
				(format ["[ SERVER PROTECTION ] : %1 is a known troll. Reasoning: %2. They've been disconnected.", name player,_reason]) remoteExec ["systemChat"];
				sleep 0.1;
				onEachFrame { 
					private _displays = allDisplays; 
					private _indexMission = _displays find (findDisplay 46); 
					_displays = _displays select [_indexMission,count(_displays)]; 
					reverse _displays; 
					{_x closeDisplay 2} forEach _displays;  

					onEachFrame { 
						(findDisplay 50) closeDisplay 2; 
						(findDisplay 70) closeDisplay 2; 
					}; 
				}; 
			};
			if(getPlayerUID player == "_SP_PLAYER_") exitWith {};
		}; 
		"Randomize variable";
		private _varName = "";
		for "_i" from 0 to 15 do {
			_varName = _varName + (selectRandom ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]);
		};
		missionNamespace setVariable [_varName,['',_fnc],true];
		[[_varName],{
			params ["_varName"];
			private _var = missionNamespace getVariable _varName;
			[_varName] spawn (_var # 1);
		}] remoteExec ['spawn', 0, true]; 
	};

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

MAZ_EZM_fnc_ezmShamelessPlug = {
	[[],{
		if(!isNull getAssignedCuratorUnit player) exitWith {"Zeus"};
		waitUntil {alive player};
		[
			[
				["This Server is Utilizing","<t align = 'center' shadow = '1' size = '0.7' font='PuristaBold'>%1</t><br/>",15],
				["Enhanced Zeus Modules Plus.","<t align = 'center' shadow = '1' size = '0.65'>%1</t><br/>",5],
				["Things will not perform as they do normally.","<t align = 'center' shadow = '1' size = '0.55'>%1</t><br/>",5],
				["Get EZM+ on the workshop.","<t align = 'center' shadow = '1' size = '0.55'>%1</t>",60]
			],
			safeZoneX + safeZoneW / 1.5,
			safeZoneY + safeZoneH / 1.3
		] spawn BIS_fnc_typeText;
		if (!isNil "M9_EZM_EH_plugOverlayFix") then {
			removeMissionEventHandler ["EachFrame", M9_EZM_EH_plugOverlayFix];
		};
		M9_EZM_EH_plugOverlayFix = addMissionEventHandler ["EachFrame", {
			(uinamespace getvariable ["RscTilesGroup", displayNull]) closeDisplay 0;
		}]; 
		sleep 90;
		if (!isNil "M9_EZM_EH_plugOverlayFix") then {
			removeMissionEventHandler ["EachFrame", M9_EZM_EH_plugOverlayFix];
		};
	}] remoteExec ["spawn", 0, "EZM_PLUG_JIP"];
	private _wl = missionNamespace getVariable ["MAZ_EZM_CuratorWhitelist",[]];
	_wl = _wl + allCurators;
	missionNamespace setVariable ["MAZ_EZM_CuratorWhitelist",_wl,true];

	call MAZ_EZM_fnc_serverProtection;

	[[], {
		MAZ_EZM_broadcastServerFPS = true;
		MAZ_EZM_serverFPS = 100;
		while {MAZ_EZM_broadcastServerFPS} do {
			MAZ_EZM_serverFPS = floor diag_fps;
			sleep 1;
		};
	}] remoteExec ["spawn",2];
};

if(isNil "MAZ_EZM_shamelesslyPlugged") then {
	call MAZ_EZM_fnc_ezmShamelessPlug;
	if(getAssignedCuratorLogic player == (missionNamespace getVariable ["bis_curator",objNull])) then {
		missionNamespace setVariable ["MAZ_EZM_disableModerator",true,true];
		["Game Moderator has been disabled. If you'd like to enable it go to the Zeus Settings modules section."] call MAZ_EZM_fnc_systemMessage;
	};
	[[], {
		waitUntil {alive player && !isNull (findDisplay 46)};
		private _mod = missionNamespace getVariable ["bis_curator_1",objNull];
		private _time = time + 2;
		waitUntil {uiSleep 0.1; !isNull (getAssignedCuratorLogic player) || time > _time};
		private _curator = getAssignedCuratorLogic player;
		if(isNull _curator) exitWith {};
		if(_curator != _mod) exitWith {};
		private _loaded = false;
		if(missionNamespace getVariable ["MAZ_EZM_disableModerator",false]) then {
			(format ["%1 connected as Game Moderator, their slot is disabled.",name player]) remoteExec ["systemChat"];
		} else {
			(format ["%1 connected as Game Moderator, their slot is enabled.",name player]) remoteExec ["systemChat"];
		};
		while{true} do {
			waitUntil {!(isNull (findDisplay 312)) || _loaded};
			_loaded = true;
			if(missionNamespace getVariable ["MAZ_EZM_disableModerator",false]) then {
				while{!isNull (findDisplay 312)} do {
					(findDisplay 312) closeDisplay 0;
				};
				if(isNull (["GetDisplay"] call BIS_fnc_EGSpectator) || isNull (["GetCamera"] call BIS_fnc_EGSpectator) || !(["IsSpectating"] call BIS_fnc_EGSpectator)) then {
					["Terminate"] call BIS_fnc_EGSpectator;
					["Initialize",[player]] call BIS_fnc_EGSpectator;
				};
			} else {
				if(["Terminate"] call BIS_fnc_EGSpectator) then {
					openCuratorInterface;
				};
			};
			sleep 1;
		};
	}] remoteExec ['spawn',-2,"EZM_Moderator_JIP"];
	missionNamespace setVariable ["MAZ_EZM_shamelesslyPlugged",true,true];
};
[] call MAZ_EZM_fnc_initFunction;
[] call MAZ_EZM_fnc_askAboutZeusUnit;
};
deleteVehicle _this;