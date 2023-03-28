import 'package:cryptofile/model/dto/addSubscribeDemandDTO.dart';
import 'package:cryptofile/model/dto/addWriteAuthorityDTO.dart';
import 'package:cryptofile/model/dto/allowSubscribeDTO.dart';
import 'package:cryptofile/model/dto/fileContentsDTO.dart';
import 'package:cryptofile/model/dto/generateFileDTO.dart';
import 'package:cryptofile/model/dto/generateFolderDTO.dart';
import 'package:cryptofile/model/dto/modifyFileDTO.dart';
import 'package:cryptofile/model/dto/searchContentsDTO.dart';
import 'package:dio/dio.dart';
import 'package:cryptofile/model/dto/fileDTO.dart';
import 'package:cryptofile/model/dto/readAuthorityFolderDTO.dart';
import 'package:cryptofile/model/dto/writeAuthorityFolderDTO.dart';

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
    Response res = await dio.request(
      "$baseUrl/api/v1/folders/${Uri.encodeComponent(folderCP)}",
      data: dto,
      options: Options(method: 'POST', contentType: "application/json"),
    );
    //responseType: ResponseType.plain
    print(res.data);
    return res.data.toString();
  }

  Future<List<WriteAuthorityFolderDTO>> getWriteAuthByAccountCP(
      String accountCP) async {
    print(Uri.encodeComponent(accountCP));
    Response res = await dio.request(
      "$baseUrl/api/v1/write-auths/${Uri.encodeComponent(accountCP)}/folders",
      options: Options(method: 'GET'),
    );
    List list = res.data;
    List<WriteAuthorityFolderDTO> writeAuthorityFolderList = [];
    for (int i = 0; i < list.length; ++i) {
      WriteAuthorityFolderDTO folder = WriteAuthorityFolderDTO(
          list[i]["folderCP"],
          list[i]["folderPublicKey"],
          list[i]["folderPrivateKeyEWA"],
          list[i]["isTitleOpen"],
          list[i]["title"],
          list[i]["symmetricKeyEWF"],
          list[i]["lastChangedDate"]);
      writeAuthorityFolderList.add(folder);
    }
    return writeAuthorityFolderList;
  }

  Future<List<ReadAuthorityFolderDTO>> getReadAuthByAccountCP(
      String accountCP) async {
    Response res = await dio.request(
      "$baseUrl/api/v1/read-auths/${Uri.encodeComponent(accountCP)}/folders",
      options: Options(method: 'GET'),
    );
    print(res.data);
    List list = res.data;
    List<ReadAuthorityFolderDTO> readAuthorityFolderList = [];
    for (int i = 0; i < list.length; ++i) {
      ReadAuthorityFolderDTO folder = ReadAuthorityFolderDTO(
        list[i]["folderCP"],
        list[i]["isTitleOpen"],
        list[i]["title"],
        list[i]["symmetricKeyEWA"],
        list[i]["lastChangedDate"],
      );
      readAuthorityFolderList.add(folder);
    }
    return readAuthorityFolderList;
  }

  Future<String> generateFile(
      String folderPublicKey, GenerateFileDTO dto) async {
    Response res = await dio.request(
      "$baseUrl/api/v1/folders/${Uri.encodeComponent(folderPublicKey)}/files",
      data: dto,
      options: Options(method: 'POST', contentType: "application/json"),
    );
    print(res.data);
    return res.data;
  }

  Future<String> modifyFile(
      ModifyFileDTO dto, String folderPublickey, String fileId) async {
    Response res = await dio.request(
      "$baseUrl/api/v1/folders/${Uri.encodeComponent(folderPublickey)}/files/$fileId",
      options: Options(method: 'PUT', contentType: "application/json"),
      data: dto,
    );
    print(res.data);
    return res.data;
  }

  Future<List<FileDTO>> getFileByFolderCP(String folderCP) async {
    Response res = await dio.request(
      "$baseUrl/api/v1/folders/${Uri.encodeComponent(folderCP)}/files",
      options: Options(method: 'GET'),
    );
    print(res.data);
    List list = res.data;
    List<FileDTO> fileList = [];
    for (int i = 0; i < list.length; ++i) {
      FileDTO file = FileDTO(list[i]["folderCP"], list[i]["fileId"],
          list[i]["lastChangedDate"], list[i]["subheadEWS"]);
      fileList.add(file);
    }
    return fileList;
  }

  Future<FileContentsDTO> getContentsByFileIdAndFolderCP(
      String folderCP, String fileId) async {
    Response res = await dio.request(
      "$baseUrl/api/v1/folders/${Uri.encodeComponent(folderCP)}/files/${Uri.encodeComponent(fileId)}",
      options: Options(method: 'GET'),
    );
    return FileContentsDTO(contentsEWS: res.data);
  }

  Future<void> addSubscribeDemand(AddSubscribeDemandDTO dto) async {
    Response res = await dio.request(
      "$baseUrl/api/v1/subscribe-demands/add",
      options: Options(method: 'POST', contentType: "application/json"),
      data: dto,
    );
    print(res.data);
  }

  Future<void> allowSubscribe(AllowSubscribeDTO dto) async {
    Response res = await dio.request(
      "$baseUrl/api/v1/subscribe-demands/allow",
      options: Options(method: 'POST', contentType: "application/json"),
      data: dto,
    );
    print(res);
  }

  Future<List<String>> getSubscribeDemands(String folderCP) async {
    Response res = await dio.request(
      "$baseUrl/api/v1/subscribe-demands?folderCP=${Uri.encodeComponent(folderCP)}",
      options: Options(method: 'GET'),
    );
    print(res.data);
    List list = res.data;
    List<String> subscribeDemandsList = [];
    for (int i = 0; i < list.length; ++i) {
      subscribeDemandsList.add(list[i].toString());
    }
    return subscribeDemandsList;
  }

  Future<void> addWriteAuthority(AddWriteAuthorityDTO dto) async {
    Response res = await dio.request(
      "$baseUrl/api/v1/write-auths",
      options: Options(method: 'POST', contentType: "application/json"),
      data: dto,
    );
  }

  Future<List<SearchContentsDTO>> search(String keyword) async {
    Response res = await dio.request(
      "$baseUrl/api/v1/folders?keyword=${Uri.encodeComponent(keyword)}",
      options: Options(method: 'GET'),
    );
    print(res);
    List list = res.data;
    List<SearchContentsDTO> searchList = [];
    for (int i = 0; i < list.length; ++i) {
      SearchContentsDTO search =
          SearchContentsDTO(list[i]["title"], list[i]["folderCP"]);
      searchList.add(search);
    }
    return searchList;
  }
}
