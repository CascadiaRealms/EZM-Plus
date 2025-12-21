
MAZ_EZM_fnc_emulateModeClick = {
	params ["_ctrl"];
	ctrlActivate _ctrl;
	uiNamespace setVariable ["MAZ_EZM_emulateModeCtrl",_ctrl];
	with uiNamespace do {
		private _ctrlSelected = MAZ_EZM_emulateModeCtrl;
		private _display = ctrlparent _ctrlSelected;
		private _mode = 0;
		{
			private _ctrl = _display displayctrl _x;
			_ctrl ctrlsettextcolor [1,1,1,0.5];
			private _scale = 0.8;
			private _color = [1,1,1,0.5];
			if (_ctrl == _ctrlSelected) then {
				_scale = 1;
				_color = [1,1,1,1];
				_mode = _forEachIndex;
			};
			_ctrl ctrlsettextcolor _color;
			[_ctrl,_scale,0.1] call bis_fnc_ctrlsetscale;
		} forEach [150,151,152,154,170];
		with missionnamespace do {
			RscDisplayCurator_sections set [0,_mode];
		};
	};
	uiNamespace setVariable ["MAZ_EZM_emulateModeCtrl",nil];
	false
};

MAZ_EZM_fnc_emulateSideClick = {
	params ["_ctrl"];
	ctrlActivate _ctrl;
	uiNamespace setVariable ["MAZ_EZM_emulateSideCtrl",_ctrl];
	with uiNamespace do {
		private _ctrlSelected = MAZ_EZM_emulateSideCtrl;
		private _display = ctrlparent _ctrlSelected;
		private _selectedColor = [0,0,0,0];
		private _side = 0;
		{
			private _ctrl = _display displayctrl _x;

			private _color = _foreachindex call bis_fnc_sidecolor;
			private _scale = 0.8;
			if (_ctrl == _ctrlSelected) then {
				_selectedColor = _color;
				_scale = 1;
				_side = _foreachindex;
			} else {
				_color set [3,0.5];
			};
			_ctrl ctrlsettextcolor _color;
			[_ctrl,_scale,0.1] call bis_fnc_ctrlsetscale;
		} foreach [156,155,157,158,159];

		_selectedColor set [3,0.1];
		private _createBackground = _display displayctrl 15510;
		_createBackground ctrlsetbackgroundcolor _selectedColor;
		with missionnamespace do {
			RscDisplayCurator_sections set [1, [1, 0, 2, 3, 4] select _side];
		};
	};
	uiNamespace setVariable ["MAZ_EZM_emulateSideCtrl",nil];
	false
};
