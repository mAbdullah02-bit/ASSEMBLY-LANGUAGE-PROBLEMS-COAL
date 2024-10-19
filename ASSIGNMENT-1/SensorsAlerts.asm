[org 0x0100]
jmp start

sensors: dw 0x8855, 0x0581
alerts: dw 0,0
criticalalert: dw 0,0
warningalert: dw 0,0
infoalert: dw 0,0

count_ones:
mov ax,[sensors+bx]

L1:shl ax,1
jnc skip
call categorize_alerts

skip:
dec cx
cmp cx,0
jne L1
ret


categorize_alerts: add word [alerts+bx],1
dec cx
cmp cx,12
jge critical
cmp cx,8
jge warning
add word [infoalert+bx],1
jmp return
warning: add word [warningalert+bx],1
jmp return
critical: add word [criticalalert+bx],1
return: 
inc cx
ret

start:
xor cx,cx
xor bx,bx
mov cx,16
call count_ones
add bx,2
mov cx,16
call count_ones
 mov ax,0x4c00
 int 0x21









