params ["_player", "_didJIP"];

_profileGarage = profileNamespace getVariable "FU_profileVehicleGarage";
_profileRoles = profileNamespace getVariable "FU_profileRoles";

//Check if player is new - set garage
if(isNil "_profileGarage") then {
	profileNamespace setVariable ["FU_profileVehicleGarage", []];
};

//Check if player is new - set roles
if(isNil "_profileRoles") then {
	profileNamespace setVariable ["FU_profileRoles", [
		//AR
		["I_Soldier_AR_F", [[["LMG_03_F","","","optic_Hamr",["200Rnd_556x45_Box_Tracer_Red_F",200],[],""],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["FU_Uni_bison",[["ACE_elasticBandage",10],["ACE_packingBandage",5],["ACE_CableTie",2],["ACE_epinephrine",4],["ACE_morphine",2],["ACE_splint",2],["ACE_tourniquet",4],["ACE_MapTools",1],["ACE_Flashlight_XL50",1],["SmokeShellBlue",1,1]]],["FU_Vest_rig_blackb",[["HandGrenade",2,1],["SmokeShell",2,1],["16Rnd_9x21_Mag",2,17],["200Rnd_556x45_Box_Tracer_Red_F",2,200]]],["B_AssaultPack_blk",[["ACE_EntrenchingTool",1],["200Rnd_556x45_Box_Tracer_Red_F",2,200]]],"FU_helm_bison","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc148jem","ItemCompass","ItemWatch","ACE_NVG_Wide_Black"]],[]]],
		//Crewman
		["I_crew_F", [[["arifle_SPAR_01_blk_F","","","optic_Hamr",["30Rnd_556x45_Stanag_Tracer_Red",30],[],""],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["FU_Uni_bison",[["ACE_elasticBandage",10],["ACE_packingBandage",5],["ACE_CableTie",2],["ACE_epinephrine",4],["ACE_morphine",2],["ACE_splint",2],["ACE_tourniquet",4],["ACE_MapTools",1],["ACE_Flashlight_XL50",1],["SmokeShellBlue",1,1]]],["FU_Vest_rig_black",[["ACE_artilleryTable",1],["ACE_RangeTable_82mm",1],["HandGrenade",2,1],["SmokeShell",2,1],["30Rnd_556x45_Stanag_Tracer_Red",10,30],["16Rnd_9x21_Mag",2,17]]],["B_AssaultPack_blk",[["ACE_EntrenchingTool",1],["ToolKit",1],["MineDetector",1]]],"H_Tank_eaf_F","",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc148jem","ItemCompass","ItemWatch","ACE_NVG_Wide_Black"]],[]]],
		//Marksman
		["I_Soldier_M_F", [[["FU_Rifle_p_b","","","optic_DMS",["20Rnd_762x51_Mag",20],[],"bipod_01_F_blk"],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["FU_Uni_bison",[["ACE_elasticBandage",10],["ACE_packingBandage",5],["ACE_CableTie",2],["ACE_epinephrine",4],["ACE_morphine",2],["ACE_splint",2],["ACE_tourniquet",4],["ACE_MapTools",1],["ACE_Flashlight_XL50",1],["SmokeShellBlue",1,1]]],["FU_Vest_rig_blackb",[["HandGrenade",2,1],["SmokeShell",2,1],["16Rnd_9x21_Mag",2,17],["20Rnd_762x51_Mag",7,20]]],["B_AssaultPack_blk",[["ACE_EntrenchingTool",1],["20Rnd_762x51_Mag",8,20]]],"FU_helm_bison","",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc148jem","ItemCompass","ItemWatch","ACE_NVG_Wide_Black"]],[]]],
		//Medic
		["I_medic_F", [[["arifle_SPAR_01_blk_F","","","optic_Hamr",["30Rnd_556x45_Stanag_Tracer_Red",30],[],""],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["FU_Uni_bison",[["ACE_elasticBandage",10],["ACE_packingBandage",5],["ACE_CableTie",2],["ACE_epinephrine",4],["ACE_morphine",2],["ACE_splint",2],["ACE_tourniquet",4],["ACE_MapTools",1],["ACE_Flashlight_XL50",1],["SmokeShellBlue",1,1]]],["FU_Vest_rig_blackb",[["HandGrenade",1,1],["SmokeShell",5,1],["30Rnd_556x45_Stanag_Tracer_Red",10,30],["16Rnd_9x21_Mag",2,17]]],["FU_kitbag_black",[["ACE_EntrenchingTool",1],["ACE_elasticBandage",70],["ACE_bloodIV",5],["ACE_bloodIV_500",10],["ACE_epinephrine",30],["ACE_morphine",15],["ACE_splint",20],["ACE_tourniquet",10]]],"FU_helm_bison","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc148jem","ItemCompass","ItemWatch","ACE_NVG_Wide_Black"]],[]]],
		//Heli P*lot
		["I_helipilot_F", [[["arifle_SPAR_01_blk_F","","","optic_Hamr",["30Rnd_556x45_Stanag_Tracer_Red",30],[],""],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["FU_Uni_bison",[["ACE_elasticBandage",10],["ACE_packingBandage",5],["ACE_CableTie",2],["ACE_epinephrine",4],["ACE_morphine",2],["ACE_splint",2],["ACE_tourniquet",4],["ACE_MapTools",1],["ACE_Flashlight_XL50",1],["SmokeShellBlue",1,1]]],["FU_Vest_rig_black",[["HandGrenade",2,1],["SmokeShell",2,1],["30Rnd_556x45_Stanag_Tracer_Red",10,30],["16Rnd_9x21_Mag",2,17]]],["B_AssaultPack_blk",[["ACE_EntrenchingTool",1],["ToolKit",1]]],"FU_NVG_helm","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc148jem","ItemCompass","ItemWatch",""]],[]]],
		//P*lot
		["I_pilot_F", [[["SMG_03C_TR_black","","","optic_Aco_smg",["50Rnd_570x28_SMG_03",50],[],""],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["U_I_pilotCoveralls",[["ACE_elasticBandage",10],["ACE_packingBandage",5],["ACE_CableTie",2],["ACE_epinephrine",4],["ACE_morphine",2],["ACE_splint",2],["ACE_tourniquet",4],["ACE_MapTools",1],["ACE_Flashlight_XL50",1],["SmokeShellBlue",1,1],["50Rnd_570x28_SMG_03",1,50]]],[],["B_Kitbag_sgg",[["ToolKit",1]]],"H_PilotHelmetFighter_I","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc148jem","ItemCompass","ItemWatch",""]],[]]],
		//Rifleman
		["I_soldier_F", [[["arifle_SPAR_02_blk_F","","","optic_Hamr",["30Rnd_556x45_Stanag_Tracer_Red",30],[],""],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["FU_Uni_bison",[["ACE_elasticBandage",10],["ACE_packingBandage",5],["ACE_CableTie",2],["ACE_epinephrine",4],["ACE_morphine",2],["ACE_splint",2],["ACE_tourniquet",4],["ACE_MapTools",1],["ACE_Flashlight_XL50",1],["SmokeShellBlue",1,1]]],["FU_Vest_rig_blackb",[["HandGrenade",2,1],["SmokeShell",2,1],["16Rnd_9x21_Mag",2,17],["30Rnd_556x45_Stanag_Tracer_Red",11,30]]],["B_AssaultPack_blk",[["ACE_EntrenchingTool",1]]],"FU_helm_bison","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc148jem","ItemCompass","ItemWatch","ACE_NVG_Wide_Black"]],[]]],
		//AT
		["I_Soldier_LAT_F", [[["arifle_SPAR_01_blk_F","","","optic_Hamr",["30Rnd_556x45_Stanag_Tracer_Red",30],[],""],["launch_NLAW_F","","","",[],[],""],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["FU_Uni_bison",[["ACE_elasticBandage",10],["ACE_packingBandage",5],["ACE_CableTie",2],["ACE_epinephrine",4],["ACE_morphine",2],["ACE_splint",2],["ACE_tourniquet",4],["ACE_MapTools",1],["ACE_Flashlight_XL50",1],["SmokeShellBlue",1,1]]],["FU_Vest_rig_blackb",[["HandGrenade",2,1],["SmokeShell",2,1],["30Rnd_556x45_Stanag_Tracer_Red",10,30],["16Rnd_9x21_Mag",2,17]]],["B_AssaultPack_blk",[["ACE_EntrenchingTool",1]]],"FU_helm_bison","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc148jem","ItemCompass","ItemWatch","ACE_NVG_Wide_Black"]],[]]],
		//SL
		["I_Soldier_SL_F", [[["arifle_SPAR_01_GL_blk_F","","","optic_Hamr",["30Rnd_556x45_Stanag_Tracer_Red",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["FU_Uni_bison",[["ACE_elasticBandage",10],["ACE_packingBandage",5],["ACE_CableTie",2],["ACE_epinephrine",4],["ACE_morphine",2],["ACE_splint",2],["ACE_tourniquet",4],["ACE_MapTools",1],["ACE_Flashlight_XL50",1],["SmokeShellBlue",1,1]]],["FU_Vest_rig_blackb",[["HandGrenade",2,1],["SmokeShell",2,1],["16Rnd_9x21_Mag",2,17],["30Rnd_556x45_Stanag_Tracer_Red",10,30]]],["B_RadioBag_01_black_F",[["ACE_EntrenchingTool",1],["1Rnd_HE_Grenade_shell",15,1]]],"FU_helm_bison","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc148jem","ItemCompass","ItemWatch","ACE_NVG_Wide_Black"]],[]]],
		//UAV
		["I_soldier_UAV_F", [[["arifle_SPAR_01_blk_F","","","optic_Hamr",["30Rnd_556x45_Stanag_Tracer_Red",30],[],""],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["FU_Uni_bison",[["ACE_elasticBandage",10],["ACE_packingBandage",5],["ACE_CableTie",2],["ACE_epinephrine",4],["ACE_morphine",2],["ACE_splint",2],["ACE_tourniquet",4],["ACE_MapTools",1],["ACE_Flashlight_XL50",1],["SmokeShellBlue",1,1]]],["FU_Vest_rig_blackb",[["HandGrenade",2,1],["SmokeShell",2,1],["30Rnd_556x45_Stanag_Tracer_Red",10,30],["16Rnd_9x21_Mag",2,17]]],["I_UAV_01_backpack_F",[]],"FU_helm_bison","",["Binocular","","","",[],[],""],["ItemMap","I_UavTerminal","TFAR_anprc148jem","ItemCompass","ItemWatch","ACE_NVG_Wide_Black"]],[]]]
	]];
};

//Player Variables
FU_waitingForDrop = false;
player setVariable ["FU_inSafeZone", false, true];
player setVariable ["FU_vehicleGarage", [], true];
player setVariable ["FU_totalKills", 0, true];
player setVariable ["FU_shotsFired", 0];
player setVariable ["FU_maxLifeTime", 0];
player setVariable ["FU_trainingStage", 0];

//Local inits
if("Heli_Pilot" in vehicleVarName player) then {[] spawn FU_fnc_initPilot};
[] spawn FU_fnc_initSafeZone;
[] spawn FU_fnc_initMedicalTent;
[] spawn FU_fnc_initStats;
[] spawn FU_fnc_playerMenu;

//Set player role depending on the profile loadout
private _loadout = [player] call FU_fnc_getRole;
[player, _loadout] call CBA_fnc_setLoadout;

//Create special layer for fade in and out
_hudLayer = "FU_HUD" call BIS_fnc_rscLayer;
"FU_FadeLayer" cutText ["", "BLACK OUT", 0.1];

//Other misc init stuff when spawned on server -- music, text, etc...
sleep 4;
"FU_FadeLayer" cutText ["", "BLACK IN", 5];
playMusic "BackgroundTrack01a_F";

sleep 5;

_year = systemTimeUTC select 0;
_month = systemTimeUTC select 1;
_day = systemTimeUTC select 2;
_hour = systemTimeUTC select 3;
_minute = systemTimeUTC select 4;
_baseName = "";

switch (side player) do {
	case resistance: {_baseName = "FU HQ"};
	case civilian: {_baseName = "IDAP HQ"};
};

[ 
	[ 
		[format["%1", toUpper(_baseName)], "<t align = 'left' shadow = '1' size = '0.7' font='PuristaBold'>%1</t><br/>", 20],
		[format["DATE: %1/%2/%3", _day, _month, _year], "<t align = 'left' shadow = '1' size = '0.7' font='PuristaBold'>%1</t><br/>", 20],
		[format["TIME: %1:%2 UTC", [_hour, "HH"] call BIS_fnc_timeToString, [_minute, "HH"] call BIS_fnc_timeToString], "<t align = 'left' shadow = '1' size = '0.7' font='PuristaBold'>%1</t><br/>", 60]
	], 0.0358213 * safezoneW + safezoneX, 0.808 * safezoneH + safezoneY
] spawn BIS_fnc_typeText;