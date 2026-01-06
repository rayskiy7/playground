#include <iostream> // I/O
#include <sstream>  // string streams
#include <map>      // map
#include <string>   // strings
#include <cctype>   // isalpha(), etc.
using namespace std;

namespace Error {
    int no_of_errors = 0;
    double error(const string &s)
    {
        no_of_errors++;
        cerr << "error: " << s << '\n';
        return 1;
    }
}

namespace Table {
    map<string, double> table;
}

namespace Lexer {

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

        Token get();
        const Token &current() { return ct; }

        void set_input(istream &s)
        {
            close();
            ip = &s;
            owns = false;
        }
        void set_input(istream *p)
        {
            close();
            ip = p;
            owns = true;
        }

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

    Token_stream ts{cin};

    Token Token_stream::get()
    {
        char ch;
        do
            if (!ip->get(ch))
                return ct = Token{Kind::end};
        while (isspace(ch) && ch != '\n');

        switch (ch)
        {
        case 0: return ct = Token{Kind::end};
        case '\n': return ct = Token{Kind::print};
        case ';': case '*': case '/': case '+': case '-': case '(': case ')': case '=':
            return ct = Token{static_cast<Kind>(ch)};
        default:
            if (isdigit(ch) || ch == '.') {
                ip->putback(ch);
                *ip >> ct.number_value;
                ct.kind = Kind::number;
                return ct;
            }
            if (isalpha(ch)) {
                ct.string_value = ch;
                while(ip->get(ch) && isalnum(ch)) ct.string_value += ch;
                if (ip->peek() != EOF) ip->putback(ch);
                ct.kind = Kind::name;
                return ct;
            }
            return Error::error("bad token"), ct = Token{Kind::print};
        }
    }

} // namespace Lexer

namespace Parser {

    using Lexer::ts;
    using Lexer::Kind;
    using Table::table;
    using Error::error;

    double expr(bool get);

    double prim(bool get)
    {
        if (get) ts.get();
        switch (ts.current().kind)
        {
        case Kind::number:
        {
            double v = ts.current().number_value;
            ts.get();
            return v;
        }
        case Kind::name:
        {
            double &v = table[ts.current().string_value];
            if (ts.get().kind == Kind::assign)
                v = expr(true);
            return v;
        }
        case Kind::minus:
            return -prim(true);
        case Kind::lp:
        {
            auto e = expr(true);
            if (ts.current().kind != Kind::rp)
                return error("')' expected");
            ts.get();
            return e;
        }
        default:
            return error("primary expected");
        }
    }

    double term(bool get)
    {
        double left = prim(get);
        for (;;)
        {
            switch(ts.current().kind)
            {
            case Kind::mul: left *= prim(true); break;
            case Kind::div: 
            {
                double d = prim(true);
                if(d == 0) return error("divide by 0");
                left /= d;
                break;
            }
            default: return left;
            }
        }
    }

    double expr(bool get)
    {
        double left = term(get);
        for (;;)
        {
            switch(ts.current().kind)
            {
            case Kind::plus: left += term(true); break;
            case Kind::minus: left -= term(true); break;
            default: return left;
            }
        }
    }

} // namespace Parser

namespace Driver {

    using namespace Lexer;
    using Parser::expr;
    using Lexer::ts;
    using Lexer::Kind;

    void calculate()
    {
        for (;;)
        {
            ts.get();
            if (ts.current().kind == Kind::end) break;
            if (ts.current().kind == Kind::print) continue;
            cout << expr(false) << '\n';
        }
    }

} // namespace Driver

int main(int argc, char* argv[])
{
    using namespace Table;
    using namespace Lexer;
    using namespace Driver;

    if(argc > 1)
        ts.set_input(new istringstream{argv[1]});

    table["pi"] = 3.1415926535897932385;
    table["e"]  = 2.7182818284590452354;

    calculate();

    return Error::no_of_errors;
}
