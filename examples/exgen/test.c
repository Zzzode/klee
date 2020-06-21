#include "klee/klee.h"

int a, b;

int plus() {
  int c, result;

  c = a + b;

  if (a > 0 && b > 0) {
    if (c < a)
      result = 1;
    else if(c == a)
      result = -1;
    else
      result = 0;
  }

  return result;
}

int main() {
  plus();

  return 0;
}
