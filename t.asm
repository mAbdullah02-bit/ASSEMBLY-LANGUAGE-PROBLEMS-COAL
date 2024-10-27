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
    mov word [es:di], 0x0700   
    add di, 2
    cmp di, 4000
    jne nextloc
    pop di
    pop ax
    pop es
    ret

printmessage:
    mov ax, 0xb800
    mov es, ax
    mov di, 0

   
    mov al, 1           
    mov ah, 07          
    mov di, 160       

fill_box:
    mov [es:di], ax
    add di, 2
    cmp di, 3840       
    jne fill_box

    
    mov al, 35         
    mov ah, 07         

   mov di,0

    L1:
   mov [es:di],ax
   add di,2
   cmp di,158
   jne L1
mov di,3840
 L2:
        mov [es:di], ax
        add di, 2
        cmp di, 4000
        jne L2

mov di,160
L3:
mov [es:di], ax
mov [es:di-2], ax

        add di, 160
        cmp di, 3840
        jne L3

    ret

start:
    call clrscr
    call printmessage

    mov ax, 0x4c00
    int 0x21
