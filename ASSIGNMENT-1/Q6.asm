[org 0x0100]
jmp start

; Clear screen function
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

; subroutine
subroutine:
    push bp 
    mov bp, sp
    push ax
    push bx
    push cx
    push di
    push si
    push dx
    ; Create 5 local variables with random values
    mov ax, 1
    push ax
    mov bx, 2
    push bx 
    mov cx, 3
    push cx
    mov dx, 4
    push dx
    mov si, 5
    push si

    ; Cleaning up
    pop si
    pop dx
    pop cx
    pop bx
    pop ax

    pop dx
    pop si
    pop di
    pop cx 
    pop bx
    pop ax
    pop bp
    ret 8

start:
    ; Set up initial values
    mov cx, 5     ; Output variables
    push cx
    mov bx, 9
    push bx
    mov ax, 2
    push ax
    ; Input variables
    mov ax, 0
    push ax
    mov ax, 5
    push ax
    mov ax, 8
    push ax
    mov ax, 1
    push ax

    call subroutine
    call clrscr
    mov ax, 0xb800
    mov es, ax
    mov di, 160
    
    ; Pop and display results
    pop ax
    pop bx
    pop cx

    mov ch, 07
    add cl, 0x30
    mov [es:di], cx
    add di, 160
    mov bh, 07
    add bl, 0x30
    mov [es:di], bx
    add di, 160
    mov ah, 07
    add al, 0x30
    mov [es:di], ax

; Part 2
    ; pushing and creating outputs
    push word 0  ; Output 1
    push word 0  ; Output 2
    push word 0  ; Output 3

    ; Inputs for part2sub
    mov ax, 60   ; Input 1 lahore
    push ax
    mov ax, 62   ; Input 2 faisalabad
    push ax
    mov ax, 44   ; Input 3  murree
    push ax
    mov ax, 55   ; Input 4 islamabad
    push ax

    call part2sub

    ;  display outputs
    pop cx           ; Output 1
    add di, 480
    push cx          ; Print output 1
    call printnum

    pop bx           ; Output 2
    add di, 160
    push bx          ; Print output 2
    call printnum

    pop ax           ; Output 3
    add di, 160      ; Print output 3
    push ax
    call printnum

    mov ax, 0x4c00
    int 0x21

part2sub:
    push bp
    mov bp, sp
    push ax
    push bx
    push cx

    
    ; Store result of I1 + I2 in O1
    mov ax, [bp+8]
    mov bx, [bp+10]
    add ax, bx
    mov [bp+16], ax   

    ; Store result of (I4 + 6 - 1) in O2
    mov ax, [bp+4]
    add ax, 6
    sub ax, 1
    mov [bp+14], ax   

    ; Store result of I3 +2nd local in output 1
    mov ax, [bp+6]
    add ax, [bp+6]
    mov [bp+12], ax   

    pop cx
    pop bx
    pop ax
    pop bp
    ret 8

printnum:
    push bp
    mov bp, sp
    push bx
    push dx
    push ax
    mov ax, [bp+4]
    mov bx, 10
    xor cx, cx  

L5:     ; Divide the number by 10 to get remainder and print character by character
    xor dx, dx
    div bx
    add dx, 0x30
    push dx 
    inc cx          ; Count number of digits pushed
    cmp ax, 0
    jne L5

    ; Print all digits stored on stack
print_loop:
    pop ax
    mov ah, 07
    mov [es:di], ax
    add di, 2
    loop print_loop   ; Loop CX times

    ; Restore stack
    pop ax
    pop dx
    pop bx
    pop bp
    ret 2
