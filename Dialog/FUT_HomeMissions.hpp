class FUT_HomeMissions {
	idd = 4605;
	//movingEnable = true;
	enableSimulation = true;
	
	class Controls {
		class Body: RscPicture
		{
			idc = 4601;
			//moving = true;
			text = "Images\GUI\FUT_Body.paa";
			x = 0.288541 * safezoneW + safezoneX;
			y = 0.071 * safezoneH + safezoneY;
			w = 0.422918 * safezoneW;
			h = 0.858 * safezoneH;
		};
		class Power: RscButton
		{
			idc = 4602;
			x = 0.371061 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.0206302 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0,0,0,0};
			colorActive[] = {0,0,0,0};
			tooltip = "Power Button"; //--- ToDo: Localize;
		};
		class Mute: RscButton
		{
			idc = 4603;
			x = 0.407164 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.0361028 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0,0,0,0};
			colorActive[] = {0,0,0,0};
			tooltip = "Mute/Unmute"; //--- ToDo: Localize;
		};
		class Status: RscPicture
		{
			idc = 4604;
			text = "#(argb,8,8,3)color(1,1,1,1)";
			x = 0.310718 * safezoneW + safezoneX;
			y = 0.29188 * safezoneH + safezoneY;
			w = 0.379111 * safezoneW;
			h = 0.001 * safezoneH;
		};
		class Status_Operater: RscStructuredText
		{
			idc = 4605;
			text = "<t size='1' valign='middle' align='left'>Telemach</t>";
			x = 0.314328 * safezoneW + safezoneX;
			y = 0.269 * safezoneH + safezoneY;
			w = 0.0722056 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class Status_Battery: RscPicture
		{
			idc = 4606;

			text = "Images\GUI\FUT_Status_Battery.paa";
			x = 0.675356 * safezoneW + safezoneX;
			y = 0.269 * safezoneH + safezoneY;
			w = 0.0103151 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class Status_Signal: RscPicture
		{
			idc = 4608;

			text = "Images\GUI\FUT_Status_Signal.paa";
			x = 0.654726 * safezoneW + safezoneX;
			y = 0.269 * safezoneH + safezoneY;
			w = 0.0154726 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class Status_Bluetooth: RscPicture
		{
			idc = 4609;

			text = "Images\GUI\FUT_Status_Bluetooth.paa";
			x = 0.639254 * safezoneW + safezoneX;
			y = 0.269 * safezoneH + safezoneY;
			w = 0.0103151 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class Status_Mute: RscPicture
		{
			idc = 4610;

			text = "Images\GUI\FUT_Status_Mute.paa";
			x = 0.623781 * safezoneW + safezoneX;
			y = 0.269 * safezoneH + safezoneY;
			w = 0.0103151 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class Time: RscStructuredText
		{
			idc = 4611;
			text = "<t size='1' valign='middle' align='center'>00:00</t>";
			x = 0.469055 * safezoneW + safezoneX;
			y = 0.269 * safezoneH + safezoneY;
			w = 0.0618905 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class Apps: RscPicture
		{
			idc = 4612;
			text = "#(argb,8,8,3)color(1,1,1,1)";
			x = 0.310409 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.379111 * safezoneW;
			h = 0.001 * safezoneH;
		};
		class App1: RscActivePicture
		{
			idc = 4613;
			text = "Images\GUI\FUT_Arsenal.paa";
			x = 0.334959 * safezoneW + safezoneX;
			y = 0.632 * safezoneH + safezoneY;
			w = 0.0412603 * safezoneW;
			h = 0.077 * safezoneH;
			colorDisabled[] = {1, 1, 1, 0.25};
			tooltip = "Open Arsenal (Only works within safe zones).";
		};
		class App2: RscActivePicture
		{
			idc = 4614;
			text = "Images\GUI\FUT_Garage.paa";
			x = 0.407164 * safezoneW + safezoneX;
			y = 0.632 * safezoneH + safezoneY;
			w = 0.0412603 * safezoneW;
			h = 0.077 * safezoneH;
			colorDisabled[] = {1, 1, 1, 0.25};
			tooltip = "Open Vehicle Garage Menu (Some feature only work within safe zones).";
		};
		class App3: RscActivePicture
		{
			idc = 4615;
			text = "Images\GUI\FUT_Stats.paa";
			x = 0.47937 * safezoneW + safezoneX;
			y = 0.632 * safezoneH + safezoneY;
			w = 0.0412603 * safezoneW;
			h = 0.077 * safezoneH;
			colorDisabled[] = {1, 1, 1, 0.25};
			tooltip = "Open Stats.";
		};
		class App4: RscActivePicture
		{
			idc = 4616;
			text = "Images\GUI\FUT_Missions.paa";
			x = 0.551575 * safezoneW + safezoneX;
			y = 0.632 * safezoneH + safezoneY;
			w = 0.0412603 * safezoneW;
			h = 0.077 * safezoneH;
			colorDisabled[] = {1, 1, 1, 0.25};
			tooltip = "Open Mission Generator.";
		};
		class App5: RscActivePicture
		{
			idc = 4617;
			text = "Images\GUI\FUT_Settings.paa";
			x = 0.623781 * safezoneW + safezoneX;
			y = 0.632 * safezoneH + safezoneY;
			w = 0.0412603 * safezoneW;
			h = 0.077 * safezoneH;
			colorDisabled[] = {1, 1, 1, 0.25};
			tooltip = "Open Settings.";
		};
		
		class MainScreen: IGUIBack
		{
			idc = 4618;
			x = 0.314328 * safezoneW + safezoneX;
			y = 0.302 * safezoneH + safezoneY;
			w = 0.371343 * safezoneW;
			h = 0.297 * safezoneH;
		};

		class BG1: IGUIBack
		{
			idc = 4619;
			x = 0.324644 * safezoneW + safezoneX;
			y = 0.357 * safezoneH + safezoneY;
			w = 0.350713 * safezoneW;
			h = 0.176 * safezoneH;
		};

		class BG2: IGUIBack
		{
			idc = 4620;
			x = 0.324644 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.350713 * safezoneW;
			h = 0.033 * safezoneH;
		};

		class Title: RscStructuredText
		{
			idc = 4621;
			text = "<t size=""1.5"">Mission Generator</t>"; //--- ToDo: Localize;
			x = 0.324644 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.350713 * safezoneW;
			h = 0.033 * safezoneH;
		};

		class MissionType: RscText
		{
			idc = 4622;
			text = "Task Selection:"; //--- ToDo: Localize;
			x = 0.334959 * safezoneW + safezoneX;
			y = 0.357 * safezoneH + safezoneY;
			w = 0.0722056 * safezoneW;
			h = 0.044 * safezoneH;

			tooltip = "Hold CTRL to select multiple tasks.";
		};

		class Location: RscText
		{
			idc = 4624;
			text = "Location:"; //--- ToDo: Localize;
			x = 0.334959 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.0722056 * safezoneW;
			h = 0.044 * safezoneH;
		};

		class Side: RscText
		{
			idc = 4625;
			text = "Enemy Faction:"; //--- ToDo: Localize;
			x = 0.334959 * safezoneW + safezoneX;
			y = 0.489 * safezoneH + safezoneY;
			w = 0.0722056 * safezoneW;
			h = 0.044 * safezoneH;

			tooltip = "EAST = Russian Armed Forces; RESISTANCE = National Party or Chernarus";
		};

		class MissionTypeList: RscListBoxMulti
		{
			idc = 4626;
			x = 0.407164 * safezoneW + safezoneX;
			y = 0.368 * safezoneH + safezoneY;
			w = 0.154726 * safezoneW;
			h = 0.066 * safezoneH;
		};

		class LocationList: RscCombo
		{
			idc = 4628;
			x = 0.407164 * safezoneW + safezoneX;
			y = 0.456 * safezoneH + safezoneY;
			w = 0.154726 * safezoneW;
			h = 0.022 * safezoneH;
		};

		class SideList: RscCombo
		{
			idc = 4629;
			x = 0.407164 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.154726 * safezoneW;
			h = 0.022 * safezoneH;
		};

		class GenerateButton: RscButton
		{
			idc = 4630;
			text = "Generate Mission"; //--- ToDo: Localize;
			x = 0.5 * safezoneW + safezoneX;
			y = 0.544 * safezoneH + safezoneY;
			w = 0.175356 * safezoneW;
			h = 0.044 * safezoneH;
			colorDisabled[] = 
			{
				"(profilenamespace getvariable ['IGUI_BCG_RGB_R',0])",
				"(profilenamespace getvariable ['IGUI_BCG_RGB_G',1])",
				"(profilenamespace getvariable ['IGUI_BCG_RGB_B',1])",
				"(profilenamespace getvariable ['IGUI_BCG_RGB_A',0.7])"
			};
			colorBackground[] = 
			{
				"(profilenamespace getvariable ['IGUI_BCG_RGB_R',0])",
				"(profilenamespace getvariable ['IGUI_BCG_RGB_G',1])",
				"(profilenamespace getvariable ['IGUI_BCG_RGB_B',1])",
				"(profilenamespace getvariable ['IGUI_BCG_RGB_A',0.9])"
			};
			colorBackgroundDisabled[] = 
			{
				"(profilenamespace getvariable ['IGUI_BCG_RGB_R',0])",
				"(profilenamespace getvariable ['IGUI_BCG_RGB_G',1])",
				"(profilenamespace getvariable ['IGUI_BCG_RGB_B',1])",
				"(profilenamespace getvariable ['IGUI_BCG_RGB_A',0.7])"
			};
			colorBackgroundActive[] = 
			{
				"(profilenamespace getvariable ['IGUI_BCG_RGB_R',0])",
				"(profilenamespace getvariable ['IGUI_BCG_RGB_G',1])",
				"(profilenamespace getvariable ['IGUI_BCG_RGB_B',1])",
				"(profilenamespace getvariable ['IGUI_BCG_RGB_A',1])"
			};
			tooltip = "Generate Mission with given parameters";
		};

		class CancelButton: RscButton
		{
			idc = 4631;
			text = "Cancel"; //--- ToDo: Localize;
			x = 0.324644 * safezoneW + safezoneX;
			y = 0.544 * safezoneH + safezoneY;
			w = 0.170199 * safezoneW;
			h = 0.044 * safezoneH;
			colorDisabled[] = 
			{
				"(profilenamespace getvariable ['IGUI_BCG_RGB_R',0])",
				"(profilenamespace getvariable ['IGUI_BCG_RGB_G',1])",
				"(profilenamespace getvariable ['IGUI_BCG_RGB_B',1])",
				"(profilenamespace getvariable ['IGUI_BCG_RGB_A',0.7])"
			};
			colorBackground[] = 
			{
				"(profilenamespace getvariable ['IGUI_BCG_RGB_R',0])",
				"(profilenamespace getvariable ['IGUI_BCG_RGB_G',1])",
				"(profilenamespace getvariable ['IGUI_BCG_RGB_B',1])",
				"(profilenamespace getvariable ['IGUI_BCG_RGB_A',0.9])"
			};
			colorBackgroundDisabled[] = 
			{
				"(profilenamespace getvariable ['IGUI_BCG_RGB_R',0])",
				"(profilenamespace getvariable ['IGUI_BCG_RGB_G',1])",
				"(profilenamespace getvariable ['IGUI_BCG_RGB_B',1])",
				"(profilenamespace getvariable ['IGUI_BCG_RGB_A',0.7])"
			};
			colorBackgroundActive[] = 
			{
				"(profilenamespace getvariable ['IGUI_BCG_RGB_R',0])",
				"(profilenamespace getvariable ['IGUI_BCG_RGB_G',1])",
				"(profilenamespace getvariable ['IGUI_BCG_RGB_B',1])",
				"(profilenamespace getvariable ['IGUI_BCG_RGB_A',1])"
			};
			tooltip = "Cancel Generation";
		};
		
		class MiniMap: RscMapControl
		{
			idc = 4632;
			x = 0.567048 * safezoneW + safezoneX;
			y = 0.368 * safezoneH + safezoneY;
			w = 0.103151 * safezoneW;
			h = 0.154 * safezoneH;
		};
	};
};