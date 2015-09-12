; Disassembly of file: synth/Core.obj
; Mon Jun 09 00:19:29 2014
; Mode: 32 bits
; Syntax: YASM/NASM
; Instruction set: 80386, 80x87

; Error: symbol names contain illegal characters,
; 2 Symbol names not changed


global _D5synth4Core25StructParticleInformation6__initZ
global _D5synth4Core12__ModuleInfoZ
global _D5synth4Core15StructSynthCore6__initZ
global _D5synth4Core20StructPlayedParticle6__initZ
global _D39TypeInfo_E5synth4Core16EnumEnvelopeType6__initZ; Note: Communal.
global _D38TypeInfo_S5synth4Core15StructSynthCore6__initZ; Note: Communal.
global _D43TypeInfo_S5synth4Core20StructPlayedParticle6__initZ; Note: Communal.
global _D48TypeInfo_S5synth4Core25StructParticleInformation6__initZ; Note: Communal.
global _D5synth4Core25StructParticleInformation11__xopEqualsFKxSx80xa6xb7x80xa9xa9Zb; Note: Communal.
global _D5synth4Core12newSynthCoreFZPS5synth4Core15StructSynthCore; Note: Communal.
global _D5synth4Core13freeSynthCoreFPS5synth4Core15StructSynthCoreZv; Note: Communal.
global _D5synth4Core13queueParticleFPS5synth4Core15StructSynthCorekkffE5synth4Core16EnumEnvelopeTypeZv; Note: Communal.
global _D5synth4Core17samplesIntoBufferFPS5synth4Core15StructSynthCorePfkZv; Note: Communal.
global _D5synth4Core29calculateGaussianDistributionFfffZf; Note: Communal.

extern _malloc                                          ; near
extern _D4Math6sinCosFfJfJfZv                           ; near
extern _D10allocators13DartAllocator8allocateFPS10allocators13DartAllocator10StructDartkJbZPv ; near
extern _free                                            ; near
extern _D10allocators13DartAllocator16newDartAllocatorFZPS10allocators13DartAllocator10StructDart ; near
extern _D4Math3expFfZf                                  ; near
extern _D4Math4exp2FfZf                                 ; near
extern _D15TypeInfo_Struct6__vtblZ                      ; byte
extern _D10allocators13DartAllocator17freeDartAllocatorFPS10allocators13DartAllocator10StructDartZv ; near
extern _D10TypeInfo_i6__initZ                           ; byte
extern _D13TypeInfo_Enum6__vtblZ                        ; byte
extern _D10allocators13DartAllocator4freeFPS10allocators13DartAllocator10StructDartPvkZv ; near
extern _D5synth4Core29calculateGaussianDistributionFfffZf ; near
extern _D5synth4Core17samplesIntoBufferFPS5synth4Core15StructSynthCorePfkZv ; near
extern _D5synth4Core13queueParticleFPS5synth4Core15StructSynthCorekkffE5synth4Core16EnumEnvelopeTypeZv ; byte
extern _D5synth4Core13freeSynthCoreFPS5synth4Core15StructSynthCoreZv ; byte
extern _D5synth4Core12newSynthCoreFZPS5synth4Core15StructSynthCore ; byte
extern __fltused                                        ; byte
extern _D5synth4Core25StructParticleInformation11__xopEqualsFKxSx80xa6xb7x80xa9xa9Zb ; byte
extern _D48TypeInfo_S5synth4Core25StructParticleInformation6__initZ ; byte
extern _D43TypeInfo_S5synth4Core20StructPlayedParticle6__initZ ; byte
extern _D38TypeInfo_S5synth4Core15StructSynthCore6__initZ ; byte
extern _D39TypeInfo_E5synth4Core16EnumEnvelopeType6__initZ ; byte

FLAT    GROUP 


SECTION .TEXT   align=4 execute                         ; section number 1, code


SECTION .DATA   align=16 noexecute                      ; section number 2, data

?_001:                                                  ; byte
        db 73H, 79H, 6EH, 74H, 68H, 2EH, 43H, 6FH       ; 0000 _ synth.Co
        db 72H, 65H, 2EH, 45H, 6EH, 75H, 6DH, 45H       ; 0008 _ re.EnumE
        db 6EH, 76H, 65H, 6CH, 6FH, 70H, 65H, 54H       ; 0010 _ nvelopeT
        db 79H, 70H, 65H, 00H                           ; 0018 _ ype.

?_002:                                                  ; byte
        db 73H, 79H, 6EH, 74H, 68H, 2EH, 43H, 6FH       ; 001C _ synth.Co
        db 72H, 65H, 2EH, 53H, 74H, 72H, 75H, 63H       ; 0024 _ re.Struc
        db 74H, 53H, 79H, 6EH, 74H, 68H, 43H, 6FH       ; 002C _ tSynthCo
        db 72H, 65H, 00H                                ; 0034 _ re.

?_003:                                                  ; byte
        db 73H, 79H, 6EH, 74H, 68H, 2EH, 43H, 6FH       ; 0037 _ synth.Co
        db 72H, 65H, 2EH, 53H, 74H, 72H, 75H, 63H       ; 003F _ re.Struc
        db 74H, 50H, 6CH, 61H, 79H, 65H, 64H, 50H       ; 0047 _ tPlayedP
        db 61H, 72H, 74H, 69H, 63H, 6CH, 65H, 00H       ; 004F _ article.

?_004:                                                  ; byte
        db 73H, 79H, 6EH, 74H, 68H, 2EH, 43H, 6FH       ; 0057 _ synth.Co
        db 72H, 65H, 2EH, 53H, 74H, 72H, 75H, 63H       ; 005F _ re.Struc
        db 74H, 50H, 61H, 72H, 74H, 69H, 63H, 6CH       ; 0067 _ tParticl
        db 65H, 49H, 6EH, 66H, 6FH, 72H, 6DH, 61H       ; 006F _ eInforma
        db 74H, 69H, 6FH, 6EH, 00H, 00H, 00H, 00H       ; 0077 _ tion....
        db 00H                                          ; 007F _ .

_D5synth4Core25StructParticleInformation6__initZ:       ; byte
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 0080 _ ........
        db 00H, 00H, 00H, 00H, 00H, 00H, 0E0H, 7FH      ; 0088 _ ........
        db 00H, 00H, 0E0H, 7FH, 00H, 00H, 00H, 00H      ; 0090 _ ........

?_005:  dd 7FA00000H                                    ; 0098 _ 1.#QNAN 

?_006:  dd 3F000000H                                    ; 009C _ 0.5 

?_007:  dd 40490625H                                    ; 00A0 _ 3.141 

?_008:  dd 3E4CCCCDH                                    ; 00A4 _ 1045220557 

?_009:  dd 40000000H                                    ; 00A8 _ 2.0 

?_010:  dd 0C1000000H                                   ; 00AC _ -8.0 

?_011:                                                  ; switch/case jump table
        dd _D5synth4Core17samplesIntoBufferFPS5synth4Core15StructSynthCorePfkZv+164H; 00B0 _ 00000164 (segrel)
        dd _D5synth4Core17samplesIntoBufferFPS5synth4Core15StructSynthCorePfkZv+170H; 00B4 _ 00000170 (segrel)
        dd _D5synth4Core17samplesIntoBufferFPS5synth4Core15StructSynthCorePfkZv+18CH; 00B8 _ 0000018C (segrel)
        dd _D5synth4Core17samplesIntoBufferFPS5synth4Core15StructSynthCorePfkZv+200H; 00BC _ 00000200 (segrel)
        dd _D5synth4Core17samplesIntoBufferFPS5synth4Core15StructSynthCorePfkZv+219H; 00C0 _ 00000219 (segrel)

?_012:  dd 3F3504F7H                                    ; 00C4 _ 0.70710701 

?_013:  dd 0BF000000H, 00000000H                        ; 00C8 _ -0.5 0.0 

_D5synth4Core12__ModuleInfoZ:                           ; byte
        db 04H, 10H, 00H, 00H, 00H, 00H, 00H, 00H       ; 00D0 _ ........
        db 73H, 79H, 6EH, 74H, 68H, 2EH, 43H, 6FH       ; 00D8 _ synth.Co
        db 72H, 65H, 00H                                ; 00E0 _ re.


SECTION CONST   align=16 noexecute                      ; section number 3, const


SECTION .BSS    align=16 noexecute                      ; section number 4, bss

_D5synth4Core15StructSynthCore6__initZ:                 ; byte
        resb    16                                      ; 0000

_D5synth4Core20StructPlayedParticle6__initZ:            ; byte
        resb    12                                      ; 0010


SECTION FMB     align=4 noexecute                       ; section number 5, data


SECTION FM      align=4 noexecute                       ; section number 6, data

        dd FLAT:_D5synth4Core12__ModuleInfoZ            ; 0000 _ 000000D0 (segrel)


SECTION FME     align=4 noexecute                       ; section number 7, data


SECTION .text$_D39TypeInfo_E5synth4Core16EnumEnvelopeType6__initZ align=16 noexecute ; section number 8, data
;  Communal section not supported by YASM

_D39TypeInfo_E5synth4Core16EnumEnvelopeType6__initZ:    ; byte
        dd FLAT:_D13TypeInfo_Enum6__vtblZ               ; 0000 _ 00000000 (segrel)
        dd 00000000H                                    ; 0004 _ 0 
        dd FLAT:_D10TypeInfo_i6__initZ                  ; 0008 _ 00000000 (segrel)
        dd 0000001BH                                    ; 000C _ 27 
        dd FLAT:?_001                                   ; 0010 _ 00000000 (segrel)
        dd 00000000H, 00000000H                         ; 0014 _ 0 0 


SECTION .text$_D38TypeInfo_S5synth4Core15StructSynthCore6__initZ align=16 noexecute ; section number 9, data
;  Communal section not supported by YASM

_D38TypeInfo_S5synth4Core15StructSynthCore6__initZ:     ; byte
        dd FLAT:_D15TypeInfo_Struct6__vtblZ             ; 0000 _ 00000000 (segrel)
        dd 00000000H, 0000001AH                         ; 0004 _ 0 26 
        dd FLAT:?_002                                   ; 000C _ 0000001C (segrel)
        dd 00000010H, 00000000H                         ; 0010 _ 16 0 
        dd 00000000H, 00000000H                         ; 0018 _ 0 0 
        dd 00000000H, 00000000H                         ; 0020 _ 0 0 
        dd 00000001H, 00000000H                         ; 0028 _ 1 0 
        dd 00000000H, 00000004H                         ; 0030 _ 0 4 
        dd 12345678H                                    ; 0038 _ 305419896 


SECTION .text$_D43TypeInfo_S5synth4Core20StructPlayedParticle6__initZ align=16 noexecute ; section number 10, data
;  Communal section not supported by YASM

_D43TypeInfo_S5synth4Core20StructPlayedParticle6__initZ: ; byte
        dd FLAT:_D15TypeInfo_Struct6__vtblZ             ; 0000 _ 00000000 (segrel)
        dd 00000000H, 0000001FH                         ; 0004 _ 0 31 
        dd FLAT:?_003                                   ; 000C _ 00000037 (segrel)
        dd 0000000CH, 00000000H                         ; 0010 _ 12 0 
        dd 00000000H, 00000000H                         ; 0018 _ 0 0 
        dd 00000000H, 00000000H                         ; 0020 _ 0 0 
        dd 00000001H, 00000000H                         ; 0028 _ 1 0 
        dd 00000000H, 00000004H                         ; 0030 _ 0 4 
        dd 12345678H                                    ; 0038 _ 305419896 


SECTION .text$_D48TypeInfo_S5synth4Core25StructParticleInformation6__initZ align=16 noexecute ; section number 11, data
;  Communal section not supported by YASM

_D48TypeInfo_S5synth4Core25StructParticleInformation6__initZ: ; byte
        dd FLAT:_D15TypeInfo_Struct6__vtblZ             ; 0000 _ 00000000 (segrel)
        dd 00000000H, 00000024H                         ; 0004 _ 0 36 
        dd FLAT:?_004                                   ; 000C _ 00000057 (segrel)
        dd 00000018H                                    ; 0010 _ 24 
        dd FLAT:_D5synth4Core25StructParticleInformation6__initZ; 0014 _ 00000080 (segrel)
        dd 00000000H                                    ; 0018 _ 0 
        dd FLAT:_D5synth4Core25StructParticleInformation11__xopEqualsFKxSx80xa6xb7x80xa9xa9Zb; 001C _ 00000000 (segrel)
        dd 00000000H, 00000000H                         ; 0020 _ 0 0 
        dd 00000001H, 00000000H                         ; 0028 _ 1 0 
        dd 00000000H, 00000004H                         ; 0030 _ 0 4 
        dd 12345678H                                    ; 0038 _ 305419896 


SECTION .text$_D5synth4Core25StructParticleInformation11__xopEqualsFKxSx80xa6xb7x80xa9xa9Zb align=4 execute ; section number 12, code
;  Communal section not supported by YASM

_D5synth4Core25StructParticleInformation11__xopEqualsFKxSx80xa6xb7x80xa9xa9Zb:; Function begin, communal
        enter   4, 0                                    ; 0000 _ C8, 0004, 00
        push    ebx                                     ; 0004 _ 53
        push    esi                                     ; 0005 _ 56
        mov     dword [ebp-4H], eax                     ; 0006 _ 89. 45, FC
        mov     ecx, dword [ebp+8H]                     ; 0009 _ 8B. 4D, 08
        mov     edx, dword [ecx]                        ; 000C _ 8B. 11
        cmp     edx, dword [eax]                        ; 000E _ 3B. 10
        jnz     ?_014                                   ; 0010 _ 75, 3C
        mov     ebx, dword [ecx+4H]                     ; 0012 _ 8B. 59, 04
        cmp     ebx, dword [eax+4H]                     ; 0015 _ 3B. 58, 04
        jnz     ?_014                                   ; 0018 _ 75, 34
        mov     esi, dword [ecx+8H]                     ; 001A _ 8B. 71, 08
        cmp     esi, dword [eax+8H]                     ; 001D _ 3B. 70, 08
        jnz     ?_014                                   ; 0020 _ 75, 2C
        fld     dword [ecx+0CH]                         ; 0022 _ D9. 41, 0C
        fld     dword [eax+0CH]                         ; 0025 _ D9. 40, 0C
        fucompp                                         ; 0028 _ DA. E9
        fnstsw  ax                                      ; 002A _ DF. E0
        sahf                                            ; 002C _ 9E
        jnz     ?_014                                   ; 002D _ 75, 1F
        jpe     ?_014                                   ; 002F _ 7A, 1D
        fld     dword [ecx+10H]                         ; 0031 _ D9. 41, 10
        mov     eax, dword [ebp-4H]                     ; 0034 _ 8B. 45, FC
        fld     dword [eax+10H]                         ; 0037 _ D9. 40, 10
        fucompp                                         ; 003A _ DA. E9
        fnstsw  ax                                      ; 003C _ DF. E0
        sahf                                            ; 003E _ 9E
        jnz     ?_014                                   ; 003F _ 75, 0D
        jpe     ?_014                                   ; 0041 _ 7A, 0B
        mov     ecx, dword [ecx+14H]                    ; 0043 _ 8B. 49, 14
        mov     edx, dword [ebp-4H]                     ; 0046 _ 8B. 55, FC
        cmp     ecx, dword [edx+14H]                    ; 0049 _ 3B. 4A, 14
        jz      ?_015                                   ; 004C _ 74, 04
?_014:  xor     eax, eax                                ; 004E _ 31. C0
        jmp     ?_016                                   ; 0050 _ EB, 05

?_015:  mov     eax, 1                                  ; 0052 _ B8, 00000001
?_016:  pop     esi                                     ; 0057 _ 5E
        pop     ebx                                     ; 0058 _ 5B
        leave                                           ; 0059 _ C9
        ret     4                                       ; 005A _ C2, 0004
; _D5synth4Core25StructParticleInformation11__xopEqualsFKxSx80xa6xb7x80xa9xa9Zb End of function


SECTION .text$_D5synth4Core12newSynthCoreFZPS5synth4Core15StructSynthCore align=4 execute ; section number 13, code
;  Communal section not supported by YASM

_D5synth4Core12newSynthCoreFZPS5synth4Core15StructSynthCore:; Function begin, communal
        enter   16, 0                                   ; 0000 _ C8, 0010, 00
        push    ebx                                     ; 0004 _ 53
        push    esi                                     ; 0005 _ 56
        mov     dword [ebp-10H], 0                      ; 0006 _ C7. 45, F0, 00000000
        push    16                                      ; 000D _ 6A, 10
        call    _malloc                                 ; 000F _ E8, 00000000(rel)
        mov     dword [ebp-10H], eax                    ; 0014 _ 89. 45, F0
        add     esp, 4                                  ; 0017 _ 83. C4, 04
        test    eax, eax                                ; 001A _ 85. C0
        jnz     ?_017                                   ; 001C _ 75, 07
        mov     eax, dword [ebp-10H]                    ; 001E _ 8B. 45, F0
        pop     esi                                     ; 0021 _ 5E
        pop     ebx                                     ; 0022 _ 5B
        leave                                           ; 0023 _ C9
        ret                                             ; 0024 _ C3

?_017:  xor     ecx, ecx                                ; 0025 _ 31. C9
        mov     edx, dword [ebp-10H]                    ; 0027 _ 8B. 55, F0
        mov     dword [edx+0CH], ecx                    ; 002A _ 89. 4A, 0C
        mov     dword [edx+8H], ecx                     ; 002D _ 89. 4A, 08
        push    1200                                    ; 0030 _ 68, 000004B0
        call    _malloc                                 ; 0035 _ E8, 00000000(rel)
        mov     ebx, dword [ebp-10H]                    ; 003A _ 8B. 5D, F0
        mov     dword [ebx+4H], eax                     ; 003D _ 89. 43, 04
        add     esp, 4                                  ; 0040 _ 83. C4, 04
        test    eax, eax                                ; 0043 _ 85. C0
        jnz     ?_018                                   ; 0045 _ 75, 16
        push    dword [ebp-10H]                         ; 0047 _ FF. 75, F0
        call    _free                                   ; 004A _ E8, 00000000(rel)
        xor     esi, esi                                ; 004F _ 31. F6
        mov     dword [ebp-10H], esi                    ; 0051 _ 89. 75, F0
        mov     eax, esi                                ; 0054 _ 89. F0
        add     esp, 4                                  ; 0056 _ 83. C4, 04
        pop     esi                                     ; 0059 _ 5E
        pop     ebx                                     ; 005A _ 5B
        leave                                           ; 005B _ C9
        ret                                             ; 005C _ C3

?_018:  mov     dword [ebp-0CH], 0                      ; 005D _ C7. 45, F4, 00000000
        mov     dword [ebp-8H], 100                     ; 0064 _ C7. 45, F8, 00000064
?_019:  mov     ecx, dword [ebp-0CH]                    ; 006B _ 8B. 4D, F4
        cmp     ecx, dword [ebp-8H]                     ; 006E _ 3B. 4D, F8
        jge     ?_020                                   ; 0071 _ 7D, 22
        mov     edx, dword [ebp-0CH]                    ; 0073 _ 8B. 55, F4
        mov     dword [ebp-4H], edx                     ; 0076 _ 89. 55, FC
        mov     ebx, dword [ebp-4H]                     ; 0079 _ 8B. 5D, FC
        lea     esi, [ebx+ebx*2]                        ; 007C _ 8D. 34 5B
        lea     esi, [esi*4]                            ; 007F _ 8D. 34 B5, 00000000
        mov     eax, dword [ebp-10H]                    ; 0086 _ 8B. 45, F0
        mov     ecx, dword [eax+4H]                     ; 0089 _ 8B. 48, 04
        mov     byte [esi+ecx], 0                       ; 008C _ C6. 04 0E, 00
        inc     dword [ebp-0CH]                         ; 0090 _ FF. 45, F4
        jmp     ?_019                                   ; 0093 _ EB, D6

?_020:  call    _D10allocators13DartAllocator16newDartAllocatorFZPS10allocators13DartAllocator10StructDart; 0095 _ E8, 00000000(rel)
        mov     edx, dword [ebp-10H]                    ; 009A _ 8B. 55, F0
        mov     dword [edx], eax                        ; 009D _ 89. 02
        test    eax, eax                                ; 009F _ 85. C0
        jnz     ?_021                                   ; 00A1 _ 75, 1F
        mov     ebx, dword [ebp-10H]                    ; 00A3 _ 8B. 5D, F0
        push    dword [ebx+4H]                          ; 00A6 _ FF. 73, 04
        call    _free                                   ; 00A9 _ E8, 00000000(rel)
        push    ebx                                     ; 00AE _ 53
        call    _free                                   ; 00AF _ E8, 00000000(rel)
        xor     esi, esi                                ; 00B4 _ 31. F6
        mov     dword [ebp-10H], esi                    ; 00B6 _ 89. 75, F0
        mov     eax, esi                                ; 00B9 _ 89. F0
        add     esp, 8                                  ; 00BB _ 83. C4, 08
        pop     esi                                     ; 00BE _ 5E
        pop     ebx                                     ; 00BF _ 5B
        leave                                           ; 00C0 _ C9
        ret                                             ; 00C1 _ C3

?_021:  mov     eax, dword [ebp-10H]                    ; 00C2 _ 8B. 45, F0
        pop     esi                                     ; 00C5 _ 5E
        pop     ebx                                     ; 00C6 _ 5B
        leave                                           ; 00C7 _ C9
        ret                                             ; 00C8 _ C3
; _D5synth4Core12newSynthCoreFZPS5synth4Core15StructSynthCore End of function


SECTION .text$_D5synth4Core13freeSynthCoreFPS5synth4Core15StructSynthCoreZv align=4 execute ; section number 14, code
;  Communal section not supported by YASM

_D5synth4Core13freeSynthCoreFPS5synth4Core15StructSynthCoreZv:; Function begin, communal
        enter   4, 0                                    ; 0000 _ C8, 0004, 00
        mov     dword [ebp-4H], eax                     ; 0004 _ 89. 45, FC
        mov     eax, dword [eax]                        ; 0007 _ 8B. 00
        call    _D10allocators13DartAllocator17freeDartAllocatorFPS10allocators13DartAllocator10StructDartZv; 0009 _ E8, 00000000(rel)
        mov     ecx, dword [ebp-4H]                     ; 000E _ 8B. 4D, FC
        push    dword [ecx+4H]                          ; 0011 _ FF. 71, 04
        call    _free                                   ; 0014 _ E8, 00000000(rel)
        push    dword [ebp-4H]                          ; 0019 _ FF. 75, FC
        call    _free                                   ; 001C _ E8, 00000000(rel)
        add     esp, 8                                  ; 0021 _ 83. C4, 08
        leave                                           ; 0024 _ C9
        ret                                             ; 0025 _ C3
; _D5synth4Core13freeSynthCoreFPS5synth4Core15StructSynthCoreZv End of function


SECTION .text$_D5synth4Core13queueParticleFPS5synth4Core15StructSynthCorekkffE5synth4Core16EnumEnvelopeTypeZv align=4 execute ; section number 15, code
;  Communal section not supported by YASM

_D5synth4Core13queueParticleFPS5synth4Core15StructSynthCorekkffE5synth4Core16EnumEnvelopeTypeZv:; Function begin, communal
        enter   12, 0                                   ; 0000 _ C8, 000C, 00
        push    ebx                                     ; 0004 _ 53
        push    esi                                     ; 0005 _ 56
        mov     dword [ebp-4H], eax                     ; 0006 _ 89. 45, FC
        xor     ecx, ecx                                ; 0009 _ 31. C9
        mov     dword [ebp-0CH], ecx                    ; 000B _ 89. 4D, F4
        mov     byte [ebp-8H], cl                       ; 000E _ 88. 4D, F8
        mov     edx, dword [ebp+18H]                    ; 0011 _ 8B. 55, 18
        push    dword [edx]                             ; 0014 _ FF. 32
        push    24                                      ; 0016 _ 6A, 18
        lea     eax, [ebp-8H]                           ; 0018 _ 8D. 45, F8
        call    _D10allocators13DartAllocator8allocateFPS10allocators13DartAllocator10StructDartkJbZPv; 001B _ E8, 00000000(rel)
        mov     dword [ebp-0CH], eax                    ; 0020 _ 89. 45, F4
        mov     dword [eax], 0                          ; 0023 _ C7. 00, 00000000
        mov     ebx, dword [ebp+14H]                    ; 0029 _ 8B. 5D, 14
        mov     dword [eax+4H], ebx                     ; 002C _ 89. 58, 04
        mov     esi, dword [ebp+10H]                    ; 002F _ 8B. 75, 10
        mov     dword [eax+8H], esi                     ; 0032 _ 89. 70, 08
        fld     dword [ebp+0CH]                         ; 0035 _ D9. 45, 0C
        fstp    dword [eax+0CH]                         ; 0038 _ D9. 58, 0C
        fld     dword [ebp+8H]                          ; 003B _ D9. 45, 08
        fstp    dword [eax+10H]                         ; 003E _ D9. 58, 10
        mov     ecx, dword [ebp-4H]                     ; 0041 _ 8B. 4D, FC
        mov     dword [eax+14H], ecx                    ; 0044 _ 89. 48, 14
        mov     edx, dword [ebp+18H]                    ; 0047 _ 8B. 55, 18
        cmp     dword [edx+0CH], 0                      ; 004A _ 83. 7A, 0C, 00
        jnz     ?_022                                   ; 004E _ 75, 0E
        mov     eax, dword [ebp-0CH]                    ; 0050 _ 8B. 45, F4
        mov     ebx, dword [ebp+18H]                    ; 0053 _ 8B. 5D, 18
        mov     dword [ebx+8H], eax                     ; 0056 _ 89. 43, 08
        mov     dword [ebx+0CH], eax                    ; 0059 _ 89. 43, 0C
        jmp     ?_023                                   ; 005C _ EB, 0F

?_022:  mov     esi, dword [ebp-0CH]                    ; 005E _ 8B. 75, F4
        mov     ecx, dword [ebp+18H]                    ; 0061 _ 8B. 4D, 18
        add     ecx, 8                                  ; 0064 _ 83. C1, 08
        mov     edx, dword [ecx]                        ; 0067 _ 8B. 11
        mov     dword [edx], esi                        ; 0069 _ 89. 32
        mov     dword [ecx], esi                        ; 006B _ 89. 31
?_023:  pop     esi                                     ; 006D _ 5E
        pop     ebx                                     ; 006E _ 5B
        leave                                           ; 006F _ C9
        ret     20                                      ; 0070 _ C2, 0014
; _D5synth4Core13queueParticleFPS5synth4Core15StructSynthCorekkffE5synth4Core16EnumEnvelopeTypeZv End of function


SECTION .text$_D5synth4Core17samplesIntoBufferFPS5synth4Core15StructSynthCorePfkZv align=4 execute ; section number 16, code
;  Communal section not supported by YASM

_D5synth4Core17samplesIntoBufferFPS5synth4Core15StructSynthCorePfkZv:; Function begin, communal
        enter   140, 0                                  ; 0000 _ C8, 008C, 00
        push    ebx                                     ; 0004 _ 53
        push    esi                                     ; 0005 _ 56
        push    edi                                     ; 0006 _ 57
        fld     dword [?_005]                           ; 0007 _ D9. 05, 00000098(segrel)
        fstp    dword [ebp-74H]                         ; 000D _ D9. 5D, 8C
        xor     ecx, ecx                                ; 0010 _ 31. C9
        mov     dword [ebp-70H], ecx                    ; 0012 _ 89. 4D, 90
        mov     dword [ebp-6CH], ecx                    ; 0015 _ 89. 4D, 94
        mov     dword [ebp-68H], eax                    ; 0018 _ 89. 45, 98
?_024:  mov     eax, dword [ebp-6CH]                    ; 001B _ 8B. 45, 94
        cmp     eax, dword [ebp-68H]                    ; 001E _ 3B. 45, 98
        jnc     ?_045                                   ; 0021 _ 0F 83, 00000446
        mov     edx, dword [ebp-6CH]                    ; 0027 _ 8B. 55, 94
        mov     dword [ebp-64H], edx                    ; 002A _ 89. 55, 9C
        mov     dword [ebp-70H], 0                      ; 002D _ C7. 45, 90, 00000000
        mov     dword [ebp-60H], 0                      ; 0034 _ C7. 45, A0, 00000000
        mov     dword [ebp-5CH], 100                    ; 003B _ C7. 45, A4, 00000064
?_025:  mov     ebx, dword [ebp-60H]                    ; 0042 _ 8B. 5D, A0
        cmp     ebx, dword [ebp-5CH]                    ; 0045 _ 3B. 5D, A4
        jge     ?_026                                   ; 0048 _ 7D, 29
        mov     esi, dword [ebp-60H]                    ; 004A _ 8B. 75, A0
        mov     dword [ebp-58H], esi                    ; 004D _ 89. 75, A8
        mov     ecx, dword [ebp-58H]                    ; 0050 _ 8B. 4D, A8
        lea     eax, [ecx+ecx*2]                        ; 0053 _ 8D. 04 49
        lea     eax, [eax*4]                            ; 0056 _ 8D. 04 85, 00000000
        mov     edx, dword [ebp+0CH]                    ; 005D _ 8B. 55, 0C
        mov     ebx, dword [edx+4H]                     ; 0060 _ 8B. 5A, 04
        mov     cl, byte [eax+ebx]                      ; 0063 _ 8A. 0C 18
        xor     cl, 01H                                 ; 0066 _ 80. F1, 01
        jnz     ?_026                                   ; 0069 _ 75, 08
        inc     dword [ebp-70H]                         ; 006B _ FF. 45, 90
        inc     dword [ebp-60H]                         ; 006E _ FF. 45, A0
        jmp     ?_025                                   ; 0071 _ EB, CF

?_026:  mov     dword [ebp-74H], 0                      ; 0073 _ C7. 45, 8C, 00000000
        mov     dword [ebp-54H], 0                      ; 007A _ C7. 45, AC, 00000000
        mov     esi, dword [ebp-70H]                    ; 0081 _ 8B. 75, 90
        mov     dword [ebp-50H], esi                    ; 0084 _ 89. 75, B0
?_027:  mov     eax, dword [ebp-54H]                    ; 0087 _ 8B. 45, AC
        cmp     eax, dword [ebp-50H]                    ; 008A _ 3B. 45, B0
        jnc     ?_030                                   ; 008D _ 0F 83, 000001F0
        mov     edx, dword [ebp-54H]                    ; 0093 _ 8B. 55, AC
        mov     dword [ebp-4CH], edx                    ; 0096 _ 89. 55, B4
        fld     dword [?_005]                           ; 0099 _ D9. 05, 00000098(segrel)
        fstp    dword [ebp-48H]                         ; 009F _ D9. 5D, B8
        fld     dword [?_005]                           ; 00A2 _ D9. 05, 00000098(segrel)
        fstp    dword [ebp-44H]                         ; 00A8 _ D9. 5D, BC
        fld     dword [?_005]                           ; 00AB _ D9. 05, 00000098(segrel)
        fstp    dword [ebp-40H]                         ; 00B1 _ D9. 5D, C0
        fld     dword [?_005]                           ; 00B4 _ D9. 05, 00000098(segrel)
        fstp    dword [ebp-3CH]                         ; 00BA _ D9. 5D, C4
        fld     dword [?_005]                           ; 00BD _ D9. 05, 00000098(segrel)
        fstp    dword [ebp-38H]                         ; 00C3 _ D9. 5D, C8
        fld     dword [?_005]                           ; 00C6 _ D9. 05, 00000098(segrel)
        fstp    dword [ebp-34H]                         ; 00CC _ D9. 5D, CC
        fld     dword [?_005]                           ; 00CF _ D9. 05, 00000098(segrel)
        fstp    dword [ebp-30H]                         ; 00D5 _ D9. 5D, D0
        fld     dword [?_005]                           ; 00D8 _ D9. 05, 00000098(segrel)
        fstp    dword [ebp-2CH]                         ; 00DE _ D9. 5D, D4
        fld     dword [?_005]                           ; 00E1 _ D9. 05, 00000098(segrel)
        fstp    dword [ebp-28H]                         ; 00E7 _ D9. 5D, D8
        fld     dword [?_005]                           ; 00EA _ D9. 05, 00000098(segrel)
        fstp    dword [ebp-24H]                         ; 00F0 _ D9. 5D, DC
        lea     ebx, [edx+edx*2]                        ; 00F3 _ 8D. 1C 52
        lea     ebx, [ebx*4]                            ; 00F6 _ 8D. 1C 9D, 00000000
        mov     ecx, dword [ebp+0CH]                    ; 00FD _ 8B. 4D, 0C
        add     ebx, dword [ecx+4H]                     ; 0100 _ 03. 59, 04
        mov     esi, dword [ebx+4H]                     ; 0103 _ 8B. 73, 04
        fld     dword [esi+0CH]                         ; 0106 _ D9. 46, 0C
        fstp    dword [ebp-38H]                         ; 0109 _ D9. 5D, C8
        fld     dword [esi+10H]                         ; 010C _ D9. 46, 10
        fstp    dword [ebp-34H]                         ; 010F _ D9. 5D, CC
        mov     eax, dword [ebx+8H]                     ; 0112 _ 8B. 43, 08
        mov     dword [ebp-84H], eax                    ; 0115 _ 89. 85, FFFFFF7C
        xor     edx, edx                                ; 011B _ 31. D2
        mov     dword [ebp-80H], edx                    ; 011D _ 89. 55, 80
        fild    qword [ebp-84H]                         ; 0120 _ DF. AD, FFFFFF7C
        mov     ebx, dword [esi+8H]                     ; 0126 _ 8B. 5E, 08
        mov     dword [ebp-84H], ebx                    ; 0129 _ 89. 9D, FFFFFF7C
        mov     dword [ebp-80H], edx                    ; 012F _ 89. 55, 80
        fild    qword [ebp-84H]                         ; 0132 _ DF. AD, FFFFFF7C
        fdivp   st1, st(0)                              ; 0138 _ DE. F9
        fstp    dword [ebp-40H]                         ; 013A _ D9. 5D, C0
        fld     dword [ebp-40H]                         ; 013D _ D9. 45, C0
        fsub    dword [?_006]                           ; 0140 _ D8. 25, 0000009C(segrel)
        fadd    st0, st(0)                              ; 0146 _ DC. C0
        fmul    dword [?_007]                           ; 0148 _ D8. 0D, 000000A0(segrel)
        fstp    dword [ebp-28H]                         ; 014E _ D9. 5D, D8
        mov     edi, dword [esi+14H]                    ; 0151 _ 8B. 7E, 14
        cmp     edi, 4                                  ; 0154 _ 83. FF, 04
        ja      ?_029                                   ; 0157 _ 0F 87, 000000D7
        jmp     near [?_011+edi*4]                      ; 015D _ FF. 24 BD, 000000B0(segrel)

; Note: Inaccessible code
        mov     dword [ebp-2CH], 1065353216             ; 0164 _ C7. 45, D4, 3F800000
        jmp     ?_029                                   ; 016B _ E9, 000000C4

; Note: Inaccessible code
        push    dword [ebp-40H]                         ; 0170 _ FF. 75, C0
        push    dword [?_006]                           ; 0173 _ FF. 35, 0000009C(segrel)
        push    dword [?_008]                           ; 0179 _ FF. 35, 000000A4(segrel)
        call    _D5synth4Core29calculateGaussianDistributionFfffZf; 017F _ E8, 00000000(rel)
        fstp    dword [ebp-2CH]                         ; 0184 _ D9. 5D, D4
        jmp     ?_029                                   ; 0187 _ E9, 000000A8

; Note: Inaccessible code
        mov     ecx, dword [ebp-4CH]                    ; 018C _ 8B. 4D, B4
        lea     eax, [ecx+ecx*2]                        ; 018F _ 8D. 04 49
        lea     eax, [eax*4]                            ; 0192 _ 8D. 04 85, 00000000
        mov     edx, dword [ebp+0CH]                    ; 0199 _ 8B. 55, 0C
        add     eax, dword [edx+4H]                     ; 019C _ 03. 42, 04
        mov     ebx, dword [eax+4H]                     ; 019F _ 8B. 58, 04
        mov     esi, dword [ebx+8H]                     ; 01A2 _ 8B. 73, 08
        mov     dword [ebp-84H], esi                    ; 01A5 _ 89. B5, FFFFFF7C
        xor     ecx, ecx                                ; 01AB _ 31. C9
        mov     dword [ebp-80H], ecx                    ; 01AD _ 89. 4D, 80
        fild    qword [ebp-84H]                         ; 01B0 _ DF. AD, FFFFFF7C
        fdiv    dword [?_009]                           ; 01B6 _ D8. 35, 000000A8(segrel)
        mov     eax, dword [eax+8H]                     ; 01BC _ 8B. 40, 08
        mov     dword [ebp-84H], eax                    ; 01BF _ 89. 85, FFFFFF7C
        mov     dword [ebp-80H], ecx                    ; 01C5 _ 89. 4D, 80
        fild    qword [ebp-84H]                         ; 01C8 _ DF. AD, FFFFFF7C
        fucompp                                         ; 01CE _ DA. E9
        fnstsw  ax                                      ; 01D0 _ DF. E0
        sahf                                            ; 01D2 _ 9E
        jnz     ?_028                                   ; 01D3 _ 75, 0B
        jpe     ?_028                                   ; 01D5 _ 7A, 09
        mov     dword [ebp-2CH], 1065353216             ; 01D7 _ C7. 45, D4, 3F800000
        jmp     ?_029                                   ; 01DE _ EB, 54

?_028:  fld     dword [ebp-28H]                         ; 01E0 _ D9. 45, D8
        fstp    dword [ebp-24H]                         ; 01E3 _ D9. 5D, DC
        push    dword [ebp-24H]                         ; 01E6 _ FF. 75, DC
        lea     edx, [ebp-48H]                          ; 01E9 _ 8D. 55, B8
        push    edx                                     ; 01EC _ 52
        lea     eax, [ebp-44H]                          ; 01ED _ 8D. 45, BC
        call    _D4Math6sinCosFfJfJfZv                  ; 01F0 _ E8, 00000000(rel)
        fld     dword [ebp-48H]                         ; 01F5 _ D9. 45, B8
        fdiv    dword [ebp-24H]                         ; 01F8 _ D8. 75, DC
        fstp    dword [ebp-2CH]                         ; 01FB _ D9. 5D, D4
        jmp     ?_029                                   ; 01FE _ EB, 34

; Note: Inaccessible code
        fld     dword [ebp-40H]                         ; 0200 _ D9. 45, C0
        fmul    dword [?_010]                           ; 0203 _ D8. 0D, 000000AC(segrel)
        sub     esp, 4                                  ; 0209 _ 83. EC, 04
        fstp    dword [esp]                             ; 020C _ D9. 1C 24
        call    _D4Math4exp2FfZf                        ; 020F _ E8, 00000000(rel)
        fstp    dword [ebp-2CH]                         ; 0214 _ D9. 5D, D4
        jmp     ?_029                                   ; 0217 _ EB, 1B

; Note: Inaccessible code
        fld     dword [ebp-40H]                         ; 0219 _ D9. 45, C0
        fld1                                            ; 021C _ D9. E8
        fsubrp  st1, st(0)                              ; 021E _ DE. E1
        fmul    dword [?_010]                           ; 0220 _ D8. 0D, 000000AC(segrel)
        sub     esp, 4                                  ; 0226 _ 83. EC, 04
        fstp    dword [esp]                             ; 0229 _ D9. 1C 24
        call    _D4Math4exp2FfZf                        ; 022C _ E8, 00000000(rel)
        fstp    dword [ebp-2CH]                         ; 0231 _ D9. 5D, D4
?_029:  fld     dword [ebp-40H]                         ; 0234 _ D9. 45, C0
        fstp    dword [ebp-3CH]                         ; 0237 _ D9. 5D, C4
        fld     dword [ebp-3CH]                         ; 023A _ D9. 45, C4
        fadd    st0, st(0)                              ; 023D _ DC. C0
        fmul    dword [?_007]                           ; 023F _ D8. 0D, 000000A0(segrel)
        fmul    dword [ebp-38H]                         ; 0245 _ D8. 4D, C8
        fstp    dword [ebp-3CH]                         ; 0248 _ D9. 5D, C4
        push    dword [ebp-3CH]                         ; 024B _ FF. 75, C4
        lea     ebx, [ebp-48H]                          ; 024E _ 8D. 5D, B8
        push    ebx                                     ; 0251 _ 53
        lea     eax, [ebp-44H]                          ; 0252 _ 8D. 45, BC
        call    _D4Math6sinCosFfJfJfZv                  ; 0255 _ E8, 00000000(rel)
        fld     dword [ebp-48H]                         ; 025A _ D9. 45, B8
        fstp    dword [ebp-30H]                         ; 025D _ D9. 5D, D0
        fld     dword [ebp-34H]                         ; 0260 _ D9. 45, CC
        fmul    dword [ebp-30H]                         ; 0263 _ D8. 4D, D0
        fstp    dword [ebp-30H]                         ; 0266 _ D9. 5D, D0
        fld     dword [ebp-2CH]                         ; 0269 _ D9. 45, D4
        fmul    dword [ebp-30H]                         ; 026C _ D8. 4D, D0
        fstp    dword [ebp-30H]                         ; 026F _ D9. 5D, D0
        fld     dword [ebp-30H]                         ; 0272 _ D9. 45, D0
        fadd    dword [ebp-74H]                         ; 0275 _ D8. 45, 8C
        fstp    dword [ebp-74H]                         ; 0278 _ D9. 5D, 8C
        inc     dword [ebp-54H]                         ; 027B _ FF. 45, AC
        jmp     ?_027                                   ; 027E _ E9, FFFFFE04

?_030:  mov     dword [ebp-20H], 0                      ; 0283 _ C7. 45, E0, 00000000
        mov     ecx, dword [ebp-70H]                    ; 028A _ 8B. 4D, 90
        mov     dword [ebp-1CH], ecx                    ; 028D _ 89. 4D, E4
?_031:  mov     edx, dword [ebp-20H]                    ; 0290 _ 8B. 55, E0
        cmp     edx, dword [ebp-1CH]                    ; 0293 _ 3B. 55, E4
        jnc     ?_032                                   ; 0296 _ 73, 1B
        mov     esi, dword [ebp-20H]                    ; 0298 _ 8B. 75, E0
        lea     ebx, [esi+esi*2]                        ; 029B _ 8D. 1C 76
        lea     ebx, [ebx*4]                            ; 029E _ 8D. 1C 9D, 00000000
        mov     eax, dword [ebp+0CH]                    ; 02A5 _ 8B. 45, 0C
        add     ebx, dword [eax+4H]                     ; 02A8 _ 03. 58, 04
        inc     dword [ebx+8H]                          ; 02AB _ FF. 43, 08
        inc     dword [ebp-20H]                         ; 02AE _ FF. 45, E0
        jmp     ?_031                                   ; 02B1 _ EB, DD

?_032:  fld     dword [ebp-74H]                         ; 02B3 _ D9. 45, 8C
        mov     ecx, dword [ebp-64H]                    ; 02B6 _ 8B. 4D, 9C
        mov     edx, dword [ebp+8H]                     ; 02B9 _ 8B. 55, 08
        fstp    dword [edx+ecx*4]                       ; 02BC _ D9. 1C 8A
        mov     dword [ebp-18H], 0                      ; 02BF _ C7. 45, E8, 00000000
?_033:  cmp     dword [ebp-18H], 100                    ; 02C6 _ 83. 7D, E8, 64
        jnc     ?_036                                   ; 02CA _ 0F 83, 000000C6
        mov     esi, dword [ebp-18H]                    ; 02D0 _ 8B. 75, E8
        lea     ebx, [esi+esi*2]                        ; 02D3 _ 8D. 1C 76
        lea     ebx, [ebx*4]                            ; 02D6 _ 8D. 1C 9D, 00000000
        mov     eax, dword [ebp+0CH]                    ; 02DD _ 8B. 45, 0C
        add     ebx, dword [eax+4H]                     ; 02E0 _ 03. 58, 04
        mov     cl, byte [ebx]                          ; 02E3 _ 8A. 0B
        xor     cl, 01H                                 ; 02E5 _ 80. F1, 01
        jne     ?_036                                   ; 02E8 _ 0F 85, 000000A8
        mov     edx, dword [ebx+8H]                     ; 02EE _ 8B. 53, 08
        mov     esi, dword [ebx+4H]                     ; 02F1 _ 8B. 73, 04
        cmp     dword [esi+8H], edx                     ; 02F4 _ 39. 56, 08
        setb    bl                                      ; 02F7 _ 0F 92. C3
        movzx   ebx, bl                                 ; 02FA _ 0F B6. DB
        test    bl, bl                                  ; 02FD _ 84. DB
        je      ?_035                                   ; 02FF _ 0F 84, 00000089
        mov     eax, dword [ebp+0CH]                    ; 0305 _ 8B. 45, 0C
        push    dword [eax]                             ; 0308 _ FF. 30
        mov     ecx, dword [ebp-18H]                    ; 030A _ 8B. 4D, E8
        lea     edx, [ecx+ecx*2]                        ; 030D _ 8D. 14 49
        lea     edx, [edx*4]                            ; 0310 _ 8D. 14 95, 00000000
        lea     esi, [eax+4H]                           ; 0317 _ 8D. 70, 04
        mov     ebx, dword [esi]                        ; 031A _ 8B. 1E
        lea     eax, [edx+ebx]                          ; 031C _ 8D. 04 1A
        push    dword [eax+4H]                          ; 031F _ FF. 70, 04
        mov     eax, 24                                 ; 0322 _ B8, 00000018
        mov     dword [ebp-88H], edx                    ; 0327 _ 89. 95, FFFFFF78
        call    _D10allocators13DartAllocator4freeFPS10allocators13DartAllocator10StructDartPvkZv; 032D _ E8, 00000000(rel)
        mov     ecx, dword [ebp-88H]                    ; 0332 _ 8B. 8D, FFFFFF78
        mov     edx, dword [esi]                        ; 0338 _ 8B. 16
        mov     byte [ecx+edx], 0                       ; 033A _ C6. 04 11, 00
        cmp     dword [ebp-18H], 99                     ; 033E _ 83. 7D, E8, 63
        jnz     ?_034                                   ; 0342 _ 75, 47
        mov     ebx, dword [ebp-18H]                    ; 0344 _ 8B. 5D, E8
        lea     esi, [ebx+1H]                           ; 0347 _ 8D. 73, 01
        lea     eax, [esi+esi*2]                        ; 034A _ 8D. 04 76
        lea     eax, [eax*4]                            ; 034D _ 8D. 04 85, 00000000
        mov     ecx, dword [ebp+0CH]                    ; 0354 _ 8B. 4D, 0C
        add     ecx, 4                                  ; 0357 _ 83. C1, 04
        mov     edx, dword [ecx]                        ; 035A _ 8B. 11
        mov     bl, byte [eax+edx]                      ; 035C _ 8A. 1C 10
        mov     esi, dword [ebp-18H]                    ; 035F _ 8B. 75, E8
        lea     edi, [esi+esi*2]                        ; 0362 _ 8D. 3C 76
        lea     edi, [edi*4]                            ; 0365 _ 8D. 3C BD, 00000000
        mov     byte [edi+edx], bl                      ; 036C _ 88. 1C 17
        mov     edx, dword [ecx]                        ; 036F _ 8B. 11
        lea     ebx, [eax+edx]                          ; 0371 _ 8D. 1C 10
        mov     esi, dword [ebx+4H]                     ; 0374 _ 8B. 73, 04
        lea     edx, [edi+edx]                          ; 0377 _ 8D. 14 17
        mov     dword [edx+4H], esi                     ; 037A _ 89. 72, 04
        mov     ecx, dword [ecx]                        ; 037D _ 8B. 09
        lea     eax, [eax+ecx]                          ; 037F _ 8D. 04 08
        mov     ebx, dword [eax+8H]                     ; 0382 _ 8B. 58, 08
        lea     esi, [edi+ecx]                          ; 0385 _ 8D. 34 0F
        mov     dword [esi+8H], ebx                     ; 0388 _ 89. 5E, 08
?_034:  dec     dword [ebp-18H]                         ; 038B _ FF. 4D, E8
?_035:  inc     dword [ebp-18H]                         ; 038E _ FF. 45, E8
        jmp     ?_033                                   ; 0391 _ E9, FFFFFF30

?_036:  mov     dword [ebp-14H], 0                      ; 0396 _ C7. 45, EC, 00000000
?_037:  mov     edx, dword [ebp+0CH]                    ; 039D _ 8B. 55, 0C
        add     edx, 12                                 ; 03A0 _ 83. C2, 0C
        mov     ecx, dword [edx]                        ; 03A3 _ 8B. 0A
        mov     dword [ebp-14H], ecx                    ; 03A5 _ 89. 4D, EC
        test    ecx, ecx                                ; 03A8 _ 85. C9
        je      ?_042                                   ; 03AA _ 0F 84, 00000099
        cmp     dword [ecx+4H], 0                       ; 03B0 _ 83. 79, 04, 00
        jne     ?_042                                   ; 03B4 _ 0F 85, 0000008F
        mov     eax, dword [ecx]                        ; 03BA _ 8B. 01
        mov     dword [edx], eax                        ; 03BC _ 89. 02
        test    eax, eax                                ; 03BE _ 85. C0
        jnz     ?_038                                   ; 03C0 _ 75, 0A
        mov     ebx, dword [ebp+0CH]                    ; 03C2 _ 8B. 5D, 0C
        mov     dword [ebx+8H], 0                       ; 03C5 _ C7. 43, 08, 00000000
?_038:  mov     dword [ebp-10H], 0                      ; 03CC _ C7. 45, F0, 00000000
        mov     dword [ebp-0CH], 100                    ; 03D3 _ C7. 45, F4, 00000064
?_039:  mov     esi, dword [ebp-10H]                    ; 03DA _ 8B. 75, F0
        cmp     esi, dword [ebp-0CH]                    ; 03DD _ 3B. 75, F4
        jge     ?_041                                   ; 03E0 _ 7D, 58
        mov     edx, dword [ebp-10H]                    ; 03E2 _ 8B. 55, F0
        mov     dword [ebp-8H], edx                     ; 03E5 _ 89. 55, F8
        mov     ecx, dword [ebp-8H]                     ; 03E8 _ 8B. 4D, F8
        lea     eax, [ecx+ecx*2]                        ; 03EB _ 8D. 04 49
        lea     eax, [eax*4]                            ; 03EE _ 8D. 04 85, 00000000
        mov     ebx, dword [ebp+0CH]                    ; 03F5 _ 8B. 5D, 0C
        mov     esi, dword [ebx+4H]                     ; 03F8 _ 8B. 73, 04
        mov     dl, byte [eax+esi]                      ; 03FB _ 8A. 14 30
        xor     dl, 01H                                 ; 03FE _ 80. F2, 01
        jz      ?_040                                   ; 0401 _ 74, 32
        mov     ecx, dword [ebp-8H]                     ; 0403 _ 8B. 4D, F8
        lea     eax, [ecx+ecx*2]                        ; 0406 _ 8D. 04 49
        lea     eax, [eax*4]                            ; 0409 _ 8D. 04 85, 00000000
        mov     ebx, dword [ebp+0CH]                    ; 0410 _ 8B. 5D, 0C
        add     ebx, 4                                  ; 0413 _ 83. C3, 04
        mov     esi, dword [ebx]                        ; 0416 _ 8B. 33
        mov     byte [eax+esi], 1                       ; 0418 _ C6. 04 30, 01
        mov     edx, dword [ebp-14H]                    ; 041C _ 8B. 55, EC
        mov     ecx, dword [ebx]                        ; 041F _ 8B. 0B
        lea     edi, [eax+ecx]                          ; 0421 _ 8D. 3C 08
        mov     dword [edi+4H], edx                     ; 0424 _ 89. 57, 04
        mov     ebx, dword [ebx]                        ; 0427 _ 8B. 1B
        lea     eax, [eax+ebx]                          ; 0429 _ 8D. 04 18
        mov     dword [eax+8H], 0                       ; 042C _ C7. 40, 08, 00000000
        jmp     ?_041                                   ; 0433 _ EB, 05

?_040:  inc     dword [ebp-10H]                         ; 0435 _ FF. 45, F0
        jmp     ?_039                                   ; 0438 _ EB, A0

?_041:  xor     edx, edx                                ; 043A _ 31. D2
        mov     ecx, dword [ebp-14H]                    ; 043C _ 8B. 4D, EC
        mov     dword [ecx], edx                        ; 043F _ 89. 11
        mov     dword [ebp-14H], edx                    ; 0441 _ 89. 55, EC
        jmp     ?_037                                   ; 0444 _ E9, FFFFFF54

?_042:  mov     esi, dword [ebp+0CH]                    ; 0449 _ 8B. 75, 0C
        mov     ebx, dword [esi+0CH]                    ; 044C _ 8B. 5E, 0C
        mov     dword [ebp-14H], ebx                    ; 044F _ 89. 5D, EC
?_043:  cmp     dword [ebp-14H], 0                      ; 0452 _ 83. 7D, EC, 00
        jz      ?_044                                   ; 0456 _ 74, 0D
        mov     eax, dword [ebp-14H]                    ; 0458 _ 8B. 45, EC
        dec     dword [eax+4H]                          ; 045B _ FF. 48, 04
        mov     edx, dword [eax]                        ; 045E _ 8B. 10
        mov     dword [ebp-14H], edx                    ; 0460 _ 89. 55, EC
        jmp     ?_043                                   ; 0463 _ EB, ED

?_044:  inc     dword [ebp-6CH]                         ; 0465 _ FF. 45, 94
        jmp     ?_024                                   ; 0468 _ E9, FFFFFBAE

?_045:  pop     edi                                     ; 046D _ 5F
        pop     esi                                     ; 046E _ 5E
        pop     ebx                                     ; 046F _ 5B
        leave                                           ; 0470 _ C9
        ret     8                                       ; 0471 _ C2, 0008
; _D5synth4Core17samplesIntoBufferFPS5synth4Core15StructSynthCorePfkZv End of function


SECTION .text$_D5synth4Core29calculateGaussianDistributionFfffZf align=4 execute ; section number 17, code
;  Communal section not supported by YASM

_D5synth4Core29calculateGaussianDistributionFfffZf:; Function begin, communal
        enter   16, 0                                   ; 0000 _ C8, 0010, 00
        fld     dword [?_005]                           ; 0004 _ D9. 05, 00000098(segrel)
        fstp    dword [ebp-4H]                          ; 000A _ D9. 5D, FC
        fld     dword [ebp+10H]                         ; 000D _ D9. 45, 10
        fsub    dword [ebp+0CH]                         ; 0010 _ D8. 65, 0C
        fstp    dword [ebp-4H]                          ; 0013 _ D9. 5D, FC
        fld     dword [ebp+8H]                          ; 0016 _ D9. 45, 08
        fmul    dword [?_012]                           ; 0019 _ D8. 0D, 000000C4(segrel)
        fld     dword [ebp-4H]                          ; 001F _ D9. 45, FC
        fmul    dword [ebp-4H]                          ; 0022 _ D8. 4D, FC
        fld     dword [ebp+8H]                          ; 0025 _ D9. 45, 08
        fmul    dword [ebp+8H]                          ; 0028 _ D8. 4D, 08
        fdivp   st1, st(0)                              ; 002B _ DE. F9
        fmul    dword [?_013]                           ; 002D _ D8. 0D, 000000C8(segrel)
        sub     esp, 4                                  ; 0033 _ 83. EC, 04
        fstp    dword [esp]                             ; 0036 _ D9. 1C 24
; Note: Displacement could be made smaller by sign extension
        fstp    dword [ebp-10H]                         ; 0039 _ D9. 9D, FFFFFFF0
        call    _D4Math3expFfZf                         ; 003F _ E8, 00000000(rel)
; Note: Displacement could be made smaller by sign extension
        fld     dword [ebp-10H]                         ; 0044 _ D9. 85, FFFFFFF0
        fmulp   st1, st(0)                              ; 004A _ DE. C9
        leave                                           ; 004C _ C9
        ret     12                                      ; 004D _ C2, 000C
; _D5synth4Core29calculateGaussianDistributionFfffZf End of function


