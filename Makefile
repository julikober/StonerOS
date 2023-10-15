SRCDIR = src
BUILDDIR = build

KERNELDIR = $(SRCDIR)/kernel
BOOTDIR = $(SRCDIR)/boot

GCCDIR = gcc/gcc-i386-elf

CFLAGS = -ffreestanding -fno-stack-protector -m32

all: clean $(BUILDDIR)/os-image

$(BUILDDIR)/boot_sect.bin: $(BOOTDIR)/boot_sect.asm
	nasm -f bin -o $(BUILDDIR)/boot_sect.bin $(BOOTDIR)/boot_sect.asm -I $(BOOTDIR)/ -I $(SRCDIR)/asm_tools/

$(BUILDDIR)/kernel_entry.o: $(KERNELDIR)/kernel_entry.asm
	nasm -f elf -o $(BUILDDIR)/kernel_entry.o $(KERNELDIR)/kernel_entry.asm

$(BUILDDIR)/kernel.o: $(KERNELDIR)/kernel.c
	${GCCDIR}/bin/i386-elf-gcc $(CFLAGS) -c $(KERNELDIR)/kernel.c -o $(BUILDDIR)/kernel.o 

$(BUILDDIR)/kernel.bin: $(BUILDDIR)/kernel_entry.o $(BUILDDIR)/kernel.o
	${GCCDIR}/bin/i386-elf-ld -o $(BUILDDIR)/kernel.bin -Ttext 0x5000 $(BUILDDIR)/kernel_entry.o $(BUILDDIR)/kernel.o --oformat binary
	# write 15 sectors of 0s to kernel.bin
	dd if=/dev/zero of=$(BUILDDIR)/kernel.bin bs=512 count=15 seek=1

$(BUILDDIR)/os-image: $(BUILDDIR)/boot_sect.bin $(BUILDDIR)/kernel.bin
	cat $(BUILDDIR)/boot_sect.bin $(BUILDDIR)/kernel.bin > $(BUILDDIR)/os-image

clean:
	rm -rf $(BUILDDIR)/*
	

run: all
	qemu-system-x86_64 $(BUILDDIR)/os-image