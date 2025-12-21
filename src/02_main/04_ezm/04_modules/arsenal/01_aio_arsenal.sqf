JAM_EZM_fnc_createAIOArsenalModule = {
			params [["_entity", objnull],["_pos",nil],["_doLight",true],["_doMarker",true],["_doAnimations",true]];
			if(isNil "_pos") then {
				_pos = [true] call MAZ_EZM_fnc_getScreenPosition;
			};
			private _arsenalBox = if (isNull _entity) then {
				private _arsenalBox = createVehicle ["B_supplyCrate_F", _pos, [], 0, "CAN_COLLIDE"];
				_arsenalBox allowdamage false;
				
				if(_doLight) then {
					private _arsenalHeliLight = createVehicle["PortableHelipadLight_01_green_F", _pos, [], 0, "CAN_COLLIDE"];
					_arsenalHeliLight = [_arsenalHeliLight] call BIS_fnc_replaceWithSimpleObject;
					_arsenalHeliLight attachTo [_arsenalBox, [0, 0, 0.5]];
					
					private _arsenalLightTemp = createVehicle ["#lightpoint", _pos,[],0,"CAN_COLLIDE"];
					_arsenalLightTemp attachto [_arsenalBox,[0,0,0.5]];
					
					private _fnc =  {
						if (!hasInterface) exitWith {}; 
						params ["_light"]; 
						if (!isNull _light) then { 
							_light setLightBrightness 0.14; 
							_color = [0.1,1,0.1];
							_light setLightAmbient _color; 
							_light setLightColor _color; 
						}; 
					};
					M9SD_AIO_REfnc_initArsenalLight = ["b2", _fnc]; 
					publicVariable "M9SD_AIO_REfnc_initArsenalLight"; 
					
					[[_arsenalLightTemp], { 
						_this spawn (M9SD_AIO_REfnc_initArsenalLight select 1); 
					}] remoteExec ["spawn", 0, _arsenalLightTemp];
				};
				[_arsenalBox] call MAZ_EZM_fnc_deleteAttachedWhenKilled;
				[_arsenalBox] call MAZ_EZM_fnc_deleteAttachedWhenDeleted;
				_arsenalBox
			} else {
				_entity;
			};
			if (isNull _arsenalBox) exitWith {};

			["AmmoboxInit", [_arsenalBox, true]] call BIS_fnc_arsenal;

			M9SD_fnc_addSmallArsenalActions = {
				params[["_arsenalBox", objNull],["_doAnimations",true]];
				if (isNull _arsenalBox) exitWith {};
				if (_arsenalBox getVariable["M9SD_hasArsenalActions", false]) exitWith {};
				_arsenalBox setVariable["M9SD_hasArsenalActions", true, true];
				if (isNil "M9SD_AIOArsenal_JIPCount") then {
					M9SD_AIOArsenal_JIPCount = 0;
				};
				M9SD_AIOArsenal_JIPCount = M9SD_AIOArsenal_JIPCount + 1;
				publicVariable "M9SD_AIOArsenal_JIPCount";
				private _uniqueJIP = format["M9SD_JIP_AIOArsenalActions_%1", M9SD_AIOArsenal_JIPCount];
				[[_arsenalBox, _uniqueJIP,_doAnimations], {
					if (!hasInterface) exitWith {};
					params[["_supplyCrate", objNull], ["_uniqueJIP", ""], ["_doAnimations",true]];
					if (isNull _supplyCrate) exitWith {
						remoteExec["", _uniqueJIP]
					};
					_supplyCrate addAction[
						"<t color='#FFFFFF' size='1.2'><img image='a3\ui_f\data\logos\a_64_ca.paa'></img><t color='#00ff00' size='1.2' font='puristaBold'> Full Arsenal</t>", 
						{
							playSound["beep_target", true];
							playSound["beep_target", false];
							["Preload"] call BIS_fnc_arsenal;
							["Open", true] spawn BIS_fnc_arsenal;
							0 = [] spawn {
								for "_i" from 1 to 12 do {
									(format["arsenalNotification%1", _i]) cutFadeOut 0;
								};
								"arsenalNotification1" cutText ["<br/><t color='#00ff00' size='2.1' shadow='2' font='puristaMedium'>AIO Arsenal</t>", "PLAIN DOWN", -1, true, true];
								uiSleep 1;
								if !(isNull findDisplay - 1) then {
									"arsenalNotification2" cutFadeOut 0;
									"arsenalNotification2" cutText["<br/><br/><br/><t color='#00a6ff' size='1.2' shadow='2' font='puristaSemiBold'>by <t color='#00c9ff'>M9-SD</t>", "PLAIN DOWN", -1, true, true];
								};
								uiSleep 7;
								"arsenalNotification1" cutFadeOut 2.1;
								"arsenalNotification2" cutFadeOut 2.1;
							};
							if(_this select 3) then {
								private _arsenalAnims = [
									"Salute",
									"gear",
									"acts_Mentor_Freeing_Player",
									"Acts_Hilltop_Calibration_Pointing_Left",
									"Acts_Hilltop_Calibration_Pointing_Right",
									[player,"acts_civilidle_1"],
									[player,"acts_civilListening_2"],
									[player,"acts_commenting_on_fight_loop"],
									[player,"acts_gallery_visitor_01"],
									[player,"acts_gallery_visitor_02"],
									[player,"acts_hilltop_calibration_loop"],
									[player,"acts_kore_talkingoverradio_loop"],
									[player,"acts_staticPose_photo"],
									[player,"Acts_Taking_Cover_From_Jets"],
									[player,"Acts_standingSpeakingUnarmed"],
									[player,"acts_kore_talkingOverRadio_In"],
									[player,"acts_kore_idleNoWeapon_In"],
									[player,"Acts_JetsOfficerSpilling"],
									[player,"Acts_Grieving"]

								];
								private _arsenalAnimsAdd = switch (currentWeapon player) do {
									case (primaryWeapon player): {
										[
											"Acts_SupportTeam_Right_ToKneelLoop",
											"Acts_SupportTeam_Left_ToKneelLoop",
											"Acts_SupportTeam_Front_ToKneelLoop",
											"Acts_SupportTeam_Back_ToKneelLoop",
											"acts_RU_briefing_Turn",
											"acts_RU_briefing_point",
											"acts_RU_briefing_point_tl",
											"acts_RU_briefing_move",
											"acts_rifle_operations_right",
											"acts_rifle_operations_left",
											"acts_rifle_operations_front",
											"acts_rifle_operations_checking_chamber",
											"acts_rifle_operations_barrel",
											"acts_rifle_operations_back",
											"acts_pointing_up",
											"acts_pointing_down",
											"acts_peering_up",
											"acts_peering_down",
											"acts_peering_front",
											[player,"acts_briefing_SA_loop"],
											[player, "acts_getAttention_loop"],
											[player, "acts_millerIdle"],
											[player, "Acts_starGazer"],
											[player, "acts_rifle_operations_zeroing"],
											[player, "Acts_Helping_Wake_Up_1"]
										];
									};
									case (handgunWeapon player): {
										[
											[player, "acts_examining_device_player"],
											[player, "acts_executioner_standingloop"],
											"Acts_ViperMeeting_A_End",
											"Acts_UGV_Jamming_Loop",
											"Acts_starterPistol_Fire"
										]
									};
									default {
										[]
									};
								};
								_arsenalAnims = _arsenalAnims + _arsenalAnimsAdd;
								private _playAnim = selectRandom _arsenalAnims;
								if(typeName _playAnim == "STRING") then {
									player playMoveNow _playAnim;
								} else {
									_playAnim remoteExec ["switchMove"];
								};
								if !(isNil "M9SD_EH_ResetPlayerAnimsOnArsenalClosed") then {
									(findDisplay 46) displayRemoveEventHandler["keyDown", M9SD_EH_ResetPlayerAnimsOnArsenalClosed];
								};
								M9SD_EH_ResetPlayerAnimsOnArsenalClosed = (findDisplay 46) displayAddEventHandler["keyDown", {
									params["_displayOrControl", "_key", "_shift", "_ctrl", "_alt"];
									private _w = 17;
									private _a = 30;
									private _s = 31;
									private _d = 32;
									private _keys = [_w, _a, _s, _d];
									if (_key in _keys) then {
										if !(isNil "M9SD_EH_ResetPlayerAnimsOnArsenalClosed") then {
											(findDisplay 46) displayRemoveEventHandler["keyDown", M9SD_EH_ResetPlayerAnimsOnArsenalClosed];
										};
										player enableSimulation true;
										player playActionNow "";
										player playMoveNow "";
										player switchMove "";
										if (isMultiplayer) then {
											[player, ""] remoteExec ["switchMove"]
										};
										"arsenalNotification1"
										cutFadeOut 0;
										"arsenalNotification2"
										cutFadeOut 0;
									};
								}];
							};
							playSound["hintExpand", true];
							playSound["hintExpand", false];
						}, _doAnimations, 7777, true, true, "", "(_this == vehicle _this)", 7
					];
					_supplyCrate addAction[
						"<t color='#FFFFFF' size='1.2'><img image='\A3\ui_f\data\map\diary\icons\taskCustom_ca.paa'></img><t color='#00ff00' size='1.2' font='puristaBold'> Copy Loadout</t>", 
						{
							playSound ["beep_target", true]; 
							playSound ["beep_target", false]; 
							player playmovenow "AinvPknlMstpSnonWnonDnon_1"; 
							private _nearMen = nearestObjects [player, ["Man"], 21]; 
							if ((count _nearMen) <= 1) exitWith { 
								playSound ["AddItemFailed", true]; 
								playSound ["AddItemFailed", false]; 
								0 = [] spawn { 
									for "_i" from 1 to 12 do { 
										(format ["arsenalNotification%1", _i]) cutFadeOut 0; 
									}; 
									"arsenalNotification8" cutFadeOut 0;  
									"arsenalNotification8" cutText ["<t color='#ffd700' font='puristaMedium' shadow='2' size='1.4'>ERROR:<br/>No unit is close enough.</t>", "PLAIN DOWN", -1, true, true]; 
									uiSleep 3.5; 
									"arsenalNotification8" cutFadeOut 0.35; 
								}; 
							}; 
							private _nearestMan = _nearMen # 1; 
							private _loadout = getUnitLoadout _nearestMan; 
							player setUnitLoadout _loadout; 
							private _unitName = name _nearestMan; 
							private _notifText = format ["<t color='#ffd700' font='puristaMedium' shadow='2' size='1.4'>Nearest unit’s loadout copied:<br/><br/><t color='#FFFFFF' font='puristaSemiBold'>“%1”</t>", _unitName]; 
							0 = _notifText spawn { 
								for "_i" from 1 to 12 do { 
									(format ["arsenalNotification%1", _i]) cutFadeOut 0; 
								}; 
								"arsenalNotification8" cutFadeOut 0;  
								"arsenalNotification8" cutText [_this, "PLAIN DOWN", -1, true, true]; 
								uiSleep 3.5; 
								"arsenalNotification8" cutFadeOut 0.35; 
							}; 
							playSound ["hintExpand", true]; 
							playSound ["hintExpand", false]; 
						}, nil, 7777, true, true, "", "(_this == vehicle _this)", 7
					];
					_supplyCrate addAction[
						"<t color='#FFFFFF' size='1.2'><img image='a3\ui_f\data\igui\cfg\actions\obsolete\ui_action_gear_ca.paa'></img><t color='#00ff00' size='1.2' font='puristaBold'> Empty Loadout</t>", 
						{
							playSound["beep_target", true];
							playSound["beep_target", false];
							player playmovenow "AinvPknlMstpSnonWnonDnon_1";
							removeAllWeapons player;
							removeAllItems player;
							removeAllAssignedItems player;
							removeUniform player;
							removeVest player;
							removeBackpack player;
							removeHeadgear player;
							removeGoggles player;
							0 = [] spawn {
								for "_i" from 1 to 12 do {
									(format["arsenalNotification%1", _i]) cutFadeOut 0;
								};
								"arsenalNotification4" cutFadeOut 0;
								"arsenalNotification4" cutText["<t color='#00ff00' font='puristaMedium' shadow='2' size='1.2'>Loadout removed.</t>", "PLAIN DOWN", -1, true, true];
								uiSleep 3.5;
								"arsenalNotification4" cutFadeOut 0.35;
							};
							playSound["hintExpand", true];
							playSound["hintExpand", false];
						}, nil, 7777, true, true, "", "(_this == vehicle _this)", 7
					];
					_supplyCrate addAction[
						"<t color='#FFFFFF' size='1.2'><img image='a3\3den\data\displays\Display3DEN\ToolBar\save_ca.paa'></img><t color='#00ff00' size='1.2' font='puristaBold'> Save Respawn Loadout</t>", 
						{
							playSound["beep_target", true];
							playSound["beep_target", false];
							player playActionNow "putdown";
							[player, [missionnamespace, "M9SD_arsenalRespawnLoadout"]] call BIS_fnc_saveInventory;
							if (!isNil "M9SD_EH_arsenalRespawnLoadout") then {
								player removeEventHandler["Respawn", M9SD_EH_arsenalRespawnLoadout];
							};
							M9SD_EH_arsenalRespawnLoadout = player addEventHandler ["Respawn", {
								0 = [] spawn {
									waitUntil {alive player};
									sleep 0.07;
									[player, [missionnamespace, "M9SD_arsenalRespawnLoadout"]] call BIS_fnc_loadInventory;
								};
							}];
							0 = [] spawn {
								for "_i" from 1 to 12 do {
									(format["arsenalNotification%1", _i]) cutFadeOut 0;
								};
								"arsenalNotification6" cutFadeOut 0;
								"arsenalNotification6" cutText["<t color='#00ff00' font='puristaMedium' shadow='2' size='1.2'>Respawn loadout set.</t>", "PLAIN DOWN", -1, true, true];
								uiSleep 3.5;
								"arsenalNotification6" cutFadeOut 0.35;
							};
							playSound["hintExpand", true];
							playSound["hintExpand", false];
						}, nil, 7777, true, true, "", "(_this == vehicle _this)", 7
					];
					_supplyCrate addAction[
						"<t color='#FFFFFF' size='1.2'><img image='a3\3den\data\displays\Display3DEN\ToolBar\open_ca.paa'></img><t color='#00ff00' size='1.2' font='puristaBold'> Load Respawn Loadout</t>", 
						{
							playSound["beep_target", true];
							playSound["beep_target", false];
							player playActionNow "putdown";
							[player, [missionnamespace, "M9SD_arsenalRespawnLoadout"]] call BIS_fnc_loadInventory;
							0 = [] spawn {
								for "_i" from 1 to 12 do {
									(format["arsenalNotification%1", _i]) cutFadeOut 0;
								};
								"arsenalNotification12" cutFadeOut 0;
								"arsenalNotification12" cutText["<t color='#00ff00' font='puristaMedium' shadow='2' size='1.2'>Respawn loadout applied.</t>", "PLAIN DOWN", -1, true, true];
								uiSleep 3.5;
								"arsenalNotification12" cutFadeOut 0.35;
							};
							playSound["hintExpand", true];
							playSound["hintExpand", false];
						}, nil, 7777, true, true, "", "(_this == vehicle _this) && !isNil 'M9SD_EH_arsenalRespawnLoadout'", 7
					];
					_supplyCrate addAction[
						"<t color='#FFFFFF' size='1.2'><img image='\a3\3den\data\Cfg3DEN\History\deleteItems_ca.paa'></img><t color='#00ff00' size='1.2' font='puristaBold'> Delete Respawn Loadout</t>", 
						{
							playSound["beep_target", true];
							playSound["beep_target", false];
							player playActionNow "putdown";
							if (!isNil "M9SD_EH_arsenalRespawnLoadout") then {
								player removeEventHandler["Respawn", M9SD_EH_arsenalRespawnLoadout];
								M9SD_EH_arsenalRespawnLoadout = nil;
							};
							0 = [] spawn {
								for "_i" from 1 to 12 do {
									(format["arsenalNotification%1", _i]) cutFadeOut 0;
								};
								"arsenalNotification5" cutFadeOut 0;
								"arsenalNotification5" cutText["<t color='#00ff00' font='puristaMedium' shadow='2' size='1.2'>Respawn loadout disabled.</t>", "PLAIN DOWN", -1, true, true];
								uiSleep 3.5;
								"arsenalNotification5" cutFadeOut 0.35;
							};
							playSound["hintExpand", true];
							playSound["hintExpand", false];
						}, nil, 7777, true, true, "", "(_this == vehicle _this) && !isNil 'M9SD_EH_arsenalRespawnLoadout'", 7
					];
					_supplyCrate addAction[
						"<t color='#FFFFFF' size='1.2'><img image='\A3\ui_f\data\IGUI\Cfg\simpleTasks\types\heal_ca.paa'></img><t color='#00ff00' size='1.2' font='puristaBold'> Heal</t>", 
						{
							playSound["beep_target", true];
							playSound["beep_target", false];
							player playActionNow "Medic";
							[player] call BIS_fnc_reviveEhRespawn;
							player setDamage 0;
							player setUnconscious false;
							player setCaptive false;
							0 = [] spawn {
								for "_i" from 1 to 12 do {
									(format["arsenalNotification%1", _i]) cutFadeOut 0;
								};
								"arsenalNotification3" cutFadeOut 0;
								"arsenalNotification3" cutText["<t color='#00ff00' font='puristaMedium' shadow='2' size='1.2'>Healing...</t>", "PLAIN DOWN", -1, true, true];
								uiSleep 6.33;
								playSound["hintCollapse", true];
								playSound["hintCollapse", false];
								"arsenalNotification3" cutFadeOut 0;
								"arsenalNotification3" cutText["<t color='#00ff00' font='puristaMedium' shadow='2' size='1.2'>Healed.</t>", "PLAIN DOWN", -1, true, true];
								uiSleep 3.33;
								"arsenalNotification3" cutFadeOut 0.35;
							};
							playSound["hintExpand", true];
							playSound["hintExpand", false];
						}, nil, 7777, true, true, "", "((_this == vehicle _this) && (damage _this > 0))", 7
					];
				}] remoteExec["call", 0, _uniqueJIP];
			};
			[_arsenalBox,_doAnimations] call M9SD_fnc_addSmallArsenalActions;
			
			if(_doMarker) then {
				M9SD_fnc_smallArsenalMarkers = {
					params[["_supplyCrate", objNull]];
					if (isNull _supplyCrate) exitWith {};
					if (_supplyCrate getVariable ["M9SD_hasMarkers", false]) exitWith {};
					_supplyCrate setVariable ["M9SD_hasMarkers", true, true];

					private _list = missionNamespace getVariable ["M9SD_smallArsenals",[]];
					_list pushBackUnique _supplyCrate;
					missionNamespace setVariable ["M9SD_smallArsenals",_list,true];

					[[], {
						if (!hasInterface) exitWith {};
						waitUntil {!isNil {player} && {!isNull player}};
						waitUntil {!isNull(findDisplay 46)};
						M9SD_smallArsenalIcons_texture = "\a3\3den\data\displays\display3den\entitymenu\arsenal_ca.paa";
						M9SD_smallArsenalIcons_width = 0.7;
						M9SD_smallArsenalIcons_height = 0.7;
						M9SD_smallArsenalIcons_angle = 0;
						M9SD_smallArsenalIcons_text = "Virtual Arsenal";
						M9SD_smallArsenalIcons_shadow = 2;
						M9SD_smallArsenalIcons_textSize = 0.04;
						M9SD_smallArsenalIcons_font = "PuristaSemiBold";
						M9SD_smallArsenalIcons_textAlign = "center";
						M9SD_smallArsenalIcons_drawSideArrows = false;
						M9SD_smallArsenalIcons_offsetX = 0;
						M9SD_smallArsenalIcons_offsetY = -0.07;
						M9SD_smallArsenalIcons_offset = 2.1;
						if (!isNil "M9SD_EH_drawSmallArsenal3D") then {
							removeMissionEventHandler["Draw3D", M9SD_EH_drawSmallArsenal3D];
						};
						M9SD_EH_drawSmallArsenal3D = addMissionEventHandler ["Draw3D", {
							private _arsenals = missionNamespace getVariable ["M9SD_smallArsenals",[]];
							if(count _arsenals == 0) exitWith {};
							{
								if(isNull _x) then {continue};
								if !(_x in [cursorTarget, cursorObject]) then {continue};
								if((_x distance (vehicle player)) > 28) then {continue};

								private _position = getPosATL _x;
								_position set [2, (_position # 2) + M9SD_smallArsenalIcons_offset];
								drawIcon3D[
									M9SD_smallArsenalIcons_texture, [1, 1, 1, 1],
									_position,
									M9SD_smallArsenalIcons_width,
									M9SD_smallArsenalIcons_height,
									M9SD_smallArsenalIcons_angle,
									"",
									M9SD_smallArsenalIcons_shadow,
									M9SD_smallArsenalIcons_textSize,
									M9SD_smallArsenalIcons_font,
									M9SD_smallArsenalIcons_textAlign,
									M9SD_smallArsenalIcons_drawSideArrows,
									M9SD_smallArsenalIcons_offsetX,
									M9SD_smallArsenalIcons_offsetY
								];
								drawIcon3D [
									"", [0, 1, 0, 1],
									_position,
									M9SD_smallArsenalIcons_width,
									M9SD_smallArsenalIcons_height,
									M9SD_smallArsenalIcons_angle,
									M9SD_smallArsenalIcons_text,
									M9SD_smallArsenalIcons_shadow,
									M9SD_smallArsenalIcons_textSize,
									M9SD_smallArsenalIcons_font,
									M9SD_smallArsenalIcons_textAlign,
									M9SD_smallArsenalIcons_drawSideArrows,
									M9SD_smallArsenalIcons_offsetX,
									M9SD_smallArsenalIcons_offsetY
								];
							}forEach _arsenals;
							if(objNull in _arsenals) then {
								[[], {
									private _arsenals = missionNamespace getVariable ["M9SD_smallArsenals",[]];
									_arsenals = _arsenals - [objNull];
									missionNamespace setVariable ["M9SD_smallArsenals",_arsenals,true];
								}] remoteExec ["spawn",2];
							};
						}];

						waitUntil {!isNull(findDisplay 12 displayCtrl 51)};
						
						if (!isNil "M9SD_EH_drawSmallArsenal2D") then {
							(findDisplay 12 displayCtrl 51) ctrlRemoveEventHandler["Draw", M9SD_EH_drawSmallArsenal2D];
						};
						
						M9SD_AIO_color1 = [0, 1, 0, 1];
						M9SD_AIO_color2 = [1, 1, 1, 1];
						M9SD_AIO_iconPath = "a3\ui_f\data\logos\a_64_ca.paa";
						
						M9SD_EH_drawSmallArsenal2D = (findDisplay 12 displayCtrl 51) ctrlAddEventHandler["Draw", 
						{
							params ["_map"];
							private _arsenals = missionNamespace getVariable ["M9SD_smallArsenals",[]];
							if (count _arsenals == 0) exitWith {}; 
							{
								if(isNull _x) then {continue};
								private _pos = _x modelToWorldVisual [0, 0, 0];
								private _iconText = if (((_map ctrlMapWorldToScreen (_x modelToWorldVisual[0, 0, 0])) distance2D getMousePosition) > 0.02) then {
									""
								} else {
									"Virtual Arsenal"
								};
								_map drawIcon [
									M9SD_AIO_iconPath,
									M9SD_AIO_color1,
									_pos,
									20,
									20,
									0,
									_iconText,
									1,
									0.05,
									"PuristaBold",
									"left"
								];
								_map drawIcon [
									M9SD_AIO_iconPath,
									M9SD_AIO_color2,
									_pos,
									20,
									20,
									0,
									"",
									1,
									0.05,
									"PuristaSemiBold",
									"left"
								];
							} forEach _arsenals;
						}];
					}] remoteExec ["spawn", 0, "M9SD_JIP_smallArsenalIcons"];
				};
				[_arsenalBox] call M9SD_fnc_smallArsenalMarkers;
			};
			[_arsenalBox, false] remoteExec ["allowDamage"]; 
			{
				[_x, false] remoteExec ["allowDamage"];
			}forEach attachedObjects _arsenalBox;
			[_arsenalBox] call MAZ_EZM_fnc_addObjectToInterface;
			[attachedObjects _arsenalBox] call MAZ_EZM_fnc_addObjectToInterface;
		};

		MAZ_EZM_fnc_createAIOArsenalDialog = {
			params ["_entity"];
			[
				"AIO Arsenal Spawner",
				[
					[
						"TOOLBOX:YESNO",
						"Light?",
						[missionNamespace getVariable ["MAZ_EZM_AIO_Light",true]]
					],
					[
						"TOOLBOX:YESNO",
						"Map Marker?",
						[missionNamespace getVariable ["MAZ_EZM_AIO_Markers",true]]
					],
					[
						"TOOLBOX:YESNO",
						"Do Animations?",
						[missionNamespace getVariable ["MAZ_EZM_AIO_Anims",true]]
					]
				],
				{
					params ["_values","_args","_display"];
					_values params ["_light","_markers","_anims"];
					MAZ_EZM_AIO_Light = _light;
					MAZ_EZM_AIO_Markers = _markers;
					MAZ_EZM_AIO_Anims = _anims;
					(_args + _values) call JAM_EZM_fnc_createAIOArsenalModule;
					["AIO Arsenal Created.","addItemOk"] call MAZ_EZM_fnc_systemMessage;
					_display closeDisplay 1;
				},
				{
					params ["_values","_args","_display"];
					_display closeDisplay 2;
				},
				[_entity,[true] call MAZ_EZM_fnc_getScreenPosition]
			] call MAZ_EZM_fnc_createDialog;
		};

		MAZ_EZM_fnc_resetSavedLoadouts = {
			[[], {
				if (!isNil "M9SD_EH_arsenalRespawnLoadout") then {
					player removeEventHandler["Respawn", M9SD_EH_arsenalRespawnLoadout];
				};
			}] remoteExec ["spawn"];
		};