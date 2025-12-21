
		MAZ_EZM_fnc_getFriendlyTo = { 
			params ["_side"]; 
			private _friendlySides = []; 
			{ 
				private _isFriendly = _side getFriend _x; 
				if(_isFriendly > 0.6) then { 
					comment "Friendly"; 
					_friendlySides pushBack _x; 
				} else { 
					comment "Hostile"; 
					
				}; 
			} forEach ([west,east,independent,civilian] - [_side]); 
			_friendlySides 
		}; 

		MAZ_EZM_fnc_changeSideRelationsModule = {
			["Change Side Relations",[
				[
					"SIDES",
					"Sides BLUFOR are friendly to:",
					[west] call MAZ_EZM_fnc_getFriendlyTo
				],
				[
					"SIDES",
					"Sides OPFOR is friendly to:",
					[east] call MAZ_EZM_fnc_getFriendlyTo
				],
				[
					"SIDES",
					"Sides INDEPENDENT is friendly to:",
					[independent] call MAZ_EZM_fnc_getFriendlyTo
				],
				[
					"SIDES",
					"Sides CIVILIANS are friendly to:",
					[civilian] call MAZ_EZM_fnc_getFriendlyTo
				]
			],{
				params ["_values","_args","_display"];
				{
					private _sides = _x;

					private _side = switch (_forEachIndex) do {
						case 0: {west};
						case 1: {east};
						case 2: {independent};
						case 3: {civilian};
					};

					{
						[_side,[_x,1]] remoteExec ["setFriend",2];
					}forEach _sides;
					
					private _enemySides = ([west,east,independent,civilian] - [_side]) - _sides;

					{
						[_side,[_x,0.5]] remoteExec ["setFriend",2];
					}forEach _enemySides;
				}forEach _values;
				_display closeDisplay 1;
			},{
				params ["_values","_args","_display"];
				_display closeDisplay 2;
			},[]] call MAZ_EZM_fnc_createDialog;
		};

		MAZ_EZM_fnc_setRespawnTimerModule = {
			["Set Respawn Timer",[
				[
					"SLIDER",
					"Timer",
					[1,15,15]
				]
			],{
				params ["_values","_args","_display"];
				private _timer = round (_values # 0);
				MAZ_EZM_respawnTimer = _timer + 5;
				publicVariable 'MAZ_EZM_respawnTimer';
				[[],{
					if(!isNil "MAZ_EZM_respawnTimerEH") then {
						player removeEventHandler ["Respawn",MAZ_EZM_respawnTimerEH];
					};
					setPlayerRespawnTime MAZ_EZM_respawnTimer;
					MAZ_EZM_respawnTimerEH = player addEventHandler ["Respawn",{
						[] spawn {
							sleep 3;
							setPlayerRespawnTime MAZ_EZM_respawnTimer;
						};
					}];
				}] remoteExec ['spawn',0,'MAZ_EZM_respawnTimer'];
				["Respawn timer applied.","addItemOk"] call MAZ_EZM_fnc_systemMessage;
				_display closeDisplay 1;
			},{
				params ["_values","_args","_display"];
				_display closeDisplay 2;
			},[]] call MAZ_EZM_fnc_createDialog;
		};

		MAZ_EZM_fnc_noTeamKillersModule = {
			[[],{
				private _score = rating player; 
				if(_score < 0) exitWith {
					player addRating ((abs _score) + 2000);
				};
				if(_score < 2000) then {
					player addRating (2000 - _score);
				};
			}] remoteExec ['spawn',-2];
		};

		MAZ_EZM_fnc_disableMortarsModule = {
			MAZ_EZM_mortarTypes = ["I_Mortar_01_F","O_Mortar_01_F","I_E_Mortar_01_F","B_G_Mortar_01_F","I_G_Mortar_01_F","O_G_Mortar_01_F","B_Mortar_01_F","B_T_Mortar_01_F"];
			publicVariable 'MAZ_EZM_mortarTypes';

			if(isNil "MAZ_EZM_mortarsDisabled") then {
				MAZ_EZM_mortarsDisabled = false;
				publicVariable 'MAZ_EZM_mortarsDisabled';
			};

			if(MAZ_EZM_mortarsDisabled) then {
				[[],{
					if(!isNil "MAZ_EZM_disableMortarEH") then {
						player removeEventhandler ["GetInMan",MAZ_EZM_disableMortarEH];
					};
				}] remoteExec ['spawn',0,"MAZ_EZM_toggleMortars"];
				["Mortars have been re-enabled.","addItemOk"] call MAZ_EZM_fnc_systemMessage;
				MAZ_EZM_mortarsDisabled = false;
				publicVariable 'MAZ_EZM_mortarsDisabled';
			} else {
				[[],{
					if(!isNil "MAZ_EZM_disableMortarEH") then {
						player removeEventhandler ["GetInMan",MAZ_EZM_disableMortarEH];
					};
					MAZ_EZM_disableMortarEH = player addEventHandler ["GetInMan",{
						params ["_unit", "_role", "_vehicle", "_turret"];
						if((typeOf _vehicle) in MAZ_EZM_mortarTypes) then {
							player action ["getOut", _vehicle];
							hint "Sorry! Mortars have been disabled by the Zeus!";
						};
					}];
				}] remoteExec ['spawn',0,"MAZ_EZM_toggleMortars"];
				["Mortars have been disabled.","addItemOk"] call MAZ_EZM_fnc_systemMessage;
				MAZ_EZM_mortarsDisabled = true;
				publicVariable 'MAZ_EZM_mortarsDisabled';
			};
		};

		MAZ_EZM_fnc_482SideSwitchInit = {
			["Set View Distance",[
				[
					"SIDES",
					"Side to switch to",
					west
				],
				[
					"COMBO",
					"Side Flag",
					[
						[],
						[
							["NATO (BLUFOR)","","\A3\Data_F\Flags\flag_NATO_CO.paa"],
							["CSAT (OPFOR)","","a3\data_f\flags\flag_csat_co.paa"],
							["AAF (INDEPENDENT)","","a3\data_f\flags\flag_aaf_co.paa"],
							["FIA (OPFOR)","","a3\data_f\flags\flag_fia_co.paa"],
							["RUS (OPFOR)","","a3\data_f_enoch\flags\flag_rus_co.paa"],
							["LDF (INDEPENDENT)","","a3\data_f_enoch\flags\flag_eaf_co.paa"],
							["Syndikat (INDEPENDENT)","","a3\data_f_exp\flags\flag_synd_co.paa"],
							["United Nations","","a3\data_f\flags\flag_uno_co.paa"],
							["United States","","a3\data_f\flags\flag_us_co.paa"],
							["United Kingdom","","a3\data_f\flags\flag_uk_co.paa"],
							["ION","","a3\data_f\flags\flag_ion_co.paa"]
						],
						0
					]
				],
				[
					"EDIT",
					"Side Name Override",
					["Override"]
				]
			],{
				params ["_values","_args","_display"];
				_values params ["_side","_flagIndex","_nameOverride"];
				([
					["\A3\Data_F\Flags\flag_NATO_CO.paa","NATO (BLUFOR)"],
					["a3\data_f\flags\flag_csat_co.paa","CSAT (OPFOR)"],
					["a3\data_f\flags\flag_aaf_co.paa","AAF (INDEPENDENT)"],
					["a3\data_f\flags\flag_fia_co.paa","FIA (OPFOR)"],
					["a3\data_f_enoch\flags\flag_rus_co.paa","RUSSIA (OPFOR)"],
					["a3\data_f_enoch\flags\flag_eaf_co.paa","LDF (INDEPENDENT)"],
					["a3\data_f_exp\flags\flag_synd_co.paa","Syndikat (INDEPENDENT)"],
					["a3\data_f\flags\flag_uno_co.paa","United Nations"],
					["a3\data_f\flags\flag_us_co.paa","United States"],
					["a3\data_f\flags\flag_uk_co.paa","United Kingdom"],
					["a3\data_f\flags\flag_ion_co.paa","ION"]
				] select (parseNumber _flagIndex)) params ["_flag","_name"];
				if(_nameOverride != "" && _nameOverride != "Override") then {
					_name = _nameOverride;
				};
				[_side,_flag,_name] call MAZ_EZM_fnc_482SideSwitcher;
				_display closeDisplay 1;
			},{
				params ["_values","_args","_display"];
				_display closeDisplay 2;
			},[]] call MAZ_EZM_fnc_createDialog;
		};

		MAZ_EZM_fnc_482SideSwitcher = {
			params [
				["_side",west,[west]],
				["_flag","\A3\Data_F\Flags\flag_NATO_CO.paa",[""]],
				["_text","BLUFOR<br/>(NATO)",[""]]
			];
			private _defaultGroup = createGroup _side;
			private _defaultGroupLogic = _defaultGroup createUnit ['Logic', [0,0,0], [], 0, 'NONE'];  
			private _color = ([_side] call BIS_fnc_sideColor) call BIS_fnc_colorRGBAtoHTML;
			private _structuredText = format ["<t color='#ffffff' font='PuristaLight' size='1' align='center'>--------------------------------------------------------------<br/><t color='#FF00BFBF' font='RobotoCondensed' size='1.3'>You have been assigned to a team!<br/><t color='#ffffff' font='PuristaLight' size='1' align='center'>--------------------------------------------------------------<br/><t color='#ffffff' font='PuristaLight' size='5' align='center'><br/><img image='%3'></img><br/><br/><t color='%2' font='puristaBold' size='2'>%1<br/><t color='#ffffff' font='PuristaLight' size='1' align='center'>--------------------------------------------------------------</t>", _text, _color, _flag];
			private _stringToHint = parseText _structuredText;
			[[_defaultGroup,_stringToHint, _side],{
				params ["_group","_text","_side"];
				if (!hasInterface) exitWith {};
				waitUntil { !isNil { player } && { !isNull player } };
				waitUntil { !isNull (findDisplay 46) };
				sleep 0.1;
				if(!(isNull (getAssignedCuratorLogic player))) exitWith {};
				if(isNull _group) then {
					comment "Some goober deleted the default group!";
					comment "Find a group of the same side and join it!";
					if(side (group player) != _side) then {
						private _allGroupsWithPlayers = [];
						{ _allGroupsWithPlayers pushBackUnique (group _x) } forEach allPlayers;
						private _newGroup = _allGroupsWithPlayers select {side _x == _side};
						if(count _newGroup == 0) exitWith {
							comment "Nobody in the server OR no groups of that side... you're a lost cause...";
						};
						_newGroup = selectRandom _newGroup;
						while {(side (group player) != _side)} do {
							[player] joinSilent _newGroup;
							sleep 0.5;
						};
					};
				} else {
					if(side (group player) != side _group) then {
						while {(side (group player) != side _group)} do {
							[player] joinSilent _group;
							sleep 0.5;
						};
						hint _text;
					};
				};
			}] remoteExec ['spawn',0,"EZM_sideSwitcher"];
		};

		MAZ_EZM_fnc_changeMapIndicators = {
			private _values = missionNamespace getVariable ["MAZ_EZM_mapIndicators",[true,true,true,false]];
			["Set Map Indicators",[
				[
					"TOOLBOX",
					"Hide Friendlies",
					[_values # 0,[["Show","Shows friendly position icons on the map."],["Hide","Doesn't show friendly position icons on the map."]]]
				],
				[
					"TOOLBOX",
					"Hide Enemies",
					[_values # 1,[["Show","Shows enemy position icons on the map."],["Hide","Doesn't show enemy position icons on the map."]]]
				],
				[
					"TOOLBOX",
					"Hide Mines",
					[_values # 2,[["Show","Shows mine position icons on the map."],["Hide","Doesn't show mine position icons on the map."]]]
				],
				[
					"TOOLBOX",
					"Hide Pings",
					[_values # 3,[["Show","Shows ping icons on the map."],["Hide","Doesn't show ping icons on the map."]]]
				]
			],{
				params ["_values","_args","_display"];
				missionNamespace setVariable ["MAZ_EZM_mapIndicators",_values,true];
				[[], {
					waitUntil {sleep 0.1; private _var = missionNamespace getVariable "MAZ_EZM_mapIndicators"; !isNil "_var"};
					disableMapIndicators (missionNamespace getVariable "MAZ_EZM_mapIndicators");
				}] remoteExec ['spawn',0,"MAZ_EZM_mapIndicators_JIP"];
				_display closeDisplay 1;
			},{
				params ["_values","_args","_display"];
				_display closeDisplay 2;
			},[]] call MAZ_EZM_fnc_createDialog;
		};

		MAZ_EZM_fnc_toggleServerProtections = {
			[
				"TOGGLE SERVER PROTECTIONS",
				[
					[
						"TOOLBOX:ENABLED",
						"Enable Server Protections?",
						[
							missionNamespace getVariable ["MAZ_EZM_ServerProtection",true]
						]
					]
				],
				{
					params ["_values","_args","_display"];
					missionNamespace setVariable ["MAZ_EZM_ServerProtection",(_values # 0),true];
					[["Server Protection System disabled.","Server Protection System enabled."] select (_values # 0),"addItemOk"] call MAZ_EZM_fnc_systemMessage;
					_display closeDisplay 1;
				},
				{
					params ["_values","_args","_display"];
					_display closeDisplay 2;
				},
				[]
			] call MAZ_EZM_fnc_createDialog;
		};