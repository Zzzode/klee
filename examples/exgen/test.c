#include "klee/klee.h"

int a, b;

int plus() {
  int c, result;

  a = b + 1;

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
