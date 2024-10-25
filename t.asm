[org 0x0100]
jmp start
message: db 'Hello world'
length: dw 11

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

printmessage:
    push bp
    mov bp, sp
    push ax
    push bx
    push di
    push es

    mov ax, 0xb800
    mov es, ax
    mov si, [bp+6]
    mov cx, [bp+4]

    mov di, 220
    mov ah, 0x07  
L1:
    mov al, [si]      
    mov [es:di], ax   
    inc si         
    add di, 2         
    loop L1           

    pop es
    pop di
    pop bx
    pop ax
    pop bp
    ret

start:
    mov ax, message
    mov bx, [length]
    push bx
    push ax
    call clrscr
    call printmessage

    mov ax, 0x4c00
    int 0x21
