disableSerialization;

params ["_caller"];

if(vehicle player != player) exitWith {hint "You're currently inside a vehicle!";};

createDialog "GarageManager";

_display = findDisplay 4603;

_listVehicles = _display displayCtrl 4624;
_listActions = _display displayCtrl 4625;
_button = _display displayCtrl 4626;
_cancel = _display displayCtrl 4627;
_vehiclePicture = _display displayCtrl 4629;

{
	_listActions lbAdd _x;
}foreach ["Spawn Vehicle", "Remove Vehicle", "Store Vehicle"]; 
_listActions lbSetCurSel 0;

_buttonAction = _button ctrlAddEventHandler ["ButtonClick", {
	params ["_control"];
	_caller = player;
	
	_listVehicles = (findDisplay 4603) displayCtrl 4624;
	_listActions = (findDisplay 4603) displayCtrl 4625;

	closeDialog 2;
	
	_vehicleGarage = player getVariable "FU_vehicleGarage";
	_profileGarage = profileNamespace getVariable "FU_profileVehicleGarage";
	
	_selectedAction = _listActions lbText (lbcurSel _listActions);

	if(_selectedAction == "Spawn Vehicle") then {
		_selectedVehicleArray = _profileGarage select (lbCurSel _listVehicles);
	
		//Check if player has too many vehicles spawned
		_spawnedVehicles = player getVariable "FU_vehicleGarage";
		if(count _spawnedVehicles >= 3) then {
			systemChat "[SERVER]: You're have spawned too many vehicles!";
		} else {
			//Add player to queue, if player is in the queue already, don't add him
			_currentQueue = missionNamespace getVariable "FU_vehicleQueue";
			if(_caller in _currentQueue) then {
				systemChat "[SERVER]: You're already queued up! Please wait your turn!";
			} else {
				_currentQueue pushBack (name _caller);
				missionNamespace setVariable ["FU_vehicleQueue", _currentQueue, true];
				
				//Find is in safezone
				private _safeZones = allMapMarkers select {"SafeZone" in _x};
				private _nearestSafeZone = [_safeZones, getPos player] call BIS_fnc_nearestPosition;
				private _nearestSafeZoneSize = (getMarkerSize _nearestSafeZone) select 0;
				private _inSafeZone = (getPos player) inArea [getMarkerPos _nearestSafeZone, _nearestSafeZoneSize, _nearestSafeZoneSize, 0, false, -1];

				//Nearest spawn
				private _spawns = allMapMarkers select {"FU_VehicleSpawn" in _x};
				private _nearestSpawn = [_spawns, getPos player] call BIS_fnc_nearestPosition;

				//Vehicle spawns found, check if player is close enough to it to spawn vehicles
				if(_inSafeZone) then {					
					//Get info for vehicle
					_vehicleType = _selectedVehicleArray select 2;
					_vehicleName = getText (configFile >> "CfgVehicles" >> _vehicleType >> "displayName");
					_vehicleSettings = _selectedVehicleArray select 3;
					_vehiclePylons = _selectedVehicleArray select 4;
					
					_spawnScript = [_nearestSpawn, [_vehicleName, _vehicleType, _vehicleSettings, _vehiclePylons]] spawn FU_fnc_vehicleSpawn;
				} else {
					systemChat "[SERVER]: You're too far from any Virtual Garage spawns!";
				};
			};
		};
	};
	
	if(_selectedAction == "Remove Vehicle") then {
		_selectedVehicleArray = (_vehicleGarage + _profileGarage) select (lbCurSel _listVehicles);
	
		if(_selectedVehicleArray in _vehicleGarage) then {
			_vehicle = _selectedVehicleArray select 0;
			deleteVehicle _vehicle;
		};
		
		if(_selectedVehicleArray in _profileGarage) then {
			_profileGarage = _profileGarage - [_selectedVehicleArray];
			profileNamespace setVariable ["FU_profileVehicleGarage", _profileGarage];
		};
	};
	
	if(_selectedAction == "Store Vehicle") then {
		createDialog "VehicleManager_StoreVehicle";
		
		_button = (findDisplay 4609) displayCtrl 4621;
		_cancel = (findDisplay 4609) displayCtrl 4622;
		_text = (findDisplay 4609) displayCtrl 4614;
		
		selectedVehicle = lbCurSel _listVehicles;
		
		//Default name
		_selectedVehicleArray = _vehicleGarage select selectedVehicle;
		_vehicleType = _selectedVehicleArray select 2;
		_vehicleName = getText (configFile >> "CfgVehicles" >> _vehicleType >> "displayName");
		_text ctrlSetText format["[S]: %1", _vehicleName];
	
		_buttonAction = _button ctrlAddEventHandler ["ButtonClick", {
			params ["_control"];
	
			_text = (findDisplay 4609) displayCtrl 4614;
	
			closeDialog 2;
			
			_vehicleGarage = player getVariable "FU_vehicleGarage";
			_profileGarage = profileNamespace getVariable "FU_profileVehicleGarage";
	
			//Select the vehicle params array
			_selectedVehicleArray = _vehicleGarage select selectedVehicle;
			_vehicle = _selectedVehicleArray select 0;
			
			//Store new textures and pylons
			_newVehicleTextures = getObjectTextures _vehicle;
			_newVehicleSettings = [_vehicle] call BIS_fnc_getVehicleCustomization;
			_newVehicleSettings set [0, _newVehicleTextures];			
			_newVehiclePylons = getAllPylonsInfo _vehicle;
			
			//Remove vehicle from normal garage
			_vehicleGarage = _vehicleGarage - [_selectedVehicleArray];
			player setVariable ["FU_vehicleGarage", _vehicleGarage, true];
			
			//Add vehicle to profile garage
			_selectedVehicleArray set [1, format["%1", ctrlText _text]];
			_selectedVehicleArray set [3, _newVehicleSettings];
			_selectedVehicleArray set [4, _newVehiclePylons];
			_profileGarage pushBack _selectedVehicleArray;
			profileNamespace setVariable ["FU_profileVehicleGarage", _profileGarage];
			
			deleteVehicle _vehicle;
			selectedVehicle = nil;
			
			if("penis" in toLower(ctrlText _text)) then {
				hint "Grow up! :D";
			};
		}];
		_cancelAction = _cancel buttonSetAction "closeDialog 2;";
	};
}];
_cancelAction = _cancel buttonSetAction "closeDialog 2;";

while {dialog} do {
	_vehicleGarage = player getVariable "FU_vehicleGarage";
	_profileGarage = profileNamespace getVariable "FU_profileVehicleGarage";
	
	_garageArray = [];
	
	_currentAction = lbCurSel _listActions;
	_currentActionText = _listActions lbText _currentAction;
	
	if(_currentAction >= 0) then {
		switch _currentActionText do {
			case "Spawn Vehicle": {
				_garageArray = _profileGarage;
			};
			case "Remove Vehicle": {
				_garageArray = _vehicleGarage + _profileGarage;
			};				
			case "Store Vehicle": {
				_garageArray = _vehicleGarage;
			};
		};
		
		if(count _garageArray == 0) then {
			_button ctrlEnable false;
		};
		
		{
			_text = _x select 1;
			_listVehicles lbAdd _text;
		}foreach _garageArray;
		
		_listVehicles lbSetCurSel 0;
		
		_pictureControl = [_vehiclePicture, _listVehicles, _garageArray, _currentAction, _listActions] spawn {
			params ["_vehiclePicture", "_listVehicles", "_garageArray", "_currentAction", "_listActions"];
			
			while {dialog && _currentAction isEqualTo (lbCurSel _listActions)} do {
				_currentVehicle = lbCurSel _listVehicles;

				if(_currentVehicle >= 0 && count(_garageArray) > 0) then {
					_selectedVehicleArray = _garageArray select _currentVehicle;
					_vehicleType = _selectedVehicleArray select 2;
					
					_picture = getText (configFile >> "CfgVehicles" >> _vehicleType >> "editorPreview");
					_vehiclePicture ctrlSetText _picture;
				} else {
					_vehiclePicture ctrlSetText "#(argb,8,8,3)color(0.475,0.518,0.502,1)";
				};
				
				waitUntil {_currentVehicle isNotEqualTo (lbCurSel _listVehicles)};
			}; 
		};
	};
	
	waitUntil {_currentAction isNotEqualTo (lbCurSel _listActions)};
	lbClear _listVehicles;
	_button ctrlEnable true;
};

_button ctrlRemoveAllEventHandlers "ButtonClick";