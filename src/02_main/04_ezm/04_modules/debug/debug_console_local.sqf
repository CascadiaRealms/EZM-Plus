MAZ_EZM_fnc_debugConsoleLocalModule = {
			params ["_entity"];
			disableSerialization;
			createDialog "RscDisplayEmpty";
			private _display = findDisplay -1;
			private _debug = _display ctrlCreate ["RscDebugConsole",-1];
			_debug ctrlSetPosition [0.17,0.0599999,0.66,1]; 
			_display setVariable ["MAZ_EZM_debugTarget",_entity];


			_RSCDEBUGCONSOLE_LINK = _display ctrlCreate ["RscHTML", -1, _debug]; 
			_RSCDEBUGCONSOLE_LINK htmlLoad (["\A3\Ui_f\data\html\RscDebugConsole.html", "\A3\Ui_f\data\html\RscDebugConsoleCDC.html"] select (!isNull getMissionConfig "CfgDisabledCommands" && {count getMissionConfig "CfgDisabledCommands" > 0})); 
			_RSCDEBUGCONSOLE_LINK ctrlSetPosition [0.21,0,0.45,0.04]; 
			_RSCDEBUGCONSOLE_LINK ctrlSetText ""; 
			_RSCDEBUGCONSOLE_LINK ctrlSetBackgroundColor [0,0,0,0]; 
			_RSCDEBUGCONSOLE_LINK ctrlSetTextColor [1,1,1,1]; 
			_RSCDEBUGCONSOLE_LINK ctrlCommit 0; 

			_RSCDEBUGCONSOLE_EXPRESSION = _display displayCtrl 12284; 
			_RSCDEBUGCONSOLE_EXPRESSION ctrlSetText (profileNamespace getVariable ["RscDebugConsole_expression", ""]); 
			_RSCDEBUGCONSOLE_EXPRESSION ctrlAddEventHandler ["KeyDown", { 
				params ["_displayOrControl", "_key", "_shift", "_ctrl", "_alt"]; 
				[_displayOrControl] call MAZ_EZM_fnc_saveExpression; 
			}]; 
			_RSCDEBUGCONSOLE_EXPRESSION ctrlCommit 0; 

			_RSCDEBUGCONSOLE_BUTTONCODEPERFORMANCE = _display displayCtrl 13284; 
			_RSCDEBUGCONSOLE_BUTTONCODEPERFORMANCE ctrlAddEventHandler ["ButtonClick", { 
				_input = [(ctrlText ((ctrlParent (_this select 0)) displayCtrl 12284))] call MAZ_EZM_fnc_removeComments; 
				
				[_input, nil, nil, (ctrlParent (_this select 0))] spawn BIS_fnc_codePerformance; 
				[(ctrlParent (_this select 0)) displayCtrl 12284] call MAZ_EZM_fnc_saveExpression; 
				[(ctrlParent (_this select 0)), 3] call MAZ_EZM_fnc_expressionResult; 
			}]; 
			_RSCDEBUGCONSOLE_BUTTONCODEPERFORMANCE ctrlCommit 0; 
				
			_RSCDEBUGCONSOLE_BUTTONEXECUTESERVER = _display displayCtrl 13286; 
			_RSCDEBUGCONSOLE_BUTTONEXECUTESERVER ctrlAddEventHandler ["ButtonClick", { 
				private _debug = ctrlParent (_this select 0);
				private _target = _debug getVariable ["MAZ_EZM_debugTarget",objNull];
				_input = [(ctrlText ((ctrlParent (_this select 0)) displayCtrl 12284))] call MAZ_EZM_fnc_removeComments; 
				_input = format ["this = _this select 0; %1",_input];
				
				[[2, compile _input,_target],{[(_this select 0), (_this select 1), (_this select 2)] call MAZ_EZM_fnc_executeExpression;}] remoteExec ['call',2]; 
				[(ctrlParent (_this select 0)) displayCtrl 12284] call MAZ_EZM_fnc_saveExpression; 
				[(ctrlParent (_this select 0)), 2] call MAZ_EZM_fnc_expressionResult; 
			}]; 
			_RSCDEBUGCONSOLE_BUTTONEXECUTESERVER ctrlCommit 0; 
				
			_RSCDEBUGCONSOLE_BUTTONEXECUTEALL = _display displayCtrl 13285; 
			_RSCDEBUGCONSOLE_BUTTONEXECUTEALL ctrlAddEventHandler ["ButtonClick", { 
				private _debug = ctrlParent (_this select 0);
				private _target = _debug getVariable ["MAZ_EZM_debugTarget",objNull];
				_input = [(ctrlText ((ctrlParent (_this select 0)) displayCtrl 12284))] call MAZ_EZM_fnc_removeComments; 
				_input = format ["this = _this select 0; %1",_input];
				
				[[1, compile _input,_target],{[(_this select 0), (_this select 1), (_this select 2)] call MAZ_EZM_fnc_executeExpression;}] remoteExec ['call',2]; 
				[(ctrlParent (_this select 0)) displayCtrl 12284] call MAZ_EZM_fnc_saveExpression; 
				[(ctrlParent (_this select 0)), 1] call MAZ_EZM_fnc_expressionResult; 
			}]; 
			_RSCDEBUGCONSOLE_BUTTONEXECUTEALL ctrlCommit 0; 
				
			_RSCDEBUGCONSOLE_BUTTONEXECUTELOCAL = _display displayCtrl 13484; 
			_RSCDEBUGCONSOLE_BUTTONEXECUTELOCAL ctrlAddEventHandler ["ButtonClick", { 
				private _debug = ctrlParent (_this select 0);
				private _target = _debug getVariable ["MAZ_EZM_debugTarget",objNull];
				_input = [(ctrlText ((ctrlParent (_this select 0)) displayCtrl 12284))] call MAZ_EZM_fnc_removeComments; 
				_input = format ["this = _this select 0; %1",_input];

				private _return = [_target] call (compile _input);
				[(ctrlParent (_this select 0)) displayCtrl 12284] call MAZ_EZM_fnc_saveExpression; 
				(parsingNamespace getVariable ["BIS_RscDebugConsoleExpressionResultCtrl", controlNull]) ctrlSetText (str _return); 
			}]; 
			_RSCDEBUGCONSOLE_BUTTONEXECUTELOCAL ctrlCommit 0; 
				
				
			_RSCDEBUGCONSOLE_BUTTONSPECTATORCAMERA = _display displayCtrl 13287; 
			_RSCDEBUGCONSOLE_BUTTONSPECTATORCAMERA ctrlAddEventHandler ["ButtonClick", 
			{ 
				if (["IsInitialized"] call BIS_fnc_EGSpectator) exitWith  
				{ 
					["Terminate"] call BIS_fnc_EGSpectator; 
					ctrlParent (_this select 0) closeDisplay 2; 
				}; 
				
				["Initialize", [player, nil, true, true]] spawn BIS_fnc_EGSpectator; 
			}]; 
			_RSCDEBUGCONSOLE_BUTTONSPECTATORCAMERA ctrlCommit 0; 
				
			_RSCDEBUGCONSOLE_BUTTONSPLENDIDCAMERA = _display displayCtrl 13288; 
			_RSCDEBUGCONSOLE_BUTTONSPLENDIDCAMERA ctrlAddEventHandler ["ButtonClick", {[] spawn (uiNamespace getVariable "BIS_fnc_camera")}]; 
			_RSCDEBUGCONSOLE_BUTTONSPLENDIDCAMERA ctrlCommit 0; 
				
			_RSCDEBUGCONSOLE_BUTTONCANCEL = _display ctrlCreate ["RscButtonMenu", -1, _debug]; 
			_RSCDEBUGCONSOLE_BUTTONCANCEL ctrlSetPosition [0,0.864,0.222,0.04]; 
			_RSCDEBUGCONSOLE_BUTTONCANCEL ctrlSetText "CANCEL"; 
			_RSCDEBUGCONSOLE_BUTTONCANCEL ctrlSetBackgroundColor [0,0,0,0.8]; 
			_RSCDEBUGCONSOLE_BUTTONCANCEL ctrlSetTextColor [1,1,1,1]; 
			_RSCDEBUGCONSOLE_BUTTONCANCEL ctrlAddEventHandler ["ButtonClick", {ctrlParent (_this select 0) closeDisplay 2}]; 
			_RSCDEBUGCONSOLE_BUTTONCANCEL ctrlCommit 0; 
				
			_RSCDEBUGCONSOLE_BUTTONFUNCTIONS = _display displayCtrl 13289; 
			_RSCDEBUGCONSOLE_BUTTONFUNCTIONS ctrlAddEventHandler ["ButtonClick", {[ctrlParent (_this select 0)] spawn (uiNamespace getVariable "BIS_fnc_help")}]; 
			_RSCDEBUGCONSOLE_BUTTONFUNCTIONS ctrlCommit 0; 
				
			_RSCDEBUGCONSOLE_BUTTONCONFIG = _display displayCtrl 13290; 
			_RSCDEBUGCONSOLE_BUTTONCONFIG ctrlAddEventHandler ["ButtonClick", {[ctrlParent (_this select 0)] spawn (uiNamespace getVariable "BIS_fnc_configViewer")}]; 
			_RSCDEBUGCONSOLE_BUTTONCONFIG ctrlCommit 0; 
				
			_RSCDEBUGCONSOLE_BUTTONANIMATIONS = _display displayCtrl 13291; 
			_RSCDEBUGCONSOLE_BUTTONANIMATIONS ctrlAddEventHandler ["ButtonClick", {[] spawn (uiNamespace getVariable "BIS_fnc_animViewer")}]; 
			_RSCDEBUGCONSOLE_BUTTONANIMATIONS ctrlCommit 0; 
				
			_RSCDEBUGCONSOLE_BUTTONGUI = _display displayCtrl 13292; 
			_RSCDEBUGCONSOLE_BUTTONGUI ctrlAddEventHandler ["ButtonClick", {[] spawn BIS_fnc_guiEditor; ctrlParent (_this select 0) closeDisplay 2}]; 
			_RSCDEBUGCONSOLE_BUTTONGUI ctrlCommit 0; 
				
				
			{ 
				private _value = profileNamespace getVariable ["RscDebugConsole_watch" + str (_forEachIndex + 1), [true, "", false]]; 
				if !(_value isEqualTypeParams [true, ""]) then {_value = [true, _value, false]};  
				_x ctrlSetText (_value select 1); 
				if (_value select 2) then {ctrlSetFocus _x}; 
				_x setVariable ["RscDebugConsole_watchStatus", _value]; 

				_x ctrlAddEventHandler ["KeyDown", { 
					params ["_displayOrControl", "_key", "_shift", "_ctrl", "_alt"]; 
					private _value = _displayOrControl getVariable ["RscDebugConsole_watchStatus", [true, ""]]; 
					if (_value select 1 isEqualTo "") then {_value set [0, true]}; 
					_value set [1, ctrlText _displayOrControl]; 
					_value set [2, _displayOrControl getVariable ["RscDebugConsole_watchPaused", false]]; 
					_ctrlIndex = 0; 
					switch (ctrlIDC _displayOrControl) do { 
						case 12285: {_ctrlIndex = 0;}; 
						case 12287: {_ctrlIndex = 1;}; 
						case 12289: {_ctrlIndex = 2;}; 
						case 12291: {_ctrlIndex = 3;}; 
					}; 
					profileNamespace setVariable ["RscDebugConsole_watch" + str (_ctrlIndex + 1), _value]; 
				}]; 

				_x ctrlCommit 0; 
			} 
			forEach [_display displayCtrl 12285, _display displayCtrl 12287, _display displayCtrl 12289, _display displayCtrl 12291]; 
			
			_display setVariable ["RscDebugConsole_fnc_watchField", { 
				params ["_input", "_output"];  
			
				_this = ctrlText _input;  
				if (_this isEqualTo "") exitWith {  
					_input ctrlSetBackgroundColor [0,0,0,0];  
					_output ctrlSetText ""; 
				};  
				
				if (_input getVariable ["RscDebugConsole_watchPaused", false]) exitWith { 
					_input ctrlSetBackgroundColor [0.5,0.1,0,0.8];  
					_output ctrlSetText ""; 
				};  
				
				_status = _input getVariable "RscDebugConsole_watchStatus"; 
				if (!(_status select 0) && {_status select 1 isEqualTo _this}) exitWith {_input ctrlSetBackgroundColor [0.5,0.1,0,0.8]}; 
				
				_duration = diag_tickTime;  
				_duration = compile _this call {   
					_output ctrlSetText str ([nil] apply {private ["_input", "_output", "_status", "_duration"]; [] call _this} param [0, text ""]);  
					diag_tickTime - _duration 
				}; 
			
				if (_duration < 0.003) exitWith {  
					_input ctrlSetBackgroundColor [0,0,0,0];  
					_status set [0, true];  
				};  
				
				_input ctrlSetBackgroundColor [0.8,0.4,0,0.5];  
				_status set [0, false];  
				
				if (_duration > 0.1) exitWith {_status set [1, _this]};  
				
				_status set [1, ""]; 
			}]; 
			
			_display displayAddEventHandler ["MouseMoving", {[_this select 0 displayCtrl 12285, _this select 0 displayCtrl 12286] call (_this select 0 getVariable "RscDebugConsole_fnc_watchField")}]; 
			_display displayAddEventHandler ["MouseHolding", {[_this select 0 displayCtrl 12285, _this select 0 displayCtrl 12286] call (_this select 0 getVariable "RscDebugConsole_fnc_watchField")}]; 
			_display displayAddEventHandler ["MouseMoving", {[_this select 0 displayCtrl 12287, _this select 0 displayCtrl 12288] call (_this select 0 getVariable "RscDebugConsole_fnc_watchField")}]; 
			_display displayAddEventHandler ["MouseHolding", {[_this select 0 displayCtrl 12287, _this select 0 displayCtrl 12288] call (_this select 0 getVariable "RscDebugConsole_fnc_watchField")}]; 
			_display displayAddEventHandler ["MouseMoving", {[_this select 0 displayCtrl 12289, _this select 0 displayCtrl 12290] call (_this select 0 getVariable "RscDebugConsole_fnc_watchField")}]; 
			_display displayAddEventHandler ["MouseHolding", {[_this select 0 displayCtrl 12289, _this select 0 displayCtrl 12290] call (_this select 0 getVariable "RscDebugConsole_fnc_watchField")}]; 
			_display displayAddEventHandler ["MouseMoving", {[_this select 0 displayCtrl 12291, _this select 0 displayCtrl 12293] call (_this select 0 getVariable "RscDebugConsole_fnc_watchField")}]; 
			_display displayAddEventHandler ["MouseHolding", {[_this select 0 displayCtrl 12291, _this select 0 displayCtrl 12293] call (_this select 0 getVariable "RscDebugConsole_fnc_watchField")}]; 
				
			_display displayAddEventHandler ["MouseButtonDown", {ctrlSetFocus (_this select 0 displayCtrl 12284)}]; 
				
			_display displayAddEventHandler ["KeyDown", { 
				if (_this select 1 in [0x1C, 0x9C]) then { 
					_parentDisplay = _this select 0; 
					if ({_x getVariable ["RscDebugConsole_watchPaused", false]} count [_parentDisplay displayCtrl 12285, _parentDisplay displayCtrl 12287,_parentDisplay displayCtrl 12289, _parentDisplay displayCtrl 12291] > 0) then { 
						ctrlSetFocus (_parentDisplay displayCtrl 12284); 
						true 
					}; 
				}; 
			}]; 
				
			_display displayAddEventHandler ["KeyDown", { 
				params ["_parentDisplay", "_key"]; 
				if (_key in [0xC9, 0xD1]) then { 
					_expressionHistory = profileNamespace getVariable "RscDebugConsole_expressionHistory"; 
					_expressionResultHistory = parsingNamespace getVariable "BIS_RscDebugConsoleExpressionResultHistory"; 
					
					_last = count _expressionHistory - 1; 
					
					_index = 0 max ((_parentDisplay getVariable "RscDebugConsole_expressionHistory_index") + ([1, -1] select (_key == 0xD1))) min _last; 
					_parentDisplay setVariable ["RscDebugConsole_expressionHistory_index", _index]; 
					
					_expressionCtrl = _parentDisplay displayCtrl 12284; 
					_expressionCtrl ctrlSetText (_expressionHistory select _index); 
					
					if (ctrlEnabled _expressionCtrl) then { 
						_lastResult = ctrlText (parsingNamespace getVariable ["BIS_RscDebugConsoleExpressionResultCtrl", controlNull]); 
						_expressionResultHistory set [0, _lastResult]; 
						if (_lastResult isEqualTo "") then { _expressionResultHistory set [1, [0,0,0,0]] }; 
					}; 
					
					if (_index < _last) then {  
						_expressionCtrl ctrlEnable false; 
						(parsingNamespace getVariable ["BIS_RscDebugConsoleExpressionResultCtrl", controlNull]) ctrlEnable false; 
						(parsingNamespace getVariable ["BIS_RscDebugConsoleExpressionResultCtrl", controlNull]) ctrlSetText ""; 
						
						_parentDisplay displayCtrl 13191 ctrlSetBackgroundColor [0,0,0,0];  
						_parentDisplay getVariable "RscDebugConsole_state" params ["_stateServer", "_stateGlobal", "_stateLocal"]; 
						
						_stateServer select 0 ctrlSetText ""; 
						_stateGlobal select 0 ctrlSetText ""; 
					
						if (isMultiplayer) then { 
							_stateServer select 0 ctrlenable false; 
							_stateGlobal select 0 ctrlenable false; 
						}; 
						
						_stateLocal select 0 ctrlSetText format ["%1 %2", toUpper localize "str_usract_menu_select", (count _expressionHistory) - 1 - _index]; 
						ctrlSetFocus (_stateLocal select 0); 
					} else { 
						_expressionCtrl ctrlEnable true; 
						(parsingNamespace getVariable ["BIS_RscDebugConsoleExpressionResultCtrl", controlNull]) ctrlEnable true; 
						(parsingNamespace getVariable ["BIS_RscDebugConsoleExpressionResultCtrl", controlNull]) ctrlSetText (_expressionResultHistory select 0); 
						_parentDisplay displayCtrl 13191 ctrlSetBackgroundColor (_expressionResultHistory select 1); 
						
						{  
							_x select 0 ctrlSetText (_x select 1); 
							if (isMultiplayer) then { _x select 0 ctrlEnable true }; 
						} forEach (_parentDisplay getVariable "RscDebugConsole_state"); 
						
						ctrlSetFocus _expressionCtrl; 
					}; 
					
					true 
				}; 
			}]; 
				
				
			_debug ctrlCommit 0; 
			saveProfileNamespace;  
			showChat true; 
		};
