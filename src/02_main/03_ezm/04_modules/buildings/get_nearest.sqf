MAZ_EZM_fnc_getNearestBuilding = {
			params [
				["_position",[0,0,0],[[],objNull]],
				["_radius",50,[0]],
				["_2d",false,[false]]
			];
			if(_position isEqualTo [0,0,0]) exitWith {["Provide a position argument to getNearestBuilding!","addItemFailed"] call MAZ_EZM_fnc_systemMessage};
			if(_position isEqualType objNull) then {_position = getPosATL _position;};
			private _nearestBuildings = (nearestObjects [_position, ["building"], _radius, _2d]) select {

				count ([_x] call BIS_fnc_buildingPositions) > 0
			};
			(_nearestBuildings select 0)
		};