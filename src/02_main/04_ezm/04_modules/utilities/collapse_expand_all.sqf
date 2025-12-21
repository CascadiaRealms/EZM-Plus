
		MAZ_EZM_fnc_collapseAllTrees = {
			private _display = (findDisplay 312);
			{
				for '_n' from 0 to ((_display displayCtrl _x) tvCount []) do {
					(_display displayCtrl _x) tvCollapse [_n];
				};
			} forEach [270,271,272,273,274,275,276,277,278,280];
		};

		MAZ_EZM_fnc_expandAllTrees = {
			private _display = (findDisplay 312);
			{
				for '_n' from 0 to ((_display displayCtrl _x) tvCount [])  do {
					(_display displayCtrl _x) tvExpand [_n];
				};
			} forEach [270,271,272,273,274,275,276,277,278,280];
		};
		