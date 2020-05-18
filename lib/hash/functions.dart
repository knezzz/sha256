import 'dart:math';

int sigma0(int input) {
  int _rotateRight7 = rotateRight(input, 7);
  int _rotateRight18 = rotateRight(input, 18);
  int _shiftRight3 = input >> 3;
  return _rotateRight7 ^ _rotateRight18 ^ _shiftRight3;
}

int sigma1(int input) {
  int _rotateRight17 = rotateRight(input, 17);
  int _rotateRight19 = rotateRight(input, 19);
  int _shiftRight10 = input >> 10;
  return _rotateRight17 ^ _rotateRight19 ^ _shiftRight10;
}

int rotateRight(int input, int n) {
  return (input >> n) | (input << (32 - n)) % pow(2, 32);
}

int usigma0(int input) {
  int _rotateRight2 = rotateRight(input, 2);
  int _rotateRight13 = rotateRight(input, 13);
  int _rotateRight22 = rotateRight(input, 22);
  return _rotateRight2 ^ _rotateRight13 ^ _rotateRight22;
}

int usigma1(int input) {
  int _rotateRight6 = rotateRight(input, 6);
  int _rotateRight11 = rotateRight(input, 11);
  int _rotateRight25 = rotateRight(input, 25);
  return _rotateRight6 ^ _rotateRight11 ^ _rotateRight25;
}

int choice(int x, int y, int z) {
  return (x & y) ^ (~x & z);
}

int majority(int x, int y, int z) {
  return (x & y) ^ (x & z) ^ (y & z);
}
