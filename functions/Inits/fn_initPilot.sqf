private _player = player;
private _onlinePilots = missionNamespace getVariable "FU_onlinePilots";
_onlinePilots pushBack (name player);
missionNamespace setVariable ["FU_onlinePilots", _onlinePilots, true];

["TransportRequest", [format["Pilot %1 is now online.", name _player]]] remoteExecCall ["BIS_fnc_showNotification", 0];