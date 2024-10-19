[org 0x0100]
jmp start

num: dw 11
sum: dw 0

printsum: 

L1:
mov ax,1
xor si,si
add si,cx
add si,bx
L2:
cmp ax,bx
ja skip
add word [sum],ax
mov dx,ax
dec dx
jmp skip1
skip:

add word [sum],dx
dec dx
skip1:
inc ax
cmp ax,si
jbe L2
inc cx
inc bx
cmp bx,[num]
jbe L1

ret

start:

mov cx,0
mov dx,0
mov bx,1
mov ax,1

call printsum

mov ax,[sum]

 mov ax,0x4c00
 int 0x21









