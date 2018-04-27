# Makefile - build script */

# source files
SOURCES_ASM := $(wildcard *.S)
SOURCES_C   := $(wildcard *.c)

# object files
OBJS        := $(patsubst %.S,%.o,$(SOURCES_ASM))
OBJS        += $(patsubst %.c,%.o,$(SOURCES_C))

# Build flags
# DEPENDFLAGS := -MD -MP
INCLUDES    := -I.
BASEFLAGS   := -fpic -nostdlib -nostartfiles -ffreestanding -nodefaultlibs -fno-builtin -fomit-frame-pointer 
BASEFLAGS   += -O2
WARNFLAGS   := -Wall -Werror
ASFLAGS     := $(INCLUDES) $(DEPENDFLAGS)
CFLAGS      := $(INCLUDES) $(DEPENDFLAGS) $(BASEFLAGS) $(WARNFLAGS)


# build rules
all: kernel.img

include $(wildcard *.d)

kernel.elf: $(OBJS) bare_metal.ld
	ld $(OBJS) -Tbare_metal.ld -o $@

kernel.img: kernel.elf
	objcopy kernel.elf -O binary kernel.img

clean:
	$(RM) -f $(OBJS) kernel.elf kernel.img

dist-clean: clean
	$(RM) -f *.d

# C.
%.o: %.c Makefile
	gcc $(CFLAGS) -c $< -o $@

# AS.
%.o: %.S Makefile
	gcc $(ASFLAGS) -c $< -o $@
