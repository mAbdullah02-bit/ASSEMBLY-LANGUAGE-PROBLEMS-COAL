[org 0x0100]
jmp start
arr: db 6,6, 5, 2, 3, 1, 3
newarr: db 0 ,0 ,0 ,0 ,0 ,0 ,0 
min: db 1
size: db 6
swap: db 0



removeduplicates: 
mov bx,0
mov si,0
L3:
mov al,[arr+bx]
cmp al,[arr+bx+1]
jne skipreplace
mov byte [arr+bx],0

skipreplace: 
inc bx
cmp bx,6
jne L3

mov ch,0
mov bx,0
mov si,0
L4:mov al,[ arr+bx]
cmp al,0
je skipstore
inc ch
mov [newarr+si],al
inc si
skipstore:
inc bx
cmp bx,[size]
jne L4
inc ch
mov [size],ch
ret



sort:
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

ret


start:
call sort
call removeduplicates



mov cl,[min]
mov bx,newarr
Loop1:
cmp [bx],cl 
jne found

inc cl
inc bx
cmp cl,[size]
jne Loop1
jmp end

found: mov al,cl

end:
mov ax,0x4c00

int 0x21
