[org 0x0100]
jmp start
num: dd 1700
num1: dd 3200
result: dq 0
start:
mov cx,32

l1:
shr word [num1],1
jz skip
 mov ax,[num]
 add ax,[result]
 mov ax,[num+2]
 adc ax,[result+2]


skip:
dec cx
shl word [num],1
rcl word [num],1
cmp cx,0
jne l1


mov ax,0x4c00
int 0x21