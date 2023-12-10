class Missions {
	idd = 4605;
	//movingEnable = true;
	enableSimulation = true;
	
	class Controls {
		class BG1: IGUIBack
		{
			idc = 4619;
			x = 0.324644 * safezoneW + safezoneX;
			y = 0.357 * safezoneH + safezoneY;
			w = 0.350713 * safezoneW;
			h = 0.308 * safezoneH;
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

		class TaskType: RscText
		{
			idc = 4622;

			text = "Task Selection:"; //--- ToDo: Localize;
			x = 0.340116 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.0722056 * safezoneW;
			h = 0.044 * safezoneH;
			tooltip = "Hold CTRL to select multiple tasks."; //--- ToDo: Localize;
		};
		class Location: RscText
		{
			idc = 4624;

			text = "Location:"; //--- ToDo: Localize;
			x = 0.334959 * safezoneW + safezoneX;
			y = 0.566 * safezoneH + safezoneY;
			w = 0.0722056 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class Side: RscText
		{
			idc = 4625;

			text = "Enemy Faction:"; //--- ToDo: Localize;
			x = 0.334959 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.0722056 * safezoneW;
			h = 0.044 * safezoneH;
			tooltip = "EAST = Russian Armed Forces; RESISTANCE = National Party or Chernarus"; //--- ToDo: Localize;
		};
		class MissionTypeList: RscListBoxMulti
		{
			idc = 4626;

			x = 0.407164 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.154726 * safezoneW;
			h = 0.132 * safezoneH;
		};
		class LocationList: RscCombo
		{
			idc = 4628;

			x = 0.407164 * safezoneW + safezoneX;
			y = 0.577 * safezoneH + safezoneY;
			w = 0.154726 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class SideList: RscCombo
		{
			idc = 4629;

			x = 0.407164 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.154726 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class GenerateButton: RscButton
		{
			idc = 4630;
			colorDisabled[] = {0,0,0,0.7};
			colorBackgroundDisabled[] = {0,0,0,0.7};
			colorBackgroundActive[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0.5};

			text = "Generate Mission"; //--- ToDo: Localize;
			x = 0.5 * safezoneW + safezoneX;
			y = 0.676 * safezoneH + safezoneY;
			w = 0.175356 * safezoneW;
			h = 0.044 * safezoneH;

			tooltip = "Generate Mission with given parameters"; //--- ToDo: Localize;
		};
		class CancelButton: RscButton
		{
			idc = 4631;
			colorDisabled[] = {0,0,0,0.7};
			colorBackgroundDisabled[] = {0,0,0,0.7};
			colorBackgroundActive[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0.5};

			text = "Cancel"; //--- ToDo: Localize;
			x = 0.324644 * safezoneW + safezoneX;
			y = 0.676 * safezoneH + safezoneY;
			w = 0.170199 * safezoneW;
			h = 0.044 * safezoneH;
			
			tooltip = "Cancel Generation"; //--- ToDo: Localize;
		};
		class MiniMap: RscMapControl
		{
			idc = 4632;

			x = 0.567048 * safezoneW + safezoneX;
			y = 0.379 * safezoneH + safezoneY;
			w = 0.103151 * safezoneW;
			h = 0.264 * safezoneH;
		};
		class MissionCombo: RscCombo
		{
			idc = 4633;

			x = 0.407164 * safezoneW + safezoneX;
			y = 0.379 * safezoneH + safezoneY;
			w = 0.154726 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class Mission: RscText
		{
			idc = 4634;

			text = "Mission Type:"; //--- ToDo: Localize;
			x = 0.340116 * safezoneW + safezoneX;
			y = 0.368 * safezoneH + safezoneY;
			w = 0.0722056 * safezoneW;
			h = 0.044 * safezoneH;
			tooltip = "Select Mission Type"; //--- ToDo: Localize;
		};
	};
};