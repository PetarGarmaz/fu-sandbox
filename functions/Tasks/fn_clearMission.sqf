params [["_missionPos", []], ["_currentTask", ""], ["_otherObjects", []], ["_cleanDistance", 750]];

//If no position was given, find one from the given task
if(_missionPos isEqualTo []) then {
	_allTasks = player call BIS_fnc_tasksUnit;
	
	{
		if(format["%1Task", _currentTask] in _x) then {_currentTask = _x};
	}foreach _allTasks;
	

	_missionPos = _currentTask call BIS_fnc_taskDestination;
	[_currentTask, 'CANCELED', true] call BIS_fnc_taskSetState;
};

_allUnitsInArea = _missionPos nearEntities [["AllVehicles"], _cleanDistance];


//Delete all map markers
{
	_distance = _missionPos distance (getMarkerPos _x);
	
	if(_distance < _cleanDistance && !("dp_" in _x) && _x != "mapCenter") then {
		deleteMarker _x;
	};
}forEach allMapMarkers;


//Filtering players and player owned vehicles
{
	
	if(_x isKindOf "Man") then {
		deleteVehicle _x; sleep 0.5;
	} else {
		if(!isNil {_x getVariable "isPersonalVehicle"}) then {
			if(!(_x getVariable "isPersonalVehicle")) then {
				{
					deleteVehicle _x;
				}forEach (crew _x);
				
				deleteVehicle _x;
			};
		} else {
			{
				deleteVehicle _x;
			}forEach (crew _x);
			
			deleteVehicle _x;
		};
		
		sleep 0.5;
	};
}forEach _allUnitsInArea;

//Filter objects
_objects = _missionPos nearObjects ["Static", _cleanDistance];

{
	deleteVehicle _x;
}forEach _objects;


//Delete other objects
{
	if(!isNull(_x))then {deleteVehicle _x;};
}forEach _otherObjects;

//Delete dead bodies, vehicles
{
	deleteVehicle _x
} forEach allDead;