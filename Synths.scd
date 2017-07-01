//Alyssa Jo Tice - MUSIC 452 Final Project
//Synths that can be used with the MIDI/control  board setup

//All synths have amptitude (for CC), time (for CC), freq (for MIDI), and bend (for MIDI), gate (for MIDI)

/*********************************************************************/
//Red Cedar Wood Plate - Synth 1
(
SynthDef.new("redCedar", {

	arg gate=0, freq=300, bend = 0, amp =1, time =1;
	var sig, e, env, a;
	amp = amp + 3;

	a = Klank.ar(`[[1, 1.47, 2.09, 2.56]*(freq*bend.midiratio),  [0.3, 0.1, 0.15, 0.1],[0.2 + time, 0.5 + time, 0.25 + time, 0.2 + time]], Impulse.ar(0.0001));

	e = Env.new([1,1], [time]);
	env = EnvGen.ar(e, gate: gate, doneAction: 2);

	sig = env*a*amp;

	Out.ar(0, sig); //0 is the left speaker
	Out.ar(1,sig); //1 is the right speaker

}).add;
)

x = Synth.new("redCedar", [\freq, 200,  \time, 2, \amp, 2]);

/****************************************************/
//Synth 2 - Chorded Trumpet
(
SynthDef.new(\chorded_trumpet, {

	arg amp = 1, freq = 440, gate =0, bend =0, time = 0.5;
	var fr, fr1, l, e, env, sig, f, filterEnv, v1, a;

	fr = LFPar.ar(15).range(freq-1.midicps, freq+1.midicps); //oscillates from freq-1 whole step to freq+1 whole step 15x per second
	fr1 = fr + 7.midicps; //up 7 semitones

	a = Saw.ar(fr*bend.midiratio) + Saw.ar(fr1*bend.midiratio);

	//amplitude envelope
	e = Env.adsr(0, 0, 1, time);
	env = EnvGen.kr(e, gate, doneAction:2);

	f = Env.new([250, 300, 60], [time, 0.3, 0.3], curve: 'lin');
	filterEnv = EnvGen.kr(f, levelScale: 2, doneAction:2); //envelope for the filter's cutoff frequency

	l = RLPF.ar(a, filterEnv, 1/0.56);

	sig = l   *env*amp; //to use the amp envelope

	            Out.ar(0, sig);
	            Out.ar(1, sig);

}).add;
)

x = Synth.new(\chorded_trumpet, [\gate, 1]);
x.set(\gate, 0);

/****************************************************/
//Free Verb pulseTest Synth 3
(
SynthDef.new(\pulseTest, {

	arg   freq =400, amp=1, time = 0.8, gate = 0, bend =0;
	var sig1, sig2, env1, e1, width = 0.5, maxPartial = 4, ampHz = 4;

	sig1 = Pulse.ar([(freq*bend.midiratio), (freq*0.5*bend.midiratio), (freq*0.25*bend.midiratio)], width, amp);
	sig2 = FreeVerb.ar(sig1, 0.7, 0.8, 0.25);

	e1 = Env.perc(0.01, time);
	env1 = EnvGen.ar(e1, gate: gate, doneAction:2);

	Out.ar(0, (sig2*env1));
	Out.ar(1, (sig2*env1));
}).add;
)
Synth.new(\pulseTest, [\freq, 300, \amp, 1, \time, 0.4, \gate, 1]);

/******************************************************/
//Bells - Synth 4
(
SynthDef("bell", { arg freq1=400, time = 1, amp =1, bend = 0, gate =0 ;

	var freq, sig, env1, env2, env3, env4, env5, env6, env7, env8, env9, env10, env11, e1, e2, e3, e4, e5, e6, e7, e8, e9, e10, e11, o1, o2, o3, o4, o5, o6, o7, o8, o9, o10, o11;

	freq = (freq1*bend.midiratio);

	//O1
	o1 = SinOsc.ar(freq, mul: amp);
	e1 = Env.perc(0.01, time);
	env1 = EnvGen.ar(e1, gate: gate, doneAction:2);

	//O2
	o2 = SinOsc.ar(freq*1.0052, mul: amp*0.6857);
	e2 = Env.perc(0.01, (time*0.9048));
	env2 = EnvGen.ar(e2);

	//O3
	o3 = SinOsc.ar(freq*1.6428, mul: amp);
	e3 = Env.perc(0.01, (time*0.8762));
	env3 = EnvGen.ar(e3);

	//O4
	o4 = SinOsc.ar(freq*1.65, mul: amp*1.8);
	e4 = Env.perc(0.01, (time*0.5524));
	env4 = EnvGen.ar(e4);

	//O5
	o5 = SinOsc.ar(freq*2.125, mul: amp*2.6857);
	e5= Env.perc(0.01, (time*0.3238));
	env5 = EnvGen.ar(e5);

	//O6
	o6 = SinOsc.ar(freq*3.1357, mul: amp*1.6571);
	e6 = Env.perc(0.01, (time*0.1048));
	env6 = EnvGen.ar(e6);

	//O7
	o7 = SinOsc.ar(freq*3.5713, mul: amp*1.4571);
	e7 = Env.perc(0.01, (time*0.2476));
	env7 = EnvGen.ar(e7);

	//O8
	o8 = SinOsc.ar(freq*4.8928, mul: amp*1.3429);
	e8 = Env.perc(0.01, (time*0.2));
	env8 = EnvGen.ar(e8);

	//O9
	o9 = SinOsc.ar(freq*5.3571, mul: amp*1.3429);
	e9 = Env.perc(0.01, (time*0.1524));
	env9 = EnvGen.ar(e9);

	//O10
	o10 = SinOsc.ar(freq*6.7142, mul: amp*0.9713);
	e10 = Env.perc(0.01, (time*0.1048));
	env10 = EnvGen.ar(e10);

	//O11
	o11 = SinOsc.ar(freq*7.2678, mul: amp*1.3429);
	e11 = Env.perc(0.01, (time*0.0762));
	env11 = EnvGen.ar(e11);

	sig =( (o1*env1)+(o2*env2)+(o3*env3)+(env4*o4)+(o5*env5)+(o6*env6)+(o7*env7)+(o8*env8)+(o9*env9)+(env10*o10)+(env11*o11)) * 0.2;
	Out.ar(0, sig);
    Out.ar(1, sig);

}).add;
)

(x = Synth.new(\bell,  [\freq1, 400, \time, 1, \amp, 1, \bend, 0, \gate, 1]);)


/****************************************************/
//Vibraphone - Synth 5
(
SynthDef.new("vibraphone", {

	arg freq = 200, time = 1, gate = 1, bend =0, amp =1;
	var sig, e, env, a, b;

	a = Klank.ar(`[[1, 3.984, 10.668, 17.979, 23.679, 33.642]*(freq*(bend.midiratio)),  [ 0.7, 1, 0.7, 0.4],[(time -0.1), (time + 1), (time - 0.35), (time - 0.3)]], Impulse.ar(0.0001));

	e = Env.new([1,1], [4]);
	env = EnvGen.ar(e, gate: gate, doneAction: 2);
	b = env*a;

	sig = FreeVerb.ar(b);

	Out.ar(0, (sig*amp)); //0 is the left speaker
	Out.ar(1,(sig*amp)); //1 is the right speaker

}).add;
)

x = Synth.new("vibraphone", [\freq, 800, \time, 1, \gate, 1, \bend, 0, \amp, 1]);


/****************************************************/
//Guitar - Synth 6
(
SynthDef.new("guitar", {

	arg freq=440, amp = 1, gate =1, time = 1, bend = 0;

	var coef=0.5, decay=10, a, e, env, freq1, b;

	freq1 = freq*bend.midiratio;

	a=Pluck.ar(WhiteNoise.ar(0.25), Impulse.kr(0), freq1.reciprocal, freq1.reciprocal, decay, coef);
	e = Env.new([0,1, 0],[0.01, time], curve:'lin');
	env = EnvGen.ar(e, gate: gate, doneAction:2);

	Out.ar(0, ((a)*env*(amp+3)));
	Out.ar(1, ((a)*env*(amp+3)));
}).add;
)

Env.new([0,1, 0],[0.01, 3, curve:'lin']).test.plot;
x = Synth.new("guitar", [\gate, 1, \freq, 400, \amp, 1, \bend, 0, \time, 3]);


/****************************************************/
//Laser - Synth 7
(
SynthDef.new("laser", {

	arg freq =600, gate =1, time =1, amp =1, bend =0;
	var freq1, e, env, sig;

	time = time * 0.5;

	e = Env.new([1,1], [time]);
	env = EnvGen.ar(e, gate: gate, doneAction:2);

	env = XLine.kr(1, 0.01, time, doneAction:2);
	freq1 = XLine.kr((freq*bend.midiratio), 110, time, doneAction:2);

	sig = Pulse.ar(freq1)*env;

	Out.ar(0, (sig*amp)); //0 is the left speaker
	Out.ar(1, (sig*amp)); //1 is the right speaker

}).add;
)

x = Synth.new("laser", [\freq, 500, \gate, 1, \amp, 1, \bend, 0, \time, 2]);


/****************************************************/
//Vibrato -Synth 8
(
SynthDef.new("vibrato", {

	arg time =1, freq = 400, bend = 0, amp = 1, gate =1;
	var  modulatorFreq = 10, modulatorWidth = 2;
	var sig, a, env1, e1;

	time = time*0.3; //constants to make them time and amp controllable
	amp = amp + 1;

	a = PMOsc.ar((freq*bend.midiratio), modulatorFreq, modulatorWidth);

	e1 = Env.new([1, 1, 0], [time, 0.1]);
	env1 = EnvGen.ar(e1, gate: gate, doneAction:2);

	sig = (a*env1*amp);

	Out.ar(0, sig); //0 is the left speaker
	Out.ar(1,sig); //1 is the right speaker

}).add;
)

x = Synth.new("vibrato", [\freq, 200, \time, 4, \bend, 0, \amp, 1, \gate, 1]);

/*
/****************************************************/
//Flute -Synth 9
(
SynthDef.new("flute", {

	arg freq= 400, gate = 1, bend= 0, amp =1, time =1;

	var sig, e, env, a;

	time = time*0.3;

	a = Klank.ar(`[[1, 3.2, 6.23, 6.27, 9.92,14.15]*(freq*bend.midiratio),  [ 0.7, 1, 0.7, 0.4],[1, 1.5, 0.75, 0.8]], WhiteNoise.ar(0.01));

	e = Env.new([1,1, 0], [time, 0.2]);
	env = EnvGen.ar(e, gate:gate, doneAction: 2);

	sig = (env*a*amp);

	Out.ar(0, sig); //0 is the left speaker
	Out.ar(1,sig); //1 is the right speaker

}).add;
)

x = Synth.new("flute",[\gate, 1, \freq, 500, \bend, 0, \amp, 1, \time, 3]);
*/

/*******************************************************/
//flute
//This synth is not my own, and was obtained from The University of Rochester Eastman Computer Music School, then adapted to be used with my program. Notably, I changed the arguments so that they could be used with the MIDI data coming in from the control board.
(
SynthDef("waveguideFlute", {

	arg gate = 1, pch = 72, dur = 1, bend =0, amp1 = 1,   scl = 0.2,  ipress = 0.9, ibreath = 0.09, ifeedbk1 = 0.4, ifeedbk2 = 0.4,      vibrato=0.2;
	//args: gate, dur (time), amp1 (amp), pch (freq converted to midicps), bend

    var kenv1, kenv2, kenvibr, kvibr, sr, cr, block, poly, signalOut, ifqc,  fdbckArray;
    var aflow1, asum1, asum2, afqc, atemp1, ax, apoly, asum3, avalue, atemp2, aflute1, amp;

	amp = (amp1 * 0.4); //rescale amp

    sr = SampleRate.ir;
    cr = ControlRate.ir;
    block = cr.reciprocal;
	ifqc = (pch.midicps*bend.midiratio); //create bend and freq

    // noise envelope
    kenv1 = EnvGen.kr(Env.new(
        [ 0.0, 1.1 * ipress, ipress, ipress, 0.0 ], [ 0.06, 0.2, dur - 0.46, 0.2 ], 'linear' )
    );
    // overall envelope
    kenv2 = EnvGen.kr(Env.new( [ 0.0, amp, amp, 0.0 ], [ 0.1, dur - 0.02, 0.1 ], 'linear' ), doneAction: 2 );
    // vibrato envelope
    kenvibr = EnvGen.kr(Env.new( [ 0.0, 0.0, 1, 1, 0.0 ], [ 0.5, 0.5, dur - 1.5, 0.5 ], 'linear') )*vibrato;
    // create air flow and vibrato
    aflow1 = LFClipNoise.ar( sr, kenv1 );
    kvibr = SinOsc.ar( 5, 0, 0.1 * kenvibr );
    asum1 = ( ibreath * aflow1 ) + kenv1 + kvibr;
    afqc = ifqc.reciprocal - ( asum1/20000 ) - ( 9/sr ) + ( ifqc/12000000 ) - block;
    fdbckArray = LocalIn.ar( 1 );
    aflute1 = fdbckArray;
    asum2 = asum1 + ( aflute1 * ifeedbk1 );
    //ax = DelayL.ar( asum2, ifqc.reciprocal * 0.5, afqc * 0.5 );
    ax = DelayC.ar( asum2, ifqc.reciprocal - block * 0.5, afqc * 0.5 - ( asum1/ifqc/cr ) + 0.001 );
    apoly = ax - ( ax.cubed );
    asum3 = apoly + ( aflute1 * ifeedbk2 );
    avalue = LPF.ar( asum3, 2000 );
    aflute1 = DelayC.ar( avalue, ifqc.reciprocal - block, afqc );
    fdbckArray = [ aflute1 ];
    LocalOut.ar( fdbckArray );
    signalOut = avalue;
    OffsetOut.ar( 0, [ signalOut * kenv2, signalOut * kenv2 ] );
}).add;
)
//pchs is midi note value
(
Synth(\waveguideFlute, [\amp1, 2, \bend, 0, \gate, 1, \dur, 3, \ipress, 0.90, \ibreath, 0.00536, \ifeedbk1, 0.4, \ifeedbk2, 0.4, \pch, 100, \vibrato, 0.2] );
)