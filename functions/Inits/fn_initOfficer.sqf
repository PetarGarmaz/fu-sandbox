params ["_officer"];

//Get basic info
private _varName = vehicleVarName _officer;
private _face = face _officer;
private _name = name _officer;
private _loadout = getUnitLoadout _officer;
private _group = group _officer;

private _pos = getPosASL _officer;
private _dir = direction _officer;

//Very important, make officer sit :)
[_officer, "SIT2", "FULL"] remoteExecCall ["BIS_fnc_ambientAnim", 0, true];
_officer disableAI "ALL";

waitUntil {!alive _officer};

sleep 1;
deleteVehicle _officer;

//Create officer object
private _newOfficer = _group createUnit ["B_G_officer_F", _pos, [], 0, "CAN_COLLIDE"];
_newOfficer setDir _dir;
_newOfficer setPosASL _pos;
_newOfficer allowDamage false;
sleep 0.2;

//Set his identity
_newOfficer setVehicleVarName _varName;
publicVariable _varName;
[_newOfficer, "COLONEL"] remoteExec ["setRank", 0, true];
[_newOfficer, _face] remoteExec ["setFace", 0, true];
[_newOfficer, _name] remoteExec ["setName", 0, true];
_newOfficer setUnitLoadout _loadout;
removeGoggles _newOfficer;
sleep 0.2;

//Put scripts on him
if(_varName == "Officer_WEST") then {
	[this, "MISSION", ""] remoteExec ["FU_fnc_initTerminal", 0, true];
	[this, "RECRUIT", ""] remoteExec ["FU_fnc_initTerminal", 0, true];
};

//Repeat this script for new officer
[_newOfficer] spawn FU_fnc_officer;