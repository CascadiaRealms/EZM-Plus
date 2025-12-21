
		MAZ_EZM_fnc_deleteMarkersModule = {
			private _numOfMarkers = 0;
			{
				deleteMarker _x;
				_numOfMarkers = _numOfMarkers + 1;
			}forEach allMapMarkers;
			[format ["%1 map markers deleted.",_numOfMarkers],"addItemOk"] call MAZ_EZM_fnc_systemMessage;
		};
