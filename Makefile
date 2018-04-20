C_OBJS= audio.o misc.o
ASM_OBJS= RasPi_IO.o LED.o main.o games.o


# Linktime Flags
LFLAGS=-g

CFLAGS=-g -I.

# ASM compiler flags
ASMFLAGS=-g -I.

simon: ${C_OBJS} ${ASM_OBJS}
	gcc ${LFLAGS} -o $@ ${C_OBJS} ${ASM_OBJS}

%.o: %.c
	gcc ${CFLAGS} -c $<

%.o: %.S
	gcc ${ASMFLAGS} -c $<

clean:
	rm -f change *.o *~
