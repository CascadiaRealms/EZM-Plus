MAZ_EZM_fnc_tvFind = {
			params ["_tree",["_path",[]],["_text",""]];
			if(_text == "") exitWith {};
			private _index = -1;
			private _size = (_tree tvCount _path) - 1;
			for "_i" from 0 to _size do {
				private _tempPath = _path + [_i];
				if((_tree tvText _tempPath) == _text) exitWith {_index = _i};
			};
			_index;
		};

		comment "Will return the first valid result. Not useful for searching for things like 'Autorifleman' or vague, reused terms.";
		MAZ_EZM_fnc_tvFindDeepSearch = {
			params ["_tree",["_startPath",[]],["_text",""]];
			if(_text == "") exitWith {};
			private _path = +_startPath;
			private _size = (_tree tvCount _startPath) - 1;
			for "_i" from 0 to _size do {
				private _tempPath = _path + [_i];
				if((_tree tvText _tempPath) == _text) exitWith {_path = _tempPath};
				if(_tree tvCount _tempPath > 0) then {
					private _searchResult = [_tree,_tempPath,_text] call MAZ_EZM_fnc_tvFindDeepSearch;
					if (!(_searchResult isEqualTo [])) then {
						_path = _searchResult;
						break;
					};
				};
			};
			if(_path isEqualTo _startPath) then {_path = []};
			_path;
		};

		MAZ_EZM_fnc_tvEmpty = {
			params ["_tree",["_path",[]]];
			private _size = (_tree tvCount _path) - 1;
			for "_i" from _size to 0 step -1 do {
				private _newPath = _path + [_i];
				_tree tvDelete _newPath;
			};
		};

		MAZ_EZM_fnc_addRespawnModules = {
			private _display = findDisplay 312;
			private _tree = _display displayCtrl 280;
			private _respawnPath = [];
			_respawnPath pushBack ([_tree,[],"Respawn"] call MAZ_EZM_fnc_tvFind);
			[_tree,_respawnPath] call MAZ_EZM_fnc_tvEmpty;
			{
				private _displayName = getText (configFile >> "CfgVehicles" >> _x >> "displayName");
				private _icon = getText (configFile >> "CfgVehicles" >> _x >> "portrait");
				private _index = _tree tvAdd [_respawnPath,_displayName];
				private _newPath = _respawnPath + [_index];
				_tree tvSetData [_newPath,_x];
				_tree tvSetPicture [_newPath,_icon];
			}forEach ["ModuleRespawnInventory_F","ModuleRespawnPositionWest_F","ModuleRespawnPositionEast_F","ModuleRespawnPositionGuer_F","ModuleRespawnPositionCiv_F","ModuleVehicleRespawnPositionWest_F","ModuleVehicleRespawnPositionEast_F","ModuleVehicleRespawnPositionGuer_F","ModuleVehicleRespawnPositionCiv_F"];
		};

		MAZ_EZM_fnc_getSafePos = {
			params ["_pos", ["_range", ""], ["_objDist", getNumber(configFile >> "CfgWorlds" >> worldName >> "safePositionRadius")], ["_waterMode", 1], ["_maxGradient", 1]];

			private _minDist = -1;
			private _maxDist = -1;
			switch (typeName _range) do {
				case "ARRAY" : {
					_minDist = _range select 0;
					_maxDist = _range select 1;
				};
				case "SCALAR" : {
					_minDist = 0;
					_maxDist = _range;
				};
				default {
					_minDist = 0;
					_maxDist = getNumber(configFile >> "CfgWorlds" >> worldName >> "safePositionRadius");
				};
			};

			if(_objDist < 0) then {
				_objDist = getNumber(configFile >> "CfgWorlds" >> worldName >> "safePositionRadius");
			};

			private _newPos = [];
			private _posX = _pos select 0;
			private _posY = _pos select 1;
			private _attempts = 0;

			while {_attempts < 1000} do {
				private _newX = _posX + (_maxDist - (random (_maxDist * 2)));
				private _newY = _posY + (_maxDist - (random (_maxDist * 2)));
				private _testPos = [_newX, _newY];

				if ( (_pos distance _testPos) >= _minDist) then {
					if !((_testPos isFlatEmpty [_objDist, 0, _maxGradient, _objDist max 5, _waterMode, !(_waterMode == 0), objNull]) isEqualTo []) exitWith {
						_newPos = _testPos;
					};
				};
				_attempts = _attempts + 1;
			};

			if (_newPos isEqualTo []) then {
				_newPos = _pos;
			};
			_newPos
		};