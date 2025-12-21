MAZ_EZM_fnc_detachModule = {
			params ["_entity"];
			if(_entity isEqualTo objNull) exitWith {["No object selected.","addItemFailed"] call MAZ_EZM_fnc_systemMessage;};

			{detach _x;} foreach attachedObjects _entity;
			{detach _x;} foreach attachedObjects attachedTo _entity;

			["Object detached.","addItemOk"] call MAZ_EZM_fnc_systemMessage;
		};