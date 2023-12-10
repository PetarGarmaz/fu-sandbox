params ["_target", "_caller", ["_arguments", ["", [0,0,0], civilian]]];

//Find the mission location
private _locationName = _arguments select 0;
private _missionPos = _arguments select 1;

//Sides
private _friendlySide = side _target;
private _enemySide = _arguments select 2;
private _factionComp = [_enemySide] call FU_fnc_getFactionCompositions;
sleep 1;

//Spawn Objects
private _taskPos = [_missionPos, 100, 750, 10, 0, 0.4, 0, [], []] call BIS_fnc_findSafePos;
private _targetBuilding = "Land_u_Shed_Ind_F" createVehicle _taskPos;

[_targetBuilding, "mil", false, false, false, 1] call ZEI_fnc_createTemplate;
[_taskPos, _factionComp, 100, [15,15,0,false], "COMBAT"] call FU_fnc_spawnGarrison;

//Task
private _missionName = "FU_mission_" + str(missionNamespace getVariable "FU_completedMissions");
private _taskName = "FU_taskDepot_" + str(missionNamespace getVariable "FU_completedMissions");
_task = [_friendlySide, [_taskName, _missionName], ["Secure enemy ammo depot.", "Secure Supply Depot", ""], _taskPos, "CREATED", 1, true, "rearm", true] call BIS_fnc_taskCreate;

//Condition
while {true} do {
	private _allUnits = allUnits inAreaArray [_taskPos, 100, 100, 0, false, -1];
	private _enemyUnits = _allUnits select {side _x == _enemySide};

	if(count _enemyUnits == 0) exitWith {
		[_task, 'SUCCEEDED', true] call BIS_fnc_taskSetState;

		private _completedTasks = missionNamespace getVariable "FU_completedTasks";
		_completedTasks = _completedTasks + 1;
		missionNamespace setVariable ["FU_completedTasks", _completedTasks, true];
	};

	sleep 5;
};