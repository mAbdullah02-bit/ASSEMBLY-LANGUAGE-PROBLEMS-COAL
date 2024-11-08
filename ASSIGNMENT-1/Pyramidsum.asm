[org 0x0100]
jmp start
message: db 'The sum is: $'
num: dw 6
sum: dw 0

; Triangle implementation
calcsum1: 

L1:
mov ax,1
xor si,si
add si,cx
add si,bx
L2:
cmp ax,bx
ja skip
add word [sum],ax  ; add th forw sum
mov dx,ax  ; store in dx for backword
dec dx       
jmp skip1
skip:

add word [sum],dx  ;  add the backword sum
dec dx    ;start decrementing till 1
skip1:
inc ax
cmp ax,si  ; compare ax with si if not equal
jbe L2
inc cx
inc bx
cmp bx,[num]   ; check no of rows
jbe L1

ret
 
;Formula implementation

calcsum:
push ax
push cx
push bx
push dx
xor cx,cx
mov bx,1
Loop1:
mov bx,ax
mul bx
add cx,ax
inc bx
cmp bx,[num]
jne Loop1
pop dx
pop bx 
pop cx
pop ax
ret

printsum:
mov ax,0xb800
mov es,ax
mov bx,message ;store address of mesasge
mov di,160
mov ah,07
L6:mov al,[bx]
cmp al,'$'
je end_string
    mov [es:di], ax      ; display to screen
    add di, 2 
     inc bx   ; move to next screen position
    jmp L6
end_string:

mov ax,[sum]
mov bx,10
mov cx,0
L5:     ; Divide the number by 10 to get remainder and print character by character
xor dx,dx
div bx
add dx,0x30
push dx 
inc cx
cmp ax,0
jne L5


L7:pop ax
mov ah,07
mov [es:di],ax
add di,2
loop L7
    




ret

clrscr: 
    push es
    push ax
    push di         ; clear screen same as book
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
start:
mov ax,[num]
add ax,5     ; Exevuting formula
; inc ax      ; only for 2nd method 
xchg ax,[num]

mov cx,0
mov dx,0      ; initializing varables
mov bx,1
mov ax,1
call calcsum1   ; calling functions
call clrscr   ;clear the screen
call printsum   ; show output
mov ax,[sum]

 mov ax,0x4c00
 int 0x21









