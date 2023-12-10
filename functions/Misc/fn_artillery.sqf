params [["_target", objNull], ["_allArtilleryInArea", []]];

["StatusReport", ["Enemy mortar strike incoming!", "destroy"]] remoteExecCall ["BIS_fnc_showNotification", 0];

private _targetPos = getPos _target;
private _smoke = "SmokeShellRed" createVehicle _targetPos;

sleep 20;

for "_i" from 1 to 3 do {
	{
		_x setVehicleAmmo 1;
		
		[_x, _targetPos]spawn {
			params ["_artillery", "_targetPos"];

			private _pos = [[[_targetPos, 200]], ["water"]] call BIS_fnc_randomPos;
			private _round = currentMagazine _artillery;
			_artillery doArtilleryFire [_pos, _round, 1];
		};
		
		sleep 1;	
	}forEach _allArtilleryInArea;
	
	sleep 20;
};