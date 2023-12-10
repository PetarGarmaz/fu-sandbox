class GarageManager {
	idd = 4603;
	//movingEnable = true;
	enableSimulation = true;
	
	class Controls {
		/*
		class Body: RscPicture
		{
			idc = 4601;
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

		*/

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
			text = "<t size=""1.5"">Vehicle Manager</t>"; //--- ToDo: Localize;
			x = 0.324644 * safezoneW + safezoneX;
			y = 0.311 * safezoneH + safezoneY;
			w = 0.350713 * safezoneW;
			h = 0.033 * safezoneH;
		};

		class Vehicles: RscText
		{
			idc = 4622;

			text = "Vehicles:"; //--- ToDo: Localize;
			x = 0.324644 * safezoneW + safezoneX;
			y = 0.401 * safezoneH + safezoneY;
			w = 0.0722056 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class Actions: RscText
		{
			idc = 4623;

			text = "Actions:"; //--- ToDo: Localize;
			x = 0.324644 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.0722056 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class VehiclesList: RscCombo
		{
			idc = 4624;

			x = 0.396849 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.139254 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class ActionsList: RscCombo
		{
			idc = 4625;

			x = 0.396849 * safezoneW + safezoneX;
			y = 0.456 * safezoneH + safezoneY;
			w = 0.139254 * safezoneW;
			h = 0.022 * safezoneH;
		};
		
		class ConfirmButton: RscButton {
			idc = 4626;
			colorDisabled[] = {"(profilenamespace getvariable ['IGUI_BCG_RGB_R',0])","(profilenamespace getvariable ['IGUI_BCG_RGB_G',1])","(profilenamespace getvariable ['IGUI_BCG_RGB_B',1])","(profilenamespace getvariable ['IGUI_BCG_RGB_A',0.7])"};
			colorBackgroundDisabled[] = {"(profilenamespace getvariable ['IGUI_BCG_RGB_R',0])","(profilenamespace getvariable ['IGUI_BCG_RGB_G',1])","(profilenamespace getvariable ['IGUI_BCG_RGB_B',1])","(profilenamespace getvariable ['IGUI_BCG_RGB_A',0.7])"};
			colorBackgroundActive[] = {"(profilenamespace getvariable ['IGUI_BCG_RGB_R',0])","(profilenamespace getvariable ['IGUI_BCG_RGB_G',1])","(profilenamespace getvariable ['IGUI_BCG_RGB_B',1])","(profilenamespace getvariable ['IGUI_BCG_RGB_A',1])"};

			text = "Confirm"; //--- ToDo: Localize;
			x = 0.5 * safezoneW + safezoneX;
			y = 0.544 * safezoneH + safezoneY;
			w = 0.175356 * safezoneW;
			h = 0.044 * safezoneH;
			colorBackground[] = {"(profilenamespace getvariable ['IGUI_BCG_RGB_R',0])","(profilenamespace getvariable ['IGUI_BCG_RGB_G',1])","(profilenamespace getvariable ['IGUI_BCG_RGB_B',1])","(profilenamespace getvariable ['IGUI_BCG_RGB_A',0.9])"};
			tooltip = "Confirm your selection"; //--- ToDo: Localize;
		};
		
		class CancelButton: RscButton {
			idc = 4627;
			colorDisabled[] = {"(profilenamespace getvariable ['IGUI_BCG_RGB_R',0])","(profilenamespace getvariable ['IGUI_BCG_RGB_G',1])","(profilenamespace getvariable ['IGUI_BCG_RGB_B',1])","(profilenamespace getvariable ['IGUI_BCG_RGB_A',0.7])"};
			colorBackgroundDisabled[] = {"(profilenamespace getvariable ['IGUI_BCG_RGB_R',0])","(profilenamespace getvariable ['IGUI_BCG_RGB_G',1])","(profilenamespace getvariable ['IGUI_BCG_RGB_B',1])","(profilenamespace getvariable ['IGUI_BCG_RGB_A',0.7])"};
			colorBackgroundActive[] = {"(profilenamespace getvariable ['IGUI_BCG_RGB_R',0])","(profilenamespace getvariable ['IGUI_BCG_RGB_G',1])","(profilenamespace getvariable ['IGUI_BCG_RGB_B',1])","(profilenamespace getvariable ['IGUI_BCG_RGB_A',1])"};

			text = "Cancel"; //--- ToDo: Localize;
			x = 0.324644 * safezoneW + safezoneX;
			y = 0.544 * safezoneH + safezoneY;
			w = 0.170199 * safezoneW;
			h = 0.044 * safezoneH;
			colorBackground[] = {"(profilenamespace getvariable ['IGUI_BCG_RGB_R',0])","(profilenamespace getvariable ['IGUI_BCG_RGB_G',1])","(profilenamespace getvariable ['IGUI_BCG_RGB_B',1])","(profilenamespace getvariable ['IGUI_BCG_RGB_A',0.9])"};
			tooltip = "Cancel"; //--- ToDo: Localize;
		};
		
		class BG_3: IGUIBack
		{
			idc = 4628;

			x = 24 * GUI_GRID_W + GUI_GRID_X;
			y = 6.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 14 * GUI_GRID_W;
			h = 7 * GUI_GRID_H;
		};
		class VehiclePicture: RscPicture
		{
			idc = 4629;

			text = "#(argb,8,8,3)color(1,1,1,1)";
			x = 0.546418 * safezoneW + safezoneX;
			y = 0.379 * safezoneH + safezoneY;
			w = 0.134096 * safezoneW;
			h = 0.132 * safezoneH;
		};
	};
};