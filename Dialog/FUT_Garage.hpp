class FUT_Garage {
	idd = 4610;
	//movingEnable = true;
	enableSimulation = true;
	
	class Controls {
		class BG_Options: IGUIBack
		{
			idc = 2200;
			x = 0.0100336 * safezoneW + safezoneX;
			y = 0.071 * safezoneH + safezoneY;
			w = 0.201144 * safezoneW;
			h = 0.275 * safezoneH;
			colorBackground[] = {0,0,0,0.5};
		};
		class Button_SpawnIn: RscButton
		{
			idc = 1600;
			text = "SPAWN VEHICLE (IN)"; //--- ToDo: Localize;
			x = 0.0100336 * safezoneW + safezoneX;
			y = 0.885 * safezoneH + safezoneY;
			w = 0.201144 * safezoneW;
			h = 0.044 * safezoneH;
			colorBackground[] = {0,0,0,0.5};
			colorActive[] = {0,0,0,0.4};
			colorFocused[] = {0,0,0,0.4};
			colorDisabled[] = {0,0,0,0.2};
			tooltip = "You will spawn the vehicle and be teleported inside it."; //--- ToDo: Localize;
		};
		class Button_SpawnOut: RscButton
		{
			idc = 1601;
			text = "SPAWN VEHICLE (OUT)"; //--- ToDo: Localize;
			x = 0.0100336 * safezoneW + safezoneX;
			y = 0.94 * safezoneH + safezoneY;
			w = 0.201144 * safezoneW;
			h = 0.044 * safezoneH;
			colorBackground[] = {0,0,0,0.5};
			colorActive[] = {0,0,0,0.4};
			colorFocused[] = {0,0,0,0.4};
			colorDisabled[] = {0,0,0,0.2};
			tooltip = "You will spawn the vehicle, but you will stay where you are."; //--- ToDo: Localize;
		};
		class Button_Save: RscButton
		{
			idc = 1602;
			text = "SAVE VEHICLE"; //--- ToDo: Localize;
			x = 0.0100336 * safezoneW + safezoneX;
			y = 0.72 * safezoneH + safezoneY;
			w = 0.201144 * safezoneW;
			h = 0.044 * safezoneH;
			colorBackground[] = {0,0,0,0.5};
			colorActive[] = {0,0,0,0.4};
			colorFocused[] = {0,0,0,0.4};
			colorDisabled[] = {0,0,0,0.2};
			tooltip = "Save the vehicle with the current setup."; //--- ToDo: Localize;
		};
		class Button_Load: RscButton
		{
			idc = 1603;
			text = "LOAD VEHICLE"; //--- ToDo: Localize;
			x = 0.0100336 * safezoneW + safezoneX;
			y = 0.775 * safezoneH + safezoneY;
			w = 0.201144 * safezoneW;
			h = 0.044 * safezoneH;
			colorBackground[] = {0,0,0,0.5};
			colorActive[] = {0,0,0,0.4};
			colorFocused[] = {0,0,0,0.4};
			colorDisabled[] = {0,0,0,0.2};
			tooltip = "Load a vehicle that you have previously stored."; //--- ToDo: Localize;
		};
		class Button_Cancel: RscButton
		{
			idc = 1604;
			text = "X"; //--- ToDo: Localize;
			x = 0.959021 * safezoneW + safezoneX;
			y = 0.016 * safezoneH + safezoneY;
			w = 0.0309452 * safezoneW;
			h = 0.055 * safezoneH;
			colorBackground[] = {0,0,0,0.7};
			colorActive[] = {0,0,0,0.4};
			colorFocused[] = {0,0,0,0.4};
			colorDisabled[] = {0,0,0,0.2};
			tooltip = "Cancels the spawn"; //--- ToDo: Localize;
		};
		class BG_Title: IGUIBack
		{
			idc = 2201;
			x = 0.010034 * safezoneW + safezoneX;
			y = 0.016 * safezoneH + safezoneY;
			w = 0.201144 * safezoneW;
			h = 0.044 * safezoneH;
			colorBackground[] = {0,0,0,0.5};
		};
		class Text_Title: RscStructuredText
		{
			idc = 1101;
			text = "<t size='1.5' valign='middle' align='center'>FUG - Garage</t>"; //--- ToDo: Localize;
			x = 0.0100336 * safezoneW + safezoneX;
			y = 0.016 * safezoneH + safezoneY;
			w = 0.201144 * safezoneW;
			h = 0.044 * safezoneH;
			colorBackground[] = {0,0,0,0};
		};
		class Text_Type: RscStructuredText
		{
			idc = 1102;
			text = "<t size=""1.3"">Vehicle Type:</t>"; //--- ToDo: Localize;
			x = 0.0151911 * safezoneW + safezoneX;
			y = 0.082 * safezoneH + safezoneY;
			w = 0.190829 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {0,0,0,0};
		};
		class Combo_Type: RscCombo
		{
			idc = 2101;
			x = 0.0151911 * safezoneW + safezoneX;
			y = 0.115 * safezoneH + safezoneY;
			w = 0.190829 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class Text_Vehicle: RscStructuredText
		{
			idc = 1103;
			text = "<t size=""1.3"">Vehicle:</t>"; //--- ToDo: Localize;
			x = 0.0151911 * safezoneW + safezoneX;
			y = 0.17 * safezoneH + safezoneY;
			w = 0.190829 * safezoneW;
			h = 0.033 * safezoneH;

			
			colorBackground[] = {0,0,0,0};
		};
		class Combo_Vehicle: RscCombo
		{
			idc = 2102;
			x = 0.0151911 * safezoneW + safezoneX;
			y = 0.203 * safezoneH + safezoneY;
			w = 0.190829 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class Text_Texture: RscStructuredText
		{
			idc = 1104;
			text = "<t size=""1.3"">Vehicle Texture:</t>"; //--- ToDo: Localize;
			x = 0.0151911 * safezoneW + safezoneX;
			y = 0.258 * safezoneH + safezoneY;
			w = 0.190829 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {0,0,0,0};
		};
		class Combo_Texture: RscCombo
		{
			idc = 2103;
			x = 0.0151911 * safezoneW + safezoneX;
			y = 0.291 * safezoneH + safezoneY;
			w = 0.190829 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class Button_Pylons: RscButton
		{
			idc = 1605;
			text = "CHANGE PYLONS"; //--- ToDo: Localize;
			x = 0.0100336 * safezoneW + safezoneX;
			y = 0.357 * safezoneH + safezoneY;
			w = 0.201144 * safezoneW;
			h = 0.044 * safezoneH;
			colorBackground[] = {0,0,0,0.5};
			colorActive[] = {0,0,0,0.4};
			colorFocused[] = {0,0,0,0.4};
			colorDisabled[] = {0,0,0,0.2};
			tooltip = "Customize pylons."; //--- ToDo: Localize;
		};
		class Button_NVG: RscButton
		{
			idc = 1606;
			text = "NIGHT VISION"; //--- ToDo: Localize;
			x = 0.0100336 * safezoneW + safezoneX;
			y = 0.555 * safezoneH + safezoneY;
			w = 0.201144 * safezoneW;
			h = 0.044 * safezoneH;
			colorBackground[] = {0,0,0,0.5};
			colorActive[] = {0,0,0,0.4};
			colorFocused[] = {0,0,0,0.4};
			colorDisabled[] = {0,0,0,0.2};
			tooltip = "Turn NVG On or Off."; //--- ToDo: Localize;
		};
		class Button_Lights: RscButton
		{
			idc = 1607;
			text = "LIGHTS"; //--- ToDo: Localize;
			x = 0.0100336 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.201144 * safezoneW;
			h = 0.044 * safezoneH;
			colorBackground[] = {0,0,0,0.5};
			colorActive[] = {0,0,0,0.4};
			colorFocused[] = {0,0,0,0.4};
			colorDisabled[] = {0,0,0,0.2};
			tooltip = "Turn the lights On or Off."; //--- ToDo: Localize;
		};
	};
};


////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Bizo, v1.063, #Hucofi)
////////////////////////////////////////////////////////

class BG_Options: IGUIBack
{
	idc = 2200;

	x = 0.0100336 * safezoneW + safezoneX;
	y = 0.071 * safezoneH + safezoneY;
	w = 0.201144 * safezoneW;
	h = 0.275 * safezoneH;
	colorBackground[] = {0,0,0,0.5};
};

class Button_Pylons: RscButton
{
	idc = 1605;
	colorFocused[] = {0,0,0,0.4};
	colorDisabled[] = {0,0,0,0.2};

	text = "CHANGE PYLONS"; //--- ToDo: Localize;
	x = 0.0100336 * safezoneW + safezoneX;
	y = 0.357 * safezoneH + safezoneY;
	w = 0.201144 * safezoneW;
	h = 0.044 * safezoneH;
	colorBackground[] = {0,0,0,0.5};
	colorActive[] = {0,0,0,0.4};
	tooltip = "Customize pylons."; //--- ToDo: Localize;
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////
