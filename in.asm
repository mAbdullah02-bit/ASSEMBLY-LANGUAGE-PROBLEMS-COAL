org 0x100

mov si, num + 2 
mov cx, 4       

outer_loop:
    mov ax, [si] 
    mov di, si
    sub di, 2   

inner_loop:
    cmp di, num  
    jl end_inner_loop
    cmp ax, [di] 
    jge end_inner_loop
    mov dx,[di]
    mov  [di+2], dx 
    sub di, 2
    jmp inner_loop

end_inner_loop:
    mov [di+2], ax 
    add si, 2
    
    loop outer_loop

mov ax, 0x4c00
int 0x21

num: dw 5,2,6,3,1,0
