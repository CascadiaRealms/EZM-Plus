MAZ_MessagesTree = [
					MAZ_zeusModulesTree,
					"Messages",
					"a3\3den\data\cfg3den\comment\texture_ca.paa"
				] call MAZ_EZM_fnc_zeusAddCategory;
				
				[
					MAZ_zeusModulesTree,
					MAZ_MessagesTree,
					'3D Speak',
					'Make an speak via 3D text above head.',
					'MAZ_EZM_fnc_3DSpeakModule',
					'\A3\ui_f\data\IGUI\Cfg\simpleTasks\types\talk3_ca.paa'
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_MessagesTree,
					"Send Subtitle Message",
					"Sends a subtitle message to specific side players.",
					"MAZ_EZM_fnc_sendSubtitleModule",
					"a3\3den\data\cfg3den\comment\texture_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_MessagesTree,
					'Voice Dialog Message',
					'Play a voiced message from Arma 3.\n(Select voice lines from a menu.)',
					'MAZ_EZM_fnc_moduleDialogMessage',
					'\A3\ui_f\data\IGUI\Cfg\actions\talk_ca.paa'
				] call MAZ_EZM_fnc_zeusAddModule;
