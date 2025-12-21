MAZ_EZM_fnc_mortarAreaModule = {
			private _pos = [true] call MAZ_EZM_fnc_getScreenPosition;
			[
				"Mortar Area",
				[
					[
						"COMBO",
						"Round Type:",
						[
							["Sh_82mm_AMOS","Smoke_82mm_AMOS_White","Sh_155mm_AMOS","Smoke_120mm_AMOS_White"],
							["82mm HE","82mm Smoke","155mm HE","155mm Smoke"],
							0
						]
					],
					[
						"SLIDER:RADIUS",
						"Round Radius:",
						[
							50,
							300,
							100,
							_pos,
							[1,0,0,1],
							false
						]
					],
					[
						"SLIDER",
						"Number of Rounds:",
						[
							1,
							15,
							10
						]
					],
					[
						"SLIDER",
						"Minimum Delay:",
						[
							2,
							4,
							3
						]
					],
					[
						"SLIDER",
						"Maximum Delay",
						[
							5,
							8,
							6
						]
					]
				],
				{
					params ["_values","_pos","_display"];
					_values params ["_roundType","_radius","_rounds","_min","_max"];
					_display closeDisplay 1;
					[_pos,_roundType,_radius,_rounds,_min,_max] spawn {
						params ["_pos","_roundType","_radius","_rounds","_min","_max"];
						[_pos,_roundType,_radius * 1.1,1,[_min,_max],{false},(_radius * 0.75)] spawn BIS_fnc_fireSupportVirtual;
						sleep (5 + random 5);
						[_pos,_roundType,_radius,_rounds,[_min,_max]] spawn BIS_fnc_fireSupportVirtual;
					};
				},
				{
					params ["_values","_args","_display"];
					_display closeDisplay 1;
				},
				_pos
			] call MAZ_EZM_fnc_createDialog;
		};