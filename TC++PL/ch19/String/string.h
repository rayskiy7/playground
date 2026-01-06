#include <iostream>
#include <stdexcept>

// provides strong exception guarantee

class String{
    inline static const int buf = 15;

    int sz;
    char* ptr; // wherever real data is
    union {
        int space;
        char ch[buf+1];
    };

    void check(int n) const {
        if (n<0 || n>=sz)
            throw std::out_of_range("index is out of bounds");
    }

    void copy_from(const String& x);
    void move_from(String& x);

public:
    String();

    explicit String(const char*);

    // copy
    String(const String&);
    String& operator= (const String&);
    // move
    String(String&&);
    String& operator= (String&&);

    ~String() {if (sz>buf) delete[] ptr;}

    char& operator[](int n) {return ptr[n];}
    char operator[](int n) const {return ptr[n];}

    char& at(int n) {check(n); return ptr[n];}
    char at(int n) const {check(n); return ptr[n];}

    String& operator+=(char c);

    char* c_str() {return ptr;}
    const char* c_str() const {return ptr;}

    int size() const {return sz;}
    int capacity() const {if (sz<=buf) return buf; else return sz+space;}
};

char* expand(const char*, int);
std::ostream& operator<<(std::ostream&, const String&);
std::istream& operator>>(std::istream&, String& );
bool operator==(const String&, const String&);
bool operator!=(const String&, const String&);
char* begin(String&);
char* end(String&);
const char* begin(const String&);
const char* end(const String&);
String operator+(const String&, const String&);
String& operator+=(String&, const String&);
String operator"" _s(const char*, size_t);