MAZ_CleanUpTree = [
					MAZ_zeusModulesTree,
					"Clean-Up Tools",
					"a3\3den\data\displays\display3den\panelleft\entitylist_delete_ca.paa"
				] call MAZ_EZM_fnc_zeusAddCategory;

				[
					MAZ_zeusModulesTree,
					MAZ_CleanUpTree,
					"Delete Bodies",
					"Similar to Delete Clutter except it does not delete destroyed buildings.",
					"MAZ_EZM_fnc_deleteBodies",
					"a3\3den\data\displays\display3den\panelleft\entitylist_delete_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_CleanUpTree,
					"Delete Clutter",
					"Deletes all clutter on the ground.",
					"MAZ_EZM_fnc_deleteClutterModule",
					"a3\3den\data\displays\display3den\panelleft\entitylist_delete_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_CleanUpTree,
					"Delete Empty Groups",
					"Deletes all empty groups.",
					"MAZ_EZM_fnc_deleteEmptyGroupsModule",
					"\a3\ui_f_curator\data\rsccommon\rscattributeformation\wedge_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;
				
				[
					MAZ_zeusModulesTree,
					MAZ_CleanUpTree,
					"Delete Everything",
					"Deletes all mission objects.",
					"MAZ_EZM_fnc_deleteEverythingModule",
					"a3\3den\data\displays\display3den\panelleft\entitylist_delete_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_CleanUpTree,
					"Delete Markers",
					"Deletes all markers.",
					"MAZ_EZM_fnc_deleteMarkersModule",
					"a3\3den\data\displays\display3den\panelright\submode_marker_icon_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_CleanUpTree,
					"Delete Mines",
					"Deletes all mines.",
					"MAZ_EZM_fnc_deleteMinesModule",
					"a3\ui_f_curator\data\cfgmarkers\minefieldap_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_CleanUpTree,
					"Delete Protection Zones",
					"Deletes all protection zones.",
					"MAZ_EZM_fnc_deleteProtectionZonesModule"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_CleanUpTree,
					"Delete Radius",
					"Deletes all objects in a radius.",
					"MAZ_EZM_fnc_deleteRadiusModule",
					"a3\3den\data\displays\display3den\panelleft\entitylist_delete_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;
