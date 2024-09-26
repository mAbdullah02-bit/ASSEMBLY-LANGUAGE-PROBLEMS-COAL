[org 0x100]
mov cx,3
mov bx,num
outeri:

add bx,2
mov si,bx
mov di,bx
innerj:

sub si,2
 

mov dx, [si]    
cmp dx, [di] 
ja swap
cmp si,num
je outeri
jmp innerj
 
swap:
mov ax,[di]
mov [di],dx
mov [si],ax
mov di,si
cmp si,num
je outeri
jmp innerj

end:
mov ax, 0x4c00
int 0x21

num: dw 23,1,10,5,2
