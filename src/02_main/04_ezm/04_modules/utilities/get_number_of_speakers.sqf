EZM_fnc_getNumberOfSpeakers = {
			params ['_topic','_container','_sentence'];
			private ['_speakers','_cfgSentences','_actor','_numberOfSpeakers'];
			_speakers = [];
			_cfgSentences = (configfile >> "CfgSentences" >> _topic >> _container >> "Sentences") call BIS_fnc_getCfgSubClasses;
			{
				_sentence = _x;
				_actor = getText (configFile >> "CfgSentences" >> _topic >> _container >> "Sentences" >> _sentence >> "Actor");
				if (not (_actor in _speakers)) then 
				{
					_speakers pushBackUnique _actor;
				};
			} forEach _cfgSentences;
			_numberOfSpeakers = count _speakers;
			_numberOfSpeakers
		};
