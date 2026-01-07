#include "../calculator.h"

Lexer::Token Lexer::Token_stream::get()
{
    char ch;

    do
        if (!ip->get(ch))
            return ct = Token{Kind::end};
    while (ch != '\n' && isspace(ch));

    switch (ch)
    {
    case 0:
        return ct = Token{Kind::end};
    case '\n':
        return ct = Token{Kind::print};
    case ';':
    case '*':
    case '/':
    case '+':
    case '-':
    case '(':
    case ')':
    case '=':
        return ct = Token{static_cast<Kind>(ch)};
    case '0':
    case '1':
    case '2':
    case '3':
    case '4':
    case '5':
    case '6':
    case '7':
    case '8':
    case '9':
    case '.':
        ip->putback(ch);
        *ip >> ct.number_value;
        ct.kind = Kind::number;
        return ct;
    default:
        if (isalpha(ch))
        {
            ct.string_value = ch;
            while (ip->get(ch))
                if (isalnum(ch))
                    ct.string_value += ch;
                else
                {
                    ip->putback(ch);
                    break;
                }
            ct.kind = Kind::name;
            return ct;
        }

        Error::error("bad token");
        return ct = Token{Kind::print};
    }
}

Lexer::Token Lexer::Token_stream::get_old()
{
    char ch = 0;
    *ip >> ch;

    switch (ch)
    {
    case 0:
        return ct = Token{Kind::end};
    case ';':
    case '*':
    case '/':
    case '+':
    case '-':
    case '(':
    case ')':
    case '=':
        return ct = Token{static_cast<Kind>(ch)};
    case '0':
    case '1':
    case '2':
    case '3':
    case '4':
    case '5':
    case '6':
    case '7':
    case '8':
    case '9':
    case '.':
        ip->putback(ch);
        *ip >> ct.number_value;
        ct.kind = Kind::number;
        return ct;
    default:
        if (isalpha(ch))
        {
            ip->putback(ch);
            *ip >> ct.string_value;
            ct.kind = Kind::name;
            return ct;
        }

        Error::error("bad token");
        return ct = Token{Kind::print};
    }
}

void Lexer::Token_stream::set_input(istream &s)
{
    close();
    ip = &s;
    owns = false;
}
void Lexer::Token_stream::set_input(istream *p)
{
    close();
    ip = p;
    owns = true;
}

Lexer::Token_stream Lexer::ts{std::cin};