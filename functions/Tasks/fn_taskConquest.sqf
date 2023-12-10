params ["_target", "_caller", ["_arguments", ["", [0,0,0], civilian]]];

//Find the mission location
private _locationName = _arguments select 0;
private _missionPos = _arguments select 1;

//Find friendly staging area first
private _friendlyPos = [_missionPos, 900, 1000, 1, 0, 0.1, 0, [], [], _missionPos] call BIS_fnc_findSafePos;
private _dir = _friendlyPos getDir _missionPos;
private _dist = _friendlyPos distance2D _missionPos;
private _friendlyHQ = [_friendlyPos, 0, call (compile (preprocessFileLineNumbers "Compositions\compHQ_2.sqf"))] call BIS_fnc_ObjectsMapper;

//Find enemy staging area second
private _enemyPos = _missionPos getPos [_dist, _dir];

if (surfaceIsWater _enemyPos) then {
	_enemyPos = [_enemyPos, 10, 600, 1, 0, 0.1, 0, [], [], _enemyPos] call BIS_fnc_findSafePos;
} else {
	_enemyPos = [_enemyPos, 10, 100, 1, 0, 0.1, 0, [], [], _enemyPos] call BIS_fnc_findSafePos;
};

private _enemyHQ = [_enemyPos, 0, call (compile (preprocessFileLineNumbers "Compositions\compHQ_1.sqf"))] call BIS_fnc_ObjectsMapper;

//Sides
private _friendlySide = side _target;
private _enemySide = _arguments select 2;
private _factionComp_E = [_enemySide] call FU_fnc_getFactionCompositions;
private _factionComp_F = [_friendlySide, false] call FU_fnc_getFactionCompositions;
sleep 1;

//Markers
_marker_E = createMarker ["FU_MarkerConquestEnemy", _enemyPos];
_marker_F = createMarker ["FU_MarkerConquestFriendly", _friendlyPos];

_marker_E setMarkerType "mil_box";
_marker_E setMarkerText "Enemy Staging Area";

_marker_F setMarkerType "mil_box";
_marker_F setMarkerText "Friendly Staging Area";

[_marker_E, _enemySide] call FU_fnc_setMarkerColor;
[_marker_F, _friendlySide] call FU_fnc_setMarkerColor;

//Spawn helipads
for "_i" from 1 to 10 do {
	private _padPos = [_missionPos, 10, 300, 1, 0, 0.1, 0, [], [], _missionPos] call BIS_fnc_findSafePos;
	private _pad = createVehicle ["Land_HelipadEmpty_F", _padPos, [], 0, "NONE"];
};

//Reach the AO
private _missionName = "FU_mission_" + str(missionNamespace getVariable "FU_completedMissions");
private _taskName = "FU_taskConquestReach_" + str(missionNamespace getVariable "FU_completedMissions");
_task = [_friendlySide, [_taskName, _missionName], ["Reach friendly staging area", "Reach Staging Area", ""], _friendlyPos, "CREATED", 1, true, "run", true] call BIS_fnc_taskCreate;

private _trigger = createTrigger ["EmptyDetector", _friendlyPos, false];
_trigger setTriggerArea [200, 200, 0, false, -1];
_trigger setTriggerActivation ["ANYPLAYER", "PRESENT", false];
_trigger setTriggerStatements ["this", "", ""];

waitUntil {triggerActivated _trigger};
[_task, 'SUCCEEDED', true] call BIS_fnc_taskSetState;

//Tickets
missionNamespace setVariable ["FU_friendlyTickets", 300, true];
missionNamespace setVariable ["FU_enemyTickets", 300, true];

//Spawn UI for players
[_friendlySide, _enemySide] remoteExec ["FU_fnc_initConquestHUD", 0, true];

//Task
private _taskName = "FU_taskConquest_" + str(missionNamespace getVariable "FU_completedMissions");
_task = [_friendlySide, [_taskName, _missionName], ["Neutralize a total of 300 enemy units in the ongoing conquest.", "Neutralize Enemy Units", ""], _missionPos, "CREATED", 1, true, "map", true] call BIS_fnc_taskCreate;

//Count kills
killCounterIndex = addMissionEventHandler ["EntityKilled", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	
	if(side (group _unit) == east || side (group _unit) == west) then {
		_tickets = missionNamespace getVariable "FU_enemyTickets";
		_tickets = _tickets - 1;
		missionNamespace setVariable ["FU_enemyTickets", _tickets, true];
	};
	
	if(side (group _unit) == resistance) then {
		_tickets = missionNamespace getVariable "FU_friendlyTickets";
		_tickets = _tickets - 1;
		missionNamespace setVariable ["FU_friendlyTickets", _tickets, true];
	};
}];

//Starting units
_group = [_friendlyPos, _factionComp_F, 7, 100, _missionPos] call FU_fnc_spawnAttackers;
_group = [_enemyPos, _factionComp_E, 7, 100, _missionPos] call FU_fnc_spawnAttackers;

_group = [_friendlyPos, _factionComp_F, 7, 100, _missionPos] call FU_fnc_spawnAttackers;
_group = [_enemyPos, _factionComp_E, 7, 100, _missionPos] call FU_fnc_spawnAttackers;

_group = [_friendlyPos, _factionComp_F, 8, 100, _missionPos] call FU_fnc_spawnAttackers;
_group = [_enemyPos, _factionComp_E, 8, 100, _missionPos] call FU_fnc_spawnAttackers;

//Main Loop
private _i = 0;
while {missionNamespace getVariable "FU_friendlyTickets" > 0 && missionNamespace getVariable "FU_enemyTickets" > 0} do {
	private _units = allUnits inAreaArray [_missionPos, 1500, 1500, 0, false, -1];
	
	_friendlyCount = _units select {side _x == _friendlySide && !isPlayer _x};
	_enemyCount = _units select {side _x == _enemySide && !isPlayer _x};
	
	//Reinforce
	_forceChance = [1, 3] call BIS_fnc_randomInt;
	_forceID = [2, 3, 4, 5, 6] selectRandomWeighted [0.2, 0.25, 0.15, 0.25, 0.15];
	if(count _friendlyCount <= 24) then {
		_group = [_friendlyPos, _factionComp_F, [7, 8] selectRandomWeighted [0.6, 0.4], 50, _missionPos] call FU_fnc_spawnAttackers;
		if(_forceChance == 1) then {private _dist = 50; if(_forceID > 4) then {_dist = 4000}; _group = [_friendlyPos, _factionComp_F, _forceID, _dist, _missionPos] call FU_fnc_spawnAttackers;};
	};
	
	if(count _enemyCount <= 24) then {
		_group = [_enemyPos, _factionComp_E, [7, 8] selectRandomWeighted [0.6, 0.4], 50, _missionPos] call FU_fnc_spawnAttackers;
		if(_forceChance == 1) then {private _dist = 50; if(_forceID > 4) then {_dist = 4000}; _group = [_enemyPos, _factionComp_E, _forceID, _dist, _missionPos] call FU_fnc_spawnAttackers;};
	};
	
	//Cleanup
	if(_i % 4 == 0) then {
		_allDeadInArea = allDead inAreaArray [_missionPos, 1500, 1500, 0, false, -1];
		{deleteVehicle _x; sleep 0.1;}foreach _allDeadInArea;
	};
	
	_i = _i + 1;
	
	sleep 30;
};

[_task, 'SUCCEEDED', true] call BIS_fnc_taskSetState;
deleteMarker _marker_E;
deleteMarker _marker_F;

private _completedTasks = missionNamespace getVariable "FU_completedTasks";
_completedTasks = _completedTasks + 1;
missionNamespace setVariable ["FU_completedTasks", _completedTasks, true];

removeMissionEventHandler ["EntityKilled", killCounterIndex];