class FU_RecruitUnits {
	idd = 4615;
	
	class Controls {
		class BG1: IGUIBack {
			idc = 4610;

			x = 0.376219 * safezoneW + safezoneX;
			y = 0.401 * safezoneH + safezoneY;
			w = 0.247562 * safezoneW;
			h = 0.077 * safezoneH;
		};
		
		class BG2: IGUIBack {
			idc = 4611;

			x = 0.376219 * safezoneW + safezoneX;
			y = 0.357 * safezoneH + safezoneY;
			w = 0.2475 * safezoneW;
			h = 0.033 * safezoneH;
		};
		
		class Title: RscStructuredText
		{
			idc = 4612;
			text = "<t size=""1.5"">Recruit units</t>"; //--- ToDo: Localize;
			x = 0.376251 * safezoneW + safezoneX;
			y = 0.357 * safezoneH + safezoneY;
			w = 0.2475 * safezoneW;
			h = 0.033 * safezoneH;
		};
		
		class Name: RscText {
			idc = 4613;

			text = "Enter a number:"; //--- ToDo: Localize;
			x = 0.376219 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.0928357 * safezoneW;
			h = 0.022 * safezoneH;
		};
		
		class NameText: RscEdit {
			idc = 4614;
			x = 0.381377 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.237247 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0,0,0,0.5};
			tooltip = "This number can be in range from 1 to 12.";
		};
		
		class ConfirmButton: RscButton {
			idc = 4621;
			colorDisabled[] = {"(profilenamespace getvariable ['IGUI_BCG_RGB_R',0])","(profilenamespace getvariable ['IGUI_BCG_RGB_G',1])","(profilenamespace getvariable ['IGUI_BCG_RGB_B',1])","(profilenamespace getvariable ['IGUI_BCG_RGB_A',0.7])"};
			colorBackgroundDisabled[] = {"(profilenamespace getvariable ['IGUI_BCG_RGB_R',0])","(profilenamespace getvariable ['IGUI_BCG_RGB_G',1])","(profilenamespace getvariable ['IGUI_BCG_RGB_B',1])","(profilenamespace getvariable ['IGUI_BCG_RGB_A',0.7])"};
			colorBackgroundActive[] = {"(profilenamespace getvariable ['IGUI_BCG_RGB_R',0])","(profilenamespace getvariable ['IGUI_BCG_RGB_G',1])","(profilenamespace getvariable ['IGUI_BCG_RGB_B',1])","(profilenamespace getvariable ['IGUI_BCG_RGB_A',1])"};

			text = "Confirm"; //--- ToDo: Localize;
			x = 0.432952 * safezoneW + safezoneX;
			y = 0.489 * safezoneH + safezoneY;
			w = 0.12375 * safezoneW;
			h = 0.033 * safezoneH;
			
			colorBackground[] = {"(profilenamespace getvariable ['IGUI_BCG_RGB_R',0])","(profilenamespace getvariable ['IGUI_BCG_RGB_G',1])","(profilenamespace getvariable ['IGUI_BCG_RGB_B',1])","(profilenamespace getvariable ['IGUI_BCG_RGB_A',0.9])"};
			tooltip = "Confirm the number"; //--- ToDo: Localize;
		};
	};
};