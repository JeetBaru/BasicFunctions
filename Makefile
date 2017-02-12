#!/bin/
#host=Host Linux VM platform
#bbb=BeagleBone platform
#frdm=FRDMKL25z platform

include sources.mk
ifeq ($(ARCH), BBB)
		CC = arm-linux-gnueabihf-gcc
		CFLAGS= -Wall -Werror -g -std=c99 
else

		CC = gcc
		CFLAGS = -g -Werror -std=c99
#	REMOTE_PATH = debian@192.168.7.2 :/home/debian/bin
endif

ifeq ($(ARCH), FRDM)
	CC = arm-none-eabi-gcc
	CFLAGS = -Werror -g -std=c99 -specs=nosys.specs
endif

FILE_SIZE = stat -c %s $@

RM = rm -rf 

Headers= project_1.h data.h memory.h
           
OBJS = main.o data.o memory.o project_1.o



.PHONY : all

all : main.out	

main.out : $(SRCS)
	$(CC) -o $@ $(CFLAGS) $^ 
	$(FILE_SIZE)

Preprocessor: 
	$(CC) -E main.c -o main.i
	$(CC) -E memory.c -o memory.i
	$(CC) -E data.c -o data.i
	$(CC) -E project_1.c -o project_1.i
	
Assembly:
	$(CC) -S main.c -o main.s
	$(CC) -S data.c -o data.s
	$(CC) -S memory.c -o memory.s
	$(CC) -S project.c -o project.s
	
Dependancy:
	$(CC) -M main.c -o main.dep
	$(CC) -M data.c -o data.dep
	$(CC) -M memory.c -o memory.dep
	$(CC) -M project_1.c -o project_1.dep
%.i : %.c 
	$(CC) -E $^ -o $@

%.o : %.c 
	$(CC) -c $^ -o $@

%.s : %.c 
	$(CC) -S $^ -o $@

%.dep : %.c
	$(CC) -M $^ -o $@
	
build-FRDM:
	arm-none-eabi-gcc -o Project1 -c $(CFLAGS) main.o main.c 
	arm-none-eabi-gcc -o Project1 -c $(CFLAGS) data.o data.c 
	arm-none-eabi-gcc -o Project1 -c $(CFLAGS) project_1.o project_1.c 
	arm-none-eabi-gcc -o Project1 -c $(CFLAGS) memory.o memory.c 
	arm-none-eabi-gcc -o Project1 $(OBJS) 
	
build-BBB: 
	arm-linux-gnueabihf-gcc -o Project1 $(CFLAGS) -c -o main.o main.c 
	arm-linux-gnueabihf-gcc -o Project1 $(CFLAGS) -c -o data.o data.c
	arm-linux-gnueabihf-gcc -o Project1 $(CFLAGS) -c -o project_1.o project_1.c
	arm-linux-gnueabihf-gcc -o Project1 $(CFLAGS) -c -o memory.o memory.c
	arm-linux-gnueabihf-gcc -o Project1 $(OBJS)

build-host : $(OBJS)
	$(CC) -o Project1 -Wl,-Map=main.map $^ $(CFLAGS)

compile-all : $(SRCS)
	$(CC) $(CFLAGS) -c -o main.o main.c 
	$(CC) $(CFLAGS) -c -o data.o data.c
	$(CC) $(CFLAGS) -c -o project_1.o project_1.c
	$(CC) $(CFLAGS) -c -o memory.o memory.c

	
.PHONY : clean

clean :
	 $(RM) main.out \ 
	 $(RM) *.o \
	 $(RM) *.i\
	 $(RM) *.s \
	 $(RM)Project1 \
	 $(RM) main.out
	 
	 
	



	
