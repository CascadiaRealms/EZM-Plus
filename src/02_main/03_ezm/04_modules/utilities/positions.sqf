MAZ_EZM_fnc_getScreenPosition = {
	params [
		["_getHeight",false,[false]],
		["_screenPos",getMousePosition,[[]],2]
	];

	if(visibleMap) exitWith {
		private _ctrlMap = findDisplay 312 displayCtrl 50;
		private _pos2D = _ctrlMap ctrlMapScreenToWorld _screenPos;
		private _position = (_pos2D + [0]);
		_position
	};
	private _position = AGLtoASL screenToWorld _screenPos;
	{
		_x params ["_intersectPos","_surfaceNormal","","_obj"];
		private _className = (str _obj) splitString ":";
		if(count _className <= 1) then {
			comment "TODO : Using variable name for object, I have no clue how to handle this...";
			continue;
		};
		_className = _className select 1;
		private _faunaCheck = _className select [1,2];

		if(_faunaCheck isEqualType "") then {
			if(_faunaCheck == "t_" || _faunaCheck == "b_") then {
				continue;
			};
		};

		if(_surfaceNormal vectorDotProduct [0,0,1] > 0.5) exitWith {_position = _intersectPos;};
	}forEach lineIntersectsSurfaces [getPosASL curatorCamera,_position,objNull,objNull,true,5,"VIEW","FIRE",false];
	if(!_getHeight) then {
		_position set [2,0];
	};
	(ASLtoAGL _position)
};

MAZ_EZM_fnc_selectSecondaryPosition = {
	params [
		["_text","",[""]],
		["_function",{},[{}]],
		["_objects",objNull,[objNull,[]]],
		["_args",[]],
		["_icon","\a3\ui_f\data\igui\cfg\cursors\select_target_ca.paa",[""]],
		["_angle",45,[0]],
		["_color",[1,0,0,1],[[]],4]
	];
	if(isNil "MAZ_EZM_isSelectingSecondPos") then {
		MAZ_EZM_isSelectingSecondPos = false;
	};

	if(MAZ_EZM_isSelectingSecondPos) exitWith {
		["Already selecting a position!","addItemFailed"] call MAZ_EZM_fnc_systemMessage;
	};

	MAZ_EZM_isSelectingSecondPos = true;

	private _display = findDisplay 312;
	private _ctrlMap  = _display displayCtrl 50;
	private _visuals = [_text,_icon,_angle,_color];

	_display setVariable ["MAZ_EZM_selectSecondPosParams",[_function,_objects,_args,_visuals]];
	_ctrlMap setVariable ["MAZ_EZM_selectSecondPosParams",[_objects,_visuals]];

	comment "ButtonClick on display";
	private _mouseEh = _display displayAddEventHandler ["MouseButtonDown",{
		params ["_display","_button","","","_shift","_ctrl","_alt"];
		(_display getVariable "MAZ_EZM_selectSecondPosParams") params ["_function","_objects","_args",""];
		if(_button != 0) exitWith {};

		private _position = [true] call MAZ_EZM_fnc_getScreenPosition;
		[_objects,_position,_args,_shift,_ctrl,_alt] call _function;

		MAZ_EZM_isSelectingSecondPos = false;
	}];
	comment "Keyboard input";
	private _keyboardEH = _display displayAddEventHandler ["KeyDown",{
		params ["_display", "_key", "_shift", "_ctrl", "_alt"];
		(_display getVariable "MAZ_EZM_selectSecondPosParams") params ["_function","_objects","_args",""];
		if(_key != 1) exitWith {false};
		["Selection cancelled.","addItemFailed"] call MAZ_EZM_fnc_systemMessage;
		MAZ_EZM_isSelectingSecondPos = false;
		true
	}];
	comment "Draw 2D icons on map";
	private _drawEH = _ctrlMap ctrlAddEventHandler ["Draw",{
		params ["_ctrlMap"];
		(_ctrlMap getVariable "MAZ_EZM_selectSecondPosParams") params ["_objects","_visuals"];
		_visuals params ["_text","_icon","_angle","_color"];
		private _pos = _ctrlMap ctrlMapScreenToWorld getMousePosition;
		_ctrlMap drawIcon [
			_icon,
			_color,
			_pos,
			24,
			24,
			_angle,
			_text,
			1,
			0.06,
			"RobotoCondensed"
		];

		if(!(_objects isEqualType [])) then {
			_objects = [_objects];
		};

		{
			_ctrlMap drawLine [_x, _pos, _color];
		}forEach _objects;
	}];
	comment "Draw 3D icons at position";
	["MAZ_EZM_selectPosEachFrame","onEachFrame",{
		params ["_objects", "_visuals", "_mouseEh", "_keyboardEH", "_drawEH"];

		if((isNull (findDisplay 312)) || !(isNull findDisplay 49)) then {
			MAZ_EZM_isSelectingSecondPos = false;
		};

		if(!MAZ_EZM_isSelectingSecondPos) then {
			private _display = findDisplay 312;
			_display displayRemoveEventHandler ["MouseButtonDown", _mouseEh];
			_display displayRemoveEventHandler ["KeyDown", _keyboardEH];
			private _ctrlMap = _display displayCtrl 50;
			_ctrlMap ctrlRemoveEventHandler ["Draw", _drawEH];
			["MAZ_EZM_selectPosEachFrame","onEachFrame"] call BIS_fnc_removeStackedEventHandler;
		};

		if(visibleMap) exitWith {};

		private _pos = [true] call MAZ_EZM_fnc_getScreenPosition;
		_visuals params ["_text", "_icon", "_angle", "_color"];
		drawIcon3D [
			_icon, 
			_color, 
			_pos, 
			1.5,
			1.5, 
			_angle, 
			_text,
			1
		];

		if(!(_objects isEqualType [])) then {
			_objects = [_objects];
		};

		{
			drawLine3D [ASLtoAGL getPosASL _x, _pos, _color];
		}forEach _objects;
	},[_objects,_visuals,_mouseEh,_keyboardEH,_drawEH]] call BIS_fnc_addStackedEventHandler;
};