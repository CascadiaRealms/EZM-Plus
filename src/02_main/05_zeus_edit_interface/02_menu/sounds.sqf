MAZ_SoundsTree = [
					MAZ_zeusModulesTree,
					"Sounds",
					'\A3\ui_f\data\IGUI\RscIngameUI\RscDisplayChannel\MuteVON_ca.paa'
				] call MAZ_EZM_fnc_zeusAddCategory;

				[
					MAZ_zeusModulesTree,
					MAZ_SoundsTree,
					'Jukebox',
					'Music Player:\n\nThis module will open the Jukebox GUI and play music for everyone.\nView and preview all music in arma 3.\nClick the green (top left) to play the selected song for everyone.',
					'M9sd_fnc_moduleOpenJUKEBOX',
					'a3\modules_f_curator\data\portraitmusic_ca.paa'
				] call MAZ_EZM_fnc_zeusAddModule;
				
				[
					MAZ_zeusModulesTree,
					MAZ_SoundsTree,
					'Sound Board 2.0',
					'Open the Sound Board GUI and play any sound from the game files.\nYou can preview sounds to play them only on your client,\nor you can play them on all clients.',
					'M9sd_fnc_moduleSoundBoard2',
					'a3\modules_f_curator\data\portraitSound_ca.paa'
				] call MAZ_EZM_fnc_zeusAddModule;