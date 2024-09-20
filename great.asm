[org 0x0100]

mov bx,0
mov dx,0
Loop1:

mov ax,[num+bx]
add bx,2
cmp dx,ax

jg st



st:
mov dx,ax 
cmp bx,10
jne Loop1

mov ax,0x4c00
int 0x21

num: dw 1, 5, 9,8, 0, 1