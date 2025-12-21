MAZ_EZM_fnc_exportInteriorsFromEditor = {
			if(!is3DEN) exitWith {systemChat "Not in 3DEN!"};

			private _br = toString [0x0D, 0x0A];
			private _tab = toString [9];
			private _outputText = "comment 'Interior Exports by " + profileName + "';" + _br;

			private _objects = get3DENSelected "object";
			_objects = [_objects,[],{(getText (configFile >> "CfgVehicles" >> typeOf _x >> "displayName"))}, "DESCEND"] call BIS_fnc_sortBy;
			private _lastObjectType = "";
			{
				private _type = typeOf _x;
				private _displayName = getText (configFile >> "CfgVehicles" >> _type >> "displayName");
				if(_type != _lastObjectType) then {
					_outputText = _outputText + _br + _tab + "comment '" + _displayName + "';" + _br;
					_lastObjectType = _type;
				};
				private _interiorData = [_x] call MAZ_EZM_fnc_getBuildingInteriorData;
				_outputText = _outputText + _tab + _tab + "_compData pushBack " + (str _interiorData) + ";" + _br;
			}forEach _objects;

			copyToClipboard _outputText;
			_outputText
		};