#include <string>
#include <new>
#include <iostream>

using namespace std;

class Entry
{
public:
    enum class Tag
    {
        number,
        text
    };
    Tag type; // discriminant
    union
    { // tagged (or discriminated union)
        int i;
        string s;
    };

public:
    struct Bad_entry
    {
    }; // for exceptions
    string name;

    ~Entry();
    Entry &operator=(const Entry &);
    Entry(const Entry &, string = "unnamed");
    Entry();

    int number() const;
    string text() const;

    void set_number(int);
    void set_text(const string &);
};

int Entry::number() const
{
    if (type != Tag::number)
        throw Bad_entry{};
    return i;
}

string Entry::text() const
{
    if (type != Tag::text)
        throw Bad_entry{};
    return s;
}

void Entry::set_number(int n)
{
    if (type == Tag::text)
    {
        s.~string(); // explicitly destroy string
        type = Tag::number;
    }
    i = n;
}

void Entry::set_text(const string &str)
{
    if (type == Tag::text)
        s = str;
    else
    {
        // placement new: explicitly construct string
        new (&s) string{str};
        type = Tag::text;
    }
}

Entry &Entry::operator=(const Entry &e)
{
    if (type == Tag::text && e.type == Tag::text)
    {
        s = e.s;
        return *this;
    }

    if (type == Tag::text)
        s.~string();

    switch (e.type)
    {
    case Tag::number:
        i = e.i;
        break;
    case Tag::text:
        new (&s) string(e.s);
        type = e.type;
        break;
    }

    return *this;
}

Entry::~Entry()
{
    if (type == Tag::text)
        s.~string();
}

Entry::Entry(const Entry &e, string nm)
{
    switch (e.type)
    {
    case Tag::number:
        i = e.number();
        break;
    case Tag::text:
        new (&s) string{e.text()};
        break;
    }
    type = e.type;
    name = nm;
}

Entry::Entry()
    : i{0}, type{Tag::number}, name{"unnamed"}
{
}

ostream &operator<<(ostream &o, const Entry &e)
{
    switch (e.type)
    {
    case Entry::Tag::number:
        return o << "Entry(" << e.name << ")[" << e.number() << "]";
    case Entry::Tag::text:
        return o << "Entry(" << e.name << ")[\"" << e.text() << "\"]";
    }
}

int main()
{
    Entry e{};
    cout << e << endl;
    e.set_number(7);
    Entry e2{e, "hello"};
    cout << e2 << endl;
    e2.set_text("good day");
    cout << e2 << endl;
}