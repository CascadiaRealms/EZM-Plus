		MAZ_EZM_fnc_createDestroyerModule = {
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
				private _destroyer = createVehicle ["Land_Destroyer_01_base_F",[-300,-300,0],[],0,"CAN_COLLIDE"];
				_destroyer setPosATL _pos;
				_destroyer setVectorDirAndUp [[sin _dir, cos _dir, 0], [0,0,1]];
				sleep 0.5;
				[_destroyer] remoteExec ["BIS_fnc_Destroyer01Init", 0, _destroyer];
				{deleteVehicle _x} forEach (nearestObjects [[-300,-300,0], ["Land_Destroyer_01_Boat_Rack_01_Base_F","Land_Destroyer_01_hull_base_F","ShipFlag_US_F"], 300, true]);
				if(!isNull _object) then {
					{_object deleteVehicleCrew _x} forEach crew _object;
					sleep 0.1;
					deleteVehicle _object;
				};
			};
			["USS Liberty Destroyer deployed!","addItemOk"] call MAZ_EZM_fnc_systemMessage;
		};

		MAZ_EZM_fnc_deleteAllDestroyersModule = {
			private _data = (getArray (configfile >> 'CfgVehicles' >> 'Land_Destroyer_01_base_F' >> 'multiStructureParts'));
			{
				_x params ['_class','_pos'];
				{
					deleteVehicle _x;
				} foreach allMissionObjects _class;
			} foreach _data;

			["All Destroyers are deleted.","addItemOk"] call MAZ_EZM_fnc_systemMessage;
		};