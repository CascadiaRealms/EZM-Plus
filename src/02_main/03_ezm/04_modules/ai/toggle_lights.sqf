		MAZ_EZM_fnc_toggleLightsModule = {
			params ["_entity"];
			[[],{
				{
					private _unit = _x;
					private _group = group _unit;
					private _vehicle = vehicle _unit;
					_group enableIRLasers true;
					_unit enableIRLasers true;
					_group enableGunLights "ForceOn";
					_unit enableGunLights "ForceOn";
					_vehicle setPilotLight true;
					_vehicle setCollisionLight true;
					
					_unit action ["IRLaserOn", _unit];
					_unit action ["GunLightOn", _unit];
					_unit action ["CollisionLightOn", _vehicle];
					_unit action ["lightOn", _vehicle];
					_unit action ["SearchlightOn", _vehicle];
				} forEach (allUnits - allPlayers);
			}] remoteExec ['spawn'];
			["Units have their lasers/lights turned on.","addItemOk"] call MAZ_EZM_fnc_systemMessage;
		};

		MAZ_EZM_fnc_toggleOffLightsModule = {
			params ["_entity"];
			[[],{
				{
					private _unit = _x;
					private _group = group _unit;
					private _vehicle = vehicle _unit;
					_group enableIRLasers false;
					_unit enableIRLasers false;
					_group enableGunLights "ForceOff";
					_unit enableGunLights "ForceOff";
					_vehicle setPilotLight false;
					_vehicle setCollisionLight false;
					
					_unit action ["IRLaserOff", _unit];
					_unit action ["GunLightOff", _unit];
					_unit action ["CollisionLightOff", _vehicle];
					_unit action ["lightOff", _vehicle];
					_unit action ["SearchlightOff", _vehicle];
				} forEach (allUnits - allPlayers);
			}] remoteExec ['spawn'];
			["Units have their lasers/lights turned off.","addItemOk"] call MAZ_EZM_fnc_systemMessage;
		};