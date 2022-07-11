#include <iostream>
#include <vector>
#include <deque>

int main() {
  int a = 0, b = 0;;

  std::deque<int> dq;

  for (int i = 0; i < 3; ++i) {
    int x;
    std::cin >> x;
    dq.push_back(x);
    a += x;
  }
  int x;
  int res = 0;
  while (std::cin >> x) {
    int b = a - dq.front() + x;
    if (b > a) {
      ++res;
    }
    a = b;
    dq.pop_front();
    dq.push_back(x);
  }

  std::cout << res << std::endl;
}