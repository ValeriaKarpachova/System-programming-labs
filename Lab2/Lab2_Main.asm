use16
org 100h

  mov al,[a] ;Завантажуємо значення a в AL
  mov bl,[b] ; Завантажуємо значення b в BL
  mul bl  ; AX=AL(7)*BL(3)=21
  
  mov cl,[c] ;CL = c(5)
  neg cl ;CL = -CL = -c(-5)
  add al,cl ; 7*3-5=16         !
  
  mov cl, 4
  div cl  ;(7*3-5)/4=4
  mov bl,al  ;BL=4
  
  mov al,[d]
  add al,bl  ;40+(7*3-5)/4
  mov [e],al 
  
  mov ax,4C00h ;\
  int 21h ;/ Завершення програми
;-------------------------------------------------------
;40+(7*3-5)/4=44
a db 7
b db 3
c db 5
d db 40
e db ?    
