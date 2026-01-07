#include "../../headers/parser.h"
#include "../../headers/error.h"
#include "../../headers/lexer.h"
#include "../../headers/table.h"

using Error::error;
using namespace Lexer;

namespace Parser
{
    double prim(bool get);
    double term(bool get);
    double expr(bool get);
}