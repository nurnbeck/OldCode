#include <stdio.h>
#include <math.h>
#include <assert.h>

//find distance beween
double dist(p,q){
  double a = (p.x - q.x)*(p.x - q.x);
  double b = (p.y - q.y)*(p.y - q.y);
  double c = a+b;
  a = sqrt(c);
  return a;
}

//compare all pieces of array
int closest_index(const points[],int n,const point & p){
  int c = 0;
  double close = dist(points[0], p);
  while (c < n){
    if (dist(points[c],p) < close){
      close = dist(points[c],p)
    }
    c++;
  }
  
  
  
  return c;
}
//create array and print closest
int main()
{
  typedef struct {int x, y; } point;
  point p = (1,3.2);
  point *p = new points point[(0,1),(1,3),(2,4),(-1,0)];
  int n = 4;
  x = closest_index(points[] , n , p);
  printf("%d is closest index \n", x)
  
}
