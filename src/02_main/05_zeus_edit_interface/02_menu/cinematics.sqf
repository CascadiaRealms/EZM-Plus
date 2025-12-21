MAZ_Cinematics = [
					MAZ_zeusModulesTree,
					"Cinematics",
					"a3\ui_f\data\gui\cfg\keyframeanimation\iconcamera_ca.paa"
				] call MAZ_EZM_fnc_zeusAddCategory;

				[
					MAZ_zeusModulesTree,
					MAZ_Cinematics,
					"Circle Cinematic",
					"Create a cinematic that circles around a specified area.",
					"MAZ_EZM_fnc_circleCinematicDialog",
					"a3\ui_f\data\igui\cfg\islandmap\iconcamera_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_Cinematics,
					"Intro Cinematic",
					"Create an introduction cinematic showcasing the scenario name, your name, and some optional text.\nCreated by: Bijx",
					"HYPER_EZM_fnc_introCinematicModule",
					"a3\ui_f\data\igui\cfg\islandmap\iconcamera_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;