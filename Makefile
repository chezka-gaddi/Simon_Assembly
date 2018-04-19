C_OBJS= audio.o
ASM_OBJS= RasPi_IO.o


# Linktime Flags
LFLAGS=-g

CFLAGS=-g -I.

# ASM compiler flags
ASMFLAGS=-g -I.

binary: ${C_OBJS} ${ASM_OBJS} bounce.o
	gcc ${LFLAGS} -o $@ ${C_OBJS} ${ASM_OBJS} bounce.o

butt: ${C_OBJS} ${ASM_OBJS} RasPi_Button_LED.o
	gcc ${LFLAGS} -o $@ ${C_OBJS} ${ASM_OBJS} RasPi_Button_LED.o

%.o: %.c
	gcc ${CFLAGS} -c $<

%.o: %.S
	gcc ${ASMFLAGS} -c $<

clean:
	rm -f change *.o *~
