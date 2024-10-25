[org 0x0100]
jmp start

num1: dw 7
sequence: dw 0,0,0,0,0,0,0
index: dw 0,0
fibonacci:
mov word [sequence],0
mov word [sequence+2],1
mov word [index+2],2
mov word [index],0
sub cx,2
mov bx,4
L1:
mov si,[index+2]
mov ax,[sequence+si]
mov si,[index]
add ax,[sequence+si]
mov [sequence+bx],ax

mov dx,[index+2]
mov [index],dx
mov [index+2],bx

add bx,2
dec cx
cmp cx,0
jne L1

ret




start:
mov si,sequence
mov cx,[num1]
call fibonacci


mov ax,0x4c00
int 0x21

