MAZ_EZM_fnc_createAttributesMenuBase = {
	params ["_labelText"];
	createDialog "RscDisplayEmpty";
	showchat true;
	private _display = findDisplay -1;

	private _primaryContentGroup = _display ctrlCreate ["RscControlsGroupNoScrollbars",100];
	_primaryContentGroup ctrlSetPosition [["X",6.5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,0,["W",27] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,0];
	_primaryContentGroup ctrlCommit 0;

	private _label = _display ctrlCreate ["RscText",101,_primaryContentGroup];
	_label ctrlSetPosition [0,0,1,["H",1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat];
	_label ctrlSetBackgroundColor EZM_dialogColor;
	_label ctrlSetText _labelText;
	_label ctrlCommit 0;

	private _background = _display ctrlCreate ["RscText",102,_primaryContentGroup];
	_background ctrlSetPosition [0,0,1,0];
	_background ctrlSetBackgroundColor [0,0,0,0.7];
	_background ctrlCommit 0;

	private _contentGroup = _display ctrlCreate ["RscControlsGroup",103,_primaryContentGroup];
	_contentGroup ctrlSetPosition [0.015,["Y",1.6] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,["W",26] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,0];
	_contentGroup ctrlCommit 0;

	private _okayButton = _display ctrlCreate ["RscButtonMenuOk",104];
	_okayButton ctrlAddEventhandler ["ButtonClick",{
		params ["_control"];
		private _display = ctrlParent _control;
		(_display getVariable "MAZ_EZM_attributesDialogInfo") params ["_display","_controls","_args"];
		private _values = [];
		{
			private _value = [_x] call (_x getVariable "MAZ_EZM_getControlValue");
			_values pushBack _value;
		}forEach _controls;

		[_display,_values,_args] call (_display getVariable 'MAZ_EZM_onAttribsConfirm');
	}];

	private _cancelButton = _display ctrlCreate ["RscButtonMenuCancel",105];
	_cancelButton ctrlAddEventhandler ["ButtonClick",{
		params ["_control"];
		private _display = ctrlParent _control;
		(_display getVariable "MAZ_EZM_attributesDialogInfo") params ["_display","_controls","_args"];
		private _values = [];
		{
			private _value = [_x] call (_x getVariable "MAZ_EZM_getControlValue");
			_values pushBack _value;
		}forEach _controls;

		[_display,_values,_args] call (_display getVariable 'MAZ_EZM_onAttribsCancel');
	}];

	_display displayAddEventHandler ["Unload", {
		params ["_display", "_exitCode"];

		if (_exitCode == 2) then {
			(_display getVariable "MAZ_EZM_attributesDialogInfo") params ["_display","_controls","_args"];
			private _values = [];
			{
				private _value = [_x] call (_x getVariable "MAZ_EZM_getControlValue");
				_values pushBack _value;
			}forEach _controls;

			[_display,_values,_args] call (_display getVariable 'MAZ_EZM_onAttribsCancel');
		};

		false
	}];

	_display
};

MAZ_EZM_fnc_createAttributesRowBase = {
	params ["_display"];
	private _contentGroup = _display displayCtrl 103;
	private _controlsGroup = _display ctrlCreate ["RscControlsGroupNoScrollbars",151,_contentGroup];
	_controlsGroup ctrlSetPosition [0,0,(["W",26] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),(["H",1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat)];
	_controlsGroup ctrlCommit 0;

	private _rowLabel = _display ctrlCreate ["RscText",150,_controlsGroup];
	_rowLabel ctrlSetPosition [0,0,(["W",9] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),(["H",1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat)];
	_rowLabel ctrlSetBackgroundColor [0,0,0,0.6];
	_rowLabel ctrlCommit 0;

	private _rowBG = _display ctrlCreate ["RscPicture",152,_controlsGroup];
	_rowBG ctrlSetPosition [(["W",9.1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),0,(["W",16.9] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),(["H",1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat)];
	_rowBG ctrlSetText "#(argb,8,8,3)color(1,1,1,0.1)";
	_rowBG ctrlCommit 0;

	_controlsGroup
};

MAZ_EZM_fnc_createAttribEditRow = {
	params ["_display","_settings"];
	_settings params ["_default"];
	private _rowControlsGroup = [_display] call MAZ_EZM_fnc_createAttributesRowBase;

	private _rowEditBox = _display ctrlCreate ["RscEdit",160,_rowControlsGroup];
	_rowEditBox ctrlSetPosition [["W",9.1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,pixelH,["W",16.9] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,((["H",1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat) - pixelH)];
	_rowEditBox ctrlSetText _default;
	_rowEditBox ctrlSetBackgroundColor [0,0,0,0.3];
	_rowEditBox ctrlCommit 0;

	_rowControlsGroup setVariable ["MAZ_EZM_getControlValue",{
		params ["_controlsGroup"];
		ctrlText (_controlsGroup controlsGroupCtrl 160)
	}];

	_rowControlsGroup
};

MAZ_EZM_fnc_createAttribEditMultiRow = {
	params ["_display","_settings"];
	_settings params ["_default","_align"];
	private _rowControlsGroup = [_display] call MAZ_EZM_fnc_createAttributesRowBase;
	_rowControlsGroup ctrlSetPositionH (["H",4] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
	_rowControlsGroup ctrlCommit 0;

	private _rowLabel = _rowControlsGroup controlsGroupCtrl 150;
	private _text = ctrlText _rowLabel;
	_rowLabel ctrlSetStructuredText parseText (format ["<t align='%1'>%2</t>",_align,_text]);
	_rowLabel ctrlSetPositionW (["W",26] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
	_rowLabel ctrlCommit 0;

	private _rowEditMultiBox = _display ctrlCreate ["RscEditMulti",161,_rowControlsGroup];
	_rowEditMultiBox ctrlSetPosition [["W",0.1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,(["H",1.1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat) + pixelH,["W",25.9] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,((["H",2.9] call MAZ_EZM_fnc_convertToGUI_GRIDFormat) - pixelH)];
	_rowEditMultiBox ctrlSetText _default;
	_rowEditMultiBox ctrlSetBackgroundColor [0,0,0,0.3];
	_rowEditMultiBox ctrlCommit 0;

	_rowControlsGroup setVariable ["MAZ_EZM_getControlValue",{
		params ["_controlsGroup"];
		ctrlText (_controlsGroup controlsGroupCtrl 161)
	}];

	_rowControlsGroup
};

MAZ_EZM_fnc_createAttribSliderWithEditRow = {
	params ["_display","_settings"];
	_settings params ["_default","_min","_max",["_isPercent",false]];
	private _rowControlsGroup = [_display] call MAZ_EZM_fnc_createAttributesRowBase;

	private _slider = _display ctrlCreate ["RscXSliderH",170,_rowControlsGroup];
	_slider ctrlSetPosition [["W",9.1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,0,["W",13.9] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,(["H",1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat)];
	_slider sliderSetRange [_min,_max];
	_slider sliderSetPosition _default;
	_slider ctrlCommit 0;

	private _sliderEdit = _display ctrlCreate ["RscEdit",171,_rowControlsGroup];
	_sliderEdit ctrlSetPosition [["W",23.1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,pixelH,["W",2.9] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,((["H",1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat) - pixelH)];
	if(_isPercent) then {
		_sliderEdit ctrlSetText ((str (round (_default * 100))) + "%");
	} else {
		_sliderEdit ctrlSetText (str _default);
	};
	_sliderEdit ctrlSetBackgroundColor [0,0,0,0.3];
	_sliderEdit ctrlCommit 0;

	_rowControlsGroup setVariable ["MAZ_EZM_isSliderEditPercent",_isPercent];

	_slider ctrlAddEventHandler ["SliderPosChanged",{
		params ["_control","_newValue"];
		private _ctrlGroup = ctrlParentControlsGroup _control;
		private _isPercent = _ctrlGroup getVariable ["MAZ_EZM_isSliderEditPercent",false];
		private _editCtrl = _ctrlGroup controlsGroupCtrl 171;
		if(_isPercent) then {
			private _editValue = str (round (_newValue * 100));
			_editCtrl ctrlSetText (_editValue + "%");
		} else {
			private _editValue = [_newValue,2] call BIS_fnc_cutDecimals;
			_editCtrl ctrlSetText format ["%1",_editValue];
		};
	}];

	_sliderEdit ctrlAddEventHandler ["KeyUp",{
		params ["_displayOrControl", "_key", "_shift", "_ctrl", "_alt"];
		private _num = parseNumber (ctrlText _displayOrControl);
		private _ctrlGroup = ctrlParentControlsGroup _displayOrControl;
		private _sliderCtrl = _ctrlGroup controlsGroupCtrl 170;
		private _isPercent = _ctrlGroup getVariable ["MAZ_EZM_isSliderEditPercent",false];
		if(_isPercent) then {
			_sliderCtrl sliderSetPosition (_num/100);
		} else {
			_sliderCtrl sliderSetPosition _num;
		};
	}];

	_rowControlsGroup setVariable ["MAZ_EZM_getControlValue",{
		params ["_controlsGroup"];
		private _slider = _controlsGroup controlsGroupCtrl 170;
		private _value = sliderPosition _slider;
		[_value,2] call BIS_fnc_cutDecimals;
	}];

	_rowControlsGroup
};

MAZ_EZM_fnc_createAttribIconsRow = {
	params ["_display","_settings"];
	_settings params ["_default","_values","_icons","_tooltips","_positions","_sizes",["_height",2.5],["_colors",[]]];
	private _rowControlsGroup = [_display] call MAZ_EZM_fnc_createAttributesRowBase;
	_rowControlsGroup ctrlSetPositionH (["H",_height] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
	_rowControlsGroup ctrlCommit 0;

	private _rowLabel = _rowControlsGroup controlsGroupCtrl 150;
	private _text = ctrlText _rowLabel;
	_rowLabel ctrlSetStructuredText parseText (format ["<t size='%1'>&#160;</t><br/>%2",_height * 0.35,_text]);
	_rowLabel ctrlSetPositionH (["H",_height] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
	_rowLabel ctrlCommit 0;

	private _rowBG = _rowControlsGroup controlsGroupCtrl 152;
	_rowBG ctrlSetPositionH (["H",_height] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
	_rowBG ctrlCommit 0;

	private _iconControls = [];
	for "_i" from 0 to (count _icons - 1) do {
		private _value = _values select _i;
		private _icon = _icons select _i;
		private _tooltip = _tooltips select _i;
		private _position = _positions select _i;
		private _size = _sizes select _i;

		private _colorNormal = [0.8,0.8,0.8,0.4];
		private _colorActive = [1,1,1,0.9];
		
		if(count _colors - 1 >= _i) then {
			private _color = _colors select _i;
			_colorActive = _color # 0;
			_colorNormal = _color # 1;
		};
		_position params ["_posX","_posY"];

		private _iconCtrl = _display ctrlCreate ["RscActivePicture",-1,_rowControlsGroup];
		_iconCtrl ctrlSetText _icon;
		_iconCtrl ctrlSetTooltip _tooltip;
		_iconCtrl ctrlSetTextColor _colorNormal;
		_iconCtrl ctrlSetActiveColor _colorActive;
		_iconCtrl ctrlSetPosition [["W",_posX] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,["H",_posY] call MAZ_EZM_fnc_convertToGUI_GRIDFormat, ["W",_size] call MAZ_EZM_fnc_convertToGUI_GRIDFormat, ["H",_size] call MAZ_EZM_fnc_convertToGUI_GRIDFormat];
		_iconCtrl ctrlCommit 0;
		
		_iconCtrl setVariable ["MAZ_EZM_iconActiveColor",_colorActive];
		_iconCtrl setVariable ["MAZ_EZM_iconNormalColor",_colorNormal];

		_iconCtrl ctrlAddEventHandler ["ButtonClick",{
			params ["_control"];
			private _controlGroup = ctrlParentControlsGroup _control;
			private _newValue = _control getVariable "MAZ_EZM_iconVariable";
			_controlGroup setVariable ["MAZ_EZM_iconSelectionData",_newValue];
			
			comment "Change old icon to normal";
			private _oldCtrl = _controlGroup getVariable "MAZ_EZM_iconSelected";
			_oldCtrl ctrlSetScale 1;
			_oldCtrl ctrlSetTextColor (_oldCtrl getVariable "MAZ_EZM_iconNormalColor");
			_oldCtrl ctrlCommit 0.2;

			comment "Change new icon to scaled and highlighted";
			_control ctrlSetScale 1.1;
			_control ctrlSetTextColor (_control getVariable "MAZ_EZM_iconActiveColor");
			_control ctrlCommit 0.2;
			_controlGroup setVariable ["MAZ_EZM_iconSelected",_control];
		}];
		_iconCtrl setVariable ["MAZ_EZM_iconVariable",_value];
		if(_value == _default) then {
			_rowControlsGroup setVariable ["MAZ_EZM_iconSelectionData",_value];
			_rowControlsGroup setVariable ["MAZ_EZM_iconSelected",_iconCtrl];
			_iconCtrl ctrlSetTextColor _colorActive;
			_iconCtrl ctrlSetScale 1.1;
			_iconCtrl ctrlCommit 0;
		};
	};

	_rowControlsGroup setVariable ["MAZ_EZM_getControlValue",{
		params ["_controlsGroup"];
		_controlsGroup getVariable "MAZ_EZM_iconSelectionData"
	}];

	_rowControlsGroup
};

MAZ_EZM_fnc_createAttribComboRow = {
	params ["_display","_settings"];
	_settings params ["_default","_entries"];
	private _rowControlsGroup = [_display] call MAZ_EZM_fnc_createAttributesRowBase;
	private _rowBG = _rowControlsGroup controlsGroupCtrl 152;
	ctrlDelete _rowBG;

	private _combo = _display ctrlCreate ["RscCombo",180,_rowControlsGroup];
	_combo ctrlSetPosition [["W",9.1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,0,["W",16.9] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,(["H",1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat)];
	_combo ctrlCommit 0;

	{
		_x params ["_value","_text","_icon","_iconColor"];
		_text params ["_text","_tooltip"];

		private _index = _combo lbAdd _text;
		_combo lbSetData [_index,_value];
		_combo lbSetTooltip [_index,_tooltip];
		_combo lbSetPicture [_index,_icon];
		_combo lbSetPictureColor [_index,_iconColor];

		if(_index isEqualTo _default) then {
			_combo lbSetCurSel _index;
		};
	}forEach _entries;

	_rowControlsGroup setVariable ["MAZ_EZM_getControlValue",{
		params ["_controlsGroup"];
		private _combo = _controlsGroup controlsGroupCtrl 180;
		_combo lbData (lbCurSel _combo);
	}];

	_rowControlsGroup
};

MAZ_EZM_fnc_createAttribNewButton = {
	params ["_display","_settings"];
	_settings params ["_tooltip","_onButtonClick","_args"];
	private _existingButtons = _display getVariable ["MAZ_EZM_attribsButtons",[]];
	private _numOfButtons = count _existingButtons;

	private _newButton = _display ctrlCreate ["RscButtonMenu",105 + (_numOfButtons + 1)];
	_newButton setVariable ['MAZ_EZM_attribsButtonClick',_onButtonClick];
	_newButton setVariable ['MAZ_EZM_attribsButtonArgs',_args];
	_newButton ctrlSetPositionX (["X",(28.5 - (5.1 * (_numOfButtons + 1)))] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
	_newButton ctrlSetPositionW (["W",5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
	_newButton ctrlSetPositionH (["H",1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
	_newButton ctrlSetStructuredText parseText _label;
	_newButton ctrlSetTooltip _tooltip;
	_newButton ctrlAddEventhandler ["ButtonClick",{
		params ["_control"];
		private _display = ctrlParent _control;
		[_display,_control getVariable 'MAZ_EZM_attribsButtonArgs'] call (_control getVariable 'MAZ_EZM_attribsButtonClick');
	}];
	_newButton ctrlCommit 0;

	_existingButtons pushBack _newButton;
	_display setVariable ["MAZ_EZM_attribsButtons",_existingButtons];
};

MAZ_EZM_fnc_createAttribNewRespawnRow = {
	params ["_display","_settings"];
	_settings params ["_default","_unit"];
	private _rowControlsGroup = [_display] call MAZ_EZM_fnc_createAttributesRowBase;
	_rowControlsGroup ctrlSetPositionH (["H",2.5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
	_rowControlsGroup ctrlCommit 0;

	private _rowLabel = _rowControlsGroup controlsGroupCtrl 150;
	private _text = ctrlText _rowLabel;
	_rowLabel ctrlSetStructuredText parseText (format ["<t size='0.75'>&#160;</t><br/>%1",_text]);
	_rowLabel ctrlSetPositionH (["H",2.5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
	_rowLabel ctrlCommit 0;

	private _rowBG = _rowControlsGroup controlsGroupCtrl 152;
	_rowBG ctrlSetPositionH (["H",2.5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
	_rowBG ctrlCommit 0;

	private _respawnIDs = [1,0,2,3,4];
	private _respawnIcons = ["A3\UI_F_CURATOR\DATA\RscCommon\RscAttributeRespawnPosition\west_ca.paa","A3\UI_F_CURATOR\DATA\RscCommon\RscAttributeRespawnPosition\east_ca.paa","A3\UI_F_CURATOR\DATA\RscCommon\RscAttributeRespawnPosition\guer_ca.paa","A3\UI_F_CURATOR\DATA\RscCommon\RscAttributeRespawnPosition\civ_ca.paa","A3\3den\Data\Attributes\default_ca.paa"];
	private _toolTips = ["BLUFOR","OPFOR","INDEPENDENT","CIVILIAN","NONE"];
	private _posInfo = [
		[[11,0.25],2.0],
		[[14,0.25],2.0],
		[[17,0.25],2.0],
		[[20,0.25],2.0],
		[[23,0.5],1.5]
	];

	{
		private _respawnIcon = _respawnIcons select _forEachIndex;
		private _posData = _posInfo select _forEachIndex;
		private _tooltip = _toolTips select _forEachIndex;
		_posData params ["_pos","_size"];
		_pos params ["_posX","_posY"];

		private _side = [_x] call BIS_fnc_sideType;
		private _color = [_side] call BIS_fnc_sideColor;
		_color params ["_r","_g","_b","_a"];

		private _colorDefault = [_r,_g,_b,0.5];
		private _colorActive = _color;

		private _iconCtrl = _display ctrlCreate ["RscActivePicture",-1,_rowControlsGroup];
		_iconCtrl ctrlSetText _respawnIcon;
		_iconCtrl ctrlSetActiveColor _colorActive;
		_iconCtrl ctrlSetTooltip _tooltip;
		_iconCtrl ctrlSetTextColor _colorDefault;
		_iconCtrl ctrlSetPosition [["W",_posX] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,["H",_posY] call MAZ_EZM_fnc_convertToGUI_GRIDFormat, ["W",_size] call MAZ_EZM_fnc_convertToGUI_GRIDFormat, ["H",_size] call MAZ_EZM_fnc_convertToGUI_GRIDFormat];
		_iconCtrl ctrlCommit 0;

		_iconCtrl setVariable ["MAZ_EZM_iconNormalColor",_colorDefault];
		_iconCtrl setVariable ["MAZ_EZM_iconActiveColor",_colorActive];
		_iconCtrl setVariable ["MAZ_EZM_iconVariable",_x];

		_iconCtrl ctrlAddEventHandler ["ButtonClick",{
			params ["_control"];
			private _controlGroup = ctrlParentControlsGroup _control;
			private _newValue = _control getVariable "MAZ_EZM_iconVariable";
			_controlGroup setVariable ["MAZ_EZM_iconSelectionData",_newValue];
			
			comment "Change old icon to normal";
			private _oldCtrl = _controlGroup getVariable "MAZ_EZM_iconSelected";
			_oldCtrl ctrlSetScale 1;
			_oldCtrl ctrlSetTextColor (_oldCtrl getVariable "MAZ_EZM_iconNormalColor");
			_oldCtrl ctrlCommit 0.2;

			comment "Change new icon to scaled and highlighted";
			_control ctrlSetScale 1.1;
			_control ctrlSetTextColor (_control getVariable "MAZ_EZM_iconActiveColor");
			_control ctrlCommit 0.2;
			_controlGroup setVariable ["MAZ_EZM_iconSelected",_control];
		}];
		if(_x == _default) then {
			_rowControlsGroup setVariable ["MAZ_EZM_iconSelectionData",_x];
			_rowControlsGroup setVariable ["MAZ_EZM_iconSelected",_iconCtrl];
			_iconCtrl ctrlSetTextColor _colorActive;
			_iconCtrl ctrlSetScale 1.1;
			_iconCtrl ctrlCommit 0;
		};
	}forEach _respawnIDs;

	_rowControlsGroup setVariable ["MAZ_EZM_getControlValue",{
		params ["_controlsGroup"];
		_controlsGroup getVariable "MAZ_EZM_iconSelectionData"
	}];

	_rowControlsGroup
};

MAZ_EZM_fnc_createAttribToolboxRow = {
	params ["_display","_settings"];
	_settings params ["_default","_strings"];
	private _rowControlsGroup = [_display] call MAZ_EZM_fnc_createAttributesRowBase;

	private _rowToolbox = _display ctrlCreate ["RscToolbox",190,_rowControlsGroup];
	_rowToolbox ctrlSetPosition [["W",9.1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,0,["W",16.9] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,["H",1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat];
	_rowToolbox ctrlSetTextColor [1,1,1,1];
	_rowToolbox ctrlSetBackgroundColor [0,0,0,0.7];
	_rowToolbox ctrlCommit 0;
	lbClear _rowToolbox;

	{
		_x params ["_text",["_tooltip",""]];

		private _index = _rowToolbox lbAdd _text;
		_rowToolbox lbSetTooltip [_index, _tooltip];
	} forEach _strings;

	if(_default isEqualType false) then {
		_default = parseNumber _default;
	};
	_rowToolbox lbSetCurSel _default;

	_rowControlsGroup setVariable ["MAZ_EZM_getControlValue", {
		params ["_controlsGroup"];
		private _value = lbCurSel (_controlsGroup controlsGroupCtrl 190);
		_value = _value > 0;

		_value
	}];

	_rowControlsGroup
};

MAZ_EZM_fnc_createAttributesDialog = {
	params [
		["_title","Edit Attributes",[""]],
		["_content",[],[[]]],
		["_onCancel",{},[{}]],
		["_onConfirm",{},[{}]],
		["_args",[]],
		["_maxHeight",30,[30]]
	];

	private _display = [_title] call MAZ_EZM_fnc_createAttributesMenuBase;
	_display setVariable ['MAZ_EZM_onAttribsCancel',_onCancel];
	_display setVariable ['MAZ_EZM_onAttribsConfirm',_onConfirm];

	private _controls = [];
	private _yOffset = 0;
	{
		_x params [
			["_typeData","",[""]],
			["_label","",["",[]]],
			["_settings",[],[[]]]
		];

		(toUpper _typeData) splitString ":" params ["_type","_subType"];
		private _controlsGroup = switch (_type) do {
			case "COMBO": {
				[_display,_settings] call MAZ_EZM_fnc_createAttribComboRow;
			};
			case "EDIT": {
				[_display,_settings] call MAZ_EZM_fnc_createAttribEditRow;
			};
			case "EDITMULTI": {
				[_display,_settings] call MAZ_EZM_fnc_createAttribEditMultiRow;
			};
			case "ICONS": {
				[_display,_settings] call MAZ_EZM_fnc_createAttribIconsRow;
			};
			case "NEWBUTTON": {
				[_display,_settings] call MAZ_EZM_fnc_createAttribNewButton;
			};
			case "RESPAWN": {
				[_display,_settings] call MAZ_EZM_fnc_createAttribNewRespawnRow;
			};
			case "SLIDER": {
				[_display,_settings] call MAZ_EZM_fnc_createAttribSliderWithEditRow;
			};
			case "TOOLBOX": {
				[_display,_settings] call MAZ_EZM_fnc_createAttribToolboxRow;
			};
		};

		if(_type != "NEWBUTTON") then {
			_label params ["_label",["_tooltip",""]];
			private _labelCtrl = _controlsGroup controlsGroupCtrl 150;
			_labelCtrl ctrlSetText _label;
			_labelCtrl ctrlSetTooltip _tooltip;

			_controlsGroup ctrlSetPositionY _yOffset;
			_controlsGroup ctrlCommit 0;

			_yOffset = _yOffset + (ctrlPosition _controlsGroup select 3) + (["H",0.1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);

			_controls pushBack _controlsGroup;
		};
	}forEach _content;
	
	private _maxHeight = ["H",_maxHeight] call MAZ_EZM_fnc_convertToGUI_GRIDFormat;
	if(_yOffset > _maxHeight) then {
		_yOffset = _maxHeight;
	};

	private _contentHeight = (_yOffset - (["H",0.1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat));
	private _mainDisplayGroup = _display displayCtrl 100;
	private _displayContent = _mainDisplayGroup controlsGroupCtrl 103;
	_displayContent ctrlSetPositionH _contentHeight;
	_displayContent ctrlCommit 0;

	private _totalHeight = _yOffset + (["H",2.1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
	private _topOfDisplay = (0.5 - (_totalHeight / 2));

	_mainDisplayGroup ctrlSetPositionY _topOfDisplay;
	_mainDisplayGroup ctrlSetPositionH _totalHeight;
	_mainDisplayGroup ctrlCommit 0;

	private _contentBG = _mainDisplayGroup controlsGroupCtrl 102;
	_contentBG ctrlSetPositionY (["Y",1.1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
	_contentBG ctrlSetPositionH (_contentHeight + (["Y",1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat));
	_contentBG ctrlCommit 0;

	private _okButton = _display displayCtrl 104;
	private _cancelButton = _display displayCtrl 105;

	private _buttonHeight = _topOfDisplay + _totalHeight - (["H",1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat) + (["Y",1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
	_okButton ctrlSetPosition [(["X",6.5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat) + (["W",22] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),_buttonHeight,["W",5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,["H",1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat];
	_okButton ctrlCommit 0;

	_cancelButton ctrlSetPosition [["X",6.5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,_buttonHeight,["W",5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,["H",1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat];
	_cancelButton ctrlCommit 0;

	private _additionalButtons = _display getVariable ["MAZ_EZM_attribsButtons",[]];
	{
		_x ctrlSetPositionY _buttonHeight;
		_x ctrlCommit 0;
	}forEach _additionalButtons;

	_display setVariable ["MAZ_EZM_attributesDialogInfo",[_display,_controls,_args]];
};
