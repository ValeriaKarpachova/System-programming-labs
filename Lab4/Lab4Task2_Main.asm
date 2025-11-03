use16
org 100h
jmp start

; --------------------
n           dw 3
matrix      db 1,2,3,4,5,6,7,8,9    
sum_main    dw 0                     
sum_side    dw 0                     
total_sum   dw 0                    
; --------------------

start:
    mov cx, [n]       ; cx = n
    xor si, si        ; i = 0
    
    mov word [sum_main], 0
    mov word [sum_side], 0
    mov word [total_sum], 0

loop_i:
    ; ------- main_index = i*n + i -------
    mov ax, si         ; ax = i
    mul cx             ; AX = i * n 
    add ax, si         ; AX = i*n + i
    mov bx, ax         
    mov dl, [matrix + bx]   ; dl = matrix[ main_index ]

    xor ah, ah
    mov al, dl
    add [sum_main], ax

    ; ------- side_index = i*n + (n-1-i) -------
    mov ax, si
    mul cx             ; AX = i * n
    mov bx, ax         ; bx = i*n
    mov dx, cx
    dec dx             ; dx = n - 1
    sub dx, si         ; dx = n - 1 - i
    add bx, dx         ; bx = i*n + (n-1-i)
    mov dl, [matrix + bx]   ; dl = matrix[ side_index ]

    xor ah, ah
    mov al, dl
    add [sum_side], ax

    inc si
    cmp si, cx
    jl loop_i

    ; total_sum = sum_main + sum_side
    mov ax, [sum_main]
    add ax, [sum_side]
    mov [total_sum], ax

    mov ax, 4C00h
    int 21h





