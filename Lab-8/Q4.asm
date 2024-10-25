[org 0x100]
jmp start
num: dw 5,2,8,1,0
swaper: db 0
swap:
   push ax
    mov ax, [num+bx]     
    xchg [num+bx+2], ax   
    mov [num+bx],ax  
    pop ax
    


ret
bubblesort:
push bp
mov bp,sp
push ax
push bx
mov bx,[bp+6]
mainloop:
mov bx,0
mov byte [swaper],0
L1:

mov ax,[num+bx]
cmp ax,[num+bx+2]
ja noswap
mov byte [swaper],1
call swap
noswap:
add bx,2
cmp bx,10
jne L1
cmp byte [swaper],0
jne mainloop

pop bx
pop ax
pop bp
ret


start:
mov bx,0
mov ax,0
call bubblesort



mov ax,0x4c00
int 0x21

