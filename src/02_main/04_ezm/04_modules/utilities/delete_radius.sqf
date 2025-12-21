MAZ_EZM_fnc_deleteRadiusModule = {
			private _pos = [true] call MAZ_EZM_fnc_getScreenPosition;
			["Delete Objects In Radius",[
				[
					"SLIDER:RADIUS",
					"Radius",
					[10,1000,100,_pos,[1,1,1,1]]
				]
			],{
				params ["_values","_args","_display"];
				private _objects = [_args,_values # 0] call MAZ_EZM_fnc_getEditableObjectsRadius;
				[_objects] call MAZ_EZM_fnc_deleteObjectsServer;
				_display closeDisplay 1;
			},{
				params ["_values","_args","_display"];
				_display closeDisplay 2;
			},_pos] call MAZ_EZM_fnc_createDialog;
		};