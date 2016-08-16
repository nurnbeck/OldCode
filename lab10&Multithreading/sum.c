// this code should be compiled with
// g++ -Wall -Wextra -Wconversion -O3 sum.c -o sum -lpthread

#include <pthread.h>
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

// a Job is a struct that represents the work that a thread
// needs to do.  In this case, struct Job should contain
// a pointer to the double array itself, the start and the end indices, 
// and a variable storing the result

typedef unsigned int uint4;
pthread_mutex_t sumutex = PTHREAD_MUTEX_INITIALIZER;
//double sum;
struct Job
{
  // TODO: Fill in this struct
  double *arr;
  uint4 start;
  uint4 end;
  uint4 Length;
  double res;
  uint4 step;
};


// All threads will run this function when started.
// The thread retrieves the job that was passed in as an argument, 
// which contains the array, the start and the end indices of array,
// and a variable storing the result.
// You should calculate the sum of array elements between start 
// and end indices, then save the answer back into the result
// variable in the job struct.
static void *sum_thread(void *data)
{
  Job *job = (Job *) data;
  // TODO: Fill in this function
  
  job->res = 0;
  for(uint4 i =job->start;i < job->end;i++){
    job->res += job->arr[i];
  }
  return 0;
}


// This function sums up n elements in array A using TN threads
// returns the sum as a double
  
double sum(double A[], int n, int TN)
{
  assert(n > 0);
  assert(TN > 0);
  
  pthread_t threads[TN];  // there are TN threads
  Job jobs[TN];           // there are TN jobs, each job is passed into a thread
  uint4 step = n/TN;
  for (int i=0; i < TN; ++i) {
  
    // TODO: add code here
    // Here you have array A, containing n elements.
    // You need to divide the n elements among TN jobs.
    // Each job calculates the sum of array elements from a start to
    // an end index. For each job jobs[i], you need to set the
    // approprite values for the variables in the Job struct, such as
    // the start and end indices.
    jobs[i].start = i*step; //number of threads times step number
    jobs[i].end = (i+1)*(step);//array end
    jobs[i].arr = A; //thread 
    
    // launch thread with parameter jobs[i]
    pthread_create(&threads[i], NULL, sum_thread, &jobs[i]);
  }

  // Wait for threads to complete (join),
  // And then add up partial sums to sum
  double sum = 0;
  for (int i=0; i < TN; ++i) {
    // TODO: add code here
    pthread_join( threads[ i ], NULL);
    sum+=jobs[i].res;
  }
  return sum;
}



int main(int argc, char *argv[])
{
  if (argc != 3) {
    printf("usage: %s array-length threads\n", argv[0]);
    exit(1);
  }

  int length = 100000;
  int TN = 1;

  length = atoi(argv[1]);
  TN = atoi(argv[2]);

  assert(length >= 1);
  assert(TN > 0);
  
  // create and initialize array of doubles
  double *A = new double[length];
  int count = 0;
  for (int i=0; i < length; ++i) {
    A[i] = count++;
  }

  // calculate sum of array using sum() function
  double result;
  for (int i=0; i < 1000; ++i) {
    result = sum(A, length, TN);
  }
  
  printf("Result = %f\n", result);
  delete [] A;
  
  return 0;
}

/*
  Copy and paste the output of the test results here:
  ug28[lab10]:time ./sum 4000000 1
Result = 7999998000000.000000

real	0m3.893s
user	0m3.784s
sys	0m0.076s
ug28[lab10]:   time ./sum 4000000 2
Result = 7999998000000.000000

real	0m2.144s
user	0m4.056s
sys	0m0.108s
ug28[lab10]:   time ./sum 4000000 3
Result = 7999994000001.000000

real	0m1.849s
user	0m5.208s
sys	0m0.132s
ug28[lab10]:   time ./sum 4000000 4
Result = 7999998000000.000000

real	0m1.747s
user	0m6.684s
sys	0m0.100s


  
  How many threads give you the fastest result?
  Answer:4
  
*/
