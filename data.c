#include "data.h"

int8_t * my_itoa(int8_t * str, int32_t data, int32_t base)
{
	int8_t count=0;
	int32_t rem,d;
	d=data;
	if(str == '\0')
	{
		return 0;
	}
	if(base<=1 || base>36)
	{
		return 0;
	}
	else
	{
		while(d!=0)
		{
			count++;
			d=d/base;
		}
		if(data>=0)
		{
			*str='+';
		}
		else
		{
			*str='-';
			data=-data;
		}
		str=str+count+1;
		*str='\0';
		str--;
		while(count>0)
		{
			rem=data%base;
			if(rem<10)
			{
				*str=0x30+rem;
			}
			else
			{
				*str=0x41+rem-10;
			}
			data=data/base;
			str--;
			count--;
		}
	}
	return str;
}
int32_t my_atoi(int8_t * str)
{
	int32_t data=0;
	int8_t sign=1;
	int8_t * ptr;
	ptr=str;
	int8_t c=0,k=0;
	if(str == '\0')
	{
		return 0;
	}
	while(*ptr!='\0')
	{
		if((*ptr>=0x30 && *ptr <=0x39) || (*ptr=='-') || (*ptr=='+'))
		{
			c++;
		}
		k++;
		ptr++;
	}
	if(c!=k)
	{
		return 0;
	}
	else
	{
		if(*str=='-')
		{
			sign=-1;
			str++;
		}
		else if(*str=='+')
		{
			sign=1;
			str++;
		}
		else
		{
			sign=1;
		}
		while(*str!='\0')
		{
			data=data*10+((int)(*str)-48);
			str++;
			if(data>214748364 && *str!='\0')
			{
				return 0;
			}
		}
		return sign*data;
	}
}
int8_t big_to_little32(uint32_t * data,uint32_t length)
{
	if( !data )
	{
		return 0;
	}
	uint8_t * p;
	p=(uint8_t *)data;
	uint32_t i,temp;
	for(i=1;i<=length;i++)
	{
		temp=*p;
		*p=*(p+3);
		*(p+3)=temp;
		temp=*(p+1);
		*(p+1)=*(p+2);
		*(p+2)=temp;
		p=p+4;
	}
	return 1;
}

int8_t little_to_big32(uint32_t * data,uint32_t length)
{
	uint8_t * p;
	p=(uint8_t *)data;
	uint32_t i,temp;
	if( !data )
	{
		return 0;
	}
	for(i=1;i<=length;i++)
	{
		temp=*p;
		*p=*(p+3);
		*(p+3)=temp;
		temp=*(p+1);
		*(p+1)=*(p+2);
		*(p+2)=temp;
		p=p+4;
	}
	return 1;
}
void print_memory(uint8_t * start, uint32_t length)
{
	while(length>0)
	{
		printf("%x ",*start);
		start++;
		length--;
	}
}
