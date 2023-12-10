params ["_target", "_caller", ["_arguments", ["", [0,0,0], civilian]]];

if([] call TFAR_fnc_getTeamspeakPluginVersion == "Not connected to TeamSpeak") exitWith {
	"TFAR TEAMSPEAK PLUGIN" hintC [
		"You are currently not connected to Teamspeak, or your TFAR plugin is not enabled/installed.",
		"If your TFAR plugin is not installed, please install it, then talk to the officer again.",
		parseText "You can access instructions on installing the plugin by following this link: <a color='#FFA500' href='https://wiki.fugaming.org/arma/home/intro-module-1#teamspeak-setup'>Freelancers Union Wiki - Arma 3 - Intro Module </a>"
	];
};

player setVariable ["FU_trainingStage", 1];

//Cooldown timer
[] spawn {
	private _timer = 60;

	while {_timer > 0} do {
		sleep 1;

		_timer = _timer - 1;
		missionNamespace setVariable ["FU_trainingCooldown", _timer, true];
	};
};

private _transportVehicle = "O_LSV_02_unarmed_F";
private _transportVehicleCustomTextures = ["a3\soft_f_exp\lsv_02\data\csat_lsv_01_black_co.paa","a3\soft_f_exp\lsv_02\data\csat_lsv_02_black_co.paa","a3\soft_f_exp\lsv_02\data\csat_lsv_03_black_co.paa"];
private _transportHeli = "I_Heli_light_03_unarmed_F";
private _spawnPos = getMarkerPos "FU_Intro_Drive_1";
private _waitPos = getMarkerPos "FU_Intro_Drive_2";
private _flatTirePos = getMarkerPos "FU_Intro_Drive_5";
private _getoutPos = getMarkerPos "FU_Intro_Drive_6";
private _markers = allMapMarkers select {"FU_Intro_Drive_" in _x && _x != "FU_Intro_Drive_1"};
private _mission = [player, "FU_TrainingMission_" + (name player), ["Complete your training.", "Training: " + (name player), ""], objNull, "CREATED", 1, true, "whiteboard", true] call BIS_fnc_taskCreate;
private _group = createGroup [resistance, true];
private _vehicle = createVehicle [_transportVehicle, _spawnPos, [], 10, "NONE"];
private _factionComp = [side player] call FU_fnc_getFactionCompositions;
private _squadComp = _factionComp select 0;
private _customLoadout = _factionComp select 3;
private _loadoutsCheck = _customLoadout select 0;
private _loadouts = _customLoadout select 1;
private _driver = _group createUnit [(_squadComp select 2), _spawnPos, [], 0, "CAN_COLLIDE"];

//	TASK 1
if((player getVariable 'FU_trainingStage') == 1) then {
	[_target, "Ahhh, look at that, newcomers!", "FU_Dialogue_1", 3, player, false] call FU_fnc_trainingDialogue;
	[_target, "Welcome to the Freelancers Union!", "FU_Dialogue_2", 3, player, false] call FU_fnc_trainingDialogue;
	[_target, "Since you're new around here, we need to test your skills and see if you've seen some action or not.", "FU_Dialogue_3", 7, player, false] call FU_fnc_trainingDialogue;
	[_target, "Go ahead and board that transport vehicle out back when you're ready to start!", "FU_Dialogue_4", 4, player, false] call FU_fnc_trainingDialogue;
	
	if(count _transportVehicleCustomTextures > 0) then {
		{[_vehicle, [_foreachIndex, _x]] remoteExec ["setObjectTexture", 0, true]}foreach _transportVehicleCustomTextures;
	};

	private _task = [player, ["FU_TrainingTask_1_" + (name player), _mission], ["", "[1]: Board the Transport", ""], _vehicle, "CREATED", 1, true, "getin", true] call BIS_fnc_taskCreate;

	if(_loadoutsCheck) then {
		[_driver, _loadouts select 2] call CBA_fnc_setLoadout;
	};

	_group setBehaviourStrong "CARELESS";
	_group setCombatMode "BLUE";
	_driver moveInDriver _vehicle;
	_wp = _group addWaypoint [_waitPos, 0];
	_vehicle allowDamage false;
	_driver allowDamage false;

	waitUntil {sleep 1; vehicle player == _vehicle};

	[_task, 'SUCCEEDED', true] call BIS_fnc_taskSetState;
	[player] call FU_fnc_trainingAddStage;
};

//	TASK 2
if((player getVariable 'FU_trainingStage') == 2) then {
	private _task = [player, ["FU_TrainingTask_2_" + (name player), _mission], ["", "[2]: Reach Training Grounds", ""], _getoutPos, "CREATED", 1, true, "car", true] call BIS_fnc_taskCreate;
	{_wp = _group addWaypoint [getMarkerPos _x, 0];}foreach _markers;
	[_group, 6] setWaypointType "TR UNLOAD";

	[_task, _vehicle, _driver] spawn FU_fnc_trainingPreventDriver;

	private _trigger = createTrigger ["EmptyDetector", _getoutPos, false];
	_trigger setTriggerArea [50, 50, 0, false, -1];
	_trigger setTriggerActivation ["VEHICLE", "PRESENT", false];
	_trigger triggerAttachVehicle [player];
	_trigger setTriggerStatements ["this", "", ""];

	//While driving do the intro for the radio
	sleep 10;
	[_target, "While you're traveling to the training grounds, let us use the time to get you familiarized with our radio system.", "FU_Dialogue_5", 6, player] call FU_fnc_trainingDialogue;
	[_target, "Now, grab your short range radio.", "FU_Dialogue_6", 3, player] call FU_fnc_trainingDialogue;
	"OPENING RADIO MENU" hintC [
		parseText "To open up your Short Range radio, press <t color='#FFA500'>CTRL + P</t> by default."
	];

	waitUntil {sleep 1; dialog}; sleep 3;

	[_target, "Alright, now the main thing you need to notice is the CURRENT FREQUENCY, which is 80 at the moment.", "FU_Dialogue_7", 7, player] call FU_fnc_trainingDialogue;
	[_target, "When we start our missions, the leaders usually organize their squads to have seperate frequencies...", "FU_Dialogue_8", 6, player] call FU_fnc_trainingDialogue;
	[_target, "For example, Alpha is on frequency 81.0, Bravo is on 82.0, etc...", "FU_Dialogue_9", 7, player] call FU_fnc_trainingDialogue;
	[_target, "As an example I want you to switch to frequency 83.0, then try to contact me.", "FU_Dialogue_10", 6, player] call FU_fnc_trainingDialogue;
	"CHANGING FREQUENCIES & TRANSMITTING" hintC [
		parseText "To change the frequency, you simply need to select the <t color='#FFA500'>FREQUENCY NUMBER</t> text box with your mouse, then delete it using <t color='#FFA500'>BACKSPACE</t> or <t color='#FFA500'>DELETE</t>",
		parseText "To set the new frequency, enter new <t color='#FFA500'>FREQUENCY NUMBER</t> in the text box.",
		parseText "Press <t color='#FFA500'>ENTER</t> to set it.",
		parseText "To transmit, press and hold <t color='#FFA500'>CAPS LOCK</t>."
	];

	player setVariable ["FU_hasSpoken", false, true];
	["Training_1", "OnTangent", {
		params ["_unit", "_radio", "_isSW", "_something", "_transmitting"];
		
		private _SRFrequency = [] call TFAR_fnc_currentSWFrequency;

		if(_SRFrequency == "83") then {
			if(!_transmitting) then {
				_unit setVariable ["FU_hasSpoken", true, true];
			};
		} else {
			if(!_transmitting) then {
				[
					"CHANGING FREQUENCIES & TRANSMITTING",
					[
						parseText format["You are currently on frequency <t color='#FFA500'>%1</t>. Please switch to frequency <t color='#FFA500'>83</t> and say something on the radio.", _SRFrequency],
						parseText "To change the frequency, you simply need to select the <t color='#FFA500'>FREQUENCY NUMBER</t> text box with your mouse, then delete it using <t color='#FFA500'>BACKSPACE</t> or <t color='#FFA500'>DELETE</t>",
						parseText "To set the new frequency, enter new <t color='#FFA500'>FREQUENCY NUMBER</t> in the text box.",
						parseText "Press <t color='#FFA500'>ENTER</t> to set it.",
						parseText "To transmit, press and hold <t color='#FFA500'>CAPS LOCK</t>."
					]
				] remoteExec ["hintC", _unit];
			};
		};
	}, player] call TFAR_fnc_addEventHandler;

	waitUntil {sleep 0.5; player getVariable "FU_hasSpoken"};

	[_target, "Good check!", "FU_Dialogue_11", 2, player] call FU_fnc_trainingDialogue;

	//GPS CHECK
	"ORIENTATION - GPS" hintC [
		parseText format["Press <t color='#FFA500'>%1</t> to open your GPS/MiniMap.", actionKeysNames "MiniMapToggle"],
		parseText format["Press <t color='#FFA500'>%1</t> or <t color='#FFA500'>%1</t> to open your GPS/MiniMap on different sides of your screen.", actionKeysNames "ListLeftVehicleDisplay", actionKeysNames "ListRightVehicleDisplay"]
	];

	waitUntil {sleep 1; visibleGPS};
	
	//MAP CHECK
	"ORIENTATION - MAP" hintC [
		parseText format["Press <t color='#FFA500'>%1</t> to open your Map.", actionKeysNames "showMap"]
	];

	waitUntil {sleep 1; visibleMap};

	//TASK CHECK
	"ORIENTATION - TASKS" hintC [
		parseText format["Press <t color='#FFA500'>%1</t> to open your task diary.", actionKeysNames "diary"]
	];
	
	waitUntil {sleep 1; systemChat str(_task == player call BIS_fnc_taskCurrent); _task == player call BIS_fnc_taskCurrent};

	//SETTING MARKERS
	"ORIENTATION - MARKERS" hintC [
		parseText "To create a marker on the map <t color='#FFA500'>double click</t> on the map."
	];

	waitUntil {sleep 1; count(allMapMarkers select {format["_USER_DEFINED #%1", ((netId player) splitString ":") select 0] in _x}) > 0};

	waitUntil {sleep 1; triggerActivated _trigger};
	[_task, 'SUCCEEDED', true] call BIS_fnc_taskSetState;
	[_target, "Welcome to the training area.", "", 1, player] call FU_fnc_trainingDialogue;
	waitUntil {sleep 1; vehicle player == player};
	[_target, "Head over to the shooting position next to the table by the stone wall.", "", 1, player] call FU_fnc_trainingDialogue;
	_vehicle allowDamage true;
	_driver allowDamage true;
	sleep 5;

	[player] call FU_fnc_trainingAddStage;
};

//	TASK 3
if((player getVariable 'FU_trainingStage') == 3) then {
	private _task = [player, ["FU_TrainingTask_3_" + (name player), _mission], ["", "[3]: ACE INTERACTION - Fix the Flat Tire", ""], _vehicle, "CREATED", 1, true, "repair", true] call BIS_fnc_taskCreate;
	[_target, "Oh whoops, looks like your driver had a flat tire. Why don't you go help him first, then come back to the training area.", "", 1, player] call FU_fnc_trainingDialogue;
	[_vehicle, ["HitLFWheel", 1.0]] remoteExec ["setHitPointDamage", 0];
	_driver disableAI "MOVE";
	[_vehicle, ["RHS_ERA_EXPLOSION_1", 300]] remoteExec ["say3D", 0];

	waitUntil{sleep 1; player inArea [getPos _vehicle, 5, 5, 0, false, -1]};

	"ACE INTERACTION - FIXING BROKEN TIRES" hintC [
		parseText "Your driver got a flat tire. You can fix it using the <t color='#FFA500'>ACE INTERACTION</t> from the <t color='#FFA500'>ACE 3</t> mod.",
		parseText "To use the <t color='#FFA500'>ACE INTERACTION</t>, press and hold <t color='#FFA500'>WINDOWS KEY</t>, then aim at the interactable object.",
		parseText "In this case, select the option <t color='#FFA500'>CARGO</t> to open cargo of a vehicle.",
		parseText "Select <t color='#FFA500'>SPARE WHEEL</t> and press <t color='#FFA500'>UNLOAD</t> to unload the spare wheel.",
		parseText "Drop the spare wheel next to the broken wheel axle.",
		parseText "Use <t color='#FFA500'>ACE INTERACTION</t> on the broken wheel axle select <t color='#FFA500'>CHANGE WHEEL</t>."
	];

	waitUntil {sleep 1; _vehicle getHitPointDamage "HitLFWheel" == 0};

	[_task, 'SUCCEEDED', true] call BIS_fnc_taskSetState;
	_driver enableAI "MOVE";

	[player] call FU_fnc_trainingAddStage;
};

//	TASK 4
if((player getVariable 'FU_trainingStage') == 4) then {
	private _task = [player, ["FU_TrainingTask_4_" + (name player), _mission], ["", "[4]: ACE INTERACTION - Grab Ammo Box", ""], FU_AmmoBox, "CREATED", 1, true, "rearm", true] call BIS_fnc_taskCreate;

	[_target, "Okay, come back to the range.", "", 1, player] call FU_fnc_trainingDialogue;
	[_target, "Also, while you're at it, grab yourself an ammo box infront of that rusty building there.", "", 1, player] call FU_fnc_trainingDialogue;

	waitUntil{sleep 1; player inArea [getPos FU_AmmoBox, 5, 5, 0, false, -1]};

	"ACE INTERACTION - INTERACTING" hintC [
		parseText "Reminder: to use the <t color='#FFA500'>ACE INTERACTION</t>, press and hold <t color='#FFA500'>WINDOWS KEY</t>, then aim at the interactable object."
	];

	waitUntil {sleep 1; player getVariable ["ace_dragging_isCarrying", false];};

	[_task, getPos FU_Range] call BIS_fnc_taskSetDestination;
	[_task, "ASSIGNED", true] call BIS_fnc_taskSetState;

	[_target, "Now, bring it to the shooting spot.", "", 1, player] call FU_fnc_trainingDialogue;

	waitUntil{sleep 1; player inArea [getPos FU_Range, 5, 5, 0, false, -1]};

	[_task, 'SUCCEEDED', true] call BIS_fnc_taskSetState;

	[player] call FU_fnc_trainingAddStage;
};

//	TASK 5
if((player getVariable 'FU_trainingStage') == 5) then {
	private _task = [player, ["FU_TrainingTask_5_" + (name player), _mission], ["", "[5]: ACE INTERACTION - Self Interaction", ""], player, "CREATED", 1, true, "use", true] call BIS_fnc_taskCreate;
	[_target, "Alright, why don't you shoot some targets over there?", "", 1, player] call FU_fnc_trainingDialogue;
	[_target, "Get comfy on the shooting position and let me know when you're ready to fire. Three targets will pop-up on signal.", "", 1, player] call FU_fnc_trainingDialogue;

	"ACE INTERACTION - SELF INTERACTION" hintC [
		parseText "To interact with yourself using <t color='#FFA500'>ACE SELF INTERACTION</t>, press and hold <t color='#FFA500'>CTRL + WINDOWS KEY</t>",
		parseText "Select the option <t color='#FFA500'>[TRAINING]: Ready to Fire</t>"
	];

	player setVariable ["FU_ReadyToFire", false, true];
	_action = ["Ready_To_Fire", "[TRAINING]: Ready to Fire", "\A3\ui_f\data\igui\cfg\simpleTasks\types\rifle_ca.paa", {player setVariable ["FU_ReadyToFire", true, true];}, {!(player getVariable "FU_ReadyToFire")}] call ace_interact_menu_fnc_createAction;   
	[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;

	waitUntil{sleep 1; player getVariable "FU_ReadyToFire"};

	[_task, 'SUCCEEDED', true] call BIS_fnc_taskSetState;
	[player] call FU_fnc_trainingAddStage;
};

//	TASK 6
private _results_1 = 0;
if((player getVariable 'FU_trainingStage') == 6) then {
	private _task = [player, ["FU_TrainingTask_6_" + (name player), _mission], ["", "[6]: Hit 3 targets", ""], objNull, "CREATED", 1, true, "target", true] call BIS_fnc_taskCreate;
	private _allTargets = [FU_Target_1,FU_Target_2,FU_Target_3,FU_Target_4,FU_Target_5,FU_Target_6,FU_Target_7]; 
	private _targets = []; 
	while {count _targets < 3} do { 
		_targets pushBackUnique (selectRandom _allTargets); 
	}; 

	{_x animateSource ["Terc", 1];}foreach _allTargets; sleep 3;
	{_x animateSource ["Terc", 0]; _x setVariable ["nopop", true];}foreach _targets;
	[FU_Beeper, ["FU_Beep", 200]] remoteExec ["say3D", 0]; sleep 0.1;

	player setVariable ["FU_TrainingShots", 0, true];
	private _firedEH = player addEventHandler ["FiredMan", {
		params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle"];

		private _shots = _unit getVariable "FU_TrainingShots";
		_shots = _shots + 1;
		_unit setVariable ["FU_TrainingShots", _shots, true];
	}];

	private _timer = 0;
	waitUntil {private _downTargets = _targets select {_x animationPhase "Terc" == 1}; sleep 0.1; _timer = _timer + 0.1; count _downTargets == 3};

	player removeEventHandler ["FiredMan", _firedEH];
	hint format["Shooting completed:\n- Time: %1 sec\n- Accuracy: %2%3", _timer, (3 / (player getVariable "FU_TrainingShots")) * 100, "%"];
	_results_1 = [_timer, player getVariable "FU_TrainingShots"];
	[_task, 'SUCCEEDED', true] call BIS_fnc_taskSetState;
	//{_x setVariable ["nopop", false];}foreach _targets;

	[player] call FU_fnc_trainingAddStage;
};

//	TASK 7
if((player getVariable 'FU_trainingStage') == 7) then {
	private _task = [player, ["FU_TrainingTask_7_" + (name player), _mission], ["", "[7]: STAMINA MANAGMENT: Fix the Target", ""], FU_Target_2, "CREATED", 1, true, "run", true] call BIS_fnc_taskCreate;
	[_target, "Looks like Target #2 on the construction building has broken sensors, why don't you go there and change them?", "", 1, player] call FU_fnc_trainingDialogue;

	FU_Target_Fixed = false;

	"STAMINA MANAGEMENT - INFANTRY MOVEMENT" hintC [
		parseText format["<t color='#FFA500'>COMBAT PACE</t> is slower paced running well suited for combat.", actionKeysNames "TactToggle"],
		parseText format["To toggle between combat/normal pace, press <t color='#FFA500'>%1</t>", actionKeysNames "TactToggle"],
		parseText format["To toggle between raising/lowering your weapon, press <t color='#FFA500'>%1</t>", actionKeysNames "toggleRaiseWeapon"],
		parseText format["To toggle between running/walking, press <t color='#FFA500'>%1</t>", actionKeysNames "WalkRunToggle"],
		parseText "The best way to manage your stamina efficiently is to toggle <t color='#FFA500'>COMBAT PACE</t> and to <t color='#FFA500'>LOWER YOUR WEAPON</t>."
	];

	waitUntil{sleep 1; (getPosASL player) inArea [getPosASL FU_Target_2, 20, 20, 0, false, -1]};

	[_target, "Oh, I forgot to mention, there are no ladders leading to the roof, you may need to climb.", "", 1, player] call FU_fnc_trainingDialogue;

	"ENHANCED MOVEMENT - CLIMBING" hintC [
		parseText "To climb up press <t color='#FFA500'>Left Shift+V</t>.",
		parseText "To climb down press <t color='#FFA500'>Left Shift+V</t> while <t color='#FFA500'>aiming at the ledge</t>."
	];

	waitUntil{sleep 1; FU_Target_Fixed};

	playSound "ACE_replaceUAVBattery";
	playSound "ACE_replaceUAVBattery";
	playSound "ACE_replaceUAVBattery";

	[_task, 'SUCCEEDED', true] call BIS_fnc_taskSetState;
	[player] call FU_fnc_trainingAddStage;
};

//	TASK 8
if((player getVariable 'FU_trainingStage') == 8) then {
	private _task = [player, ["FU_TrainingTask_8_" + (name player), _mission], ["", "[8]: STAMINA MANAGMENT: Run back", ""], FU_Range, "CREATED", 1, true, "run", true] call BIS_fnc_taskCreate;
	[_target, "Nice, now come back!", "", 1, player] call FU_fnc_trainingDialogue;
	[_target, "Oh, and I want you to sprint all the way back.", "", 1, player] call FU_fnc_trainingDialogue;

	"STAMINA MANAGEMENT - INFANTRY MOVEMENT" hintC [
		parseText format["To sprint, press <t color='#FFA500'>%1</t>", actionKeysNames "turbo"],
		"Sprinting is the least efficient mode of movement, but it is the fastest.",
		"You will no longer be able to sprint when you reach about 30% of your stamina."
	];

	while {true} do {
		sleep 5;

		if(speed player < 18 && player getVariable "ace_advanced_fatigue_aimfatigue" < 0.65) then {
			private _rng = [0, 3] call BIS_fnc_randomInt;

			if(_rng == 0) then {[_target, "Stop slacking and start sprinting!", "", 1, player] call FU_fnc_trainingDialogue;};
			if(_rng == 1) then {[_target, "You call that sprinting?!", "", 1, player] call FU_fnc_trainingDialogue;};
			if(_rng == 2) then {[_target, "Come on, come on, step on it granny!", "", 1, player] call FU_fnc_trainingDialogue;};
			if(_rng == 3) then {[_target, "Get going already!", "", 1, player] call FU_fnc_trainingDialogue;};
		};

		if(player inArea [getPos FU_Range, 3, 3, 0, false, -1]) exitWith {};
	};

	[_task, 'SUCCEEDED', true] call BIS_fnc_taskSetState;
	[player] call FU_fnc_trainingAddStage;
};

//	TASK 9
if((player getVariable 'FU_trainingStage') == 9) then {
	private _task = [player, ["FU_TrainingTask_9_" + (name player), _mission], ["", "[9]: Hit 3 targets", ""], objNull, "CREATED", 1, true, "target", true] call BIS_fnc_taskCreate;
	[_target, "Good, now try hitting the targets again after the beep!", "", 1, player] call FU_fnc_trainingDialogue;

	sleep 3;

	private _allTargets = [FU_Target_1,FU_Target_2,FU_Target_3,FU_Target_4,FU_Target_5,FU_Target_6,FU_Target_7]; 
	private _targets = []; 
	while {count _targets < 3} do { 
		_targets pushBackUnique (selectRandom _allTargets); 
	}; 
	{_x animateSource ["Terc", 1];}foreach _allTargets; sleep 3;
	{_x animateSource ["Terc", 0]; _x setVariable ["nopop", true];}foreach _targets;
	[FU_Beeper, ["FU_Beep", 200]] remoteExec ["say3D", 0]; sleep 0.1;

	player setVariable ["FU_TrainingShots", 0, true];
	private _firedEH = player addEventHandler ["FiredMan", {
		params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle"];

		private _shots = _unit getVariable "FU_TrainingShots";
		_shots = _shots + 1;
		_unit setVariable ["FU_TrainingShots", _shots, true];
	}];

	private _timer = 0;
	waitUntil {private _downTargets = _targets select {_x animationPhase "Terc" == 1}; sleep 0.1; _timer = _timer + 0.1; count _downTargets == 3};

	player removeEventHandler ["FiredMan", _firedEH];
	hint format["Shooting completed:\n- Time: %1 sec\n- Accuracy: %2%3", _timer, (3 / (player getVariable "FU_TrainingShots")) * 100, "%"];
	{_x setVariable ["nopop", false];}foreach _allTargets;
	private _results_2 = [_timer, player getVariable "FU_TrainingShots"];
	[_task, 'SUCCEEDED', true] call BIS_fnc_taskSetState;

	if(_results_2 select 1 > _results_1 select 1) then {
		[_target, "As you can clearly see by these results, this time you had worse accuracy than last time.", "", 1, player] call FU_fnc_trainingDialogue;
		[_target, "That is caused by the weapon sway you got from exerting yourself too much.", "", 1, player] call FU_fnc_trainingDialogue;
	} else {
		if(_results_2 select 0 > _results_1 select 0) then {
			[_target, "Uhhhh, as you can clearly see by these results, you had the same or better accuracy, but it took you longer to take down your targets.", "", 1, player] call FU_fnc_trainingDialogue;
			[_target, "That is caused by the weapon sway you got from exerting yourself too much.", "", 1, player] call FU_fnc_trainingDialogue;
		} else {
			[_target, "Huh...I was going to mention how exerting yourself takes a toll on your aim, but apparently you didn't even break a sweat...", "", 1, player] call FU_fnc_trainingDialogue;
		};
	};

	sleep 5;

	[player] call FU_fnc_trainingAddStage;
};

//	TASK 10
if((player getVariable 'FU_trainingStage') == 10) then {
	private _task = [player, ["FU_TrainingTask_10_0_" + (name player), _mission], ["", "[10]: GRENADES - Get Grenades (Min: 5)", ""], FU_Range_G, "CREATED", 1, true, "resupply", true] call BIS_fnc_taskCreate;
	[_target, "Anyways, let's move on now, shall we? Go ahead and get set up on the grenades stand.", "", 1, player] call FU_fnc_trainingDialogue;
	[_target, "Grab yourself 5 or more grenades from the box.", "", 1, player] call FU_fnc_trainingDialogue;

	waitUntil{
		sleep 1;
		_count_1 = {_x == "HandGrenade"} count (uniformItems player);
		_count_2 = {_x == "HandGrenade"} count (VestItems player);
		_count_3 = {_x == "HandGrenade"} count (backpackItems player);
		
		_count_1 + _count_2 + _count_3 >= 5
	};


	if(actionKeysNames "throw" == """G""") then {
		[_target, "Just, uhhh, be careful with them please.", "", 1, player] call FU_fnc_trainingDialogue;

		"GRENADES - CAUSION" hintC [
			parseText format["Your grenade throw button is bound to <t color='#FFA500'>%1</t>", actionKeysNames "throw"],
			parseText "For preventive reasons, please bind your grenade throw to <t color='#FFA500'>2xG</t>"
		];
	};
	
	[_task, 'SUCCEEDED', true] call BIS_fnc_taskSetState;

	sleep 2;

	private _task = [player, ["FU_TrainingTask_10_1_" + (name player), _mission], ["", "[10-1]: GRENADES - Toss a Grenade Through Window", ""], getPos FU_Grenades_1, "CREATED", 1, true, "destroy", true] call BIS_fnc_taskCreate;
	[_target, "Alright, now first target is that window infront of you. Toss a grenade over there.", "", 1, player] call FU_fnc_trainingDialogue;
	player setVariable ["FU_Grenade_1", false, true];

	"GRENADE MENU - TOSSING GRENADES" hintC [
		parseText "To open <t color='#FFA500'>Grenade Menu</t>, press <t color='#FFA500'>Shift+G</t>",
		parseText "Dots represent the arc of the grenade. <t color='#FFA500'>Grenade Menu</t>, press <t color='#FFA500'>Shift+G</t>",
		parseText "<t color='#FFA500'>White Dots</t> = flight path",
		parseText "<t color='#00FF00'>Green Dots</t> = collision with ground surface",
		parseText "<t color='#FF0000'>Red Dots</t> = collision with object",
		parseText "<t color='#FFFF00'>Yellow Dots</t> = possible collision"
	];

	["ace_firedPlayer", {
		params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle"];

		[_projectile] spawn {
			params ["_projectile"];
			
			sleep 2;

			if(_projectile inArea FU_Grenades_1 && typeOf _projectile == "GrenadeHand") then {
				player setVariable ["FU_Grenade_1", true, true];
			};
		};

	}] call CBA_fnc_addEventHandler;

	waitUntil{sleep 1; player getVariable "FU_Grenade_1"};
	[_task, 'SUCCEEDED', true] call BIS_fnc_taskSetState;

	private _task = [player, ["FU_TrainingTask_10_2_" + (name player), _mission], ["", "[10-2]: GRENADES - Toss a Grenade Through Concrete Pipe (Tall)", ""], getPos FU_Grenades_2, "CREATED", 1, true, "destroy", true] call BIS_fnc_taskCreate;
	[_target, "Next target, that tall concrete pipe. Lob the grenade in.", "", 1, player] call FU_fnc_trainingDialogue;
	player setVariable ["FU_Grenade_2", false, true];

	"GRENADE MENU - LOBBING GRENADES" hintC [
		parseText "To lob a grenade, open <t color='#FFA500'>Grenade Menu</t>, press <t color='#FFA500'>Shift+G</t>, then use <t color='#FFA500'>Scrollwheel Up/Down</t>"
	];

	["ace_firedPlayer", {
		params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle"];

		[_projectile] spawn {
			params ["_projectile"];
			
			sleep 2;

			if(_projectile inArea FU_Grenades_2 && typeOf _projectile == "GrenadeHand") then {
				player setVariable ["FU_Grenade_2", true, true];
			};
		};

	}] call CBA_fnc_addEventHandler;

	waitUntil{sleep 1; player getVariable "FU_Grenade_2"};
	[_task, 'SUCCEEDED', true] call BIS_fnc_taskSetState;

	private _task = [player, ["FU_TrainingTask_10_3_" + (name player), _mission], ["", "[10-3]: GRENADES - Toss a Grenade Through Concrete Pipe (Low)", ""], getPos FU_Grenades_3, "CREATED", 1, true, "destroy", true] call BIS_fnc_taskCreate;
	[_target, "Final target, that lower concrete pipe. Drop the grenade in.", "", 1, player] call FU_fnc_trainingDialogue;
	player setVariable ["FU_Grenade_3", false, true];

	"GRENADE MENU - DROPPING GRENADES" hintC [
		parseText "To drop a grenade, open <t color='#FFA500'>Grenade Menu</t>, press <t color='#FFA500'>Shift+G</t>, then press <t color='#FFA500'>Ctrl+G</t>"
	];

	["ace_firedPlayer", {
		params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle"];

		[_projectile] spawn {
			params ["_projectile"];
			
			sleep 2;

			if(_projectile inArea FU_Grenades_3 && typeOf _projectile == "GrenadeHand") then {
				player setVariable ["FU_Grenade_3", true, true];
			};
		};

	}] call CBA_fnc_addEventHandler;

	waitUntil{sleep 1; player getVariable "FU_Grenade_3"};
	[_task, 'SUCCEEDED', true] call BIS_fnc_taskSetState;

	sleep 5;

	[player] call FU_fnc_trainingAddStage;
};

//	TASK 11
if((player getVariable 'FU_trainingStage') == 11) then {
	private _task = [player, ["FU_TrainingTask_11_" + (name player), _mission], ["", "[11]: MEDICAL", ""], FU_Wounded, "CREATED", 1, true, "heal", true] call BIS_fnc_taskCreate;
		
	[_target, "Okay, next up is the medical training. We'll only go over the simple theory, as you can only learn more advanced stuff out in the field.", "", 1, player] call FU_fnc_trainingDialogue;
	[_target, "Head over to the medical tent over there, a wounded man should be waiting for you.", "", 1, player] call FU_fnc_trainingDialogue;

	_wounded = _group createUnit [(_squadComp select 2), getPosATL FU_Wounded, [], 3, "CAN_COLLIDE"];
	if(_loadoutsCheck) then {[_wounded, _loadouts select 2] call CBA_fnc_setLoadout;};
	_wounded disableAI "ALL";
	_wounded setUnitPos "DOWN";
	[_wounded, "Unconscious"] remoteExec ["switchMove", 0];
	[_wounded, 1, "LeftLeg", "bullet"] call ace_medical_fnc_addDamageToUnit;
	removeAllItems _wounded;

	waitUntil{sleep 1; player inArea [getPos _wounded, 5, 5, 0, false, -1]};

	"MEDICAL MENU - OPENING THE MENU" hintC [
		parseText "The most basic form of healing others is applying bandages on wounded body parts.",
		parseText "In case of the unit in front of you, his chest seems to be wounded.",
		parseText "To begin the healing process, first open <t color='#FFA500'>Medical Menu</t> by pressing <t color='#FFA500'>H</t>, while <t color='#FFA500'>aiming at the wounded soldier</t>."
	];

	waitUntil{sleep 1; dialog};

	"MEDICAL MENU - BANDAGING" hintC [
		parseText "Wounded body parts show up on the body image at the center of the menu.",
		parseText "There are 6 body parts: Head, Body, Left Arm, Right Arm, Left Leg and Right Leg.",
		parseText "Wounded body parts show different colors depending on the damage caused (<t color='#FFFF00'>Yellow is small</t>, <t color='#FFA500'>Orange is medium</t> and <t color='#FF0000'>Red is severe</t>).",
		parseText "To close the wound, select the wounded body part, in this case the <t color='#FFA500'>Left Leg</t>, then select the <t color='#FFA500'>Bandage / Fractures</t> tab on the left-hand side of the menu and finally select either <t color='#FFA500'>Elastic bandage</t> or <t color='#FFA500'>Packing bandage</t> to close the wound.",
		parseText "Wound will be closed until the body shows either <t color='#FFFFFF'>WHITE</t> or <t color='#0000FF'>BLUE</t> color."
	];

	sleep 1;

	while {true} do {
		if(!alive _wounded) then {
			[_wounded, "UnconsciousOutProne"] remoteExec ["switchMove", 0];
			[_target, "Ahhhh damn, our wounded guy died, oh well, let's get another one, shall we?", "", 1, player] call FU_fnc_trainingDialogue;
			deleteVehicle _wounded;

			_wounded = _group createUnit [(_squadComp select 2), getPosATL FU_Wounded, [], 2, "CAN_COLLIDE"];
			if(_loadoutsCheck) then {[_wounded, _loadouts select 2] call CBA_fnc_setLoadout;};
			_wounded disableAI "ALL";
			_wounded setUnitPos "DOWN";
			[_wounded, "Unconscious"] remoteExec ["switchMove", 0];
			[_wounded, 1, "LeftLeg", "bullet"] call ace_medical_fnc_addDamageToUnit;
			removeAllItems _wounded;
		} else {
			if((_wounded getvariable "ace_medical_bodypartdamage") select 4 <= 0.1) exitWith {
				[_wounded, "UnconsciousOutProne"] remoteExec ["switchMove", 0];
				[_task, 'SUCCEEDED', true] call BIS_fnc_taskSetState;
				break;
			};
		};

		sleep 2;
	};

	[_target, "There we go, our wounded guy is back up!", "", 1, player] call FU_fnc_trainingDialogue;
	[_target, "He's in pain at the moment, so he'll need to give himself some morpheine later. Fun fact, you can overdose on morpheine, if you inject more than 1 within 15 minutes.", "", 1, player] call FU_fnc_trainingDialogue;
	
	[_target, "Well, thats all we can do with simulated medical here...like I said, this is best learned out in the field with our experienced medics by your side.", "", 1, player] call FU_fnc_trainingDialogue;
};

[_mission, 'SUCCEEDED', true] call BIS_fnc_taskSetState;

//PRACTICAL MISSION
[_target, "Alright, that's going to be it for the training.", "", 1, player] call FU_fnc_trainingDialogue;
[_target, "And by the look of these results you've done more than enough to prove yourself as a good member of our team.", "", 1, player] call FU_fnc_trainingDialogue;
[_target, "Now return back to...", "", 1, player] call FU_fnc_trainingDialogue; sleep 1;
[_target, "...wait one...", "", 1, player] call FU_fnc_trainingDialogue; sleep 5;
[_target, "Well, it seems we have a first job for you.", "", 1, player] call FU_fnc_trainingDialogue;
[_target, "It seems our contractors have found a local guerrilla force hideout, they want us to head over there and clear it out.", "", 1, player] call FU_fnc_trainingDialogue;
[_target, "But our recon team is one man short, so we're sending you to fill up that spot.", "", 1, player] call FU_fnc_trainingDialogue;
[_target, "A helicopter will pick you up and fly you over, so head over to the LZ and board the helicopter.", "", 1, player] call FU_fnc_trainingDialogue;
[_target, "Good luck! See you back at base!", "", 1, player] call FU_fnc_trainingDialogue;

private _mission = [player, "FU_TrainingMission_Practical_" + (name player), ["Complete your first mission.", "First Mission", ""], objNull, "CREATED", 1, true, "whiteboard", true] call BIS_fnc_taskCreate;
private _task = [player, ["FU_TrainingTask_Practical_1_" + (name player), _mission], ["", "Interact with the FU Flag", ""], getPos FU_Flag_1, "CREATED", 1, true, "use", true] call BIS_fnc_taskCreate;

//Prevent player from dying
[_mission] spawn FU_fnc_trainingPreventDeath;

playMusic "EventTrack01a_F_Tacops";


//Find a nice location
//Reset the locations if all have been used already

if(count FU_trainingLocations == 0) then {
	missionNamespace setVariable ["FU_trainingLocations", allMapMarkers select {"FU_TrainingLocation_" in _x}, true];
	missionNamespace setVariable ["FU_trainingLocationsLZ", allMapMarkers select {"FU_TrainingLZ_" in _x}, true];
};

private _index = [0, (count FU_trainingLocations) - 1] call BIS_fnc_randomInt;

private _locations = FU_trainingLocations;
private _lzs = FU_trainingLocationsLZ;
private _teamLocations = allMapMarkers select {"FU_RedTeam" in _x};
private _trapLocations = allMapMarkers select {"FU_Trap" in _x};

private _location = FU_trainingLocations select _index;
private _lz = FU_trainingLocationsLZ select _index;

private _enemyFactionComp = [["O_G_Soldier_SL_F","O_G_medic_F","O_G_Soldier_F","O_G_Soldier_LAT2_F","O_G_Soldier_SL_F","O_G_medic_F","O_G_Soldier_F","O_G_Soldier_AR_F","O_G_Soldier_SL_F","O_G_medic_F","O_G_Soldier_F","O_G_Soldier_LAT_F"], ["O_G_Offroad_01_F","O_G_Offroad_01_armed_F","O_G_Offroad_01_AT_F","O_G_Van_02_vehicle_F","O_G_Van_02_transport_F","O_G_Van_01_transport_F","O_G_Quadbike_01_F"], east, [false, []], "", "", "", ""];

_locations deleteAt _index;
_lzs deleteAt _index;

missionNamespace setVariable ["FU_trainingLocations", _locations, true];
missionNamespace setVariable ["FU_trainingLocationsLZ", _lzs, true];

//Enemies
[getMarkerPos _location, _enemyFactionComp, 80, [70,70,0,false], "CANNOT_MOVE"] call FU_fnc_spawnGarrison;

//Friendlies
_assaultGroup = createGroup [resistance, true];

for "_i" from 0 to 10 do {
	_man = _assaultGroup createUnit [(_squadComp select _i), getMarkerPos _lz, [], 0, "CAN_COLLIDE"];
	_man setSkill 1;

	if(_loadoutsCheck) then {
		[_man, _loadouts select _i] call CBA_fnc_setLoadout;
	};

	_man setUnitPos "MIDDLE";
	_man allowDamage false;
};

_leader = leader _assaultGroup;
_leader setIdentity "Guthammer";

_assaultGroup setGroupId ["Guthammer"];
_assaultGroup setCombatMode "GREEN";
_assaultGroup setFormation "FILE";

FU_Flag_1 addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\types\meet_ca.paa'/> Teleport to the meeting point", { 
	params ["_target", "_caller", "_actionId", "_arguments"];
	
	"FU_FadeLayer" cutText ["", "BLACK OUT", 2];
	_caller allowDamage false;
	playSound "outro_Truck";
	playSound "outro_Truck";
	playSound "outro_Truck";
	sleep 2;
		
	[
		[  
			["TELEPORTING TO:", "<t align = 'center' shadow = '1' size = '0.7' font='PuristaBold'>%1</t><br/>", 10], 
			["Meeting Point", "<t align = 'center' shadow = '1' size = '0.7' font='PuristaBold'>%1</t><br/>", 30] 
		], 0, 0.5  
	] spawn BIS_fnc_typeText;

	if(vehicle _tpTarget != _tpTarget) then { 
		_caller moveInAny (vehicle _tpTarget);  
	} else { 
		_caller setPosASL (getPosASL _tpTarget);  
	};
	
	"FU_FadeLayer" cutText ["", "BLACK IN", 5];
	sleep 5; 
	
	_caller allowDamage true; 
}, nil, 1.5, true, true, "", "true", 5];

waitUntil{sleep 1; player inArea [getPos _leader, 100, 100, 0, false, -1]};
[_task, 'SUCCEEDED', true] call BIS_fnc_taskSetState;

private _task = [player, ["FU_TrainingTask_Practical_2_" + (name player), _mission], ["", "Rendevous with Assault Squad", ""], _lz, "CREATED", 1, true, "meet", true] call BIS_fnc_taskCreate;

waitUntil{sleep 1; player inArea [getPos _leader, 5, 5, 0, false, -1]};

[_leader, "Ah, there you are, come on, fall in.", "FU_Dialogue_G_1", 3, player, false] call FU_fnc_trainingDialogue;
"ACE INTERACTION - JOINING GROUPS" hintC [
	parseText "To join a group, open <t color='#FFA500'>ACE Interaction</t> menu, then select <t color='#FFA500'>Interactions</t> on a unit you want to join and finally select the <t color='#FFA500'>Join Group</t>."
];

waitUntil {player in (units _assaultGroup)};

[_task, 'SUCCEEDED', true] call BIS_fnc_taskSetState;

sleep 2;

_task = [player, ["FU_TrainingTask_Practical_3_" + (name player), _mission], ["", "Join Green Team", ""], _lz, "CREATED", 1, true, "meet", true] call BIS_fnc_taskCreate;

[_leader, "Here's the situation, the guerrilla force has holed up in that compound just up ahead, we're going to split into 2 fire teams and assault the hideout at the same time from 2 positions.", "FU_Dialogue_G_2", 11, player, false] call FU_fnc_trainingDialogue;
[_leader, "Now, join green team, then once you do we can begin the assault.", "FU_Dialogue_G_3", 5, player, false] call FU_fnc_trainingDialogue;

{
	if(!isPlayer _x) then {
		if(_foreachindex <= 5) then {
			_x assignTeam "RED";
		} else {
			_x assignTeam "GREEN";
		};
	};
}foreach (units _assaultGroup);

"ACE INTERACTION - JOINING FIRE TEAMS" hintC [
	parseText "To join a fire team, open <t color='#FFA500'>ACE Self Interaction</t> menu, then select <t color='#FFA500'>Team Management</t> and finally select the <t color='#00FF00'>Join Green</t>."
];

waitUntil {assignedTeam player == "GREEN"};

playMusic "AmbientTrack01_F_Tank";

[_task, 'SUCCEEDED', true] call BIS_fnc_taskSetState;

_red = (units _assaultGroup) select {assignedTeam _x == "RED"};
_green = (units _assaultGroup) select {assignedTeam _x == "GREEN"};

_redPos = getmarkerPos ([_teamLocations, getmarkerPos _location] call BIS_fnc_nearestPosition);
_dir = _redPos getDir (getmarkerPos _location);
_dir = (_dir - 90) % 360;
_dist = _redPos distance2D (getmarkerPos _location);
_greenPos = (getmarkerPos _location) getPos [_dist, _dir];

_red doMove _redPos; sleep 5;
_green doMove _greenPos;

{_x setUnitPos "UP";}foreach (units _assaultGroup);

_task = [player, ["FU_TrainingTask_Practical_4_" + (name player), _mission], ["", "Move to assigned position", ""], _greenPos, "CREATED", 1, true, "run", true] call BIS_fnc_taskCreate;
[_leader, "Red team, move right.", "FU_Dialogue_G_4", 3, player] call FU_fnc_trainingDialogue;
[_leader, "Green team, move left.", "FU_Dialogue_G_5", 3, player] call FU_fnc_trainingDialogue;

waitUntil {player distance2D _greenPos <= 50};

[_task, 'SUCCEEDED', true] call BIS_fnc_taskSetState;

_task = [player, ["FU_TrainingTask_Practical_5_" + (name player), _mission], ["", "Assault the Hideout", ""], _location, "CREATED", 1, true, "attack", true] call BIS_fnc_taskCreate;
_assaultGroup setCombatMode "YELLOW";
_red doMove (getmarkerPos _location);
_green doMove (getmarkerPos _location);
{_x setUnitPos "UP";}foreach (units _assaultGroup);

while {true} do {
	private _allUnits = allUnits inAreaArray [getmarkerPos _location, 150, 150, 0, false, -1];
	private _enemyUnits = _allUnits select {side _x == east};

	if(count _enemyUnits == 0) exitWith {};

	sleep 5;
};

[_leader, "Something isn't right, there aren't nearly enough enemies as our intel suggested, stay frosty, this could be a trap.", "FU_Dialogue_G_6", 1, player] call FU_fnc_trainingDialogue;
{_x setUnitPos "MIDDLE";}foreach (units _assaultGroup);
_assaultGroup setCombatMode "RED";
playMusic "LeadTrack03_F_EPC";
_trapPos = getmarkerPos ([_trapLocations, getmarkerPos _location] call BIS_fnc_nearestPosition);
_enemyGroup_1 = [_trapPos, _enemyFactionComp, 0, 40, getMarkerPos _location, "true"] call FU_fnc_spawnAttackers;
_enemyGroup_2 = [_trapPos, _enemyFactionComp, 0, 40, getMarkerPos _location, "true"] call FU_fnc_spawnAttackers;
_enemyGroup_3 = [_trapPos, _enemyFactionComp, 3, 40, getMarkerPos _location, "true"] call FU_fnc_spawnAttackers;
_enemyGroup_4 = [_trapPos, _enemyFactionComp, 7, 40, getMarkerPos _location, "true"] call FU_fnc_spawnAttackers;


while {true} do {
	private _allUnits = allUnits inAreaArray [getmarkerPos _location, 350, 350, 0, false, -1];
	private _enemyUnits = _allUnits select {side _x == east};

	if(count _enemyUnits == 0) exitWith {
		[_task, 'SUCCEEDED', true] call BIS_fnc_taskSetState;
	};

	sleep 5;
};

playMusic "EventTrack02_F_EPA";

[_leader, "Alright, I suppose that's it. Thanks for the help rookie, we'll finish things up here. You're free to return back to base.", "FU_Dialogue_G_7", 9, player] call FU_fnc_trainingDialogue;
[_leader, "Oh, I almost forgot...welcome to the Freelancers Union!", "FU_Dialogue_G_8", 6, player] call FU_fnc_trainingDialogue;

[_mission, 'SUCCEEDED', true] call BIS_fnc_taskSetState;
_newGroup = createGroup [resistance, true];
[player] join _newGroup;

"FU_FadeLayer" cutText ["", "BLACK OUT", 5];
sleep 5;
player setPos (getMarkerPos "respawn_guerrila");
sleep 2;
"FU_FadeLayer" cutText ["", "BLACK IN", 5];

private _wipeList = nearestObjects [getmarkerPos _location, ["Man", "LandVehicle"], 500, true];
{deleteVehicle _x; sleep 0.02;}foreach _wipeList;

player setVariable ["FU_trainingStage", 0];