[org 0x0100]
jmp start
arr: db 1,2, 3, 4, 6, 7, 8
min: db 1
max: db 7
start:
mov cl,[min]
mov bx,arr

L1:

cmp [bx],cl 
jne found

inc cl
inc bx
cmp cl,[max]
jne L1
jmp end

found: mov al,cl

end:
mov ax,0x4c00

int 0x21


