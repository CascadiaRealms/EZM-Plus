MAZ_VehicleModTree = [
					MAZ_zeusModulesTree,
					"Vehicle Modifiers",
					"a3\ui_f\data\igui\cfg\vehicletoggles\engineiconon_ca.paa"
				] call MAZ_EZM_fnc_zeusAddCategory;

				[
					MAZ_zeusModulesTree,
					MAZ_VehicleModTree,
					"Unflip Vehicle",
					"Unflip the vehicle the module is placed on.",
					"MAZ_EZM_fnc_unflipVehicleModule"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_VehicleModTree,
					"Rearm",
					"Rearm the vehicle.",
					"MAZ_EZM_fnc_rearmVehicleModule",
					'\A3\ui_f\data\IGUI\Cfg\simpleTasks\types\rearm_ca.paa'
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_VehicleModTree,
					"Refuel",
					"Refuel the vehicle.",
					"MAZ_EZM_fnc_refuelVehicleModule",
					'\A3\ui_f\data\IGUI\Cfg\simpleTasks\types\refuel_ca.paa'
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_VehicleModTree,
					"Repair",
					"Repair the vehicle.",
					"MAZ_EZM_fnc_repairVehicleModule",
					'\A3\ui_f\data\IGUI\Cfg\simpleTasks\types\repair_ca.paa'
				] call MAZ_EZM_fnc_zeusAddModule;
				
				[
					MAZ_zeusModulesTree,
					MAZ_VehicleModTree,
					"Set Plate Number",
					"Set the license plate number of a car.",
					"HYPER_EZM_fnc_setPlateNumber",
					"a3\ui_f\data\igui\cfg\simpletasks\types\car_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;