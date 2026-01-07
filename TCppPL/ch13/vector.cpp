#include <memory>
#include <iterator>
#include <iostream>
#include <iterator>
#include <algorithm>

// std::uninitialized_fill implementation
template<class For, class T>
void uninitialized_fill(For beg, For end, const T& x)
{
    For p;
    try {
        for (p=beg; p!=end; ++p) // we don't guard exceptions on interator operations
            ::new (static_cast<void*>(&*p)) T(x);
    }
    catch (...) {
        for (For q=beg; q!=p; ++q) // we destruct NOT in reverse order
            (&*q)->~T();
        throw;
    }
}

template<class T, class A = std::allocator<T>>
struct vector_base {
    A alloc;
    T *elem, *space, *last;

    vector_base(const A& a, typename A::size_type n)
        :alloc{a}, elem{alloc.allocate(n)}, space{elem+n}, last{elem+n}
        { }
    ~vector_base() {alloc.deallocate(elem, last-elem);}

    vector_base(const vector_base&) = delete;
    vector_base& operator=(const vector_base&) = delete;

    vector_base(vector_base&&);
    vector_base& operator=(vector_base&&);
};

template<class T, class A>
vector_base<T,A>::vector_base(vector_base&& a)
    :alloc{a.alloc},
    elem{a.elem},
    space{a.space},
    last{a.last}
{
    a.elem = a.space = a.last = nullptr;
}

template<class T, class A>
vector_base<T,A>& vector_base<T,A>::operator=(vector_base&& a)
{
    if (this != &a) {
        if (elem) alloc.deallocate(elem, last - elem);
        elem = a.elem;
        space = a.space;
        last = a.last;
        alloc = std::move(a.alloc);
        a.elem = a.space = a.last = nullptr;
    }
    return *this;
}

template<class T, class A = std::allocator<T>>
class vector{
    vector_base<T,A> vb;
    void destroy_elements();
public:
    using sizet = unsigned int;

    explicit vector(sizet, const T& = T{}, const A& = A{});

    vector(const vector&);
    vector& operator=(const vector&);

    vector(vector&&);
    vector& operator=(vector&&);

    ~vector(){ destroy_elements(); }

    sizet size() const { return vb.space - vb.elem; }
    T* begin() const {return vb.elem;}
    T* end() const {return vb.space;}
    sizet capacity() const { return vb.last - vb.elem; }

    void reserve(sizet);

    void resize(sizet, const T& = T{});
    void clear() { resize(0); }
    void push_back(const T&);
};

template<class T, class A>
void vector<T,A>::destroy_elements()
{
    for (auto& p : *this)
        p.~T();
    vb.space=vb.elem;
}

template<class T, class A>
vector<T, A>::vector(sizet n, const T& val, const A& a)
    :vb{a, n}
{
    uninitialized_fill(begin(), end(), val);
}

template<class T, class A>
vector<T,A>::vector(const vector<T,A>& a)
    :vb{a.vb.alloc, a.size()}
{
    std::uninitialized_copy(a.begin(), a.end(), vb.elem);
}

template<class T, class A>
vector<T,A>::vector(vector&& a)
    :vb{std::move(a.vb)}
{ }

template<class T, class A>
vector<T,A>& vector<T,A>::operator=(vector&& a)
{
    clear(); // may be omitted
    std::swap(vb, a.vb); 
    return *this;
}

template <class T, class A>
vector<T,A>& vector<T,A>::operator=(const vector& a)
{
    if (capacity() < a.size()){
        vector tmp{a};
        std::swap(*this, tmp);
        return *this;
    }
    if (this == &a) return *this;

    sizet sz = size();
    sizet asz = a.size();
    vb.alloc = a.vb.alloc;

    if (asz <= sz){
        std::copy(a.begin(), a.end(), vb.elem);
        for (T* p = vb.elem + asz; p!=vb.space; ++p)
            p->~T();
    }
    else {
        std::copy(a.begin(), a.begin()+sz, vb.elem);
        std::uninitialized_copy(a.begin() + sz, a.end(), vb.space);
    }

    vb.space = vb.elem + asz;
    return *this;
}

template <typename In, typename Out>
Out uninitialized_move(In b, In e, Out oo) // what if one move fails?
{
    using T = typename std::iterator_traits<In>::value_type;
    for (; b!=e; ++b, ++oo){
        new(static_cast<void*>(&*oo)) T{std::move(*b)};
        b->~T();
    }
    return oo;
}

template<class T, class A>
void vector<T,A>::reserve(sizet newalloc)
{
    if (newalloc <= capacity())
        return;

    vector_base<T,A> b{vb.alloc, newalloc};
    uninitialized_move(begin(), end(), b.elem);
    b.space = b.elem + size();
    std::swap(vb, b);
}

template<typename In>
void destroy(In b, In e)
{
    using T = typename std::iterator_traits<In>::value_type;
    for (; b!=e; ++b)
        b->~T();
}

template<class T, class A>
void vector<T,A>::resize(sizet newsize, const T& val)
{
    reserve(newsize);
    if (size()<newsize)
        uninitialized_fill(end(), vb.elem+newsize, val);
    else
        destroy(vb.elem+newsize, end());
    vb.space = vb.elem + newsize;
}

template<class T, class A>
void vector<T, A>::push_back(const T& val)
{
    if (capacity() == size())
        reserve(size()?2*size():8);
    vb.alloc.construct(&vb.elem[size()], val);
    ++vb.space;
}

template<class T, class A>
std::ostream& operator<<(std::ostream& o, const vector<T, A>& v){
    o << "vector{";
    for (auto& x : v)
        o << x << ",";
    return o<<"}\n";
}

int main(){
    vector v{10, 5};
    v.reserve(743);
    std::cout << v;
}

/*
template<class T, class A = std::allocator<T>>
class vector{ // without composition
private:
    T* elem;
    T* space;
    T* last;
    A alloc;
public:
    using sizet = unsigned int;

    explicit vector(sizet n, const T& val = T{}, const A& = A{});

    vector(const vector& a);
    vector& operator=(const vector& a);

    vector(vector&& a);
    vector& operator=(vector&& a);

    ~vector();

    sizet size() const {return space-elem;}
    sizet capacity() const {return last-elem;}
    void reserve(sizet n);

    void resize(sizet n, const T& = {});
    void push_back(const T&);
};

template<class T, class A>
vector<T, A>::vector(sizet n, const T& val, const A& a)  // naive V1
    :alloc{a}
{
    elem = alloc.allocate(n);
    space = last = elem + n;
    for (T* p = elem; p!=last; ++p)
        a.construct(p, val);
}

template<class T, class A>
vector<T, A>::vector(sizet n, const T& val, const A& a) // verbose V2
    :alloc{a}
{
    elem = alloc.allocate(n); // no need guard! if throws to outside it's ok
    T* p;
    try{
        T* end = elem+n;
        for (p=elem; p!=end; ++p)
            alloc.construct(p, val);
        last = space = p;
    }
    catch (...){
        for (T* q = elem; q!=p; ++q)
            alloc.destroy(q);
        alloc.deallocate(elem, n);
        throw;
    }
}

template<class T, class A>
vector<T, A>::vector(sizet n, const T& val, const A& a)
    :alloc{a}
{
    elem = alloc.allocate(n);
    try{
        uninitialized_fill(elem, elem+n, val);
        space = last = elem + n;
    }
    catch (...) {
        alloc.deallocate(elem, n);
        throw;
    }
}

template <class T, class A>
vector<T, A>& vector<T,A>::operator=(const vector& a)  // verbose
{
    vector_base<T, A> b{a.vb.alloc, a.size()};
    std::uninitialized_copy(a.begin(), a.end(), b.elem);
    destroy_elements();
    swap(vb, b);
    return *this;
}
template <class T, class A>
vector<T, A>& vector<T,A>::operator=(const vector& a) // offers strong guarantee
// but has no optimization with exclude extra allocations
{
    vector tmp{a};
    std::swap(*this, tmp);
    return *this;
}

Just example of call-by-value exception-safety copy-assignment
note: Stroustrup neven can decide if this version is good.
template<class T, class A>
void safe_assign(vector<T,A>& a, vector<T,A> b) // by value!
{
    swap(a, b);
}

template<class T, class A>
void vector<T,A>::reserve(sizet newalloc) // double loop ;(
{
    if (newalloc <= capacity())
        return;
    
    vector<T, A> v{newalloc};
    std::copy(begin(), end(), v.begin());
    v.vb.space = v.vb.elem+newalloc;
    swap(*this, v);
}
*/