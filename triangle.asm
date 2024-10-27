[org 0x0100]
jmp start

clrscr:
    mov ax, 0xb800         
    mov es, ax
    mov di, 0             
    mov ax, 0x0720         
clear_screen:
    mov [es:di], ax       
    add di, 2
    cmp di, 4000           
    jne clear_screen
    ret

print_triangle:
    mov ax, 0xb800         
    mov es, ax
    mov bx, 38            
    mov di, 240           
    mov ax, 0x0701         
    mov cx, 5             
    mov dx, 1              
outer_loop:
    mov si, 0             
    add di, 160       
                   
    add dx, 2              
    sub di,2     

inner_loop:
    mov [es:di], ax       
    add di, 2             
    inc si               
    cmp si, dx             
    jne inner_loop         
shl si,1
sub di,si
    dec cx                
    cmp cx, 0              
    jne outer_loop         
    ret

start:
    call clrscr
    call print_triangle

    mov ax, 0x4c00        
    int 0x21
