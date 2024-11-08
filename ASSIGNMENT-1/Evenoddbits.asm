[org 0x0100]
jmp start
arr: dw 5,10,3,0,8
size: dw 10

count_bits:   ;will count bits 

xor cx,cx
mov dl,16 ; no of bits in word act as counter
L2:
shr ax ,1

jnc zero  ;cmp if it is zero
inc cl  ; count 1s
jmp skip  
zero:
inc ch  ; count zeros
skip:
dec dl  
cmp dl,0  ; check if its 0
jne L2

ret

process_word:   ; process array word by word


mov dh,2       ; checking if even or odd
mov ax,[arr+bx]
call count_bits    ; call funcion for every word
l1:
mov ax,[arr+bx]
div dh     ; check even or not by / 2
cmp ah,0
jne odd
mov [arr+bx],ch  ;store even number bits
jmp skip2
odd:
mov [arr+bx],cl
skip2:add bx,2 ; store odd no bits
cmp bx,[size]  ; cmp bx with size
jne process_word

ret



start:  ;start
call process_word



end:
mov ax,0x4c00
int 0x21
