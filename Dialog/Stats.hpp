class FU_Stats {
	idd = 4601;
	
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

		//Pictures and Text
		class Kills: RscPicture
		{
			idc = 4604;

			text = "#(argb,8,8,3)color(0,0,0,0.75)";
			x = 0.324949 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.103151 * safezoneW;
			h = 0.11 * safezoneH;
		};
		class Deaths: RscPicture
		{
			idc = 4605;

			text = "#(argb,8,8,3)color(0,0,0,0.75)";
			x = 0.448514 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.103151 * safezoneW;
			h = 0.11 * safezoneH;
		};
		class KDR: RscPicture
		{
			idc = 4606;

			text = "#(argb,8,8,3)color(0,0,0,0.75)";
			x = 0.57208 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.103151 * safezoneW;
			h = 0.11 * safezoneH;
		};
		class ShotsFired: RscPicture
		{
			idc = 4607;

			text = "#(argb,8,8,3)color(0,0,0,0.75)";
			x = 0.324949 * safezoneW + safezoneX;
			y = 0.577 * safezoneH + safezoneY;
			w = 0.103151 * safezoneW;
			h = 0.11 * safezoneH;
		};
		class ShotsPerKill: RscPicture
		{
			idc = 4608;

			text = "#(argb,8,8,3)color(0,0,0,0.75)";
			x = 0.448514 * safezoneW + safezoneX;
			y = 0.577 * safezoneH + safezoneY;
			w = 0.103151 * safezoneW;
			h = 0.11 * safezoneH;
		};
		class MaxLifetime: RscPicture
		{
			idc = 4609;

			text = "#(argb,8,8,3)color(0,0,0,0.75)";
			x = 0.57208 * safezoneW + safezoneX;
			y = 0.577 * safezoneH + safezoneY;
			w = 0.103151 * safezoneW;
			h = 0.11 * safezoneH;
		};
		class KillsText: RscStructuredText
		{
			idc = 4610;

			x = 0.324949 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.103151 * safezoneW;
			h = 0.11 * safezoneH;
			tooltip = "Total Kills"; //--- ToDo: Localize;
		};
		class DeathsText: RscStructuredText
		{
			idc = 4611;

			x = 0.448514 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.103151 * safezoneW;
			h = 0.11 * safezoneH;
			tooltip = "Total Deaths"; //--- ToDo: Localize;
		};
		class KDRText: RscStructuredText
		{
			idc = 4612;

			x = 0.57208 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.103151 * safezoneW;
			h = 0.11 * safezoneH;
			tooltip = "KDR = Kills / Deaths"; //--- ToDo: Localize;
		};
		class ShotsFiredText: RscStructuredText
		{
			idc = 4613;

			x = 0.324949 * safezoneW + safezoneX;
			y = 0.577 * safezoneH + safezoneY;
			w = 0.103151 * safezoneW;
			h = 0.11 * safezoneH;
			tooltip = "Total Shots Fired"; //--- ToDo: Localize;
		};
		class ShotsPerKillText: RscStructuredText
		{
			idc = 4614;

			x = 0.448514 * safezoneW + safezoneX;
			y = 0.577 * safezoneH + safezoneY;
			w = 0.103151 * safezoneW;
			h = 0.11 * safezoneH;
			tooltip = "SpK = Shots Fired / Kills"; //--- ToDo: Localize;
		};
		class MaxLifetimeText: RscStructuredText
		{
			idc = 4615;

			x = 0.57208 * safezoneW + safezoneX;
			y = 0.577 * safezoneH + safezoneY;
			w = 0.103151 * safezoneW;
			h = 0.11 * safezoneH;
			tooltip = "Best lifetime (in min)"; //--- ToDo: Localize;
		};

		class Close: RscButton
		{
			idc = 4616;
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
			idc = 4617;
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
