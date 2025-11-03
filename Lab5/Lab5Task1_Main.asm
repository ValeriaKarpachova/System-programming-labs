format PE console 4.0
include 'win32a.inc'
entry start

section '.code' code readable executable
start:
    cinvoke fopen, filename, type
    mov     ebx, eax

.nextLine:
    cinvoke fgets, buf, 255, ebx
    test    eax, eax
    jz      .done           ; якщо NULL -> кінець файлу
    cinvoke printf, fmt, buf
    jmp     .nextLine

.done:
    cinvoke fclose, ebx
    invoke  getch
    cinvoke exit, 0

section '.data' data readable writeable
type      db 'r',0
filename  db 'file.txt',0
fmt       db '%s',13,10,0      ; формат для printf (додає новий рядок)

section '.bss' readable writeable
buf rb 256                     ; буфер: 255 символів + '\0'

 data import
 library msvcrt,'MSVCRT.DLL',\ 
    kernel32,'KERNEL32.DLL',\ 
    user32,'USER32.DLL' 

 import msvcrt,\
    puts,'puts',\
    scanf,'scanf',\
        printf,'printf',\ 
         fopen,'fopen',\ 
          fgets,'fgets',\ 
           fclose,'fclose',\ 
           fseek,'fseek',\
            getch,'_getch',\ 
    exit,'exit'
end data



