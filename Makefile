#!/bin/

#host=Host Linux VM platform
#bbb=BeagleBone platform
#frdm=FRDMKL25z platform
ifeq ($(ARCH), BBB)
	CC = arm-linux-gnueabihf-gcc
	CFLAGS= -mcpu=comrtex-a8  -Wll -Werror -g -08 -std=c99 -c
	REMOTE_PATH = debian@192.168.7.2 :/home/debian/bin
	else
	CC = gcc
endif

ifeq ($(ARCH), FRDM)
	CC = arm-none-eabi-gcc
	CFLAGS = -mcpu
endif

CFLAGS = -g  \
		  -Werror \
		  -std=c99
INCLUDES = -I./Cfiles \
           -I./hfiles
Headers= project_1.h data.h memory.h
           
#FLAGS = -g \
		-Werror \
		-std=c99


 		
SRCS = main.c data.c memory.c projet_1.c
OBJS = main.o data.o memory.o project_1.o

.PHONY : all

all : main.out

			

main.out : $(OBJS)
	$(CC) -o $@  $^ 


%.i : %.c 
	$(CC) -E $^ -o $@

%.o : %.c 
	$(CC) -c $^ -o $@

%.s : %.c 
	$(CC) -S $^ -o $@

%.dep : %.c
	$(CC) -M $^ -o $@

sample.mk :
	mkdir sample.mk/
	mv *.o sample.mk
	mv *.c sample.mk

build : $(OBJS)
	$(CC) -Wl,-Map=main.map $(Headers) $^ $(FLAGS)

compile-all : $(OBJS)
	$(CC) $(Headers) $(CFLAGS) $^
	rm -rf a.out
	


	
.PHONY : clean

clean :
	 rm -rf main.out \ 
	 rm -rf *.o \
	 rm -rf *.i\
	 rm -rf *.s \
	 rm -rf *.gch \
	 rm -rf a.out
	 
	 
	



	
