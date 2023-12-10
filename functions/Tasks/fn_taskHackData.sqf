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
private _objects = [_taskPos, 0, call (compile (preprocessFileLineNumbers "Compositions\compData.sqf"))] call BIS_fnc_ObjectsMapper;

//Find the data object
private _data = nearestObject [_taskPos, "Land_Device_disassembled_F"];
_data setVariable ["FU_isHacked", false, true];

[
	_data,
	"<img image='\A3\ui_f\data\igui\cfg\simpleTasks\types\interact_ca.paa'/> Hack Data Site",
	"\a3\data_f_destroyer\data\UI\IGUI\Cfg\holdactions\holdAction_loadVehicle_ca.paa",
	"\a3\data_f_destroyer\data\UI\IGUI\Cfg\holdactions\holdAction_loadVehicle_ca.paa",
	"_this distance _target < 7 && alive _target && !(_target getVariable 'FU_isHacked')",
	"_caller distance _target < 7",
	{},
	{},
	{
		params ["_target", "_caller", "_actionId", "_arguments"];
		_target setVariable ["FU_isHacked", true, true];
	},
	{},
	[],
	10,
	0,
	false,
	false
] remoteExecCall ["BIS_fnc_holdActionAdd", 0, true];

//Task
private _missionName = "FU_mission_" + str(missionNamespace getVariable "FU_completedMissions");
private _taskName = "FU_taskData_" + str(missionNamespace getVariable "FU_completedMissions");
_task = [_friendlySide, [_taskName, _missionName], ["The enemy has set up a data site here which contains locations on all enemies in the area. Hack it to learn where each enemy unit is located at.", "Hack Data Site", ""], _taskPos, "CREATED", 1, true, "intel", true] call BIS_fnc_taskCreate;

//Condition
waitUntil{sleep 5; _data getVariable "FU_isHacked" || !alive _data};

if(alive _data) then {
	[_task, 'SUCCEEDED', true] call BIS_fnc_taskSetState;
	[_missionPos, 750, _enemySide, _missionName] spawn FU_fnc_enemyData;
} else {
	[_task, 'FAILED', true] call BIS_fnc_taskSetState;
};

private _completedTasks = missionNamespace getVariable "FU_completedTasks";
_completedTasks = _completedTasks + 1;
missionNamespace setVariable ["FU_completedTasks", _completedTasks, true];