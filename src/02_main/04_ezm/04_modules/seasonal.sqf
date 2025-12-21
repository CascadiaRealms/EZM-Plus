
		MAZ_EZM_fnc_isInRange = {
			params ["_start","_end","_num"];
			if(_num >= _start && _num <= _end) exitWith {true};
			false
		};

		MAZ_EZM_fnc_getHoliday = {
			(systemTimeUTC) params ["_year","_month","_day","_hr","_min","_s","_ms"];

			comment "New Years";
			if((_month == 12 && _day == 31) || (_month == 1 && _day == 1)) exitWith {"NewYears"};

			comment "Valentines Day";
			if(_month == 2 && _day == 14) exitWith {"Valentines"};

			comment "St. Patricks Day";
			if(_month == 3 && _day == 17) exitWith {"StPatricks"};

			comment "April Fools";
			if(_month == 4 && _day == 1) exitWith {"AprilFools"};

			comment "Easter";
			if(_month == 4 && _day == 17) exitWith {"Easter"};

			comment "July 4th";
			if(_month == 7 && _day == 4) exitWith {"July4th"};

			comment "Halloween";
			if(_month == 10 && ([24,31,_day] call MAZ_EZM_fnc_isInRange)) exitWith {"Halloween"};

			comment "Veterans Day";
			if(_month == 11 && _day == 11) exitWith {"Veterans"};

			comment "Christmas";
			if(_month == 12 && ([1,31,_day] call MAZ_EZM_fnc_isInRange)) exitWith {"Christmas"};
			""
		};

		MAZ_EZM_fnc_isHoliday = {
			private _holiday = call MAZ_EZM_fnc_getHoliday;
			if(_holiday != "") exitWith {true};
			false
		};

		switch (call MAZ_EZM_fnc_getHoliday) do {
			case "Christmas": {
				MAZ_EZM_holidayFunctions = {
					MAZ_EZM_fnc_createChristmasTree = {
						private _pos = [true] call MAZ_EZM_fnc_getScreenPosition;
						private _tree = createSimpleObject ["a3\Vegetation_F_Enoch\Tree\t_PiceaAbiesNativitatis_2s.p3d",_pos]; 
						private _helipad = "Land_HelipadEmpty_F" createVehicle _pos;
						_helipad setPos _pos;
						_tree attachto [_helipad, [0,0,8.1]];
						[_helipad] call MAZ_EZM_fnc_addObjectToInterface;
						[_helipad] call MAZ_EZM_fnc_deleteAttachedWhenDeleted;
					};

					MAZ_EZM_fnc_createSantaHostage = {
						private _santa = [west, "I_G_Story_SF_Captain_F"] call MAZ_EZM_fnc_createMan;
						[_santa] spawn {
							params ["_santa"];
							sleep 0.1;
							comment "SANTA_1 UNIT INIT";  
						
							_santa setVariable ["BIS_enableRandomization", false];   
							_santa setUnitLoadout [["sgun_HunterShotgun_01_sawedoff_F","","","",["2Rnd_12Gauge_Pellets",2],[],""],[],[],["U_C_Paramedic_01_F",[["FirstAidKit",1],["Chemlight_green",1,1],["2Rnd_12Gauge_Pellets",3,2]]],["V_DeckCrew_red_F",[]],[],"H_Beret_CSAT_01_F","G_Squares",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]];   
							_santa setName "Santa Claus";   
							[_santa, "WhiteHead_26"] remoteExec ["setFace"];   
							_santa allowDamage false;   
							removeGoggles _santa;   
							_santa addItem 'G_Squares';   
							_santa assignItem 'G_Squares';   
						}; 
						_santa setCaptive true;  
						_santa disableAI 'Move';  
						[_santa,"Acts_AidlPsitMstpSsurWnonDnon_loop"] remoteExec ["switchMove"];  
						[  
							_santa,             
							"Free SANTA CLAUS",            
							"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_secure_ca.paa",   
							"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_secure_ca.paa",   
							"_this distance _target < 3",        
							"_caller distance _target < 3",        
							{},               
							{},               
							{   
								_unit = (_this select 0);  
								[_unit,false] remoteExec ["setCaptive"];  
								[_unit,"Move"]remoteExec ["enableAI"];  
								[_unit,"AmovPercMstpSnonWnonDnon"] remoteExec ["playMove"];  
								[_unit] remoteExec ["removeAllActions"];  
								detach _unit;  
							},      
							{},               
							[],               
							6,               
							0,               
							true,              
							false              
						] remoteExec ["BIS_fnc_holdActionAdd", 0, _santa];
					};

					MAZ_EZM_fnc_createCandyCane = {
						params [["_color","#(rgb,8,8,3)color(0,1,0,1)",[""]],["_layerWhiteList",[],[[]]],["_layerBlacklist",[],[[]]],["_posCenter",[0,0,0],[[]]],["_dir",0,[0]],["_idBlacklist",[],[[]]]];
						private _allWhitelisted = _layerWhiteList isEqualTo [];
						private _layerRoot = (_allWhitelisted || {true in _layerWhiteList}) && {!(true in _layerBlackList)};
						private _markers = [];
						private _markerIDs = [];
						private _groups = [];
						private _groupIDs = [];
						private _objects = [];
						private _objectIDs = [];

						private _item14 = objNull;
						if (_layerRoot) then {
							_item14 = createVehicle ["Land_VR_Block_04_F",[4912.04,5544.64,8.956],[],0,"CAN_COLLIDE"];
							_this = _item14;
							_objects pushback _this;
							_objectIDs pushback 14;
							_this setPosWorld [4912.04,5544.64,18.456];
							_this setVectorDirAndUp [[-1.0411e-006,-1,0],[0,0,1]];
							_this setObjectTextureGlobal [0,"#(argb,8,8,3)color(0.75,0.75,0.75,1.0,co)"];
							_this setObjectMaterialGlobal [0,"a3\structures_f_bootcamp\vr\coverobjects\data\vr_coverobject_basic.rvmat"];
							_this setObjectTextureGlobal [1,"#(argb,8,8,3)color(1.0,1.0,1.0,1.0,co)"];
							_this setObjectMaterialGlobal [1,"a3\structures_f_bootcamp\vr\coverobjects\data\vr_coverobject_emmisive.rvmat"];
						};

						private _item15 = objNull;
						if (_layerRoot) then {
							_item15 = createVehicle ["Land_VR_Block_04_F",[4911.98,5544.67,17.956],[],0,"CAN_COLLIDE"];
							_this = _item15;
							_objects pushback _this;
							_objectIDs pushback 15;
							_this setPosWorld [4911.98,5544.67,27.456];
							_this setVectorDirAndUp [[-1.0411e-006,-1,0],[0,0,1]];
							_this setObjectTextureGlobal [0,"#(argb,8,8,3)color(0.75,0.75,0.75,1.0,co)"];
							_this setObjectMaterialGlobal [0,"a3\structures_f_bootcamp\vr\coverobjects\data\vr_coverobject_basic.rvmat"];
							_this setObjectTextureGlobal [1,"#(argb,8,8,3)color(1.0,1.0,1.0,1.0,co)"];
							_this setObjectMaterialGlobal [1,"a3\structures_f_bootcamp\vr\coverobjects\data\vr_coverobject_emmisive.rvmat"];
						};

						private _item16 = objNull;
						if (_layerRoot) then {
							_item16 = createVehicle ["Land_VR_Block_04_F",[4912.05,5544.67,26.956],[],0,"CAN_COLLIDE"];
							_this = _item16;
							_objects pushback _this;
							_objectIDs pushback 16;
							_this setPosWorld [4912.05,5544.67,36.456];
							_this setVectorDirAndUp [[-1.0411e-006,-1,0],[0,0,1]];
							_this setObjectTextureGlobal [0,"#(argb,8,8,3)color(0.75,0.75,0.75,1.0,co)"];
							_this setObjectMaterialGlobal [0,"a3\structures_f_bootcamp\vr\coverobjects\data\vr_coverobject_basic.rvmat"];
							_this setObjectTextureGlobal [1,"#(argb,8,8,3)color(1.0,1.0,1.0,1.0,co)"];
							_this setObjectMaterialGlobal [1,"a3\structures_f_bootcamp\vr\coverobjects\data\vr_coverobject_emmisive.rvmat"];
						};

						private _item17 = objNull;
						if (_layerRoot) then {
							_item17 = createVehicle ["Land_VR_Block_04_F",[4912.02,5544.75,35.956],[],0,"CAN_COLLIDE"];
							_this = _item17;
							_objects pushback _this;
							_objectIDs pushback 17;
							_this setPosWorld [4912.02,5544.75,45.456];
							_this setVectorDirAndUp [[-1.0411e-006,-1,0],[0,0,1]];
							_this setObjectTextureGlobal [0,"#(argb,8,8,3)color(0.75,0.75,0.75,1.0,co)"];
							_this setObjectMaterialGlobal [0,"a3\structures_f_bootcamp\vr\coverobjects\data\vr_coverobject_basic.rvmat"];
							_this setObjectTextureGlobal [1,"#(argb,8,8,3)color(1.0,1.0,1.0,1.0,co)"];
							_this setObjectMaterialGlobal [1,"a3\structures_f_bootcamp\vr\coverobjects\data\vr_coverobject_emmisive.rvmat"];
						};

						private _item18 = objNull;
						if (_layerRoot) then {
							_item18 = createVehicle ["Land_VR_Block_04_F",[4912,5546.24,41.492],[],0,"CAN_COLLIDE"];
							_this = _item18;
							_objects pushback _this;
							_objectIDs pushback 18;
							_this setPosWorld [4912,5546.24,50.992];
							_this setVectorDirAndUp [[-3.25841e-007,-0.866026,0.499998],[3.01992e-007,0.499998,0.866026]];
							_this setObjectTextureGlobal [0,"#(argb,8,8,3)color(0.75,0.75,0.75,1.0,co)"];
							_this setObjectMaterialGlobal [0,"a3\structures_f_bootcamp\vr\coverobjects\data\vr_coverobject_basic.rvmat"];
							_this setObjectTextureGlobal [1,"#(argb,8,8,3)color(1.0,1.0,1.0,1.0,co)"];
							_this setObjectMaterialGlobal [1,"a3\structures_f_bootcamp\vr\coverobjects\data\vr_coverobject_emmisive.rvmat"];
						};

						private _item19 = objNull;
						if (_layerRoot) then {
							_item19 = createVehicle ["Land_VR_Block_04_F",[4911.98,5550.38,45.832],[],0,"CAN_COLLIDE"];
							_this = _item19;
							_objects pushback _this;
							_objectIDs pushback 19;
							_this setPosWorld [4911.98,5550.38,55.332];
							_this setVectorDirAndUp [[-8.02679e-007,-0.500002,0.866024],[7.78829e-007,0.866024,0.500002]];
							_this setObjectTextureGlobal [0,"#(argb,8,8,3)color(0.75,0.75,0.75,1.0,co)"];
							_this setObjectMaterialGlobal [0,"a3\structures_f_bootcamp\vr\coverobjects\data\vr_coverobject_basic.rvmat"];
							_this setObjectTextureGlobal [1,"#(argb,8,8,3)color(1.0,1.0,1.0,1.0,co)"];
							_this setObjectMaterialGlobal [1,"a3\structures_f_bootcamp\vr\coverobjects\data\vr_coverobject_emmisive.rvmat"];
						};

						private _item20 = objNull;
						if (_layerRoot) then {
							_item20 = createVehicle ["Land_VR_Block_04_F",[4911.95,5556.08,47.357],[],0,"CAN_COLLIDE"];
							_this = _item20;
							_objects pushback _this;
							_objectIDs pushback 20;
							_this setPosWorld [4911.95,5556.08,56.857];
							_this setVectorDirAndUp [[-1.75635e-006,4.37119e-008,1],[3.01992e-007,1,-4.37114e-008]];
							_this setObjectTextureGlobal [0,"#(argb,8,8,3)color(0.75,0.75,0.75,1.0,co)"];
							_this setObjectMaterialGlobal [0,"a3\structures_f_bootcamp\vr\coverobjects\data\vr_coverobject_basic.rvmat"];
							_this setObjectTextureGlobal [1,"#(argb,8,8,3)color(1.0,1.0,1.0,1.0,co)"];
							_this setObjectMaterialGlobal [1,"a3\structures_f_bootcamp\vr\coverobjects\data\vr_coverobject_emmisive.rvmat"];
						};

						private _item21 = objNull;
						if (_layerRoot) then {
							_item21 = createVehicle ["Land_VR_Block_04_F",[4912.04,5561.75,45.918],[],0,"CAN_COLLIDE"];
							_this = _item21;
							_objects pushback _this;
							_objectIDs pushback 21;
							_this setPosWorld [4912.04,5561.75,55.418];
							_this setVectorDirAndUp [[3.2559e-006,0.500001,0.866025],[0,-0.866025,0.500001]];
							_this setObjectTextureGlobal [0,"#(argb,8,8,3)color(0.75,0.75,0.75,1.0,co)"];
							_this setObjectMaterialGlobal [0,"a3\structures_f_bootcamp\vr\coverobjects\data\vr_coverobject_basic.rvmat"];
							_this setObjectTextureGlobal [1,"#(argb,8,8,3)color(1.0,1.0,1.0,1.0,co)"];
							_this setObjectMaterialGlobal [1,"a3\structures_f_bootcamp\vr\coverobjects\data\vr_coverobject_emmisive.rvmat"];
						};

						private _item22 = objNull;
						if (_layerRoot) then {
							_item22 = createVehicle ["Land_VR_Block_04_F",[4912.23,5565.96,41.578],[],0,"CAN_COLLIDE"];
							_this = _item22;
							_objects pushback _this;
							_objectIDs pushback 22;
							_this setPosWorld [4912.23,5565.96,51.078];
							_this setVectorDirAndUp [[3.12924e-006,0.866026,0.499999],[-1.3411e-007,-0.499999,0.866026]];
							_this setObjectTextureGlobal [0,"#(argb,8,8,3)color(0.75,0.75,0.75,1.0,co)"];
							_this setObjectMaterialGlobal [0,"a3\structures_f_bootcamp\vr\coverobjects\data\vr_coverobject_basic.rvmat"];
							_this setObjectTextureGlobal [1,"#(argb,8,8,3)color(1.0,1.0,1.0,1.0,co)"];
							_this setObjectMaterialGlobal [1,"a3\structures_f_bootcamp\vr\coverobjects\data\vr_coverobject_emmisive.rvmat"];
						};

						private _item23 = objNull;
						if (_layerRoot) then {
							_item23 = createVehicle ["Land_VR_Block_04_F",[4912.21,5567.47,36.042],[],0,"CAN_COLLIDE"];
							_this = _item23;
							_objects pushback _this;
							_objectIDs pushback 23;
							_this setPosWorld [4912.21,5567.47,45.542];
							_this setVectorDirAndUp [[4.06802e-006,1,0],[0,0,1]];
							_this setObjectTextureGlobal [0,"#(argb,8,8,3)color(0.75,0.75,0.75,1.0,co)"];
							_this setObjectMaterialGlobal [0,"a3\structures_f_bootcamp\vr\coverobjects\data\vr_coverobject_basic.rvmat"];
							_this setObjectTextureGlobal [1,"#(argb,8,8,3)color(1.0,1.0,1.0,1.0,co)"];
							_this setObjectMaterialGlobal [1,"a3\structures_f_bootcamp\vr\coverobjects\data\vr_coverobject_emmisive.rvmat"];
						};

						private _item24 = objNull;
						if (_layerRoot) then {
							_item24 = createVehicle ["Land_VR_Block_04_F",[4912.04,5544.66,0],[],0,"CAN_COLLIDE"];
							_this = _item24;
							_objects pushback _this;
							_objectIDs pushback 24;
							_this setPosWorld [4912.04,5544.66,9.5];
							_this setVectorDirAndUp [[-1.0411e-006,-1,0],[0,0,1]];
							candyCaneGreen_base = _this;
							_this setVehicleVarName "candyCaneGreen_base";
							_this setObjectTextureGlobal [0,"#(argb,8,8,3)color(0.75,0.75,0.75,1.0,co)"];
							_this setObjectMaterialGlobal [0,"a3\structures_f_bootcamp\vr\coverobjects\data\vr_coverobject_basic.rvmat"];
							_this setObjectTextureGlobal [1,"#(argb,8,8,3)color(1.0,1.0,1.0,1.0,co)"];
							_this setObjectMaterialGlobal [1,"a3\structures_f_bootcamp\vr\coverobjects\data\vr_coverobject_emmisive.rvmat"];
						};
						private _triggers = [];
						private _triggerIDs = [];
						private _waypoints = [];
						private _waypointIDs = [];
						private _logics = [];
						private _logicIDs = [];
						isNil {
							if !(isnull _item14) then {
								this = _item14;
								[this,[0,'#(rgb,8,8,3)color(1,1,1,1)']] remoteExec ['setObjectTextureGlobal',0,this];[this, candyCaneGreen_base] call BIS_fnc_attachToRelative;;
							};
							if !(isnull _item15) then {
								this = _item15;
								[this,[0,_color]] remoteExec ['setObjectTextureGlobal',0,this];[this, candyCaneGreen_base] call BIS_fnc_attachToRelative;;
							};
							if !(isnull _item16) then {
								this = _item16;
								[this,[0,'#(rgb,8,8,3)color(1,1,1,1)']] remoteExec ['setObjectTextureGlobal',0,this];[this, candyCaneGreen_base] call BIS_fnc_attachToRelative;;
							};
							if !(isnull _item17) then {
								this = _item17;
								[this,[0,_color]] remoteExec ['setObjectTextureGlobal',0,this];[this, candyCaneGreen_base] call BIS_fnc_attachToRelative;;
							};
							if !(isnull _item18) then {
								this = _item18;
								[this,[0,'#(rgb,8,8,3)color(1,1,1,1)']] remoteExec ['setObjectTextureGlobal',0,this];[this, candyCaneGreen_base] call BIS_fnc_attachToRelative;;
							};
							if !(isnull _item19) then {
								this = _item19;
								[this,[0,_color]] remoteExec ['setObjectTextureGlobal',0,this];[this, candyCaneGreen_base] call BIS_fnc_attachToRelative;;
							};
							if !(isnull _item20) then {
								this = _item20;
								[this,[0,'#(rgb,8,8,3)color(1,1,1,1)']] remoteExec ['setObjectTextureGlobal',0,this];[this, candyCaneGreen_base] call BIS_fnc_attachToRelative;;
							};
							if !(isnull _item21) then {
								this = _item21;
								[this,[0,_color]] remoteExec ['setObjectTextureGlobal',0,this];[this, candyCaneGreen_base] call BIS_fnc_attachToRelative;;
							};
							if !(isnull _item22) then {
								this = _item22;
								[this,[0,'#(rgb,8,8,3)color(1,1,1,1)']] remoteExec ['setObjectTextureGlobal',0,this];[this, candyCaneGreen_base] call BIS_fnc_attachToRelative;;
							};
							if !(isnull _item23) then {
								this = _item23;
								[this,[0,_color]] remoteExec ['setObjectTextureGlobal',0,this];[this, candyCaneGreen_base] call BIS_fnc_attachToRelative;;
							};
							if !(isnull _item24) then {
								this = _item24;
								[this,[0,_color]] remoteExec ['setObjectTextureGlobal',0,this];;
							};
						};

						[[_objects,_groups,_triggers,_waypoints,_logics,_markers],[_objectIDs,_groupIDs,_triggerIDs,_waypointIDs,_logicIDs,_markerIDs]];
						candyCaneGreen_base
					};

					MAZ_EZM_fnc_createCandyCaneRed = {
						private _base = ["#(rgb,8,8,3)color(1,0,0,1)"] call MAZ_EZM_fnc_createCandyCane;
						private _pos = [true] call MAZ_EZM_fnc_getScreenPosition;
						_base setPosATL _pos;
						[_base] call MAZ_EZM_fnc_addObjectToInterface;
						[_base] call MAZ_EZM_fnc_deleteAttachedWhenDeleted;
					};

					MAZ_EZM_fnc_createCandyCaneGreen = {
						private _base = [] call MAZ_EZM_fnc_createCandyCane;
						private _pos = [true] call MAZ_EZM_fnc_getScreenPosition;
						_base setPosATL _pos;
						[_base] call MAZ_EZM_fnc_addObjectToInterface;
						[_base] call MAZ_EZM_fnc_deleteAttachedWhenDeleted;
					};

					MAZ_EZM_fnc_createSittingSanta = {
						params [["_layerWhiteList",[],[[]]],["_layerBlacklist",[],[[]]],["_posCenter",[0,0,0],[[]]],["_dir",0,[0]],["_idBlacklist",[],[[]]]];
						private _allWhitelisted = _layerWhiteList isEqualTo [];
						private _layerRoot = (_allWhitelisted || {true in _layerWhiteList}) && {!(true in _layerBlackList)};

						private _markers = [];
						private _markerIDs = [];
						private _groups = [];
						private _groupIDs = [];

						private _item30 = grpNull;
						if (_layerRoot) then {
							_item30 = createGroup west;
							_this = _item30;
							_groups pushback _this;
							_groupIDs pushback 30;
						};
						private _objects = [];
						private _objectIDs = [];
						private _item31 = objNull;
						if (_layerRoot) then {
							_item31 = _item30 createUnit ["I_G_Story_SF_Captain_F",[4875.9,5554.56,0],[],0,"CAN_COLLIDE"];
							_item30 selectLeader _item31;
							_this = _item31;
							_objects pushback _this;
							_objectIDs pushback 31;
							_this setPosWorld [4875.9,5554.61,5.00144];
							_this setVectorDirAndUp [[0,1,0],[0,0,1]];
							SANTA = _this;
							_this setVehicleVarName "SANTA";
							_this allowdamage false;;
							_this enablestamina false;;
							_this setname "Alexandros Moritiadou";;
							_this setpitch 1.03;;
						};

						private _item32 = objNull;
						if (_layerRoot) then {
							_item32 = createVehicle ["Land_ArmChair_01_F",[4875.92,5554.5,0.435],[],0,"CAN_COLLIDE"];
							_this = _item32;
							_objects pushback _this;
							_objectIDs pushback 32;
							_this setPosWorld [4875.92,5554.5,5.9188];
							_this setVectorDirAndUp [[0,1,0],[0,0,1]];
						};

						private _item33 = objNull;
						if (_layerRoot) then {
							_item33 = createVehicle ["Land_HelipadEmpty_F",[4875.92,5554.51,0.00500011],[],0,"CAN_COLLIDE"];
							_this = _item33;
							_objects pushback _this;
							_objectIDs pushback 33;
							_this setPosWorld [4875.92,5554.51,5.005];
							_this setVectorDirAndUp [[0,1,0],[0,0,1]];
							santa_base = _this;
							_this setVehicleVarName "santa_base";
						};
						private _triggers = [];
						private _triggerIDs = [];
						_this = _item30;
						if !(units _this isEqualTo []) then {
							[_this,0] setWaypointPosition [position leader _this,0];
							_this setGroupID ["Alpha 1-1"];;
						};
						private _waypoints = [];
						private _waypointIDs = [];
						private _logics = [];
						private _logicIDs = [];
						isNil {
							if !(isnull _item31) then {
								this = _item31;
								[] spawn 
						{sleep 0.1;comment "SANTA UNIT INIT"; 
						
						SANTA setVariable ["BIS_enableRandomization", false];  
						SANTA setUnitLoadout [["sgun_HunterShotgun_01_sawedoff_F","","","",["2Rnd_12Gauge_Pellets",2],[],""],[],[],["U_C_Paramedic_01_F",[["FirstAidKit",1],["Chemlight_green",1,1],["2Rnd_12Gauge_Pellets",3,2]]],["V_DeckCrew_red_F",[]],[],"H_Beret_CSAT_01_F","G_Squares",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]];  
						SANTA setname "Santa Claus";  
						[SANTA, "WhiteHead_26"] remoteExec ['setFace'];  
						SANTA allowDamage false;  
						removeGoggles SANTA;  
						SANTA addItem 'G_Squares';  
						SANTA assignItem 'G_Squares';  
							};
						[this, santa_base] call BIS_fnc_attachToRelative;
						[this, 2.1] remoteExec ['setObjectScale'];;
						[SANTA, 'crew'] remoteExec ['switchMove'];

						[SANTA, ["<t color='#00FF00'>Sit on Santa's Lap</t>",  
						{ 
						_this spawn  
						{ 
						params ["_target", "_caller", "_actionId", "_arguments"]; 
						private _pos = getPosASL _caller; 
						_caller attachto [_target getVariable 'seat',[0,0.55,0.8]]; 
						[_caller, 'crew'] remoteExec ['switchMove']; 
						sleep 10; 
						detach _caller; 
						[_caller, ''] remoteExec ['switchMove']; 
						_caller setPosASL _pos; 
						}; 
						},nil,1.5,true,true,"","_target distance _this < 6"]] remoteExec ['addAction',0,SANTA];;
							};
							if !(isnull _item32) then {
								this = _item32;
								[this, santa_base] call BIS_fnc_attachToRelative;
						[this, 2] remoteExec ['setObjectScale', 0, this];;
						[this,[0,'#(rgb,8,8,3)color(1,1,1,1)']] remoteExec ['setObjectTextureGlobal',0,this]; 
						;
							};
							if !(isnull _item33) then {
								this = _item33;
								SANTA setVariable ["seat", this, true]; ;
							};
						};
						[[_objects,_groups,_triggers,_waypoints,_logics,_markers],[_objectIDs,_groupIDs,_triggerIDs,_waypointIDs,_logicIDs,_markerIDs]];
						santa_base
					};

					MAZ_EZM_fnc_createSittingSantaCall = {
						private _base = [] call MAZ_EZM_fnc_createSittingSanta;
						private _pos = [true] call MAZ_EZM_fnc_getScreenPosition;
						_base setPosATL _pos;
						[_base] call MAZ_EZM_fnc_addObjectToInterface;
						[_base] call MAZ_EZM_fnc_deleteAttachedWhenDeleted;
					};

					MAZ_EZM_fnc_setupSnow = {
						private _fnc = {
							fn_initSnow = {
								if (!isServer) exitWith {};
								params ["_snowfall","_duration_storm","_ambient_sounds_al","_breath_vapors","_snow_burst","_effect_on_objects","_vanilla_fog","_local_fog","_intensifywind","_unitsneeze"];
								[] spawn fn_hunt; waitUntil {!isNil "hunt_alias"};
								if (_vanilla_fog) then {al_foglevel = fog; publicVariable "al_foglevel"; 60 setFog [1,0.01,0.5]};
								[_duration_storm] spawn {params ["_duration_storm"];al_snowstorm_om=true; publicvariable "al_snowstorm_om"; sleep _duration_storm; al_snowstorm_om=false; publicvariable "al_snowstorm_om"; if (!isNil "al_foglevel") then {60 setFog al_foglevel}};
								sleep 5;
								comment '["AL_snowstorm\al_check_pos.sqf"] remoteExec ["execVM",0,true]';
								[[],{
									waitUntil{!isNil "fn_check_pos"};
									[] spawn fn_check_pos;
								}] remoteExec ['spawn',0,true];
								if (_local_fog) then {[[],{waitUntil{!isNil "fn_mediumFog"};[] spawn fn_mediumFog;}] remoteExec ["spawn",0,true]};
								if (_breath_vapors) then {[[],{waitUntil{!isNil "fn_snowBreath"};[] spawn fn_snowBreath;}] remoteExec ["spawn",0,true]};
								if (_snowfall) then {
									[[],{
										waitUntil{!isNil "fn_snowfall_SFX" && alive player};
										[] spawn fn_snowfall_SFX;
										snowFallInit = player addEventHandler ["Respawn",{
											params ["_unit", "_corpse"];
											player removeEventHandler ["respawn",snowFallInit];
											[] spawn fn_snowfall_SFX;
										}];
									}] remoteExec ["spawn",0,true];
								};
								if (_snow_burst>0) then {[_effect_on_objects] spawn fn_rotocol_server; interval_burst = _snow_burst; publicVariable "interval_burst"; sleep 10; [[_unitsneeze],{params ['_unitSneeze'];waitUntil{!isNil "fn_breath"};[_unitSneeze] spawn fn_rotocol_client}] remoteExec ["spawn",0,true]};
								if (_intensifywind) then {
									al_windlevel	= wind;	for "_i" from 1 to 5 step 0.2 do {setWind [(al_windlevel#0)*_i,(al_windlevel#1)*_i,true]; sleep 4};
									waitUntil {sleep 60; !al_snowstorm_om};
									al_windlevel	= wind;	for "_i" from 1 to 5 step 0.1 do {setWind [(al_windlevel#0)/_i,(al_windlevel#1)/_i,true]; sleep 4};
								};
							};

							fn_hunt = {
								if (!isServer) exitWith {};
								if (!isNil "hunt_alias") exitwith {};

								while {true} do 
								{
									_allunits = [];
									{if (alive _x) then {_allunits pushBack _x};}  foreach (if (isMultiplayer) then {playableUnits} else {switchableUnits});
									hunt_alias = selectRandom _allunits; publicVariable "hunt_alias";
									sleep 60;
								};
							};

							fn_check_pos = {
								if (!hasInterface) exitWith {};
								if (!isNil {player getVariable "ck_ON"}) exitwith {};
								player setVariable ["ck_ON",true];

								alias_snow = "Land_HelipadEmpty_F" createVehiclelocal [0,0,0];

								KK_fnc_inHouse = 
								{
									_house = lineIntersectsSurfaces [getPosWorld _this,getPosWorld _this vectorAdd [0,0,50],_this,objNull,true,1,"GEOM","NONE"];
									if (((_house select 0) select 3) isKindOf "house") exitWith	{pos_p = "in_da_house"; cladire = ((_house select 0) select 3); casa= typeOf ((_house select 0) select 3); raza_snow = sizeof casa};
									if ((getPosASL player select 2 < 0)&&(getPosASL player select 2 > -3)) exitWith	{pos_p = "under_water"; alias_snow setPosASL [getPosASL player #0,getPosASL player #1,1]};
									if (getPosASL player select 2 < -3) exitWith {pos_p = "deep_sea"};
									if ((player != vehicle player)&&(getPosASL player select 2 > 0)) exitWith {pos_p = "player_car"; };
									pos_p = "open";
								};
								while {!isNull player} do {while {al_snowstorm_om} do {player call KK_fnc_inHouse; sleep 0.5};waitUntil {sleep 10; al_snowstorm_om}};
							};

							fn_mediumFog = {
								if (!hasInterface) exitWith {};
								waitUntil {!isNil "pos_p"};
								while {(!isNull player) and (al_snowstorm_om)} do 
								{
									if (pos_p=="open") then 
									{
										_alias_local_fog = "#particlesource" createVehicleLocal (getPosATL player);
										_alias_local_fog setParticleCircle [10,[3,3,0]];
										_alias_local_fog setParticleRandom [2,[0.25,0.25,0],[1,1,0],1,1,[0,0,0,0.1],0,0];
										_alias_local_fog setParticleParams [["\A3\data_f\cl_basic",1,0,1],"","Billboard",1,8,[0,0,0],[-1,-1,0],3,10.15,7.9,0.03,[5,10,10],[[0.5,0.5,0.5,0],[0.5,0.5,0.5,0.1],[1,1,1,0]],[1],1, 0,"","",player];
										_alias_local_fog setDropInterval 0.1;
										waitUntil {pos_p!="open"};
										deleteVehicle _alias_local_fog;
									};
									if (pos_p=="player_car") then 
									{
										_alias_local_fog = "#particlesource" createVehicleLocal (getPosATL player);
										_alias_local_fog setParticleCircle [30,[3,3,0]];
										_alias_local_fog setParticleRandom [0,[0.25,0.25,0],[1,1,0],1,1,[0,0,0,0.1],0,0];
										_alias_local_fog setParticleParams [["\A3\data_f\cl_basic",1,0,1],"","Billboard",1,4,[0,0,0],[-1,-1,0],3,10.15,7.9,0.03,[5,10,20],[[0.5,0.5,0.5,0],[0.5,0.5,0.5,0.1],[1,1,1,0]],[1],1, 0,"","",player];
										_alias_local_fog setDropInterval 0.1;		
										waitUntil {pos_p!="player_car"};
										deleteVehicle _alias_local_fog;
									};
									if (pos_p=="in_da_house") then  
									{
										_alias_local_fog = "#particlesource" createVehicleLocal (getPosATL player);
										_alias_local_fog setParticleCircle [raza_snow,[3,3,0]];
										_alias_local_fog setParticleRandom [0,[0.25,0.25,0],[1,1,0],1,1,[0,0,0,0.1],0,0];
										_alias_local_fog setParticleParams [["\A3\data_f\cl_basic",1,0,1],"","Billboard",1,4,[0,0,0],[-1,-1,0],3,10.15,7.9,0.03,[5,10,20],[[0.5,0.5,0.5,0],[0.5,0.5,0.5,0.1],[1,1,1,0]],[1],1, 0,"","",player];
										_alias_local_fog setDropInterval 0.1;		
										waitUntil {pos_p!="in_da_house"};
										deleteVehicle _alias_local_fog;
									};	
									if (pos_p=="under_water") then {waitUntil {sleep 5; pos_p!="under_water"}};
									if (pos_p=="deep_sea") then {waitUntil {sleep 5; pos_p!="deep_sea"}};
								};
							};

							fn_snowBreath = {
								private ["_footmobile","_alias_breath"];
								if (!hasInterface) exitWith {};
								_alias_breath = "Land_HelipadEmpty_F" createVehiclelocal [0,0,0];
								_alias_breath attachto [player,[0,0.2,0],"head"];
								while {!isnull player} do 
								{
									if ((alive player)&&(eyePos player select 2 > 0)) then 
									{
										_footmobile= player nearEntities ["Man",20];
										_alias_breath attachto [selectrandom _footmobile,[0,0.1,0],"head"];
										_flow = (getposasl _alias_breath vectorFromTo (_alias_breath getRelPos [10,90])) vectorMultiply 0.5;
										drop [
											[
												"\A3\data_f\ParticleEffects\Universal\Universal",
												16,
												12,
												8,
												1
											],
											"",
											"Billboard",
											0.15,
											0.3,
											[0,0,0],
											[_flow#0,_flow#1,-0.2],
											3,
											1.2,
											1,
											0,
											[0.1,.2,.3],
											[[1,1,1,0.05],[1,1,1,0.2],[1,1,1,0.05]],
											[0.1],
											0,
											0.04,
											"",
											"",
											_alias_breath,
											90
										];
										sleep 0.15; drop [["\A3\data_f\ParticleEffects\Universal\Universal",16,12,8,1],"","Billboard",0.15,0.3,[0,0,0],[_flow#0/2,_flow#1/2,-0.2],3,1.2,1,0,[0.1,.2,.3],[[1,1,1,0.05],[1,1,1,0.1],[1,1,1,0]],[0.1],0,0.04,"","",_alias_breath,90];
										sleep 5+random 5;
									} else {sleep 10};
								};
							};

							fn_snowfall_SFX = {
								if (!hasInterface) exitWith {};

								waitUntil {!isNil "pos_p"};
								waitUntil {!isNil "al_snowstorm_om"};
								while {al_snowstorm_om} do 
								{
									if (pos_p=="open") then 
									{
										_fulg_nea  = "#particlesource" createVehiclelocal getposaTL player;
										_fulg_nea setParticleCircle [0,[0,0,0]];
										_fulg_nea setParticleRandom [0,[20,20,9],[0,0,0],0,0.1,[0,0,0,0.1],0,0];
										_fulg_nea setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8,1],"","Billboard",1,7,[0,0,10],[0,0,0],3,1.7,1,1,[0.1],[[1,1,1,1]],[1],0.3,1,"","",player];
										_fulg_nea setDropInterval 0.005;
										waitUntil {pos_p!="open"};
										deleteVehicle _fulg_nea;
									};
									if (pos_p=="player_car") then 
									{
										_fulg_nea  = "#particlesource" createVehiclelocal getposaTL player;
										_fulg_nea setParticleCircle [0,[0,0,0]];
										_fulg_nea setParticleRandom [0,[20,20,9],[0,0,0],0,0.1,[0,0,0,0.1],0,0];
										_fulg_nea setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8,1],"","Billboard",1,7,[0,0,10],[0,0,0],3,1.7,1,1,[0.1],[[1,1,1,1]],[1],0.3,1,"","",player];
										_fulg_nea setDropInterval 0.005;
										waitUntil {pos_p!="player_car"};
										deleteVehicle _fulg_nea;	
									};
									if (pos_p=="under_water") then  
									{
										_fulg_nea  = "#particlesource" createVehiclelocal getposasl alias_snow;
										_fulg_nea setParticleCircle [0,[0,0,0]];
										_fulg_nea setParticleRandom [0,[25,25,0],[0,0,0],0,0.1,[0,0,0,0.1],1,1];
										_fulg_nea setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8,1],"","Billboard",1,4,[0,0,15],[0,0,0],3,2,1,0.7,[0.1],[[1,1,1,1]],[1],1,1,"","",alias_snow];
										_fulg_nea setDropInterval 0.005;
										waitUntil {pos_p!="under_water"};
										deleteVehicle _fulg_nea;
									};
									if (pos_p=="deep_sea") then {waitUntil {pos_p!="deep_sea"}};
									if (pos_p=="in_da_house") then
									{
										_fulg_nea_1  = "#particlesource" createVehiclelocal getposATL cladire;
										_fulg_nea_1 setParticleCircle [raza_snow,[0,0,0]];
										_fulg_nea_1 setParticleRandom [0,[5,5,0],[0,0,0],0,0,[0,0,0,0],0,0.5];
										_fulg_nea_1 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8,1],"","Billboard",1,0.2,[0,0,1],[0,0,0],3,2,1,0,[0.1],[[1,1,1,1]],[1],0,1,"","",cladire,0,true];
										_fulg_nea_1 setDropInterval 0.01;		
										waitUntil {pos_p!="in_da_house"};
										deleteVehicle _fulg_nea_1;
									};	
								};
							};

							fn_rotocol_server = {
								params ["_effect_on_objects"];
								while {al_snowstorm_om} do 
								{
									snow_gust=selectrandom [["rafala_1",12],["rafala_2",8.5],["rafala_3",17],["rafala_5",13],["rafala_6",16],["rafala_7",13.5]]; publicVariable "snow_gust";
									vit_x = (selectrandom [1,-1])*round(2+random 5); vit_y = (selectrandom [1,-1])*round(2+random 5);	publicVariable "vit_x";publicVariable "vit_y";
									if (_effect_on_objects) then {[vit_x,vit_y] spawn fn_blow_objects};
									sleep 60;
								};
							};

							fn_blow_objects = {
								params ["_vit_x","_vit_y"];
								waitUntil {!isNil "rafala"};
								if (rafala) then {
									al_nearobjects = nearestObjects [hunt_alias,[],50];
									ar_obj_eligibl = [];
									{if((_x isKindOf "LandVehicle") or (_x isKindOf "Man") or (_x isKindOf "Air") or (_x isKindOf "Wreck")) then {ar_obj_eligibl pushBack _x;}} foreach al_nearobjects;
									sleep 1;
									if (count ar_obj_eligibl > 0) then {
										_blowobj= selectRandom ar_obj_eligibl;
										_blowobj setvelocity [_vit_x,_vit_y,random 0.1];sleep 0.1;_blowobj setvelocity [_vit_x*1.5,_vit_y*1.5,random 0.1];sleep 0.1; _blowobj setvelocity [wind#0/4,wind#0/4,random 0.1];
									}	
								};
							};

							fn_rotocol_client = {
								if (!hasInterface) exitWith {};
								params ["_unit_cold"];
								if (_unit_cold) then {player_act_cold = true} else {player_act_cold = false};
								while {al_snowstorm_om} do 
								{
									if ((pos_p=="open")&&(player == hunt_alias)) then 
									{
										rafala = true; publicVariable "rafala";
										_pozitie_x = (selectrandom [1,-1])*round(random 50); _pozitie_y = (selectrandom [1,-1])*round(random 50);
										[[_pozitie_x,_pozitie_y],{params ["_x1","_y1"];[_x1,_y1] spawn fn_trembling;}] remoteExec ["spawn",0];
										sleep (snow_gust#1);
										rafala = false; publicVariable "rafala";
									};
									sleep 20+random interval_burst;
								};
							};

							fn_trembling = {
								if ((!hasInterface)or(pos_p!="open")) exitWith {};
								params ["_pozitie_x","_pozitie_y"];

								drop [["\A3\data_f\cl_basic",1,0,1],"","Billboard",0.5,(snow_gust#1)/2,[_pozitie_x,_pozitie_y,0],[vit_x,vit_y,0],13,1.3,1,0.1,[1,10,15],[[1,1,1,0],[1,1,1,.1],[1,1,1,0]],[1],1,0,"","",hunt_alias,0,true,0.1];
								sleep 0.6;

								_fulgi  = "#particlesource" createVehiclelocal getposaTL player;
								_fulgi setParticleCircle [0,[0,0,0]];
								_fulgi setParticleRandom [0,[10,10,5],[0,0,0],0,0.1,[0,0,0,0.1],0,0];
								_fulgi setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8,1],"","Billboard",1,5,[0,0,7],[vit_x,vit_y,0],0,1.7,1,0,[0.1],[[1,1,1,1]],[1],0,0,"","",player];
								_fulgi setDropInterval 0.01;

								_snow_flakes  = "#particlesource" createVehiclelocal getposaTL player;
								_snow_flakes setParticleCircle [0,[0,0,0]];
								_snow_flakes setParticleRandom [0,[5,5,9],[0,0,0],0,0.1,[0,0,0,0.1],0,0];
								_snow_flakes setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8,1],"","Billboard",1,3,[0,0,10],[vit_x*2,vit_y*2,0],3,1.7,1,0,[0.2],[[1,1,1,1]],[1],0.3,1,"","",player];
								_snow_flakes setDropInterval 0.01;

								if (player_act_cold) then {
								enableCamShake true;

								0 = ["FilmGrain",2000] spawn
								{
									params ["_name","_priority","_effect","_handle"];
									while {_handle = ppEffectCreate [_name, _priority];	_handle < 0} do {_priority = _priority + 1};
									_handle ppEffectEnable true;
									for "_i" from 0 to 0.1 step 0.01 do
									{
										_handle ppEffectAdjust [_i,1,5,0.5,0.3,0];
										sleep 0.3;
										_handle ppEffectCommit 0;
									};
									sleep 5;
									_i=0.1;
									while {_i>0} do 
									{
										_i = _i-0.01;
										_handle ppEffectAdjust [_i,1,5,0.5,0.3,0];
										sleep 0.5;		
										_handle ppEffectCommit 0;
									};
									_handle ppEffectEnable false;
									ppEffectDestroy _handle;
								};
								if (goggles player=="") then 
								{
									0 = ["RadialBlur",100,[0.11,1,0.33,0.16]] spawn
									{
										params ["_name", "_priority", "_effect", "_handle"];
										while {	_handle = ppEffectCreate [_name, _priority];_handle < 0} do {_priority = _priority + 1};
										sleep 2;
										call BIS_fnc_fatigueEffect;
										_handle ppEffectEnable true;
										_handle ppEffectAdjust _effect;
										_handle ppEffectCommit 4;
										waitUntil {ppEffectCommitted _handle};
										call BIS_fnc_fatigueEffect;
										_i = 0.11;
										sleep 2;
										while {_i>0} do 
										{
											_i = _i-0.01;
											_handle ppEffectAdjust [_i,1,0.33,0.16];
											sleep 0.5;		
											_handle ppEffectCommit 0;
										};	
										_handle ppEffectEnable false;
										ppEffectDestroy _handle;
									};
								};

								sleep 1;
								addCamShake [0.5,(snow_gust#1)*2,25]};
								sleep (snow_gust#1)/2;
								deleteVehicle _snow_flakes;	
								deleteVehicle _fulgi;
							};

							fn_breath = {
								drop [["\A3\data_f\ParticleEffects\Universal\Universal",16,12,8,1],"","Billboard",1,1,_this,[0,0,0.1],1,1.275,1,1,[.3,.5,.7],[[1,1,1,0.1],[1,1,1,0.03],[1,1,1,0]],[0.8],1,0.5,"","",_this,90];
							};
						};
						private _varName = "MAZ_EZM_Snow";
						private _myJIPCode = "MAZ_EZM_Snow_JIP";

						private _value = (str _fnc) splitString "";

						_value deleteAt (count _value - 1);
						_value deleteAt 0;

						_value = _value joinString "";
						_value = _value + "removeMissionEventhandler ['EachFrame',_thisEventHandler];";
						_value = _value splitString "";

						missionNamespace setVariable [_varName,_value,true];

						[[_varName], {
							params ["_ding"];
							private _data = missionNamespace getVariable [_ding,[]];
							_data = _data joinString "";
							private _id = addMissionEventhandler ["EachFrame", _data];
						}] remoteExec ['spawn',0,_myJIPCode];
					};

					MAZ_EZM_fnc_startSnowStorm = {
						if(count (missionNamespace getVariable ["MAZ_EZM_Snow",[]]) == 0) then {call MAZ_EZM_fnc_setupSnow;};
						if(missionNamespace getVariable ["al_snowstorm_om",false]) exitWith {["Snow storm already happening!","addItemFailed"] call MAZ_EZM_fnc_systemMessage;};
						[[],{
							waitUntil {!isNil "fn_initSnow"};
							comment '[
								"_snowfall",
								"_duration_storm",
								"_ambient_sounds_al",
								"_breath_vapors",
								"_snow_burst",
								"_effect_on_objects",
								"_vanilla_fog",
								"_no_snow_indoor",
								"_local_fog",
								"_intensifywind",
								"_unitsneeze"
							]';
							[true,3600,15,true,0,true,false,false,false,true] spawn fn_initSnow;
						}] remoteExec ['spawn',2];
						["Guys, look! Its snowing!","addItemOk"] call MAZ_EZM_fnc_systemMessage;
					};
				};
				MAZ_EZM_holidayModulesAdd = {
					with uiNamespace do {
						MAZ_zeusModulesTree tvSetPictureRight [[MAZ_FestiveTree],"a3\3den\data\displays\display3den\toolbar\help_updates_new_ca.paa"];
						MAZ_zeusModulesTree tvSetColor [[MAZ_FestiveTree],[0,0.7,0,1]];
						[
							MAZ_zeusModulesTree,
							MAZ_FestiveTree,
							"Create a Christmas Tree",
							"Create a Christmas Tree!",
							"MAZ_EZM_fnc_createChristmasTree",
							"a3\modules_f\data\editterrainobject\texturechecked_tree_ca.paa"
						] call MAZ_EZM_fnc_zeusAddModule;

						[
							MAZ_zeusModulesTree,
							MAZ_FestiveTree,
							"Create a Candy Cane (Red)",
							"Create a Red Candy Cane!",
							"MAZ_EZM_fnc_createCandyCaneRed",
							"\A3\ui_f\data\IGUI\Cfg\simpleTasks\types\help_ca.paa"
						] call MAZ_EZM_fnc_zeusAddModule;

						[
							MAZ_zeusModulesTree,
							MAZ_FestiveTree,
							"Create a Candy Cane (Green)",
							"Create a Green Candy Cane!",
							"MAZ_EZM_fnc_createCandyCaneGreen",
							"\A3\ui_f\data\IGUI\Cfg\simpleTasks\types\help_ca.paa"
						] call MAZ_EZM_fnc_zeusAddModule;

						[
							MAZ_zeusModulesTree,
							MAZ_FestiveTree,
							"Create a Big, Sitting Santa",
							"Create a Big, Sitting Santa!",
							"MAZ_EZM_fnc_createSittingSantaCall",
							"\A3\ui_f\data\IGUI\Cfg\simpleTasks\types\help_ca.paa"
						] call MAZ_EZM_fnc_zeusAddModule;

						[
							MAZ_zeusModulesTree,
							MAZ_FestiveTree,
							"Create a Santa Hostage",
							"Create a Santa Hostage!",
							"MAZ_EZM_fnc_createSantaHostage",
							"\A3\ui_f\data\IGUI\Cfg\simpleTasks\types\help_ca.paa"
						] call MAZ_EZM_fnc_zeusAddModule;

						[
							MAZ_zeusModulesTree,
							MAZ_FestiveTree,
							"Start Snow Storm",
							"Create a Snow Storm!",
							"MAZ_EZM_fnc_startSnowStorm",
							"\A3\ui_f\data\IGUI\Cfg\simpleTasks\types\help_ca.paa"
						] call MAZ_EZM_fnc_zeusAddModule;
					};
				};
			};
			case "NewYears": {
				MAZ_EZM_holidayFunctions = {
					MAZ_EZM_fnc_createFirework = {
						DCON_boomSounds = [ 
							"A3\Sounds_F\arsenal\explosives\shells\30mm40mm_shell_explosion_01.wss", 
							"A3\Sounds_F\arsenal\explosives\shells\Artillery_tank_shell_155mm_explosion_02.wss", 
							"A3\Sounds_F\arsenal\explosives\shells\Tank_shell_explosion_02.wss", 
							"A3\Sounds_F\arsenal\explosives\shells\Artillery_shell_explosion_04.wss", 
							"A3\Sounds_F\arsenal\explosives\shells\Artillery_shell_explosion_05.wss", 
							"A3\Sounds_F\arsenal\explosives\shells\Artillery_shell_explosion_06.wss", 
							"A3\Sounds_F\arsenal\explosives\shells\Artillery_shell_explosion_07.wss", 
							"A3\Sounds_F\arsenal\weapons\Launchers\RPG32\RPG32_Hit.wss" 
						]; 
						DCON_launchSounds = [ 
							"A3\Sounds_F\arsenal\weapons_static\Missile_Launcher\Titan.wss", 
							"A3\Sounds_F\arsenal\weapons\Launchers\Titan\Titan.wss", 
							"A3\Sounds_F\arsenal\weapons\Launchers\RPG32\rpg32.wss", 
							"A3\Sounds_F\arsenal\weapons\Launchers\NLAW\nlaw.wss" 
						]; 
						DCON_fnc_FireworkSounds = { 
							_boomSound = DCON_boomSounds call BIS_fnc_selectRandom; 
							_launchSound = DCON_launchSounds call BIS_fnc_selectRandom; 
							playSound3D [_launchSound, _this select 0]; 
							sleep 2.3; 
							playSound3D [_boomSound, _this select 0]; 
						}; 
						DCON_fnc_FireworkVisuals = { 
							_firing_position = _this select 0; 
							_firing_dir = _this select 1; 
							_rocket = _this select 2; 
							_color = _this select 3; 
							_explosion_power = 100; 
							_glitter_count = 20; 
							_initial_velocity = _firing_dir vectorMultiply 300; 
							_explosion_fragments_array = []; 
							_explosion_subfragments_array = []; 
							_randomLaunch = (random 4.5) - 2.3; 
							_randomSleep = (random 0.5) - 0.25; 
							_randomSleepLong = (random 8) - 4; 
							for [{_i=0},{_i < _glitter_count},{_i=_i+1}] do {  
								_rand_expl_power1 = ((random _explosion_power)*2) - _explosion_power; 
								_rand_expl_power2 = ((random _explosion_power)*2) - _explosion_power; 
								_rand_expl_power3 = ((random _explosion_power)*2) - _explosion_power; 
								_explosion_fragments_array = _explosion_fragments_array +  
								[[(_rand_expl_power1) -_rand_expl_power1/2,(_rand_expl_power2) -_rand_expl_power2/2, (_rand_expl_power3) -_rand_expl_power3/2]]; 
								if (_i < _glitter_count/3) then { 
									_rand_subexpl_power1 = ((random _explosion_power)/2) - _explosion_power/2; 
									_rand_subexpl_power2 = ((random _explosion_power)/2) - _explosion_power/2; 
									_rand_subexpl_power3 = ((random _explosion_power)/2) - _explosion_power/2; 
									_explosion_subfragments_array = _explosion_subfragments_array +  
									[[(_rand_subexpl_power1/4) -_rand_subexpl_power1/8,(_rand_subexpl_power2/4) -_rand_subexpl_power2/8, (_rand_subexpl_power3/4) -_rand_subexpl_power3/8]]; 
								}; 
							}; 
							comment "_rocket setVelocity _initial_velocity; "; 
							_light1 = "#lightpoint" createVehicle [0,0,0]; 
							[_light1,0.1] remoteExec ['setLightBrightness']; 
							[_light1,[1,0.3,0]] remoteExec ['setLightColor']; 
							[_light1,true] remoteExec ['setLightUseFlare']; 
							[_light1,1000] remoteExec ['setLightFlareMaxDistance']; 
							[_light1,5] remoteExec ['setLightFlareSize']; 
							_light2 = "#lightpoint" createVehicle [0,0,0]; 
							[_light2,3] remoteExec ['setLightBrightness']; 
							[_light2,[1,0.8,0]] remoteExec ['setLightColor']; 
							[_light2,true] remoteExec ['setLightUseFlare']; 
							[_light2,1000] remoteExec ['setLightFlareMaxDistance']; 
							[_light2,8] remoteExec ['setLightFlareSize']; 
							sleep 0.01; 
							[_light1,[_rocket,[0,0,0]]] remoteExec ['lightAttachObject']; 
							[_light2,[_rocket,[0,0,0]]] remoteExec ['lightAttachObject']; 
							sleep 2.3; 
							deleteVehicle _light1; 
							deleteVehicle _light2; 
							for [{_i=0},{_i < count _explosion_fragments_array},{_i=_i+1}] do { 
								[_rocket,_explosion_fragments_array,_color,_i] spawn { 
									_rocket = _this select 0; 
									_fragments = _this select 1; 
									_color2 = _this select 2; 
									_selector = _this select 3; 
									_rocket = "CMflare_Chaff_Ammo" createVehicle (getPosATL _rocket);  
									_smoke = "SmokeLauncherAmmo" createVehicle (getPosATL _rocket);  
									_rocket setVelocity (_fragments select _selector); 
									_light2 = "#lightpoint" createVehicle [0,0,0]; 
									[_light2,3] remoteExec ['setLightBrightness']; 
									[_light2,_color2] remoteExec ['setLightAmbient']; 
									[_light2,_color2] remoteExec ['setLightColor']; 
									[_light2,[_rocket,[0,0,0]]] remoteExec ['lightAttachObject']; 
									[_light2,true] remoteExec ['setLightUseFlare']; 
									[_light2,1000] remoteExec ['setLightFlareMaxDistance']; 
									[_light2,10] remoteExec ['setLightFlareSize']; 
									sleep 5; 
									deleteVehicle _light2; 
								}; 
							}; 
							sleep 1; 
							sleep 7; 
							deleteVehicle _rocket; 
						}; 
						M9SD_fnc_spawnFireworks = { 
							_pos = _this;  
							
							_fireworkCount = 1;  
							_colorArray = [ 
								[0.42,0.81,0.1], 
								[0.8,0.1,0.35], 
								[0.2,0.73,0.85], 
								[1,1,1], 
								[0.1,0.81,0.1] 
							];  
							for "_i" from 1 to _fireworkCount do { 
								_velocity = [random 1024,random 1024,random [1000,2500,5000]]; 
								_color = _colorArray call BIS_fnc_selectRandom; 
								
								_firework = "CMflare_Chaff_Ammo" createVehicle _pos; 
								_firework setDir (random 359); 
								_firework setVelocity _velocity; 
								_firingdir = [selectRandom [0,1],selectRandom [0,1],selectRandom [0,1]]; 
								[_pos,_firingdir,_firework,_color] spawn DCON_fnc_FireworkVisuals; 
								[_firework] spawn DCON_fnc_FireworkSounds; 
								sleep 1.5; 
							}; 
						}; 
						private _pos = [true] call MAZ_EZM_fnc_getScreenPosition;
						_pos spawn M9SD_fnc_spawnFireworks; 
					};
				};
				MAZ_EZM_holidayModulesAdd = {
					with uiNamespace do {
						MAZ_zeusModulesTree tvSetPictureRight [[MAZ_FestiveTree],"a3\3den\data\displays\display3den\toolbar\help_updates_new_ca.paa"];
						MAZ_zeusModulesTree tvSetColor [[MAZ_FestiveTree],[0,0.7,0,1]];
						[
							MAZ_zeusModulesTree,
							MAZ_FestiveTree,
							"Spawn a Firework",
							"Creates a random colored firework!",
							"MAZ_EZM_fnc_createFirework",
							"a3\modules_f_curator\data\portraitflarewhite_ca.paa"
						] call MAZ_EZM_fnc_zeusAddModule;

					};
				};
			};
			default {
				MAZ_EZM_holidayFunctions = {};
				MAZ_EZM_holidayModulesAdd = {
					with uiNamespace do {
						[
							MAZ_zeusModulesTree,
							MAZ_FestiveTree,
							"No Festive Modules...",
							"Its not a holiday!",
							"",
							"a3\ui_f\data\gui\rsc\rscdisplayarcademap\icon_exit_cross_ca.paa"
						] call MAZ_EZM_fnc_zeusAddModule;
					};
				};
			};
		};

		call MAZ_EZM_holidayFunctions;
		uiNamespace setVariable ["MAZ_EZM_holidayModulesAdd",MAZ_EZM_holidayModulesAdd];