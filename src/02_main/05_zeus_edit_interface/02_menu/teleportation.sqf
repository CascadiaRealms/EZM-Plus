MAZ_TeleportTree = [
					MAZ_zeusModulesTree,
					"Teleportation",
					"a3\ui_f\data\igui\cfg\simpletasks\types\move_ca.paa"
				] call MAZ_EZM_fnc_zeusAddCategory;
				
				[
					MAZ_zeusModulesTree,
					MAZ_TeleportTree,
					"Teleport Self",
					"Teleport your character to the modules position.",
					"MAZ_EZM_fnc_teleportSelfModule"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_TeleportTree,
					"Teleport All Players",
					"Teleport all players to the modules position.",
					"MAZ_EZM_fnc_teleportAllPlayersModule",
					"a3\ui_f\data\gui\rsc\rscdisplaymain\menu_multiplayer_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_TeleportTree,
					"Teleport One Player",
					"Teleport specific player to the modules position.",
					"MAZ_EZM_fnc_teleportPlayerModule",
					"a3\ui_f\data\gui\rsc\rscdisplaymain\menu_singleplayer_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_TeleportTree,
					"Teleport Side",
					"Teleport specific side to the modules position.",
					"MAZ_EZM_fnc_teleportSideModule",
					'\A3\ui_f\data\IGUI\Cfg\simpleTasks\types\meet_ca.paa'
				] call MAZ_EZM_fnc_zeusAddModule;