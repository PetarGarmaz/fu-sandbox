params ["_target", "_caller"];

if(missionNamespace getVariable "FU_missionStarted_IDAP") exitWith {systemChat '[SERVER]: You cannot generate new missions while another is already running!';};

missionNamespace setVariable ["FU_missionStarted_IDAP", true, true];

//Find the mission location
private _markers = allMapMarkers select {"FU_Delivery_" in _x};
private _marker = selectRandom _markers;
private _pos = getMarkerPos _marker;
private _text = markerText _marker;

//Spawn cargo
private _spawnPos = getMarkerPos "cargoSpawn_CIV";
private _cargoTypes = ["Land_FoodSacks_01_large_brown_idap_F", "Land_WaterBottle_01_stack_F", "Land_PaperBox_01_small_stacked_F"];
private _cargoType = selectRandom _cargoTypes;
private _cargo = createVehicle [_cargoType, _spawnPos, [], 0, "NONE"];
private _cargoName = getText(configFile >> "CfgVehicles" >> _cargoType >> "displayName");
[_cargo, 1] call ace_cargo_fnc_setSize;

sleep 2;

//Main task
openMap true;

sleep 0.5;
[4, 0.05, _pos] call BIS_fnc_mapAnimAdd;

["FU_delivery"] call BIS_fnc_deleteTask;
["FU_deliveryCargo"] call BIS_fnc_deleteTask;

sleep 4;
private _task = [civilian, "FU_delivery", ["Deliver IDAP care package to those in need. The delivery point is marked on the map!", "Delivery Job", ""], _pos, "ASSIGNED", 1, true, "truck", true] call BIS_fnc_taskCreate;
private _taskCargo = [civilian, "FU_deliveryCargo", ["IDAP Cargo", ["TRACKER: %1", _cargoName], ""], _cargo, "CREATED", 1, true, "box", true] call BIS_fnc_taskCreate;

sleep 2;
openMap false;

//Condition & Looters
private _maxDistance = (getPos _cargo) distance _pos;
private _distancePassed = 0;
private _ambushes = 1;
private _ambushStep = _maxDistance / 3;
private _units = ["I_L_Looter_Pistol_F", "I_L_Looter_SG_F", "I_L_Looter_SMG_F", "I_L_Criminal_SG_F", "I_L_Criminal_SMG_F"];

_caller addRating -9999;

while {true} do {
	private _distance = (getPos _cargo) distance _pos;
	private _guards = allPlayers inAreaArray [getPos _cargo, 500, 500, 0, false, -1];

	private _posOld = getPosATL _cargo; 

	sleep 5;

	private _posNew = getPosATL _cargo; 
	_distancePassed = _distancePassed + (_posNew distance _posOld);
	//systemChat format["%1; %2", _distancePassed, _ambushStep];

	if(_distancePassed >= _ambushStep * _ambushes) then {
		private _dir = getDir _cargo;
		private _pos = [((getPosATL _cargo) select 0) + (sin _dir * 700), ((getPosATL _cargo) select 1) + (cos _dir * 700), 0];
		_pos = getPosATL([_pos, 2000] call BIS_fnc_nearestRoad);

		for "_i" from 1 to 3 do {
			private _group = createGroup [resistance, true];
			private _vehicle = createVehicle ["C_Offroad_01_F", _pos, [], 30, "NONE"];
			for "_j" from 1 to 5 do {private _unit = _group createUnit [selectRandom _units, _pos, [], 10, "NONE"]; sleep 0.1; _unit moveInAny _vehicle; sleep 0.1;};
			_group addVehicle _vehicle;
			(leader _group) assignAsDriver _vehicle;
			[_group, group _caller, 10, 0, {!alive _cargo}, 0] spawn BIS_fnc_stalk;
		};

		_ambushes = _ambushes + 1;
	};

	if(_distance <= 50) exitWith {
		[_task, 'SUCCEEDED', true] call BIS_fnc_taskSetState;
		[_taskCargo, 'SUCCEEDED', true] call BIS_fnc_taskSetState;
	};
	
	if(count _guards <= 0) exitWith {
		[_task, 'FAILED', true] call BIS_fnc_taskSetState;
		[_taskCargo, 'FAILED', true] call BIS_fnc_taskSetState;
	};
};

_caller addRating 9999;

sleep 10;
deleteVehicle _cargo;

missionNamespace setVariable ["FU_missionStarted_IDAP", false, true];