[org 0x0100]

mov ax,0xF00F
mov cl,4

L1:

      
rol al,1        

rol ah,1                 


dec cl
cmp cl,0
jnz L1



mov ax,0x4c00
int 0x21