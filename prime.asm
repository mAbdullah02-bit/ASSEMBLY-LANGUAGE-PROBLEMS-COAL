[org 0x0100]


mov bx,2
mov ax,[data]
mov byte[result],1

l1:
cmp bx,[data]
je end
mov ax,[data]
div bx
cmp dx,0
je noprime
inc bx
xor dx,dx
xor ax,ax
jmp l1
noprime:
mov byte[result],0
end:
mov ax,0x4c00
int 21h

data: dw 19
result: db 0