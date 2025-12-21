		MAZ_EZM_fnc_createCarrierModule = {
			params ["_entity"];
			private _data = if(_entity isEqualTo objNull) then {
				[objNull,[true] call MAZ_EZM_fnc_getScreenPosition];
			} else {
				if !(_entity isKindOf "Ship") exitWith {["Object is not a boat!","addItemFailed"] call MAZ_EZM_fnc_systemMessage;};
				[_entity,nil];
			};
			_data spawn {
				params ["_object","_pos"];
				private _dir = if(!isNull _object) then {
					_pos = getPosATL _object;
					((getDir _object)+180);
				} else {
					_pos = ASLtoATL _pos;
					180;
				};
				private _carrier = createVehicle ["Land_Carrier_01_base_F",[0,0,0],[],0,"CAN_COLLIDE"];
				_carrier setPosATL _pos;
				_carrier setVectorDirAndUp [[sin _dir, cos _dir, 0], [0,0,1]];
				sleep 0.5;
				[_carrier] remoteExec ["BIS_fnc_Carrier01Init", 0, _carrier];
				{deleteVehicle _x} forEach (nearestObjects [[0,0,0], ["Land_Carrier_01_hull_Base_F","DynamicAirport_01_F"], 300, true]);
				if(!isNull _object) then {
					{_object deleteVehicleCrew _x} forEach crew _object;
					sleep 0.5;
					deleteVehicle _object;
				};
			};
			["USS Freedom Carrier deployed!","addItemOk"] call MAZ_EZM_fnc_systemMessage;
		};
		MAZ_EZM_fnc_deleteAllCarriersModule = {
			private _data = (getArray (configfile >> 'CfgVehicles' >> 'Land_Carrier_01_base_F' >> 'multiStructureParts'));
			{
				_x params ['_class','_pos'];
				{
					deleteVehicle _x;
				} foreach allMissionObjects _class;
			} foreach _data;

			["All Aircraft Carriers are deleted.","addItemOk"] call MAZ_EZM_fnc_systemMessage;
		};