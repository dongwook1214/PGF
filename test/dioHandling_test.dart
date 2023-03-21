import 'package:cryptofile/dto/addSubscribeDemandDTO.dart';
import 'package:cryptofile/dto/addWriteAuthorityDTO.dart';
import 'package:cryptofile/dto/allowSubscribeDTO.dart';
import 'package:cryptofile/dto/generateFileDTO.dart';
import 'package:cryptofile/dto/generateFolderDTO.dart';
import 'package:cryptofile/dto/modifyFileDTO.dart';
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

  test("dio generateFolder test", () async {
    DioHandling _instance = DioHandling();
    String folderCP = "sadasda";
    GenerateFolderDTO dto =
        GenerateFolderDTO(true, "hihi", "fasgfkasgkfjhaskjfhawirqwoh");
    String str = await _instance.generateFolder(dto, folderCP);
    print(str);
  });
  test("dio getWriteAuthByAccountCP test", () async {
    DioHandling _instance = DioHandling();
    var res = await _instance.getWriteAuthByAccountCP("123");
    print(res);
    expect(res.isEmpty, false);
  });
  test("dio getReadAuthByAccountCP test", () async {
    DioHandling _instance = DioHandling();
    var res = await _instance.getReadAuthByAccountCP("123");
    expect(res.isEmpty, false);
  });

  test("dio generateFile test", () async {
    DioHandling _instance = DioHandling();
    GenerateFileDTO dto = GenerateFileDTO([1, 2, 34, 4], "subhead");
    var res = await _instance.generateFile("123", dto);
    expect(res.isEmpty, false);
  });

  test("dio modifyFile test", () async {
    DioHandling _instance = DioHandling();
    ModifyFileDTO dto = ModifyFileDTO([1, 2, 34, 4], "subhead", "s");
    var res = await _instance.modifyFile(dto, "123", "fileId");
    expect(res.isEmpty, false);
  });

  test("dio getFileByFolderCP test", () async {
    DioHandling _instance = DioHandling();
    var res = await _instance.getFileByFolderCP("fileId");
    expect(res.isEmpty, false);
  });

  test("dio addSubscribeDemand test", () async {
    DioHandling _instance = DioHandling();
    AddSubscribeDemandDTO dto =
        AddSubscribeDemandDTO("folderCP", "accountPublicKey", [1, 2, 3, 4]);
    var res = await _instance.addSubscribeDemand(dto);
  });

  test("dio allowSubscribe test", () async {
    DioHandling _instance = DioHandling();
    AllowSubscribeDTO dto =
        AllowSubscribeDTO("folderCP", "accountPublicKey", "", "");
    var res = await _instance.allowSubscribe(dto);
  });

  test("dio getSubscribeDemands test", () async {
    DioHandling _instance = DioHandling();
    var res = await _instance.getSubscribeDemands("folderCP");
    expect(res.isEmpty, false);
  });

  test("dio addWriteAuthority test", () async {
    DioHandling _instance = DioHandling();
    AddWriteAuthorityDTO dto = AddWriteAuthorityDTO("", "", "", "");
    var res = await _instance.addWriteAuthority(dto);
  });

  test("dio search test", () async {
    DioHandling _instance = DioHandling();
    var res = await _instance.search("keyword");
    expect(res.isEmpty, false);
  });
}
