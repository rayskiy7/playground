#include <stdio.h>
#include <ctype.h>
#define BUFSIZE 10000000 // 10 M
#define MAXNODES 1000000
#define MAXWL 100

static char buffer[BUFSIZE];
static char tchar=-1;
static int nodes = 0;
static char *words[MAXNODES];

/* count word and print them with frequencies in decreasing order */

char getch(void){
    if (tchar!=-1){
        char res = tchar;
        tchar = -1;
        return res;
    }
    else{
        return getchar();
    }
}

void ungetch(char c){
    if (tchar == -1)
        tchar = c;
    else
        printf("ungetch ERROR!\n");
}

struct node{
    char *data;
    int count;
    struct node *left;
    struct node *right;
};

void *alloc(int size)
{
    static char *bp = buffer;
    if (buffer + BUFSIZE - bp < size)
    {
        printf("Allocation fail!\n");
        return NULL;
    }
    void *res = bp;
    bp += size;
    return res;
}

int cmp(char *str1, char *str2)
{
    int i;
    for (i = 0; str1[i] == str2[i]; i++)
        if (str1[i] == '\0')
            return 0;
    return str1[i] - str2[i];
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

char* getword(){
    char c, word[MAXWL], *wp = word;
    while (!isalnum(c=getch()) && c!=EOF)
        ;
    ungetch(c);
    while (isalnum(c=getch()))
        *wp++ = c;
    ungetch(c);
    if (wp!=word){
        *wp++ = '\0';
        char *s, *st = s = alloc(wp-word);
        wp = word;
        while(*st++=*wp++)
            ;
        return s;
    } else
        return NULL;
}

struct node *putintree(struct node *root, char* word){
    
    if (!root){
        root = (struct node*)alloc(sizeof(struct node));
        root->count=1;
        root->data=word;
        root->left=0;
        root->right=0;
        nodes++;
    } else if (cmp(word, root->data) < 0)
        root->left = putintree(root->left, word);
    else if (cmp(word, root->data) > 0)
        root->right = putintree(root->right, word);
    else if (cmp(word, root->data) == 0)
        root->count++;
    else
        printf("UNEXPECTED ERROR!!!\n");
    return root;
}

void printtree(struct node *root){
    if (root){
        printtree(root->left);
        printf("%d %s\n", root->count, root->data);
        printtree(root->right);
    }
}

int cmpnodes(struct node *p1, struct node *p2){
    return -(p1->count - p2->count);
}

int main(){
    char *word; int i=0;
    struct node *root = 0;
    while ((word=getword()) != NULL)
        words[i++] = word;
    for (int j=0;j<i;j++)
        root = putintree(root, words[j]);
    struct node *treenodes[nodes];

    struct node * rootc = root;
    for (i=0; i<nodes;i++)
        treenodes[i] = rootc++;
    qsort(treenodes, 0, nodes-1, (int(*)(void*, void*))cmpnodes);

    for (int j=0;j<i;j++)
        printf("%d %s\n", (treenodes[j])->count, (treenodes[j])->data);
}

/*
TEST DATA:
I walked and walked along the road,  
hearing the leaves, leaves falling down.  
The air was cool, cool against my skin,  
and the silence, silence made me think.  

Dreams came and came again,  
shadows moved, moved in the night.  
I called your name, name with trembling voice,  
and the echo, echo stayed behind.  

======================================================================
RESULT:
5 the
4 and
2 cool
2 silence
2 I
2 leaves
2 came
2 walked
2 moved
2 echo
2 name
1 made
1 shadows
1 was
1 down
1 against
1 in
1 skin
1 night
1 along
1 called
1 think
1 your
1 falling
1 The
1 road
1 with
1 hearing
1 trembling
1 Dreams
1 voice
1 my
1 air
1 again
1 stayed
1 me
1 behind
*/