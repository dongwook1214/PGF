import 'package:cryptofile/model/dioHandling/dioHandling.dart';
import 'package:cryptofile/model/dto/fileContentsDTO.dart';
import 'package:cryptofile/model/file/fileContents.dart';
import 'package:get/get.dart';

class FileContentsGetX extends GetxController {
  FileContents contents = FileContents(fileContents: "");

  Future getFileContents(
      String folderCP, String fileId, String aesKeyString) async {
    contents = FileContents(fileContents: "");
    DioHandling dioHandling = DioHandling();
    FileContentsDTO dto =
        await dioHandling.getContentsByFileIdAndFolderCP(folderCP, fileId);
    contents = FileContents.fromDTO(dto, aesKeyString);
    print(contents.fileContents);
    print("finish");
    update();
  }
}
