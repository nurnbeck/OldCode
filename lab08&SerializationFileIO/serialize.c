#include <stdio.h>
#include <stdlib.h>
#include <fstream>

// Xfour is a struct containing four variables
struct Xfour 
{
  int a;
  int b;
  char c;
  char d;

  // prints the four variables in struct Xfour
  void print() const {
    printf("[ %d %d %d %d ] ", a, b, c, d);
  }
  
  // returns true iff current object of type Xfour is equal to object o of type Xfour
  bool equals(Xfour & o) const {
    return a == o.a && b == o.b && c == o.c && d == o.d;
  }
};


// writes x (an object of type Xfour) to file *fp in binary.
// You can choose your own binary file format.
void serialize(const Xfour & x, FILE *fp)
{
  //puts each individual element into fp with fputc
  //if error occurs will return and print problem element
  if (fputc(x.a,fp) == EOF){
    fprintf(stderr,"exit on x.a");
    return;
  }
  if (fputc(x.b,fp) == EOF){
    fprintf(stderr,"exit on x.b");
    return;
  }
  if (fputc(x.c,fp) == EOF){
    fprintf(stderr,"exit on x.c");
    return;
  }
  if (fputc(x.d,fp) == EOF){
    fprintf(stderr,"exit on x.d");
    return;
  }
}


// reads an object of type Xfour from file *fp to x in binary,
// using the same binary file format as you used in serialize()
void deserialize(Xfour & x, FILE *fp)
{
  //individually grab parts of Xfour x from file
  //get a
  if (feof(fp)==0){
    x.a = getc(fp);
  }
  //get b
  if (feof(fp)==0){
    x.b = getc(fp);
  }
  //get c typecast to avoid warning
  if (feof(fp)==0){
    x.c = (char)getc(fp);
  }
  //get d typecasting to avoid warning
  if (feof(fp)==0){
    x.d = (char)getc(fp);
  }
  
}


int main()
{

  // Declare x with two int values and two char values
  Xfour x = { 1, 2, 3, 4 };

  FILE *fp;
  
  // open file called "test" for write, and check for error when opening file
  // add code here:
  fp = fopen("test", "w");
  if (!fp){
    fprintf(stderr,"file did not open properly");
    return 10;
}
  
  // writes x to file *fp
  serialize(x, fp);

  // close file, and check for error when closing file
  // add code here:
  //close and return if improperly done
  if (fclose(fp) != 0){
    fprintf(stderr,"error closing file");
    return 10;
  }  
  
  // Declare y with no variables initialized
  Xfour y;
  
  // open file "test" for read, and check for error when opening file
  // add code here:
  fp = fopen("test", "r");
  if (!fp){
    fprintf(stderr,"file did not open properly");
    return 10;
  }
  
  
  
  // read from file *fp and stores it in y
  deserialize(y, fp);
  
  // close file, and check for error when closing file
  // add code here:
  //close and return if improperly done
  if (fclose(fp) != 0){
    fprintf(stderr,"error closing file");
    return 10;
  }
  
  
  
  // x and y should be equal.
  // if not, print both
  // Use functions print() and equals() for testing.
  if (!x.equals(y)) {
	printf("Error: ");
	x.print();
	printf(" != ");
	y.print();
	printf("\n");
  }
  else {
	printf("The function finished successfully.\n");
  }
  
  return 0;
}
