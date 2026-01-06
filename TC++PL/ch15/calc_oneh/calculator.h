#include <iostream> // I/O
#include <sstream>  // string streams
#include <map>      // map
#include <string>   // strings
#include <cctype>   // isalpha(), etc.

using std::string, std::istream, std::map;

namespace Parser
{
    double prim(bool get);
    double term(bool get);
    double expr(bool get);
}

namespace Lexer
{
    enum class Kind : char
    {
        name,
        number,
        end,
        plus = '+',
        minus = '-',
        mul = '*',
        div = '/',
        print = ';',
        assign = '=',
        lp = '(',
        rp = ')',
    };

    struct Token
    {
        Kind kind;
        string string_value;
        double number_value;
    };

    class Token_stream
    {
    public:
        Token_stream(istream &s) : ip{&s}, owns{false} {}
        Token_stream(istream *p) : ip{p}, owns{true} {}

        ~Token_stream() { close(); }

        Token get_old();
        Token get();
        const Token &current() { return ct; }

        void set_input(istream &s);
        void set_input(istream *p);

    private:
        void close()
        {
            if (owns)
                delete ip;
        }

        istream *ip;
        bool owns;
        Token ct{Kind::end};
    };

    extern Token_stream ts;

}

namespace Table
{
    extern map<string, double> table;
}

namespace Driver
{
    void calculate();

}


namespace Error
{
    extern int no_of_errors;
    double error(const string &s);
}