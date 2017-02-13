#include "project_1.h"
#include "memory.h"
#include "data.h"
# include <stdint.h>

//This file is used to test and verify our functions defined in memory.c and data.c

void project_1_report()
{
	test_data1();										//Calls all test functions
	test_data2();
	test_memory();
}

void test_data1()
{
	uint8_t set_1[] = {0x0,0x1,0x2,0x3,0x4,0x5,0x6,0x7,0x8,0x9,0xA,0xB,0xC,0xD,0xE,0xF,0x0,0x1,0x2,0x3,0x4,0x5,0x6,0x7,0x8,0x9,0xA,0xB,0xC,0xD,0xE,0xF};
	uint8_t * ptr = set_1;
	uint32_t * pt = (uint32_t *)set_1;					//32 bit pointer is made to point at first 4 bytes of the array
	printf("Test data 1\nInitial Data\n");
	print_memory( ptr, 32);								
	printf("\nData after Big to Little\n");
	big_to_little32(pt,8);								//length passed is 8 as there are 8 such 4 byte data that can be passed
	print_memory( ptr, 32);
	printf("\nData After Little to Big\n");
	little_to_big32(pt,8);
	print_memory( ptr, 32);
}

void test_data2()
{
	int8_t set_2[]= {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31};
	int8_t * ptr = set_2;
	int8_t c[34];										//c is the destination of ascii converted string
	int8_t j;
	int8_t i=1;
	int8_t * dest=c;
	int32_t base=10;
	int32_t dat = 0;									//initialize data, 32 bit data passed, to be zero
	int32_t l=0;
	printf("\n\n\nTest Data 2\n");
	for(i=0;i<8;i++)
	{
		for(j=0;j<4;j++)								//Block generates 4 bytes data from given string
		{
			dat=dat<<8;									//left shift saves the current 8 bits and allows next bit to be added
			dat=dat+*ptr;								//next bit is added
			ptr++;										//pointer points to next bit
		}
		
		printf("%d 4 Byte Data %x  \n ASCII Converted Data, Base = %d\n",i+1,dat,base);
		dest=my_itoa(dest, dat, base);					//Destination address, 4 byte data, and base passed to itoa function
		while(dat!=0)									//Counts length of ascii string
		{
			l=l+1;
			dat/=base;									
		}
		print_memory((uint8_t *)dest, l+1);				//Prints ascii string
		printf("\n Decimal value of given ASCII string: ");
		dat=my_atoi(dest);								//Starting address of string is passed to obtain decimal data
		printf("%d\n\n",dat);				
		l=0;
	}
}

void test_memory()
{
	uint8_t set_2[]= {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31};
	uint8_t * ptr = set_2;
	printf("\n\n\nTest Memory \n Initial Data\n");		
	print_memory(ptr,32);								//Prints initial data set
	printf("\n");
	my_rev(ptr,12);										//reverses first 12 characters of array
	my_memset(ptr+15, 4, 0xEE);							//sets memory locations 15 - 19 of array to be EE  
	my_memmov(ptr + 25, ptr + 19, 6);					//moves data from location 25 to 19
	my_memzero(ptr + 11,5);								//sets value of next 5 locations from 11th position to be zero
	my_memmov(ptr,ptr+8,8);								//moves data from start to 8th location
	printf("Data after manipulations \n");
	print_memory(ptr,32);								//prints memory after manipulations
}	
		

