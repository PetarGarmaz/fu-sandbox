class FU_Settings {
	idd = 4603;
	
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
		class PLButton: RscButton
		{
			idc = 4604;
			text = "Set as Platoon Leader"; //--- ToDo: Localize;
			x = 0.324644 * safezoneW + safezoneX;
			y = 0.401 * safezoneH + safezoneY;
			w = 0.350713 * safezoneW;
			h = 0.044 * safezoneH;
			colorDisabled[] = {0,0,0,0.7};
			colorBackgroundDisabled[] = {0,0,0,0.7};
			colorBackgroundActive[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0.5};
			tooltip = "Give yourself the PL role."; //--- ToDo: Localize;
		};
		class MedicButton: RscButton
		{
			idc = 4605;
			text = "Set as Medic"; //--- ToDo: Localize;
			x = 0.324644 * safezoneW + safezoneX;
			y = 0.467 * safezoneH + safezoneY;
			w = 0.350713 * safezoneW;
			h = 0.044 * safezoneH;
			colorDisabled[] = {0,0,0,0.7};
			colorBackgroundDisabled[] = {0,0,0,0.7};
			colorBackgroundActive[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0.5};
			tooltip = "Become a medic."; //--- ToDo: Localize;
		};
		class EngineerButton: RscButton
		{
			idc = 4606;
			text = "Set as Engineer"; //--- ToDo: Localize;
			x = 0.324644 * safezoneW + safezoneX;
			y = 0.533 * safezoneH + safezoneY;
			w = 0.350713 * safezoneW;
			h = 0.044 * safezoneH;
			colorDisabled[] = {0,0,0,0.7};
			colorBackgroundDisabled[] = {0,0,0,0.7};
			colorBackgroundActive[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0.5};
			tooltip = "Become an engineer."; //--- ToDo: Localize;
		};
		class TPButton: RscButton
		{
			idc = 4607;
			text = "Teleport to HQ"; //--- ToDo: Localize;
			x = 0.324644 * safezoneW + safezoneX;
			y = 0.599 * safezoneH + safezoneY;
			w = 0.350713 * safezoneW;
			h = 0.044 * safezoneH;
			colorDisabled[] = {0,0,0,0.7};
			colorBackgroundDisabled[] = {0,0,0,0.7};
			colorBackgroundActive[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0.5};
			tooltip = "Teleport to HQ."; //--- ToDo: Localize;
		};

		class Close: RscButton
		{
			idc = 4608;
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
			idc = 4609;
			colorDisabled[] = {0,0,0,0.7};
			colorBackgroundDisabled[] = {0,0,0,0.7};
			colorBackgroundActive[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0.5};

			text = "Back"; //--- ToDo: Localize;
			x = 0.324949 * safezoneW + safezoneX;
			y = 0.753 * safezoneH + safezoneY;
			w = 0.164754 * safezoneW;
			h = 0.044 * safezoneH;
		};
	};
};
