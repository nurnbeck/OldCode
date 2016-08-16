#include <stdio.h>

int main()
{
  const int val_max = 6;

  int x = 4;

  int count = 0;
  //checks for numbers less than 5 proprly
  if (val_max <= 4) {
    printf("val_max = %d %d \n", val_max, count);
    return 0;
  }
  while (x < val_max )
    {
      if ((x % 2) == 0) {
	count++;
	++x;
      } else if ((x % 3) == 0) {
	count++;
	++x;
      } else {
	++x;
      }
    }
  printf("val_max = %d %d \n",val_max, count);
  return 0;
}
