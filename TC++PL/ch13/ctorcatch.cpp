#include <iostream>
#include <type_traits>
#include <stdexcept>
#include <initializer_list>
#define isn(X) cout << #X " is null: " << (X == 0) << endl

using namespace std;

class A
{
public:
    A()
    {
        cout << "A::A()" << endl;
        throw runtime_error{""};
    }
};

class B
{
    A a;

public:
    B()
    try
        : a{}
    {
    }
    catch (...)
    {
        cout << "in B" << endl;
    }
};

class C
{
    A a;

public:
    C()
        : a{}
    {
        try
        {
            a = {};
        }
        catch (...)
        {
            cout << "in C" << endl;
        }
    }
};

class D
{
    int a;

public:
    D()
        : a{}
    {
        try
        {
            a = {};
            throw runtime_error{""};
        }
        catch (...)
        {
            cout << "in D" << endl;
        }
    }
};

class E
{
    int a;

public:
    E()
    try    : a{}
    {
            a = {};
            throw runtime_error{""};
        
    }catch (...)
        {
            cout << "in E" << endl;
        }
};

void esp()
try{
    throw runtime_error("from spr()");
}
catch (...){
    cout << "esp throw caught" << endl;
}

int main()
{
    try
    {
        B b{};
    }
    catch (...)
    {
        cout << "b in main" << endl;
    }
    try
    {
        C c{};
    }
    catch (...)
    {
        cout << "c in main" << endl;
    }
    try
    {
        D d{};
    }
    catch (...)
    {
        cout << "d in main" << endl;
    }
    try
    {
        E E{};
    }
    catch (...)
    {
        cout << "e in main" << endl;
    }
    esp();
}
