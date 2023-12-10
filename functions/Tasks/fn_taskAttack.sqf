params ["_target", "_caller", ["_arguments", ["", [0,0,0], civilian]]];

//Find the mission location
private _locationName = _arguments select 0;
private _missionPos = _arguments select 1;

//Sides
private _friendlySide = side _target;
private _enemySide = _arguments select 2;
private _factionComp = [_enemySide] call FU_fnc_getFactionCompositions;
sleep 1;

//Skeleton Units
_spawnUnits = [_missionPos, _factionComp, 0, 0, 200] spawn FU_fnc_spawnDefenders;
waitUntil{scriptDone _spawnUnits};

//Task
private _missionName = "FU_mission_" + str(missionNamespace getVariable "FU_completedMissions");
private _taskName = "FU_taskAttack_" + str(missionNamespace getVariable "FU_completedMissions");
_task = [_friendlySide, [_taskName, _missionName], [format["Clear %1 of all hostiles.", _locationName], format["Secure %1", _locationName], ""], _missionPos, "CREATED", 1, true, "attack", true] call BIS_fnc_taskCreate;

//Condition
while {true} do {
	private _allUnits = allUnits inAreaArray [_missionPos, 750, 750, 0, false, -1];
	private _enemyUnits = _allUnits select {side _x == _enemySide};

	if(count _enemyUnits == 0) exitWith {
		[_task, 'SUCCEEDED', true] call BIS_fnc_taskSetState;

		private _completedTasks = missionNamespace getVariable "FU_completedTasks";
		_completedTasks = _completedTasks + 1;
		missionNamespace setVariable ["FU_completedTasks", _completedTasks, true];
	};

	sleep 5;
};