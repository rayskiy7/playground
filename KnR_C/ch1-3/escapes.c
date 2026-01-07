#include <stdio.h>

void escape(char out[], char in[])
{
    char c, r[3];
    int i = 0, j = 0, k = 0;

    for (i = 0, j = 0; (c = in[i]) != '\0'; i++, j = 0)
    {
        switch (c)
        {
        case '\n':
            r[0] = '\\';
            r[1] = 'n';
            r[2] = '\0';
            break;
        case '\t':
            r[0] = '\\';
            r[1] = 't';
            r[2] = '\0';
            break;
        default:
            r[0] = c;
            r[1] = '\0';
        }
        while (r[j] != '\0')
            out[k++] = r[j++];
    }
    out[k]='\0';
}

void unescape(char out[], char in[])
{
    int i, j;
    char r;
    for(i=0, j=0; in[i]!='\0' && in[i+1]!='\0'; i++, j++){
        if (in[i]=='\\')
            switch(in[i+1])
            {
            case 'n':
                r = '\n';
                i++;
                break;
            case 't':
                r = '\t';
                i++;
                break;
            default:
                r = in[i];
                break;
            }
        else
            r = in[i];
        out[j] = r;
    }
    out[j] = in[i];
    if (out[j] != '\0')
        out[++j] = '\0';
}

int main()
{
    char result1[100], result2[100];
    escape(result1, "hello\tworld!\nIt's my name:\tDima.");
    unescape(result2, result1);
    printf("%s\n", result1);
    printf("%s\n", result2);
}