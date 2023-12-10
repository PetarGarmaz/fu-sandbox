params ["_target", "_text", "_sound", ["_delay", 1], ["_locality", 0], ["_radio", true]];

if(_radio) then {
	[_sound] remoteExec ["playSound", _locality];	
} else {
	[_target, [_sound, 100]] remoteExec ["say3D", _locality];
};

/*
private _distance = player distance2D _target;
if(_distance < 10) then {
	[_target, [_sound, 100]] remoteExec ["say3D", _locality];
} else {
	[_sound] remoteExec ["playSound", _locality];	
};
*/

_target setRandomLip true;
[_target, _text] remoteExec ["sideChat", _locality];
sleep _delay;
_target setRandomLip false;

true;