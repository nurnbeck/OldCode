#include <iostream>
#include <assert.h>
#include <algorithm>
using namespace std;

//initialize Q, and sum all the elements of arrays
//A & B into Q and return Q
template <typename T>
T dot_product(T *A, T *B)
{
  T Q;
  int i = 0;
  while(i < 11)
  {
    Q = Q + (A[i]*B[i]);//dot product operation
    i++;
  }
  
  return Q;
}

//each element of S(S[i]) is made to be the sum of (A[i]+B[i])
//i is created as index and lists are traversed as long as i<n
template <typename T>
void array_sum( T *S,const T *A,const T *B,const int n)
{
  assert(n > 0);
  int i = 0;
  while (i < n){
    S[i] = A[i] + B[i];
    i++;
  }
}
//traverse elements of array of type T
//items sent to cout
template <typename T>
void array_print(T *A)
{
  int i = 0;
  while(i < 11)
  {
    cout << A[i] << " ";
    i++;
  }
  cout << endl;
}
  
int main()
{
  //creating test arrays
  int *A = new int[11];
  int *B = new int[11];
  int *S = new int[11];
  int n = 11;
  //populating with test values
  for(int i = 0; i < 11; i++)
  {
    A[i] = 2;
    B[i] = 3;
  }
  //test function calls
  array_print(A);
  array_print(B);
  array_print(S);
  int D = dot_product(A,B);
  array_sum(S,A,B,n);
  array_print(A);
  array_print(B);
  cout << "the summed array S is:" << endl;
  array_print(S);

  cout << D << endl;
  return 1;
}
