#include <ctype.h>
#include "string.h"
#include <stdio.h>




void to_upper(char *s)
{
// convert all characters in a string s
// into upper case
  while (*s){
    toupper(*s);
    s++;
  }
}


int vowel_count(const char *s)
{

  int count = 0;

  while(*s) {
    switch(s) {
    case 'A':
    case 'E':
    case 'I':
    case 'O':
    case 'U':
      count++;
      break;
    default;
    break;
    }
    return count;
  }
}




bool empty(const char *s)        // returns true if and only if a string is empty
{
  //checks if fist char is "\0" returns True/False
  return (*s == 0);
  }
}
void print_os()
{
// prints the operating system the application
// is compiled for:
// - if macro UNIX is defined, print UNIX to standard output (screen),
// - else if macro WINDOWS is defined, print WINDOWS,
// - otherwise, print UNKNOWN
// Hint: Course Notes Part 4 Page 8
#ifdef WINDOWS
  printf("WINDOWS \n");
#else
#ifdef UNIX
  printf("UNIX \n");
#else
  printf("UNKNOWN \n");
#endif
#endif
}
