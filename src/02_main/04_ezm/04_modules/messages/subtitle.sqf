MAZ_EZM_fnc_sendSubtitleModule = {
			["Send Subtitle Message",[
				[
					"EDIT",
					"Sender Name",
					[missionNamespace getVariable ["EZM_senderName","High Command"]]
				],
				[
					"EDIT:MULTI",
					"Message",
					["Message..."]
				],
				[
					"SIDES",
					"Sides Who See The Message",
					[west,east,independent,civilian]
				]
			],{
				params ["_values","_args","_display"];
				_values params ["_sender","_message","_side"];
				private _sides = _side + [sideLogic];
				private _targets = [];
				{
					if(side (group _x) in _sides) then {
						_targets pushBack _x;
					};
				}forEach allPlayers;
				if(count _message > 300) exitWith {
					["Message too long! Cannot send, max characters is 300.","addItemFailed"] call MAZ_EZM_fnc_systemMessage;
				};
				_message = [_message] call MAZ_EZM_fnc_checkForBlacklistedWords;
				[
					_sender,
					_message
				] remoteExec ['BIS_fnc_showSubtitle',_targets];
				missionNamespace setVariable ["EZM_senderName",_sender];
				_display closeDisplay 1;
			},{
				params ["_values","_args","_display"];
				_display closeDisplay 2;
			},[]] call MAZ_EZM_fnc_createDialog;
		};