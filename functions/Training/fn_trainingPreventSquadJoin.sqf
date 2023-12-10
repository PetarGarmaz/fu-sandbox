params ["_task", "_heliGroup"];

while {[_task] call BIS_fnc_taskState != "SUCCEEDED"} do {
	if(group player == _heliGroup) then {
		_newGroup = createGroup [resistance, true];
		[player] join _newGroup;
	};

	sleep 2;
};