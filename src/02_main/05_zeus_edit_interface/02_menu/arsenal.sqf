MAZ_ArsenalTree = [
					MAZ_zeusModulesTree,
					"Arsenal Creator",
					'\A3\ui_f\data\Logos\a_64_ca.paa'
				] call MAZ_EZM_fnc_zeusAddCategory;
				
				MAZ_zeusModulesTree tvSetTooltip [[MAZ_ArsenalTree], ""];

				[
					MAZ_zeusModulesTree,
					MAZ_ArsenalTree,
					"AIO Arsenal",
					"All-In-One Arsenal (by M9-SD)\n\nDescription:\n There are two ways to use this module:\n(1) Place onto another object to make it an AIO arsenal.\n(2) Place on ground to spawn supply box AIO arsenal.\n\nIncludes the following options:\n- Full Arsenal\n- Quick Rearm\n- Copy Loadout\n- Empty Loadout\n- Save Respawn Loadout\n- Load Respawn Loadout\n- Delete Respawn Loadout\n- Edit Group Loadouts",
					"MAZ_EZM_fnc_createAIOArsenalDialog",
					'\A3\ui_f\data\Logos\a_64_ca.paa'
				] call MAZ_EZM_fnc_zeusAddModule;
				
				[
					MAZ_zeusModulesTree,
					MAZ_ArsenalTree,
					"Reset All Saved Loadouts",
					"Delete All Saved Loadouts\n\nDescription:\n This module will remove the saved loadouts from all players.",
					"MAZ_EZM_fnc_resetSavedLoadouts",
					'\A3\ui_f\data\Logos\a_64_ca.paa'
				] call MAZ_EZM_fnc_zeusAddModule;