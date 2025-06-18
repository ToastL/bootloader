ARCH=x86_64
TARGET=$(ARCH)-elf
AS=nasm

all: bootloader

bootloader:
	nasm src/main.asm -o build/boot

run: bootloader
	qemu-system-x86_64 build/boot