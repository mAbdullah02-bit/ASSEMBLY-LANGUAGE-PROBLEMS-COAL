[org 0x100]


mov bx,10
mov cx,2

LOOP1:
mov ax,[num]qui
div bx
mov [num],ax
mov ax,[num+2]
mov [num+4],dx
mul bx

add ax,[num+4]
mov [num+2],ax
sub cx,1
jnz LOOP1

mov ax, 0x4c00
int 0x21

num: dw 12,0,0;