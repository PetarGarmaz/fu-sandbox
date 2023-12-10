params ["_marker", "_side"];

switch _side do {
	case west: {_marker setMarkerColor "colorBLUFOR"};
	case east: {_marker setMarkerColor "colorOPFOR"};
	case resistance: {_marker setMarkerColor "colorIndependent"};
	default {_marker setMarkerColor "colorCivilian"};
};

true;