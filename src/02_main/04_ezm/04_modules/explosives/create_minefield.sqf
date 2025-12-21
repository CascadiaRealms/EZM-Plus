MAZ_EZM_fnc_createMinefieldModule = {
			private _pos = [] call MAZ_EZM_fnc_getScreenPosition;
			["Create Minefield",[
				[
					"COMBO",
					"Mine Type",
					[
						["APERSMine","APERSBoundingMine","ATMine"],
						["APERS Mine","APERS Bounding Mine","AT Mine"],
						0
					]
				],
				[
					"SLIDER:RADIUS",
					"Mines Radius",
					[10,50,25,_pos,[1,0,0,1]]
				],
				[
					"SLIDER",
					"Mines Amount",
					[5,35,15]
				]
			],{
				params ["_values","_pos","_display"];
				_values params ["_mineType","_radius","_amount"];
				private _mines = [];
				for "_i" from 1 to _amount do {
					private _randomPos = [
						[[_pos,_radius]],
						[]
					] call BIS_fnc_randomPos;

					_randomPos set [2,0];

					private _mine = createMine [_mineType,_randomPos,[],0];
				};

				_display closeDisplay 1;
			},{
				params ["_values","_args","_display"];
				_display closeDisplay 2;
			},_pos] call MAZ_EZM_fnc_createDialog;
		};