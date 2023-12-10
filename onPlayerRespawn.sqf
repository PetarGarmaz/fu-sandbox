params ["_newUnit", "_oldUnit", "_respawn", "_respawnDelay"];

if(!isNil "PL") then {
	if(_oldUnit == PL) then {
		PL = _newUnit;
		publicVariable 'PL';
	};
};