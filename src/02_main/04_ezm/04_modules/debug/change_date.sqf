MAZ_EZM_fnc_changeDateModule = {
			date params ["_year", "_month", "_day", "_hours", "_minutes"];
			["Change Date",[
				[
					"SLIDER",
					"Month:",
					[0,12,_month]
				],
				[
					"SLIDER",
					"Day:",
					[0,30,_day]
				],
				[
					"SLIDER",
					"Year (Does not work on Official):",
					[2000,3000,_year]
				]
			],{
				params ["_values","_pos","_display"];
				_values params ["_month","_day","_year"];
				date params ["","","","_hour","_minute"];
				[[_year,_month,_day,_hour,_minute]] remoteExec ["setDate",2];
				_display closeDisplay 1;
			},{
				params ["_values","_args","_display"];
				_display closeDisplay 2;
			},[]] call MAZ_EZM_fnc_createDialog;
		};