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
	print_memory( ptr, 32);
	printf("\n");
	big_to_little32(pt,8);
	print_memory( ptr, 32);
	printf("\n");
	little_to_big32(pt,8);
	print_memory( ptr, 32);
}
void test_data2()
{
	uint8_t set_2[]= {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31};
	uint8_t * ptr = set_2;
	uint8_t c[34];
	uint8_t j;
	uint8_t i=1;
	uint8_t * dest=c;
	uint32_t base=8;
	uint32_t dat = 0;
	uint32_t l=0;
	for(i=0;i<8;i++)
	{
		for(j=0;j<4;j++)
		{
			dat=dat<<8;			
			dat=dat+*ptr;			
			ptr++;
		}
		printf("%x  \n",dat);
		dest=my_itoa(dest, dat, base);
		while(dat!=0)
		{
			l=l+1;
			dat/=base;
		}
		print_memory(dest, l+1);
		printf("\n");
		dat=my_atoi(dest);
		printf("%d\n",dat);
		l=0;
	}
}
void test_memory()
{
	uint8_t set_2[]= {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31};
	uint8_t * ptr = set_2;
	print_memory(ptr,32);
	printf("\n");
	rev(ptr,12);
	my_memset(ptr+15, 4, 0xEE);
	my_memmov(ptr + 25, ptr + 19, 6);
	my_memzero(ptr + 11,5);
	my_memmov(ptr,ptr+8,8);
	print_memory(ptr,32);
}	
		

