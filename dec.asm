[org 0x100]

mov di,num

mov cx,10


LOOP1:
mov [di],cx
add di,1
sub cx,1
     jnz LOOP1




mov ax,0x4c00
int 0x21

num: db 0,0,0,0,0,0,0,0,0,0;
res: db 0;