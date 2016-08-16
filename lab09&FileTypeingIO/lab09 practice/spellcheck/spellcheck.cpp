// spellcheck.cpp
// A simple spell-checking program,
// powered by a hash table.
// Mike Johanson, October 30, 2014

#include <stdio.h>
#include <assert.h>
#include <string.h>
#include <sys/time.h>
#include <string>
#include <unordered_set>
// LAB 09
// Include the STL "unordered_set" and "string" headers here.
// The C++ STL header files don't require an extension - no .h or .hpp
// at the end of the name.





using namespace std;

// Include our own util.hpp, for processing strings
#include "util.hpp"

// 'words' is a dictionary file: one word on each line.
// .  It's at this path on Mac OSX and
// the lab computers.  If compiling and running this program elsewhere,
// make sure this file exists.
//
// For testing, try making a replacement file in your own filespace,
// fill it with 4-5 words (one per line), and change
// dictionaryPath to the name of your replacement file.
const char *dictionaryPath = "/usr/share/dict/words";


int main( const int argc, const char *argv[] )
{
  if( argc != 2 ) {
    printf( "Usage: ./spellcheck <file>\n" );
    return 1;
  }

  // LAB 09
  // For RA 9, we designed our own hash table class and created
  // it here.  For this exercise, we will instead use the STL
  // unordered_set type, which is a templated hash table.
  // On the next line, create an unordered_set object
  // with the template type <string>, called 'dictionary'.
  // string is a C++ STL type, similar to C-strings, but which
  // can be easily copied, assigned with the = operator, and so on.
  unordered_set<string> dictionary;


  printf("Loading dictionary file [%s]...\n", dictionaryPath );
  struct timeval dictStart;
  gettimeofday( &dictStart, NULL );

  // Open the dictionary file, add words
  FILE *stream = fopen( dictionaryPath, "r" );
  if( stream == NULL ) {
    printf( "Couldn't open dictionary file [%s]\n", dictionaryPath );
    return 1;
  }

  // Add words
  char buffer[ 1000 ];
  char copy[ 1000 ];
  while( fgets( buffer, 1000, stream ) != NULL ) {
    // process the string - convert to lowercase, remove
    // punctuation.
    processString( buffer );

    // LAB 09
    // Here, we have just processed a C-string, stored in 'buffer'.
    // We need to add it into the unordered_set 'dictionary' 
    // that we created earlier.
    // This can be done by calling dictionary's "insert"
    // function.  The insert function takes an STL string, 
    // but if we pass it a C-string such as the one stored 
    // in 'buffer', an STL string object will automatically 
    // be constructed.
    dictionary.insert(buffer);

  }
  
  // Close dictionary
  fclose( stream );

  struct timeval dictEnd;
  gettimeofday( &dictEnd, NULL );
  double dictLoadTime = (double)(dictEnd.tv_sec - dictStart.tv_sec) + (double)(dictEnd.tv_usec - dictStart.tv_usec) / 1000000.0;

  // LAB 09
  // We can call the dictionary's size() function to find out
  // how many words it contains.  Use that to set the value
  // of numEntries below.

  unsigned int numEntries = (int) dictionary.size();




  printf("Dictionary loaded (%u words).  Load took %lf seconds.\n", numEntries, dictLoadTime );

  printf("\nSpellchecking file [%s]\n", argv[ 1 ] );

  struct timeval spellStart;
  gettimeofday( &spellStart, NULL );

  unsigned int numWords = 0;
  unsigned int numTypos = 0;
  // Open input file, check contents
  stream = fopen( argv[ 1 ], "r" );
  while( fscanf( stream, "%1000s", buffer ) != EOF ) {
    strncpy( copy, buffer, 1000 );
    processString( buffer );
    // After processing, is the word non-empty?
    if( buffer[ 0 ] != '\0') {
      numWords++;

      // LAB 09
      // On this line, we have to find out if the word
      // stored as a C-string in 'buffer' is in our
      // dictionary.  We can do this by calling 
      // dictionary's 'find' function, which takes an
      // STL string.  As with insert(), if we pass it a
      // C-string such as the one stored in buffer,
      // an STL string will automatically be constructed.
      // If find() successfully finds the word, it returns
      // an iterator that points at it.  If it does not
      // contain the word, it returns an iterator equal
      // to dictionary's end iterator.  
      //
      // If the word is not in the dictionary, print it
      // to the screen and increment 'numTypos'.
      if(dictionary.find(buffer) == dictionary.end()){
        numTypos++;
        printf(" [%s], originally [%s] \n", buffer, copy );
      }

    }
  }
  fclose( stream );
  
  struct timeval spellEnd;
  gettimeofday( &spellEnd, NULL );
  double spellTime = (double)(spellEnd.tv_sec - spellStart.tv_sec) + (double)(spellEnd.tv_usec - spellStart.tv_usec) / 1000000.0;
  
  printf("Spellcheck complete: %u words and %u errors.  Took %lf seconds\n", numWords, numTypos, spellTime );

  return 0;
}


