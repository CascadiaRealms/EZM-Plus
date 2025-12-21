MAZ_EZM_fnc_editObjectAttributesModule = {
			params ["_entity"];
			if(isNull _entity) exitWith {["Place the module onto an object!","addItemFailed"] call MAZ_EZM_fnc_systemMessage;};
			private _textures = getObjectTextures _entity;

			private _objName = if (isPlayer _entity) then {name _entity} else {getText (configFile >> 'cfgVehicles' >> typeOf _entity >> 'displayName');};
			if (_objName == '') then {
				_objName = typeOf _entity;
			};

			private _uiData = [
				[
					"EDIT:MULTI",
					"Object Init:",
					[
						"",
						3
					]
				],
				[
					"TOOLBOX:YESNO",
					"God Mode:",
					[
						!isDamageAllowed _entity
					]
				],
				[
					"TOOLBOX:YESNO",
					"Hide Object:",
					[
						isObjectHidden _entity
					]
				],
				[
					"TOOLBOX:YESNO",
					"Enable Simulation:",
					[
						simulationEnabled _entity
					]
				],
				[
					"COMBO",
					"Lock State:",
					[
						["0","1","2","3"],
						["Unlocked","Default","Locked","Locked for Players"],
						locked _entity
					]
				]
			];

			{
				_uiData pushBack [
					"EDIT",
					format ["Texture [%1]:",_forEachIndex],
					[_x]
				]
			}forEach _textures;
			
			[
				format ["Object Attributes Editor (%1)",_objName],
				_uiData,
				{
					params ["_values","_entity","_display"];
					_values params ["_init","_godMode","_hidden","_sim","_lockState","_tex1","_tex2","_tex3","_tex4"];
					_entity call (compile _init);
					_entity allowDamage !_godMode;
					[_entity,_hidden] remoteExec ["hideObjectGlobal",2];
					[_entity,_sim] remoteExec ["enableSimulationGlobal",2];
					[_entity,parseNumber _lockState] remoteExec ["lock"];
					{
						_entity setObjectTextureGlobal [_forEachIndex,_x];
					}forEach [_tex1,_tex2,_tex3,_tex4];
					_display closeDisplay 1;
				},
				{
					params ["_values","_args","_display"];
					_display closeDisplay 2;
				},
				_entity
			] call MAZ_EZM_fnc_createDialog;
		};