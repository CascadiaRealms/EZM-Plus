MAZ_EZM_fnc_deleteProtectionZonesModule = {
			{
				if ((typeOf _x == 'ProtectionZone_F') or (typeOf _x == 'ProtectionZone_Invisible_F')) then 
				{
					deleteVehicle _x;
				};
			} forEach allMissionObjects '';
			
			["Protection zones removed.","addItemOk"] call MAZ_EZM_fnc_systemMessage;
		};