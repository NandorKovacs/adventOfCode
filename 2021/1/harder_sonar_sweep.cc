#include <iostream>
#include <string>

int main() {
  int a = -1, b = -1, c = -1, prev = -1, res = 0;
  while (std::cin >> a) {
    if (a == -1 || b == -1 || c == -1) {
      c = b;
      b = a;
      continue;
    }
    if (prev != -1 && prev < (a + b + c)) {
      ++res;
    }
    prev = a + b + c;
    c = b;
    b = a;
  }

  std::cout << res;
}