#include "parser_impl.h"

/*
FULL GRAMMAR

program:
end
expr_list end

expr_list:
expression print
expression print expr_list

expression:
expression + term
expression - term
term

term:
term / primary
term * primary
primary

primary:
number
name
name = expression
- primary
( expression )
*/

double Parser::prim(bool get)
{
    if (get)
        ts.get();

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
        double &v = Table::table[ts.current().string_value];
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

double Parser::term(bool get)
{
    double left = prim(get);

    for (;;)
    {
        switch (ts.current().kind)
        {
        case Kind::mul:
            left *= prim(true);
            break;
        case Kind::div:
            if (auto d = prim(true))
            {
                left /= d;
                break;
            }
            return error("devide by 0");
        default:
            return left;
        }
    }
}

double Parser::expr(bool get)
{
    double left = term(get);

    for (;;)
    {
        switch (ts.current().kind)
        {
        case Kind::plus:
            left += term(true);
            break;
        case Kind::minus:
            left -= term(true);
            break;
        default:
            return left;
        }
    }
}
