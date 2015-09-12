; Disassembly of file: allocators/DartAllocator.obj
; Mon Jun 09 00:19:29 2014
; Mode: 32 bits
; Syntax: YASM/NASM
; Instruction set: 80386


global _D10allocators13DartAllocator12__ModuleInfoZ
global _D10allocators13DartAllocator10StructDart6__initZ
global _D10allocators13DartAllocator11StructFrame6__initZ
global _D49TypeInfo_S10allocators13DartAllocator10StructDart6__initZ; Note: Communal.
global _D50TypeInfo_S10allocators13DartAllocator11StructFrame6__initZ; Note: Communal.
global _D10allocators13DartAllocator16newDartAllocatorFZPS10allocators13DartAllocator10StructDart; Note: Communal.
global _D10allocators13DartAllocator17freeDartAllocatorFPS10allocators13DartAllocator10StructDartZv; Note: Communal.
global _D10allocators13DartAllocator8allocateFPS10allocators13DartAllocator10StructDartkJbZPv; Note: Communal.
global _D10allocators13DartAllocator4freeFPS10allocators13DartAllocator10StructDartPvkZv; Note: Communal.
global _D10allocators13DartAllocator13allocateFrameFZPS10allocators13DartAllocator11StructFrame; Note: Communal.

extern _free                                            ; near
extern _D15TypeInfo_Struct6__vtblZ                      ; byte
extern _malloc                                          ; near
extern _D10allocators13DartAllocator13allocateFrameFZPS10allocators13DartAllocator11StructFrame ; near
extern _D10allocators13DartAllocator4freeFPS10allocators13DartAllocator10StructDartPvkZv ; byte
extern _D10allocators13DartAllocator8allocateFPS10allocators13DartAllocator10StructDartkJbZPv ; byte
extern _D10allocators13DartAllocator17freeDartAllocatorFPS10allocators13DartAllocator10StructDartZv ; byte
extern _D10allocators13DartAllocator16newDartAllocatorFZPS10allocators13DartAllocator10StructDart ; byte
extern _D50TypeInfo_S10allocators13DartAllocator11StructFrame6__initZ ; byte
extern _D49TypeInfo_S10allocators13DartAllocator10StructDart6__initZ ; byte

FLAT    GROUP 


SECTION .TEXT   align=4 execute                         ; section number 1, code


SECTION .DATA   align=16 noexecute                      ; section number 2, data

?_001:                                                  ; byte
        db 61H, 6CH, 6CH, 6FH, 63H, 61H, 74H, 6FH       ; 0000 _ allocato
        db 72H, 73H, 2EH, 44H, 61H, 72H, 74H, 41H       ; 0008 _ rs.DartA
        db 6CH, 6CH, 6FH, 63H, 61H, 74H, 6FH, 72H       ; 0010 _ llocator
        db 2EH, 53H, 74H, 72H, 75H, 63H, 74H, 44H       ; 0018 _ .StructD
        db 61H, 72H, 74H, 00H                           ; 0020 _ art.

?_002:                                                  ; byte
        db 61H, 6CH, 6CH, 6FH, 63H, 61H, 74H, 6FH       ; 0024 _ allocato
        db 72H, 73H, 2EH, 44H, 61H, 72H, 74H, 41H       ; 002C _ rs.DartA
        db 6CH, 6CH, 6FH, 63H, 61H, 74H, 6FH, 72H       ; 0034 _ llocator
        db 2EH, 53H, 74H, 72H, 75H, 63H, 74H, 46H       ; 003C _ .StructF
        db 72H, 61H, 6DH, 65H, 00H, 00H, 00H, 00H       ; 0044 _ rame....
        db 00H, 00H, 00H, 00H                           ; 004C _ ....

_D10allocators13DartAllocator12__ModuleInfoZ:           ; byte
        db 04H, 10H, 00H, 00H, 00H, 00H, 00H, 00H       ; 0050 _ ........
        db 61H, 6CH, 6CH, 6FH, 63H, 61H, 74H, 6FH       ; 0058 _ allocato
        db 72H, 73H, 2EH, 44H, 61H, 72H, 74H, 41H       ; 0060 _ rs.DartA
        db 6CH, 6CH, 6FH, 63H, 61H, 74H, 6FH, 72H       ; 0068 _ llocator
        db 00H                                          ; 0070 _ .


SECTION CONST   align=16 noexecute                      ; section number 3, const


SECTION .BSS    align=16 noexecute                      ; section number 4, bss

_D10allocators13DartAllocator10StructDart6__initZ:      ; byte
        resb    16                                      ; 0000

_D10allocators13DartAllocator11StructFrame6__initZ:     ; byte
        resb    20                                      ; 0010


SECTION FMB     align=4 noexecute                       ; section number 5, data


SECTION FM      align=4 noexecute                       ; section number 6, data

        dd FLAT:_D10allocators13DartAllocator12__ModuleInfoZ; 0000 _ 00000050 (segrel)


SECTION FME     align=4 noexecute                       ; section number 7, data


SECTION .text$_D49TypeInfo_S10allocators13DartAllocator10StructDart6__initZ align=16 noexecute ; section number 8, data
;  Communal section not supported by YASM

_D49TypeInfo_S10allocators13DartAllocator10StructDart6__initZ: ; byte
        dd FLAT:_D15TypeInfo_Struct6__vtblZ             ; 0000 _ 00000000 (segrel)
        dd 00000000H, 00000023H                         ; 0004 _ 0 35 
        dd FLAT:?_001                                   ; 000C _ 00000000 (segrel)
        dd 00000008H, 00000000H                         ; 0010 _ 8 0 
        dd 00000000H, 00000000H                         ; 0018 _ 0 0 
        dd 00000000H, 00000000H                         ; 0020 _ 0 0 
        dd 00000001H, 00000000H                         ; 0028 _ 1 0 
        dd 00000000H, 00000004H                         ; 0030 _ 0 4 
        dd 12345678H                                    ; 0038 _ 305419896 


SECTION .text$_D50TypeInfo_S10allocators13DartAllocator11StructFrame6__initZ align=16 noexecute ; section number 9, data
;  Communal section not supported by YASM

_D50TypeInfo_S10allocators13DartAllocator11StructFrame6__initZ: ; byte
        dd FLAT:_D15TypeInfo_Struct6__vtblZ             ; 0000 _ 00000000 (segrel)
        dd 00000000H, 00000024H                         ; 0004 _ 0 36 
        dd FLAT:?_002                                   ; 000C _ 00000024 (segrel)
        dd 00000014H, 00000000H                         ; 0010 _ 20 0 
        dd 00000000H, 00000000H                         ; 0018 _ 0 0 
        dd 00000000H, 00000000H                         ; 0020 _ 0 0 
        dd 00000001H, 00000000H                         ; 0028 _ 1 0 
        dd 00000000H, 00000004H                         ; 0030 _ 0 4 
        dd 12345678H                                    ; 0038 _ 305419896 


SECTION .text$_D10allocators13DartAllocator16newDartAllocatorFZPS10allocators13DartAllocator10StructDart align=4 execute ; section number 10, code
;  Communal section not supported by YASM

_D10allocators13DartAllocator16newDartAllocatorFZPS10allocators13DartAllocator10StructDart:; Function begin, communal
        enter   4, 0                                    ; 0000 _ C8, 0004, 00
        mov     dword [ebp-4H], 0                       ; 0004 _ C7. 45, FC, 00000000
        push    8                                       ; 000B _ 6A, 08
        call    _malloc                                 ; 000D _ E8, 00000000(rel)
        mov     dword [ebp-4H], eax                     ; 0012 _ 89. 45, FC
        add     esp, 4                                  ; 0015 _ 83. C4, 04
        test    eax, eax                                ; 0018 _ 85. C0
        jnz     ?_003                                   ; 001A _ 75, 05
        mov     eax, dword [ebp-4H]                     ; 001C _ 8B. 45, FC
        leave                                           ; 001F _ C9
        ret                                             ; 0020 _ C3

?_003:  xor     ecx, ecx                                ; 0021 _ 31. C9
        mov     edx, dword [ebp-4H]                     ; 0023 _ 8B. 55, FC
        mov     dword [edx], ecx                        ; 0026 _ 89. 0A
        mov     dword [edx+4H], ecx                     ; 0028 _ 89. 4A, 04
        mov     eax, edx                                ; 002B _ 89. D0
        leave                                           ; 002D _ C9
        ret                                             ; 002E _ C3
; _D10allocators13DartAllocator16newDartAllocatorFZPS10allocators13DartAllocator10StructDart End of function


SECTION .text$_D10allocators13DartAllocator17freeDartAllocatorFPS10allocators13DartAllocator10StructDartZv align=4 execute ; section number 11, code
;  Communal section not supported by YASM

_D10allocators13DartAllocator17freeDartAllocatorFPS10allocators13DartAllocator10StructDartZv:; Function begin, communal
        enter   12, 0                                   ; 0000 _ C8, 000C, 00
        mov     dword [ebp-4H], eax                     ; 0004 _ 89. 45, FC
        mov     dword [ebp-0CH], 0                      ; 0007 _ C7. 45, F4, 00000000
        mov     ecx, dword [eax]                        ; 000E _ 8B. 08
        mov     dword [ebp-0CH], ecx                    ; 0010 _ 89. 4D, F4
?_004:  mov     dword [ebp-8H], 0                       ; 0013 _ C7. 45, F8, 00000000
        cmp     dword [ebp-0CH], 0                      ; 001A _ 83. 7D, F4, 00
        jz      ?_005                                   ; 001E _ 74, 20
        mov     eax, dword [ebp-0CH]                    ; 0020 _ 8B. 45, F4
        mov     dword [ebp-8H], eax                     ; 0023 _ 89. 45, F8
        mov     edx, dword [eax]                        ; 0026 _ 8B. 10
        mov     dword [ebp-0CH], edx                    ; 0028 _ 89. 55, F4
        push    dword [eax+10H]                         ; 002B _ FF. 70, 10
        call    _free                                   ; 002E _ E8, 00000000(rel)
        push    dword [ebp-8H]                          ; 0033 _ FF. 75, F8
        call    _free                                   ; 0036 _ E8, 00000000(rel)
        add     esp, 8                                  ; 003B _ 83. C4, 08
        jmp     ?_004                                   ; 003E _ EB, D3

?_005:  push    dword [ebp-4H]                          ; 0040 _ FF. 75, FC
        call    _free                                   ; 0043 _ E8, 00000000(rel)
        add     esp, 4                                  ; 0048 _ 83. C4, 04
        leave                                           ; 004B _ C9
        ret                                             ; 004C _ C3
; _D10allocators13DartAllocator17freeDartAllocatorFPS10allocators13DartAllocator10StructDartZv End of function


SECTION .text$_D10allocators13DartAllocator8allocateFPS10allocators13DartAllocator10StructDartkJbZPv align=4 execute ; section number 12, code
;  Communal section not supported by YASM

_D10allocators13DartAllocator8allocateFPS10allocators13DartAllocator10StructDartkJbZPv:; Function begin, communal
        enter   8, 0                                    ; 0000 _ C8, 0008, 00
        push    ebx                                     ; 0004 _ 53
        push    esi                                     ; 0005 _ 56
        push    edi                                     ; 0006 _ 57
        mov     dword [ebp-4H], eax                     ; 0007 _ 89. 45, FC
        xor     ecx, ecx                                ; 000A _ 31. C9
        mov     byte [eax], cl                          ; 000C _ 88. 08
        mov     byte [eax], cl                          ; 000E _ 88. 08
        mov     edx, dword [ebp+0CH]                    ; 0010 _ 8B. 55, 0C
        cmp     dword [edx+4H], 0                       ; 0013 _ 83. 7A, 04, 00
        jnz     ?_006                                   ; 0017 _ 75, 1D
        call    _D10allocators13DartAllocator13allocateFrameFZPS10allocators13DartAllocator11StructFrame; 0019 _ E8, 00000000(rel)
        mov     ebx, dword [ebp+0CH]                    ; 001E _ 8B. 5D, 0C
        lea     esi, [ebx+4H]                           ; 0021 _ 8D. 73, 04
        mov     dword [esi], eax                        ; 0024 _ 89. 06
        mov     dword [ebx], eax                        ; 0026 _ 89. 03
        cmp     dword [esi], 0                          ; 0028 _ 83. 3E, 00
        jnz     ?_006                                   ; 002B _ 75, 09
        xor     eax, eax                                ; 002D _ 31. C0
        pop     edi                                     ; 002F _ 5F
        pop     esi                                     ; 0030 _ 5E
        pop     ebx                                     ; 0031 _ 5B
        leave                                           ; 0032 _ C9
        ret     8                                       ; 0033 _ C2, 0008

?_006:  mov     ecx, dword [ebp+0CH]                    ; 0036 _ 8B. 4D, 0C
        mov     edx, dword [ecx+4H]                     ; 0039 _ 8B. 51, 04
        mov     ebx, dword [edx+4H]                     ; 003C _ 8B. 5A, 04
        cmp     ebx, dword [ebp+8H]                     ; 003F _ 3B. 5D, 08
        jnc     ?_008                                   ; 0042 _ 73, 30
        mov     dword [ebp-8H], 0                       ; 0044 _ C7. 45, F8, 00000000
        call    _D10allocators13DartAllocator13allocateFrameFZPS10allocators13DartAllocator11StructFrame; 004B _ E8, 00000000(rel)
        mov     dword [ebp-8H], eax                     ; 0050 _ 89. 45, F8
        mov     esi, dword [ebp+0CH]                    ; 0053 _ 8B. 75, 0C
        cmp     dword [esi+4H], 0                       ; 0056 _ 83. 7E, 04, 00
        jnz     ?_007                                   ; 005A _ 75, 09
        xor     eax, eax                                ; 005C _ 31. C0
        pop     edi                                     ; 005E _ 5F
        pop     esi                                     ; 005F _ 5E
        pop     ebx                                     ; 0060 _ 5B
        leave                                           ; 0061 _ C9
        ret     8                                       ; 0062 _ C2, 0008

?_007:  mov     ecx, dword [ebp-8H]                     ; 0065 _ 8B. 4D, F8
        mov     edx, dword [ebp+0CH]                    ; 0068 _ 8B. 55, 0C
        add     edx, 4                                  ; 006B _ 83. C2, 04
        mov     ebx, dword [edx]                        ; 006E _ 8B. 1A
        mov     dword [ebx], ecx                        ; 0070 _ 89. 0B
        mov     dword [edx], ecx                        ; 0072 _ 89. 0A
?_008:  mov     esi, dword [ebp+0CH]                    ; 0074 _ 8B. 75, 0C
        add     esi, 4                                  ; 0077 _ 83. C6, 04
        mov     eax, dword [esi]                        ; 007A _ 8B. 06
        mov     ecx, dword [eax+10H]                    ; 007C _ 8B. 48, 10
        lea     edx, [eax+8H]                           ; 007F _ 8D. 50, 08
        add     ecx, dword [edx]                        ; 0082 _ 03. 0A
        mov     ebx, dword [ebp+8H]                     ; 0084 _ 8B. 5D, 08
        add     dword [edx], ebx                        ; 0087 _ 01. 1A
        mov     edi, dword [esi]                        ; 0089 _ 8B. 3E
        sub     dword [edi+4H], ebx                     ; 008B _ 29. 5F, 04
        mov     eax, dword [esi]                        ; 008E _ 8B. 06
        inc     dword [eax+0CH]                         ; 0090 _ FF. 40, 0C
        mov     esi, dword [ebp-4H]                     ; 0093 _ 8B. 75, FC
        mov     byte [esi], 1                           ; 0096 _ C6. 06, 01
        mov     eax, ecx                                ; 0099 _ 89. C8
        pop     edi                                     ; 009B _ 5F
        pop     esi                                     ; 009C _ 5E
        pop     ebx                                     ; 009D _ 5B
        leave                                           ; 009E _ C9
        ret     8                                       ; 009F _ C2, 0008
; _D10allocators13DartAllocator8allocateFPS10allocators13DartAllocator10StructDartkJbZPv End of function


SECTION .text$_D10allocators13DartAllocator4freeFPS10allocators13DartAllocator10StructDartPvkZv align=4 execute ; section number 13, code
;  Communal section not supported by YASM

_D10allocators13DartAllocator4freeFPS10allocators13DartAllocator10StructDartPvkZv:; Function begin, communal
        enter   12, 0                                   ; 0000 _ C8, 000C, 00
        push    ebx                                     ; 0004 _ 53
        push    esi                                     ; 0005 _ 56
        xor     ecx, ecx                                ; 0006 _ 31. C9
        mov     dword [ebp-0CH], ecx                    ; 0008 _ 89. 4D, F4
        mov     dword [ebp-8H], ecx                     ; 000B _ 89. 4D, F8
        mov     edx, dword [ebp+0CH]                    ; 000E _ 8B. 55, 0C
        mov     ebx, dword [edx]                        ; 0011 _ 8B. 1A
        mov     dword [ebp-8H], ebx                     ; 0013 _ 89. 5D, F8
?_009:  cmp     dword [ebp-8H], 0                       ; 0016 _ 83. 7D, F8, 00
; Note: Immediate operand could be made smaller by sign extension
        je      ?_016                                   ; 001A _ 0F 84, 00000074
        mov     eax, dword [ebp-8H]                     ; 0020 _ 8B. 45, F8
        mov     esi, dword [eax+10H]                    ; 0023 _ 8B. 70, 10
        cmp     dword [ebp+8H], esi                     ; 0026 _ 39. 75, 08
        jc      ?_010                                   ; 0029 _ 72, 0B
        lea     ecx, [esi+80000H]                       ; 002B _ 8D. 8E, 00080000
        cmp     dword [ebp+8H], ecx                     ; 0031 _ 39. 4D, 08
        jc      ?_011                                   ; 0034 _ 72, 04
?_010:  xor     edx, edx                                ; 0036 _ 31. D2
        jmp     ?_012                                   ; 0038 _ EB, 05

?_011:  mov     edx, 1                                  ; 003A _ BA, 00000001
?_012:  xor     dl, 01H                                 ; 003F _ 80. F2, 01
        jz      ?_013                                   ; 0042 _ 74, 0D
        mov     ebx, dword [ebp-8H]                     ; 0044 _ 8B. 5D, F8
        mov     dword [ebp-0CH], ebx                    ; 0047 _ 89. 5D, F4
        mov     eax, dword [ebx]                        ; 004A _ 8B. 03
        mov     dword [ebp-8H], eax                     ; 004C _ 89. 45, F8
        jmp     ?_009                                   ; 004F _ EB, C5

?_013:  mov     esi, dword [ebp-8H]                     ; 0051 _ 8B. 75, F8
        dec     dword [esi+0CH]                         ; 0054 _ FF. 4E, 0C
        mov     ecx, dword [esi+0CH]                    ; 0057 _ 8B. 4E, 0C
        mov     edx, dword [ebp+0CH]                    ; 005A _ 8B. 55, 0C
        mov     ebx, dword [edx+4H]                     ; 005D _ 8B. 5A, 04
        cmp     ebx, esi                                ; 0060 _ 3B. DE
        jz      ?_015                                   ; 0062 _ 74, 2A
        test    ecx, ecx                                ; 0064 _ 85. C9
        jnz     ?_015                                   ; 0066 _ 75, 26
        cmp     dword [ebp-0CH], 0                      ; 0068 _ 83. 7D, F4, 00
        jz      ?_014                                   ; 006C _ 74, 0A
        mov     eax, dword [ebp-8H]                     ; 006E _ 8B. 45, F8
        mov     esi, dword [eax]                        ; 0071 _ 8B. 30
        mov     ecx, dword [ebp-0CH]                    ; 0073 _ 8B. 4D, F4
        mov     dword [ecx], esi                        ; 0076 _ 89. 31
?_014:  mov     edx, dword [ebp-8H]                     ; 0078 _ 8B. 55, F8
        push    dword [edx+10H]                         ; 007B _ FF. 72, 10
        call    _free                                   ; 007E _ E8, 00000000(rel)
        push    dword [ebp-8H]                          ; 0083 _ FF. 75, F8
        call    _free                                   ; 0086 _ E8, 00000000(rel)
        add     esp, 8                                  ; 008B _ 83. C4, 08
?_015:  pop     esi                                     ; 008E _ 5E
        pop     ebx                                     ; 008F _ 5B
        leave                                           ; 0090 _ C9
        ret     8                                       ; 0091 _ C2, 0008

?_016:  hlt                                             ; 0094 _ F4
; _D10allocators13DartAllocator4freeFPS10allocators13DartAllocator10StructDartPvkZv End of function


SECTION .text$_D10allocators13DartAllocator13allocateFrameFZPS10allocators13DartAllocator11StructFrame align=4 execute ; section number 14, code
;  Communal section not supported by YASM

_D10allocators13DartAllocator13allocateFrameFZPS10allocators13DartAllocator11StructFrame:; Function begin, communal
        enter   4, 0                                    ; 0000 _ C8, 0004, 00
        mov     dword [ebp-4H], 0                       ; 0004 _ C7. 45, FC, 00000000
        push    20                                      ; 000B _ 6A, 14
        call    _malloc                                 ; 000D _ E8, 00000000(rel)
        mov     dword [ebp-4H], eax                     ; 0012 _ 89. 45, FC
        add     esp, 4                                  ; 0015 _ 83. C4, 04
        test    eax, eax                                ; 0018 _ 85. C0
        jnz     ?_017                                   ; 001A _ 75, 05
        mov     eax, dword [ebp-4H]                     ; 001C _ 8B. 45, FC
        leave                                           ; 001F _ C9
        ret                                             ; 0020 _ C3

?_017:  push    524288                                  ; 0021 _ 68, 00080000
        call    _malloc                                 ; 0026 _ E8, 00000000(rel)
        mov     ecx, dword [ebp-4H]                     ; 002B _ 8B. 4D, FC
        mov     dword [ecx+10H], eax                    ; 002E _ 89. 41, 10
        add     esp, 4                                  ; 0031 _ 83. C4, 04
        test    eax, eax                                ; 0034 _ 85. C0
        jnz     ?_018                                   ; 0036 _ 75, 0F
        push    dword [ebp-4H]                          ; 0038 _ FF. 75, FC
        call    _free                                   ; 003B _ E8, 00000000(rel)
        xor     eax, eax                                ; 0040 _ 31. C0
        add     esp, 4                                  ; 0042 _ 83. C4, 04
        leave                                           ; 0045 _ C9
        ret                                             ; 0046 _ C3

?_018:  mov     edx, dword [ebp-4H]                     ; 0047 _ 8B. 55, FC
        mov     dword [edx], 0                          ; 004A _ C7. 02, 00000000
        mov     dword [edx+4H], 524288                  ; 0050 _ C7. 42, 04, 00080000
        mov     dword [edx+8H], 0                       ; 0057 _ C7. 42, 08, 00000000
        mov     eax, edx                                ; 005E _ 89. D0
        leave                                           ; 0060 _ C9
        ret                                             ; 0061 _ C3
; _D10allocators13DartAllocator13allocateFrameFZPS10allocators13DartAllocator11StructFrame End of function


