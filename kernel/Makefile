include ../makeTools/Makefile

SRCDIR = src
BUILDDIR = build

SRC = $(SRCDIR)/kernel.c $(SRCDIR)/VideoMemory/VideoMemory.c
OBJ = $(BUILDDIR)/kernel.o $(BUILDDIR)/VideoMemory.o

all: $(SRC) $(BUILDDIR)/disk.img

$(BUILDDIR)/disk.img: $(BUILDDIR)/kernel.bin
#	write 15 sectors of 0s to kernel.bin
	dd if=/dev/zero of=$(BUILDDIR)/kernel.bin bs=512 count=15 seek=1

$(BUILDDIR)/kernel.bin: $(SRC) $(BUILDDIR)/kernel_entry.o $(OBJ)
	$(LD) -o $(BUILDDIR)/kernel.bin -Ttext 0x1000 $(BUILDDIR)/kernel_entry.o $(OBJ) --oformat binary

$(BUILDDIR)/kernel_entry.o: $(SRCDIR)/kernel_entry.asm
	nasm -f elf -o $(BUILDDIR)/kernel_entry.o $(SRCDIR)/kernel_entry.asm

$(BUILDDIR)/kernel.o:
	$(CXX32) $(CFLAGS) -o $(BUILDDIR)/kernel.o -c $(SRCDIR)/kernel.c

$(BUILDDIR)/VideoMemory.o:
	$(CXX32) $(CFLAGS) -o $(BUILDDIR)/VideoMemory.o -c $(SRCDIR)/VideoMemory/VideoMemory.c

