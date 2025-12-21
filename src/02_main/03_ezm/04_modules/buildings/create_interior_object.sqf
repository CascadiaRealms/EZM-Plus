MAZ_EZM_fnc_createInteriorObject = {
			params ["_building","_objectParams"];
			_objectParams params ["_type","_modelPos","_relDirAndUp","_isSimple","_objectTextures",["_scale",1]];

			private _object = objNull;
			private _relPos = _modelPos vectorDiff (boundingCenter _building);
			private _absPos = _building modelToWorldWorld _relPos;
			if(_isSimple) then {
				_object = createSimpleObject [_type,[0,0,0]];
				{
					if("camo" in (toLower _x)) then {continue};
					_object hideSelection [_x,true];
				}forEach (selectionNames _object);
			} else {
				_object = createVehicle [_type,[0,0,0],[],0,"CAN_COLLIDE"];
			};
			_object setPosWorld _absPos;
			_relDirAndUp params ["_dir","_up"];
			_dir = _building vectorModelToWorld _dir;
			_up = _building vectorModelToWorld _up;
			_object setVectorDirAndUp [_dir,_up];
			{
				_object setObjectTextureGlobal [_forEachIndex,_x];
			}forEach _objectTextures;
			[_object,_building] call BIS_fnc_attachToRelative;
			_object setObjectScale _scale;
			_object
		};