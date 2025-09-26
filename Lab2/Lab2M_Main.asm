use16
org 100h

 mov ax, [C]       ; AX = C
 mov bx, 4
 mul bx          ; DX:AX = AX(C) * BX(4)
 mov bx, 9
 div bx          ; AX = (C*4)/9, DX = (C*4) mod 9
 mov ax, dx      ; AX = остаток
 add ax, 5       ; AX = M
 mov [M], ax       ; сохраняем M                 
                                       
 mov ax, 4C00h
 int 21h
;-------------------------------------------------------     
C dw 6
M dw ?   
 