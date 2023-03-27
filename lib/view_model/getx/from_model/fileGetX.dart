import 'package:cryptofile/model/crypto/RSAKeyPairClass.dart';
import 'package:cryptofile/model/dioHandling/dioHandling.dart';
import 'package:cryptofile/model/dto/fileDTO.dart';
import 'package:cryptofile/model/dto/readAuthorityFolderDTO.dart';
import 'package:cryptofile/model/file/fileClass.dart';
import 'package:cryptofile/model/folder/readAuthorityFolderClass.dart';
import 'package:get/get.dart';

import 'accountGetX.dart';

class FileGetX extends GetxController {
  List<FileClass> fileList = [];
  Future setFileList(String folderCP) async {
    fileList = [];
    DioHandling dioHandling = DioHandling();
    List<FileDTO> fileDTOList = await dioHandling.getFileByFolderCP(folderCP);
    for (FileDTO dto in fileDTOList) {
      fileList.add(FileClass.fromDTO(dto));
    }
    update();
  }
}
