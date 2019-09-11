TARGET=Numbers

all:   $(TARGET).o
	ld -m elf_i386 -o $(TARGET) $(TARGET).o io.o

$(TARGET).o:  $(TARGET).asm
	nasm -f elf $(TARGET).asm -l $(TARGET).lst


