[org 0x0100]

mov ax,0xF00F
mov dx,16
mov cl,0
mov bx,0x00F3
L1:
 test bx,1      
jz skip 

inc cl

skip:
shr bx,1
cmp bx,0
jnz L1



mov bx,1
shl bx,cl
sub bx,1

xor ax,bx





mov ax,0x4c00
int 0x21