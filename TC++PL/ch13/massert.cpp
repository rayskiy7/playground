/*
run with:
clang++ ~/dev/playground/TC++PL/ch13/massert.cpp -o ~/dev/playground/TC++PL/build/massert.bin -DCURRENT_MODE=Mode::throw_ -DCURRENT_LEVEL=0
*/


// #include <iostream>
// #include <type_traits>
// #include <stdexcept>
// #include <initializer_list>

// using namespace std;

// namespace Assert {
//     enum class Mode {throw_, terminate_, ignore_};
//     constexpr Mode current_mode  = CURRENT_MODE;
//     constexpr int  current_level = CURRENT_LEVEL; // assert if level < CURRENT_LEVEL

//     constexpr bool level(int l){
//         return l<current_level;
//     }
    
//     template<bool condition = level(1)>
//     constexpr void assert(bool assertion, const char* message = "assertion failed")
//     {
//         if (assertion)
//             return;
//         if (current_mode == Mode::throw_)
//             throw runtime_error(message);
//         if (current_mode == Mode::terminate_)
//             terminate();
//     }
// }

// // usage:
// int main(){
//     using Assert::assert, Assert::level;
//     assert(2<3);
//     assert(5<3);
//     assert<level(0)>(1<-1);
//     assert(0<10);
// }
