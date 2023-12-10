params ["_target", "_caller", "_arguments", "_tasks", "_mission"];

if(count _tasks == 0) exitWith {["[SERVER]: You did not select any tasks!"] remoteExec ["systemChat", _caller];};

missionNamespace setVariable ["FU_missionStarted", true, true];
missionNamespace setVariable ["FU_completedTasks", 0, true];

private _location = _arguments select 0;
private _side = _arguments select 1;

//Location
private _locationArgs = [_location] call FU_fnc_getMissionLocation;
private _customName = _locationArgs select 1;
private _position = _locationArgs select 2;

//Sides
private _friendlySide = side _target;
private _sides = [west, east, resistance] - [_friendlySide];
private _enemySide = _side;
if(_enemySide == civilian) then {_enemySide = selectRandom _sides};

_arguments = [_customName, _position, _enemySide];

switch (_mission select 0) do {
	case 0: {
		private _factionComp = [_enemySide] call FU_fnc_getFactionCompositions;

		//Markers
		_marker = createMarker ["FU_MissionMarker", _position];
		_markerText = createMarker ["FU_MissionMarkerText", _position];

		_marker setMarkerShape "ELLIPSE";
		_marker setMarkerBrush "FDiagonal";
		_marker setMarkerSize [750, 750];

		_markerText setMarkerType "mil_objective";
		_markerText setMarkerText format["Operation: Assault of %1", _customName];
		_markerText setMarkerSize [0.6, 0.6];

		[_marker, _enemySide] call FU_fnc_setMarkerColor;
		[_markerText, _enemySide] call FU_fnc_setMarkerColor;

		//Deploy enemies
		_spawnUnits = [_position, _factionComp, 0, 0, 250] spawn FU_fnc_spawnDefenders;
		waitUntil{scriptDone _spawnUnits};
		_spawnUnits = [_position, _factionComp, 0, 150, 300] spawn FU_fnc_spawnDefenders;
		waitUntil{scriptDone _spawnUnits};
		_spawnUnits = [_position, _factionComp, 1, 150, 300] spawn FU_fnc_spawnDefenders;
		waitUntil{scriptDone _spawnUnits};

		//Force multipliers
		for "_i" from 1 to 4 do {
			private _type = [0, 2, 3, 4, 5, 6] selectRandomWeighted [0.3, 0.25, 0.1, 0.1, 0.15, 0.1];
			_spawnUnits = [_position, _factionComp, _type, 250, 500] spawn FU_fnc_spawnDefenders;
			waitUntil{scriptDone _spawnUnits};
		};

		//Crate mission
		private _missionName = "FU_mission_" + str(missionNamespace getVariable "FU_completedMissions");
		sleep 1;
		_task = [_friendlySide, _missionName, [format["Perform a series of tasks in %1.", _customName], format["Operation: Assault of %1", _customName], ""], _position, "CREATED", 1, false, "whiteboard", false] call BIS_fnc_taskCreate;

		//Create tasks
		{
			if(_x == 0) then {[_target, _caller, _arguments] spawn FU_fnc_taskAttack; sleep 5;};
			if(_x == 1) then {[_target, _caller, _arguments] spawn FU_fnc_taskAssassinate; sleep 5;};
			if(_x == 2) then {[_target, _caller, _arguments, count _tasks] spawn FU_fnc_taskCAP; sleep 5;};
			if(_x == 3) then {[_target, _caller, _arguments] spawn FU_fnc_taskDestroyAA; sleep 5;};
			if(_x == 4) then {[_target, _caller, _arguments] spawn FU_fnc_taskDestroyRT; sleep 5;};
			if(_x == 5) then {[_target, _caller, _arguments] spawn FU_fnc_taskHackData; sleep 5;};
			if(_x == 6) then {[_target, _caller, _arguments] spawn FU_fnc_taskLogistics; sleep 5;};
			if(_x == 7) then {[_target, _caller, _arguments] spawn FU_fnc_taskPOW; sleep 5;};
			if(_x == 8) then {[_target, _caller, _arguments] spawn FU_fnc_taskSecureMP; sleep 5;};
			if(_x == 9) then {[_target, _caller, _arguments] spawn FU_fnc_taskDepot; sleep 5;};
		}foreach _tasks;

		//Condition
		waitUntil {sleep 5; missionNamespace getVariable "FU_completedTasks" >= count _tasks};

		[_task, 'SUCCEEDED', true] call BIS_fnc_taskSetState;
		deleteMarker _markerText;
		missionNamespace setVariable ["FU_missionStarted", false, true];

		private _missionsCompleted = missionNamespace getVariable "FU_completedMissions";
		_missionsCompleted = _missionsCompleted + 1;
		missionNamespace setVariable ["FU_completedMissions", _missionsCompleted, true];

		//Clear the field
		private _exitName = "FU_mission_exit_" + str(missionNamespace getVariable "FU_completedMissions");
		private _task = [_friendlySide, _exitName, ["Exit the area of operations.", "Exit the AO", ""], _position, "CREATED", 1, false, "run", false] call BIS_fnc_taskCreate;
		private _trigger = createTrigger ["EmptyDetector", _position, false];
		_trigger setTriggerArea [1000, 1000, 0, false, -1];
		_trigger setTriggerActivation ["ANYPLAYER", "NOT PRESENT", false];
		_trigger setTriggerStatements ["this", "", ""];

		waitUntil{triggerActivated _trigger};

		[_task, 'SUCCEEDED', true] call BIS_fnc_taskSetState;
		deleteMarker _marker;
		private _wipeList = nearestObjects [_position, ["AllVehicles", "Static", "Thing"], 1000, true];
		{deleteVehicle _x; sleep 0.02;}foreach _wipeList;

		systemChat "[SERVER]: The mission area has been cleared!";
	};

	case 1: {
		//Markers
		_marker = createMarker ["FU_MissionMarker", _position];
		_markerText = createMarker ["FU_MissionMarkerText", _position];

		_marker setMarkerShape "ELLIPSE";
		_marker setMarkerBrush "FDiagonal";
		_marker setMarkerSize [1000, 1000];

		_markerText setMarkerType "mil_objective";
		_markerText setMarkerText format["Operation: Conquest of %1", _customName];
		_markerText setMarkerSize [0.6, 0.6];

		[_marker, _enemySide] call FU_fnc_setMarkerColor;
		[_markerText, _enemySide] call FU_fnc_setMarkerColor;

		//Crate mission
		private _missionName = "FU_mission_" + str(missionNamespace getVariable "FU_completedMissions");
		sleep 1;
		_task = [_friendlySide, _missionName, [format["Your company was hired by AAF to kill all enemies in the current ongoing conflict %1.", _customName], format["Operation: Conquest of %1", _customName], ""], _position, "CREATED", 1, false, "whiteboard", false] call BIS_fnc_taskCreate;

		[_target, _caller, _arguments] spawn FU_fnc_taskConquest;

		waitUntil {sleep 5; missionNamespace getVariable "FU_completedTasks" >= count _tasks};

		[_task, 'SUCCEEDED', true] call BIS_fnc_taskSetState;
		deleteMarker _markerText;
		missionNamespace setVariable ["FU_missionStarted", false, true];

		private _missionsCompleted = missionNamespace getVariable "FU_completedMissions";
		_missionsCompleted = _missionsCompleted + 1;
		missionNamespace setVariable ["FU_completedMissions", _missionsCompleted, true];

		//Clear the field
		private _exitName = "FU_mission_exit_" + str(missionNamespace getVariable "FU_completedMissions");
		private _task = [_friendlySide, _exitName, ["Exit the area of operations.", "Exit the AO", ""], _position, "CREATED", 1, false, "run", false] call BIS_fnc_taskCreate;
		private _trigger = createTrigger ["EmptyDetector", _position, false];
		_trigger setTriggerArea [1000, 1000, 0, false, -1];
		_trigger setTriggerActivation ["ANYPLAYER", "NOT PRESENT", false];
		_trigger setTriggerStatements ["this", "", ""];

		waitUntil{triggerActivated _trigger};

		[_task, 'SUCCEEDED', true] call BIS_fnc_taskSetState;
		deleteMarker _marker;
		private _wipeList = nearestObjects [_position, ["AllVehicles", "Static", "Thing"], 1100, true];
		{deleteVehicle _x; sleep 0.02;}foreach _wipeList;

		systemChat "[SERVER]: The mission area has been cleared!";
	};
};