params ["_terminal", "_type", ["_terminalSpawn", ""]]; //Types: "GARAGE", "TRANS"

if(_type == "GARAGE") then {
	_terminal addAction["<img image='\A3\ui_f\data\map\vehicleicons\iconVirtual_ca.paa'/> Vehicle garage", { 
		params ["_target", "_caller", "_actionId", "_arguments"];

		private _terminalSpawn = _arguments select 0;

		[_target, ["OMComputerReboot", 20]] remoteExec ["say3D", 0]; 
		[_target, ["OMIntelGrabPC_02", 20]] remoteExec ["say3D", 0];

		[_terminalSpawn, _caller] spawn FU_fnc_vehicleGarage;
	}, [_terminalSpawn], 1.5, true, true, "", "true", 5];

	_terminal addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\types\car_ca.paa'/> Vehicle Manager", { 
		params ["_target", "_caller", "_actionId", "_arguments"];

		private _terminalSpawn = _arguments select 0;

		[_target, ["OMComputerReboot", 20]] remoteExec ["say3D", 0]; 
		[_target, ["OMIntelGrabPC_02", 20]] remoteExec ["say3D", 0];

		[_caller] spawn FU_fnc_vehicleManager;
	}, [_terminalSpawn], 1.5, true, true, "", "true", 5];

	_terminal addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\types\heli_ca.paa'/> Request Transport", { 
		params ["_target", "_caller", "_actionId", "_arguments"];

		private _terminalSpawn = _arguments select 0;
		private _onlinePilots = missionNamespace getVariable "FU_onlinePilots";

		[_target, ["OMComputerReboot", 20]] remoteExec ["say3D", 0]; 
		[_target, ["OMIntelGrabPC_02", 20]] remoteExec ["say3D", 0];

		//See if there are any pilots online
		if(count _onlinePilots > 0) then {		
			//Add caller to requests
			["TransportRequest", ["You have requested transport."]] call BIS_fnc_showNotification;
			
			//Notify pilots and update their tasks
			[] remoteExec ["FU_fnc_transportRequestUpdate", 2];
			{
				if(name _x in _onlinePilots) then {
					["TransportRequest", [format["%1 requested transport.", name _caller]]] remoteExecCall ["BIS_fnc_showNotification", _x];
				};
			}foreach (call BIS_fnc_listPlayers);
		} else {
			hint "There are no pilots online.";
		};

		[_target, ["vr_shutdown", 20]] remoteExec ["say3D", 0];
	}, [_terminalSpawn], 1.5, true, true, "", "true", 5];
};

if(_type == "MISSION") then {
	_terminal addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\types\talk_ca.paa'/> Generate a mission", { 
		params ["_target", "_caller", "_actionId", "_arguments"];

		[_target, _caller] spawn FU_fnc_missionGenerator;
	}, nil, 1.5, true, true, "", "!(missionNamespace getVariable 'FU_missionStarted')", 5];

	_terminal addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\letters\x_ca.paa'/> Cancel the mission", { 
		params ["_target", "_caller", "_actionId", "_arguments"];

		private _tasks = player call BIS_fnc_tasksUnit;
		private _task = _tasks select {"FU_mission" in _x};
		private _position = _task call BIS_fnc_taskDestination;

		systemChat "[SERVER]: Cancelling the mission, please stand-by.";

		cargo setDamage 1;

		systemChat "[SERVER]: Deleting things...";
		private _wipeBlacklist = ["RU_WarfareBUAVterminal", "Land_TTowerBig_2_F", "CUP_B_M6LineBacker_USA_W", "CUP_O_2S6M_RU", "CUP_I_Ural_ZU23_NAPA", "CUP_B_M252_USMC", "CUP_O_2b14_82mm_RU", "CUP_I_2b14_82mm_NAPA"];
		private _wipeList = nearestObjects [_position, ["AllVehicles", "Static", "Thing"], 1000, true];
		{if(typeOf _x in _wipeBlacklist) then {_x setDamage 1} else {deleteVehicle _x}; sleep 0.05;}foreach _wipeList;

		systemChat "[SERVER]: Deleting people...";
		private _wipeListMan = nearestObjects [_position, ["Man"], 1000, true];
		{deleteVehicle _x; sleep 0.05;}foreach _wipeListMan;

		systemChat "[SERVER]: Deleting dead things...";
		{deleteVehicle _x; sleep 0.05;}foreach allDead;

		systemChat "[SERVER]: Mission has been cancelled successfully.";
	}, nil, 1.5, true, true, "", "missionNamespace getVariable 'FU_missionStarted'", 5];
};

if(_type == "MISSION_IDAP") then {
	_terminal addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\types\talk_ca.paa'/> Generate a delivery mission", { 
		params ["_target", "_caller", "_actionId", "_arguments"];

		[_target, _caller] spawn FU_fnc_taskIDAP;
	}, nil, 1.5, true, true, "", "!(missionNamespace getVariable 'FU_missionStarted_IDAP')", 5];
};

if(_type == "RECRUIT") then {
	_terminal addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\types\meet_ca.paa'/> Recruit Units", { 
		params ["_target", "_caller", "_actionId", "_arguments"];

		[] spawn FU_fnc_recruitUnits;
	}, nil, 1.5, true, true, "", "true", 5];
};

if(_type == "ARSENAL") then {
	_terminal addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\types\box_ca.paa'/> Select Role", { 
		params ["_target", "_caller", "_actionId", "_arguments"];

		[] spawn FU_fnc_roleSelection;
	}, nil, 1.5, true, true, "", "true", 5];

	_terminal addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\types\backpack_ca.paa'/> Set Default Loadout", { 
		params ["_target", "_caller", "_actionId", "_arguments"];

		[_caller] call FU_fnc_setRole;
	}, nil, 1.5, true, true, "", "true", 5];

	_terminal addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\types\rearm_ca.paa'/> Get Default Loadout", { 
		params ["_target", "_caller", "_actionId", "_arguments"];

		private _loadout = [_caller] call FU_fnc_getRole;
		[_caller, _loadout] call CBA_fnc_setLoadout;
	}, nil, 1.5, true, true, "", "true", 5];
};

if(_type == "TRAINING") then {
	_terminal addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\types\whiteboard_ca.paa'/> Start Intro Training", { 
		params ["_target", "_caller", "_actionId", "_arguments"];

		if(FU_trainingCooldown > 0) then {
			hint parseText format["Someone started the Intro Training before you. Wait <t color='#FFA500'>%1 sec</t> to start your own Intro Training.", FU_trainingCooldown];
		} else {
			[_target, _caller] spawn FU_fnc_taskTraining;
		};
	}, nil, 1.5, true, true, "", "(_this getVariable 'FU_trainingStage') == 0", 5];
};