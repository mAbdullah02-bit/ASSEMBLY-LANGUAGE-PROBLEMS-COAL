[org 0x0100]
jmp start
arr: dw 5,6,8,l,9,2,8
size: 6 
swapper:db 0

swap: 
push ax
mov ax,[bx+si]
xchg ax,[bx+si+2]
mov [bx+si],ax
pop ax
ret

bubblesort:
push bx
push cx
push ax
push dx
push si
mov bx,0

mov cx,[bp-2]
mov si,[bp+6]

L1:
mov byte [bp-4],0

L2: mov ax,[si+bx]
cmp ax,[si+bx+2]
jbe noswap
call swap
mov byte [bp-4],1
noswap:
add si,2
cmp si,cxjne innerloop
cmp byte [bp-4],1
jz L1
pop si
pop dx 
pop ax
pop cx
pop bx
ret

statsofarr: 
push bp
mov bp,sp
mov cx,[bp+4]
shl cx
push cx
push swapper
call bubblesort
pop di
push si
mov si,[bp+6]



mov ax,[bp+4]
div 2
cmp dx ,0
jne odd

shl ax
mov bx,ax
mov ax,[si+bx]
add ax,[si+bx+2]
div 2
mov cx,ax

odd: 
shl ax
mov bx
mov cx,[si+bx]

mov ax,[si]
mov bx,[si+di]

pop si
pop bp
push ax
push bx
push cx
ret
start:
mov bx,arr
push bx
mov cx,[size]
push cx
call statsofarr

jmp 

 mov ax,0x4c00
 int 0x21









