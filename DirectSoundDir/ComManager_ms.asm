format MS COFF

extrn __imp__CoInitialize@4
extrn __imp__CoUninitialize@0

public _D14DirectSoundDir10ComManager10ComManager9initilizeFZv
public _D14DirectSoundDir10ComManager10ComManager11uninitilizeFZv
public _D14DirectSoundDir10ComManager10RefCounterk
section '.DATA' data
_D14DirectSoundDir10ComManager10RefCounterk:
dd 1

section '.TEXT' executable
_D14DirectSoundDir10ComManager10ComManager11uninitilizeFZv:
cmp dword [_D14DirectSoundDir10ComManager10RefCounterk], 0
jz ?_018
cmp dword [_D14DirectSoundDir10ComManager10RefCounterk], 1
jnz ?_017
mov dword [_D14DirectSoundDir10ComManager10RefCounterk], 0
call near [__imp__CoUninitialize@0]
jmp ?_018
?_017:
dec dword [_D14DirectSoundDir10ComManager10RefCounterk]
?_018:
ret 
_D14DirectSoundDir10ComManager10ComManager9initilizeFZv:
cmp dword [_D14DirectSoundDir10ComManager10RefCounterk], 0
jnz ?_016
push 0
call near [__imp__CoInitialize@4]
?_016:
inc dword [_D14DirectSoundDir10ComManager10RefCounterk]
ret 

