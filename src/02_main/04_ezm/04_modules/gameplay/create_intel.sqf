HYPER_EZM_fnc_handleCreateIntel = {
	params ["_title","_description","_intelObject","_deleteOnPickup", "_target", "_holdDuration", "_visibility"];

	private _intelObjModel = switch (_intelObject) do {
		case "laptop": {"Land_Laptop_unfolded_F"};
		case "ruggedtablet": {"Land_Tablet_02_black_F"};
		case "tablet": {"Land_Tablet_01_F"};
		case "documents": {"LanD_File1_f"};
		case "folder": {"Land_File_research_F"};
		default {"LanD_File1_f"};
	};
	private _intelObj = _intelObjModel createVehicle _target;
	_intelObj setDamage 1;
	_intelObj setPosATL _target;
	[_intelObj] call MAZ_EZM_fnc_ignoreWhenCleaning;

	private _actionParams = [
		_intelObj,
		"<t color='#ff9b00'>Pick up Intel</t>", 
		"a3\ui_f\data\igui\cfg\holdactions\holdaction_search_ca.paa", 
		"a3\ui_f\data\igui\cfg\holdactions\holdaction_search_ca.paa", 
		"_this distance _target < 3",
		"_caller distance _target < 3",  
		{},
		{},
		{
			private _intel = _this select 0; 
			private _args = _this select 3;
			_args params ["_title","_description","_deleteOnPickup", "_visibility"];

			private _targetPlayers = switch (_visibility) do {
				case "side": {allPlayers select {side _x == side player}};
				case "global": {allPlayers};
				default {allPlayers};
			};

			[_intel,0] remoteExec ["removeAction",0];
			["IntelAdded",[format ["%1 picked up %2", (name _caller), _title], "a3\ui_f\data\igui\cfg\simpletasks\types\documents_ca.paa"]] remoteExec ['BIS_fnc_showNotification', _targetPlayers];

			comment "for all players, remoteExec the createDiaryRecord";

			private _intelParams = ["Diary", [format["%1", _title], format["%1", _description]]];

			[_intelParams, {
				player createDiaryRecord _this;
			}] remoteExec ["spawn", _targetPlayers];

			if (_deleteOnPickup) then {
				deleteVehicle _intel;
			};
		},
		{},
		[_title, _description, _deleteOnPickup, _visibility],
		_holdDuration, 
		10, 
		true,
		false 
	];
	_actionParams remoteExec ["BIS_fnc_holdActionAdd", 0, _intelObj];

	[_intelObj] call MAZ_EZM_fnc_addObjectToInterface;
	["Intel created.","addItemOk"] call MAZ_EZM_fnc_systemMessage;
};

HYPER_EZM_fnc_createIntel = {
	private _dialogTitle = "Create Intel";
	private _target = [true] call MAZ_EZM_fnc_getScreenPosition;
	private _content = [
		[
			"EDIT",
			"Title",
			[
				"",
				1
			]
		],
		[
			"EDIT:MULTI",
			"Description",
			[
				"",
				3
			]
		],
		[
			"COMBO",
			"Intel Object",
			[
				["documents", "laptop", "ruggedtablet", "tablet", "folder"],
				["Documents", "Laptop", "Rugged Tablet", "Tablet", "Folder"],
				0
			]
		],
		[
			"TOOLBOX:YESNO",
			"Delete on Pick Up",
			[
				true
			]
		],
		[
			"SLIDER",
			"Hold Duration",
			[
				1,
				12,
				3
			]
		],
		[
			"COMBO",
			"Show Intel To",
			[
				["side", "global"],
				["Side", "Global"],
				0
			]
		]

	];
	private _onConfirm = {
		params ["_values", "_args", "_display"];
		_values params ["_title","_description","_intelObject","_deleteOnPickup","_holdDuration", "_visibility"];
		private _target = _args;
		[ _title, _description, _intelObject, _deleteOnPickup, _target, _holdDuration, _visibility ] call HYPER_EZM_fnc_handleCreateIntel;
		_display closeDisplay 1;
	};
	private _onCancel = {
		params ["_values", "_args", "_display"];
		_display closeDisplay 2;
	};
	[
		_dialogTitle,
		_content,
		_onConfirm,
		_onCancel,
		_target
	] call MAZ_EZM_fnc_createDialog;
};