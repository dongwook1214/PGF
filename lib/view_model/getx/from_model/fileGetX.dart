import 'package:cryptofile/model/crypto/RSAKeyPairClass.dart';
import 'package:cryptofile/model/dioHandling/dioHandling.dart';
import 'package:cryptofile/model/dto/fileDTO.dart';
import 'package:cryptofile/model/dto/readAuthorityFolderDTO.dart';
import 'package:cryptofile/model/file/fileClass.dart';
import 'package:cryptofile/model/folder/readAuthorityFolderClass.dart';
import 'package:get/get.dart';
import 'package:mutex/mutex.dart';

import 'accountGetX.dart';

class FileGetX extends GetxController {
  final m = Mutex();
  List<FileClass> fileList = [];
  Future setFileList(String folderCP, String aesKey) async {
    await m.acquire();
    fileList = [];
    DioHandling dioHandling = DioHandling();
    List<FileDTO> fileDTOList = await dioHandling.getFileByFolderCP(folderCP);
    for (FileDTO dto in fileDTOList) {
      fileList.add(FileClass.fromDTO(dto, aesKey));
    }
    update();
    m.release();
  }
}
