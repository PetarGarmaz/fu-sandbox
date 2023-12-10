params ["_pos", "_radius", "_side", "_task"];

private _markers = [];

while {[_task] call BIS_fnc_taskState != "SUCCEEDED"} do {
	private _allUnits = allUnits inAreaArray [_pos, _radius, _radius, 0, false, -1];
	private _enemyUnits = _allUnits select {side _x == _side};

	{
		private _marker = createMarker [format["FU_enemyData_%1", _foreachIndex], getPosASL _x];
		_marker setMarkerType "mil_triangle";
		_marker setMarkerSize [0.7, 0.7];
		[_marker, _side] call FU_fnc_setMarkerColor;
		_markers pushBack _marker;
	}foreach _enemyUnits;

	sleep 5;

	{deleteMarker _x;}foreach _markers;
};