MAZ_EZM_fnc_addObjectToInterface = {
	params [
		["_objects",[],[[],objNull]],
		["_curators",allCurators]
	];
	if(_objects isEqualType objNull) then {
		_objects = [_objects];
	};
	if(!(_curators isEqualType [])) then {
		_curators = [_curators];
	};
	if(("CuratorModeratorRights" call BIS_fnc_getParamValue) == -1 && _curators isEqualTo allCurators) then {
		_curators = [getAssignedCuratorLogic player];
	};
	[[_objects,_curators],{
		params ["_objects","_curators"];
		{
			_x addCuratorEditableObjects [_objects,true];
		} foreach _curators;
	}] remoteExec ["Spawn",2];
};

MAZ_EZM_fnc_removeObjectFromInterface =  {
	params [
		["_objects",[],[[],objNull]],
		["_curators",allCurators]
	];
	if(_objects isEqualType objNull) then {
		_objects = [_objects];
	};
	if(!(_curators isEqualType [])) then {
		_curators = [_curators];
	};
	if(("CuratorModeratorRights" call BIS_fnc_getParamValue) == -1 && _curators isEqualTo allCurators) then {
		_curators = [getAssignedCuratorLogic player];
	};
	[[_objects,_curators],{
		params ["_objects","_curators"];
		{
			_x removeCuratorEditableObjects [_objects,true];
		} foreach _curators;
	}] remoteExec ["Spawn",2];
};

MAZ_EZM_fnc_deleteAttachedWhenKilled = {
	params ["_object"];
	_object addEventhandler ["Killed", {
		params ["_unit", "_killer", "_instigator", "_useEffects"];
		[_unit] call MAZ_EZM_fnc_deleteAttached;
	}];
};

MAZ_EZM_fnc_deleteAttachedWhenDeleted = {
	params ["_object"];
	_object addEventhandler ["Deleted", {
		params ["_object"];
		[_object] call MAZ_EZM_fnc_deleteAttached;
	}];
};

MAZ_EZM_fnc_deleteAttached = {
	params ["_object"];
	{
		detach _x;
		{
			deleteVehicle _x;
		}forEach (crew _x);
		[_x] call MAZ_EZM_fnc_deleteAttached;
		deleteVehicle _x;
	}forEach (attachedObjects _object);
};

MAZ_EZM_fnc_ignoreWhenCleaning = {
	params ["_object"];
	_object setVariable ["MAZ_EZM_fnc_doNotRemove",true,true];
};

MAZ_EZM_fnc_cleanerWaitTilNoPlayers = {
	params ["_object"];
	if(!MAZ_EZM_enableCleaner) exitWith {};
	[[_object], {
		private _fnc_cleaner = {
			params ["_object"];
			waitUntil {uiSleep 0.1; !alive _object};
			waitUntil {
				(count (allPlayers select { (getPosATL _x) distance _object < 1600 })) == 0 ||
				isNull _object
			};
			if(!isNull _object) then {
				sleep 300;
				"After 5 minutes check if players are still near, if they are, call function again, else delete.";
				if(count (allPlayers select { (getPosATL _x) distance _object < 1600 }) != 0) exitWith {[_object] spawn _fnc_cleaner;};
				deleteVehicle _object;
			};
		};
		_this spawn _fnc_cleaner;
	}] remoteExec ["spawn",2];
};