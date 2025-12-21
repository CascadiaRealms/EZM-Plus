MAZ_EZM_fnc_getAllFactionGroups = {
	params [["_side",[0,1,2],[west,[]]]];
	private _sides = [];
	if(_side isEqualType west) then {
		_sides pushBack (_side call BIS_fnc_sideID);
	};
	if(_side isEqualType []) then {
		_sides = _side;
	};
	private _factions = [];
	{
		private _cfg = _x;
		private _side = getNumber (_x >> "side");
		if(!(_side in _sides)) then {continue};
		{
			private _name = getText (_x >> "name");
			private _cfgs = if(_name == "Spetsnaz") then {
				("true" configClasses (_x >> "SpecOps"))
			} else {
				("true" configClasses (_x >> "Infantry"))
			};
			private _groups = [];
			{
				private _groupName = getText (_x >> "name");
				_groups pushBack [_groupName,_x];
			}forEach _cfgs;
			private _flag = getText (configfile >> "CfgFactionClasses" >> configName _x >> "flag");
			if(_flag == "" && _name == "FIA") then {
				_flag = "\a3\Data_f\Flags\flag_FIA_co.paa";
			};
			private _icon = getText (configfile >> "CfgFactionClasses" >> configName _x >> "icon");
			_factions pushBack [_name,_flag,_icon,_groups];
		}forEach ("true" configClasses _x)
	}forEach ("true" configClasses (configFile >> "CfgGroups"));
	_factions
};

MAZ_EZM_fnc_getGroupDataFromIndex = {
	params ["_factionData","_index"];
	private _out = "";
	private _i = 0;
	{
		_x params ["_name","_flag","_icon","_groups"];
		if(!(_out isEqualType "")) exitWith {};
		private _groupName = "";
		{
			_x params ["_grpName","_cfg"];
			if(_i == _index) exitWith {
				_out = _cfg;
			};
			_i = _i + 1;
		}forEach _groups;
	}forEach _factionData;
	_out
};