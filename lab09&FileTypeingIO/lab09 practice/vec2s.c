#include <iostream>

using namespace std;


template <typename T> struct Vec3 
{
  // constructor: sets all values
  Vec3(const T & a_, const T & b_, const T & c_)
  {
    a = a_;
    b = b_;
    c = c_;
  }
  
  // this is what the default assignment
  // operator does if we don't provide it
  void operator=(const Vec3 &rhs) {
    cout << "assignment operator called" << endl;
    a = rhs.a;
    b = rhs.b;
    c = rhs.c;
  }

  // print component values
  void print() const
  {
    cout << "a=" << a
         << " b=" << b
         << " c=" << c
         << endl;
  }

  // data
  T a, b, c;
};

int main()
{
  {
    Vec3<double> v(1.5, 2.5, 3.5), w(0, 1, 2);
    cout << "w: ";
    w.print();
    cout << endl;

    w = v;
    cout << "v: ";
    v.print();
    cout << endl;
    cout << "w: ";
    w.print();
  }
  {
    Vec3<int> v(1, 2, 3), w(4, 5, 6);
    cout << "w: ";
    w.print();
    cout << endl;

    w = v;
    cout << "v: ";
    v.print();
    cout << endl;
    cout << "w: ";
    w.print();
  }
}