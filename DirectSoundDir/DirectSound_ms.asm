format MS COFF

extrn _D14DirectSoundDir10ComManager10ComManager9initilizeFZv
extrn _D14DirectSoundDir10ComManager10ComManager11uninitilizeFZv
extrn __imp__CoCreateInstance@20
extrn _D4Math6sinCosFfJfJfZv
extrn _D14DirectSoundDir6dsound17CLSID_DirectSoundxS3std1c7windows3com4GUID
extrn _D14DirectSoundDir6dsound16IID_IDirectSoundxS3std1c7windows3com4GUID
extrn _D4misc6memsetFPvgkZv


public _D14DirectSoundDir11DirectSound5setupFPvKS14DirectSoundDir11DirectSound17DirectSoundStructJbZv
public _D14DirectSoundDir11DirectSound8shutdownFKS14DirectSoundDir11DirectSound17DirectSoundStructZv
public _D14DirectSoundDir11DirectSound6createFKS14DirectSoundDir11DirectSound17DirectSoundStructPvZb
public _D14DirectSoundx80x83x8b11x80x8bx9017createx80x85x8dBufferFKSx80x9fxb3x80x8bx8dStructPCx80x90xb26dsx80x85xac8Ix80x8bx98x80x86xe0kkxc9Zv
public _D14DirectSoundx80x83x8b11x80x8bx9013getWaveFormatFCx80x90xae6dsx80x85xa88Ix80x8bx98BufferPSx80x98xad2WAVEFORMATEXZb
public _D14DirectSoundx80x83x8b11x80x8bx9010lockBufferFKSx80x9exac7x80x8bx8dStructCx80x90xb16dsx80x85xab8Ix80x8bx98x80x86xdfkkPPvPxe4kZb
public _D14DirectSoundDir11DirectSound12unlockBufferFC14DirectSoundDir6dsound18IDirectSoundBufferPvkPvkZb
public _D14DirectSoundDir11DirectSound4playFC14DirectSoundDir6dsound18IDirectSoundBufferbZb
public _D14DirectSoundDir11DirectSound4stopFC14DirectSoundDir6dsound18IDirectSoundBufferZb
public _D14DirectSoundx80x83x8b11x80x8bx9010fillBufferFKSx80x9exac7x80x8bx8dStructCx80x90xb16dsx80x85xab8Ix80x8bx98x80x86xdfkkS11SimpleArray19__Tx80x8dx92TfZx80x8dx90Zb
public _D14DirectSoundx80x83x8b11x80x8bx9013generatex80x85x8fFSx80x9exae7x80x8bx8dStructCx80x90xb16dsx80x85xab8Ix80x8bx98BufferkkkZb
public _D14DirectSoundDir11DirectSound17setPlaybackVolumeFC14DirectSoundDir6dsound18IDirectSoundBufferiZb
public _D14DirectSoundDir11DirectSound10setBalanceFC14DirectSoundDir6dsound18IDirectSoundBufferiZb
public _D14DirectSoundDir11DirectSound15getPlayPositionFC14DirectSoundDir6dsound18IDirectSoundBufferZi

section '.TEXT' data
?_003:
dw 0FBFH,03BFH
?_002:
dd 46800000H
?_006:
dd 46EA6000H
?_005:
dd 40C90FDAH
?_004:
dd 7FA00000H

section '0' executable
_D14DirectSoundDir11DirectSound5setupFPvKS14DirectSoundDir11DirectSound17DirectSoundStructJbZv:
enter 4, 0
mov dword [ebp-4H], eax
mov byte [eax], 0
call _D14DirectSoundDir10ComManager10ComManager9initilizeFZv
push dword [ebp+8H]
mov eax, dword [ebp+0CH]
call _D14DirectSoundDir11DirectSound6createFKS14DirectSoundDir11DirectSound17DirectSoundStructPvZb
mov ecx, dword [ebp-4H]
mov byte [ecx], al
leave 
ret 8
section '0' executable
_D14DirectSoundDir11DirectSound8shutdownFKS14DirectSoundDir11DirectSound17DirectSoundStructZv:
enter 4, 0
push ebx
push esi
mov dword [ebp-4H], eax
cmp dword [eax], 0
jz ?_025
mov ecx, dword [eax+28H]
push ecx
mov edx, dword [ecx]
call near [edx+8H]
mov eax, dword [ebp-4H]
mov ebx, dword [eax]
push ebx
mov esi, dword [ebx]
call near [esi+8H]
?_025:
call _D14DirectSoundDir10ComManager10ComManager11uninitilizeFZv
pop esi
pop ebx
leave 
ret 
section '0' executable
_D14DirectSoundDir11DirectSound6createFKS14DirectSoundDir11DirectSound17DirectSoundStructPvZb:
enter 4, 0
push ebx
push esi
mov dword [ebp-4H], eax
mov ecx, dword [ebp+8H]
cmp dword [ecx], 0
jne ?_030
push ecx
mov edx, _D14DirectSoundDir6dsound16IID_IDirectSoundxS3std1c7windows3com4GUID
push edx
push 7
push 0
mov ebx, _D14DirectSoundDir6dsound17CLSID_DirectSoundxS3std1c7windows3com4GUID
push ebx
call near [__imp__CoCreateInstance@20]
test eax, eax
jz ?_026
xor eax, eax
pop esi
pop ebx
leave 
ret 4
?_026:
push 0
mov esi, dword [ebp+8H]
mov ecx, dword [esi]
push ecx
mov edx, dword [ecx]
call near [edx+28H]
test eax, eax
jz ?_027
xor eax, eax
pop esi
pop ebx
leave 
ret 4
?_027:
push 1
push dword [ebp-4H]
mov ebx, dword [ebp+8H]
mov esi, dword [ebx]
push esi
mov ecx, dword [esi]
call near [ecx+18H]
test eax, eax
jz ?_028
xor eax, eax
pop esi
pop ebx
leave 
ret 4
?_028:
mov edx, dword [ebp+8H]
lea ebx, [edx+4H]
push ebx
push 0
mov eax, 36
call _D4misc6memsetFPvgkZv
mov dword [ebx], 36
mov ecx, dword [ebp+8H]
mov dword [ecx+8H], 1
push 0
lea esi, [ecx+28H]
push esi
lea edx, [ecx+4H]
push edx
mov ebx, dword [ecx]
push ebx
mov eax, dword [ebx]
call near [eax+0CH]
test eax, eax
jz ?_029
xor eax, eax
pop esi
pop ebx
leave 
ret 4
?_029:
mov al, 1
pop esi
pop ebx
leave 
ret 4
?_030:
xor eax, eax
pop esi
pop ebx
leave 
ret 4
section '0' executable
_D14DirectSoundx80x83x8b11x80x8bx9017createx80x85x8dBufferFKSx80x9fxb3x80x8bx8dStructPCx80x90xb26dsx80x85xac8Ix80x8bx98x80x86xe0kkxc9Zv:
enter 24, 0
push ebx
push esi
push edi
mov dword [ebp-4H], eax
lea ecx, [ebp-18H]
xor edx, edx
mov dword [ecx], edx
mov dword [ecx+4H], edx
mov dword [ecx+8H], edx
mov dword [ecx+0CH], edx
mov dword [ecx+10H], edx
mov ebx, dword [ebp+18H]
cmp dword [ebx], 0
jnz ?_031
mov esi, dword [ebp+14H]
mov dword [esi], edx
pop edi
pop esi
pop ebx
leave 
ret 20
?_031:
lea edi, [ebp-18H]
push edi
push edx
mov eax, 20
call _D4misc6memsetFPvgkZv
mov word [ebp-18H], 1
mov cx, word [ebp+10H]
mov word [ebp-16H], cx
mov dx, word [ebp+0CH]
mov word [ebp-0AH], dx
mov ebx, dword [ebp+8H]
mov dword [ebp-14H], ebx
mov esi, dword [ebp+0CH]
shr esi, 3
mov eax, esi
mov ecx, dword [ebp+10H]
mul ecx
mov word [ebp-0CH], ax
movzx edx, ax
imul edx, dword [ebp-14H]
mov dword [ebp-10H], edx
mov word [ebp-8H], 20
mov ebx, dword [ebp+18H]
lea esi, [ebx+4H]
push esi
push 0
mov eax, 36
call _D4misc6memsetFPvgkZv
mov dword [esi], 36
mov dword [ebx+8H], 33248
mov eax, dword [ebp-4H]
imul eax, dword [ebp-10H]
mov ecx, 1000
xor edx, edx
div ecx
mov dword [ebx+0CH], eax
lea edx, [ebp-18H]
mov dword [ebx+14H], edx
push 0
push dword [ebp+14H]
lea esi, [ebx+4H]
push esi
mov ebx, dword [ebx]
push ebx
mov eax, dword [ebx]
call near [eax+0CH]
test eax, eax
jz ?_032
mov ecx, dword [ebp+14H]
mov dword [ecx], 0
pop edi
pop esi
pop ebx
leave 
ret 20
?_032:
pop edi
pop esi
pop ebx
leave 
ret 20
section '0' executable
_D14DirectSoundx80x83x8b11x80x8bx9013getWaveFormatFCx80x90xae6dsx80x85xa88Ix80x8bx98BufferPSx80x98xad2WAVEFORMATEXZb:
enter 8, 0
mov dword [ebp-8H], 0
cmp dword [ebp+8H], 0
jnz ?_033
xor eax, eax
leave 
ret 4
?_033:
mov word [eax+10H], 20
push dword [ebp-8H]
push 20
push eax
push dword [ebp+8H]
mov ecx, dword [ebp+8H]
mov edx, dword [ecx]
call near [edx+14H]
test eax, eax
jz ?_034
xor eax, eax
leave 
ret 4
?_034:
mov al, 1
leave 
ret 4
section '0' executable
_D14DirectSoundx80x83x8b11x80x8bx9010lockBufferFKSx80x9exac7x80x8bx8dStructCx80x90xb16dsx80x85xab8Ix80x8bx98x80x86xdfkkPPvPxe4kZb:
enter 24, 0
push ebx
mov dword [ebp-4H], eax
lea ecx, [ebp-18H]
xor edx, edx
mov dword [ecx], edx
mov dword [ecx+4H], edx
mov dword [ecx+8H], edx
mov dword [ecx+0CH], edx
mov dword [ecx+10H], edx
cmp dword [ebp+1CH], 0
jnz ?_035
mov al, dl
pop ebx
leave 
ret 28
?_035:
push dword [ebp+1CH]
lea eax, [ebp-18H]
call _D14DirectSoundx80x83x8b11x80x8bx9013getWaveFormatFCx80x90xae6dsx80x85xa88Ix80x8bx98BufferPSx80x98xad2WAVEFORMATEXZb
xor al, 01H
jz ?_036
xor eax, eax
pop ebx
leave 
ret 28
?_036:
push 0
push dword [ebp-4H]
push dword [ebp+8H]
push dword [ebp+0CH]
push dword [ebp+10H]
mov eax, dword [ebp+14H]
imul eax, dword [ebp-10H]
mov ecx, 1000
xor edx, edx
div ecx
push eax
mov eax, dword [ebp+18H]
imul eax, dword [ebp-10H]
xor edx, edx
div ecx
push eax
push dword [ebp+1CH]
mov edx, dword [ebp+1CH]
mov ebx, dword [edx]
call near [ebx+2CH]
test eax, eax
jz ?_037
xor eax, eax
pop ebx
leave 
ret 28
?_037:
mov al, 1
pop ebx
leave 
ret 28
section '0' executable
_D14DirectSoundDir11DirectSound12unlockBufferFC14DirectSoundDir6dsound18IDirectSoundBufferPvkPvkZb:
enter 4, 0
cmp dword [ebp+14H], 0
jnz ?_038
xor eax, eax
leave 
ret 16
?_038:
push eax
push dword [ebp+8H]
push dword [ebp+0CH]
push dword [ebp+10H]
push dword [ebp+14H]
mov ecx, dword [ebp+14H]
mov edx, dword [ecx]
call near [edx+4CH]
test eax, eax
jz ?_039
xor eax, eax
leave 
ret 16
?_039:
mov al, 1
leave 
ret 16
section '0' executable
_D14DirectSoundDir11DirectSound4playFC14DirectSoundDir6dsound18IDirectSoundBufferbZb:
enter 4, 0
push ebx
mov dword [ebp-4H], eax
cmp dword [ebp+8H], 0
jnz ?_040
xor eax, eax
pop ebx
leave 
ret 4
?_040:
push 0
push dword [ebp+8H]
mov ecx, dword [ebp+8H]
mov edx, dword [ecx]
call near [edx+34H]
cmp byte [ebp-4H], 0
mov ebx, 1
jnz ?_041
xor ebx, ebx
?_041:
push ebx
push 0
push 0
push dword [ebp+8H]
mov eax, dword [ebp+8H]
mov ecx, dword [eax]
call near [ecx+30H]
test eax, eax
jz ?_042
xor eax, eax
pop ebx
leave 
ret 4
?_042:
mov al, 1
pop ebx
leave 
ret 4
section '0' executable
_D14DirectSoundDir11DirectSound4stopFC14DirectSoundDir6dsound18IDirectSoundBufferZb:
enter 4, 0
mov dword [ebp-4H], eax
cmp dword [ebp-4H], 0
jnz ?_043
xor eax, eax
leave 
ret 
?_043:
push dword [ebp-4H]
mov ecx, dword [ebp-4H]
mov edx, dword [ecx]
call near [edx+48H]
test eax, eax
jz ?_044
xor eax, eax
leave 
ret 
?_044:
mov al, 1
leave 
ret 
section '0' executable
_D14DirectSoundx80x83x8b11x80x8bx9010fillBufferFKSx80x9exac7x80x8bx8dStructCx80x90xb16dsx80x85xab8Ix80x8bx98x80x86xdfkkS11SimpleArray19__Tx80x8dx92TfZx80x8dx90Zb:
enter 60, 0
push ebx
push esi
lea eax, [ebp-3CH]
xor ecx, ecx
mov dword [eax], ecx
mov dword [eax+4H], ecx
mov dword [eax+8H], ecx
mov dword [eax+0CH], ecx
mov dword [eax+10H], ecx
mov dword [ebp-28H], ecx
mov dword [ebp-24H], ecx
mov dword [ebp-20H], ecx
mov dword [ebp-1CH], ecx
mov dword [ebp-18H], ecx
mov dword [ebp-14H], ecx
mov dword [ebp-10H], ecx
cmp dword [ebp+18H], 0
jnz ?_045
mov al, cl
pop esi
pop ebx
leave 
ret 24
?_045:
push dword [ebp+18H]
lea eax, [ebp-3CH]
call _D14DirectSoundx80x83x8b11x80x8bx9013getWaveFormatFCx80x90xae6dsx80x85xa88Ix80x8bx98BufferPSx80x98xad2WAVEFORMATEXZb
xor al, 01H
jz ?_046
xor eax, eax
pop esi
pop ebx
leave 
ret 24
?_046:
mov edx, 2
mov dword [ebp-10H], edx
movzx ecx, word [ebp-3AH]
cmp ecx, edx
jz ?_047
mov al, dh
pop esi
pop ebx
leave 
ret 24
?_047:
push dword [ebp+1CH]
push dword [ebp+18H]
push dword [ebp+14H]
push dword [ebp+10H]
lea ebx, [ebp-28H]
push ebx
lea esi, [ebp-20H]
push esi
lea edx, [ebp-24H]
push edx
lea eax, [ebp-1CH]
call _D14DirectSoundx80x83x8b11x80x8bx9010lockBufferFKSx80x9exac7x80x8bx8dStructCx80x90xb16dsx80x85xab8Ix80x8bx98x80x86xdfkkPPvPxe4kZb
xor al, 01H
jz ?_048
xor eax, eax
pop esi
pop ebx
leave 
ret 24
?_048:
mov dword [ebp-18H], 0
mov ecx, dword [ebp-28H]
mov dword [ebp-14H], ecx
?_049:
mov ebx, dword [ebp-20H]
add ebx, dword [ebp-1CH]
cmp dword [ebp-18H], ebx
jnc ?_053
mov edx, dword [ebp-18H]
cmp edx, dword [ebp-20H]
jnz ?_050
mov esi, dword [ebp-24H]
mov dword [ebp-14H], esi
?_050:
cmp dword [ebp-10H], 1
jnz ?_051
mov eax, dword [ebp-18H]
shr eax, 1
mov ecx, dword [ebp+0CH]
fld dword [ecx+eax*4]
fmul dword [?_002]
sub esp, 8
fnstcw word [esp+4H]
fldcw word [?_003]
fistp dword [esp]
fldcw word [esp+4H]
pop ebx
add esp, 4
mov dword [ebp-0CH], ebx
mov dx, word [ebp-0CH]
mov esi, dword [ebp-14H]
mov word [esi], dx
add dword [ebp-18H], 2
add dword [ebp-14H], 2
jmp ?_049
?_051:
cmp dword [ebp-10H], 2
jnz ?_052
mov eax, dword [ebp-18H]
shr eax, 2
add eax, eax
mov ecx, dword [ebp+0CH]
fld dword [ecx+eax*4]
fmul dword [?_002]
sub esp, 8
fnstcw word [esp+4H]
fldcw word [?_003]
fistp dword [esp]
fldcw word [esp+4H]
pop ebx
add esp, 4
mov dword [ebp-8H], ebx
lea edx, [eax+1H]
fld dword [ecx+edx*4]
fmul dword [?_002]
sub esp, 8
fnstcw word [esp+4H]
fldcw word [?_003]
fistp dword [esp]
fldcw word [esp+4H]
pop esi
add esp, 4
mov dword [ebp-4H], esi
mov ax, word [ebp-8H]
mov ecx, dword [ebp-14H]
mov word [ecx], ax
mov bx, word [ebp-4H]
mov word [ecx+2H], bx
add dword [ebp-18H], 4
add dword [ebp-14H], 4
jmp ?_049
?_052:
xor eax, eax
pop esi
pop ebx
leave 
ret 24
?_053:
push dword [ebp+18H]
push dword [ebp-28H]
push dword [ebp-20H]
push dword [ebp-24H]
mov eax, dword [ebp-1CH]
call _D14DirectSoundDir11DirectSound12unlockBufferFC14DirectSoundDir6dsound18IDirectSoundBufferPvkPvkZb
xor al, 01H
jz ?_054
xor eax, eax
pop esi
pop ebx
leave 
ret 24
?_054:
mov al, 1
pop esi
pop ebx
leave 
ret 24
section '0' executable
_D14DirectSoundx80x83x8b11x80x8bx9013generatex80x85x8fFSx80x9exae7x80x8bx8dStructCx80x90xb16dsx80x85xab8Ix80x8bx98BufferkkkZb:
enter 80, 0
push ebx
push esi
mov dword [ebp-4H], eax
lea ecx, [ebp-40H]
xor edx, edx
mov dword [ecx], edx
mov dword [ecx+4H], edx
mov dword [ecx+8H], edx
mov dword [ecx+0CH], edx
mov dword [ecx+10H], edx
mov dword [ebp-2CH], edx
mov dword [ebp-28H], edx
mov dword [ebp-24H], edx
mov dword [ebp-20H], edx
mov dword [ebp-1CH], edx
mov dword [ebp-18H], edx
cmp dword [ebp+10H], 0
jnz ?_055
mov al, dl
pop esi
pop ebx
leave 
ret 56
?_055:
push dword [ebp+10H]
lea eax, [ebp-40H]
call _D14DirectSoundx80x83x8b11x80x8bx9013getWaveFormatFCx80x90xae6dsx80x85xa88Ix80x8bx98BufferPSx80x98xad2WAVEFORMATEXZb
xor al, 01H
jz ?_056
xor eax, eax
pop esi
pop ebx
leave 
ret 56
?_056:
lea ecx, [ebp+14H]
push ecx
push dword [ebp+10H]
push dword [ebp+0CH]
push dword [ebp+8H]
lea edx, [ebp-2CH]
push edx
lea ebx, [ebp-24H]
push ebx
lea esi, [ebp-28H]
push esi
lea eax, [ebp-20H]
call _D14DirectSoundx80x83x8b11x80x8bx9010lockBufferFKSx80x9exac7x80x8bx8dStructCx80x90xb16dsx80x85xab8Ix80x8bx98x80x86xdfkkPPvPxe4kZb
xor al, 01H
jz ?_057
xor eax, eax
pop esi
pop ebx
leave 
ret 56
?_057:
mov dword [ebp-1CH], 0
mov ecx, dword [ebp-2CH]
mov dword [ebp-18H], ecx
?_058:
mov edx, dword [ebp-24H]
add edx, dword [ebp-20H]
cmp dword [ebp-1CH], edx
jnc ?_060
fld dword [?_004]
fstp dword [ebp-14H]
fld dword [?_004]
fstp dword [ebp-10H]
mov ebx, dword [ebp-1CH]
cmp ebx, dword [ebp-24H]
jnz ?_059
mov esi, dword [ebp-28H]
mov dword [ebp-18H], esi
?_059:
mov eax, dword [ebp-38H]
mov dword [ebp-50H], eax
xor ecx, ecx
mov dword [ebp-4CH], ecx
fild qword [ebp-50H]
mov edx, dword [ebp-4H]
mov dword [ebp-50H], edx
mov dword [ebp-4CH], ecx
fild qword [ebp-50H]
fmul dword [?_005]
fdivp st1, st
fstp dword [ebp-0CH]
mov ebx, dword [ebp-1CH]
mov dword [ebp-50H], ebx
mov dword [ebp-4CH], ecx
fild qword [ebp-50H]
fdiv dword [ebp-0CH]
sub esp, 4
fstp dword [esp]
lea esi, [ebp-14H]
push esi
lea eax, [ebp-10H]
call _D4Math6sinCosFfJfJfZv
fld dword [ebp-14H]
fmul dword [?_006]
push eax
fnstcw word [esp+2H]
fldcw word [?_003]
fistp word [esp]
fldcw word [esp+2H]
pop ecx
movsx ecx, cx
mov dword [ebp-8H], ecx
mov dx, word [ebp-8H]
mov ebx, dword [ebp-18H]
mov word [ebx+2H], dx
mov word [ebx], dx
add dword [ebp-1CH], 4
add dword [ebp-18H], 4
jmp ?_058
?_060:
push dword [ebp+10H]
push dword [ebp-2CH]
push dword [ebp-24H]
push dword [ebp-28H]
mov eax, dword [ebp-20H]
call _D14DirectSoundDir11DirectSound12unlockBufferFC14DirectSoundDir6dsound18IDirectSoundBufferPvkPvkZb
xor al, 01H
jz ?_061
xor eax, eax
pop esi
pop ebx
leave 
ret 56
?_061:
mov al, 1
pop esi
pop ebx
leave 
ret 56
section '0' executable
_D14DirectSoundDir11DirectSound17setPlaybackVolumeFC14DirectSoundDir6dsound18IDirectSoundBufferiZb:
enter 4, 0
cmp dword [ebp+8H], 0
jnz ?_062
xor eax, eax
leave 
ret 4
?_062:
push eax
push dword [ebp+8H]
mov ecx, dword [ebp+8H]
mov edx, dword [ecx]
call near [edx+3CH]
test eax, eax
jz ?_063
xor eax, eax
leave 
ret 4
?_063:
mov al, 1
leave 
ret 4
section '0' executable
_D14DirectSoundDir11DirectSound10setBalanceFC14DirectSoundDir6dsound18IDirectSoundBufferiZb:
enter 4, 0
cmp dword [ebp+8H], 0
jnz ?_064
xor eax, eax
leave 
ret 4
?_064:
push eax
push dword [ebp+8H]
mov ecx, dword [ebp+8H]
mov edx, dword [ecx]
call near [edx+40H]
test eax, eax
jz ?_065
xor eax, eax
leave 
ret 4
?_065:
mov al, 1
leave 
ret 4
section '0' executable
_D14DirectSoundDir11DirectSound15getPlayPositionFC14DirectSoundDir6dsound18IDirectSoundBufferZi:
enter 28, 0
push ebx
push esi
push edi
mov dword [ebp-4H], eax
lea ecx, [ebp-1CH]
xor edx, edx
mov dword [ecx], edx
mov dword [ecx+4H], edx
mov dword [ecx+8H], edx
mov dword [ecx+0CH], edx
mov dword [ecx+10H], edx
mov dword [ebp-8H], edx
mov ebx, 20
mov dword [ebp-1CH], ebx
lea esi, [ebp-1CH]
push esi
push eax
mov edi, dword [eax]
call near [edi+0CH]
test eax, eax
jz ?_066
mov eax, 4294967295
pop edi
pop esi
pop ebx
leave 
ret 
?_066:
push 0
lea ecx, [ebp-8H]
push ecx
push dword [ebp-4H]
mov edx, dword [ebp-4H]
mov esi, dword [edx]
call near [esi+10H]
test eax, eax
jz ?_067
mov eax, 4294967295
pop edi
pop esi
pop ebx
leave 
ret 
?_067:
mov edi, dword [ebp-8H]
imul eax, edi, 100
xor edx, edx
div dword [ebp-14H]
pop edi
pop esi
pop ebx
leave 
ret 
