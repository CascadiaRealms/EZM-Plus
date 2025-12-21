MAZ_terrainObjectModTree = [
					MAZ_zeusModulesTree,
					"Terrain Object Modifiers",
					"a3\ui_f\data\igui\rscingameui\rscunitinfo\icon_terrain_ca.paa"
				] call MAZ_EZM_fnc_zeusAddCategory;

				[
					MAZ_zeusModulesTree,
					MAZ_terrainObjectModTree,
					"Edit Building Doors",
					"Allows you to open and close doors on buildings.",
					"MAZ_EZM_fnc_openDoorsModule",
					"\a3\ui_f\data\igui\cfg\actions\open_door_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_terrainObjectModTree,
					"God Mode Fences",
					"Allows you to god mode fences in a radius.\nPlayers will no longer be able to ram through walls that aren't half destroyed.",
					"MAZ_EZM_fnc_godModeFencesModule",
					"a3\modules_f\data\editterrainobject\texturechecked_wall_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_terrainObjectModTree,
					"Hide Terrain Objects (Radius)",
					"Hide terrain objects in a given radius.",
					"MAZ_EZM_fnc_hideTerrainRadiusModule",
					"a3\modules_f\data\hideterrainobjects\icon_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;