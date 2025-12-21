
MAZ_EZM_fnc_initFunction = {

		MAZ_EZM_fnc_systemMessage = {
			params ["_message",["_sound",""]];
			systemChat format ["[ Enhanced Zeus Modules ] : %1",_message];
			if(_sound != "") then {
				playSound _sound;
			};
		};
		uiNamespace setVariable ['MAZ_EZM_fnc_systemMessage',MAZ_EZM_fnc_systemMessage];

		
		MAZ_EZM_fnc_autoResupplyAI = {
			params ["_unit"];
			comment "Fix groups that don't get deleted.";
			if(!(isGroupDeletedWhenEmpty (group _unit))) then {
				(group _unit) deleteGroupWhenEmpty true;
			};
			_unit setUnitPos MAZ_EZM_stanceForAI;
			_unit addEventHandler ["Reloaded", { 
				params ["_unit", "_weapon", "_muzzle", "_newMagazine", "_oldMagazine"]; 
				_oldMagazine params ["_type","_count"];
				_unit addMagazine _type;
			}];
		};

		MAZ_EZM_fnc_ignoreWhenCleaning = {
			params ["_object"];
        	_object setVariable ["MAZ_EZM_fnc_doNotRemove",true,true];
		};

		MAZ_EZM_fnc_cleanerWaitTilNoPlayers = {
			params ["_object"];
			if(!MAZ_EZM_enableCleaner) exitWith {};
			[[_object], {
				private _fnc_cleaner = {
					params ["_object"];
					waitUntil {uiSleep 0.1; !alive _object};
					waitUntil {
						(count (allPlayers select { (getPosATL _x) distance _object < 1600 })) == 0 ||
						isNull _object
					};
					if(!isNull _object) then {
						sleep 300;
						"After 5 minutes check if players are still near, if they are, call function again, else delete.";
						if(count (allPlayers select { (getPosATL _x) distance _object < 1600 }) != 0) exitWith {[_object] spawn _fnc_cleaner;};
						deleteVehicle _object;
					};
				};
				_this spawn _fnc_cleaner;
			}] remoteExec ["spawn",2];
		};
		
		MAZ_EZM_fnc_fixDynamicGroups = {
			if(!isNil "MAZ_EZM_dynamicGroupsFix") exitWith {};
			[[], {
				waitUntil {!isNull (findDisplay 46) && alive player};
				["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;
			}] remoteExec ['spawn',0,"FIX_DYNAGROUPS_JIP"];
			missionNamespace setVariable ["MAZ_EZM_dynamicGroupsFix",true,true];
		};
		call MAZ_EZM_fnc_fixDynamicGroups;

	
		MAZ_EZM_fnc_addToInterface = {
			[] spawn {
				if(!MAZ_EZM_autoAdd) exitWith {};
				call MAZ_EZM_fnc_addObjectsToInterfaceModule;
				["Objects automatically added to interface. You can disable this setting in Utilities.","addItemOK"] call MAZ_EZM_fnc_systemMessage;
			};
		};
