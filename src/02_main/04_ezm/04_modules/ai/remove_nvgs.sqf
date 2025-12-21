MAZ_EZM_fnc_removeNVGsAddFlashlightsModule = {
			["Remove/Add AI Equipment",[
				[
					"TOOLBOX",
					"Night Vision:",
					[false,[["REMOVE","Removes NVGs from the selected side's AI."],["EQUIP","Adds NVGs to the selected side's AI."]]]
				],
				[
					"TOOLBOX",
					"Flashlights:",
					[true,[["REMOVE","Removes flashlights from the selected side's AI."],["EQUIP","Adds flashlights to the selected side's AI."]]]
				],
				[
					"TOOLBOX",
					["Smokes:","Helps performance when lots of AI may be throwing smoke."],
					[false,[["REMOVE","Removes smoke grenades from the selected side's AI."],["EQUIP","This doesn't do anything, I'm lazy..."]]]
				],
				[
					"SIDES",
					"Sides Effected:",
					[east,independent]
				]
			],{
				params ["_values","_args","_display"];
				_values params ["_nvgs","_flashlights","_smokes","_sides"];
				{
					if((!isPlayer _x) && (side _x in _sides)) then {
						private _unit = _x;
						private _NVGArray = [
							"NVGoggles",
							"NVGoggles_OPFOR",
							"NVGoggles_INDEP",
							"NVGoggles_tna_F",
							"O_NVGoggles_ghex_F",
							"O_NVGoggles_grn_F",
							"O_NVGoggles_hex_F",
							"O_NVGoggles_urb_F",
							"NVGogglesB_blk_F",
							"NVGogglesB_grn_F",
							"NVGogglesB_gry_F",
							"Integrated_NVG_TI_1_F"
						];
						if(_nvgs) then {
							private _default = getUnitLoadout (configFile >> "CfgVehicles" >> typeOf _unit);
							_unit linkItem (_default # 9 # 5);
						} else {
							{
								if(_x in _NVGArray) then {
									_unit unlinkItem _x;
								};
							}forEach assignedItems _unit;
						};

						if(_flashlights) then {
							_unit addWeaponItem [primaryWeapon _unit,"acc_flashlight",true];
						} else {
							_unit addWeaponItem [primaryWeapon _unit,"acc_pointer_ir",true];
						};

						private _smokesArray = ["SmokeShellBlue","SmokeShellGreen","SmokeShellOrange","SmokeShellPurple","SmokeShellRed","SmokeShell","SmokeShellYellow"];
						if(!_smokes) then {
							{
								if(_x in _smokesArray) then {
									_unit removeMagazine _x;
								};
							}forEach magazines _unit;
						};
					};
				}forEach allUnits;
				["AI Equipment updated.","addItemOk"] call MAZ_EZM_fnc_systemMessage;
				_display closeDisplay 1;
			},{
				params ["_values","_args","_display"];
				_display closeDisplay 2;
			},[]] call MAZ_EZM_fnc_createDialog;
		};