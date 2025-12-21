MAZ_PlayerModTree = [
					MAZ_zeusModulesTree,
					"Player Modifiers",
					"a3\ui_f\data\gui\rsc\rscdisplaymain\menu_singleplayer_ca.paa"
				] call MAZ_EZM_fnc_zeusAddCategory;

				[
					MAZ_zeusModulesTree,
					MAZ_PlayerModTree,
					"Change Side",
					"Change the side of the selected player.",
					"MAZ_EZM_fnc_changeSideModule",
					'\A3\ui_f\data\IGUI\Cfg\simpleTasks\types\meet_ca.paa'
				] call MAZ_EZM_fnc_zeusAddModule;
				
				[
					MAZ_zeusModulesTree,
					MAZ_PlayerModTree,
					"Disarm",
					"Removes the weapons from a player.",
					"MAZ_EZM_fnc_disarmModule",
					'\a3\3den\data\displays\display3den\entitymenu\arsenal_ca.paa'
				] call MAZ_EZM_fnc_zeusAddModule;
				
				[
					MAZ_zeusModulesTree,
					MAZ_PlayerModTree,
					"Heal / Revive",
					"Heal and/or revive the selected player.",
					"MAZ_EZM_fnc_healAndReviveModule",
					'\A3\ui_f\data\IGUI\Cfg\simpleTasks\types\heal_ca.paa'
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_PlayerModTree,
					"Heal / Revive All",
					"Heal and/or revive all players.",
					"MAZ_EZM_fnc_healAndReviveAllModule",
					'\A3\ui_f\data\IGUI\Cfg\simpleTasks\types\heal_ca.paa'
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_PlayerModTree,
					"Kill Player",
					"Kills the player its placed on.",
					"MAZ_EZM_fnc_killUnit",
					"a3\ui_f_curator\data\cfgmarkers\kia_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_PlayerModTree,
					"Force Eject",
					"Eject players from the selected vehicle.",
					"MAZ_EZM_fnc_forceEjectModule",
					'\A3\ui_f\data\IGUI\Cfg\actions\eject_ca.paa'
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_PlayerModTree,
					"Toggle Mute Server",
					"Toggles every player's voice chat (Global, Side, Group, Command).",
					"MAZ_EZM_fnc_muteServerModule",
					'\A3\ui_f\data\IGUI\RscIngameUI\RscDisplayChannel\MuteVON_crossed_ca.paa'
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_PlayerModTree,
					"Reset Player Loadout",
					"Removes a player's loadout.",
					"MAZ_EZM_fnc_resetLoadout",
					"a3\ui_f\data\igui\cfg\actions\obsolete\ui_action_gear_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;
				
				[
					MAZ_zeusModulesTree,
					MAZ_PlayerModTree,
					"Toggle ZEUS access.",
					"Give or remvoke a player's access to ZEUS mode.",
					"MAZ_EZM_fnc_togglePlayerZEUS",
					"a3\ui_f\data\igui\cfg\actions\obsolete\ui_action_gear_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;