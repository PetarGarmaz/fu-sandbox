params ["_player"];

private _stage = _player getVariable 'FU_trainingStage';
_stage = _stage + 1;
_player setVariable ["FU_trainingStage", _stage];

true;