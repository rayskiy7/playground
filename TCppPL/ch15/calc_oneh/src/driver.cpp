#include "../calculator.h"

void Driver::calculate()
{
    for (;;)
    {
        Lexer::ts.get();
        if (Lexer::ts.current().kind == Lexer::Kind::end)
            break;
        if (Lexer::ts.current().kind == Lexer::Kind::print)
            continue;
        std::cout << Parser::expr(false) << '\n';
    }
}
