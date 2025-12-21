
		MAZ_EZM_fnc_openGUIEditor = {
			[] spawn {
				(findDisplay 312) closeDisplay 0;
				waitUntil {isNull (findDisplay 312)};
				if(!isMultiplayer) then {
					sleep 0.5;
				};
				call BIS_fnc_GUIeditor;
			};
		};