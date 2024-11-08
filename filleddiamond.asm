[org 0x0100] 

jmp start  


clrscr: 
    push es
    push ax
    push di
    mov ax, 0xb800 
    mov es, ax
    mov di, 0      
nextloc: 
    mov word [es:di], 0x0720 
    add di, 2
    cmp di, 4000    
    jne nextloc
    pop di
    pop ax
    pop es
    ret    

printhollow:

push bp
mov bp,sp
push ax 
push bx
push di
push es
push cx

mov ax,0xb800
mov es,ax 
mov al,80
mul byte [bp+6]
add ax,[bp+4]
shl ax,1
mov di,ax
mov dx,di
mov cx,[bp+8]
mov ax,0x0701
mov dx,1
L1:
push dx
push di
L3:

mov [es:di],ax
add di,2
dec dx
cmp dx,0
jne L3
pop di
pop dx
add dx,2
add di,158
loop L1

mov cx,[bp+8]
inc cx
L2:

push dx
push di
L4:

mov [es:di],ax
add di,2
dec dx
cmp dx,0
jne L4
pop di
pop dx
sub dx,2
add di,162
loop L2

ret 6

start: 
    call clrscr
     mov cx,5
     push cx
mov ax,3
push ax
mov ax,39
push ax
call printhollow


    mov ax, 0x4c00
    int 0x21  