#include <stdio.h>

int main()
{
  int n = 365, sum = 0, remainder;
 
   while(n != 0)
   {
      remainder = n % 10;
      sum = sum + remainder;
      n = n / 10;
   }
 
   printf("Sum of digits of number = %d\n",sum);
 
   return 0;
}
