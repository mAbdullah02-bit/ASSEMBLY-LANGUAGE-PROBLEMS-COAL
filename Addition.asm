[org 0x100]

mov ax,0
mov bx,0
mov cx,10

LOOP1: ; loop

add ax,[nums+bx]
add bx,2
sub cx,1
jnz LOOP1




mov ax,0x4c00
int 0x21

nums: dw 0,1,2,3,4,5,6,7,8,9,10