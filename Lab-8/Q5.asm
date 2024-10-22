[org 0x100]
jmp start
num: db 5,0

factorial:

sub cx,1
mov bx,ax
LOOP1:
sub bx,1
mul bx
sub cx,1
jnz LOOP1

mov [num+1],ax
ret


start:
mov ax,[num]
mov cx,ax;
call factorial

mov ax,0x4c00
int 0x21
