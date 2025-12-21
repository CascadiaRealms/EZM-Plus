
		MAZ_EZM_fnc_getBaseType = {
			params ["_building"];
			private _type = typeOf _building;
			private _parents = [configFile >> "CfgVehicles" >> _type, true] call BIS_fnc_returnParents;
			private _baseType = _type;
			{
				if("land_u" in (toLower _baseType) && ("land_i" in (toLower _x))) exitWith {}; 
				if("house_small_f" in (toLower _x)) exitWith {};
				if("house_f" in (toLower _x)) exitWith {};
				_baseType = _x;
			}forEach _parents;
			_baseType
		};