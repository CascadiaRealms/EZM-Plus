MAZ_ZeusTree = [
					MAZ_zeusModulesTree,
					"Zeus Settings",
					"a3\ui_f_curator\data\logos\arma3_zeus_icon_ca.paa"
				] call MAZ_EZM_fnc_zeusAddCategory;

				[
					MAZ_zeusModulesTree,
					MAZ_ZeusTree,
					"Toggle Game Mod Rights",
					"Change the Game Moderator rights.",
					"MAZ_EZM_fnc_toggleGameModerator",
					"a3\3den\data\attributes\taskstates\canceled_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_ZeusTree,
					"Edit Zeus Interface",
					"Change the Zeus interface colors and opacity.",
					"MAZ_EZM_fnc_editZeusInterfaceColors",
					"a3\modules_f_curator\data\iconpostprocess_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;
				
				[
					MAZ_zeusModulesTree,
					MAZ_ZeusTree,
					"Grant ZEUS Access",
					"Give a player's access to ZEUS mode.",
					"MAZ_EZM_fnc_grantPlayerZEUS",
					"a3\ui_f\data\igui\cfg\actions\obsolete\arma3_zeus_icon_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;
				[
					MAZ_zeusModulesTree,
					MAZ_ZeusTree,
					"Revoke ZEUS Access",
					"Revoke a player's access to ZEUS mode.",
					"MAZ_EZM_fnc_revokePlayerZEUS",
					"a3\ui_f_curator\data\logos\arma3_zeus_icon_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;

				if(typeOf player != "C_Man_French_universal_F") then {
					[
						MAZ_zeusModulesTree,
						MAZ_ZeusTree,
						"Create Zeus Unit",
						"Change the Zeus interface colors and opacity.",
						"MAZ_EZM_fnc_askAboutZeusUnit",
						"a3\ui_f_curator\data\logos\arma3_zeus_icon_ca.paa"
					] call MAZ_EZM_fnc_zeusAddModule;
				};
				
				