[org 0x0100]
jmp start
arr: dw 5,10,3,0,8
size: dw 10

count_bits:

xor cx,cx
mov dl,16
L2:
shr ax ,1

jnc zero
inc cl
jmp skip
zero:
inc ch
skip:
dec dl
cmp dl,0
jne L2

ret

process_word:
mov dh,2
mov ax,[arr+bx]
call count_bits 
l1:
mov ax,[arr+bx]
div dh
cmp ah,0
jne odd
mov [arr+bx],ch
jmp skip2
odd:
mov [arr+bx],cl
skip2:add bx,2
cmp bx,[size]
jne process_word
ret



start:
mov bx,0
call process_word



end:
mov ax,0x4c00
int 0x21
