#include "project_1.h"
#include "memory.h"
#include "data.h"

void project_1_report()
{
	test_data1();
	test_data2();
	test_memory();
}
void test_data1()
{
	uint8_t set_1[] = {0x0,0x1,0x2,0x3,0x4,0x5,0x6,0x7,0x8,0x9,0xA,0xB,0xC,0xD,0xE,0xF,0x0,0x1,0x2,0x3,0x4,0x5,0x6,0x7,0x8,0x9,0xA,0xB,0xC,0xD,0xE,0xF};
	uint8_t * ptr = set_1;
	uint32_t * pt = (uint32_t *)set_1;
	printf("Test data 1\nInitial Data\n");
	print_memory( ptr, 32);
	printf("\nData after Big to Little\n");
	big_to_little32(pt,8);
	print_memory( ptr, 32);
	printf("\nData After Little to Big\n");
	little_to_big32(pt,8);
	print_memory( ptr, 32);
}
void test_data2()
{
	int8_t set_2[]= {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31};
	int8_t * ptr = set_2;
	int8_t c[34];
	int8_t j;
	int8_t i=1;
	int8_t * dest=c;
	int32_t base=10;
	int32_t dat = 0;
	int32_t l=0;
	printf("\n\n\nTest Data 2\n");
	for(i=0;i<8;i++)
	{
		for(j=0;j<4;j++)
		{
			dat=dat<<8;			
			dat=dat+*ptr;			
			ptr++;
		}
		
		printf("%d 4 Byte Data %x  \n ASCII Converted Data, Base = %d\n",i,dat,base);
		dest=my_itoa(dest, dat, base);
		while(dat!=0)
		{
			l=l+1;
			dat/=base;
		}
		print_memory((uint8_t *)dest, l+1);
		printf("\n Decimal value of given ASCII string: ");
		dat=my_atoi(dest);
		printf("%d\n",dat);
		l=0;
	}
}
void test_memory()
{
	uint8_t set_2[]= {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31};
	uint8_t * ptr = set_2;
	printf("\n\n\nInitial Data\n");
	print_memory(ptr,32);
	printf("\n");
	my_rev(ptr,12);
	my_memset(ptr+15, 4, 0xEE);
	my_memmov(ptr + 25, ptr + 19, 6);
	my_memzero(ptr + 11,5);
	my_memmov(ptr,ptr+8,8);
	printf("Data after manipulations \n");
	print_memory(ptr,32);
}	
		

