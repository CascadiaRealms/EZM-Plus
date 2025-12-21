if(!isNil "MAZ_EZM_action_addEditableObjects") then {
	[MAZ_EZM_action_addEditableObjects] call MAZ_EZM_fnc_removeContextAction;
};
MAZ_EZM_action_addEditableObjects = [
	"Add Editable Objects",
	{
		params ["_pos"];
		private _objects = [_pos,100] call MAZ_EZM_fnc_getEditableObjectsRadius;
		[_objects,getAssignedCuratorLogic player] call MAZ_EZM_fnc_addObjectToInterface;
	},
	{true},
	6,
	"a3\3den\data\displays\display3den\panelright\customcomposition_add_ca.paa",
	[1,1,1,1],
	[
		[
			"50m",
			{
				params ["_pos"];
				private _objects = [_pos,50] call MAZ_EZM_fnc_getEditableObjectsRadius;
				[_objects,getAssignedCuratorLogic player] call MAZ_EZM_fnc_addObjectToInterface;
			},
			{true},
			3,
			"",
			[1,1,1,1],
			[]
		],
		[
			"100m",
			{
				params ["_pos"];
				private _objects = [_pos,100] call MAZ_EZM_fnc_getEditableObjectsRadius;
				[_objects,getAssignedCuratorLogic player] call MAZ_EZM_fnc_addObjectToInterface;
			},
			{true},
			3,
			"",
			[1,1,1,1],
			[]
		],
		[
			"250m",
			{
				params ["_pos"];
				private _objects = [_pos,250] call MAZ_EZM_fnc_getEditableObjectsRadius;
				[_objects,getAssignedCuratorLogic player] call MAZ_EZM_fnc_addObjectToInterface;
			},
			{true},
			3,
			"",
			[1,1,1,1],
			[]
		],
		[
			"500m",
			{
				params ["_pos"];
				private _objects = [_pos,500] call MAZ_EZM_fnc_getEditableObjectsRadius;
				[_objects,getAssignedCuratorLogic player] call MAZ_EZM_fnc_addObjectToInterface;
			},
			{true},
			3,
			"",
			[1,1,1,1],
			[]
		],
		[
			"1000m",
			{
				params ["_pos"];
				private _objects = [_pos,1000] call MAZ_EZM_fnc_getEditableObjectsRadius;
				[_objects,getAssignedCuratorLogic player] call MAZ_EZM_fnc_addObjectToInterface;
			},
			{true},
			3,
			"",
			[1,1,1,1],
			[]
		]
	]
] call MAZ_EZM_fnc_createNewContextAction;

if(!isNil "MAZ_EZM_action_removeEditableObjects") then {
	[MAZ_EZM_action_removeEditableObjects] call MAZ_EZM_fnc_removeContextAction;
};
MAZ_EZM_action_removeEditableObjects = [
	"Remove Edit Objects",
	{
		params ["_pos"];
		private _objects = [_pos,100] call MAZ_EZM_fnc_getEditableObjectsRadius;
		[_objects,getAssignedCuratorLogic player] call MAZ_EZM_fnc_removeObjectFromInterface;
	},
	{true},
	7,
	"a3\3den\data\cfg3den\group\iconcustomcomposition_ca.paa",
	[1,1,1,1],
	[
		[
			"50m",
			{
				params ["_pos"];
				private _objects = [_pos,50] call MAZ_EZM_fnc_getEditableObjectsRadius;
				[_objects,getAssignedCuratorLogic player] call MAZ_EZM_fnc_removeObjectFromInterface;
			},
			{true},
			3,
			"",
			[1,1,1,1]
		],
		[
			"100m",
			{
				params ["_pos"];
				private _objects = [_pos,100] call MAZ_EZM_fnc_getEditableObjectsRadius;
				[_objects,getAssignedCuratorLogic player] call MAZ_EZM_fnc_removeObjectFromInterface;
			},
			{true},
			3,
			"",
			[1,1,1,1]
		],
		[
			"250m",
			{
				params ["_pos"];
				private _objects = [_pos,250] call MAZ_EZM_fnc_getEditableObjectsRadius;
				[_objects,getAssignedCuratorLogic player] call MAZ_EZM_fnc_removeObjectFromInterface;
			},
			{true},
			3,
			"",
			[1,1,1,1]
		],
		[
			"500m",
			{
				params ["_pos"];
				private _objects = [_pos,500] call MAZ_EZM_fnc_getEditableObjectsRadius;
				[_objects,getAssignedCuratorLogic player] call MAZ_EZM_fnc_removeObjectFromInterface;
			},
			{true},
			3,
			"",
			[1,1,1,1]
		],
		[
			"1000m",
			{
				params ["_pos"];
				private _objects = [_pos,1000] call MAZ_EZM_fnc_getEditableObjectsRadius;
				[_objects,getAssignedCuratorLogic player] call MAZ_EZM_fnc_removeObjectFromInterface;
			},
			{true},
			3,
			"",
			[1,1,1,1]
		]
	]
] call MAZ_EZM_fnc_createNewContextAction;