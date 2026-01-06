
#include <stdio.h>

void swap(char str[], int l, int r){
    // main idea is to swap by borders
}
void reverse(char str[]){
    // ...
}

/* convert positive int to ASCII string (with enough array size)*/
int itoa_helper(int a, char res[]){
    int pos = 0;
    if (a/10)
        pos = itoa_helper(a/10, res);
    res[pos] = a%10 + '0';
    return pos+1;
}
void itoa(int a, char res[]){
    int pos = itoa_helper(a, res);
    res[pos]='\0';
}

int main(){
    char res[20];
    itoa(17438, res);
    itoa(9876544, res);
    printf("%s\n", res);
}