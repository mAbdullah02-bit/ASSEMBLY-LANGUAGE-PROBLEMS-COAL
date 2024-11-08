[org 0x0100]
jmp start
arr: db 6,6, 5, 2, 3, 1, 3  ; given arr
newarr: db 0 ,0 ,0 ,0 ,0 ,0 ,0   ; new arr
min: db 1
size: db 7  ;size of array
swap: db 0
Foundnum: db 0
N: dw 6   ; Range from 1 to N

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
removeduplicates: 
push bx
push si
push ax
push cx
mov bx,0      ; bx for array 1 indexing
mov si,0       ; si for array 2 indexing
L3:
mov al,[arr+bx]       
cmp al,[arr+bx+1]      ; check the next one
jne skipreplace     ; skip if equal
mov byte [arr+bx],0     ; 

skipreplace:  ; skip if not duplicate
inc bx
cmp bx,6 ; cmp with size-1
jne L3

mov ch,0
mov bx,0
mov si,0
L4:mov al,[ arr+bx]    ; loop for storing to new array
cmp al,0     ; compare with 0 to not include in new array
je skipstore
inc ch
mov [newarr+si],al  ; store if not 0
inc si
skipstore:
inc bx
cmp bx,[size]   
jne L4
inc ch   ; inc neew size of the new array
mov [size],ch
pop cx
pop ax
pop si
pop bx
ret

sort:            ; sorting function same as class
push bx 
push si
push ax
push cx
L1:
mov byte [swap],0                
mov bx,0
L2:
mov al,[arr+bx]
cmp al,[arr+bx+1]qui
jbe noswap

mov ah,al
mov al,[arr+bx+1]
mov [arr+bx+1],ah
mov [arr+bx],al
mov byte [swap],1
noswap:
inc bx
cmp bx,6
jne L2

cmp byte [swap],1
je L1
pop cx
pop ax
pop si
pop bx
ret

Find:   ; Find the missing number
push cx
push ax
push bx
xor ax,ax
mov ch,[min]   ; initialize to 1 
mov bx,newarr  ; store new arr address
Loop1:
cmp [bx],ch  ;cmp ch with the values of new array
jne found   ;if val not same then ch is missing

inc ch
inc bx
cmp ch,[N]  ; cmp ch with N val [1,N]
jne Loop1
jmp skipfound
found:
 mov [Foundnum] , ch ; store mssing no
skipfound
pop bx
pop ax 
pop cx
ret
printnumber: 
push ax
push es
push di              ; print no function
mov ax,0xb800
mov es,ax

mov di,160
mov cx,15
mov si,string   ; strong address
mov ah,05
l1:mov al,[si]
mov [es:di],ax
add di,2
inc si
loop l1
mov ah,05
mov al,[Foundnum]  ;  store missing no
add al,0x30
mov [es:di],ax ; display missing no
pop di
pop es
pop ax
ret
start:
call sort;func calls
call removeduplicates    ;func calls
call Find;func calls
call clrscr;func calls
call printnumber;func calls

mov ax,0x4c00

int 0x21
string: db 'Missing no is: '  ; string to print
length: dw 15   ; string lngth