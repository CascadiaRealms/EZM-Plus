comment "Dialog Creation";

MAZ_EZM_fnc_convertToGUI_GRIDFormat = {
	params ["_mode","_value"];

	comment "Defines";
		private _GUI_GRID_WAbs = ((safeZoneW / safeZoneH) min 1.2);
		private _GUI_GRID_HAbs = (_GUI_GRID_WAbs / 1.2);
		private _GUI_GRID_W = (_GUI_GRID_WAbs / 40);
		private _GUI_GRID_H = (_GUI_GRID_HAbs / 25);
		private _GUI_GRID_X = (safeZoneX);
		private _GUI_GRID_Y = (safeZoneY + safeZoneH - _GUI_GRID_HAbs);

		private _GUI_GRID_CENTER_WAbs = _GUI_GRID_WAbs;
		private _GUI_GRID_CENTER_HAbs = _GUI_GRID_HAbs;
		private _GUI_GRID_CENTER_W = _GUI_GRID_W;
		private _GUI_GRID_CENTER_H = _GUI_GRID_H;
		private _GUI_GRID_CENTER_X = (safeZoneX + (safeZoneW - _GUI_GRID_CENTER_WAbs)/2);
		private _GUI_GRID_CENTER_Y = (safeZoneY + (safeZoneH - _GUI_GRID_CENTER_HAbs)/2);

	comment "Mode Selection";
	private _return = switch (toUpper _mode) do {
		case "X": {((_value) * _GUI_GRID_W + _GUI_GRID_CENTER_X)};
		case "Y": {((_value) * _GUI_GRID_H + _GUI_GRID_CENTER_Y)};
		case "W": {((_value) * _GUI_GRID_W)};
		case "H": {((_value) * _GUI_GRID_H)};
	};
	_return
};
uiNamespace setVariable ["MAZ_EZM_fnc_convertToGUI_GRIDFormat",MAZ_EZM_fnc_convertToGUI_GRIDFormat];

MAZ_EZM_fnc_createDialogBase = {
	createDialog "RscDisplayEmpty";
	showchat true;
	private _display = findDisplay -1;

	private _label = _display ctrlCreate ["RscText",201];
	_label ctrlSetPositionX (["X",6.5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
	_label ctrlSetPositionW (["W",27] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
	_label ctrlSetPositionH (["H",1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
	_label ctrlSetBackgroundColor EZM_dialogColor;
	_label ctrlCommit 0;

	private _background = _display ctrlCreate ["RscText",202];
	_background ctrlSetPositionX (["X",6.5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
	_background ctrlSetPositionW (["W",27] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
	_background ctrlSetBackgroundColor EZM_dialogBackgroundCO;
	_background ctrlCommit 0;

	private _contentGroup = _display ctrlCreate ["RscControlsGroupNoScrollbars",203];
	_contentGroup ctrlSetPositionX (["X",7] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
	_contentGroup ctrlSetPositionW (["W",26] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
	_contentGroup ctrlCommit 0;

	private _okayButton = _display ctrlCreate ["RscButtonMenuOk",204];
	_okayButton ctrlSetPositionX (["X",28.5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
	_okayButton ctrlSetPositionW (["W",5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
	_okayButton ctrlSetPositionH (["H",1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
	_okayButton ctrlAddEventhandler ["ButtonClick",{
		params ["_control"];
		private _display = ctrlParent _control;
		(_display getVariable "MAZ_moduleMenuInfo") params ["_controls","_onConfirm","_onCancel","_args"];

		private _values = _controls apply {
			_x params ["_controlsGroup","_settings"];

			[_controlsGroup,_settings] call (_controlsGroup getVariable "controlValue");
		};

		[_values,_args,_display] call _onConfirm;
	}];
	_okayButton ctrlCommit 0;

	private _cancelButton = _display ctrlCreate ["RscButtonMenuCancel",205];
	_cancelButton ctrlSetPositionX (["X",6.5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
	_cancelButton ctrlSetPositionW (["W",5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
	_cancelButton ctrlSetPositionH (["H",1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
	_cancelButton ctrlAddEventhandler ["ButtonClick",{
		params ["_control"];
		private _display = ctrlParent _control;
		(_display getVariable "MAZ_moduleMenuInfo") params ["_controls","_onConfirm","_onCancel","_args"];

		private _values = _controls apply {
			_x params ["_controlsGroup","_settings"];

			[_controlsGroup,_settings] call (_controlsGroup getVariable "controlValue");
		};

		[_values,_args,_display] call _onCancel;
	}];
	_cancelButton ctrlCommit 0;

	_display displayAddEventHandler ["Unload", {
		params ["_display", "_exitCode"];

		if (_exitCode == 2) then {
			(_display getVariable "MAZ_moduleMenuInfo") params ["_controls","_onConfirm","_onCancel","_args"];

			private _values = _controls apply {
				_x params ["_controlsGroup","_settings"];

				[_controlsGroup,_settings] call (_controlsGroup getVariable "controlValue");
			};

			[_values,_args,_display] call _onCancel;
		};

		false
	}];

	_display
};

MAZ_EZM_fnc_createRowBase = {
	params ["_display"];
	private _contentGroup = _display displayCtrl 203;
	private _controlsGroupRow = _display ctrlCreate ["RscControlsGroupNoScrollbars",210,_contentGroup];
	_controlsGroupRow ctrlSetPosition [0,0,(["W",26] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),(["H",1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat)];
	_controlsGroupRow ctrlCommit 0;

	private _rowLabel = _display ctrlCreate ["RscText",211,_controlsGroupRow];
	_rowLabel ctrlSetPosition [0,0,(["W",10] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),(["H",1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat)];
	_rowLabel ctrlSetBackgroundColor [0,0,0,0.5];
	_rowLabel ctrlCommit 0;

	_controlsGroupRow
};

MAZ_EZM_fnc_createColorRow = {
	params ["_display","_data","_onChange"];
	_data params [
		["_rgb",[],[[]]]
	];

	private _rowControlGroup = [_display] call MAZ_EZM_fnc_createRowBase;

	private _doAlpha = (count _rgb) == 4;
	private _endIndex = if(_doAlpha) then {237} else {235};
	_rowControlGroup setVariable ["MAZ_EZM_doAlpha",_doAlpha];

	private _rowColors = [
		[1,0,0,1],
		[0,1,0,1],
		[0,0,1,1],
		[1,1,1,1]
	];
	private _index = 0;
	private _yPos = 0;
	for "_i" from 230 to _endIndex step 2 do {
		private _color = _rowColors # _index;
		private _inactiveColor = +_color;
		_inactiveColor set [3,0.6];

		private _slider = _display ctrlCreate ["RscXSliderH",_i,_rowControlGroup];
		_slider ctrlSetPosition [(["W",10.1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),_yPos,(["W",13.5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),(["H",1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat)];
		_slider ctrlSetForegroundColor _inactiveColor;
		_slider ctrlSetActiveColor _color;
		_slider sliderSetRange [0, 1];
		_slider sliderSetSpeed [0.1, 0.1];
		_slider sliderSetPosition (_rgb # _index);
		_slider ctrlCommit 0;
		_slider setVariable ["MAZ_EZM_onChange",_onChange];

		private _sliderEdit = _display ctrlCreate ["RscEdit",_i + 1,_rowControlGroup];
		_sliderEdit ctrlSetPosition [(["W",23.7] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),_yPos + pixelH,(["W",2.3] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),((["H",1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat) - pixelH)];
		_sliderEdit ctrlSetTextColor [1,1,1,1];
		_sliderEdit ctrlSetBackgroundColor [0,0,0,0.2];
		_sliderEdit ctrlSetText (str (sliderPosition _slider));
		_sliderEdit ctrlCommit 0;

		_slider ctrlAddEventHandler ["sliderPosChanged", {
			params ["_ctrlSlider", "_value"];
			private _controlGroup = ctrlParentControlsGroup _ctrlSlider;
			private _ctrlEdit = _controlGroup controlsGroupCtrl (ctrlIDC _ctrlSlider + 1);
			private _roundedValue = (round (_value * 100) / 100);
			_ctrlEdit ctrlSetText format ["%1",_roundedValue];

			private _valueRGB = [_controlGroup] call (_controlGroup getVariable "controlValue");
			private _picture = _controlGroup controlsGroupCtrl 238;
			if(count _valueRGB == 4) then {
				_picture ctrlSetText (format ["#(argb,8,8,3)color(%1,%2,%3,%4)",_valueRGB#0,_valueRGB#1,_valueRGB#2,_valueRGB#3]);
			} else {
				_picture ctrlSetText (format ["#(argb,8,8,3)color(%1,%2,%3,1)",_valueRGB#0,_valueRGB#1,_valueRGB#2]);
			};
			
			[ctrlParent _ctrlSlider,_valueRGB] call (_ctrlSlider getVariable "MAZ_EZM_onChange");
		}];

		_sliderEdit ctrlAddEventHandler ["keyUp",{
			params ["_control", "_key", "_shift", "_ctrl", "_alt"];
			private _num = parseNumber (ctrlText _control);
			private _ctrlGroup = ctrlParentControlsGroup _control;
			private _sliderCtrl = _ctrlGroup controlsGroupCtrl (ctrlIDC _control - 1);
			_sliderCtrl sliderSetPosition _num;
		}];	

		_yPos = _yPos + (["H",1.1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
		_index = _index + 1;
	};	

	private _picture = _display ctrlCreate ["RscPicture",238,_rowControlGroup];
	if(_doAlpha) then {
		_picture ctrlSetText (format ["#(argb,8,8,3)color(%1,%2,%3,%4)",_rgb#0,_rgb#1,_rgb#2,_rgb#3]);
	} else {
		_picture ctrlSetText (format ["#(argb,8,8,3)color(%1,%2,%3,1)",_rgb#0,_rgb#1,_rgb#2]);
	};
	_picture ctrlSetPosition [0,(["H",1.1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),(["W",10] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),_yPos - (["H",1.2] call MAZ_EZM_fnc_convertToGUI_GRIDFormat)];
	_picture ctrlCommit 0;

	_rowControlGroup ctrlSetPositionH _yPos;
	_rowControlGroup ctrlCommit 0;

	_rowControlGroup setVariable ["controlValue",{
		params ["_controlsGroup"];

		private _doAlpha = _controlsGroup getVariable ["MAZ_EZM_doAlpha",false];
		private _endIndex = if(_doAlpha) then {237} else {235};
		private _rgb = [];
		for "_i" from 230 to _endIndex step 2 do {
			private _slider = _controlsGroup controlsGroupCtrl _i;
			private _value = sliderPosition _slider;
			_rgb pushBack (round (_value * 100) / 100);
		};
		if(!_doAlpha) then {_rgb pushBack 1};
		_rgb;
	}];

	_rowControlGroup
};

MAZ_EZM_fnc_createComboRow = {
	params ["_display","_data","_onChange"];
	_data params [
		["_comboData",[],[[]]],
		["_comboNames",[],[[]]],
		["_defaultIndex",0,[0]]
	];
	private _rowControlGroup = [_display] call MAZ_EZM_fnc_createRowBase;

	private _combo = _display ctrlCreate ["RscCombo",213,_rowControlGroup];
	_combo ctrlSetPosition [(["W",10.1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),0,(["W",15.9] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),(["H",1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat)];
	_combo ctrlCommit 0;

	_combo setVariable ["MAZ_EZM_onChange",_onChange];

	_combo ctrlAddEventHandler ["lbSelChanged", {
		params ["_control", "_lbCurSel", "_lbSelection"];
		[ctrlParent _control,_lbSelection] call (_control getVariable "MAZ_EZM_onChange");
	}];

	for "_i" from 0 to (count _comboNames - 1) do {
		private _data = if(count _comboData <= _i) then {str _i} else {_comboData # _i};
		private _text = _comboNames # _i;
		
		_text params ["_text",["_tooltip",""],["_icon",""],["_textColor",[1,1,1,1]]];

		private _index = _combo lbAdd _text;
		_combo lbSetTooltip [_index,_tooltip];
		_combo lbSetPicture [_index,_icon];
		_combo lbSetColor [_index,_textColor];
		_combo lbSetData [_index,_data];
		
		if(_i == _defaultIndex) then {
			_combo lbSetCurSel _i;
		};
	};

	_rowControlGroup setVariable ["controlValue",{
		params ["_controlsGroup"];

		private _ctrlCombo = _controlsGroup controlsGroupCtrl 213;
		private _index = lbCurSel _ctrlCombo;
		_ctrlCombo lbData _index;
	}];

	_rowControlGroup
};

MAZ_EZM_fnc_createEditRow = {
	params ["_display","_data","_onChange"];
	_data params ["_defaultText",["_height",1]];
	private _rowControlGroup = [_display] call MAZ_EZM_fnc_createRowBase;
	_rowControlGroup ctrlSetPositionH (["H",_height] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
	_rowControlGroup ctrlCommit 0;

	private _label = _rowControlGroup controlsGroupCtrl 211; 
	_label ctrlSetPositionH (["H",_height] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
	_label ctrlCommit 0;

	private _edit = _display ctrlCreate ["RscEditMulti",214,_rowControlGroup];
	_edit ctrlSetPosition [(["W",10.1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),pixelH,(["W",15.9] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),(["H",_height] call MAZ_EZM_fnc_convertToGUI_GRIDFormat) - pixelH];
	_edit ctrlSetTextColor [1,1,1,1];
	_edit ctrlSetBackgroundColor [0,0,0,0.2];
	_edit ctrlCommit 0;
	
	_edit setVariable ["MAZ_EZM_onChange",_onChange];

	_edit ctrlAddEventHandler ["KeyUp", {
		params ["_control", "_key", "_shift", "_ctrl", "_alt"];
		[ctrlParent _control,ctrlText _control] call (_control getVariable "MAZ_EZM_onChange");
	}];

	_edit ctrlSetText _defaultText;

	_rowControlGroup setVariable ["controlValue", {
		params ["_controlsGroup"];
		ctrlText (_controlsGroup controlsGroupCtrl 214)
	}];

	_rowControlGroup
};

MAZ_EZM_fnc_createEditMultiRow = {
	params ["_display","_data","_onChange"];
	_data params ["_defaultText",["_height",4]];
	private _rowControlGroup = [_display] call MAZ_EZM_fnc_createRowBase;
	_rowControlGroup ctrlSetPositionH (["H",_height + 1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
	_rowControlGroup ctrlCommit 0;

	private _label = _rowControlGroup controlsGroupCtrl 211;
	_label ctrlSetPositionW (["W",26] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
	_label ctrlCommit 0;

	private _edit = _display ctrlCreate ["RscEditMulti",214,_rowControlGroup];
	_edit ctrlSetPosition [pixelW,(["H",1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),(["W",26] call MAZ_EZM_fnc_convertToGUI_GRIDFormat) - pixelW,(["H",_height] call MAZ_EZM_fnc_convertToGUI_GRIDFormat) - pixelH];
	_edit ctrlSetTextColor [1,1,1,1];
	_edit ctrlSetBackgroundColor [0,0,0,0.2];
	_edit ctrlSetText _defaultText;
	_edit ctrlCommit 0;

	_edit setVariable ["MAZ_EZM_onChange",_onChange];
	
	_edit ctrlAddEventHandler ["KeyUp", {
		params ["_control", "_key", "_shift", "_ctrl", "_alt"];
		[ctrlParent _control,ctrlText _control] call (_control getVariable "MAZ_EZM_onChange");
	}];

	_rowControlGroup setVariable ["controlValue", {
		params ["_controlsGroup"];
		ctrlText (_controlsGroup controlsGroupCtrl 214)
	}];

	_rowControlGroup
};

MAZ_EZM_fnc_createListRow = {
	params ["_display","_data","_onChange"];
	_data params [
		["_listData",[],[[]]],
		["_listNames",[],[[]]],
		["_defaultIndex",0,[0]],
		["_height",6,[6]]
	];
	private _rowControlGroup = [_display] call MAZ_EZM_fnc_createRowBase;
	_rowControlGroup ctrlSetPositionH (["H",_height + 1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
	_rowControlGroup ctrlCommit 0;

	private _label = _rowControlGroup controlsGroupCtrl 211;
	_label ctrlSetPositionW (["W",26] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
	_label ctrlCommit 0;

	private _listBox = _display ctrlCreate ["RscListBox",213,_rowControlGroup];
	_listBox ctrlSetPosition [0,(["H",1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),(["W",26] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),(["H",6] call MAZ_EZM_fnc_convertToGUI_GRIDFormat)];
	_listBox ctrlSetPositionH (["H",_height] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
	_listBox ctrlCommit 0;

	_listBox setVariable ["MAZ_EZM_onChange",_onChange];

	_listBox ctrlAddEventHandler ["lbSelChanged", {
		params ["_control", "_lbCurSel", "_lbSelection"];
		[ctrlParent _control,_lbSelection] call (_control getVariable "MAZ_EZM_onChange");
	}];

	for "_i" from 0 to (count _listNames - 1) do {
		private _data = if(count _listData <= _i) then {str _i} else {_listData # _i};
		private _text = _listNames # _i;
		
		_text params ["_text",["_tooltip",""],["_icon",""],["_textColor",[1,1,1,1]]];

		private _index = _listBox lbAdd _text;
		_listBox lbSetTooltip [_index,_tooltip];
		_listBox lbSetPicture [_index,_icon];
		_listBox lbSetColor [_index,_textColor];
		_listBox lbSetData [_index,_data];
		
		if(_i == _defaultIndex) then {
			_listBox lbSetCurSel _i;
		};
	};

	_listBox lbAdd " ";

	"TODO : See if this is needed.";
	'_listBox lbAdd " ";
	_listBox lbAdd "  ";
	_listBox lbAdd "   "';

	_rowControlGroup setVariable ["controlValue",{
		params ["_controlsGroup"];

		private _ctrlList = _controlsGroup controlsGroupCtrl 213;
		private _index = lbCurSel _ctrlList;
		_ctrlList lbData _index;
	}];

	_rowControlGroup
};

MAZ_EZM_fnc_createSidesRow = {
	params ["_display","_data","_onChange"];
	private _rowControlGroup = [_display] call MAZ_EZM_fnc_createRowBase;

	_rowControlGroup ctrlSetPositionH (["H",2.5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
	
	"Elements";

		private _label = _rowControlGroup controlsGroupCtrl 211;
		_label ctrlSetPositionH (["H",2.5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
		_label ctrlCommit 0;

		private _background = _display ctrlCreate ["RscText",-1,_rowControlGroup];
		_background ctrlSetBackgroundColor [0,0,0,0.6];
		_background ctrlSetPosition [(["W",10.1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),0,(["W",16] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),(["H",2.5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat)];
		_background ctrlSetTextColor [1,1,1,0.5];
		_background ctrlCommit 0;

		private _sidesGroup = _display ctrlCreate ["RscControlsGroupNoScrollbars",217,_rowControlGroup];
		_sidesGroup ctrlSetPosition [(["W",10] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),0,(["W",16] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),(["H",2.5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat)];
		_sidesGroup ctrlCommit 0;

		private _blufor = _display ctrlCreate ["RscActivePicture",250,_sidesGroup];
		_blufor ctrlSetText "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_west_ca.paa";
		_blufor ctrlSetPosition [(["W",2.5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),(["H",0.25] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),(["W",2] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),(["H",2] call MAZ_EZM_fnc_convertToGUI_GRIDFormat)];
		_blufor ctrlCommit 0;

		private _opfor = _display ctrlCreate ["RscActivePicture",251,_sidesGroup];
		_opfor ctrlSetText "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_east_ca.paa";
		_opfor ctrlSetPosition [(["W",5.5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),(["H",0.25] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),(["W",2] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),(["H",2] call MAZ_EZM_fnc_convertToGUI_GRIDFormat)];
		_opfor ctrlCommit 0;

		private _indep = _display ctrlCreate ["RscActivePicture",252,_sidesGroup];
		_indep ctrlSetText "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_guer_ca.paa";
		_indep ctrlSetPosition [(["W",8.5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),(["H",0.25] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),(["W",2] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),(["H",2] call MAZ_EZM_fnc_convertToGUI_GRIDFormat)];
		_indep ctrlCommit 0;

		private _civ = _display ctrlCreate ["RscActivePicture",253,_sidesGroup];
		_civ ctrlSetText "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_civ_ca.paa";
		_civ ctrlSetPosition [(["W",11.5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),(["H",0.25] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),(["W",2] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),(["H",2] call MAZ_EZM_fnc_convertToGUI_GRIDFormat)];
		_civ ctrlCommit 0;

	"Functionality";

	private _allowMultiple = if(typeName _data == "ARRAY") then {
		_data = +_data;
		true;
	} else {false};

	_sidesGroup setVariable ["controlValue",_data];
	_sidesGroup setVariable ["MAZ_EZM_onChange",_onChange];

	private _controls = [];
	private _IDCs = [251,250,252,253];
	{
		private _sideCtrl = _sidesGroup controlsGroupCtrl _x;
		private _color = [_forEachIndex] call BIS_fnc_sideColor;
		private _side = [_forEachIndex] call BIS_fnc_sideType;
		_sideCtrl setVariable ["MAZ_EZM_SIDE",_side];

		"Setup initial values";
			_sideCtrl ctrlSetActiveColor _color;
			if(_allowMultiple) then {
				if(_side in _data) then {
					[_sideCtrl,1.2,0] call BIS_fnc_ctrlSetScale;
				} else {
					_color set [3,0.5];
				};
			} else {
				if(_side isEqualTo _data) then {
					[_sideCtrl,1.2,0] call BIS_fnc_ctrlSetScale;
				} else {
					_color set [3,0.5];
				};
			};
			_sideCtrl ctrlSetTextColor _color;

		"If multiple selections";
		if(_allowMultiple) then {
			_sideCtrl ctrlAddEventHandler ["ButtonClick",{
				params ["_sideCtrl"];
				private _side = _sideCtrl getVariable "MAZ_EZM_SIDE";
				private _controlGroup = ctrlParentControlsGroup _sideCtrl;
				private _value = _controlGroup getVariable "controlValue";

				private _scale = 1;
				private _alpha = 0.5;
				if(_side in _value) then {
					_value deleteAt (_value find _side);
					_scale = 1;
					_alpha = 0.5;
				} else {
					_value pushBack _side;
					_scale = 1.25;
					_alpha = 1;
				};
				private _color = ctrlTextColor _sideCtrl;
				_color set [3,_alpha];
				_sideCtrl ctrlSetTextColor _color;
				[_sideCtrl,_scale,0.1] call BIS_fnc_ctrlSetScale;

				[ctrlParent _controlGroup,_value] call (_controlGroup getVariable "MAZ_EZM_onChange");
			}];
		} else {
			_sideCtrl ctrlAddEventHandler ["ButtonClick",{
				params ["_sideCtrl"];
				private _controlGroup = ctrlParentControlsGroup _sideCtrl;
				{
					private _ctrl = _x;
					private _side = _ctrl getVariable "MAZ_EZM_SIDE";
					private _scale = 1;
					private _alpha = 0.5;
					if(_ctrl isEqualTo _sideCtrl) then {
						_scale = 1.25;
						_alpha = 1;
						_controlGroup setVariable ["controlValue",_side];
					} else {
						_scale = 1;
						_alpha = 0.5;
					};
					private _color = ctrlTextColor _ctrl;
					_color set [3,_alpha];
					_ctrl ctrlSetTextColor _color;
					[_ctrl,_scale,0.1] call BIS_fnc_ctrlSetScale;
				}forEach (allControls _controlGroup);

				[ctrlParent _controlGroup,_controlGroup getVariable "controlValue"] call (_controlGroup getVariable "MAZ_EZM_onChange");
			}];
		};
	}forEach [251,250,252,253];

	_rowControlGroup setVariable ["controlValue", {
		params ["_controlsGroup"];

		private _ctrlSides = _controlsGroup controlsGroupCtrl 217;
		_ctrlSides getVariable "controlValue"
	}];

	_rowControlGroup
};

MAZ_EZM_fnc_createSliderRow = {
	params ["_display","_data","_onChange"];
	_data params [
		["_min",0,[0]],
		["_max",100,[100]],
		["_defaultValue",50,[50]],
		["_drawRadius",false,[false]],
		["_radiusCenter",objNull,[objNull,[]]],
		["_radiusColor",[1,1,1,1],[[]]],
		["_isPercent",false,[false]]
	];

	private _rowControlGroup = [_display] call MAZ_EZM_fnc_createRowBase;
	_rowControlGroup setVariable ["MAZ_EZM_isPercent",_isPercent];

	private _slider = _display ctrlCreate ["RscXSliderH",215,_rowControlGroup];
	_slider ctrlSetPosition [(["W",10.1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),0,(["W",13.5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),(["H",1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat)];
	_slider ctrlSetTextColor [1,1,1,0.6];
	_slider ctrlSetActiveColor [1,1,1,1];
	_slider ctrlCommit 0;
	_slider setVariable ["MAZ_EZM_onChange",_onChange];

	private _sliderEdit = _display ctrlCreate ["RscEdit",214,_rowControlGroup];
	_sliderEdit ctrlSetPosition [(["W",23.7] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),pixelH,(["W",2.3] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),((["H",1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat) - pixelH)];
	_sliderEdit ctrlSetTextColor [1,1,1,1];
	_sliderEdit ctrlSetBackgroundColor [0,0,0,0.2];
	_sliderEdit ctrlCommit 0;

	if(_drawRadius) then {
		["MAZ_EZM_drawSliderRadius","onEachFrame",{
			params ["_ctrlSlider","_center","_color"];
			if(isNull _ctrlSlider || {_center isEqualTo objNull}) exitWith {
				["MAZ_EZM_drawSliderRadius","onEachFrame"] call BIS_fnc_removeStackedEventHandler;
			};

			if (_center isEqualType objNull) then {
				_center = ASLToAGL getPosASLVisual _center;
			};

			private _radius = sliderPosition _ctrlSlider;
			private _count = 6 max floor (2 * pi * _radius / 15);
			private _intervals = 360 / _count;

			for "_i" from 0 to (_count - 1) do {
				private _circumferencePos = _i * _intervals;
				drawIcon3D ["\a3\ui_f\data\map\markers\military\dot_ca.paa", _color, [_radius * cos _circumferencePos + (_center # 0),_radius * sin _circumferencePos + (_center # 1),0], 0.5, 0.5, 0];
			};
		},[_slider,_radiusCenter,_radiusColor]] call BIS_fnc_addStackedEventHandler;
	};

	_slider sliderSetRange [_min, _max];
	_slider sliderSetSpeed [1, 1];
	_slider sliderSetPosition _defaultValue;
	if(_isPercent) then {
		private _text = (str (round (_defaultValue * 100))) + "%";
		_sliderEdit ctrlSetText _text;
		_slider sliderSetSpeed [0.1, 0.1];
	} else {
		_sliderEdit ctrlSetText (str _defaultValue);
	};

	_slider ctrlAddEventHandler ["sliderPosChanged", {
		params ["_ctrlSlider", "_value"];
		private _controlGroup = ctrlParentControlsGroup _ctrlSlider;
		private _isPercent = _controlGroup getVariable ["MAZ_EZM_isPercent",false];
		private _ctrlEdit = _controlGroup controlsGroupCtrl 214;
		if(_isPercent) then {
			private _text = (str (round (_value * 100))) + "%";
			_ctrlEdit ctrlSetText _text;
		} else {
			private _roundedValue = round _value;
			_ctrlEdit ctrlSetText format ["%1",_roundedValue];
		};
		
		[ctrlParent _ctrlSlider,round _value] call (_ctrlSlider getVariable "MAZ_EZM_onChange");
	}];

	_sliderEdit ctrlAddEventHandler ["keyUp",{
		params ["_displayOrControl", "_key", "_shift", "_ctrl", "_alt"];
		private _num = parseNumber (ctrlText _displayOrControl);
		private _ctrlGroup = ctrlParentControlsGroup _displayOrControl;
		private _isPercent = _ctrlGroup getVariable ["MAZ_EZM_isPercent",false];
		private _sliderCtrl = _ctrlGroup controlsGroupCtrl 215;
		if(_isPercent) then {
			_sliderCtrl sliderSetPosition (round (_num/100));
		} else {
			_sliderCtrl sliderSetPosition _num;
		};
	}];

	_rowControlGroup setVariable ["controlValue",{
		params ["_controlsGroup"];
		sliderPosition (_controlsGroup controlsGroupCtrl 215)
	}];

	_rowControlGroup
};

MAZ_EZM_fnc_createToolBoxRow = {
	params ["_display","_data"];
	_data params ["_default","_strings"];
	private _rowControlGroup = [_display] call MAZ_EZM_fnc_createRowBase;

	private _ctrlToolbox = _display ctrlCreate ["RscToolBox",216,_rowControlGroup];
	_ctrlToolbox ctrlSetPosition [(["W",10.1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),0,(["W",15.9] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),(["H",1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat)];
	_ctrlToolbox ctrlSetTextColor [1,1,1,1];
	_ctrlToolbox ctrlSetBackgroundColor [0,0,0,0.3];
	_ctrlToolbox ctrlCommit 0;
	lbClear _ctrlToolbox;
	
	{
		_x params ["_text","_tooltip"];

		private _index = _ctrlToolbox lbAdd _text;
		_ctrlToolbox lbSetTooltip [_index, _tooltip];
	} forEach _strings;

	if(_default isEqualType false) then {
		_default = parseNumber _default;
	};
	_ctrlToolbox lbSetCurSel _default;

	_ctrlToolbox setVariable ["MAZ_EZM_onChange",_onChange];

	_ctrlToolbox ctrlAddEventHandler ["ToolBoxSelChanged", {
		params ["_control", "_selectedIndex"];

		[ctrlParent _control,_selectedIndex > 0] call (_control getVariable "MAZ_EZM_onChange");
	}];

	_rowControlGroup setVariable ["controlValue", {
		params ["_controlsGroup", "_settings"];

		private _value = lbCurSel (_controlsGroup controlsGroupCtrl 216);
		_value > 0
	}];
	
	_rowControlGroup
};

MAZ_EZM_fnc_createVectorRow = {
	params ["_display","_data"];
	_data params [
		["_defaultValues",[],[[]]],
		["_labels",[],[[]]],
		["_numOfEdits",3,[3]]
	];
	private _rowControlGroup = [_display] call MAZ_EZM_fnc_createRowBase;

	_numOfEdits = [_numOfEdits,2,3] call BIS_fnc_clamp;

	private _labelColors = [[0.765,0.18,0.1,1],[0.575,0.815,0.22,1],[0.26,0.52,0.92,1]];

	private _startingX = ["W",10] call MAZ_EZM_fnc_convertToGUI_GRIDFormat;
	private _totalWidth = ["W",16] call MAZ_EZM_fnc_convertToGUI_GRIDFormat;
	private _widthPerVector = _totalWidth / _numOfEdits;
	private _labelWidth = ["W",1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat;
	private _editWidth = _widthPerVector - _labelWidth - (["W",0.2] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);

	for "_i" from 0 to (_numOfEdits - 1) do {
		private _labelPosX = (_widthPerVector * _i) + (["W",0.1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
		private _editPosX = _labelPosX + (["W",1.1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);

		private _editLabel = _display ctrlCreate ["RscStructuredText",-1,_rowControlGroup];
		_editLabel ctrlSetStructuredText parseText (format ["<t align='center'>%1</t>",_labels select _i]);
		_editLabel ctrlSetBackgroundColor (_labelColors select _i);
		_editLabel ctrlSetPosition [_startingX + _labelPosX,0,["W",1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,["H",1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat];
		_editLabel ctrlCommit 0;

		private _editBox  = _display ctrlCreate ["RscEdit",[220,221,222] select _i,_rowControlGroup];
		_editBox ctrlSetText (str (_defaultValues select _i));
		_editBox ctrlSetPosition [_startingX + _editPosX,0,_editWidth,["H",1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat];
		_editBox ctrlCommit 0;
	};

	_rowControlGroup ctrlSetPositionH (["H",1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
	_rowControlGroup ctrlCommit 0;

	_rowControlGroup setVariable ["numOfVectorControls",_numOfEdits];

	_rowControlGroup setVariable ["controlValue", {
		params ["_controlsGroup", "_settings"];
		private _numOfEdits = _controlsGroup getVariable "numOfVectorControls";
		private _value = [];
		for "_i" from 0 to (_numOfEdits - 1) do {
			private _editBox = _controlsGroup controlsGroupCtrl ([220,221,222] select _i);
			_value pushBack (parseNumber (ctrlText _editBox));
		};

		_value
	}];
	
	_rowControlGroup
};

MAZ_EZM_fnc_changeDisplayHeights = {
	params ["_display"];
	private _ctrlContent = _display displayCtrl 203;
	ctrlPosition _ctrlContent params ["_posX","","_posW","_posH"];

	_ctrlContent ctrlSetPositionY (0.5 - (_posH / 2));
	_ctrlContent ctrlCommit 0;

	private _ctrlTitle = _display displayCtrl 201;
	_ctrlTitle ctrlSetPositionY (0.5 - (_posH / 2) - (["H",1.6] call MAZ_EZM_fnc_convertToGUI_GRIDFormat));
	_ctrlTitle ctrlCommit 0;

	private _ctrlBG = _display displayCtrl 202;
	_ctrlBG ctrlSetPositionY (0.5 - (_posH / 2) - (["H",0.5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat));
	_ctrlBG ctrlSetPositionH (_posH + (["H",1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat));
	_ctrlBG ctrlCommit 0;

	private _ctrlOkBtn = _display displayCtrl 204;
	_ctrlOkBtn ctrlSetPositionY (0.5 + (_posH / 2) + (["H",0.6] call MAZ_EZM_fnc_convertToGUI_GRIDFormat));
	_ctrlOkBtn ctrlCommit 0;

	private _ctrlCancelBtn = _display displayCtrl 205;
	_ctrlCancelBtn ctrlSetPositionY (0.5 + (_posH / 2) + (["H",0.6] call MAZ_EZM_fnc_convertToGUI_GRIDFormat));
	_ctrlCancelBtn ctrlCommit 0;
};

MAZ_EZM_fnc_updateDialog = {
	params ["_display","_controls"];
	private _ctrlContent = _display displayCtrl 203;
	while {!isNull _display} do {
		private _height = 0;
		{
			_x params ["_ctrlGroup","_condition"];
			if(typeName _condition == "STRING") then {
				_condition = compile _condition;
			};
			if([_display,_ctrlGroup] call _condition) then {
				_ctrlGroup ctrlShow true;
				_ctrlGroup ctrlSetPositionY _height;
				_ctrlGroup ctrlCommit 0;
				_height = (_height + (ctrlPosition _ctrlGroup select 3) + (["H",0.1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat));
			} else {
				_ctrlGroup ctrlShow false;
			};
		}forEach _controls;

		_ctrlContent ctrlSetPositionH (_height - (["H",0.1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat));
		_ctrlContent ctrlCommit 0;

		[_display] call MAZ_EZM_fnc_changeDisplayHeights;

		sleep 0.1;
	};
};

MAZ_EZM_fnc_createDialog = {
	params [
		["_title","Module Dialog",[""]],
		["_content",[],[[]]],
		["_onConfirm",{},[{}]],
		["_onCancel",{},[{}]],
		["_args",[]],
		["_onLoad",{},[{}]]
	];

	private _display = [] call MAZ_EZM_fnc_createDialogBase;

	if(isNull _display) exitWith {false};

	private _ctrlTitle = _display displayCtrl 201;
	_ctrlTitle ctrlSetText (toUpper _title);

	private _ctrlContent = _display displayCtrl 203;
	private _contentPosY = 0;
	private _controls = [];
	
	private _error = "";
	{
		_x params [
			["_type","",[""]],
			["_label","",["",[]]],
			["_data",[],[[],west]],
			["_condition",{true},[{},""]],
			["_onChange",{{}},[{},""]]
		];

		_label params [["_label","",[""]],["_toolTip","",[""]]];

		(toUpper _type splitString ":") params [["_type",""],["_subType",""]];

		private _result = switch (_type) do {
			case "COLOR": {
				[_display,_data,_onChange] call MAZ_EZM_fnc_createColorRow;
			};
			case "COMBO": {
				[_display,_data,_onChange] call MAZ_EZM_fnc_createComboRow;
			};
			case "EDIT": {
				private _fnc = switch (_subType) do {
					case "MULTI": {
						MAZ_EZM_fnc_createEditMultiRow
					};
					default {MAZ_EZM_fnc_createEditRow};
				};
				[_display,_data,_onChange] call _fnc;
			};
			case "ICON": {
				[_display,_data,_onChange] call MAZ_EZM_fnc_createIconsRow;
			};
			case "LIST": {
				[_display,_data,_onChange] call MAZ_EZM_fnc_createListRow;
			};
			case "SIDES": {
				[_display,_data,_onChange] call MAZ_EZM_fnc_createSidesRow;
			};
			case "SLIDER": {
				_data params ["_min","_max","_default","_radiusCenter","_radiusColor","_isPercent"];
				private _drawRadius = (typeName _radiusCenter isEqualTo "OBJECT" && {!isNull _radiusCenter}) || typeName _radiusCenter == "ARRAY";
				_data insert [3,[_drawRadius]];
				[_display,_data,_onChange] call MAZ_EZM_fnc_createSliderRow;
			};
			case "TOOLBOX": {
				switch (_subType) do {
					case "YESNO": {
						_data set [1,[["NO",""],["YES",""]]];
					};
					case "ENABLED": {
						_data set [1,[["DISABLE",""],["ENABLE",""]]];
					};
				};
				[_display,_data,_onChange] call MAZ_EZM_fnc_createToolBoxRow;
			};
			case "VECTOR": {
				[_display,_data,_onChange] call MAZ_EZM_fnc_createVectorRow;
			};
			default {
				_error = _error + (format ["Wrong content type %1. ",_type]);
				false;
			};
		};
		if(typeName _result == "BOOL" && {!_result}) then {
			_error = _error + (format ["%1 data was incorrect for %2. ",_type,_label]);
			continue;
		};

		private _ctrlLabel = _result controlsGroupCtrl 211;
		_ctrlLabel ctrlSetText (format ["%1",_label]);
		_ctrlLabel ctrlSetTooltip _toolTip;

		_controls pushBack [_result,_condition];

	}forEach _content;

	if(_error != "") exitWith {
		_display closeDisplay 3;
		systemChat format ["[ ERROR ] : %1",_error];
		playSound "addItemFailed";
	};

	[_display,_controls] call _onLoad;

	[_display,_controls] spawn MAZ_EZM_fnc_updateDialog;

	_display setVariable ["MAZ_moduleMenuInfo",[_controls,_onConfirm,_onCancel,_args]];

	true;
};