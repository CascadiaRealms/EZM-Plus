MAZ_EZM_fnc_interiorTypeInArray = {
			params ["_type","_array"];
			private _return = false;
			{
				if(_type isKindOf _x) exitWith {_return = true;};
			}forEach _array;
			_return
		};