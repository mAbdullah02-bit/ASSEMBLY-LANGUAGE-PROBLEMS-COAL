[org 0x0100]
jmp start

num1: dw 5
num2: dw 10
result: dw 0
Addno:
add ax,bx
mov [result],ax

ret


start:
mov ax,[num1]
mov bx,[num2]
call Addno

mov ax,0x4c00
int 0x21

