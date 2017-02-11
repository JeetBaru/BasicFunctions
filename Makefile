#!/bin/bash
#include sample.mk 

#host=Host Linux VM platform
#bbb=BeagleBone platform
#frdm=FRDMKL25z platform
ifeq ($(ARCH), BBB)
	CC = arm-linux-gnueabihf-gcc
	REMOTE_PATH = debian@192.168.7.2 :/home/debian/bin
	else
	CC = gcc
endif

ifeq ($(ARCH), FRDM)
	CC = arm-none-eabi-gcc
endif

CFLAGS = -Wl,-Map=main.map
INCLUDES = -I./Cfiles \
           -I./hfiles
           
FLAGS = -g \
		-Werror \
		-std=c99


 		 
#SRCS = Cfiles/main.c \	
#	   Cfiles/data.c \
#	   Cfiles/memory.c \
#	   Cfiles/project_1.c

#OBJS = $(SRCS:.c=.o)

#.PHONY : all

#all

main.out : main.o data.o memory.o project_1.o
	$(CC) $(FLAGS)  -o $@  $^


%.i : %.c
	$(CC) project_1.h -E $^ -o $@

%.o : %.c
	$(CC) -c $^ -o $@

%.s : %.c
	$(CC) -S $^ -o $@



	



	
.PHONY : clean

clean :
	 rm -rf main.out \ 
	 rm -rf *.o
	 rm -rf *.i
	 rm -rf *.s
	 
	



	
