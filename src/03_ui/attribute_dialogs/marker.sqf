MAZ_EZM_fnc_createMarkerAttributesDialog = {
	params ["_marker"];
	if(dialog) then {
		closeDialog 2;
	};
	[_marker] spawn {
		params ["_marker"];
		openMap false;
		private _markerType = getText (configfile >> "CfgMarkers" >> (markerType _marker) >> "icon");
		private _colorData = [];
		{
			private _colorActive = _x;
			private _colorNormal = [_x # 0,_x # 1,_x # 2,0.5];
			_colorData pushBack [_colorActive,_colorNormal];
		}forEach [
			[0,0,0,1],
			[0,0,0,1],
			[0.5,0.5,0.5,1],
			[0.9,0,0,1],
			[0.5,0.25,0,1],
			[0.85,0.4,0,1],
			[0.85,0.85,0,1],
			[0.5,0.6,0.4,1],
			[0,0.8,0,1],
			[0,0,1,1],
			[1,1,1,1],
			[profileNamespace getVariable ['Map_BLUFOR_R',0],profileNamespace getVariable ['Map_BLUFOR_G',1],profileNamespace getVariable ['Map_BLUFOR_B',1],profileNamespace getVariable ['Map_BLUFOR_A',1]],
			[profileNamespace getVariable ['Map_OPFOR_R',0],profileNamespace getVariable ['Map_OPFOR_G',1],profileNamespace getVariable ['Map_OPFOR_B',1],profileNamespace getVariable ['Map_OPFOR_A',1]],
			[profileNamespace getVariable ['Map_Independent_R',0],profileNamespace getVariable ['Map_Independent_G',1],profileNamespace getVariable ['Map_Independent_B',1],profileNamespace getVariable ['Map_Independent_A',1]],
			[profileNamespace getVariable ['Map_Civilian_R',0],profileNamespace getVariable ['Map_Civilian_G',1],profileNamespace getVariable ['Map_Civilian_B',1],profileNamespace getVariable ['Map_Civilian_A',1]],
			[profileNamespace getVariable ['Map_Unknown_R',0],profileNamespace getVariable ['Map_Unknown_G',1],profileNamespace getVariable ['Map_Unknown_B',1],profileNamespace getVariable ['Map_Unknown_A',1]]
		];
		sleep 0.1;
		["EDIT MARKER",[ 
			[
				"EDIT",
				"Text:",
				[markerText _marker]
			],
			[
				"ICONS",
				"Color:",
				[
					markerColor _marker,
					[
						"Default",
						"ColorBlack",
						"ColorGrey",
						"ColorRed",
						"ColorBrown",
						"ColorOrange",
						"ColorYellow",
						"ColorKhaki",
						"ColorGreen",
						"ColorBlue",
						"ColorWhite",
						"ColorBLUFOR",
						"ColorOPFOR",
						"ColorGUER",
						"ColorCIV",
						"ColorUNKNOWN"
					],
					[
						_markerType,
						_markerType,
						_markerType,
						_markerType,
						_markerType,
						_markerType,
						_markerType,
						_markerType,
						_markerType,
						_markerType,
						_markerType,
						_markerType,
						_markerType,
						_markerType,
						_markerType,
						_markerType
					],
					[
						"Default",
						"Black",
						"Grey",
						"Red",
						"Brown",
						"Orange",
						"Yellow",
						"Khaki",
						"Green",
						"Blue",
						"White",
						"BLUFOR",
						"OPFOR",
						"Independent",
						"Civilian",
						"UNKNOWN"
					],
					[
						[9.5,0.2],
						[11.5,0.2],
						[13.5,0.2],
						[15.5,0.2],
						[17.5,0.2],
						[19.5,0.2],
						[21.5,0.2],
						[23.5,0.2],
						[9.5,2.2],
						[11.5,2.2],
						[13.5,2.2],
						[15.5,2.2],
						[17.5,2.2],
						[19.5,2.2],
						[21.5,2.2],
						[23.5,2.2]
					],
					[
						1.5,
						1.5,
						1.5,
						1.5,
						1.5,
						1.5,
						1.5,
						1.5,
						1.5,
						1.5,
						1.5,
						1.5,
						1.5,
						1.5,
						1.5,
						1.5
					],
					4,
					_colorData
				]
			],
			[
				"SLIDER",
				"Marker Direction:",
				[markerDir _marker,0,360,false]
			],
			[ 
				"NEWBUTTON", 
				"DELETE", 
				[ 
					"Deletes the Selected Marker.", 
					{
						params ["_display","_args"];
						deleteMarker _args;
						_display closeDisplay 0;
					}, 
					_marker
				] 
			]
		],{
			params ["_display","_values","_args"];
			_display closeDisplay 1;
		},{
			params ["_display","_values","_args"];
			[_args,_values] call MAZ_EZM_fnc_applyAttributeChangesToMarker;
			_display closeDisplay 0;
		},_marker] call MAZ_EZM_fnc_createAttributesDialog;
	};
};


MAZ_EZM_fnc_applyAttributeChangesToMarker = {
	params ["_marker","_attribs"];
	_attribs params ["_text","_markerColor","_markerDir"];
	_marker setMarkerText _text;
	_marker setMarkerColor _markerColor;
	MAZ_EZM_markerColorDefault = _markerColor;
	_marker setMarkerDir _markerDir;
};