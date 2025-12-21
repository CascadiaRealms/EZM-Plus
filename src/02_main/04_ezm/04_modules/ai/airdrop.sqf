MAZ_EZM_fnc_callAirdropModule = {
			["Call an Airdrop",[
				[
					"TOOLBOX",
					"Airdrop Type",
					[false,["Arsenal","Vehicle"]],
					{true},
					{
						params ["_display","_value"];
						_display setVariable ["MAZ_EZM_isVehicle",_value];
					}
				],
				[
					"LIST",
					["Payload","Loaded vehicle in the airdrop, only applicable to VEHICLE airdrops."],
					[
						[],
						[
							"Hunter",
							"Hunter HMG",
							"Hunter GMG",
							"Ifrit",
							"Ifrit HMG",
							"Ifrit GMG",
							"Strider",
							"Strider HMG",
							"Strider GMG",
							"Prowler",
							"Prowler HMG",
							"Prowler AT",
							"Qilin",
							"Qilin Minigun",
							"Qilin AT",
							"AWC 302 Nyx (Recon)",
							"AWC 302 Nyx (Autocannon)",
							"AWC 302 Nyx (AT)",
							"AWC 302 Nyx (AA)",
							"AMV-7 Marshall",
							"Rhino",
							"Rhino MGS UP",
							"MSE-3 Marid",
							"AFV-4 Gorgon",
							"FV-720 Mora"
						],
						0
					],
					{
						params ["_display"];
						_display getVariable "MAZ_EZM_isVehicle";
					}
				],
				[
					"TOOLBOX:YESNO",
					"AIO Arsenal?",
					[true],
					{
						params ["_display"];
						!(_display getVariable "MAZ_EZM_isVehicle");
					}
				],
				[
					"LIST",
					["Direction","Direction the airdrop aircraft comes from."],
					[
						['NW','N','NE','E','SE','S','SW','W'],
						['NW','N','NE','E','SE','S','SW','W'],
						0
					]
				],
				[
					"LIST",
					["Airdrop Aircraft Type","The aircraft type that the airdrop will be carried in."],
					[
						['blackfish','huron','xian','mohawk'],
						["V-44X Blackfish","CH-67 Huron","Y-32 Xi'an","CH-49 Mohawk"],
						0,
						4
					]
				],
				[
					"SIDES",
					"Side of Airdrop",
					west
				],
				[
					"TOOLBOX:YESNO",
					["Radio SFX","Whether to play radio sound effects when the airdrop is called."],
					[false]
				]
			],{
				params ["_values","_args","_display"];
				_values params ["_type","_payloadType","_aioArsenal","_dir","_aircraft","_side","_radioSFX"];

				private _typeArray = [];
				if(_type) then {
					_typeArray pushBack 'Vehicle';
					switch (_payloadType) do {
						case 0: {_typeArray pushBack 'B_MRAP_01_F';};
						case 1: {_typeArray pushBack 'B_MRAP_01_hmg_F';};
						case 2: {_typeArray pushBack 'B_MRAP_01_gmg_F';};
						case 3: {_typeArray pushBack 'O_MRAP_02_F';};
						case 4: {_typeArray pushBack 'O_MRAP_02_hmg_F';};
						case 5: {_typeArray pushBack 'O_MRAP_02_gmg_F';};
						case 6: {_typeArray pushBack 'I_MRAP_03_F';};
						case 7: {_typeArray pushBack 'I_MRAP_03_hmg_F';};
						case 8: {_typeArray pushBack 'I_MRAP_03_gmg_F';};
						case 9: {_typeArray pushBack 'B_LSV_01_unarmed_F';};
						case 10: {_typeArray pushBack 'B_LSV_01_armed_F';};
						case 11: {_typeArray pushBack 'B_LSV_01_AT_F';};
						case 12: {_typeArray pushBack 'O_LSV_02_unarmed_F';};
						case 13: {_typeArray pushBack 'O_LSV_02_armed_F';};
						case 14: {_typeArray pushBack 'O_LSV_02_AT_F';};
						case 15: {_typeArray pushBack 'I_LT_01_scout_F';};
						case 16: {_typeArray pushBack 'I_LT_01_cannon_F';};
						case 17: {_typeArray pushBack 'I_LT_01_AT_F';};
						case 18: {_typeArray pushBack 'I_LT_01_AA_F';};
						case 19: {_typeArray pushBack 'B_APC_Wheeled_01_cannon_F';};
						case 20: {_typeArray pushBack 'B_AFV_Wheeled_01_cannon_F';};
						case 21: {_typeArray pushBack 'B_AFV_Wheeled_01_up_cannon_F';};
						case 22: {_typeArray pushBack 'O_APC_Wheeled_02_rcws_v2_F';};
						case 23: {_typeArray pushBack 'I_APC_Wheeled_03_cannon_F';};
						case 24: {_typeArray pushBack 'I_APC_tracked_03_cannon_F';};
					};
				} else {
					_typeArray pushBack 'Arsenal';
				};

				[_args,_typeArray,_aioArsenal,_dir,_aircraft,_side,_radioSFX] spawn MAZ_EZM_fnc_airDropSupportModule; 
				_display closeDisplay 1;
			},{
				params ["_values","_args","_display"];
				_display closeDisplay 2;
			},
			[true] call MAZ_EZM_fnc_getScreenPosition,
			{
				params ["_display"];
				_display setVariable ["MAZ_EZM_isVehicle",false];
			}
			] call MAZ_EZM_fnc_createDialog;
		};