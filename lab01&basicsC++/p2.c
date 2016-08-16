#include <stdio.h>

int main()
{
  int x = 25;  // set to different values to test your program
  int j = 2;
  int count = 0;
  while (j <= x) {
    if ((x % j) == 0) {
      ++count;
      ++j;
    }
    else {
      ++j;  
    }
  }

  printf("%d can be divided by %d number(s)\n", x, count);
  return 0;
}
