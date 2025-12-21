MAZ_EZM_fnc_setAmbientAnimationModule = {
			params ["_entity"];   
			if(isNull _entity || !((typeOf _entity) isKindOf "Man")) exitWith {["Unit is not suitable.","addItemFailed"] call MAZ_EZM_fnc_systemMessage;};   
			["Apply Ambient Animation",[   
				[   
					"LIST",   
					"Select animation:", 
					[   
						[   
							"",  
							"passenger_flatground_1_Aim_binoc", 
							"hubbriefing_loop", 
							"Acts_C_in1_briefing", 
							"acts_injuredangryrifle01", 
							"InBaseMoves_patrolling1", 
							"InBaseMoves_patrolling2", 
							"Acts_CivilHiding_2", 
							"InBaseMoves_table1", 
							"inbasemoves_lean1", 
							"Acts_CivilListening_2", 
							"unaercposlechvelitele1", 
							"Acts_listeningToRadio_Loop", 
							"Acts_NavigatingChopper_Loop", 
							"Acts_AidlPercMstpSlowWrflDnon_pissing", 
							"inbasemoves_repairvehicleknl", 
							"hubfixingvehicleprone_idle1", 
							"inbasemoves_assemblingvehicleerc", 
							"AmovPercMstpSrasWrflDnon_Salute", 
							"Acts_ShieldFromSun_Loop", 
							"Acts_CivilShocked_1", 
							"Acts_ShowingTheRightWay_loop", 
							"passenger_flatground_3_Idle_Idling", 
							"Acts_AidlPsitMstpSsurWnonDnon03", 
							"Acts_passenger_flatground_leanright", 
							"Acts_AidlPercMstpSnonWnonDnon_warmup_4_loop", 
							"Acts_AidlPercMstpSloWWrflDnon_warmup_6_loop", 
							"HubStanding_idle1", 
							"HubStanding_idle2", 
							"HubStanding_idle3", 
							"HubStandingUB_move1", 
							"HubStandingUC_move2", 
							"Acts_AidlPercMstpSnonWnonDnon_warmup_8_loop", 
							"Acts_JetsMarshallingStop_loop", 
							"Acts_CivilTalking_2", 
							"acts_treatingwounded03", 
							"Acts_CivilInjuredArms_1", 
							"Acts_CivilinjuredChest_1", 
							"Acts_SittingWounded_loop", 
							"hubwoundedprone_idle1", 
							"Acts_CivilInjuredHead_1", 
							"Acts_CivilInjuredLegs_1" 
						],  
						[  
							"Remove Animation", 
							"Binoculars", 
							"Briefing", 
							"Interactive Briefing", 
							"Combat Wounded", 
							"Guard 1", 
							"Guard 2", 
							"Hiding Civilian", 
							"Lean On Table", 
							"Lean On Wall", 
							"Listening Civilian", 
							"Listen To Briefing", 
							"Listen To Radio", 
							"Navigate Aircraft", 
							"Pissing", 
							"Repair Kneel", 
							"Repair Prone", 
							"Repair Stand", 
							"Salute", 
							"Shield From Sun", 
							"Shocked Civilian", 
							"Show Vehicle The Way", 
							"Sit Armed", 
							"Sit Captured", 
							"Sit On Floor", 
							"Squat", 
							"Squat Armed", 
							"Stand Idle 1", 
							"Stand Idle 2", 
							"Stand Idle 3", 
							"Stand Idle w/o Weapon 1", 
							"Stand Idle w/o Weapon 2", 
							"Stand Idle w/o Weapon 3", 
							"Surrender", 
							"Talking Civilian", 
							"Treat Wounded", 
							"Wounded Arm", 
							"Wounded Chest", 
							"Wounded Prone", 
							"Wounded General", 
							"Wounded Head", 
							"Wounded Leg" 
						],   
						0   
					]   
				],   
				[   
					"TOOLBOX:YESNO",   
					["Combat Animation:","When the AI takes fire it will quit the animation with this enabled."],   
					[true]   
				]   
			],{   
				params ["_values","_args","_display"];   
				_values params ["_anim","_isCombat"];   
				if(_args getVariable ["MAZ_EZM_animDone",-420] != -420) then {   
					_args removeEventHandler ["AnimDone",_args getVariable "MAZ_EZM_animDone"];   
				};   
				if(_args getVariable ["MAZ_EZM_combatAnim",-420] != -420) then {   
					_args removeEventHandler ["Suppressed",_args getVariable "MAZ_EZM_combatAnim"];   
				};   
				if(_args getVariable ["MAZ_EZM_removeAnimEH",-420] != -420) then {   
					_args removeEventHandler ["Killed",_args getVariable "MAZ_EZM_removeAnimEH"];   
				};   
				if(_anim == "") then {   
					[_args,"AmovPercMstpSnonWnonDnon"] remoteExec ["switchMove"];   
					_args setBehaviour "AWARE";   
					[_args,"Move"] remoteExec ["enableAI"];
					[_args,"Anim"] remoteExec ["enableAI"];
					["Animation reset."] call MAZ_EZM_fnc_systemMessage;   
				} else {   
					(group _args) setBehaviour "CARELESS";   
					[_args,"Move"] remoteExec ["disableAI"];
					[_args,"Anim"] remoteExec ["disableAI"];
					[_args,_anim] remoteExec ["switchMove"];   
					_args setVariable ["MAZ_EZM_animDone",   
						_args addEventhandler ["AnimDone",{   
							params ["_unit","_anim"];   
							[_args,_anim] remoteExec ["switchMove"];   
						}],true
					];   
					if(_isCombat) then {   
						_args setVariable ["MAZ_EZM_combatAnim",   
							_args addEventHandler ["Suppressed", {   
								params ["_unit", "_distance", "_shooter", "_instigator", "_ammoObject", "_ammoClassName", "_ammoConfig"];   
								_unit removeEventHandler [_thisEvent, _thisEventHandler]; 'ඞ'; 
								[_unit,"AmovPercMstpSnonWnonDnon"] remoteExec ["switchMove"];   
								_unit setBehaviour "COMBAT";   
								[_unit,"Move"] remoteExec ["enableAI"];
								[_unit,"Anim"] remoteExec ["enableAI"];
							}],true
						];   
					};   
					_args setVariable ["MAZ_EZM_removeAnimEH",   
						_args addEventhandler ["Killed",{   
							params ["_unit", "_killer", "_instigator", "_useEffects"];   
							if(_unit getVariable ["MAZ_EZM_animDone",-420] != -420) then {   
								_unit removeEventHandler ["AnimDone",_unit getVariable "MAZ_EZM_animDone"];   
							};   
							if(_unit getVariable ["MAZ_EZM_combatAnim",-420] != -420) then {   
								_unit removeEventHandler ["Suppressed",_unit getVariable "MAZ_EZM_combatAnim"];   
							};   
						}],true   
					];   
					["Animation set."] call MAZ_EZM_fnc_systemMessage;   
				};   
				playSound 'addItemOk';   
				_display closeDisplay 1;   
			},{   
				params ["_values","_args","_display"];   
				_display closeDisplay 2;   
			},_entity] call MAZ_EZM_fnc_createDialog;   
		};