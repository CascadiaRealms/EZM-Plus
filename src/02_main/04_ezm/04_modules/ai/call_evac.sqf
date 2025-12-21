MAZ_EZM_fnc_callEvacModule = {
			["Call Helicopter Evac",[
				[
					"COMBO",
					"Direction of Evac",
					[
						[],
						["N","S","E","W"],
						0
					]
				],
				[
					"SIDES",
					"Side of Evac",
					west
				],
				[
					"LIST",
					"Helicopter Type",
					[
						["Hummingbird","Orca","Ghosthawk","Ghosthawk CTRG","Hellcat","Huron","Mohawk","Taru"],
						["MH-9 Hummingbird","PO-30 Orca","UH-80 Ghosthawk","UH-80 Ghosthawk (CTRG)","WY-55 Hellcat (Unarmed)","CH-67 Huron","CH-49 Mohawk","Mi-290 Taru"],
						0
					]
				],
				[
					"SLIDER",
					["Number of Passengers","The number of passengers required before the AI will take off and move to the destination."],
					[1,8,3]
				]
			],{
				params ["_values","_pos","_display"];
				_values params ["_directionIndex","_side","_helicopterType","_numToLeave"];
				_display closeDisplay 1;
				private _dir = switch (parseNumber _directionIndex) do {
					case 0: {'North'};
					case 1: {'South'};
					case 2: {'East'};
					case 3: {'West'};
				};
				private _heliParams = [_pos,_dir,_side,_helicopterType,[],_numToLeave];

				private _helipadMarker = createVehicle ["Land_HelipadEmpty_F",_pos,[],0,"CAN_COLLIDE"];

				["Helicopter Destination",{
					params ["_objects","_position","_args","_shift","_ctrl","_alt"];
					deleteVehicle _units;

					_args set [4,_position];
					_args spawn MAZ_EZM_fnc_heliEvacExec;
				},_helipadMarker,_heliParams] call MAZ_EZM_fnc_selectSecondaryPosition;
			},{
				params ["_values","_args","_display"];
				_display closeDisplay 2;
			},[true] call MAZ_EZM_fnc_getScreenPosition] call MAZ_EZM_fnc_createDialog;
		};