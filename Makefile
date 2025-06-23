ARCH=x86_64
TARGET=$(ARCH)-elf

CC=$(TARGET)-gcc
LD=$(TARGET)-ld
AS=nasm

CFLAGS = -ffreestanding -c
LDFLAGS = -Ttext 0x1000 --oformat binary
ASFLAGS = 

SRC = $(wildcard kernel/*.c)
OBJ = $(SRC:.c=.o)

all: build/os.bin

%.bin: %.asm
	nasm -f bin $< -o $@

%.o: %.asm
	nasm -f elf64 $< -o $@

%.bin: %.c
	$(CC) $(CFLAGS) $< -o $@

build/kernel.bin: boot/kernel_entry.o $(OBJ)
	$(LD) $(LDFLAGS) $^ -o $@

build/os.bin: boot/bootsect.bin build/kernel.bin
	cat $^ > $@

run: build/os.bin
	qemu-system-x86_64 $<

clean:
	rm -rf $(OBJ) build/kernel.bin boot/*.bin boot/*.o