MAZ_EZM_fnc_getIfObjectIsVanilla = {
			params ["_object",["_className",""]];
			if(_className == "") then {
				_className = typeOf _object;
			};
			private _isVanilla = true;
			private _addon = (unitAddons _className) # 0;
			private _author = getText (configfile >> "CfgPatches" >> _addon >> "author");
			if(_author != "" && {_author != "Bohemia Interactive"}) exitWith {false};
			private _required = getArray (configFile >> "CfgPatches" >> _addon >> "requiredAddons");
			while {count (_required) != 0} do {
				_addon = _required # 0;
				_author = getText (configfile >> "CfgPatches" >> _addon >> "author");
				if(_author != "" && {_author != "Bohemia Interactive"}) exitWith {
					_isVanilla = false;
				};
				_required = getArray (configFile >> "CfgPatches" >> _addon >> "requiredAddons");
			};
			_isVanilla;
		};
