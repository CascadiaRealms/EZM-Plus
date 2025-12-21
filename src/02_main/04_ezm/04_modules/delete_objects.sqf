MAZ_EZM_fnc_deleteObjectsServer = {
			params ["_objects"];
			[[_objects], {
				params ["_objects"];
				deleteVehicle _objects;
			}] remoteExec ["spawn",2];
		};