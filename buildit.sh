gcc -fno-pie -m32 -ffreestanding -c kernel.c -o kernel.o
nasm.exe kernel_enter.asm -f elf -o kernel_enter.o
nasm.exe bootsect.asm -f bin -o bootsect.bin
ld -melf_i386 -o kernel.bin -Ttext 0x1000 kernel_enter.o kernel.o --oformat binary
cat bootsect.bin kernel.bin > os-image.bin
qemu-system-i386.exe -fda os-image.bin