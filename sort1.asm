[org 0x0100]

mov cx,10
xor bx,bx
L2:

mov si,num
add si,bx
L1:
mov ax,[num + bx]
add si,2
sub cx,2

cmp ax,[si] 
ja swap

cmp cx,0
je update

jmp L1
update:
mov cx,10
add bx,2
sub cx,bx

cmp bx,10
jne L2

jmp end

swap:
mov dx,[si]
mov  [num+bx],dx
mov [si],ax
cmp cx,0
jne L1

cmp bx,10   
jne update

end:
mov ax,0x4c00
int 0x21

num: dw 7, 5, 2,8, 0, 1