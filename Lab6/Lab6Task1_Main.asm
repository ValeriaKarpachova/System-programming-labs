include 'win32ax.inc'

.code
main:
    finit                       ; ініціалізація FPU
    fld dword [value]            ; завантажити x = π/3
    fcos                         ; обчислити cos(x)
    fstp dword [res]             ; зберегти результат
    invoke ExitProcess, 0
.end main

.data
    value dd 1.0471976           ; x = π/3 (≈60°)
    res   dd ?
