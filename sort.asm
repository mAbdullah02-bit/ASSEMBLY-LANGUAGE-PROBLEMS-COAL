[org 0x0100]

mov cx,9          ; Set CX to the number of elements minus 1
xor bx,bx         ; Clear BX (used as outer index)
L2:
    mov si,num    ; Load the address of the array into SI
    add si,bx     ; Add outer index (BX) to SI
    
L1:
    mov al,[num + bx] ; Load the current element into AL
    add si,1          ; Move to the next element
    sub cx,1          ; Decrease comparison count
    
    cmp al,[si]    ; Compare current element with the next one
    jle swap       ; Jump to swap if current is larger
    
    cmp cx,0       ; Check if inner loop is done
    je update      ; If yes, jump to update outer index
    
    jmp L1         ; Otherwise, repeat inner loop
    
swap:
    mov dl,[si]       ; Load the next element into DL
    mov [num + bx],dl ; Swap current element with the next
    mov [si],al       ; Place the previous current element in the next spot
    cmp cx,0          ; Check if inner loop is done
    jne L1            ; Continue if inner loop not done

update:
    mov cx,9          ; Reset CX for the next pass
    add bx,1          ; Move to the next element in the array
    sub cx,bx         ; Decrease CX by BX
    
    cmp bx,9          ; Check if we're at the last element
    jne L2            ; If not, continue outer loop

end:
    mov ax,0x4c00
    int 0x21          ; Terminate program

num: db -10,8,7,6,5,-4,3,3,1