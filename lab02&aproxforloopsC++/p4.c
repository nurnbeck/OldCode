#include <stdio.h>

int factorial(int i)
{
  if (i == 0)
    return 1;
  else
    return(i * factorial(i-1));
}

double pow(double x, int i){
  int y = 0;
  double temp = x;
  while (y<i){
    x = x*temp;
    y++;
  }
  return x;
}

int compare(){
  //check if temp+temp & temp are approximately =
}

  
int main()
{
  double x = 3.1415936535;
  double temp = 1;
  int i = 1;
  count = 1;
  long int i = 1
    while ((temp+temp) != temp){
      temp -= (pow(x,i)/factor(i))
      if ((count%2) == 0){
        temp -= (pow(x,i)/factorial(i));
      }
      else{
        temp += (pow(x,i)/factorial(i));
      }
    }
  printf("mycos(%lf) = %lf \n",x,temp)
  return 0;
}
