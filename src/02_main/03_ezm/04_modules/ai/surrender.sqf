MAZ_EZM_fnc_toggleSurrenderModule = {
			params ["_entity"];
			if(isNull _entity || !((typeOf _entity) isKindOf "Man")) exitWith {["Unit is not suitable.","addItemFailed"] call MAZ_EZM_fnc_systemMessage;};

			private _isSurrendered = _entity getVariable ['EZM_isSurrendered',false];
			if(_isSurrendered) then {
				[_entity,"AmovPercMstpSnonWnonDnon"] remoteExec ["switchMove"];
				[_entity,false] remoteExec ["setCaptive"];
				_entity setVariable ["EZM_isSurrendered",false,true];
				
				["Unit is no longer surrendered.","addItemOk"] call MAZ_EZM_fnc_systemMessage;
			} else {
				_entity action ["Surrender",_entity];
				[_entity,true] remoteExec ["setCaptive"];
				_entity setVariable ["EZM_isSurrendered",true,true];
				[_entity] spawn {
					params ["_entity"];
					private _weapon = currentWeapon _entity; 
					if(_weapon isEqualTo "") exitWith{};
					[_entity, _weapon] remoteExec ["removeWeapon"];
					sleep 0.1;
					private _weaponHolder = "WeaponHolderSimulated" createVehicle [0,0,0];
					_weaponHolder addWeaponCargoGlobal [_weapon,1];
					_weaponHolder setPos (_entity modelToWorld [0,.2,1.2]);
					_weaponHolder disableCollisionWith _entity;
					private _dir = random(360);
					private _speed = 1.5;
					_weaponHolder setVelocity [_speed * sin(_dir), _speed * cos(_dir),4]; 
				};

				["Unit is now surrendered.","addItemOk"] call MAZ_EZM_fnc_systemMessage;
			};
		};