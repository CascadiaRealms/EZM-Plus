MAZ_EZM_fnc_expressionResult = { 
			params ["_parentDisplay","_buttonType"]; 
			_backgroundColor = [0,0,0,0]; 
			switch _buttonType do { 
				case 0: {_backgroundColor = [0,0,1,0.25];}; 
				case 1: {_backgroundColor = [1,0,0,0.25];}; 
				case 2: {_backgroundColor = [0,1,0,0.25];}; 
				case 3: {_backgroundColor = [0,0,0,0];}; 
			}; 
			(_parentDisplay displayCtrl 13191) ctrlSetBackgroundColor _backgroundColor; 
			(parsingNamespace getVariable ["BIS_RscDebugConsoleExpressionResultCtrl", controlNull]) ctrlSetText ((parsingNamespace getVariable "BIS_RscDebugConsoleExpressionResultHistory") select 0); 
		}; 