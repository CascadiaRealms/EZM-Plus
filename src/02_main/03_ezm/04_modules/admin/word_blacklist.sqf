MAZ_EZM_fnc_checkForBlacklistedWords = {
			params [["_message","",[""]]];
			private _isFound = false;
			private _return = _message;
			private _badWords = [
				["n","i","g","g","e"] joinString "",
				["n","i","g","g","a"] joinString "",
				["n","i","g","g","e","r"] joinString "",
				["n","i","g","g"] joinString "",
				["f","u","c","k"] joinString "",
				["c","u","n","t"] joinString "",
				["f","a","g"] joinString "",
				["g","a","y"] joinString ""
			];

			{
				if(((toLower _return) find _x) != -1) then {
					_isFound = true;
					private _length = count _x;
					private _index = (toLower _return) find _x;
					_return = _return splitString "";
					for "_i" from _index to (_index + _length - 1) do {
						_return set [_i,"*"];
					};
					_return = _return joinString "";
				};
			}forEach _badWords;
			if(_isFound) then {
				_return = [_return] call MAZ_EZM_fnc_checkForBlacklistedWords;
			};
			_return
		};