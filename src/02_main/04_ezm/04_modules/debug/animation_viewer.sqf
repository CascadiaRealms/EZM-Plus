MAZ_EZM_fnc_openAnimViewerModule = {
			params ["_entity"];
			if(isNull _entity) exitWith {
				[] call BIS_fnc_animViewer;
			};
			if(_entity isKindOf "CAManBase" && alive _entity) exitWith {
				[[typeOf _entity, animationState _entity]] call BIS_fnc_animViewer;
			};
			[] call BIS_fnc_animViewer;
		};
