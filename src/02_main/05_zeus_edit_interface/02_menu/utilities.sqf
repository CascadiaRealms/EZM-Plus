MAZ_UtilitiesTree = [
					MAZ_zeusModulesTree,
					"Utilities",
					"a3\3den\data\cfgwaypoints\scripted_ca.paa"
				] call MAZ_EZM_fnc_zeusAddCategory;
				
				[
					MAZ_zeusModulesTree,
					MAZ_UtilitiesTree,
					"Add Objects to Interface",
					"Adds all objects to your zeus interface.",
					"MAZ_EZM_fnc_addObjectsToInterfaceModule",
					'\A3\ui_f\data\IGUI\Cfg\simpleTasks\types\download_ca.paa'
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_UtilitiesTree,
					"Add Objects to Interface (Radius)",
					"Adds all objects to your zeus interface within a radius.",
					"MAZ_EZM_fnc_addObjectsToInterfaceRadiusModule",
					'\A3\ui_f\data\IGUI\Cfg\simpleTasks\types\download_ca.paa'
				] call MAZ_EZM_fnc_zeusAddModule;
				
				[
					MAZ_zeusModulesTree,
					MAZ_UtilitiesTree,
					"Toggle Auto-Add to Interface",
					"Adds all objects to your zeus interface when you open it.",
					"MAZ_EZM_fnc_toggleAutoAddToInterface",
					'\A3\3den\data\cfgwaypoints\cycle_ca.paa'
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_UtilitiesTree,
					"Toggle Auto-Cleaner System",
					"Automatically deletes destroyed objects when they're out of player view.",
					"MAZ_EZM_fnc_toggleCleaner",
					"a3\3den\data\displays\display3den\panelleft\entitylist_delete_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;