MAZ_EZM_fnc_setInterfaceToRefresh = {
	params [["_refreshTime",10]];
	private _refresh = missionNamespace getVariable "MAZ_EZM_refreshTime";
	if(isNil "_refresh") then {
		private _refreshOnClose = ["onZeusInterfaceClosed", {
			private _refresh = missionNamespace getVariable "MAZ_EZM_refreshTime";
			if(!isNil "_refresh") then {
				missionNamespace setVariable ["MAZ_EZM_refresh", true];
				missionNamespace setVariable ["MAZ_EZM_refreshTime",time];
			};
		}] call MAZ_EZM_fnc_addEZMEventHandler;
		
		missionNamespace setVariable ["MAZ_EZM_refreshTime",time + _refreshTime];
		_refreshOnClose spawn {
			while {time < (missionNamespace getVariable "MAZ_EZM_refreshTime")} do {
				titleText [format ["NEW MODULES ADDED TO EZM\nYOUR ZEUS INTERFACE WILL BE AUTOMATICALLY REFRESHED IN %1 SECONDS", ceil ((missionNamespace getVariable "MAZ_EZM_refreshTime") - time)],"PLAIN DOWN",0.01];
				sleep 0.1;
			};
			if(!(missionNamespace getVariable ["MAZ_EZM_refresh",false])) then {
				call MAZ_EZM_fnc_refreshInterface;
			};
			missionNamespace setVariable ["MAZ_EZM_refreshTime",nil];
			missionNamespace setVariable ["MAZ_EZM_refresh", false];
			titleText ["","PLAIN DOWN",0.01];
			["onZeusInterfaceClosed", _this] call MAZ_EZM_fnc_removeEZMEventHandler;
		};
	} else {
		missionNamespace setVariable ["MAZ_EZM_refreshTime", time + _refreshTime];
	};
};

MAZ_EZM_fnc_refreshInterface = {
	(findDisplay 312) closeDisplay 0;
	waitUntil {isNull (findDisplay 312)};
	sleep 0.1;
	openCuratorInterface;
};