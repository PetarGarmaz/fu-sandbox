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
private _objects = [_taskPos, 0, call (compile (preprocessFileLineNumbers "Compositions\compRT.sqf"))] call BIS_fnc_ObjectsMapper;

//Place Minefield
for "_i" from 1 to 100 do {
	private _minePos = [_taskPos, 30, 70, 1, 0, 0, 0, [], []] call BIS_fnc_findSafePos;
	private _mine = createVehicle ["APERSMine_Range_Ammo", _minePos, [], 0, "CAN_COLLIDE"];
	_enemySide revealMine _mine;
};

//Place an RT
private _rt = createVehicle ["Land_TTowerBig_2_F", _taskPos, [], 0, "CAN_COLLIDE"];
_rt setVariable ["FU_isDisabled", false, true];
_rt setVectorUp [0,0,1];

//Find the switch
private _switch = nearestObject [_taskPos, "Land_TransferSwitch_01_F"];
_switch animateSource["SwitchPosition", 1];
_switch animateSource["SwitchLight", 1];
_switch animateSource["Power_1", 1];
_switch animateSource["Power_2", 1];

[_switch, ["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\types\use_ca.paa'/> Disable the Radio Tower", {
	params ["_target", "_caller", "_actionId", "_arguments"];
	private _rt = _arguments select 0;

	_target animateSource["SwitchPosition", 0];
	_target animateSource["SwitchLight", 0];
	_target animateSource["Power_1", 0];
	_target animateSource["Power_2", 0];
	
	[_target] remoteExec ["removeAllActions", 0, true];

	_rt setVariable ["FU_isDisabled", true, true];
}, [_rt], 1.5, true, true, "", "true", 3]] remoteExec ["addAction", -2, true];

//Danger
[_rt, _enemySide, _taskPos] spawn {
	params ["_rt", "_enemySide", "_taskPos"];

	private _vehicle = objNull;
	private _vehicleGroup = [];

	while {alive _rt && !(_rt getVariable "FU_isDisabled")} do {
		private _nearPlayers = allPlayers inAreaArray [_taskPos, 2000, 2000, 0, false, -1];

		if(count _nearPlayers > 0) then {
			{
				private _target = _x;

				if(_enemySide knowsAbout _target == 4) then {
					//Player has a plane
					if(vehicle _target isKindOf "Plane") exitWith {
						if(isNull _vehicle) then {
							["StatusReport", ["Enemy CAS inbound!", "plane"]] remoteExecCall ["BIS_fnc_showNotification", 0];
					
							private _factionComp = [_enemySide] call FU_fnc_getFactionCompositions;
							private _vehicleComp = _factionComp select 1;
							private _vehicleType = _vehicleComp select 4;

							_pos = [(getPos _target select 0) + 7000, (getPos _target select 1), 200];	
							_vehicleGroup = createGroup [_enemySide, true];
							_vehicle = createVehicle [_vehicleType, _pos, [], 0, "FLY"];
							_vehicleGroup = createVehicleCrew _vehicle;
							_vehicle flyInHeightASL [500, 500, 700];

							_sad = _vehicleGroup addWaypoint [[(getPos _target select 0), (getPos _target select 1), 200], 0];
							_sad setWaypointType "SAD";
							
							[_vehicle] spawn {
								params ["_vehicle"];
								waitUntil{sleep 5; !alive _vehicle};
								["StatusReport", ["Enemy CAS has been neutralized!", "plane"]] remoteExecCall ["BIS_fnc_showNotification", 0];
							};
						};
					};

					//Player has a helicopter
					if(vehicle _x isKindOf "Helicopter") exitWith {
						if(isNull _vehicle) then {
							["StatusReport", ["Enemy CAS inbound!", "heli"]] remoteExecCall ["BIS_fnc_showNotification", 0];
					
							private _factionComp = [_enemySide] call FU_fnc_getFactionCompositions;
							private _vehicleComp = _factionComp select 1;
							private _vehicleType = _vehicleComp select 3;

							_pos = [(getPos _target select 0) + 3000, (getPos _target select 1), 200];	
							_vehicleGroup = createGroup [_enemySide, true];
							_vehicle = createVehicle [_vehicleType, _pos, [], 0, "FLY"];
							_vehicleGroup = createVehicleCrew _vehicle;

							_sad = _vehicleGroup addWaypoint [[(getPos _target select 0), (getPos _target select 1), 200], 0];
							_sad setWaypointType "SAD";
							
							[_vehicle] spawn {
								params ["_vehicle"];
								waitUntil{sleep 5; !alive _vehicle};
								["StatusReport", ["Enemy CAS has been neutralized!", "heli"]] remoteExecCall ["BIS_fnc_showNotification", 0];
							};
						};
					};
				};
			}foreach _nearPlayers;
		};

		sleep 60;
	};
};

//Task
private _missionName = "FU_mission_" + str(missionNamespace getVariable "FU_completedMissions");
private _taskName = "FU_taskRT_" + str(missionNamespace getVariable "FU_completedMissions");
_task = [_friendlySide, [_taskName, _missionName], ["The enemy has set up a Radio Tower here.", "Disable or Destroy Radio Tower", ""], _taskPos, "CREATED", 1, true, "destroy", true] call BIS_fnc_taskCreate;

//Condition
waitUntil{sleep 5; _rt getVariable "FU_isDisabled" || !alive _rt};

[_task, 'SUCCEEDED', true] call BIS_fnc_taskSetState;

private _completedTasks = missionNamespace getVariable "FU_completedTasks";
_completedTasks = _completedTasks + 1;
missionNamespace setVariable ["FU_completedTasks", _completedTasks, true];