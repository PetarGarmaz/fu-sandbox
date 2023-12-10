private _medicalZones = allMapMarkers select {"Medical" in _x};

while {true} do {
	private _nearestMedicalZone = [_medicalZones, getPos player] call BIS_fnc_nearestPosition;
	private _nearestMedicalZoneDir = markerDir _nearestMedicalZone;
	private _nearestMedicalZoneSize_1 = (getMarkerSize _nearestMedicalZone) select 0;
	private _nearestMedicalZoneSize_2 = (getMarkerSize _nearestMedicalZone) select 1;
	private _inMedicalZone = (getPos player) inArea [getMarkerPos _nearestMedicalZone, _nearestMedicalZoneSize_1, _nearestMedicalZoneSize_2, _nearestMedicalZoneDir, true, -1];

	if(_inMedicalZone) then {
		[player] call ace_medical_treatment_fnc_fullHealLocal;
		systemChat "[SERVER]: You have been fully healed!";
	};
	
	sleep 5;
};