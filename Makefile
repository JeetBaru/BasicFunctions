include sources.mk
ifeq ($(ARCH), BBB)
		CC = arm-linux-gnueabihf-gcc
		CFLAGS= -Wall -Werror -g -std=c99 
else

		CC = gcc
		CFLAGS = -g -Werror -std=c99
endif

ifeq ($(ARCH), FRDM)
	CC = arm-none-eabi-gcc
	CFLAGS = -Werror -g -std=c99 -specs=nosys.specs
endif

FILE_SIZE = stat -c %s $@

RM = rm -rf

A = srcs/

Headers= project_1.h data.h memory.h

.PHONY : all Project1 Preprocessor Assembly Dependency build-FRDM build-BBB \
	build-FRDM build-host compile-all objdmp-data.o objdmp-main.o objdmp-memory.o\
	objdmp-project_1.o build-lib clean

all : Project1	

Project1 : $(SRCS)
	$(CC) -o $@ $(CFLAGS) $^ 
	$(FILE_SIZE)

Preprocessor: $(SRCS)
	$(CC) -E $(A)main.c -o main.i
	$(CC) -E $(A)memory.c -o memory.i
	$(CC) -E $(A)data.c -o data.i
	$(CC) -E $(A)project_1.c -o project_1.i
	
Assembly: $(SRCS)
	$(CC) -S $(A)main.c -o main.s
	$(CC) -S $(A)data.c -o data.s
	$(CC) -S $(A)memory.c -o memory.s
	$(CC) -S $(A)project_1.c -o project_1.s
	
Dependency: $(SRCS)
	$(CC) -M $(A)main.c -o main.dep
	$(CC) -M $(A)data.c -o data.dep
	$(CC) -M $(A)memory.c -o memory.dep
	$(CC) -M $(A)project_1.c -o project_1.dep
	
%.i : %.c 
	$(CC) -E $^ -o $@

%.o : %.c 
	$(CC) -c $^ -o $@

%.s : %.c 
	$(CC) -S $^ -o $@

%.dep : %.c
	$(CC) -M $^ -o $@
	
build-FRDM:
	arm-none-eabi-gcc -c $(CFLAGS) -o main.o srcs/main.c 
	arm-none-eabi-gcc -c $(CFLAGS) -o data.o srcs/data.c 
	arm-none-eabi-gcc -c $(CFLAGS) -o project_1.o srcs/project_1.c 
	arm-none-eabi-gcc -c $(CFLAGS) -o memory.o srcs/memory.c 
	arm-none-eabi-gcc -o Project1 $(OBJS) -specs=nosys.specs
	
build-BBB: 
	arm-linux-gnueabihf-gcc $(CFLAGS) -c -o main.o srcs/main.c 
	arm-linux-gnueabihf-gcc $(CFLAGS) -c -o data.o srcs/data.c
	arm-linux-gnueabihf-gcc $(CFLAGS) -c -o project_1.o srcs/project_1.c
	arm-linux-gnueabihf-gcc $(CFLAGS) -c -o memory.o srcs/memory.c
	arm-linux-gnueabihf-gcc -o Project1 $(OBJS)

build-host : $(OBJS) 
	$(CC) -o Project1 -Wl,-Map=main.map $^ $(CFLAGS)

compile-all : $(SRCS)
	$(CC) $(CFLAGS) -c -o main.o srcs/main.c 
	$(CC) $(CFLAGS) -c -o data.o srcs/data.c
	$(CC) $(CFLAGS) -c -o project_1.o srcs/project_1.c
	$(CC) $(CFLAGS) -c -o memory.o srcs/memory.c

objdmp-main.o : main.o
	objdump -D $^

objdmp-data.o : data.o
	objdump -D $^
	
objdmp-project_1.o : project_1.o
	objdump -D $^
	
objdmp-memory.o: memory.o
	objdump -D $^
	
build-lib : data.c memory.c
	ar cr libproj1.a $(A)data.c $(A)memory.c

clean : 
	 $(RM) *.o \
	 $(RM) *.i\
	 $(RM) *.s \
	 $(RM) Project1 \
	 $(RM) libproj1.a \
	 $(RM) *.dep *.map
