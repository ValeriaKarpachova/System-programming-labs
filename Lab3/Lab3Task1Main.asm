use16
org 100h

jmp start
; ------------------------------------------------------
first_menu db 13,10,'a=', '$'
second_menu db 13,10,'b=',  '$'
; ------------------------------------------------------
menu db 13,10,'+ - Add numbers', 13,10
     db '- - Subtract numbers', 13,10
     db '* - Multiply numbers', 13,10
     db '/ - Divide the numbers', 13,10
     db '0 - Exit', 13,10, '$'
select db 13,10, 'Select> $'
result db 13,10, 'Result= $' 
err_div0 db 13,10,'Error: division by zero!$'
; ------------------------------------------------------
a db ?
b db ?
res  dw ?
buffer db 6 dup(?) 
; ------------------------------------------------------
start:
      mov ah, 09h
      mov dx, first_menu
      int 21h

      mov ah, 01h
      int 21h
      sub al, '0'
      mov [a], al

      mov ah, 09h
      mov dx, second_menu
      int 21h
      
      mov ah, 01h
      int 21h
      sub al, '0'
      mov [b], al

show_menu:
      mov ah, 09h
      mov dx, menu
      int 21h

select_loop:
      mov ah, 09h
      mov dx, select
      int 21h

      mov ah, 01h
      int 21h     

      cmp al, '+'
      je c1
      cmp al, '-'
      je c2
      cmp al, '*'
      je c3
      cmp al, '/'
      je c4
      cmp al, '0'
      je exit
      jmp select_loop

; додавання
c1:
      mov al, [a]
      add al, [b]
      movzx ax, al
      mov [res], ax

      mov ah, 09h
      mov dx, result
      int 21h

      mov ax, [res]
      mov bx, 10
      mov si, 0

c1_conv:
      xor dx, dx
      div bx
      add dl, '0'
      mov [buffer+si], dl
      inc si
      test ax, ax
      jnz c1_conv

c1_print:
      dec si
      mov dl, [buffer+si]
      mov ah, 02h
      int 21h
      test si, si
      jnz c1_print
      jmp start

; віднімання
c2:
      mov al, [a] 
      sub al, [b] 
      mov [res], ax 
      mov ah, 09h 
      mov dx, result 
      int 21h 
      mov ax, [res] 
      add al, '0' 
      mov dl, al 
      mov ah, 02h 
      int 21h 
      jmp start

; множення 
c3:
      mov al, [a]
      mov bl, [b]
      mul bl          
      mov [res], ax

      mov ah, 09h
      mov dx, result
      int 21h

      mov ax, [res]
      mov bx, 10
      mov si, 0

c3_conv:
      xor dx, dx
      div bx
      add dl, '0'
      mov [buffer+si], dl
      inc si
      test ax, ax
      jnz c3_conv

c3_print:
      dec si
      mov dl, [buffer+si]
      mov ah, 02h
      int 21h
      test si, si
      jnz c3_print
      jmp start

; ділення
c4:
      mov al, [b]        
      cmp al, 0
      je div_error
      
      mov al, [a] 
      mov bl, [b] 
      xor ah, ah 
      div bl 
      mov [res], ax 
      mov ah, 09h 
      mov dx, result 
      int 21h 
      mov ax, [res] 
      add al, '0' 
      mov dl, al 
      mov ah, 02h 
      int 21h 
      jmp start  
 
div_error:
      mov ah, 09h
      mov dx, err_div0
      int 21h
      jmp start   

exit:
      mov ax, 4C00h
      int 21h
