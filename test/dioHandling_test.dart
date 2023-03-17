import 'package:flutter_test/flutter_test.dart';
import 'package:cryptofile/dioHandling/dioHandling.dart';

void main() {
  test("singleton test", () {
    DioHandling _instance = DioHandling();
    DioHandling _instance2 = DioHandling();
    expect(_instance == _instance2, true);
  });
  test("singleton test", () {
    DioHandling _instance = DioHandling();
    _instance.dio;
  });
}
