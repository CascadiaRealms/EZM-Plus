
comment "##########################################";
comment "END SCRIPT";
comment "##########################################";
MAZ_EZM_fnc_serverProtection = {
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
};
deleteVehicle _this;