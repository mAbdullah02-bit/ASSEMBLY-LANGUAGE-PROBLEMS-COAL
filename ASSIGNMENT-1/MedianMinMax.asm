

[org 0x0100]
jmp start
string1: db 'Minimum Value:  $'
string2: db 'Maximum Value:  $'
string3: db 'Median Value:  $'
arr: dw 5,6,8,1,9,2   
size: dw 6              
swapper: db 0   


clrscr: 
    push es
    push ax
    push di ; clear screen same as book
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

    ret 4



print:
   
   
    push bp
mov bp,sp
push bx
push ax 
push cx
    ; Print Minimum Values
    mov si, string1     ; Load string1 address
    mov di, 160                  
    call print_string
    
    mov al, [bp+4]
    call print_number


    ; Print Maximum Value
    mov si, string2  ; Load string2 address
    mov di, 320                   
    call print_string
    mov al, [bp+6]
    call print_number

; Print Median Value
mov si, string3      ; Load string3 address
    mov di, 480                  
    call print_string
    mov al, [bp+8]
    call print_number

    ret 6

;print strings
print_string:
    mov ax, 0xB800              
    mov es, ax
    mov ah, 0x07   
                 
print_char:mov al,[si]
                            
    cmp al, '$'     ; Check for end of string
    je end_string
    mov [es:di], ax      ; display to screen
    add di, 2 
     inc si    ; move to next screen position
    jmp print_char
end_string:
    ret

; print single-digit number in AX
print_number:
mov ah,05
    add al, '0'                  ; Convert to ASCII
    mov [es:di], ax              ; print
    ret







start:
    mov si, arr          
    push si
    mov cx, [size]       
    push cx
    call statsofarr     
  push cx
  push bx
  push ax
  call clrscr
  call print

    mov ax, 0x4c00      
    int 0x21          
