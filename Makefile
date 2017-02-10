#include sample.mk
CC= gcc
CLAGS = -Wl,map=main.map 
SRCS = main.c \	
	   data.c \
	   memory.c \
	   project_1.c
FLAGS= -g\
		-Werror \
		-std=c99
		
OBJS = $(SRCS:.c=.o)

.PHONY : all

all : main.out

main.out : $(OBJS)
	$(CC) -g -$(CFLAGS) -o $@ $^
	
main.o : main.c project_1.h 
	$(CC) $(FLAGS) -c -o $@ main.c
	
data.o :data.c data.h
	$(CC) $(FLAGS)-c -o $@ data.c 
	
memory.o : memory.c memory.h
	$(CC) $(FLAGS) -c -o $@ memory.c

project_1.o : project_1.c project_1.o
	$(CC) $(Flags) -c -o $@ project_1.c
	
	
.PHONY : clean

clean :
	rm main.map $(OBJS) main.out
	



	
