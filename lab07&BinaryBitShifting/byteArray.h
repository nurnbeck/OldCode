#pragma once

typedef unsigned char byte;

// Prints all elements in the array A in hexadecimal.
void array_print_hex( const byte *A, int n );

// Prints all elements in the array A in binary.
void array_print_binary( const byte *A, int n );

// Count the number of 1-bits (bits in array A that are 1).
int array_count_ones( const byte *A, int n );

//Performs "bit-wise and" operation on array X and array Y
void array_and( byte *A, const byte *X, const byte *Y, int n );

//Rotates array A bit-wise to the right
void array_rotate_right( byte *A, int n );
