format PE console
entry start

include "win32a.inc"

section ".data" data readable writeable
    x       dq 13.0
    ln2     dq 0.69314718055994530942
    y       dq 0.0
    fmt     db "y = %.6f",13,10,0

section ".code" code readable executable
start:

    fld1
    fld qword [x]
    fyl2x               ; st0 = log2(x)

    fld qword [ln2]
    fmulp st1, st0      ; st0 = log2(x) * ln2 = ln(x)
    fstp qword [y]

    ; printf
    sub esp, 8
    fld qword [y]
    fstp qword [esp]
    push fmt
    call [printf]
    add esp, 12

    call [getchar]

    push 0
    call [exit]

section ".idata" import data readable writeable
    library msvcrt,"msvcrt.dll", kernel32,"kernel32.dll"

    import msvcrt,\
        printf,"printf",\
        puts,"puts",\
        getchar,"getchar",\
        exit,"exit"

    import kernel32,\
        ExitProcess,"ExitProcess"


