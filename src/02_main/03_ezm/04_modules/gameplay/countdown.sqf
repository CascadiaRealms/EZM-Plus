MAZ_EZM_fnc_startCountdown = {
			params ["_time"];
			_time = time + _time;
			MAZ_EZM_countDownStop = true;
			sleep 0.1;
			
			with uiNamespace do {
				private _display = findDisplay 46;
				private _background = _display ctrlCreate ["RscPicture",-1];
				_background ctrlSetText "#(argb,8,8,3)color(0,0,0,0.8)";
				_background ctrlSetPosition [0 * safezoneW + safezoneX,0.973 * safezoneH + safezoneY,0.0515625 * safezoneW,0.033 * safezoneH];
				_background ctrlCommit 0;

				private _timerIcon = _display ctrlCreate ["RscPictureKeepAspect",-1];
				_timerIcon ctrlSetText "a3\modules_f_curator\data\portraitskiptime_ca.paa";
				_timerIcon ctrlSetPosition [0.002 * safezoneW + safezoneX,0.9755 * safezoneH + safezoneY,0.0154688 * safezoneW,0.022 * safezoneH];
				_timerIcon ctrlCommit 0;

				private _timerText = _display ctrlCreate ["RscStructuredText",-1];
				_timerText ctrlSetStructuredText parseText "";
				_timerText ctrlSetPosition [0.0204687 * safezoneW + safezoneX,0.9755 * safezoneH + safezoneY,0.0309375 * safezoneW,0.022 * safezoneH];
				_timerText ctrlCommit 0;

				MAZ_EZM_TimerControls = [_background,_timerIcon,_timerText];
			};

			[_time] spawn {
				params ["_time"];
				sleep 0.1;
				MAZ_EZM_countDownStop = false;
				while {time < _time && !MAZ_EZM_countDownStop} do {
					private _difference = _time - time;
					private _minutes = floor (_difference / 60);
					private _seconds = floor (_difference % 60);
					with uiNamespace do {
						if(_minutes == 0) then {
							(MAZ_EZM_TimerControls # 2) ctrlSetTextColor [0.85,0.4,0,1];
						};
						private _secondsStr = if(_seconds < 10) then {"0" + (str _seconds)} else {str _seconds};
						private _minutesStr = if(_minutes < 10) then {"0" + (str _minutes)} else {str _minutes};
						(MAZ_EZM_TimerControls # 2) ctrlSetStructuredText parseText (format ["%1:%2",_minutesStr,_secondsStr]);
					};
					sleep 0.1;
				};
				with uiNamespace do {
					{
						ctrlDelete _x;
					}forEach MAZ_EZM_TimerControls;
				};
			};
		};

		MAZ_EZM_fnc_createCountdownModule = {
			["Create Countdown",[
				[
					"SLIDER",
					"Minutes:",
					[0,30,5]
				],
				[
					"SLIDER",
					"Seconds:",
					[0,60,0]
				],
				[
					"SIDES",
					"Sides Who See The Timer:",
					[west,east,independent,civilian]
				]
			],{
				params ["_values","_args","_display"];
				_values params ["_minutes","_seconds","_side"];
				private _sides = _side + [sideLogic];
				_seconds = round _seconds; _minutes = round _minutes;
				private _timer = (_minutes * 60) + _seconds;

				if(isNil "MAZ_EZM_countdownAr") then {
					MAZ_EZM_countdownAr = ['t',MAZ_EZM_fnc_startCountdown];
					publicVariable "MAZ_EZM_countdownAr";
				};

				[[_timer], {
					params ["_time"];
					[_time] call (MAZ_EZM_countdownAr # 1);
				}] remoteExec ["spawn",_sides];
				
				_display closeDisplay 1;
			},{
				params ["_values","_args","_display"];
				_display closeDisplay 2;
			},[]] call MAZ_EZM_fnc_createDialog;
		};