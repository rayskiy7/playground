#include<iostream>
#include <random>
using namespace std;

#include <regex>

constexpr int m = 128;

template<typename T>
void use(const vector<T>& v)
{
	constexpr int bufmax = 1024;
	alignas(m) char buffer[bufmax]; // uninitialized
    cout << "address = 0 (mod m): " << ((intptr_t)buffer % m == 0) << endl;

	const int max_els = min(v.size(), bufmax/sizeof(T));
	uninitialized_copy(v.begin(), v.begin() + max_els, (T*)buffer);
}

struct Record{
    int32_t x;
    char c;
};

int main()
{
    vector<Record> v{{11, 48}, {11, 48}, {11, 48}, {11, 48}, {11, 48}};
    use(v);
}