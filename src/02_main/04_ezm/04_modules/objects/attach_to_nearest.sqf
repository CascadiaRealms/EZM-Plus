MAZ_EZM_fnc_attachToNearestModule = {
			params ["_entity"];
			if(_entity isEqualTo objNull) exitWith {["No object selected.","addItemFailed"] call MAZ_EZM_fnc_systemMessage;};

			private _nearestObjects = nearestObjects [_entity,["AllVehicles"],50];
			_nearestObjects = (_nearestObjects - [_entity]);
			_nearestObject = _nearestObjects select 0;
			if(isNil "_nearestObject") exitWith {["No near objects.","addItemFailed"] call MAZ_EZM_fnc_systemMessage;};
			[_entity,_nearestObject] call BIS_fnc_attachToRelative;
			["Object attached.","addItemOk"] call MAZ_EZM_fnc_systemMessage;
		};