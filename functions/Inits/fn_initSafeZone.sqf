private _safeZones = allMapMarkers select {"SafeZone" in _x};

while {true} do {
	private _nearestSafeZone = [_safeZones, getPos player] call BIS_fnc_nearestPosition;
	private _size = getMarkerSize _nearestSafeZone;
	private _dir = markerDir _nearestSafeZone;
	private _pos = getMarkerPos _nearestSafeZone;
	private _isRect = if(markerShape _nearestSafeZone == "RECTANGLE") then {true} else {false}; 
	private _inSafeZone = (getPos player) inArea [_pos, _size select 0, _size select 1, _dir, _isRect, -1];

	if(_inSafeZone && isDamageAllowed player || _inSafeZone && isDamageAllowed (vehicle player)) then {
		player allowDamage false;
		(vehicle player) allowDamage false;
		//[player, currentWeapon player, true] call ace_safemode_fnc_setWeaponSafety;
		player setVariable ["FU_inSafeZone", true, true];
		systemChat "[SERVER]: You have entered the safe zone!";
	};
	
	if(!_inSafeZone && !isDamageAllowed player || !_inSafeZone && !isDamageAllowed (vehicle player)) then {
		player allowDamage true;
		(vehicle player) allowDamage true;
		//[player, currentWeapon player, false] call ace_safemode_fnc_setWeaponSafety;
		player setVariable ["FU_inSafeZone", false, true];
		systemChat "[SERVER]: You have exited the safe zone!";
	};
	
	sleep 2;
};