#include <stdio.h>

int htoi(char str[])
{
    int i=0, n=0;
    char c;

    while (str[i]!='\0'){
        c = str[i++];
        n = n*16 + ('0'<=c && c<='9'?c-'0':(c-'a'+10));
    }

    return n;
}

int main(){
    printf("%d\n", htoi("ef2"));
}