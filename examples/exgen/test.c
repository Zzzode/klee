#include "klee/klee.h"

int plus(int a, int b){
    int c;
    c = a + b;
    return c;
}

int test(int x, int y){
    int result;
    result = plus(x, y);
    return result;
}

int main(){
    int a, b, c = -1;
    int result;
    klee_make_symbolic(&a, sizeof(a), "a");
    klee_make_symbolic(&b, sizeof(b), "b");
    klee_make_symbolic(&c, sizeof(c), "c");
    klee_make_symbolic(&result, sizeof(result), "result");
    // klee_assume(result == 1 & a > 0 & b > 0);
    if(a > 0 && b > 0){
        c = test(a, b);
        if(c < a)
            result = 1;
        else
            result = 0;
    } else
        result = 2;
    
    return 0;
}
