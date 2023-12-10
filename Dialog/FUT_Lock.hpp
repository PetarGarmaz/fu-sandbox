class FUT_Lock {
	idd = 4600;
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
			
			tooltip = "Power Button"; //--- ToDo: Localize;
		};
		class Mute: RscButton
		{
			idc = 4603;
			x = 0.407164 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.0361028 * safezoneW;
			h = 0.022 * safezoneH;

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
			text = "<t size='4' valign='middle' align='center'>00:00</t>";
			x = 0.448425 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.11 * safezoneH;
		};
		class Date: RscStructuredText
		{
			idc = 4612;
			text = "<t size='1' valign='middle' align='center'>Friday, January 1st, 2021</t>";
			x = 0.448425 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.103151 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class UnlockButton: RscActivePicture
		{
			idc = 4613;
			text = "Images\GUI\FUT_Lock.paa";
			x = 0.474212 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.0515754 * safezoneW;
			h = 0.088 * safezoneH;
			tooltip = "Unlock Tablet"; //--- ToDo: Localize;
		};
	};
};