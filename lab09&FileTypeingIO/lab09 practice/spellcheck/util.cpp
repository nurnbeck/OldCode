// util.cpp
// Utility functions for creating a hash table of strings
// Mike Johanson, October 30, 2014

#include <stdio.h>
#include <assert.h>

// Prime number constant used for hashing strings
#define HASH_MULT 31

// Removes the character pointed at by str.
// Moves subsequent chars in the string to the left
// until a null character is found
static void deleteShiftLeft( char *str )
{
  // Function shouldn't be called with a NULL string
  assert( str != NULL );
  // Function shouldn't be called to remove a null character
  assert( *str != '\0' );
  
  char *p = str;
  while( *p != '\0' ) {
    // Replace this character with the next one
    *p = *(p+1);
    // Advance the pointer
    p++;
  }
}

void processString( char *str )
{
  // Function shouldn't be called with a NULL string
  assert( str != NULL );
  // Function shouldn't be called to remove a null character
  assert( *str != '\0' );

  char *p = str;
  // Loop until we find the null character
  while( *p != '\0' ) {

    // Is *p uppercase?  Convert to lowercase
    if( ( *p >= 'A' ) && ( *p <= 'Z' ) ) {
      *p = (char)(( *p - 'A' ) + 'a');
    }

    // Is *p anything but a lowercase letter or a dash?
    // If so, remove it.
    if( ( ( *p < 'a' ) || ( *p > 'z' ) ) &&
	( *p != '-' ) &&
	( *p != '\'' ) ) {
      deleteShiftLeft( p );
    }
    else {
      p++;
    }
  }
}

// Take a string, and quickly produce an unsigned int "hash"
// number, in the range [0,n).  
// The goal is for all of the words we input to hash
// to different values, fairly evenly spread across that range.
// In our function below, we do this by multiplying each
// character with a HASH_MULT constant, 31.
// For good performance, n and HASH_MULT should be co-prime.
unsigned int hashString( const char *str, const unsigned int n )
{
  unsigned int hash = 0;
  const char *p;

  assert( str != NULL );
  
  for( p = str; *p != '\0'; p++ ) {
    hash = (HASH_MULT * hash + (unsigned int)(*p));
  }

  return ( hash % n );
}
