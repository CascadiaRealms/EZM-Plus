MAZ_EZM_fnc_deleteEverythingModule = {
			[] spawn {
				private _objBlacklist = 
				[
					"Logic",
					"ModuleHQ_F",
					"ModuleSector_F",
					"ModuleCurator_F",
					"VirtualCurator_F",
					"ModuleCuratorSetCosts_F",
					"ModuleCuratorSetCoefs_F",
					"LogicSectorPreview100m_F",
					"LogicSectorUnknown100m_F",
					"ModuleCuratorSetCamera_F",
					"ModuleMPTypeGameMaster_F",
					"ModuleCuratorAddPoints_F",
					"ModuleRadioChannelCreate_F",
					"ModuleCuratorSetModuleCosts_F",
					"ModuleCuratorSetObjectCosts_F",
					"ModuleCuratorSetDefaultCosts_F",
					"ModuleCuratorSetAttributesPlayer_F",
					"ModuleCuratorAddEditingAreaPlayers_F"
				];

				private _goodObjects = [];
				{
					if(!(typeOf _x in _objBlacklist)) then {
						_goodObjects pushBack _x;
					};
				}forEach allMissionObjects "All";

				{
					_goodObjects pushBack _x;
				}forEach allSimpleObjects [];

				[_goodObjects] call MAZ_EZM_fnc_deleteObjectsServer;
			};
		};