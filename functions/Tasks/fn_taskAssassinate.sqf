params ["_target", "_caller", ["_arguments", ["", [0,0,0], civilian]]];

//Find the mission location
private _locationName = _arguments select 0;
private _missionPos = _arguments select 1;

//Sides
private _friendlySide = side _target;
private _enemySide = _arguments select 2;
private _factionComp = [_enemySide] call FU_fnc_getFactionCompositions;
private _type = _factionComp select 4;
sleep 1;

//Spawn Officer
private _group_1 = [_missionPos, _factionComp, 0, 200, 400] call FU_fnc_spawnDefenders;
private _group_2 = [_missionPos, _factionComp, 0, 200, 400] call FU_fnc_spawnDefenders;
(units _group_2) joinSilent _group_1;

private _officer = _group_1 createUnit [_type, _missionPos, [], 0, "NONE"];

//Task
private _missionName = "FU_mission_" + str(missionNamespace getVariable "FU_completedMissions");
private _taskName = "FU_taskAssassinate_" + str(missionNamespace getVariable "FU_completedMissions");
_task = [_friendlySide, [_taskName, _missionName], [format["Assassinate %1.", name _officer], format["Assassinate %1", name _officer], ""], _officer, "CREATED", 1, true, "kill", true] call BIS_fnc_taskCreate;

//Condition
waitUntil {sleep 5; !alive _officer};

[_task, 'SUCCEEDED', true] call BIS_fnc_taskSetState;

private _completedTasks = missionNamespace getVariable "FU_completedTasks";
_completedTasks = _completedTasks + 1;
missionNamespace setVariable ["FU_completedTasks", _completedTasks, true];