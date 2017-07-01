//Alyssa Jo Tice - MUSIC 452 Final Project - Control Board Code

MIDIClient.init;
MIDIIn.connectAll;
MIDIIn.disconnectAll;
MIDIdef.freeAll;

/*These must be initialized before running. They hold the global variables from the board to change values on the MIDI keyboard.
    synthNum - current synth selected  range: 1-9
    synthVol - array with the current volumes selected on the slider  range: 0-2
    synthTime - the dial turned to a certain length of time    range: 0-4
*/

~synthNum = 1;
~synthVol = Array.new(9); //array in order to have 1 as the initial value
(
9.do({
	~synthVol.add(1);
});
)
~synthTime = Array.new(9); //array in order to have 1 as the initial valye
(
9.do({
	~synthTime.add(1);
});
)

//test these variabels
~synthNum;
~synthVol;
~synthTime;

//TEST - the input MIDI data from the control board
(
//print the actual MIDI data
MIDIdef.cc(\test, {
	arg vel, nn, chan, src;
	[vel, nn, chan, src].postln;
});
)

//This control change def will accept all control change data coming from the control board.
(
MIDIdef.cc(\ccDef, {
	arg vel, nn;
	var ampInd;

	//[vel, nn].postln; //test code

	//TOP BUTTONS is pressed, then global variable for synthNum is assigned
	if ((nn >= 23) && (nn <= 31)){//range 23-31
		~synthNum = (nn-22);
	};

	//SLIDERS - control the volume of that specific synth using the array
	if ((nn >= 2) && (nn <= 13)){  //range 2-13

		//Assign new values for amplitude array index because the sliders don't go in numerical order
		ampInd = (nn-2);
		if(nn == 8){ ampInd = 5};
		if(nn==9){ ampInd = 6};
		if(nn==12){ampInd = 7};
		if(nn==13){ampInd = 8};

		~synthVol = ~synthVol.put((ampInd), (LinLin.ar(vel, 0, 127, 0, 2))); //linlin maps to an acceptable range for amplitude
		//assign the corresponding amplitude to the correct synth
	};

	//TIME DIALS
		if ((nn >= 14) && (nn <= 22)){//range 14-22
		~synthTime = ~synthTime.put((nn-14), (LinLin.ar(vel, 0, 127, 0, 2))); //linlin maps to an acceptabel range for time
	};
});
)