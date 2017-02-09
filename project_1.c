#include "project_1.h"

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
	uint32_t * pt = set_1;
	print_memory( ptr, 32);
	big_to_little32(pt,8);
	print_memory( ptr, 32);
	little_to_big32(pt,8);
	print_memory( ptr, 32);
}
void test_data2()
{
	uint8_t set_2[]= {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31};
	uint8_t * ptr = set_2;
	uint32_t * pt = set_2;
	for(i=1;i<8;i++)
	{
		my_itoa(ptr, *pt, 10);
		print_memory(ptr,5);
		my_atoi(ptr);
		print_memory(ptr,4);
		ptr=ptr+4;
		pt++;
	}
}
void test_memory()
{
	uint8_t set_2[]= {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31};
	uint8_t * ptr = set_2;
	print_memory(ptr,32);
	rev(ptr,12);
	my_memset(ptr+16, 4, 0xEE);
	my_memmov(ptr + 26, ptr + 20, 6);
	print_memory(ptr,32);
}	
		

