MAZ_ServerSettingsTree = [
					MAZ_zeusModulesTree,
					"Server Settings",
					"a3\3den\data\displays\display3den\statusbar\server_ca.paa"
				] call MAZ_EZM_fnc_zeusAddCategory;

				private _maxPlayable = (playableSlotsNumber west) + (playableSlotsNumber east) + (playableSlotsNumber independent) + (playableSlotsNumber civilian) + (playableSlotsNumber sideLogic);
				if(_maxPlayable > 18) then {
					[
						MAZ_zeusModulesTree,
						MAZ_ServerSettingsTree,
						"48+2 Team Switcher",
						"Makes all players on the selected side when they join making everyone in the server the same side.\nPrimarily for 48+2 servers.",
						"MAZ_EZM_fnc_482SideSwitchInit",
						'\A3\ui_f\data\IGUI\Cfg\simpleTasks\types\help_ca.paa'
					] call MAZ_EZM_fnc_zeusAddModule;
				};

				[
					MAZ_zeusModulesTree,
					MAZ_ServerSettingsTree,
					"Change Side Relations",
					"Change the relations of different sides towards Independent factions.",
					"MAZ_EZM_fnc_changeSideRelationsModule",
					"a3\ui_f\data\gui\cfg\communicationmenu\attack_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_ServerSettingsTree,
					"Change Map Indicators",
					"Change the shown map indicators.",
					"MAZ_EZM_fnc_changeMapIndicators"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_ServerSettingsTree,
					"Disable Mortars",
					"Disable or enable mortars for all players.",
					"MAZ_EZM_fnc_disableMortarsModule",
					'\A3\ui_f\data\GUI\Cfg\CommunicationMenu\mortar_ca.paa'
				] call MAZ_EZM_fnc_zeusAddModule;
				
				[
					MAZ_zeusModulesTree,
					MAZ_ServerSettingsTree,
					"Set Respawn Timer",
					"Set the respawn timer.",
					"MAZ_EZM_fnc_setRespawnTimerModule",
					"a3\ui_f\data\igui\cfg\actions\settimer_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;
				
				[
					MAZ_zeusModulesTree,
					MAZ_ServerSettingsTree,
					"Remove Team-Killers",
					"Removes the Team-Killer status from all players.",
					"MAZ_EZM_fnc_noTeamKillersModule",
					"a3\ui_f_curator\data\cfgmarkers\kia_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_ServerSettingsTree,
					"Toggle Server Protections",
					"Prevents known trolls and malicious scripters from joining the server.\nAlerts players if an unauthorized person has access to Zeus.\nAlerts players when someone rejoins with a different name.",
					"MAZ_EZM_fnc_toggleServerProtections",
					"a3\ui_f\data\igui\cfg\holdactions\holdaction_secure_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;