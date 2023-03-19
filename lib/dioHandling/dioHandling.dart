import 'package:cryptofile/dto/generateFolderDTO.dart';
import 'package:dio/dio.dart';
import 'package:cryptofile/dto/fileDTO.dart';
import 'package:cryptofile/dto/readAuthorityFolderDTO.dart';
import 'package:cryptofile/dto/writeAuthorityFolderDTO.dart';

class DioHandling {
  DioHandling._privateConstructor();
  static final DioHandling _instance = DioHandling._privateConstructor();
  final Dio dio = Dio();
  final String baseUrl =
      "http://ec2-43-201-160-79.ap-northeast-2.compute.amazonaws.com:8080";
  factory DioHandling() {
    return _instance;
  }

  Future<String> generateFolder(GenerateFolderDTO dto, String folderCP) async {
    Response request = await dio.request(
      "$baseUrl/api/v1/folders/$folderCP",
      data: dto,
      options: Options(method: 'POST'),
    );
    print(request.data);
    return request.data["folderCP"].toString();
  }

  Future<List<WriteAuthorityFolderDTO>> getWriteAuthByAccountCP() async {
    WriteAuthorityFolderDTO folder =
        WriteAuthorityFolderDTO("", "", "", true, "", "", 1);
    return [folder];
  }

  Future<List<ReadAuthorityFolderDTO>> getReadAuthByAccountCP() async {
    ReadAuthorityFolderDTO folder = ReadAuthorityFolderDTO("", true, "", "", 1);
    return [folder];
  }

  Future<String> generateFile() async {
    return "";
  }

  Future<String> modifyFile() async {
    return "";
  }

  Future<List<FileDTO>> getFileByFolderCP() async {
    FileDTO file = FileDTO("", "", 1, "", "");
    return [file];
  }

  Future<void> addSubscribeDemand() async {}

  Future<void> allowSubscribe() async {}

  Future<List<String>> getSubscribeDemands() async {
    return [""];
  }

  Future<void> addWriteAuthority() async {}
  Future<List> search() async {
    return [""];
  }
}
