import 'package:dio/dio.dart';
import 'package:cryptofile/dto/fileClass.dart';
import 'package:cryptofile/dto/readAuthorityFolder.dart';
import 'package:cryptofile/dto/writeAuthorityFolder.dart';

class DioHandling {
  DioHandling._privateConstructor();
  static final DioHandling _instance = DioHandling._privateConstructor();
  final Dio dio = Dio();
  factory DioHandling() {
    return _instance;
  }

  Future<String> generateFolder() async {
    return "";
  }

  Future<List<WriteAuthorityFolder>> getWriteAuthByAccountCP() async {
    WriteAuthorityFolder folder =
        WriteAuthorityFolder("", "", "", true, "", "", 1);
    return [folder];
  }

  Future<List<ReadAuthorityFolder>> getReadAuthByAccountCP() async {
    ReadAuthorityFolder folder = ReadAuthorityFolder("", true, "", "", 1);
    return [folder];
  }

  Future<String> generateFile() async {
    return "";
  }

  Future<String> modifyFile() async {
    return "";
  }

  Future<List<FileClass>> getFileByFolderCP() async {
    FileClass file = FileClass("", "", 1, "", "");
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
