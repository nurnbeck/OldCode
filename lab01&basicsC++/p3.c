#include <stdio.h>

int main()
{
  unsigned int y = 1023;
  unsigned int k = 1;
  while(k*k <= 2*y)
  {
    k++;

  }
  printf("%d \n", k-1 );
  return 0;
}
