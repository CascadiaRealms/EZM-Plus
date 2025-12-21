MAZ_EZM_fnc_editVehiclePylons = {
			params ["_veh"];
			createDialog "RscDisplayEmpty";
			showchat true;
			private _display = findDisplay -1;

			private _label = _display ctrlCreate ["RscText",-1];
			_label ctrlSetText (format ["EDIT AIRCRAFT PYLONS - (%1)",getText (configfile >> "CfgVehicles" >> typeOf _veh >> "displayName")]);
			_label ctrlSetPosition [0.29375 * safezoneW + safezoneX,(0.203 * safezoneH + safezoneY) - (["H",0.1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),0.4125 * safezoneW,(["H",1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat)];
			_label ctrlSetBackgroundColor EZM_dialogColor;
			_label ctrlCommit 0;

			private _okayButton = _display ctrlCreate ["RscButtonMenuOk",-1];
			_okayButton ctrlSetPosition [(["X",3.3] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),(0.775 * safezoneH + safezoneY) + (["H",0.1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),(["W",33.4] call MAZ_EZM_fnc_convertToGUI_GRIDFormat),(["H",1] call MAZ_EZM_fnc_convertToGUI_GRIDFormat)];
			_okayButton ctrlSetText "OK, DONE EDITING";
			_okayButton ctrlAddEventhandler ["ButtonClick",{
				params ["_control"];
				private _display = ctrlParent _control;
				_display closeDisplay 0;
			}];
			_okayButton ctrlCommit 0;

			private _uiPicture = getText (configfile >> "CfgVehicles" >> typeOf _veh >> "Components" >> "TransportPylonsComponent" >> "uiPicture");
			
			private _controlsGroup = _display ctrlCreate ["RscControlsGroupNoScrollbars",-1];
			_controlsGroup ctrlSetPosition [0.29375 * safezoneW + safezoneX,0.225 * safezoneH + safezoneY,0.4125 * safezoneW,0.55 * safezoneH];
			_controlsGroup ctrlCommit 0;
			
			private _pictureBG = _display ctrlCreate ["RscPicture",-1,_controlsGroup];
			_pictureBG ctrlSetText "#(argb,8,8,3)color(0.4,0.4,0.4,0.9)";
			_pictureBG ctrlSetPosition [0,0,1,1];
			_pictureBG ctrlCommit 0;

			private _picture = _display ctrlCreate ["RscPictureKeepAspect",-1,_controlsGroup];
			_picture ctrlSetText _uiPicture;
			_picture ctrlSetPosition [0,0,1,1];
			_picture ctrlCommit 0;
			
			private _currentMags = getPylonMagazines _veh;
			private _pylonSlots = (configFile >> "CfgVehicles" >> typeOf _veh >> "Components" >> "TransportPylonsComponent" >> "Pylons") call BIS_fnc_getCfgSubClasses;
			{
				private _pylon = _x;
				private _pylonIndex = _forEachIndex;

				private _UIPos = getArray (configFile >> "CfgVehicles" >> typeOf _veh >> "Components" >> "TransportPylonsComponent" >> "Pylons" >> _x >> "UIposition");
				_UIPos pushBack (0.061875 * safezoneW);
				_UIPos pushBack (0.022 * safezoneH);
				_UIPos = _UIPos vectorAdd [0.1,0.2,0,0];
				
				private _combo = _display ctrlCreate ["RscCombo",-1];
				_combo ctrlSetPosition _UIPos;
				_combo ctrlSetTooltip _pylon;
				_combo setVariable ["MAZ_EZM_PylonData",[_veh,_pylon]];
				_combo ctrlCommit 0;

				_combo lbAdd "None";
				_combo lbSetData [0,""];
				_combo lbSetTooltip [0,"Remove this Pylon's weapon"];

				private _compatMags = _veh getCompatiblePylonMagazines _pylon;
				{
					private _compatMag = _x;
					private _displayName = getText (configFile >> "CfgMagazines" >> _compatMag >> "displayName");
					private _descriptionShort = getText (configfile >> "CfgMagazines" >> _compatMag >> "descriptionShort");
					private _tooltip = format ["%1\n%2",_displayName,_descriptionShort];
					private _index = _combo lbAdd _displayName;
					_combo lbSetData [_index,_compatMag];
					_combo lbSetTooltip [_index,_tooltip];
					if((_currentMags # _pylonIndex) == _compatMag) then {
						_combo lbSetCurSel _index;
					};
				}forEach _compatMags;

				_combo ctrlAddEventHandler ["LBSelChanged", {
					params ["_control","_index"];
					(_control getVariable "MAZ_EZM_PylonData") params ["_vehicle","_pylon"];
					private _newWeapon = _control lbData _index;
					[_vehicle,[_pylon,_newWeapon]] remoteExec ["setPylonLoadout"];

					private _pylonMaxAmmo = getNumber (configFile >> "CfgMagazines" >> _newWeapon >> "count");
					[_vehicle,[_pylon,_pylonMaxAmmo]] remoteExec ["setAmmoOnPylon"];

					private _pylonMags = getPylonMagazines _vehicle;
					{
						private _weapon = _x;
						private _defaultWeapons = getArray (configFile >> "CfgVehicles" >> typeOf _vehicle >> "weapons");
						if(_weapon in _defaultWeapons) then {continue};
						private _mags = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines");

						private _magInPylons = false;
						{
							if(_x in _pylonMags) then {
								_magInPylons = true;
								break;
							};
						}forEach _mags;
						if(!_magInPylons) then {
							[_vehicle,_weapon] remoteExec ["removeWeapon"];
						};
					}forEach (weapons _vehicle);
				}];
			}forEach _pylonSlots;
		};