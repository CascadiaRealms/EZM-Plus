MAZ_EZM_fnc_moduleDialogMessage = {
			params["_object"];
			with uiNamespace do {
				createDialog "RscDisplayEmpty";
				showchat true;
				_display = (findDisplay -1);
				EMAZllDialogControls = [];
				EZMDialogLastIndex = [0];
				_ctrl = _display ctrlCreate ["RscPicture",-1];
				_ctrl ctrlSetPosition [0.375312 * safezoneW + safezoneX,0.234 * safezoneH + safezoneY,0.249375 * safezoneW,0.56 * safezoneH];
				_ctrl ctrlSetText ("#(argb,8,8,3)color(1,1,1,1)");
				_ctrl ctrlSetTextColor [0,0,0,0.5];
				_ctrl ctrlCommit 0;
				EMAZllDialogControls pushBack _ctrl;
				_ctrl = _display ctrlCreate ["RscPicture",-1];
				_ctrl ctrlSetPosition [0.381875 * safezoneW + safezoneX,0.248 * safezoneH + safezoneY,0.23625 * safezoneW,0.532 * safezoneH];
				_ctrl ctrlSetText ("#(argb,8,8,3)color(1,1,1,1)");
				_ctrl ctrlSetTextColor [0,0,0,0.5];
				_ctrl ctrlCommit 0; 
				EMAZllDialogControls pushBack _ctrl;
				_ctrl = _display ctrlCreate ["RscStructuredText",-1];
				_ctrl ctrlSetPosition [0.375312 * safezoneW + safezoneX,0.206926 * safezoneH + safezoneY,0.248854 * safezoneW,0.028 * safezoneH];
				_ctrl ctrlSetStructuredText parseText ("Dialog Selection");
				_ctrl ctrlSetBackgroundColor [0,0.5,1,1];
				_ctrl ctrlCommit 0;
				EMAZllDialogControls pushBack _ctrl;
				_ctrl = _display ctrlCreate ["RscCombo",-1];
				_ctrl ctrlSetPosition [0.375312 * safezoneW + safezoneX,0.794 * safezoneH + safezoneY,0.249375 * safezoneW,0.042 * safezoneH];
				_ctrl lbAdd "GLOBAL";
				_ctrl lbAdd "BLUFOR";
				_ctrl lbAdd "OPFOR";
				_ctrl lbAdd "Independent";
				_ctrl lbAdd "Civilian";
				_ctrl lbSetCurSel 0;
				_ctrl ctrlCommit 0;
				_ctrl ctrlShow false;
				EZMDialogCombo = _ctrl;
				EMAZllDialogControls pushBack _ctrl;
				_ctrl = _display ctrlCreate ["RscTree",-1];
				_ctrl ctrlSetPosition [0.388437 * safezoneW + safezoneX,0.262 * safezoneH + safezoneY,0.223125 * safezoneW,0.434 * safezoneH];
				_ctrl ctrlCommit 0;
				EZMDialogTree = _ctrl;
				EMAZllDialogControls pushBack _ctrl;
				_ctrl ctrlAddEventHandler ["TreeSelChanged",{
					params ["_control", "_selectedIndex"];
					with uiNamespace do {EZMDialogLastIndex = _selectedIndex;};
				}];
				_allDialogClasses = (configFile >> "CfgSentences") call BIS_fnc_getCfgSubClasses;
				{
					_topic = _x;
					_pindex = _ctrl tvAdd [[],_topic];
					_ctrl tvSetData [[_pindex],_topic];
					_containers = (configFile >> "CfgSentences" >> _topic) call BIS_fnc_getCfgSubClasses;
					{
						_container = _x;
						_cindex = _ctrl tvAdd [[_pindex],_container];
						_ctrl tvSetData [[_pindex,_cindex],_container];
						_sentences = (configFile >> "CfgSentences" >> _topic >> _container >> "Sentences") call BIS_fnc_getCfgSubClasses; 
						{ 
							_sentence = _x;
							_textPlain = getText(configFile >> "CfgSentences" >> _topic >> _container >> "Sentences" >> _sentence >> "textPlain");
							if(_textPlain isEqualTo "") then 
							{
								_textPlain = getText(configFile >> "CfgSentences" >> _topic >> _container >> "Sentences" >> _sentence >> "text"); 
							};
							_index = _ctrl tvAdd [[_pindex,_cindex],_textPlain];
							_ctrl tvSetData [[_pindex,_cindex,_index],_sentence];
						} foreach _sentences;
					} foreach _containers;
				} foreach _allDialogClasses;
				_ctrl = _display ctrlCreate ["RscButtonMenu",-1];
				_ctrl ctrlSetPosition [0.388437 * safezoneW + safezoneX,0.71 * safezoneH + safezoneY,0.223125 * safezoneW,0.056 * safezoneH];
				_ctrl ctrlSetStructuredText parseText ("PLAY DIALOG");
				_ctrl ctrlCommit 0;
				EMAZllDialogControls pushBack _ctrl;
				_ctrl ctrlAddEventHandler ["ButtonDown",{
					_comboBox = controlNull;
					_tree = controlNull;
					with uiNamespace do {
						_tree = EZMDialogTree;
						_comboBox = EZMDialogCombo;
					};
					_channel = _comboBox lbText (lbCurSel _comboBox);
					_index = tvCurSel _tree;
					_topic = _tree tvData [(_index select 0)];
					_container = _tree tvData [(_index select 0),(_index select 1)];
					_sentence = _tree tvData _index;
					_numberOfSpeakers = [_topic,_container,_sentence] call EZM_fnc_getNumberOfSpeakers;
					_speakers = [];
					_group = createGroup (playerSide);
					_crewman = _group createUnit ["B_Story_SF_Captain_F",[0,0,0],[],0,"CAN_COLLIDE"];
					_crewman hideObjectGlobal true;
					[_crewman] joinSilent _group;
					removeAllWeapons _crewman;
					[_crewman,_group] spawn 
					{
						params ["_crewman","_group"];
						sleep 60;
						deleteVehicle _crewman;
						deleteGroup _group;
					};
					for "_i" from 0 to (_numberOfSpeakers-1) do {_speakers pushBack _crewman;};
					[_container, _topic, [_sentence,_sentence], _channel, {true},_speakers, 1, true] spawn BIS_fnc_kbTell;
					closeDialog 1;
					[getAssignedCuratorLogic player, " "] call BIS_fnc_showCuratorFeedbackMessage;
				}];
			};
		};