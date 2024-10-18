

[org 0x0100]
jmp start

arr: dw 5,6,8,1,9,2   
size: dw 6              
swapper: db 0           
swap:
    push ax
    mov ax, [si+bx]     
    xchg [si+bx+2], ax   
    mov [si+bx],ax  
    pop ax
    ret 

bubblesort:

    push si
    push cx
    push bx
    mov cx, [bp-6] 
    sub cx,2     
   mov si,[bp+6]      
       
L1:
    mov byte [swapper], 0       
    mov bx, 0           

L2:
    mov ax, [si+bx]     
    cmp ax, [si+bx+2]   
    jbe no_swap         
    mov byte [swapper], 1      
    call swap           

no_swap:
    add bx, 2           
    cmp bx, cx           
    jne L2               

    cmp byte [swapper], 1 
    jz L1                 

   
    mov ax, [si]        
    push bx
    mov bx, cx           
    mov dx, [si+bx]      
    pop bx

    pop bx
    pop cx
    pop si
    ret



statsofarr:
    push bp
    mov bp, sp
    mov cx, [bp+4]       
    shl cx, 1            

    call bubblesort    
    push ax
    push dx 
come:
    mov si, [bp+6]       
    mov ax, [bp+4]      

    test ax, 1           
    jnz odd              

even:
    mov ax, [bp+4]     
    shr ax, 1        
      shl ax,1      
    mov bx, ax
    mov ax, [si+bx]   
   
    add ax, [si+bx-2]   
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

pop bx
pop ax
pop bp
    ret


start:
    mov si, arr          
    push si
    mov cx, [size]       
    push cx
    call statsofarr     
  

    mov ax, 0x4c00      
    int 0x21          
