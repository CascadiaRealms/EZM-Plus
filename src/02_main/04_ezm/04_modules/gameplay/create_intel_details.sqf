HYPER_EZM_fnc_handleCreateIntelDetails = {
			params ["_values", "_target"];
			_values params ["_title","_authorName","_timestamp","_timezone","_subtitle","_image","_bodyText","_bodyTextLocked"];

			HYPER_safeParse = {
				params ["_str"];
				private _num = parseNumber _str;
				if ((_num == 0) && (_str != "0")) then {
					-1
				} else {
					_num
				}
			};

			HYPER_fnc_parseTimestamp = {
				params ["_dateString"];
				private _defaultDate = [2035, 1, 1, 10, 38];
				private _parts = _dateString splitString " ";
				if (count _parts != 2) exitWith {_defaultDate};
				private _datePart = _parts select 0;
				private _timePart = _parts select 1;
				private _dateComponents = _datePart splitString "/";
				if (count _dateComponents != 3) exitWith {_defaultDate};
				private _timeComponents = _timePart splitString ":";
				if (count _timeComponents != 2) exitWith {_defaultDate};

				private _year   = [_dateComponents select 0] call HYPER_safeParse;
				private _month  = [_dateComponents select 1] call HYPER_safeParse;
				private _day    = [_dateComponents select 2] call HYPER_safeParse;
				private _hour   = [_timeComponents select 0] call HYPER_safeParse;
				private _minute = [_timeComponents select 1] call HYPER_safeParse;
				if ( (_year == -1) || (_month == -1) || (_day == -1) || (_hour == -1) || (_minute == -1) ) exitWith {_defaultDate};
				if (!((_year >= 0) && (_month >= 1 && _month <= 12) && (_day >= 1 && _day <= 31) && 
					(_hour >= 0 && _hour <= 23) && (_minute >= 0 && _minute <= 59))) exitWith {_defaultDate};
				[_year, _month, _day, _hour, _minute]
			};
			private _intelOptions = [];

			comment "Image banner validation";
			private _imageTexture = switch (_image) do {
				case "warthog": {"a3\missions_f_aow\data\img\artwork\landscape\showcase_aow_picture_64_co.paa"};
				case "divers": {"a3\missions_f_aow\data\img\artwork\landscape\showcase_aow_picture_65_co.paa"};
				case "breach": {"a3\missions_f_aow\data\img\artwork\landscape\showcase_aow_picture_04_co.paa"};
				case "ww2medical": {"a3\missions_f_aow\data\img\artwork\landscape\showcase_aow_picture_14_co.paa"};
				case "exfil": {"a3\missions_f_aow\data\img\artwork\landscape\showcase_aow_picture_106_co.paa"};
				case "soldiers": {"a3\missions_f_aow\data\img\artwork\landscape\showcase_aow_picture_59_co.paa"};
				case "schematic": {"a3\missions_f_aow\data\img\artwork\landscape\showcase_aow_picture_63_co.paa"};
				case "riot": {"a3\missions_f_aow\data\img\artwork\landscape\showcase_aow_picture_22_co.paa"};
				case "ambulance": {"a3\missions_f_aow\data\img\artwork\landscape\showcase_aow_picture_62_co.paa"};
				case "ww2attack": {"a3\missions_f_aow\data\img\artwork\landscape\showcase_aow_picture_92_co.paa"};
				case "ghosts": {"a3\missions_f_aow\data\img\artwork\landscape\showcase_aow_picture_18_co.paa"};
				case "town": {"a3\missions_f_aow\data\img\artwork\landscape\showcase_aow_picture_68_co.paa"};
				case "decon": {"a3\missions_f_aow\data\img\artwork\landscape\showcase_aow_picture_31_co.paa"};
				case "tank": {"a3\missions_f_aow\data\img\artwork\landscape\showcase_aow_picture_98_co.paa"};
				case "launcher": {"a3\missions_f_aow\data\img\artwork\landscape\showcase_aow_picture_122_co.paa"};
				case "cargotrain": {"a3\missions_f_aow\data\img\artwork\landscape\showcase_aow_picture_27_co.paa"};
				case "convoy": {"a3\missions_f_aow\data\img\artwork\landscape\showcase_aow_picture_87_co.paa"};
				case "fallen": {"a3\missions_f_aow\data\img\artwork\landscape\showcase_aow_picture_118_co.paa"};
				case "firefight": {"a3\missions_f_aow\data\img\artwork\landscape\showcase_aow_picture_76_co.paa"};
				case "fleet": {"a3\missions_f_aow\data\img\artwork\landscape\showcase_aow_picture_46_co.paa"};
				case "drones": {"a3\missions_f_aow\data\img\artwork\landscape\showcase_aow_picture_30_co.paa"};
				default {"a3\missions_f_aow\data\img\artwork\landscape\showcase_aow_picture_64_co.paa"};
			};
			
			comment "Metadata group validation";
			private _timestampParts = _timestamp call HYPER_fnc_parseTimestamp;
			if (_authorName == "") then {_authorName = "Anonymous";};
			if (_timezone == "") then {_timezone = "UTC";};

			comment "Other field validation";
			if (_title != "") then {_intelOptions pushBack ["title",_title];};
			_intelOptions pushBack ["meta",[_authorName,_timestampParts,_timezone]];
			if (_subtitle != "") then {_intelOptions pushBack ["textbold",_subtitle];};
			_intelOptions pushBack ["image",_imageTexture];
			if (_bodyText != "") then {_intelOptions pushBack ["text",_bodyText];};
			if (_bodyTextLocked != "") then {_intelOptions pushBack ["textlocked",[_bodyTextLocked,"Please Subscribe"]];};

			comment "Create intel object and action";
			private _intelObj = "Land_Laptop_unfolded_F" createVehicle _target;
			_intelObj setDamage 1;
			_intelObj setPosATL _target;
			_intelObj setObjectTextureGlobal [0, "a3\missions_f_orange\data\img\orange_compositions\c8\aan_co.paa"];

			[_intelObj] call MAZ_EZM_fnc_ignoreWhenCleaning;

			private _actionParams = [
				_intelObj,
				"<t color='#ff9b00'>View News Article</t>", 
				"a3\ui_f\data\igui\cfg\holdactions\holdaction_search_ca.paa", 
				"a3\ui_f\data\igui\cfg\holdactions\holdaction_search_ca.paa", 
				"_this distance _target < 3",
				"_caller distance _target < 3",  
				{},
				{},
				{
					private _args = _this select 3;
					_args params ["_intelOptions"];

					[ _intelOptions ] call BIS_fnc_showAANArticle;

				},
				{},
				[_intelOptions],
				2, 
				10, 
				false,
				false 
			];
			_actionParams remoteExec ["BIS_fnc_holdActionAdd", 0, _intelObj];

			[_intelObj] call MAZ_EZM_fnc_addObjectToInterface;
			["AAN article laptop created.","addItemOk"] call MAZ_EZM_fnc_systemMessage;
		};