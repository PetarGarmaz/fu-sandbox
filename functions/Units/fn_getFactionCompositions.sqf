params ["_side", ["_isRecruited", true]];

_squadComp = [];
_vehComp = [];
_vip = "";
_aa = "";
_mortar = "";
_jet = "";
_loadout = [false, []];

switch _side do {
	case west: {
		_randomAA = ["B_soldier_AA_F", "B_Soldier_F"] selectRandomWeighted [0.2, 0.8];
		_squadComp = ["B_Soldier_SL_F","B_medic_F",_randomAA,"B_Soldier_LAT_F","B_Soldier_TL_F","B_medic_F","B_Soldier_F","B_Soldier_AR_F","B_Soldier_TL_F","B_medic_F","B_Soldier_F","B_soldier_M_F"];
		_vehComp = ["B_LSV_01_armed_F", "B_APC_Wheeled_01_cannon_F", "B_MBT_01_TUSK_F", "B_Heli_Light_01_dynamicLoadout_F", "B_Plane_CAS_01_dynamicLoadout_F", "B_Truck_01_covered_F", "B_Heli_Transport_03_unarmed_F"];
		_vip = "B_officer_F";
		_aa = "B_APC_Tracked_01_AA_F";
		_mortar = "B_Mortar_01_F";
		_jet = "B_Plane_Fighter_01_F";
	};

	case east: {
		_randomAA = ["O_soldier_AA_F", "O_Soldier_F"] selectRandomWeighted [0.2, 0.8];
		_squadComp = ["O_Soldier_SL_F","O_medic_F",_randomAA,"O_Soldier_LAT_F","O_Soldier_TL_F","O_medic_F","O_Soldier_F","O_Soldier_AR_F","O_Soldier_TL_F","O_medic_F","O_Soldier_F","O_soldier_M_F"];
		_vehComp = ["O_LSV_02_armed_F", "O_APC_Wheeled_02_rcws_v2_F", "O_MBT_02_cannon_F", "O_Heli_Light_02_dynamicLoadout_F", "O_Plane_CAS_02_dynamicLoadout_F", "O_Truck_02_covered_F", "O_Heli_Transport_04_covered_F"];
		_vip = "O_officer_F";
		_aa = "O_APC_Tracked_02_AA_F";
		_mortar = "O_Mortar_01_F";
		_jet = "O_Plane_Fighter_02_F";
	};

	case resistance: {
		_randomAA = ["I_soldier_AA_F", "I_Soldier_F"] selectRandomWeighted [0.2, 0.8];
		_squadComp = ["I_Soldier_SL_F","I_medic_F",_randomAA,"I_Soldier_LAT_F","I_Soldier_TL_F","I_medic_F","I_Soldier_F","I_Soldier_AR_F","I_Soldier_TL_F","I_medic_F","I_Soldier_F","I_soldier_M_F"];
		_vehComp = ["B_T_LSV_01_armed_F", "I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F", "I_Heli_light_03_dynamicLoadout_F", "I_Plane_Fighter_03_CAS_F", "I_Truck_02_covered_F", "I_Heli_Transport_02_F"];
		
		if(_isRecruited) then {
			_loadout = [true, [
				[[["arifle_SPAR_01_GL_blk_F","","","optic_Hamr",["30Rnd_556x45_Stanag_Tracer_Red",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["FU_Uni_bison",[["ACE_elasticBandage",10],["ACE_packingBandage",5],["ACE_CableTie",2],["ACE_epinephrine",4],["ACE_morphine",2],["ACE_splint",2],["ACE_tourniquet",4],["ACE_MapTools",1],["ACE_Flashlight_XL50",1],["SmokeShellBlue",1,1]]],["FU_Vest_rig_blackb",[["HandGrenade",2,1],["SmokeShell",2,1],["16Rnd_9x21_Mag",2,17],["30Rnd_556x45_Stanag_Tracer_Red",10,30]]],["B_RadioBag_01_black_F",[["ACE_EntrenchingTool",1],["1Rnd_HE_Grenade_shell",15,1]]],"FU_helm_bison","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc148jem","ItemCompass","ItemWatch","ACE_NVG_Wide_Black"]],[]],
				[[["arifle_SPAR_01_blk_F","","","optic_Hamr",["30Rnd_556x45_Stanag_Tracer_Red",30],[],""],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["FU_Uni_bison",[["ACE_elasticBandage",10],["ACE_packingBandage",5],["ACE_CableTie",2],["ACE_epinephrine",4],["ACE_morphine",2],["ACE_splint",2],["ACE_tourniquet",4],["ACE_MapTools",1],["ACE_Flashlight_XL50",1],["SmokeShellBlue",1,1]]],["FU_Vest_rig_blackb",[["HandGrenade",1,1],["SmokeShell",5,1],["30Rnd_556x45_Stanag_Tracer_Red",10,30],["16Rnd_9x21_Mag",2,17]]],["FU_kitbag_black",[["ACE_EntrenchingTool",1],["ACE_elasticBandage",70],["ACE_bloodIV",5],["ACE_bloodIV_500",10],["ACE_epinephrine",30],["ACE_morphine",15],["ACE_splint",20],["ACE_tourniquet",10]]],"FU_helm_bison","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc148jem","ItemCompass","ItemWatch","ACE_NVG_Wide_Black"]],[]],
				[[["arifle_SPAR_02_blk_F","","","optic_Hamr",["30Rnd_556x45_Stanag_Tracer_Red",30],[],""],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["FU_Uni_bison",[["ACE_elasticBandage",10],["ACE_packingBandage",5],["ACE_CableTie",2],["ACE_epinephrine",4],["ACE_morphine",2],["ACE_splint",2],["ACE_tourniquet",4],["ACE_MapTools",1],["ACE_Flashlight_XL50",1],["SmokeShellBlue",1,1]]],["FU_Vest_rig_blackb",[["HandGrenade",2,1],["SmokeShell",2,1],["16Rnd_9x21_Mag",2,17],["30Rnd_556x45_Stanag_Tracer_Red",11,30]]],["B_AssaultPack_blk",[["ACE_EntrenchingTool",1]]],"FU_helm_bison","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc148jem","ItemCompass","ItemWatch","ACE_NVG_Wide_Black"]],[]],
				[[["arifle_SPAR_01_blk_F","","","optic_Hamr",["30Rnd_556x45_Stanag_Tracer_Red",30],[],""],["launch_NLAW_F","","","",[],[],""],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["FU_Uni_bison",[["ACE_elasticBandage",10],["ACE_packingBandage",5],["ACE_CableTie",2],["ACE_epinephrine",4],["ACE_morphine",2],["ACE_splint",2],["ACE_tourniquet",4],["ACE_MapTools",1],["ACE_Flashlight_XL50",1],["SmokeShellBlue",1,1]]],["FU_Vest_rig_blackb",[["HandGrenade",2,1],["SmokeShell",2,1],["30Rnd_556x45_Stanag_Tracer_Red",10,30],["16Rnd_9x21_Mag",2,17]]],["B_AssaultPack_blk",[["ACE_EntrenchingTool",1]]],"FU_helm_bison","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc148jem","ItemCompass","ItemWatch","ACE_NVG_Wide_Black"]],[]],
				[[["arifle_SPAR_01_GL_blk_F","","","optic_Hamr",["30Rnd_556x45_Stanag_Tracer_Red",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["FU_Uni_bison",[["ACE_elasticBandage",10],["ACE_packingBandage",5],["ACE_CableTie",2],["ACE_epinephrine",4],["ACE_morphine",2],["ACE_splint",2],["ACE_tourniquet",4],["ACE_MapTools",1],["ACE_Flashlight_XL50",1],["SmokeShellBlue",1,1]]],["FU_Vest_rig_blackb",[["HandGrenade",2,1],["SmokeShell",2,1],["16Rnd_9x21_Mag",2,17],["30Rnd_556x45_Stanag_Tracer_Red",10,30]]],["B_RadioBag_01_black_F",[["ACE_EntrenchingTool",1],["1Rnd_HE_Grenade_shell",15,1]]],"FU_helm_bison","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc148jem","ItemCompass","ItemWatch","ACE_NVG_Wide_Black"]],[]],
				[[["arifle_SPAR_01_blk_F","","","optic_Hamr",["30Rnd_556x45_Stanag_Tracer_Red",30],[],""],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["FU_Uni_bison",[["ACE_elasticBandage",10],["ACE_packingBandage",5],["ACE_CableTie",2],["ACE_epinephrine",4],["ACE_morphine",2],["ACE_splint",2],["ACE_tourniquet",4],["ACE_MapTools",1],["ACE_Flashlight_XL50",1],["SmokeShellBlue",1,1]]],["FU_Vest_rig_blackb",[["HandGrenade",1,1],["SmokeShell",5,1],["30Rnd_556x45_Stanag_Tracer_Red",10,30],["16Rnd_9x21_Mag",2,17]]],["FU_kitbag_black",[["ACE_EntrenchingTool",1],["ACE_elasticBandage",70],["ACE_bloodIV",5],["ACE_bloodIV_500",10],["ACE_epinephrine",30],["ACE_morphine",15],["ACE_splint",20],["ACE_tourniquet",10]]],"FU_helm_bison","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc148jem","ItemCompass","ItemWatch","ACE_NVG_Wide_Black"]],[]],
				[[["arifle_SPAR_02_blk_F","","","optic_Hamr",["30Rnd_556x45_Stanag_Tracer_Red",30],[],""],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["FU_Uni_bison",[["ACE_elasticBandage",10],["ACE_packingBandage",5],["ACE_CableTie",2],["ACE_epinephrine",4],["ACE_morphine",2],["ACE_splint",2],["ACE_tourniquet",4],["ACE_MapTools",1],["ACE_Flashlight_XL50",1],["SmokeShellBlue",1,1]]],["FU_Vest_rig_blackb",[["HandGrenade",2,1],["SmokeShell",2,1],["16Rnd_9x21_Mag",2,17],["30Rnd_556x45_Stanag_Tracer_Red",11,30]]],["B_AssaultPack_blk",[["ACE_EntrenchingTool",1]]],"FU_helm_bison","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc148jem","ItemCompass","ItemWatch","ACE_NVG_Wide_Black"]],[]],
				[[["LMG_03_F","","","optic_Hamr",["200Rnd_556x45_Box_Tracer_Red_F",200],[],""],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["FU_Uni_bison",[["ACE_elasticBandage",10],["ACE_packingBandage",5],["ACE_CableTie",2],["ACE_epinephrine",4],["ACE_morphine",2],["ACE_splint",2],["ACE_tourniquet",4],["ACE_MapTools",1],["ACE_Flashlight_XL50",1],["SmokeShellBlue",1,1]]],["FU_Vest_rig_blackb",[["HandGrenade",2,1],["SmokeShell",2,1],["16Rnd_9x21_Mag",2,17],["200Rnd_556x45_Box_Tracer_Red_F",2,200]]],["B_AssaultPack_blk",[["ACE_EntrenchingTool",1],["200Rnd_556x45_Box_Tracer_Red_F",2,200]]],"FU_helm_bison","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc148jem","ItemCompass","ItemWatch","ACE_NVG_Wide_Black"]],[]],
				[[["arifle_SPAR_01_GL_blk_F","","","optic_Hamr",["30Rnd_556x45_Stanag_Tracer_Red",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["FU_Uni_bison",[["ACE_elasticBandage",10],["ACE_packingBandage",5],["ACE_CableTie",2],["ACE_epinephrine",4],["ACE_morphine",2],["ACE_splint",2],["ACE_tourniquet",4],["ACE_MapTools",1],["ACE_Flashlight_XL50",1],["SmokeShellBlue",1,1]]],["FU_Vest_rig_blackb",[["HandGrenade",2,1],["SmokeShell",2,1],["16Rnd_9x21_Mag",2,17],["30Rnd_556x45_Stanag_Tracer_Red",10,30]]],["B_RadioBag_01_black_F",[["ACE_EntrenchingTool",1],["1Rnd_HE_Grenade_shell",15,1]]],"FU_helm_bison","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc148jem","ItemCompass","ItemWatch","ACE_NVG_Wide_Black"]],[]],
				[[["arifle_SPAR_01_blk_F","","","optic_Hamr",["30Rnd_556x45_Stanag_Tracer_Red",30],[],""],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["FU_Uni_bison",[["ACE_elasticBandage",10],["ACE_packingBandage",5],["ACE_CableTie",2],["ACE_epinephrine",4],["ACE_morphine",2],["ACE_splint",2],["ACE_tourniquet",4],["ACE_MapTools",1],["ACE_Flashlight_XL50",1],["SmokeShellBlue",1,1]]],["FU_Vest_rig_blackb",[["HandGrenade",1,1],["SmokeShell",5,1],["30Rnd_556x45_Stanag_Tracer_Red",10,30],["16Rnd_9x21_Mag",2,17]]],["FU_kitbag_black",[["ACE_EntrenchingTool",1],["ACE_elasticBandage",70],["ACE_bloodIV",5],["ACE_bloodIV_500",10],["ACE_epinephrine",30],["ACE_morphine",15],["ACE_splint",20],["ACE_tourniquet",10]]],"FU_helm_bison","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc148jem","ItemCompass","ItemWatch","ACE_NVG_Wide_Black"]],[]],
				[[["arifle_SPAR_02_blk_F","","","optic_Hamr",["30Rnd_556x45_Stanag_Tracer_Red",30],[],""],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["FU_Uni_bison",[["ACE_elasticBandage",10],["ACE_packingBandage",5],["ACE_CableTie",2],["ACE_epinephrine",4],["ACE_morphine",2],["ACE_splint",2],["ACE_tourniquet",4],["ACE_MapTools",1],["ACE_Flashlight_XL50",1],["SmokeShellBlue",1,1]]],["FU_Vest_rig_blackb",[["HandGrenade",2,1],["SmokeShell",2,1],["16Rnd_9x21_Mag",2,17],["30Rnd_556x45_Stanag_Tracer_Red",11,30]]],["B_AssaultPack_blk",[["ACE_EntrenchingTool",1]]],"FU_helm_bison","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc148jem","ItemCompass","ItemWatch","ACE_NVG_Wide_Black"]],[]],
				[[["FU_Rifle_p_b","","","optic_DMS",["20Rnd_762x51_Mag",20],[],"bipod_01_F_blk"],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["FU_Uni_bison",[["ACE_elasticBandage",10],["ACE_packingBandage",5],["ACE_CableTie",2],["ACE_epinephrine",4],["ACE_morphine",2],["ACE_splint",2],["ACE_tourniquet",4],["ACE_MapTools",1],["ACE_Flashlight_XL50",1],["SmokeShellBlue",1,1]]],["FU_Vest_rig_blackb",[["HandGrenade",2,1],["SmokeShell",2,1],["16Rnd_9x21_Mag",2,17],["20Rnd_762x51_Mag",7,20]]],["B_AssaultPack_blk",[["ACE_EntrenchingTool",1],["20Rnd_762x51_Mag",8,20]]],"FU_helm_bison","",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc148jem","ItemCompass","ItemWatch","ACE_NVG_Wide_Black"]],[]]
			]];
		};
		_vip = "I_G_officer_F";
		_aa = "I_LT_01_AA_F";
		_mortar = "I_G_Mortar_01_F";
		_jet = "I_Plane_Fighter_04_F";
	};
	
	case civilian: {
		_squadComp = ["C_Man_casual_4_F_euro","C_Man_casual_9_F_euro","C_Man_casual_1_F_euro","C_Man_smart_casual_2_F_euro","C_scientist_02_formal_F","C_man_polo_2_F_euro","C_Man_casual_5_v2_F_euro","C_Man_casual_6_F_euro","C_Man_casual_5_F_euro","C_man_shorts_1_F_euro","C_scientist_01_informal_F","C_man_sport_1_F_euro"];
		_vehComp = ["C_SUV_01_F", "C_Van_02_vehicle_F", "C_Truck_02_covered_F", "C_Heli_Light_01_civil_F", "C_Plane_Civil_01_F", "C_Truck_02_covered_F"];
	};
};

[_squadComp, _vehComp, _side, _loadout, _vip, _aa, _mortar, _jet];