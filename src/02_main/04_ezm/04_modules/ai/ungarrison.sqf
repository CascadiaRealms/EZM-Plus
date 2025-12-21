MAZ_EZM_fnc_unGarrisonModule = {
			params ["_entity"];
			if(isNull _entity || !((typeOf _entity) isKindOf "Man")) exitWith {["Unit is not suitable.","addItemFailed"] call MAZ_EZM_fnc_systemMessage;};
			[_entity] spawn {
				_object =  _this select 0;
				_groupUnderCursor = group _object;
				if (local (leader _groupUnderCursor)) then{
					private _outsidePos = [getPos (leader _groupUnderCursor), [3,15], 2, 0] call MAZ_EZM_fnc_getSafePos;
					{
						_x setUnitPos MAZ_EZM_stanceForAI;
						_x forceSpeed -1;
						_x doWatch objNull;
						_x doMove _outsidePos;
					} forEach(units _groupUnderCursor);
				};
				["AI are leaving the building.","addItemOk"] call MAZ_EZM_fnc_systemMessage;
			};
		};