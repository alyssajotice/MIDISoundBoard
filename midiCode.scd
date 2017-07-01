//Alyssa Jo Tice - MUSIC 452 Final Project

//test global variables
~synthNum;
~synthVol;
~synthTime;

//initialize MIDI
MIDIClient.init;
MIDIIn.connectAll;

//initialize MIDI variables
~notes = Array.newClear(128);
~bend  = 8192;

(
MIDIdef.noteOn(\noteOnAction, {

	arg vel, nn, chan, src;
	[vel, nn].postln;

	//depending on the global variable assigned to synth, play the corresponding SynthDef

	//Synth 1 - Red Cedar Wood Plate
	if(~synthNum == 1){

	~notes[nn] = Synth.new(
		\redCedar,
		[
			\freq, nn.midicps,
				\amp, ~synthVol.at((~synthNum-1)),
			\gate, 1,
			\bend, ~bend.linlin(0, 16383, -2, 2),
				\time, ~synthTime.at((~synthNum-1))
	]);
	};

	//Synth 2 - Chorded Trumpet
	if(~synthNum == 2){
			~notes[nn] = Synth.new(
		\chorded_trumpet,
		[
			\freq, nn.midicps,
			\amp, ~synthVol.at((~synthNum-1)),
			\gate, 1,
			\bend, ~bend.linlin(0, 16383, -2, 2),
				\time, ~synthTime.at((~synthNum-1))
	]);
	};

	//Synth 3 - pulseTest
		if(~synthNum == 3){
			~notes[nn] = Synth.new(
		\pulseTest,
		[
			\freq, nn.midicps,
			\amp, ~synthVol.at((~synthNum-1)),
			\gate, 1,
			\bend, ~bend.linlin(0, 16383, -2, 2),
				\time, ~synthTime.at((~synthNum-1))
	]);
	};

		//Synth 4 -Bells
		if(~synthNum == 4){
			~notes[nn] = Synth.new(
		\bell,
		[
			\freq1, nn.midicps,
			\amp, ~synthVol.at((~synthNum-1)),
			\gate, 1,
			\bend, ~bend.linlin(0, 16383, -2, 2),
				\time, ~synthTime.at((~synthNum-1))
	]);
	};


		//Synth 5 -Vibraphone
		if(~synthNum == 5){
			~notes[nn] = Synth.new(
		\vibraphone,
		[
			\freq, nn.midicps,
			\amp, ~synthVol.at((~synthNum-1)),
			\gate, 1,
			\bend, ~bend.linlin(0, 16383, -2, 2),
				\time, ~synthTime.at((~synthNum-1))
	]);
	};

		//Synth 6 - Guitar
		if(~synthNum == 6){
			~notes[nn] = Synth.new(
		\guitar,
		[
			\freq, nn.midicps,
			\amp, ~synthVol.at((~synthNum-1)),
			\gate, 1,
			\bend, ~bend.linlin(0, 16383, -2, 2),
					\time, ~synthTime.at((~synthNum-1))
	]);
	};

		//Synth 7 - laser
		if(~synthNum == 7){
			~notes[nn] = Synth.new(
		\laser,
		[
			\freq, nn.midicps,
			\amp, ~synthVol.at((~synthNum-1)),
			\gate, 1,
			\bend, ~bend.linlin(0, 16383, -2, 2),
				\time, ~synthTime.at((~synthNum-1))
	]);
	};

		//Synth 8 - Vibrato
		if(~synthNum == 8){
			~notes[nn] = Synth.new(
		\vibrato,
		[
			\freq, nn.midicps,
			\amp, ~synthVol.at((~synthNum-1)),
			\gate, 1,
			\bend, ~bend.linlin(0, 16383, -2, 2),
				\time, ~synthTime.at((~synthNum-1))
	]);
	};

		//Synth 9 - Flute
		if(~synthNum == 9){
			~notes[nn] = Synth.new(
		\waveguideFlute,
		[
			\pch, nn,
			\amp1, ~synthVol.at((~synthNum-1)),
			\gate, 1,
			\bend, ~bend.linlin(0, 16383, -2, 2),
					\dur, ~synthTime.at((~synthNum-1))
	]);

	};
});
)


//noteOff to free Synths when key is released
(
MIDIdef.noteOff(\noteOffAction, {
	arg vel, nn;
	[vel, nn].postln;
	~notes[nn].set(\gate, 0);
	~notes[nn] = nil;
    }
)
)

//this allows the pitch wheel to be used
(
MIDIdef.bend(\bendTest,   {
	    arg val, chan, src;
		[val, chan, src].postln;
		~bend = val;
		~notes.do{arg synth;
			synth.set(\bend, val.linlin(0, 16383, -2, 2))};

}, chan:0 );
)

nil.set(\freq, 880);