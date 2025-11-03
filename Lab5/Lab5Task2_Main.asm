format PE console 4.0
include 'win32a.inc'
entry start

IDC_HAND equ 32649          ; курсор "рука"
OCR_NORMAL equ 32512        ; стандартний курсор
SPI_SETCURSORS equ 0x57     ; команда для відновлення стандартних курсорів

section '.code' code readable executable
start:
    ; отримати поточні координати курсора
    invoke GetCursorPos, point

    mov eax, [point.x]
    sub eax, 300
    mov [point.x], eax

    mov eax, [point.y]
    sub eax, 100
    mov [point.y], eax

    ; перемістити курсор у нову позицію
    invoke SetCursorPos, [point.x], [point.y]

    ; завантажити стандартний курсор "рука" і зробити його системним
    invoke LoadCursor, 0, IDC_HAND
    invoke SetSystemCursor, eax, OCR_NORMAL

    invoke getch                ; чекати клавішу

    ; повернути стандартні курсори
    invoke SystemParametersInfo, SPI_SETCURSORS, 0, 0, 0

    invoke ExitProcess, 0

section '.data' data readable writeable
point POINT <>

data import
    library kernel32,'KERNEL32.DLL',\
            user32,'USER32.DLL',\
            msvcrt,'MSVCRT.DLL'

    import kernel32,\
        ExitProcess,'ExitProcess'

    import user32,\
        GetCursorPos,'GetCursorPos',\
        SetCursorPos,'SetCursorPos',\
        LoadCursor,'LoadCursorA',\
        SetSystemCursor,'SetSystemCursor',\
        SystemParametersInfo,'SystemParametersInfoA'

    import msvcrt,\
        getch,'_getch'
end data

