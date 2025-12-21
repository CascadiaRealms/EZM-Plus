MAZ_EZM_fnc_deleteEmptyGroupsModule = {
			params ["_entity"];
			private _totalEmptyGroupsDeleted = 0;
			{
				if(count (units _x) == 0) then {
					deleteGroup _x;
					_totalEmptyGroupsDeleted = _totalEmptyGroupsDeleted + 1;
				};
			}forEach allGroups;
			[format ["%1 empty groups deleted.",_totalEmptyGroupsDeleted],"addItemOk"] call MAZ_EZM_fnc_systemMessage;
		};