player setVariable ['FUT_muteSound', false];

_tabletAction = [
	"Open FU Tablet",
	"[FUT] FU Tablet",
	"Images\GUI\FUT_ACELogo.paa",
	{[0] spawn FU_fnc_openTablet;},
	{true}
] call ace_interact_menu_fnc_createAction;

[player, 1, ["ACE_SelfActions"], _tabletAction] call ace_interact_menu_fnc_addActionToObject;