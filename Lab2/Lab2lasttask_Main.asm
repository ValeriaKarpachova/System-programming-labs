use16
org 100h

  mov ax,word[x]       ;3344
  add ax,word[y]       ;+C3D4 
  mov word[z],ax       ;=F718
  
  mov ax,word[x+2]     ;1122
  adc ax,word[y+2]     ;+A1B2
  mov word[z+2],ax     ;=B2D4
  
  mov ax,word[x+4]     ;7788
  adc ax,word[y+4]     ;+0718
  mov word[z+4],ax     ;=7EA0
  
  mov ax,word[x+6]     ;5566
  adc ax,word[y+6]     ;+E5F6
  mov word[z+6],ax     ;=3B5C
  
  mov ax,word[x+8]     ;99AA
  adc ax,word[y+8]     ;+192A
  mov word[z+8],ax     ;=B2D5
  
  mov al,byte[x+10]    ;BB
  adc al,byte[y+10]    ;+3B
  mov byte[z+10],al    ;=F6
  
  mov ax,4C00h ;\
  int 21h ;/ Завершення програми
;-------------------------------------------------------
x dd 0x11223344           
  dd 0x55667788      
  dw 0x99AA          
  db 0xBB           
y dd 0xA1B2C3D4           
  dd 0xE5F60718     
  dw 0x192A          
  db 0x3B            
z rb 11               ;F6B2D53B5C7EA0B2D4F718 
