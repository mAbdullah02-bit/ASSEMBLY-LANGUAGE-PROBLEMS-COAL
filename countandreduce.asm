[org 0x0100]

mov ax,8312
mov dx,0

L1:
inc dx
mov cx,0
mov bx,ax
L2:

shr bx,1
jnc skip

inc cx
skip:
cmp bx,0
jne L2

mov ax,cx
cmp ax,1
jne L1

mov ax , 0x4c00
int 0x21

