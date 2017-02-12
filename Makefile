#!/bin/
#include srcs.mk
#host=Host Linux VM platform
#bbb=BeagleBone platform
#frdm=FRDMKL25z platform
ifeq ($(ARCH), BBB)
	CC = arm-linux-gnueabihf-gcc
	CFLAGS= -mcpu=cortex-a8  -Wll -Werror -g -08 -std=c99 -c
#	REMOTE_PATH = debian@192.168.7.2 :/home/debian/bin
	else
	CC = gcc
	CFLAGS = -g -Werror -std=c99
endif

ifeq ($(ARCH), FRDM)
	CC = arm-none-eabi-gcc
	CFLAGS = -mcpu=cortex-m0plus -Werror -g -std=c99 -c
endif


		  
INCLUDES = -I./Cfiles \
           -I./hfiles
           
Headers= project_1.h data.h memory.h
           
FLAGS = -g \
		-Werror \
		-std=c99


 		
SRCS = main.c data.c memory.c project_1.c
OBJS = main.o data.o memory.o project_1.o



.PHONY : all

all : main.out

			

main.out : $(OBJS)
	$(CC) -o $@ $(CFLAGS) $^ 


%.i : %.c 
	$(CC) -E $^ -o $@

%.o : %.c 
	$(CC) -c $^ -o $@

%.s : %.c 
	$(CC) -S $^ -o $@

%.dep : %.c
	$(CC) -M $^ -o $@
	
build-FRDM:
	arm-none-eabi-gcc -o Project1 -c -o main.o main.c 
	arm-none-eabi-gcc -o Project1 -c -o data.o data.c 
	arm-none-eabi-gcc -o Project1 -c -o project_1.o project_1.c 
	arm-none-eabi-gcc -o Project1 -c -o memory.o memory.c 
	arm-none-eabi-gcc -o Project1 $(OBJS) -specs=nosys.specs
	
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
	 rm -rf main.out \ 
	 rm -rf *.o \
	 rm -rf *.i\
	 rm -rf *.s \
	 rm -rf Project1
	 
	 
	



	
