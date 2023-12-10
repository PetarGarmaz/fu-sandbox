params ["_player"];

private _type = typeOf _player;
private _loadout = [];
private _profileRoles = profileNamespace getVariable "FU_profileRoles";

{
	if(_type == _x select 0) exitWith {_loadout = _x select 1};
}foreach _profileRoles;

_loadout;