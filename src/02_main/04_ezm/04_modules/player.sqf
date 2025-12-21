		MAZ_EZM_fnc_disarmModule = {
			params ["_entity"];
			if(isNull _entity || !((typeOf _entity) isKindOf "Man")) exitWith {["Unit is not suitable.","addItemFailed"] call MAZ_EZM_fnc_systemMessage;};
			_entity remoteExec ['removeAllWeapons'];

			["Weapons have been removed from the unit.","addItemOk"] call MAZ_EZM_fnc_systemMessage;
		};

		MAZ_EZM_fnc_healAndReviveModule = {
			params ["_entity"];
			if(isNull _entity || !((typeOf _entity) isKindOf "Man")) exitWith {["Unit is not suitable.","addItemFailed"] call MAZ_EZM_fnc_systemMessage;};

			if(isPlayer _entity) then {
				[[],{
					player setDamage 0;
					["#rev",1,player] call BIS_fnc_reviveOnState;
				}] remoteExec ['spawn',_entity];
			} else {
				_entity setDamage 0; 
			};

			["The unit has been healed, and revived if possible.","addItemOk"] call MAZ_EZM_fnc_systemMessage;
		};

		MAZ_EZM_fnc_healAndReviveAllModule = {
			[[],{
				player setDamage 0;
				["#rev",1,player] call BIS_fnc_reviveOnState;
			}] remoteExec ['spawn',-2];
			["The players have been healed, and revived if possible.","addItemOk"] call MAZ_EZM_fnc_systemMessage;
		};

		MAZ_EZM_fnc_changeSideModule = {
			params ["_entity"];
			if(isNull _entity || !((typeOf _entity) isKindOf "Man")) exitWith {["Unit is not suitable.","addItemFailed"] call MAZ_EZM_fnc_systemMessage;};
			["Change Unit Side",[
				[
					"SIDES",
					"New Side",
					(side _entity)
				]
			],{
				params ["_values","_args","_display"];
				private _grp = (createGroup [(_values # 0),true]);

				if((typeOf _args) isKindOf "Man") then {
					private _count = {alive _x} count (units (group _args)); 
					if(_count > 1 && !isPlayer _args) then {
						private _leader = leader (group _args);
						(units (group _args)) joinSilent _grp;
						_grp selectLeader _leader;
						["Unit group side is changed."] call MAZ_EZM_fnc_systemMessage;
					} else {
						[_args] joinSilent _grp;
						["Unit side is changed."] call MAZ_EZM_fnc_systemMessage;
					};
				};
				if((typeOf _args) isKindOf "LandVehicle" || (typeOf _args) isKindOf "Air" || (typeOf _args) isKindOf "Ship") then {
					(crew _args) joinSilent _grp;
					["Vehicle crew side is changed."] call MAZ_EZM_fnc_systemMessage;
				};
				playSound 'addItemOk';
				_display closeDisplay 1;
			},{
				params ["_values","_args","_display"];
				_display closeDisplay 2;
			},_entity] call MAZ_EZM_fnc_createDialog;
		};

		MAZ_EZM_fnc_forceEjectModule = {
			params ["_entity"];
			if(isNull _entity) exitWith {["No object selected.","addItemFailed"] call MAZ_EZM_fnc_systemMessage;};

			{
				moveOut _x;
			} foreach (crew _entity);

			["Units have been ejected from the vehicle.","addItemOk"] call MAZ_EZM_fnc_systemMessage;
		};

		MAZ_EZM_fnc_muteServerModule = {
			private _muted = missionNamespace getVariable ["MAZ_EZM_ServerMuted",false];
			private _zeuses = allCurators apply {getAssignedCuratorUnit _x};
			[[_muted],{
				params ["_muted"];
				0 enableChannel [true,_muted];
				1 enableChannel [true,_muted]; 
				2 enableChannel [true,_muted];
				3 enableChannel [true,_muted];
			}] remoteExec ['spawn',(allPlayers - _zeuses)];
			_muted = !_muted;
			missionNamespace setVariable ["MAZ_EZM_ServerMuted",_muted,true];
			[["The server has been unmuted.","The server has been muted."] select _muted,"addItemOk"] call MAZ_EZM_fnc_systemMessage;
		};
		
		MAZ_EZM_fnc_resetLoadout = {
			params ["_entity"];
			if(isNull _entity || !((typeOf _entity) isKindOf "Man")) exitWith {["Unit is not suitable.","addItemFailed"] call MAZ_EZM_fnc_systemMessage;};
			_entity setUnitLoadout (configFile >> "EmptyLoadout");
			comment '
			TODO : Version 2.20
			_entity spawn {
				waitUntil {!isSwitchingWeapon _this};
				_this setUnitLoadout (configFile >> "EmptyLoadout");
			}';

			if(isPlayer _entity) then {
				[[], {
					if (!isNil "M9SD_EH_arsenalRespawnLoadout") then {
						player removeEventHandler["Respawn", M9SD_EH_arsenalRespawnLoadout];
					};
				}] remoteExec ["spawn",_entity];
			};
		};

		MAZ_EZM_fnc_killUnit = {
			params ["_entity"];
			if(isNull _entity || !((typeOf _entity) isKindOf "Man")) exitWith {["Unit is not suitable.","addItemFailed"] call MAZ_EZM_fnc_systemMessage;};
			_entity setDamage 1;
		};
