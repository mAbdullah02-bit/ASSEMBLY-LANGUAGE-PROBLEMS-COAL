[org 0x0100]
jmp start
num1: dw 5
num2: dw 10
Swapnumbers
mov ax,[num1]
xchg ax,[num2]
mov [num2],ax
ret


start:

call Swapnumbers

mov ax,0x4c00
int 0x21

