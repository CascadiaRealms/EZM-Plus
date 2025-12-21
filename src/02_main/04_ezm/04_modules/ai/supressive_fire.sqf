MAZ_EZM_fnc_suppressiveFireModule = {
			params ["_entity"];
		
			if (!(_entity isKindOf "CAManBase") && !(_entity isKindOf "AllVehicles")) exitWith {["This must be done to a vehicle or a unit!","addItemFailed"] call MAZ_EZM_fnc_systemMessage;};
			if(_entity isKindOf "AllVehicles" && isNull (gunner _entity)) exitWith {["This vehicle has no gunner!","addItemFailed"] call MAZ_EZM_fnc_systemMessage;};
			if (_entity getVariable ["MAZ_EZM_isSuppressing", false]) exitwith {["Unit is already suppressing!", "addItemFailed"] call MAZ_EZM_fnc_systemMessage;};

			["Suppressive fire", [
				[
					"SLIDER",
					"Duration of Suppress",
					[5, 60, 10]
				]
			], {
				params ["_values", "_entity", "_display"];
				_values params ["_duration"];
				_display closeDisplay 1;
				
				["Position to Suppress", {
					params ["_objects", "_position", "_args", "_shift", "_ctrl", "_alt"];
					_args params ["_entity", "_duration"];
					
					private _target = (creategroup [east, true]) createUnit ["O_Soldier_unarmed_F", _position, [], 0, "CAN_COLLIDE"];
					_target disableAI "Move";
					_target allowDamage false;
					[_target,true] remoteExec ["hideObjectGlobal",2];
					_target setUnitPos "UP";
					_target addRating -100000000000;
					
					[_entity, _duration, _target] spawn {
						params ["_entity", "_duration", "_target"];
						_entity setVariable ["MAZ_EZM_isSuppressing", true, true];
						_entity doSuppressiveFire _target;
						_entity suppressFor _duration;
						private _behaviorPrior = behaviour _entity;
						_entity setBehaviour "COMBAT";
						_entity doWatch _target;

						sleep 3;

						private _timeToStop = time + _duration + 1;

						
						private _currentWeapon = currentWeapon _entity;
						private _weaponModes = getArray (configFile >> "Cfgweapons" >> _currentWeapon >> "modes");
						private _weaponMode = if("FullAuto" in _weaponModes) then {"FullAuto"} else {"Single"};
						private _burstLength = 20;
						private _reloadTime = getNumber (configFile >> "CfgWeapons" >> _currentWeapon >> _weaponMode >> "realodTime");
						while {time < _timeToStop} do {
							if !(_entity isKindOf "CAManBase") then {
								_entity action ["useWeapon",_entity,gunner _entity,0];
								sleep (0.5 + random 1.5);
								continue;
							};

							private _roundsNumber = round (3 + random 2);
							for "_i" from 0 to _roundsNumber do {
								_entity forceWeaponFire [_currentWeapon, _weaponMode];
								sleep _reloadTime;
							};
							_entity setVehicleAmmo 1;
							sleep (0.5 + random 1.5);
						};
						
						_entity doWatch objNull;
						deletevehicle _target;
						_entity setBehaviour _behaviorPrior;
						_entity setVariable ["MAZ_EZM_isSuppressing", false, true];
					};
				}, _entity, [_entity, _duration], "a3\ui_f\data\igui\cfg\cursors\attack_ca.paa", 45] call MAZ_EZM_fnc_selectSecondaryposition;
			}, {
				params ["_values", "_args", "_display"];
				_display closeDisplay 2;
			}, _entity] call MAZ_EZM_fnc_createdialog;
		};