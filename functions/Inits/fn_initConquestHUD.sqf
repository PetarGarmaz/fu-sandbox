params ["_friendlySide", "_enemySide"];

disableSerialization;

"FU_HUD" cutRsc ["FU_HUD", "PLAIN", 2, true];

private _icon_L = (uinamespace getVariable "FU_HUD") displayCtrl 4605;
private _icon_R = (uinamespace getVariable "FU_HUD") displayCtrl 4606;
private _tickets_L = (uinamespace getVariable "FU_HUD") displayCtrl 4607;
private _tickets_R = (uinamespace getVariable "FU_HUD") displayCtrl 4608;

private _natoFaction = "\a3\Data_f\Flags\flag_NATO_co.paa";
private _csatFaction = "\a3\Data_f\Flags\flag_CSAT_co.paa";
private _aafFaction = "\a3\Data_f\Flags\flag_AAF_co.paa";

private _friendlyIcon = "";
private _enemyIcon = "";

switch _friendlySide do {
	case west: {_friendlyIcon = _natoFaction};
	case east: {_friendlyIcon = _csatFaction};
	case resistance: {_friendlyIcon = _aafFaction};
};

switch _enemySide do {
	case west: {_enemyIcon = _natoFaction};
	case east: {_enemyIcon = _csatFaction};
	case resistance: {_enemyIcon = _aafFaction};
};

_icon_L ctrlSetText _friendlyIcon;
_icon_R ctrlSetText _enemyIcon;

while {missionNamespace getVariable "FU_friendlyTickets" > 0 && missionNamespace getVariable "FU_enemyTickets" > 0} do {
	_tickets_L ctrlSetStructuredText parseText format["<t size='2' align='center' valign='middle'>%1</t>", missionNamespace getVariable "FU_friendlyTickets"];
	_tickets_R ctrlSetStructuredText parseText format["<t size='2' align='center' valign='middle'>%1</t>", missionNamespace getVariable "FU_enemyTickets"];
	
	sleep 5;
};

"FU_HUD" cutRsc ["Default", "PLAIN", 2, true];