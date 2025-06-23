[org 0x7c00]
    mov [BOOT_DRIVE], dl
    mov bp, 0x9000
    mov sp, bp

    call load_kernel
    call switch_to_pm
    jmp $

load_kernel:
    mov bx, KERNEL_OFFSET
    mov dh, 1
    mov dl, [BOOT_DRIVE]
    call load_disk
    ret

%include "boot/print.asm"
%include "boot/disk.asm"
%include "boot/gdt.asm"
%include "boot/switch.asm"

[bits 32]
BEGIN_PM:
    call KERNEL_OFFSET
    jmp $

KERNEL_OFFSET equ 0x1000
BOOT_DRIVE db 0

times 510-($-$$) db 0
dw 0xaa55