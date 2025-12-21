
		MAZ_EZM_fnc_doorConfig = {
			params ["_building"];
			private _doors = [_building] call MAZ_EZM_fnc_getDoors;
			if(_doors isEqualTo []) exitWith {};

			private _display = findDisplay 312;
			private _existingControls = [];

			private _icon = [
				"\a3\modules_f\data\editterrainobject\icon3d_doorclosed32_ca.paa",
				"\a3\modules_f\data\editterrainobject\icon3d_doorlocked32_ca.paa",
				"\a3\modules_f\data\editterrainobject\icon3d_dooropened32_ca.paa"
			];
			{
				if((ctrlText _x) in _icon) then {
					ctrlDelete _x;
				};
			}forEach allControls _display;

			private _controls = [];
			{
				private _control = _display ctrlCreate ["RscActivePicture",-1];

				_control setVariable ["params",[_building,_forEachIndex + 1]];
				_control ctrlAddEventHandler ["ButtonClick",{
					params ["_control"];
					(_control getVariable "params") params ["_building","_door"];
					[_building,_door] call MAZ_EZM_fnc_doorSetState;
				}];
				_control ctrlCommit 0;

				_controls pushBack _control;
			}forEach _doors;

			["MAZ_updateDoorsEachFrame","onEachFrame",{
				params ["_building","_doors","_controls"];
				if(isNull (findDisplay 312)) exitWith {
					["MAZ_updateDoorsEachFrame","onEachFrame"] call BIS_fnc_removeStackedEventHandler;
				};

				if(curatorCamera distance _building > 200) then {
					["MAZ_updateDoorsEachFrame","onEachFrame"] call BIS_fnc_removeStackedEventHandler;
					{ctrlDelete _x} forEach _controls;
				};
				
				{
					private _control = _controls select _forEachIndex;

					private _position = _building modelToWorldVisual _x;
					private _distance = curatorCamera distance _position;
					private _screenPos = worldToScreen _position;
					
					if(_screenPos isEqualTo [] || {_distance > 100}) then {
						_control ctrlShow false;
					} else {
						_control ctrlShow true;

						private _state = [_building,_forEachIndex + 1] call MAZ_EZM_fnc_doorGetState;
						private _icon = [
							"\a3\modules_f\data\editterrainobject\icon3d_doorclosed32_ca.paa",
							"\a3\modules_f\data\editterrainobject\icon3d_doorlocked32_ca.paa",
							"\a3\modules_f\data\editterrainobject\icon3d_dooropened32_ca.paa"
						] select _state;
						private _color = [
							[1,1,1,1],
							[1,1,1,1],
							[1,1,1,1]
						] select _state;

						_control ctrlSetText _icon;
						_control ctrlSetActiveColor _color;

						_color set [3,0.8];
						_control ctrlSetTextColor _color;

						_screenPos params ["_posX","_posY"];

						private _size = linearConversion [0,100,_distance,1.75,1,true];
						private _posW = ["W",_size] call MAZ_EZM_fnc_convertToGUI_GRIDFormat;
						private _posH = ["H",_size] call MAZ_EZM_fnc_convertToGUI_GRIDFormat;

						_control ctrlSetPosition [_posX - _posW / 2, _posY - _posH / 2,_posW,_posH];
						_control ctrlCommit 0;
					};
				} forEach _doors;
			},[_building,_doors,_controls]] call BIS_fnc_addStackedEventHandler;
		};

		MAZ_EZM_fnc_getDoors = {
			params ["_building"];
			private _cfg = (configOf _building >> "UserActions");
			if !(isClass _cfg) exitWith {[]};

			private _positions = [];
			private _position = "";

			for "_doorID" from 1 to 24 do {
				_position = getText(_cfg >> format["OpenDoor_%1",_doorID] >> "position");
				if (_position == "") exitWith {};
				_positions pushBack (_building selectionPosition _position);
			};

			if (count _positions == 0) exitWith {[]};

			_positions
		};

		MAZ_EZM_fnc_doorSetState = {
			params ["_building","_door"];
			private _state = [_building,_door] call MAZ_EZM_fnc_doorGetState;

			_building setVariable [format ["bis_disabled_door_%1",_door],[1, 0, 0] select _state, true];
			_building animateSource [format ["door_%1_sound_source", _door], [0, 1, 0] select _state, false];
			_building animateSource [format ["door_%1_noSound_source", _door], [0, 1, 0] select _state, false];
		};

		MAZ_EZM_fnc_doorGetState = {
			params ["_building","_door"];
			private _var = _building getVariable [(format ["bis_disabled_door_%1",_door]),0];

			comment "If locked, exit function";
			if(_var == 1) exitWith {1};
			comment "Get animationSourcePhase from door, if closed return 0, if open return 2.";
			[0,2] select (_building animationSourcePhase (format ["door_%1_sound_source", _door]) > 0.5)
		};

		MAZ_EZM_fnc_initDoorModule = {
			params ["_pos"];
			private _building = nearestObject [_pos, "Building"];

			if(isNull _building) exitWith {["No near buildings!","addItemFailed"] call MAZ_EZM_fnc_systemMessage;};
			[_building] call MAZ_EZM_fnc_doorConfig;
		};

		MAZ_EZM_fnc_openDoorsModule = {
			[[true] call MAZ_EZM_fnc_getScreenPosition] call MAZ_EZM_fnc_initDoorModule;
		};

		MAZ_EZM_fnc_godModeFencesModule = {
			private _pos = [true] call MAZ_EZM_fnc_getScreenPosition;
			["God Mode Fences",[
				[
					"SLIDER:RADIUS",
					"Fences Radius:",
					[10,200,25,_pos,[1,1,1,1]]
				]
			],{
				params ["_values","_pos","_display"];
				_values params ["_radius"];
				
				private _blackListFences = [
					"land_pipewall_conretel_8m_f","land_mil_wiredfence_gate_f","land_mil_concretewall_f","land_cncbarrier_f","land_cncbarrier_stripes_f",
					"land_concrete_smallwall_8m_f","land_concrete_smallwall_4m_f",
					"land_brickwall_04_l_pole_f","land_brickwall_03_l_pole_f",
					"land_polewall_01_pole_f","land_brickwall_04_l_5m_d_f","land_slums01_pole",
					"land_canal_wall_stairs_f","land_mil_wallbig_4m_damaged_left_f","land_backalley_01_l_1m_f",
					"land_brickwall_04_l_5m_old_d_f","land_brickwall_02_l_5m_d_f","land_brickwall_03_l_5m_v2_d_f",
					"land_mil_wallbig_gate_f","land_canal_wall_d_center_f","land_backalley_01_l_gap_f","land_bamboofence_01_s_d_f",
					"land_brickwall_04_l_pole_old_f","land_backalley_01_l_gate_f","land_concretewall_01_m_d_f","land_concretewall_01_l_d_f",
					"land_hbarrier_01_wall_4_green_f","land_concretewall_02_m_d_f","land_brickwall_02_l_corner_v2_f","land_brickwall_03_l_5m_v1_d_f",
					"land_gravefence_02_f","land_mil_wallbig_debris_f","land_stone_gate_f","land_stone_8md_f",
					"land_canal_wallsmall_10m_f","land_canal_wall_10m_f","land_new_wiredfence_10m_dam_f","land_new_wiredfence_pole_f","land_slums02_pole",
					"land_canal_wall_d_left_f","land_city_8md_f","land_city2_8md_f","land_wall_tin_pole","land_mil_wiredfenced_f","land_ancient_wall_8m_f",
					"land_ancient_wall_4m_f","land_wall_indcnc_pole_f","land_canal_wall_d_right_f","land_wall_indcnc_end_2_f","land_indfnc_pole_f",
					"land_indfnc_3_d_f","land_bamboofence_01_s_pole_f","land_backalley_02_l_1m_f","land_woodenwall_02_s_pole_f",
					"land_concretewall_02_m_pole_f","land_hbarrier_01_wall_6_green_f","land_wiredfence_01_pole_45_f","land_brickwall_01_l_end_f",
					"land_gravefence_01_f","land_brickwall_01_l_pole_f","land_wallcity_01_8m_dmg_whiteblue_f","land_pipefence_01_m_d_f",
					"land_wallcity_01_8m_dmg_pink_f","land_concretewall_01_l_pole_f","land_concretewall_03_m_pole_f","land_netfence_03_m_pole_f",
					"land_mil_wallbig_4m_damaged_center_f","land_pipefence_01_m_pole_f","land_wiredfence_01_8m_d_f","land_gravefence_04_f",
					"land_brickwall_01_l_5m_d_f","land_brickwall_02_l_end_f","land_silagewall_01_l_pole_f","land_wiredfence_01_pole_f",
					"land_camoconcretewall_01_pole_v1_f","land_woodenwall_01_m_pole_f","land_netfence_02_m_pole_f","land_camoconcretewall_01_l_end_v1_f",
					"land_wiredfence_01_gate_f","land_tinwall_01_m_pole_f","land_gameprooffence_01_l_d_f","land_hbarrier_01_wall_corner_green_f",
					"land_mil_wallbig_4m_damaged_right_f","land_netfence_03_m_3m_d_f","land_tinwall_02_l_pole_f","land_wallcity_01_8m_dmg_yellow_f",
					"land_netfence_02_m_d_f","land_gravefence_03_f","land_wallcity_01_8m_dmg_grey_f","land_wallcity_01_8m_dmg_blue_f",
					"land_quayconcrete_01_20m_wall_f","land_fortress_01_innercorner_90_f","land_fortress_01_innercorner_70_f","land_fortress_01_5m_f",
					"land_woodenwall_03_s_d_5m_v1_f","land_fortress_01_outtercorner_80_f","land_pipefence_02_s_8m_f","land_woodenwall_05_m_d_4m_f",
					"land_fortress_01_d_r_f","land_woodenwall_02_s_8m_f","land_woodenwall_04_s_pole_f","land_petroglyphwall_01_f",
					"land_hbarrierwall_corner_f","land_basaltwall_01_4m_f","land_hbarrierwall4_f","land_wired_fence_4m_f","land_wired_fence_8m_f",
					"land_mound02_8m_f","land_mound01_8m_f","land_wall_tin_4_2","land_hbarrier_1_f","land_mil_wiredfence_f","land_razorwire_f",
					"land_slums01_8m","land_slums02_4m","land_hbarrier_5_f","land_hbarrier_big_f","land_pipe_fence_4m_f","land_sportground_fence_f",
					"land_hbarrier_3_f","land_net_fenced_8m_f","land_net_fence_pole_f","land_net_fence_8m_f","land_net_fence_4m_f",
					"land_wired_fence_4md_f","land_wired_fence_8md_f","land_pipefence_02_s_4m_f","land_woodenwall_05_m_4m_v2_f",
					"land_woodenwall_04_s_end_v2_f","land_woodenwall_04_s_d_5m_f","land_basaltwall_01_d_right_f","land_woodenwall_01_m_4m_f",
					"land_woodenwall_02_s_4m_f","land_woodenwall_05_m_end_f","land_woodenwall_03_s_pole_f","land_woodenwall_04_s_end_v1_f",
					"land_woodenwall_03_s_5m_v1_f","land_petroglyphwall_02_f","land_woodenwall_03_s_d_5m_v2_f","land_woodenwall_01_m_8m_f",
					"land_tinwall_02_l_4m_f","land_vineyardfence_01_f","land_slumwall_01_s_2m_f","land_hbarrierwall_corridor_f",
					"land_basaltwall_01_gate_f","land_tinwall_01_m_4m_v2_f","land_plasticnetfence_01_long_f","land_plasticnetfence_01_short_f",
					"land_plasticnetfence_01_short_d_f","land_fortress_01_outtercorner_50_f","land_fortress_01_innercorner_110_f",
					"land_polewall_03_5m_v1_f","land_hbarrierwall6_f","land_slumwall_01_s_4m_f","land_hedge_01_s_4m_f","land_polewall_03_5m_v2_f",
					"land_gameprooffence_01_l_pole_f","land_woodenwall_03_s_5m_v2_f","land_woodenwall_04_s_5m_f","land_woodenwall_05_m_pole_f",
					"land_bamboofence_01_s_4m_f","land_bamboofence_01_s_8m_f","land_plasticnetfence_01_pole_f","land_plasticnetfence_01_long_d_f",
					"land_castleruins_01_wall_d_l_f","land_hedge_01_s_2m_f","land_stonewall_01_s_10m_f","land_tinwall_01_m_4m_v1_f",
					"land_polewall_03_end_f","land_hbarriertower_f","land_woodenwall_02_s_2m_f","land_tinwall_02_l_8m_f","land_wall_tin_4",
					"land_stonewall_01_s_d_f","land_woodenwall_01_m_d_f","land_gameprooffence_01_l_gate_f","land_fortress_01_10m_f",
					"land_stonewall_02_s_10m_f","land_woodenwall_05_m_4m_v1_f","land_woodenwall_03_s_d_pole_f","land_woodenwall_02_s_d_f",
					"land_gameprooffence_01_l_5m_f","land_mound04_8m_f","land_fortress_01_outtercorner_90_f","land_mound03_8m_f",
					"land_castleruins_01_wall_d_r_f","land_castleruins_01_wall_10m_f","land_fortress_01_d_l_f","land_basaltwall_01_8m_f",
					"land_basaltwall_01_d_left_f","land_castle_01_wall_01_f","land_castle_01_wall_02_f","land_castle_01_wall_03_f",
					"land_castle_01_wall_04_f","land_castle_01_wall_05_f","land_castle_01_wall_06_f","land_castle_01_wall_07_f","land_castle_01_wall_08_f",
					"land_castle_01_wall_09_f","land_castle_01_wall_10_f","land_castle_01_wall_11_f","land_castle_01_wall_12_f","land_castle_01_wall_13_f",
					"land_castle_01_wall_14_f","land_castle_01_wall_15_f","land_castle_01_wall_16_f","land_pipe_fence_4mnolc_f","land_crash_barrier_f",
					"land_crashbarrier_01_4m_f","land_crashbarrier_01_8m_f","land_crashbarrier_01_end_l_f","land_crashbarrier_01_end_r_f",
					"land_castle_01_church_ruin_f","land_castle_01_church_b_ruin_f","land_castle_01_step_f","land_pier_wall_f","land_castle_01_house_ruin_f",
					"land_new_wiredfence_5m_f","land_new_wiredfence_10m_f","land_cncbarriermedium_f","land_sportground_fence_nolc_f","land_cncwall1_f",
					"land_cncwall4_f","land_cncshelter_f"
				];
				private  _count = 0;
				{
					if(!alive _x) then {continue};
					private _modelString = ((str _x) splitString ":" select 1) select [1];
					private _removeExtension = _modelString splitString "." select 0; 
					private _type = format ['land_%1',_removeExtension];
					
					if !((toLower _type) in _blackListFences) then {
						_count = _count + 1;
						private _position = getPosASL _x;
						private _newObj = createSimpleObject [format ["%1",_type],_position];
						_newObj setPosASL _position;
						_newObj setVectorDirAndUp [vectorDir _x,surfaceNormal _position];
						if("pillar" in _type) then {
							_newObj setVectorUp (vectorUp _x);
						};
						[_x,true] remoteExec ["hideObjectGlobal",2];
						[_x,false] remoteExec ["allowDamage"];
					};
				}forEach (nearestTerrainObjects [_pos,["WALL","FENCE"],_radius]);

				[format ["%1 fences replaced!",_count],"addItemOk"] call MAZ_EZM_fnc_systemMessage;
				_display closeDisplay 1;
			},{
				params ["_values","_args","_display"];
				_display closeDisplay 2;
			},_pos] call MAZ_EZM_fnc_createDialog;
		};

		MAZ_EZM_fnc_hideTerrainRadiusModule = {
			private _pos = [true] call MAZ_EZM_fnc_getScreenPosition;
			["Hide Terrain Objects",[
				[
					"SLIDER:RADIUS",
					"Radius",
					[1,250,50,_pos,[1,1,1,1]]
				],
				[
					"TOOLBOX",
					"Hide or Show",
					[true,[["SHOW","Reveals the terrain objects within the radius."],["HIDE","Hides terrain objects within the radius."]]]
				],
				[
					"TOOLBOX",
					"Buildings",
					[true,[["NO","Don't apply to buildings."],["YES","Apply to buildings."]]]
				],
				[
					"TOOLBOX",
					"Fences and Walls",
					[true,[["NO","Don't apply to fences and walls."],["YES","Apply to fences and walls."]]]
				],
				[
					"TOOLBOX",
					"Vegetation",
					[true,[["NO","Don't apply to vegetation."],["YES","Apply to vegetation."]]]
				],
				[
					"TOOLBOX",
					"Other",
					[true,[["NO","Don't apply to other objects."],["YES","Apply to other objects."]]]
				]
			],{
				params ["_values","_args","_display"];
				_values params ["_radius","_hide","_buildings","_fences","_veg","_other"];
				if(!_buildings && !_fences && !_veg && !_other) exitWith {
					["You didn't even select any options...","addItemFailed"] call MAZ_EZM_fnc_systemMessage;
				};
				private _nearestObjects = [];
				if(_buildings) then {
					_nearestObjects = _nearestObjects + (nearestTerrainObjects [_args,["BUILDING","HOUSE","CHURCH","CHAPEL","FUELSTATION","HOSPITAL","RUIN","BUNKER"],_radius,false,true]);
				};
				if(_fences) then {
					_nearestObjects = _nearestObjects + (nearestTerrainObjects [_args,["WALL","FENCE"],_radius,false,true]);
				};
				if(_veg) then {
					_nearestObjects = _nearestObjects + (nearestTerrainObjects [_args,["TREE","SMALL TREE","BUSH"],_radius,false,true]);
				};
				if(_other) then {
					_nearestObjects = _nearestObjects + (nearestTerrainObjects [_args,["ROCK","ROCKS","FOREST BORDER","FOREST TRIANGLE","FOREST SQUARE","CROSS","FORTRESS","FOUNTAIN","VIEW-TOWER","LIGHTHOUSE","QUAY","HIDE","BUSSTOP","ROAD","FOREST","TRANSMITTER","STACK","TOURISM","WATERTOWER","TRACK","MAIN ROAD","POWER LINES","RAILWAY","POWERSOLAR","POWERWAVE","POWERWIND","SHIPWRECK","TRAIL"],_radius,false,true]);
				};
				if(_hide) then {
					{
						[_x,true] remoteExec ["hideObjectGlobal",2];
						[_x,false] remoteExec ["allowDamage"];
					} forEach _nearestObjects;
				} else {
					{
						[_x,false] remoteExec ["hideObjectGlobal",2];
						[_x,true] remoteExec ["allowDamage"];
					} forEach _nearestObjects;
				};
				_display closeDisplay 1;
			},{
				params ["_values","_args","_display"];
				_display closeDisplay 2;
			},_pos] call MAZ_EZM_fnc_createDialog;
		};