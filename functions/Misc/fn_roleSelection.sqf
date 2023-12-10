disableSerialization;

createDialog "FU_RoleSelection";

_button = (findDisplay 4616) displayCtrl 4621;
_list = (findDisplay 4616) displayCtrl 4614;

_roles = missionNamespace getVariable "FU_roles";

_buttonAction = _button ctrlAddEventHandler ["ButtonClick", {
	params ["_control"];
		
	[] spawn {
		_list = (findDisplay 4616) displayCtrl 4614;
		_selection = lbCurSel _list;

		_roles = missionNamespace getVariable "FU_roles";
		_role = _roles select _selection;
		
		private _roleName = _role select 0;
		private _loadout = _role select 1;

		closeDialog 2;

		[player, _loadout] call CBA_fnc_setLoadout;
	};
}];

//Initial list update
{
	private _role = _x select 0;
	_list lbAdd _role;
}foreach _roles;
_list lbSetCurSel 0;