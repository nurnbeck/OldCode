#include <stdio.h>

double pow(double x, unsigned int y){
  y--;
  int temp = 0;
  double pow = x;
  while (temp < y){
    x = x*pow;
    temp++;
  }
  return x;
}

int main()
{
  double x = 4;
  unsigned int y = 2;
  double action = pow(x,y);
  printf("%.0lf \n", action);
  return 0;
}
