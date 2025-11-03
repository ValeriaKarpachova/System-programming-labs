format PE console
entry start

include "win32a.inc"

section ".data" data readable writeable
    pi        dq 3.141592653589793
    deg180    dq 180.0
    x_double  dq 0.0
    rad       dq 0.0
    y_val     dq 0.0
    i_int     dd 0

    fmt       db "x=%d   y=%.20f",13,10,0
    done_msg  db "Done. Press Enter...",13,10,0

section ".code" code readable executable
start:
    mov [i_int], 0

.loop:
    mov eax, [i_int]
    cmp eax, 91          ; x = 0..90
    jge .end

    ; Перетворення x в double
    fild dword [i_int]
    fstp qword [x_double]

    ; rad = x * pi / 180
    fld qword [x_double]
    fld qword [pi]
    fmulp st1, st0        ; st0 = x*pi
    fld qword [deg180]
    fdivp st1, st0        ; st0 = x*pi/180
    fstp qword [rad]

    ; y = cos(rad)
    fld qword [rad]
    fcos
    fstp qword [y_val]

    ; Вивід на екран
    sub esp, 8
    fld qword [y_val]
    fstp qword [esp]
    push dword [i_int]
    push fmt
    call [printf]
    add esp, 16

    ; Наступний x
    mov eax, [i_int]
    inc eax
    mov [i_int], eax
    jmp .loop

.end:
    push done_msg
    call [puts]
    call [getchar]

    push 0
    call [exit]

section ".idata" import data readable writeable
    library msvcrt, "msvcrt.dll", kernel32, "kernel32.dll"

    import msvcrt, \
        printf, "printf", \
        puts, "puts", \
        getchar, "getchar", \
        exit, "exit"

    import kernel32, \
        ExitProcess, "ExitProcess"

