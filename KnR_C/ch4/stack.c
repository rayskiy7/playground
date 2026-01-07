#include <stdio.h>
#define MAXSIZE 1000

char stack[MAXSIZE];
int sp;

void push(char c)
{
    if (sp < MAXSIZE)
        stack[sp++] = c;
    else
        printf("stack overflow");
}

char pop(void)
{
    if (sp > 0)
        return stack[--sp];
    else
        return '\0';
}

char get()
{
    char c = pop();
    if (c != '\0')
        push(c);
    return c;
}

void clear(void)
{
    sp = 0;
}

void print(char c){
    printf("%c\n", c);
}

int main()
{
    int i;
    char str[] = "Hello world!";
    for(i=0; str[i]!='\0';i++)
        push(str[i]);
    print(pop());
    print(pop());
    print(get());
    print(get());
    clear();
    print(get());
    print(pop());
    push('x');
    print(pop());
}