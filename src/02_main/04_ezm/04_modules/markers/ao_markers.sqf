MAZ_EZM_fnc_createAOMarkerDialog = {
			private _pos = [true] call MAZ_EZM_fnc_getScreenPosition;
			["Create AO Markers",[
				[
					"VECTOR",
					"Size:",
					[[500,500],["X","Y"],2]
				],
				[
					"COMBO",
					"Border Color:",
					[
						["Default","ColorBlack","ColorGrey","ColorRed","ColorBrown","ColorOrange","ColorYellow","ColorKhaki","ColorGreen","ColorBlue","ColorPink","ColorWhite","ColorWest","ColorEAST","ColorGUER","ColorCIV","ColorUNKNOWN"],
						["Default","ColorBlack","ColorGrey","ColorRed","ColorBrown","ColorOrange","ColorYellow","ColorKhaki","ColorGreen","ColorBlue","ColorPink","ColorWhite","ColorWest","ColorEAST","ColorGUER","ColorCIV","ColorUNKNOWN"],
						13
					]
				]
			],{
				params ["_values","_args","_display"];
				_values params ["_size","_color"];
				[_args,_size,_color] call MAZ_EZM_fnc_createAOMarkers;
				_display closeDisplay 1;
			},{
				params ["_values","_args","_display"];
				_display closeDisplay 2;
			},_pos] call MAZ_EZM_fnc_createDialog;
		};

		MAZ_EZM_fnc_createAOMarkers = {
			params ["_pos","_size","_color"];
			private _middleLeft = [((_pos # 0) - (_size # 0)) / 2,worldSize/2];
			private _edgeRight = (_pos # 0) + (_size # 0);
			private _middleRight = [((worldSize - _edgeRight) / 2) + _edgeRight,worldSize/2];

			private _edgeTop = (_pos # 1) + (_size # 1);
			private _edgeBottom = (_pos # 1) - (_size # 1);
			private _middleTop = [_pos # 0, ((worldSize - _edgeTop) / 2) + _edgeTop];
			private _middleBottom = [_pos # 0, _edgeBottom / 2];

			createMarker ["MAZ_AO_LeftMarker",[0,0,0]];
			"MAZ_AO_LeftMarker" setMarkerPos _middleLeft;
			"MAZ_AO_LeftMarker" setMarkerShape "RECTANGLE";
			"MAZ_AO_LeftMarker" setMarkerBrush "SolidFull";
			"MAZ_AO_LeftMarker" setMarkerColor "ColorBlack";
			"MAZ_AO_LeftMarker" setMarkerAlpha 0.5;
			"MAZ_AO_LeftMarker" setMarkerSize _middleLeft;

			createMarker ["MAZ_AO_RightMarker",[0,0,0]];
			"MAZ_AO_RightMarker" setMarkerPos _middleRight;
			"MAZ_AO_RightMarker" setMarkerShape "RECTANGLE";
			"MAZ_AO_RightMarker" setMarkerBrush "SolidFull";
			"MAZ_AO_RightMarker" setMarkerColor "ColorBlack";
			"MAZ_AO_RightMarker" setMarkerAlpha 0.5;
			"MAZ_AO_RightMarker" setMarkerSize [(_middleRight # 0) - _edgeRight, worldSize/2];

			createMarker ["MAZ_AO_BottomMarker",[0,0,0]];
			"MAZ_AO_BottomMarker" setMarkerPos _middleBottom;
			"MAZ_AO_BottomMarker" setMarkerShape "RECTANGLE";
			"MAZ_AO_BottomMarker" setMarkerBrush "SolidFull";
			"MAZ_AO_BottomMarker" setMarkerColor "ColorBlack";
			"MAZ_AO_BottomMarker" setMarkerAlpha 0.5;
			"MAZ_AO_BottomMarker" setMarkerSize [_size # 0, _middleBottom # 1];

			createMarker ["MAZ_AO_TopMarker",[0,0,0]];
			"MAZ_AO_TopMarker" setMarkerPos _middleTop;
			"MAZ_AO_TopMarker" setMarkerShape "RECTANGLE";
			"MAZ_AO_TopMarker" setMarkerBrush "SolidFull";
			"MAZ_AO_TopMarker" setMarkerColor "ColorBlack";
			"MAZ_AO_TopMarker" setMarkerAlpha 0.5;
			"MAZ_AO_TopMarker" setMarkerSize [_size # 0, (_middleTop # 1) - _edgeTop];

			createMarker ["MAZ_AO_Border",[0,0,0]];
			"MAZ_AO_Border" setMarkerPos _pos;
			"MAZ_AO_Border" setMarkerShape "RECTANGLE";
			"MAZ_AO_Border" setMarkerBrush "Border";
			"MAZ_AO_Border" setMarkerColor _color;
			"MAZ_AO_Border" setMarkerSize _size;
		};

		MAZ_EZM_fnc_deleteAOMarkers = {
			{
				deleteMarker _x;
			}forEach ["MAZ_AO_LeftMarker","MAZ_AO_RightMarker","MAZ_AO_TopMarker","MAZ_AO_BottomMarker","MAZ_AO_Border"];
		};