HYPER_EZM_fnc_handleIntroCinematic = {
			params ["_cinematicType","_backgroundSong","_intertitles", "_zeusCanSeeCutscene", "_postProcess", "_target"];

			["Intro cinematic initiated for all players.","addItemOk"] call MAZ_EZM_fnc_systemMessage;

			comment "If zeus shouldn't see the cutscene, we need to get the player set differenced with zeus player set";
			private _zeusPlayers = allCurators apply {getAssignedCuratorUnit _x};
			private _allPlayers = if(_zeusCanSeeCutscene) then {
				allPlayers;
			} else {
				allPlayers - _zeusPlayers;
			};

			comment "Get mission name";
			private _briefingName = missionNamespace getVariable ["bis_fnc_moduleMissionName_name",""];
			if (_briefingName == "") then {
				_briefingName = briefingName;
			};

			comment "Get zeus name(s)";
			private _author = "";
			if (count allcurators > 0) then {
				_authors = [];
				{
					_curatorPlayer = getAssignedCuratorUnit _x;
					if (isPlayer _curatorPlayer) then {_authors set [count _authors,name _curatorPlayer];};
				} foreach allCurators;

				{
					private _prefix = "";
					if (_foreachindex > 0) then {
						_prefix = if (_foreachindex == count _authors - 1) then {" &amp; "} else {", "};
					};
					_author = _author + _prefix + _x;
				} foreach _authors;
			} else {
				_author = getText (missionconfigfile >> "onLoadName");
			};
			if (_author != "") then {_author = format [localize "STR_FORMAT_AUTHOR_SCRIPTED",_author];};

			comment "Show intro titles";
			private _track = switch (_backgroundSong) do {
				case "epic": {"Music_Arrival"};
				case "action": {"EventTrack02a_F_EPB"};
				case "stealth": {"AmbientTrack02d_F_EXP"};
				case "random": {
					selectRandom ["EventTrack01a_F_EPA","EventTrack01a_F_EPB","EventTrack01_F_EPA","EventTrack03_F_EPB","EventTrack03a_F_EPB","EventTrack02b_F_EPC"];
				};
				default {"EventTrack01a_F_EPA"};
			};
			[_track] remoteExec ["playMusic",_allPlayers];

			comment "Close Zeus interface so it looks nicer";
			[[], {
				if(!isNull (findDisplay 312)) then {
					(findDisplay 312) closeDisplay 0;
				};
			}] remoteExec ["spawn",_zeusPlayers];

			private _delay = 6;
			[0, _delay, true, true] remoteExec ["BIS_fnc_cinemaBorder", _allPlayers];
			[["", "BLACK", _delay]] remoteExec ["cutText", _allPlayers];

			[format["<t color='#ffffff' font='PuristaBold' size='2'>%1</t><t color='#B57F50' font='TahomaB' size='0.6'><br />%2</t>",_briefingName, _author],0,0.3,4,1,0,789] remoteExec ["BIS_fnc_dynamicText", _allPlayers];

			sleep _delay;

			[["", "PLAIN", 2]] remoteExec ["cutText", _allPlayers];
			comment "cutRsc [""SplashNoise"", ""PLAIN""];";

			comment "Show intertitles";
			private _line1 = [_intertitles # 0] call HYPER_EZM_fnc_splitMaxLine;
			private _line2 = [_intertitles # 1] call HYPER_EZM_fnc_splitMaxLine;
			
			comment "Post processing";
			switch (_postProcess) do {
				case "none": {
					[[],HYPER_EZM_fnc_remotePostProcessing] remoteExec ["call", _allPlayers];
				};
				case "highcontrast": {
					[[[1, 0.9, -0.002, [0.0, 0.0, 0.0, 0.0], [1.0, 0.6, 0.4, 0.6],  [0.199, 0.587, 0.114, 0.0]]],HYPER_EZM_fnc_remotePostProcessing] remoteExec ["call", _allPlayers];
				};
				case "blue": {
					[[[1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.6, 0.6, 1.8, 0.7],  [0.199, 0.587, 0.114, 0.0]]],HYPER_EZM_fnc_remotePostProcessing] remoteExec ["call", _allPlayers];
				};
				case "dull": {
					[[[1, 0.8, -0.002, [0.0, 0.0, 0.0, 0.0], [0.6, 0.7, 0.8, 0.65],  [0.199, 0.587, 0.114, 0.0]]],HYPER_EZM_fnc_remotePostProcessing] remoteExec ["call", _allPlayers];
				};
				case "yellowgamma": {
					[[[1, 1, 0, [0.0, 0.0, 0.0, 0.0], [1.8, 1.8, 0.3, 0.7],  [0.199, 0.587, 0.114, 0.0]]],HYPER_EZM_fnc_remotePostProcessing] remoteExec ["call", _allPlayers];
				};
				case "greengamma": {
					[[[1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.6, 1.4, 0.6, 0.7],  [0.199, 0.587, 0.114, 0.0]]],HYPER_EZM_fnc_remotePostProcessing] remoteExec ["call", _allPlayers];
				};
			};

			switch (_cinematicType) do {
				case "Flyby": {
					comment "in flyby mode, we select the module location as our target, and the camera paths are automatically designated at 0 and 90 degrees";
					HYPER_fnc_remoteCamera = {
						params ["_target", "_line1", "_line2"];
						HYPER_EZM_fnc_showIntertitles = {
							params ["_line1", "_line2"];
							sleep 3;
							_line1 spawn BIS_fnc_infoText;
							sleep 5;
							_line2 spawn BIS_fnc_infoText;
						};
						[_line1, _line2] spawn HYPER_EZM_fnc_showIntertitles;
						private _zeus = !isNull (getAssignedCuratorLogic player);
						private _camTarget = "Land_HelipadEmpty_F" createVehicleLocal _target;
						private _circleRadius = 200;
						private _camHeight = 200;
						private _camSrc0 = [_target select 0, (_target select 1) + _circleRadius, (_target select 2) + _camHeight];
						private _camSrc90 = [(_target select 0) + _circleRadius, _target select 1, (_target select 2) + _camHeight];
						
						private _camera = call MAZ_EZM_fnc_createCinematicCam;
						[] spawn MAZ_EZM_fnc_enterCinematicCamera;

						_camera camPreparePos _camSrc0;
						_camera camPrepareTarget _camTarget;
						_camera camCommitPrepared 0;

						_camera camPreparePos _camSrc90;
						_camera camCommitPrepared 15;
						waitUntil { camCommitted _camera };
						cutRsc ["RscStatic", "PLAIN"];
						sleep 0.4;

						ppEffectDestroy HYPER_PP_CC_Cinematic;
						
						cutText ["", "BLACK IN", 2];
						[1, 2, true, true] call BIS_fnc_cinemaBorder;

						call MAZ_EZM_fnc_destroyCinematicCamera;
					};
					[[_target, _line1, _line2],HYPER_fnc_remoteCamera] remoteExec ["spawn", _allPlayers];
				};
				case "News": {
					private _briefingNameTitle = parseText format ["<t size='2'>%1</t>",_briefingName];
					private _subTitle = parseText format["// %1 - %2 // REPORTING LIVE FROM %3", _intertitles # 0, _intertitles # 1, worldName];
					HYPER_fnc_remoteCamera = {
						params ["_target", "_briefingNameTitle", "_subTitle"];
						[] spawn {
							playSoundUI ["a3\sounds_f\vehicles\air\heli_attack_01\heli_attack_01_ext_rotor.wss", 0.2];
							sleep 7.5;
							playSoundUI ["a3\sounds_f\vehicles\air\heli_attack_01\heli_attack_01_ext_rotor.wss", 0.2];
						};
						[
							_briefingNameTitle,
							_subTitle
						] spawn BIS_fnc_AAN;

						private _cam = call MAZ_EZM_fnc_createCinematicCam;
						[] spawn MAZ_EZM_fnc_enterCinematicCamera;

						private _pos = _target;
						private _posASL = AGLToASL _pos;
						private _height = (_posASL # 2) + 200;
						_cam camPrepareTarget _pos;
						_cam camCommitPrepared 0;

						private _posStart = _pos getPos [200,0];
						_posStart set [2,_height];
						_cam setPosASL _posStart;

						private _angle = 0;
						private _zoom = 0.75;
						while {_angle <= 155} do {
							private _posMove = _pos getPos [200,_angle];
							_posMove set [2,_height];

							if (_angle > 45 && _angle < 135) then {
								_cam camSetFov (_zoom - 0.01);
							};

							_cam camPreparePos (ASLtoAGL _posMove);
							_cam camCommitPrepared 0.5;
							waitUntil { camCommitted _cam };

							_angle = _angle + 5;
						};
						call MAZ_EZM_fnc_destroyCinematicCamera;
						(uiNamespace getVariable "BIS_AAN") closeDisplay 1;
						
						comment "Remove color correction right after cutscene is done so we don't have to remoteExec it";
						ppEffectDestroy HYPER_PP_CC_Cinematic;
						
						cutText ["", "BLACK IN", 2];
						[1, 2, true, true] call BIS_fnc_cinemaBorder;
					};
					[[_target, _briefingNameTitle, _subTitle],HYPER_fnc_remoteCamera] remoteExec ["spawn", _allPlayers];
				};
			};
		};

		HYPER_EZM_fnc_introCinematicModule = {
			params ["_entity"];
			private _target = [true] call MAZ_EZM_fnc_getScreenPosition;
			private _dialogTitle = "Intro Cinematic";
			private _content = [
				[
					"COMBO",
					"Cinematic Type",
					[
						["Flyby", "News"],
						["Flyby", "News Helicopter"],
						0
					]
				],
				[
					"COMBO",
					"Background Song",
					[
						["random", "epic", "action", "stealth"],
						["Random Event Track", "Epic", "Action", "Stealth"],
						0
					]
				],
				[
					"EDIT",
					"Intertitle 1",
					[
						"",
						1
					]
				],
				[
					"EDIT",
					"Intertitle 2",
					[
						"",
						1
					]
				],
				[
					"TOOLBOX:YESNO",
					["Zeus Can See Cutscene?","Zeus player may experience a small lag spike when cutscene ends."],
					[true]
				],
				[
					"COMBO",
					"Post-Process Filter",
					[
						["none", "highcontrast", "blue", "dull", "yellowgamma", "greengamma"],
						["None", "High Contrast", "Blue", "Dull", "Yellow Gamma", "Green Gamma"],
						0
					]
				]
			];
			private _onConfirm = {
				params ["_values", "_args", "_display"];
				_values params ["_cinematicType","_backgroundSong","_text1","_text2","_zeusCanSeeCutscene","_postProcess"];
				private _target = _args # 0;
				private _intertitles = [_text1,_text2];
				[_cinematicType, _backgroundSong, _intertitles, _zeusCanSeeCutscene, _postProcess, _target] spawn HYPER_EZM_fnc_handleIntroCinematic;
				_display closeDisplay 1;
			};
			private _onCancel = {
				params ["_values", "_args", "_display"];
				_display closeDisplay 2;
			};
			[
				_dialogTitle,
				_content,
				_onConfirm,
				_onCancel,
				[_target]
			] call MAZ_EZM_fnc_createDialog;
			
		};

		if(isNil "MAZ_EZM_fnc_createCinematicCam") then {
			MAZ_EZM_fnc_createCinematicCam = {
				call MAZ_EZM_fnc_destroyCinematicCamera;
				MAZ_EZM_CinematicCamera = "camera" camCreate [0,0,0];
				MAZ_EZM_CinematicCamera camSetFov 1;
				MAZ_EZM_CinematicCamera camCommit 0;

				MAZ_EZM_CinematicCamera;
			};
			publicVariable "MAZ_EZM_fnc_createCinematicCam";

			MAZ_EZM_fnc_enterCinematicCamera = {
				"Close Zeus";
				if(!isNull (findDisplay 312)) then {
					(findDisplay 312) closeDisplay 0;
					waitUntil {isNull (findDisplay 312)};
				};

				"Close arsenal";
				if (!isNull ((findDisplay -1) displayCtrl 44046)) then {  
					(findDisplay -1) closeDisplay 0;
					waitUntil {(isNull ((findDisplay -1) displayCtrl 44046))};
				};

				if (player != vehicle player) then {
					[vehicle player, false] remoteExec ["enableSimulationGlobal", 2];
				};

				MAZ_EZM_CinematicCamera cameraEffect ["internal", "back"];
			};
			publicVariable "MAZ_EZM_fnc_enterCinematicCamera";

			MAZ_EZM_fnc_destroyCinematicCamera = {
				if(isNil "MAZ_EZM_CinematicCamera") exitWith {"Nothing to destroy"};

				if (player != vehicle player) then {
					[vehicle player, true] remoteExec ["enableSimulationGlobal", 2];
				};

				MAZ_EZM_CinematicCamera cameraEffect ["terminate","back"];
				camDestroy MAZ_EZM_CinematicCamera;
				

				MAZ_EZM_CinematicCamera = nil;
				[] spawn {
					if(!isNull (getAssignedCuratorLogic player)) then {
						sleep 0.2;
						openCuratorInterface;
						false setCamUseTI 0;
					};
				};
			};
			publicVariable "MAZ_EZM_fnc_destroyCinematicCamera";
		};

		MAZ_EZM_fnc_circleCinematic = {
			params ["_pos","_radius","_altitude","_effect","_showText","_operationName","_operationDetail","_showGrid"];
			private _cam = call MAZ_EZM_fnc_createCinematicCam;
			[] spawn MAZ_EZM_fnc_enterCinematicCamera;

			if(_effect == "UAV_TI") then {
				"MAZ_EZM_CinematicLayer" cutRsc ["RscStatic","PLAIN"];
				true setCamUseTI 0;
			};
			if(_effect == "UAV_NV") then {
				"MAZ_EZM_CinematicLayer" cutRsc ["RscStatic","PLAIN"];
				camUseNVG true;
			};

			if(_showText && _operationName != "") then {
				private _grid = mapGridPosition _pos;
				private _gridString = if(_showGrid) then {format ["GRID %1-%2",_grid select [0,3], _grid select [3]]} else {""};
				[
					[
						[format ["OPERATION %1",toUpper _operationName], "<t align='center' shadow='1' size='1.0' font='PuristaSemiBold'>%1</t><br/>", 10],
						[format ["%1",toUpper _operationDetail], "<t align='center' shadow='1' size='0.8'>%1</t><br/>", 10],
						[_gridString, "<t align='center' shadow='1' size='0.6'>%1</t>", 20]
					],
					0,
					safeZoneY + ((safeZoneH / 4) * 3)
				] spawn BIS_fnc_typeText;
			};

			private _posASL = AGLtoASL _pos;
			private _height = _posASL # 2;
			_cam camPrepareTarget _pos;
			_cam camCommitPrepared 0;

			private _posStart = _pos getPos [_radius,0];
			_posStart set [2,_height + _altitude];
			_cam setPosASL _posStart;

			private _angle = 0;
			while {_angle <= 360} do {
				private _posMove = _pos getPos [_radius,_angle];
				_posMove set [2,_height + _altitude];

				_cam camPreparePos (ASLtoAGL _posMove);
				_cam camCommitPrepared 0.5;
				waitUntil { camCommitted _cam };

				_angle = _angle + 5;
			};

			sleep 1;

			if(_effect in ["UAV_TI","UAV_NV"]) then {
				"MAZ_EZM_CinematicLayer" cutRsc ["RscStatic","PLAIN"];
			};
			call MAZ_EZM_fnc_destroyCinematicCamera;
		};

		MAZ_EZM_fnc_circleCinematicDialog = {
			private _pos = [true] call MAZ_EZM_fnc_getScreenPosition;
			[
				"CIRCLE CINEMATIC",
				[
					[
						"SLIDER",
						"Cinematic Radius:",
						[
							100,
							300,
							200,
							_pos
						]
					],
					[
						"SLIDER",
						"Cinematic Height:",
						[100,300,200]
					],
					[
						"COMBO",
						"Cinematic Effect:",
						[
							["","UAV_TI","UAV_NV"],
							["None","UAV Thermals", "UAV NVGs"],
							0
						]
					],
					[
						"TOOLBOX:YESNO",
						"Cinematic Text?",
						[false],
						{true},
						{
							params ["_display","_value"];
							_display setVariable ["MAZ_EZM_ShowText",_value];
						}
					],
					[
						"EDIT",
						"Operation Name:",
						["BREAKER"],
						{
							params ["_display"];
							_display getVariable "MAZ_EZM_ShowText";
						}
					],
					[
						"EDIT",
						"Operation Details:",
						["Text to appear under the operation's name"],
						{
							params ["_display"];
							_display getVariable "MAZ_EZM_ShowText";
						}
					],
					[
						"TOOLBOX:YESNO",
						"Show Grid:",
						[true],
						{
							params ["_display"];
							_display getVariable "MAZ_EZM_ShowText";
						}
					]
				],
				{
					params ["_values","_args","_display"];
					_values params ["_radius","_height","_effect","_showText","_opName","_opDescription","_showGrid"];

					[[_args,_radius,_height,_effect,_showText,_opName,_opDescription,_showGrid],MAZ_EZM_fnc_circleCinematic] remoteExec ["spawn"];

					_display closeDisplay 1;
				},
				{
					params ["_values","_args","_display"];
					_display closeDisplay 2;
				},
				_pos,
				{
					params ["_display"];
					_display setVariable ["MAZ_EZM_ShowText",false];
				}
			] call MAZ_EZM_fnc_createDialog;
		};