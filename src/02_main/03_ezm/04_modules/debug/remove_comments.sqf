MAZ_EZM_fnc_removeComments = {
			params ["_input"]; 
			private _strings = []; 
			private _start = -1; 
			
			while {_start = _input find "//"; _start > -1} do {
				_input select [0, _start] call {
					private _badQuotes = _this call { 
						private _qtsGood = []; 
						private _qtsInfo = []; 
						private _arr = toArray _this; 
						
						{ 
							_qtsGood pushBack ((count _arr - count (_arr - [_x])) % 2 == 0); 
							_qtsInfo pushBack [_this find toString [_x], _x]; 
						}forEach [34, 39]; 
							
						if (_qtsGood isEqualTo [true, true]) exitWith {0}; 
							
						_qtsInfo sort true; 
						_qtsInfo select 0 select 1 
					}; 
				
					if (_badQuotes > 0) exitWith {  
						_last = _input select [_start] find toString [_badQuotes]; 
							
						if (_last < 0) exitWith  
						{ 
							_strings = [_input]; 
							_input = ""; 
						}; 
							
						_last = _start + _last + 1; 
						_strings pushBack (_input select [0, _last]); 
						
						_input = _input select [_last]; 
					}; 
				
					_strings pushBack _this; 
					_input = _input select [_start]; 
					private _end = _input find toString [10]; 
					if (_end < 0) exitWith {_input = ""}; 
					_input = _input select [_end + 1]; 
				}; 
			}; 
			
			_input = (_strings joinString "") + _input; 
			_input 
		};