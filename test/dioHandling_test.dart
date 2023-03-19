import 'package:cryptofile/dto/generateFolderDTO.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cryptofile/dioHandling/dioHandling.dart';

void main() {
  test("singleton test", () {
    DioHandling _instance = DioHandling();
    DioHandling _instance2 = DioHandling();
    expect(_instance == _instance2, true);
  });

  test("dio server test", () async {
    final Dio dio = Dio();
    String baseUrl =
        "http://ec2-43-201-160-79.ap-northeast-2.compute.amazonaws.com:8080/hello";
    var res = await dio.request(
      baseUrl,
      options: Options(method: 'GET'),
    );
    print(res);
  });
  test("dio server test2", () async {
    final Dio dio = Dio();
    String baseUrl =
        "http://ec2-43-201-160-79.ap-northeast-2.compute.amazonaws.com:8080/api/v1/posts/2";
    var res = await dio.request(
      baseUrl,
      options: Options(method: 'DELETE'),
    );
    print(res);
  });
  test("dio server test3", () async {
    final Dio dio = Dio();
    String baseUrl =
        "http://ec2-43-201-160-79.ap-northeast-2.compute.amazonaws.com:8080/api/v1/write-auths/fdsdfsa/folders";
    var res = await dio.request(
      baseUrl,
      options: Options(method: 'GET'),
    );
    print(res);
  });

  test("dio server test4", () async {
    final Dio dio = Dio();
    String baseUrl = "http://121.130.255.202";
    var res = await dio.request(
      baseUrl,
      options: Options(method: 'CONNECT'),
    );
    print(res);
  });
  test("dio generateFolder test", () async {
    DioHandling _instance = DioHandling();
    String folderCP = "sadasda";
    GenerateFolderDTO dto =
        GenerateFolderDTO(true, "hihi", "fasgfkasgkfjhaskjfhawirqwoh");
    String str = await _instance.generateFolder(dto, folderCP);
    print(str);
  });
}
