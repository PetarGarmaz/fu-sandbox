params ["_target", "_caller", ["_arguments", ["", [0,0,0], civilian]]];

//Find the mission location
private _locationName = _arguments select 0;
private _missionPos = _arguments select 1;
private _taskPos = [_missionPos, 750, 1000, 10, 0, 0.4, 0, [], []] call BIS_fnc_findSafePos;

//Sides
private _friendlySide = side _target;
private _enemySide = _arguments select 2;
private _factionComp_E = [_enemySide] call FU_fnc_getFactionCompositions;
private _factionComp_F = [_friendlySide] call FU_fnc_getFactionCompositions;
sleep 1;

//Determine delivery type
private _taskType = ["supplies", "troops"] selectRandomWeighted [0.25, 0.75];

//Set the AO marker up
_markerDeliveryPoint = createMarker ["logisticsMarkerDelivery", _taskPos];
_markerExitPoint = createMarker ["logisticsMarkerExit", _taskPos];

_markerDeliveryPoint setMarkerShape "ELLIPSE";
_markerDeliveryPoint setMarkerBrush "Solid";
_markerDeliveryPoint setMarkerSize [50, 50];
_markerDeliveryPoint setMarkerAlpha 0.75;

_markerExitPoint setMarkerShape "ELLIPSE";
_markerExitPoint setMarkerBrush "Border";
_markerExitPoint setMarkerSize [150, 150];
sleep 1;

//Create Cargo
cargo = objNull;
private _group = grpNull;
private _spawnPos = [];
private _holdPos = [];
private _cargoName = "";
private _cargoType = "";
private _objects = [_taskPos, 0, call (compile (preprocessFileLineNumbers "Compositions\compHQ_2.sqf"))] call BIS_fnc_ObjectsMapper;

switch _friendlySide do {
	case west: {_spawnPos = getMarkerPos "cargoSpawn_WEST"; _holdPos = getMarkerPos "cargoSpawn_WEST"};
	case east: {_spawnPos = getMarkerPos "cargoSpawn_WEST"; _holdPos = getMarkerPos "cargoSpawn_WEST"};
	case resistance: {_spawnPos = getMarkerPos "cargoSpawn_WEST"; _holdPos = getMarkerPos "cargoSpawn_WEST"};
};

switch _taskType do {
	case "troops": {
		_group = createGroup[_friendlySide, true]; 
		_cargoType = _factionComp_F select 0;
		_cargoName = "Squad Leader";
		
		for "_i" from 0 to 5 do {
			_man = _group createUnit [_cargoType select _i, _spawnPos, [], 0, "NONE"];
			if(_i == 0) then {cargo= _man};
			sleep 0.25;
		};
	};
	
	case "supplies": {
		cargo= createVehicle ["B_supplyCrate_F", _spawnPos, [], 0, "NONE"];
		_cargoName = "Supply Box";
	};
};

//AI Logic
if(_taskType == "troops") then {
	[_group, cargo, _caller, _taskPos, _holdPos] spawn {
		params ["_group", "_cargo", "_caller", "_taskPos", "_holdPos"];
		
		while {alive cargo} do {
			if(vehicle _caller != _caller) exitWith {
				_hold = _group addWaypoint [_holdPos, 0];
				_hold setWaypointType "HOLD";
			};
			
			sleep 10;
		};
		
		while {alive cargo} do {
			_distance = (getPos _caller) distance _holdPos;
		
			if(_distance <= 50) exitWith {
				deleteWaypoint [_group, 1];
				_getIn = _group addWaypoint [_holdPos, 0];
				_getIn waypointAttachVehicle (vehicle _caller);
				_getIn setWaypointType "GETIN";
			};
			
			sleep 5;
		};
		
		while {alive cargo} do {
			_distance = (getPos _caller) distance _taskPos;
	
			if(_distance <= 150 && isTouchingGround (vehicle _caller)) exitWith {
				{
					_x action ["Eject", (vehicle _x)];
					unassignVehicle _x;
				}foreach units _group;
				
				_move = _group addWaypoint [_taskPos, 0];
				_move setWaypointType "MOVE";
			};
			
			sleep 5;
		};	
	};
};

//Main task
private _missionName = "FU_mission_" + str(missionNamespace getVariable "FU_completedMissions");
private _taskName = "FU_taskLogi_" + str(missionNamespace getVariable "FU_completedMissions");
_task = [_friendlySide, [_taskName + "_1", _missionName], [format["Deliver %1 to %2 with any means you like.", _taskType, _missionName], format["Deliver %1", _taskType], ""], _taskPos, "CREATED", 1, true, "container", false] call BIS_fnc_taskCreate;
_tracker = [_friendlySide, [_taskName + "_2", _missionName], ["Cargo tracker", format["TRACKER: %1", _cargoName], ""], cargo, "CREATED", 1, true, "box", true] call BIS_fnc_taskCreate;
_deliverer = [_friendlySide, [_taskName + "_3", _missionName], ["Cargo deliverer's tracker.", format["ASSIGNED DELIVERER: %1", name _caller], ""], _caller, "CREATED", 1, true, "meet", true] call BIS_fnc_taskCreate;

//Enemy Reinforcements
private _trigger = createTrigger ["EmptyDetector", _taskPos, false];
_trigger setTriggerActivation ["ANYPLAYER", "PRESENT", false];
_trigger setTriggerArea [1000, 1000, 0, false, 200];
_trigger setTriggerStatements ["this", "", ""];

waitUntil {!alive cargo || triggerActivated _trigger};

//Spawn Units
_spawnUnits = [_taskPos, _factionComp_F, 0, 10, 100] spawn FU_fnc_spawnDefenders;
waitUntil{scriptDone _spawnUnits};
private _enemyPos = [_taskPos, 500, 700, 10, 0, 0.4, 0, [], []] call BIS_fnc_findSafePos;
_spawnUnits = [_enemyPos, _factionComp_E, 2, 50, _taskPos] spawn FU_fnc_spawnAttackers;
waitUntil{scriptDone _spawnUnits};
_spawnUnits = [_enemyPos, _factionComp_E, 7, 50, _taskPos] spawn FU_fnc_spawnAttackers;
waitUntil{scriptDone _spawnUnits};

//Condition
while {true} do {
	private _distance = (getPos cargo) distance _taskPos;
	
	if(_distance <= 50) exitWith {
		[_task, 'SUCCEEDED', true] call BIS_fnc_taskSetState;
		[_tracker, 'SUCCEEDED', true] call BIS_fnc_taskSetState;
		[_deliverer, 'SUCCEEDED', true] call BIS_fnc_taskSetState;
	};
	
	if(!alive cargo) exitWith {
		[_task, 'FAILED', true] call BIS_fnc_taskSetState;
		[_tracker, 'FAILED', true] call BIS_fnc_taskSetState;
		[_deliverer, 'FAILED', true] call BIS_fnc_taskSetState;
	};
	
	sleep 5;
};

private _completedTasks = missionNamespace getVariable "FU_completedTasks";
_completedTasks = _completedTasks + 1;
missionNamespace setVariable ["FU_completedTasks", _completedTasks, true];

deleteMarker _markerDeliveryPoint;
deleteMarker _markerExitPoint;