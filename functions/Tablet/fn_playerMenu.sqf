disableSerialization;

FU_PlayerMenu = false;

while {true} do {
	waitUntil{uisleep 0.1; !isNull(findDisplay 49)};

	//Move default UI elements up
	private _menuDisplay = findDisplay 49;
	private _bg = _menuDisplay displayCtrl 1050;
	private _txt1 = _menuDisplay displayCtrl 523;
	private _txt2 = _menuDisplay displayCtrl 109;

	private _size = ctrlPosition _bg;
	private _pos = _size select 1;
	private _w = _size select 2;
	private _h = _size select 3;
	/*{
		_x ctrlSetPositionY (_pos - 0.1);
		_x ctrlCommit 0;
	}foreach [_bg, _txt1, _txt2];
	*/
	private _ctrlButton = _menuDisplay ctrlCreate ["RscActivePicture", 4600]; 
	_ctrlButton ctrlSetPosition _size; 
	_ctrlButton ctrlSetPositionW _w;
	_ctrlButton ctrlSetPositionH _h * 15;
	_ctrlButton ctrlSetTooltip "Open FU Player Menu"; 
	_ctrlButton ctrlSetPositionY (0.027 * safezoneH + safezoneY); 
	_ctrlButton ctrlSetText "Images\FU_Logo.paa";
	//_ctrlButton ctrlSetFont "PuristaLight";
	_ctrlButton ctrlCommit 0;

	_buttonAction = _ctrlButton ctrlAddEventHandler ["ButtonClick", {
		params ["_control"];

		(findDisplay 49) closeDisplay 2;

		["INIT"] spawn FU_fnc_openPlayerMenu;
	}];

	waitUntil{uisleep 0.1; isNull(findDisplay 49)};
};