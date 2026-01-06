#include <stdio.h>

void squeze(char str[], char set[])
{
    char chars[128];
    int i, j;
    for (i=0; i < 128; i++)
        chars[i] = 0;

    for (i=0;set[i] != '\0';i++)
        chars[set[i]]++;

    for (i=0, j=0; str[i] != '\0'; i++)
        if (!chars[str[i]])
            str[j++] = str[i];
    str[j]='\0';
}

int main()
{
    char a[] = "Hello my dear fried! I'm glad to see u! How was your weekends? Tell me all what you want ahah)";
    char b[] = "abde";
    squeze(a, b);
    printf("%s\n", a);
}