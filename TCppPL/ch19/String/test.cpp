#include <cassert>
#include <random>
#include <vector>
#include <sstream>
#include <iostream>
#include <limits>
#include <stdexcept>

#include "string.h"

using std::cout;

static std::mt19937 rng{std::random_device{}()};
static std::uniform_int_distribution<int> coin(0, 1);
static std::uniform_int_distribution<int> small(0, 30);
static std::uniform_int_distribution<int> char_dist(32, 126);

char rand_char() {
    return static_cast<char>(char_dist(rng));
}

void check_invariants(const String& s) {
        assert(s.size() >= 0);

        assert(s.c_str()[s.size()] == '\0');

        assert(strlen(s.c_str()) == static_cast<size_t>(s.size()));

        if (s.size() <= 15) {
                assert(s.capacity() >= 15);
    } else {
        assert(s.capacity() >= s.size());
    }
}

String rand_String(int maxlen = 40) {
    int n = small(rng) % (maxlen + 1);
    std::string tmp;
    tmp.reserve(n);
    for (int i = 0; i < n; ++i) tmp.push_back(rand_char());
    return String(tmp.c_str());
}

void expect_equal(const String& a, const std::string& b) {
    assert(a.size() == static_cast<int>(b.size()));
    for (int i = 0; i < a.size(); ++i) assert(a[i] == b[i]);
    assert(strcmp(a.c_str(), b.c_str()) == 0);
}

void fuzz_round() {
    String a = rand_String();
    std::string b = a.c_str();

    check_invariants(a);
    expect_equal(a, b);

    for (int step = 0; step < 5000; ++step) {
        int op = small(rng) % 12;

        switch (op) {
            case 0: {                 char c = rand_char();
                a += c;
                b.push_back(c);
                break;
            }

            case 1: {                 String c = a;
                check_invariants(c);
                expect_equal(c, b);
                break;
            }

            case 2: {                 String tmp = rand_String();
                std::string bb = tmp.c_str();
                String c = std::move(tmp);
                check_invariants(c);
                expect_equal(c, bb);
                break;
            }

            case 3: {                 String c = rand_String();
                std::string bb = c.c_str();
                c = a;
                check_invariants(c);
                expect_equal(c, b);
                break;
            }

            case 4: {                 String c = rand_String();
                std::string bb = c.c_str();
                c = std::move(a);
                check_invariants(c);
                                a = String(bb.c_str());
                b = bb;
                break;
            }

            case 5: {                 String x = rand_String();
                String y = rand_String();
                std::string xs = x.c_str();
                std::string ys = y.c_str();
                String z = x + y;
                std::string zs = xs + ys;
                check_invariants(z);
                expect_equal(z, zs);
                break;
            }

            case 6: {                 String x = rand_String();
                std::string xs = x.c_str();
                assert((x == a) == (xs == b));
                assert((x != a) == (xs != b));
                break;
            }

            case 7: {                 if (a.size() == 0) break;
                int i = small(rng);
                if (i < a.size()) {
                    char c1 = a.at(i);
                    char c2 = b.at(i);
                    assert(c1 == c2);
                } else {
                    bool thrown = false;
                    try {
                        (void)a.at(i);
                    } catch (const std::out_of_range&) {
                        thrown = true;
                    }
                    assert(thrown);
                }
                break;
            }

            case 8: {                 a = a;
                check_invariants(a);
                expect_equal(a, b);
                break;
            }

            case 9: {                 a = std::move(a);
                check_invariants(a);
                expect_equal(a, b);
                break;
            }

            case 10: {                 std::string tmp;
                for (auto c : a) tmp.push_back(c);
                assert(tmp == b);
                break;
            }

            case 11: {                 std::stringstream ss;
                ss << a;
                String t;
                ss >> t;
                                std::string tok;
                ss.clear();
                ss.str("");
                                std::stringstream ss2;
                ss2 << b;
                ss2 >> tok;
                check_invariants(t);
                expect_equal(t, tok);
                break;
            }
        }

        check_invariants(a);
        expect_equal(a, b);
    }
}

int main() {
    for (int i = 0; i < 2000; ++i) {
        fuzz_round();
        if (i % 50 == 0) cout << ".";
    }
    cout << "\nALL TESTS PASSED\n";
}
