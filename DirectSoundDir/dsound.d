module DirectSoundDir.dsound;

public import std.c.windows.com;
public import core.sys.windows.windows;

// not directly part of directsound
const uint WAVE_FORMAT_PCM = 0x0001;

const uint DSSCL_NORMAL = 0x00000001;

const uint DSBCAPS_PRIMARYBUFFER     = 0x00000001;
const uint DSBCAPS_CTRLFREQUENCY     = 0x00000020;
const uint DSBCAPS_CTRLPAN           = 0x00000040;
const uint DSBCAPS_CTRLVOLUME        = 0x00000080;
const uint DSBCAPS_GLOBALFOCUS       = 0x00008000;
enum uint DSBCAPS_CTRLPOSITIONNOTIFY = 0x00000100;

const uint DSBPLAY_LOOPING = 0x00000001;


//const uint E_INVALIDARG = 0x80070057;


const uint DSERR_BUFFERLOST  = MAKE_DSHRESULT(150);
const uint DSERR_INVALIDCALL = MAKE_DSHRESULT(50);
const uint DSERR_INVALIDPARAM = 0x80070057;// E_INVALIDARG;
const uint DSERR_PRIOLEVELNEEDED = MAKE_DSHRESULT(70);


const IID IID_IDirectSound = { 0x279AFA83, 0x4981, 0x11CE, [0xA5, 0x21, 0x00, 0x20, 0xAF, 0x0B, 0xE5, 0x60]};
const CLSID CLSID_DirectSound = { 0x47d4d946, 0x62e8, 0x11cf, [0x93, 0xbc, 0x44, 0x45, 0x53, 0x54, 0x0, 0x0]};

const IID IID_IDirectSoundNotify = { 0xb0210783, 0x89cd, 0x11d0, [0xaf, 0x8, 0x0, 0xa0, 0xc9, 0x25, 0xcd, 0x16]};

extern( Windows )
{ 
	interface IDirectSound : IUnknown
	{
    	HRESULT CreateSoundBuffer(in DSBUFFERDESC *pcDSBufferDesc, IDirectSoundBuffer *ppDSBuffer, /*IUNKNOWN*/void *pUnkOuter);
    	HRESULT GetCaps(/*DSCAPS*/void *pDSCaps);
    	HRESULT DuplicateSoundBuffer(in IDirectSoundBuffer pDSBufferOriginal, IDirectSoundBuffer *ppDSBufferDuplicate);
    	HRESULT SetCooperativeLevel(HWND hwnd, DWORD dwLevel);
    	HRESULT Compact();
    	HRESULT GetSpeakerConfig(DWORD *pdwSpeakerConfig);
    	HRESULT SetSpeakerConfig(DWORD dwSpeakerConfig);
    	HRESULT Initialize(GUID *pcGuidDevice);
	}

	interface IDirectSoundBuffer : IUnknown
	{
		HRESULT GetCaps(DSBCAPS *pDSBufferCaps);
    	HRESULT GetCurrentPosition(DWORD *pdwCurrentPlayCursor, DWORD *pdwCurrentWriteCursor);
		HRESULT GetFormat(WAVEFORMATEX *pwfxFormat, DWORD dwSizeAllocated, DWORD *pdwSizeWritten);
		HRESULT GetVolume(LONG *plVolume);
		HRESULT GetPan(LONG *plPan);
		HRESULT GetFrequency(DWORD *pdwFrequency);
		HRESULT GetStatus(DWORD *pdwStatus);
		HRESULT Initialize(in /*DIRECTSOUND*/void *pDirectSound, DSBUFFERDESC *pcDSBufferDesc);
		HRESULT Lock(DWORD dwOffset, DWORD dwBytes, VOID **ppvAudioPtr1, DWORD *pdwAudioBytes1, VOID **ppvAudioPtr2, DWORD *pdwAudioBytes2, DWORD dwFlags);
		HRESULT Play(DWORD dwReserved1, DWORD dwPriority, DWORD dwFlags);
		HRESULT SetCurrentPosition(DWORD dwNewPosition);
		HRESULT SetFormat(WAVEFORMATEX *pcfxFormat);
		HRESULT SetVolume(LONG lVolume);
		HRESULT SetPan(LONG lPan);
		HRESULT SetFrequency(DWORD dwFrequency);
		HRESULT Stop();
		HRESULT Unlock(VOID *pvAudioPtr1, DWORD dwAudioBytes1, VOID *pvAudioPtr2, DWORD dwAudioBytes2);
		HRESULT Restore();
	}

	interface IDirectSoundNotify : IUnknown
	{
		HRESULT SetNotificationPositions(DWORD dwPositionNotifies, DSBPOSITIONNOTIFY* pcPositionNotifies);
	}
}

struct DSBUFFERDESC
{
	DWORD           dwSize;
	DWORD           dwFlags;
	DWORD           dwBufferBytes;
	DWORD           dwReserved;
	WAVEFORMATEX    *lpwfxFormat;
//#if DIRECTSOUND_VERSION >= 0x0700
    GUID            guid3DAlgorithm;
//#endif
};

// not directly part of directsound
struct WAVEFORMATEX
{
  WORD  wFormatTag;
  WORD  nChannels;
  DWORD nSamplesPerSec;
  DWORD nAvgBytesPerSec;
  WORD  nBlockAlign;
  WORD  wBitsPerSample;
  WORD  cbSize;
};

struct DSBCAPS
{
    DWORD           dwSize;
    DWORD           dwFlags;
    DWORD           dwBufferBytes;
    DWORD           dwUnlockTransferRate;
	DWORD           dwPlayCpuOverhead;
}

struct DSBPOSITIONNOTIFY
{
	DWORD dwOffset;
    HANDLE hEventNotify;
}

// not directy part of directsound
HRESULT MAKE_HRESULT(uint sev, uint fac, uint code)
{
	return cast(HRESULT)((sev<<31) | (fac<<16) | code);
}

private const uint _FACDS = 0x878;   /* DirectSound's facility code */

HRESULT MAKE_DSHRESULT(uint code)
{
	return MAKE_HRESULT(1, _FACDS, code);
}
