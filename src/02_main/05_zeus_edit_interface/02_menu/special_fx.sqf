MAZ_SpecialFXTree = [
					MAZ_zeusModulesTree,
					"Special Effects",
					'\A3\ui_f\data\IGUI\Cfg\simpleTasks\types\destroy_ca.paa'
				] call MAZ_EZM_fnc_zeusAddCategory;
				
				[
					MAZ_zeusModulesTree,
					MAZ_SpecialFXTree,
					"Particle Effect",
					"Creates a particle effect of your choosing.\nSmoke and Fire effects of various sizes.",
					"MAZ_EZM_fnc_createParticleEffectModule",
					"a3\ui_f\data\igui\cfg\actions\obsolete\ui_action_fire_in_flame_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_SpecialFXTree,
					"Earthquake",
					"Creates an earthquake.",
					"MAZ_EZM_fnc_earthquakeEffectModule",
					"a3\modules_f\data\editterrainobject\icon_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_SpecialFXTree,
					"Toggle Lamps",
					"Disables or enables lamps in a radius.",
					"MAZ_EZM_fnc_toggleLampsModule",
					"a3\3den\data\displays\display3den\toolbar\flashlight_off_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_SpecialFXTree,
					"Tracers",
					"Creates tracer effects in at the position.",
					"MAZ_EZM_fnc_tracerModuleDialog",
					"a3\modules_f_curator\data\portraittracers_ca.paa"
				] call MAZ_EZM_fnc_zeusAddModule;