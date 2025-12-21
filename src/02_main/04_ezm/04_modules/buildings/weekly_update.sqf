MAZ_EZM_fnc_weeklyUpdate = {
			private _shouldWeeklyUpdate = profileNamespace getVariable ["MAZ_EZM_BuildingWeekly",true];
			if(!_shouldWeeklyUpdate) exitWith {false};
			private _lastSave = profileNamespace getVariable ["MAZ_EZM_BuildingLastSave",nil];
			if(isNil "_lastSave") then {
				_lastSave = 0;
			};
			systemTimeUTC params ["_year","_month","_day"];
			"Calculate days since June 1st 2024";

			private _refYear = 2024;
			private _refMonth = 6;
			private _refDay = 1;

			_month = _month + ((_year - _refYear) * 12);
			_day = _day + ((_month - refMonth) * 30);

			

		};