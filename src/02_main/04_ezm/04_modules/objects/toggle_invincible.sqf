MAZ_EZM_fnc_toggleInvincibleModule = {
			params ["_entity"];
			if(_entity isEqualTo objNull) exitWith {["No object selected.","addItemFailed"] call MAZ_EZM_fnc_systemMessage;};

			private _god = isDamageAllowed _entity;
			[_entity,!_god] remoteExec ["allowDamage"];
			[["Object is god moded", "Object is no longer god moded."] select !_god,"addItemOk"] call MAZ_EZM_fnc_systemMessage;
		};