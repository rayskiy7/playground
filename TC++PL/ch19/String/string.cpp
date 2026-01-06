#include "./string.h"
#include <stdexcept>
#include <cstring>
#include <iostream>

char* expand(const char* ptr, int n){
    char* target = new char[n];
    strcpy(target, ptr);
    return target;
}

std::ostream& operator<<(std::ostream& os, const String& s)
{
    return os << s.c_str();
}

std::istream& operator>>(std::istream& is, String& s){
    s = String("");
    is >> std::ws;
    char ch;
    while(is.get(ch) && !isspace(ch))
        s+= ch;
    return is;
}

bool operator==(const String& a, const String& b){
    if (a.size()!=b.size())
        return false;
    for (int i=0; i!=a.size();++i)
        if (a[i]!=b[i])
            return false;
    return true;
}

bool operator!=(const String& a, const String& b){
    return !(a==b);
}

char* begin(String& x) {return x.c_str();}
char* end(String& x) {return x.c_str() + x.size();}
const char* begin(const String& x) {return x.c_str();}
const char* end(const String& x) {return x.c_str() + x.size();}

String operator"" _s(const char* p, size_t){
    return String{p};
}

String operator+(const String& a, const String& b){
    String res{a};
    res += b;
    return res;
}

String& operator+=(String& a, const String& b){
    for (auto c: b)
        a += c;
    return a;
}

void String::copy_from(const String& source){
    if (source.sz <= buf){
        memcpy(this, &source, sizeof(String));
        ptr = ch;
    } else {
        ptr = expand(source.ptr, source.sz + 1);
        sz = source.sz;
        space = 0;
    }
}

void String::move_from(String& source){
    if (source.sz <= buf) {
        memcpy(this, &source, sizeof(String));
        ptr = ch;
    } else {
        ptr = source.ptr; sz = source.sz; space = source.space;
        source.ptr = source.ch;
        source.sz = source.ch[0] = 0;
    }
}

String::String()
    : sz{}, ptr{ch}
{
    ch[0] = 0;
}

String::String(const char* cstr)
    : sz{static_cast<int>(strlen(cstr))}, ptr{(sz<=buf)?ch:new char[sz+1]}, space{0}
{
    strcpy(ptr, cstr);
}

String::String(const String& source){
    copy_from(source);
}

String::String(String&& source){
    move_from(source);
}

String& String::operator=(const String& source){
    if (this == &source) return *this;
    char* todel = (sz > buf) ? ptr : nullptr;
    copy_from(source);
    delete[] todel;
    return *this;
}

String& String::operator=(String&& source){
    if (this == &source) return *this;
    if (sz>buf) delete[] ptr;
    move_from(source);
    return *this;
}

String& String::operator+=(char c){
    if (sz==buf){
        int newsz = sz+sz+2;
        ptr = expand(ptr, newsz);
        space = newsz-sz-2;
    } else if (sz > buf){
        if (space==0){
            int newsz = sz+sz+2;
            char* newp = expand(ptr, newsz);
            delete[] ptr;
            ptr = newp;
            space = newsz - sz - 2;
        }
        else
            --space;
    }
    ptr[sz] = c;
    ptr[++sz] = 0;
    return *this;
}