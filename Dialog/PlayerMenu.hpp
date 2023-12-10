class FU_PlayerMenu {
	idd = 4600;
	
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

			text = "<t size='1.5' valign='middle' align='center'>FU PLAYER MENU</t>"; //--- ToDo: Localize;
			x = 0.32464 * safezoneW + safezoneX;
			y = 0.32994 * safezoneH + safezoneY;
			w = 0.350713 * safezoneW;
			h = 0.055 * safezoneH;
		};
		class Stats: RscButton
		{
			idc = 4604;
			colorDisabled[] = {0,0,0,0.7};
			colorBackgroundDisabled[] = {0,0,0,0.7};
			colorBackgroundActive[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0.5};
			
			text = "Player Statistics"; //--- ToDo: Localize;
			x = 0.32464 * safezoneW + safezoneX;
			y = 0.401 * safezoneH + safezoneY;
			w = 0.350713 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class Vehicles: RscButton
		{
			idc = 4605;
			colorDisabled[] = {0,0,0,0.7};
			colorBackgroundDisabled[] = {0,0,0,0.7};
			colorBackgroundActive[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0.5};

			text = "Vehicle Menu"; //--- ToDo: Localize;
			x = 0.32464 * safezoneW + safezoneX;
			y = 0.467 * safezoneH + safezoneY;
			w = 0.350713 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class Arsenal: RscButton
		{
			idc = 4606;
			colorDisabled[] = {0,0,0,0.7};
			colorBackgroundDisabled[] = {0,0,0,0.7};
			colorBackgroundActive[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0.5};
			
			text = "Infantry Arsenal"; //--- ToDo: Localize;
			x = 0.32464 * safezoneW + safezoneX;
			y = 0.533 * safezoneH + safezoneY;
			w = 0.350713 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class Missions: RscButton
		{
			idc = 4607;
			colorDisabled[] = {0,0,0,0.7};
			colorBackgroundDisabled[] = {0,0,0,0.7};
			colorBackgroundActive[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0.5};
			
			text = "Mission Generator"; //--- ToDo: Localize;
			x = 0.324949 * safezoneW + safezoneX;
			y = 0.599 * safezoneH + safezoneY;
			w = 0.350713 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class Settings: RscButton
		{
			idc = 4608;
			colorDisabled[] = {0,0,0,0.7};
			colorBackgroundDisabled[] = {0,0,0,0.7};
			colorBackgroundActive[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0.5};
			
			text = "Player Options"; //--- ToDo: Localize;
			x = 0.324949 * safezoneW + safezoneX;
			y = 0.665 * safezoneH + safezoneY;
			w = 0.350713 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class Close: RscButton
		{
			idc = 4609;
			colorDisabled[] = {0,0,0,0.7};
			colorBackgroundDisabled[] = {0,0,0,0.7};
			colorBackgroundActive[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0.5};
			
			text = "Close"; //--- ToDo: Localize;
			x = 0.42792 * safezoneW + safezoneX;
			y = 0.753 * safezoneH + safezoneY;
			w = 0.144159 * safezoneW;
			h = 0.044 * safezoneH;
		};
	};
};