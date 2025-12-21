MAZ_GameplayTree = [
					MAZ_zeusModulesTree,
					"Gameplay",
					'\A3\ui_f\data\IGUI\Cfg\simpleTasks\types\meet_ca.paa'
				] call MAZ_EZM_fnc_zeusAddCategory;
				
				[
					MAZ_zeusModulesTree,
					MAZ_GameplayTree,
					"Create Countdown",
					"Creates an on screen countdown for players of specified side.",
					"MAZ_EZM_fnc_createCountdownModule",
					"a3\ui_f\data\igui\cfg\actions\settimer_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_GameplayTree,
					"Create Intel",
					"Creates an intel object to be picked up by the players.\nCreated by: Bijx",
					"HYPER_EZM_fnc_createIntel",
					"a3\ui_f\data\igui\cfg\simpletasks\types\documents_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_GameplayTree,
					"Create AAN News Article",
					"Creates a laptop which shows an AAN News Article when interacted on.\nCreated by: Bijx",
					"HYPER_EZM_fnc_createAANIntel",
					"a3\ui_f\data\igui\cfg\simpletasks\types\documents_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;