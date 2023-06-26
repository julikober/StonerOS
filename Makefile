include makeTools/Makefile


BUILDDIR = build

TARGET = $(BUILDDIR)/os-image.img

KERNELBUILD = kernel/build
KERNELBIN = $(KERNELBUILD)/kernel.bin

BOOTLOADERBUILD = bootloader/build
BOOTLOADER = $(BOOTLOADERBUILD)/boot_sect.bin

all: ChildrenMake $(TARGET)

#$(BUILDDIR)/kernel_entry.o: $(KERNELDIR)/kernel_entry.asm
#	nasm -f elf -o $(BUILDDIR)/kernel_entry.o $(KERNELDIR)/kernel_entry.asm

#$(BUILDDIR)/kernel.o: $(KERNELDIR)/kernel.cpp
#	${GCCDIR}/bin/i386-elf-g++ $(CFLAGS) -c $(KERNELDIR)/kernel.cpp -o $(BUILDDIR)/kernel.o 

#$(BUILDDIR)/kernel.bin: $(BUILDDIR)/kernel_entry.o $(BUILDDIR)/kernel.o
#	${GCCDIR}/bin/i386-elf-ld -o $(BUILDDIR)/kernel.bin -Ttext 0x1000 $(BUILDDIR)/kernel_entry.o $(BUILDDIR)/kernel.o --oformat binary
#	# write 15 sectors of 0s to kernel.bin
#	dd if=/dev/zero of=$(BUILDDIR)/kernel.bin bs=512 count=15 seek=1

ChildrenMake:
	cd kernel; make
	cd bootloader; make


$(TARGET): $(BOOTLOADER) $(KERNELBIN)
	cat $(BOOTLOADER) $(KERNELBIN) > $(TARGET)


clean:
	rm -rf $(BUILDDIR)/*.o
	rm -rf $(BUILDDIR)/*.bin

	rm -rf $(KERNELBUILD)/*.o
	rm -rf $(KERNELBUILD)/*.bin

	rm -rf $(BOOTLOADERBUILD)/*.o
	rm -rf $(BOOTLOADERBUILD)/*.bin

run: clean all
	qemu-system-x86_64 $(TARGET)

debug: clean all
	qemu-system-x86_64 -s -S $(TARGET)