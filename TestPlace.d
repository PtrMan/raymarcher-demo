import core.sys.windows.windows;

static import DirectSoundDir.DirectSound;
import DirectSoundDir.dsound;

import MemoryC;

// for testing
import synth.Core;

import std.stdio;

import SimpleArray : SimpleArray;

import Random;

// testing
import Synth.NotesGenerator;



extern(Windows) HANDLE CreateEventA(void* /*SECURITY_ATTRIBUTES* */, BOOL, BOOL, void* /*LPCTSTR */);
extern(Windows) BOOL ResetEvent(HANDLE);

// gets called when the buffer need to be refilled
// TODO< more parameters >
void refillBuffer(StructSynthCore* synth, ref StructRandom random, ref DirectSoundDir.DirectSound.DirectSoundStruct directSoundStruct, ref IDirectSoundBuffer directSoundSecondaryBuffer, uint bufferOffsetInSamples)
{

	float[44100/2] buffer;

	foreach( i; 0..(buffer.length-150)/150 )
	{
		uint length;

		length = 80 + cast(uint)(0.0f* random.generateFloating!(float)() );

		synth.queueParticle(i*150+cast(uint)(0.0f* random.generateFloating!(float)()), length, 1.0f, 0.4f, EnumEnvelopeType.SINC1CYCLE);
	}

	writeln("sample");

	synth.samplesIntoBuffer(buffer.ptr, buffer.length);

	writeln("end sample");

	/*
	foreach(sampleI; 0..buffer.length)
	{
		writeln(buffer[sampleI]);
	}
	*/

	SimpleArray!float stereoBuffer;

	stereoBuffer.ptr = cast(float*)malloc(float.sizeof*buffer.length*2);
	stereoBuffer.length = buffer.length*2;


	// copy buffer into real stereo buffer
	foreach( i; 0..buffer.length )
	{
		stereoBuffer.ptr[i*2+0] = buffer[i];
		stereoBuffer.ptr[i*2+1] = buffer[i];
	}

	DirectSoundDir.DirectSound.fillBuffer(directSoundStruct, directSoundSecondaryBuffer, (bufferOffsetInSamples*1000)/44100 /* ms */, 500 /* ms */, stereoBuffer);

	Synth.NotesGenerator.aa();

}


void main(string[])
{
	bool calleeSuccess;

	HWND hwnd = GetConsoleWindow();

	DirectSoundDir.DirectSound.DirectSoundStruct directSoundStruct;
	IDirectSoundBuffer directSoundSecondaryBuffer;

	DirectSoundDir.DirectSound.setup(hwnd, directSoundStruct, calleeSuccess);
	if( !calleeSuccess )
	{
		
		for(;;)
		{}
	}

	DirectSoundDir.DirectSound.createSoundBuffer(directSoundStruct, &directSoundSecondaryBuffer, 2, 16, 44100, 1000 /*ms*/);
	if( directSoundSecondaryBuffer is null )
	{
		
		for(;;)
		{}
	}

	/+
	DirectSoundDir.DirectSound.generateSound(directSoundStruct, directSoundSecondaryBuffer, 0, 1000 /*ms*/, 5000 /* hz */);

	DirectSoundDir.DirectSound.setPlaybackVolume(directSoundSecondaryBuffer, 0 /*db*/);

	DirectSoundDir.DirectSound.play(directSoundSecondaryBuffer, /*looped */false);	
	

	for(;;)
	{
	}
	+/

	StructRandom random;

	Random.init(random);


	StructSynthCore* synth;

	synth = newSynthCore();


	





	HANDLE eventNotify[2];


	// in the real world without any size limit we can encapsulate this [buffer refilling handling] into its own class
	{

		IDirectSoundNotify directSoundNotify;

		// setup notifications for direct sound
		// because when we just look up the time and refill at will we have the problems
		// * buffer position can desync -> leads to refilling of played buffer
		// * timers aren't that precise
		// * etc.

		if( directSoundSecondaryBuffer.QueryInterface(&IID_IDirectSoundNotify, cast(void**)&directSoundNotify) == E_NOINTERFACE )
		{
			// TODO< report error
			for(;;)
			{
			}
		}

		// create objects for notification
		

		eventNotify[0] = CreateEventA(null, false, false, null);
		eventNotify[1] = CreateEventA(null, false, false, null);

		if( eventNotify[0] == null || eventNotify[1] == null )
		{
			// TODO< report error
			for(;;)
			{
			}
		}

		DSBPOSITIONNOTIFY notifyStructures[2];
		notifyStructures[0].dwOffset = ((44100*2*2)/4)*1;
		notifyStructures[0].hEventNotify = eventNotify[0];
		notifyStructures[1].dwOffset = ((44100*2*2)/4)*3;
		notifyStructures[1].hEventNotify = eventNotify[1];

		// TODO< handling errors >
		directSoundNotify.SetNotificationPositions(2, cast(DSBPOSITIONNOTIFY*)&notifyStructures);

		// TODO< qurying and refilling on playback >

		// TODO in the real world we should need to clean up the
		// * directSoundNotify object with .release
		// * handles of the objects used to query the events
	}







	
	DirectSoundDir.DirectSound.generateSound(directSoundStruct, directSoundSecondaryBuffer, 0, 1000 /*ms*/, 5000 /* hz */);

	DirectSoundDir.DirectSound.setPlaybackVolume(directSoundSecondaryBuffer, 0 /*db*/);

	DirectSoundDir.DirectSound.play(directSoundSecondaryBuffer, /*looped */true);

	writeln("loop endless");

	for(;;)
	{
		// NONDEMO< belongs into a own method/function with a passed delegate which gets called if the buffer need to get refilled >
		{
			HRESULT hr;
			uint bufferOffsetInSamples;
			bool needRefill;

			needRefill = false;

			hr = WaitForMultipleObjects(2, eventNotify.ptr, false, 0);
			if( hr == WAIT_OBJECT_0 )
			{
				bufferOffsetInSamples = (44100/2)*1;
				needRefill = true;
			}
			else if( hr == WAIT_OBJECT_0 + 1 )
			{
				bufferOffsetInSamples = (44100/2)*0;
				needRefill = true;
			}
			// TODO< error handling >

			if( needRefill )
			{
				// NODEMO< call refill delegate >
				refillBuffer(synth, random, directSoundStruct, directSoundSecondaryBuffer, bufferOffsetInSamples);
			}
		}

	}

	

	freeSynthCore(synth);

}