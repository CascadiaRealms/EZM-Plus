MAZ_EZM_fnc_resetInteriorsData = {
			private _cargoTowers = ["Land_Cargo_Tower_V1_No1_F","Land_Cargo_Tower_V1_No2_F","Land_Cargo_Tower_V1_No3_F","Land_Cargo_Tower_V1_No4_F","Land_Cargo_Tower_V1_No5_F","Land_Cargo_Tower_V1_No6_F","Land_Cargo_Tower_V1_No7_F","Land_Cargo_Tower_V3_F","Land_Cargo_Tower_V1_F","Land_Cargo_Tower_V2_F","Land_Cargo_Tower_V4_F"];
			private _cargoPost = ["Land_Cargo_Patrol_V3_F","Land_Cargo_Patrol_V1_F","Land_Cargo_Patrol_V2_F","Land_Cargo_Patrol_V4_F"];
			private _cargoHQ = ["Land_Cargo_HQ_V3_F","Land_Cargo_HQ_V1_F","Land_Cargo_HQ_V2_F","Land_Cargo_HQ_V4_F","Land_Medevac_HQ_V1_F"];
			private _cargoHouse = ["Land_Cargo_House_V3_F","Land_Cargo_House_V1_F","Land_Cargo_House_V2_F","Land_Cargo_House_V4_F","Land_Medevac_house_V1_F"];

			private _newData = [];
			{
				_newData pushBack [_x,[]];
			}forEach [_cargoTowers,_cargoPost,_cargoHQ,_cargoHouse];
			profileNamespace setVariable ["MAZ_EZM_BuildingCompositionData",_newData];
			saveProfileNamespace;
		};