params ["_marker", "_caller"];

private _callerPos = getPosASL _caller;
private _callerName = name _caller;

disableSerialization;

//Check if player has too many vehicles spawned
if(count (_caller getVariable "FU_vehicleGarage") >= 3) then {
	systemChat "[LOCAL]: You're have spawned too many vehicles!";
} else {
	//Add player to queue, if player is in the queue already, don't add him
	private _currentQueue = missionNamespace getVariable "FU_vehicleQueue";

	if(_callerName in _currentQueue) then {
		systemChat "[LOCAL]: You're already queued up! Please wait your turn!";
	} else {
		_currentQueue pushBack _callerName;
		missionNamespace setVariable ["FU_vehicleQueue", _currentQueue, true];
	
		//Create special pad for each person depending on the queue
		_queueCount = count(_currentQueue);
		_queueRow = 0;

		if(_queueCount > 14) then {_queueRow = 1};

		private _garagePadPos = [(getMarkerPos "FU_vehicleViewer" select 0) + _queueCount * 50, (getMarkerPos "FU_vehicleViewer" select 1) + _queueRow * 50, 0];
		private _garagePad = createVehicle ["Land_HelipadEmpty_F", _garagePadPos, [], 0, "CAN_COLLIDE"];

		//Open garage, then wait until player closes the garage interface
		["Open", [true, _garagePad]] call BIS_fnc_garage;  sleep 1;
		missionnamespace setvariable ["BIS_fnc_arsenal_fullGarage", false, true];
		uiNamespace setVariable ["BIS_fnc_arsenal_toggleSpace", false];
		waitUntil{sleep 1; isNull(uiNamespace getVariable ["BIS_fnc_arsenal_cam", objNull])};
		systemChat "[SERVER]: Pulling vehicle now.";
		sleep 0.5;
		deleteVehicle _garagePad;
		sleep 0.5;

		//See what vehicles was spawned
		private _vehicleList = _garagePadPos nearEntities [["Ship", "LandVehicle", "Air"], 25];

		if(count _vehicleList == 0) then {
			systemChat "[SERVER]: Vehicle pull failed, no vehicles detected!";

			_currentQueue = missionNamespace getVariable "FU_vehicleQueue";
			_currentQueue = _currentQueue - [_callerName];
			missionNamespace setVariable ["FU_vehicleQueue", _currentQueue, true];
		};

		{
			//Get the vehicle information from the local garage
			private _vehicleType = typeOf _x;
			private _vehicleName = getText (configFile >> "CfgVehicles" >> _vehicleType >> "displayName");
			private _vehiclePos = getMarkerPos _marker;
			private _objectType = _vehicleType call BIS_fnc_objectType;
			
			//Variables for banned vehicles
			private _spawnVehicle = true;
			private _bannedVehicles = ["rhs_9k79", "TU95MS"];
			private _bannedExceptions = ["B_SAM_System_02_F", "B_Ship_MRLS_01_F", "B_SAM_System_01_F", "B_AAA_System_01_F", "B_Ship_Gun_01_F"];
			
			//Delete the any of those weird "AI Crewmen"
			private _crew = crew _x;
			{deleteVehicle _x;} forEach _crew;
			
			//Save vehicle cosmetics and pylons
			private _vehicleTextures = getObjectTextures _x;
			private _vehicleSettings = [_x] call BIS_fnc_getVehicleCustomization;
			_vehicleSettings set [0, _vehicleTextures];
			private _vehiclePylons = getAllPylonsInfo _x;
			
			deleteVehicle _x;
			
			sleep 1;

			//Check if vehicle is an exception to ban
			_spawnVehicle = ({_x in _vehicleType} count _bannedVehicles) == 0;

			if(!_spawnVehicle) then {
				systemChat "[SERVER]: You are not allowed to spawn this vehicle!";
				
				//Remove player from queue if they get a banned vehicle
				_currentQueue = missionNamespace getVariable "FU_vehicleQueue";
				_currentQueue = _currentQueue - [_callerName];
				missionNamespace setVariable ["FU_vehicleQueue", _currentQueue, true];
			} else {
				private _deadVehicles = allDead inAreaArray [_callerPos, 50, 50, 0, false, -1];
				{deleteVehicle _x} foreach _deadVehicles;
				[_marker, [_vehicleName, _vehicleType, _vehicleSettings, _vehiclePylons]] spawn FU_fnc_vehicleSpawn;
			};
			
			//Prevent player from getting stuck in the desert
			_caller setPosASL _callerPos;
		} forEach _vehicleList;
	};
};

true;