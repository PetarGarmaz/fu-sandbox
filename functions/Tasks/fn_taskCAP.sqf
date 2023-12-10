params ["_target", "_caller", ["_arguments", ["", [0,0,0], civilian]], "_taskCount"];

//Find the mission location
private _locationName = _arguments select 0;
private _missionPos = _arguments select 1;

//Sides
private _friendlySide = side _target;
private _enemySide = _arguments select 2;
private _factionComp = [_enemySide] call FU_fnc_getFactionCompositions;
private _casPlane = (_factionComp select 1) select 4;
private _capPlane = _factionComp select 7;
sleep 1;

//Markers
_marker = createMarker ["FU_CAP_Marker", _missionPos];
_marker setMarkerShape "ELLIPSE";
_marker setMarkerBrush "Border";
_marker setMarkerSize [7000, 7000];
[_marker, _enemySide] call FU_fnc_setMarkerColor;

//Task
private _missionName = "FU_mission_" + str(missionNamespace getVariable "FU_completedMissions");
private _taskName = "FU_taskCAP_" + str(missionNamespace getVariable "FU_completedMissions");
_task = [_friendlySide, [_taskName, _missionName], [format["Keep the skies clear above %1.", _locationName], "Combat Air Patrol", ""], _missionPos, "CREATED", 1, true, "plane", true] call BIS_fnc_taskCreate;

//Condition
private _i = 0;
while {missionNamespace getVariable "FU_completedTasks" < _taskCount} do {
	private _players = allPlayers inAreaArray [_missionPos, 7000, 7000, 0, false, -1];
	_players = _players select {(vehicle _x) isKindOf "Plane"};

	if(_i % 36 == 0) then {
		private _pos = [_missionPos, 7000, 8000, 10, 1, 0.4, 0, [], []] call BIS_fnc_findSafePos;
		private _group = createGroup [_enemySide, true];

		_vehicle = createVehicle [_casPlane, [(_pos select 0), (_pos select 1), 200], [], 0, "FLY"];
		_group = createVehicleCrew _vehicle;

		_move1 = _group addWaypoint [_missionPos, 0];
		_move1 setWaypointType "SAD";
		_move1 setWaypointBehaviour "AWARE";

		_group setCombatMode "RED";
		_group setSpeedMode "FULL";
	};

	if(_i % 60 == 0 && _i != 0) then {
		private _pos = [_missionPos, 7000, 8000, 10, 1, 0.4, 0, [], []] call BIS_fnc_findSafePos;
		private _group = createGroup [_enemySide, true];
		
		_vehicle = createVehicle [_capPlane, [(_pos select 0), (_pos select 1), 200], [], 0, "FLY"];
		_group = createVehicleCrew _vehicle;

		_move1 = _group addWaypoint [_missionPos, 0];
		_move1 setWaypointType "SAD";
		_move1 setWaypointBehaviour "AWARE";

		_group setCombatMode "RED";
		_group setSpeedMode "FULL";
	};

	sleep 5;

	_i = _i + 1;
};

[_task, 'SUCCEEDED', true] call BIS_fnc_taskSetState;
deleteMarker _marker;

private _completedTasks = missionNamespace getVariable "FU_completedTasks";
_completedTasks = _completedTasks + 1;
missionNamespace setVariable ["FU_completedTasks", _completedTasks, true];