params ["_target", "_caller", ["_arguments", ["", [0,0,0], civilian]]];

//Find the mission location
private _missionName = _arguments select 0;
private _missionPos = _arguments select 1;

//Sides
private _friendlySide = side _target;
private _enemySide = _arguments select 2;
private _factionComp = [_enemySide] call FU_fnc_getFactionCompositions;
private _type = _factionComp select 6;
sleep 1;

//Skeleton Units
_spawnUnits = [_missionPos, _factionComp, 1, 0, 200] spawn FU_fnc_spawnDefenders;
waitUntil{scriptDone _spawnUnits};

//Mortars
private _mortars = [];
private _taskPos = [_missionPos, 100, 750, 10, 0, 0.4, 0, [], []] call BIS_fnc_findSafePos;
private _mortarPit1 = [[(_taskPos select 0) + 15, (_taskPos select 1), (_taskPos select 2)], 0, call (compile (preprocessFileLineNumbers "Compositions\compMortar.sqf"))] call BIS_fnc_ObjectsMapper;
private _mortarPit2 = [[(_taskPos select 0), (_taskPos select 1) + 15, (_taskPos select 2)], 0, call (compile (preprocessFileLineNumbers "Compositions\compMortar.sqf"))] call BIS_fnc_ObjectsMapper;
private _mortarPit3 = [_taskPos, 0, call (compile (preprocessFileLineNumbers "Compositions\compMortar.sqf"))] call BIS_fnc_ObjectsMapper;

for "_i" from 1 to 3 do {
	private _m = 0;
	private _n = 0;
	
	if(_i == 1) then {_m = 15; _n = 0;};
	if(_i == 2) then {_m = 0; _n = 15;};
	if(_i == 3) then {_m = 0; _n = 0;};

	private _mortar = createVehicle [_type, [(_taskPos select 0) + _m, (_taskPos select 1) + _n, 0], [], 0, "CAN_COLLIDE"];
	private _mortarGroup = createVehicleCrew _mortar;
	_mortars pushBack _mortar;
};

//Task
private _missionName = "FU_mission_" + str(missionNamespace getVariable "FU_completedMissions");
private _taskName = "FU_taskMortar_" + str(missionNamespace getVariable "FU_completedMissions");
_task = [_friendlySide, [_taskName, _missionName], ["Clear out enemy mortar pits.", "Secure Mortar Pits", ""], _taskPos, "CREATED", 1, true, "destroy", true] call BIS_fnc_taskCreate;

_fireMission = [_taskPos, _enemySide, _mortars] spawn {
	params ["_taskPos", "_enemySide", "_mortars"];

	while {true} do {
		private _nearPlayers = allPlayers inAreaArray [_taskPos, 1000, 1000, 0, false, -1];
		private _crewMortars = _mortars select {if(alive _x) then {private _crew = crew _x; count _crew > 0}};
		
		if(count _crewMortars > 0) then {
			if(count _nearPlayers > 0) then {
				{
					private _teammates = allPlayers inAreaArray [getPos _x, 40, 40, 0, false, -1];

					if(_enemySide knowsAbout _x == 4 && isTouchingGround _x && count _teammates >= 3) exitWith {
						[_x, _mortars] spawn FU_fnc_artillery;
						sleep 300;
					};
				}foreach _nearPlayers;
			};
		} else {
			break;
		};
	};
};

//Condition
while {true} do {
	private _crewMortars = _mortars select {if(alive _x) then {private _crew = crew _x; count _crew > 0}};

	if(count _crewMortars <= 0) exitWith {
		[_task, 'SUCCEEDED', true] call BIS_fnc_taskSetState;

		private _completedTasks = missionNamespace getVariable "FU_completedTasks";
		_completedTasks = _completedTasks + 1;
		missionNamespace setVariable ["FU_completedTasks", _completedTasks, true];
	};

	sleep 5;
};