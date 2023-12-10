params [["_locationArgs", ["Random Location", locationNull]]];

private _customName = _locationArgs select 0;
private _location = _locationArgs select 1;
private _name = "";
private _pos = [0, 0, 0];

private _allLocations = nearestLocations [getMarkerPos "mapCenter", ["NameVillage","NameCityCapital", "NameCity", "NameLocal"], 15000];
private _whitelist = _allLocations select {!(text _x in ["Telos", "Gravia", "military", "Terminal", ""])};

if(_customName == "Random Location") then {
	_location = selectRandom _whitelist;
	_name = text _location;
	_pos = [
		locationPosition _location select 0,
		locationPosition _location select 1,
		0
	];
} else {
	_name = _customName;
	_pos = [
		locationPosition _location select 0,
		locationPosition _location select 1,
		0
	];
};

[_location, _name, _pos];