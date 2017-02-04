# include<stdint.h>

int8_t my_memmov(uint8_t * scr, uint8_t * dest,uint32_t length)
{
	int8_t i;
	if((!scr) || (!dest))
	{
		return 1;
	}
	if(scr<dest)
	{
		for(i=0;i<length;i++)
		{
			*(dest+i)=*(scr+i);
			*(scr+i)=0;
		}
	}
	else
	{
		for(i=length-1;i>=0;i--)
		{
			*(dest+i)=*(scr+i);
			*(scr+i)=0;
		}		
	}
	return 0;
}

int8_t my_memset(uint8_t * scr, uint32_t length,uint8_t value)
{
	int8_t i;
	if(!scr)
	{
		return 1;
	}
	for(i=0;i<length;i++)
	{
		*(scr+i)=value;
	}	
	return 0;	
}

int8_t my_memzero(uint8_t *scr, uint32_t length)
{
	int8_t i;
	if(!scr)
	{
		return 1;
	}
	for(i=0;i<length;i++)
	{
		*(scr+i)=0;
	}
	return 0;
}
char rev(char * ptr,int length)
{
	length=length-1;
	int l;
	if(length%2==0)
	{
		l=length/2;
	}
	else
	{
		l=(length-1)/2;
	}
	char i;
	char temp;
	for(i=0;i<=l;i++)
	{
		temp=*(ptr+i);
		*(ptr+i)=*(ptr+length-i);
		*(ptr+length-i)=temp;
	}
}
