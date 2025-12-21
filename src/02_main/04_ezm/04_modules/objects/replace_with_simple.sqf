MAZ_EZM_fnc_replaceWithSimpleObject = {
			params ["_object"];
			if(isPlayer _object  || (typeOf _object) isKindOf "CAManBase") exitWith {["Not an object!","addItemFailed"] call MAZ_EZM_fnc_systemMessage;};
			private _typeOf = typeOf _object;
			private _objPos = getPosASL _object;
			private _vectorDir = vectorDir _object;
			private _vectorUp = vectorUp _object;

			deleteVehicle _object;
			private _newSimpleObj = createSimpleObject [_typeOf,_objPos];
			_newSimpleObj setVectorDirAndUp [_vectorDir,_vectorUp];
			private _logic = createVehicle ["Land_HelipadEmpty_F",_objPos,[],0,"CAN_COLLIDE"];
			[_logic] call MAZ_EZM_fnc_addObjectToInterface;
			[_newSimpleObj,_logic] call BIS_fnc_attachToRelative;
			[_newSimpleObj,_logic] spawn {
				params ["_newSimpleObj","_logic"];
				[[_newSimpleObj,_logic],{
					params ["_newSimpleObj","_logic"];
					waitUntil {isNull _logic};
					deleteVehicle _newSimpleObj;
				}] remoteExec ["spawn",2];
			};
			["Object replaced with simple object.","addItemOk"] call MAZ_EZM_fnc_systemMessage;
		};