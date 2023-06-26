BUILDDIR = build

TARGET = $(BUILDDIR)/boot_sect.bin

SRCDIR = src
SRC = $(SRCDIR)/boot_sect.asm

INCLUDE = $(SRCDIR)/asm_tools/ -I $(SRCDIR)

all: $(BUILDDIR) $(BUILDDIR)/boot_sect.bin

$(BUILDDIR):
	mkdir build

$(TARGET): $(SRC)
	nasm -f bin -o $(TARGET) $(SRC) -I $(INCLUDE)
