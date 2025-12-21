MAZ_EZM_fnc_createAreaMarker = {
			if(!visibleMap) exitWith {["Cannot place a marker without the map open!","addItemFailed"] call MAZ_EZM_fnc_systemMessage;};
			private _position = [] call MAZ_EZM_fnc_getScreenPosition;
			if(isNil "MAZ_EZM_areaMarkers") then {
				MAZ_EZM_areaMarkers = [];
				publicVariable 'MAZ_EZM_areaMarkers';
			};
			private _marker = createMarker [format ["MAZ_EZM_marker_%1",count MAZ_EZM_areaMarkers],_position];
			_marker setMarkerSize [50,50];
			_marker setMarkerShape "ELLIPSE";
			MAZ_EZM_areaMarkers pushBack _marker;
			publicVariable 'MAZ_EZM_areaMarkers';
			[_marker] call MAZ_EZM_fnc_createEditAreaMarkerDialog;
		};

		MAZ_EZM_fnc_editAreaMarker = {
			params ["_marker","_values"];
			_values params ["_markerText","_markerPos","_markerSize","_markerBrush","_markerColor","_markerShape","_markerAlpha"];
			_marker setMarkerText _markerText;
			_marker setMarkerPos _markerPos;
			_marker setMarkerSize _markerSize;
			_marker setMarkerBrush _markerBrush;
			_marker setMarkerColor _markerColor;
			_marker setMarkerAlpha _markerAlpha;
			_marker setMarkerShape (["ELLIPSE","RECTANGLE"] select _markerShape);
		};

		MAZ_EZM_fnc_createEditAreaMarkerDialog = {
			params ["_marker"];
			(getMarkerSize _marker) params ["_sizeX","_sizeY"];
			(getMarkerPos _marker) params ["_posX","_posY"];
			private _markerShapeSelect = [false,true] select (markerShape _marker == "RECTANGLE");
			private _dataList = [];
			{
				private _color = getArray (configFile >> "CfgMarkerColors" >> _x >> "color");
				if([0,0,0,1] isEqualTo _color) then {_color = [1,1,1,1]};
				if((_color select 0) isEqualType "") then {
					{
						_color set [_forEachIndex,call (compile _x)];
					}forEach _color;
				};
				_dataList pushback [getText (configFile >> "CfgMarkerColors" >> _x >> "name"), "", "",_color];
			}forEach ["Default","ColorBlack","ColorGrey","ColorRed","ColorBrown","ColorOrange","ColorYellow","ColorKhaki","ColorGreen","ColorBlue","ColorPink","ColorWhite","ColorWest","ColorEAST","ColorGUER","ColorCIV","ColorUNKNOWN"];

			private _brushList = [];
			{
				_brushList pushBack [getText (configFile >> "CfgMarkerBrushes" >> _x >> "name"), "", getText (configFile >> "CfgMarkerBrushes" >> _x >> "texture")];
			}forEach ["Solid","SolidFull","SolidBorder","Border","Horizontal","Vertical","Grid","FDiagonal","BDiagonal","Diaggrid","Cross"];

			["Edit Area Marker",[
				[
					"EDIT",
					"Marker Text:",
					[markerText _marker]
				],
				[
					"VECTOR",
					"Position:",
					[[_posX,_posY],["X","Y"],2]
				],
				[
					"VECTOR",
					"Size:",
					[[_sizeX,_sizeY],["X","Y"],2]
				],
				[
					"COMBO",
					"Marker Brush:",
					[
						["Solid","SolidFull","SolidBorder","Border","Horizontal","Vertical","Grid","FDiagonal","BDiagonal","Diaggrid","Cross"],
						_brushList,
						(["Solid","SolidFull","SolidBorder","Border","Horizontal","Vertical","Grid","FDiagonal","BDiagonal","Diaggrid","Cross"] find (markerBrush _marker))
					]
				],
				[
					"COMBO",
					"Marker Color:",
					[
						["Default","ColorBlack","ColorGrey","ColorRed","ColorBrown","ColorOrange","ColorYellow","ColorKhaki","ColorGreen","ColorBlue","ColorPink","ColorWhite","ColorWest","ColorEAST","ColorGUER","ColorCIV","ColorUNKNOWN"],
						_dataList,
						(["Default","ColorBlack","ColorGrey","ColorRed","ColorBrown","ColorOrange","ColorYellow","ColorKhaki","ColorGreen","ColorBlue","ColorPink","ColorWhite","ColorWest","ColorEAST","ColorGUER","ColorCIV","ColorUNKNOWN"] find (markerColor _marker))
					]
				],
				[
					"TOOLBOX",
					"Marker Shape:",
					[_markerShapeSelect,[["ELLIPSE","Circle marker type."],["RECTANGLE","Rectangle marker type."]]]
				],
				[
					"SLIDER",
					"Marker Alpha:",
					[
						0,
						1,
						markerAlpha _marker,
						objNull,
						[1,1,1,1],
						true
					]
				]
			],{
				params ["_values","_args","_display"];
				[_args,_values] call MAZ_EZM_fnc_editAreaMarker;
				_display closeDisplay 1;
			},{
				params ["_values","_args","_display"];
				_display closeDisplay 2;
			},_marker] call MAZ_EZM_fnc_createDialog;
		};