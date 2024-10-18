[org 0x0100]
jmp start

arr: dw 5,6,8,1,9,2,8   
size: dw 7             
swapper: dw 0

swap:
    push ax
    mov ax, [bx+si]
    xchg ax, [bx+si+2]
    mov [bx+si], ax
    pop ax
    ret

bubblesort:
    push bx
    push cx
    push ax
    push dx
    push si
    mov cx, [bp+4]     
    shl cx, 1         

outerloop:
    mov byte [bp-4], 0
    xor bx, bx       
    xor si, si

innerloop:
    cmp bx, cx
    jge skip_outer     
    mov ax, [si+bx]
    cmp ax, [si+bx+2]
    jbe noswap
    call swap         
    mov byte [bp-4], 1 

noswap:
    add bx, 2
    cmp bx, cx
    jl innerloop

skip_outer:
    cmp byte [bp-4], 1
    jz outerloop       

    
    mov ax, [si]       
    mov bx, [si+cx-2]  

    pop si
    pop dx
    pop ax
    pop cx
    pop bx
    ret

statsofarr:
    push bp
    mov bp, sp
    mov cx, [bp+4]     
    shl cx, 1        

    call bubblesort    

    mov si, [bp+6]     

   
    mov ax, [bp+4]
    test ax, 1         
    jnz odd            

even:
    mov ax, [bp+4]     
    shr ax, 1          
    shl ax, 1          
    mov bx, ax
    mov ax, [si+bx]    
    add ax, [si+bx+2]  
    shr ax, 1         
    mov cx, ax         
    jmp done

odd:
    mov ax, [bp+4]     
    shr ax, 1          
    shl ax, 1          
    mov bx, ax
    mov cx, [si+bx]    

done:
    pop bp
    ret

start:
    mov bx, arr
    push bx
    mov cx, [size]
    push cx
    call statsofarr
    pop cx
    pop bx

    mov ax, 0x4c00
    int 0x21
