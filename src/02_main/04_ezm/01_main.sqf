	MAZ_EZM_autoAdd = profileNamespace getVariable ["MAZ_EZM_autoAddVar",true];
	MAZ_EZM_spawnWithCrew = true;
	MAZ_EZM_nvgsOnlyAtNight = true;
	MAZ_EZM_enableCleaner = profileNamespace getVariable ["MAZ_EZM_autoCleanerVar",true];
	MAZ_EZM_stanceForAI = "UP";
	uiNamespace setVariable ["MAZ_EZM_activeWarnings",[]];
	uiNamespace setVariable ["MAZ_EZM_missingRespawnWarn",nil];
	if(isNil "MAZ_EZM_factionAddons") then {
		MAZ_EZM_factionAddons = [];
};

EZM_themeColor = profileNamespace getVariable ["MAZ_EZM_ThemeColor",[0, 0.75, 0.75, 1]];
uiNamespace setVariable ["EZM_themeColor", EZM_themeColor];
EZM_zeusTransparency = profileNamespace getVariable ["MAZ_EZM_Transparency",1];
EZM_dialogColor = profileNamespace getVariable ["MAZ_EZM_DialogColor",[0,0.5,0.5,1]];
EZM_dialogBackgroundCO = [0, 0, 0, 0.7];

if(isNil "MAZ_EZM_moduleAddons") then {
	MAZ_EZM_moduleAddons = [];
};

comment "Close Debug display add initial respawns";
if (!isNull findDisplay 49) then {
	comment "Likely ran EZM from debug before adding respawns... ";
	comment "... adding manually to avoid module overwrite bug.";
	[
		createAgent ['ModuleRespawnPositionWest_F', [0,0,0], [], 0, 'CAN_COLLIDE'],
		createAgent ['ModuleRespawnPositionEast_F', [0,0,0], [], 0, 'CAN_COLLIDE'],
		createAgent ['ModuleRespawnPositionGuer_F', [0,0,0], [], 0, 'CAN_COLLIDE'],
		createAgent ['ModuleRespawnPositionCiv_F', [0,0,0], [], 0, 'CAN_COLLIDE']
	] spawn {sleep 2; {deleteVehicle _x} forEach _this};
	if (!isNull findDisplay 312) then {
		findDisplay 49 closeDisplay 0;
		waitUntil {isNull findDisplay 312};
		openCuratorInterface;
		waitUntil {!isNull findDisplay 312}
	} else {
		findDisplay 49 closeDisplay 0;
	};
};