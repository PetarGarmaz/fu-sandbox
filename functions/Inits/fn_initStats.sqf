//Shots Fired stat
player addEventHandler ["Fired", {
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
	
	private _shotsFired = _unit getVariable "FU_shotsFired";
	_unit setVariable ["FU_shotsFired", _shotsFired + 1];
}];

//Lifetime stat
private _lifetime = 0;
while {true} do {
	private _maxLifeTime = player getVariable "FU_maxLifeTime";

	if(alive player) then {
		_lifetime = _lifetime + 1;
		
		if(_lifetime > _maxLifeTime) then {
			_maxLifeTime = _lifetime;
		};
	} else {
		_lifetime = 0;
	};
	
	sleep 1;
	player setVariable ["FU_maxLifeTime", _maxLifeTime];
};