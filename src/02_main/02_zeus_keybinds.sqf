MAZ_EZM_addZeusKeybinds_312 = {
	waitUntil{!isNull(findDisplay 312)};

	if(!isNil "MAZ_EZM_closeZeusInterface") then {
		(findDisplay 312) displayRemoveEventHandler ["KeyDown",MAZ_EZM_closeZeusInterface];
	};
	if(!isNil "MAZ_EZM_changeCuratorSideEH") then {
		(findDisplay 312) displayRemoveEventHandler ["KeyDown",MAZ_EZM_changeCuratorSideEH];
	};

	if(!isNil "MAZ_EZM_remoteControlShortcutUpEH") then {
		(findDisplay 312) displayRemoveEventHandler ["MouseButtonUp",MAZ_EZM_remoteControlShortcutUpEH];
	};
	if(!isNil "MAZ_EZM_remoteControlShortcutDownEH") then {
		(findDisplay 312) displayRemoveEventHandler ["MouseButtonDown",MAZ_EZM_remoteControlShortcutDownEH];
	};
	
	if(!isNil "MAZ_EZM_mapClickDownEH") then {
		((findDisplay 312) displayCtrl 50) ctrlRemoveEventHandler ["MouseButtonDown",MAZ_EZM_mapClickDownEH];
	};
	if(!isNil "MAZ_EZM_mapClickUpEH") then {
		((findDisplay 312) displayCtrl 50) ctrlRemoveEventHandler ["MouseButtonUp",MAZ_EZM_mapClickUpEH];
	};
	if(!isNil "MAZ_EZM_mapMovingEH") then {
		((findDisplay 312) displayCtrl 50) ctrlRemoveEventHandler ["MouseMoving",MAZ_EZM_mapMovingEH];
	};
	if(!isNil "MAZ_EZM_deleteMarkerMapEH") then {
		(findDisplay 312) displayRemoveEventHandler ["KeyDown",MAZ_EZM_deleteMarkerMapEH];
	};
	if(!isNil "MAZ_EZM_mapDoubleClickEH") then {
		((findDisplay 312) displayCtrl 50) ctrlRemoveEventHandler ["MouseButtonDblClick",MAZ_EZM_mapDoubleClickEH];
	};

	if(!isNil "MAZ_EZM_rightClickContextMenuUpEH") then {
		(findDisplay 312) displayRemoveEventHandler ["MouseButtonUp",MAZ_EZM_rightClickContextMenuUpEH];
	};
	if(!isNil "MAZ_EZM_rightClickContextMenuDownEH") then {
		(findDisplay 312) displayRemoveEventHandler ["MouseButtonDown",MAZ_EZM_rightClickContextMenuDownEH];
	};

	if(!isNil "MAZ_EZM_deployFlaresOnAircraft") then {
		(findDisplay 312) displayRemoveEventHandler ["KeyDown",MAZ_EZM_deployFlaresOnAircraft];
	};

	if(!isNil "MAZ_EZM_editorTabActions") then {
		(findDisplay 312) displayRemoveEventHandler ["KeyDown",MAZ_EZM_editorTabActions];
	};

	if(!isNil "MAZ_EZM_copyPasteFix") then {
		(findDisplay 312) displayRemoveEventHandler ["KeyDown",MAZ_EZM_copyPasteFix];
	};

	MAZ_EZM_closeZeusInterface = (findDisplay 312) displayAddEventHandler ["KeyDown", {
		params ["_displayOrControl", "_key", "_shift", "_ctrl", "_alt"];
		if(_key == 21 && _ctrl) then {
			(findDisplay 312) closeDisplay 0;
		};
	}];
	MAZ_EZM_changeCuratorSideEH = (findDisplay 312) displayAddEventHandler ["KeyDown", {
		params ["_displayOrControl", "_key", "_shift", "_ctrl", "_alt"];
		if(_key == 22 && _ctrl) then {
			[] spawn MAZ_EZM_fnc_groupMenuTeamSwitcher;
		};
	}];

	MAZ_EZM_remoteControlShortcutDownEH = (findDisplay 312) displayAddEventHandler ["MouseButtonDown",{
		params ["_displayOrControl", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];
		if(_button == 0 && _alt) then {
			if(isNil "MAZ_EZM_mousePressTime") then {
				MAZ_EZM_mousePressTime = time;
			};
		};
	}];
	MAZ_EZM_remoteControlShortcutUpEH = (findDisplay 312) displayAddEventHandler ["MouseButtonUp", {
		params ["_displayOrControl", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];
		
		if(_button == 0 && _alt) then {
			private _buttonHoldTime = time - MAZ_EZM_mousePressTime;
			MAZ_EZM_mousePressTime = nil;
			if(_buttonHoldTime < 0.1) then {
				private _logic = createVehicle ["Land_HelipadEmpty_F",[0,0,0],[],0,"CAN_COLLIDE"];
				[_logic,_targetObj,true] spawn MAZ_EZM_BIS_fnc_remoteControlUnit;
			};
		};
	}];

	MAZ_EZM_mapClickDownEH = ((findDisplay 312) displayCtrl 50) ctrlAddEventHandler ["MouseButtonDown",{
		params ["_displayOrControl", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];
		if(_button != 0) exitWith {};
		if((curatorMouseOver isEqualTo []) or (curatorMouseOver isEqualTo [''])) then {
			private _pos = [] call MAZ_EZM_fnc_getScreenPosition;
			if(({(markerPos _x) distance2D _pos < 75} count allMapMarkers) != 0) then {
				private _closest = nil;
				{
					if(isNil "_closest" && ((markerPos _x) distance2D _pos < 75)) then {
						_closest = _x;
					};
					if(!isNil "_closest" && markerPos _x distance2D _pos < markerPos _closest distance2D _pos) then {
						_closest = _x;
					};
				}forEach allMapMarkers;
				if(!isNil "_closest") then {
					if((markerShape _closest == "ELLIPSE") || (markerShape _closest == "RECTANGLE")) then {
						_displayOrControl setVariable ["EZM_isMovingMarker",true];
						_displayOrControl setVariable ["EZM_movingMarker",_closest];
					};
				};
			};
		};
	}];
	MAZ_EZM_mapClickUpEH = ((findDisplay 312) displayCtrl 50) ctrlAddEventHandler ["MouseButtonUp",{
		params ["_displayOrControl", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];
		if(_button != 0) exitWith {};
		if(_displayOrControl getVariable ["EZM_isMovingMarker",false]) then {
			private _marker = _displayOrControl getVariable "EZM_movingMarker";
			if(!isNil "_marker") then {
				_marker setMarkerPos (getMarkerPos _marker);
			};
			_displayOrControl setVariable ["EZM_isMovingMarker",false];
			_displayOrControl setVariable ["EZM_movingMarker",nil];
		};
	}];
	MAZ_EZM_mapMovingEH = ((findDisplay 312) displayCtrl 50) ctrlAddEventHandler ["MouseMoving",{
		params ["_control", "_xPos", "_yPos", "_mouseOver"];
		if(_control getVariable ["EZM_isMovingMarker",false]) then {
			private _marker = _control getVariable "EZM_movingMarker";
			if(!isNil "_marker") then {
				_marker setMarkerPosLocal (_control ctrlMapScreenToWorld getMousePosition);
			};
		};
	}];
	MAZ_EZM_deleteMarkerMapEH = (findDisplay 312) displayAddEventHandler ["KeyDown",{
		params ["_displayOrControl", "_key", "_shift", "_ctrl", "_alt"];
		if(!visibleMap) exitWith {};
		if(_key != 211) exitWith {};
		if((curatorMouseOver isEqualTo []) or (curatorMouseOver isEqualTo [''])) then {
			private _pos = [] call MAZ_EZM_fnc_getScreenPosition;
			if(({(markerPos _x) distance2D _pos < 100} count allMapMarkers) != 0) then {
				private _closest = nil;
				{
					if(isNil "_closest" && ((markerPos _x) distance2D _pos < 100)) then {
						_closest = _x;
					};
					if(!isNil "_closest" && markerPos _x distance2D _pos < markerPos _closest distance2D _pos) then {
						_closest = _x;
					};
				}forEach allMapMarkers;
				if(!isNil "_closest") then {
					if((markerShape _closest == "ELLIPSE") || (markerShape _closest == "RECTANGLE")) then {
						deleteMarker _closest;
					};
				};
			};
		};
	}];
	MAZ_EZM_mapDoubleClickEH = ((findDisplay 312) displayCtrl 50) ctrlAddEventHandler ["MouseButtonDblClick",{
		params ["_control", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];
		private _pos = [] call MAZ_EZM_fnc_getScreenPosition;
		if ((curatorMouseOver isEqualTo []) or (curatorMouseOver isEqualTo [''])) then {
			if(({(markerPos _x) distance2D _pos < 100} count allMapMarkers) != 0) then {
				private _closest = nil;
				{
					if(isNil "_closest" && ((markerPos _x) distance2D _pos < 100)) then {
						_closest = _x;
					};
					if(!isNil "_closest" && markerPos _x distance2D _pos < markerPos _closest distance2D _pos) then {
						_closest = _x;
					};
				}forEach allMapMarkers;
				if(!isNil "_closest") then {
					if((markerShape _closest == "ELLIPSE") || (markerShape _closest == "RECTANGLE")) then {
						[_closest] spawn MAZ_EZM_fnc_createEditAreaMarkerDialog;
					} else {
						[_closest] spawn MAZ_EZM_fnc_createMarkerAttributesDialog;
					};
				};
			};
		};
	}];

	MAZ_EZM_rightClickContextMenuDownEH = (findDisplay 312) displayAddEventHandler ["MouseButtonDown",{
		params ["_displayOrControl", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];
		if(_button == 1 && (!_ctrl && !_shift && !_alt)) then {
			
				MAZ_EZM_mousePressTimeContext = time;
			
			comment "detect mouse movement (panning camera)";
			
				JAM_EZM_mouseMovementContext = getMousePosition;
			
		};
	}];
	MAZ_EZM_rightClickContextMenuUpEH = (findDisplay 312) displayAddEventHandler ["MouseButtonUp", {
		params ["_displayOrControl", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];
		comment "TODO:Optimize";
		if(_button == 1 && (!_ctrl && !_shift && !_alt)) then {
			if (isNil 'MAZ_EZM_mousePressTimeContext') then {MAZ_EZM_mousePressTimeContext = time;};
			private _buttonHoldTime = time - MAZ_EZM_mousePressTimeContext;
			MAZ_EZM_mousePressTimeContext = nil;
			if (_buttonHoldTime < 0.2) then {
			
				comment "Tweak amount of tolerance (for camera panning):";
				
				comment "systemchat 'holdtime good';";
				
				_wiggleRoom = 0.01;
			
				_mousePosLast = missionNamespace getvariable ['JAM_EZM_mouseMovementContext', getMousePosition];
				_mousePosCurrent = getMousePosition;
				
				_mousePosLast_x = _mousePosLast # 0;
				_mousePosLast_y = _mousePosLast # 1;
				
				_mousePosCurrent_x = _mousePosCurrent # 0;
				_mousePosCurrent_y = _mousePosCurrent # 1;
				
				_difference_x = _mousePosCurrent_x - _mousePosLast_x;
				_difference_y = _mousePosCurrent_y - _mousePosLast_y;
				
				_absoluteDifference_x = if (_difference_x < 0) then {_difference_x * -1} else {_difference_x};
				_absoluteDifference_y = if (_difference_y < 0) then {_difference_y * -1} else {_difference_y};
				
				comment "distance formula: d=√((x2−x1)^2+(y2−y1)^2)";
				
				_distanceTraveled = sqrt (((_difference_x)^2) + ((_difference_y)^2));
				
				if (_distanceTraveled <= _wiggleRoom) then {
					call MAZ_EZM_fnc_openContextMenu;
				};
			};
		} else {
			[] spawn {
				sleep 0.01;
				call MAZ_EZM_fnc_closeContextMenu;
			};
		};
	}];

	MAZ_EZM_deployFlaresOnAircraft = (findDisplay 312) displayAddEventhandler ["KeyDown",{
		params ["_displayOrControl", "_key", "_shift", "_ctrl", "_alt"];
		if(!(_key in (actionKeys "launchCM")) || (_shift || _ctrl || _alt)) exitWith {};
		if(!(curatorMouseOver isEqualTo []) && !(curatorMouseOver isEqualTo [''])) then {
			private _vehicle = curatorMouseOver select 1;
			if(typeOf _vehicle isKindOf "Air") then {
				private _driverVeh = driver _vehicle;
				if(!isPlayer _driverVeh && alive _driverVeh) then {
					_driverVeh spawn {
						for "_i" from 0 to 3 do {
							_this forceWeaponFire ["CMFlareLauncher", "AIBurst"];
							sleep 0.4;
						};
					};
				};
			};
		};
		private _objectsSelected = curatorSelected select 0;
		{
			if(typeOf _x isKindOf "Air") then {
				private _driverVeh = driver _x;
				if(!isPlayer _driverVeh && alive _driverVeh) then {
					_driverVeh spawn {
						for "_i" from 0 to 3 do {
							_this forceWeaponFire ["CMFlareLauncher", "AIBurst"];
							sleep 0.4;
						};
					};
				};
			};
		}forEach _objectsSelected;
	}];

	MAZ_EZM_editorTabActions = (findDisplay 312) displayAddEventHandler ["KeyDown",{
		params ["_displayOrControl", "_key", "_shift", "_ctrl", "_alt"];
		if(!(_key in [59,60,61,62,63])) exitWith {};
		switch (_key) do {
			case 59: {
				if(_shift) then {
					[(findDisplay 312) displayCtrl 155] call MAZ_EZM_fnc_emulateSideClick;
				} else {
					[((findDisplay 312) displayCtrl 150)] call MAZ_EZM_fnc_emulateModeClick;
					MAZ_EZM_isInGroupTabVar = false;
				};
			};
			case 60: {
				if(_shift) then {
					[(findDisplay 312) displayCtrl 156] call MAZ_EZM_fnc_emulateSideClick;
				} else {
					[((findDisplay 312) displayCtrl 151)] call MAZ_EZM_fnc_emulateModeClick;
					MAZ_EZM_isInGroupTabVar = true;
				};
			};
			case 61: {
				if(_shift) then {
					[(findDisplay 312) displayCtrl 157] call MAZ_EZM_fnc_emulateSideClick;
				} else {
					[((findDisplay 312) displayCtrl 152)] call MAZ_EZM_fnc_emulateModeClick;
					MAZ_EZM_isInGroupTabVar = false;
				};
			};
			case 62: {
				if(_shift) then {
					[(findDisplay 312) displayCtrl 158] call MAZ_EZM_fnc_emulateSideClick;
				} else {
					[((findDisplay 312) displayCtrl 154)] call MAZ_EZM_fnc_emulateModeClick;
					MAZ_EZM_isInGroupTabVar = false;
				};
			};
			case 63: {
				if(_shift) then {
					[(findDisplay 312) displayCtrl 159] call MAZ_EZM_fnc_emulateSideClick;
				} else {
					[((findDisplay 312) displayCtrl 170)] call MAZ_EZM_fnc_emulateModeClick;
					MAZ_EZM_isInGroupTabVar = false;
				};
			};
		};
	}];

	MAZ_EZM_copyPasteFix = (findDisplay 312) displayAddEventHandler ["KeyDown",{
		params ["_displayOrControl", "_key", "_shift", "_ctrl", "_alt"];
		if(!_ctrl) exitWith {};
		if(!(_key in [46,47])) exitWith {};
		if(isNil "MAZ_EZM_copyingTimerOn") then {
			MAZ_EZM_copyingTimerOn = false;
		};
		switch (_key) do {
			case 46: {
				MAZ_EZM_copyingTimer = 15;
				if(!MAZ_EZM_copyingTimerOn) then {
					[] spawn {
						MAZ_EZM_copyingTimerOn = true;
						while {MAZ_EZM_copyingTimer > 0} do {
							sleep 1;
							MAZ_EZM_copyingTimer = MAZ_EZM_copyingTimer - 1;
						};
						MAZ_EZM_copyingTimerOn = false;
					};
				};
			};
			case 47: {
				if(MAZ_EZM_copyingTimerOn) then {
					MAZ_EZM_copyingTimer = 15;
				};
			};
		};
	}];
};
