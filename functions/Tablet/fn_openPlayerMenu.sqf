params ["_mode"];

disableSerialization;

switch _mode do {
	case "INIT": {
		closeDialog 2;
		createDialog "FU_PlayerMenu";

		_display = findDisplay 4600;

		_stats = _display displayCtrl 4604;
		_vehicles = _display displayCtrl 4605;
		_arsenal = _display displayCtrl 4606;
		_missions = _display displayCtrl 4607;
		_settings = _display displayCtrl 4608;
		_close = _display displayCtrl 4609;

		// Stats --------------------------------------------------------------------------
		_statsAction = _stats ctrlAddEventHandler ["ButtonClick", {
			params ["_control"];
			["STATS"] spawn FU_fnc_openPlayerMenu;
		}];

		// Vehicles --------------------------------------------------------------------------
		_vehiclesAction = _vehicles ctrlAddEventHandler ["ButtonClick", {
			params ["_control"];
			["VEHICLES"] spawn FU_fnc_openPlayerMenu;
		}];

		// Arsenal --------------------------------------------------------------------------
		_arsenalAction = _arsenal ctrlAddEventHandler ["ButtonClick", {
			params ["_control"];
			["ARSENAL"] spawn FU_fnc_openPlayerMenu;
		}];

		// Missions --------------------------------------------------------------------------
		_missionsAction = _missions ctrlAddEventHandler ["ButtonClick", {
			params ["_control"];
			["MISSIONS"] spawn FU_fnc_openPlayerMenu;			
		}];

		// Settings --------------------------------------------------------------------------
		_settingsAction = _settings ctrlAddEventHandler ["ButtonClick", {
			params ["_control"];
			["SETTINGS"] spawn FU_fnc_openPlayerMenu;	
		}];

		// Close --------------------------------------------------------------------------
		_closeAction = _close ctrlAddEventHandler ["ButtonClick", {
			params ["_control"];

			closeDialog 2;
		}];
	};

	case "STATS": {
		closeDialog 2;
		createDialog "FU_Stats";

		_display = findDisplay 4601;

		_kills = _display displayCtrl 4604;
		_deaths = _display displayCtrl 4605;
		_kdr = _display displayCtrl 4606;
		_shots = _display displayCtrl 4607;
		_spk = _display displayCtrl 4608;
		_maxLifetime = _display displayCtrl 4609;
		_close = _display displayCtrl 4616;
		_back = _display displayCtrl 4617;

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
			_statText = _display displayCtrl (4610 + _i);
			_stats = _allStats select _i;
			
			_text = _stats select 0;
			_value = _stats select 1;
		
			_statText ctrlSetStructuredText parseText format["<t align= ""center"" valign= ""middle"" size=""2.5"">%1</t> <br/> <t align= ""center"" valign= ""middle"" size=""1"">%2</t>", [_value, 1] call BIS_fnc_cutDecimals, _text];
		};

		_closeAction = _close ctrlAddEventHandler ["ButtonClick", {
			params ["_control"];

			closeDialog 2;
		}];

		_backAction = _back ctrlAddEventHandler ["ButtonClick", {
			params ["_control"];

			closeDialog 2;
			["INIT"] spawn FU_fnc_openPlayerMenu;
		}];
	};

	case "VEHICLES": {
		closeDialog 2;
		createDialog "FU_VehiclesMenu";

		_display = findDisplay 4602;

		_garage = _display displayCtrl 4604;
		_manager = _display displayCtrl 4605;
		_request = _display displayCtrl 4606;
		_close = _display displayCtrl 4607;
		_back = _display displayCtrl 4608;

		_requestAction = _request ctrlAddEventHandler ["ButtonClick", {
			params ["_control"];

			(findDisplay 4602) closeDisplay 2;

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
		}];

		_garageAction = _garage ctrlAddEventHandler ["ButtonClick", {
			params ["_control"];

			closeDialog 2;

			//Check if player is not in vehicle
			if(vehicle player == player) then {
				//Find nearest vehicle spawn
				private _vehicleSpawns = allMapMarkers select {'FU_VehicleSpawn_' in _x};
				private _closestVehicleSpawn = [_vehicleSpawns, player] call BIS_fnc_nearestPosition;
				
				//Vehicle spawns found, check if player is close enough to it to spawn vehicles
				if(player getVariable 'FU_inSafeZone') then {
					_garageScript = [_closestVehicleSpawn, player, markerText _closestVehicleSpawn] spawn FU_fnc_vehicleGarage;
				} else {
					hint "You're too far from any Virtual Garage spawns!";
				};
			} else {
				hint "You're currently inside a vehicle!";
			};
		}];

		_managerAction = _manager ctrlAddEventHandler ["ButtonClick", {
			params ["_control"];

			closeDialog 2;
			_managerScript = [player] spawn FU_fnc_vehicleManager;
		}];

		_closeAction = _close ctrlAddEventHandler ["ButtonClick", {
			params ["_control"];
			closeDialog 2;
		}];

		_backAction = _back ctrlAddEventHandler ["ButtonClick", {
			params ["_control"];

			closeDialog 2;
			["INIT"] spawn FU_fnc_openPlayerMenu;
		}];
	};

	case "ARSENAL": {
		closeDialog 2;

		if(player getVariable 'FU_inSafeZone') then {
			[player, player, true] call ace_arsenal_fnc_openBox;
		} else {
			hintC 'Unable to open arsenal, you are not in the safe zone.';
		};	
	};

	case "MISSIONS": {
		closeDialog 2;
		[Officer_WEST_1, player] spawn FU_fnc_missionGenerator;		
	};

	case "SETTINGS": {
		closeDialog 2;
		createDialog "FU_Settings";

		_display = findDisplay 4603;

		_pl = _display displayCtrl 4604;
		_medic = _display displayCtrl 4605;
		_engi = _display displayCtrl 4606;
		_tp = _display displayCtrl 4607;
		_close = _display displayCtrl 4608;
		_back = _display displayCtrl 4609;

		_plAction = _pl ctrlAddEventHandler ["ButtonClick", {
			params ["_control"];

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
		}];

		_medicAction = _medic ctrlAddEventHandler ["ButtonClick", {
			params ["_control"];

			player setVariable ['ace_medical_medicClass', 1, true];
			systemChat '[LOCAL]: You have been promoted to a medic!';

			closeDialog 2;
		}];

		_engiAction = _engi ctrlAddEventHandler ["ButtonClick", {
			params ["_control"];

			player setVariable ['ACE_IsEngineer', 2, true];
			systemChat '[LOCAL]: You have been promoted to an engineer!';

			closeDialog 2;
		}];

		_tpAction = _tp ctrlAddEventHandler ["ButtonClick", {
			params ["_control"];

			if(player getVariable 'FU_inSafeZone') then {
				[] spawn {"FU_FadeLayer" cutText ["", "BLACK OUT", 1]; sleep 1; player setPos (getMarkerPos "respawn_guerrila"); sleep 1; "FU_FadeLayer" cutText ["", "BLACK IN", 1];};
			} else {
				hintC 'Unable to open teleport to HQ, you are not in the safe zone.';
			};

			closeDialog 2;
		}];

		_closeAction = _close ctrlAddEventHandler ["ButtonClick", {
			params ["_control"];

			closeDialog 2;
		}];

		_backAction = _back ctrlAddEventHandler ["ButtonClick", {
			params ["_control"];

			closeDialog 2;
			["INIT"] spawn FU_fnc_openPlayerMenu;
		}];
	};
};