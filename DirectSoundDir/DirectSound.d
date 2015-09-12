module DirectSoundDir.DirectSound;

/* NOTE DEV-SRC<
   is practically copied from my project "ProjectSci"
   the class was converted to a struct with some functions which act as methods
   plus some minor quirks
   >
 */

public import std.c.windows.com;

import SimpleArray : SimpleArray;
import misc: memset;
import Math : sinCos;

import DirectSoundDir.dsound;
import DirectSoundDir.ComManager;

import Window;

struct DirectSoundStruct
{
	private IDirectSound DirectSoundPtr;
	private DSBUFFERDESC PrimaryBufferDescription;
	private IDirectSoundBuffer DirectSoundBufferPrimary;
}

public void setup(HWND hwnd, ref DirectSoundStruct thisPtr, out bool Success)
{
	ComManager.initilize();

	Success = thisPtr.create(hwnd);
}

public void shutdown(ref DirectSoundStruct thisPtr)
{
	if( !(thisPtr.DirectSoundPtr is null) )
	{
		thisPtr.DirectSoundBufferPrimary.Release(); // BUG
		thisPtr.DirectSoundPtr.Release();
	}

	ComManager.uninitilize();
}

private bool create(ref DirectSoundStruct thisPtr, HWND Hwnd)
{
	if( thisPtr.DirectSoundPtr is null )
	{
		// init DirectSound-Interface
		
		if( CoCreateInstance(&CLSID_DirectSound, null, CLSCTX_ALL, &IID_IDirectSound, cast(VOID**)&(thisPtr.DirectSoundPtr)) != S_OK )
		{
			return false;
		}

		if( thisPtr.DirectSoundPtr.Initialize(null) != S_OK )
		{
			return false;
		}

		// be cooperative

		if( thisPtr.DirectSoundPtr.SetCooperativeLevel(Hwnd, DSSCL_NORMAL) != S_OK )
		{
        	return false;
        }
		
		// init primary sound buffer

		memset(&(thisPtr.PrimaryBufferDescription), 0, DSBUFFERDESC.sizeof);
		thisPtr.PrimaryBufferDescription.dwSize = DSBUFFERDESC.sizeof;
		thisPtr.PrimaryBufferDescription.dwFlags = DSBCAPS_PRIMARYBUFFER;

		if( thisPtr.DirectSoundPtr.CreateSoundBuffer(&(thisPtr.PrimaryBufferDescription), &(thisPtr.DirectSoundBufferPrimary), null) != S_OK )
		{
			return false;
		}

		return true;
	}
	
	return false;
}

/** \brief tries to create a sound buffer
 * 
 * the buffer will be null on failture
 *
 * \param Buffer is the buffer which should be created
 * \param Channels ...
 * \param BitsPerSample ...
 * \param SamplesPerSecond ...
 * \param Duration the duration in milliseconds
 */
public void createSoundBuffer(ref DirectSoundStruct thisPtr, IDirectSoundBuffer *Buffer, uint Channels, uint BitsPerSample, uint SamplesPerSecond, uint Duration)
{
	WAVEFORMATEX Pcmwf;

	if( thisPtr.DirectSoundPtr is null )
	{
		*Buffer = cast(IDirectSoundBuffer)null;
		return;
	}

	memset(&Pcmwf, 0, WAVEFORMATEX.sizeof);
	Pcmwf.wFormatTag = cast(ushort)WAVE_FORMAT_PCM;
	Pcmwf.nChannels = cast(WORD)Channels;
	Pcmwf.wBitsPerSample = cast(WORD)BitsPerSample;
	Pcmwf.nSamplesPerSec = SamplesPerSecond;
	Pcmwf.nBlockAlign = cast(WORD)(Channels*(BitsPerSample/8));
	Pcmwf.nAvgBytesPerSec = Pcmwf.nSamplesPerSec * Pcmwf.nBlockAlign;
	Pcmwf.cbSize = WAVEFORMATEX.sizeof;

	memset(&(thisPtr.PrimaryBufferDescription), 0, DSBUFFERDESC.sizeof);
	thisPtr.PrimaryBufferDescription.dwSize = DSBUFFERDESC.sizeof;
	thisPtr.PrimaryBufferDescription.dwFlags = DSBCAPS_CTRLPAN | DSBCAPS_CTRLVOLUME | DSBCAPS_CTRLFREQUENCY | DSBCAPS_GLOBALFOCUS | DSBCAPS_CTRLPOSITIONNOTIFY /* actually only needed if notifications are used */  ;
	thisPtr.PrimaryBufferDescription.dwBufferBytes = (Duration * Pcmwf.nAvgBytesPerSec) / 1000;
	thisPtr.PrimaryBufferDescription.lpwfxFormat = &Pcmwf; // TODO< fix thisPtr >

	// create the sound buffer now
	if( thisPtr.DirectSoundPtr.CreateSoundBuffer(&(thisPtr.PrimaryBufferDescription), Buffer, null) != S_OK )
	{
		*Buffer = cast(IDirectSoundBuffer)null;
		return;
	}

	// all fine
	return;
}

private bool getWaveFormat(IDirectSoundBuffer Buf, WAVEFORMATEX *Pcmwf)
{
	uint* NullPtr = cast(uint*)0;

	if( Buf is null )
	{
		return false;
	}

	Pcmwf.cbSize = WAVEFORMATEX.sizeof;

	if( Buf.GetFormat(Pcmwf, WAVEFORMATEX.sizeof, NullPtr) != S_OK )
	{
		return false;
	}

	return true;
}

/** \brief tries to lock the low level buffer
 *
 * \param Buf low level buffer
 * \param Offset the offset in milliseconds
 * \param Size size in milliseconds
 * \param Ptr1 see DirectSound docs
 * \param Bytes1 see DirectSound docs
 * \param Ptr2 see DirectSound docs
 * \param Bytes2 see DirectSound docs
 * \return true on success
 */
public bool lockBuffer(ref DirectSoundStruct thisPtr, IDirectSoundBuffer Buf, uint Offset, uint Size, void **Ptr1, DWORD *Bytes1, void **Ptr2, DWORD *Bytes2)
{
	WAVEFORMATEX Pcmwf;

	if( Buf is null )
	{
		return false;
	}

	if( !getWaveFormat(Buf, &Pcmwf) )
	{
		return false;
	}

	HRESULT Result = Buf.Lock(
		(Offset * Pcmwf.nAvgBytesPerSec) / 1000,
		(Size * Pcmwf.nAvgBytesPerSec) / 1000,
		Ptr1,
		Bytes1,
		Ptr2,
		Bytes2,
		0
	);

	if( Result != S_OK )
	{
		return false;
	}

	return true;
}

public bool unlockBuffer(IDirectSoundBuffer Buf, void *Ptr1, DWORD Bytes1, void *Ptr2, DWORD Bytes2)
{
	HRESULT Res;

	if( Buf is null )
	{
		return false;
	}

	Res = Buf.Unlock(Ptr1, Bytes1, Ptr2, Bytes2);

	if( Res != S_OK )
	{
		return false;
	}

	return true;
}

final public bool play(IDirectSoundBuffer Buf, bool Looped = false)
{
	if( Buf is null )
	{
		return false;
	}

	Buf.SetCurrentPosition(0);
  
	if( Buf.Play(0, 0, Looped?DSBPLAY_LOOPING:0) != S_OK )
	{
		return false;
	}

	return true;
}

final public bool stop(IDirectSoundBuffer Buf)
{
	if( Buf is null )
	{
		return false;
	}

	if( Buf.Stop() != S_OK )
	{
		return false;
	}

	return true;
}



/** \brief fills the buffer with the data
*
* \param Buffer ...
* \param Offset offset in milliseconds
* \param Length length in milliseconds
* \param Data (stereo) float buffer
* \return true on success
*/
public bool fillBuffer(ref DirectSoundStruct thisPtr, IDirectSoundBuffer Buffer, uint Offset, uint Length, SimpleArray!float Data)
{
	WAVEFORMATEX Pcmwf;
	void *LpvPtr1;
	void *LpvPtr2;
	DWORD DwBytes1, DwBytes2;
	uint i;
	short *T;
	uint NumberOfChannels;
	
	if( Buffer is null )
	{
		return false;
	}

	if( !getWaveFormat(Buffer, &Pcmwf) )
	{
		return false;
	}

	NumberOfChannels = 2; // is allways stereo

	// check if the number of channels matches
	if( Pcmwf.nChannels != NumberOfChannels )
	{
		return false;
	}

	if( !thisPtr.lockBuffer(Buffer, Offset, Length, &LpvPtr1, &DwBytes1, &LpvPtr2, &DwBytes2) )
	{
		return false;
	}

	// write the sound
	for( i = 0, T = cast(short*)LpvPtr1; i < (DwBytes1+DwBytes2); )
	{
		if( i == DwBytes1 )
		{
			T = cast(short*)LpvPtr2;
		}

		if( NumberOfChannels == 1 )
		{
			int Value = cast(int)( Data.ptr[i/2+0]*(cast(float)(2<<(16-3))) );

			*T = cast(short)Value;

			i += 2;
			T += 1;
		}
		else if( NumberOfChannels == 2 )
		{
			// NOTE< channels could be switched >

			int ValueR = cast(int)( Data.ptr[i/4*2 + 0]*(cast(float)(2<<(16-3))) );
			int ValueL = cast(int)( Data.ptr[i/4*2 + 1]*(cast(float)(2<<(16-3))) );

			*T = cast(short)ValueR;
			*(T+1) = cast(short)ValueL;

			i += 4;
			T += 2;
		}
		else
		{
			return false;
		}
	}

	// unlock memory
	if( !unlockBuffer(Buffer, LpvPtr1, DwBytes1, LpvPtr2, DwBytes2) )
	{
		return false;
	}

	return true;
}

// just for testing


/** \brief fills the buffer with a sinus sound
 *
 * \param Buf the buffer
 * \param Offset offset in milliseconds
 * \param Length length in milliseconds
 * \param Frequency ...
 * \return true on success
 */
final public bool generateSound(DirectSoundStruct thisPtr, IDirectSoundBuffer Buf, uint Offset, uint Length, uint Frequency)
{
	WAVEFORMATEX Pcmwf;
	void *LpvPtr1;
	void *LpvPtr2;
	DWORD DwBytes1, DwBytes2;
	uint i;
	short *T;

	if( Buf is null )
	{
		return false;
	}

	if( !getWaveFormat(Buf, &Pcmwf) )
	{
		return false;
	}

	if( !thisPtr.lockBuffer(Buf, Offset, Length, &LpvPtr1, &DwBytes1, &LpvPtr2, &DwBytes2) )
	{
		return false;
	}

	// write a sinus sound now
	for( i = 0, T=cast(short*)LpvPtr1; i < (DwBytes1+DwBytes2); i+=4,T+=2 )
	{
		float sin, cos;

		if( i == DwBytes1 )
		{
			T = cast(short*)LpvPtr2;
		}

		float Divider = cast(float)Pcmwf.nAvgBytesPerSec/(6.283185f*cast(float)Frequency);

		sinCos(cast(float)i/Divider, sin, cos);

		int Value = cast(short)(sin*30000.0f);


		*T = *(T+1) = cast(short)Value;
	}

	// unlock memory
	if( !unlockBuffer(Buf, LpvPtr1, DwBytes1, LpvPtr2, DwBytes2) )
	{
		return false;
	}

	return true;
}

final public bool setPlaybackVolume(IDirectSoundBuffer Buf, LONG Db)
{
	if( Buf is null )
	{
		return false;
	}

	if( Buf.SetVolume(Db) != S_OK )
	{
		return false;
	}

	return true;
}

final public bool setBalance(IDirectSoundBuffer Buf, LONG Pan)
{
	if( Buf is null )
	{
		return false;
	}

	if( Buf.SetPan(Pan) != S_OK )
	{
		return false;
	}

	return true;
}

final public int getPlayPosition(IDirectSoundBuffer Buf)
{
	DSBCAPS Caps;
	DWORD PlayPos;

	Caps.dwSize = DSBCAPS.sizeof;

	if( Buf.GetCaps(&Caps) != S_OK )
	{
		return -1;
	}

	if( Buf.GetCurrentPosition(&PlayPos, cast(uint*)0) != S_OK )
	{
		return -1;
	}

	return((PlayPos*100)/Caps.dwBufferBytes);
}
