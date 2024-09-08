[org 0x100]

mov cx,5;

LOOP1:
mov ax,[num+2]
mov bx,[num+2]

add ax,[num]
mov [num],bx

mov [num+2],ax

sub cx,1
        jnz LOOP1

mov ax,0x4c00
int 0x21

num: dw 0,1;