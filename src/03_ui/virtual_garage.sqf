MAZ_EZM_fnc_getVehicleCustomization = {
	params [["_vehicle",objNull,[objNull,""]]];
	private _input = [];
	private _className = "";
	if(_vehicle isEqualType "") then {
		_input = [objNull,_vehicle];
		_className = _vehicle;
	};
	if(_vehicle isEqualType objNull) then {
		if(!isNull _vehicle) then {
			_input = [_vehicle];
			_className = typeOf _vehicle;
		};
	};
	(_input call BIS_fnc_getVehicleCustomization) params ["","_animData"];

	private _customization = [];
	for "_i" from 0 to (count _animData -1) step 2 do {
		private _animSourceName = _animData # _i;
		private _displayName = getText (configfile >> "CfgVehicles" >> _className >> "AnimationSources" >> _animSourceName >> "displayName");
		_customization pushBack [_displayName,_animSourceName, _animData # (_i + 1)];
	};
	_customization
};

MAZ_EZM_fnc_getAllTextureTypes = {
	params [["_vehicle",objNull,[objNull,""]]];
	private _objectType = "";
	private _deleteAfter = false;
	if(_vehicle isEqualType "") then {
		_objectType = _vehicle;
		_vehicle = _objectType createVehicle [0,0,0];
		_deleteAfter = true;
	};
	if(_vehicle isEqualType objNull) then {
		if(!isNull _vehicle) then {
			_objectType = typeOf _vehicle;
		};
	};
	if(_objectType in ["B_Heli_Light_01_F","B_Heli_Light_01_dynamicLoadout_F","C_Heli_Light_01_civil_F","I_C_Heli_Light_01_civil_F"]) exitWith {
		private _return = [["BLUFOR",["A3\Air_F\Heli_Light_01\Data\Heli_Light_01_ext_Blufor_CO.paa"],false],["Blue",["\a3\air_f\Heli_Light_01\Data\heli_light_01_ext_blue_co.paa"],false],["Red",["\a3\air_f\Heli_Light_01\Data\heli_light_01_ext_co.paa"],false],["Ion",["\a3\air_f\Heli_Light_01\Data\heli_light_01_ext_ion_co.paa"],false],["BlueLine",["\a3\air_f\Heli_Light_01\Data\Skins\heli_light_01_ext_blueLine_co.paa"],false],["Digital",["\a3\air_f\Heli_Light_01\Data\Skins\heli_light_01_ext_digital_co.paa"],false],["Elliptical",["\a3\air_f\Heli_Light_01\Data\Skins\heli_light_01_ext_elliptical_co.paa"],false],["Furious",["\a3\air_f\Heli_Light_01\Data\Skins\heli_light_01_ext_furious_co.paa"],false],["Graywatcher",["\a3\air_f\Heli_Light_01\Data\Skins\heli_light_01_ext_graywatcher_co.paa"],false],["Jeans",["\a3\air_f\Heli_Light_01\Data\Skins\heli_light_01_ext_jeans_co.paa"],false],["Light",["\a3\air_f\Heli_Light_01\Data\Skins\heli_light_01_ext_light_co.paa"],false],["Shadow",["\a3\air_f\Heli_Light_01\Data\Skins\heli_light_01_ext_shadow_co.paa"],false],["Sheriff",["\a3\air_f\Heli_Light_01\Data\Skins\heli_light_01_ext_sheriff_co.paa"],false],["Speedy",["\a3\air_f\Heli_Light_01\Data\Skins\heli_light_01_ext_speedy_co.paa"],false],["Sunset",["\a3\air_f\Heli_Light_01\Data\Skins\heli_light_01_ext_sunset_co.paa"],false],["Vrana",["\a3\air_f\Heli_Light_01\Data\Skins\heli_light_01_ext_vrana_co.paa"],false],["Wasp",["\a3\air_f\Heli_Light_01\Data\Skins\heli_light_01_ext_wasp_co.paa"],false],["Wave",["\a3\air_f\Heli_Light_01\Data\Skins\heli_light_01_ext_wave_co.paa"],false]];
		{
			_x params ["_displayName","_textures","_isCurrent"];
			private _currentTexture = (getObjectTextures _vehicle) # 0;
			if(toLower (_textures # 0) find _currentTexture != -1) then {
				_return set [_forEachIndex,[_displayName,_textures,true]];
			};
		}forEach _return;
		_return
	};

	private _return = [];
	{
		private _vehicleEditDisplayName = getText (_x >> "displayName");
		private _textures = getArray (_x >> "textures");
		_textures = _textures apply {toLower _x};
		private _isCurrentTexture = true;
		private _objectTextures = getObjectTextures _vehicle;
		private _dataSlots = +_objectTextures;
		{
			if(_forEachIndex >= count _textures) then {
				_dataSlots deleteAt _forEachIndex;
				continue;
			};
			if((_textures select _forEachIndex) find _x != -1) then {
				_dataSlots set [_forEachIndex,true];
			} else {
				_dataSlots set [_forEachIndex,false];
			};
		}forEach _objectTextures;
		{
			if(!_isCurrentTexture) exitWith {};
			if(typeName _x == "STRING") then {continue};
			if(_x) then {
				_isCurrentTexture = true;
			} else {
				_isCurrentTexture = false;
			};
		}forEach _dataSlots;
		_return pushBack [_vehicleEditDisplayName,_textures,_isCurrentTexture];
	}forEach configProperties [configFile >> "CfgVehicles" >> _objectType >> "textureSources","isClass _x",true];
	if(_deleteAfter) then {
		deleteVehicle _vehicle;
	};
	_return
};

MAZ_EZM_fnc_createGarageInterface = {
	params ["_vehicle"];
	addCuratorSelected [_vehicle]; 
	if(isNull (findDisplay 312)) exitWith {["Not in Zeus interface!","addItemFailed"] call MAZ_EZM_fnc_systemMessage;};
	if(count (uiNamespace getVariable ["EZM_garageControls",[]]) > 0) exitWith {["Garage interface is already opened!","addItemFailed"] call MAZ_EZM_fnc_systemMessage;};
	disableSerialization;
	with uiNamespace do {
		private _display = findDisplay 312;
		EZM_garageControls = [];
		
		private _textureButtonBG = _display ctrlCreate ["RscPicture",-1];
		_textureButtonBG ctrlSetText "#(argb,8,8,3)color(0,0,0,0.8)";
		_textureButtonBG ctrlSetposition [["X",-7.5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,["Y",-8.5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,["W",3] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,["H",2.5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat];
		_textureButtonBG ctrlCommit 0;
		EZM_garage_TextureButton = _display ctrlCreate ["RscActivePicture",8001];
		EZM_garage_TextureButton ctrlSetPosition (ctrlPosition _textureButtonBG);
		EZM_garage_TextureButton ctrlSetTextColor [1,1,1,1];
		EZM_garage_TextureButton ctrlSetText "a3\ui_f\data\gui\rsc\rscdisplaygarage\texturesources_ca.paa";
		EZM_garage_TextureButton ctrlAddEventHandler ["ButtonClick",{
			params ["_control"];
			with uiNamespace do {
				EZM_garage_TextureButton ctrlSetTextColor [1,1,1,1];
				EZM_garage_AnimationsButton ctrlSetTextColor [1,1,1,0.6];
			};
			[uiNamespace getVariable "EZM_garage_listBox",uiNamespace getVariable "EZM_garage_editVehicle"] call MAZ_EZM_fnc_garagePopulateListBoxTextures;
		}];
		EZM_garage_TextureButton ctrlCommit 0;

		EZM_garageControls pushBack EZM_garage_TextureButton;
		EZM_garageControls pushBack _textureButtonBG;

		private _animButtonBG = _display ctrlCreate ["RscPicture",-1];
		_animButtonBG ctrlSetText "#(argb,8,8,3)color(0,0,0,0.8)";
		_animButtonBG ctrlSetposition [["X",-7.5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,["Y",-5.5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,["W",3] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,["H",2.5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat];
		_animButtonBG ctrlCommit 0;
		EZM_garage_AnimationsButton = _display ctrlCreate ["RscActivePicture",8002];
		EZM_garage_AnimationsButton ctrlSetPosition (ctrlPosition _animButtonBG);
		EZM_garage_AnimationsButton ctrlSetTextColor [1,1,1,0.6];
		EZM_garage_AnimationsButton ctrlSetText "a3\ui_f\data\gui\rsc\rscdisplaygarage\animationsources_ca.paa";
		EZM_garage_AnimationsButton ctrlAddEventHandler ["ButtonClick",{
			params ["_control"];
			with uiNamespace do {
				EZM_garage_AnimationsButton ctrlSetTextColor [1,1,1,1];
				EZM_garage_TextureButton ctrlSetTextColor [1,1,1,0.6];
			};
			[uiNamespace getVariable "EZM_garage_listBox",uiNamespace getVariable "EZM_garage_editVehicle"] call MAZ_EZM_fnc_garagePopulateListBoxAnimations;
		}];
		EZM_garage_AnimationsButton ctrlCommit 0;

		EZM_garageControls pushBack EZM_garage_AnimationsButton;
		EZM_garageControls pushBack _animButtonBG;


		private _controlGroup = _display ctrlCreate ["RscControlsGroupNoScrollbars",-1];
		_controlGroup ctrlSetPosition [["X",-4] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,["Y",-8.5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,["W",11.5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,["H",13.5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat];
		_controlGroup ctrlSetBackgroundColor [0,0,0,0.7];
		_controlGroup ctrlCommit 0;

		EZM_garageControls pushBack _controlGroup;

		private _controlGroupFrame = _display ctrlCreate ["RscFrame",-1,_controlGroup];
		_controlGroupFrame ctrlSetPosition [0,0,["W",11.5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,["H",13.5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat];
		_controlGroupFrame ctrlSetTextColor [0,0,0,0.8];
		_controlGroupFrame ctrlCommit 0;

		EZM_garage_listBox = _display ctrlCreate ["RscListbox",8003,_controlGroup];
		EZM_garage_listBox ctrlSetposition [0,0,["W",11.5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,["H",13.5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat];
		EZM_garage_listBox ctrlSetBackgroundColor [0.1,0.1,0.1,0.9];
		lbClear EZM_garage_listBox;
		EZM_garage_listBox ctrlCommit 0;
	};
	uiNamespace setVariable ["EZM_garage_editVehicle",_vehicle];
	[uiNamespace getVariable "EZM_garage_listBox",_vehicle] call MAZ_EZM_fnc_garagePopulateListBoxTextures;

	waitUntil {(!(_vehicle in (curatorSelected # 0))) || isNull _vehicle || !alive _vehicle};

	with uiNamespace do {
		{
			ctrlDelete _x;
		}forEach EZM_garageControls;
		EZM_garageControls = [];
	};
};

MAZ_EZM_fnc_garagePopulateListBoxTextures = {
	params ["_listBox","_vehicle"];
	lbClear _listBox;
	if(!isNil "EZM_garage_listEH") then {
		_listBox ctrlRemoveEventHandler ["LBSelChanged",EZM_garage_listEH];
	};
	_listBox setVariable ["EZM_garage_selectIndex",-1];
	private _textures = [_vehicle] call MAZ_EZM_fnc_getAllTextureTypes;
	if(_textures isEqualTo []) exitWith {
		_listBox lbAdd "No Textures...";
	};
	private _unCheckTexture = getText (configfile >> "RscCheckBox" >> "textureUnchecked");
	private _checkTexture = getText (configfile >> "RscCheckBox" >> "textureChecked");
	EZM_garage_listEH = _listBox ctrlAddEventHandler ["LBSelChanged",{
		params ["_control", "_selectedIndex"];
		private _oldSelection = _control getVariable ["EZM_garage_selectIndex",-1];
		if(_selectedIndex != _oldSelection) then {
			_control lbSetPicture [_selectedIndex,getText (configfile >> "RscCheckBox" >> "textureChecked")];
			_control lbSetPicture [_oldSelection,getText (configfile >> "RscCheckBox" >> "textureUnchecked")];
			_control setVariable ["EZM_garage_selectIndex",_selectedIndex];

			private _vehicle = uiNamespace getVariable "EZM_garage_editVehicle";
			private _textures = [_vehicle] call MAZ_EZM_fnc_getAllTextureTypes;
			private _newTexture = _textures select _selectedIndex;
			_newTexture params ["","_newTextures"];
			{
				_vehicle setObjectTextureGlobal [_forEachIndex,_x];
			}forEach _newTextures;
		};
	}];
	{
		_x params ["_displayName","_textures","_isCurrentTexture"];
		private _index = _listBox lbAdd _displayName;
		_listBox lbSetPicture [_index,_unCheckTexture];
		if(_isCurrentTexture) then {
			_listBox lbSetPicture [_index,_checkTexture];
			_listBox setVariable ["EZM_garage_selectIndex",_index];
		};
	}forEach _textures;
};

MAZ_EZM_fnc_garagePopulateListBoxAnimations = {
	params ["_listBox","_vehicle"];
	lbClear _listBox;
	if(!isNil "EZM_garage_listEH") then {
		_listBox ctrlRemoveEventHandler ["LBSelChanged",EZM_garage_listEH];
	};
	_listBox setVariable ["EZM_garage_selectIndex",-1];
	private _animations = [_vehicle] call MAZ_EZM_fnc_getVehicleCustomization;
	if(_animations isEqualTo []) exitWith {
		_listBox lbAdd "No Customization...";
	};

	private _unCheckTexture = getText (configfile >> "RscCheckBox" >> "textureUnchecked");
	private _checkTexture = getText (configfile >> "RscCheckBox" >> "textureChecked");
	EZM_garage_listEH = _listBox ctrlAddEventHandler ["LBSelChanged",{
		params ["_control", "_selectedIndex"];
		private _vehicle = uiNamespace getVariable "EZM_garage_editVehicle";
		private _animations = [_vehicle] call MAZ_EZM_fnc_getVehicleCustomization;
		(_animations select _selectedIndex) params ["_animDisplayName","_animationName","_state"];

		if(_state == 1) then {
			comment "Undo change";
			_control lbSetPicture [_selectedIndex,getText (configfile >> "RscCheckBox" >> "textureUnchecked")];
			_vehicle animate [_animationName,0,false];
			if("wing_fold" in _animationName) then {
				_vehicle animate ["wing_fold_r",0,false];
			};
		} else {
			comment "Apply change";
			_control lbSetPicture [_selectedIndex,getText (configfile >> "RscCheckBox" >> "textureChecked")];
			_vehicle animate [_animationName,1,false];
			if("wing_fold" in _animationName) then {
				_vehicle animate ["wing_fold_r",1,false];
			};
		};
	}];
	{
		_x params ["_animDisplayName","_animation","_state"];
		private _index = _listBox lbAdd _animDisplayName;
		_listBox lbSetPicture [_index,_unCheckTexture];
		if(_state == 1) then {
			_listBox lbSetPicture [_index,_checkTexture];
		};
	}forEach _animations;
};