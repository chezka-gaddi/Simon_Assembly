CPP_OBJS= 
ASM_OBJS= RasPi_IO.o

ASM_SRC= $(patsubst %.o,%.S,$(ASM_OBJS))
C_SRC= $(patsubst %.o,%.cc,$(CPP+OBJS))

# Linktime Flags
LFLAGS=-g

# C++ compiler flags
CPPFLAGS=-g -I.

# ASM compiler flags
ASMFLAGS=-g -I.

binary: ${CPP_OBJS} ${ASM_OBJS} bounce.o
	g++ ${LFLAGS} -o $@ ${CPP_OBJS} ${ASM_OBJS} bounce.o

butt: ${CPP_OBJS} ${ASM_OBJS} RasPi_Button_LED.o
	g++ ${LFLAGS} -o $@ ${CPP_OBJS} ${ASM_OBJS} RasPi_Button_LED.o

%.o: %.cc
	g++ ${CPPFLAGS} -c $<

%.o: %.S
	gcc ${ASMFLAGS} -c $<

clean:
	rm -f change *.o *~
