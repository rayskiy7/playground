#include <iostream>
#include <forward_list>

using namespace std;
using namespace std::chrono;

template <class C>
using Iterator_type = typename C::iterator;
template <class IT>
using Iterator_category = typename iterator_traits<IT>::iterator_category;
template <class IT>
using Value_type = typename iterator_traits<IT>::value_type;

template <typename RI> // random-access iterator
void sort_helper(RI beg, RI end, random_access_iterator_tag)
{
    sort(beg, end);
}

template <typename FI> // forward iterator
void sort_helper(FI beg, FI end, forward_iterator_tag)
{
    vector<Value_type<FI>> v{beg, end};
    sort(v.begin(), v.end());
    copy(v.begin(), v.end(), beg);
}

template <typename C>
void sort(C &c)
{
    using Iter = Iterator_type<C>;
    sort_helper(c.begin(), c.end(), Iterator_category<Iter>{}); // here we use tag dispatch technique
}

void test(vector<string> &v, forward_list<int> &lst)
{
    sort(v);
    sort(lst);
}

int main()
{
    vector<string> v{"bda", "door", "dap", "axe"};
    forward_list<int> lst{1, 5, 3, 4, 2};

    test(v, lst);
    cout << v[0] << " " << v[1] << " " << v[2] << " " << v[3] << " " << endl;
    auto it = lst.begin();
    cout << *it++ << " " << *it++ << " " << *it++ << " " << *it++ << " " << *it++ << endl;
}