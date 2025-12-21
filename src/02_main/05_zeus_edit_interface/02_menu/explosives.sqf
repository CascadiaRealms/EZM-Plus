MAZ_ExplosivesTree = [
					MAZ_zeusModulesTree,
					"Explosives",
					'\A3\ui_f\data\IGUI\Cfg\simpleTasks\types\destroy_ca.paa'
				] call MAZ_EZM_fnc_zeusAddCategory;

				[
					MAZ_zeusModulesTree,
					MAZ_ExplosivesTree,
					"Create Minefield",
					"Create a minefield of specific mines in a radius.",
					"MAZ_EZM_fnc_createMinefieldModule",
					"a3\ui_f_curator\data\cfgmarkers\minefieldap_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_ExplosivesTree,
					"Create IED",
					"Create an IED that will detonate when a specific side gets close.",
					"MAZ_EZM_fnc_createIEDModule",
					"a3\ui_f_curator\data\cfgmarkers\minefieldap_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;