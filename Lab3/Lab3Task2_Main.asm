use16
org 100h

jmp start
; -------------------------------------------
arr db 5, 12, 3, 7, 9, 2, 8               
min db ?                           
; -------------------------------------------

start:
    mov si, 0
    mov al, [arr+si]     
    mov [min], al       

find_min:
    inc si
    cmp si, 7
    je found_min
                              
    mov bl, [arr+si]
    cmp bl, [min]
    jge find_min
    mov [min], bl
    jmp find_min

found_min:
    mov si, 0
mul_loop:
    cmp si, 7
    je done
    cbw
    mov al, [arr+si]     
    mov bl, [min]
    cbw
    imul bl             
    mov [arr+si], al    
    inc si
    jmp mul_loop

done:
    mov ax, 4C00h
    int 21h