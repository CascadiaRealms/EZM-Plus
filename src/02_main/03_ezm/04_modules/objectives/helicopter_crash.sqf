MAZ_EZM_fnc_newHelicrashMission = {
	MAZ_EZM_fnc_crashSetPosition = {
		params ["_crater"];
		private _crashLocations = switch (worldName) do {
			case "Altis": {[[4426,14856.8,0],[4798.99,12639.2,0],[4877.75,20329.2,0],[5231.58,14871.2,0],[5578.27,17465.8,0],[6163.38,19324.6,0],[6449.08,13172.7,0],[6543.98,11516.5,0],[6718.32,19145.1,0],[7752.5,15274.9,0],[8158.96,20422.5,0],[8397.1,12966.5,0],[8819.66,11798.1,0],[8791.14,14868,0],[8870,18726,0],[9221.45,22106.7,0],[9279.24,16893.5,0],[9595.95,18836.4,0],[10056.8,8474.84,0],[10412.4,15523.6,0],[10447,12258,0],[10673.2,8163.02,0],[10643.5,16961,0],[10664,14861.2,0],[10905,13319,0],[11107.4,20417.6,0],[11265.5,6763.46,0],[11418.7,8021.57,0],[11555.3,9178.9,0],[11652.9,16580.6,0],[11822.7,21807.9,0],[11970.8,17921.5,0],[12292.4,8427.08,0],[12290.6,14908.5,0],[12272.3,16782.4,0],[12707.5,20893,0],[12818,19687,0],[13025.3,21797.8,0],[13788.3,18012.9,0],[14277.1,22192.4,0],[14352.3,21860.1,0],[14630.3,21582.1,0],[15139,18725,0],[16196.8,20505.8,0],[16511,9939,0],[16633,16039,0],[16757.5,18699.3,0],[16823,17206,0],[17268,17010,0],[17489,12283,0],[17680,15862.8,0],[18060.6,17167.3,0],[18200,10589,0],[18449.8,7986.42,0],[18442.5,14388.5,0],[18836.6,11992,0],[18850.1,17212,0],[19274,14905,0],[19455.6,7522.52,0],[19433,15434,0],[19616.9,8790.04,0],[19673.1,18544.6,0],[19896.6,6270.58,0],[20087,11211,0],[20075.9,19464.4,0],[20148.9,17218,0],[20283.4,13243.4,0],[20763,14738,0],[20747.2,18601.4,0],[20799.7,19459.5,0],[20959.8,10528.6,0],[20940.1,16583.9,0],[21099,13434,0],[21290.6,19486.8,0],[21491.1,8666.78,0],[21628.6,21366.1,0],[21746.5,16236.1,0],[21844.3,7684.46,0],[21975.9,18559.1,0],[21993,15601.4,0],[22062.4,21577.7,0],[22049.4,20284.7,0],[22190.1,15193,0],[22280.9,20129.4,0],[22604.7,22341.4,0],[22693.9,22075.5,0],[23106.8,21565.2,0],[23538.1,20580.1,0],[23755.2,22248.2,0],[23718.1,23545.8,0],[23900.7,23003.5,0],[24009.6,21359.9,0],[24143.3,23747.1,0],[24365,22093,0],[24527.1,23024.5,0],[24692.7,20078,0],[24708,21195.1,0],[24721.8,23393,0],[24952,20877,0],[25226,19954,0],[25563.3,19567.9,0],[25551.8,22500.9,0],[25574.9,20376.8,0],[25687,21512,0],[25765,22222,0],[26024.9,19984.3,0],[26259.4,20418.7,0],[26685.8,21184.4,0],[27493.4,21481.1,0],[27631.7,23592.4,0],[27672.3,23252.4,0],[27887.2,22497.3,0]]};
			case "Stratis": {[[1928.22,3534.36,0],[1977.5,2723.25,0],[2068.9,5612.03,0],[2112.91,3835.67,0],[2684.1,1259.8,0],[2678.56,4478.38,0],[2729.22,2977.94,0],[2792.35,1755.79,0],[2726.1,5830.9,0],[2986.6,1872.88,0],[2947.12,6035.31,0],[3356.14,2910.95,0],[3449.37,5377.28,0],[3559.39,4898.91,0],[3782.19,5584.72,0],[4081.06,4566.71,0],[4282.01,3705.89,0],[4231.02,6768.26,0],[4388.32,4428.61,0],[4617.95,5293.65,0],[5025.48,5905.11,0],[5207.32,5032.42,0],[5333.03,5230.53,0],[5585.59,4669.99,0],[6464.77,5312.47,0],[6559.19,5070.86,0]]};
			case "Tanoa": {[[1994.01,3318.69,0],[1977.91,6149.22,0],[2406.13,13314,0],[2635.34,11693.8,0],[2731.29,5743.97,0],[2963.1,9292.33,0],[3372.5,6528.03,0],[3857.02,13448.1,0],[4714.84,3566.41,0],[4802.19,5109.05,0],[5260.83,8748.35,0],[5282.02,11607.9,0],[5605.38,11187.2,0],[5791.82,4161.52,0],[6055.39,10381.1,0],[6247.1,9359.79,0],[6535.95,12748.7,0],[6761.22,7269.57,0],[6948.91,13296,0],[7036.33,4106.12,0],[7567.5,8102.3,0],[7562.46,12551.3,0],[8366.63,9835.1,0],[8726.58,4350.14,0],[8913.88,13772,0],[9096.26,10198.7,0],[9312.51,7382.55,0],[9419.4,4160.3,0],[9858.19,13305.3,0],[9896.49,12066.1,0],[10543.3,6618.74,0],[10684.3,8703.72,0],[10962.4,9778.89,0],[11013.3,3984.29,0],[11271.9,5088.14,0],[11439.7,12379.6,0],[11757,10253.7,0],[11901.4,3219.96,0],[11915.4,12982.1,0],[12167.1,2558.17,0],[12507.7,8126.96,0],[12495.4,8120.56,0],[12621.3,12159.2,0],[12885.6,4726.58,0],[13547.7,12353.7,0]]};
			case "Malden": {[[1173.52,553.341,0],[2574.27,3384.17,0],[2583.97,4498.49,0],[3166.79,6499.55,0],[3384.68,5855.92,0],[3499.89,8463.32,0],[3660.96,5224.26,0],[3726.6,3343.97,0],[3967.86,7360.91,0],[4135.1,6178.93,0],[4183.96,6838.41,0],[4356.08,2664.51,0],[4574.04,3726.52,0],[4478.59,9502.34,0],[4739.8,9874.42,0],[5078.69,7370.66,0],[5215.15,4752.49,0],[5228.77,6113.76,0],[5353.05,4125.18,0],[5374.87,4474.32,0],[5363.94,8711.72,0],[5543.19,11192.8,0],[5657.82,7003.13,0],[5907.66,3348.21,0],[5972.87,9644.25,0],[6004.93,6552.75,0],[6192.93,8605.72,0],[6206.64,10717,0],[6595.55,3999.55,0],[6853.07,5497.6,0],[6971.02,4776.37,0],[6925.04,11188.2,0],[6952.59,9921.21,0],[7005.67,8298.7,0],[7173.55,5916.48,0],[7332.62,6976.11,0],[7553.26,10731,0],[7803.76,4451.71,0],[7788.3,7683.12,0],[8138.48,3109.62,0],[8146.16,10031.8,0],[8280.43,2937.81,0],[8327.22,5660.38,0],[8526.92,3246.26,0]]};
			case "Enoch": {[[3094.28,6975.88,0],[3042.18,5372.35,0],[3208.97,2258.87,0],[3439.1,8982.46,0],[3434.31,11016.1,0],[3642.56,8689.51,0],[4137.82,7578.32,0],[4179.18,10347.8,0],[4541.4,4743.86,0],[5256.73,2160.37,0],[5130.52,10421.7,0],[5598.42,8704.12,0],[5911.77,7912.09,0],[6130.03,8106.55,0],[6426.88,10990.5,0],[6881.97,1203.95,0],[7293.8,2718.96,0],[7628.54,5652.17,0],[7887.01,9806.89,0],[7930.4,10720.5,0],[8132.23,11082.9,0],[8272.61,8822.85,0],[8424.41,10082,0],[8940.26,6589.97,0],[9107.57,1685.31,0],[9033.24,4388.54,0],[9284.32,11058,0],[9731.2,7845.74,0],[9889.61,8624.03,0],[10400.6,6797.57,0],[11122.2,2492.39,0],[11305.6,9583.08,0]]};
			case "VR": {[[7520.18,7513.92,0]]};
		};
		private _position = selectRandom _crashLocations;
		_crater setPosATL _position;
		_crater setVectorUp surfaceNormal position _crater;
		private _randomDir = round (random 360);
		_crater setDir _randomDir;
		_position;
	};
	
	
	MAZ_EZM_fnc_createSmokeForCrash = {
		params ["_position"];
		private _smokeNfire = createVehicle ["test_EmptyObjectForSmoke",_position,[],0,"CAN_COLLIDE"];
		_smokeNfire
	};
	MAZ_EZM_fnc_createSoldierMission = {
		params ["_location","_groupSize"];
		private _position = [[[_location,50]],[]] call BIS_fnc_randomPos;
		private _unitLoadouts = [
			[["arifle_Katiba_F","","acc_pointer_IR","optic_ACO_grn",["30Rnd_65x39_caseless_green",30],[],""],[],[],["U_O_CombatUniform_ocamo",[["FirstAidKit",5]]],["V_HarnessO_brn",[["HandGrenade",2,1],["SmokeShell",2,1],["SmokeShellGreen",1,1],["30Rnd_65x39_caseless_green",11,30]]],[],"H_HelmetLeaderO_ocamo","",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","O_NVGoggles_hex_F"]],
			[["arifle_AK12U_F","","acc_pointer_IR","optic_ACO_grn",["30Rnd_762x39_AK12_Mag_F",30],[],""],[],[],["U_O_CombatUniform_ocamo",[["FirstAidKit",5]]],["V_HarnessO_brn",[["HandGrenade",2,1],["SmokeShell",2,1],["SmokeShellGreen",1,1],["30Rnd_762x39_AK12_Mag_F",5,30]]],[],"H_HelmetLeaderO_ocamo","",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","O_NVGoggles_hex_F"]],
			[["arifle_CTAR_hex_F","","acc_pointer_IR","optic_Arco",["30Rnd_580x42_Mag_F",30],[],""],[],[],["U_O_CombatUniform_ocamo",[["FirstAidKit",5]]],["V_HarnessO_brn",[["HandGrenade",2,1],["SmokeShell",2,1],["SmokeShellGreen",1,1],["30Rnd_580x42_Mag_F",5,30]]],[],"H_HelmetLeaderO_ocamo","",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","O_NVGoggles_hex_F"]],
			[["srifle_DMR_01_F","","","optic_DMS",["10Rnd_762x54_Mag",10],[],""],[],[],["U_O_CombatUniform_ocamo",[["FirstAidKit",5]]],["V_HarnessO_brn",[["HandGrenade",2,1],["SmokeShell",2,1],["SmokeShellGreen",1,1],["10Rnd_762x54_Mag",5,10]]],[],"H_HelmetLeaderO_ocamo","",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","O_NVGoggles_hex_F"]],
			[["LMG_Zafir_F","","","optic_Holosight",["150Rnd_762x54_Box",150],[],""],[],[],["U_O_CombatUniform_ocamo",[["FirstAidKit",5]]],["V_HarnessO_brn",[["HandGrenade",2,1],["SmokeShell",2,1],["SmokeShellGreen",1,1],["150Rnd_762x54_Box",1,150]]],[],"H_HelmetLeaderO_ocamo","",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","O_NVGoggles_hex_F"]]
		];

		private _soldiersCreated = [];
		private _soldierGroup = createGroup [east,true];
		for "_i" from 0 to (_groupSize-1) do {
			private _soldier = _soldierGroup createUnit ["O_Soldier_F",[23405.7,17895.8,0],[],0,"CAN_COLLIDE"];
			_soldier setPosATL _position;
			_soldier setVectorDirAndUp [[0,1,0],[0,0,1]];
			_soldier setUnitLoadout (selectRandom _unitLoadouts);
			_soldier setUnitPos MAZ_EZM_stanceForAI;

			[_soldierGroup,0] setWaypointPosition [position leader _soldierGroup,0];
			_soldierGroup setGroupID ["Alpha 1-1"];;

			_soldiersCreated pushBack _soldier;
		};
		_soldierGroup selectLeader (_soldiersCreated select 0);
		_soldierGroup allowFleeing 0;

		comment "Add waypoints";
		_position = [[[_location,35]],[]] call BIS_fnc_randomPos;
		private _moveWaypoint = _soldierGroup addWaypoint [_position,0];
		_moveWaypoint setWaypointType "MOVE";
		_moveWaypoint setWaypointBehaviour "SAFE";
		_moveWaypoint setWaypointSpeed "LIMITED";

		_position = [[[_location,35]],[]] call BIS_fnc_randomPos;
		_moveWaypoint = _soldierGroup addWaypoint [_position,0];
		_moveWaypoint setWaypointType "MOVE";
		_moveWaypoint setWaypointBehaviour "SAFE";
		_moveWaypoint setWaypointSpeed "LIMITED";

		_position = [[[_location,35]],[]] call BIS_fnc_randomPos;
		_moveWaypoint = _soldierGroup addWaypoint [_position,0];
		_moveWaypoint setWaypointType "MOVE";
		_moveWaypoint setWaypointBehaviour "SAFE";
		_moveWaypoint setWaypointSpeed "LIMITED";

		_position = [[[_location,35]],[]] call BIS_fnc_randomPos;
		_moveWaypoint = _soldierGroup addWaypoint [_position,0];
		_moveWaypoint setWaypointType "MOVE";
		_moveWaypoint setWaypointBehaviour "SAFE";
		_moveWaypoint setWaypointSpeed "LIMITED";

		_position = [[[_location,35]],[]] call BIS_fnc_randomPos;
		_moveWaypoint = _soldierGroup addWaypoint [_position,0];
		_moveWaypoint setWaypointType "MOVE";
		_moveWaypoint setWaypointBehaviour "SAFE";
		_moveWaypoint setWaypointSpeed "LIMITED";

		_position = [[[_location,35]],[]] call BIS_fnc_randomPos;
		private _cycleWaypoint = _soldierGroup addWaypoint [_position,0];
		_cycleWaypoint setWaypointType "CYCLE";
		_cycleWaypoint setWaypointBehaviour "SAFE";
		_cycleWaypoint setWaypointSpeed "LIMITED";


		_soldiersCreated;
	};

	MAZ_EZM_fnc_createReward = {
		params ["_location","_type"];
		private _position = [[[_location,15]],[]] call BIS_fnc_randomPos;
		
		private _crate = nil;
		switch (_type) do {
			case "guns": {
				_crate = createVehicle ["Box_NATO_Ammo_F",[16876.3,12244,0],[],0,"CAN_COLLIDE"];
				_crate setPos _position;
				_crate setVectorDirAndUp [[0,1,0],[-0.0346379,0,0.9994]];
				[_crate,"[[[[""arifle_Katiba_F"",""arifle_ARX_blk_F"",""arifle_CTAR_hex_F"",""arifle_RPK12_F"",""arifle_MSBS65_black_F"",""LMG_Zafir_F"",""srifle_DMR_01_F"",""srifle_DMR_04_F"",""srifle_DMR_05_blk_F"",""launch_O_Vorona_brown_F""],[5,2,5,1,2,2,3,2,2,1]],[[""30Rnd_65x39_caseless_green"",""30Rnd_762x39_AK12_Mag_F"",""75rnd_762x39_AK12_Mag_F"",""10Rnd_50BW_Mag_F"",""30Rnd_580x42_Mag_F"",""30Rnd_65x39_caseless_msbs_mag"",""150Rnd_762x54_Box"",""10Rnd_762x54_Mag"",""10Rnd_127x54_Mag"",""10Rnd_93x64_DMR_05_Mag"",""Vorona_HEAT""],[20,4,2,3,12,8,4,12,5,8,1]],[[""muzzle_snds_B"",""optic_Arco"",""optic_Aco"",""optic_ACO_grn"",""optic_Holosight"",""acc_flashlight"",""acc_pointer_IR"",""optic_DMS"",""optic_AMS"",""optic_KHS_hex"",""muzzle_snds_58_hex_F"",""muzzle_snds_65_TI_blk_F"",""optic_Holosight_blk_F"",""optic_ico_01_black_f"",""optic_Arco_AK_blk_F"",""optic_DMS_weathered_Kir_F"",""Laserdesignator_02"",""FirstAidKit""],[2,4,4,4,4,5,5,4,4,3,3,3,4,3,2,3,10,20]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
			};
			case "equip": {
				_crate = createVehicle ["Box_NATO_Equip_F",[16877,12245,0],[],0,"CAN_COLLIDE"];
				_crate setPos _position;
				_crate setVectorDirAndUp [[0.774188,0.632387,0.0268383],[-0.0346456,0,0.9994]];
				[_crate,"[[[[],[]],[[],[]],[[""H_Cap_tan_specops_US"",""H_MilCap_mcamo"",""H_Booniehat_mcamo"",""H_Booniehat_tan"",""H_HelmetB_light"",""H_HelmetB_light_black"",""H_HelmetB_light_desert"",""H_HelmetB_light_grass"",""H_HelmetB_light_sand"",""H_HelmetB_light_snakeskin"",""H_HelmetB_black"",""H_HelmetB_camo"",""H_HelmetB_desert"",""H_HelmetB_grass"",""H_HelmetB_sand"",""H_HelmetB_snakeskin"",""H_HelmetSpecB"",""H_HelmetSpecB_blk"",""H_HelmetSpecB_paint2"",""H_HelmetSpecB_paint1"",""H_HelmetSpecB_sand"",""H_HelmetSpecB_snakeskin"",""H_HelmetCrew_B"",""H_PilotHelmetFighter_B"",""H_PilotHelmetHeli_B"",""H_CrewHelmetHeli_B"",""H_HelmetB_TI_tna_F"",""H_HelmetB_tna_F"",""H_HelmetB_Enh_tna_F"",""H_HelmetB_Light_tna_F"",""H_Booniehat_tna_F"",""V_Rangemaster_belt"",""V_BandollierB_blk"",""V_BandollierB_rgr"",""V_Chestrig_blk"",""V_Chestrig_rgr"",""V_TacVest_blk"",""V_PlateCarrier1_blk"",""V_PlateCarrier1_rgr"",""V_PlateCarrier2_rgr"",""V_PlateCarrier2_blk"",""V_PlateCarrierGL_blk"",""V_PlateCarrierGL_rgr"",""V_PlateCarrierGL_mtp"",""V_PlateCarrierSpec_blk"",""V_PlateCarrierSpec_rgr"",""V_PlateCarrierSpec_mtp"",""V_RebreatherB"",""V_TacChestrig_grn_F"",""V_PlateCarrier1_tna_F"",""V_PlateCarrier2_tna_F"",""V_PlateCarrierSpec_tna_F"",""V_PlateCarrierGL_tna_F"",""V_BandollierB_ghex_F"",""V_PlateCarrier1_rgr_noflag_F"",""V_PlateCarrier2_rgr_noflag_F""],[2,2,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
			};
		};
		_crate;
	};

	MAZ_EZM_fnc_crashSounds = {
		params ["_helicopter","_newPos"];
		[_helicopter,_newPos] spawn {
			params ["_helicopter","_newPos"];
			playSound3D ["A3\sounds_f\vehicles\crashes\helis\heli_crash_ground_ext_4.wss",_helicopter,false,_newPos, 5, 1, 5500];
			sleep 0.5;
			playSound3D ["A3\sounds_f\vehicles\air\noises\heli_damage_rotor_ext_2.wss",_helicopter,false,_newPos, 5, 1, 1000];
			while {!(isNull _helicopter)} do {
				playSound3D ["A3\sounds_f\vehicles\air\noises\heli_alarm_bluefor.wss",_helicopter,false,getPosASL _helicopter, 5, 1, 30];
				sleep 2.05;
			};
		};
	};

	private _craterCrash = createVehicle ["CraterLong",[23413.8,17893.8,0],[],0,"CAN_COLLIDE"];
	_craterCrash setPosWorld [23413.8,17893.8,3.25423];
	_craterCrash setVectorDirAndUp [[0,1,0],[0,0,1]];

	private _crashGhosthawk = createVehicle ["B_Heli_Transport_01_F",[23415.3,17894.2,-1.035],[],0,"CAN_COLLIDE"];
	_crashGhosthawk setPosWorld [23414.6,17894.2,4.17478];
	_crashGhosthawk setVectorDirAndUp [[0,0.95921,-0.282693],[0.46759,0.249885,0.84789]];
	_crashGhosthawk setDamage [0.62284,false];
	_crashGhosthawk lock 2;
	_crashGhosthawk enableSimulation false;
	[_crashGhosthawk,_craterCrash] call BIS_fnc_attachToRelative;
	private _newPos = [_craterCrash] call MAZ_EZM_fnc_crashSetPosition;
	[_crashGhosthawk,_newPos] call MAZ_EZM_fnc_crashSounds;

	private _positionOfCrash = getPosATL _craterCrash;
	private _smokeObject = [_positionOfCrash] call MAZ_EZM_fnc_createSmokeForCrash;
	private _crashObjects = [_craterCrash,_crashGhosthawk,_smokeObject];
	["TaskAssignedIcon",["A3\UI_F\Data\Map\Markers\Military\warning_CA.paa","Helicopter Crash"]] remoteExec ['BIS_fnc_showNotification'];
	private _heliCrashMarker = createMarker ["heliCrashMarker_0",_positionOfCrash];
	_heliCrashMarker setMarkerText "Helicopter Crash";
	_heliCrashMarker setMarkerType "mil_objective";
	_heliCrashMarker setMarkerColor "ColorEAST";

	private _randomAmountOfEnemies = round (random [10,15,20]);
	private _groupSize = round (random [1,2,3]);
	_randomAmountOfEnemies = round (_randomAmountOfEnemies/_groupSize);
	private _soldiersArray = [];
	for "_i" from 0 to _randomAmountOfEnemies do {
		private _soldiersCreated = [_positionOfCrash,_groupSize] call MAZ_EZM_fnc_createSoldierMission;
		{
			_soldiersArray pushBack _x;
		}forEach _soldiersCreated;
	};


	[_soldiersArray,_heliCrashMarker,_crashObjects] spawn {
		params ["_soldiersArray","_heliCrashMarker","_crashObjects"];
		private _timer = 900;
		while {_timer > 0 && (({alive _x} count _soldiersArray) != 0)} do {
			_timer = _timer - 1;
			sleep 1;
		};
		if(({alive _x} count _soldiersArray) == 0) then {
			["TaskSucceeded",["","Helicopter Crash Secured"]] remoteExec ['BIS_fnc_showNotification'];
			private _randomAmount = selectRandom [1,2];
			private _rewardBoxes = [];
			for "_i" from 0 to (_randomAmount-1) do {
				private _rewardType = selectRandom ["guns","equip"];
				private _rewardBox = [getPosATL (_crashObjects select 0),_rewardType] call MAZ_EZM_fnc_createReward;
				_rewardBoxes pushBack _rewardBox;
			};
			deleteMarker _heliCrashMarker;
			sleep 90;
			waitUntil {{isPlayer _x} count ((_crashObjects select 0) nearEntities ["Man",1600]) == 0};
			{
				deleteVehicle _x;
			} forEach _crashObjects + _soldiersArray + _rewardBoxes;
		};
		if(_timer <= 0 && (({alive _x} count _soldiersArray) != 0)) then {
			["TaskFailed",["","Helicopter Crash Not Secured"]] remoteExec ['BIS_fnc_showNotification'];
			deleteMarker _heliCrashMarker;
			{
				deleteVehicle _x;
			} forEach _crashObjects + _soldiersArray;
		};
		sleep 600;
		if(MAZ_EZM_autoHelicrash) then {
			[] call MAZ_EZM_fnc_newHelicrashMission;
		};
	};
};


MAZ_EZM_fnc_toggleRandomHelicrashModule = {
	if(missionNamespace getVariable ["MAZ_EZM_autoHelicrash",false]) then {
		missionNamespace setVariable ["MAZ_EZM_autoHelicrash",false,true];
		["Automated Helicopter Crashes disabled.","addItemOk"] call MAZ_EZM_fnc_systemMessage;
	} else {
		missionNamespace setVariable ["MAZ_EZM_autoHelicrash",true,true];
		["Automated Helicopter Crashes enabled.","addItemOk"] call MAZ_EZM_fnc_systemMessage;
		[] call MAZ_EZM_fnc_newHelicrashMission;
	};
};