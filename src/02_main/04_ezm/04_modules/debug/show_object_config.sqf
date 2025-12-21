		MAZ_EZM_fnc_showObjectConfig = {
			params ["_entity"];
			if (!isNull _entity) then {
				BIS_fnc_configViewer_path = ["configFile", "CfgVehicles"];
				BIS_fnc_configViewer_selected = typeOf _entity;
			};

			[] call BIS_fnc_configViewer;
		};