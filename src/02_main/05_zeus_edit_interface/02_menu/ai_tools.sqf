comment "AI Modifers";
				MAZ_EditAITree = [
					MAZ_zeusModulesTree,
					"AI Modifiers",
					'\A3\ui_f\data\IGUI\Cfg\simpleTasks\types\intel_ca.paa'
				] call MAZ_EZM_fnc_zeusAddCategory;

				[
					MAZ_zeusModulesTree,
					MAZ_EditAITree,
					"Garrison (Instant)",
					"Places AI's group in randomized position in nearest building.",
					"MAZ_EZM_fnc_garrisonInstantModule",
					'\A3\ui_f\data\IGUI\Cfg\simpleTasks\types\run_ca.paa'
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_EditAITree,
					"Garrison (Search)",
					"Places AI's group in randomized position in nearest building.",
					"MAZ_EZM_fnc_garrisonSearchModule",
					'\A3\ui_f\data\IGUI\Cfg\simpleTasks\types\getin_ca.paa'
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_EditAITree,
					"Un-Garrison",
					"Removes AI from their garrisoned position.",
					"MAZ_EZM_fnc_unGarrisonModule",
					'\A3\ui_f\data\IGUI\Cfg\simpleTasks\types\getout_ca.paa'
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_EditAITree,
					"Edit AI Equipment",
					"Remove or equip AI with NVGs or flashlights.",
					"MAZ_EZM_fnc_removeNVGsAddFlashlightsModule",
					"a3\ui_f\data\igui\cfg\actions\gear_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_EditAITree,
					"Enable AI Lasers",
					"Makes AI turn on their lasers and lights.",
					"MAZ_EZM_fnc_toggleLightsModule",
					"a3\ui_f_curator\data\cfgcurator\laser_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_EditAITree,
					"Disable AI Lasers",
					"Makes AI turn off their lasers and lights.",
					"MAZ_EZM_fnc_toggleOffLightsModule",
					"a3\ui_f\data\map\markers\military\dot_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_EditAITree,
					"Make Hostage",
					"Makes AI into a restrained hostage.",
					"MAZ_EZM_fnc_makeHostageModule",
					'\A3\ui_f\data\IGUI\Cfg\simpleTasks\types\help_ca.paa'
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_EditAITree,
					"Make HVT",
					"Makes AI an HVT that, when killed, everyone will be notified.",
					"MAZ_EZM_fnc_makeHVTModule",
					"a3\modules_f_curator\data\portraitobjectiveneutralize_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;
				
				[
					MAZ_zeusModulesTree,
					MAZ_EditAITree,
					"Set Ambient Animation",
					"Set Ambient Animations",
					"MAZ_EZM_fnc_setAmbientAnimationModule",
					"a3\ui_f_curator\data\rsccommon\rscattributepunishmentanimation\pushupslegs.paa"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_EditAITree,
					"Set Difficulty",
					"Adjust all AI's difficulty.",
					"MAZ_EZM_fnc_changeDifficultyModule",
					'\A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\SI_stand_ca.paa'
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_EditAITree,
					"Set Stance",
					"Makes AI forced into stance mode. i.e. prone, crouch, standing, auto.",
					"MAZ_EZM_fnc_changeStanceModule",
					'\A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\SI_stand_ca.paa'
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_EditAITree,
					"Suppressive Fire",
					"Makes the AI suppress the position you select.",
					"MAZ_EZM_fnc_suppressiveFireModule",
					"a3\static_f_oldman\hmg_02\data\ui\icon_hmg_02_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_EditAITree,
					"Toggle Unit Surrender",
					"Makes AI surrender or un-surrender.",
					"MAZ_EZM_fnc_toggleSurrenderModule",
					'\A3\ui_f\data\IGUI\Cfg\simpleTasks\types\help_ca.paa'
				] call MAZ_EZM_fnc_zeusAddModule;

			comment "AI Supports";
				MAZ_AISupportTree = [
					MAZ_zeusModulesTree,
					"AI Supports",
					"a3\modules_f_curator\data\portraitradio_ca.paa"
				] call MAZ_EZM_fnc_zeusAddCategory;
				
				[
					MAZ_zeusModulesTree,
					MAZ_AISupportTree,
					"Airdrop",
					"Calls an airdrop to module position.",
					"MAZ_EZM_fnc_callAirdropModule",
					"a3\air_f_beta\parachute_01\data\ui\portrait_parachute_01_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_AISupportTree,
					"Evac Helicopter",
					"HOW TO USE:\n1: Place module on position to which a helicopter will fly and land to pickup players.\n2: Select secondary position that the helicopter will drop them off at.",
					"MAZ_EZM_fnc_callEvacModule",
					"a3\air_f\heli_light_01\data\ui\map_heli_light_01_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_AISupportTree,
					"Call Reinforcements",
					"HOW TO USE:\n1: Place module on position to which a helicopter will fly and drop off troops.\n2: Select reinforcements parameters in menu.\n3: Select secondary position that reinforcements will move to on foot.",
					"MAZ_EZM_fnc_callReinforcements",
					'\A3\ui_f\data\gui\rsc\rscdisplayarsenal\radio_ca.paa'
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_AISupportTree,
					"Mortar Area",
					"Sends virtual fire support to the area with a radius of error and a delay between rounds.",
					"MAZ_EZM_fnc_mortarAreaModule",
					"a3\static_f\mortar_01\data\ui\map_mortar_01_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;