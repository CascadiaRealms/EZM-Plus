MAZ_ObjectModTree = [
					MAZ_zeusModulesTree,
					"Object Modifiers",
					"a3\3den\data\displays\display3den\toolbar\widget_local_ca.paa"
				] call MAZ_EZM_fnc_zeusAddCategory;
				
				[
					MAZ_zeusModulesTree,
					MAZ_ObjectModTree,
					"Attach to Nearest",
					"Attaches the object to the nearest object.",
					"MAZ_EZM_fnc_attachToNearestModule"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_ObjectModTree,
					"Detach",
					"Detaches the object from anything it's attached to.",
					"MAZ_EZM_fnc_detachModule"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_ObjectModTree,
					"Edit Object Attributes",
					"Edit object attributes through an advanced menu.\nEdit textures, edit init fields, god mode, enable/disable sim, etc.",
					"MAZ_EZM_fnc_editObjectAttributesModule",
					"a3\3den\data\cfgwaypoints\scripted_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_ObjectModTree,
					"Replace w/ Simple Object",
					"Replaces the object it's placed on with a simple object to improve performance.",
					"MAZ_EZM_fnc_replaceWithSimpleObject",
					"a3\3den\data\cfgwaypoints\scripted_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;
				
				[
					MAZ_zeusModulesTree,
					MAZ_ObjectModTree,
					"Set Color to Black",
					"Changes textures of an object / unit to black if possible.",
					"HYPER_EZM_fnc_setColorBlack",
					"a3\ui_f\data\gui\rsc\rscdisplaygarage\texturesources_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_ObjectModTree,
					"Toggle Simulation",
					"Enables or disables simulation on the object.",
					"MAZ_EZM_fnc_toggleSimulationModule",
					'\A3\ui_f\data\IGUI\Cfg\simpleTasks\types\danger_ca.paa'
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_ObjectModTree,
					"Toggle God Mode",
					"Makes the object god moded or un-god moded.",
					"MAZ_EZM_fnc_toggleInvincibleModule",
					'\A3\ui_f\data\IGUI\Cfg\simpleTasks\types\kill_ca.paa'
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_ObjectModTree,
					"Toggle Object Hidden",
					"Toggles whether the object is hidden.",
					"MAZ_EZM_fnc_toggleHideObjectModule",
					'\A3\ui_f\data\IGUI\Cfg\simpleTasks\types\scout_ca.paa'
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_ObjectModTree,
					"Un-Hide All Objects",
					"Un-Hides all hidden objects.",
					"MAZ_EZM_fnc_unHideObjectAllModule",
					'\A3\ui_f\data\IGUI\Cfg\simpleTasks\types\whiteboard_ca.paa'
				] call MAZ_EZM_fnc_zeusAddModule;