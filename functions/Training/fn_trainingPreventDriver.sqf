params ["_task", "_car", "_driver"];

while {[_task] call BIS_fnc_taskState != "SUCCEEDED"} do {
	if(_driver != driver _car) then {
		moveOut player;
		player moveInCargo _car; 
		
		sleep 0.1;

		moveOut _driver;
		_driver moveInDriver _car;
	};

	sleep 1;
};