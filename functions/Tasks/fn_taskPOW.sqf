params ["_target", "_caller", ["_arguments", ["", [0,0,0], civilian]]];

//Find the mission location
private _missionName = _arguments select 0;
private _missionPos = _arguments select 1;

//Sides
private _friendlySide = side _target;
private _enemySide = _arguments select 2;
private _factionComp = [_enemySide] call FU_fnc_getFactionCompositions;
private _factionCompF = [_friendlySide] call FU_fnc_getFactionCompositions;
private _type = _factionCompF select 4;
sleep 1;

//Find building, fortify it and patrol
private _allBuildings = nearestObjects [_missionPos, ["House"], 750, true];
private _targetBuilding = _allBuildings select {count(_x buildingPos -1) >= 5};
private _buildingPos = [0,0,0];

if(count _targetBuilding > 0) then {
	_targetBuilding = selectRandom _targetBuilding;
	_buildingPos = getPos _targetBuilding;

	[_targetBuilding, "mil", true, false, false, 1] call ZEI_fnc_createTemplate;
	[_buildingPos, _factionComp, 0, 20, 100] call FU_fnc_spawnDefenders;
	[_buildingPos, _factionComp, 100, [10,10,0,false], "COMBAT"] call FU_fnc_spawnGarrison;

} else {
	//Spawn a building to act as a target building
	private _randomPos = [_missionPos, 250, 750, 10, 0, 0.1, 0, [], _missionPos] call BIS_fnc_findSafePos;

	_targetBuilding = "Land_HouseRuin_Small_02_F" createVehicle _randomPos;
	_buildingPos = _randomPos;

	[_targetBuilding, "mil", false, false, false, 1] call ZEI_fnc_createTemplate;
	[_buildingPos, _factionComp, 0, 20, 100] call FU_fnc_spawnDefenders;
	[_buildingPos, _factionComp, 75, [10,10,0,false], "COMBAT"] call FU_fnc_spawnGarrison;
};

//POW Setup
private _powPos = selectRandom (_targetBuilding buildingPos -1);
private _group = createGroup [_enemySide, true];
private _pow = _group createUnit [_type, _powPos, [], 0, "NONE"];

private _loadout = getUnitLoadout _pow;
private _face = face _pow;
private _name = name _pow;
private _side = side _pow;

_group setBehaviour "CARELESS"; 
_pow setCaptive true;
_pow setPos _powPos;
removeAllWeapons _pow;
(group _pow) setGroupIdGlobal [_name];
[_pow, true] remoteExec ["hideObject", 0, true];

private _agent = createAgent [_type, getPosASL _pow, [], 0, "CAN_COLLIDE"];
_agent setPosASL (getPosASL _pow);
_agent setDir (getDir _pow);
_agent disableAI "FSM";
_agent setBehaviour "CARELESS";
_agent setSpeedMode "FULL";

_agent setUnitLoadout _loadout;
[_agent, _face] remoteExec ["setFace", 0, true];
[_agent, true] call ACE_captives_fnc_setHandcuffed;
_agent setVariable ["FU_agentLeader", objNull, true];

//Task
private _missionName = "FU_mission_" + str(missionNamespace getVariable "FU_completedMissions");
private _taskName = "FU_taskPow_" + str(missionNamespace getVariable "FU_completedMissions");
_task = [_friendlySide, [_taskName, _missionName], ["Our friendly got himself captured and is now POW. We need to save him before he get executed.", "Unbind POW", ""], _buildingPos, "CREATED", 1, true, "help", true] call BIS_fnc_taskCreate;

//Condition
waitUntil {!captive _agent};

[_task, 'SUCCEEDED', true] call BIS_fnc_taskSetState;

//Escort
private _objective = getMarkerPos "respawn_guerrila";

_task = [_friendlySide, [_taskName + "_escort", _missionName], ["Our friendly got himself captured and is now POW. We need to save him before he get executed.", "Escort POW", ""], _objective, "CREATED", 1, true, "run", true] call BIS_fnc_taskCreate;

//Follow Action
[_agent ,[format["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\types\run_ca.paa'/> %1, follow me!", _name], {
	params ["_target", "_caller", "_actionId", "_arguments"];
	_pow = _arguments select 0;
	
	_target setVariable ["FU_agentLeader", _caller, true];
	_target setUnitPos "UP";
	
	[_pow, "Alright, I'm coming!"] remoteExec ["sideChat", 0];
}, [_pow], 6, true, true, "", "isNull(_target getVariable 'FU_agentLeader')", 5]] remoteExec ["addAction", 0, true];

//Stop Action
[_agent ,[format["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\types\run_ca.paa'/> %1, stop!", _name], {
	params ["_target", "_caller", "_actionId", "_arguments"];
	_pow = _arguments select 0;
	
	_target setVariable ["FU_agentLeader", objNull, true];
	_target setUnitPos "DOWN";
	
	[_pow, "Okay, I'll stop!"] remoteExec ["sideChat", 0];
}, [_pow], 6, true, true, "", "!isNull(_target getVariable 'FU_agentLeader')", 5]] remoteExec ["addAction", 0, true];

//Safe return
private _trigger = createTrigger ["EmptyDetector", _objective, false];
_trigger setTriggerArea [20, 20, 0, false, -1];
_trigger setTriggerActivation ["VEHICLE", "PRESENT", false];
_trigger triggerAttachVehicle [_agent];
_trigger setTriggerStatements ["this", "", ""];

//Main Loop
while {alive _agent && !triggerActivated _trigger} do {
	_leader = _agent getVariable "FU_agentLeader";
	
	if(!isNull _leader) then {
		_agent moveTo (getPos _leader);
	
		if(vehicle _leader != _leader && vehicle _agent == _agent) then {
			_agent moveInAny (vehicle _leader);
		};
		
		if(vehicle _leader == _leader && vehicle _agent != _agent) then {
			_agent action ["getOut", vehicle _agent];
		};
	};
	
	if(!alive _leader) then {
		_agent setVariable ["FU_agentLeader", objNull, true];
	};
	
	sleep 1;
};

_agent moveTo _objective;

if(alive _agent) then {
	[_pow, "Thanks for the escort!"] remoteExec ["sideChat", 0];
	[_task, 'SUCCEEDED', true] call BIS_fnc_taskSetState;

	waitUntil {speed (vehicle _agent) <= 2};
	_agent action ["getOut", vehicle _agent];
} else {
	[_pow, "*Gahhhhhh*...*Blurghhhhhh*...*Ughhhhhhhhhhhhhhhhhh*..."] remoteExec ["sideChat", 0];
	[_task, 'FAILED', true] call BIS_fnc_taskSetState;
};

private _completedTasks = missionNamespace getVariable "FU_completedTasks";
_completedTasks = _completedTasks + 1;
missionNamespace setVariable ["FU_completedTasks", _completedTasks, true];

sleep 10; 

deleteVehicle _agent;
deleteVehicle _pow;