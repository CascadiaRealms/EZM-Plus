MAZ_EZM_fnc_toggleSimulationModule = {
			params ["_entity"];
			if(_entity isEqualTo objNull) exitWith {["No object selected.","addItemFailed"] call MAZ_EZM_fnc_systemMessage;};

			private _simmed = simulationEnabled _entity;
			[_entity, !_simmed] remoteExec ["enableSimulationGlobal", 2];
			[["Object's simulation disabled.", "Object's simulation enabled."] select !_simmed,"addItemOk"] call MAZ_EZM_fnc_systemMessage;
		};