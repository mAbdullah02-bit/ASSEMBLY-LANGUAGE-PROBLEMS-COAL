[org 0x0100]

mov si,num
add si ,4
mov bx,num
mov cx,0
L1:  
cmp cx,2
jz end
add bx,cx
sub si,cx
inc cx
swap: 

mov dl,[bx]
mov dh,[si]
mov byte [bx],dh
mov [si],dl
jmp L1


end:
mov ax,0x4c00
int 0x21
num: db 5 ,3 ,2 ,1, 0
result:  db 03