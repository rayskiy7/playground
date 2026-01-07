#include <iostream>

class complex {
	double re, im;
public:
	complex(double r, double i) : re{r}, im{i} {}
	complex(double r)           : re{r}, im{0} {}
	complex()                   : re{0}, im{0} {}

	void real(double d) {re=d;}
	void imag(double d) {im=d;}
	double real() const {return re;}
	double imag() const {return im;}

	complex& operator+=(complex z) {re+=z.re, im+=z.im; return *this;}
	complex& operator-=(complex z) {re-=z.re, im-=z.im; return *this;}
	complex& operator*=(complex); // just declaration
	complex& operator/=(complex); // just declaration
};

complex operator+(complex a, complex b) {return a+=b;}
complex operator-(complex a, complex b) {return a-=b;}
complex operator-(complex a) {return {-a.real(), -a.imag()};} // unary minus
bool   operator==(complex a, complex b) {
	return a.real()==b.real() && a.imag()==b.imag();
}

int main(){
    complex a {2.3, -1.7};
    complex b {complex{1}+a}; // copy?
    std::cout << b.real() << " " << b.imag() << "\n";
}

// OUTPUT:
// 3.3 -1.7