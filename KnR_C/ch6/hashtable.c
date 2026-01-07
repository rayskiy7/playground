#include <stdio.h>

#define FACTOR 1009
#define X 138746
#define MAXBUFSIZE 10000000 // 10 M
#define print(expr) printf(#expr " = %d\n", expr)

static char buffer[MAXBUFSIZE];

struct node
{
    struct node *next;
    int data;
};

struct node *alcell()
{
    static char *bp = buffer;
    if (buffer + MAXBUFSIZE - bp < sizeof(struct node))
    {
        printf("ALLOCATION ERROR\n");
        return NULL;
    }
    char *res = bp;
    bp += sizeof(struct node);
    return (struct node *)res;
}

struct node *hashtable[FACTOR] = {};

struct node **getcell(int el)
{
    el = (el < 0) ? -el : el;
    int hash = el * 37 % FACTOR;
    return hashtable + hash;
}

int has(int el)
{
    struct node *cell = *getcell(el);
    for (; cell; cell = cell->next)
        if (cell->data == el)
            return 1;
    return 0;
}

void add(int el)
{
    if (has(el))
        return;
    struct node **prev = getcell(el);
    struct node *newcell = alcell();
    newcell->data = el;
    newcell->next = *prev;
    *prev = newcell;
}

void rem(int el)
{
    if (!has(el))
        return;
    struct node **cell = getcell(el);
    if ((*cell)->data == el)
    {
        *cell = (*cell)->next;
        return;
    }
    struct node *prev = *cell, *cur = prev->next;
    while (cur->data != el)
    {
        prev = cur;
        cur = cur->next;
    }
    prev->next = cur->next;
}

int main()
{
    print(has(X));
    add(X);
    add(X);
    print(has(X));
    rem(X);
    rem(X);
    print(has(X));
}