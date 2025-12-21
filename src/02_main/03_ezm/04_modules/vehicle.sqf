MAZ_EZM_fnc_unflipVehicleModule = {
			params ["_entity"];
			if(isNull _entity) exitWith {["No object!","addItemFailed"] call MAZ_EZM_fnc_systemMessage;};

			_entity setVectorUp surfaceNormal getPosATL _entity;
			_entity setPosATL [getPosATL _entity select 0, getPosATL _entity select 1, 0.2];

			["Vehicle unflipped.","addItemOk"] call MAZ_EZM_fnc_systemMessage;
		};

		MAZ_EZM_fnc_rearmVehicleModule = {
			params ["_entity"];
			if(isNull _entity) exitWith {["No object!","addItemFailed"] call MAZ_EZM_fnc_systemMessage;};
			[[_entity],{
				[_this,1] remoteExec ["setVehicleAmmo",owner _entity];
			}] remoteExec ['spawn',2];

			["Vehicle rearmed.","addItemOk"] call MAZ_EZM_fnc_systemMessage;
		};

		MAZ_EZM_fnc_refuelVehicleModule = {
			params ["_entity"];
			if(isNull _entity) exitWith {["No object!","addItemFailed"] call MAZ_EZM_fnc_systemMessage;};
			[_entity,{
				[_this,1] remoteExec ['setFuel',owner _this];
			}] remoteExec ['spawn',2];

			["Vehicle refueled.","addItemOk"] call MAZ_EZM_fnc_systemMessage;
		};

		MAZ_EZM_fnc_repairVehicleModule = {
			params ["_entity"];
			if(isNull _entity) exitWith {["No object!","addItemFailed"] call MAZ_EZM_fnc_systemMessage;};
			_entity setDamage 0;

			["Vehicle repaired.","addItemOk"] call MAZ_EZM_fnc_systemMessage;
		};

		HYPER_EZM_fnc_setPlateNumber = {
			params ["_entity"];
			if (!(_entity isKindOf "Car_F")) exitWith {
				["This is not a vehicle!","addItemFailed"] call MAZ_EZM_fnc_systemMessage;
			};
			[
				"Set License Plate Number",
				[ 
					[
						"EDIT",
						["Plate Number", "The maximum length of a plate number is 12 characters"],
						[ 
							getPlateNumber _entity, 
							1 
						]
					]
				], 
				{
					params ["_values", "_args", "_display"];
					private _entity = _args;
					private _inputText = _values select 0;
					if (count _inputText > 12) then {
						_inputText = _inputText select [0, 12];
					};
					[_entity,_inputText] remoteExec ["setPlateNumber"];
					["License Plate Number set.","addItemOk"] call MAZ_EZM_fnc_systemMessage;
					_display closeDisplay 1; 
				}, 
				{ 
					_display closeDisplay 2; 
				}, 
				_entity
			] call MAZ_EZM_fnc_createDialog;

		};