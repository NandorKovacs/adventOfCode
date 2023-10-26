#include <iostream>

int main() {
  std::string s;
  int horizontal = 0;
  int depth = 0;
  while (std::cin >> s) {
    int x;
    std::cin >> x;

    if (s == "down") {
      depth += x;
      continue;
    }
    if (s == "up") {
      depth -= x;
      continue;
    }
    horizontal += x;
  }

  std::cout << horizontal * depth << std::endl;
}

