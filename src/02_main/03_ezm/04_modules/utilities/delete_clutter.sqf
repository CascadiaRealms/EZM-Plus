MAZ_EZM_fnc_deleteClutterModule = {
			params ["_entity","_pos",["_deleteBuildings",true]];
			private _clutterNames = [
				'Ground', 
				'Canopy', 
				'Ejection Seat', 
				'Airplane Crater (Small)'
			];
			if(_deleteBuildings) then {
				_clutterNames pushBack 'Damaged Building';
			};
			private _clutterDeleted = 0;
			private _allMObjects = ((allMissionObjects 'All') + allUnits);
			private _objectsToDelete = [];
			{
				if (_x getVariable ['MAZ_EZM_fnc_doNotRemove', false]) then {continue;};
				if ((!alive _x) or (damage _x == 1)) then {
					comment "Delete dead soldiers & destroyed vehicles";
					_objectsToDelete pushBack _x;
					_clutterDeleted = _clutterDeleted + 1;
					continue;
				};
				private _objName = getText (configFile >> 'cfgVehicles' >> typeOf _x >> 'displayName');
				if (_objName in _clutterNames) then {
					comment "Delete Clutter";
					_objectsToDelete pushBack _x;
					_clutterDeleted = _clutterDeleted + 1;
					continue;
				};
				if(!_deleteBuildings) then {continue};
				comment "Delete Destroyed Buildings (Ruins)";
				private _objName2 = _objName splitString ' ';
				if ((count _objName2) == 0) then {continue};

				private _lastWord = _objName2 select (count _objName2 - 1);
				if ("ruin" in (toLower _lastWord)) then {
					_objectsToDelete pushBack _x;
					_clutterDeleted = _clutterDeleted + 1;
				};
			}forEach _allMObjects;
			[_objectsToDelete] call MAZ_EZM_fnc_deleteObjectsServer;
			[format ["%1 dead objects and clutter deleted.",_clutterDeleted],"addItemOk"] call MAZ_EZM_fnc_systemMessage;
			[objNull] call MAZ_EZM_fnc_deleteEmptyGroupsModule;
		};