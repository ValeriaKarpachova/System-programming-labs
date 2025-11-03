use16
org 100h
jmp start
; -----------------------------
a dw 16
b dw 7
c dw 29
d dw 11
q dw 6
sum dw 0
; -----------------------------
start:
    push [a]
    push [b]
    push [c]
    push [d]

    pop dx      ; d
    pop cx      ; c
    pop bx      ; b
    pop ax      ; a

    ;(c - d)
    mov si, cx
    sub si, dx     ; si = (c - d)= 18 (12) 
    
    ;(a * b)
    imul bx         ; ax = a * b = 122 (70)
    add si, ax      ; si = (a*b) + (c-d) = 130 (82)

    xor bp, bp      ; bp буде для результату
    mov bx, 1       ; i = 1
    mov cx, 11      ; 11 ітерацій циклу
    mov di, [q]     ; q = 6

sum_loop:
    mov ax, di       ; ax = q = 6
    mul bx           ; ax = q * i
    add ax, si      ; (a*b)+(c-d)+q*i = 136 (88(перший цикл))
    add bp, ax      ; складаємо цикли
    inc bx
    loop sum_loop

    mov [sum], bp   ; результат = 1826 (722)

    mov ax, 4C00h
    int 21h



