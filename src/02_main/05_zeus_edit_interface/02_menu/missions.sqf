MAZ_AutoMissionTree = [
					MAZ_zeusModulesTree,
					"Automatic Missions",
					"a3\ui_f\data\map\markers\military\objective_ca.paa",
					[1,1,1,1],
					"Automated Missions that can be spawned on different maps."
				] call MAZ_EZM_fnc_zeusAddCategory;
				
				[
					MAZ_zeusModulesTree,
					MAZ_AutoMissionTree,
					"Toggle Automatic Heli Crash Missions",
					"Toggles randomized helicopter crash missions.\nWill spawn and last for 15 minutes before despawning.\nAfter a mission despawns or is completed another will spawn in 10 minutes.",
					"MAZ_EZM_fnc_toggleRandomHelicrashModule",
					"a3\modules_f_curator\data\portraitobjectiveneutralize_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_AutoMissionTree,
					"Toggle Automatic Convoy Missions",
					"Toggles randomized convoy missions.\nPlayers must capture the truck moving within the convoy.\nWill spawn and last until killed or reaching its destination.\nAfter a mission despawns or is completed another will spawn in 10 minutes.",
					"MAZ_EZM_fnc_toggleRandomConvoyModule",
					"a3\modules_f_curator\data\portraitobjectivemove_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_AutoMissionTree,
					"Auto Garrison Town",
					"Automatically garrisons a named town or the town where the module is placed.",
					"MAZ_EZM_fnc_createGarrisonTownDialog",
					"a3\modules_f_curator\data\portraitobjectiveneutralize_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;