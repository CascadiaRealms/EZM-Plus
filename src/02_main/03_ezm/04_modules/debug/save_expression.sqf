MAZ_EZM_fnc_saveExpression = { 
			params ["_expressionCtrl"]; 
			private _currentExpression = ctrlText _expressionCtrl; 
			private _lastExpression = profileNamespace getVariable ["RscDebugConsole_expression", ""]; 
			private _expressionHistory = profileNamespace getVariable ["RscDebugConsole_expressionHistory", []]; 
			
			if (_lastExpression isEqualTo "" || _currentExpression isEqualTo _lastExpression) then { 
				_expressionHistory set [count _expressionHistory - 1, _currentExpression]; 
			} else { 
				if (_expressionHistory pushBack _currentExpression >= 10) then { _expressionHistory deleteRange [0, count _expressionHistory - 10] }; 
			}; 
			
			profileNamespace setVariable ["RscDebugConsole_expression", _currentExpression]; 
			_parentDisplay setVariable ["RscDebugConsole_expressionHistory_index", count _expressionHistory - 1]; 
		}; 