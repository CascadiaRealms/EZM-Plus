HYPER_EZM_fnc_setColorBlack = {
			params ["_entity"];
			if(_entity isEqualTo objNull) exitWith {["No object selected.","addItemFailed"] call MAZ_EZM_fnc_systemMessage;};

			private _colorBlack = "#(argb,8,8,3)color(0,0,0,1)";
			{
				_entity setObjectTextureGlobal [_forEachIndex, _colorBlack];
			} forEach (getObjectTextures _entity);

			["Changed object color.","addItemOk"] call MAZ_EZM_fnc_systemMessage;

		};
