HYPER_EZM_fnc_createAANIntel = {
			private _target = [true] call MAZ_EZM_fnc_getScreenPosition;
			private _dialogTitle = "Create AAN News Article";
			private _content = [
				[
					"EDIT",
					["Title", "The headline title of the article."],
					[
						"My Title",
						1
					]
				],
				[
					"EDIT",
					["Author Name", "The name of the author."],
					[
						name player,
						1
					]
				],
				[
					"EDIT",
					["Timestamp", "The date and time of the article, which MUST follow the format YYYY/MM/DD HH:MM."],
					[
						"2035/01/31 10:00",
						1
					]
				],
				[
					"EDIT",
					["Timezone", "The timezone of the article."],
					[
						"CET",
						1
					]
				],
				[
					"EDIT",
					["Subtitle", "A brief description of the article under the main title."],
					[
						"",
						1
					]
				],
				[
					"COMBO",
					["Image", "The image to be displayed with the article headline."],
					[
						["warthog", "divers", "breach", "ww2medical", "exfil", "soldiers", "schematic", "riot", "ambulance", "ww2attack", "ghosts", "town", "decon", "tank", "launcher", "cargotrain", "convoy", "fallen", "firefight", "fleet", "drones"],
						["A-10 Warthog", "Divers", "Breach and Clear", "WW2 Medical", "Helo Exfil", "Two Soldiers", "Plane Schematic", "Riot", "Ambulance", "WW2 Assault", "Ghosts of War", "Town Liberated", "Decon Showers", "Tank", "Launcher", "Cargo Train", "Convoy", "Coffin Salute", "Firefight", "Carrier Fleet", "Small Drones"],
						0
					]
				],
				[
					"EDIT:MULTI",
					["Body Text", "The main body of the article."],
					[
						"",
						5
					]
				],
				[
					"EDIT:MULTI",
					["Body Text Locked", "A paragraph that is cut off by a subscription paywall."],
					[
						"",
						3
					]
				]
			];
			private _onConfirm = {
				params ["_values", "_args", "_display"];
				_values params ["_title","_authorName","_timestamp","_timezone","_subtitle","_image","_bodyText","_bodyTextLocked"];
				private _target = _args;

				[ _values, _target ] call HYPER_EZM_fnc_handleCreateIntelDetails;
				_display closeDisplay 1;
			};
			private _onCancel = {
				params ["_values", "_args", "_display"];
				_display closeDisplay 2;
			};
			[
				_dialogTitle,
				_content,
				_onConfirm,
				_onCancel,
				_target
			] call MAZ_EZM_fnc_createDialog;
		};