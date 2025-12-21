[] call MAZ_EZM_fnc_drawEventhandlerAreaMarkers;
				
				MAZ_MarkersTree = [
					MAZ_zeusModulesTree,
					"Markers",
					"a3\3den\data\displays\display3den\panelright\submode_marker_icon_ca.paa"
				] call MAZ_EZM_fnc_zeusAddCategory;
				
				[
					MAZ_zeusModulesTree,
					MAZ_MarkersTree,
					"Create Area Marker",
					"Creates an area marker on the map position.",
					"MAZ_EZM_fnc_createAreaMarker",
					"a3\ui_f\data\map\markerbrushes\fdiagonal_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_MarkersTree,
					"Create AO Markers",
					"Creates markers that darkens out everywhere except for the AO.",
					"MAZ_EZM_fnc_createAOMarkerDialog",
					"a3\ui_f\data\gui\rsc\rscdisplayarsenal\map_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_MarkersTree,
					"Delete AO Markers",
					"Deletes the spawned AO Markers.",
					"MAZ_EZM_fnc_deleteAOMarkers",
					"a3\ui_f\data\gui\rsc\rscdisplayarcademap\icon_exit_cross_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;