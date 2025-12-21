MAZ_EZM_fnc_unHideObjectAllModule = {
			params ["_entity"];
			if(isNil "MAZ_EZM_hiddenObjects") exitWith {};
			{
				[_x,false] remoteExec ['hideObjectGlobal',2];
			}forEach MAZ_EZM_hiddenObjects;
			MAZ_EZM_hiddenObjects = [];
			publicVariable "MAZ_EZM_hiddenObjects";

			["All hidden objects are revealed.","addItemOk"] call MAZ_EZM_fnc_systemMessage;
		};