[org 0x100]

mov di,num2
mov bx,num
add bx,18
mov cx,10
fact:

mov ax,[bx]
mov [di],ax
sub bx,2
add di,2
loop fact


mov ax, 0x4c00
int 0x21

num: dw 1,2,3,4,5,6,7,8,9,10
num2: dw 0,0,0,0,0,0,0,0,0,0