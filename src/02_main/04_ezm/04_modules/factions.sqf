MAZ_EZM_fnc_removeAllClothing = {
			params ["_unit"];
			_unit setUnitLoadout [[],[],[],[],[],[],"","",["","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]];
			removeGoggles _unit;
		};

		MAZ_EZM_fnc_createMan = {
			params [
				["_side",west,[west]],
				["_unitType","B_Soldier_F",[""]],
				["_unitPos",MAZ_EZM_stanceForAI,[""]],
				["_behaviour","AWARE",[""]],
				["_rank","PRIVATE",[""]],
				["_pos",[true] call MAZ_EZM_fnc_getScreenPosition,[[]]]
			];
			private _grp = createGroup [_side,true];
			[_grp,0] setWayPointPosition [_pos,0];
			private _unit = _grp createUnit [_unitType,_pos,[],0,"CAN_COLLIDE"];
			_unit setUnitPos _unitPos;
			_unit setRank _rank;
			_grp setBehaviour _behaviour;
			[_unit] call MAZ_EZM_fnc_addObjectToInterface;
			[_unit] spawn MAZ_EZM_fnc_cleanerWaitTilNoPlayers;

			[missionNamespace, "EZM_onManCreated", [_unit]] call BIS_fnc_callScriptedEventHandler;

			_unit
		};

		MAZ_EZM_fnc_addItemAndWeapons = {
			params [
				["_unit",objNull,[objNull]],
				["_primWeapon",[],[[]]],
				["_secWeapon",[],[[]]],
				["_handgunWeapon",[],[[]]],
				["_numFirstAidKits",3,[3]],
				["_grenadeInfo",[],[[]]],
				["_extraItems",[],[[]]]
			];

			if(isNull _unit) exitWith {};

			for "_i" from 1 to _numFirstAidKits do {
				_unit addItem "FirstAidKit";
			};

			{
				_x params ["_grenadeType","_grenadeQuantity"];
				for "_i" from 1 to _grenadeQuantity do {
					_unit addMagazine _grenadeType;
				};
			}forEach _grenadeInfo;

			if(!(_primWeapon isEqualTo [])) then {
				_primWeapon params [["_primWeaponType","",[""]],["_magInfo",[],[[]]],["_primAttachments",[]]];
				for "_i" from 1 to (_magInfo select 1) do {
					_unit addMagazine (_magInfo select 0);
				};
				_unit addWeapon _primWeaponType;
				{
					_unit addPrimaryWeaponItem _x;
				}forEach _primAttachments;
			};

			if(!(_secWeapon isEqualTo [])) then {
				_secWeapon params [["_secWeaponType","",[""]],["_secMagInfo","",[[]]],["_secAttachments",[]]];
				for "_i" from 1 to (_secMagInfo select 1) do {
					_unit addMagazine (_secMagInfo select 0);
				};
				_unit addWeapon _secWeaponType;
				{
					_unit addSecondaryWeaponItem _x;
				}forEach _secAttachments;
			};

			if(!(_handgunWeapon isEqualTo [])) then {
				_handgunWeapon params [["_hGunWeaponType","",[""]],["_hGunMagInfo","",[[]]],["_hGunAttachments",[]]];
				for "_i" from 1 to (_hGunMagInfo select 1) do {
					_unit addMagazine (_hGunMagInfo select 0);
				};
				_unit addWeapon _hGunWeaponType;
				{
					_unit addSecondaryWeaponItem _x;
				}forEach _hGunAttachments;
			};

			{
				_x params ["_itemType","_itemQuantity"];
				for "_i" from 1 to _itemQuantity do {
					_unit addItem _itemType;
				};
			}forEach _extraItems;
		};

		MAZ_EZM_fnc_createVehicle = {
			params [
				["_vehicleType","B_MRAP_01_F",[""]],
				["_textures",[],[[]]],
				["_pos",[],[[]]]
			];
			private _isOnCarrier = false;
			if(_pos isEqualTo []) then {
				_pos = [true] call MAZ_EZM_fnc_getScreenPosition;
				if(surfaceIsWater _pos && {(_pos # 2) != 0}) then {_isOnCarrier = true};
				if(!(_vehicleType isKindOf "Ship") && !(getNumber (configFile >> "CfgVehicles" >> _vehicleType >> "canFloat") == 1)) then {
					_pos = ASLtoATL (AGLtoASL _pos);
				} else {
					_pos = _pos vectorAdd [0,0,1];
				};
			};
			private _vehicle = objNull;
			if(surfaceIsWater _pos && _vehicleType isKindOf "Air" && !_isOnCarrier) then {
				_vehicle = createVehicle [_vehicleType,_pos,[],0,"FLY"];
			} else {
				_vehicle = createVehicle [_vehicleType,_pos,[],0,"CAN_COLLIDE"];
			};
			{
				_vehicle setObjectTextureGlobal [_forEachIndex, _x];
			}forEach _textures;
			[_vehicle] call MAZ_EZM_fnc_addObjectToInterface;
			[_vehicle] spawn MAZ_EZM_fnc_cleanerWaitTilNoPlayers;

			[missionNamespace, "EZM_onVehicleCreated", [_vehicle]] call BIS_fnc_callScriptedEventHandler;

			_vehicle
		};

		MAZ_EZM_fnc_addNVGs = {
			params [["_unit",objNull,[objNull]],["_nvg","",[""]]];
			if(isNull _unit) exitWith {};
			if(!MAZ_EZM_nvgsOnlyAtNight) exitWith {};
			if(_nvg == "") then {
				private _loadout = getUnitLoadout (configFile >> "CfgVehicles" >> typeOf _unit);
				private _loadoutNVG = (_loadout select 9) select {"NV" in _x};
				if(_loadoutNVG isEqualTo []) exitWith {};
				_loadoutNVG = _loadoutNVG select 0;
				_nvg = _loadoutNVG;
			};
			if(call MAZ_EZM_fnc_isNightTime) then {
				_unit addItem _nvg;
				_unit assignItem _nvg;
			} else {
				private _nvg = (assignedItems _unit) select {"NV" in _x};
				if(_nvg isEqualTo []) exitWith {};
				_nvg = _nvg select 0;
				_unit unassignItem _nvg;
				_unit removeItem _nvg;
			};
		};

		MAZ_EZM_fnc_cacheExplodeOnExplosiveDamage = {
			params ["_cache"];
			_cache addEventHandler ["HandleDamage", {
				params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];
				systemChat (format ["Proj: %1 T1: %2 T2: %3 T3: %4 T4: %5",_projectile,_projectile isKindOf "TimeBombCore", _projectile isKindOf "GrenadeCore", _projectile isKindOf "BombCore", _projectile isKindOf "RocketCore"]);
				if(_projectile isKindOf "TimeBombCore" || _projectile isKindOf "GrenadeCore" || _projectile isKindOf "BombCore" || _projectile isKindOf "RocketCore") then {
					private _bomb = "IEDUrbanBig_Remote_Ammo" createVehicle (_unit modelToWorld [0,0,0]);  
					_bomb setDamage 1;
					deleteVehicle _unit;
				};
			}];
		};

		MAZ_EZM_fnc_createDeadSoldierModule = {
			params [["_gunType","Weapon_arifle_CTAR_blk_F"]];
            private _pos = [true] call MAZ_EZM_fnc_getScreenPosition;
            
            private _soldier = createVehicle ["O_Soldier_F",[24602.4,19234.3,2.38419e-007],[],0,"CAN_COLLIDE"];
            _soldier setUnitLoadout [[],[],[],["U_O_CombatUniform_ocamo",[["FirstAidKit",1],["Chemlight_red",1,1]]],["V_HarnessO_brn",[]],[],"H_HelmetO_ocamo","",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]];

            private _animData = selectRandom [
                ["KIA_gunner_static_low01",[24602.4,19234.4,3.19144],[24603.4,19234.9,3.20104],[24601.7,19235,3.195]],
                ["KIA_gunner_standup01",[24602.4,19234.4,3.19144],[24602.9,19233.5,3.2036],[24602.4,19234.3,3.19136]],
                ["KIA_driver_boat01",[24602.4,19234.4,3.19144],[24603,19235.2,3.19],[24602.8,19234.5,3.195]],
                ["KIA_passenger_boat_holdleft",[24602.5,19234.4,3.19144],[24603,19235.1,3.19896],[24602.8,19234.4,3.195]]
            ];
            
            _animData params ["_anim","_unitPos","_gunPos","_bloodPos"];
            [_soldier,_anim] remoteExec ['switchMove',0,_soldier];
            _soldier disableAI "ALL";  
            _soldier setCaptive true; 
            _soldier setSpeaker "NoVoice"; 
            _soldier allowDamage false;
            _soldier setPosWorld _unitPos;
            _soldier setVectorDirAndUp [[0.965509,-0.26037,0],[0,0,1]];
            _soldier setDir (random 359);
            [_soldier] call MAZ_EZM_fnc_deleteAttachedWhenKilled;
            [_soldier] call MAZ_EZM_fnc_deleteAttachedWhenDeleted;
            [_soldier] call MAZ_EZM_fnc_addObjectToInterface;
            [_soldier] call MAZ_EZM_fnc_ignoreWhenCleaning;

            _soldier spawn {
                while {!isNull _this} do {
                    private _sounds = [
                        ["A3\Missions_F_Oldman\Data\sound\Flies\Flies_02.wss",10.5,0.5,15]
                    ];
                    private _soundData = selectRandom _sounds;
                    _soundData params ["_sound","_time","_volume","_distance"];
                    playSound3D [_sound,_this,false,getPosASL _this, _volume, 1, _distance];
                    sleep _time;
                };
            };

            private _gun = createVehicle [_gunType,[24603.4,19234.9,0.0110364],[],0,"CAN_COLLIDE"];
            _gun setPosWorld _gunPos;
            _gun setDir (random 90);
            [_gun,_soldier] call BIS_fnc_attachToRelative;

            private _blood = createVehicle ["BloodSplatter_01_Medium_New_F",[24601.7,19235,0],[],0,"CAN_COLLIDE"];
            _blood setPosWorld _bloodPos;
            _blood setVectorDirAndUp [[0,1,0],[0,0,1]];
            _blood setObjectTextureGlobal [0,"a3\props_f_orange\humanitarian\garbage\data\bloodsplatter_medium_fresh_ca.paa"];
            _blood setDir (random 359);
            [_blood, _soldier] call BIS_fnc_attachToRelative;

            _soldier setpos _pos;

            _soldier
        }; 