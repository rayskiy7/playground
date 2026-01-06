#include <stdio.h>
#define BUFSIZE 1000000
#define MAXLINELEN 1000
#define MAXLINES 100

static int reverse = 1, ignore_case = 0;

char buffer[BUFSIZE];

char *alloc(int size)
{
    static char *bp = buffer;
    if (buffer + BUFSIZE - bp < size)
    {
        printf("Allocation fail!\n");
        return NULL;
    }
    char *res = bp;
    bp += size;
    return res;
}

char *mygetline(void)
{
    char c, str[MAXLINELEN + 1];
    int l = 0;

    while (l < MAXLINELEN && (c = getchar()) != EOF && c != '\n')
        str[l++] = c;
    if (c != EOF && c != '\n')
        printf("MAXLINELEN limit exceeded!\n");

    if (c == '\n')
        str[l++] = c;
    str[l++] = '\0';
    if (l == 1)
        return NULL;

    char *place = alloc(l);
    if (!place)
        return NULL;

    for (int i = 0; i < l; i++)
        place[i] = str[i];
    return place;
}

int getlines(char *lines[])
{
    int n = 0;
    char *str;
    while (n < 100 && (str = mygetline()))
        lines[n++] = str;
    if (mygetline())
        printf("MAXLINES limit exceeded!\n");

    return n;
}

char lower(char c)
{
    if ('A' <= c && c <= 'Z')
        return c + ignore_case;
    return c;
}

/* bad moment: too many calls to `lower`. TODO */
int cmp(char *str1, char *str2)
{
    int i;
    for (i = 0; lower(str1[i]) == lower(str2[i]); i++)
        if (str1[i] == '\0')
            return 0;
    return (lower(str1[i]) - lower(str2[i]))*reverse;
}

void setupargs(char* argv[]){
    char *arg;
    while((arg=*argv++))
        if (*arg=='-')
            while(*++arg)
                switch(*arg){
                case 'r':
                    reverse=-1;
                    break;
                case 'i':
                    ignore_case='a'-'A';
                    break;
                default:
                    printf("Found incorrect arg %c\n", *arg);
                    break;
                }
}

void swap(void* data[], int i, int j){
    void *p = data[i];
    data[i] = data[j];
    data[j] = p;
}

void qsort(void *data[], int left, int right, int (*cmp)(void*,void*)){
    int i, last;
    
    if (left>=right)
        return;
    
    swap(data, left, (left+right)/2);
    last=left;
    for (i = left+1; i<=right; i++)
        if ((*cmp)(data[i], data[left])<0)
            swap(data, ++last, i);
    swap(data, left, last);
    qsort(data, left, last-1, cmp);
    qsort(data, last+1, right, cmp);
}

int main(int argc, char *argv[])
{
    char *lines[MAXLINES];
    setupargs(argv);
    int n = getlines(lines);
    qsort((void**)lines, 0, n-1, (int(*)(void*, void*))cmp);

    printf("\n=================\n\nSORTED LINES:\n");
    for (int i=0; i<n; i++)
        printf("%s", lines[i]);
}