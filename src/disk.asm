disk_load:
    pusha

    push dx
    
    mov ah, 0x02
    mov al, dh
    mov cl, 0x02
    mov ch, 0x00
    mov dh, 0x00

    int 0x13
    jc disk_error

    pop dx
    cmp al, dh
    jne sector_error
    popa
    ret

disk_error:
    mov bx, DISK_ERROR
    call print
    call print_nl

    mov dh, ah
    call print_hex
    
    jmp disk_loop

sector_error:
    mov bx, SECTOR_ERROR
    call print

disk_loop:
    jmp $

DISK_ERROR: db "Could not load disk!", 0
SECTOR_ERROR: db "Incorrect amount of sectors given!", 0