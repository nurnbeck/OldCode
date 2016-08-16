#include <stdio.h>
#include <stdlib.h>
#include <string.h>
 

// reads all bytes from *fp_in and writes them to *fp_out
void copy(FILE *fp_in, FILE *fp_out)
{
  //as long as feof() is before end of file
  //will continue to read in and write chars
  while(feof(fp_in) == 0){
    int input = getc(fp_in);
    fputc(input, fp_out);
  }
 

}


int main(int argc, char *argv[])
{

  // check to see if the arguments are valid
  if (argc != 3) {
    printf("parameters missing\n");
    exit(10);
  }
  
  if (!strcmp(argv[1], argv[2])) {
    printf("filenames need to be different\n");
    exit(10);
  }
  
  // open first file for read
  FILE *fp_in = fopen(argv[1], "r");
  if (!fp_in) {
    printf("can't open file %s\n", argv[1]);
    exit(10);
  }

  // open second file for write.
  // Automatically create second file if it does not exist
  FILE *fp_out = fopen(argv[2], "w");
  if (!fp_out) {
    printf("can't open file %s\n", argv[2]);
    exit(10);
  }

  // copy first file to second file
  copy(fp_in, fp_out);

  // Report errors
  if (ferror(fp_in) || ferror(fp_out)) {
    printf("read/write error\n");
    exit(10);
  }
  
  // Close both files
  if (fclose(fp_in) || fclose(fp_out)) {
    printf("can't close\n");
    exit(10);
  }
  
  return 0;
}
