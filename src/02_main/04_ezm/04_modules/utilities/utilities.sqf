MAZ_EZM_zeusObjectBlacklist = [
			"Logic",
			"ModuleHQ_F",
			"ModuleSector_F",
			"ModuleCurator_F",
			"VirtualCurator_F",
			"ModuleCuratorSetCosts_F",
			"ModuleCuratorSetCoefs_F",
			"LogicSectorPreview100m_F",
			"LogicSectorUnknown100m_F",
			"ModuleCuratorSetCamera_F",
			"ModuleMPTypeGameMaster_F",
			"ModuleCuratorAddPoints_F",
			"ModuleRadioChannelCreate_F",
			"ModuleCuratorSetModuleCosts_F",
			"ModuleCuratorSetObjectCosts_F",
			"ModuleCuratorSetDefaultCosts_F",
			"ModuleCuratorSetAttributesPlayer_F",
			"ModuleCuratorAddEditingAreaPlayers_F"
		];
		MAZ_EZM_zeusObjectWhitelist = [
			"ModuleLightning_F",
			"ModuleRemoteControl_F",
			"ModuleArsenal_F",
			"ModuleHint_F",
			"ModulePunishment_F",
			"ModuleBootcampStage_F",
			"ModuleSmokeYellow_F",
			"ModuleSmokeWhite_F",
			"ModuleSmokeRed_F",
			"ModuleSmokePurple_F",
			"ModuleSmokeOrange_F",
			"ModuleSmokeGreen_F",
			"ModuleSmokeBlue_F",
			"ModuleMissionName_F",
			"ModuleRespawnTickets_F",
			"ModuleEndMission_F",
			"ModuleCountdown_F",
			"ModuleDiary_F",
			"ModuleVehicleRespawnPositionEast_F",
			"ModuleVehicleRespawnPositionGuer_F",
			"ModuleVehicleRespawnPositionCiv_F",
			"ModuleVehicleRespawnPositionWest_F",
			"ModuleRespawnPositionEast_F",
			"ModuleRespawnPositionGuer_F",
			"ModuleRespawnPositionCiv_F",
			"ModuleRespawnPositionWest_F",
			"ModuleRespawnInventory_F",
			"ModuleObjectiveRaceStart_F",
			"ModuleObjectiveRaceFinish_F",
			"ModuleObjectiveRaceCP_F",
			"ModuleObjectiveProtect_F",
			"ModuleObjectiveNeutralize_F",
			"ModuleObjectiveMove_F",
			"ModuleObjectiveGetIn_F",
			"ModuleObjective_F",
			"ModuleObjectiveSector_F",
			"ModuleObjectiveAttackDefend_F",
			"ModuleFlareGreen_F",
			"ModuleFlareRed_F",
			"ModuleFlareWhite_F",
			"ModuleFlareYellow_F",
			"ModuleCASMissile_F",
			"ModuleCASGun_F",
			"ModuleCASGunMissile_F",
			"ModuleCASBomb_F",
			"ModuleOrdnanceMortar_F",
			"ModuleOrdnanceRocket_F",
			"ModuleOrdnanceHowitzer_F",
			"ModuleWeather_F",
			"ModuleTimeMultiplier_F",
			"ModuleSkiptime_F",
			"ModulePostprocess_F",
			"ModuleTracers_F",
			"ModuleIRGrenade_F",
			"ModuleChemlightBlue_F",
			"ModuleChemlightGreen_F",
			"ModuleChemlightRed_F",
			"ModuleChemlightYellow_F",
			"ModuleMusic_F",
			"ModuleRadio_F",
			"ModuleSound_F",
			"ModuleAnimalsButterflies_F",
			"ModuleAnimalsGoats_F",
			"ModuleAnimalsPoultry_F",
			"ModuleAnimalsSeagulls_F",
			"ModuleAnimalsSheep_F"
		];

		MAZ_EZM_fnc_addObjectsToInterfaceModule = {
			[] spawn {
				private _goodObjects = [];
				{
					if(!(typeOf _x in MAZ_EZM_zeusObjectBlacklist)) then {
						_goodObjects pushBack _x;
					};
				}forEach allMissionObjects "All";
				[_goodObjects] call MAZ_EZM_fnc_addObjectToInterface;
			};
		};

		MAZ_EZM_fnc_getEditableObjectsRadius = {
			params ['_addPos', '_addRadius'];
			private _allObjs = nearestObjects [_addPos, ['ALL'], _addRadius, true];
			private _simpleObjectsInRange = (allSimpleObjects []) select {(_x distance _addPos) <= _addRadius};
			private _objsToAdd = [];
			{
				_addObject = false;
				_className = typeOf _x;
				_isKindOfLogic = _x isKindOf 'Logic';
				_isInWhitelist = _className in MAZ_EZM_zeusObjectWhitelist;
				_isInBlacklist = _className in MAZ_EZM_zeusObjectBlacklist;
				if (_isKindOfLogic) then {
					"If its logic NOT in blacklist OR in whitelist";
					if ((!_isInBlacklist) OR (_isInWhitelist)) then {
						_addObject = true;
					};
				} else {
					"If its NOT logic AND NOT in blacklist";
					if (!_isInBlacklist) then {
						_addObject = true;
					};
				};
				if !(_x getVariable ['JAM_isEditable', true]) then {
					_addObject = false;
				};
				if (_addObject) then {
					_objsToAdd pushBack _x;
				};
			} forEach (_allObjs + _simpleObjectsInRange);
			_objsToAdd;
		};

		MAZ_EZM_fnc_addObjectsToInterfaceRadiusModule = {
			private _pos = [true] call MAZ_EZM_fnc_getScreenPosition;
			["Add Objects to Interface",[
				[
					"SLIDER:RADIUS",
					"Radius",
					[10,2000,250,_pos,[1,1,1,1]]
				],
				[
					"TOOLBOX",
					"Global or Local",
					[true,[["Local","Adds to interface for you only."],["Global","Adds to interface for every zeus."]]]
				]
			],{
				params ["_values","_args","_display"];
				private _radius = round (_values # 0);
				private _isGlobal = _values # 1;
				_isGlobal = [getAssignedCuratorLogic player, allCurators] select _isGlobal;
				private _objects = [_args,_radius] call MAZ_EZM_fnc_getEditableObjectsRadius;
				[_objects,_isGlobal] call MAZ_EZM_fnc_addObjectToInterface;
				_display closeDisplay 1;
			},{
				params ["_values","_args","_display"];
				_display closeDisplay 2;
			},_pos] call MAZ_EZM_fnc_createDialog;
		};

		MAZ_EZM_fnc_toggleAutoAddToInterface = {
			MAZ_EZM_autoAdd = !MAZ_EZM_autoAdd;
			profileNamespace setVariable ["MAZ_EZM_autoAddVar",MAZ_EZM_autoAdd];
			saveProfileNamespace;
			[["Auto Add to Interface disabled","Auto Add to Interface enabled"] select MAZ_EZM_autoAdd,"addItemOk"] call MAZ_EZM_fnc_systemMessage;
		};

		MAZ_EZM_BIS_fnc_remoteControlUnit = {
			params ["_logic","_unit","_activated"];
			if (_activated && local _logic && !isnull curatorcamera) then {

				if !(isnull (missionnamespace getvariable ["bis_fnc_moduleRemoteControl_unit",objnull])) exitwith {};

				private _targetObjArray = curatorMouseOver;
				_unit = _targetObjArray select 1;
				if(isNull _unit) exitWith {
					deletevehicle _logic;
				};
				_unit = effectivecommander _unit;

				private _tempOwner = _unit getvariable ["bis_fnc_moduleRemoteControl_owner", objnull];

				_error = "";
				if !(side group _unit in [east,west,resistance,civilian]) then {_error = localize "str_a3_cfgvehicles_moduleremotecontrol_f_errorEmpty";};
				if (isplayer _unit) then {_error = localize "str_a3_cfgvehicles_moduleremotecontrol_f_errorPlayer";};
				if !(alive _unit) then {_error = localize "str_a3_cfgvehicles_moduleremotecontrol_f_errorDestroyed";};
				if (isnull _unit) then {_error = localize "str_a3_cfgvehicles_moduleremotecontrol_f_errorNull";};
				if (!isnull _tempOwner && {_tempOwner in allPlayers}) then {_error = localize "str_a3_cfgvehicles_moduleremotecontrol_f_errorControl";};
				if (isuavconnected vehicle _unit) then {_error = localize "str_a3_cfgvehicles_moduleremotecontrol_f_errorControl";};

				if (_error == "") then {
					_unit spawn {
						scriptname "bis_fnc_moduleRemoteControl: Loop";
						_unit = _this;
						_vehicle = vehicle _unit;
						_vehicleRole = str assignedvehiclerole _unit;
						private _initialPos = getPosATL player;
						private _initialHidden = isObjectHidden player;

						bis_fnc_moduleRemoteControl_unit = _unit;
						_unit setvariable ["bis_fnc_moduleRemoteControl_owner",player,true];

						[format ["wind%1",ceil random 5],"bis_fnc_playsound"] call bis_fnc_mp;

						_blur = ppeffectcreate ["RadialBlur",144];
						_blur ppeffectenable true;
						_blur ppeffectadjust [0,0,0.3,0.3];
						_blur ppeffectcommit 0;
						_blur ppeffectadjust [0.03,0.03,0.1,0.1];
						_blur ppeffectcommit 1;

						_cam = "camera" camcreate getposatl curatorcamera;
						_cam cameraeffect ["internal","back"];
						_cam campreparetarget (screentoworld [0.5,0.5]);
						_cam camcommitprepared 0;
						_cam campreparetarget _unit;
						_cam campreparefov 0.1;
						_cam camcommitprepared 1;
						sleep 0.75;

						("bis_fnc_moduleRemoteCurator" call bis_fnc_rscLayer) cuttext ["","black out",0.25];
						sleep 0.25;

						(finddisplay 312) closedisplay 2;
						waituntil {isnull curatorcamera};

						player remotecontrol _unit;
						if (cameraon != _vehicle) then {
							_vehicle switchcamera cameraview;
						};
						private _oldGroup = group player;
						private _oldSide = side _oldGroup;
						private _isDamageAllowed = isDamageAllowed player;
						[player] joinSilent (group _unit);
						player allowDamage false;
						player attachTo [_unit,[0,0,0]];
						[player,""] remoteExec ["switchMove"];
						[player,true] remoteExec ["hideObjectGlobal",2];

						ppeffectdestroy _blur;
						_cam cameraeffect ["terminate","back"];
						camdestroy _cam;

						_color = ppeffectcreate ["colorCorrections",1896];
						_color ppeffectenable true;
						_color ppeffectadjust [1,1,0,[0,0,0,1],[1,1,1,1],[0,0,0,0],[0.9,0.0,0,0,0,0.5,1]];
						_color ppeffectcommit 0;

						_curator = getassignedcuratorlogic player;
						[_curator,"curatorObjectRemoteControlled",[_curator,player,_unit,true]] call bis_fnc_callScriptedEventHandler;
						[["Curator","RemoteControl"],nil,nil,nil,nil,nil,nil,true] call bis_fnc_advHint;

						sleep 0.3;
						_color ppeffectadjust [1,1,0,[0,0,0,1],[1,1,1,1],[0,0,0,0],[0.9,0.85,0,0,0,0.5,1]];
						_color ppeffectcommit 0.3;
						("bis_fnc_moduleRemoteCurator" call bis_fnc_rscLayer) cuttext ["","black in",0.5];

						_vehicle = vehicle _unit;
						_vehicleRole = str assignedvehiclerole _unit;
						_rating = rating player;
						waituntil {
							if ((vehicle _unit != _vehicle || str assignedvehiclerole _unit != _vehicleRole) && {alive _unit}) then {
								player remotecontrol _unit;
								_vehicle = vehicle _unit;
								_vehicleRole = str assignedvehiclerole _unit;
							};
							if (rating player < _rating) then {
								player addrating (-rating player + _rating);
							};
							sleep 0.01;
							!isnull curatorcamera
							||
							{cameraon == vehicle player}
							||
							{!alive _unit}
							||
							{!alive player}
							||
							{isnull getassignedcuratorlogic player}
						};

						player addrating (-rating player + _rating);
						objnull remotecontrol _unit;
						_unit setvariable ["bis_fnc_moduleRemoteControl_owner",nil,true];

						if (alive player) then {
							if (
								isnull curatorcamera
								&&
								{cameraon != vehicle player}
								&&
								{!isnull _unit}
								&&
								{!isnull getassignedcuratorlogic player}
							) then {
								sleep 2;
								("bis_fnc_moduleRemoteCurator" call bis_fnc_rscLayer) cuttext ["","black out",1];
								sleep 1;
							};
							if !(isnull _unit) then {
								_unitPos = getposatl _unit;
								_camPos = [_unitPos,10,direction _unit + 180] call bis_fnc_relpos;
								_camPos set [2,(_unitPos select 2) + (getterrainheightasl _unitPos) - (getterrainheightasl _camPos) + 10];
								(getassignedcuratorlogic player) setvariable ["bis_fnc_modulecuratorsetcamera_params",[_camPos,_unit]];
							};

							sleep 0.1;
							("bis_fnc_moduleRemoteCurator" call bis_fnc_rscLayer) cuttext ["","black in",1e10];
							opencuratorinterface;
							ppeffectdestroy _color;

							waituntil {!isnull curatorcamera};
						} else {
							ppeffectdestroy _color;
						};
						player switchcamera cameraview;
						bis_fnc_moduleRemoteControl_unit = nil;
						("bis_fnc_moduleRemoteCurator" call bis_fnc_rscLayer) cuttext ["","black in",1];
						[_curator,"curatorObjectRemoteControlled",[_curator,player,_unit,false]] call bis_fnc_callScriptedEventHandler;
						detach player;
						player setPos _initialPos;
						if(_isDamageAllowed) then {
							[] spawn {
								waitUntil {vectorMagnitude velocity player == 0};
								sleep 0.1;
								player allowDamage true;
							};
						};
						if(isNull _oldGroup) then {
							[player] joinSilent (createGroup [_oldSide,true]);
						} else {
							[player] joinSilent _oldGroup;
						};
						[player,_initialHidden] remoteExec ["hideObjectGlobal",2];
						sleep 0.01;
					};
				} else {
					[objnull,_error] call bis_fnc_showCuratorFeedbackMessage;
				};
				deletevehicle _logic;
			};
		};

		MAZ_EZM_fnc_toggleCleaner = {
			MAZ_EZM_enableCleaner = !MAZ_EZM_enableCleaner;
			[["Auto Cleaner disabled","Auto Cleaner enabled"] select MAZ_EZM_enableCleaner,"addItemOk"] call MAZ_EZM_fnc_systemMessage;
			profileNamespace setVariable ["MAZ_EZM_autoCleanerVar",MAZ_EZM_enableCleaner];
		};