#include <stdio.h>
#include "byteArray.h"

//printf of %x(hexadecimal)
void byte_print_hex( const byte a ){
printf("%x ",a );

}
//for loop travels through each byte and prints the binary position:
//(a >> i) & 1
void byte_print_binary( const byte a ){
  for (int i = 7; i >=0; i--)
  {
    printf("%d", (a >> i) & 1);
  }
}
//travels through a, if x & 1 returns true
//then count is updated
int byte_count_ones( const byte a ){
  int count = 0;
  int x = a;
  while(x){
    if ((x & 1) == 1){
      count++;
    }
    x = (x >> 1);
  }
  return count;
}
// calls bitwise and(&) on byte a, in comparsion to x and y
void byte_and( byte *a, const byte x, const byte y ){
  *a = x & y;
}
// last bit of (a << 7) all others shift left >> 1
void byte_rotate_right( byte *a ){
  *a =(byte) ((*a >> 1 | *a << 7));

}


// Prints all elements in the array A in hexadecimal.
// A[0] stores the highest-ordered bits.
// As with the practice question, each byte's hex
// value should be printed as two characters - meaning
// that leading 0s should be printed.  
void array_print_hex( const byte *A, int n ){
  for(int i = 0; i < n; i++){
    byte_print_hex(A[i]);
  }
}




// Prints all elements in the array A in binary.
// Print from the highest-order bits to the lowest-order bits.
// A[0] stores the highest-order bits.
void array_print_binary( const byte *A, int n ){
  for(int i = 0; i < n; i++){
    byte_print_binary(A[i]);
    printf(" ");
    }
  
}



// Count the number of 1-bits (bits in array A that are 1).
int array_count_ones( const byte *A, int n ){
  int count = 0;
  int i = 0;
  while(i < n){
    count += byte_count_ones(A[i]);
    i++;
  }
  return count;
}




//Performs "bit-wise and" operation on array X and array Y
void array_and( byte *A, const byte *X, const byte *Y, int n ){
   for(int i = 0; i < n; i++){
     byte_and(&A[i],X[i],Y[i]);
  } 
}


//Rotates array A bit-wise to the right.
//Note that this is not simply a bit-shift.
//uses two bytes to shift over the bits to the rest of the array elements
//and carries them last item to front
void array_rotate_right( byte *A, int n ){
  unsigned char bts2;
  unsigned char bts1;
  for(int i = 0; i < n; i++){
    bts2 = A[i] & 0x07;
    A[i] >>= 1;
    A[i] |= bts1 << 7;
    bts1 = bts2;
  }
}
