#include <stdio.h>

#define pd(arg) printf("%d\n", (arg))

// s = grammamagama
// t = mma

/* turns 1 if the string t occurs at the end of the string s, and zero otherwise */
int strend(char *s, char *t)
{
    char *tor = t;
    while (*s++)
        ;
    while (*t++)
        ;
    while(*--s==*--t)
        if (t==tor)
            return 1;
    return 0;
}

int main()
{
    pd(strend("hellolo", "lo"));
    pd(strend("helouu", "lo"));
    pd(strend("louhe", "lo"));
    pd(strend("empty end?", ""));
    pd(strend("a", "sou long fuck"));
    pd(strend("", ""));
}