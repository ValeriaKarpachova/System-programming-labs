use16
org 100h

    mov bl,[b]     ; BL = 41
    mov cl,[c]     ; CL = 8
    and bl,cl      ; BL = 41 AND 8          101001
                   ;                    and 001000
                   ;                        001000 = 8  
                    
    mov al,[a]     ; AL = 19
    or  al,bl      ; AL = 19 OR 8            10011
                   ;                      or 01000
                   ;                         11011 = 27  
    mov dl,[d]     ; DL = 7
    xor al,dl      ; AL = 27 XOR 7           11011
                   ;                     xor 00111
                   ;                         11100 = 28
    mov bl,[e]     ; BL = 3
    or  al,bl      ; AL = 28 OR 3            11100
                   ;                      or 00011
                   ;                         11111 = 31
    mov [f],al                               

    mov ax,4C00h
    int 21h

;--------------------------
a db 19
b db 41
c db 8
d db 7
e db 3
f db ?    