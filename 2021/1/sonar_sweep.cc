#include <iostream>
#include <string>

int main() {
  int n, prev = -1, res = 0;
  while (std::cin >> n) {
    if (prev == -1) {
      prev = n;
      continue;
    }
  
    if (prev < n) {
      ++res;
    }
    prev = n;
  }

  std::cout << res;
}