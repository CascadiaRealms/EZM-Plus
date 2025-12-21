MAZ_EZM_fnc_makeHVTModule = {
			params ["_entity"];
			if(isNull _entity || !((typeOf _entity) isKindOf "Man")) exitWith {["Unit is not suitable.","addItemFailed"] call MAZ_EZM_fnc_systemMessage;};

			[[_entity],{
				params ["_nearestMan"];
				_nearestMan addEventHandler ["Killed",{
					params ["_unit", "_killer", "_instigator", "_useEffects"];
					["TaskSucceeded",["",format ["%1 was killed by %2",name _unit,name _killer]]] remoteExec ['BIS_fnc_showNotification'];
					remoteExec ["",_unit];
				}];
			}] remoteExec ["spawn",0,_entity];
			["HVT created, all players will be notified of their death.","addItemOk"] call MAZ_EZM_fnc_systemMessage;
		};