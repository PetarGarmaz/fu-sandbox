class FU_VehiclesMenu {
	idd = 4602;
	
	class Controls {
		class MainScreen: IGUIBack
		{
			idc = 4601;

			x = 0.314961 * safezoneW + safezoneX;
			y = 0.302 * safezoneH + safezoneY;
			w = 0.370696 * safezoneW;
			h = 0.517 * safezoneH;
		};
		class BG3_Title: IGUIBack
		{
			idc = 4602;

			x = 0.32464 * safezoneW + safezoneX;
			y = 0.324 * safezoneH + safezoneY;
			w = 0.350713 * safezoneW;
			h = 0.055 * safezoneH;
			colorBackground[] = {0,0,0,0.25};
		};
		class Title: RscStructuredText
		{
			idc = 4603;

			text = "<t size='1.5' valign='middle' align='center'>PLAYER STATISTICS</t>"; //--- ToDo: Localize;
			x = 0.32464 * safezoneW + safezoneX;
			y = 0.32994 * safezoneH + safezoneY;
			w = 0.350713 * safezoneW;
			h = 0.055 * safezoneH;
		};

		class GarageButton: RscButton
		{
			idc = 4604;
			text = "Virtual Garage"; //--- ToDo: Localize;
			x = 0.324644 * safezoneW + safezoneX;
			y = 0.401 * safezoneH + safezoneY;
			w = 0.350713 * safezoneW;
			h = 0.044 * safezoneH;
			colorDisabled[] = {0,0,0,0.7};
			colorBackgroundDisabled[] = {0,0,0,0.7};
			colorBackgroundActive[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0.5};
			tooltip = "Open Virtual Garage with all vehicles"; //--- ToDo: Localize;
		};
		class ManagerButton: RscButton
		{
			idc = 4605;
			text = "Vehicle Manager"; //--- ToDo: Localize;
			x = 0.324644 * safezoneW + safezoneX;
			y = 0.467 * safezoneH + safezoneY;
			w = 0.350713 * safezoneW;
			h = 0.044 * safezoneH;
			colorDisabled[] = {0,0,0,0.7};
			colorBackgroundDisabled[] = {0,0,0,0.7};
			colorBackgroundActive[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0.5};
			tooltip = "Opens personal garage with currently pulled and saved vehicles."; //--- ToDo: Localize;
		};
		class RequestButton: RscButton
		{
			idc = 4606;
			text = "Request Transport"; //--- ToDo: Localize;
			x = 0.324644 * safezoneW + safezoneX;
			y = 0.533 * safezoneH + safezoneY;
			w = 0.350713 * safezoneW;
			h = 0.044 * safezoneH;
			colorDisabled[] = {0,0,0,0.7};
			colorBackgroundDisabled[] = {0,0,0,0.7};
			colorBackgroundActive[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0.5};
			tooltip = "Request a pickup from currently online pilots, they may or may not come."; //--- ToDo: Localize;
		};

		class Close: RscButton
		{
			idc = 4607;
			colorDisabled[] = {0,0,0,0.7};
			colorBackgroundDisabled[] = {0,0,0,0.7};
			colorBackgroundActive[] = {0,0,0,1};

			text = "Close"; //--- ToDo: Localize;
			x = 0.510297 * safezoneW + safezoneX;
			y = 0.753 * safezoneH + safezoneY;
			w = 0.164754 * safezoneW;
			h = 0.044 * safezoneH;
			colorBackground[] = {0,0,0,0.5};
		};
		class Back: RscButton
		{
			idc = 4608;
			colorDisabled[] = {0,0,0,0.7};
			colorBackgroundDisabled[] = {0,0,0,0.7};
			colorBackgroundActive[] = {0,0,0,1};

			text = "Back"; //--- ToDo: Localize;
			x = 0.324949 * safezoneW + safezoneX;
			y = 0.753 * safezoneH + safezoneY;
			w = 0.164754 * safezoneW;
			h = 0.044 * safezoneH;
			colorBackground[] = {0,0,0,0.5};
		};
	};
};
