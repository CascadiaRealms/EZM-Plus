MAZ_EnvironmentTree = [
					MAZ_zeusModulesTree,
					"Environment",
					"a3\modules_f_curator\data\portraitweather_ca.paa"
				] call MAZ_EZM_fnc_zeusAddCategory;

				[
					MAZ_zeusModulesTree,
					MAZ_EnvironmentTree,
					"Change Time",
					"Change the current time.",
					"MAZ_EZM_fnc_changeTimeModule",
					"a3\modules_f_curator\data\portraitskiptime_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_EnvironmentTree,
					"Change Date",
					"Change the current date.",
					"MAZ_EZM_fnc_changeDateModule",
					"a3\modules_f_curator\data\portraitskiptime_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_EnvironmentTree,
					"Edit Weather Conditions",
					"Edit the current meteorological atmospheric environment conditions.",
					"MAZ_EZM_fnc_editWeatherConditionsModule",
					"a3\modules_f_curator\data\portraitweather_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;