MAZ_EZM_fnc_getAllWeapons = {
			private _cfgs = (configFile >> "CfgWeapons") call BIS_fnc_getCfgSubClasses;
			private _weapons = [];
			{
				if !(_x isKindOf ["Rifle", configFile >> "CfgWeapons"] || _x isKindOf ["MGun", configFile >> "CfgWeapons"]) then {continue};
				if(getText (configFile >> "CfgWeapons" >> _x >> "model") == "") then {continue};
				private _cfg = (configFile >> "CfgWeapons" >> _x);
				private _scope = getNumber (_cfg >> "Scope");
				private _parents = [_cfg, true] call BIS_fnc_returnParents;
				private _parent = _parents select 1;
				if (
					(_parent isKindOf ["Rifle", configFile >> "CfgWeapons"] || _parent isKindOf ["MGun", configFile >> "CfgWeapons"]) &&
					(getNumber (configFile >> "CfgWeapons" >> _parent >> "scope") >= 2)
				) then {
					_x = _parent;
				};
				if(_scope >= 2) then {
					_weapons pushBackUnique _x;
				};
			}forEach _cfgs;
			_weapons
		};

		MAZ_EZM_fnc_tracerModuleDialog = {
			private _weapons = call MAZ_EZM_fnc_getAllWeapons;
			_weapons = [_weapons,[],{getText (configFile >> "CfgWeapons" >> _x >> "displayName")}, "ASCEND"] call BIS_fnc_sortBy;
			["CREATE TRACERS",[
				[
					"SIDES",
					"Tracer Owner:",
					opfor
				],
				[
					"SLIDER",
					["Minimum Time:","The minimum time between bursts."],
					[2,10,5]
				],
				[
					"SLIDER",
					["Maximum Time:","How maximum time between bursts."],
					[5,25,10]
				],
				[
					"LIST",
					["Weapon:","The weapon that will be firing."],
					[
						_weapons,
						(_weapons apply {
							[
								getText (configFile >> "CfgWeapons" >> _x >> "displayName"),
								"",
								getText (configFile >> "CfgWeapons" >> _x >> "picture")
							]
						}),
						0,
						6
					]
				],
				[
					"EDIT",
					["Weapon Override:",format ["Entering a classname here will use this weapon instead of what is selected in the list.\nYour current weapon: %1",primaryWeapon player]],
					[""]
				]
			],{
				params ["_values","_pos","_display"];
				if(_values # 0 == civilian) exitWith {
					["You can't make civilians fire tracers...","addItemFailed"] call MAZ_EZM_fnc_systemMessage;
				};
				_values params ["_side","_min","_max","_weapon","_weaponOverride"];
				if(_weaponOverride != "") then {
					private _weaponCfg = configFile >> "CfgWeapons" >> _weaponOverride;
					if(!isClass _weaponCfg) exitWith {
						["The weapon supplied doesn't exist. Make sure to not include quotation marks.","addItemFailed"] call MAZ_EZM_fnc_systemMessage;
					};
					_weapon = _weaponOverride;
				};
				_values = [_side,_min,_max,_weapon];
				private _origin = "Land_HelipadEmpty_F" createVehicle _pos;
				_origin setPos _pos;
				[
					"Select Target",
					{
						params ["_origin","_position","_args","_shift","_ctrl","_alt"];
						deleteVehicle _origin;
						_args params ["_values","_pos"];
						private _hovering = curatorMouseOver;
						if(_hovering isEqualTo [""]) exitWith {
							_values set [4,str (AGLToASL _position)];
							[_values,_pos] call MAZ_EZM_fnc_tracerModule;
						};
						_hovering params ["_type","_object"];
						if(_object isEqualType objNull) exitWith {
							private _index = missionNamespace getVariable ["MAZ_EZM_tracerTargetIndex",0];
							private _varName = format ["MAZ_EZM_tracerTargetVar_%1",_index];
							missionNamespace setVariable ["MAZ_EZM_tracerTargetIndex",_index + 1,true];
							missionNamespace setVariable [_varName,_object,true];
							_values set [4,_varName];
							[_values,_pos] call MAZ_EZM_fnc_tracerModule;
						};
					},
					_origin,
					[_values,_pos]
				] call MAZ_EZM_fnc_selectSecondaryPosition;
				_display closeDisplay 1;
			},{
				params ["_values","_args","_display"];
				_display closeDisplay 2;
			},[true] call MAZ_EZM_fnc_getScreenPosition] call MAZ_EZM_fnc_createDialog;
		};

		MAZ_EZM_fnc_tracerModule = {
			params ["_values","_position"];
			_values params ["_side","_min","_max","_weapon",["_target",objNull]];
			private _logic = (createGroup [sideLogic,true]) createUnit ["ModuleTracers_F",_position, [], 0, "NONE"];
			[_logic] call MAZ_EZM_fnc_addObjectToInterface;
			_logic setVariable ["Side",str (_side call BIS_fnc_sideID),true];
			_logic setVariable ["Min",str (round _min),true];
			_logic setVariable ["Max",str (round _max),true];
			_logic setVariable ["Weapon",_weapon,true];
			private _magazines = (getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines")) select {"tracer" in (toLower _x)};
			if(_magazines isEqualTo []) then {
				_magazines = ([_weapon] call BIS_fnc_compatibleMagazines) select {"tracer" in (toLower _x)};
				if(_magazines isEqualTo []) then {
					_magazines = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines");
				};
			};
			_logic setVariable ["Magazine",selectRandom _magazines,true];
			_logic setVariable ["Target",_target,true];
			[[_logic],{
				params ["_logic"];
				sleep 0.1;
				[_logic,true] call BIS_fnc_moduleTracers;
			}] remoteExec ['spawn',2];

			_logic spawn {
				waitUntil {uiSleep 0.1; !isNull (_this getVariable ["bis_fnc_moduleTracers_gunner",objNull])};
				private _gunner = _this getVariable "bis_fnc_moduleTracers_gunner";
				[_gunner,true] remoteExec ['hideObjectGlobal',2];
			};
		};

		MAZ_EZM_fnc_ambientFlyByModule = {
			comment "TODO:FINISH ME";
		};

		MAZ_EZM_fnc_toggleLampsModule = {
			private _pos = [true] call MAZ_EZM_fnc_getScreenPosition;
			["Toggle City Lights",[
				[
					"SLIDER:RADIUS",
					"Radius",
					[10,250,100,_pos,[1,1,1,1]]
				],
				[
					"TOOLBOX",
					"Toggle Mode",
					[true,["Turn On","Turn Off"]]
				]
			],{
				params ["_values","_args","_display"];
				_values params ["_radius","_mode"];
				private _types = [
					"Lamps_Base_F",
					"Land_LampAirport_F",
					"Land_LampSolar_F",
					"Land_LampStreet_F",
					"Land_LampStreet_small_F",
					"PowerLines_base_F",
					"Land_LampDecor_F",
					"Land_LampHalogen_F",
					"Land_LampHarbour_F",
					"Land_LampShabby_F",
					"Land_PowerPoleWooden_L_F",
					"Land_NavigLight",
					"Land_runway_edgelight",
					"Land_runway_edgelight_blue_F",
					"Land_Flush_Light_green_F",
					"Land_Flush_Light_red_F",
					"Land_Flush_Light_yellow_F",
					"Land_Runway_PAPI",
					"Land_Runway_PAPI_2",
					"Land_Runway_PAPI_3",
					"Land_Runway_PAPI_4",
					"Land_fs_roof_F",
					"Land_fs_sign_F"
				];
				private _nearestLamps = nearestObjects [_args,_types, _radius];
				private _damage = [0.0,0.97] select _mode;
				{_x setDamage _damage;} forEach _nearestLamps;
				_display closeDisplay 1;
			},{
				params ["_values","_args","_display"];
				_display closeDisplay 2;
			},_pos] call MAZ_EZM_fnc_createDialog;
		};

		MAZ_EZM_fnc_createParticleEffectModule = {
			private _pos = [true] call MAZ_EZM_fnc_getScreenPosition;
			[
				"Particle Effect Creator",
				[
					[
						"COMBO",
						"Particle Type:",
						[
							["FIRE_SMALL","FIRE_MEDIUM","FIRE_BIG","SMOKE_SMALL","SMOKE_MEDIUM","SMOKE_BIG"],
							["Fire (Small)","Fire (Medium)","Fire (Big)","Smoke (Small)","Smoke (Medium)","Smoke (Big)"],
							0
						]
					]
				],
				{
					params ["_values","_pos","_display"];
					_values params ["_type"];
					private _particleData = [_type,_pos] call MAZ_EZM_fnc_createParticleEffect;
					_particleData params ["_particle",["_light", objNull]];
					private _helipad = attachedTo _particle;
					if(_type == "FIRE_SMALL") then {
						private _smokeData = ["SMOKE_SMALL",_pos] call MAZ_EZM_fnc_createParticleEffect;
						_smokeData params ["_smoke"];

						private _helipadSmoke = attachedTo _smoke;
						detach _smoke;
						deleteVehicle _helipadSmoke;
						_smoke attachTo [_helipad,[0,0,0]];
					};
					if(_type == "FIRE_MEDIUM") then {
						private _smokeData = ["SMOKE_MEDIUM",_pos] call MAZ_EZM_fnc_createParticleEffect;
						_smokeData params ["_smoke"];

						private _helipadSmoke = attachedTo _smoke;
						detach _smoke;
						deleteVehicle _helipadSmoke;
						_smoke attachTo [_helipad,[0,0,0]];
					};
					if(_type == "FIRE_BIG") then {
						private _smokeData = ["SMOKE_BIG",_pos] call MAZ_EZM_fnc_createParticleEffect;
						_smokeData params ["_smoke"];

						private _helipadSmoke = attachedTo _smoke;
						detach _smoke;
						deleteVehicle _helipadSmoke;
						_smoke attachTo [_helipad,[0,0,0]];
					};
					_display closeDisplay 1;
				},
				{
					params ["_values","_args","_display"];
					_display closeDisplay 2;
				},
				_pos
			] call MAZ_EZM_fnc_createDialog;
		};

		MAZ_EZM_fnc_createParticleEffect = {
			params ["_type","_pos"];
			private _particle = "#particlesource" createVehicle [0,0,0];
			private _lightData = switch (_type) do {
				case "SMOKE_SMALL": {
					_particle setParticleClass "SmallDestructionSmoke";
					[];
				};
				case "SMOKE_MEDIUM": {
					_particle setParticleClass "MediumSmoke";
					[];
				};
				case "SMOKE_BIG": {
					_particle setParticleClass "BigDestructionSmoke";
					[];
				};
				case "FIRE_SMALL": {
					_pos = _pos vectorAdd [0,0,0.05];
					_particle setParticleClass "SmallDestructionFire";
					[
						1,
						[1,0.85,0.6],
						[1,0.3,0],
						50,
						[0,0,0,2]
					];
				};
				case "FIRE_MEDIUM": {
					_particle setParticleClass "MediumDestructionFire";
					[
						1,
						[1,0.85,0.6],
						[1,0.3,0],
						400,
						[0,0,0,2]
					];
				};
				case "FIRE_BIG": {
					_particle setParticleClass "BigDestructionFire";
					[
						1,
						[1,0.85,0.6],
						[1,0.45,0.3],
						1600,
						[0,0,0,1.6]
					];
				};
				default {[false]};
			};
			private _helipad = "Land_HelipadEmpty_F" createVehicle [0,0,0];
			_helipad setPos _pos;
			[_helipad] call MAZ_EZM_fnc_addObjectToInterface;
			[_helipad] call MAZ_EZM_fnc_deleteAttachedWhenDeleted;
			_particle attachTo [_helipad,[0,0,0]];
			if(count _lightData == 0) exitWith {[_particle,objNull]};
			if(count _lightData == 1) exitWith {objNull};
			private _light = createVehicle ["#lightpoint",[0,0,0], [], 0, "CAN_COLLIDE"];
			[_light,_lightData # 0] remoteExec ["setLightBrightness",0,_light];
			[_light,_lightData # 1] remoteExec ["setLightColor",0,_light];
			[_light,_lightData # 2] remoteExec ["setLightAmbient",0,_light];
			[_light,_lightData # 3] remoteExec ["setLightIntensity",0,_light];
			[_light,_lightData # 4] remoteExec ["setLightAttenuation",0,_light];
			[_light,true] remoteExec ["setLightDayLight",0,_light];
			_light attachTo [_helipad,[0,0,1]];
			[_particle,_light];
		};

		MAZ_EZM_fnc_earthquakeEffectModule = {
			[
				"Earthquake Module",
				[
					[
						"SLIDER",
						"Earthquake Strength:",
						[
							1,
							4,
							2
						]
					]
				],
				{
					params ["_values","_pos","_display"];
					_values params ["_strength"];
					[_strength] remoteExec ['BIS_fnc_earthquake'];
					_display closeDisplay 1;
				},
				{
					params ["_values","_args","_display"];
					_display closeDisplay 2;
				}
			] call MAZ_EZM_fnc_createDialog;
		};