use16 
org 100h 
mov ax,1306h 
mov bx,ax 
mov ah, 9                     
mov dx,mes              
int 21h
mov ah, 0Ah
mov cx,year 
int 21h
mov ax,4C00h 
int 21h
mes db 'Karpachova Valeria$'
year db 2,0,0,6


