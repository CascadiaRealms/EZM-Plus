MAZ_EZM_fnc_createIEDModule = {
			private _pos = [true] call MAZ_EZM_fnc_getScreenPosition;
			["Create IED",[
				[
					"COMBO",
					"IED Disguise Type",
					[
						[],
						["Cardboard Box","Suitcases","Trash Can","Barrels","Vehicle Wrecks"],
						0
					]
				],
				[
					"SLIDER",
					"IED Explosive Radius",
					[3,15,7,_pos,[1,0,0,1]]
				],
				[
					"SIDES",
					["Sides That Trigger","Sides that when entering the radius the IED will detonate."],
					[west,east,independent]
				]
			],{
				params ["_values","_pos","_display"];
				_values params ["_iedType","_radius","_sides"];
				private _trashCanTypes = ["Land_GarbageBin_01_F","TrashBagHolder_01_F"];
				private _cardboardBox = ["Land_PaperBox_01_small_destroyed_brown_F"];
				private _luggageTypes = ["Land_LuggageHeap_01_F","Land_LuggageHeap_03_F"];
				private _barrelTypes = ["Land_MetalBarrel_empty_F","Land_BarrelEmpty_grey_F","Land_BarrelEmpty_F"];
				private _vehicleWreckTypes = ["Land_Wreck_Skodovka_F","Land_Wreck_CarDismantled_F","Land_Wreck_Truck_F","Land_Wreck_Van_F","Land_Wreck_Offroad_F","Land_Wreck_Truck_dropSide_F","Land_Wreck_Offroad2_F","Land_Wreck_Car3_F","Land_Wreck_Car_F","Land_Wreck_Car2_F"];

				_iedType = switch (parseNumber _iedType) do {
					case 0: {selectRandom _cardboardBox};
					case 1: {selectRandom _luggageTypes};
					case 2: {selectRandom _trashCanTypes};
					case 3: {selectRandom _barrelTypes};
					case 4: {selectRandom _vehicleWreckTypes};
				};

				private _iedObject = createVehicle [_iedType,_pos,[],0,"CAN_COLLIDE"];
				[_iedObject] call MAZ_EZM_fnc_addObjectToInterface;
				[_iedObject] call MAZ_EZM_fnc_deleteAttachedWhenDeleted;
				["IED created.","addItemOk"] call MAZ_EZM_fnc_systemMessage;
				private _ied = createMine ["IEDLandSmall_F", position _iedObject,[],0];
				_ied attachTo [_iedObject,[0,0,-5]];
				[_iedObject,_ied,_radius,_sides] spawn {
					params ["_obj","_ied","_radius","_sides"];
					waitUntil {
						(
							(count (nearestObjects [_obj,["CAManBase"],_radius])) > 0
						) &&
						(
							((nearestObjects [_obj,["CAManBase"],_radius]) findIf {alive _x}) != -1
						) &&
						(
							((nearestObjects [_obj,["CAManBase"],_radius]) findIf {side (group _x) in _sides}) != -1
						)
					};
					private _pos = getPosATL _ied;
					_pos set [2,0];
					_ied setPosATL _pos;
					_ied setDamage 1;
					sleep 0.3;
					deleteVehicle _obj;
				};

				_display closeDisplay 1;
			},{
				params ["_values","_args","_display"];
				_display closeDisplay 2;
			},_pos] call MAZ_EZM_fnc_createDialog;
		};