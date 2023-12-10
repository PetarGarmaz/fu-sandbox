class Radio3DTestDialog {
	idd = -1;
	movingEnable = 0;
	enableSimulation = 0;
	controlsBackground[] = {};
	objects[] = {Radio3DObject};
	controls[] = {};

	class Radio3DObject {
		idc = -1;

		type = 82;

		model = "\A3\ui_f\objects\radio.p3d";

		scale = 1;

		direction[] = {0, 1, 0};
		up[] = {1, 0, -1};

		position[] = {0, -0.043, 0.25};
		positionBack[] = {0, 0, 0.625};

		inBack = 1;
		enableZoom = 1;
		zoomDuration = 0.5;

		class Areas
		{
			class ThisClassCanBeNamedWhatever
			{
				selection = "papir";

				class Controls
				{
					class EditBoxMultiLine
					{
						idc = 1;

						type = 2;
						style = 16;

						x = 0;
						y = 0;
						w = 1;
						h = 1.9;

						colorText[] = { 0 ,0 ,0 , 1 };
						colorSelection[] = { 1, 1, 1, 1 };
						colorDisabled[] = { 0, 0, 0, 0 };

						sizeEx = 0.2;
						font = "PuristaMedium";

						text = "Text Text text is text. Lorem Ipsum is bae!";

						autocomplete = "";
					};
				};
			};
		};
	};
};