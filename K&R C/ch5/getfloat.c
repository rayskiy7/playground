#include <stdio.h>

int getfloat(float *x){
    float f;
    int res;
    res = scanf("%f", &f);
    *x = f;
    return res;
}

int main(){
    float f;
    getfloat(&f);
    printf("%f\n", f);
    getfloat(&f);
    printf("%f\n", f);
    getfloat(&f);
    printf("%f\n", f);
    getfloat(&f);
    printf("%f\n", f);
}