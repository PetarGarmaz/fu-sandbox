class FU_RoleSelection {
	idd = 4616;
	
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
			text = "<t size=""1.5"">Role Selector</t>"; //--- ToDo: Localize;
			x = 0.376251 * safezoneW + safezoneX;
			y = 0.357 * safezoneH + safezoneY;
			w = 0.2475 * safezoneW;
			h = 0.033 * safezoneH;
		};
		
		class Name: RscText
		{
			idc = 4613;

			text = "Select your role"; //--- ToDo: Localize;
			x = 0.376229 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.0928357 * safezoneW;
			h = 0.022 * safezoneH;
		};
		
		class NameText: RscCombo
		{
			idc = 4614;

			x = 0.381377 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.237247 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0,0,0,0.5};
			tooltip = "Role selection"; //--- ToDo: Localize;
		};
		
		class ConfirmButton: RscButton
		{
			idc = 4621;
			colorDisabled[] = {0,0,0,0.7};
			colorBackgroundDisabled[] = {0,0,0,0.7};
			colorBackgroundActive[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0.5};

			text = "Select Role"; //--- ToDo: Localize;
			x = 0.432952 * safezoneW + safezoneX;
			y = 0.489 * safezoneH + safezoneY;
			w = 0.12375 * safezoneW;
			h = 0.033 * safezoneH;
			tooltip = "Confirm the role"; //--- ToDo: Localize;
		};
	};
};