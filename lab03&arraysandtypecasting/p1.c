#include <stdio.h>
#include <string.h>


int main()
{
  int c;
  int count = 1;
  int largest = 0;
  int smallest = 0;
  int res;
  while( ( res = scanf("%d", &c) ) != EOF)
  {
    //check if it is a int or not
    if (res != 1){
      printf("corrupt input\n");
      break;
    }
    //update largest/smallest if len = 1
    else if (count == 1){
      smallest = c;
      largest = c;
      count++;
      }
    //update largest
    else if (largest < c){
      largest = c;
      count++;
    }
    //update smallest
    else if (smallest > c){
      smallest = c;
      count++;
    }
  
  }
  printf("%d %d are smallest and largest \n", smallest, largest);
  return 0;
}
