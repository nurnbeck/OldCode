#include <stdio.h>
#include <iostream>
using namespace std;

struct Vec3
{
	Vec3(int a_, int b_, int c_)
	{
		a = a_;
		b = b_;
		c = c_;
d
	}
	void operator=(const Vec3 &rhs)
	{
		a = rhs.a;
		b = rhs.b;
		c = rhs.c;
	}
	void print() const
	{
		cout << " a= " << a
		     << " b= " << b
			 << " c= " << c
			 << endl;
	}

	int a, b, c;

};

int main(){
	Vec3 v(1,2,3);
    Vec3 w(0,0,0);
    cout << "w: ";
    w.print();
    cout << endl;
    w = v;
    cout << "v: ";
    v.print();
    cout << endl;
    cout << "w: ";
    w.print();
    cout << endl;

}
