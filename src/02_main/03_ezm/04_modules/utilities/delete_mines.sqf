
		MAZ_EZM_fnc_deleteMinesModule = {
			params ["_entity"];
			[format ["%1 mines deleted.",count allMines],"addItemOk"] call MAZ_EZM_fnc_systemMessage;
			[allMines] call MAZ_EZM_fnc_deleteObjectsServer;
		};