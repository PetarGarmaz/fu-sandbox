FU_waitingForDrop = true;

hint "Press Left Mouse Button on a position where you want to HALO drop...";

openMap true;

haloDropHandle = (findDisplay 12 displayCtrl 51) ctrlAddEventHandler ["MouseButtonClick",{
	params ["_displayorcontrol", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];

	[] spawn {
		hint "You will be dropped in 10 seconds, do not move or touch your backpack, everything is being done automatically...";
	
		private _haloPos = (findDisplay 12 displayCtrl 51) ctrlMapScreenToWorld getMousePosition;
		
		private _marker = createMarker [format["haloDropMarker_%1", name player], _haloPos];
		_marker setMarkerText format["%1's Drop Zone", name player, 0, player];
		_marker setMarkerPos _haloPos;
		_marker setMarkerType "hd_end";
		
		_haloPos = [
			(_haloPos select 0),
			(_haloPos select 1),
			3000
		];
		
		openMap false;
		
		sleep 1;
		
		(findDisplay 12 displayCtrl 51) ctrlRemoveAllEventHandlers "MouseButtonClick";
		
		sleep 3;

		//Adding equipment
		hint "Putting away your current backpack.";
		private _backpackType = typeOf (unitBackpack player);
		private _backpackMagazines = backpackMagazines player;
		private _backpackItems = backpackItems player;
		removeBackpackGlobal player;

		sleep 3;

		hint "Adding parachute on back.";
		player addBackpackGlobal "B_Parachute";

		sleep 4;

		hint "Good luck!";
		"FU_FadeLayer" cutText ["", "BLACK OUT", 1];
		sleep 1;
		
		[  
			[  
				["HALO DROPPING ABOVE:", "<t align = 'center' shadow = '1' size = '0.7' font='PuristaBold'>%1</t><br/>", 30], 
				[format["%1", markerText _marker], "<t align = 'center' shadow = '1' size = '0.7' font='PuristaBold'>%1</t><br/>", 30] 
			], 0, 0.5 
		] spawn BIS_fnc_typeText;

		//Dropping
		player setPosASL _haloPos;

		sleep 4;
		"FU_FadeLayer" cutText ["", "BLACK IN", 5];
		
		sleep 10;

		FU_waitingForDrop = false;
		
		waitUntil{isTouchingGround player};
		sleep 1;
		
		deleteMarker _marker;
		removeBackpackGlobal player;
		player addBackpackGlobal _backpackType;
		{player addItemToBackpack _x;}foreach _backpackMagazines;
		{player addItemToBackpack _x;}foreach _backpackItems;
		
		hint "You have landed successfully! Your backpack has been restored!";
	};
}];