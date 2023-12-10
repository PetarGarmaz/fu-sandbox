params ["_task"];

while {[_task] call BIS_fnc_taskState != "SUCCEEDED"} do {
	waitUntil{sleep 5; player getVariable ["ACE_isUnconscious", false] || !alive player};

	sleep 5;

	[player] call ace_medical_treatment_fnc_fullHealLocal;
};