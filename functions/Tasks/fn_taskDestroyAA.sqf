params ["_target", "_caller", ["_arguments", ["", [0,0,0], civilian]]];

//Find the mission location
private _locationName = _arguments select 0;
private _missionPos = _arguments select 1;

//Sides
private _friendlySide = side _target;
private _enemySide = _arguments select 2;
private _factionComp = [_enemySide] call FU_fnc_getFactionCompositions;
private _type = _factionComp select 5;
sleep 1;

//Spawn Objects
private _taskPos = [_missionPos, 100, 500, 10, 0, 0.4, 0, [], []] call BIS_fnc_findSafePos;
private _objects = [_taskPos, 0, call (compile (preprocessFileLineNumbers "Compositions\compAA.sqf"))] call BIS_fnc_ObjectsMapper;

private _aa = createVehicle [_type, _taskPos, [], 0, "CAN_COLLIDE"];
private _aaGroup = createVehicleCrew _aa;
_aa setVariable ["FU_isDisabled", false, true];

[_aa, _aaGroup] spawn {
	params ["_aa", "_aaGroup"];
			
	while {alive _aa} do {
		private _crewNumber = (units _aaGroup) select {_x != vehicle _x};

		if(count _crewNumber == 0) exitWith {
			_aa setVariable ["FU_isDisabled", true, true];
		};
		sleep 5;
	};
};

//Task
private _missionName = "FU_mission_" + str(missionNamespace getVariable "FU_completedMissions");
private _taskName = "FU_taskAA_" + str(missionNamespace getVariable "FU_completedMissions");
_task = [_friendlySide, [_taskName, _missionName], ["The enemy has set up an Anti Air base here.", "Disable or Destroy AA", ""], _taskPos, "CREATED", 1, true, "destroy", true] call BIS_fnc_taskCreate;

//Condition
waitUntil{sleep 5; if (alive _aa) then {_aa getVariable "FU_isDisabled"} else {true;}};

[_task, 'SUCCEEDED', true] call BIS_fnc_taskSetState;

private _completedTasks = missionNamespace getVariable "FU_completedTasks";
_completedTasks = _completedTasks + 1;
missionNamespace setVariable ["FU_completedTasks", _completedTasks, true];