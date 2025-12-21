MAZ_EZM_fnc_editZeusInterface = {
	if (isNull (findDisplay 312)) exitWith {};
	showChat true;
	private _fnc_editInterface = {
		disableSerialization;
		with uiNamespace do {
			private _display = findDisplay 312;
			if(isNull _display) exitWith {};
			
			comment "Re-Color Zeus Watermark";
				_display displayAddEventHandler ['KeyDown', {
					if (_this select 1 == 14) then {
						private _display = findDisplay 312;
						[_display] spawn {
							params [['_display', displayNull]];
							uiSleep 0.01;
							if (isNull _display) exitWith {};
							(_display displayCtrl 15717) ctrlSetTextColor EZM_themeColor;
							if(_display getVariable ["MAZ_EZM_hideWarnings",false]) then {
								_display setVariable ["MAZ_EZM_hideWarnings",false];
								call (uiNamespace getVariable "MAZ_EZM_fnc_unhideAllWarnings");
							} else {
								_display setVariable ["MAZ_EZM_hideWarnings",true];
								call (uiNamespace getVariable "MAZ_EZM_fnc_hideAllWarnings");
							};
						};
					};
				}];

			comment "Transparency & Function Defines";

				missionNamespace setVariable ["MAZ_zeusModulesWithFunction", []];
				[missionNamespace getVariable "EZM_zeusTransparency"] call (missionNamespace getvariable ["MAZ_EZM_fnc_setZeusTransparency", {}]);

				MAZ_EZM_fnc_zeusAddCategory = {
					params [
						['_parentTree', findDisplay 312 displayCtrl 280],
						['_categoryName', '[ Category ]'],
						['_iconPath', '\a3\ui_f_curator\Data\Displays\RscDisplayCurator\modeModules_ca.paa'],
						['_textColor', [1,1,1,1]],
						['_toolTip', '']
					];
					private _pindex = _parentTree tvAdd [[], _categoryName];
					_parentTree tvSetPictureRight [[_pindex], _iconPath];
					_parentTree tvSetColor [[_pindex], _textColor];
					_parentTree tvSetTooltip [[_pindex], _toolTip];
					_pindex;
				};

				MAZ_EZM_fnc_zeusAddSubCategory = {
					params [
						['_parentTree', findDisplay 312 displayCtrl 280],
						['_parentCategory', 1],
						['_categoryName', '[ Subcategory ]'],
						['_iconPath', '\a3\ui_f_curator\Data\Displays\RscDisplayCurator\modeModules_ca.paa']
					];
					private _cindex = _parentTree tvAdd [[_parentCategory], _categoryName];
					_parentTree tvSetPictureRight [[_parentCategory,_cindex], _iconPath];
					_cindex;
				};

				MAZ_EZM_fnc_zeusNewAddModule = {
					params [
						["_side", sideLogic, [west]],
						["_parentTree", findDisplay 312 displayCtrl 280],
						["_parentCategory", 1],
						["_parentSubCategory", nil],
						["_moduleName", "[ Module ]"],
						["_moduleTip", "[ Placeholder ]"],
						["_moduleFunction", "MAZ_EZM_fnc_nullFunction"],
						["_iconPath", "\a3\ui_f_curator\Data\Displays\RscDisplayCurator\modeModules_ca.paa"],
						["_textColor", [1,1,1,1]],
						["_iconColor", [1,1,1,1]]
					];

					private _data = switch (_side) do {
						case west: {"B_Soldier_VR_F"};
						case east: {"O_Soldier_VR_F"};
						case independent: {"I_Soldier_VR_F"};
						case civilian: {"C_Soldier_VR_F"};
						default {"ModuleEmpty_F"};
					};

					comment "Setup functions";
						private _functionArray = missionNamespace getVariable ['MAZ_zeusModulesWithFunction', []];
						private _functionCount = count _functionArray; 
						private _functionIndex = 7000 + (_functionCount + 1);
						private _moduleTip = format ['%1\n\nFunction ID:\n%2', _moduleTip, str _functionIndex];
						_functionArray pushBack [_functionIndex, _moduleFunction];
						missionNamespace setVariable ['MAZ_zeusModulesWithFunction', _functionArray];
					
					comment "Add modules";
						private _path = [_parentCategory];
						if(!isNil "_parentSubCategory") then {_path pushBack _parentSubCategory};
						private _cindex = _parentTree tvAdd [_path, _moduleName];
						_path pushBack _cindex;

						_parentTree tvSetTooltip [_path,_moduleTip];
						_parentTree tvSetPicture [_path, _iconPath];
						_parentTree tvSetData [_path, _data];
						_parentTree tvSetPictureColor [_path, _iconColor];
						_parentTree tvSetColor [_path, _textColor];
						_parentTree ctrlCommit 0;

					_path;
				};

				MAZ_EZM_fnc_zeusAddModule = {
					_this insert [0,[sideLogic]];
					_this insert [3,[nil]];
					_this call MAZ_EZM_fnc_zeusNewAddModule;
				};

				MAZ_EZM_fnc_zeusAddModule_BLUFOR = {
					_this insert [0,[west]];
					_this call MAZ_EZM_fnc_zeusNewAddModule;
				};

				MAZ_EZM_fnc_zeusAddModule_OPFOR = {
					_this insert [0,[east]];
					_this call MAZ_EZM_fnc_zeusNewAddModule;
				};

				MAZ_EZM_fnc_zeusAddModule_INDEP = {
					_this insert [0,[independent]];
					_this call MAZ_EZM_fnc_zeusNewAddModule;
				};

				MAZ_EZM_fnc_zeusAddModule_CIVILIAN = {
					_this insert [0,[civilian]];
					_this call MAZ_EZM_fnc_zeusNewAddModule;
				};

				MAZ_EZM_fnc_addZeusPreviewEvents = {
					private _zeusDisplay = findDisplay 312;
					if (isNull _zeusDisplay) exitWith {};
					if (_zeusDisplay getVariable ['MAZ_zeusPreviewInitialized', false]) exitWith {};
					private _idcs = [270,271,272,273,274];
					{
						private _ctrl = _zeusDisplay displayCtrl _x;
						_ctrl ctrlAddEventHandler ['TreeMouseMove',{
							params ['_control', '_path'];
							private _data = _control tvData _path;
							private _img = getText (configfile >> 'CfgVehicles' >> _data >> 'editorPreview');
							if (_data == '' || _img == '') then {
								with uiNamespace do {
									{
										_x ctrlShow false;
									} forEach MAZ_zeusPreviewCtrls;
								};
							} else {
								getMousePosition params ['_mouseX', '_mouseY'];
								_mouseY = _mouseY - 0.11;
								(getTextureInfo _img) params ["_width","_height"];
								private _ratio = (_width / _height);
								private _posEdgeX = switch (getResolution # 5) do {
									case 0.47 : {52.5};
									case 0.55 : {47.5};
									case 0.7 : {42.5};
									case 0.85 : {37.5};
									case 1 : {32.5};
									default {47.5};
								};
								private _previewImage = uiNamespace getVariable "MAZ_ctrl_previewImage";
								private _previewBackground = uiNamespace getVariable "MAZ_ctrl_previewBackground";
								private _previewFrame = uiNamespace getVariable "MAZ_ctrl_previewFrame";
								_previewImage ctrlSetPositionW (["W",(5.5 * _ratio)] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
								_previewImage ctrlSetPositionX (["X",((_posEdgeX - 0.5) - (5.5*_ratio))] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
								_previewImage ctrlSetPositionY (_mouseY + 0.019);
								_previewImage ctrlSetText _img;
								_previewImage ctrlCommit 0;

								{
									_x ctrlSetPositionW (["W",(5.5 * _ratio) + 1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
									_x ctrlSetPositionX (["X",((_posEdgeX - 1) - (5.5*_ratio))] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
									_x ctrlSetPositionY _mouseY;
									_x ctrlCommit 0;
								}forEach [_previewBackground,_previewFrame];

								(ctrlPosition _previewBackground) params ["","_posY","","_posH"];
								private _extendsTooLow = (_posY + _posH) > (["Y",35] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
								private _modifyPos = (_posY + _posH) - (["Y",35] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
								if(_extendsTooLow) then {
									{
										comment "35 Y pos";
										private _y = (ctrlPosition _x) select 1;
										_x ctrlSetPositionY (_y - _modifyPos);
									}forEach [_previewImage,_previewBackground,_previewFrame];
								};
								
								{
									_x ctrlShow true;
									_x ctrlCommit 0;
								} forEach [_previewImage,_previewBackground,_previewFrame];
							};
						}];
						_ctrl ctrlAddEventHandler ['TreeMouseExit',{
							params ['_control'];
							with uiNamespace do {
								{
									_x ctrlShow false;
								} forEach MAZ_zeusPreviewCtrls;
							};
						}];
					} forEach _idcs;
					_zeusDisplay getVariable ['MAZ_zeusPreviewInitialized', true];
				};

				MAZ_EZM_fnc_zeusPreviewImage = {
					with uiNamespace do {
						_display = findDisplay 312;
						MAZ_ctrl_previewBackground = _display ctrlCreate ['RscPicture', 1200];
						MAZ_ctrl_previewBackground ctrlSetText '#(argb,8,8,3)color(0,0,0,0.6)';
						MAZ_ctrl_previewBackground ctrlSetPosition [["X",32.5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,["Y",28] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,["W",15] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,["H",6.5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat];
						MAZ_ctrl_previewBackground ctrlCommit 0;
						MAZ_ctrl_previewImage = _display ctrlCreate ['RscPicture', 1201];
						MAZ_ctrl_previewImage ctrlSetText '#(argb,8,8,3)color(0,0,0,0)';
						MAZ_ctrl_previewImage ctrlSetPosition [["X",33] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,["Y",28.5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,["W",14] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,["H",5.5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat];
						MAZ_ctrl_previewImage ctrlCommit 0;
						MAZ_ctrl_previewFrame = _display ctrlCreate ['RscFrame', 1800];
						MAZ_ctrl_previewFrame ctrlSetPosition [["X",32.5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,["Y",28] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,["W",15] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,["H",6.5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat];
						MAZ_ctrl_previewFrame ctrlCommit 0;
						MAZ_zeusPreviewCtrls = [
							MAZ_ctrl_previewBackground,
							MAZ_ctrl_previewImage,
							MAZ_ctrl_previewFrame
						];
						{
							_x ctrlShow false;
						} forEach MAZ_zeusPreviewCtrls;
					};
				};

				MAZ_EZM_fnc_drawEventhandlerAreaMarkers = {
					private _ctrlMap  = findDisplay 312 displayCtrl 50;
					_ctrlMap ctrlAddEventHandler ["Draw",{
						params ["_map"];
						{
							if((markerShape _x == "ELLIPSE") || (markerShape _x == "RECTANGLE")) then {
								private _color = getArray (configFile >> "CfgMarkerColors" >> markerColor _x >> "color");
								if((_color select 0) isEqualType "") then {
									{
										_color set [_forEachIndex,call (compile _x)];
									}forEach _color;
								};
								_map drawIcon ["\a3\3den\data\cfg3den\marker\texturecenter_ca.paa",_color,getMarkerPos _x,10,10,0];
							};
						}forEach allMapMarkers;
					}];
				};

			comment "Quality of Life Stuff";

				MAZ_EZM_fnc_addCollapseExpandButtons = {
					private _display = (findDisplay 312);
					private _zeusSearchBar = _display displayCtrl 283;
					private _zeusSearchButton = _display displayCtrl 646;
					(ctrlPosition _zeusSearchBar) params ["_searchPosX","_searchPosY","_searchPosW","_searchPosH"];
					_zeusSearchBar ctrlSetPositionW (_searchPosW - (["W",2.2] call MAZ_EZM_fnc_convertToGUI_GRIDFormat));
					_zeusSearchBar ctrlCommit 0;

					private _ctrlGroup = ctrlParentControlsGroup _zeusSearchButton;
					(ctrlPosition _zeusSearchButton) params ["_searchButtonPosX","_searchButtonPosY","_searchButtonPosW","_searchButtonPosH"];
					_zeusSearchButton ctrlSetPositionX (_searchButtonPosX - (["W",2.2] call MAZ_EZM_fnc_convertToGUI_GRIDFormat));
					_zeusSearchButton ctrlSetPositionY (_searchButtonPosY - (["H",0.1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat));
					_zeusSearchButton ctrlCommit 0;

					private _bgCtrl = _display ctrlCreate ["RscPicture",-1,_ctrlGroup];
					_bgCtrl ctrlSetText "#(argb,8,8,3)color(1,1,1,1)";
					_bgCtrl ctrlSetTextColor [0.13,0.13,0.15,1];
					_bgCtrl ctrlSetPosition [(_searchButtonPosX - (["W",1.2] call MAZ_EZM_fnc_convertToGUI_GRIDFormat)),_searchButtonPosY - (["H",0.095] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),(_searchButtonPosW * 2) + (["W",1.2] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),_searchButtonPosH];
					_bgCtrl ctrlCommit 0;

					private _zeusCollapse = _display ctrlCreate ["RscActivePicture",-1,_ctrlGroup];
					_zeusCollapse ctrlSetText "a3\3den\data\displays\display3den\tree_collapse_ca.paa";
					_zeusCollapse ctrlSetTextColor [1,1,1,0.8];
					_zeusCollapse ctrlSetActiveColor [1,1,1,1];
					_zeusCollapse ctrlSetTooltip "Collapse all the trees";
					_zeusCollapse ctrlSetPosition [(_searchButtonPosX - (["W",1.1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat)),_searchButtonPosY - (["H",0.1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),_searchButtonPosW,_searchButtonPosH];
					_zeusCollapse ctrlAddEventHandler ["ButtonClick",{
						[] call MAZ_EZM_fnc_collapseAllTrees;
					}];
					_zeusCollapse ctrlCommit 0;

					private _zeusExpand = _display ctrlCreate ["RscActivePicture",-1,_ctrlGroup];
					_zeusExpand ctrlSetText "a3\3den\data\displays\display3den\tree_expand_ca.paa";
					_zeusExpand ctrlSetTextColor [1,1,1,0.8];
					_zeusExpand ctrlSetActiveColor [1,1,1,1];
					_zeusExpand ctrlSetTooltip "Expand all the trees";
					_zeusExpand ctrlSetPosition [_searchButtonPosX,_searchButtonPosY + (["Y",0.075] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),_searchButtonPosW,_searchButtonPosH - (["Y",0.1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat)];
					_zeusExpand ctrlAddEventHandler ["ButtonClick",{
						[] call MAZ_EZM_fnc_expandAllTrees;
					}];
					_zeusExpand ctrlCommit 0;
				};
				call MAZ_EZM_fnc_addCollapseExpandButtons;

				MAZ_EZM_fnc_removeFactionStuffFromEmpty = {
					private _display = (findDisplay 312);
					private _civilianUnitTree = (_display displayCtrl 274);
					private _factionNames = [
						"$STR_A3_CFGFACTIONCLASSES_IND_F0",
						"$STR_A3_CFGFACTIONCLASSES_CIV_F0",
						"$STR_A3_CFGFACTIONCLASSES_OPF_F0",
						"$STR_A3_CFGFACTIONCLASSES_OPF_T_F0",
						"$STR_A3_CFGFACTIONCLASSES_BLU_CTRG_F0",
						"$STR_A3_CFGFACTIONCLASSES_IND_G_F0",
						"$STR_A3_CFGFACTIONCLASSES_BLU_GEN_F0",
						"$STR_A3_CFGFACTIONCLASSES_CIV_IDAP_F0",
						"$STR_A3_C_CFGFACTIONCLASSES_IND_E_F0",
						"$STR_A3_CFGFACTIONCLASSES_BLU_F0",
						"$STR_A3_CFGFACTIONCLASSES_BLU_T_F0",
						"$STR_A3_C_CFGFACTIONCLASSES_BLU_W_F0",
						"$STR_A3_CFGFACTIONCLASSES_IND_C_F0"
					] apply {localize _x};
					private _treePaths = [];
					for '_n' from 0 to 40 do {
						private _text = _civilianUnitTree tvText [_n];
						if(_text in _factionNames) then {
							_treePaths pushBack _n;
						};
					};
					{
						_civilianUnitTree tvDelete [_x - _forEachIndex];
					}forEach _treePaths;
				};
				call MAZ_EZM_fnc_removeFactionStuffFromEmpty;

				MAZ_EZM_fnc_addSpawnWithoutCrewButton = {
					private _display = (findDisplay 312);
					private _spawnBannerCtrl = (_display displayCtrl 270);
					private _ctrlGroup = ctrlParentControlsGroup _spawnBannerCtrl;
					(ctrlPosition _spawnBannerCtrl) params ["_posX","_posY","_posW","_posH"];
					private _yPosButton = _posY + _posH - (["H",1.1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);

					private _zeusCheckBoxBG = _display ctrlCreate ["RscPicture",-1,_ctrlGroup];
					_zeusCheckBoxBG ctrlSetText "#(argb,8,8,3)color(0.18,0.19,0.21,1)"; 
					_zeusCheckBoxBG ctrlSetPosition [_posX,_yPosButton - (["H",0.1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),_posW,["H",1.2] call MAZ_EZM_fnc_convertToGUI_GRIDFormat];
					_zeusCheckBoxBG ctrlEnable false;
					_zeusCheckBoxBG ctrlCommit 0;

					private _zeusCheckBoxFrame = _display ctrlCreate ["RscFrame",-1,_ctrlGroup];
					_zeusCheckBoxFrame ctrlSetTextColor [0,0,0,1];
					_zeusCheckBoxFrame ctrlSetPosition [_posX,_yPosButton - (["H",0.1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),_posW,["H",1.2] call MAZ_EZM_fnc_convertToGUI_GRIDFormat];
					_zeusCheckBoxFrame ctrlEnable false;
					_zeusCheckBoxFrame ctrlCommit 0;
					
					private _zeusCheckBoxText = _display ctrlCreate ["RscText",-1,_ctrlGroup];
					_zeusCheckBoxText ctrlSetText "Spawn vehicles with crew";
					_zeusCheckBoxText ctrlSetTextColor [1,1,1,1];
					_zeusCheckBoxText ctrlSetPosition [(_posX + (["W",1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat)),_yPosButton,_posW - (["W",1.2] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),["H",1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat];
					_zeusCheckBoxText ctrlEnable false;
					_zeusCheckBoxText ctrlCommit 0;

					private _zeusCheckBox = _display ctrlCreate ["RscCheckbox",-1,_ctrlGroup];
					_zeusCheckBox ctrlSetTextColor [1,1,1,0.8];
					_zeusCheckBox ctrlSetActiveColor [1,1,1,1];
					_zeusCheckBox cbSetChecked (missionNamespace getVariable ["MAZ_EZM_spawnWithCrew",true]);
					_zeusCheckBox ctrlSetPosition [(_posX + (["W",0.1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat)),_yPosButton,["W",1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,["H",1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat];
					_zeusCheckBox ctrlAddEventHandler ["ButtonClick",{
						if(MAZ_EZM_spawnWithCrew) then {
							MAZ_EZM_spawnWithCrew = false;
						} else {
							MAZ_EZM_spawnWithCrew = true;
						};
					}];
					_zeusCheckBox ctrlCommit 0;

					{
						(ctrlPosition (_display displayCtrl _x)) params ["","_posY","","_posH"];
						(_display displayCtrl _x) ctrlSetPositionH (_posH - (["H",1.2] call MAZ_EZM_fnc_convertToGUI_GRIDFormat));
						(_display displayCtrl _x) ctrlCommit 0;
					} forEach [270,271,272,273,274,275,276,277,278,279,280,281,282];
				};
				call MAZ_EZM_fnc_addSpawnWithoutCrewButton;

				comment "TODO : Move groups tree back once";
				MAZ_EZM_fnc_moveTree = {
					params ["_ctrl","_fromPath","_toPath"];
					private _data = [_ctrl,_fromPath] call MAZ_EZM_fnc_getSubChildrenOfTree;
					[_ctrl,_fromPath,_toPath,_data] spawn MAZ_EZM_fnc_createTree;
				};

				MAZ_EZM_fnc_getSubChildrenOfTree = {
					params ["_ctrl","_fromPath"];
					private _size = _ctrl tvCount _fromPath;
					if(_size <= 0) exitWith {};
					private _subChildren = [];
					for "_i" from 0 to (_size - 1) do {
						private _xPath = _fromPath + [_i];
						private _xText = _ctrl tvText _xPath;
						private _xData = _ctrl tvData _xPath;
						private _xHasChildren = false;
						if(_ctrl tvCount _xPath > 0) then {
							comment "Has subchildren";
							_xHasChildren = true;
						};
						_subChildren pushBack [_i,_xText,_xData,_xHasChildren];
					};
					_subChildren
				};

				MAZ_EZM_fnc_createTree = {
					params ["_ctrl","_fromPath","_toPath","_data"];
					{
						_x params ["_path","_text","_data","_hasChildren"];
						_ctrl tvAdd [_toPath,_text];
						private _xPath = _toPath + [_forEachIndex];
						_ctrl tvSetData [_xPath,_data];
						if(_hasChildren) then {
							private _children = [_ctrl,_fromPath + [_forEachIndex]] call MAZ_EZM_fnc_getSubChildrenOfTree;
							[_ctrl,_fromPath + [_forEachIndex],_xPath,_children] spawn MAZ_EZM_fnc_createTree;
						};
						sleep 0.5;
					}forEach _data;
				};

				MAZ_EZM_fnc_removeUselessGroupTrees = {
					{
						((findDisplay 312) displayCtrl _x) tvDelete [0];
					} forEach [275,276,277];
				};

				MAZ_EZM_fnc_findTree = {
					params ["_parent","_value",["_parentPath",[]]];
					private _index = -1;
					for "_i" from 0 to (_parent tvCount _parentPath) do {
						private _newPath = +_parentPath;
						_newPath pushBack _i;
						if(_parent tvText _newPath == _value) then {
							_index = _i;
							break;
						};
					};
					_index
				};

			comment "Warning System";

				MAZ_EZM_fnc_getActiveWarnings = {
					private _count = 0;
					{
						if(isNil "_x") then {continue};
						_x params ["_ctrl","_warningInfo","_isActive"];
						if(_isActive) then {_count = _count + 1;}
					}forEach (uiNamespace getVariable ["MAZ_EZM_activeWarnings",[]]);
					_count
				};

				MAZ_EZM_fnc_addWarningElement = {
					params ["_text",["_icon","A3\UI_F\Data\Map\Markers\Military\warning_ca.paa"],["_color",[1,0,0,1]]];
					if !(currentNamespace isEqualTo uiNamespace) exitWith {["This function should only be called from the uiNamespace!","addItemFailed"] call MAZ_EZM_fnc_systemMessage; nil};
					with uiNamespace do {
						private _warningPicture = (findDisplay 312) ctrlCreate ["RscPicture",-1];
						_warningPicture ctrlSetPosition [["X",46] call MAZ_EZM_fnc_convertToGUI_GRIDFormat, ["Y",-8] call MAZ_EZM_fnc_convertToGUI_GRIDFormat, ["W",1.5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,["H",1.5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat];
						_warningPicture ctrlSetText _icon;
						_warningPicture ctrlSetTooltip _text;
						_warningPicture ctrlSetTextColor _color;
						_warningPicture ctrlSetPositionY (["Y",-8 + (2 * ([] call MAZ_EZM_fnc_getActiveWarnings))] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
						_warningPicture ctrlCommit 0;

						playSound "addItemFailed";

						MAZ_EZM_activeWarnings pushBack [_warningPicture,[_text,_icon,_color],true];
					};
				};
				missionNamespace setVariable ["MAZ_EZM_fnc_addWarningElement",MAZ_EZM_fnc_addWarningElement];

				MAZ_EZM_fnc_removeWarningElement = {
					params ["_warningIndex"];
					private _warningData = (uiNamespace getVariable ["MAZ_EZM_activeWarnings",[]]) select _warningIndex;
					_warningData params ["_warningPicture","_warningInfo","_isActive"];
					(uiNamespace getVariable ["MAZ_EZM_activeWarnings",[]]) set [_warningIndex,nil];
					ctrlDelete _warningPicture;
					private _count = 0;
					{
						if(isNil "_x") then {continue};
						_x params ["_ctrl","_warningInfo","_isActive"];
						if(isNil "_warningInfo") then {continue};
						if(!_isActive) then {continue};
						_ctrl ctrlSetPositionY (["Y",-8 + (2 * _count)] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
						_ctrl ctrlCommit 0;
						_count = _count + 1;
					}forEach (uiNamespace getVariable ["MAZ_EZM_activeWarnings",[]]);
				};
				missionNamespace setVariable ["MAZ_EZM_fnc_removeWarningElement",MAZ_EZM_fnc_removeWarningElement];

				MAZ_EZM_fnc_showAllWarnings = {
					if(count (uiNamespace getVariable ["MAZ_EZM_activeWarnings",[]]) < 0) exitWith {};
					if(isNull (findDisplay 312)) exitWith {};
					with uiNamespace do {
						private _count = 0;
						if(isNil "MAZ_EZM_activeWarnings") exitWith {};
						{
							if(isNil "_x") then {continue};
							_x params ["","_warningInfo","_isActive"];
							if(isNil "_warningInfo") then {continue};
							_warningInfo params ["_text","_icon","_color"];
							if(!_isActive) then {continue};
							private _ctrl = (findDisplay 312) ctrlCreate ["RscPicture",-1];
							_ctrl ctrlSetPosition [["X",46] call MAZ_EZM_fnc_convertToGUI_GRIDFormat, ["Y",-8] call MAZ_EZM_fnc_convertToGUI_GRIDFormat, ["W",1.5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat,["H",1.5] call MAZ_EZM_fnc_convertToGUI_GRIDFormat];
							_ctrl ctrlSetText _icon;
							_ctrl ctrlSetTooltip _text;
							_ctrl ctrlSetTextColor _color;
							_ctrl ctrlSetPositionY (["Y",-8 + (2 * _count)] call MAZ_EZM_fnc_convertToGUI_GRIDFormat);
							_ctrl ctrlCommit 0;
							_count = _count + 1;
							if(!isNil "MAZ_EZM_activeWarnings") then {
								MAZ_EZM_activeWarnings set [_forEachIndex,[_ctrl,_warningInfo,_isActive]];
							};
						}forEach MAZ_EZM_activeWarnings;
					};
					(findDisplay 312) setVariable ["MAZ_EZM_hideWarnings",false];
				};
				[] call MAZ_EZM_fnc_showAllWarnings;
				
				MAZ_EZM_fnc_hideAllWarnings = {
					if(count (uiNamespace getVariable ["MAZ_EZM_activeWarnings",[]]) < 0) exitWith {};
					if(isNull (findDisplay 312)) exitWith {};
					with uiNamespace do {
						if(isNil "MAZ_EZM_activeWarnings") exitWith {};
						{
							if(isNil "_x") then {continue};
							_x params ["_ctrl","_warningInfo","_isActive"];
							if(isNil "_ctrl") then {continue};
							_ctrl ctrlSetFade 1;
							_ctrl ctrlCommit 0.1;
						}forEach MAZ_EZM_activeWarnings;
					};
				};

				MAZ_EZM_fnc_unhideAllWarnings = {
					if(count (uiNamespace getVariable ["MAZ_EZM_activeWarnings",[]]) < 0) exitWith {};
					if(isNull (findDisplay 312)) exitWith {};
					with uiNamespace do {
						if(isNil "MAZ_EZM_activeWarnings") exitWith {};
						{
							if(isNil "_x") then {continue};
							_x params [["_ctrl", controlNull],"_warningInfo","_isActive"];
							if(isNull _ctrl) then {continue};
							_ctrl ctrlSetFade 0;
							_ctrl ctrlCommit 0.1;
						}forEach MAZ_EZM_activeWarnings;
					};
				};

				MAZ_EZM_fnc_detectRespawnsUnavailable = {
					with uiNamespace do {
						private _warningText = "";
						private _sideStrings = ["BLUFOR","OPFOR","INDEPENDENT","CIVILIAN"];
						{
							private _sideOf = _x;
							private _numPlayers = {side (group _x) == _sideOf} count allPlayers;
							if(_numPlayers <= 0) then {continue};

							private _respawnCountSide = count ([_sideOf] call BIS_fnc_getRespawnPositions);
							if(_respawnCountSide != 0) then {continue};

							_warningText = _warningText + "There is no respawn for " + (_sideStrings select _forEachIndex) + " players!\n";
						}forEach [west,east,independent,civilian];

						if(_warningText == "") exitWith {
							if(!isNil "MAZ_EZM_missingRespawnWarn") then {
								[MAZ_EZM_missingRespawnWarn] call MAZ_EZM_fnc_removeWarningElement;
								MAZ_EZM_missingRespawnWarn = nil;
							};
						};

						if(!isNil "MAZ_EZM_missingRespawnWarn") exitWith {
							private _currentWarnText = MAZ_EZM_activeWarnings select MAZ_EZM_missingRespawnWarn select 1 select 0;
							if(_currentWarnText != _warningText) then {
								[MAZ_EZM_missingRespawnWarn] call MAZ_EZM_fnc_removeWarningElement;
								MAZ_EZM_missingRespawnWarn = [_warningText] call MAZ_EZM_fnc_addWarningElement;
							};
						};

						MAZ_EZM_missingRespawnWarn = [_warningText] call MAZ_EZM_fnc_addWarningElement;
					};
				};

				MAZ_EZM_fnc_detectLowServerPerformance = {
					0=[] spawn {
						"MAZ_EZM_serverFPS"; "defined on server";
						waitUntil {uiSleep 0.1; !(missionNamespace getVariable ["MAZ_EZM_isPingingServerFPS",false])};
						private _fps = uiNamespace getVariable "MAZ_EZM_serverFPS";
						if(!isNil "MAZ_EZM_lowServerFPSWarn") then {
							[MAZ_EZM_lowServerFPSWarn] call MAZ_EZM_fnc_removeWarningElement;
							MAZ_EZM_lowServerFPSWarn = nil;
						};
						if(_fps < 30) then {
							private _warnText = format ["The server FPS is low! Current server FPS: %1",_fps];
							MAZ_EZM_lowServerFPSWarn = [_warnText,"a3\ui_f\data\gui\cfg\hints\fatigue_ca.paa",[0,0,0.8,1]] call MAZ_EZM_fnc_addWarningElement;
						};
					};
				};

				[] spawn {
					while {!isNull (findDisplay 312)} do {
						call MAZ_EZM_fnc_detectRespawnsUnavailable;
						"call MAZ_EZM_fnc_detectLowServerPerformance";
						sleep 5;
					};
				};

			comment "Define Trees";
			
				MAZ_UnitsTree_BLUFOR	 = (_display displayCtrl 270);
				MAZ_UnitsTree_OPFOR		 = (_display displayCtrl 271);
				MAZ_UnitsTree_INDEP		 = (_display displayCtrl 272);
				MAZ_UnitsTree_CIVILIAN	 = (_display displayCtrl 273);
				MAZ_UnitsTree_EMPTY      = (_display displayCtrl 274);
				MAZ_GroupsTree_BLUFOR	 = (_display displayCtrl 275);
				MAZ_GroupsTree_OPFOR	 = (_display displayCtrl 276);
				MAZ_GroupsTree_INDEP	 = (_display displayCtrl 277);
				MAZ_GroupsTree_CIVILIAN	 = (_display displayCtrl 278);
				MAZ_GroupsTree_EMPTY	 = (_display displayCtrl 279);
				MAZ_zeusModulesTree 	 = (_display displayCtrl 280);
				
				for '_n' from 0 to 32 do {
					uiNamespace getVariable "MAZ_UnitsTree_BLUFOR" tvCollapse [_n];
					uiNamespace getVariable "MAZ_UnitsTree_OPFOR" tvCollapse [_n];
					uiNamespace getVariable "MAZ_UnitsTree_INDEP" tvCollapse [_n];
					uiNamespace getVariable "MAZ_UnitsTree_CIVILIAN" tvCollapse [_n];
					uiNamespace getVariable "MAZ_UnitsTree_EMPTY" tvCollapse [_n];
					uiNamespace getVariable "MAZ_zeusModulesTree" tvCollapse [_n];
					comment "
						MAZ_GroupsTree_BLUFOR tvCollapse [_n];
						MAZ_GroupsTree_OPFOR tvCollapse [_n];
						MAZ_GroupsTree_INDEP tvCollapse [_n];
						MAZ_GroupsTree_CIVILIAN tvCollapse [_n];
					";
				};

				MAZ_zeusModulesTree ctrlSetTooltipColorBox [0,0,0,1];
				MAZ_zeusModulesTree ctrlSetTooltipColorShade [0.1,0.1,0.1,0.9];
				
				{
					_x ctrlAddEventhandler ["TreeSelChanged",{
						params ["_control","_path"];
						with uiNamespace do {
							if (_path isEqualTo []) exitWith {};
							MAZ_EZM_SelectionPath = _path;
						};
					}];
				} forEach [MAZ_UnitsTree_BLUFOR,MAZ_UnitsTree_OPFOR,MAZ_UnitsTree_INDEP,MAZ_UnitsTree_CIVILIAN,MAZ_UnitsTree_EMPTY,MAZ_zeusModulesTree];

			comment "Add Divider";

			[MAZ_zeusModulesTree,"------------------------------------------------------","",EZM_themeColor] call MAZ_EZM_fnc_zeusAddCategory;

				MAZ_EZMLabelTree = [MAZ_zeusModulesTree,"Enhanced Zeus Modules",'\a3\ui_f_curator\Data\Displays\RscDisplayCurator\modeModules_ca.paa',EZM_themeColor] call MAZ_EZM_fnc_zeusAddCategory;
				MAZ_zeusModulesTree tvSetPictureRightColor [[MAZ_EZMLabelTree], EZM_themeColor];
				[
					MAZ_zeusModulesTree,
					MAZ_EZMLabelTree,
					format ["ZAM Edition - %1",missionNamespace getVariable ['MAZ_EZM_Version','']],
					"Framework originally created by: M9-SD & GamesByChris.\nExpanded and made public by: Expung3d to enhance Public Zeus.\n\nNeed help? Found a bug? Join our Discord:\nhttps://discord.gg/W4ew5HP",
					"MAZ_EZM_fnc_hiddenEasterEggModule"
				] call MAZ_EZM_fnc_zeusAddModule;
				
				[MAZ_zeusModulesTree,"------------------------------------------------------","",EZM_themeColor] call MAZ_EZM_fnc_zeusAddCategory;
			
			