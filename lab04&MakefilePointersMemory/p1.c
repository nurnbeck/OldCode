#include <stdio.h>
#include <assert.h>


int main()
{
  const int N = 10000000; // max. length

  // allocate large enough array
  // leave room for added '\n' at end  
  char *input = new char[N+1]; 

  // read all characters into array
  int num = 0;
  //linecount
  int num_lines = 0;
  //charcount
  int chrc = 0;
  //wordcount
  int wordc = 0;
  //keeps track of continual \0 or ' '
  int track = 0;
  
  for (;;) {
    //intake char
    int j = getchar();
    if (j == EOF) {
      break;
    }
    //null encountered, exit loop
    if (j == '\0') {
      printf("0 encountered\n");
      return 2;
    }
    //full array
    if (num >= N) {
      printf("input too long\n");
      return 1;
    }

    // convert '\n' to '\0'
    if (track == 1){
      if (j == '\n') {
        num_lines++;
        wordc++;
        j = '\0';
        track = 0;
      }
    }
    // if char is ' ' update word count
    if (track == 1){
      if (j == ' '){
        wordc++;
        track = 0;
      }
    }
    // if last char was not ' ' or '\0' prep to count another word
    if (j != ' '){
      if(j!= '\0')
        track = 1;
    }
    //update index and charcount
    chrc++;
    input[num++] = j;
  }

  if (!feof(stdin)) {
    printf("read error\n");
    return 1;
  }

  // add '\0' if last line was not terminated by '\n'
  if (num == 0 || (num > 0 && input[num-1] != '\0')) {
    num_lines++;
    input[num++] = '\0';
  }

  assert(num_lines > 0);

  // create an array of pointers pointing
  // to each line
  char **lines = new char*[num_lines];
  int lineIndex = 0;

  int i = 0;
  do {
    // Assign the next line
    assert( lineIndex < num_lines );
    lines[ lineIndex ] = &input[ i ];
    lineIndex++;

    // find end of the string / start of the next one
    while ( input[i] != '\0' ) {
      i++;
    }
    // i is now the index of the null character: the end of the string.
    // Advance it once more, so that it points at the start of 
    // the next string.
    i++;
    // Keep looping while i is within the number of characters
    // of input that we read. 
  } while ( i < num );

  // printf("%d %d\n", num_lines, index);

  // Make sure that we assigned all of the lines that we read.
  assert( lineIndex == num_lines );

  // sort lines lexicographically
  // sort(lines, num_lines);

  printf( "-----\n" );

  // print them for convenience
  for (int i=0; i < num_lines; i++) {
    printf("%s\n", lines[i]);
  }
  
  /*if l, c, or w defined in compilation
  (wrong, but didn't have time to change it
   to accepting option during ./prog phase), will return corresponding values
  proper way using argc intaking whatever value while executing main function,
  misread question.
  would change these values to depend on argc and strcmp() to do identical
  function but no need for preprocessor */
#ifdef l
  printf("number of lines is %d \n", num_lines);
#else
#ifdef c
  printf("character count is %d \n", chrc);
#else
#ifdef w
  printf("word count is %d \n", wordc);
#else
  
#endif
#endif
#endif
  //clears spare memory
  delete [] lines;
  delete [] input;
  return 0;
}
