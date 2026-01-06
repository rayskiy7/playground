#include <stdio.h>

int _getline(char storage[], int maxlength)
{
    int c, i = 0;
    while ((c = getchar()) != EOF && c!='\n'){
        if (i<maxlength-1)
            storage[i++]=c;
        else
            i++;
    }
    if (c=='\n'){
        if (i<maxlength-1){
            storage[i]=c;
            storage[i+1]='\0';
        }
        else
            storage[maxlength-1]='\0';
        i++;
    }
    return i;
}

void copy(char destination[], char source[])
{
    int i = 0;
    while ((destination[i] = source[i]) != '\0')
        i++;
}

int main()
{
    int MAXLENGTH = 50;
    char longestpart[MAXLENGTH], line[MAXLENGTH];
    int len=0, maxlen = 0;

    longestpart[0] = '\0';

    while ((len=_getline(line, MAXLENGTH))!=0){
        if (len>maxlen){
            copy(longestpart, line);
            maxlen=len;
        }
    }

    printf("max length = %d\nmaxline or part: %s\n", maxlen, longestpart);
}