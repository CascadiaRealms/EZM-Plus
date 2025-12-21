			MAZ_DevToolsTree = [
					MAZ_zeusModulesTree,
					"Developer Tools",
					"a3\ui_f\data\gui\rsc\rscdisplayarcademap\icon_debug_ca.paa"
				] call MAZ_EZM_fnc_zeusAddCategory;

				[
					MAZ_zeusModulesTree,
					MAZ_DevToolsTree,
					"Animation Viewer",
					"Opens the Animation Viewer.\nIf placed on a unit it will open using that unit and its current animation.",
					"MAZ_EZM_fnc_openAnimViewerModule",
					"a3\ui_f\data\gui\cfg\keyframeanimation\iconcamera_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_DevToolsTree,
					"Open Debug Console",
					"Opens the Debug Console.\nthis refers to the entity the console is placed onto.",
					"MAZ_EZM_fnc_debugConsoleLocalModule",
					"a3\3den\data\displays\display3den\entitymenu\findconfig_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_DevToolsTree,
					"Find in Config Viewer",
					"Opens the Config Viewer to the entity's config.",
					"MAZ_EZM_fnc_showObjectConfig",
					"a3\3den\data\displays\display3den\entitymenu\findconfig_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_DevToolsTree,
					"Function Viewer",
					"Opens the Function Viewer.",
					"MAZ_EZM_fnc_functionViewer",
					"a3\ui_f\data\gui\rsc\rscdisplayarcademap\icon_functions_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_DevToolsTree,
					"GUI Editor",
					"Opens the GUI Editor.",
					"MAZ_EZM_fnc_openGUIEditor"
				] call MAZ_EZM_fnc_zeusAddModule;