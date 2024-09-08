[org 0x100]

mov ax,[num]
mov cx,ax;
sub cx,1
mov bx,ax
LOOP1:
sub bx,1
mul bx
sub cx,1
jnz LOOP1

mov [num+1 ],ax

mov ax,0x4c00
int 0x21

num: db 5,0;