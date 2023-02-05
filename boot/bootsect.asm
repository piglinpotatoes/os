[org 0x7c00]
KERNEL_OFFSET equ 0x1000

    mov [BOOT_DRIVE], dl 
    mov bp, 0x9000
    mov sp, bp

    mov bx, MSG_REAL
    call print
    call print_nl

    call load_kernel
    call switch_to_pm
    jmp $ ; Never executed

%include "boot/print.asm"
%include "boot/print_hex.asm"
%include "boot/disk.asm"
%include "boot/gdt.asm"
%include "boot/print32.asm"
%include "boot/switch32.asm"

[bits 16]
load_kernel:
    mov bx, MSG_STARTING
    call print
    call print_nl

    mov bx, KERNEL_OFFSET
    mov dh, 16
    mov dl, [BOOT_DRIVE]
    call disk_load
    ret

[bits 32]
BEGIN_PM:
    mov ebx, MSG_PROTECT
    call print_string_pm
    call KERNEL_OFFSET
    jmp $

BOOT_DRIVE db 0
MSG_REAL db "Started in 16-bit Real Mode", 0
MSG_PROTECT db "Loaded 32-bit Protected Mode", 0
MSG_STARTING db "Loading Terrier OS kernel into memory", 0

; padding
times 510 - ($-$$) db 0
dw 0xaa55