format MS COFF


public _D14DirectSoundDir6dsound16IID_IDirectSoundxS3std1c7windows3com4GUID
public _D14DirectSoundDir6dsound17CLSID_DirectSoundxS3std1c7windows3com4GUID
public _D14DirectSoundDir6dsound12MAKE_HRESULTFkkkZi
section '.DATA' data
_D14DirectSoundDir6dsound16IID_IDirectSoundxS3std1c7windows3com4GUID:
db 83H,0FAH,9AH,27H,81H,49H,0CEH,11H
db 0A5H,21H,00H,20H,0AFH,0BH,0E5H,60H
_D14DirectSoundDir6dsound17CLSID_DirectSoundxS3std1c7windows3com4GUID:
db 46H,0D9H,0D4H,47H,0E8H,62H,0CFH,11H
db 93H,0BCH,44H,45H,53H,54H,00H,00H

section '.TEXT' executable
_D14DirectSoundDir6dsound12MAKE_HRESULTFkkkZi:
enter 4, 0
mov dword [ebp-4H], eax
mov eax, dword [ebp+0CH]
shl eax, 31
mov ecx, dword [ebp+8H]
shl ecx, 16
or eax, ecx
or eax, dword [ebp-4H]
leave 
ret 8

