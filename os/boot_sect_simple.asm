[org 0x7c00] ; bootloader offset
    mov bp, 0x9000 ; set the stack
    mov sp, bp

    mov bx, MSG_START
    call print ; This will be written after the BIOS messages

    call switch_to_pm
    jmp $ ; this will actually never be executed

%include "print.asm"
%include "gdt.asm"
%include "print32.asm"
%include "switch32.asm"

[bits 32]
BEGIN_PM: ; after the switch we will get here
    mov ebx, MSG_READY
    call print_string_pm ; Note that this will be written at the top left corner
    jmp $

MSG_START db "Started Macaron.OS in 16-bit mode...", 0
MSG_READY db "Loaded 32-bit protected mode!", 0

; bootsector
times 510-($-$$) db 0
dw 0xaa55