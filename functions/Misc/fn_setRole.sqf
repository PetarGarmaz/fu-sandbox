params ["_player"];

private _type = typeOf _player;
private _loadout = [_player] call CBA_fnc_getLoadout;
private _profileRoles = profileNamespace getVariable "FU_profileRoles";

{
	if(_type == _x select 0) exitWith {_profileRoles set [_foreachindex, [_type, _loadout]]};
}foreach _profileRoles;

hint format["Default loadout for %1 has been set!", getText (configFile >> "CfgVehicles" >> _type >> "displayName")];

true;