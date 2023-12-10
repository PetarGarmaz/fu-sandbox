disableSerialization;
createDialog "FUT_Garage";

private _caller = player;
private _display = findDisplay 4610;

private _buttonSpawnIn = _display displayCtrl 1600;
private _buttonSpawnOut = _display displayCtrl 1601;
private _buttonSave = _display displayCtrl 1602;
private _buttonLoad = _display displayCtrl 1603;
private _buttonCancel = _display displayCtrl 1604;
private _comboType = _display displayCtrl 2101;
private _comboVehicle = _display displayCtrl 2102;
private _comboTexture = _display displayCtrl 2103;
private _buttonPylons = _display displayCtrl 1605;
private _buttonNVG = _display displayCtrl 1606;
private _buttonLights = _display displayCtrl 1607;

private _vehicleConfig = configFile >> "CfgVehicles";
private _allVehicles = "true" configClasses (configFile >> "CfgVehicles");
private _allTypes = "true" configClasses (configFile >> "CfgEditorSubcategories");

//Types - doesn't need to update
private _allTypeSorted = [""];
private _allTypeConfName = [""];
private _allTypeNames = ["All"];
{
	private _text = getText (_x >> "displayName");
	private _configName = configName _x;
	if("Cars" in _configName || "APC" in _configName || "Tank" in _configName || "Artill" in _configName || "AA" in _configName || "Boats" in _configName || "Drones" in _configName || "Submer" in _configName || "Helicopter" in _configName || "Planes" in _configName || "Tank" in _configName || "Turret" in _configName) then {
		_allTypeNames pushBackUnique _text; 
		_allTypeConfName pushBackUnique _configName; 
		_allTypeSorted pushBackUnique _x
	};
}foreach _allTypes;
{
	_comboType lbAdd _x;
}foreach _allTypeNames;
_comboType lbSetCurSel 0;

//Main Loop
while {dialog} do {
	private _selectedCategoryIndex = lbCurSel _comboType;
	private _selectedCategory = _allTypeConfName select _selectedCategoryIndex;

	//vehicles
	private _allVehicleSorted = [];
	private _allVehicleNames = [];
	private _allVehicleConfNames = [];
	private _allTextures = [];
	{
		private _text = getText (_x >> "displayName");
		private _configName = configName _x;
		private _category = getText (_x >> "editorSubcategory");
		private _scope = getNumber (_x >> "scope");
		private _allTextures = getArray (_x >> "TextureSources");
		if(_category == _selectedCategory && _scope == 2) then {
			_allVehicleNames pushBack _text; 
			_allVehicleConfNames pushBack _configName; 
			_allVehicleSorted pushBack _x;
		};
	}foreach _allVehicles;
	{
		_comboVehicle lbAdd _x;
	}foreach _allVehicleNames;
	_comboVehicle lbSetCurSel 0;
	
	private _textureScroll = [_comboType, _selectedCategoryIndex, _comboVehicle, _allTextures, _allVehicleConfNames, _comboTexture] spawn {
		params ["_comboType", "_selectedCategoryIndex", "_comboVehicle", "_allTextures", "_allVehicleConfNames", "_comboTexture"];
		
		disableSerialization;

		while {dialog && _selectedCategoryIndex isEqualTo (lbCurSel _comboType)} do {
			private _selectedVehicleIndex = lbCurSel _comboVehicle;
			private _selectedVehicle = _allVehicleConfNames select _selectedVehicleIndex;

			//Textures
			private _allTextureNames = [];
			{
				_allTextureNames pushBack getText (configFile >> "CfgVehicles" >> _selectedVehicle >> "TextureSources" >> _x >> "displayName");
			}foreach _allTextures;
			{
				_comboTexture lbAdd _x;
			}foreach _allTextureNames;
			
			waitUntil {sleep 0.2; _selectedVehicleIndex isNotEqualTo (lbCurSel _comboVehicle)};
			lbClear _comboTexture;
		};
	};

	waitUntil {sleep 0.2; _selectedCategoryIndex != lbCurSel _comboType};

	lbClear _comboVehicle;
};