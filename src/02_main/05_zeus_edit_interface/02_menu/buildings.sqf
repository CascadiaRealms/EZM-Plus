MAZ_BuildingInteriorsTree = [
					MAZ_zeusModulesTree,
					"Building Interiors",
					"a3\3den\data\cfg3den\group\iconcustomcomposition_ca.paa"
				] call MAZ_EZM_fnc_zeusAddCategory;

				[
					MAZ_zeusModulesTree,
					MAZ_BuildingInteriorsTree,
					"Spawn Interior",
					"Spawn random interior data onto selected building.",
					"MAZ_EZM_fnc_createBuildingInteriorCall",
					"a3\3den\data\cfg3den\group\iconcustomcomposition_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_BuildingInteriorsTree,
					"Remove Interior",
					"Removes interior from selected building.",
					"MAZ_EZM_fnc_removeBuildingInteriorCall",
					"a3\3den\data\cfg3den\group\iconcustomcomposition_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_BuildingInteriorsTree,
					"Get Default Interior Data",
					"Resets EZM interior data to the default. \nThis will remove any custom compositions you may have created!",
					"MAZ_EZM_fnc_getDefaultInteriors",
					"a3\3den\data\displays\display3den\toolbar\undo_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;