[org 0x0100]
jmp start

sensors: dw  0x0581,0x8855   ; Sensor data
alerts: db 0, 0     ; Total alerts counter
criticalalert: db 0, 0  ; Critical alerts counter
warningalert: db 0, 0      ; Warning alerts counter
infoalert: db 0, 0
string0: db 'Total Alerts: $' ; Info alerts counter
string1: db 'Critical Alerts: $'
string2: db 'Warning Alerts: $'
string3: db 'Info Alerts: $'


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
; Count alerts and store in respective alert category
count_ones:
  push bp
  mov bp,sp
  push cx
  push ax
  mov ax,[bp+4]
         ; Load sensor data 
    mov cx, 16    ; Set CX =16

L1: 
    shl ax, 1    ; Shift left to test each bit
    jnc skip   ; If no carry skip
    call categorize_alerts      
skip:
    dec cx                      
    cmp cx, 0                   
    jne L1
    pop ax
    pop cx
    pop bp
    ret 2

; Categorize the alerts 
categorize_alerts:
    add byte [alerts+bx],1 ; Increment total alerts
    dec cx
    cmp cx, 12
    jge critical
    cmp cx, 8
    jge warning
    add byte [infoalert+bx], 1 ; increments Info alert if below bit 8
    jmp return

warning: 
    add byte [warningalert+bx], 1 ; increment warning alerts
    jmp return

critical: 
    add byte [criticalalert+bx], 1 ; increment critical alert

return:
    inc cx
    ret

; Print function 
print_alerts:
    ; PrintTotal alerts
   
    mov si, string0   ; Load string0 address
    mov di, 160             
    call print_string
    mov al, [alerts]
    call print_number
add di,6
mov al,[alerts+1]
call print_number
    ; Print critical alerts
    mov si, string1     ; Load string1 address
    mov di, 320                  
    call print_string
    mov al, [criticalalert]
    call print_number
add di,6
mov al,[criticalalert+1]
call print_number
    ; Print warning alerts
    mov si, string2  ; Load string2 address
    mov di, 480                   
    call print_string
    mov al, [warningalert]
    call print_number
add di,6
mov al,[warningalert+1]
call print_number
; Print Info alerts
mov si, string3      ; Load string3 address
    mov di, 640                  
    call print_string
    mov al, [infoalert]
    call print_number
add di,6
mov al,[infoalert+1]
call print_number
    ret

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
call clrscr
    xor bx, bx 

   mov ax,[sensors]
   push ax
    call count_ones              ;  first sensor
   inc bx        
   mov ax,[sensors+2]         ; next sensor
push ax
    call count_ones              ;  second sensor
    call print_alerts            ;  display results

    mov ax, 0x4C00               ; Exit program
    int 0x21
