MAZ_EZM_fnc_makeHostageModule = {
			params ["_entity"];
			if(isNull _entity || !((typeOf _entity) isKindOf "Man")) exitWith {["Unit is not suitable.","addItemFailed"] call MAZ_EZM_fnc_systemMessage;};

			[_entity,true] remoteExec ["setCaptive"];
			[_entity,"Move"] remoteExec ["disableAI"];
			[_entity,"Acts_AidlPsitMstpSsurWnonDnon_loop"] remoteExec ["switchMove"];
			private _holdActionIndex = [
				_entity,											
				"Free Hostage",										
				"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_secure_ca.paa",	
				"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_secure_ca.paa",	
				"_this distance _target < 3 && _target != _this && alive _target",
				"_caller distance _target < 3",						
				{},
				{},
				{ 
					params ["_unit","_caller"];
					[_unit,false] remoteExec ["setCaptive"];
					[_unit,"Move"] remoteExec ["enableAI"];
					[_unit,"AmovPercMstpSnonWnonDnon"] remoteExec ["playMove"];
					[_unit] remoteExec ["removeAllActions"];
					["TaskSucceeded",["",format ["Hostage (%1) was freed by %2",name _unit,name _caller]]] remoteExec ['BIS_fnc_showNotification'];

					remoteExec ["",_unit]; "Remove from JIP queue";
				},
				{},
				[],
				3,
				0,
				true,												
				false												
			] remoteExec ["BIS_fnc_holdActionAdd",0, _entity];

			if(_entity getVariable ["MAZ_EZM_hostageEH",-1] == -1) then {
				_entity setVariable ['MAZ_EZM_hostageEH',_entity addEventHandler ["Killed",{
					params ["_unit", "_killer", "_instigator", "_useEffects"];
					[_unit] remoteExec ["removeAllActions"];
					remoteExec ["",_unit];
					["TaskFailed",["",format ["Hostage (%1) was killed by %2",name _unit,name _killer]]] remoteExec ['BIS_fnc_showNotification'];
					[_unit,[
						"Take Dogtag",
						{
							params ["_target", "_caller", "_actionId", "_arguments"];
							["TaskSucceeded",["",format ["Hostage (%1) dogtag was taken by %2",name _target,name _caller]]] remoteExec ['BIS_fnc_showNotification'];
							[_target] remoteExec ["removeAllActions"];
						},
						nil,
						1.5,
						true,
						true,
						"",
						"_target distance _this < 5"
					]] remoteExec ["addAction"];
				}]];
			};

			["Unit is now a hostage, they can be freed by scrolling on them.","addItemOk"] call MAZ_EZM_fnc_systemMessage;
		};