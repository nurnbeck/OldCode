#include <stdio.h>

//y counts up to x, if x passed, returns false
int is_power_of_2(unsigned int x, unsigned int y)
{
  if (y == x){
    return 1;}
  if (y > x){
    return 0;
  }
  else {
    is_power_of_2(x,y*2);
  }
}


int main()
{
  unsigned int x = 128;
  unsigned int y = 2;
  int q = is_power_of_2(x,y);
  if (q == 1){
    printf("is_power_of_2(%d) = true \n", x);
  }
  else{
    printf("is_power_of_2(%d) = False \n", x);
  }
  return 0;
}
