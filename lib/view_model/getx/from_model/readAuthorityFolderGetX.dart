import 'package:cryptofile/model/crypto/RSAKeyPairClass.dart';
import 'package:cryptofile/model/dioHandling/dioHandling.dart';
import 'package:cryptofile/model/dto/readAuthorityFolderDTO.dart';
import 'package:cryptofile/model/folder/readAuthorityFolderClass.dart';
import 'package:get/get.dart';

import 'accountGetX.dart';

class ReadAuthorityFolderGetX extends GetxController {
  List<ReadAuthorityFolderClass> folderList = [];
  Future setFolderList() async {
    if (Get.find<AccountGetX>().myAccount == null) {
      return;
    }
    folderList = [];
    DioHandling dioHandling = DioHandling();
    RSAKeyPairClass rsaKeyPair = Get.find<AccountGetX>().myAccount!;
    String accountCP =
        Get.find<AccountGetX>().myAccount!.getCompressedPublicKeyString();
    List<ReadAuthorityFolderDTO> readAuthorityFolderDTOList =
        await dioHandling.getReadAuthByAccountCP(accountCP);
    for (ReadAuthorityFolderDTO dto in readAuthorityFolderDTOList) {
      folderList.add(ReadAuthorityFolderClass.fromDTO(dto, rsaKeyPair));
    }
    update();
  }
}
