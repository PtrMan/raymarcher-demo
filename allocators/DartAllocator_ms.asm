format MS COFF

extrn _malloc
extrn _free


public _D10allocators13DartAllocator16newDartAllocatorFZPS10allocators13DartAllocator10StructDart
public _D10allocators13DartAllocator8allocateFPS10allocators13DartAllocator10StructDartkJbZPv
public _D10allocators13DartAllocator17freeDartAllocatorFPS10allocators13DartAllocator10StructDartZv
public _D10allocators13DartAllocator13allocateFrameFZPS10allocators13DartAllocator11StructFrame

section '.TEXT' data

section '0' executable
_D10allocators13DartAllocator16newDartAllocatorFZPS10allocators13DartAllocator10StructDart:
enter 4, 0
mov dword [ebp-4H], 0
push 8
call _malloc
mov dword [ebp-4H], eax
add esp, 4
test eax, eax
jnz ?_003
mov eax, dword [ebp-4H]
leave 
ret 
?_003:
xor ecx, ecx
mov edx, dword [ebp-4H]
mov dword [edx], ecx
mov dword [edx+4H], ecx
mov eax, edx
leave 
ret 
section '0' executable
_D10allocators13DartAllocator8allocateFPS10allocators13DartAllocator10StructDartkJbZPv:
enter 8, 0
push ebx
push esi
push edi
mov dword [ebp-4H], eax
xor ecx, ecx
mov byte [eax], cl
mov byte [eax], cl
mov edx, dword [ebp+0CH]
cmp dword [edx+4H], 0
jnz ?_006
call _D10allocators13DartAllocator13allocateFrameFZPS10allocators13DartAllocator11StructFrame
mov ebx, dword [ebp+0CH]
lea esi, [ebx+4H]
mov dword [esi], eax
mov dword [ebx], eax
cmp dword [esi], 0
jnz ?_006
xor eax, eax
pop edi
pop esi
pop ebx
leave 
ret 8
?_006:
mov ecx, dword [ebp+0CH]
mov edx, dword [ecx+4H]
mov ebx, dword [edx+4H]
cmp ebx, dword [ebp+8H]
jnc ?_008
mov dword [ebp-8H], 0
call _D10allocators13DartAllocator13allocateFrameFZPS10allocators13DartAllocator11StructFrame
mov dword [ebp-8H], eax
mov esi, dword [ebp+0CH]
cmp dword [esi+4H], 0
jnz ?_007
xor eax, eax
pop edi
pop esi
pop ebx
leave 
ret 8
?_007:
mov ecx, dword [ebp-8H]
mov edx, dword [ebp+0CH]
add edx, 4
mov ebx, dword [edx]
mov dword [ebx], ecx
mov dword [edx], ecx
?_008:
mov esi, dword [ebp+0CH]
add esi, 4
mov eax, dword [esi]
mov ecx, dword [eax+10H]
lea edx, [eax+8H]
add ecx, dword [edx]
mov ebx, dword [ebp+8H]
add dword [edx], ebx
mov edi, dword [esi]
sub dword [edi+4H], ebx
mov eax, dword [esi]
inc dword [eax+0CH]
mov esi, dword [ebp-4H]
mov byte [esi], 1
mov eax, ecx
pop edi
pop esi
pop ebx
leave 
ret 8
section '0' executable
_D10allocators13DartAllocator17freeDartAllocatorFPS10allocators13DartAllocator10StructDartZv:
enter 12, 0
mov dword [ebp-4H], eax
mov dword [ebp-0CH], 0
mov ecx, dword [eax]
mov dword [ebp-0CH], ecx
?_004:
mov dword [ebp-8H], 0
cmp dword [ebp-0CH], 0
jz ?_005
mov eax, dword [ebp-0CH]
mov dword [ebp-8H], eax
mov edx, dword [eax]
mov dword [ebp-0CH], edx
push dword [eax+10H]
call _free
push dword [ebp-8H]
call _free
add esp, 8
jmp ?_004
?_005:
push dword [ebp-4H]
call _free
add esp, 4
leave 
ret 
section '0' executable
_D10allocators13DartAllocator13allocateFrameFZPS10allocators13DartAllocator11StructFrame:
enter 4, 0
mov dword [ebp-4H], 0
push 20
call _malloc
mov dword [ebp-4H], eax
add esp, 4
test eax, eax
jnz ?_017
mov eax, dword [ebp-4H]
leave 
ret 
?_017:
push 524288
call _malloc
mov ecx, dword [ebp-4H]
mov dword [ecx+10H], eax
add esp, 4
test eax, eax
jnz ?_018
push dword [ebp-4H]
call _free
xor eax, eax
add esp, 4
leave 
ret 
?_018:
mov edx, dword [ebp-4H]
mov dword [edx], 0
mov dword [edx+4H], 524288
mov dword [edx+8H], 0
mov eax, edx
leave 
ret 
