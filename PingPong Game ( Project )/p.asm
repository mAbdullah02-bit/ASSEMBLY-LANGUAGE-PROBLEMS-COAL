[org 0x0100]
jmp start

Loop:
push cx
mov cx,0xffff
L1:
loop L1
pop cx
ret

func1:
mov di,1920
mov si,2078
mov ax,0xb800
mov es,ax
mov ax,0x0742
mov cx,0x0ffff
L3:
mov [es:di],ax
mov [es:si],ax
call Loop
cmp di,1960
add di,2
sub si,2
loop L3 


ret
start:

call clrscr
call func1
mov ax,0x4c00
int 0x21
