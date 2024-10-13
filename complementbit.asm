[org 0x0100]

mov ax,5
mov bx,15

mov dx,1
shl dx,ax

xor bx,dx
mov ax,0x4c00
int 0x21

