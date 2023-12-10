params ["_flag"];

_flag addAction["<img image='\A3\ui_f_orange\data\cfgTaskTypes\airdrop_ca.paa'/> HALO Drop", { 
	params ["_target", "_caller", "_actionId", "_arguments"];
	[] spawn FU_fnc_haloDrop;
}, nil, 1, true, true, "", "!FU_waitingForDrop", 5];

_flag addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\types\wait_ca.paa'/> Skip Time (4h)", { 
	params ["_target", "_caller", "_actionId", "_arguments"];
	[4] remoteExec ["skipTime", 2];
}, nil, 1, true, true, "", "true", 5];