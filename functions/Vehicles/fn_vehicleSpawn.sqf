params ["_marker", "_vehicleParams"];

private _caller = player;
private _callerName = name _caller;

private _spawnedVehicles = _caller getVariable "FU_vehicleGarage";
private _vehicleName = format["[%1]: %2", count _spawnedVehicles + 1, _vehicleParams select 0];

private _vehicleDisplayName = _vehicleParams select 0;
private _vehicleType = _vehicleParams select 1;
private _vehicleSettings = _vehicleParams select 2;
private _vehiclePylons = _vehicleParams select 3;

private _vehicleTextures = _vehicleSettings select 0;
private _vehicleComponents = _vehicleSettings select 1;

private _vehiclePos = getMarkerPos _marker;
private _objectType = _vehicleType call BIS_fnc_objectType;

//Check if vehicle is a B O A T
if("Ship" in _objectType || "Submarine" in _objectType) then {
	private _boatSpawns = allMapMarkers select {"BoatSpawn" in _x};
	private _boatSpawn = [_boatSpawns, getPos _caller] call BIS_fnc_nearestPosition;
			
	_vehiclePos = getMarkerPos _boatSpawn;
};

//If queue exists player waits until the queue gets freed
if(missionNamespace getVariable "FU_vehicleQueue" select 0 != _callerName) then {
	private _actionID = player addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\letters\X_ca.paa'/> Quit the Vehicle Queue", { 
		params ["_target", "_caller", "_actionId", "_arguments"];

		_currentQueue = missionNamespace getVariable "FU_vehicleQueue";
		_currentQueue = _currentQueue - [name _caller];
		missionNamespace setVariable ["FU_vehicleQueue", _currentQueue, true];

		systemChat "[LOCAL]: You have been removed from the queue!";

		_target removeAction _actionId;
	}, nil, 1.5, true, true, "", "true", 5];

	systemChat format["[LOCAL]: You have been placed in the vehicle queue. Your position is: %1.", count(missionNamespace getVariable "FU_vehicleQueue") - 1];
	waitUntil{missionNamespace getVariable "FU_vehicleQueue" select 0 == _callerName || !(_callerName in (missionNamespace getVariable "FU_vehicleQueue"))};
	player removeAction _actionId;
};

//In case player quits queue
if(_callerName in (missionNamespace getVariable "FU_vehicleQueue")) then {
	//If queue is free, but vehicles still exist on the pad, wait until that is free
	private _queueMessage = false;
	while {true} do {
		private _vehicleList = _vehiclePos nearEntities [["Ship", "LandVehicle", "Air"], 25];
		
		if(count _vehicleList > 0) then {
			if(!_queueMessage) then {systemChat "[LOCAL]: The vehicle spawn is not clear, please wait until it gets cleared up!"; _queueMessage = true;};
			sleep 1;
		} else {
			break;
		};
	};

	//Create new vehicle
	private _newVehicle = createVehicle [_vehicleType, _vehiclePos, [], 0, "CAN_COLLIDE"];
	_newVehicle setDir (markerDir _marker);
	_newVehicle setPos [_vehiclePos select 0, _vehiclePos select 1, 0.25];
	sleep 0.5;
	_newVehicle setDamage 0;

	//Load vehicle cosmetics, textures and pylons
	[_newVehicle, [], _vehicleComponents] call BIS_fnc_initVehicle;

	{_newVehicle setObjectTextureGlobal [_forEachIndex, _x];}foreach _vehicleTextures;

	{
		_index = _x select 0;
		_turret = _x select 2;
		_pylon = _x select 3;
		_newVehicle setPylonLoadout [_index, _pylon, true, _turret];
	}foreach _vehiclePylons;

	//Check if vehicle is autonomous
	if(_objectType select 0 == "VehicleAutonomous") then {
		_uavObject = createVehicleCrew _newVehicle;
		_uavGroup = createGroup [side _caller, true];
		_newVehicle joinAs [_uavGroup, 0];
	};

	//Check if vehicle is one of those interesting exceptionals, enable drag on them and give them ability to see your laser target
	_bannedExceptions = ["B_SAM_System_02_F", "B_Ship_MRLS_01_F", "B_SAM_System_01_F", "B_AAA_System_01_F", "B_Ship_Gun_01_F"];
	if(_vehicleType in _bannedExceptions) then {
		[_newVehicle, true, [0, 3.5, 0.5], 180] remoteExecCall ["ace_dragging_fnc_setCarryable", 0];
		[_newVehicle, 4] remoteExecCall ["ace_cargo_fnc_setSize", 0];
		
		[_newVehicle] spawn {
			params ["_newVehicle"];
			
			while {alive _newVehicle} do {
				_crewman = crew _newVehicle select 0;
				_target = laserTarget player;
				
				if(!isNull(_target)) then {
					[resistance, [_target, 300]] remoteExec ["reportRemoteTarget", 0];
					_target confirmSensorTarget [resistance, true];
				};
			};
		};
	};

	//Set new vehicle as a part of player's garage
	private _vehicleGarage = _caller getVariable "FU_vehicleGarage";
	_vehicleGarage pushBack [_newVehicle, _vehicleName, _vehicleType, _vehicleSettings, _vehiclePylons];
	_caller setVariable ["FU_vehicleGarage", _vehicleGarage, true];
	_newVehicle setVariable ["FU_isPersonalVehicle", true, true];

	//If vehicle dies, it won't be available to be managed anymore, unless it is stored, it will also be removed from player spawned vehicles
	[_caller, [_newVehicle, _vehicleName, _vehicleType, _vehicleSettings, _vehiclePylons]] spawn {
		params ["_caller", "_vehicle"];
		
		waitUntil{!alive (_vehicle select 0)};
		
		private _vehicleGarage = player getVariable "FU_vehicleGarage";
		_vehicleGarage = _vehicleGarage - [_vehicle];
		_caller setVariable ["FU_vehicleGarage", _vehicleGarage, true];
	};

	//Spawn player in vehicle
	_caller moveInAny _newVehicle;
	[format ["[SERVER]: %1 pulled %2 from %3.", _callerName, _vehicleDisplayName, markerText _marker]] remoteExec ["systemChat",0];

	//Remove player from queue
	private _currentQueue = missionNamespace getVariable "FU_vehicleQueue";
	_currentQueue = _currentQueue - [_callerName];
	missionNamespace setVariable ["FU_vehicleQueue", _currentQueue, true];
};
