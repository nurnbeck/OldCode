#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

/*
void c_print(int T){
  T = T*T;
  cout << T << endl;
  T = T/T;
}
*/

bool compare_func(int a, int b)
{
  if(a==0){return true;}
  else if(b == 0){return false;}
  else{return a>b;}
}


int main()
{
  std::vector<int> v(5,0);
  v[0] = 10;
  v[1] = 11;
  v[2] = 22;
  v[3] = 33;
  v[4] = 13;
  sort (v.begin(), v.end());
  //for_each(v.begin(),v.end(),c_print);
  unsigned int i =0;
  while(i < v.size())
  {
    cout << v[i] << endl;
    i++;
  }
  return(1);
}
