// util.hpp
// Utility functions for creating a hash table of strings
// Mike Johanson, October 30, 2014

// Process a string: convert it to lowercase,
// remove punctuation.
void processString( char *str );

// Hash a string into a value: returns an
// unsigned int in [0,n).
// Preconditions: str is a null-terminated string
unsigned int hashString( const char *str, const unsigned int n );

