
	comment "End";

};

MAZ_EZM_fnc_askAboutZeusUnit = {
	["Create Zeus Unit?",[
		[
			"TOOLBOX:YESNO",
			["Create Zeus Unit?","Whether to create a new controllable unit for your player."],
			[true]
		],
		[
			"TOOLBOX:YESNO",
			["Join a Side Channel?","Whether you will be set as a certain side and be able to hear their side chat."],
			[true],
			{true},
			{
				params ["_display","_value"];
				_display setVariable ["MAZ_EZM_showSides",_value];
			}
		],
		[
			"SIDES",
			"Side to Join",
			west,
			{
				params ["_display"];
				_display getVariable ["MAZ_EZM_showSides",true];
			}
		],
		[
			"EDIT:MULTI",
			"Change Log",
			[
				_changelogString,
				5
			],
			{
				params ["_display","_controlGroup"];
				private _textCtrl = _controlGroup controlsGroupCtrl 214;
				((ctrlText _textCtrl) != "");
			}
		]
	],{
		params ["_values","_args","_display"];
		_values params ["_createZeusUnit","_joinSide","_sideToJoin"];
		
		if(_createZeusUnit) then {
			[_joinSide,_sideToJoin] spawn MAZ_EZM_fnc_createZeusUnit;
		} else {
			if(_joinSide) then {
				[player] joinSilent (createGroup [_sideToJoin,true]);
			};
			if (isNil "MAZ_EZM_mainLoop_Active") then {
				[] spawn MAZ_EZM_fnc_initMainLoop;
			};
		};
		_display closeDisplay 1;
	},{
		params ["_values","_args","_display"];
		_display closeDisplay 2;
	},[],{
		params ["_display"];
		_display setVariable ["MAZ_EZM_showSides",true];
	}] call MAZ_EZM_fnc_createDialog;
};