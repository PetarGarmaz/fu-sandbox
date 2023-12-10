params ["_displayType"];

closeDialog 2;
sleep 0.1;

private _user = player;

//Lock
if(_displayType == 0) then {
	_year = date select 0;
	_month = date select 1;
	_day = date select 2;

	_dayNum = [_day, 0] call FU_fnc_dateToText;
	_dayText = [_day, 2] call FU_fnc_dateToText;
	_month = [_month, 1] call FU_fnc_dateToText;
	
	createDialog "FUT_Lock";

	_dateCtrl = (findDisplay 4600) displayCtrl 4612;
	
	_powerCtrl = (findDisplay 4600) displayCtrl 4602;
	_muteButtonCtrl = (findDisplay 4600) displayCtrl 4603;
	_lockCtrl = (findDisplay 4600) displayCtrl 4613;

	_dateCtrl ctrlSetStructuredText parseText format["<t size='0.7' valign='middle' align='center'>%1, %2 %3, %4</t>", _dayText, _month, _dayNum, _year];
	
	_powerAction = _powerCtrl buttonSetAction "
		_currentSetting = player getVariable 'FUT_muteSound';
		if(!_currentSetting)then {playSound 'Orange_Timeline_FadeOut';};

		closeDialog 2;
	";
	
	_muteButtonAction = _muteButtonCtrl buttonSetAction "
		_currentSetting = player getVariable 'FUT_muteSound';
		_currentSetting = !_currentSetting;
		player setVariable ['FUT_muteSound', _currentSetting];
	";

	_unlockAction = _lockCtrl buttonSetAction "
		_currentSetting = player getVariable 'FUT_muteSound';
		if(!_currentSetting)then {playSound 'Orange_Timeline_iconFadeIn';};

		[1] spawn FU_fnc_openTablet;
	";
	
	_timeLoop = [] spawn {
		while {dialog} do {
			_hour = date select 3;
			_minute = date select 4;
			
			_hour = [_hour, "HH"] call BIS_fnc_timeToString;
			_minute = [_minute, "HH"] call BIS_fnc_timeToString;
			
			_timeCtrl = (findDisplay 4600) displayCtrl 4611;
			_timeCtrl ctrlSetStructuredText parseText format["<t size='4' valign='middle' align='center'>%1:%2</t>", _hour, _minute];
			sleep 5;
		};
	};
	
	_muteLoop = [] spawn {
		_muteCtrl = (findDisplay 4600) displayCtrl 4610;
	
		while {dialog} do {
			_currentSetting = player getVariable 'FUT_muteSound';
			
			if(_currentSetting) then {
				_muteCtrl ctrlSetText "Images\GUI\FUT_Status_Mute.paa";
			} else {
				_muteCtrl ctrlSetText "";
			};
			
			waitUntil{sleep 1; player getVariable 'FUT_muteSound' != _currentSetting || !dialog};
		};
	};	
};

//Stats
if(_displayType == 1) then {	
	createDialog "FUT_HomeStats";

	_display = findDisplay 4601;

	_powerCtrl = _display displayCtrl 4602;
	_muteButtonCtrl = _display displayCtrl 4603;

	_app_1 = _display displayCtrl 4613; 
	_app_2 = _display displayCtrl 4614;
	_app_3 = _display displayCtrl 4615; _app_3 ctrlEnable false;
	_app_4 = _display displayCtrl 4616;
	_app_5 = _display displayCtrl 4617;

	_kills = player getVariable "FU_totalKills";
	_deaths = (getPlayerScores player) select 4;
	_kdr = 0;
	_shots = player getVariable "FU_shotsFired";
	_spk = 0;
	_maxLifetime = [(player getVariable "FU_maxLifeTime")/60, 0] call BIS_fnc_cutDecimals;
	
	if(_kills == 0) then {_spk = _shots;} else {_spk = _shots / _kills;};
	if(_deaths == 0) then {_kdr = _kills;} else {_kdr = _kills/_deaths};
	
	_spk = [_spk, 1] call BIS_fnc_cutDecimals;
	
	_allStats = [["Kills", _kills], ["Deaths", _deaths], ["KDR", _kdr], ["Shots Fired", _shots], ["SPK", _spk], ["Max Lifetime", _maxLifetime]];
	
	for "_i" from 0 to 5 do {
		_statText = _display displayCtrl (4625 + _i);
		_stats = _allStats select _i;
		
		_text = _stats select 0;
		_value = _stats select 1;
	
		_statText ctrlSetStructuredText parseText format["<t align= ""center"" valign= ""middle"" size=""2.5"">%1</t> <br/> <t align= ""center"" valign= ""middle"" size=""1"">%2</t>", [_value, 1] call BIS_fnc_cutDecimals, _text];
	};

	_arsenalAction = _app_1 buttonSetAction "
		closeDialog 2;

		if(player getVariable 'FU_inSafeZone') then {
			[player, player, true] call ace_arsenal_fnc_openBox;
		} else {
			hint 'Unable to open arsenal, you are not in the safe zone.';
		};
	";

	_garageAction = _app_2 buttonSetAction "
		[2] spawn FU_fnc_openTablet;
	";

	_statsAction = _app_3 buttonSetAction "
		[1] spawn FU_fnc_openTablet;
	";

	_missionsAction = _app_4 buttonSetAction "
		closeDialog 2;

		_user = player;
		[Officer_WEST, player] spawn FU_fnc_missionGenerator;
	";

	_settingsAction = _app_5 buttonSetAction "
		_user = player;
		[5] spawn FU_fnc_openTablet;
	";

	_powerAction = _powerCtrl buttonSetAction "
		_currentSetting = player getVariable 'FUT_muteSound';
		if(!_currentSetting)then {playSound 'Orange_Timeline_FadeOut';};

		closeDialog 2;
	";
	
	_muteButtonAction = _muteButtonCtrl buttonSetAction "
		_currentSetting = player getVariable 'FUT_muteSound';
		_currentSetting = !_currentSetting;
		player setVariable ['FUT_muteSound', _currentSetting];
	";
	
	_timeLoop = [] spawn {	
		while {dialog} do {
			_hour = date select 3;
			_minute = date select 4;
			
			_hour = [_hour, "HH"] call BIS_fnc_timeToString;
			_minute = [_minute, "HH"] call BIS_fnc_timeToString;
			
			_timeCtrl = (findDisplay 4601) displayCtrl 4611;
			_timeCtrl ctrlSetStructuredText parseText format["<t size='1' valign='middle' align='center'>%1:%2</t>", _hour, _minute];
			sleep 5;
		};
	};
	
	_muteLoop = [] spawn {
		_muteCtrl = (findDisplay 4601) displayCtrl 4610;
	
		while {dialog} do {
			_currentSetting = player getVariable 'FUT_muteSound';
			
			if(_currentSetting) then {
				_muteCtrl ctrlSetText "Images\GUI\FUT_Status_Mute.paa";
			} else {
				_muteCtrl ctrlSetText "";
			};
			
			waitUntil{sleep 1; player getVariable 'FUT_muteSound' != _currentSetting || !dialog};
		};
	};
};

//Garage
if(_displayType == 2) then {	
	createDialog "FUT_HomeGarage";

	_display = findDisplay 4602;

	_powerCtrl = _display displayCtrl 4602;
	_muteButtonCtrl = _display displayCtrl 4603;

	_app_1 = _display displayCtrl 4613; 
	_app_2 = _display displayCtrl 4614; _app_2 ctrlEnable false;
	_app_3 = _display displayCtrl 4615; 
	_app_4 = _display displayCtrl 4616;
	_app_5 = _display displayCtrl 4617;

	_virtualGarage = _display displayCtrl 4619;
	_garageManager = _display displayCtrl 4620;
	_transportRequest = _display displayCtrl 4621;

	_arsenalAction = _app_1 buttonSetAction "
		closeDialog 2;

		if(player getVariable 'FU_inSafeZone') then {
			[player, player, true] call ace_arsenal_fnc_openBox;
		} else {
			hint 'Unable to open arsenal, you are not in the safe zone.';
		};
	";

	_statsAction = _app_3 buttonSetAction "
		[1] spawn FU_fnc_openTablet;
	";

	_missionsAction = _app_4 buttonSetAction "
		closeDialog 2;

		[Officer_WEST, player] spawn FU_fnc_missionGenerator;
	";

	_settingsAction = _app_5 buttonSetAction "
		_user = player;
		[5] spawn FU_fnc_openTablet;
	";

	_powerAction = _powerCtrl buttonSetAction "
		_currentSetting = player getVariable 'FUT_muteSound';
		if(!_currentSetting)then {playSound 'Orange_Timeline_FadeOut';};

		closeDialog 2;
	";
	
	_muteButtonAction = _muteButtonCtrl buttonSetAction "
		_currentSetting = player getVariable 'FUT_muteSound';
		_currentSetting = !_currentSetting;
		player setVariable ['FUT_muteSound', _currentSetting];
	";

	_virtualAction = _virtualGarage buttonSetAction "
		[3] spawn FU_fnc_openTablet;
	";

	_managerAction = _garageManager buttonSetAction "
		closeDialog 2;
		_managerScript = [player] spawn FU_fnc_vehicleManager;
	";

	_transportAction = _transportRequest buttonSetAction "
		[4] spawn FU_fnc_openTablet;
	";
	
	_timeLoop = [] spawn {	
		while {dialog} do {
			_hour = date select 3;
			_minute = date select 4;
			
			_hour = [_hour, "HH"] call BIS_fnc_timeToString;
			_minute = [_minute, "HH"] call BIS_fnc_timeToString;
			
			_timeCtrl = (findDisplay 4602) displayCtrl 4611;
			_timeCtrl ctrlSetStructuredText parseText format["<t size='1' valign='middle' align='center'>%1:%2</t>", _hour, _minute];
			sleep 5;
		};
	};
	
	_muteLoop = [] spawn {
		_muteCtrl = (findDisplay 4602) displayCtrl 4610;
	
		while {dialog} do {
			_currentSetting = player getVariable 'FUT_muteSound';
			
			if(_currentSetting) then {
				_muteCtrl ctrlSetText "Images\GUI\FUT_Status_Mute.paa";
			} else {
				_muteCtrl ctrlSetText "";
			};
			
			waitUntil{sleep 1; player getVariable 'FUT_muteSound' != _currentSetting || !dialog};
		};
	};
};

//Spawn Vehicle
if(_displayType == 3) then {
	_user = player;

	//Check if player is not in vehicle
	if(vehicle player == player) then {
		//Find nearest vehicle spawn
		private _vehicleSpawns = allMapMarkers select {'FU_VehicleSpawn_' in _x};
		private _closestVehicleSpawn = [_vehicleSpawns, player] call BIS_fnc_nearestPosition;
		
		//Vehicle spawns found, check if player is close enough to it to spawn vehicles
		if(player getVariable 'FU_inSafeZone') then {
			[_user, 'Acts_listeningToRadio_In'] remoteExec ['playMoveNow', 0, true];
			_garageScript = [_closestVehicleSpawn, player, markerText _closestVehicleSpawn] spawn FU_fnc_vehicleGarage;
			waitUntil{scriptDone _garageScript};
		} else {
			hint "You're too far from any Virtual Garage spawns!";
		};
	} else {
		hint "You're currently inside a vehicle!";
	};
};

//Request pilots
if(_displayType == 4) then {
	_user = player;

	_onlinePilots = missionNamespace getVariable "FU_onlinePilots";
	
	//See if there are any pilots online
	if(count _onlinePilots > 0) then {		
		//Add caller to requests
		["TransportRequest", ["You have requested transport."]] call BIS_fnc_showNotification;
		
		//Notify pilots and update their tasks
		[] remoteExec ["FU_fnc_transportRequestUpdate", 2];
		{
			if(name _x in _onlinePilots) then {
				["TransportRequest", [format["%1 requested transport.", name _user]]] remoteExecCall ["BIS_fnc_showNotification", _x];
			};
		}foreach (call BIS_fnc_listPlayers);
	} else {
		hint "There are no pilots online.";
	};
};

//Settings
if(_displayType == 5) then {	
	createDialog "FUT_HomeSettings";

	_display = findDisplay 4604;

	_powerCtrl = _display displayCtrl 4602;
	_muteButtonCtrl = _display displayCtrl 4603;

	_app_1 = _display displayCtrl 4613; 
	_app_2 = _display displayCtrl 4614; 
	_app_3 = _display displayCtrl 4615; 
	_app_4 = _display displayCtrl 4616;
	_app_5 = _display displayCtrl 4617; _app_5 ctrlEnable false;

	_pl = _display displayCtrl 4619;
	_med = _display displayCtrl 4620;
	_eng = _display displayCtrl 4621;

	_arsenalAction = _app_1 buttonSetAction "
		closeDialog 2;

		if(player getVariable 'FU_inSafeZone') then {
			[player, player, true] call ace_arsenal_fnc_openBox;
		} else {
			hint 'Unable to open arsenal, you are not in the safe zone.';
		};
	";

	_statsAction = _app_3 buttonSetAction "
		[1] spawn FU_fnc_openTablet;
	";

	_missionsAction = _app_4 buttonSetAction "
		closeDialog 2;

		[Officer_WEST, player] spawn FU_fnc_missionGenerator;
	";

	_settingsAction = _app_5 buttonSetAction "
		[5] spawn FU_fnc_openTablet;
	";

	_powerAction = _powerCtrl buttonSetAction "
		_currentSetting = player getVariable 'FUT_muteSound';
		if(!_currentSetting)then {playSound 'Orange_Timeline_FadeOut';};

		closeDialog 2;
	";
	
	_muteButtonAction = _muteButtonCtrl buttonSetAction "
		_currentSetting = player getVariable 'FUT_muteSound';
		_currentSetting = !_currentSetting;
		player setVariable ['FUT_muteSound', _currentSetting];
	";

	_plAction = _pl buttonSetAction "
		switch (side player) do {
			case west: {
				PL_west = player;
				publicVariable 'PL_west';
			};
			
			case east: {
				PL_east = player;
				publicVariable 'PL_east';
			};
			
			case resistance: {
				PL_guer = player;
				publicVariable 'PL_guer';
			};
		};
	
		systemChat '[LOCAL]: You have been promoted to the platoon leader!';

		closeDialog 2;
	";

	_medAction = _med buttonSetAction "
		player setVariable ['ace_medical_medicClass', 1, true];
		systemChat '[LOCAL]: You have been promoted to a medic!';

		closeDialog 2;
	";

	_engAction = _eng buttonSetAction "
		player setVariable ['ACE_IsEngineer', 2, true];
		systemChat '[LOCAL]: You have been promoted to an engineer!';

		closeDialog 2;
	";
	
	_timeLoop = [] spawn {	
		while {dialog} do {
			_hour = date select 3;
			_minute = date select 4;
			
			_hour = [_hour, "HH"] call BIS_fnc_timeToString;
			_minute = [_minute, "HH"] call BIS_fnc_timeToString;
			
			_timeCtrl = (findDisplay 4604) displayCtrl 4611;
			_timeCtrl ctrlSetStructuredText parseText format["<t size='1' valign='middle' align='center'>%1:%2</t>", _hour, _minute];
			sleep 5;
		};
	};
	
	_muteLoop = [] spawn {
		_muteCtrl = (findDisplay 4604) displayCtrl 4610;
	
		while {dialog} do {
			_currentSetting = player getVariable 'FUT_muteSound';
			
			if(_currentSetting) then {
				_muteCtrl ctrlSetText "Images\GUI\FUT_Status_Mute.paa";
			} else {
				_muteCtrl ctrlSetText "";
			};
			
			waitUntil{sleep 1; player getVariable 'FUT_muteSound' != _currentSetting || !dialog};
		};
	};
};