MAZ_DeleteShipTree = [
					MAZ_zeusModulesTree,
					"Create/Delete Ships",
					"a3\ui_f\data\map\vehicleicons\iconship_ca.paa"
				] call MAZ_EZM_fnc_zeusAddCategory;

				[
					MAZ_zeusModulesTree,
					MAZ_DeleteShipTree,
					"Create Carrier",
					"Creates the USS Freedom at its position.\nIf placed on a boat the ship will face the direction of the boat.",
					"MAZ_EZM_fnc_createCarrierModule"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_DeleteShipTree,
					"Create Destroyer",
					"Creates the USS Liberty at its position.\nIf placed on a boat the ship will face the direction of the boat.",
					"MAZ_EZM_fnc_createDestroyerModule"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_DeleteShipTree,
					"Delete All Carriers",
					"Deletes all carriers on the map.",
					"MAZ_EZM_fnc_deleteAllCarriersModule"
				] call MAZ_EZM_fnc_zeusAddModule;

				[
					MAZ_zeusModulesTree,
					MAZ_DeleteShipTree,
					"Delete All Destroyers",
					"Deletes all destroyers on the map.",
					"MAZ_EZM_fnc_deleteAllDestroyersModule"
				] call MAZ_EZM_fnc_zeusAddModule;