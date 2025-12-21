MAZ_EZM_fnc_toggleHideObjectModule = {
			params ["_entity"];
			if(_entity isEqualTo objNull) exitWith {["No object selected.","addItemFailed"] call MAZ_EZM_fnc_systemMessage;};

			private _hidden = isObjectHidden _entity;
			[_entity,!_hidden] remoteExec ["hideObjectGlobal",2];
			[["Object is hidden.","Object is shown."] select _hidden,"addItemOk"] call MAZ_EZM_fnc_systemMessage;
			
			private _objects = missionNamespace getVariable ["MAZ_EZM_hiddenObjects",[]];
			if(_hidden) then {
				_objects deleteAt (_objects find _entity);
			} else {
				_objects pushBack _entity;
			};
			missionNamespace setVariable ["MAZ_EZM_hiddenObjects",_objects,true];
		};