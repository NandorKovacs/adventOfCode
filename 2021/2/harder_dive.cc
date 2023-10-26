#include <iostream>

int main() {
  std::string s;
  int aim = 0;
  int horizontal = 0;
  int depth = 0;
  while (std::cin >> s) {
    int x;
    std::cin >> x;

    if (s == "down") {
      aim += x;
      continue;
    }
    if (s == "up") {
      aim -= x;
      continue;
    }
    horizontal += x;
    depth += aim * x;
  }

  std::cout << horizontal * depth << std::endl;
}

