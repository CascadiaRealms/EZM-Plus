HYPER_EZM_fnc_splitMaxLine = {
			params ["_inputString"];
			private _maxLength = 22;
			private _words = _inputString splitString " ";
			private _lines = [];
			private _currentLine = "";
			
			{
				private _word = _x;
				if (_currentLine isEqualTo "") then {
					_currentLine = _word;
					continue;
				};

				private _tentativeLine = format ["%1 %2", _currentLine, _word];
				if (count _tentativeLine <= _maxLength) then {
					_currentLine = _tentativeLine;
					continue;
				};
				
				_lines pushBack _currentLine;
				_currentLine = _word;
			} forEach _words;
			
			if (!(_currentLine isEqualTo "")) then {
				_lines pushBack _currentLine;
			};
			
			_lines
		};

		HYPER_EZM_fnc_remotePostProcessing = {
			params [
				["_postProcessValues", [1,1,0,[0,0,0,0],[1,1,1,1],[0,0,0,0]]],
				["_targets", allPlayers]
			];
			HYPER_PP_CC_Cinematic = ppEffectCreate ["colorCorrections",2090];
			HYPER_PP_CC_Cinematic ppEffectAdjust _postProcessValues;
			HYPER_PP_CC_Cinematic ppEffectCommit 0;
			HYPER_PP_CC_Cinematic ppEffectEnable true;
		};