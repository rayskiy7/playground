#include "headers/driver.h"
#include "headers/lexer.h"
#include "headers/table.h"
#include "headers/error.h"
#include <sstream>


int main(int argc, char *argv[])
{
    if (argc > 1)
        Lexer::ts.set_input(new std::istringstream{argv[1]});

    Table::table["pi"] = 3.1415926535897932385;
    Table::table["e"] = 2.7182818284590452354;

    Driver::calculate();

    return Error::no_of_errors;
}