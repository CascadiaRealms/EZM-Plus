MAZ_EZM_fnc_changeTimeModule = {
			private _date = date;
			_date params ["_year", "_month", "_day", "_hours", "_minutes"];
			(_date call BIS_fnc_sunriseSunsetTime) params ["_sunrise","_sunset"];
			private _sunriseData = [floor _sunrise, round ((_sunrise % 1) * 60)];
			{
				if(_x < 10) then {
					_sunriseData set [_forEachIndex,"0" + (str _x)];
				} else {
					_sunriseData set [_forEachIndex,str _x];
				};
			}forEach _sunriseData;

			private _sunsetData = [floor _sunset, round ((_sunset % 1) * 60)];
			{
				if(_x < 10) then {
					_sunsetData set [_forEachIndex,"0" + (str _x)];
				} else {
					_sunsetData set [_forEachIndex,str _x];
				};
			}forEach _sunsetData;
			[format ["Change Time - Sunrise %1:%2 - Sunset %3:%4",_sunriseData # 0,_sunriseData # 1,_sunsetData # 0, _sunsetData # 1],[
				[
					"SLIDER",
					"Hour:",
					[0,24,_hours]
				],
				[
					"SLIDER",
					"Minute:",
					[0,60,_minutes]
				]
			],{
				params ["_values","_pos","_display"];
				[_values,{
					params ["_hr","_min"];
					date params ["_year", "_month", "_day", "_hours", "_minutes"];
					setDate [_year,_month,_day,_hr,_min];
				}] remoteExec ['spawn',2];

				_display closeDisplay 1;
			},{
				params ["_values","_args","_display"];
				_display closeDisplay 2;
			},[]] call MAZ_EZM_fnc_createDialog;
		};