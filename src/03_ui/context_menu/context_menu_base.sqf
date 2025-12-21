MAZ_EZM_fnc_createNewContextAction = {
	params [
		["_displayName","CONTEXT ACTION",[""]],
		["_code",{},[{}]],
		["_condition",{true},[{}]],
		["_priority",3,[1]],
		["_img","",[""]],
		["_color",[1,1,1,1],[[]]],
		["_childActions",[],[[]]]
	];
	if(isNil "MAZ_EZM_contextMenuActions") then {
		MAZ_EZM_contextMenuActions = [];
	};
	private _index = MAZ_EZM_contextMenuActions pushBack [_displayName,_code,_condition,_priority,_img,_color,_childActions];
	_index
};

MAZ_EZM_fnc_removeContextAction = {
	params ["_index"];
	if(_index < 0 || _index >= (count MAZ_EZM_contextMenuActions)) exitWith {
		["Failed to remove action","addItemFailed"] call MAZ_EZM_fnc_systemMessage;
	};
	MAZ_EZM_contextMenuActions set [_index,nil];
};

MAZ_EZM_fnc_openContextMenu = {
	comment "Check for actions";
		if(isNil "MAZ_EZM_contextMenuActions") exitWith {};

	comment "Close existing context menu";
		call MAZ_EZM_fnc_closeContextMenu;

	comment "Get cursor entity";
		private _targetObjArray = curatorMouseOver;
		private _entity = objNull;
		if ((_targetObjArray isEqualTo []) || (_targetObjArray isEqualTo [''])) then {} else {
			_entity = _targetObjArray select 1;
		};

		private _worldPos = [true] call MAZ_EZM_fnc_getScreenPosition;

	with uiNamespace do {
		getMousePosition params ["_mouseX","_mouseY"];

		private _display = findDisplay 312;
		MAZ_EZM_contextMenuBase = _display ctrlCreate ["RscControlsGroupNoScrollbars",-1];
		MAZ_EZM_contextMenuBase ctrlSetPosition [_mouseX,_mouseY,0,0];
		MAZ_EZM_contextMenuBase ctrlSetBackgroundColor [0,0,0,0.6];
		MAZ_EZM_contextMenuBase ctrlCommit 0;

		MAZ_EZM_contextMenuBase setVariable ["MAZ_EZM_contextParams",[_worldPos,_entity]];

		[MAZ_EZM_contextMenuBase,controlNull,missionNamespace getVariable "MAZ_EZM_contextMenuActions"] call (missionNamespace getVariable ["MAZ_EZM_fnc_createContextMenuActions",{}]);
	};
};

MAZ_EZM_fnc_closeContextMenu = {
	if !(call MAZ_EZM_fnc_isContextMenuOpen) exitWith {};
	[0] call MAZ_EZM_fnc_closeContextMenuToDepth;
	with uiNamespace do {
		ctrlDelete MAZ_EZM_contextMenuBase;
		MAZ_EZM_contextMenuBase = nil;
	};
	uiNamespace setVariable ["MAZ_EZM_contextStack",[]];
};

MAZ_EZM_fnc_closeContextMenuGroup = {
	params ["_controlGroup"];
	{
		ctrlDelete _x;
	}forEach (allControls _controlGroup);
	ctrlDelete _controlGroup;
};

MAZ_EZM_fnc_closeContextMenuToDepth = {
	params ["_depth"];
	private _openContextMenus = uiNamespace getVariable ["MAZ_EZM_contextStack",[]];
	private _menusAboveDepth = _openContextMenus select [_depth];
	{
		[_x] call MAZ_EZM_fnc_closeContextMenuGroup;
	}forEach _menusAboveDepth;
	_openContextMenus = _openContextMenus - _menusAboveDepth;
	uiNamespace setVariable ["MAZ_EZM_contextStack",_openContextMenus];
};

MAZ_EZM_fnc_createContextMenuActions = {
	params ["_parentGroup",["_parentControl",controlNull],["_actions",[]]];
	"Close the existing menus that are above the depth of selected action";
	private _depth = _parentGroup getVariable ["MAZ_EZM_contextDepth",-1];
	[_depth + 1] call MAZ_EZM_fnc_closeContextMenuToDepth;

	"If there are no actions, don't create a new menu";
	if(count _actions == 0) exitWith {};

	"Create base control group for actions";
	private _display = findDisplay 312;
	private _controlGroup = _display ctrlCreate ["RscControlsGroupNoScrollbars",-1];
	private _controlGroupFrame = _display ctrlCreate ["RscFrame",-1,_controlGroup];
	_controlGroupFrame ctrlSetPosition [0,0,["W",9] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,0];
	_controlGroupFrame ctrlSetTextColor [0,0,0,0.6];

	"Get position offset to the right based on parent size and position";
	(ctrlPosition _parentGroup) params ["_parentX","_parentY","_parentW","_parentH"];
	private _xPos = _parentX + _parentW;

	"Get position offset down based on parent control from mouse enter";
	private _yPos = _parentY;
	if(!isNull _parentControl) then {
		_yPos = _yPos + ((ctrlPosition _parentControl) select 1);
	};

	_controlGroup ctrlSetPosition [_xPos,_yPos,["W",9] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,0];
	_controlGroup ctrlSetBackgroundColor [0,0,0,0.6];
	_controlGroup ctrlCommit 0;

	"Setup each open menu as variable for closing and handling";
	private _openContextMenus = uiNamespace getVariable ["MAZ_EZM_contextStack",[]];
	private _index = _openContextMenus pushBack _controlGroup;
	_controlGroup setVariable ["MAZ_EZM_contextDepth",_index];
	uiNamespace setVariable ["MAZ_EZM_contextStack",_openContextMenus];

	"Add each action from the _actions variable";
	"Save row controls to the control group";
	private _groupHeight = 0;
	private _rows = [];

	"Sort by priority";
	private _entity = (MAZ_EZM_contextMenuBase getVariable ["MAZ_EZM_contextParams",[[],objNull]]) select 1;
	_actions = [_actions,[],{_x select 3},"ASCEND"] call BIS_fnc_sortBy;
	{
		"Check condition";
		if(isNil "_x") then {continue};
		_x params ["_displayName","_code","_condition","_priority","_img","_color","_actions"];
		with missionNamespace do {
			private _result = _entity call _condition;
			uiNamespace setVariable ["MAZ_EZM_contextCondition",_result];
		};
		if(!MAZ_EZM_contextCondition) then {continue};

		"Create row, update height";
		private _row = [_controlGroup,_groupHeight,_displayName,_code,_condition,_priority,_img,_color,_actions] call (missionNamespace getVariable ["MAZ_EZM_fnc_createContextMenuRow",{}]);
		_rows pushBack _row;
		_groupHeight = _groupHeight + (["H",1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);

	}forEach _actions;
	_controlGroup setVariable ["MAZ_EZM_contextRows",_rows];

	"Update control group height";
	_controlGroup ctrlSetPositionH _groupHeight;
	_controlGroup ctrlCommit 0;
	_controlGroupFrame ctrlSetPositionH _groupHeight;
	_controlGroupFrame ctrlCommit 0;
	if(_yPos + _groupHeight > 1.405) then {
		(ctrlPosition _controlGroup) params ["","_posY"];
		_controlGroup ctrlSetPositionY ((_yPos - _groupHeight) + (["H",1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat));
		_controlGroup ctrlCommit 0;
	};

	uiNamespace setVariable ["MAZ_EZM_contextCondition",nil];
};

MAZ_EZM_fnc_createContextMenuRow = {
	params [["_parent",controlNull],["_yPos",0],["_displayName","[ TEMPLATE ]"],["_code", {}],["_condition",{true}],["_priority",3],["_img",""],["_color",[1,1,1,1]],["_childActions",[]]];
	if(isNull _parent) exitWith {};

	private _display = findDisplay 312;
	private _ctrl = _display ctrlCreate ["RscButtonMenu",-1,_parent];

	if(_img != "") then {
		_displayName = "     " + _displayName;
		private _picture = _display ctrlCreate ["RscPicture",-1,_parent];
		_picture ctrlSetText _img;
		_picture ctrlSetTextColor _color;
		_picture ctrlSetPosition [(["W",0.1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),_yPos,["W",0.9] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,["H",0.9] call MAZ_EZM_fnc_convertToGUI_GRIDFormat];
		_picture ctrlCommit 0;
	};

	_code = compile (format ["private _base = uiNamespace getVariable 'MAZ_EZM_contextMenuBase'; (_base getVariable 'MAZ_EZM_contextParams') params ['_pos','_entity']; [_pos,_entity] call %1;",_code]);

	_ctrl ctrlSetText _displayName;
	_ctrl ctrlSetFont "RobotoCondensed";
	_ctrl ctrlSetPosition [0,_yPos,["W",9] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,["H",1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat];
	_ctrl ctrlSetTextColor _color;
	_ctrl ctrlSetBackgroundColor [0,0,0,0.6];
	_ctrl ctrlSetActiveColor [0,0,0,0.7];
	_ctrl ctrlAddEventHandler ["ButtonClick", _code];
	_ctrl ctrlCommit 0;

	private _entity = MAZ_EZM_contextMenuBase getVariable "MAZ_EZM_contextParams";
	_entity = if(isNil "_entity") then {
		objNull
	} else {
		_entity select 1;
	};
	private _activeChildren = _childActions select {
		private _child = _x;
		with missionNamespace do {
			private _result = _entity call (_child select 2);
			uiNamespace setVariable ["MAZ_EZM_contextCondition",_result];
		};
		uiNamespace getVariable ["MAZ_EZM_contextCondition",false]
	};
	if((count _activeChildren) > 0) then {
		private _pictureDrop = (findDisplay 312) ctrlCreate ["RscPicture",-1,_parent];
		_pictureDrop ctrlSetText "A3\ui_f\data\gui\rsccommon\rsctree\hiddenTexture_ca.paa";
		_pictureDrop ctrlSetTextColor [1,1,1,1];
		_pictureDrop ctrlSetPosition [["W",8] call (missionNamespace getVariable "MAZ_EZM_fnc_convertToGUI_GRIDFormat"),_yPos,["W",1] call (missionNamespace getVariable "MAZ_EZM_fnc_convertToGUI_GRIDFormat"),["H",1] call (missionNamespace getVariable "MAZ_EZM_fnc_convertToGUI_GRIDFormat")];
		_pictureDrop ctrlCommit 0;
	};
	_ctrl setVariable ["MAZ_EZM_contextChildActions",_activeChildren];
	
	_ctrl ctrlAddEventHandler ["MouseEnter", {
		params ["_ctrl"];
		private _childActions = _ctrl getVariable ["MAZ_EZM_contextChildActions",[]];
		private _parentGroup = ctrlParentControlsGroup _ctrl;
		[_parentGroup,_ctrl,_childActions] call (missionNamespace getVariable ["MAZ_EZM_fnc_createContextMenuActions",{}]);
	}];

	_ctrl
};

MAZ_EZM_fnc_isContextMenuOpen = {
	private _contextBase = uiNamespace getVariable ["MAZ_EZM_contextMenuBase",controlNull];
	!(isNull _contextBase)
};