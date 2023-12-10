disableSerialization;

createDialog "FU_RecruitUnits";

_button = (findDisplay 4615) displayCtrl 4621;
_cancel = (findDisplay 4615) displayCtrl 4622;
_text = (findDisplay 4615) displayCtrl 4614;

//Default name
_text ctrlSetText "1";

_buttonAction = _button ctrlAddEventHandler ["ButtonClick", {
	params ["_control"];
		
	[] spawn {
		_text = (findDisplay 4615) displayCtrl 4614;
		_number = parseNumber(ctrlText _text);
		_group = group player;

		closeDialog 2;
		
		if(_number <= 0 || _number > 12) then {
			hint "The number you entered is invalid, it has to be from 1 to 12.";
		} else {
			if(count (units _group) + _number > 13) then {
				hint "You have too many men in your group.";
			} else {
				//Do the stuff
				private _factionComp = [side player] call FU_fnc_getFactionCompositions;
				private _squadComp = _factionComp select 0;
				private _customLoadout = _factionComp select 3;
				private _loadoutsCheck = _customLoadout select 0;
				private _loadouts = _customLoadout select 1;
				private _spawnPos = getMarkerPos "cargoSpawn_WEST";

				for "_i" from 0 to (_number - 1) do {
					_man = _group createUnit [(_squadComp select _i), _spawnPos, [], 0, "CAN_COLLIDE"];
					_man setSkill 1;

					if(_loadoutsCheck) then {
						[_man, _loadouts select _i] call CBA_fnc_setLoadout;
					};
					
					_manName = getText (configFile >> "CfgVehicles" >> typeOf _man >> "displayName");
					[
						_man,
						format["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\types\interact_ca.paa'/> Delete %1", _manName],
						"\a3\data_f_destroyer\data\UI\IGUI\Cfg\holdactions\holdAction_loadVehicle_ca.paa",
						"\a3\data_f_destroyer\data\UI\IGUI\Cfg\holdactions\holdAction_loadVehicle_ca.paa",
						"_this distance _target < 3",
						"_caller distance _target < 3",
						{},
						{},
						{
							params ["_target", "_caller", "_actionId", "_arguments"];
							deleteVehicle _target;
						},
						{},
						[],
						1,
						0,
						false,
						false
					] remoteExecCall ["BIS_fnc_holdActionAdd", 0, true];

					sleep 0.1;	
				};
			};
		};
	};
}];