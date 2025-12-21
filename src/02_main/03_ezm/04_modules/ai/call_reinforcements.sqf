MAZ_EZM_fnc_callReinforcements = {
			["Spawn Reinforcements (Choose Side)",[
				[
					"SIDES",
					"Reinforcements Side",
					east
				],
				[
					"COMBO",
					"Direction of Reinforcements",
					[
						[],
						[
							"N",
							"S",
							"E",
							"W"
						],
						0
					]
				]
			],{
				params ["_values","_pos","_display"];
				_values params ["_side","_dir"];
				if(_side == civilian) exitWith {
					["You can't reinforce with a civilian group!","addItemFailed"] call MAZ_EZM_fnc_systemMessage;
				};
				[_side,_dir] spawn MAZ_EZM_fnc_callReinforcementsChooseGroup;
				_display closeDisplay 1;
			},{
				params ["_values","_args","_display"];
				_display closeDisplay 2;
			}] call MAZ_EZM_fnc_createDialog;
		};

		MAZ_EZM_fnc_callReinforcementsChooseGroup = {
			params ["_side","_dir"];
			sleep 0.1;
			private _factions = [_side] call MAZ_EZM_fnc_getAllFactionGroups;
			private _listData = [[],[],0];
			{
				_x params ["_name","_flag","_icon","_groups"];
				private _groupName = "";
				{
					_x params ["_groupName","_cfg"];
					(_listData select 1) pushBack [format ["%1 (%2)",_name,_groupName],"",_flag];
				}forEach _groups;
			}forEach _factions;
			
			["Spawn Reinforcements (Group Select)",[
				[
					"LIST",
					"Reinforcements Type",
					_listData
				]
			],{
				params ["_values","_args","_display"];
				_args params ["_pos","_side","_dir"];
				_values params ["_groupType"];
				_display closeDisplay 1;
				
				private _reinforcementsParams = [_pos,_side,_groupType,_dir,[]];
				private _helipadMarker = createVehicle ["Land_HelipadEmpty_F",_pos,[],0,"CAN_COLLIDE"];
				_helipadMarker setPosATL _pos;

				["Reinforcements Destination on Foot",{
					params ["_objects","_position","_args","_shift","_ctrl","_alt"];
					deleteVehicle _objects;
					_args set [4,_position];
					_args spawn MAZ_EZM_fnc_spawnReinforcements;
				},_helipadMarker,_reinforcementsParams] call MAZ_EZM_fnc_selectSecondaryPosition;
			},{
				params ["_values","_args","_display"];
				[] spawn {
					sleep 0.1;
					[] spawn MAZ_EZM_fnc_callReinforcements;
				};
				_display closeDisplay 2;
			},[[true] call MAZ_EZM_fnc_getScreenPosition,_side,_dir]] call MAZ_EZM_fnc_createDialog;
		};