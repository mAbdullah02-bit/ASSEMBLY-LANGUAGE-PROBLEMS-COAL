[org 0x0100]
xor ax,ax

mov bx,8;
mov cx,6;

l1: mov ax,[num+bx]
add bx,2

cmp ax,9
jne l1
l2:
mov dx,[num+bx]
sub cx,2
cmp dx,2
jne l2
add cx,2
mov word [num+cx], 0x0003 
sub bx,2
mov [found],dx


mov ax,0x4c00
int 0x21

num: dw 1,2,3,0,5,8,9,10
found: dw 0