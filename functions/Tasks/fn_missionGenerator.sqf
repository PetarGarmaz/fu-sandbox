params ["_missionGiver", "_missionCaller"];

missionGiver = _missionGiver;
missionCaller = _missionCaller;
locations = [["Random Location", locationNull]];

private _missions = ["Assault", "Conquest"];
private _tasks_A = ["Attack", "Assasinate", "Combat Air Patrol (CAP)", "Destroy (AA)", "Destroy (Radio Tower)", "Hack (Data Site)", "Logistics", "Save POW", "Secure (Mortar Pits)", "Secure (Ammo Depot)"];
private _tasks_C = ["Conquest Task"];
private _sides = [[civilian, "Random Faction"], [east, "CSAT"], [west, "NATO"]];

if(side missionCaller == civilian) exitWith {systemChat '[SERVER]: You cannot generate missions as a civilian!';};
if(missionNamespace getVariable "FU_missionStarted") exitWith {systemChat '[SERVER]: You cannot generate new missions while another is already running!';};

createDialog "Missions";

_listMissions = (findDisplay 4605) displayCtrl 4633;
_listTasks = (findDisplay 4605) displayCtrl 4626;
_listLocation = (findDisplay 4605) displayCtrl 4628;
_listSides = (findDisplay 4605) displayCtrl 4629;
_button = (findDisplay 4605) displayCtrl 4630;
_cancel = (findDisplay 4605) displayCtrl 4631;
_map = (findDisplay 4605) displayCtrl 4632;

//Mission generator
{
	_text = _x;
	_listMissions lbAdd _text;
}foreach _missions;
_listMissions lbSetCurSel 0;

{
	_text = _x;
	_listTasks lbAdd _text;
}foreach _tasks_A;
_listTasks lbSetCurSel 0;

{
	_text = _x select 1;
	_listSides lbAdd _text;
}foreach _sides;
_listSides lbSetCurSel 0;

_buttonAction = _button ctrlAddEventHandler ["ButtonClick", {
	params ["_control"];
	
	_listMissions = (findDisplay 4605) displayCtrl 4633;
	_listTasks = (findDisplay 4605) displayCtrl 4626;
	_listLocation = (findDisplay 4605) displayCtrl 4628;
	_listSides = (findDisplay 4605) displayCtrl 4629;
	
	_sides = [civilian, east, west];
	
	closeDialog 2;
	
	_missionGiver = missionGiver;
	_missionCaller = missionCaller;
	
	_selectedMission = lbSelection _listMissions;
	_selectedTasks = lbSelection _listTasks;
	_selectedLocation = "";
	_selectedSide = _sides select (lbcurSel _listSides);
	
	_selectionIndex = lbCurSel _listLocation;
	_selectedLocation = locations select _selectionIndex;
	//systemChat str (_selectedLocation);
	
	[_missionGiver, _missionCaller, [_selectedLocation, _selectedSide], _selectedTasks, _selectedMission] remoteExec ['FU_fnc_generateMission', 2];
}];

_cancelAction = _cancel buttonSetAction "closeDialog 2;";

//Main loop
private _allLocations = nearestLocations [getMarkerPos "mapCenter", ["NameVillage","NameCityCapital", "NameCity", "NameLocal","Hill"], 15000];
private _whitelist = _allLocations select {!(text _x in ["Telos", "Gravia", "military", "Terminal", ""])};
private _locationsArray = [];
{
	_locationsArray pushBack [(text _x), _x];
}foreach _whitelist;
_locationsArray sort true;
locations = locations + _locationsArray;
{
	_text = _x select 0;
	_listLocation lbAdd _text;
}foreach locations;
_listLocation lbSetCurSel 0;

while {dialog} do {
	_selLocIndex = lbCurSel _listLocation;
	_selMisIndex = lbCurSel _listMissions;
	
	sleep 0.1;

	if(_selLocIndex > 0 && _selLocIndex isNotEqualTo (lbCurSel _listLocation)) then {
		_selLocIndex = lbCurSel _listLocation;
		_location = locations select _selLocIndex;
		_location = _location select 1;
		_locationPos = locationPosition _location;
		_map ctrlMapAnimAdd [1, 0.1, _locationPos];
		ctrlMapAnimCommit _map;
	};

	if(_selMisIndex isNotEqualTo (lbCurSel _listMissions)) then {
		_selMisIndex = lbCurSel _listMissions;
		lbClear _listTasks;

		if(_selMisIndex == 0) then {
			{
				_text = _x;
				_listTasks lbAdd _text;
			}foreach _tasks_A;
			_listTasks lbSetCurSel 0;
		} else {
			{
				_text = _x;
				_listTasks lbAdd _text;
			}foreach _tasks_C;
			_listTasks lbSetCurSel 0;
		};
	};
	
	//waitUntil {sleep 0.1; _selLocIndex isNotEqualTo (lbCurSel _listLocation)};
};

_button ctrlRemoveAllEventHandlers "ButtonClick";

missionCaller = objNull;
publicVariable "missionCaller";