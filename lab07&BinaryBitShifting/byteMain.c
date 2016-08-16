#include <stdio.h>
#include "byteArray.h"


int main()
{

  // example test cases
  printf("===\n");
  byte A[] = {100, 101};
  printf("Array in hex:\n");
  array_print_hex(A,2);  // should be 64 65
  printf("\n");

  printf("===\n");
  A[0] = 100; A[1]=  102;
  printf("Array in binary:\n");
  array_print_binary(A,2);  // should be 01100100 01100110
  printf("\n");

  printf("===\n");
  int count = array_count_ones(A,2);
  printf("The number of 1-bits in Array is: %d\n", count); // should be 7

  printf("===\n");
  byte X[] = {100, 102};
  byte Y[] = {120, 130};
  array_and(A, X, Y, 2);
  printf("X is   :\n");
  array_print_binary(X,2);
  printf("\n");
  printf("Y is   :\n");
  array_print_binary(Y,2);
  printf("\n");
  printf("X&Y is :\n");
  array_print_binary(A,2); // should be 01100000 00000010
  printf("\n");

  printf("===\n");
  byte B[] = {100, 101, 102};
  printf("Array is: \n" );
  array_print_binary(B,3);
  printf("\n");
  printf("Rotated : \n" );
  array_rotate_right( B ,3 );
  array_print_binary(B,3);
  printf("\n");

  // additional test cases:

  //empty and all ones for count_one bit function
  byte N[] = {100, 101, 255, 0 , 0, 255, 255};
  printf("===\n");
  count = array_count_ones(N,7);
  printf("The number of 1-bits in Array is: %d\n", count); // should be 7

  //rollover off last element of array of bytes
  //off te end of the array onto first spot
  // 1 = 000000001
  printf("===\n");
  byte D[] = {50, 101, 1};
  printf("Array is: \n" );
  array_print_binary(D,3);
  printf("\n");
  printf("Rotated : \n" );
  array_rotate_right( D ,3 );
  array_print_binary(D,3);
  printf("\n");
  
  
  return 0;
}
