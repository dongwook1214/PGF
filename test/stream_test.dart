import 'package:cryptofile/dto/generateFolderDTO.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cryptofile/dioHandling/dioHandling.dart';

void main() {
  test("stream test", () async {
    Future<int> sumStream(Stream<int> stream) async {
      var sum = 0;
      await for (var value in stream) {
        print(sum);
        sum += value;
      }
      return sum;
    }

    Stream<int> countStream(int to) async* {
      for (int i = 1; i <= to; i++) {
        await Future.delayed(Duration(milliseconds: 500));
        yield i;
      }
    }

    var stream = countStream(10);
    var sum = await sumStream(stream);
    print(sum);
  });
}
